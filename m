Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB093629417
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237980AbiKOJQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbiKOJQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:16:13 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2047.outbound.protection.outlook.com [40.107.105.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1D3220EE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:16:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0/Cjs+umuk2IkMc3RJRlCdkNtLSpr2xy3yDbWoxMrtYvdDGwK4jDkyWzutqI7fJPIqlkP7notnHoSo7bFsNgxARR6L+BKMtdDtzK+Hz8fS2sf2JTKd5JtBT18HrICOMNKbNC1FZgIhtXqYlllEalDP93sNILer46OkcuqGy5AiZBQdABmIbOnP+aNDhJ2gyfwBtpb0nFvyLO3gX4VOSDURltZNViJUXWM6PSXptB8oIpAigULERs8v/8M80bYbpk3mJkt4CffpOugMMkxFkeVAdCfbTukOYSrCp44ZpLTsgs+Xcc6wA0yAPwfp0KLzMmij8hqDFp726j0crZElRgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lp2YYOSAdZyP2Ed0cVr3XmjW1UCXA/Ikw+0NhZenzck=;
 b=V2eay062Z65UPQIOHbDpv/kKyMAgpCNs+LU2k+tWcZawl+rHDQntKtOrBp2GL7pHbemHZkwW/+OJbnW/5KWZczeCxgK5qqjihbA8F2eUTCfgon/+K7Bi3wVXGXE8p+jr9h+pyKFjQHti75wWJZEmkdQRVAoyKrEmUumoN8XwyhcrVl5iUOgm7Gt2eKrLsP+TYXGxBDEN0RreAYWGk1U6obB4prgC8WBDm5ZkobQk9xtTDuieoTmjwQg81GlvwAoZk7C8GlUiFOc/KmaSEEcW7KXIbf7eV2ODYojswxeL6Kxs171Uy6vzDQqy+cGau94pgS15Njf0S7L+Sw7yKI8kNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lp2YYOSAdZyP2Ed0cVr3XmjW1UCXA/Ikw+0NhZenzck=;
 b=H2sLk4oRquawOiKK4aVPsU4mjXpKOacScQoU2sIYElVaWiDYs4xcNZu7V5BUy1XfXqIh7qtSgl0ZTj/TKe8gcp3FfNd4ewrNXu8dIduD3p6/X6rZd9NvH0rFoVR+TBUTWreUTfQoJuN6LOQgzXHq0sxID48e3i9llI/hRUhYHAE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8195.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Tue, 15 Nov
 2022 09:15:58 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Tue, 15 Nov 2022
 09:15:56 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH V5 04/12] arm64: dts: imx8mp-evk: enable uart1/3 ports
