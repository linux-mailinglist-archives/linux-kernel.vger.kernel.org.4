Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1230629B54
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbiKON7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiKON7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:59:18 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700FD399;
        Tue, 15 Nov 2022 05:59:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZGpsixzBaEugnBLuneCyViG5bfkuYsLDsKyoNTTBr+4ZjZeqUidROaoEJGnUBUCJb53vNoipbeq/VFZMLnGbvuA5w6psMpQA6cPWiPCWsTxZmuvYLKZT1t4sturpKZVQ+SxJhINxFwUNUpmPAmWQpK59fSGEy3gLB5ZQjeS1S+4HluVgTvEByJS7NPSCIulIxlEjlDdUBJaZtm3nfUgNJtjgYOf/3TZtQcA7FnUcy/keuJ/a1oZ0Z+iO/0pt1l89RcwqU+nbUuNeuZTDwpfvv+sS8cP1pQLbctAz+VZ6drlwRaUkXzYnDX+QhcNw6D3b1VqseIneafowE4E7LEOHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wnu/sxBV7X/QfaUO0LBTbGhbfmm/wiCYdH/Tk/zENfM=;
 b=g1IzvvaKhBQl8PhM+VDI7SGP6H7UWkQf1gTicHeza74AFCk0it43YoTd02FWipJiVvoYBIfi3KOicd6RMMRn00nMdS90BAxHl/HibdTXQM3zkaQuHSvkZ2bo6JNX3WO62B9CCZA3TH8Gh1jGWyS4JKxgOtOy0659GJEsGgFdvs4D9wQDPrVp/qmv1eM63kg/o3gmpOh0HnHRDDz+m3uGhOVx4Q3tSAyHRUMvqAckhluK6cMGhhGizBRApDAOHdFC7uWv8UiJYtFObuvkUwtLNa+aCNcRWOyySDsEg9F7EH4hRV5aHboQ0qNZaxyqqdamMdnB88zxkgciQAJrkAusHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wnu/sxBV7X/QfaUO0LBTbGhbfmm/wiCYdH/Tk/zENfM=;
 b=CV0Fs5wy19ijkakU8FzCW2P22I9qc4ewXVtVkKydIPmkqcBhuVcojOeZSlJXzf2A6rjqLOR/lWOTu2LgvuP376koIXadNtnFc/Y8WFBn17i00Y8Ckhr3GafwZ321mQOlFxJQa4N3iLa+uQmbw2NfKJkRBDM/aLsY6WxuDPO/kSg=
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by GV1PR04MB9134.eurprd04.prod.outlook.com (2603:10a6:150:25::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.15; Tue, 15 Nov
 2022 13:59:13 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::9317:77dc:9be2:63b]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::9317:77dc:9be2:63b%7]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 13:59:13 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: Re: [PATCH v2] dt-bindings: spi: convert Freescale DSPI to dt-schema
Thread-Topic: [PATCH v2] dt-bindings: spi: convert Freescale DSPI to dt-schema
Thread-Index: AQHY9h+FTOIdILG+UESwpW9mF9x8Sq5ABQqAgAADlwA=
Date:   Tue, 15 Nov 2022 13:59:13 +0000
Message-ID: <20221115135912.ksjk7zxqsyazqhtf@skbuf>
References: <20221111224651.577729-1-vladimir.oltean@nxp.com>
 <417bfdea-ed41-6468-ec16-f54480cfe2f6@linaro.org>
