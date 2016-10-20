xquery version "3.0";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

declare function local:download-xml($node, $filename) {
response:set-header("Content-Disposition", concat("attachment;
filename=", $filename))
,
response:stream(
$node,
'indent=yes' (: serialization :)
)
};

let $results :=
    for $doc in fn:collection('/db/apps/srophe-data/data/persons/tei')//tei:person
    let $name := $doc/tei:persName
    let $uri := replace($doc/ancestor::tei:TEI/descendant::tei:idno[1],'/tei','')
    let $id := xs:integer(replace($uri,'http://syriaca.org/person/',''))
    order by $id
    return <row><uri>{$uri}</uri>{$name}</row>

return
local:download-xml($results, "allpersonnames.xml")