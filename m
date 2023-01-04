Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11B965D115
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 12:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbjADLBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 06:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234871AbjADLAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 06:00:30 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2079.outbound.protection.outlook.com [40.107.14.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E05C13F03;
        Wed,  4 Jan 2023 02:59:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKh+0/zTiajumzL51ZqVQVxIzYwHFFd4LhVtQ6I/UkZoER3MtmwlR0LjvpVgqitoAw9onQQmEh3yZbuqLlC3YC5DWjgGAgcZobg548rs91V1XWMSU6twDW6fKOWh6DaqCZdQ4iILvzx77AXLA+btCH47WQJnTXsk1SPrc11BpZyh/kMFxXJijK8KeSQA9J82aV9eBLebEFy+OJ8IDgpTX+HGtiM5SY7P7p/726HTB6tvPqI+8Wn/cz+AYyyHV6aMXhFTN/pj5KaygBuFWUm8UM4Q4bMZSgwmzCKkz4YCsK0/OHmQpHbS2guD99T4RUfhYtB2x7npqkO1e8Ej1fLJaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3wG49CyLfQycru6FjXQxDMgqbPulZy6k7X4Vik7g28=;
 b=aZ5lw9fYTbkD9w6yQJxIMkG2sLQkvR1Ghif2++gL86qv1OaffsYH0qM4Zr4MhnjfBmVgdm1srB/mJbGRv+d2w2DEA5wi92WicBFxSdzXY7jmSMClbBJSlC7dNq4RweZ1WO3UHokPRNuQI6h/wC29Xmae2W4JgCYFlF0aYIGARBbY1hcwrX+NxeHSflRo3e0xqbY35raNiVbNkRwkMoAnGW8KSd3kCB7ts06A9xwaeFXj5afaXGKyW2pY8bcZO5f/sMJ4oJBBrnz2EJhCnAMVJyWg0nthNdb28OGtXORsgzcKZsfSZ8QON9X/oMTDu6U/RdkkM58kvWG9BcFUhL4A1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3wG49CyLfQycru6FjXQxDMgqbPulZy6k7X4Vik7g28=;
 b=DY+EAN7s285h5wGI9FsRukJ7vrgLl1haHK5B254+ba88Cvt/TdhsFUaEA3nzpM05fh7aBUyslvKSD2BY2bgB3iAAoqTCp88J77Lza8QTo0AVb92Be+aAjWL7GGjqI3Lhto3HWaMQcVke5dmBMgTqI1FSKLvXODw6Yr48c9VGFUk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8408.eurprd04.prod.outlook.com (2603:10a6:102:1c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 10:59:25 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::29b9:5061:2054:174b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::29b9:5061:2054:174b%7]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 10:59:25 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aford173@gmail.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/4] clk: imx: remove clk_count of imx_register_uart_clocks
