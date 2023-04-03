Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8136A6D4125
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjDCJtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbjDCJsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:48:53 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2075.outbound.protection.outlook.com [40.107.6.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA601E393;
        Mon,  3 Apr 2023 02:48:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLFHYPwZVZkEpla2w/0e22qge/qObEJw38HFdIoBe58lKN2w3OXZs/HhujDVO/1QlXgawUsVZLmEbFDp9Am+C+wxcY+hQlaSIRPpIy6vvcFO1Snz5pSeY+D8SuK5RnPQXehgRxg6xRzvJ3yLF09wB2uxzOzujw3L2aM6YebYC0kDE8B3kd2R4qizYhTekVRpUHqWFXwkZt48XlOFZEniwJP2Y7iHU1qKtlJ3nHizmpnKjlKqk3USr00feMt2DDevvv3m7Umoyj8VuXE+7ujf+A1Yq5fU0kQcNyVjXg9CnICghLmPyMKQEoxjvRHMwfVomjS5Xr6ZudizgHzRhmT75A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihNxwOBwllBNiOM+Q1r7Lo8RQHjQX7afSP77gS1no/4=;
 b=j8d6jRNOXIpSn/xZ7uo0yViFClO3id/D3oF4N8V+BryIm1tyz+HQ9FSdDKkqNmgYl5gRa0DgCZwAXuMOMWjmDUjIrOQtBPuCVRcNTnkHCkj6BBawXs84ch/HleZqD/TVHoYYt7UY13IjQvSErGcI5O9y5Rshep+6vXH7k05JzFjmkzjtC51u8XiXs2PVAVmwkiq5bD/o6BMO/HllDZFdzBCWf3ghEZICIVxXocoyiXPo3hZ0wJc3DjRemLwVdS82QmoMRjo/NtZs4cFWzIkPAEH4rcPHjyLXMyKAl5/ZN9GBztHbPDLTjLcYQzUJv3sqYZhBeoCED7ItnJ7oA9JfEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihNxwOBwllBNiOM+Q1r7Lo8RQHjQX7afSP77gS1no/4=;
 b=GsSxXmOYua7OGeUZCvSQMrWPLO+AhabZIG2zi1vaPxSVFWOedbGchtOL07M2rjrFqWaRozxkkOjJ779C3VIqiNaqV9a74mwkv5dtUCFKg19YDsTOJv3MplTrRYqt23NjHwOrjZFtxHst35q6XNciL22NhxNTSR+SoHrHOH38HdM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8070.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 09:48:10 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 09:48:10 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 3/7] clk: imx: fracn-gppll: support integer pll
