Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907F7605BA9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 11:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiJTJ7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 05:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiJTJ6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:58:49 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80081.outbound.protection.outlook.com [40.107.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82ED81D0D57;
        Thu, 20 Oct 2022 02:58:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIZFEg5J6Rsk0DlrhsgRdIxSOe73TpW0uvf7QHYWKU+nHqCnSmX+cn5ChUJcNY8MmpS/BCHb93UzB4pbXLCiX/9An8myhWndBXvm90SbjCA8cC54wk74uzhfyO30C7kV++S+V0Q0CccVo/l5cXPswfrDzEjuuvpHTStbY+offLGRGt7JikN8mS7JsmITCESl6epme3hrOp9MiKHNneOG0K7QPN+eizhaN3B1A+EbwJdqrXoyaB127WMhOBMJ/VKso3t9fDhmaw+0oQgwFUVdWgxnVJBIGB9hrH9Bra35ViRg2uIzjwkfq5TwVFp/rWvkryal9nCtvEK1qHSiwifP/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9RwsCPZESPfzsd9gQ2WDGfqDM4UZa4QkHxJ1h8fbic=;
 b=N1lYzfLLzVUpLNEOf2rzWoNoegTfdpxWjyxiEglh4IK0RQfwjp/NNzv3NgqBKBIqFMwyzE0k+x/Wv0q47m+tqjhLO2A1nZDpx8WbF5p9ZoAPmmxtDLIFovCmxRwnTuB3E7saXsoIGRvAmleHOaYzuwf7Qwku5EdnPvLpq065OSyKnGRZA0sKsdstHBDHCO/ZHJip1icoml5ec0/wJHM0B1+Z7Cl6Tjf0ZzjgWz2B0u97KMCcGdpI0vuxd74BfsN6KG/IGCV49D4Wqhb2udC/Mp9IXQc1bLbFpEr3zo+JMOG0S+8CT6MUg5Zx4iuyoQEXqCUc8YVNF1NAYcpmwfxTgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9RwsCPZESPfzsd9gQ2WDGfqDM4UZa4QkHxJ1h8fbic=;
 b=giJinOeRrcUnCzKASWLM/8g69TCo25j4I2O9bN/Sz0AaU9W5pdnO2qmIGaBGvj/ahqZwwlPxi1XInse+HHSbw63uOgRxxt0tlnZCLLpQMGKNeiZEr1XpGWlNgQ1f52GAQVsMVykmAvSB99JMTHE89TCIfeY5qF8AZoGkjo9hkBg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8039.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Thu, 20 Oct
 2022 09:58:34 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Thu, 20 Oct 2022
 09:58:34 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 05/15] arm64: dts: imx8mp-evk: enable uart1/3 ports
