Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3004973CFDE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 11:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjFYJzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 05:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjFYJzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 05:55:05 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2051.outbound.protection.outlook.com [40.107.22.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C64D10DB;
        Sun, 25 Jun 2023 02:54:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajmtu31f91iVfPKJj5pwltdbAVaGvSZ0+A0otO7DSYSQmNB1Fl6Irf1A69HiBsk7f5dfjhkcQWYgdoqIPdM33J7LCtuzVPZPRTdQ+hTngc3V12e46hIODlxpaFAH/PRT5dfokjdsipRjRI8Yn/0Z9BLrzEauimz8wf/3hAyIIC1+18xnFfLbc4S4mapP/KThTKdKAZHpLq931oiXFPFZ/flVE4pnH+mEjZRHzdGFeGov2GbxVe8GW8T4EAJVKLQ8x+URo8pkbSOwuD8ZmmQJDQbDjolkq4AQrEEafgnzQWHo9nfx61Hmz5aEoMpEcNstUU4RhmYmpzfI5g1WA63rgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3KSAgpm2SX5c9Nc+WJipXhjla09Fqgd2y/cGryjFZk=;
 b=gwA2VOtdZl9zmAACpK8fsQDcET6oxKi4vraJE49hDYixUWms2P9YQVkcgTFM3/kY2nHQgncU0/Ejhrutcs/t5JWErHO5cN5KHt6RNlnZvgwg4IXtAZ0anZOMGM5AU1UkSPoDPEt1rRPJgj1MgKkQRh32mmL3l++PWkULyFlh0gHc18kvAgRnrwXja+/maao2Qwe7F62tqJCoqT7+iKn3dZk3C0wG4Y36RdMOckbchOAF4DUkDlFnTRPiqpe99P2d0eUgsNaIMjC0mv4cPWaxvmyD/5ezN74RQI6s/1av5wjUm2S/z16jpV+e4/xPnXNKb/cx2ikvK6mPzDZ+eOrV/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3KSAgpm2SX5c9Nc+WJipXhjla09Fqgd2y/cGryjFZk=;
 b=TAbQq7KEp/MRgkZW6KDxxyIldrlqnKAubPwZb0znIw7JCP3jjsw0Fq+QOTtdiB4zUO8BQ0NI0ok5qClVGWjza54v94LRgMdttB8ig1O80mx0Kv6tY15L19Qok+Sd7nCXT+SYONHYqmlLB7GRy235ERJR57Iirm6QH2Kq92H67TE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by PAXPR04MB8816.eurprd04.prod.outlook.com (2603:10a6:102:20f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 09:54:56 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a%3]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 09:54:55 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, shenwei.wang@nxp.com,
        gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH 3/4] arm64: dts: imx93: use "fsl,imx8ulp-lpuart" compatible for imx93