Date:   Mon,  3 Apr 2023 17:52:56 +0800
Message-Id: <20230403095300.3386988-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230403095300.3386988-1-peng.fan@oss.nxp.com>
References: <20230403095300.3386988-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0034.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: ef74d386-f89f-437b-7af5-08db342888bd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZrvkvhumryhW9bO96MA9YCrjlEcYIR+h/s7zEweC8nxwOqlPvAsX5oo2ulIq4RhOO9MSwvh10Z8nKuQqtI/Iq1xIL4i5QVKjfKpdcIrtgqBoqUKRwU3HXlw3Sfsc7NE1SZNogdVnPOXpqRILkLW02dHRhQDAzzRElDYiGICt99OnagKzRX/naNZJX6voCEbR7iw+qgDTkkhzknp7ZOTtc7F/j71alijtcAbw99zUgrVqAa2BjrqPso2xCfEMBTj+hpKsdE+5VtFP4PCGETl4B+w4QDU54p25aU3mLZMAj+jfbIW1GmYXS3shL6kfQBnOI5e3yxbjtwhR+YGEdwGmNQLIWwl0y1/rJeGSCbWlyfO61uLj3UC0hA8ypFdztEbQ9Fs3RQrJ13157BGvCBD8Gst9nrJpfyKF03u3+JQ/FSUiOU71/4Kso6oTFROVZVuWxo6FkCwdAWK12QBdegTvJOgtzvQnYjJJUvMzswfEsbMVekJPAq/4og0He/TtuM3EUkSeW8BqjV7DSXyw/9JmPNIFZLmNxG1X1VXUAp0ke8wZfqA703nmQf3jHKv09lJzJs55g0q1FWSdjXAtnvyzLTzCmJg9m2xKsS8bBh/hMlzyTluSqiy8La8ydQ10C1jV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199021)(8676002)(4326008)(66556008)(66476007)(66946007)(316002)(478600001)(8936002)(5660300002)(7416002)(41300700001)(38100700002)(38350700002)(186003)(83380400001)(2616005)(52116002)(6486002)(6666004)(6512007)(6506007)(1076003)(26005)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nK69PV4Df3/Oxilr8TbApTFq6EOAKEL5xFrdx1iEXOkc0fD4ws6PDQGDi+tE?=
 =?us-ascii?Q?pWtGDp72vdR7ZprQFPaylDO2T5xpcqmR0tP1TJIz4te/rdex16rGa7FIE0g7?=
 =?us-ascii?Q?GZM0ldS3m9TzjUqhSOPdgRnX9h0iDBfTIxBAlIbifShAZgRvUfJoj4BIybwn?=
 =?us-ascii?Q?DLjnfqWHzVKnrpGngqmAxFsZszLX/cG4xYW2T/YRdUu0rjeau36XsRjD2W0J?=
 =?us-ascii?Q?59R10o81trF5wcUcC9OXLKMjiAyEsbU+Z64bXOrR2P4uvPxTJRS7KGI5/+YA?=
 =?us-ascii?Q?OhwX2iVb5K95vVRQe05j0y1Z3dx6yfzGuCIb3SBY/xGYjQqMyV0bRbpKuSQC?=
 =?us-ascii?Q?71w2hIlLbIVPGP7P0x4nBFR8uG+YpmwzVMce2Wr9dBzVuXOKZAXz4DeA/w+V?=
 =?us-ascii?Q?uZ2b8bYRCwLJsmUJ+V8c8w8cA0RJBVErd5e3+3z4lUPUnSRS03pBfyY0wSiK?=
 =?us-ascii?Q?Z4PAgOxg2JgHh0v7+CwMl90oLiT4pRFCnmvr8tjbQ0lmFJNv5c1ddaKF2olL?=
 =?us-ascii?Q?1wKc7hvUNrB+jPM8puGD2cGjGF+uEw5XC82+HVKHR8glv43MpCI1R1C/kUF1?=
 =?us-ascii?Q?J9QZi56tGwBSyJaJBiC89wt6cGh5Tbn2FUqqe8FwsA6tUn4Mi1ILA5b+AK9t?=
 =?us-ascii?Q?5xdBpJfK0vae9RlePx4khpny3A8ago/tLgbGnO5TM7R3r3ajjg9V5xFSMI6K?=
 =?us-ascii?Q?6NdyG9DwO9NatMQcMBtczeIgqc+orRs4Vk51kUHg6FKBNwYf1bsf5tMFuTvm?=
 =?us-ascii?Q?j3T+LeGVjbM2MzmOaxKT5iuMLBSgjnTghUDKz5lMk4mbycJHq+Eg+XZJXNBx?=
 =?us-ascii?Q?CS5FWDKSfybKK+8ghNYEBBJjwiPVKUx13xG3RkYN6U61e+cELfiD/rFAe5UM?=
 =?us-ascii?Q?+TFcySxw9ODOv2GO9Tk7AvjuTZHlPp9Mlp48+blrpdWLYzlyNFn6UpW0BiaM?=
 =?us-ascii?Q?4kwb875XEOJtOYQrBtNuPX6jET9Jv0FSdkZuDoGmHxHKwwrxUFn3c40pwHqd?=
 =?us-ascii?Q?fRpNVhPSkHBPgHYaImdtIWYuj11Yk7nGKtEaPZ2z3Y9MKhiTKcRYR5YmgVHJ?=
 =?us-ascii?Q?8jAydVle3oFdbTdoLhik+ytKDRKtLGJ1Rqd6lA5wySjjim7HvnK/Ldk3vzkn?=
 =?us-ascii?Q?tvHGQLpYxfJsqG9x37/94GLapEnQw1ZIGocokNVjq8CWu7X/G/U8XkUbbZbi?=
 =?us-ascii?Q?V3e5xbc+pL0GOdJON1E4Dm6J1F91mhq8wjHcslM6YnJOTN6pIJFIpf/LfJjc?=
 =?us-ascii?Q?SkXt8yNIujFxuDUYfmTfnjWgnyQdtzbh1QB0NTikaMONcO/yUpRWTImGtRC+?=
 =?us-ascii?Q?FytvEr0y7gDcdLAY+7U9m6R+z41ycLe+PgWgOuFzqMd0maPVpufe88pxs+k9?=
 =?us-ascii?Q?/6CgdQB7Y4gQUe+UTDcuyaLKYFvVwuAAjk5cBGEe7aNjIpSwGsw5Yzsuk2tg?=
 =?us-ascii?Q?rPK35uh/o5l36+EfuiZvmo5rqZiD9hsZ5HJ72uZ1Ck57RcaioCD1Y7LdK8aL?=
 =?us-ascii?Q?riiDMCsNBsdhXxiFyJTdflCx2cOge7eGKK+1NSsf1zZo5I1vV1AsMXqSpeEr?=
 =?us-ascii?Q?DjWev8sv8zBtOkdCzMEhU/dq7IRsA2DpsLPWKpkr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef74d386-f89f-437b-7af5-08db342888bd
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 09:48:10.5918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tsgq/MXwcvf9cf0wtwxRWHZms/cTEmRT2j7nmXRf0dmVSpL7X1n0potFyD12cHqb2ZGD5RTgATdLi0NADHndFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8070
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The fracn gppll could be configured in FRAC or INTEGER mode during
hardware design. The current driver only support FRAC mode, while
this patch introduces INTEGER support. When the PLL is INTEGER pll,
there is no mfn, mfd, the calculation is as below:
 Fvco_clk = (Fref / DIV[RDIV] ) * DIV[MFI]
 Fclko_odiv = Fvco_clk / DIV[ODIV]

