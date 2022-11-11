Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D29B6251AF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 04:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbiKKD3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 22:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbiKKD2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 22:28:15 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E015E3E7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 19:27:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdHTbdnq8AjnII3eHq2V1w02XXeyAXZz4Z98f0B56NLj6WlnEt9dwhsoDiesl6hQjG7w2IrQkFGLcmiFU/kV9PWmFiGsHp1xDc9Ka0vUqj6gwlRSboUKLvqkSE25KESninZgV6pyS2fT0UrlVqL7fPro0x/dlQWsvD9+NpECV/DUB4bPHgLlCgG+F+TE6EpzH7E4nkw6vX6BnlZ6Gkx2GNTmNvZ4IrYY4AKLV5guCht/egsfYxacLjKtWXIVMCthDC8vxaGdyJ+Kn66ZYQ5L40dqVD0vbqFUTaMvMPTvSwwU4j+aaRfD4z3UqbLfC7AGecRwjgr839GCBOXrj2qWag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVAUHetCMZ+sku9azKuQuKBLE05gtFtDIRn7I/rkx80=;
 b=Sjb3D8lOHUBoUKr8K3KLzOYIHtLC4Ny9PRCXTZV7qAlD6f5drxjCwpng/gCVIRN3uexDJspuJnzj4eFv4y1IdkvM8h8IIh4aBupCB6TRT7vji3nD6yGWqxZNkXH0gUQ7/RXy1IwNfcx/02EoXu5FJcmgMK/lHHL5ybwKzEUza1iSJlVNnileCmQUTQGsLUwxF2a9RO80BxeLZtLCxyXKHTfdquGXY+ppOazzWQQCD3lrG0j8DYwiWJe5q34s0AAlceogpBQo+6OvGzvXIT2FwKVRfCdBOjNw2ZDX0pSHFdGkHpNOiPwUMpu6HIOabB9nJDHs2YZjOZYHoBuAoadQlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVAUHetCMZ+sku9azKuQuKBLE05gtFtDIRn7I/rkx80=;
 b=EJREzq9+sKJPPL9TyYrWR2EDwoMEb5+lUbBtEIvbAX+/L7r38Y08keOrluYLnsJCMKZSVvqHUxRjOo5yh+zCerV9Ucvvf8RiR6/xvHNJ1Sqi5OVmXsRQol7iR+d0ZK3zrtN84CARsFx2SKARjofyVx+JsrLp+5fWM7BtDu3iywg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB7020.eurprd04.prod.outlook.com (2603:10a6:10:126::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 03:27:19 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 03:27:19 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 11/14] arm64: dts: imx8mn-evk: enable usdhc1
