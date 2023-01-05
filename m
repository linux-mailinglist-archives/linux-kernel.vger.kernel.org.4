Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D507765EE89
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 15:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbjAEONf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 09:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbjAEOMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 09:12:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15B81A828;
        Thu,  5 Jan 2023 06:12:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17A41B81AE8;
        Thu,  5 Jan 2023 14:12:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9DBC433D2;
        Thu,  5 Jan 2023 14:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672927957;
        bh=ocATKMmPSE/H0CNy95RCV7iKXDdQZcxiCMwmjV3ux+U=;
        h=From:To:Cc:Subject:Date:From;
        b=F3aG8Herl/gKaJbVfJYJHf9ZytlMD8vIqAY0/mKfg8aomW1L/GwUPuODiIdnzO4vk
         X94wVumozfSxsbRU87Ybq75S6D5KBTcims1Onn0CZoNz7WOjCk7dsGwBi4KgRT0OmK
         gZaP7j7FxqU7P96qqPN/BYARI90fPBHy0Ct1vAokWVgDxTtMj4yCN1tXalAma9UzzF
         JJK/QkMeIhLeZ3LZj85ttL4l/YPxanQuLm/zI/fDAQn2mTV6mHyVyy1Go//Q/Bw7iM
         f3E9V6mXMT6fgBfxO7wiEPUsBadw+koRqoTa804o0zUIUbUAzEMETq5DuuxX0eQURH
         nEILQKM6n3oGw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Chanwoo Choi <cwchoi00@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: samsung: remove s3c24xx specific pll bits
Date:   Thu,  5 Jan 2023 15:12:13 +0100
Message-Id: <20230105141231.2006353-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

With the s3c24xx clk driver gone, the portions of the pll driver
for it can also be removed.

Suggested-by: Chanwoo Choi <cwchoi00@gmail.com>
Cc: Chanwoo Choi <cwchoi00@gmail.com>
Link: https://lore.kernel.org/linux-arm-kernel/0e0eff12-d8ea-72e9-d135-4259dda9a750@gmail.com/
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I'm trying to get the boardfile removal patches into shape for
6.3, and came across the comment from Chanwoo Choi that I had
not addressed yet. I've added this patch to my s3c24xx series now,
to be merged through the soc tree unless there are objections.

 drivers/clk/samsung/clk-pll.c | 181 ----------------------------------
 drivers/clk/samsung/clk-pll.h |  21 ----
 2 files changed, 202 deletions(-)

diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index 0ff28938943f..df7812371d70 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -940,169 +940,6 @@ static const struct clk_ops samsung_pll6553_clk_ops = {
 	.recalc_rate = samsung_pll6553_recalc_rate,
 };
 
