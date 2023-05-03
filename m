Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717956F5884
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 15:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjECNCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 09:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjECNCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 09:02:08 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3615598;
        Wed,  3 May 2023 06:02:06 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50b8d2eed3dso7032850a12.0;
        Wed, 03 May 2023 06:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683118925; x=1685710925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5l3X/5LryvYFHFoYM7ZoZSis1FJRQH3TBUtUCR1RoIw=;
        b=C9oigbNw++3UxAZ996YgdeW6OPwWtTmRLof1HURqz2YTaDfs768reIjTMvEVEuYABp
         DzOeyVzF2mR1EKeUllpy5Y9CCI4n6j8UkXyTm8R1DoEv5ATqA2BUOAlYZDQk0U28scKr
         ZBFxrjEXn3LYEqfjlvgBajWbW4Uol5ZeljavfZ3NqzB+yv1fL6BG14hjUBk03KE87tHc
         mkXJaY4wLo583EtTQiZABV0IsDaCV8WEnGPBekdiPDVu13il8yVEVJ8X9n9sCc3VGiMu
         0paIOzDY5HVguqSQnlS5pxws/5UIwnQHFsd28mvyNKR04nrFX7AeEVmJQmyZjiwuu4uW
         mJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683118925; x=1685710925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5l3X/5LryvYFHFoYM7ZoZSis1FJRQH3TBUtUCR1RoIw=;
        b=IfXeC4eMjS5dJ9j824SevH8NiYiKEly+t8broq3tp8dbnokFllmrnXoBU3vWLB3PnB
         ah+1wBmeE9ie5mlEgMyhjaqGkGPqmgEWkvTmAiVsWVoGzEfceJDEuODFmyLaG8DphsuS
         He/GX2pcZ8f0VypZ1UURIrbuwNbiNXozjX4cWYafj7lGV0PaNUBc3cjTmgtG0TV5jjeI
         xJFZ2+h22yI8R3O1HwyGkP+5JOOrF9q008ZxPLbzXe2q8EfpPXZoIlMkVqhzi+tIZbRO
         wjfJU/NT7e2yjpxyzuSq7SWWgkWlspJISrT7Yw0tkt49g1MYdh7ytc4kDSfJvo+r63Gw
         Iv0g==
X-Gm-Message-State: AC+VfDzogz31UYXj8/loUwPG8P2h/2kzwWgsF6M3E5EovgLRwBmYT4GD
        VOToGLtwZQk0INTSmA38LFk=
X-Google-Smtp-Source: ACHHUZ5OknE5OTyBTGKZb1lzAdQhiKHdxWR+M+MMc0367wgX2TEJ0mRMXUnVrb4obGf41yxGiwmbMw==
X-Received: by 2002:a17:907:2687:b0:94f:49a2:619a with SMTP id bn7-20020a170907268700b0094f49a2619amr2637597ejc.11.1683118924571;
        Wed, 03 May 2023 06:02:04 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.33])
        by smtp.gmail.com with ESMTPSA id my17-20020a1709065a5100b0095728081944sm16105578ejc.146.2023.05.03.06.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 06:02:04 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 3/3] clk: qcom: cbf-msm8996: Add support for MSM8996 Pro
Date:   Wed,  3 May 2023 16:00:52 +0300
Message-Id: <20230503130051.144708-4-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230503130051.144708-1-y.oudjana@protonmail.com>
References: <20230503130051.144708-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

The CBF PLL on MSM8996 Pro has a /4 post divisor instead of /2. Handle the
difference accordingly.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 drivers/clk/qcom/clk-cbf-8996.c | 121 ++++++++++++++++++++++++++++----
 1 file changed, 106 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/qcom/clk-cbf-8996.c b/drivers/clk/qcom/clk-cbf-8996.c
index 1bb2cd956d68..a3e96578ddd9 100644
--- a/drivers/clk/qcom/clk-cbf-8996.c
+++ b/drivers/clk/qcom/clk-cbf-8996.c
@@ -65,6 +65,19 @@ static const struct alpha_pll_config cbfpll_config = {
 	.early_output_mask = BIT(3),
 };
 
+static const struct alpha_pll_config cbfpll_pro_config = {
+	.l = 72,
+	.config_ctl_val = 0x200d4828,
+	.config_ctl_hi_val = 0x006,
+	.test_ctl_val = 0x1c000000,
+	.test_ctl_hi_val = 0x00004000,
+	.pre_div_mask = BIT(12),
+	.post_div_mask = 0x3 << 8,
+	.post_div_val = 0x3 << 8,
+	.main_output_mask = BIT(0),
+	.early_output_mask = BIT(3),
+};
+
 static struct clk_alpha_pll cbf_pll = {
 	.offset = CBF_PLL_OFFSET,
 	.regs = cbf_pll_regs,
@@ -93,6 +106,20 @@ static struct clk_fixed_factor cbf_pll_postdiv = {
 	},
 };
 
