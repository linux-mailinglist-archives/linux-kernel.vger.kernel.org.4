Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0AB6D17A5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 08:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjCaGmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 02:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjCaGmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 02:42:03 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2064.outbound.protection.outlook.com [40.107.104.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD761CBBD;
        Thu, 30 Mar 2023 23:41:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/Q9paJbXsMHkAJdI34/Muor49lpYXwGH3vw27LrDgXQcze0fvX1usqb/9s/VINq0BR0JWJ0bFbICU9uIprL1OnRALl3/lh4GXTKt7sltb+TWmQaMiPQ39Oz0Ue+tTQ1TkEeYYFyjj5sN6IutXtFqLTxP5ZU/QXl06QhCdMvG++GIys3KDR+9H+sTWgVIWNCJmY35TfQ8XrbfmS7Pt+shcOUcoR5ctxbFFZc/d2rNREwxZWwA6pxqPtT1UlGPxjmJlUG1taRg4rSVTvUKY3gl5Qj9SjnUxKVch77fxscYVsTHkDaSr9Ndq1yflHm2y0dFKU+PAnPoCV7LvGmOZQFDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIBehFsIFdkaRnxNQOLdNBYuAICLDBe7ee85gR/Gbcg=;
 b=AU/wRMjHrqNLwZVhVi4gCX543EyAWYTFwGWScrNjJmeBfcpLqlMR1wwH8Lp93FF56V1wg0WCxRZ3Oldeftv479EQF3VhMwhJ5w9Ch6ezFyMFPs4XBUFkTjqiJvW/4gmq6SwMEBz7OaF+iRKSmsK6aOocqknLVKIfH5haGO7ZNdNMFadvyWRwZ9T4dMRCR/NLMNX6lW6gk6IlDYaMnZ8n1t14lE5RFUhTazQbGNZaH/rggKfjxI97rAmkO+DXf44vMoLCAy4aGqc0vOoHLlm/V5ijbJCHx6J4LTHaeGBB2D/lGr9O4MUfDVLPOqZ++XSluOQ7bO2a2vGknhSVxkYQiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIBehFsIFdkaRnxNQOLdNBYuAICLDBe7ee85gR/Gbcg=;
 b=GyEE2i6yz86Wcw0xpW4udR3rxoD86AAZeyeIsDkhLnwrxX3DSqQn7suWv4TxteE2KBI8UjCOWV0tL+1FAk5cZVJcNXL9eB7qkCfW2J4lARWrDhzTj1ZHfTltmkAfZMmUI9JnifgjT50BTmeHj0vQrMxqlpt9kY7ncCm3r3wiXgo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9271.eurprd04.prod.outlook.com (2603:10a6:102:2a6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Fri, 31 Mar
 2023 06:41:45 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Fri, 31 Mar 2023
 06:41:45 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 4/6] clk: imx: fracn-gppll: support integer pll
Date:   Fri, 31 Mar 2023 14:46:27 +0800
Message-Id: <20230331064629.2475338-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230331064629.2475338-1-peng.fan@oss.nxp.com>
References: <20230331064629.2475338-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB9271:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e8ee0d7-51ab-47b7-c2cb-08db31b2fe9b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GFkU3bVYKuq4/Kwsj0J0v8R/OXCODeJtmfQeODvzi6x98ztsWMpgdiKtFcdbZIvnrkbB4eShjIKeXyWHSZtH7P6zYpb3ZZy7ywlij3yUhAjBHYzo3K8PoHsSITO2H+gzTOy9vNtZrtlDYwWEisVdaHtTqVFGuFjqzafM3K8LwiTxjeDiGVEgEa1iZFox+qrSidgEPdDfaumI+9c02USFwuGwkynJVY0PAnwnK+c7k88/iWfa7xecP64r5VqKzWUT9PZONjo6JSfNwIkIf5wgkG55T2TaBmAZCl191WFVA5HRtX8hCrYWGaT8rUuuRmtI/v3WIlHBYvh4o3KeDGK3GO+s9ATEz3RJahK1hvMOfUYcobsKvphOYbRKxUIJL/5F49S0Vn00P/P1XQNR8/3ZWJQXUJvK9Clu+Wq6Aj44J/cwjBlHKRMEyV5SpmsWIXC2uKoIuKy8TbPt1cHvMPVzXpmhoX1yZhWEkhfdNnErfZ+zZE7ZORt6ROmeDqMFrAekcGaycfRWy/+GzYwlh0+yeNAnhrgqV2VLT4SYCDEusC0ZKcPPfqGTB3O7gDF2aM+L1C+CtBajI0IPeihbjJWWMWcUOA+7Lox9q/BDCz1nGqHGb+e+E5aJn3Kp0WbGdI1L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199021)(2616005)(2906002)(4326008)(38350700002)(38100700002)(41300700001)(83380400001)(86362001)(8936002)(66946007)(66556008)(6506007)(26005)(1076003)(186003)(6512007)(66476007)(8676002)(316002)(5660300002)(6666004)(7416002)(52116002)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?twpxdh4rUv432Mw1CfES3eY/nWnCiBx/4WtMzZzXUDnAdJkVyiEkVJhOSeF0?=
 =?us-ascii?Q?ABuUu8zC2keeEFxEyBM3TsxJ0RwINA5L+O44/zejsPTdIoyvWMv54dbatrRO?=
 =?us-ascii?Q?oW2cZvphfsBnlEd5rsdNbDu4K+46vlQAk6MUxXt5FJP+9/PZdE03rC950LLe?=
 =?us-ascii?Q?fxHGUMHXwiS3NBxbUGBR22wQOpua1vloDgi3oGq56O1MqJyqITJkcjXFx/wy?=
 =?us-ascii?Q?Z486mjqK5U72Zr5YXhBfB/GxwlAx0O+04DNqTgwLZT5rmgV2CxtNv0vmVL6Q?=
 =?us-ascii?Q?kAfWSCRe6ptyqHWAydT5OJKqvd/b8NPpNOo3dhBupbaaigOJMtVe4MNDJK/D?=
 =?us-ascii?Q?0D3WeK9V56U3eKNkHIgpxHMad7avy2+B1FjM2Wc7J0xB5aI3gcMm6Ik06WNy?=
 =?us-ascii?Q?2QRU2fGGCYQabj3i7s2Wywc3fkUsGOxTywMs1xgjhMuS0GPq4Wzcl02YLtfn?=
 =?us-ascii?Q?V2i4Ui5vPEkwQD4/HFLOhZq6h2dhG1Lnf5v8Rgm1YsFv2aJ1GEl597Ye35id?=
 =?us-ascii?Q?PiAW6ZZp2uoxsB918BYuWWlHPz8Wy9q+kaz23rjK/AvboEFyW06dUcQ0SAqO?=
 =?us-ascii?Q?lzuHDYOqpF2geARN2hxlrmEG8rJtRXfKmDJoHvt5jpkJzAPEaJikNkZaQ/Zc?=
 =?us-ascii?Q?0pz402ds6uqkmAh+RumGMVTK13zBgEO6utF6pv2Q+Jq3VKPNQpWDiFnpwQlt?=
 =?us-ascii?Q?GAgegi688AybsUM4babwE5/WkZmo221AUdX0OuZVW35wCGEiSmIs3ZyCgVze?=
 =?us-ascii?Q?QFUK14d7EGdQQ72oH5aAR6i/+AQRPOWcuTiuVLA/SrVzpL9EgkGhgEme7j8M?=
 =?us-ascii?Q?NTQvBmyeealKMUkcUmiORaAJbPnnTyjitYqLlmiM1Ac2eXVtqWMYhsNJMWV6?=
 =?us-ascii?Q?7grM69i4jWiAZe6+omhIErjiGtVkSbb1BdLEO34JkXwOySaxSS1eV86zkPT3?=
 =?us-ascii?Q?cguL7c13mCcXmI1keRtALCUZFgML+VOLUv0eOFISdpQ3J5qJo1ZMwEbab5F8?=
 =?us-ascii?Q?HivC9OZrtUVeBdxloARHXKifcLOIjjeAe4FhEY7XO75hTiFsJ1BGrv5DhzxB?=
 =?us-ascii?Q?2c77j/0WzHRQ3JXqZqy1bUII2/3EvodW8Yp42uJOG09FszzdMVMvfXELI1bi?=
 =?us-ascii?Q?KGy9fgHRWqayzuErA27km1C14CDcMv+RezaR9O7WUxanAGaSnKWGyH5vldJ5?=
 =?us-ascii?Q?bNqyIwEGy66/PgDJSrJt0ti2ybIJmFVDvcSKN39h9uQ2SsJnzi1gkjFtF/SD?=
 =?us-ascii?Q?NIRQkSTBMTrJkXBNI9qOq+fyQjXZlfXW3s8UDJZ1ZD2oYNcg54FTlVXUW0om?=
 =?us-ascii?Q?Qpk/V0QcCiCCmYOZJM9o5bPEnxKyWoZGqlKjyrfPHXit+W1eb061hyd2s4pw?=
 =?us-ascii?Q?KI05geCUHzPZJTigf4/LjaqqC1rjOI0nReimmQS34dlgb6OMhXwFLR7KrDuZ?=
 =?us-ascii?Q?u2IAQqDmw8/56omrmoVRM7qYeKo/ZuQMW9TMYTZogJOUwiQCHmO94y2zJ/Gu?=
 =?us-ascii?Q?BgIupQgBYykI93hf/IxrLMsNt0Qg1miRc7G70Dun9lp6WpvROxUBXc9/V8Zp?=
 =?us-ascii?Q?T64nLYLmYtSotwpa1GubCrBigJkMVn7vOwBMKZA9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8ee0d7-51ab-47b7-c2cb-08db31b2fe9b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 06:41:45.3846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7I0PujEv6zSKywn5ooU+bZ2UiDgwuVfEDFf/YNyrM4c5zTBfVO2MkRyS8XVc+Os/O5KnlghuNsfn+t7ssvfgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9271
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
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
 drivers/clk/imx/clk-fracn-gppll.c | 66 +++++++++++++++++++++++++++----
 drivers/clk/imx/clk.h             |  7 ++++
 2 files changed, 66 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
