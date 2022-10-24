Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943CB609887
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 05:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiJXDNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 23:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiJXDM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 23:12:59 -0400
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2052.outbound.protection.outlook.com [40.107.103.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2A4760D9;
        Sun, 23 Oct 2022 20:12:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTBnkcC+4ZzT988A0DG1uyw8AjOdCwuybSK8bi2kcbNkFdtXqXwfI8ZU5tSusjZ//XISbQg41Hj/wYa9aoMFxFWm10MrEJMS+lWV3xDSJ9WdBXtpTPWS5cjBOF4GTp88VH0ZB2i0eQ+/c20fOnSS+UFeV4WDm9lpok28Zl6khH2BRJvy+U/I21UpLldYblKCALXbKWn2bsopieFISBVl93uDSS1YC6TqVjZjdZXNjdEshr5oxy6U8TnTVKJaPAc2jwYRomMnNedKpumtllpGz0see8vYjUFGLKl5VKR3843P2LigdBv1VBaQqgk6CK+rUupneOf4ZzIafkaVwOfDeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNG76ks6bwTy/rElR8vefZEugvw8xsurvW5PxDkJ7/M=;
 b=HQuLRUDnlOFhuckUvesKLfc8ABDy4tsQegxOp79r3QeDFwrM06kKXytOKJFnR+PWK+yc5xipGsb4ODd7thSj5FKgWuLozQT/dkSDkEkZwkK1nbt5pGhg6kivNZArZ2ZumbtN54CWkU2QoCJ489ZFrQoNweOrbv8I1KEhGMoOmlD8tJjuSQtCdDZQk4dnpliiQeuJ/kBnIIqn43Iud/5TDdSMa1jEO5VkGwVpRw8+jn2FUbSDxolLSv4rllIJAWfpVdC+QB6494T7Di7i6RTIKsfitvAVFyJcrvK36HoCzEoB+6nsMH3HKuDwpME+xU/liN5M9JaHuCMY0C9e1iU3yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNG76ks6bwTy/rElR8vefZEugvw8xsurvW5PxDkJ7/M=;
 b=O1+ggNGZTglK2F5Am5gNDo5jLCk14iCSSFeyFaqxniJE0OUqi3KFwue9NZLxp2/SOmM68VJ3uRBymzbyp4XqH0N9GPdSmPtZG9PytJh1cN/aNjSfuVu+KU88jSn7zSr8QDT36tcg703KobjdksPbWfkrhVlotQxs/JMubEAm1aM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by AM9PR04MB8340.eurprd04.prod.outlook.com (2603:10a6:20b:3e0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Mon, 24 Oct
 2022 03:12:39 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9344:660:a20d:8a85]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9344:660:a20d:8a85%7]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 03:12:39 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 05/15] arm64: dts: imx8mp-evk: enable uart1/3 ports
