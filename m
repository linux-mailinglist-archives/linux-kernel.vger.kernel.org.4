Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F82E73D0E9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 14:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjFYM3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 08:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjFYM3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 08:29:00 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2049.outbound.protection.outlook.com [40.107.13.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC187F0;
        Sun, 25 Jun 2023 05:28:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHzAAh6eM56LdajtNb3hFAwIg2TPZ4X3KgClALlIeuWv1caOQgY1+rVXfgWo+PAzH0+e8GcMRiyVRD7xfi9qUesRP7QUxucVRewPLhXnIxqKVFq3ekZn53RQySj0Oav0T9TGJT5i9wbGwMInOMyST/Z60DTGwiAEcPlZ3J6Ryqgqy68JTtazplw01UJWTFBEYDqI+1BodN9PPp65SVBN4D43bxs+KbcE0o+NUGyb0P2LUpPKfa8GfI0mZ7EAb3Xus7b/KRsjWwsONp0eHrQNE0vee7B3cF0aobluwOEMY9CjM7p+yXbFFgvsP1xJwB5qqQtte6NC0bvdUramZX9awA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sh1qRr208khPIcdlJ9l9pIYz0wLVILwwpdIDwogPLHc=;
 b=ZQ3Kaa14Pj9xuvSywvE/1lm55Mp74cK48gCfRW4wzpvJcquVqDmI4bmBsb8oyKfbRJzoaRN7E+32pwQWFluauJRUsVqKcYjCLWPc6EwmzezEZg679Tp4aePmE/TN48LeIejk2vyP8idUBwgyQHkxvvqJoGI09IqjrN7i00SEbrkk/MyotrXGfITC77LssGNwMatBZG1wXHQ+3sBn4xrAdw+SGav0IdQJRz/AGZMJ78f3HbViEArptBk01fiY527U1utZ4vdkvyZ0Up5JOX5dBow5OjapwNUZSsRCUwZRBTFsGpqWMnvkeCfmq3a4Kkoasc5ZdJXc+lN2e7gOKvNZKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sh1qRr208khPIcdlJ9l9pIYz0wLVILwwpdIDwogPLHc=;
 b=GnFnpUsAD5Vc7OooYieIkF7bwrSIMWN8RYKhyNf4nBudV2qEM2813jzNZXFWRmhV30qF7inWvPN2yon8Kx6b2S4cOoLd0HRVZhA8gEXEMQQqxXwyEmA9hpCmUyCGaa4QGK5Xi0sUlvzMAY0mwz4qFJM498wY/rgKmjhKASixLlM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8865.eurprd04.prod.outlook.com (2603:10a6:20b:42c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 12:28:54 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea%7]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 12:28:54 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH 1/2] clk: imx: pllv4: Fix SPLL2 MULT range
Date:   Sun, 25 Jun 2023 20:33:39 +0800
Message-Id: <20230625123340.4067536-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0241.apcprd06.prod.outlook.com
 (2603:1096:4:ac::25) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8865:EE_
