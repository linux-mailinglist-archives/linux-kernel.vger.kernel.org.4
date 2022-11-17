Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D349F62D785
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239333AbiKQJy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239668AbiKQJxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:53:18 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2049.outbound.protection.outlook.com [40.107.22.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEB86D482
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:53:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZS169kYiIhQxddpZVITcAzkrF+LF06s933s9h9l8/fQo3pjHJMx+TP2cE6MqqTuNXe4CuCqD8Y5KZiKw03vhhE8aV3kOH7RoMQzN2R2mPd4M7CrTpHZ0a+K8n7+11/Q4CGathiYShcelIke3e4toI7xD9jIv0aOWYTZMSFoYOdXVzF1pBzhe5O2KwPCOAX17fEN9szw0ng3focI1HDDyih0L/TZoqTljYXb9RaPIse8u6VRde67eVnUxiM9LHu6wEVH20nYtsmycwQ12aoIWGadOw46kNzrBbNN4JwN8MiR4+wj2T1zViQdolQgTcTmE7i3EGhxL5neAEcNwOjvyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDMUFAYBCeXdDUIF/bNjoKLWdP3q01VwdwXT3+tF3Pg=;
 b=bOpX4qigiYCuS6ZXEFlv1Lkyw6CoaPywvJbUrRniM3bKPaMizaW6uEK7PNPwDtW9/WV8L25Mkh7YyDvHgo4ZyYHtABi2lJjANGrYlY3yMeGLolQq1+/svqm1vOewdHjdsnYD5arzSKah1lA/6S8Shn/HE2YcCzDy+ybGA3df4+/1P0u9JLjOPZnjXQdx0G5UTka3GKp75dCZ/wybCPjqTFqzBSreJz/qM/RiXMEwLIkn0vsWm84o52bEg0HpW4ticH9Xz8wlGK6OcSI6h9hIzrEdDIY2wFvnHY6+CoQN3N5Qw7EWQYbVi7cCrVKsV3WR1VliCXuPWVLWkFYg/UEmtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDMUFAYBCeXdDUIF/bNjoKLWdP3q01VwdwXT3+tF3Pg=;
 b=A8i1HW3eKAD1RhfRViS0AcEOBcle+BsA3OWoyQH7Wb923i4rQRrB8muNTDvOrfP2nG+wFvryCOEQjpTRc4z/S4VRRijuL4UUwfEokMbR2fOCz8hPWIRH+8s0YjU+dgB2JTTOaVtjfQNp/6Ef0hFMcdRBLcXFgxaM/UUVgI7/EOM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8223.eurprd04.prod.outlook.com (2603:10a6:102:1c9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Thu, 17 Nov
 2022 09:53:10 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Thu, 17 Nov 2022
 09:53:10 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH V6 10/12] arm64: dts: imx8mn-evk: enable uart1
Date:   Thu, 17 Nov 2022 17:54:01 +0800
Message-Id: <20221117095403.1876071-11-peng.fan@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8223:EE_
X-MS-Office365-Filtering-Correlation-Id: 65b35056-df60-436c-67e7-08dac8818911
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IkKRD0ccdXVh1/aJ1lz75UfhRwX0wuhSL/4/vEl5kXrIWWsJKbUgEzysNNfrJvYOZVoriE8KRYLfKwgN/Vq0OmF2IZ2fRifvpcDLmKFxkB0gce+WKRdvme0iPgvINWqLVcd7k/dGJfVkLsH/7+1tGOHE2SPDc+Hpx8uwPFH1GglSSzBcxtuVdVkBsr0NAWHcR89iYGQhs0w9s62/JbpwLmWJFPTsKRv36kjKwvnQl9Bw9zYG6bXJJx0JdxLlfArxYlpD0edQ6s0NZs/tcTA3spEIWmrzZWvZngSxe9qcLC50n9mB/SXHZ15qyGcmMs+vFcicpT0SHmZuXIjC+e2leP167tsNRL6kDyg0hKUOyDlYm7VOrkn13/g/nW0neUxRU5vzsExQVP9rk8TAnu5M228LV494qCHelSsEV0ivNdDbl9KPfey3G0LmoKt2h0JiGoTJ6z87zPJePiZlC46Vx9dE/qKf8SZsLRcCVULsKzHmms8QEgkP0XcIWjN1O9Ly5sPCjVZ5JIKG7lJ0OnhDCAVFjQHxOBWg3SkjB3RLrBNfdmJ24vie//J02HuDgeYa3pHMWNXgv3kbeoN8PLEvRx+/Bei330Oj3Jz9XNWEyYPhMhCoWNoCpqoQEqJaW/mke3iX3v7LsTxjVdVpwMuGmdkx7EwLzXiDLnn4NalY9Pq6KwpFywU1MbFs0bZoN0VHKBM3g6q8vRkukHIIUHpVwM21xo3o8gXAYvXgVsx2NNFbTujraqIZRvh1qUvkGatd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199015)(83380400001)(86362001)(38350700002)(38100700002)(8936002)(2906002)(4326008)(66946007)(66556008)(66476007)(8676002)(41300700001)(5660300002)(52116002)(6666004)(6512007)(6506007)(26005)(2616005)(186003)(1076003)(316002)(54906003)(478600001)(6486002)(32563001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mOIZpwRsipTg5FdldszYoTtC5Ugud3Zxsf7ah5V90kpwgjHPsrX26eSW7g2c?=
 =?us-ascii?Q?/2osUhL3GdH+uzT8dSAcXzP/oWpy6res8S/GofU5wTtHBxA2h7BXKqJinFLr?=
 =?us-ascii?Q?tCC8NEhRuPXYjQ3H6EIwbTonDggRcaSHxvRmzpttI0BT0OyNecmGPeMzh4ZL?=
 =?us-ascii?Q?xD15y4zCanwJ7HW0yqp/eHrQ3SeKF7tC0MKxpqsePjrCQEwO/FxQhg226NQS?=
 =?us-ascii?Q?bs06fEl4Gq7Vkqd/Ha2hhCxO1RnwRyL0jQXh1mUZ/5t8p4UIhkPdZOpEd1um?=
 =?us-ascii?Q?19C/xyw/74gAJc2QbdfS4tsUlH4yhb3xwGoESjEOul7kcPVOQEJsvH8ajKAi?=
 =?us-ascii?Q?RSGeion2HS8pyU9NiM4U4NjcCCuBQQCiBNzj+Nj1omNlwa1I1b9rw9OIGdKe?=
 =?us-ascii?Q?6IG6QKgzaHNz78Uy9L92uPCf4smiSUZ4tv/JbtJuz96ax+Iu6z/kwP/7av1P?=
 =?us-ascii?Q?ngaAtqq01G1pfM6Jnyh+4Vaom8S20VFSJmROZ+0eDFs26eda9Z7Q5/gRey97?=
 =?us-ascii?Q?uaZGXXOWHwrhznI5LJra9zwPnFYXVgzHRS9VpgzQTkuv/+D+IPpDjOvrcOFs?=
 =?us-ascii?Q?kdxko3hHydv4JbmtRAhab3MxXDvO/92Ya09F2jtbsBSK7Z/pjhwc+JByJKf9?=
 =?us-ascii?Q?gn8/i7sToD2KnEywZcIAtR/S8ET3ucdC3Pg4sLWfZdLyZCueq5XpMNTgwybm?=
 =?us-ascii?Q?xFrl5R12nh9uwG0gzoZgtLuETiUN/LnyKH/ugdfqnFQz+LWTJofnpxecWlj6?=
 =?us-ascii?Q?RVz/k2Pu2hxVhPMMuY22Z4pJ2PJL+s319c7zYHpbVVoehU6SFTw+9md8h0vh?=
 =?us-ascii?Q?jvnjybMB5DRnV8EzwlHtxKvZCQXlYP1g8QDFeMdBmXJUphZ3LVV+Q0VkuXmD?=
 =?us-ascii?Q?JOWVT0JOMxT8AC8syd+AIyp4WZLya5NKR/3bUdbV3k3Wx4pAHCgfP4+ZfZec?=
 =?us-ascii?Q?yI1EgaoNhg7kFn5iQO9vB56U9RDi+cQ1hF0vxG6aYAFX2S+pn9sfbKNP0M7/?=
 =?us-ascii?Q?BNl0+o6w7Q5yFFehmGtWRdsN0EuXYKXdsV8ezvqgtaZJ5MG0UXYg5pFn5epy?=
 =?us-ascii?Q?l3iR7b/g0H7+3qbaVy7E2KfNgWFceTAyQHfLU3kJ0rS6ZTBkRjw8E0iKePKz?=
 =?us-ascii?Q?C15yhwQWWb4RJJFsmMVpMHolpR4ip+ZDK7mWid3ToeokE6WTyJF3iWiNNjQU?=
 =?us-ascii?Q?YbgAMXgOtrTPYQKrS58Furyx7OGkGom/YfGe8v+or5f/2/ydqpys4ZwTWbiw?=
 =?us-ascii?Q?w3JyOEG8btcAuHl9q6VwIDz254Ud7xsOBiGeixiL9j1bamdxh/t6lbz56x58?=
 =?us-ascii?Q?eoZBppxcmBITxCTRiS2DrXUzkUVLEiQavME3zNmqgN1ibGWq+Bf+wRIxEPu6?=
 =?us-ascii?Q?PjaVQ2A+6heRYSyXdcFCVelnL8YLABTqUXMRZF5xQiuMYEGynH0Teb22hago?=
 =?us-ascii?Q?CMEuB9erdVc1haKqNdnHHAiS4CwmXVwDGEZOTCY0ddNnTRE+TN0pnV49SfGA?=
 =?us-ascii?Q?Hm1cFyBsW/ECc3hiSGHWt4nkDJ0/RwALJSdTHlWfxAb3OyxELNM7ROyn2Do9?=
 =?us-ascii?Q?jAJzKdpn4yL+zZlMS42owNnDlnZMjQ94w1IgjrHm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b35056-df60-436c-67e7-08dac8818911
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 09:53:10.5269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qWfErgrf/JGBT9qapB7XaB46jq+ejtmFfcwhNsO21UIW3m3RdyCToiMSuTBdAF6DGBIbiVzpW+d0RpjwQW1ftg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8223
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Enable uart1 for BT usage
Configure the clock to source from IMX8MN_SYS_PLL1_80M, because the uart
could only support max 1.5M buadrate if using OSC_24M as clock source.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
index 2439b91e51d8..dfa11927b1d7 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
@@ -247,6 +247,15 @@ &spdif1 {
 	status = "okay";
 };
 
+&uart1 { /* BT */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	assigned-clocks = <&clk IMX8MN_CLK_UART1>;
+	assigned-clock-parents = <&clk IMX8MN_SYS_PLL1_80M>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
 &uart2 { /* console */
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart2>;
@@ -444,6 +453,15 @@ MX8MN_IOMUXC_SD1_STROBE_GPIO2_IO11	0x159
 		>;
 	};
 
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX8MN_IOMUXC_UART1_RXD_UART1_DCE_RX	0x140
+			MX8MN_IOMUXC_UART1_TXD_UART1_DCE_TX	0x140
+			MX8MN_IOMUXC_UART3_RXD_UART1_DCE_CTS_B	0x140
+			MX8MN_IOMUXC_UART3_TXD_UART1_DCE_RTS_B	0x140
+		>;
+	};
+
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
 			MX8MN_IOMUXC_UART2_RXD_UART2_DCE_RX	0x140
-- 
2.37.1

