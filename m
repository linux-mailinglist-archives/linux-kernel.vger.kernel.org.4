Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5D4747B59
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 03:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjGEB5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 21:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjGEB5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 21:57:37 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2058.outbound.protection.outlook.com [40.107.6.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC6810F2;
        Tue,  4 Jul 2023 18:57:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXYLq2boeSSs+7vAuJGN2Wf4xPeVwWz56z9hG5FLsPv6U6S9GO2e6AV9xBSNhLPhICl6/bzxqgHqJ8g70UJivz6TsWBOQEucPo4lQXA7jehZ7JzEAO04syjUxl/ogSyZ6wBiEyJZuOsmcKrrES9GYzQJe8kjzpAEWdEud36CGFBhXgrLPF+SCkjj2MvdWTfIeSKVv6Jsd4h/hU0wIAzaLwSmwbSuDaRriKpHv3lHm0wavfmSaFDzexdydqCljIGJvTTMw8RYnjc3WpGqrjVx8zvkn10PLLl/yisG6HZ95HQ7LVgL93pxOUTL/jyIE/KwYoOd3kMk30APU0xHv6sw4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+2oIdvGmV+wFU/Ddd/UarSTFl2JuYWhYJwY8klgrXk=;
 b=S8W2lRI2D475J0FvYjgyjpwBXMxTFNaSAj0smxOs0jh7pH4Rq+j08knL/8sLMu8NBjB0nFI+g0PySE+QlKWqJjPWKLHMdP8Rh1TvLCg1jb4HFMCOAC3eBA8UJazynL8TFWvY2FfurrdGF98yRswYD1Wml1+p0rS7kuhtVkAB1df/PAUUO69Zmcu/QGZmwflTTFB9qLn/0Qtg0+SwkN+G3AeoNiN2tFmmBrhGPZAMTB0tgXiAsJpqTmAUUOS711zcBIVtIJoebHkZnQKOLeUcxBTnq/SRfzRX735aR/novTK1a0PO/ACno6HHEfR3C97TxJs19KAJqUGbfOkOvJswng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+2oIdvGmV+wFU/Ddd/UarSTFl2JuYWhYJwY8klgrXk=;
 b=qGd+Y1XcpBFFx2XqF1nb9zurnToTgkaPxWyQFjRwkp0kOdjLZMZ3fVXZAQsWpKNibd+5g6NyRoJPzSUxciBWl0nyxIdPzfFE0C+vwP1+p/CphB6JsZe9RHvjjU4UP8KVMKbMcCGynK4HxZd2GNENDq/LEj4UWbFg/0pZiaIt6Lk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by PAXPR04MB8845.eurprd04.prod.outlook.com (2603:10a6:102:20c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 01:57:33 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a%3]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 01:57:33 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, shenwei.wang@nxp.com,
        gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH V4 2/3] arm64: dts: imx93: add "fsl,imx8ulp-lpuart" compatible for imx93
Date:   Wed,  5 Jul 2023 09:56:01 +0800
Message-Id: <20230705015602.29569-3-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230705015602.29569-1-sherry.sun@nxp.com>
References: <20230705015602.29569-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::24)
 To AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|PAXPR04MB8845:EE_