X-MS-Office365-Filtering-Correlation-Id: 5625389d-e2ef-4c37-bee9-08db7577bd90
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 45fjqPUQwLAMcVN/M5LzSu+2np9l+TLoyGMUCntwF6pq4+fQd4JGWuhPBzcFUT8XQY+sLCEwrjMf4XldLRIP10Rj1m/muCy43nuGhawzQ4ZaWOsbJFzi+maNveOvxa1EO3NP2EqGGDy7zjpashkfTHY3xu06fqGcMStSzypc98uXIn41VK3QnK4EwJEJvXEVa0Xh3SW324JQ+0gLz4/NDVb1bsemCRohqJBS8g7cN+pCSOHbTUYwydlSHxSa2xKUqvxQqhwYY8rwbNkARtmAzYRBWVdraaBCzwXAzlkzUxZsbBxp4jaRtLP9CxCGoXhpKCG5w+aeK6SttmrecoIQOTdKDjy7SSQnSA4Cue6iOTH3f/5m1TG3j3Y5aLge5lwBoLiqnqC4IvYBmCvvUq1Acu1tXSoHzxq7d1TBILSz2uT2bxlA1VW15BWBWIEWwEjhWfKPZYiWJpq8GYEIR+iscPEdzWXmuNg0cMedpCi2kacC1u8KduIT2/S1jr6UzeUtLWwbb6Z0u4sletXg0lIoj5CRo7An7RlfPtq62GzyG+65L/4IgsbbTQLiBjEo+c4ODpOidVnsKhXzeme/stIva1SEszJyUKXP+UGeo+klA5eM/+5ZbCqrjG+okNPhO2qe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199021)(6486002)(478600001)(52116002)(2616005)(54906003)(83380400001)(6666004)(6506007)(6512007)(1076003)(26005)(186003)(2906002)(5660300002)(7416002)(38350700002)(38100700002)(4326008)(66946007)(8936002)(8676002)(41300700001)(316002)(86362001)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fWqLc0txUeszZTQR2VZmEpfpJJM1QLp9hbSn7/8FpvVqabqJVkpd4vJRr1jE?=
 =?us-ascii?Q?fErbpZKCIdoIFvxksxPTYaYtUSgxaoIYBz2cI+/IaIebSiLyGAIc4ljBZo+t?=
 =?us-ascii?Q?6m37xil8IO/BQEBiVqr2WI5DgVEqs8vNm6whJQBrArgX9fGxEPOsuHCDBjPf?=
 =?us-ascii?Q?MsMCiDuLXaz3eIM+To3RmqIGovY6KHD3CJ2GG+wl2/0OXxzZfl162DaBlVX/?=
 =?us-ascii?Q?16N2i6c2PUgfG8mSGBbGpuhMkh551Yi0WmGscUiz4ryVseqS1HGj+kxNFpyF?=
 =?us-ascii?Q?ZATpoGEHTrtganDwcbyxe+B6zJg0ozwNaLpHQ0LKCUeWOUmskcfIF5lIj7ep?=
 =?us-ascii?Q?cYqyl7kSYN+xEIC0kbc69JdzSrTGf7WHK1EgaiuhjcXrxE9u7PfB2zHQzueC?=
 =?us-ascii?Q?YbxWtqQN7jFI9wapeOPHi/AR00ds5SeLX6QC7NnQK7p+EcDkmudlQN9YPjAQ?=
 =?us-ascii?Q?ZR0s7Nv37wRkT/F4cskqXs5iFu84FVtj1T6lYTgyPAW0kDA8G5SF/GwjgYoD?=
 =?us-ascii?Q?EImxgElZvDNjjyxAmfjKmCgxki2jxdgpIymT4yUC5Zl4UDVMx1xTNcDnm1Jg?=
 =?us-ascii?Q?VJuJNilrXEX9pfKMwhU2QvXoCJRD+6nBJBlfgygh5mB+qhfJwZSmF3/dK2ec?=
 =?us-ascii?Q?TubiYGDSFXIfLzITyrViLdhXt5qGtNdTjh/7WsNP9VYZ4r/piE33D9o6uYVE?=
 =?us-ascii?Q?9NFUN+rMprRGku6ns9nbBtg14EXbq08ZCEcV+6datGv9t+zTNUCK+9M+1Tq3?=
 =?us-ascii?Q?PE+I7+oR2qGTkqgVksNBugxM4CkcY92XH9qYrl4+BF5YwJZO5gEWOm+ot7x0?=
 =?us-ascii?Q?rjuEv7u4qZW8LwNE/eCmD8egApFC9xwkQeUV4oOK6hhtnhLNwn7FUEmpAHxY?=
 =?us-ascii?Q?jfQ6PZKXn/ITjKX2rCDrEWGnkzKHWowXna61q/Lt273XxX6Tbq2zEdmj2860?=
 =?us-ascii?Q?kYMpa5JcMb1PaD0Ao/X3XPT7coaCbFIcTDdvMf5JyzRKgwjmm/KTFxHu/sn3?=
 =?us-ascii?Q?nzT55YfEFsSF+ACjxp0WlyRkC4PqBQn4+SMNEz95Cghlf6+3wCCAO9y2CRFD?=
 =?us-ascii?Q?cQAoPwlpQVdGGKMWDMpMCgaOHVFrH8B7oKwEVaNnVzA3XyqtiTEy0CIpad0g?=
 =?us-ascii?Q?UCCUiqicALXwpibgGeEsOFnSv/WYCeY4wF5oXWgyg/FPWPx1MOWSseXE7ufk?=
 =?us-ascii?Q?ShQq7ssE4Az/yeJ55BEvYIphgovgiJO1hi/TP3HcKiQwxXXPC2uzSdHVDR9R?=
 =?us-ascii?Q?AHuEsvXAVhiHP58yBppxNs/2NwuvD0oZfAIlN/SXjSHca7igpn7JBPoZTsm7?=
 =?us-ascii?Q?ADii9fXO6sB5Sv9ecxvkr421npwVyg0staK22LKZSfiDaIemJpEobTHcEjWB?=
 =?us-ascii?Q?ICjhuPTE3pPYIgl68dyw5sNBjBeleHBOSCPILmpSFbCYLqm0kPfVP35qWGba?=
 =?us-ascii?Q?1Q7NzgIH3s1ih/XztfBJRiYsnQYSanLmLdj+iyeBeLe4XlRzwkA39RVkPenu?=
 =?us-ascii?Q?mIwASjgnSp1JOrm+SskSh1sXd1w1BEKgc2ZMLHMS6uPqexEWvelXDru/2rF4?=
 =?us-ascii?Q?oLigyUr84QzsgOGEjdH5UR8otEFFPwW6UfoTfvXX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5625389d-e2ef-4c37-bee9-08db7577bd90
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 12:28:54.6851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2l3PxuN2Zz878NoTaH5Oqmv0ScQNLN5G1Mh6mx9c6TkwkgAV5F/8NjFYf8MDU8mmJus4AcfpQfpS0Feap6z47w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8865
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Li <ye.li@nxp.com>