Date:   Thu, 20 Oct 2022 17:59:24 +0800
Message-Id: <20221020095934.1659449-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221020095934.1659449-1-peng.fan@oss.nxp.com>
References: <20221020095934.1659449-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8039:EE_
X-MS-Office365-Filtering-Correlation-Id: 41a51b82-e8c1-4988-61af-08dab281a657
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xuB5jxqACZ/k1/2hvWbSHi4nf/AD/jYZCN5YXvOoqo89LvfclukEty6QKQmBJ9SDoEQ0cwUrOqH0LDmFJdVyCPFHCvmeEmYEGF6aos8tRBGhQar98+QR+0Oi3C/yXTBeXPDFhzt8IYb9t9iT7z5N7WzILAn4GGWeLgNuP599dMQI64m5BcVJxQ02NKSonKYeBqqqZvjzyBYcCrTN5M2YCQ9pRjJ0QDRE0M/XvB6Q6v8EwSlfsJWJ+vwlC9eSw1apwy1zM7dHcoY9UapPD72gmeLyFEivEtwuinvljZlJJde53b2q2voWgfZ1b5GHEpeR/gENhxPhMU4rUixn2ym1IvdqewXXmoXsuoAkF9H/kyreBHJG1tYhTofd7llAd7/6Jig1z1rmFqwgWnIJy4g4tgQe3TwgXwtWUapKXvxu9JnMpFA35Gy/KO162Y5dsA6yO+a2NAvxQ0DE83KxCtNhJ/SBcEh0piv/28xRYVjnKbaAdI5dsCnEgMp1BN2Zt5wAyA+yYdaFEiQRJQ6d9LXuWXe9fCOWbyz2wHiUv/uvpcOH+XALSEymioERYwj2tBvcV8z7I33wrxoFARQEWJGiet7yWwXcf9UTEYBc3JvmoG4wdyBa9ILkj2/4/mncxgzGBdCQhXpCYVDew2epjB7owS9KIiXrVXpzFSNbRXn+JERcyPZSW7dF04NsxgtMwYzIGSRHpIvAPE0vppz4gI1hvtGuHel/2A1zFA68OzfD+p6Aef1cDOgzqIQBLmEWmcZWQhhnxBxRo0vhfG9U+mtVNFxTMG7VxZNe5j1TI9n9EQ+gtL92F/aITz5joVVxh7cW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199015)(6486002)(83380400001)(478600001)(86362001)(66946007)(66556008)(6666004)(26005)(41300700001)(6512007)(4326008)(8676002)(8936002)(66476007)(38100700002)(2616005)(2906002)(38350700002)(1076003)(186003)(5660300002)(6506007)(52116002)(316002)(32563001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dPsbvvYNowG3GDT6SJuGfupVSqJXDlkhy/SI7iaYlOsJ0cY49uhvhLIViMCF?=
 =?us-ascii?Q?qHSlV/ETRmXkItjM8xGQn6OQRZSsba6mHHvgZU+wC9xfaguqAPz7dz4tWqt8?=
 =?us-ascii?Q?2zjdd/gyS01FM/Ajs5ij511XzczuvK9waciy1jK9+/wBMw6SWZJxMwcsF5lC?=
 =?us-ascii?Q?BQwH1ISOZijOTrGXqHvVh2jGH9aij0wUe0wIhcbI9z3Uvqvuy10xgdMxrKyL?=
 =?us-ascii?Q?Xi8EiwGred/V/DuaAalkN01iPsCve2RHHWr/d1Dbb2lsRWg0mt4+25Vbfzro?=
 =?us-ascii?Q?t1mk33srpRlC/06OqFa98emx5USE+gMDmwcAn6zCO20c2M1cPFiRtOwP06G0?=
 =?us-ascii?Q?o6IW6dWQB+vD25r2VnEBMNt9hAzHHohTCSMfR/E3xLhHa+IQ38MfuNOHWAth?=
 =?us-ascii?Q?IZe/zWqRPWrhLGTMwTP94zeLbiTZvu4nX6A3XQDC4IsUSPWbWMbyVYbuHf16?=
 =?us-ascii?Q?dyQ5TlHM3MXiZw0eyRQ4vLF3z3Nk6MHC3dwlfI1zaOuOqnqxa11seF0iXYih?=
 =?us-ascii?Q?D9IdAw08ll43l+0Ps3QMuYgziAGKX6z6j0Z/buElaIt3bJxFvS5T9hzirh+z?=
 =?us-ascii?Q?Yvpm8Gu08vyQQmVLvBclAsQKSdqDs8txzzH7JECe8Xn+QGlCpsfh3G1TA2Sa?=
 =?us-ascii?Q?EHZB3yl9qm4ynKFpo0AI82wUmRcL4a5v4KfVO8Iw6eNAagv0nFZPw6K8bUns?=
 =?us-ascii?Q?RLiuPLboEuGrCtthN3/so8OOziM6kyvYiSdjU5dR6NeSuKCGmomqDHkNccqi?=
 =?us-ascii?Q?TZ9hr3M3oZ/nGHNy1acCeHyDPDkXwdjFBkvyjDPMoDV6OmZ885xW0EL/p9aP?=
 =?us-ascii?Q?OUoFLCswWuuy+M2y4TcRfFtT04pwZoa4hMHZ0HAB2B9xydzZyH7Zf6CmvB7B?=
 =?us-ascii?Q?v4SfeE0/IgChbZX7LsreEd/HJ684bZVicEnnP4axdAoQE3ShGSdhzIOqP0mP?=
 =?us-ascii?Q?sRWUHc+A7Fk7bk7mV1IqZy46mO19N+ofqTCfpcW+muC08iOiNLlHgioXKjjm?=
 =?us-ascii?Q?jPifDSY791vWDXCdzO5hW7Rmg74VUQnXtuqEv1n+LG9XkvDEtTmvxB3PjEJR?=
 =?us-ascii?Q?D3nf3U9zNzvhjThKATQotLe6gAqdx26NSvcvmc9dSFyGSp+COnYZ/B84St0C?=
 =?us-ascii?Q?wRIhJQaheG3e/fhJQg5puT0UKPeUrYIFeWBmGmzGLwosgUUYPv6PjK+gLVqj?=
 =?us-ascii?Q?lI/zQLivkdUPmDTIKx46bjw1ClXlDoNtgTx+7lVb902U9oVicgpIDBhUqmtC?=
 =?us-ascii?Q?2/uY/qOpQ53ld4pEbqZu9Fg561IvKTVvuOyFC3LBEo9FqSvzdY+X5Z/OGrhj?=
 =?us-ascii?Q?7RWqIWRi0IvC2qKxov6EI36IAIWlb9fhISgo/14ogCXjlz1HkAk5hqSdXSnC?=
 =?us-ascii?Q?k2iFcKpQT57XdsIb3/zPcgtinh+EQBoGYXEfErowApGk3Pp7EMzX6jNQzEr0?=
 =?us-ascii?Q?j1YdAUzWGFRBd6QHDW9fAXqkQwKPG9Q30uNeJbc8+tRVJqmBMFU06pV8Xi6G?=
 =?us-ascii?Q?3p9V1xnAY3nQIwDzVoq69Bw1s3ecwWYNDR3gbieQEyNSbck9KnYoJUcjzVd2?=
 =?us-ascii?Q?9r+hu3xyr/czhl2it83fomVWM9prBqRbkV6Ik9oN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a51b82-e8c1-4988-61af-08dab281a657
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 09:58:34.0272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cTgLau+dnp8PY0kM6J+Lx+Xxx2cMvKLOGZ61IiLMvV0FsJkAVemaSNwRlq9UQ9ZCCTPLgNaspVrgMi3sGWKjEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8039
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

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 36 ++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 2e29bb3c041c..366f709f8790 100644
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

