  "(\d+),(\d+)"  "\1.\2"
  -- input
  LOAD DATA LOCAL INFILE 'indikatorenatlas-arbeitsmarkt---arbeitslose.csv' 
  INTO TABLE munich_indicators 
  CHARACTER SET UTF8
  FIELDS TERMINATED BY ',' 
  ENCLOSED BY '"' 
  LINES TERMINATED BY '\r\n'
  IGNORE 1 LINES;

  -- check for output
  SELECT DISTINCT `INDIKATOR_BEZEICHNUNG` FROM `munich_indicators` WHERE 1
  
  SELECT 'Arbeitslose', 'Stadtteil' 
  UNION ALL
  SELECT REPLACE(INDIKATOR_WERT, '.', ',') as `Arbeitslose`, name as Stadtteil
  from munich_indicators 
  where INDIKATOR_BEZEICHNUNG = 'Arbeitslose' 
  and 	INDIKATOR_AUSPRAEGUNG = 'Langzeit' 
  and jahr = 2014
  and name not LIKE '%München%'
  INTO OUTFILE 'D:/motor.csv'
  FIELDS TERMINATED BY ';'
  LINES TERMINATED BY '\r\n';
  
  update munich_indicators set INDIKATOR_AUSPRAEGUNG = 'Maenner' where INDIKATOR_AUSPRAEGUNG = 'Männer' ;

  
  delete from munich_indicators  where INDIKATOR_BEZEICHNUNG = 'Haushalte mit Kindern'; 
  

  select INDIKATOR_WERT as Motorisierungsgrad, name 
  from munich_indicators 
  where INDIKATOR_BEZEICHNUNG = 'Motorisierungsgrad' 
  and jahr = 2014