+static struct clk_fixed_factor cbf_pro_pll_postdiv = {
+	.mult = 1,
+	.div = 4,
+	.hw.init = &(struct clk_init_data){
+		.name = "cbf_pll_postdiv",
+		.parent_hws = (const struct clk_hw*[]){
+			&cbf_pll.clkr.hw
+		},
+		.num_parents = 1,
+		.ops = &clk_fixed_factor_ops,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
 static const struct clk_parent_data cbf_mux_parent_data[] = {
 	{ .index = DT_XO },
 	{ .hw = &cbf_pll.clkr.hw },
@@ -100,6 +127,13 @@ static const struct clk_parent_data cbf_mux_parent_data[] = {
 	{ .index = DT_APCS_AUX },
 };
 
+static const struct clk_parent_data cbf_pro_mux_parent_data[] = {
+	{ .index = DT_XO },
+	{ .hw = &cbf_pll.clkr.hw },
+	{ .hw = &cbf_pro_pll_postdiv.hw },
+	{ .index = DT_APCS_AUX },
+};
+
 struct clk_cbf_8996_mux {
 	u32 reg;
 	struct notifier_block nb;
@@ -140,12 +174,14 @@ static int clk_cbf_8996_mux_determine_rate(struct clk_hw *hw,
 					   struct clk_rate_request *req)
 {
 	struct clk_hw *parent;
+	struct clk_hw *post_div_hw = clk_hw_get_parent_by_index(hw, CBF_DIV_INDEX);
+	struct clk_fixed_factor *post_div = to_clk_fixed_factor(post_div_hw);
 
-	if (req->rate < (DIV_THRESHOLD / 2))
+	if (req->rate < (DIV_THRESHOLD / post_div->div))
 		return -EINVAL;
 
 	if (req->rate < DIV_THRESHOLD)
-		parent = clk_hw_get_parent_by_index(hw, CBF_DIV_INDEX);
+		parent = post_div_hw;
 	else
 		parent = clk_hw_get_parent_by_index(hw, CBF_PLL_INDEX);
 
@@ -177,10 +213,24 @@ static struct clk_cbf_8996_mux cbf_mux = {
 	},
 };
 
+static struct clk_cbf_8996_mux cbf_pro_mux = {
+	.reg = CBF_MUX_OFFSET,
+	.nb.notifier_call = cbf_clk_notifier_cb,
+	.clkr.hw.init = &(struct clk_init_data) {
+		.name = "cbf_mux",
+		.parent_data = cbf_pro_mux_parent_data,
+		.num_parents = ARRAY_SIZE(cbf_pro_mux_parent_data),
+		.ops = &clk_cbf_8996_mux_ops,
+		/* CPU clock is critical and should never be gated */
+		.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+	},
+};
+
 static int cbf_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
 			       void *data)
 {
 	struct clk_notifier_data *cnd = data;
+	struct clk_hw *hw = __clk_get_hw(cnd->clk);
 
 	switch (event) {
 	case PRE_RATE_CHANGE:
@@ -188,19 +238,19 @@ static int cbf_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
 		 * Avoid overvolting. clk_core_set_rate_nolock() walks from top
 		 * to bottom, so it will change the rate of the PLL before
 		 * chaging the parent of PMUX. This can result in pmux getting
-		 * clocked twice the expected rate.
+		 * clocked twice (or 4 times) the expected rate.
 		 *
-		 * Manually switch to PLL/2 here.
+		 * Manually switch to PLL/DIV here.
 		 */
 		if (cnd->old_rate > DIV_THRESHOLD &&
 		    cnd->new_rate < DIV_THRESHOLD)
-			clk_cbf_8996_mux_set_parent(&cbf_mux.clkr.hw, CBF_DIV_INDEX);
+			clk_cbf_8996_mux_set_parent(hw, CBF_DIV_INDEX);
 		break;
 	case ABORT_RATE_CHANGE:
 		/* Revert manual change */
 		if (cnd->new_rate < DIV_THRESHOLD &&
 		    cnd->old_rate > DIV_THRESHOLD)
-			clk_cbf_8996_mux_set_parent(&cbf_mux.clkr.hw, CBF_PLL_INDEX);
+			clk_cbf_8996_mux_set_parent(hw, CBF_PLL_INDEX);
 		break;
 	default:
 		break;
@@ -213,11 +263,50 @@ static struct clk_hw *cbf_msm8996_hw_clks[] = {
 	&cbf_pll_postdiv.hw,
 };
 
+static struct clk_hw *cbf_msm8996pro_hw_clks[] = {
+	&cbf_pro_pll_postdiv.hw,
+};
+
 static struct clk_regmap *cbf_msm8996_clks[] = {
 	&cbf_pll.clkr,
 	&cbf_mux.clkr,
 };
 
+static struct clk_regmap *cbf_msm8996pro_clks[] = {
+	&cbf_pll.clkr,
+	&cbf_pro_mux.clkr,
+};
+
+struct cbf_match_data {
+	const struct alpha_pll_config *config;
+	struct clk_fixed_factor *cbf_pll_postdiv;
+	struct clk_cbf_8996_mux *cbf_mux;
+	struct clk_hw **hw_clks;
+	size_t nr_hw_clks;
+	struct clk_regmap **clks;
+	size_t nr_clks;
+};
+
+static const struct cbf_match_data cbf_msm8996_match_data = {
+	.config = &cbfpll_config,
+	.cbf_pll_postdiv = &cbf_pll_postdiv,
+	.cbf_mux = &cbf_mux,
+	.hw_clks = cbf_msm8996_hw_clks,
+	.nr_hw_clks = ARRAY_SIZE(cbf_msm8996_hw_clks),
+	.clks = cbf_msm8996_clks,
+	.nr_clks = ARRAY_SIZE(cbf_msm8996_clks)
+};
+
+static const struct cbf_match_data cbf_msm8996pro_match_data = {
+	.config = &cbfpll_pro_config,
+	.cbf_pll_postdiv = &cbf_pro_pll_postdiv,
+	.cbf_mux = &cbf_pro_mux,
+	.hw_clks = cbf_msm8996pro_hw_clks,
+	.nr_hw_clks = ARRAY_SIZE(cbf_msm8996pro_hw_clks),
+	.clks = cbf_msm8996pro_clks,
+	.nr_clks = ARRAY_SIZE(cbf_msm8996pro_clks)
+};
+
 static const struct regmap_config cbf_msm8996_regmap_config = {
 	.reg_bits		= 32,
 	.reg_stride		= 4,
@@ -274,6 +363,7 @@ static int qcom_msm8996_cbf_probe(struct platform_device *pdev)
 	void __iomem *base;
 	struct regmap *regmap;
 	struct device *dev = &pdev->dev;
+	const struct cbf_match_data *data = of_device_get_match_data(dev);
 	int i, ret;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
@@ -295,7 +385,7 @@ static int qcom_msm8996_cbf_probe(struct platform_device *pdev)
 			   CBF_MUX_AUTO_CLK_SEL_ALWAYS_ON_MASK,
 			   CBF_MUX_AUTO_CLK_SEL_ALWAYS_ON_GPLL0_SEL);
 
-	clk_alpha_pll_configure(&cbf_pll, regmap, &cbfpll_config);
+	clk_alpha_pll_configure(&cbf_pll, regmap, data->config);
 
 	/* Wait for PLL(s) to lock */
 	udelay(50);
@@ -311,27 +401,27 @@ static int qcom_msm8996_cbf_probe(struct platform_device *pdev)
 	/* Switch CBF to use the primary PLL */
 	regmap_update_bits(regmap, CBF_MUX_OFFSET, CBF_MUX_PARENT_MASK, 0x1);
 
-	for (i = 0; i < ARRAY_SIZE(cbf_msm8996_hw_clks); i++) {
-		ret = devm_clk_hw_register(dev, cbf_msm8996_hw_clks[i]);
+	for (i = 0; i < data->nr_hw_clks; i++) {
+		ret = devm_clk_hw_register(dev, data->hw_clks[i]);
 		if (ret)
 			return ret;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(cbf_msm8996_clks); i++) {
-		ret = devm_clk_register_regmap(dev, cbf_msm8996_clks[i]);
+	for (i = 0; i < data->nr_clks; i++) {
+		ret = devm_clk_register_regmap(dev, data->clks[i]);
 		if (ret)
 			return ret;
 	}
 
-	ret = devm_clk_notifier_register(dev, cbf_mux.clkr.hw.clk, &cbf_mux.nb);
+	ret = devm_clk_notifier_register(dev, data->cbf_mux->clkr.hw.clk, &data->cbf_mux->nb);
 	if (ret)
 		return ret;
 
-	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, &cbf_mux.clkr.hw);
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, &data->cbf_mux->clkr.hw);
 	if (ret)
 		return ret;
 
-	return qcom_msm8996_cbf_icc_register(pdev, &cbf_mux.clkr.hw);
+	return qcom_msm8996_cbf_icc_register(pdev, &data->cbf_mux->clkr.hw);
 }
 
 static int qcom_msm8996_cbf_remove(struct platform_device *pdev)
@@ -340,7 +430,8 @@ static int qcom_msm8996_cbf_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id qcom_msm8996_cbf_match_table[] = {
-	{ .compatible = "qcom,msm8996-cbf" },
+	{ .compatible = "qcom,msm8996-cbf", .data = &cbf_msm8996_match_data },
+	{ .compatible = "qcom,msm8996pro-cbf", .data = &cbf_msm8996pro_match_data },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, qcom_msm8996_cbf_match_table);
-- 
2.40.0

