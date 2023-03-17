Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696C66BE945
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 13:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjCQMcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 08:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjCQMci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 08:32:38 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2074.outbound.protection.outlook.com [40.107.241.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9276FFDE;
        Fri, 17 Mar 2023 05:32:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nr9+V0vWlc2HvCSJY8XWM6lDDuAfAonPm44DNDwoGm/uFLPt+p6ci3BXnSoc6sf4RaQ2xxUty4hu9SOULSa+rbBXZP4qyNqO4ZWsNVHjlGRzp5Xw8XViwH+BoilieGoZubTU3b7bM2Pjh+MqJ6ESChivVULGV3imrrBTHBDIP583NE1BHQeM4bDOMsvyqdVCHgu+UeHqRC858mO7xFORg0D2JpLvuq+7rBYctqGlmhw4N/x7tLNI4wSZ473HVmarz5gx9iktEvZjOfNxHC3icLw0IuK93SDgsMSTNhRRXN9G62p8VPoyUc+hsVnKz0/W3X5iLHRgw+ETTX7Nnmbphw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bEFt01oeXktAoasX8gfn18yVdwp45SrLy9riv98vpc=;
 b=dci2IpTa37qnStkeUytNZyQPNFKTGBc++L9j+iVmi5WE9+rlEwoAfqenGNhtRtpNPkYoBhvCajA36JtUZSCs5PyIEvY5J+lej2Pr763y++xF6z8iYDJy1K+v15OnqjWJXn8moW/l/6VaYwerfW8U6Da5C3JzcOutSy6QdCHKAZOwY5sRfhvwcvIxrWIgtjwB3/I8tOsZK/IOywG7Qcvll7XRZa6jSSarnxYhZeCk029BKyVasQefN6eyB+eyMmMBoik1ibXg+Y2oodhfiC0z9XFuqef+35hNwomb2sxZnyD0Q82n2Bl6SO+PyI7aMFtdaJ5hIS3E+2zkK8Kx7kHBTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bEFt01oeXktAoasX8gfn18yVdwp45SrLy9riv98vpc=;
 b=mM6bjroFo3XAxsYSJ3Io/jDzV+sId3JtRTnrNeWI4hleIaN2wLFZtDHPdcVZtjUyffy2d8IBldLt3aAfk79PlvOZd29E5DV9tlRJyAcLkSviv/KBvJNu4ThGS/wwSl+ip0r4yqDppJFBs2HpaquXcycd4ERfE5TXtVGSSN0F2qA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by AM8PR04MB7361.eurprd04.prod.outlook.com (2603:10a6:20b:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 12:32:22 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::7ebc:3d88:4dd1:ecbf]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::7ebc:3d88:4dd1:ecbf%6]) with mapi id 15.20.6178.026; Fri, 17 Mar 2023
 12:32:22 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 4/6] arm64: dts: imx8mm: update usb compatible
