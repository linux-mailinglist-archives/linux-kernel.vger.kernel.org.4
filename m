Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC4873D6F3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 06:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjFZErH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 00:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjFZErE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 00:47:04 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2072.outbound.protection.outlook.com [40.107.7.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2D7BA;
        Sun, 25 Jun 2023 21:46:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KH5sFORT8uFDAEseYViP6B+tsNwtTJH72wKtfpKy5+JkjuNT5nyFnNzF963tIMVJmf0GPf6GJh9w76iEdsMxi+vIcQDrB5AJAhazzHTVJpxGQxr5TbkZqM3EtqbIfQmLhYr1s9l7OogRg9r6CBw5H0MK2bxnIyUdbuYlYNo67rhWLb3Ofjm9jW4LG6B3oByuf7YgqWHxdcP4+Ks1tE+rBApx/YlIJq/YMZdTEnA3ZB3EdtxtEsw6SYurusGz7FEBTXSiq4bkRpq/rUgh8kSXPAhHHPLxisdjGtupkuOtZe/4FQnn7rAlEqDep/+toUAKlZkhkatbmw1J6nuY/6Jh9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTCIbgnBeaoS0IWBK7/CoRlRMy6ZHU3C8LaupT0gxyw=;
 b=VWKbQi1/VtbU5/NWL5m8fDXiMgWWMc00uUBjSp0YI93C5bm/3+P3zDH85JH98UjU49OubzzzFQHXp0E7R59R3psYtzDKh4pocrm3DXvZKU5QpLEPAaHqaRgbuFGadl3mwGzUzA8zvAc048gsyMNwkMmHpgiyt2NWGTjDiNJk2snBMzsIe0TULalcKY4/+CUDFdDB0z8N7I+yFfQXBcE/a95xRMiFPn5RrOW/JwH3L8QF1wXiaqpW0nw2j2d7ZyVJSqA4opneuP0IBc4T9E6khfx6S7GPW8tMWJ2TwjqS9dy+tbuDKjv0ZuRjB+QGPJ+VsskkQdewgh+J5ZcTweqgew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTCIbgnBeaoS0IWBK7/CoRlRMy6ZHU3C8LaupT0gxyw=;
 b=K4aJm4KZ+TWwnkjvxvddCLUo1tEBocuJoYuEaIrMZUIksmAmzHsVGxa6o48gShB1BXRuNnP9o0RMCQK2hqH7diqCQfohuBMEsHq6varq8O9ejYKsNNULrCGeP2tF4Yl4NiC3sl25I6DEXnccZsEcyuVKAGow7m/YjQTcL6va/JE=
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by DB9PR04MB8121.eurprd04.prod.outlook.com (2603:10a6:10:24b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Mon, 26 Jun
 2023 04:46:46 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::413f:a9d5:4c09:9dad]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::413f:a9d5:4c09:9dad%3]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 04:46:46 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Pankaj Gupta <pankaj.gupta@nxp.com>, Varun Sethi <V.Sethi@nxp.com>