index f6674110a88e..2c4e64db828f 100644
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
@@ -300,8 +337,8 @@ static const struct clk_ops clk_fracn_gppll_ops = {
 	.set_rate	= clk_fracn_gppll_set_rate,
 };
 
-struct clk_hw *imx_clk_fracn_gppll(const char *name, const char *parent_name, void __iomem *base,
-				   const struct imx_fracn_gppll_clk *pll_clk)
+struct clk_hw *_imx_clk_fracn_gppll(const char *name, const char *parent_name, void __iomem *base,
+				    const struct imx_fracn_gppll_clk *pll_clk, u32 pll_flags)
 {
 	struct clk_fracn_gppll *pll;
 	struct clk_hw *hw;
@@ -322,6 +359,7 @@ struct clk_hw *imx_clk_fracn_gppll(const char *name, const char *parent_name, vo
 	pll->hw.init = &init;
 	pll->rate_table = pll_clk->rate_table;
 	pll->rate_count = pll_clk->rate_count;
+	pll->flags = pll_flags;
 
 	hw = &pll->hw;
 
@@ -334,4 +372,18 @@ struct clk_hw *imx_clk_fracn_gppll(const char *name, const char *parent_name, vo
 
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
index 3d94722bbf99..bb105d6e5b39 100644
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