Date:   Sun, 25 Jun 2023 17:48:56 +0800
Message-Id: <20230625094857.29644-4-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230625094857.29644-1-sherry.sun@nxp.com>
References: <20230625094857.29644-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0126.apcprd02.prod.outlook.com
 (2603:1096:4:188::11) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|PAXPR04MB8816:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b9bed31-659f-459a-abc3-08db75623ac9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kwPvrLNNKGnKCtAX1mBRMc7lgTmRCwtgsiesdfAyODdrIkRRu8Ut+9zq7qDW9RLJ9wU4KCB+eQP/u27dGkUjrWhPh9XvZk/pnuCBZ7Q7n6B1pDeW5Jld/JWjEXmKz11V466oJlV6eb5ut44U50e5pjlbhzagdqbaSrZ+i9cYEAME5NwufhEn6Jn3X4KgfVs5tGLou4PdzfZ5y91KjTlnSa15YeHP2nsM+kY0ecZTnuUo07tVfZuDMiJsbWRq7H8lSQgWvtk0a47YVe0a7E5kML3IeTU3mNH0EWUTBDL7tkKk2D6/nBop34wbiNOgzcqv+A6A5nfhjS40pCafPOlwzLDrd0EmcqY5TMBpCuGour40HE5znUfvRAWr1mZ6JRb0s3VAGFRVv4Tk5ljYK9B0p3f5+tpLKy9EVsKa8kJj9xJGh4IZuOAinRTxuoA/UbQkrKkFoHAmSBABOsdo9/Ho19CkG8NSClPG37L5LyvnF2yoEi3NvTFXcUwBonpmD5yPESXqQQGNXQNOQWO3LUnJPKKAvXBxkq8oP7APlMxUE4usIDhBvIPbZofxRCHEeaMcCXwe99CcIqiTmYqLGfTGZhj+3bZid6b36hTNoCfd4lmYhiagxSg5EhLqAjTh9grH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(451199021)(26005)(36756003)(5660300002)(7416002)(44832011)(66476007)(8936002)(8676002)(41300700001)(86362001)(316002)(66556008)(4326008)(38350700002)(38100700002)(66946007)(6506007)(1076003)(6512007)(2906002)(6486002)(186003)(52116002)(83380400001)(478600001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fp38CJiTtr9mIzydFprprE4wiqzbIFwmCmtbOCUA0yfur2OslNUfKK/Gai6m?=
 =?us-ascii?Q?g3Tgjpf/6frk/ynjVrWzipzyaLZi44yv/bcbExLiAydpqEdijIRp3mRhT+lu?=
 =?us-ascii?Q?LUkgDmFkP5axzpstRY7dW2tDXRETokQaFJxP+WKaFqPaqkQz2t5QXx3byjMB?=
 =?us-ascii?Q?tVXZX/byES3kUPNOU2C+BdTKeAvCdCeF5gKKjDzzRhThroxG4KfkxHAApsJS?=
 =?us-ascii?Q?YvE6X1MKr8IUlE0WsHGIPLamG9FWs+Dd0ohI9sxGGa0I2QZVzspLXeazfrh8?=
 =?us-ascii?Q?PeLwzutT3nOA84SsE/aRKGwx+Ma3NyNIxrmA6sNJFN7Ms+OuQ05yHtJ3+QVO?=
 =?us-ascii?Q?IIEPBhWHAuAkIXMlMpB1vrq0gnkUFfAubE1iCytyA+yDKgOIbN1SmoMM7vTK?=
 =?us-ascii?Q?VpTRqR8rxv4eDhpQx7Ppo+zQpG/7UzO5MvYHHqxRfxr6mhB5+UwtOPLFN/EU?=
 =?us-ascii?Q?xSURgPcljXlIxgZU80AMKPsOfWb9E1KY8Wxs6gGCESakLuuoviTSYRQsrz4y?=
 =?us-ascii?Q?9USuJiPStpYQ2PmfFSTKiSQtIanvgfcKxMaYaTFM3RIJA39huvEPbZ4Ussq2?=
 =?us-ascii?Q?2uyTR6SV3mvp9HKVabWkqgE1dmpIuRCzjakeEsIwhg7fs20MfdR4pIpdQrFB?=
 =?us-ascii?Q?0enckX4Cp2jE1lrL0kUmlgYMsytOmUQBTl03wiTUuTereV4zQDQfgrH8H9rl?=
 =?us-ascii?Q?UG9OPreUuoL5m1/31GDY0SYLYyvGXsJ8hb3lBh9MbAb9qWU/rzewM6si8LOs?=
 =?us-ascii?Q?dnMFbO3P4vWjHwWIIy3wSiIFJSUuiLpkx3mI0XQMmZ4lMd7F3d/Oc3atfpnu?=
 =?us-ascii?Q?YN8BCLWnq7PLMMdDGMwgqs0CKSG68qjeU/TzsmCOYeOi0fSIJjkFAv9d7SYi?=
 =?us-ascii?Q?X9wxiGC0DXDiZbSuj6X1RwDzSZZG5k+EIUJCuckIHXeUl80E+1qPuWYdvEZB?=
 =?us-ascii?Q?hL0cDIIkI30mNJtAfDHMCiInFg8DMFY3yieYeWQu6p1afhYkTQPikTGW/yiZ?=
 =?us-ascii?Q?mSO2aZ17MmXD6OCP9aQfwHjGps4BSKNoJWNNEzHsZVauOA/HBSEpYTDFeK7L?=
 =?us-ascii?Q?2VABG1smUBY5HGABMfC75Ac0zJuwrpUv7gQuxKbEdO3lGQmhLQY0EDtcx59u?=
 =?us-ascii?Q?Y9lTDlFOpainQIJTSvewbS8/4znDssSrKoU5517R5z1uhYzmZrEAJTJ70k0r?=
 =?us-ascii?Q?7f6BYLwf9MfuK9+1RgHg7gbunSr3jmqxRklxhI3KKCmG3/EDCM5VJym89HX7?=
 =?us-ascii?Q?SkYBKukVM+6Rw9zlyRucByfDMNRU2V+lJb9wyozqkbzMB1t/pWUxxTpdNXYf?=
 =?us-ascii?Q?iwGD1wmsaUyDJ30IOK5VMlULLaOxov4QMr47t0/CYkDuMEhPcO2EFKq1QxMF?=
 =?us-ascii?Q?XQgBeKQY1GneL4N1lm1lPbBwCX9H1uHz6g/5tLJxrTqp+LO8hGhDNncD68V1?=
 =?us-ascii?Q?NAFt5ytIfn4JhnulFIQsJg79oeZVqoAp0IdUZ8Y5hwJLFG2rqcTI0pVI3pyZ?=
 =?us-ascii?Q?XpNabgEUFpQNOmRhdHDAymRXAoHajwrDY5wBmA33D4ZYO7cLyBQF1BhL4BT4?=
 =?us-ascii?Q?h5Tv6oNQmnMgMoSdZngX8U+Q2b2h3xhv7ILCajJk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b9bed31-659f-459a-abc3-08db75623ac9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 09:54:55.8560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jGnczqgbjklQO92we3O+PP+9K5DTd3Yo1B20MHCHM5j5a0EOK1Hi6Vh8Sgmn612OHLWSeUfbJU1Lmaf7b02GlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8816
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX93 is much more compatible with imx8ulp than imx7ulp, for example,
i.MX93 and i.MX8ulp can support EOP(end-of-packet) function while
i.MX7ulp doesn't support.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 8643612ace8c..46fda327ae5e 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -252,7 +252,7 @@
 			};
 
 			lpuart1: serial@44380000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