The SPLL2 on iMX8ULP is different with other frac PLLs, it can
support VCO from 650Mhz to 1Ghz. According to RM, the MULT is
using a range from 27 to 54, not some fixed values. If using
current PLL implementation, some clock rate can't be supported.

Fix the issue by adding new type for the SPLL2 and use MULT range
to replace MULT table

Fixes: 5f0601c47c33 ("clk: imx: Update the pllv4 to support imx8ulp")
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-pllv4.c | 46 +++++++++++++++++++++++++++++--------
 drivers/clk/imx/clk.h       |  1 +
 2 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/imx/clk-pllv4.c b/drivers/clk/imx/clk-pllv4.c
index 6e7e34571fc8..9b136c951762 100644
--- a/drivers/clk/imx/clk-pllv4.c
+++ b/drivers/clk/imx/clk-pllv4.c
@@ -44,11 +44,15 @@ struct clk_pllv4 {
 	u32		cfg_offset;
 	u32		num_offset;
 	u32		denom_offset;
+	bool		use_mult_range;
 };
 
 /* Valid PLL MULT Table */
 static const int pllv4_mult_table[] = {33, 27, 22, 20, 17, 16};
 
+/* Valid PLL MULT range, (max, min) */
+static const int pllv4_mult_range[] = {54, 27};
+
 #define to_clk_pllv4(__hw) container_of(__hw, struct clk_pllv4, hw)
 
 #define LOCK_TIMEOUT_US		USEC_PER_MSEC