Date:   Fri, 11 Nov 2022 11:28:08 +0800
Message-Id: <20221111032811.2456916-12-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c19dc7d2-11b4-4b02-a6b5-08dac394a39c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ub1GbyQS74LNzsKCeo0akfCht6/f8HJT8NNDz/LxIFS80+GgbGI2FOO9Jvj9KZvoYbEyalUCWvL3u3h/NU/7vcHaizHm4fRGgHLaZbt4aEFRtIxJjsFiEpXSG55fqLRmPFrs1+hbFX3PFIuWRt1r270nww2dSHImiYuaQO/BgRAF7NM4hMLgblHPU5Ux75vjJ7DFu8C4K6gVKW3zBLjQDho8smVqrmu6mxY/GVy9+z9lz6oY0pdWo01F9/0a3BXxZBlnqC0KlB/BQcNDglHO+ZcgFKyn1hcYVuWxXvKebYkDqCyDl64I+M9rYSjaqrCX4DauC1xxIlbLU1aa/U2HRKHQztTLFp36qUJIPpEQgevPiwQ9Sn6oz0sP/bYa5G6N21d6xUHl21FrPdwOAX9qAT9xPOIn8KYW3RUhGx7VWpSy5MdBwa/sp2Y7/g1hqG0xuhwjrFL11OLRDAStpUlTAcX6YVSt23nVTx9oHKNNXmEV2TRAkp6TJcUKxlEOB92ByPcHagWCYayyj82FX9+PBfqbogkd1o0N81uV32nvzP6wy6NSxaSTtFFYlpNBbj45+xzmuLkP1olaKGGtq4ClJUp8aDFLS7BtlXxdhWFB3oHnHIzDgRBvoUHej8ULcHwm7LqbRa+nkxUEWAcFzfELiu6RVmJI1W0AlUKN/96kPPuoIdXFkBwjMbky+0ImYyXUOR2QUbIzn6Nktss0uSxCDiPXf2qES9Xi2j7zXwlPJtUBOyBzt5YlmmWsEkDg3m/dfB7JiNDVLDSxFDTRZ/P0iR78FZqNz61wxS4yArXwBxqbqzhGoVpaJ7CGk4XhyhLt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199015)(6486002)(83380400001)(6666004)(8936002)(478600001)(41300700001)(5660300002)(1076003)(186003)(316002)(6506007)(4326008)(38100700002)(38350700002)(6512007)(26005)(86362001)(2616005)(8676002)(2906002)(66556008)(66946007)(66476007)(52116002)(32563001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P6p09g5fPjFAv6fXXyuJ3LOGHvyMykcH9g6X1MxoQCoZH1pRe6qjWbcWrB86?=
 =?us-ascii?Q?ebK2XGXeoCELSBuPYA5y2twRySxYP7Ht/BVGpQI7JOf5alb1PAFr/uaA5tWK?=
 =?us-ascii?Q?t3GaA14lRK15TIS6FDRHY1jhC7fMmyxpF+c2l/RNy5j/qABx2l4gmtUycsXs?=
 =?us-ascii?Q?YPSRYTK+TOIXPe6OnP/KtPzA+H4SaIBG+nbthkU8eKlM85+w1f00+eBBOEts?=
 =?us-ascii?Q?bCScEuEOxzlg0hX9K1Hs9SgG3Zh/Mw21u20aSJGfI7QUxF04PHRe5pI/KGZV?=
 =?us-ascii?Q?tdOAxc1kp/FQHhqX4a21rRj2OHLV3sjhLKMaX1RNGf1Izv9pZqNvk4cWgc3G?=
 =?us-ascii?Q?N6CxucTU/gS9pKhmWUgvimJ1tGyNQXTJTY+WdQU7BqYhnWxwg7iIa1OcMbRA?=
 =?us-ascii?Q?FbqYjKPGJbupS8I+2m2gYLqB5yTioCQDnBz6IcRAqSAGUcGr+34IY3eTyYC7?=
 =?us-ascii?Q?mwFNQ4z0qs3hsr/Y9HUbdrInA9Kv7m+0sB5NdNLYiIyn20n+hWB87xSZ5jVe?=
 =?us-ascii?Q?/gBx4DOXOQGCVkh21q7xcm6koGO3q9e3t70vjqLNktNic5K7s1tL1j+PjBag?=
 =?us-ascii?Q?jolOh5xhzWyCtvaqgbO7eC3QYzJUdQ5f+0YIG3lf/E+s8Mn/VshLhDUESCdG?=
 =?us-ascii?Q?XCuEjnr2chWBF3X3ZsVx7nvimhnd/YlxeW6AvNS7GYWOdp0mgFNXzY64tdNW?=
 =?us-ascii?Q?oWCmhL8gYSfW2wWdtDrLpQ3UtHMgV9SZYgSlVrEh/1zJ5k/++JK3BxuXJuf7?=
 =?us-ascii?Q?CdL3gafJ75oVP+0FHKQNe54usgbWPEaBo5k2sZ+GR+9+HUqJy3Uq9R8CruvN?=
 =?us-ascii?Q?5zYbnCdJuWrevFprsTR3SJbG3WbZBUM5ZjZdqsDEhDhPjAm2P5rcwleZdbM5?=
 =?us-ascii?Q?UU+FsPz/Fb1ZKXzj92y/Gq0O5lYDbbLW+LgnmOiD+f+YRYdPnQwzYZv0CIAj?=
 =?us-ascii?Q?dBB8OrAccz1Ngg9aw2YwAYwNKNbVt4Z28QdBr6ds34+18V02Ef40uEBC/Avq?=
 =?us-ascii?Q?qEmny6t7JoafPVYyzsNHQALOt+FSeuzAJWPHw7bTSA4wIj27vHRqqOP21Gk1?=
 =?us-ascii?Q?jy4XIvPCjaUkPbNnJFlboMEmxDjyiY0w7biX68BZQvURMHXHEUT2+2FKpvE+?=
 =?us-ascii?Q?SVrFT03/vRZ4ghcY4cjd2joMCHLdVMgMuzb3xk3UQnaOc5A1maz+8V0fZfeC?=
 =?us-ascii?Q?OFU03s7Qw23W3N6mbaQjqIoT3NYTYLpoPqRysr0htAeGR11aixM9he7V5Dn1?=
 =?us-ascii?Q?Yndpen6BYb0LehFdNGzX+cLTlQsDafG9uSRLtV0X90+MqMOyfWVN/YGyy0Oh?=
 =?us-ascii?Q?UBGpJPR9/ZCyAD5joF/S02eVNvpEouWB8Fm4M+UNAmlKkf6wE/sbykeXMj7s?=
 =?us-ascii?Q?HwrblrpgrrYAT4VP5zGRFEtiCDw+7drMieJIQD9C2mGLc8AtIZXf44gu2ueU?=
 =?us-ascii?Q?vgBsTappVqE4CRA/1dcBbGTEPcpRRuARH3XPFnxhDuM3ot7UAyEAYZuCCTeX?=
 =?us-ascii?Q?O2x0TQQyl70VfCrPDcHZpncPuHMbRqOxk1k8XwgfcO17/wF+/VWRxNuIIiIP?=
 =?us-ascii?Q?k0x7sg/9BVF9fMGWFdeivSYBTI6Z2NFM7ob4SAjY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c19dc7d2-11b4-4b02-a6b5-08dac394a39c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 03:27:19.5905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ePUO0YRsa/Gq7l3pDuFpTKJ/uXxtSRBIpV/vG8l6AtPm1A2q5e16yhIpxg8gnbjda9d4Q2bdTaTgLCARlhU6Vw==
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

Enable usdhc1 for wlan usage, the wifi device node not included.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
index 12dc5d398a03..8d498718e0ca 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
@@ -28,6 +28,13 @@ memory@40000000 {
 		reg = <0x0 0x40000000 0 0x80000000>;
 	};
 
+	usdhc1_pwrseq: usdhc1_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usdhc1_gpio>;
+		reset-gpios = <&gpio2 10 GPIO_ACTIVE_LOW>;
+	};
+
 	reg_usdhc2_vmmc: regulator-usdhc2 {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -271,6 +278,20 @@ &uart3 {
 	status = "okay";
 };
 
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>, <&pinctrl_wlan>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>, <&pinctrl_wlan>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>, <&pinctrl_wlan>;
+	bus-width = <4>;
+	keep-power-in-suspend;
+	non-removable;
+	wakeup-source;
+	fsl,sdio-async-interrupt-enabled;
+	mmc-pwrseq = <&usdhc1_pwrseq>;
+	status = "okay";
+};
+
 &usbotg1 {
 	dr_mode = "otg";
 	hnp-disable;
@@ -474,6 +495,45 @@ MX8MN_IOMUXC_ECSPI1_MISO_UART3_DCE_CTS_B	0x140
 		>;
 	};
 