-/*
- * PLL Clock Type of S3C24XX before S3C2443
- */
-
-#define PLLS3C2410_MDIV_MASK		(0xff)
-#define PLLS3C2410_PDIV_MASK		(0x1f)
-#define PLLS3C2410_SDIV_MASK		(0x3)
-#define PLLS3C2410_MDIV_SHIFT		(12)
-#define PLLS3C2410_PDIV_SHIFT		(4)
-#define PLLS3C2410_SDIV_SHIFT		(0)
-
-#define PLLS3C2410_ENABLE_REG_OFFSET	0x10
-
-static unsigned long samsung_s3c2410_pll_recalc_rate(struct clk_hw *hw,
-					unsigned long parent_rate)
-{
-	struct samsung_clk_pll *pll = to_clk_pll(hw);
-	u32 pll_con, mdiv, pdiv, sdiv;
-	u64 fvco = parent_rate;
-
-	pll_con = readl_relaxed(pll->con_reg);
-	mdiv = (pll_con >> PLLS3C2410_MDIV_SHIFT) & PLLS3C2410_MDIV_MASK;
-	pdiv = (pll_con >> PLLS3C2410_PDIV_SHIFT) & PLLS3C2410_PDIV_MASK;
-	sdiv = (pll_con >> PLLS3C2410_SDIV_SHIFT) & PLLS3C2410_SDIV_MASK;
-
-	fvco *= (mdiv + 8);
-	do_div(fvco, (pdiv + 2) << sdiv);
-
-	return (unsigned int)fvco;
-}
-
-static unsigned long samsung_s3c2440_mpll_recalc_rate(struct clk_hw *hw,
-					unsigned long parent_rate)
-{
-	struct samsung_clk_pll *pll = to_clk_pll(hw);
-	u32 pll_con, mdiv, pdiv, sdiv;
-	u64 fvco = parent_rate;
-
-	pll_con = readl_relaxed(pll->con_reg);
-	mdiv = (pll_con >> PLLS3C2410_MDIV_SHIFT) & PLLS3C2410_MDIV_MASK;
-	pdiv = (pll_con >> PLLS3C2410_PDIV_SHIFT) & PLLS3C2410_PDIV_MASK;
-	sdiv = (pll_con >> PLLS3C2410_SDIV_SHIFT) & PLLS3C2410_SDIV_MASK;
-
-	fvco *= (2 * (mdiv + 8));
-	do_div(fvco, (pdiv + 2) << sdiv);
-
-	return (unsigned int)fvco;
-}
-
-static int samsung_s3c2410_pll_set_rate(struct clk_hw *hw, unsigned long drate,
-					unsigned long prate)
-{
-	struct samsung_clk_pll *pll = to_clk_pll(hw);
-	const struct samsung_pll_rate_table *rate;
-	u32 tmp;
-
-	/* Get required rate settings from table */
-	rate = samsung_get_pll_settings(pll, drate);
-	if (!rate) {
-		pr_err("%s: Invalid rate : %lu for pll clk %s\n", __func__,
-			drate, clk_hw_get_name(hw));
-		return -EINVAL;
-	}
-
-	tmp = readl_relaxed(pll->con_reg);
-
-	/* Change PLL PMS values */
-	tmp &= ~((PLLS3C2410_MDIV_MASK << PLLS3C2410_MDIV_SHIFT) |
-			(PLLS3C2410_PDIV_MASK << PLLS3C2410_PDIV_SHIFT) |
-			(PLLS3C2410_SDIV_MASK << PLLS3C2410_SDIV_SHIFT));
-	tmp |= (rate->mdiv << PLLS3C2410_MDIV_SHIFT) |
-			(rate->pdiv << PLLS3C2410_PDIV_SHIFT) |
-			(rate->sdiv << PLLS3C2410_SDIV_SHIFT);
-	writel_relaxed(tmp, pll->con_reg);
-
-	/* Time to settle according to the manual */
-	udelay(300);
-
-	return 0;
-}
-
-static int samsung_s3c2410_pll_enable(struct clk_hw *hw, int bit, bool enable)
-{
-	struct samsung_clk_pll *pll = to_clk_pll(hw);
-	u32 pll_en = readl_relaxed(pll->lock_reg + PLLS3C2410_ENABLE_REG_OFFSET);
-	u32 pll_en_orig = pll_en;
-
-	if (enable)
-		pll_en &= ~BIT(bit);
-	else
-		pll_en |= BIT(bit);
-
-	writel_relaxed(pll_en, pll->lock_reg + PLLS3C2410_ENABLE_REG_OFFSET);
-
-	/* if we started the UPLL, then allow to settle */
-	if (enable && (pll_en_orig & BIT(bit)))
-		udelay(300);
-
-	return 0;
-}
-
-static int samsung_s3c2410_mpll_enable(struct clk_hw *hw)
-{
-	return samsung_s3c2410_pll_enable(hw, 5, true);
-}
-
-static void samsung_s3c2410_mpll_disable(struct clk_hw *hw)
-{
-	samsung_s3c2410_pll_enable(hw, 5, false);
-}
-
-static int samsung_s3c2410_upll_enable(struct clk_hw *hw)
-{
-	return samsung_s3c2410_pll_enable(hw, 7, true);
-}
-
-static void samsung_s3c2410_upll_disable(struct clk_hw *hw)
-{
-	samsung_s3c2410_pll_enable(hw, 7, false);
-}
-
-static const struct clk_ops samsung_s3c2410_mpll_clk_min_ops = {
-	.recalc_rate = samsung_s3c2410_pll_recalc_rate,
-	.enable = samsung_s3c2410_mpll_enable,
-	.disable = samsung_s3c2410_mpll_disable,
-};
-
-static const struct clk_ops samsung_s3c2410_upll_clk_min_ops = {
-	.recalc_rate = samsung_s3c2410_pll_recalc_rate,
-	.enable = samsung_s3c2410_upll_enable,
-	.disable = samsung_s3c2410_upll_disable,
-};
-
-static const struct clk_ops samsung_s3c2440_mpll_clk_min_ops = {
-	.recalc_rate = samsung_s3c2440_mpll_recalc_rate,
-	.enable = samsung_s3c2410_mpll_enable,
-	.disable = samsung_s3c2410_mpll_disable,
-};
-
-static const struct clk_ops samsung_s3c2410_mpll_clk_ops = {
-	.recalc_rate = samsung_s3c2410_pll_recalc_rate,
-	.enable = samsung_s3c2410_mpll_enable,
-	.disable = samsung_s3c2410_mpll_disable,
-	.round_rate = samsung_pll_round_rate,
-	.set_rate = samsung_s3c2410_pll_set_rate,
-};
-
-static const struct clk_ops samsung_s3c2410_upll_clk_ops = {
-	.recalc_rate = samsung_s3c2410_pll_recalc_rate,
-	.enable = samsung_s3c2410_upll_enable,
-	.disable = samsung_s3c2410_upll_disable,
-	.round_rate = samsung_pll_round_rate,
-	.set_rate = samsung_s3c2410_pll_set_rate,
-};
-
-static const struct clk_ops samsung_s3c2440_mpll_clk_ops = {
-	.recalc_rate = samsung_s3c2440_mpll_recalc_rate,
-	.enable = samsung_s3c2410_mpll_enable,
-	.disable = samsung_s3c2410_mpll_disable,
-	.round_rate = samsung_pll_round_rate,
-	.set_rate = samsung_s3c2410_pll_set_rate,
-};
-
 /*
  * PLL2550x Clock Type
  */
