Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873D373D6FE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 06:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjFZEyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 00:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbjFZEy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 00:54:27 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2052.outbound.protection.outlook.com [40.107.8.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D29100;
        Sun, 25 Jun 2023 21:54:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Anc7FsZCvqLmjZ1NSy1+uxZOiPHDhEi7t5XXPjKmlmW044l7XAIHLtNdg8s7QUiaTqzLilF9aX+5nEYuvLpaIyj27rnNfv1AEqEMF1mbzSix94F874c+cT2PSy4e/dCb/a78zMlFRf69DAOJYelQLB+LiOR0t/uKPweKtQW8pj7QPR4I8NvBe8nC4YiOn3XnsXOcM00Wf/DE21ndWg/ytx8EQNhyplG+4sOt8jdue29RSsdoeH88YOV3QgSyQ7QkXBFQnvjFufwJr/pc/Eb4DKn/dBYenePMMcokgcWCPq77x74ZnXwmrrxjNQxT3gduMpoNYiAFbzsBUrV6gbpb9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+2oIdvGmV+wFU/Ddd/UarSTFl2JuYWhYJwY8klgrXk=;
 b=nm8xTM/8Mys7FRmu4yz7miukQqu9qmrHGtbxNOsSsHFqBWAap3pA2JTLbBlUb7wxM4D3OBpVQ0vkPjcOrIZs/sT6swvruT3bz/XkN69NH8z4Gk/arEzP8GSE7SyJampFjxVn3PzGzZnzg5JyHYD5vfOUBlzQneoJ6dui0U/otni60iNYP90z5oZTzwdMak8VJT35tkZRj2FCPMOjwM9w93Dqky7Tsd8xyQB7sEWzif6pt+ZLKQJjQ3GVKU0eJS+2INUPRynjWNN46+VBPmRgUddSG+CbO61xYoOcZ4vJIxdD5OFzv4c9BJenuz8CDERkv9pye3uA0vyWOY6hFBUpVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+2oIdvGmV+wFU/Ddd/UarSTFl2JuYWhYJwY8klgrXk=;
 b=eB7hoRfL0AupbKGliOzMDM2xysW8R7qf1MLMp5E0Wvh3deqs3B/OG64CCYbeESd0MU9/lmecZup6Q0uIjABnuKSZXTYYFhk5GAwSRFqK3nKep2L6kxSymP9xDk+XbajT9iI9UakuuI8hzXRLsJXq3GMQq+esBrYB9GcEcjNUWK4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DB9PR04MB8092.eurprd04.prod.outlook.com (2603:10a6:10:24f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 04:54:23 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::ef9f:1e01:e8a:6a4a%3]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 04:54:23 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, shenwei.wang@nxp.com,
        gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH V2 2/3] arm64: dts: imx93: add "fsl,imx8ulp-lpuart" compatible for imx93
Date:   Mon, 26 Jun 2023 12:48:47 +0800
Message-Id: <20230626044848.4417-3-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230626044848.4417-1-sherry.sun@nxp.com>
References: <20230626044848.4417-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::27)
 To AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8404:EE_|DB9PR04MB8092:EE_