Subject: [PATCH v2] arm64: dts: imx8ulp-evk: add caam jr
Thread-Topic: [PATCH v2] arm64: dts: imx8ulp-evk: add caam jr
Thread-Index: AQHZp+k2v8Jbz02GhkGV+zbcgHYc4w==
Date:   Mon, 26 Jun 2023 04:46:46 +0000
Message-ID: <DU2PR04MB86300C782DC7637C469599EC9526A@DU2PR04MB8630.eurprd04.prod.outlook.com>
References: <20230616174050.644880-1-pankaj.gupta@nxp.com>
In-Reply-To: <20230616174050.644880-1-pankaj.gupta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8630:EE_|DB9PR04MB8121:EE_
x-ms-office365-filtering-correlation-id: 5d21f134-f5ce-4b80-554c-08db760058ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uVqKRDRveqo8jfQ/xds0WA5gFvfaq8pF4qdm4ifaV+kvk/S13s9y6/dMXngMnM6sGc18wxUQeGbmp+Vn7zr+sw0+ABQ+e4+z94jhy3tEHQlOestChqtmjGyjwCxraz2eB/09rQ2UBzWqXC+5odj2LDBpl+UygZXZhjHKz+AKDXyC+V0sm+L+aDxLrs5V2zx8C7bEV+5AFRpE6+PBQStQOV5jZkuvUTkWRnbXtge1/0eK6lt/JHdtlD9VCc2L4DiVNBELYrxbX7V+CDhoiPKL561PKDL19x2OdY2CAGggYDGK78GaMhekfxltQJvGbT48bSNndb+M7nL2wbusAtyFR375b7ALgtRCdOaVIBa0D9Q1wb0iV9gV7z9lhmL5L2MZTbWsmb/27Ex2o8n/wH3hmywo85MKt/Ze5gMOoW5TZ2jDDaV8lqIJsDXQszPCzSwPBtFoK7QrSH5N+LCcqmqWvj+kUnnhwLQv+kEG1CFc6pzAyioijz7M05KLQB00RLp42FHCIcy6ml/Hrpn/4U5PrxQ4Dc5Yn3eDs4J0ruXMeyGCBvYqY/n6vhkxa1yOsKIH39Pj2QNmSnm2ZD/SH6PZQgglTkIhIUBrwdQrCBCFcqQ9zYUinbs0fvBwjyCi07S71+IEGYYDdN9bhdT+GuOE501ipg9BliEyz0acUNfJssU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199021)(921005)(122000001)(38100700002)(38070700005)(83380400001)(33656002)(86362001)(478600001)(54906003)(110136005)(7696005)(71200400001)(41300700001)(55016003)(66476007)(66556008)(66946007)(316002)(8676002)(76116006)(8936002)(66446008)(64756008)(26005)(4326008)(6506007)(186003)(9686003)(2906002)(44832011)(7416002)(5660300002)(52536014)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cONVQz3nnR4NeZ6VD7vm7KPwgPsv15ynfDqM80YShXph5SMMSIYuDrxMgokp?=
 =?us-ascii?Q?msfnqvdaDeQKiuP9HMz8DwNnQ7Y7ivphoK9RVK+Ui/mIq1rfVZWDwkiu6oUv?=
 =?us-ascii?Q?M2V6xnVABNQGvgkdAVXXMWGbb+nVvZyXm1MbSqGHIuVfOAmhyPtN5U6bd0V0?=
 =?us-ascii?Q?aZhbkKd2UbXj2vGQZUkt5gVrUrCJqCgjkvwsHnBQYTKSr/CmEvuu8p3eTqAJ?=
 =?us-ascii?Q?859U33ZEB++KWLb8Sh9sgWrlSz0GnZFg7SdV4ZxfjaIM6Fe1YaIJ+XwVRkCP?=
 =?us-ascii?Q?vtdTMUk1KxIraT633DnFkSv6Wsu9Zl9/BqUCa6que0e8Y8gysnFcD96Q5ELF?=
 =?us-ascii?Q?UBrPR2bD1YhFALhAOookSRHgcrPF7yE9Ll/lVcSdkNcc0qpYcD92B0IRFEtP?=
 =?us-ascii?Q?Od/XIrlthD3ZceG2Gl2LhxANfoK+1wBXUKor1TSow3VnTCj6UKhPT6jaLY6r?=
 =?us-ascii?Q?WRx06Ft7pkHqitZgbjBR1Q2Tg1QyfAC6nG6dM2yWDDZq5MN7jCrrbogxZO7N?=
 =?us-ascii?Q?cldxd8szOXrS10WSYSxRmtYP9QSlpQzf1Z7PVYVt8CWzp8Dc+PQzxFAzcGUp?=
 =?us-ascii?Q?dxRw4OwP2lZSnd2WcYasBJkLJNJi+scfujWKxaoEObm9wYSbr4qYHalWLh26?=
 =?us-ascii?Q?3JCukR+I3p4cw5WdSrBy3Lp+DiHSBqFA4geqnLGzhg+08ttRHYm1RGglSs2W?=
 =?us-ascii?Q?/lUcBxB/xPpiqBufly8O5wlnEqcnE83u+UAWpRKCbH8mjr6EDbUfS5hI3eIV?=
 =?us-ascii?Q?3qRnTQfXagcbLW/OQ34attwuKclbrZq2iJ6hfYpD78+V+70vlXlqtBLX9D5M?=
 =?us-ascii?Q?Xmnek2LxDi5dYOBvlcG0VFqKj+wuidcH6uxbBIg41usH2EkyI4QoDVrALyDV?=
 =?us-ascii?Q?KE9md7hMhCmHHPwNc178ffAfNcACRmejxpEgQpT2HB7606LefGclEFNX9sIC?=
 =?us-ascii?Q?1yg+xpIhPHBG2+dVj7xAYPmbXwtQb2T3raQXNbWi3KnJqnRByZ7Ln0RzaEXg?=
 =?us-ascii?Q?1+2eA3bUMSvisu/CtxQlcq2IblHDwWLshn7B/gv73OF34VO/Im0EiWP87bmy?=
 =?us-ascii?Q?YKybhY56/OrW+yhdbJWVxVWmGMcj6gGJyHVgoUQD7DXQwP0krhO5mpuRF0Ua?=
 =?us-ascii?Q?n/DGCoHVCHq+5vAH/8d43Y+iJ2MqAmBFCmOEWDtGU6v6JdSi2WL3/vt1VB/8?=
 =?us-ascii?Q?MXLwi1VsbNDQodJSXbD/BiaGtuoxNV6pm56tWVA0YLj/NZQCanegHW+ICI2c?=
 =?us-ascii?Q?Da9JF+RtXMJAYJnB1a/gBkCTAtZgzdEZRMSHwB62An6Gy4s1wkLoBHw76gjf?=
 =?us-ascii?Q?Jnk2typ1pnyJqWu9J+dQwHZ6pd672JvZYmn8dm3cN4NWMj6Yl/OYkn/2Jom0?=
 =?us-ascii?Q?sPwoRhvtz5N4FTqYaXRJavOaRbN4rD+6vS/iudHulyyjzasKYD2cwRl0WilD?=
 =?us-ascii?Q?rOstMHid8UZKi9MxZ56tNxSeKZi6sEztUjvctIbux1p+RGStApieAlLArqVQ?=
 =?us-ascii?Q?Q7dNXfOUP1YvsKaXLmSPeihVPg5N5riVtMyS12U+d/9FfFzV+5obJCFxAzYx?=
 =?us-ascii?Q?9MDW+wM3fa6sX7P5sO7qzL3JzoRcxOUgWBbVPVkB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d21f134-f5ce-4b80-554c-08db760058ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 04:46:46.2514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r00aUG4eE2Lzz7aV26j3rvI4qLf0QJpGijnMnYTWOb67a2PtePrxLCx2UI1n8NHeIbdAZaHlpWt2yqFGVdu0tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8121
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2: Changed the email subject line.
------------------------------------------------


