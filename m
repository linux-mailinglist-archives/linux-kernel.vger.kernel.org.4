Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9A6629BD9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiKOOTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiKOOTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:19:08 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2042.outbound.protection.outlook.com [40.107.20.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BA92A42B;
        Tue, 15 Nov 2022 06:19:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUZ8nG8ild/SOALBucWFx6nMKq5Bxw6XFescgxQ9MYjRdIiclY31dM9qTSatEoZShP+fDS002bxUOmD2rdpEDs4cvbIxY10kqT0x8QFfuQCJtNeQdeTTUFxQbtNLZzUrI7VS9rMUHCLYz6WG8Sse4fRmMz16M6kW3Jnb8uvOwqOyQ44MussTZMQEYL0ap8VWAfuNQOERGi1EUETL3Whyd+6RMIA73saGFF+Z1rDlV8CV5RDkRQEXjrDcQPX6EjN78h0RGS1xlCVQXgyjo1ufngLRkkMsvzwq2YJvg8iwnRYyU4SZia/Co0Dlhddji1ttHDte1w3vD/XdQ73n8iZrnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v63sPBnKPKaPVOUli3zqAALZJ8zwXOfS9G9x8oNL3OE=;
 b=PVWU6d3NPtQ+Ypsi89ZUPSdgb69fmXBJCZEGBBGc6eS0YVVdVnnopBKv8y3WtD46/hvxePaGFujYgx3gUSHCm2e+nCgR6UVDDvcgMUdCqd6lTNCDVgzWqW4x8F1FcnhciycONj/85xkCzfnTFndjS2WGzcvmL0PQAJmzdIld4yzZ2Qg3HpdDkov6y51twqddcDlhI9b34z2nMfoyg/yVdz/bvsjQrBEhylBH+audUrrVQGup9eYlJGojges7I2j/x8L0mVB/vAMLxYDP7dwRS8ixAdrpSOsP2461L3UBiiWDLkxT7CzRKmL28RV1xd5Q5UajmSr/g7NFxdUv4CV1Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v63sPBnKPKaPVOUli3zqAALZJ8zwXOfS9G9x8oNL3OE=;
 b=WmZwa4N82+HsKKAY+uT/BtCpPlCDr+ojysWwrA2gQBg08bpE8ZZKnNWRIPSoykXszL2Ttmr3P9+Gd8p2HFvC5MjdRS4AGQ5qDw/BWEPhtL3PqlgJwtN9MQlsfwr+AVzl/D5Mna1yNjiJRb1TmJurQ5TlHEk+9XBrvgii4x4CrWg=
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by DB9PR04MB8251.eurprd04.prod.outlook.com (2603:10a6:10:24f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Tue, 15 Nov
 2022 14:19:05 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::9317:77dc:9be2:63b]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::9317:77dc:9be2:63b%7]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 14:19:04 +0000
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
Thread-Index: AQHY9h+FTOIdILG+UESwpW9mF9x8Sq5ABQqAgAADlwCAAAKigIAAAusA
Date:   Tue, 15 Nov 2022 14:19:04 +0000
Message-ID: <20221115141904.26lyetiforkgoqaf@skbuf>
References: <20221111224651.577729-1-vladimir.oltean@nxp.com>
 <417bfdea-ed41-6468-ec16-f54480cfe2f6@linaro.org>
 <20221115135912.ksjk7zxqsyazqhtf@skbuf>
 <c9b82051-a9f5-883f-5455-1cb06aa6521b@linaro.org>