In this patch, we reuse the FRAC pll logic with some condition check to
simplify the driver

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-fracn-gppll.c | 68 +++++++++++++++++++++++++++----
 drivers/clk/imx/clk.h             |  7 ++++
 2 files changed, 68 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
index f6674110a88e..e2633ad94640 100644
--- a/drivers/clk/imx/clk-fracn-gppll.c
+++ b/drivers/clk/imx/clk-fracn-gppll.c
@@ -53,11 +53,22 @@
 		.odiv	=	(_odiv),			\
 	}
 
+#define PLL_FRACN_GP_INTEGER(_rate, _mfi, _rdiv, _odiv)		\
+	{							\
+		.rate	=	(_rate),			\
+		.mfi	=	(_mfi),				\
+		.mfn	=	0,				\
+		.mfd	=	0,				\
+		.rdiv	=	(_rdiv),			\
+		.odiv	=	(_odiv),			\
+	}
+
 struct clk_fracn_gppll {
 	struct clk_hw			hw;
 	void __iomem			*base;
 	const struct imx_fracn_gppll_rate_table *rate_table;
 	int rate_count;
+	u32 flags;
 };
 
 /*
@@ -83,6 +94,24 @@ struct imx_fracn_gppll_clk imx_fracn_gppll = {
 };
 EXPORT_SYMBOL_GPL(imx_fracn_gppll);
 
+/*
+ * Fvco = (Fref / rdiv) * MFI
+ * Fout = Fvco / odiv
+ * The (Fref / rdiv) should be in range 20MHz to 40MHz
+ * The Fvco should be in range 2.5Ghz to 5Ghz
+ */
+static const struct imx_fracn_gppll_rate_table int_tbl[] = {
+	PLL_FRACN_GP_INTEGER(1700000000U, 141, 1, 2),
+	PLL_FRACN_GP_INTEGER(1400000000U, 175, 1, 3),
+	PLL_FRACN_GP_INTEGER(900000000U, 150, 1, 4),
+};
+
+struct imx_fracn_gppll_clk imx_fracn_gppll_integer = {
+	.rate_table = int_tbl,
+	.rate_count = ARRAY_SIZE(int_tbl),
+};
+EXPORT_SYMBOL_GPL(imx_fracn_gppll_integer);
+
 static inline struct clk_fracn_gppll *to_clk_fracn_gppll(struct clk_hw *hw)
 {
 	return container_of(hw, struct clk_fracn_gppll, hw);
@@ -169,9 +198,15 @@ static unsigned long clk_fracn_gppll_recalc_rate(struct clk_hw *hw, unsigned lon
 		break;
 	}
 
-	/* Fvco = Fref * (MFI + MFN / MFD) */
-	fvco = fvco * mfi * mfd + fvco * mfn;
-	do_div(fvco, mfd * rdiv * odiv);
+	if (pll->flags & CLK_FRACN_GPPLL_INTEGER) {
+		/* Fvco = (Fref / rdiv) * MFI */
+		fvco = fvco * mfi;
+		do_div(fvco, rdiv * odiv);
+	} else {
+		/* Fvco = (Fref / rdiv) * (MFI + MFN / MFD) */
+		fvco = fvco * mfi * mfd + fvco * mfn;
+		do_div(fvco, mfd * rdiv * odiv);
+	}
 
 	return (unsigned long)fvco;
 }
