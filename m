Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9076251B0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 04:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbiKKD3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 22:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbiKKD2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 22:28:15 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70059.outbound.protection.outlook.com [40.107.7.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665355E3E6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 19:27:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMuwl1Dbe7PqPFzS8kGOxVjR4DSg6rM3kK4iPagojjd4e2NUJPeIUZJ3eo5uGVHpRfgrjqfrTp1PA0t12yGJVBoUgOI9a2UC2BmZAbccomlMvn8U4H1dgXAwGwJ8ATXI33R7AYGrIRZUlUDFzKoVkRWZA8WXATWQD5PoJOolBgENOKDgZC7JiXwAOKQpukw35PqvKyyuX3H1GWtCBfY0MJX61jJALdFzy1vrNIxGQh0KgDy/Q5rWQdx3PwXr94n44cc2xGhPdGW4LczpPjGh6htIOHlY3zE/SEZJxFJYer7X3RNtP/6+jsO4r0RFMZuu6ucEvnmidzml7DQf0N2ykA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVZcr/S99xNnQtY1GSazp191cisvYVqNqs7IKEpic50=;
 b=B9IQb8DTZc/wI+IlBnXv5Lsco4adNybshNCKCbmjN1kp3/x7v7e4Ebfv1kmRvqjD66xYf6CEI+FIVfhv9uvn/+Cz/jRIvZEgmsbm7ZHPWH5JxJgB+e30A3l1huyrqLkOLGXO+UvUxAxBAi6++WslWHJw4VeURjGRI0k2i817KPNviL3BEmaHtktJdVkBtO1v2rg1limIYWiWX4KwpR4ib4lAI5BylfIKX0+UQVKOY5gTXNxlEUw1ubdWBmOX57RqAoeQibFFhb5Bxnq6Wq/THtvnXrzFKPllLfBauL5B1RK71L8t1OAI1y3J+TjyA3bo3tViq5LumuI2Jh3Ew/fxuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVZcr/S99xNnQtY1GSazp191cisvYVqNqs7IKEpic50=;
 b=kX2S17FMAv1fCWwPrn7oS/g0y5jaGLOG1eQBkTIx1ExDOvn/nHTvv6JEISnnbQj7Gel1Eh63PFHxNh5ASVvwav927mtwXhfpq7pjZ1os9gF/4esPAVquCERWaWDSTDkrOJyA1hvv87cNLy3SwYTp4R4YZ18gf0G951GieimuoCo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB7020.eurprd04.prod.outlook.com (2603:10a6:10:126::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 03:27:16 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 03:27:16 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 10/14] arm64: dts: imx8mn-evk: enable uart1
Date:   Fri, 11 Nov 2022 11:28:07 +0800
Message-Id: <20221111032811.2456916-11-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: d40b7aae-63f1-4641-9e19-08dac394a1ea
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wT6eciPTyq/td2V9kI5Og9fHDRCE+UIPkTYxwBEMApeoiIpA9EVqVqCjOs3Xy3TgE4qyEcGPD/3QPI8l5RnuXPv5srNw8iqlveQTzCIBZ8ThT22t9WqZtxRWgT7nIPVoKia3Z32mExmB8dOWBFwLKdIOyFDFtDiiBUOH5aUPHQKKlbsA6/d4MIPYwRKr58jpXB+zweESzv/dWOx/TV/X8VHfhz3hz2jyfgEluE9OYumaEKxUqLJ4AuqpzWBytR6/shKzzMWPbBUKgDq4+HW0urluO0n0MK0vu6L2T18LEsY57R3afND9tS/6Pq+UvURuxPhqYNMnslM3j0Z8OHub8sAaSAaduvZGF6f9+Ve+bgTRYA0LNHvT5czGb99GX84zg1Z8SRQ8O0jAZW3TUxTp+uODERDNHMyeeqMqtl32x7hEUgAXIB/4OsgbToSuyJvPhvV7sr/6/GqFZq+fDgLDVOsUwJ0hR9qyLtsfEq3JMHovffMK+sAPDpohvKMeJJ/Vckcr7mak7+NKsDRsrHzq129x+6VrdG+s+L9s3WeQcktKocFrOBjjEtFZjal27hyWSM6FAyTkJEi1bEA/6cbm/oeBdPTzRcvIih1ENC/8sZ7kRxBHERI/ut/l/0QaurfqBYuAo3A4Afe3QyXN0BmJkn3u+FROWkDdchR0AKYd17CvCZUIAXS0Rh9dpkoFCsR1se9QhzkcjWRXFggQvFt+PXdVGSNvKHekor5w8zRsYCtkepBPUS5kBLk2g99JkZlvNmhHEJCfOkJwpmxi214ypSP3MAiUnQQpiKp95VhAoL3+gtp+gpFBJKAqIRoOYLD2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199015)(6486002)(83380400001)(6666004)(8936002)(478600001)(41300700001)(5660300002)(1076003)(186003)(316002)(6506007)(4326008)(38100700002)(38350700002)(6512007)(26005)(86362001)(2616005)(8676002)(2906002)(66556008)(66946007)(66476007)(52116002)(32563001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MEaNrmqyjaNBhi3ML+6cQSHUsU9GS1z3ty0BGSgdkUisb1LOVG6M9OXnNFlR?=
 =?us-ascii?Q?1cPN5iqtk6st9vShYU+hROREq/HL/bDNNM8QBrGn5b3bcfjI4wgboM9fDoUv?=
 =?us-ascii?Q?j7UYVxbcMI35RqRIuqyqSw6kIlKETo7U8PDprDZq33GTxcFHcWLFvQeQ832y?=
 =?us-ascii?Q?QEZZYtrBG6PqWuvmg4s3AQSs1H1VwVNfffaBwIypkFqBteOqAeykwEXB/XUc?=
 =?us-ascii?Q?gBv0px/mZRxTnCZKW9uPi/PMNP9roygSZnutlBsJ2oHywNxKyMCvLRp+Wixz?=
 =?us-ascii?Q?rt2THUb1RiSRStW7QDIu8nZMEf8WBb9+ED58P0Qp6v+u0dI06/YQcViWTQNs?=
 =?us-ascii?Q?ibgg0jmhHOHSHorMJkIlNkwt+Pl7D/EYmLe9NU8a12H88Bt6yoC1iJiSBxCf?=
 =?us-ascii?Q?Ytl3CyTDRYcVkDUlsZ3wFoNjoNijXIGbJ9ASM9LkZs3ZGJRIboi+j71ijG81?=
 =?us-ascii?Q?6CEeC15vDpmKczkgvTjrBYvA0e9kh8sa/3qDS7VJ5pRS2pBZ/NBKH+9s6knP?=
 =?us-ascii?Q?m9W+Jy9NulrbjbMJ/2QZSQ9ZRr3lamLIn2U69VKiz0/+d1TCRInX+TQzJGh4?=
 =?us-ascii?Q?NhJpECHKXQQc3Kryjo1vOf6LkVXv3OD1F+/D3+Tou4PrHkl1q8QLv4XVm/xe?=
 =?us-ascii?Q?EWzj2ht4TApNV8lBKxMt/y6XrH4wjpMoM4hzhLMEYQBE0Im0PSdTTJlNtOij?=
 =?us-ascii?Q?oq6CVdrZ3KSCdyv5cVZiBOMNR4So1PCeGXwvuv+YG2UOrGiSQx3IxCD/RZTa?=
 =?us-ascii?Q?rjUYS2HEFsTblnfdQm7Tqkr8SNRDaQMGceu90HqZZ5BRWbdrwr9GiTRcc+u+?=
 =?us-ascii?Q?9V7hE+THW/g1bRTO51itjcDii4kh6+Z+pvlbLamfaWJ2T49fTvhYzqw94Qiv?=
 =?us-ascii?Q?DyAzfWUD14//XvAAfKLNI05+25DgX0GNGpTXn7pn9vn5oU6prgLPS0kLtyY6?=
 =?us-ascii?Q?933zo49Igobzrz00rY3xkba5xYxBGE2GHYQzjNNkaPmExUsFfr6ABYcw4VJa?=
 =?us-ascii?Q?qPyPSCaffC+NokTwpCZVcJtaPhShbzjAFb3fEWJTe0OvoZJEAreGGHc6p/NB?=
 =?us-ascii?Q?K6ajg1Xt+EKvRp7GT9EAFJ0QUSjE8lM1yZe5ZsYkNafxZSP4S8cm88aQ56VY?=
 =?us-ascii?Q?7FG0sDSJnuXGEW0XjdWzuHRSM0A5J2dd30PID+7ZMSGWhQPsk4oycicUVdOd?=
 =?us-ascii?Q?lDQiRs1UUv1vNTLFqKbKS419LM7ZAxiIN0YMLyDRhPnxMLQB9yJFqA1A0D3g?=
 =?us-ascii?Q?14/tGNtlnQS3AxdKR32dXGBM99T6VscQ096wmBoMbwp2CfvIvBMh5epXBU0b?=
 =?us-ascii?Q?1VYQdJrdt2AfFYwltu4hAcHmXtJ0e4zDDOaAcP8Nk8FNeCrHYHLpVpF+3VtK?=
 =?us-ascii?Q?j8fALG9UW9S1BNR+SGr0QEpI8UisjyIJ1A2w2rx5HuJ5UKagQvBcJ0K5OT8T?=
 =?us-ascii?Q?AsCK7BzsFnsPXoD4KaX2tgzcwDbY8uI8WnMaTCMuAo99X6D6l04tVC6DKKRv?=
 =?us-ascii?Q?AOd83IVnEIYIuYkhofaRCLgzo6vSYQtFWBtPwtdJDfZpuLLvAId/T9jL1+bd?=
 =?us-ascii?Q?if80E7b9/Z7OhIpdDqO/g0Pc4EnuWIpO1qH7S8LI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d40b7aae-63f1-4641-9e19-08dac394a1ea
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 03:27:16.7461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EXKQF3zXrl792zLWXxrzXJJUuszWzSafEL5fa1OzjYjDgM6gn7m6v8FssCEg45dI+mZbSLkVIdf5xw2QNjtEPA==
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

Enable uart1 for BT usage
Configure the clock to source from IMX8MN_SYS_PLL1_80M, because the uart
could only support max 1.5M buadrate if using OSC_24M as clock source.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
index 1971f095e4c2..12dc5d398a03 100644
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
@@ -440,6 +449,15 @@ MX8MN_IOMUXC_SD1_STROBE_GPIO2_IO11	0x159
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

