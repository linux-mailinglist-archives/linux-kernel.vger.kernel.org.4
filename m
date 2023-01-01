Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5213965AAE3
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 18:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjAAR6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 12:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjAAR56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 12:57:58 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256A02DD3
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 09:57:57 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id tz12so62244036ejc.9
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jan 2023 09:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrbxkXpog4qNAkw1QjCrHsgv8afYOfm6Gannx3KUosE=;
        b=O4SyjwrRvTGNhGi/26VzFtQlejkjvEFRVkGcgVAx0pzwBKSZBcrGvgJUFB+8/cLG5g
         c7e5zF3BqrdPJ1WoGcVfvNxIzgpWs1Jv4fppWTFXaSaDcbacGF0Bdby/ffkF6urK09Xw
         dbzvsTgjQJBf8XnbC43iScCWJ1FeGh//0A9i8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zrbxkXpog4qNAkw1QjCrHsgv8afYOfm6Gannx3KUosE=;
        b=6jzsuEVsYK2rWH2mHffmwxMXG11v/IarFjsqJbvS20wsiA+UPBhmdQf+vlt5GnxaOS
         A7kresMZz2e0NIaFETGEAGtU1Yke7U6IC/abHuzI0wO4PCW18abM/pOR9N54mhQ0XaDX
         IRBpU3BbmgEkBo8Sd8xYmT2G/XGS74Ts4mlFKQl232Vy7NLeGqfG4ZXlPEk+xDGTmUiD
         Lm9NM76ISxtHjqsaDs1DT1xhVHK5IwJIWeA/5pInNnAOONqfQ54wNj36rJVDre32kla9
         lr817ISFMd6uD7sFAmZKmuCEBt54L2TSU2KqsYgZBK+7G3hsKfBdy1YoMlFJ+18o8dTY
         vbPg==
X-Gm-Message-State: AFqh2kp55OzwObx4Wrsf5AFcJYhNEwAjOTF1YmG8rW507Ca+3vFmtMB9
        alk3fgeWC8EC66s75FVOzw13bjMALZ7IY17v7gc=
X-Google-Smtp-Source: AMrXdXsXz1sqX6iORHHMyTPY53+HKSrdLpd6AhjJwY50Z/7hHpCpuBRgh967J3ihvI6yTi+qQPCJuw==
X-Received: by 2002:a17:907:3e96:b0:7c4:f501:e5b1 with SMTP id hs22-20020a1709073e9600b007c4f501e5b1mr44824314ejc.51.1672595875491;
        Sun, 01 Jan 2023 09:57:55 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-180-23-57.retail.telecomitalia.it. [80.180.23.57])
        by smtp.gmail.com with ESMTPSA id q2-20020a1709063d4200b0082ddfb47d06sm12273018ejf.148.2023.01.01.09.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 09:57:55 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     angelo@amarulasolutions.com, michael@amarulasolutions.com,
        tommaso.merciai@amarulasolutions.com,
        Chen-Yu Tsai <wenst@chromium.org>,
        linux-amarula@amarulasolutions.com, anthony@amarulasolutions.com,
        jagan@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [RFC PATCH v2 06/11] clk: imx: pll14xx: add device tree support
Date:   Sun,  1 Jan 2023 18:57:35 +0100
Message-Id: <20230101175740.1010258-7-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230101175740.1010258-1-dario.binacchi@amarulasolutions.com>
References: <20230101175740.1010258-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch, backwards compatible, extends the driver to initialize the
clock directly from the device tree.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/clk/imx/clk-pll14xx.c | 220 +++++++++++++++++++++++++++-------
 1 file changed, 176 insertions(+), 44 deletions(-)

diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
index 828336873a98..6503005b885a 100644
--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -12,6 +12,10 @@
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/jiffies.h>
 