In-Reply-To: <417bfdea-ed41-6468-ec16-f54480cfe2f6@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB5136:EE_|GV1PR04MB9134:EE_
x-ms-office365-filtering-correlation-id: 2b93228e-45b7-43e3-a168-08dac71193b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0DT5EzP1YoFbqE/yxwZJR5zmAsrCx5FT37knnojO7JtMiODSdqfc4vKtf785IvalrusHIxu7rs4OkrjAdpm/GEki4oq23uAGa5YhtTjzWiLdwg9uTeRLJYJnmwQowNDI4amEEu25xlk5GWAT77mxqFCQAHmKaFKjTbHDaCcWeAlRd016RQHcWQLOpr5J2hUOTz6lyewXPdTVvHolRYr4mELvWgXwEohF6RB3PCEsX2MsQzM2Srtab/b2v6slwHim3bPocKm9VXCrcrdeQ2Z6rBIsL2FxUFPyn1y9ykAqhoXg0LzW8l3COjrUeo4bdPFLt3S9/eSw/7PeiSrb7EM54BICQ2mZzm6pSONdRPc9Z/mwidklVQh3pqQk2irj6368Bz4XhmPJOhTNqCFYTGAEy+vEXk2cAyYCRVImasDa6d4vwovwfiy2xMGLQ/OtrIg6QZT3HP00xRTsqRksP2yJva5Vu/pIFJhUyGCQ4FcJwH/JSWej8f50GxXqMSodsyBPxuDDrGf6a5CLHiMRPnnp/X00f7fmkCbN6Gj+5834EOZmrMwzTK6v3VnaYRUS/TMNq91AGUYOqK45VP9Tr9rV+4OLcKP19eZNpwbdgBAACe07bcdA4lS/l0q16dtnE5WQlLorfVyjBe8pt0XO40N++aBUAgMSI2lJWNE33vZiW1zDdpAtRX30YEVfr4iaJTsCVP1NhdTXyByBNQj115ZAWVvEPJiX9ySbLtWrI4V7W7QgdWK3odqTgnzYRETG/LMsfZHgmMCEn5rDfYRxJ7QKsbF2jK7Rj5cmX1jo2SCNc/CgM9ye1nN+ot4Yhxe648fLmIdrF0OzdPCcD/RgfFv2SA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199015)(316002)(7416002)(8936002)(5660300002)(44832011)(64756008)(66476007)(66556008)(66446008)(41300700001)(4326008)(76116006)(8676002)(66946007)(38070700005)(966005)(54906003)(6916009)(71200400001)(122000001)(478600001)(6486002)(86362001)(6512007)(6506007)(26005)(9686003)(2906002)(186003)(1076003)(33716001)(83380400001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bJhOQyD8UntEbpMO7XBJQcJfGxeNaLgsSGaS+hOYYD1oNJ6qxzEfo/B7LAaA?=
 =?us-ascii?Q?nXa7/iIsDe5A/IzhUhQLFNc8JEmx4wbrwS+BFIolTLDCvhlwczy6kLLLLW7/?=
 =?us-ascii?Q?VloM9qECjvdINd0wlhPegqlH9yoxbzP9JQUc2LOnr1U0dRqFG8pYYnf3C8HW?=
 =?us-ascii?Q?5cXYR0hl0V/jm6JnEZaSgZ+ckNXxe9bSoMCqhdTwHRNl8ai0UR81j8gTTkbV?=
 =?us-ascii?Q?1yEr6NoVikXWQ5TqNWXIb3WHJPoc0vvnQEzQmEmCp4KcmqFdSXH5otOc+N54?=
 =?us-ascii?Q?S3SKxdmAakCrETK4XHHcvp45M7r3n3lngOcQNESZvfNLDgO16vvWQCbBe8Vw?=
 =?us-ascii?Q?HH6BlQcYyTZ7ff8y8mjbjf85ftcJ+1/1Gm7ZmzkyZOhfglhKBZR4NH59kvKD?=
 =?us-ascii?Q?G7oGADOA0E6N4I2fHiWuF7QwccFpi025uCpLEipMfO+ShL0JmX3ySrgTw06f?=
 =?us-ascii?Q?lv/9VmpZibQJLfrQNXgY4/iEnZDHhyV0b6v1lOrjUaGkSnC4d+MeLD4yGYkN?=
 =?us-ascii?Q?XiXSZcjP3DAyAmLLcZ03XcTUUfNOlZez+vlXUz5zzbvPE/qBqld4gvS3oNuX?=
 =?us-ascii?Q?8e6WclllQARBc7JmKzlOOU08J+65Ki09BYLa2K/pCIk4flXIIlUejjbsIk14?=
 =?us-ascii?Q?284jTqOV4J5p03NwhegFhibGtBaEqe0g6/dcTaWC0S4LRqbH5pIVB83qvsNX?=
 =?us-ascii?Q?3kGd+MhBxz+nA+upimlnxA2dGr++pUjygCI/yAcl6xEUYqLmnTKnc5gWtvcq?=
 =?us-ascii?Q?M5KyDDFB003bQbMI+RrWjOZHmhGYCivFNRozo58GBGZ1ndar+JoK0A67nFlK?=
 =?us-ascii?Q?2ZUqRqyaGipVlQeAStiQMLhwkYnz9pZqpKvzRzwSrn5kTym156akflbD+azi?=
 =?us-ascii?Q?8/q1R9TRhFNaaDfYAd/5DhyH4byG2oxaY27A0OhxgIM4MD87ik8X1taLb7FG?=
 =?us-ascii?Q?unedq7D9y458TlztJm64AaKnOFkJdA+V93vyEJrFIDuguMs6jzDKTyDjaXOf?=
 =?us-ascii?Q?eqwE7v/ge5eRyMkSP0yYg0rLAd67lidnulKGOPh7JP+mgNQHTA65AS11TCiW?=
 =?us-ascii?Q?TbNvUX8YDD1D/G2iowUVdjwni27VlJQbNOyDjl+WOeT1qw+ziTxuaRYnDbc0?=
 =?us-ascii?Q?at96ZLrkyehycNRsRXW5scwVJJ744au4CyWXtbKGgcHuB6yzkZfhFgsIZWtW?=
 =?us-ascii?Q?Oj6IoAAHpRUkn3zkB6g7h8Rxs02z6jlNFFMBTvIRQk1PO6XrVPXXZ75/Mdbw?=
 =?us-ascii?Q?8wvRD2RnWb4WEFyQ2VEc4LEM7uyNNp2mUXay+Vjhju6s08tiwjRMmcBgWMgr?=
 =?us-ascii?Q?Tx5G1XyKDVHBywamRlccufy2IMozrWPAae8YoQ2oM6i70GibsCZDnfD4/vHY?=
 =?us-ascii?Q?Ix4yrEkHSIRcFug78q/gNDQXk2PIhQdqYEVcmwP1I0Qxln+d7AhY7nS490Z3?=
 =?us-ascii?Q?P3QtLvGfTx8u4kWTkQ72LCvFieghWZsYXwkdK7QBSBlgu+EeB0iSyKZg00lU?=
 =?us-ascii?Q?XSykJoPQ65UBJfFK5IxkZbwnNwhSIWeFW0oKAiXVyeeOctUPO8cEuRfibiTF?=
 =?us-ascii?Q?V84awztIe8UWUputb6pf/m8ZHdtaBiBG56NA94cQTwCiyyGBmfm8kp4dZvKX?=
 =?us-ascii?Q?1w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <61D7D668F27E024CBFF423B6F522FF1A@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b93228e-45b7-43e3-a168-08dac71193b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 13:59:13.2468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bsDCmc2AnYQS5tqR6QPmgLU6eFyN5HA1WjrTrIjJfobtWy/+LxOsoH1nUpnAyJx2mx4HYcvDpCL/yhrTLgw7/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9134
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 02:46:21PM +0100, Krzysztof Kozlowski wrote:
> > +$id: http://devicetree.org/schemas/spi/fsl,spi-fsl-dspi.yaml
>=20
> Why second "fsl" in file name? It does not patch compatibles and
> duplicates the vendor. We do not have compatibles "nxp,imx6-nxp".

Ok, which file name would be good then? There are 9 different (all SoC
specific) compatible strings, surely the convention of naming the file
after a compatible string has some limitations...

> > +$schema: http://devicetree.org/meta-schemas/core.yaml
> > +
> > +title: Freescale DSPI Controller
> > +
> > +maintainers:
> > +  - Vladimir Oltean <olteanv@gmail.com>
> > +
> > +allOf:
> > +  - $ref: "spi-controller.yaml#"
>=20
> Drop quotes.
>=20
> > +
> > +properties:
> > +  compatible:
> > +    description:
> > +      Some integrations can have a single compatible string containing=
 their
> > +      SoC name (LS1012A, LS1021A, ...). Others require their SoC compa=
tible
> > +      string, plus a fallback compatible string (either on LS1021A or =
on
> > +      LS2085A).
>=20
> Why? The fsl,ls1012a-dspi device is either compatible with
> fsl,ls1021a-v1.0-dspi or not. It cannot be both - compatible and not
> compatible.

LS1012A is compatible with LS1021A to the extent that it works when
treated like a LS1021A. LS1012A has a FIFO size of 8 SPI words, LS1021A
of just 4. Treating it like LS1021A means roughly half the performance,
but it still works.

I didn't invent any of this. When I took over the driver, there were
device trees like this all over the place:

		dspi: spi@2100000 {
			compatible =3D "fsl,ls1012a-dspi", "fsl,ls1021a-v1.0-dspi";
			#address-cells =3D <1>;
			#size-cells =3D <0>;
			reg =3D <0x0 0x2100000 0x0 0x10000>;
			interrupts =3D <0 64 IRQ_TYPE_LEVEL_HIGH>;
			clock-names =3D "dspi";
			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
					    QORIQ_CLK_PLL_DIV(1)>;
			spi-num-chipselects =3D <5>;
			big-endian;
			status =3D "disabled";
		};

but the Linux driver pre-~5.7 always relied on the fallback compatible
string (LS1021A in this case). I'm working with what's out in the field,
haven't changed a thing there.

> > +    oneOf:
> > +      - enum:
> > +          - fsl,ls1012a-dspi
> > +          - fsl,ls1021a-v1.0-dspi
> > +          - fsl,ls1028a-dspi
> > +          - fsl,ls2085a-dspi
> > +          - fsl,lx2160a-dspi
> > +          - fsl,vf610-dspi
> > +      - items:
> > +          - enum:
> > +              - fsl,ls1012a-dspi
> > +              - fsl,ls1028a-dspi
> > +              - fsl,ls1043a-dspi
> > +              - fsl,ls1046a-dspi
> > +              - fsl,ls1088a-dspi
> > +          - const: fsl,ls1021a-v1.0-dspi
> > +      - items:
> > +          - enum:
> > +              - fsl,ls2080a-dspi
> > +              - fsl,lx2160a-dspi
> > +          - const: fsl,ls2085a-dspi
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    items:
> > +      - const: dspi
> > +
> > +  dmas:
> > +    maxItems: 2
> > +
> > +  dma-names:
> > +    items:
> > +      - const: tx
> > +      - const: rx
> > +
> > +  spi-num-chipselects:
>=20
> Would be nice to deprecated it in separate patches. There is num-cs
> property.

Will add this on my TODO list. Right now I'm just converting what exists.

> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/fsl,qoriq-clockgen.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    soc {
> > +        #address-cells =3D <2>;
> > +        #size-cells =3D <2>;
> > +
> > +        spi@2100000 {
> > +            compatible =3D "fsl,ls1028a-dspi", "fsl,ls1021a-v1.0-dspi"=
;
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +            reg =3D <0x0 0x2100000 0x0 0x10000>;
>=20
> reg by convention is a second property.

ok.

> > diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props=
.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > index dca677f9e1b9..a475e757f8da 100644
> > --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > @@ -101,6 +101,7 @@ properties:
> >  # The controller specific properties go here.
> >  allOf:
> >    - $ref: cdns,qspi-nor-peripheral-props.yaml#
> > +  - $ref: fsl,spi-fsl-dspi-peripheral-props.yaml#
> >    - $ref: samsung,spi-peripheral-props.yaml#
> >    - $ref: nvidia,tegra210-quad-peripheral-props.yaml#
> > =20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index c242098a34f9..c75ae49c85b5 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -8160,7 +8160,8 @@ FREESCALE DSPI DRIVER
> >  M:	Vladimir Oltean <olteanv@gmail.com>
> >  L:	linux-spi@vger.kernel.org
> >  S:	Maintained
> > -F:	Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
> > +F:	Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi.yaml
>=20
> Instead: Documentation/devicetree/bindings/spi/fsl,spi-fsl-dspi*

ok...=