In-Reply-To: <c9b82051-a9f5-883f-5455-1cb06aa6521b@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB5136:EE_|DB9PR04MB8251:EE_
x-ms-office365-filtering-correlation-id: 4a9fbb6a-d842-4574-77ef-08dac71459f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mkvHWfE/BiWMeaFz0EFH2d9BLVwEOubxFMZ7K8SAOYnP3TIz/nTXe8U+mF2DxwX31wtllZPl/q121FRSEj7SWO3bMRjprb7BUzEfu8yfNDF7k2VpAdZr8t4IfEisQK2XSCCBAiohJh8K131XMK0gY6Mtl6rWfSgNlx9sMFE4PKDZFeIfHD7ECG8/QNaW90XZua0zAbn8mE/a5W6PwLfokhZlPQ/vfZp1L7Ax+PGDyZp7M4bMVKJiMvedK1cEvWTCk1e0nhhXr7rXspv+iW4A78TdC8ZDbgoqnT0oCmZIRkWfPrhmH0Rid2F3W6lr80yYT+Vdig3xNIz5oEZaqq5zlbE5nT0NJabJYnv6fuxO4FhUqwFDW7mcQUl+uLiKH+SswvtNNLGYHLru0neFczBbAS8GoR04yvSc1FYFZsk/0xTMrEN0zJIDNpdnfyRPxrcWm4fNtJtkeOLNV5KrTc7CP4+coodxZWHLQzQyLkAP+AKrCAx0EdUS6Z21Ux5kM9jZ4Ggthd/mdRP2sgULqZdyNoK3OgwkSJdjjtPCG9c/3W8H5qebJ1vPoj0Vc1yzm5FXeP56yEsEAKXe2aLFFNS4BdWe6/0NhE4J17ie4bibXS4Et55rhDH1OkyznWE81OMeMnvJmpHdDl5MbXoQflQU5slYey3owFd/OSnQVRZQr6Te6woOc8PrH2Lzlw/CKbAtX/ABR0rdTHc+8hvErIYBuoggsf2xbqTd0FHAklnJbJ5MWU3xg3VNA3qt8TJDB0cPVfz4TQcFOAdtB4gi2gHTT7EE+3vNAxDmvkHMM8noQ/Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199015)(86362001)(2906002)(38100700002)(122000001)(7416002)(44832011)(8936002)(83380400001)(38070700005)(1076003)(186003)(54906003)(6916009)(316002)(5660300002)(478600001)(33716001)(966005)(6486002)(66446008)(53546011)(64756008)(8676002)(76116006)(66946007)(41300700001)(4326008)(6506007)(66556008)(26005)(9686003)(71200400001)(6512007)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tIqH/Wi5UG9f7aZdpFmD0raGS7Jf8bS0IV4j6jnzUm3ZXPw1leHgoUf3iqrl?=
 =?us-ascii?Q?rbwdKBwHZCfuctJvmbNgk5iyMBDY8UOWRih0Va8agOQAq7wiju+WBx3xHcaS?=
 =?us-ascii?Q?Lg7dyr7wPU/WJ/mzrtHw4wqjF+o6PLxZEHMSemCZ2C5HxwePmUrQz2B13vKe?=
 =?us-ascii?Q?JpZD6EZdhhvuMu0A0PK3bQ6U0eWx1ouEQ+ZROavWoIUkiS2nslssrV/XknuO?=
 =?us-ascii?Q?ju/Nhb/1UFJ9Al75bBewdpnUVj6nh643EE+lcHe/gB2sqde9+w0yUs1DhCdX?=
 =?us-ascii?Q?A3r5hrTpl8sqyXxHHeZsViIo/iViqDdXwNtmUuHfbph/qrv2PD/VnMmRyH18?=
 =?us-ascii?Q?Ge/8qd6McLEG7ew4RDjQ2q/DPk2Y6t1f+Igw7pR33qcyNWh2yr6KauEjKC73?=
 =?us-ascii?Q?Ei/GFGlBKQdHf475YEzv80+I/uTGcGnejItlv2hapItzhCpwXW8FS3cib7XY?=
 =?us-ascii?Q?LfmoeAWaQ0tI+Bd87ABeJDpQgi7DD3wOagh/hIu6aWWczPugucavNUCFmGG7?=
 =?us-ascii?Q?T+QyIfB4mtVdu/iQHHW+R7APEn2sGGzWcVWMPQNKmSSwg/RiHei1AmYwRnCT?=
 =?us-ascii?Q?RiICc1yADPIz5+xau1LuZ0+krdgA9UW8ym+I1HUKQ3+L9cbfYOAhB/3nOB14?=
 =?us-ascii?Q?MJNzqJUblAmgoy3sIBsPRcC3oJd3uywtcJ/jLQ9A5uaWUh5q+cFsR7MKy8TC?=
 =?us-ascii?Q?BCtVFA2V2g+jOR5N7ppeVEzFEkO77vs08iOvsMPjdnMJH5TGQYpEntVBrVhv?=
 =?us-ascii?Q?kTNqzoSAfV6LsO7YEEaWHFP8Po/E5IqFXEmsq3KCCDO4n32HkMnjAliJQUTX?=
 =?us-ascii?Q?vzHt3S4hV9/6Yp8bckshTAAZ5ThwxxZALcuuVTpjBm6D+R5/AywWoM3kErFk?=
 =?us-ascii?Q?o5ztizjbGTUmPwfHx54B8ceAK+ggnVXFV52xWWAGZxGyBA6TzN3tj4X0bDQ1?=
 =?us-ascii?Q?8td5IAkD/JH1gQdottK4ST3D9SFP3HYKReU+kyxDPGBcQ8t4f7eK04nyWH15?=
 =?us-ascii?Q?ssQFgqBtd69p+MtRKKVRQ4SdbvdXtYxCZ3EhoUTqwhj9FPYHcW97n/9zqtEK?=
 =?us-ascii?Q?5hCulxBPtNCV8AZ7LKolFQ7fW/0ZwP+2FYuN17Lxp90EOs82DaZMzvuiv5ah?=
 =?us-ascii?Q?3CTE7TMVvUzw8qHVwszT+lfD7wZR3z5//szR6juNfGerU4FBHHh8pWqDM/ae?=
 =?us-ascii?Q?hGC5FLlNHgyPfsYbdp4jnRwX2ql8TWLFGyy1lzD6G+zxlEtofrn4FTC3INdj?=
 =?us-ascii?Q?w1RThkF3bknJkA0ZribPoGJ4D4WDg1wbM16bSLSrSSFs5jF/Cs1NTaKNUzMR?=
 =?us-ascii?Q?g5c/lnspP78qaej8Y0Xh6ux+xM+6euh639TTKywag9R/iu07sYWq2OWz6kbc?=
 =?us-ascii?Q?M6IZMfbVaiC543Xbl+4pzuuJwg9+QugfFDZMXbxWPHNRI4Dbqs1jL7fcwel0?=
 =?us-ascii?Q?niqAgqG5bhE4e9zrzL1X/ZRoB8hGJj4WGBaZL2zpU8eaq4MDdSzw/lQHOmpx?=
 =?us-ascii?Q?1s+4bamwd1U5ON9MHp6N1ODgkKU1Iy0N1GkD/g/ccauOlIU6r3cjs4hsICg+?=
 =?us-ascii?Q?KoYvDwyHIaVs5wIbDko5yE2euKTmifoh2Aeh3FO0fpLaYQWRTTez4R82n3kQ?=
 =?us-ascii?Q?wA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3E4FA11BAD0F2545A04D507BD9EDB958@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9fbb6a-d842-4574-77ef-08dac71459f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 14:19:04.8501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rGEL+GjSUpNO6h80FBYm1WPbmPxWb7E41OcsvHH+f2eAg3IpVAmI2eclVmSRcjTavWPs+qW3Ew2vFZCBA150Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8251
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 03:08:37PM +0100, Krzysztof Kozlowski wrote:
> On 15/11/2022 14:59, Vladimir Oltean wrote:
> > On Tue, Nov 15, 2022 at 02:46:21PM +0100, Krzysztof Kozlowski wrote:
> >>> +$id: http://devicetree.org/schemas/spi/fsl,spi-fsl-dspi.yaml
> >>
> >> Why second "fsl" in file name? It does not patch compatibles and
> >> duplicates the vendor. We do not have compatibles "nxp,imx6-nxp".
> >=20
> > Ok, which file name would be good then? There are 9 different (all SoC
> > specific) compatible strings, surely the convention of naming the file
> > after a compatible string has some limitations...
>=20
> If all DSPI blocks fit here, then maybe: fsl,dspi.yaml
>=20
> fsl,spi-dspi.yaml is also a bit redundant.