Date:   Wed,  4 Jan 2023 19:00:31 +0800
Message-Id: <20230104110032.1220721-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230104110032.1220721-1-peng.fan@oss.nxp.com>
References: <20230104110032.1220721-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8408:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b99e941-1025-4257-7d82-08daee42bde8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9LXSzNQs9REO/5C3x94tH97Ib8oP6eK3kwlq8GCMIUkTiZFPH4/HIk6r+qJc01V1eOjUjZ1/OtKClv5UzIP0hdi3ckXjNK5Fb/iBZiQ8yLtRY76H7ttqgcLac9jCxIYMzWSjhGAJeY+hWrloJgNPzz9H/yEg1g27OBGHBXk8udaaQmdtK4Zf/tWCdTa10E0HWd89zRczdoTs+1ssMQfNn0gZftM8hNqo+LBkZGV8sZMkQI4/3Q+CWcmB2XMTI+dmDJ6PZKp+YkM1DQnSijG6udnmm88hDswT7iyS1y/UTNGOwlkzDNm8fdoagJaTSsZ2W2cjFDvenYUYcK0XJtlxoBXlDEo3uPUOZfza38B5gbZMos6KmX99+pkzyvgWvYzjGKpzsQ+pOgFFdhiDVtHGv2k6IbIRCxt1bysTrJuP32IlwvLFS9NHJTNjlhFRCVJa/4TA/SsnSXHNUOmGJVmVFlV65KmOe1Tfa08T9DzisLx0pLB9vJUCh2vo7p+uOhHogNQd3hyqLfLFVtS+Vkx9ZiY2APF0U295gGwwNOK0CTQF6d0FAK241h1DaD42ZK8gPcNtyfypW/JUbzWY0APVEOA2+1p31+qU3NS0coyigN2Pedglyv3socxzz06d2SlcYveFIay3WBfho4jg/ZXGFvwk4l0hJ5cVzC1Qo9FP5LlB+I5I9X07/9DKGvbykHK/7BRLOAa8IBOGs9l0zxy4Lw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(451199015)(2906002)(8936002)(38100700002)(38350700002)(5660300002)(41300700001)(7416002)(86362001)(83380400001)(52116002)(66946007)(6486002)(66556008)(478600001)(6666004)(8676002)(4326008)(66476007)(316002)(1076003)(186003)(6506007)(26005)(6512007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZN+POIGR/i8+EcPChgXtwS7dJUDYBlESQ2uqgTEHUzGDde2CqA8t1Tofo+/Q?=
 =?us-ascii?Q?KuewbWjruWMNWZPX0Jy+ejPrjMLgNWVdQDFv3DIUs9pXtnwgk2DCJbkRaqC5?=
 =?us-ascii?Q?t7c9+KxOeyjpyOdx7tzm5kVJs7T1g6nR5TwBvn5iA8xOPlr51hkMMj21t5cd?=
 =?us-ascii?Q?RR3Q9SCn3xoJWF6ouGw/1jTeUvXEVFI2lbkzuM+t2PGWIqxOO0kigo7SKVbW?=
 =?us-ascii?Q?RbncLZJOF+lDTgz6aYkhiOCxbfAQ1TAnEb+++CEskc/y998NoR68lLGRNSi9?=
 =?us-ascii?Q?nC7XF0gfAafzNJ+pTZM3dyZmS4oDuyNFKiDQhlgtkY7ZXfvpJgCzUBS+3Moh?=
 =?us-ascii?Q?3cCGex68jSpqD4u2GRm1rFg9/HycRCX8DdllOHrHwJG3U91ZcDfb6jHSWigy?=
 =?us-ascii?Q?bAPXsnEkECZ4bOK/Vdth/61XzYMO3GWm6fDF8YXvynyR0BSoItpEbMIOFTVt?=
 =?us-ascii?Q?l+ye79hyjyUHv76aoULBgEGs9CDK0tcfQsTJTw91EpS/lcQKHGUd080eL/YK?=
 =?us-ascii?Q?I6dJhKbb0+1SUbhXNIgYhXUVTMH5ZBKMaZBX5ZtEipnUowu3wKuwHtfHntHq?=
 =?us-ascii?Q?y2qZEhdJNEbpFflQEcQAxCrTwekeeVgC5qvjrrbe0FjnQMrqgAIcxavjF0xe?=
 =?us-ascii?Q?SV0Q72bhSR4tsDD0xvBGdBEgzFthrN+xpJ3im8vIyFK5Ar+c8xqRn4BiGgnP?=
 =?us-ascii?Q?r7vnlw6bQoIfTZekEMXE+oK64TnETkfrvA5zzxHOb7p78DVAnGfNrddo5IBH?=
 =?us-ascii?Q?14pH7AvODNM/Q5t1DcUalqMUYxI0IfAPrJ0AI3St9kEyLE/dTi+YQtY3TXq0?=
 =?us-ascii?Q?aKtYkUestNh4//AGCb8VnyLh86PPYCFUfEj2CQieFLw7GndjaGi1rKdKDO+A?=
 =?us-ascii?Q?uQa2mgzjZybe/r47P6qG9jIS97x3HzJqjbTcP9MWFjPu4m058xvybnD9YyWx?=
 =?us-ascii?Q?tJ0xLur1d79cRjYg890+U+UF6o5BtovFvjc7h/m6zxvBmhAmFe9v1UA8X534?=
 =?us-ascii?Q?T7C11Jf+mqSCmkUe+Dw5O31k5A28Tg4s/6107NbCv18wFXqaYdGbwn7t2bHN?=
 =?us-ascii?Q?srAYi9C3m+N0k4RjZsgPPN5vRM6iNkdMGWW+D/RXrsi9KCPXX2Qaa/RxbmLX?=
 =?us-ascii?Q?p17hnbfxuaty2giGG3vtCLjSQ0t2c7mppTO2mVomiB3J20Y5xmO+/05y5bCW?=
 =?us-ascii?Q?sT5xNKffo4UUtE00r0EE6EBGPDhZOfaCZuQe265EWmMwSxhLHW8avMW31WzU?=
 =?us-ascii?Q?KFpLITty3z/rPmZvifoqBQ8qZtXuvsR/FMwlNJhyjy6YXQyQvNUUaMv1Wtr/?=
 =?us-ascii?Q?bn5/v3nhrAl5MHWfhwIt9z9YSt0HW3rBE07F5oB3F0iyHcDfdC/s8DlrTCJs?=
 =?us-ascii?Q?wsHJkK9vp970LCA8zuxfZ2Ng1tnJaz6P6ponfrelBPOu/wtaYnoUtL2EN02e?=
 =?us-ascii?Q?75QTfhf6zLhB+wQfqKRXnjA9FKqVkcCM/9cmXPx6uWWwJgL7y/MaDxHQcrFe?=
 =?us-ascii?Q?1xU2jc+eFarhIycGwIIeW+oOswjUJ38p7djwIX+9asXbALDEXex1OBiEd/UD?=
 =?us-ascii?Q?MRZRynuwNsOyVNM2tTIcoNioT5TxCKzU+ALClR90?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b99e941-1025-4257-7d82-08daee42bde8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 10:59:25.0714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2O7QAyTe9bfLLflJrzEhSFe93fyY3YYQHP7HpuS4xzTZ/fXmpmF3PE6SZzHG5vbxWMw5wgfMGvO7ClTcftj6Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8408
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The clk count has been get with of_clk_get_parent_count, there is
no need to pass clk_count from users.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx25.c   | 2 +-
 drivers/clk/imx/clk-imx27.c   | 2 +-
 drivers/clk/imx/clk-imx35.c   | 2 +-
 drivers/clk/imx/clk-imx5.c    | 6 +++---
 drivers/clk/imx/clk-imx6q.c   | 2 +-
 drivers/clk/imx/clk-imx6sl.c  | 2 +-
 drivers/clk/imx/clk-imx6sll.c | 2 +-
 drivers/clk/imx/clk-imx6sx.c  | 2 +-
 drivers/clk/imx/clk-imx7d.c   | 2 +-
 drivers/clk/imx/clk-imx7ulp.c | 4 ++--
 drivers/clk/imx/clk-imx8mm.c  | 2 +-
 drivers/clk/imx/clk-imx8mn.c  | 2 +-
 drivers/clk/imx/clk-imx8mp.c  | 2 +-
 drivers/clk/imx/clk-imx8mq.c  | 2 +-
 drivers/clk/imx/clk-imx8ulp.c | 2 +-
 drivers/clk/imx/clk.c         | 2 +-
 drivers/clk/imx/clk.h         | 4 ++--
 17 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/clk/imx/clk-imx25.c b/drivers/clk/imx/clk-imx25.c
index 66192fe0a898..cc013b343e62 100644
--- a/drivers/clk/imx/clk-imx25.c
+++ b/drivers/clk/imx/clk-imx25.c
@@ -218,7 +218,7 @@ static int __init __mx25_clocks_init(void __iomem *ccm_base)
 	 */
 	clk_set_parent(clk[cko_sel], clk[ipg]);
 
-	imx_register_uart_clocks(6);
+	imx_register_uart_clocks();
 
 	return 0;
 }