+	pinctrl_usdhc1_gpio: usdhc1grpgpio {
+		fsl,pins = <
+			MX8MN_IOMUXC_SD1_RESET_B_GPIO2_IO10	0x41
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX8MN_IOMUXC_SD1_CLK_USDHC1_CLK		0x190
+			MX8MN_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d0
+			MX8MN_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d0
+			MX8MN_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d0
+			MX8MN_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d0
+			MX8MN_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d0
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+		fsl,pins = <
+			MX8MN_IOMUXC_SD1_CLK_USDHC1_CLK		0x194
+			MX8MN_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d4
+			MX8MN_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d4
+			MX8MN_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d4
+			MX8MN_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d4
+			MX8MN_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d4
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+		fsl,pins = <
+			MX8MN_IOMUXC_SD1_CLK_USDHC1_CLK		0x196
+			MX8MN_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d6
+			MX8MN_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d6
+			MX8MN_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d6
+			MX8MN_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d6
+			MX8MN_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d6
+		>;
+	};
+
 	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
 		fsl,pins = <
 			MX8MN_IOMUXC_GPIO1_IO15_GPIO1_IO15	0x1c4
@@ -569,4 +629,11 @@ pinctrl_wdog: wdoggrp {
 			MX8MN_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B		0x166
 		>;
 	};
+
+	pinctrl_wlan: wlangrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_GPIO1_IO00_ANAMIX_REF_CLK_32K	0x141
+			MX8MN_IOMUXC_SD1_DATA7_GPIO2_IO9		0x159
+		>;
+	};
 };
-- 
2.37.1