X-MS-Office365-Filtering-Correlation-Id: d69fb2b4-2910-4864-021c-08db7cfb3281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B7I4IyiSDzd8tUEwiHgMji7w2sHQB20V6Iufa0MRCPwkqPJQZffqosuMY/oRMjuBVhxsqMb5efT43Tkur+yOtib0Qz7TmeG3iOA4m9TPZZ7NKEXNAd0D2KBwapIY5G4RApSFyEKkVuZL9gR51OP7tf/BCLJ4psC0Ygz+MtysvD2ZmzW/HQVGjOuD/HIPDbufssHI2NsAjUgbV0ulJxgzfn4tAb8wvh5iyAGBnLIcsyk4SLptvrm6Q9byMIuBuR4B/6noxUsZMV2pyJ9/bpQ4AhyRc3v9OSdLGO3uq7zJ1cbqomPJd7vsH0XViopDNII4eC7XWXRMOSzZWLBOIHlpsA8YLbGxvUbPC+PloCUvzvLfCFWoyNmyERlmNtK7NitDzvxPW9vtdD5W8k961tNO2DeX4uJnB6bsNZBZEjG0oP77SiQtmW4NQkIUCbBQKeug5jhgnqVSMXXg6EUuTsbokt89Yo60zFQzoa37KJaIVoKh7ZjQeV1ke743DRMKVUf8gLGovqBKNpONicn2Z4rSApJJM6SQumXhnlpHeMCB3pQQrUTMnFOh8vQthzNkFfr8NBmLcVJVVAG8J0KVqickqVd8QiQjwnqpbOof82x2DxD6NsrsthYGVU5IX+rJmT/9QxmnAvqJtunVRc5M/S/Jn8X2wiSSLNLxDsuzurE7gWU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(396003)(376002)(39860400002)(451199021)(6512007)(1076003)(6506007)(66476007)(316002)(4326008)(38100700002)(66946007)(38350700002)(66556008)(2616005)(83380400001)(186003)(26005)(478600001)(2906002)(8936002)(8676002)(52116002)(44832011)(36756003)(5660300002)(7416002)(86362001)(6486002)(41300700001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LozrIJk1dGVg6LO782fbUKm4txZddOIDUPJpkc0cd2zkZDKQDyXsyK3QXJ8h?=
 =?us-ascii?Q?Ynb63Zp8C/tlSkCTUijlgoGJNY6xP/QsObjSzu0gkIkpnLjpix4EqMf5KAMb?=
 =?us-ascii?Q?y2XHhYTpmBEM9FqwCaec4+hXjwF2/iDJuo4DUZmHp/mVzulSw5rHdUeSjFNK?=
 =?us-ascii?Q?KXL1r7T/frimZba+ST/lXIieZrxWhFp8fU5hSm2XMBamqQofiw6pjCBqVj63?=
 =?us-ascii?Q?eFnOTwe0rIeNNkgWSUZw6ayxfIv55VGCvbtikxdJgbxWaAs7ud8xMIkp8vqG?=
 =?us-ascii?Q?KsKJWFQy8TPzJi+8EOD+hD3/NmCuCI72pRaDTyckRVQn0xPbo+BkFHUskwzI?=
 =?us-ascii?Q?f7kl/mZ+2Rxz5d8wqvW1hED9rYvOMHrjiltf4J1AiuvHD4usfF4B9XPE/2gw?=
 =?us-ascii?Q?7FBGPmpobL2ETERnVawY6WEt8MkJwcTS3M1J/kD9jVgFNIK8OH8HR2tuvsFs?=
 =?us-ascii?Q?r0vK8Gj5kfmj2s8xTF6tDAgo2gQt3DX7oYlcXI8nLYZzhZBx2bjVKF0CHQlA?=
 =?us-ascii?Q?iNC9u6pYPY5Dy0yC16b+QzIWM6rE55BDTVV3vj2IvvrEAJZ9CKd3+f/CBE5m?=
 =?us-ascii?Q?ououASbb8AyzRfXOEKIUjCTPrbMe/oeg0mE+XHAgLF8ZMzgvesB7XKxYIkq5?=
 =?us-ascii?Q?39ZyxNw4Qi8B7IfgicTrZxLRy2WyNNRVRrfnKeeCDq+df+7PCKzMmJDOhS/g?=
 =?us-ascii?Q?PgQ7SE2Jo05dt/dx+fWuYEjj8IKpZdXpUzTKsJVc4qrhCvDJIdba70+KfD8m?=
 =?us-ascii?Q?Xi+ijfFTQuaVTdDr+Ui51DK+16Sr04xhQgP0kGIRB0JMvE4O0Dy8GB/4rNdo?=
 =?us-ascii?Q?Dq4ZOcWtxglwBMVPD7KQcWipIeT/jkOrMQNxL/wxzlbnLy+eEeLhKfPBClwY?=
 =?us-ascii?Q?ddREIq/O2xb1VpCYg4nDN+xSay6pGoQDxsqMGDDfHuWSBhyBBzbkS7KTxow4?=
 =?us-ascii?Q?cO3eVwTVGXzt1xDOZ3xGuIwNemwXiJBwUg+WgHM/Qa9MFNg5eQzQc/GuRiss?=
 =?us-ascii?Q?hM2HJjbV+xQsiIx7wvr8Fmr6DWdk0NIrHo8qfHc0aGffeYHIP0YLPwMKDUvI?=
 =?us-ascii?Q?jklqhiQwpmEPttl9jip9cMrPqZBbvvK1ngvdM7QfKNNWLI82DuydDWMqh57E?=
 =?us-ascii?Q?uCIXfiFbzdNTENFhfGMFOuCu1fqAzigZXsOLhVr3W1IHyRkLwTdnTZvE8GNQ?=
 =?us-ascii?Q?7vPtXhfDMQX4JPXOdixxyUCi2CpFQLk8xLK21CQA55gtVPlZ7JWmDOlZPoRl?=
 =?us-ascii?Q?yN49CxeMnMHUFX9Qhqu6k/5//4kpWOyuG8fjLp5Xao/N1pKzRyNmFKZO8hGw?=
 =?us-ascii?Q?aunMyHmQfE/4JWXtYEX4NJ/y0iqqnyzAfw9ThS08AFxNRXGIx82EripKTmrh?=
 =?us-ascii?Q?TFxIGV6L5cK1FiQZJNChK0bBqBNXuwRTc+aWze+sd6SHhsixOfm/q/4h26oy?=
 =?us-ascii?Q?dskOuBOxQr3zWdS04/csX/XFN9ik8+WWfy6JiWq7s/rr2U4ADTIVi/Gwavdc?=
 =?us-ascii?Q?HArlXr4MX6R4ctWfiiSHzg6aRksRwb7mhXM8VpjsRbnqdtNXo2ZA4S6JlN0b?=
 =?us-ascii?Q?S0a6FW/Iqp3s26uALoQ6PApNeJn1UViREEHdvLd9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d69fb2b4-2910-4864-021c-08db7cfb3281
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 01:57:33.0705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2cvnPBBpzjRLPCEHMvayxv8a7Hhz2BPB4y13akG7FVhsLS/mpxoj23DgDVvURMc+XsIEfEq3cNVzcaJZi+VOGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8845
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX93 and i.MX8ULP lpuart add some new featurs based on i.MX7ULP, for
example, i.MX93 and i.MX8ULP can support EOP(end-of-packet) function
while i.MX7ULP doesn't support, so add "fsl,imx8ulp-lpuart" compatible
string for i.MX93 to support those new features.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 8643612ace8c..16da5ef578c5 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -252,7 +252,7 @@
 			};
 
 			lpuart1: serial@44380000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