diff --git a/drivers/clk/imx/clk-imx27.c b/drivers/clk/imx/clk-imx27.c
index 56a5fc402b10..5d177125728d 100644
--- a/drivers/clk/imx/clk-imx27.c
+++ b/drivers/clk/imx/clk-imx27.c
@@ -165,7 +165,7 @@ static void __init _mx27_clocks_init(unsigned long fref)
 
 	clk_prepare_enable(clk[IMX27_CLK_EMI_AHB_GATE]);
 
-	imx_register_uart_clocks(7);
+	imx_register_uart_clocks();
 
 	imx_print_silicon_rev("i.MX27", mx27_revision());
 }
diff --git a/drivers/clk/imx/clk-imx35.c b/drivers/clk/imx/clk-imx35.c
index 0fe5ac210156..7dcbaea3fea3 100644
--- a/drivers/clk/imx/clk-imx35.c
+++ b/drivers/clk/imx/clk-imx35.c
@@ -235,7 +235,7 @@ static void __init _mx35_clocks_init(void)
 	 */
 	clk_prepare_enable(clk[scc_gate]);
 
-	imx_register_uart_clocks(4);
+	imx_register_uart_clocks();
 
 	imx_print_silicon_rev("i.MX35", mx35_revision());
 }
diff --git a/drivers/clk/imx/clk-imx5.c b/drivers/clk/imx/clk-imx5.c
index e4493846454d..b82044911603 100644
--- a/drivers/clk/imx/clk-imx5.c
+++ b/drivers/clk/imx/clk-imx5.c
@@ -358,7 +358,7 @@ static void __init mx50_clocks_init(struct device_node *np)
 	r = clk_round_rate(clk[IMX5_CLK_USBOH3_PER_GATE], 54000000);
 	clk_set_rate(clk[IMX5_CLK_USBOH3_PER_GATE], r);
 