+				compatible = "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart";
 				reg = <0x44380000 0x1000>;
 				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART1_GATE>;
@@ -261,7 +261,7 @@
 			};
 
 			lpuart2: serial@44390000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
+				compatible = "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart";
 				reg = <0x44390000 0x1000>;
 				interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART2_GATE>;
@@ -486,7 +486,7 @@
 			};
 
 			lpuart3: serial@42570000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
+				compatible = "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart";
 				reg = <0x42570000 0x1000>;
 				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART3_GATE>;
@@ -495,7 +495,7 @@
 			};
 
 			lpuart4: serial@42580000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
+				compatible = "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart";
 				reg = <0x42580000 0x1000>;
 				interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART4_GATE>;
@@ -504,7 +504,7 @@
 			};
 
 			lpuart5: serial@42590000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
+				compatible = "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart";
 				reg = <0x42590000 0x1000>;
 				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART5_GATE>;
@@ -513,7 +513,7 @@
 			};
 
 			lpuart6: serial@425a0000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
+				compatible = "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart";
 				reg = <0x425a0000 0x1000>;
 				interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART6_GATE>;
@@ -551,7 +551,7 @@
 			};
 
 			lpuart7: serial@42690000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
+				compatible = "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart";
 				reg = <0x42690000 0x1000>;
 				interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART7_GATE>;
@@ -560,7 +560,7 @@
 			};
 
 			lpuart8: serial@426a0000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
+				compatible = "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart";
 				reg = <0x426a0000 0x1000>;
 				interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART8_GATE>;
-- 
2.17.1