+				compatible = "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
 				reg = <0x44380000 0x1000>;
 				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART1_GATE>;
@@ -261,7 +261,7 @@
 			};
 
 			lpuart2: serial@44390000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
+				compatible = "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
 				reg = <0x44390000 0x1000>;
 				interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART2_GATE>;
@@ -486,7 +486,7 @@
 			};
 
 			lpuart3: serial@42570000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
+				compatible = "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
 				reg = <0x42570000 0x1000>;
 				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART3_GATE>;
@@ -495,7 +495,7 @@
 			};
 
 			lpuart4: serial@42580000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
+				compatible = "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
 				reg = <0x42580000 0x1000>;
 				interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART4_GATE>;
@@ -504,7 +504,7 @@
 			};
 
 			lpuart5: serial@42590000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
+				compatible = "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
 				reg = <0x42590000 0x1000>;
 				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART5_GATE>;
@@ -513,7 +513,7 @@
 			};
 
 			lpuart6: serial@425a0000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
+				compatible = "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
 				reg = <0x425a0000 0x1000>;
 				interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART6_GATE>;
@@ -551,7 +551,7 @@
 			};
 
 			lpuart7: serial@42690000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
+				compatible = "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
 				reg = <0x42690000 0x1000>;
 				interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART7_GATE>;
@@ -560,7 +560,7 @@
 			};
 
 			lpuart8: serial@426a0000 {
-				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
+				compatible = "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
 				reg = <0x426a0000 0x1000>;
 				interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX93_CLK_LPUART8_GATE>;
-- 
2.17.1

