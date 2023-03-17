Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2476BEBDD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 15:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjCQOzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 10:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjCQOzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:55:21 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2056.outbound.protection.outlook.com [40.107.6.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E54C5A1A0;
        Fri, 17 Mar 2023 07:55:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRbCcsJ3SdpEijPPWI5UOt9Fs13pnCm7d/k1SZ5lN/tHywsDpE1EOhwll9oGURGvaP4Nkt3wldgrZw4YM2CY3TWmj5Bm5rOAkIooiyoJbxfXQflPinbVqY1T0lmwrMaagZmXpx6ERDEsorLJhnkHXQh0DsDLlNrQRvXEelx2TwEISsF54NLTuHtaoSPFnCgLIg34Z9CNkWJaCKdaokBg7/WIk5jTHnfX+bBBs147CMYTLXZzQ89QllFSlrndVAK7bbb3+Jx3PrlkjHWIeLq31JnYNTH8yMZImlwv7MFrU4okx30x+1U/zI/GEBzgO3r1P7ihNjySTOIyR/hBdtwrLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chXhs12Hzgby12r0e3oPdK2d4AWoEJNnUJ3foZpob1A=;
 b=P6Okn25rQTAwevihAFulGaU1Mw5w5Z8wELLvI2ApkJo96wtxbCHsZMISIl06Zl/NbWO+c3ipzi8Ze2tvjipP7WF5SFbWN/GeXOkiFfkZQsZx6KF2alPAEchx9FXlwrO+bHLVuaK9abTXoa7mHDJJ8ObsMH1Lbm0V5FOek3+viO8rLZ2QnUeBdogW1ji1T0eRF4K/1BRLcbe4xrxVAMmeX22+JKpMOOuJgMGdvjZt/Bi0MT/CSVCTbUQdW4tDimqyVHPj9IKpHtGumy0+cAFPG/uG9PKUnkrjQVyHoG/kBgfzfhbbSV3JAkVsIlxcKmtAYVAAimlexPgyMbjirzYW5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chXhs12Hzgby12r0e3oPdK2d4AWoEJNnUJ3foZpob1A=;
 b=VfxvwcSK8JqAcpbuNDWq/3Kg1Oddwj/xskgHNcGIw67+b8bgxhtuLeSx52zM3usHkayNsUApB+LyKiF5ijGDU4uus4bpd2HvcQqjTRE40INPs7ZmfS0TrAwcv2C7jr6a9WeEWfEdK5/e6L0ZQUq2VoEPiYKIqLtK/j+juOYAuKk=
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8623.eurprd04.prod.outlook.com (2603:10a6:102:21a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 14:55:06 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::fb2a:a683:b78e:b9b5%4]) with mapi id 15.20.6178.029; Fri, 17 Mar 2023
 14:55:06 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: RE: [EXT] Re: [PATCH v2 1/3] dt-bindings: usb: cdns-imx8qm: add
 imx8qm cdns3 glue bindings
Thread-Topic: [EXT] Re: [PATCH v2 1/3] dt-bindings: usb: cdns-imx8qm: add
 imx8qm cdns3 glue bindings
Thread-Index: AQHZWE4ev2xmRcSa20iFYFwtFRu1OK7+r7IAgABftWA=
Date:   Fri, 17 Mar 2023 14:55:06 +0000
Message-ID: <AM6PR04MB4838D1958A029701E1601BA588BD9@AM6PR04MB4838.eurprd04.prod.outlook.com>
References: <20230316212712.2426542-1-Frank.Li@nxp.com>
 <20230316212712.2426542-2-Frank.Li@nxp.com>
 <e6935c0c-375e-b763-ea91-3b8bbc906ebc@linaro.org>