@@ -36,7 +40,9 @@
 
 struct clk_pll14xx {
 	struct clk_hw			hw;
-	void __iomem			*base;
+	struct imx_clk_reg		gnrl_ctl;
+	struct imx_clk_reg		div_ctl0;
+	struct imx_clk_reg		div_ctl1;
 	enum imx_pll14xx_type		type;
 	const struct imx_pll14xx_rate_table *rate_table;
 	int rate_count;
@@ -90,6 +96,30 @@ struct imx_pll14xx_clk imx_1416x_pll = {
 };
 EXPORT_SYMBOL_GPL(imx_1416x_pll);
 
+static void imx_pll14xx_writel(u32 val, const struct imx_clk_reg *reg)
+{
+	if (reg->base)
+		writel_relaxed(val, reg->base + reg->offset);
+	else if (reg->regmap)
+		regmap_write(reg->regmap, reg->offset, val);
+	else
+		pr_err("%s: memory address not set\n", __func__);
+}
+
+static u32 imx_pll14xx_readl(const struct imx_clk_reg *reg)
+{
+	u32 val = 0;
+
+	if (reg->base)
+		val = readl_relaxed(reg->base + reg->offset);
+	else if (reg->regmap)
+		regmap_read(reg->regmap, reg->offset, &val);
+	else
+		pr_err("%s: memory address not set\n", __func__);
+
+	return val;
+}
+
 static const struct imx_pll14xx_rate_table *imx_get_pll_settings(
 		struct clk_pll14xx *pll, unsigned long rate)
 {
@@ -161,11 +191,11 @@ static void imx_pll14xx_calc_settings(struct clk_pll14xx *pll, unsigned long rat
 		return;
 	}
 
-	pll_div_ctl0 = readl_relaxed(pll->base + DIV_CTL0);
+	pll_div_ctl0 = imx_pll14xx_readl(&pll->div_ctl0);
 	mdiv = FIELD_GET(MDIV_MASK, pll_div_ctl0);
 	pdiv = FIELD_GET(PDIV_MASK, pll_div_ctl0);
 	sdiv = FIELD_GET(SDIV_MASK, pll_div_ctl0);
-	pll_div_ctl1 = readl_relaxed(pll->base + DIV_CTL1);
+	pll_div_ctl1 = imx_pll14xx_readl(&pll->div_ctl1);
 
 	/* Then see if we can get the desired rate by only adjusting kdiv (glitch free) */
 	rate_min = pll14xx_calc_rate(pll, mdiv, pdiv, sdiv, KDIV_MIN, prate);
@@ -249,13 +279,13 @@ static unsigned long clk_pll14xx_recalc_rate(struct clk_hw *hw,
 	struct clk_pll14xx *pll = to_clk_pll14xx(hw);
 	u32 mdiv, pdiv, sdiv, kdiv, pll_div_ctl0, pll_div_ctl1;
 
-	pll_div_ctl0 = readl_relaxed(pll->base + DIV_CTL0);
+	pll_div_ctl0 = imx_pll14xx_readl(&pll->div_ctl0);
 	mdiv = FIELD_GET(MDIV_MASK, pll_div_ctl0);
 	pdiv = FIELD_GET(PDIV_MASK, pll_div_ctl0);
 	sdiv = FIELD_GET(SDIV_MASK, pll_div_ctl0);
 
 	if (pll->type == PLL_1443X) {
-		pll_div_ctl1 = readl_relaxed(pll->base + DIV_CTL1);
+		pll_div_ctl1 = imx_pll14xx_readl(&pll->div_ctl1);
 		kdiv = FIELD_GET(KDIV_MASK, pll_div_ctl1);
 	} else {
 		kdiv = 0;
@@ -277,10 +307,22 @@ static inline bool clk_pll14xx_mp_change(const struct imx_pll14xx_rate_table *ra
 
 static int clk_pll14xx_wait_lock(struct clk_pll14xx *pll)
 {
+	struct imx_clk_reg *reg = &pll->gnrl_ctl;
 	u32 val;
 
-	return readl_poll_timeout(pll->base + GNRL_CTL, val, val & LOCK_STATUS, 0,
-			LOCK_TIMEOUT_US);
+	if (reg->base)
+		return readl_poll_timeout(reg->base + reg->offset, val,
+					  val & LOCK_STATUS, 0,
+					  LOCK_TIMEOUT_US);
+
+	if (reg->regmap)
+		return regmap_read_poll_timeout(reg->regmap, reg->offset, val,
+						val & LOCK_STATUS, 0,
+						LOCK_TIMEOUT_US);
+
+	pr_err("%s: memory address not set\n", __func__);
+
+	return -EIO;
 }
 
 static int clk_pll1416x_set_rate(struct clk_hw *hw, unsigned long drate,
@@ -298,32 +340,32 @@ static int clk_pll1416x_set_rate(struct clk_hw *hw, unsigned long drate,
 		return -EINVAL;
 	}
 
-	tmp = readl_relaxed(pll->base + DIV_CTL0);
+	tmp = imx_pll14xx_readl(&pll->div_ctl0);
 
 	if (!clk_pll14xx_mp_change(rate, tmp)) {
 		tmp &= ~SDIV_MASK;
 		tmp |= FIELD_PREP(SDIV_MASK, rate->sdiv);
-		writel_relaxed(tmp, pll->base + DIV_CTL0);
+		imx_pll14xx_writel(tmp, &pll->div_ctl0);
 
 		return 0;
 	}
 
 	/* Bypass clock and set lock to pll output lock */
-	tmp = readl_relaxed(pll->base + GNRL_CTL);
+	tmp = imx_pll14xx_readl(&pll->gnrl_ctl);
 	tmp |= LOCK_SEL_MASK;
-	writel_relaxed(tmp, pll->base + GNRL_CTL);
+	imx_pll14xx_writel(tmp, &pll->gnrl_ctl);
 
 	/* Enable RST */
 	tmp &= ~RST_MASK;
-	writel_relaxed(tmp, pll->base + GNRL_CTL);
+	imx_pll14xx_writel(tmp, &pll->gnrl_ctl);
 
 	/* Enable BYPASS */
 	tmp |= BYPASS_MASK;
-	writel(tmp, pll->base + GNRL_CTL);
+	imx_pll14xx_writel(tmp, &pll->gnrl_ctl);
 
 	div_val = FIELD_PREP(MDIV_MASK, rate->mdiv) | FIELD_PREP(PDIV_MASK, rate->pdiv) |
 		FIELD_PREP(SDIV_MASK, rate->sdiv);
-	writel_relaxed(div_val, pll->base + DIV_CTL0);
+	imx_pll14xx_writel(div_val, &pll->div_ctl0);
 
 	/*
 	 * According to SPEC, t3 - t2 need to be greater than
@@ -335,7 +377,7 @@ static int clk_pll1416x_set_rate(struct clk_hw *hw, unsigned long drate,
 
 	/* Disable RST */
 	tmp |= RST_MASK;
-	writel_relaxed(tmp, pll->base + GNRL_CTL);
+	imx_pll14xx_writel(tmp, &pll->gnrl_ctl);
 
 	/* Wait Lock */
 	ret = clk_pll14xx_wait_lock(pll);
@@ -344,7 +386,7 @@ static int clk_pll1416x_set_rate(struct clk_hw *hw, unsigned long drate,
 
 	/* Bypass */
 	tmp &= ~BYPASS_MASK;
-	writel_relaxed(tmp, pll->base + GNRL_CTL);
+	imx_pll14xx_writel(tmp, &pll->gnrl_ctl);
 
 	return 0;
 }
@@ -359,35 +401,35 @@ static int clk_pll1443x_set_rate(struct clk_hw *hw, unsigned long drate,
 
 	imx_pll14xx_calc_settings(pll, drate, prate, &rate);
 
-	div_ctl0 = readl_relaxed(pll->base + DIV_CTL0);
+	div_ctl0 = imx_pll14xx_readl(&pll->div_ctl0);
 
 	if (!clk_pll14xx_mp_change(&rate, div_ctl0)) {
 		/* only sdiv and/or kdiv changed - no need to RESET PLL */
 		div_ctl0 &= ~SDIV_MASK;
 		div_ctl0 |= FIELD_PREP(SDIV_MASK, rate.sdiv);
-		writel_relaxed(div_ctl0, pll->base + DIV_CTL0);
+		imx_pll14xx_writel(div_ctl0, &pll->div_ctl0);
 
-		writel_relaxed(FIELD_PREP(KDIV_MASK, rate.kdiv),
-			       pll->base + DIV_CTL1);
+		imx_pll14xx_writel(FIELD_PREP(KDIV_MASK, rate.kdiv),
+				   &pll->div_ctl1);
 
 		return 0;
 	}
 
 	/* Enable RST */
-	gnrl_ctl = readl_relaxed(pll->base + GNRL_CTL);
+	gnrl_ctl = imx_pll14xx_readl(&pll->gnrl_ctl);
 	gnrl_ctl &= ~RST_MASK;
-	writel_relaxed(gnrl_ctl, pll->base + GNRL_CTL);
+	imx_pll14xx_writel(gnrl_ctl, &pll->gnrl_ctl);
 
 	/* Enable BYPASS */
 	gnrl_ctl |= BYPASS_MASK;
-	writel_relaxed(gnrl_ctl, pll->base + GNRL_CTL);
+	imx_pll14xx_writel(gnrl_ctl, &pll->gnrl_ctl);
 
 	div_ctl0 = FIELD_PREP(MDIV_MASK, rate.mdiv) |
 		   FIELD_PREP(PDIV_MASK, rate.pdiv) |
 		   FIELD_PREP(SDIV_MASK, rate.sdiv);
-	writel_relaxed(div_ctl0, pll->base + DIV_CTL0);
+	imx_pll14xx_writel(div_ctl0, &pll->div_ctl0);
 
-	writel_relaxed(FIELD_PREP(KDIV_MASK, rate.kdiv), pll->base + DIV_CTL1);
+	imx_pll14xx_writel(FIELD_PREP(KDIV_MASK, rate.kdiv), &pll->div_ctl1);
 
 	/*
 	 * According to SPEC, t3 - t2 need to be greater than
@@ -399,7 +441,7 @@ static int clk_pll1443x_set_rate(struct clk_hw *hw, unsigned long drate,
 
 	/* Disable RST */
 	gnrl_ctl |= RST_MASK;
-	writel_relaxed(gnrl_ctl, pll->base + GNRL_CTL);
+	imx_pll14xx_writel(gnrl_ctl, &pll->gnrl_ctl);
 
 	/* Wait Lock*/
 	ret = clk_pll14xx_wait_lock(pll);
@@ -408,7 +450,7 @@ static int clk_pll1443x_set_rate(struct clk_hw *hw, unsigned long drate,
 
 	/* Bypass */
 	gnrl_ctl &= ~BYPASS_MASK;
-	writel_relaxed(gnrl_ctl, pll->base + GNRL_CTL);
+	imx_pll14xx_writel(gnrl_ctl, &pll->gnrl_ctl);
 
 	return 0;
 }
@@ -423,20 +465,20 @@ static int clk_pll14xx_prepare(struct clk_hw *hw)
 	 * RESETB = 1 from 0, PLL starts its normal
 	 * operation after lock time
 	 */
-	val = readl_relaxed(pll->base + GNRL_CTL);
+	val = imx_pll14xx_readl(&pll->gnrl_ctl);
 	if (val & RST_MASK)
 		return 0;
 	val |= BYPASS_MASK;
-	writel_relaxed(val, pll->base + GNRL_CTL);
+	imx_pll14xx_writel(val, &pll->gnrl_ctl);
 	val |= RST_MASK;
-	writel_relaxed(val, pll->base + GNRL_CTL);
+	imx_pll14xx_writel(val, &pll->gnrl_ctl);
 
 	ret = clk_pll14xx_wait_lock(pll);
 	if (ret)
 		return ret;
 
 	val &= ~BYPASS_MASK;
-	writel_relaxed(val, pll->base + GNRL_CTL);
+	imx_pll14xx_writel(val, &pll->gnrl_ctl);
 
 	return 0;
 }
@@ -446,7 +488,7 @@ static int clk_pll14xx_is_prepared(struct clk_hw *hw)
 	struct clk_pll14xx *pll = to_clk_pll14xx(hw);
 	u32 val;
 
-	val = readl_relaxed(pll->base + GNRL_CTL);
+	val = imx_pll14xx_readl(&pll->gnrl_ctl);
 
 	return (val & RST_MASK) ? 1 : 0;
 }
@@ -460,9 +502,9 @@ static void clk_pll14xx_unprepare(struct clk_hw *hw)
 	 * Set RST to 0, power down mode is enabled and
 	 * every digital block is reset
 	 */
-	val = readl_relaxed(pll->base + GNRL_CTL);
+	val = imx_pll14xx_readl(&pll->gnrl_ctl);
 	val &= ~RST_MASK;
-	writel_relaxed(val, pll->base + GNRL_CTL);
+	imx_pll14xx_writel(val, &pll->gnrl_ctl);
 }
 
 static const struct clk_ops clk_pll1416x_ops = {
@@ -487,13 +529,24 @@ static const struct clk_ops clk_pll1443x_ops = {
 	.set_rate	= clk_pll1443x_set_rate,
 };
 
-struct clk_hw *imx_dev_clk_hw_pll14xx(struct device *dev, const char *name,
-				const char *parent_name, void __iomem *base,
-				const struct imx_pll14xx_clk *pll_clk)
+static void imx_clk_hw_unregister_pll14xx(struct clk_hw *hw)
 {
+	struct clk_pll14xx *pll = to_clk_pll14xx(hw);
+
+	clk_hw_unregister(hw);
+	kfree(pll);
+}
+
+static struct clk_hw *
+imx_clk_hw_register_pll14xx(struct device_node *node, const char *name,
+			    const char *parent_name,
+			    struct imx_clk_reg *iomap,
+			    const struct imx_pll14xx_clk *pll_clk)
+{
+	struct clk_parent_data pdata = { .index = 0 };
+	struct clk_init_data init = { NULL };
 	struct clk_pll14xx *pll;
 	struct clk_hw *hw;
-	struct clk_init_data init;
 	int ret;
 	u32 val;
 
@@ -503,7 +556,8 @@ struct clk_hw *imx_dev_clk_hw_pll14xx(struct device *dev, const char *name,
 
 	init.name = name;
 	init.flags = pll_clk->flags;
-	init.parent_names = &parent_name;
+	init.parent_names = parent_name ? &parent_name : NULL;
+	init.parent_data = &pdata;
 	init.num_parents = 1;
 
 	switch (pll_clk->type) {
@@ -522,19 +576,24 @@ struct clk_hw *imx_dev_clk_hw_pll14xx(struct device *dev, const char *name,
 		return ERR_PTR(-EINVAL);
 	}
 
-	pll->base = base;
+	memcpy(&pll->gnrl_ctl, iomap, sizeof(*iomap));
+	pll->gnrl_ctl.offset += GNRL_CTL;
+	memcpy(&pll->div_ctl0, iomap, sizeof(*iomap));
+	pll->div_ctl0.offset += DIV_CTL0;
+	memcpy(&pll->div_ctl1, iomap, sizeof(*iomap));
+	pll->div_ctl1.offset += DIV_CTL1;
+
 	pll->hw.init = &init;
 	pll->type = pll_clk->type;
 	pll->rate_table = pll_clk->rate_table;
 	pll->rate_count = pll_clk->rate_count;
 
-	val = readl_relaxed(pll->base + GNRL_CTL);
+	val = imx_pll14xx_readl(&pll->gnrl_ctl);
 	val &= ~BYPASS_MASK;
-	writel_relaxed(val, pll->base + GNRL_CTL);
+	imx_pll14xx_writel(val, &pll->gnrl_ctl);
 
 	hw = &pll->hw;
-
-	ret = clk_hw_register(dev, hw);
+	ret = of_clk_hw_register(node, hw);
 	if (ret) {
 		pr_err("failed to register pll %s %d\n", name, ret);
 		kfree(pll);
@@ -543,4 +602,77 @@ struct clk_hw *imx_dev_clk_hw_pll14xx(struct device *dev, const char *name,
 
 	return hw;
 }
+
+struct clk_hw *imx_dev_clk_hw_pll14xx(struct device *dev, const char *name,
+				const char *parent_name, void __iomem *base,
+				const struct imx_pll14xx_clk *pll_clk)
+{
+	struct imx_clk_reg iomap = {};
+
+	iomap.base = base;
+	return imx_clk_hw_register_pll14xx(dev_of_node(dev), name, parent_name,
+					   &iomap, pll_clk);
+}
 EXPORT_SYMBOL_GPL(imx_dev_clk_hw_pll14xx);
+
+/**
+ * of_imx_pll14xx_clk_setup() - Setup function for imx pll14xx clock
+ * @node:	device node for the clock
+ */
+static void __init of_imx_pll14xx_clk_setup(struct device_node *node)
+{
+	struct clk_hw *hw;
+	struct imx_clk_reg iomap = {};
+	const char *name = node->name;
+	const struct imx_pll14xx_clk *pll_clk;
+	const char *pll_type;
+	u32 val;
+
+	iomap.regmap = syscon_regmap_lookup_by_phandle(node, "fsl,anatop");
+	if (IS_ERR(iomap.regmap)) {
+		pr_err("missing regmap for %pOFn\n", node);
+		return;
+	}
+
+	if (of_property_read_u32_index(node, "fsl,anatop", 1, &val)) {
+		pr_err("missing register offset for %pOFn\n", node);
+		return;
+	}
+
+	iomap.offset = val;
+	if (of_clk_get_parent_count(node) != 1) {
+		pr_err("%pOFn must have 1 parent clock\n", node);
+		return;
+	}
+
+	of_property_read_string(node, "clock-output-names", &name);
+	if (of_property_read_string(node, "fsl,type", &pll_type)) {
+		pr_err("missing 'fsl,type' for %pOFn\n", node);
+		return;
+	}
+
+	if (!strcmp(pll_type, "1443x")) {
+		if (of_property_read_bool(node, "fsl,get-rate-nocache"))
+			pll_clk = &imx_1443x_dram_pll;
+		else
+			pll_clk = &imx_1443x_pll;
+	} else if (!strcmp(pll_type, "1416x")) {
+		pll_clk = &imx_1416x_pll;
+	} else {
+		pr_err("failed to get pll clock for %pOFn\n", node);
+		return;
+	}
+
+	hw = imx_clk_hw_register_pll14xx(node, name, NULL, &iomap, pll_clk);
+	if (IS_ERR(hw))
+		return;
+
+	if (of_clk_add_hw_provider(node, of_clk_hw_simple_get, hw)) {
+		imx_clk_hw_unregister_pll14xx(hw);
+		return;
+	}
+
+	pr_debug("name: %s, offset: 0x%x, pll_type: %s\n", name, iomap.offset,
+		 pll_type);
+}
+CLK_OF_DECLARE(fsl_pll14xx_clk, "fsl,pll14xx-clock", of_imx_pll14xx_clk_setup);
-- 
2.32.0