Date:   Fri, 17 Mar 2023 20:37:06 +0800
Message-Id: <20230317123708.337286-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230317123708.337286-1-peng.fan@oss.nxp.com>
References: <20230317123708.337286-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To PA4PR04MB9416.eurprd04.prod.outlook.com
 (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9416:EE_|AM8PR04MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: 31e0cfcd-37a8-4468-041a-08db26e3a7c7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xYhwVSKqaX6kIkGDPQTDKAhZuuCqf7DoRhUdUKLlTg2GmPcBBHvXK0EIcCPzNFShYrbaff03HbTSy9DWJJMk/fHlO1RBm/qyV0uMHmgDCAVZzfqJy5Ril732BOxyOGp9aednKt6pzENYdJu5hZn2QV59aMQbo9kUdRs4kPFXgz1Pfh7haQ2PsxbRGm9mIOBGIvNOnsIwW1tR3z0x8AiFpbbudlBtuMPCnrdIcYsjt5YHZNNh16POvSiuhBwA90/hhODPe3FuRcg2PS0XsgxjrXgQEq+d5e/10Czrr6zV0QLhGYdzLnRZyCPQSZU/7DRtGdN3Mp8SuALlDdRAj18h1CIrbhvT2KCZslyTvu2tRqhpiII+A53dYeW6OF3GkYbZu08wT0eAk2u4pXmQ8GdahgVPezv8QbDISAeanmNyei8NDB3g7JvK2hXgZ/ENp/ueQwsQUyWQS5n5Z7Q24np+ljf290ZB57IT46A0DYYNe5kZXBejkUioEEbbnQZt7im+3iGQjLaLoqUL2vPJz9dLdIPyhdBQTgZ/99oRWW/OR/ivPP4wyS1JvpoRxUHNqUlHyu00hecCcnAjAvMKFmlMPY6xhxEWPlay+v9P/2nMQJXjluvP9UrxMIONw1g22XfNjjJxQtONUWJuIzKSt1IEB+7W95GevfhH5gi7KOf2oJT8ABrEU53idc/VW0LQWCJge124xfH4U5ZO6yQxSbWg7oO1PHkntIylJX1bERUpyso=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199018)(38350700002)(316002)(15650500001)(38100700002)(2906002)(478600001)(4326008)(8936002)(5660300002)(41300700001)(66556008)(66946007)(66476007)(8676002)(83380400001)(7416002)(86362001)(186003)(52116002)(26005)(6512007)(6506007)(2616005)(1076003)(6666004)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3vBvgNsMBPLl6x1L2zRfONth+mZMmHlkRFikOzi6u9SXDdZRF0QA2LIK9Stx?=
 =?us-ascii?Q?OSk8d3YiMctvOqBywQExwUFKIcox+qvjiISfZv7WMcqS45MUTQljKyvwTUQt?=
 =?us-ascii?Q?hDgo3YFO2hfpHCxdnH1FfApIX9xcmTCsq0GY9zJobVi05TlVLQZBDau5B0WY?=
 =?us-ascii?Q?Fg/++5CusHqokvm5A6SdxYqnBi5CxVAtGltq5+LSnZ55iQVaLi2CDqWW51kc?=
 =?us-ascii?Q?lKsgbQIMxh8BkX1z29fPLJD4keCds7DQhCJ6Nz2F59hWJEqnTFVG1arstq8c?=
 =?us-ascii?Q?6Ekl3DZoUKmCfG/AxesC2GCowWPgo8sGbX/v0X8miH3vCHdbnWdS3FlGv3C7?=
 =?us-ascii?Q?oi/k6bv9IxagUrR3Zxw0+lCUrR0p0O/w2yOOe0L8Zb6TV1fyiw0t0S01cLUv?=
 =?us-ascii?Q?vS6oJ4pC3kKi+RS66i1TZMuHU31dkHe8RBm+jBBVLfsuJkzCG7DlSmR+POsQ?=
 =?us-ascii?Q?DpFl1EO33m8kfrncrnqrzTp/fs5TLXXXZWVOzuLZOi9pCs0WggdJEXoXdssK?=
 =?us-ascii?Q?eAFfA0EkravZx0zYFOYirQ2E7enudO8/E7nk/fGteY9FPyBK0VkqngsW4eEb?=
 =?us-ascii?Q?7Z63M63qU73ssPEWBhizlqgi6yzwBQ5xeddOyjgb6r+RlSnRgqS9oO+V5zl2?=
 =?us-ascii?Q?K1J+0i/d3Q3Fb2te85uTacHzFgZTWGsv9zBowg3Xv1ZXfBDHVo6WjVlMT8HG?=
 =?us-ascii?Q?aUyK9ytwrhz0JpeOpt6Ds+AS5eKRoSLM6ZeCLmSSzLUU/piTQkgU3iMr3ZBu?=
 =?us-ascii?Q?HUL5BjxaGIO4JUzOUksnTDwFdZyRWHXCO1isyRSVeIGXWYQ3l2a4Gxo6w4qS?=
 =?us-ascii?Q?VYfrF0ovGwCKlIDQfisZe9Hn7s6noVYmGL4FBwRBDeHu8TBlzVa2NA0K3cm6?=
 =?us-ascii?Q?7kTbnEm03Q8pRU37NOKFKvkeZJyu6yuod0yD2yYL7jSS8BcGtp7Hk9KJ+jMB?=
 =?us-ascii?Q?8Ut0BAmkO8+MFLOQ0mC2M/4uCyhvudCF/pwPASu/Is0a9vwbn81zgFIIR2x2?=
 =?us-ascii?Q?a7MSnwmHAzTnxs0ZRBshb1Utbeb2KLBmOBMgORKsz6OTewDuQnMV26quennz?=
 =?us-ascii?Q?myMRkOwQ9UsmLgRrpFhTyJEKoaL+wEb4C3kQAskku7VNA7gP0q03PRIULcCX?=
 =?us-ascii?Q?25EOKPQFFqhI6DKwvfrSoC9S3qc/NITZrUuFdP+wYyEPZZD4lOXLZ/3+tBnC?=
 =?us-ascii?Q?hZHn9LEnNRrOxJP8z7YqjCCmVIIzEX9Z07lV25yhBC/5yFvQi5Ifl2nVJSAe?=
 =?us-ascii?Q?coXWwQnBiW47cnz0jnclF4rZpoSSDzDmQgH/9JGk2a0nUlLPEJ+nL5DMTPQ/?=
 =?us-ascii?Q?ZaDDC53jDNIje9D0qqkmXPjTsaryewa8tcOXMUEPo26GA93e9jq0cq7gzBTT?=
 =?us-ascii?Q?++bcEZ0OOzpDGZA7H73JWdZoB4OfEYiuR+osr4jkHBYvdV4r+TqKnb0uWgY4?=
 =?us-ascii?Q?CImsxO5b7x5JpDrVhGwXu5hwXTOlbGoEeiCoD+rDsWY1XLYpIz/PfzmfY0CM?=
 =?us-ascii?Q?bPwBmXkSSpvTJ6GrCfPXBZNGx8afFS4y4aaa0CxJvlr+J6gBuObnxSP0nme/?=
 =?us-ascii?Q?Rn/1Za97+ByVjsbKLwONpEXWf0YQFx90DQ+PD8W/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e0cfcd-37a8-4468-041a-08db26e3a7c7
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 12:32:22.0294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sWowbWADg/lfHT9tkIEjmvlcXV5I7OnszRklDa9gQVVQJHwfKiACHWWneLkuywBR5CjHDdpnWuO16rzM1gQqdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7361
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Update usb compatible per binding doc

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 31f4548f85cf..719e38223bef 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -1198,7 +1198,7 @@ imx8mm_mipi_csi_out: endpoint {
 			};
 
 			usbotg1: usb@32e40000 {
-				compatible = "fsl,imx8mm-usb", "fsl,imx7d-usb";
+				compatible = "fsl,imx8mm-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
 				reg = <0x32e40000 0x200>;
 				interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MM_CLK_USB1_CTRL_ROOT>;
@@ -1212,13 +1212,14 @@ usbotg1: usb@32e40000 {
 			};
 
 			usbmisc1: usbmisc@32e40200 {
-				compatible = "fsl,imx8mm-usbmisc", "fsl,imx7d-usbmisc";
+				compatible = "fsl,imx8mm-usbmisc", "fsl,imx7d-usbmisc",
+					     "fsl,imx6q-usbmisc";
 				#index-cells = <1>;
 				reg = <0x32e40200 0x200>;
 			};
 
 			usbotg2: usb@32e50000 {
-				compatible = "fsl,imx8mm-usb", "fsl,imx7d-usb";
+				compatible = "fsl,imx8mm-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
 				reg = <0x32e50000 0x200>;
 				interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MM_CLK_USB1_CTRL_ROOT>;
@@ -1232,7 +1233,8 @@ usbotg2: usb@32e50000 {
 			};
 
 			usbmisc2: usbmisc@32e50200 {
-				compatible = "fsl,imx8mm-usbmisc", "fsl,imx7d-usbmisc";
+				compatible = "fsl,imx8mm-usbmisc", "fsl,imx7d-usbmisc",
+					     "fsl,imx6q-usbmisc";
 				#index-cells = <1>;
 				reg = <0x32e50200 0x200>;
 			};
-- 
2.37.1

