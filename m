Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336696D3DD0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjDCHIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 03:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjDCHIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:08:35 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2074.outbound.protection.outlook.com [40.107.241.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D649DCDD5;
        Mon,  3 Apr 2023 00:08:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TM3uU2J3JGc5NLd3Ro9aNrEzR4C6oKXlgEBsvIrjXTmn2wUG/zaJRrhwMUsKQib8EbCdWbykQ85LRjZT8SScs8Ew3ywRIq80Z394T3l27hmZTX0PlRPwX+wSl/9jYl5R+7G8I6JLcRQPWw/lwEjDYIWNou0viBrHLkVQoHuDprDC/reQjumtaTnuyXXaMsWkLMiimIO74dURdh4zp4lTiGUOZh1dPJ7Xfusu26IuFXmesUVOmfqEzhMYbF2BFX+vVRXKUD6+m8AZXy7HsCU2kS7eKt8YMzTeibXgrLxJrAWbA9KSLnbErtNA5+lx+dvGJ6ybwLzCc+SFnITXXCo/Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGMJgzPwTz5FjjiQx7lwN1zpgCeVtHZ2zjWcpQnxsd8=;
 b=BshZlck+QxJiIE43lyLEl3+TwYcE3Hak0JfsACn76Ju2SkNmJ2Vx7mf1UwRjXaNuNrZijWBIE271xojuR2j193Ky1cNdZHuLGTDYPHZIikFNtkd1vDm/eDOT7xqRFqrheX8setZFuhsCKmol9EtZLvbOWit6GZEDk2eRIft0SAjTOPWjIgE0ENlE819z5vi+Ls6YfgPHMapoFN9iJI9W96INXf4vGic0UmcbWk1tlcucq1d6eXLXSrxYkzUQnTBdXYA6B3AXYdiQBWbKMkQKgciUkYwDPSRqyjdlK7fTOcb27ZF3TqyL1OogLqtdLF4XuXR2TwKlIJ1tkwzVIFisMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGMJgzPwTz5FjjiQx7lwN1zpgCeVtHZ2zjWcpQnxsd8=;
 b=Gw7aKJc2Jxf7otGrTjPVb1AT7mcabYbaPhpNsqeDhUTuxKhMubklXScvBh47VvWqYP+h9OQstvPPHOx+81aQUmfNLh1Pi7lGkLqVEpC7zc2EwcnKYzLNJd8ftOVveKqOMeUOJzjlfKBcWWg4qDHaCv0KJuM0lWFYo4ZMXNx3Bs4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 07:08:20 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 07:08:20 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 3/7] clk: imx: fracn-gppll: support integer pll
