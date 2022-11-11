Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69FE6251AB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 04:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbiKKD2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 22:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiKKD1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 22:27:49 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22A365E50
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 19:27:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7IJ4oFnBSVU0DKkVIN/T8yqEmkImU2kSkJW5N6svjZqvtDGANYoDIEqy4hLpPnTZn/Ca9TGXo/AMTI8FkjDtKt9qNBl4QtuW13ftSqakO04uT2xBLspgbmk0kM47UY4+s7mgyMHwuDmjNaCja2QERLh7ymkNOzxl993a96vTI9CtAIEIOKK1F8gTAlWNS9fr45YJ+4XTaNKBzec/FtSg/EyxVIOz/DNOZiGKXycnyLl1isGyUVkrk0R+EpeI+4t6zR+w1v0X1NK5rNVAOcAYuS6kVgUAQ1JsXjPE6WfcREA93BZNXZ0Hfu3C9jp2ET+x01few5fR8/eT8IFxKgWVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lp2YYOSAdZyP2Ed0cVr3XmjW1UCXA/Ikw+0NhZenzck=;
 b=UedBcICo4kh8bPSSl7ujWdLFbGOUw0X7XnNZujPgeSqozFLcrz6ta18aGOLwMiXzns5C1pktmDo4c9y6enuOIMc81u4cVlxnmpTrcX1l23UinsAwfIjsduHm0RROcNal5gG7LQerFv+jXAV0R19Za3n1zjwrsSwqa/cozJRPZYfg4vCUkoQ7KSbii45Gkr5eAltXkH3QPSojNuB9NHEajP4CZq7P2bZNRFwpuDKtXqo0dPMYtDhdmjiwpu6Hb5yNbVv2OLJ+xSjOPSYLQ5kx9RFqF99t195ZPY93YyX4VWQAuT5+JVaFtP1XvKc4sfu0Ck+ePI6CMzCo/5uy40rPcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lp2YYOSAdZyP2Ed0cVr3XmjW1UCXA/Ikw+0NhZenzck=;
 b=EanZbllnxgDEqAsFWp0lXZmwMEcudNphHCEFxUH3YVSPT6PlzQNjNsFqUqAaR65LdBWWCVhVZ1ogtPBiYwku4bkZfLOBT62pmVIoHkrbfiMcS61Yl2qBwoPbd0wi4FgSCWLk6lRh2euQYxPvTMpE7aohPaI4zalRUcry8qtdVbQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB7020.eurprd04.prod.outlook.com (2603:10a6:10:126::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 03:26:58 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 03:26:58 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH V4 04/14] arm64: dts: imx8mp-evk: enable uart1/3 ports