Ok, fsl,dspi.yaml and fsl,dspi-peripheral-props.yaml, and MAINTAINERS
entry for fsl,dspi*.yaml?

> >>> +properties:
> >>> +  compatible:
> >>> +    description:
> >>> +      Some integrations can have a single compatible string containi=
ng their
> >>> +      SoC name (LS1012A, LS1021A, ...). Others require their SoC com=
patible
> >>> +      string, plus a fallback compatible string (either on LS1021A o=
r on
> >>> +      LS2085A).
> >>
> >> Why? The fsl,ls1012a-dspi device is either compatible with
> >> fsl,ls1021a-v1.0-dspi or not. It cannot be both - compatible and not
> >> compatible.
> >=20
> > LS1012A is compatible with LS1021A to the extent that it works when
> > treated like a LS1021A. LS1012A has a FIFO size of 8 SPI words, LS1021A
> > of just 4. Treating it like LS1021A means roughly half the performance,
> > but it still works.
> >=20
> > I didn't invent any of this. When I took over the driver, there were
> > device trees like this all over the place:
> >=20
> > 		dspi: spi@2100000 {
> > 			compatible =3D "fsl,ls1012a-dspi", "fsl,ls1021a-v1.0-dspi";
>=20
> Which looks ok...
>=20
> > 			#address-cells =3D <1>;
> > 			#size-cells =3D <0>;
> > 			reg =3D <0x0 0x2100000 0x0 0x10000>;
> > 			interrupts =3D <0 64 IRQ_TYPE_LEVEL_HIGH>;
> > 			clock-names =3D "dspi";
> > 			clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
> > 					    QORIQ_CLK_PLL_DIV(1)>;
> > 			spi-num-chipselects =3D <5>;
> > 			big-endian;
> > 			status =3D "disabled";
> > 		};
> >=20
> > but the Linux driver pre-~5.7 always relied on the fallback compatible
> > string (LS1021A in this case). I'm working with what's out in the field=
,
> > haven't changed a thing there.
>=20
> The driver matters less (except ABI), but anyway it confirms the case -
> fallback is expected always.  Why the fallback should be removed if the
> devices are compatible (including halved performance)?

I don't think I said the fallback should be removed? I think you're
talking about a typo/braino I made, which puts the LS1012A both in the
bucket of SoCs with a single compatible strings required, as well as in
that with fallback required. Obviously both can't be true... I didn't
mean LS1012A but VF610.=