Date:   Mon, 24 Oct 2022 11:13:41 +0800
Message-Id: <20221024031351.4135651-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221024031351.4135651-1-peng.fan@oss.nxp.com>
References: <20221024031351.4135651-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:3:18::30) To PA4PR04MB9416.eurprd04.prod.outlook.com
 (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9416:EE_|AM9PR04MB8340:EE_
X-MS-Office365-Filtering-Correlation-Id: 0062bd97-de73-4d43-cf20-08dab56d9bc3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ijef91u3udHwAILix8ryaHo0/erlRT6Z5O10TN0ATiGKOGIEDgB/oendH7q+hMvldjZyPzCZM5W9Aj50Ok02U2ZtcfebWDjN2Ho5zV3UQSzB/Vh55zOEiBlkEf0aeWu5DJcTbfl3zKvM5YORLVW3nIF3tIjEIoFBhcnd8It+yhFGJfK3grZfXt1XUTQjSQa7Cqi8x7bp8vUO8TYp3pVw3ObaYnK8Yl2/uJfIr/l0N9NQx6SBXxNtWqSrc88vsFRngwKRN7rvDjo2dcZVqKRGOoHfjothyNhsQibMiKwAw3V/iP5pcU0E5H3btuSyB2IDlstMYAO+YnAKixcOgnWUHCQ5ozp8XJ82BNI0n8t0kufwPeS89nBBTBfHJFU2TcoZTsPlp2RqLoB6X5ppMcnV6RHiFsMEjFlexAQAzfJGlpc2xUcL1sEtkG4PW20gycmyJxaN66C11BYyAtCU1qBonB80XPblC7TbdW3YOuhfIJtKLhj1QkGnB/fIl2tjH0KZ9kt+3a9QLOasF5fR9UcA6LZfG+U9dXaFYEGquEv0FfrdBgns3zxzMH9Rnuc8twBII5UdK60+dVuYMxptu9F5lbKFz6f0isHNy6ZtQngp/Wuhzbb0Ulxjyzd3oRy2yjwEVOYvNhS2YzYGkqGV0OdNgwJrDQLdmYQ4b20ZIZ0tmJifoss9nDwsyOQo6gAxbnePPMfytykG4wuysy/685kxi1UpcvP980lVo7mnPJ0auF4zZZQ6XM3VT67ekZSit2cS3WldfBHyAxFjXftAspTIQR8VhDlNCxIY7lxMijWJmFxcTj/Latm2NOLVKv0qIrXE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199015)(2906002)(41300700001)(52116002)(83380400001)(86362001)(66476007)(66556008)(66946007)(316002)(4326008)(8676002)(8936002)(5660300002)(1076003)(186003)(2616005)(6512007)(26005)(6486002)(478600001)(6506007)(38100700002)(38350700002)(6666004)(32563001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XO9fmtxq05oBt4W3f8EuGKSklzDUu/5s1JnyFN+zZfwOEDLgPmWRk8RG/U5D?=
 =?us-ascii?Q?xfGqvSJuOilZlYZUj2aY76XRhrgQ2O+M/nk9AQQqLP+Lq6PgUuLkkTRg5nK/?=
 =?us-ascii?Q?DuZ5P60U34lA8N/AgdCnLkVo4CUaKV9pWn/zcsSP0/BoyQvSG2TEVfc3twDH?=
 =?us-ascii?Q?85UkCVjRCvG7y0O/+D/xQmu6QfKze5fST21bM/Y4rNKcBQwTZl60z5ACdyHw?=
 =?us-ascii?Q?6P5nQF8RIAhlKtbpyRI8H4OWh7+hpBeOqMj4fnGhN4RcW6VahXsX4Tg7L2WE?=
 =?us-ascii?Q?JNSjg6EvyqvpoUfQBNZue2ZlL0ogRP5JrSfMwma2T2KMUw6gk0G0af4fJH4K?=
 =?us-ascii?Q?NdXnsIO4NXHhkZBh9XqrUe/cdra/G5uXQcy5TBxUH60iLRVsuJi5caOKWJQJ?=
 =?us-ascii?Q?VkIlGGqWXRWDAGWWq5sp6JCL46JrGyz7/78F/RY24P+7RQ/sHyEgA1S0wRCu?=
 =?us-ascii?Q?pxPXpmYQD2sSHZ2iL4hfTahoOkfnlXcDmuRH8/zX+MANfXASKFetJfMCKxJl?=
 =?us-ascii?Q?QBFLTebCHIsPE5vcNLDIBEv2u2rZtDaX7CyT43lSfoCadW9ZAQtwvaK8YNKN?=
 =?us-ascii?Q?ObeighfQzbxotXixuV8a0bhArdvrcnRRD+5dMQOTCYgbP9xE4bUfY9RmX+fG?=
 =?us-ascii?Q?u6A8nFoYfF+PpTwCf4TqYst69aDapjrwC5JTqb6TYtb9l+B/UspRnm6JugBF?=
 =?us-ascii?Q?HFDwudjjQLWJGQQIdstXewWWWJggs06+wZCt6ZNsJcbnh5jsQeyno/0i/VVI?=
 =?us-ascii?Q?/4OGh7wYMYBOLInAqecG/JJQNvzd3USWnTuqTp69HMg9xL0M8ILu4utGnQbu?=
 =?us-ascii?Q?mY5c6rJpcn5FfERXM09agjX0hkLSUJXQ78XHJTOhIT8+h2GrbMRmGi7/QwSb?=
 =?us-ascii?Q?aOiSAwumtOBfMxwlyot+HLFwXSJWTNCWw8HFeOqbvbtDwDTvnhChkokNaTBv?=
 =?us-ascii?Q?w8hH6D1hv7mx/4fG6nk1gvc+EUkAchtzu3DjDnta+102Gz1luYVrw5JUiJBG?=
 =?us-ascii?Q?yNnNZtESrmcM5D0rcjZXbmC9GdqWRofFDnt57WbFaqsmMOHhLW1aDqOt0DdO?=
 =?us-ascii?Q?7rCJJVWbdmHJuR5rUh0/Z8MfoiYcstBKFQ8SpSKcRSlpzEwMu6bLgrrwFn1Q?=
 =?us-ascii?Q?DRKCrXIi7+cTM0Ztz7mXfu6vhZUMHNikxKKpRmdLmpA190ojPhbZq6gnpCvS?=
 =?us-ascii?Q?kK5DzfrYRIpUzLEp5tjHJmw9Yf9/Qh5JHgXzZI+o7KJd808vxEKLHM2GLLzV?=
 =?us-ascii?Q?zlvzTWySF1JVYXm3+myArsbI2Mn8qQVuB5dguUBZoRLHO3tOOZXVbJ7sArxs?=
 =?us-ascii?Q?LH5hjxsC3WETlakAOkmLsvMdoF7FlSpPZ0FAawv3xX7EDZ2YVDxja44QHeY6?=
 =?us-ascii?Q?4PKd7WnLFZylFn7UsoKmvOR8HKtZkL0ohGHbXWLJvHXefTnTCVkw1WrtIvLA?=
 =?us-ascii?Q?oJCckdHtLN+RPSRt9YCHOG/C+IcFCqdJszMUzxSQ9dYtHvIsibR4ZvIfIapj?=
 =?us-ascii?Q?vrL86849dnUilHXvG31zH0fd+KYJYirGpyV6uMN3lvUPySk3WZE2E2q+VHUH?=
 =?us-ascii?Q?RxcOZO3UVlYxL842Unr/jsIpcGXsgRVg/yuu6Jf0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0062bd97-de73-4d43-cf20-08dab56d9bc3
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 03:12:39.8209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kkW/wC8/QSMG7nIYNTgdZcDULgsfWpeX9td5HGlvUVBRCIAdrqbi+GEOzUGeQTG/LZalFykwGGJUfyAySpGXJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8340
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
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 36 ++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 316390f917a4..b8a7de87ce4c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -428,6 +428,15 @@ &snvs_pwrkey {
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
@@ -450,6 +459,15 @@ &usb_dwc3_1 {
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
@@ -625,6 +643,15 @@ MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x40
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
@@ -638,6 +665,15 @@ MX8MP_IOMUXC_GPIO1_IO14__USB2_OTG_PWR	0x10
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