Add crypto node in device tree for:
- CAAM job-ring

Signed-off-by: Varun Sethi <v.sethi@nxp.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/d=
ts/freescale/imx8ulp.dtsi
index 32193a43ff49..ce8de81cac9a 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -207,6 +207,38 @@ pcc3: clock-controller@292d0000 {
 				#reset-cells =3D <1>;
 			};
=20
+			crypto: crypto@292e0000 {
+				compatible =3D "fsl,sec-v4.0";
+				#address-cells =3D <1>;
+				#size-cells =3D <1>;
+				reg =3D <0x292e0000 0x10000>;
+				ranges =3D <0 0x292e0000 0x10000>;
+
+				sec_jr0: jr@1000 {
+					compatible =3D "fsl,sec-v4.0-job-ring";
+					reg =3D <0x1000 0x1000>;
+					interrupts =3D <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				sec_jr1: jr@2000 {
+					compatible =3D "fsl,sec-v4.0-job-ring";
+					reg =3D <0x2000 0x1000>;
+					interrupts =3D <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				sec_jr2: jr@3000 {
+					compatible =3D "fsl,sec-v4.0-job-ring";
+					reg =3D <0x3000 0x1000>;
+					interrupts =3D <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+				sec_jr3: jr@4000 {
+					compatible =3D "fsl,sec-v4.0-job-ring";
+					reg =3D <0x4000 0x1000>;
+					interrupts =3D <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+				};
+			};
+
 			tpm5: tpm@29340000 {
 				compatible =3D "fsl,imx8ulp-tpm", "fsl,imx7ulp-tpm";
 				reg =3D <0x29340000 0x1000>;
--=20
2.34.1