In-Reply-To: <e6935c0c-375e-b763-ea91-3b8bbc906ebc@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB4838:EE_|PAXPR04MB8623:EE_
x-ms-office365-filtering-correlation-id: 9b4a4b6f-92ca-4ab2-f371-08db26f798f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ngrw5AVm1KOzA1Uad/yKJWksknGPfFA0JPxozyoOsrx2Fi2i2jVDu/x7tw+b28zE8E0xjp9E9LZWw/o60VQ+sfkQFjaVARoM7mN5kV0BCBg8k8ceHvMK/rxnVGtqzlPh4fgGNv1WX14E/mpit4HwgQH2bzAq1cThpqEHB1jVmwTusRnmFzVo1BDfLM9l8wQ2WhzCSH7889rY+woVmQJTfmcEeEa9i++RTZsRJyjvjKLJwT9jJGXyzRiCzOliJ4JyBRRezxxudmmoFuT1hT9RLYc71FUX4dbW3yr9XqiXPGAZuaVaa2i5u4aWIEk5B1c6nm2P5te5tvU44EeNmyhNTSLQr128NyU5j+hZUa+3esgjAIr0R9ku4c6l62G+sZ7R+Ece4ZST6nZ+Hi/T+4uF+BF0RMUFxsHBuAEZlajLJriXGu7HMepczA4rRMlmrmxR4U7RCRasUsq48y8wHm1tT0NizW3QBlO0diiaX7CMjYY7fwlqEs8tfTcG6d3oAEHd7jWS4anzsgAomj1VYYUuovfvyfM8gqHLO4aOwSejft1g8hIDebPztPGs8z6ztzBHHwRdAz/5huD1ynWGkD/jw4nfMELuzxs+rwnz1f8a6OP9g5JqGBhtm18Zjc331mT7CSqBowGff5q9uIFCeZFovmEeDp6c8pbpHZeIbPKWYpQ2iXfdwktZ8tL6o/KviXDDmVGg3HhwMwn3tQUpwSFqLU4VICR0p3X3fB3OX+QoErQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(451199018)(4326008)(53546011)(55236004)(71200400001)(26005)(478600001)(6506007)(966005)(83380400001)(45080400002)(54906003)(66946007)(186003)(7696005)(9686003)(316002)(66446008)(66476007)(76116006)(8676002)(64756008)(110136005)(66556008)(52536014)(8936002)(44832011)(5660300002)(41300700001)(7416002)(122000001)(38100700002)(2906002)(55016003)(38070700005)(86362001)(33656002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4UPQfBA8MUZ7trcGx+SUSLrwhcUQFn5ZPX6L9oOhANGEg3u5JC1imms7dup5?=
 =?us-ascii?Q?fzqVcietUrBI3EvNiEIbRgce0+ja+scU9IMWCKybkQNXXXAE4/XC2Z8ieSak?=
 =?us-ascii?Q?OE4UkGFFHPMTiIt+vHuyLXWEOJDAwAeEhPnhK/s8bA6hlzv5Frn6FmgNO9QT?=
 =?us-ascii?Q?f0S4/ruh3olvNj8lHqAnGjH1jAW+6aktn1BRHDebF8p37RUaEDZgnnIoi67Q?=
 =?us-ascii?Q?bigfYMADJQ74wNVYB9vrN581pyCKDUuPjiaHjI6ARW4Yl5V6M0N0YIqOq/Kx?=
 =?us-ascii?Q?DMfnEZbU4Ds8S6rtjfNR7hwXSt/EWneNA+WzVHGO/eCkeonzR6JqjDUm2Ssa?=
 =?us-ascii?Q?S7TUNFdnvaqEJfPtxw6E7+0+/OacgqM/rHB+AEYk703Y9nnEMi/+znJRm10/?=
 =?us-ascii?Q?B8+f6+Q4MF2wPi6GVVl1xz4U5WUjbNczQtTUbgCdRUlouMsKJ+yS0xMJ72sx?=
 =?us-ascii?Q?fSdnSo3veuAFnJOFdXji772bvlbPXadqXlasM6uzEnApKRNs0BtM/UeXaeI7?=
 =?us-ascii?Q?Gzmexh0CUmE2Q5D8UWKee+Kwz3sVnuFKp+oN0B158qim4y+l6oVan5cuH+4F?=
 =?us-ascii?Q?Yoc8jeTaBZIjB06zwRkRyrb6U8SymM6shAHU07ey37JB/3VJSMKm5r/g9Y/z?=
 =?us-ascii?Q?VPVkf0RJNKUK/Ph2m50yVgROArhoV58PyNsCJaLY6QpLryLQblsa9t4sX4pi?=
 =?us-ascii?Q?AMqsLkK4Z9zMViA6I5ObunwpyttB053JLTFWArrxdQ5vqOFyjFZRu4phz6Zf?=
 =?us-ascii?Q?fGVJvltBRNJQ+/mDmX/OmZCq0jTeK7M9r76uDA/zf6IAfwP/KxwkX6UyB+DH?=
 =?us-ascii?Q?EKfQ9opzo3zITQTHpU4Fkxdeph9cD5fkKMWKdwWocqQ/YP3m2DnA6gybXl6N?=
 =?us-ascii?Q?i5bdQd8/U1fItcQhHj4D4ivSLw2cPm57/JCD/+SSf1whnR3hvoAyyUnXMvHI?=
 =?us-ascii?Q?npSleT4uwg3WXP8/VrHKFr5nSSC3Utr6/GGx3QfMkRsYbj/pQ61lDrmXZlTn?=
 =?us-ascii?Q?z+D45gkvskN+3EAhwiA9KMU9GE3i1e4WGhuMnbGwmDYWLA9Qja+uDX3bpD1g?=
 =?us-ascii?Q?hzY19gLJZl1bFyUsDYmTYFydpOpZY4zR4BSQq2j1kyWBDRw7z2oOD8uex2y5?=
 =?us-ascii?Q?aL9Txbc/XdhdhcdIRywE26ocC+SCWG1oM/8za2+3RBgh2ETwnOokBmTrg393?=
 =?us-ascii?Q?tlQ2SVAbD56tJ7kEBy83ue9CR/reRlVhFErn3fWHMopGABjxHiy9XYahqAaM?=
 =?us-ascii?Q?/8eI+6nNOjM7RNwEoS9wkgzLoVF76vsE4tfmJzlBORWgym7zWVJD0mt/PspA?=
 =?us-ascii?Q?VB/km/PFo153/50am66uZkp/B8KGCVzXVPS3gOFJS32vDGtHluCHZnISbBJj?=
 =?us-ascii?Q?dkC6mW3ciA/Ye/IFon7Z+YjwJjAANuGVrUtXID6x0wU7QLk6Uh7l8y+sjTnC?=
 =?us-ascii?Q?/OyjLvsYDxbMX9toLc1V4LLjqRcx27tSL0Jy6/KyTDfrEgbYayuezIJ256Lw?=
 =?us-ascii?Q?l8KTY9iah1jlwS/u+zltDSC+rZlbPbSy5TT8WZrJ5XiM/o4nXk42A5mm32Ig?=
 =?us-ascii?Q?Rk3sZyV3+FsWLsKbRyI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4a4b6f-92ca-4ab2-f371-08db26f798f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 14:55:06.7424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qCvErxwjhhrgcah4U6eWGp/Bq9XpOCYoELa1qEwbSzjfoWM3YcCFKDCE48uXeO6NbA2dAcm+MfYz3AIKsgqDFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8623
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Friday, March 17, 2023 4:09 AM
> To: Frank Li <frank.li@nxp.com>; shawnguo@kernel.org
> Cc: devicetree@vger.kernel.org; festevam@gmail.com; imx@lists.linux.dev;
> kernel@pengutronix.de; krzysztof.kozlowski+dt@linaro.org; linux-arm-
> kernel@lists.infradead.org; dl-linux-imx <linux-imx@nxp.com>; linux-
> kernel@vger.kernel.org; robh+dt@kernel.org; s.hauer@pengutronix.de
> Subject: [EXT] Re: [PATCH v2 1/3] dt-bindings: usb: cdns-imx8qm: add
> imx8qm cdns3 glue bindings
>=20
> Caution: EXT Email
>=20
> On 16/03/2023 22:27, Frank Li wrote:
> > NXP imx8qm integrates 1 cdns3 IP. This is glue layer device bindings.
> >
>=20
> Subject: drop second/last, redundant "bindings". The "dt-bindings"
> prefix is already stating that these are bindings.
>=20
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  .../bindings/usb/fsl,imx8qm-cdns3.yaml        | 122 ++++++++++++++++++
> >  1 file changed, 122 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/fsl,imx8qm-
> cdns3.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/usb/fsl,imx8qm-
> cdns3.yaml b/Documentation/devicetree/bindings/usb/fsl,imx8qm-
> cdns3.yaml
> > new file mode 100644
> > index 000000000000..fc24df1e4483
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/fsl,imx8qm-cdns3.yaml
> > @@ -0,0 +1,122 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright (c) 2020 NXP
> > +%YAML 1.2
> > +---
> > +$id:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevice
> tree.org%2Fschemas%2Fusb%2Ffsl%2Cimx8qm-
> cdns3.yaml%23&data=3D05%7C01%7CFrank.Li%40nxp.com%7Cac9af3d617dc4cf
> 14baf08db26c74b07%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6
> 38146409617970248%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C
> &sdata=3DEczZhjyMUGnnp7ZGfSvTj4lmOUuGlOtWYIsxxXIlNXw%3D&reserved
> =3D0
> > +$schema:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevice
> tree.org%2Fmeta-
> schemas%2Fcore.yaml%23&data=3D05%7C01%7CFrank.Li%40nxp.com%7Cac9a
> f3d617dc4cf14baf08db26c74b07%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C
> 0%7C0%7C638146409617970248%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiM
> C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000
> %7C%7C%7C&sdata=3DuTNYuDm%2ByhZ56oQET2pX8sHpEqVvsUYtmOBCPXEK
> v40%3D&reserved=3D0
> > +
> > +title: NXP iMX8QM Soc USB Controller
> > +
> > +maintainers:
> > +  - Frank Li <Frank.Li@nxp.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: fsl,imx8qm-usb3
> > +
> > +  reg:
> > +    items:
> > +      - description: Address and length of the register set for iMX US=
B3
> Platform Control
>=20
> Drop "Address and length of the"... or actually just maxItems: 1,
> because the description is a bit obvious.
>=20
> > +
> > +  "#address-cells":
> > +    enum: [ 1, 2 ]
> > +
> > +  "#size-cells":
> > +    enum: [ 1, 2 ]
> > +
> > +  ranges: true
> > +
> > +  clocks:
> > +    description:
> > +      A list of phandle and clock-specifier pairs for the clocks
> > +      listed in clock-names.
>=20
> Drop description.
>=20
> > +    items:
> > +      - description: Standby clock. Used during ultra low power states=
.
> > +      - description: USB bus clock for usb3 controller.
> > +      - description: AXI clock for AXI interface.
> > +      - description: ipg clock for register access.
> > +      - description: Core clock for usb3 controller.
> > +
> > +  clock-names:
> > +    items:
> > +      - const: usb3_lpm_clk
> > +      - const: usb3_bus_clk
> > +      - const: usb3_aclk
> > +      - const: usb3_ipg_clk
> > +      - const: usb3_core_pclk
> > +
> > +  assigned-clocks:
> > +    items:
> > +      - description: Phandle and clock specifier of IMX_SC_PM_CLK_PER.
> > +      - description: Phandle and clock specifoer of IMX_SC_PM_CLK_MISC=
.
> > +      - description: Phandle and clock specifoer of
> IMX_SC_PM_CLK_MST_BUS.
> > +
> > +  assigned-clock-rates:
> > +    items:
> > +      - description: Must be 125 Mhz.
> > +      - description: Must be 12 Mhz.
> > +      - description: Must be 250 Mhz.
>=20
> I would argue that both properties above are not needed. If your
> hardware requires fixed frequencies, clock provider can fix them, can't i=
t?

Clock provider don't know fixed value and turn on only used by client.=20

>=20
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +# Required child node:
> > +
> > +patternProperties:
> > +  "^usb@[0-9a-f]+$":
> > +    $ref: cdns,usb3.yaml#
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#address-cells"
> > +  - "#size-cells"
> > +  - ranges
> > +  - clocks
> > +  - clock-names
> > +  - power-domains
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/imx8-lpcg.h>
> > +    #include <dt-bindings/firmware/imx/rsrc.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    usbotg3: usb@5b110000 {
>=20
> Drop label, unused
>=20
> > +      compatible =3D "fsl,imx8qm-usb3";
> > +      ranges;
> > +      reg =3D <0x5b110000 0x10000>;
>=20
> reg is second property
>=20
> > +      clocks =3D <&usb3_lpcg IMX_LPCG_CLK_1>,
> > +               <&usb3_lpcg IMX_LPCG_CLK_0>,
> > +               <&usb3_lpcg IMX_LPCG_CLK_7>,
> > +               <&usb3_lpcg IMX_LPCG_CLK_4>,
> > +               <&usb3_lpcg IMX_LPCG_CLK_5>;
> > +      clock-names =3D "usb3_lpm_clk", "usb3_bus_clk", "usb3_aclk",
> > +                    "usb3_ipg_clk", "usb3_core_pclk";
> > +      assigned-clocks =3D <&clk IMX_SC_R_USB_2 IMX_SC_PM_CLK_PER>,
> > +                        <&clk IMX_SC_R_USB_2 IMX_SC_PM_CLK_MISC>,
> > +                        <&clk IMX_SC_R_USB_2 IMX_SC_PM_CLK_MST_BUS>;
> > +      assigned-clock-rates =3D <125000000>, <12000000>, <250000000>;
> > +      power-domains =3D <&pd IMX_SC_R_USB_2>;
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <1>;
> > +      status =3D "disabled";
>=20
> Drop status
>=20
> > +
> > +      usbotg3_cdns3: usb@5b120000 {
>=20
> Drop label
>=20
> > +          compatible =3D "cdns,usb3";
> > +          interrupt-parent =3D <&gic>;
> > +          interrupts =3D <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
> > +                       <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
> > +                       <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
> > +                       <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>;
> > +          interrupt-names =3D "host", "peripheral", "otg", "wakeup";
> > +          reg =3D <0x5b120000 0x10000>,   /* memory area for OTG/DRD
> registers */
> > +                <0x5b130000 0x10000>,   /* memory area for HOST regist=
ers */
> > +                <0x5b140000 0x10000>;   /* memory area for DEVICE regi=
sters */
> > +          reg-names =3D "otg", "xhci", "dev";
>=20
> reg is second property, reg-names third.
>=20
> > +          phys =3D <&usb3_phy>;
> > +          phy-names =3D "cdns3,usb3-phy";
> > +      };
> > +    };
>=20
> Best regards,
> Krzysztof