Date:   Mon,  3 Apr 2023 15:13:05 +0800
Message-Id: <20230403071309.3113513-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230403071309.3113513-1-peng.fan@oss.nxp.com>
References: <20230403071309.3113513-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:4:186::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8459:EE_
X-MS-Office365-Filtering-Correlation-Id: 881aee4e-dce1-415d-0cd9-08db341234e3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Red4/pLIdR5oUv8msVvLCNE0Re8n43kLjL++3BMSA7v2g/Toq13SRucA67bPbQRt7TCJzGnYLeV/+PDyTwWeW9UKGj5n1fYmFaDr1InkNQlu2+Qe3uD8Qj64Lbw6V+6YB5U5Z+MrVxkVOmfeg/F66lqhbmOWAnvfzAtA+jMGwp6Rke6xq+AyRwJyac61kikBqsiMxyjh+UNDW8JOGkiSmMCxWmTOQyFj9MqnyYdL6vPLg9y1qzjxKbGLk5P551DKK/JuY0RqdOP+3Dcp7Ml3tkWRSlR1uIaUEth+qIxRAiQS1EeHy+JMidP1v+7JyOTBGKaZMfCOko8W3pZR7mQcWQS6ZO4cJksixHQctOH8rBHDe/omBcu+srWMOiIv531YfNz3UEl9KGwJRcyUV6FacjPvM/IjrzKmKyKOPaM09DRMhhYLNuo7UGBM7wV1RuJx87T2tbgIk1VTT37Xdmt/cMjuQgqDWNz1ovWv35Qfd5hc1wYZb0B/vMTUiEIGeQMTgnfmoyWSHH/HnxkqyX3v11DxN5yhhEjXTclPO2ePdXLoLWFS2Z57zMiMgzRmGdQpSovDP1YRcb3XxAG8vz+VJ4/1rC3EDCmCVzl9RuFNlYn2bqTZHY/T79khjgkcbAuR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199021)(86362001)(38350700002)(38100700002)(316002)(478600001)(7416002)(6666004)(66476007)(66946007)(66556008)(4326008)(41300700001)(6486002)(52116002)(2906002)(186003)(26005)(6512007)(1076003)(6506007)(8676002)(8936002)(2616005)(5660300002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FNGvtM4b1hrlortMHXYG+Am4FPDeQaksQsoXNohaC2481MGzn7a/RywVFzCE?=
 =?us-ascii?Q?H1mXYb9C91vlRWYYXIdIlvXEC8/PXHBvc5L5zRdWK9U3KXqorkv0vUXmEr0T?=
 =?us-ascii?Q?YNAFYCMfAr6kpRLuznI9kh2cxwl1dULdYGSyfnmL8ZS2MY+fm4woYUxB1FUE?=
 =?us-ascii?Q?suAyNOqy1y6ApC6YHRsTdFmOtn305x9kvmEQUJvFZujVgLWKdk3ebNCSi/X+?=
 =?us-ascii?Q?YcL28UlbmVvdsNbyzAJVcbrh4fHVCBh9JJ137xh1GUfHWCDvvKKcjzYDysgC?=
 =?us-ascii?Q?DWnWU77EsOPxJej5zLesLA/vHHnLgaBICAZx3LMGO36ScQDpj+/1B6bmjBqD?=
 =?us-ascii?Q?IkvHsSV8T6mpKz7qeiQjG7fuy31o6sVDeNAFmgiA6ACK9DNbykDD8yIB8gfv?=
 =?us-ascii?Q?157DlR4xqXJxg+LDUC3VOwNobM2Mx+5Nx0EFi3bVAm8sYk5mTIYEngz69wFX?=
 =?us-ascii?Q?OcZjkcM/HFx0PJLDcBjD5mT7TdQD3XnOf2HhxtMC5fHt2F9U/LNeMgcnzs6H?=
 =?us-ascii?Q?YRwvUULDFS64z7t5zpjjES6IHH2mq+4nKIhham8ikwYZFR94bs+M+gFT/Z4z?=
 =?us-ascii?Q?QfYbLl7VPvFTeKAyKS+gMZN8MUX0WLd8MEbtcmnph+rTau+MG12fuEUDDync?=
 =?us-ascii?Q?0zjcOiNQFZmuGq1Sm2p4Wq5F7/mJigGlijHXF4TvabHQBA7PFQKVJP/Fj+q6?=
 =?us-ascii?Q?djysJci/hLoZNgn7bvp/135VYWn19Dxq4Cqbhp8Nqk18O5TTP6ZBHLJeKLW9?=
 =?us-ascii?Q?EGK+lSLdSwoXdle5i3eN8uQD7jz5yzZVpKiGS1kY0pq/nibfkcBercjPhZiu?=
 =?us-ascii?Q?IrIVCShpX9u77bseV3+K05XFIrO722n6LO/GGdRC95YKa6UvcD+bB9LmD0Gu?=
 =?us-ascii?Q?UFx5GsNgtWP0XrSc3hoX0iS/YaBvluslb6iTyYGf3soiREXjiX27GPJGh2wc?=
 =?us-ascii?Q?QGJExvC2pQm7/E9ldlhLlQhimVcMu1p0F+xCP7wKn7gwvgggeY5GiKvOSmFA?=
 =?us-ascii?Q?y5/SWex1IzS3EsbYT/uLSu2EigOgr/SktXEqM397Q1CKhH82PC8qBZz3Q47X?=
 =?us-ascii?Q?uiV3walqqRcad8FWSX8qRCmqF0AefwqIRUgO0s95sR+KSuC1vqGk1Wjmbn1A?=
 =?us-ascii?Q?1MmX9PglaXwddN0OJ6f7p+YPGjaqayd57qxUkyVThe9PAmrH5KK0Q7/EiaYq?=
 =?us-ascii?Q?lzMWvjhwUNRuO884a50KdCIbR6SJtJ2N21c9RWixVUtVe4M4U9100/Chd3HX?=
 =?us-ascii?Q?x6IKMdHStrK09fx8RlYrmMa6hkhiXhnWitB+Bz11+ef1InnalytTOJNJQ1OC?=
 =?us-ascii?Q?Vip2e8LRNEoUpgXysuqtIkI57eZylHXRD3uhGDcfXRGKUmysvanyDnjGbHjM?=
 =?us-ascii?Q?9oxfJiZBfiA08gVE1NyB8aR6XgUjG2Ac9ZcJekwccDE7j7oqfTHzrJbER+ZH?=
 =?us-ascii?Q?pwwpfNqGYe5jD3fRJrMPzO3VrtGq92+9+XxQUuvcG36j2C84hiEuzKncGyk9?=
 =?us-ascii?Q?awJS4lPTSS660vYcdfugh/YD3yCW8jvDTv3ts7dAeapkQxBIoGQuRjOUcny0?=
 =?us-ascii?Q?NQeSGPyg/BZyv6cBEkGc0PP6O91sAznaLNr0lB/v?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 881aee4e-dce1-415d-0cd9-08db341234e3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 07:08:20.6417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nlqlquclEqx7tDmfEMdy5fp7zVPHUUGIfYLNX47rB6wW30Jq7ONnhgLx4ypfxjHqTP8n+nVDe/quKF3xipvZEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8459
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
index 0259a75ddf35..ca1f75eb3197 100644
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