Date:   Fri, 11 Nov 2022 11:28:01 +0800
Message-Id: <20221111032811.2456916-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221111032811.2456916-1-peng.fan@oss.nxp.com>
References: <20221111032811.2456916-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::7) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB8PR04MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e4e8edd-ef74-4349-6410-08dac39496c7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NuTQAzT+jOFBQWQSbyHL+l8PAZ4R/5hMjJ6C7N8BrbR35petd8B7D+FavO7/3uvadqNR93nDntTAonEMaqMz/1YDDHRIOebv4y3Am/fd2rTTWeZMCYpzhwK8zpO8FtLORI0VjpvFEQP0eGXL9pJLtPLLttw3Ewt3XM+1rehh7ahRsxH69RsIBke1ko5pgspnmCnUogy0WhkJxYkzGx9L5GxIjhnGQBHOV5LoLTLugjuzowlMkdxVHGoTJjPZ1Xbpqg3FjvEzZ5KT2tD7xbaOl/tawYuWsVPzcBYhBtrM/57ADJcvEXqkexgf6Sy+mQLJGviIpnIP7+BUk4Lqq/mLBqJRHT7AcocKsCXNcR27+tHfNKH1xIpdKXVUr4PklLopXF5EhtiAoqgO8K2sIwES8t/b0611/qxvm6ENoxRyYbeS1PMnJyJ9QPIYou6kLyGv/D1BGQxnGa1yPZ+jja3c7MTUiaiF5fOCK7KJpH0AzQCWCiipHzDhVEmlfvF9y46ex7xdWLaFT6+jSg5vFnWWNiVN8ff+xZhdFbxK79W3TqLP+p4S9oDJdW73w7LM1MDzvDdbX0/A3GCVRkSRp06fBXIUuBJf1kYujmYhCxghYfZ6/rzMKF0r0kldgH+DhKe12ardXOvTCzj2Qwk50pEmJXiwc2Gp8HowH6vd+mTfcw2ygIZGRxcDtqjSPDJfgu+M/xL44Jo+Nces9mI1MA/CIUEo7ReJcF0pG6GNKq7bdQUO4kRWjCHsC/Bw3BXhiRlTLo7w6BnFUAver/6slzU+aIB68oASOQLkFgIeM3dLMmHCWoA9Y5NpSHHVoaMwzKGa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199015)(6486002)(83380400001)(6666004)(8936002)(478600001)(41300700001)(5660300002)(1076003)(186003)(316002)(6506007)(4326008)(38100700002)(38350700002)(6512007)(26005)(86362001)(2616005)(8676002)(2906002)(66556008)(66946007)(66476007)(54906003)(52116002)(32563001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uDDrDZcENDeINKmPnwTIXOdLHacm3LnksLJTtdAtXPmMcK6Kmu5cudpz6Eh2?=
 =?us-ascii?Q?KJ3lE0RQq3fEbfknij167LT+MivM9jexKfs+1c/1YPdcEAW6diwAGQ9iYWne?=
 =?us-ascii?Q?M3cir5+WyDQvJA/Uy7VOHwUF6yoB693bJWB/8ZeJtaPbVOZn8LbeqvRCdI8F?=
 =?us-ascii?Q?+8VLi/NK5U7J39zAOzhypaHDDtUzZW4JgShqDiuDAkchFbx6upcF66Tryo16?=
 =?us-ascii?Q?V6+tXu1Z+ur8XYAISCnLpFGHben3U0rBREZAWDMGMpYPO1ehdVTxowjNgGHI?=
 =?us-ascii?Q?iCCm97boggaCNM+4n0vj9CuzXhb7Eecgk57LetY9sXRTWbunYR8WXFRNSdaL?=
 =?us-ascii?Q?tZTKkDRyIWhQPooU8NcLjJ9MmFRMsCMy5q9q3FlWpcm8izoW0eOH/pf03LLS?=
 =?us-ascii?Q?TpjTuuCazEBs/Ha0plHQVSjhn9iAmwg5iDyL707kE8q4za1rpyWpvj9Z7O/A?=
 =?us-ascii?Q?w8kt9BPeg2v7qA8hr+FlK9NXkVIlzLwc3Ayz1eOMmBI7G0V4srwvIfVtmdfO?=
 =?us-ascii?Q?rf4BSmMAQMpP4FTfXw0bzu1B++pGKaatHQbxWMwgjL7eQ6hHepHHuAPiD3+M?=
 =?us-ascii?Q?2XAm2GCF5lHnXEcM/DLA+6pwSFRdlaATkpyTx8IUBsFHHGj2SJfLB+8N2uTV?=
 =?us-ascii?Q?GnzvlpEv+0FIawRihSR6+Hj+Q5d5gR1ihEtS/SL/slqIL1oIPEr+tgKGXEjs?=
 =?us-ascii?Q?lmookhLQoBE9gY4FoAXP/mlQXdZyycRSnUShehZjaIJMkd+31IbC7m+2n1yZ?=
 =?us-ascii?Q?h0vDeQNWusEOkAYBcZ5zCTcu4kJL0LEX6KcOLLxsUtnurrjEFvcdQhuYBCcF?=
 =?us-ascii?Q?5YZPn2ZRZtDnIW3SLVzL8R/ToBMJ3tbKB7vi8vjyHNiOZ/YsfiPpIw4iBp7b?=
 =?us-ascii?Q?Q896p3ZfJm9Xpga8l1gXq526FhH62GLqtta7EtJRtzQynlO65wm0s13736Qi?=
 =?us-ascii?Q?bNOjF6d/f2hAoYgBAXOxvWkh9GmNkYeTUOw2FO1rxz/mQ4MWyEe2X+sWZdVM?=
 =?us-ascii?Q?hqn7miGnydrRNByUCiBSCiE+kT+UfNbEdL6GQtMMKS2O/h9YY2lIqX0mRmDI?=
 =?us-ascii?Q?mwaxPhU9qlzE3okbq595YA7T0tbR7b05qxnnpoKrJs7NQVx7zRUCtvv+jICn?=
 =?us-ascii?Q?RYUvToGK3r6kfWPtyvg9IAeYZyDPOXR3Q5zwoyZC85qoVb7X98afR6r6Cyfj?=
 =?us-ascii?Q?jp6OARefcnazFkBsMd6cSWTeb8ji0qjN68UL1DVJT1qg9OkXesC7SVuomrxu?=
 =?us-ascii?Q?UVcyH3k1fhD/98XXRHh5jBbLoxSxAR83iI40kM4k8/GmzNVSrvXhfQ9cgzbi?=
 =?us-ascii?Q?a30pOHhsa8CGRIehFr1Jj+L76mj6FEDUv6EmsSODaBwRkph/bjcBxGbFkebO?=
 =?us-ascii?Q?4fTNTccR+7+AbWcDU71wSlrD48ENJV5rCJn9mjwtVvHEt8myvBHyXlvR9llh?=
 =?us-ascii?Q?cKzFNLYHerCnoSJ99VoowsQOIOZjz4wujZllXDZqBpNXEbEarVNiLNLyq8oa?=
 =?us-ascii?Q?8jxFpwB3jxwZ/2xFc70PPUY6gEkCSGxqv7dluVp/FXI+zTA48ffbp/y5fNff?=
 =?us-ascii?Q?Hx7T76Ksm0Iz5v3DfTg6qijo3fLb6IgOP8aO5MuU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4e8edd-ef74-4349-6410-08dac39496c7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 03:26:58.1240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iRVx/kxq5tcM7+IUHCcIMCvDb/oVQxhq5ojo/cHc/aLzhdU9fETYqGSOUA147pSvu1z24VU8i6XtjcTM6zCFTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7020
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Enable uart1/3 ports for evk board.
Configure the clock to source from IMX8MP_SYS_PLL1_80M, because the uart
could only support max 1.5M buadrate if using OSC_24M as clock source.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 36 ++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index e323e6f4b7e5..29472502d547 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -412,6 +412,15 @@ &snvs_pwrkey {
 	status = "okay";
 };
 
+&uart1 { /* BT */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	assigned-clocks = <&clk IMX8MP_CLK_UART1>;
+	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_80M>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
 &uart2 {
 	/* console */
 	pinctrl-names = "default";
@@ -434,6 +443,15 @@ &usb_dwc3_1 {
 	status = "okay";
 };
 
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	assigned-clocks = <&clk IMX8MP_CLK_UART3>;
+	assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_80M>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
 &usdhc2 {
 	assigned-clocks = <&clk IMX8MP_CLK_USDHC2>;
 	assigned-clock-rates = <400000000>;
@@ -609,6 +627,15 @@ MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x40
 		>;
 	};
 
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_UART1_RXD__UART1_DCE_RX	0x140
+			MX8MP_IOMUXC_UART1_TXD__UART1_DCE_TX	0x140
+			MX8MP_IOMUXC_UART3_RXD__UART1_DCE_CTS	0x140
+			MX8MP_IOMUXC_UART3_TXD__UART1_DCE_RTS	0x140
+		>;
+	};
+
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX	0x140
@@ -622,6 +649,15 @@ MX8MP_IOMUXC_GPIO1_IO14__USB2_OTG_PWR	0x10
 		>;
 	};
 
+	pinctrl_uart3: uart3grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_ECSPI1_SCLK__UART3_DCE_RX		0x140
+			MX8MP_IOMUXC_ECSPI1_MOSI__UART3_DCE_TX		0x140
+			MX8MP_IOMUXC_ECSPI1_SS0__UART3_DCE_RTS		0x140
+			MX8MP_IOMUXC_ECSPI1_MISO__UART3_DCE_CTS		0x140
+		>;
+	};
+
 	pinctrl_usdhc2: usdhc2grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_SD2_CLK__USDHC2_CLK	0x190
-- 
2.37.1