X-MS-Office365-Filtering-Correlation-Id: a1458e93-5452-4898-e606-08db76016929
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bsN7tDp2cmXvG+jBzFFl4OJfJDtMZX9wBimotjca5DYjfLHPuRFcI3Oq1C1rgOwHNP+dTrppTy/tfAjeg4AF8OnAHY9WCT7F6VggGTXAmYS/4vbCPzA4VRepiTr9Pb8lJ7BgSc8ORh6LUN/vUFdozf0aV6UI67iqSzYbi5XBfDaA3OfX/0lrh452RkH7j2XMJJOk09zmxCppYaXGbBFLayk5eo2C5O3CjUU91omLcosYanP+PIlELduhEG48ra5Fga6/V7qivqWMZei6YywgawCGpHyhiUZrLBXD0O3fsU6bl+ftfdounNQqCJyBM2f4c7JzarC++2nmSkQSKwVl4zrljcAvIer4HUk7YFK2iaKxuvWPvvnUgY6Z0GyaWKSoC3nOQVoFpcKFCSsXOePJBpYietE2tcTse2xI7WiMZpDVPcF0CHIF6LAD0phGlqeEANjgvtFVm9CdwXmsCIpR50B289Uj7tuGVz6jY0FcpW7WHuyqJt/UuQSO2yyNqb3bEBrfib85HhG/XHTIOlnaumN2qjYu/NTwFqPY7hMDpK1KyqoyLhdvm13Sa/SH+XnUixRUiUuIJLC7FTBiQnEFJWk4yZo54boQZuGM48KvUKFWiPiC61+mkdY/OPsRbMfP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(186003)(26005)(2906002)(52116002)(6666004)(7416002)(8676002)(36756003)(316002)(478600001)(6486002)(86362001)(4326008)(2616005)(38350700002)(1076003)(38100700002)(41300700001)(44832011)(5660300002)(8936002)(66556008)(83380400001)(66946007)(66476007)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QOChmsInzOgS90p09uUb42oqp8jjEdMnGgGNHURLhjx+N3vddFeIeNSStN/t?=
 =?us-ascii?Q?NraXy+0zjcuYPPaKoj3gu/9OwndkrJbxsWV0OpFt9+rF4QROmQUdbE8o0jsp?=
 =?us-ascii?Q?e7Y4zzoslbu4YreZOjq72qRIeUDYmxluen5L4159FFwH0ILk37NqSEPC1l5I?=
 =?us-ascii?Q?fk+TGVjOax3x8jZA/KfQvoFgXcRLcxcE2RUEcLJqNmYBZSwIkDoRcunF5/Ea?=
 =?us-ascii?Q?9yui+FidwnHi0vyh+MfmqBWoSKs3xkAggS2YVpxRf/NfZ/O0Te+tEWs7sPqf?=
 =?us-ascii?Q?p+XHEgm/cluwVrIHTnafPSq2oGNLa6WJIYjCYLzB38EzIb1ztE2S2N6pZGy9?=
 =?us-ascii?Q?Kkj9VkzHPCIWs2tDR4iR5MIPP8/m5+j1AS22qVds4fkBu8X8N3KXovXv6o7v?=
 =?us-ascii?Q?UJ7r/xUIKZiTr/H6ZgogIKsdRs31xV09xXCvNx4RIohVX7oDE8P0VgTkQIn8?=
 =?us-ascii?Q?dMeP/8euNx/NYQa6E0qt+TM6iGQwGmcT23W7D58yTqLCcWHOsa/aPSoYNloL?=
 =?us-ascii?Q?2wxJPnoeSWgDrQsu5e9GaRkxV4OOFVlmLJ/OKg5Um42kAUHgdz+cVDsySNSd?=
 =?us-ascii?Q?EypLdz6dw9gPle+2Xjazggn49caZJ4gGdGz9/bbgqrBdQ5REHjSk4EA3G2wJ?=
 =?us-ascii?Q?JR3cSIXJ1xYJRucpJyAAHEabZGrS3FojGHHpNCutwcz7w4rj2KVW+Ik6sCeS?=
 =?us-ascii?Q?iW8GXt70OuXamogzBr2TmDwxZDKD5JdeOKr7xXoTrFtbsUZVbH7Of0dA8sr6?=
 =?us-ascii?Q?vCPFKI/jZimz79BgQOCgRpZVnImkXXJp3W/38xC5jdCGBAN66FAOG3A6wJv3?=
 =?us-ascii?Q?V9fKRopkX1r/B6zcgU2rm/b1Rbt7EljsQHZNswk2G6bCQJcrgEwXKYXM0lz6?=
 =?us-ascii?Q?OJ/pkgVZB1Ge/hX62iJSdskd7p3fVHpqpqsIUWUrL123MCiSnkYUcUC2REo3?=
 =?us-ascii?Q?x8YfnqtuEriFc4x1J9nkaFQXyO9wyxaxNOA1Jk02+j39LoPPsDHyTzhfyezc?=
 =?us-ascii?Q?WcabmCJfFExayyqMUVlZoauWr/hGglEzm8yevOMwhec72WBmFrsxYlrnU6k3?=
 =?us-ascii?Q?wxCxoq1IAYt8AsXWnNj0nTh0F5W2Hvkibbz76lPyBeD/fFXfvhZ+EdF+30gT?=
 =?us-ascii?Q?URx1dUmOj4ZIfAjWHVcaY573Ju1xvyek2yi0c1lRWI3o4oe7xb12izuAuWxO?=
 =?us-ascii?Q?yA1GhrEijbQVYFqVOttnQ1TWekEocmp5NyWk/r+f+7swKj+QTtB39nuDGkzG?=
 =?us-ascii?Q?KMvBndXVP3ryy8CDpOGqoV1vAbIZuhKh9xPebnvIwiAF5/pu4JfxzIcjg0xc?=
 =?us-ascii?Q?JqFxHKAOUbuQxVGQ3ks4kwe8bIj1fO9ijsI4IsBMbJb2bSZQRX9oTM0Kl7Rk?=
 =?us-ascii?Q?i34Op5gEojdSXuCe54UY5tqKs2QDToel3lahrtMnawRin7iqqaUeylzza5NZ?=
 =?us-ascii?Q?bz7lwwt3nPjb30ToO9VCPtMs2c4exP6IA8cp3haYgcmV15tF3jrhB77Flbub?=
 =?us-ascii?Q?n/ZDZV1+sGu6yDn92uw77sa7cZRZ5Uwh1z9DuVzpgiPdT0/bphESE0ZuDUZe?=
 =?us-ascii?Q?max5u2WrhxAyJ+Wb+GjjEkuouc2zOyIzmji8EgSj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1458e93-5452-4898-e606-08db76016929
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 04:54:23.6327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YWDTPrDKvAJHNHfcAwxrMNq9Y6WnJTxfAhLB/z4wkcS9HpqU0xW3Aza2/8MPcyI37FmQXSO2EgpKAsDKXIchfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8092
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

