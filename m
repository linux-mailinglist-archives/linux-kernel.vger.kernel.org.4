Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFCF62D77A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239432AbiKQJxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239378AbiKQJxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:53:11 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B607697D8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:52:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QliB5sbzYUFk8vFbFl6WygjDwzSsDMkBOdXVSJPafkS+De1E2OZOf1ocuRlrXw/04MSM9c7IRPs3ZJtKYbjESqlIxOkHhG+EtT8ifk3RL0Huja2xs5V3ngHB7x6jeusgdDBVeBh3VBHqaa10IKFRvS1EaIFVrXCjtveASdIZPaErRn44oOLM3L5cbteGrtq6l1lNpDuIb2cJmeR4lERYTR0Ml6sRuitrWUJoIr2KblTyb6I0VhuCCfhMVXv3iTNr8jPEjzCG3TLmzvsEvY0ho0EOVcp+3GIp+dUPWaG0iOWcnobahj9qeff2UcP4nRkbe6ydhgrF0a2iI9CI/3oGHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lp2YYOSAdZyP2Ed0cVr3XmjW1UCXA/Ikw+0NhZenzck=;
 b=TpSOov4xj4N47vm5JM1yhxgnBkGEX/0NVe8dQT9YmxC9FE48qp049YsbSoWrKlK7XBNtMRCvgpW3jcL5w7WswOBtAl3bTaSRKvmVzuDZ/Y/8h+phfNfl1lsRhGW+yxJgIjBU3PDcl7yiQblW11pQIpj7xKxxQXtJWIu3FwSUf09Kk6zEStySnUA6+XG5XakhVZ0YEoBlxTmRZuc/m1gxa4Ae9sZPjlxgIuBNC5BpeWOP/Fsi2bBixdNI5tZHgAe1ktlaCn35XA0H3l/F416+sQTU88b6NGKaqB5Ir7Sypx+VuNvLB4GLiHiYS8tMPLXwN2hf7kMCUhIjWL6fC1bB9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lp2YYOSAdZyP2Ed0cVr3XmjW1UCXA/Ikw+0NhZenzck=;
 b=VxBVTPQpy850qysCJ4POX0HCmMJqGmlMLhNT0z71wxUY0BE3Nrgsmxkzz6/UZCfX013LgTO+IoexvBZVE1EQTN6paFRqi+nd/pgjFb/oQBGPrGQRlkDY60ZSBr+nlH+OKwXEs/TvEKWfl+aJ0EQfy8Mek41YXe6smfgiN0KNCUQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7702.eurprd04.prod.outlook.com (2603:10a6:20b:23f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.15; Thu, 17 Nov
 2022 09:52:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Thu, 17 Nov 2022
 09:52:51 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH V6 04/12] arm64: dts: imx8mp-evk: enable uart1/3 ports