@@ -94,17 +98,30 @@ static unsigned long clk_pllv4_recalc_rate(struct clk_hw *hw,
 static long clk_pllv4_round_rate(struct clk_hw *hw, unsigned long rate,
 				 unsigned long *prate)
 {
+	struct clk_pllv4 *pll = to_clk_pllv4(hw);
 	unsigned long parent_rate = *prate;
 	unsigned long round_rate, i;
 	u32 mfn, mfd = DEFAULT_MFD;
 	bool found = false;
 	u64 temp64;
-
-	for (i = 0; i < ARRAY_SIZE(pllv4_mult_table); i++) {
-		round_rate = parent_rate * pllv4_mult_table[i];
-		if (rate >= round_rate) {
+	u32 mult;
+
+	if (pll->use_mult_range) {
+		temp64 = (u64)rate;
+		do_div(temp64, parent_rate);
+		mult = temp64;
+		if (mult >= pllv4_mult_range[1] &&
+		    mult <= pllv4_mult_range[0]) {
+			round_rate = parent_rate * mult;
 			found = true;
-			break;
+		}
+	} else {
+		for (i = 0; i < ARRAY_SIZE(pllv4_mult_table); i++) {
+			round_rate = parent_rate * pllv4_mult_table[i];
+			if (rate >= round_rate) {
+				found = true;
+				break;
+			}
 		}
 	}
 
@@ -138,14 +155,20 @@ static long clk_pllv4_round_rate(struct clk_hw *hw, unsigned long rate,
 	return round_rate + (u32)temp64;
 }
 
-static bool clk_pllv4_is_valid_mult(unsigned int mult)
+static bool clk_pllv4_is_valid_mult(struct clk_pllv4 *pll, unsigned int mult)
 {
 	int i;
 
 	/* check if mult is in valid MULT table */
-	for (i = 0; i < ARRAY_SIZE(pllv4_mult_table); i++) {
-		if (pllv4_mult_table[i] == mult)
+	if (pll->use_mult_range) {
+		if (mult >= pllv4_mult_range[1] &&
+		    mult <= pllv4_mult_range[0])
 			return true;
+	} else {
+		for (i = 0; i < ARRAY_SIZE(pllv4_mult_table); i++) {
+			if (pllv4_mult_table[i] == mult)
+				return true;
+		}
 	}
 
 	return false;
@@ -160,7 +183,7 @@ static int clk_pllv4_set_rate(struct clk_hw *hw, unsigned long rate,
 
 	mult = rate / parent_rate;
 
-	if (!clk_pllv4_is_valid_mult(mult))
+	if (!clk_pllv4_is_valid_mult(pll, mult))
 		return -EINVAL;
 
 	if (parent_rate <= MAX_MFD)
@@ -227,10 +250,13 @@ struct clk_hw *imx_clk_hw_pllv4(enum imx_pllv4_type type, const char *name,
 
 	pll->base = base;
 
-	if (type == IMX_PLLV4_IMX8ULP) {
+	if (type == IMX_PLLV4_IMX8ULP ||
+	    type == IMX_PLLV4_IMX8ULP_1GHZ) {
 		pll->cfg_offset = IMX8ULP_PLL_CFG_OFFSET;
 		pll->num_offset = IMX8ULP_PLL_NUM_OFFSET;
 		pll->denom_offset = IMX8ULP_PLL_DENOM_OFFSET;
+		if (type == IMX_PLLV4_IMX8ULP_1GHZ)
+			pll->use_mult_range = true;
 	} else {
 		pll->cfg_offset = PLL_CFG_OFFSET;
 		pll->num_offset = PLL_NUM_OFFSET;
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index af19d9f6aed0..adb7ad649a0d 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -45,6 +45,7 @@ enum imx_pll14xx_type {
 enum imx_pllv4_type {
 	IMX_PLLV4_IMX7ULP,
 	IMX_PLLV4_IMX8ULP,
+	IMX_PLLV4_IMX8ULP_1GHZ,
 };
 
 enum imx_pfdv2_type {
-- 
2.37.1