@@ -215,8 +250,10 @@ static int clk_fracn_gppll_set_rate(struct clk_hw *hw, unsigned long drate,
 	pll_div = FIELD_PREP(PLL_RDIV_MASK, rate->rdiv) | rate->odiv |
 		FIELD_PREP(PLL_MFI_MASK, rate->mfi);
 	writel_relaxed(pll_div, pll->base + PLL_DIV);
-	writel_relaxed(rate->mfd, pll->base + PLL_DENOMINATOR);
-	writel_relaxed(FIELD_PREP(PLL_MFN_MASK, rate->mfn), pll->base + PLL_NUMERATOR);
+	if (pll->flags & CLK_FRACN_GPPLL_FRACN) {
+		writel_relaxed(rate->mfd, pll->base + PLL_DENOMINATOR);
+		writel_relaxed(FIELD_PREP(PLL_MFN_MASK, rate->mfn), pll->base + PLL_NUMERATOR);
+	}
 
 	/* Wait for 5us according to fracn mode pll doc */
 	udelay(5);
@@ -300,8 +337,10 @@ static const struct clk_ops clk_fracn_gppll_ops = {
 	.set_rate	= clk_fracn_gppll_set_rate,
 };
 
-struct clk_hw *imx_clk_fracn_gppll(const char *name, const char *parent_name, void __iomem *base,
-				   const struct imx_fracn_gppll_clk *pll_clk)
+static struct clk_hw *_imx_clk_fracn_gppll(const char *name, const char *parent_name,
+					   void __iomem *base,
+					   const struct imx_fracn_gppll_clk *pll_clk,
+					   u32 pll_flags)
 {
 	struct clk_fracn_gppll *pll;
 	struct clk_hw *hw;
@@ -322,6 +361,7 @@ struct clk_hw *imx_clk_fracn_gppll(const char *name, const char *parent_name, vo
 	pll->hw.init = &init;
 	pll->rate_table = pll_clk->rate_table;
 	pll->rate_count = pll_clk->rate_count;
+	pll->flags = pll_flags;
 
 	hw = &pll->hw;
 
@@ -334,4 +374,18 @@ struct clk_hw *imx_clk_fracn_gppll(const char *name, const char *parent_name, vo
 
 	return hw;
 }
+
+struct clk_hw *imx_clk_fracn_gppll(const char *name, const char *parent_name, void __iomem *base,
+				   const struct imx_fracn_gppll_clk *pll_clk)
+{
+	return _imx_clk_fracn_gppll(name, parent_name, base, pll_clk, CLK_FRACN_GPPLL_FRACN);
+}
 EXPORT_SYMBOL_GPL(imx_clk_fracn_gppll);
+
+struct clk_hw *imx_clk_fracn_gppll_integer(const char *name, const char *parent_name,
+					   void __iomem *base,
+					   const struct imx_fracn_gppll_clk *pll_clk)
+{
+	return _imx_clk_fracn_gppll(name, parent_name, base, pll_clk, CLK_FRACN_GPPLL_INTEGER);
+}
+EXPORT_SYMBOL_GPL(imx_clk_fracn_gppll_integer);
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 055bc9197fb4..cb4e4c4b8278 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -73,6 +73,9 @@ extern struct imx_pll14xx_clk imx_1416x_pll;
 extern struct imx_pll14xx_clk imx_1443x_pll;
 extern struct imx_pll14xx_clk imx_1443x_dram_pll;
 
+#define CLK_FRACN_GPPLL_INTEGER	BIT(0)
+#define CLK_FRACN_GPPLL_FRACN	BIT(1)
+
 /* NOTE: Rate table should be kept sorted in descending order. */
 struct imx_fracn_gppll_rate_table {
 	unsigned int rate;
@@ -91,8 +94,12 @@ struct imx_fracn_gppll_clk {
 
 struct clk_hw *imx_clk_fracn_gppll(const char *name, const char *parent_name, void __iomem *base,
 				   const struct imx_fracn_gppll_clk *pll_clk);
+struct clk_hw *imx_clk_fracn_gppll_integer(const char *name, const char *parent_name,
+					   void __iomem *base,
+					   const struct imx_fracn_gppll_clk *pll_clk);
 
 extern struct imx_fracn_gppll_clk imx_fracn_gppll;
+extern struct imx_fracn_gppll_clk imx_fracn_gppll_integer;
 
 #define imx_clk_cpu(name, parent_name, div, mux, pll, step) \
 	to_clk(imx_clk_hw_cpu(name, parent_name, div, mux, pll, step))
-- 
2.37.1