Date:   Tue, 15 Nov 2022 17:17:01 +0800
Message-Id: <20221115091709.2865997-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221115091709.2865997-1-peng.fan@oss.nxp.com>
References: <20221115091709.2865997-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: 46f79b43-4336-4cb9-3f3a-08dac6ea0093
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PouWZMNNI/k2AKhipVxzAQjPysuduX2diF0Qgdb3VukT90IJwewxN4GUAWf7U32T+nIdZ8uc/IW7t3ACpPzwGn5ppi3sjIaxe9pe9lrhba4m7vsSzT5+uIpzlEvXIZQQ7NzgAlHmvXcpn080odyfjiDVApFrTWNdPJz1QNLr0CYiQ37WXvi7m4CAnfMWGkuOymG+1W2YUV2NBBa3DqcGaSsonmMcJGmJiJKJQN5RYWgPmncJSNIvLY6YAg0OJfJwHhoArGwV7x0xTf3LzoqJTIOCQYg+dc2/P4YUGzTGjEUBKI9xXVIuXchG+rz8+mSwzRDjStHN4Y4dPR8U5XLS00/P1BGlDPs/uIpG2shKvbhWTBU5FEoH+KjHJ9Ho/rtDx3P829/LrxHSdN4U6bxzZVimbG+NBf3jOonN04NGuEt98AybfVtSIjB+4D1Nh1ixflsBspuNKLvTTM60BKJDtKU3WmlR8ym78d8HdPYV51gZUMMs6q+PCnWP1uxNKNsuvGFURgNeDFHXXfufhEqo02e5c1KzzCbFU15rHg6xw6H8QknFfJ0dDw+g3TwMArxDIOhBX+FXrba9ht2KstSvTatGmWuq7PQ5ADdAUi9R3AScS8zgfz1GyZeIWAODZOYnYAPWaspx0uHhmc15o/cIi58t8u3IcT7cWsgwtgsR7lUdOMrWEw4gvDjlcuAcmOn571EPndaSU/lCjI2CbyYS/7DbnuYMQb5IL8KDfclJt8EFU6Bp1FtPFQYYfK6pRO29krdN/Z2/RjcmUZBweKSP/MRYXF9iYCU+zw1Bwqzs40a4mxLWGnguFU38d3/9ifY+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199015)(6512007)(52116002)(86362001)(38350700002)(38100700002)(1076003)(186003)(83380400001)(2616005)(2906002)(26005)(6506007)(8936002)(5660300002)(6666004)(478600001)(6486002)(66476007)(54906003)(66946007)(316002)(66556008)(8676002)(41300700001)(4326008)(32563001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NkVP0VnZoBOI/WBFda21VCOhV6IEhLTZAlUOKHJtDN3rBAVkOhiLCdhCIJO7?=
 =?us-ascii?Q?bNp1ZlHayqvbUeFitGKGIhG4Ee9Pu25j39esTa0WCy7gtqcOBoSdAmqbXAAH?=
 =?us-ascii?Q?pL6KHvS7EAAgfxKYXWqlpAWADyfIQXEP/6qaWLOIiU79MW0Skv9hz5Y5gG1H?=
 =?us-ascii?Q?JhGqyUwJQIs+m63J2ajVbkcTMzF5ZZKwBKUXY2TYArmDltBEfJx0rfyaJirS?=
 =?us-ascii?Q?brvD26Jqzuu09wR9wZ+ybIIw2WTS6bRGcGUkJ2buNk9+wWi/c+v3rXlRMLGX?=
 =?us-ascii?Q?S0Ux1iZ7/JEjQSxEnZZH85XIRk+Yd8sZZZO2C/NVy2RtOpg8GxC4XtnkgAlZ?=
 =?us-ascii?Q?TKdHBYjeYbfW8uNU+wfsfT8q6oxqwVrinG+oNIwNqrbYBtuZp8aDi9SyZKDU?=
 =?us-ascii?Q?mTGZjnMniXYjztm07/ynj2u7FjPy/QvA3HVfCSv9MWAW4oYeaVFal0AsXsyY?=
 =?us-ascii?Q?biYuAbM6WERta/eS4V3Xjzh2SIM22OJpbak955wneZ6O8lgE8pG6ANOnopW0?=
 =?us-ascii?Q?dAl1ulJfXGb48f7zdOs2DDZ7e6l3qEKZMfU3KXsot23jm6o1rhILhm/cPwL4?=
 =?us-ascii?Q?R4gvJCr5BjSvYcsAVQFwuNZzxrTWdoLGHQAdrZyYHJSQdKf9ZiBxetxlyh1k?=
 =?us-ascii?Q?xztwIFzUWqSjQ9MUvBmkxYyhRWYVsGuf8KfR46qm+H01AUWGZuhTjedqtsTe?=
 =?us-ascii?Q?kr+tf68/hhWIWEyIonFkBtRUuiAthD/tPCsy436qJIFwrCkQKNzyHNos+482?=
 =?us-ascii?Q?w9YaaiRFcmIki0RmoJrokt1eu3C7CQkMkTdyFpPtjuQF6yXdBSl1uorC8Oa5?=
 =?us-ascii?Q?bTzD/B9bC7+lrvxNWoPhRJGcn5jRVaMJHWpFP7gK6KOhQMbJI2hx7+/4lGUm?=
 =?us-ascii?Q?+VmePnU5QwGqjYi9rBAgg4QLI/fp3tLbmYlFeevkiNyMNKQmm1TenmG6rbR/?=
 =?us-ascii?Q?NReo1ES37XrggIaARX4meb98ZN/M/aT4ktLqcwp9RWK3QTIVP2LdJHPX8ipt?=
 =?us-ascii?Q?oLu205HDAVsW4+Wwbao1q2cPaPWc+iK1b7uARylNYSS6vKaDk6SZks6I01Aw?=
 =?us-ascii?Q?tPt7scQAU9C5o+ADqi1nCEdKrwvDrQa/EKKpmbnXcZ8IMwPPoAFtjbNNQCkz?=
 =?us-ascii?Q?zGKMYgPkbzSVaBYFVfsrU1mtIgM8KPh1MkB+9tlrZ3F3R3kFWr5tUo2G/epv?=
 =?us-ascii?Q?gVbdoD99PDes6oDqHlDCxGagEmUGv+NKKlIHGD8glb58RrBIcRPFFQ3V5G4W?=
 =?us-ascii?Q?9iykWxwrgimTPvLbjdvFNhwj2glp1m7fkF4elNhjHFWCcc3Z/yZRN3re41rQ?=
 =?us-ascii?Q?KcQd5AR0SqCE907xLsXcH13hNE1n8y2ghqh6gDy4Xwbk7vVEdfOJ0byj1qxb?=
 =?us-ascii?Q?JDjppCNtL2a1xjl+AM8HuD0sP+3BY+O1PLh/wY/K5Ye+Yd2hkSkL1HMzx1IM?=
 =?us-ascii?Q?adW9Ce2PGG8/xy9fU7YLQHr9C1UV8SNhKNcBG3HYozmsUy2Q97gc2bgKAOk/?=
 =?us-ascii?Q?YEWZqPhFf9P7f91aXDS1XZjrnYSHR2MvnLAHftmwbApFGWTnLJYLVeqfJOYQ?=
 =?us-ascii?Q?V96ARqgVe0hK2riJb+q+1thUZ++SzdfpNQXM0R4+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f79b43-4336-4cb9-3f3a-08dac6ea0093
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 09:15:56.3625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 026lsHB6ZJJ1WSUNNAHCM1oiy33cy+YPz7bg7B0Dn9Ti1zx3+YV0q0y5dNj34KIMCYZdJnryKUXVb1dRhDaO4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8195
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