@@ -1530,24 +1367,6 @@ static void __init _samsung_clk_register_pll(struct samsung_clk_provider *ctx,
 		else
 			init.ops = &samsung_pll46xx_clk_ops;
 		break;
-	case pll_s3c2410_mpll:
-		if (!pll->rate_table)
-			init.ops = &samsung_s3c2410_mpll_clk_min_ops;
-		else
-			init.ops = &samsung_s3c2410_mpll_clk_ops;
-		break;
-	case pll_s3c2410_upll:
-		if (!pll->rate_table)
-			init.ops = &samsung_s3c2410_upll_clk_min_ops;
-		else
-			init.ops = &samsung_s3c2410_upll_clk_ops;
-		break;
-	case pll_s3c2440_mpll:
-		if (!pll->rate_table)
-			init.ops = &samsung_s3c2440_mpll_clk_min_ops;
-		else
-			init.ops = &samsung_s3c2440_mpll_clk_ops;
-		break;
 	case pll_2550x:
 		init.ops = &samsung_pll2550x_clk_ops;
 		break;
diff --git a/drivers/clk/samsung/clk-pll.h b/drivers/clk/samsung/clk-pll.h
index a9892c2d1f57..5d5a58d40e7e 100644
--- a/drivers/clk/samsung/clk-pll.h
+++ b/drivers/clk/samsung/clk-pll.h
@@ -25,9 +25,6 @@ enum samsung_pll_type {
 	pll_6552,
 	pll_6552_s3c2416,
 	pll_6553,
-	pll_s3c2410_mpll,
-	pll_s3c2410_upll,
-	pll_s3c2440_mpll,
 	pll_2550x,
 	pll_2550xx,
 	pll_2650x,
@@ -56,24 +53,6 @@ enum samsung_pll_type {
 		.sdiv	=	(_s),				\
 	}
 
-#define PLL_S3C2410_MPLL_RATE(_fin, _rate, _m, _p, _s)		\
-	{							\
-		.rate	=	PLL_VALID_RATE(_fin, _rate,	\
-				_m + 8, _p + 2, _s, 0, 16),	\
-		.mdiv	=	(_m),				\
-		.pdiv	=	(_p),				\
-		.sdiv	=	(_s),				\
-	}
-
-#define PLL_S3C2440_MPLL_RATE(_fin, _rate, _m, _p, _s)		\
-	{							\
-		.rate	=	PLL_VALID_RATE(_fin, _rate,	\
-				2 * (_m + 8), _p + 2, _s, 0, 16), \
-		.mdiv	=	(_m),				\
-		.pdiv	=	(_p),				\
-		.sdiv	=	(_s),				\
-	}
-
 #define PLL_36XX_RATE(_fin, _rate, _m, _p, _s, _k)		\
 	{							\
 		.rate	=	PLL_VALID_RATE(_fin, _rate,	\
-- 
2.39.0