Date:   Thu, 17 Nov 2022 17:53:55 +0800
Message-Id: <20221117095403.1876071-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221117095403.1876071-1-peng.fan@oss.nxp.com>
References: <20221117095403.1876071-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ddfccee-36bc-4554-972e-08dac8817d70
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dXqkIK05rksDJdzGkn3LJpkqbHlhi4Rf7GPivp2uKbANEaMYGgAqV96q2C/TqEGAEqgKmIDgQrzmS0EHgALuhl7p/OTkFvWq2bX2QhPhKrUkeGlYX3xFs9sMp7AwV2PxiAbpBaje6DLGA3IjyepTx4Tf2lU+0bBApwJp21lZrbPBe2IAYBzQ2GgbayZNZZBFbxYFAPVd+jwUeq3rNcY4MgCzysaLBuaHoMNPe3qVqnRzmtL0UTpohrYqUY3RgSUpFpWMqd4Wn7cnDfHMnn3+klq1nGtxONPDezRUUig9ao2DeuPs+5cLA51LCfCcmyi80fskQOK5k15sPhQ0GguLsDhE10JiIWr8pBvEzs0SD2Ha1BXIA20mNq6J8exh5eTCgMpssToSonLHu6xy6t22U+PqR+UANw1lBhQ/LxEyqn/d6xmvCUpB7g7GO6rwgD4I9T5opczrB+J+deNLzd0G1KGIArMqIMz+BZRZwlBahpk1LE4fjl6JZ+SYsQtDgEsXXelxdJ9UzEwBhkosVEZvf6zkvjmeIan3KmNeQGEoQ+sT1qXvPSTY97KplCZ4WRJGv7iH42+jOMOIcMetJ+Edd81RU7zkERNiHrTgqUW5yKiJe2Uk09G/rtsN3lrqxJ9UUZ8TogSPn9bt1O2PKWjx3YeX24WyLMgiwzYvnpr1uEdWOq3o6+9Jz9jsUOxdWqQ3OMwLCJHUc/erSHbaV3rmDfk5BVHYDsB+B/b73NpkEIhbsMMsByXTdVMbqGwXqd8j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199015)(83380400001)(86362001)(38350700002)(38100700002)(8936002)(2906002)(4326008)(66946007)(66556008)(66476007)(8676002)(41300700001)(5660300002)(52116002)(6512007)(6506007)(26005)(2616005)(186003)(1076003)(316002)(54906003)(478600001)(6486002)(32563001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?08/tb7XNy97P3lD/nfGmis9qrJHeG+e5uQ4okJw3bsWT7MZZRxRlGsUfgUZZ?=
 =?us-ascii?Q?pVO0p4fGMP19pO5c78Dcew9qRNJsrG904V8bbUw6KqrZd7T7+7P1KES6zhm4?=
 =?us-ascii?Q?WEfgaILHBpx+Sgwjbia9uZHaWE76z7ryAB32uDlm3nqSyXhC71oxNGkL2R/e?=
 =?us-ascii?Q?r9zzyXargP0WoFziKpMQ9kA2EMWzY2QPl75lQ0V06HwVSZWAeesFuLcGJqTX?=
 =?us-ascii?Q?agQlXEm+UZZZu3W2eaabaWmOnIwpRtVc92WEzXvU5uYlONRnh9S1Xh2Fl61f?=
 =?us-ascii?Q?sXPKAhFvydpeez6Yvf8d/V5wuOH77neriHcsnEI+w5xQ13mq3HQDub7KxPno?=
 =?us-ascii?Q?LWCydRmXR5Zq7HKFhukg780VfPVMdcXh32qr0pspWxNJPDbkQmHxGR7R9wiW?=
 =?us-ascii?Q?alHtWsN/MFF1ZZroRUxDAyqdFXOBvSgLHF8nVKnu1r/drqwkQ83zN4XUQz42?=
 =?us-ascii?Q?yVkw/Zn+HU4AJGiAE/gGqL3o07o98CK8NR/uobsyUbSIxXaGFN/8sQi4uAZP?=
 =?us-ascii?Q?KGLxLkX9w5MhbVgF5WknIVm0IsyVc3MxjIcKAse+OOq7LDJ8OkqGueJav86p?=
 =?us-ascii?Q?S7hr7NJK6UDuga1m9sLtJt2wMEqCrymHeiRIpr0KMOpTgJiks8oa+GmE6FeF?=
 =?us-ascii?Q?PACgHjiVtrPyZXvPRpVjeF/AwB5AJbpSf1DSWtp6KWCAsnFlnmMwUwJVxcQV?=
 =?us-ascii?Q?QTTU11EyopKQrzlUECbMrcmJWhLLZVM7HnbRZX3tJTos6dUyFx+dEfYzdK7E?=
 =?us-ascii?Q?4CjgRMrV6ryzMRWZN0NiBGPz5co5mlZAoNgOhgqPf0C8Ic/LKl3mNGQMDDYU?=
 =?us-ascii?Q?hrz0tYElGfcifhSM+CvcUAS5aHUCQ1QZY9Lp0/zVmlm6rmIMaRZ2RTmXeuzU?=
 =?us-ascii?Q?EbO6lOM+nI0NbaS6ToZXekUdpbnCBffzKVAjEVv4YLj/9Ykav5XugPtoKKf5?=
 =?us-ascii?Q?iNAa7Va/8VbQhwvhz+bCbMb8U8+/rdbuIatQ/TMpAZrWyG8mvvTpML2W+2VO?=
 =?us-ascii?Q?fI8C33EJG6wLaiTfF00maNicySmp8zGGZejG2c9dCfZgCqU3YJkIX2F/R46O?=
 =?us-ascii?Q?W6qCcSFPAboBHVrkDHWMeBzY19S6ZZUIX8RAZEmDzfffYSsMrBpU9d+es87I?=
 =?us-ascii?Q?XXq5ledl9CSA35buUkREQtkNlkZGBF0/Tpnnj1ZcXQRBJl3nZLRO7/Wcrbhp?=
 =?us-ascii?Q?/WHkqZnC3fTvVcZuktkP7ntevSPSNkPX78DvQI+we4GM5KwkAy/b53cFJ5r/?=
 =?us-ascii?Q?srlcckt4C5gHrVWhGtEXSycdWD8IZ2yO5wlccsos7vpO03JtgPZl9RwVnINC?=
 =?us-ascii?Q?Nj8FbZ9PaupMHHCUWvbVpLTj7MwzH+9QvUfvmqT5tnJIaY5RfSHvQByCLqfb?=
 =?us-ascii?Q?syXZMPx2SVl8McVsjpTdrmdr5YxyAekc5LCRypcSdKkeMocfASlAF2HRgELT?=
 =?us-ascii?Q?ceP8m/0c2hLdLRTW4OBoA+buruvt16TTUXa3NsYMkE7yBVcsRWWknpqi1GAV?=
 =?us-ascii?Q?58A5a48ZiZtRMvkBFsJGqRKUADiSiOLYvV36j1qcfbFN9ZHeR4LgbgxQG8I8?=
 =?us-ascii?Q?ybDOM8i0MC/5xSOH1vkJslWv2OsHJV7Ve3cK09pl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ddfccee-36bc-4554-972e-08dac8817d70
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 09:52:50.9088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XSDtGKTUh81aKEjJU5h2xOFTNijWzwyMiJ8lM3bUxY00Hxwkbf9WSu7sa26SXYQ5nFDYgMZT4nYQFHLHX/dPkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7702
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