-	imx_register_uart_clocks(5);
+	imx_register_uart_clocks();
 }
 CLK_OF_DECLARE(imx50_ccm, "fsl,imx50-ccm", mx50_clocks_init);
 
@@ -464,7 +464,7 @@ static void __init mx51_clocks_init(struct device_node *np)
 	val |= 1 << 23;
 	writel(val, MXC_CCM_CLPCR);
 
-	imx_register_uart_clocks(3);
+	imx_register_uart_clocks();
 }
 CLK_OF_DECLARE(imx51_ccm, "fsl,imx51-ccm", mx51_clocks_init);
 
@@ -609,6 +609,6 @@ static void __init mx53_clocks_init(struct device_node *np)
 	r = clk_round_rate(clk[IMX5_CLK_USBOH3_PER_GATE], 54000000);
 	clk_set_rate(clk[IMX5_CLK_USBOH3_PER_GATE], r);
 
-	imx_register_uart_clocks(5);
+	imx_register_uart_clocks();
 }
 CLK_OF_DECLARE(imx53_ccm, "fsl,imx53-ccm", mx53_clocks_init);
diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index de36f58d551c..da71e064531e 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -974,6 +974,6 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 			       hws[IMX6QDL_CLK_PLL3_USB_OTG]->clk);
 	}
 
-	imx_register_uart_clocks(2);
+	imx_register_uart_clocks();
 }
 CLK_OF_DECLARE(imx6q, "fsl,imx6q-ccm", imx6q_clocks_init);
diff --git a/drivers/clk/imx/clk-imx6sl.c b/drivers/clk/imx/clk-imx6sl.c
index 277365970320..47b8667cfa3f 100644
--- a/drivers/clk/imx/clk-imx6sl.c
+++ b/drivers/clk/imx/clk-imx6sl.c
@@ -440,6 +440,6 @@ static void __init imx6sl_clocks_init(struct device_node *ccm_node)
 	clk_set_parent(hws[IMX6SL_CLK_LCDIF_AXI_SEL]->clk,
 		       hws[IMX6SL_CLK_PLL2_PFD2]->clk);
 
-	imx_register_uart_clocks(2);
+	imx_register_uart_clocks();
 }
 CLK_OF_DECLARE(imx6sl, "fsl,imx6sl-ccm", imx6sl_clocks_init);
diff --git a/drivers/clk/imx/clk-imx6sll.c b/drivers/clk/imx/clk-imx6sll.c
index 1c9351649eab..2fa70bf35e45 100644
--- a/drivers/clk/imx/clk-imx6sll.c
+++ b/drivers/clk/imx/clk-imx6sll.c
@@ -340,7 +340,7 @@ static void __init imx6sll_clocks_init(struct device_node *ccm_node)
 
 	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
 
-	imx_register_uart_clocks(5);
+	imx_register_uart_clocks();
 
 	/* Lower the AHB clock rate before changing the clock source. */
 	clk_set_rate(hws[IMX6SLL_CLK_AHB]->clk, 99000000);
diff --git a/drivers/clk/imx/clk-imx6sx.c b/drivers/clk/imx/clk-imx6sx.c
index b378531240e6..7cf86707bc39 100644
--- a/drivers/clk/imx/clk-imx6sx.c
+++ b/drivers/clk/imx/clk-imx6sx.c
@@ -548,6 +548,6 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 	clk_set_parent(hws[IMX6SX_CLK_QSPI1_SEL]->clk, hws[IMX6SX_CLK_PLL2_BUS]->clk);
 	clk_set_parent(hws[IMX6SX_CLK_QSPI2_SEL]->clk, hws[IMX6SX_CLK_PLL2_BUS]->clk);
 
-	imx_register_uart_clocks(2);
+	imx_register_uart_clocks();
 }
 CLK_OF_DECLARE(imx6sx, "fsl,imx6sx-ccm", imx6sx_clocks_init);
diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index d681b6c4b29a..2b77d1fc7bb9 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -882,7 +882,7 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	hws[IMX7D_USB1_MAIN_480M_CLK] = imx_clk_hw_fixed_factor("pll_usb1_main_clk", "osc", 20, 1);
 	hws[IMX7D_USB_MAIN_480M_CLK] = imx_clk_hw_fixed_factor("pll_usb_main_clk", "osc", 20, 1);
 
-	imx_register_uart_clocks(7);
+	imx_register_uart_clocks();
 
 }
 CLK_OF_DECLARE(imx7d, "fsl,imx7d-ccm", imx7d_clocks_init);
diff --git a/drivers/clk/imx/clk-imx7ulp.c b/drivers/clk/imx/clk-imx7ulp.c
index 208a0ab80d5e..f4a48a42637f 100644
--- a/drivers/clk/imx/clk-imx7ulp.c
+++ b/drivers/clk/imx/clk-imx7ulp.c
@@ -176,7 +176,7 @@ static void __init imx7ulp_clk_pcc2_init(struct device_node *np)
 
 	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_data);
 
-	imx_register_uart_clocks(2);
+	imx_register_uart_clocks();
 }
 CLK_OF_DECLARE(imx7ulp_clk_pcc2, "fsl,imx7ulp-pcc2", imx7ulp_clk_pcc2_init);
 
@@ -223,7 +223,7 @@ static void __init imx7ulp_clk_pcc3_init(struct device_node *np)
 
 	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_data);
 
-	imx_register_uart_clocks(7);
+	imx_register_uart_clocks();
 }
 CLK_OF_DECLARE(imx7ulp_clk_pcc3, "fsl,imx7ulp-pcc3", imx7ulp_clk_pcc3_init);
 
diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index cb44e8148e53..b618892170f2 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -609,7 +609,7 @@ static int imx8mm_clocks_probe(struct platform_device *pdev)
 		goto unregister_hws;
 	}
 
-	imx_register_uart_clocks(4);
+	imx_register_uart_clocks();
 
 	return 0;
 
diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index af256ade554f..a042ed3a9d6c 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -602,7 +602,7 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 		goto unregister_hws;
 	}
 
-	imx_register_uart_clocks(4);
+	imx_register_uart_clocks();
 
 	return 0;
 
diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index a57d877d393d..3253589851ff 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -723,7 +723,7 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 
 	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
 
-	imx_register_uart_clocks(4);
+	imx_register_uart_clocks();
 
 	return 0;
 }
diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index 2bcaec19a999..4bd65879fcd3 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -601,7 +601,7 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
 		goto unregister_hws;
 	}
 
-	imx_register_uart_clocks(4);
+	imx_register_uart_clocks();
 
 	return 0;
 
diff --git a/drivers/clk/imx/clk-imx8ulp.c b/drivers/clk/imx/clk-imx8ulp.c
index 8eb1af2d6429..a07df3b44703 100644
--- a/drivers/clk/imx/clk-imx8ulp.c
+++ b/drivers/clk/imx/clk-imx8ulp.c
@@ -385,7 +385,7 @@ static int imx8ulp_clk_pcc3_init(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	imx_register_uart_clocks(1);
+	imx_register_uart_clocks();
 
 	/* register the pcc3 reset controller */
 	return imx8ulp_pcc_reset_init(pdev, base, pcc3_resets, ARRAY_SIZE(pcc3_resets));
diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
index df810f0ee16d..4f7db3c9e144 100644
--- a/drivers/clk/imx/clk.c
+++ b/drivers/clk/imx/clk.c
@@ -165,7 +165,7 @@ __setup_param("earlycon", imx_keep_uart_earlycon,
 __setup_param("earlyprintk", imx_keep_uart_earlyprintk,
 	      imx_keep_uart_clocks_param, 0);
 
-void imx_register_uart_clocks(unsigned int clk_count)
+void imx_register_uart_clocks(void)
 {
 	unsigned int num __maybe_unused;
 
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 689b3ad927c0..c4c73477e772 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -12,9 +12,9 @@ extern bool mcore_booted;
 void imx_check_clocks(struct clk *clks[], unsigned int count);
 void imx_check_clk_hws(struct clk_hw *clks[], unsigned int count);
 #ifndef MODULE
-void imx_register_uart_clocks(unsigned int clk_count);
+void imx_register_uart_clocks(void);
 #else
-static inline void imx_register_uart_clocks(unsigned int clk_count)
+static inline void imx_register_uart_clocks(void)
 {
 }
 #endif
-- 
2.37.1

