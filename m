Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021E069695C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjBNQX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbjBNQXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:23:50 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2192BEC5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:23:34 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id t24so1165801eji.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozYPPNMlOqBvz81VpF5vesQsdonAUuLCWQqlx4bMCig=;
        b=wL0v80cyoX++qWOTRDjv+2gM2HVaKZfr82wb/+ngBKHSyDyavWgLzu5MS+t6FzOPjs
         Q4NsCyTYaGPgiC1biuyPi1Jgo2N0Zk4ye4V+FUS1qCq6zdWiZJgarowaVvbekZw88Js+
         e49Fx6p+239xDzyPUyZ7BWwLmkF4dm2gohhCq/so7qZb6nhX6KkzcNqoDox2CJwoLcA8
         xaByv7xKksPfO8sbM/FStYBIBSm0ycAUD+P4Pa6kwczzA2k5tf4WbvE89np/VYjyxJx2
         URMux5qW1hU3u1+BsTwAlxG0CdWL7QdDJv6xPsM2vEV8J17F2syg/It+WvdU+NtZkt1c
         GpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozYPPNMlOqBvz81VpF5vesQsdonAUuLCWQqlx4bMCig=;
        b=2j5IGqhNaIFytU7KFbOJzTdApi8infxqJ3j5WcJ0qdK6gFIX5iiScLHQVUWB+XVB/h
         QxgO3zuVBtdbAROfSAEMLQxRUSZVItgW96u6RDNWbhcg623j4VoDYKAPFzgynDbT1ik/
         NwBW6Sm7NWLBgl3J4moIvPPXZxyT8bThKH2wSoRslIYbjzIkfZNPPS3Zd1k9RuJi7TYM
         8HqcCk2gNLWln+4Cnv0/SG2dM+/YOR+a1XIfJWYOAi1e4RidKHlk74EJ+qBPN3qdobXu
         s5ALmhSFVKNkxh4KtM7KiXdZcn+zK5nQ568v4GFF4XVOJtAjKwTUhq+dCJ8ANDNFgJAo
         ezPw==
X-Gm-Message-State: AO0yUKU26zrpY7SCqXv1WFALoRGXHO1yBbJj3gmpKFjpxjj67iM9EJDw
        piBEwlTB87++WPJytu7BD68pww==
X-Google-Smtp-Source: AK7set+WCtey16VL6vTfg8C/Zq2W9WrcirnaUMlkLcsiseN2vdHJm33eyBy3SWAGYGIddGQ6SU65Bg==
X-Received: by 2002:a17:906:f10d:b0:8b1:3293:ead2 with SMTP id gv13-20020a170906f10d00b008b13293ead2mr2204319ejb.25.1676391812780;
        Tue, 14 Feb 2023 08:23:32 -0800 (PST)
Received: from fedora.. (cpezg-94-253-130-165-cbl.xnet.hr. [94.253.130.165])
        by smtp.googlemail.com with ESMTPSA id bp8-20020a170907918800b008806a3c22c5sm1318027ejb.25.2023.02.14.08.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 08:23:32 -0800 (PST)
From:   Robert Marko <robert.marko@sartura.hr>
To:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     luka.perkov@sartura.hr, Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 5/7] clk: qcom: gcc-ipq4019: move PLL clocks up
Date:   Tue, 14 Feb 2023 17:23:23 +0100
Message-Id: <20230214162325.312057-5-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214162325.312057-1-robert.marko@sartura.hr>
References: <20230214162325.312057-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move PLL clock declarations up, before clock parent tables, so that we
can use pll hw clock fields in the next commit.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/clk/qcom/gcc-ipq4019.c | 1052 ++++++++++++++++----------------
 1 file changed, 526 insertions(+), 526 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq4019.c b/drivers/clk/qcom/gcc-ipq4019.c
index a50887d3626f7..f4bc587131c20 100644
--- a/drivers/clk/qcom/gcc-ipq4019.c
+++ b/drivers/clk/qcom/gcc-ipq4019.c
@@ -171,6 +171,334 @@ static const char * const gcc_xo_ddr_500_200[] = {
 	"ddrpllapss",
 };
 
+/* Calculates the VCO rate for FEPLL. */
+static u64 clk_fepll_vco_calc_rate(struct clk_fepll *pll_div,
+				   unsigned long parent_rate)
+{
+	const struct clk_fepll_vco *pll_vco = pll_div->pll_vco;
+	u32 fdbkdiv, refclkdiv, cdiv;
+	u64 vco;
+
+	regmap_read(pll_div->cdiv.clkr.regmap, pll_vco->reg, &cdiv);
+	refclkdiv = (cdiv >> pll_vco->refclkdiv_shift) &
+		    (BIT(pll_vco->refclkdiv_width) - 1);
+	fdbkdiv = (cdiv >> pll_vco->fdbkdiv_shift) &
+		  (BIT(pll_vco->fdbkdiv_width) - 1);
+
+	vco = parent_rate / refclkdiv;
+	vco *= 2;
+	vco *= fdbkdiv;
+
+	return vco;
+}
+
+static const struct clk_fepll_vco gcc_apss_ddrpll_vco = {
+	.fdbkdiv_shift = 16,
+	.fdbkdiv_width = 8,
+	.refclkdiv_shift = 24,
+	.refclkdiv_width = 5,
+	.reg = 0x2e020,
+};
+
+static const struct clk_fepll_vco gcc_fepll_vco = {
+	.fdbkdiv_shift = 16,
+	.fdbkdiv_width = 8,
+	.refclkdiv_shift = 24,
+	.refclkdiv_width = 5,
+	.reg = 0x2f020,
+};
+
+/*
+ * Round rate function for APSS CPU PLL Clock divider.
+ * It looks up the frequency table and returns the next higher frequency
+ * supported in hardware.
+ */
+static long clk_cpu_div_round_rate(struct clk_hw *hw, unsigned long rate,
+				   unsigned long *p_rate)
+{
+	struct clk_fepll *pll = to_clk_fepll(hw);
+	struct clk_hw *p_hw;
+	const struct freq_tbl *f;
+
+	f = qcom_find_freq(pll->freq_tbl, rate);
+	if (!f)
+		return -EINVAL;
+
+	p_hw = clk_hw_get_parent_by_index(hw, f->src);
+	*p_rate = clk_hw_get_rate(p_hw);
+
+	return f->freq;
+};
+
+/*
+ * Clock set rate function for APSS CPU PLL Clock divider.
+ * It looks up the frequency table and updates the PLL divider to corresponding
+ * divider value.
+ */
+static int clk_cpu_div_set_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long parent_rate)
+{
+	struct clk_fepll *pll = to_clk_fepll(hw);
+	const struct freq_tbl *f;
+	u32 mask;
+
+	f = qcom_find_freq(pll->freq_tbl, rate);
+	if (!f)
+		return -EINVAL;
+
+	mask = (BIT(pll->cdiv.width) - 1) << pll->cdiv.shift;
+	regmap_update_bits(pll->cdiv.clkr.regmap,
+			   pll->cdiv.reg, mask,
+			   f->pre_div << pll->cdiv.shift);
+	/*
+	 * There is no status bit which can be checked for successful CPU
+	 * divider update operation so using delay for the same.
+	 */
+	udelay(1);
+
+	return 0;
+};
+
+/*
+ * Clock frequency calculation function for APSS CPU PLL Clock divider.
+ * This clock divider is nonlinear so this function calculates the actual
+ * divider and returns the output frequency by dividing VCO Frequency
+ * with this actual divider value.
+ */
+static unsigned long
+clk_cpu_div_recalc_rate(struct clk_hw *hw,
+			unsigned long parent_rate)
+{
+	struct clk_fepll *pll = to_clk_fepll(hw);
+	u32 cdiv, pre_div;
+	u64 rate;
+
+	regmap_read(pll->cdiv.clkr.regmap, pll->cdiv.reg, &cdiv);
+	cdiv = (cdiv >> pll->cdiv.shift) & (BIT(pll->cdiv.width) - 1);
+
+	/*
+	 * Some dividers have value in 0.5 fraction so multiply both VCO
+	 * frequency(parent_rate) and pre_div with 2 to make integer
+	 * calculation.
+	 */
+	if (cdiv > 10)
+		pre_div = (cdiv + 1) * 2;
+	else
+		pre_div = cdiv + 12;
+
+	rate = clk_fepll_vco_calc_rate(pll, parent_rate) * 2;
+	do_div(rate, pre_div);
+
+	return rate;
+};
+
+static const struct clk_ops clk_regmap_cpu_div_ops = {
+	.round_rate = clk_cpu_div_round_rate,
+	.set_rate = clk_cpu_div_set_rate,
+	.recalc_rate = clk_cpu_div_recalc_rate,
+};
+
+static const struct freq_tbl ftbl_apss_ddr_pll[] = {
+	{ 384000000, P_XO, 0xd, 0, 0 },
+	{ 413000000, P_XO, 0xc, 0, 0 },
+	{ 448000000, P_XO, 0xb, 0, 0 },
+	{ 488000000, P_XO, 0xa, 0, 0 },
+	{ 512000000, P_XO, 0x9, 0, 0 },
+	{ 537000000, P_XO, 0x8, 0, 0 },
+	{ 565000000, P_XO, 0x7, 0, 0 },
+	{ 597000000, P_XO, 0x6, 0, 0 },
+	{ 632000000, P_XO, 0x5, 0, 0 },
+	{ 672000000, P_XO, 0x4, 0, 0 },
+	{ 716000000, P_XO, 0x3, 0, 0 },
+	{ 768000000, P_XO, 0x2, 0, 0 },
+	{ 823000000, P_XO, 0x1, 0, 0 },
+	{ 896000000, P_XO, 0x0, 0, 0 },
+	{ }
+};
+
+static struct clk_fepll gcc_apss_cpu_plldiv_clk = {
+	.cdiv.reg = 0x2e020,
+	.cdiv.shift = 4,
+	.cdiv.width = 4,
+	.cdiv.clkr = {
+		.enable_reg = 0x2e000,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "ddrpllapss",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "xo",
+				.name = "xo",
+			},
+			.num_parents = 1,
+			.ops = &clk_regmap_cpu_div_ops,
+		},
+	},
+	.freq_tbl = ftbl_apss_ddr_pll,
+	.pll_vco = &gcc_apss_ddrpll_vco,
+};
+
+/* Calculates the rate for PLL divider.
+ * If the divider value is not fixed then it gets the actual divider value
+ * from divider table. Then, it calculate the clock rate by dividing the
+ * parent rate with actual divider value.
+ */
+static unsigned long
+clk_regmap_clk_div_recalc_rate(struct clk_hw *hw,
+			       unsigned long parent_rate)
+{
+	struct clk_fepll *pll = to_clk_fepll(hw);
+	u32 cdiv, pre_div = 1;
+	u64 rate;
+	const struct clk_div_table *clkt;
+
+	if (pll->fixed_div) {
+		pre_div = pll->fixed_div;
+	} else {
+		regmap_read(pll->cdiv.clkr.regmap, pll->cdiv.reg, &cdiv);
+		cdiv = (cdiv >> pll->cdiv.shift) & (BIT(pll->cdiv.width) - 1);
+
+		for (clkt = pll->div_table; clkt->div; clkt++) {
+			if (clkt->val == cdiv)
+				pre_div = clkt->div;
+		}
+	}
+
+	rate = clk_fepll_vco_calc_rate(pll, parent_rate);
+	do_div(rate, pre_div);
+
+	return rate;
+};
+
+static const struct clk_ops clk_fepll_div_ops = {
+	.recalc_rate = clk_regmap_clk_div_recalc_rate,
+};
+
+static struct clk_fepll gcc_apss_sdcc_clk = {
+	.fixed_div = 28,
+	.cdiv.clkr = {
+		.hw.init = &(struct clk_init_data){
+			.name = "ddrpllsdcc",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "xo",
+				.name = "xo",
+			},
+			.num_parents = 1,
+			.ops = &clk_fepll_div_ops,
+		},
+	},
+	.pll_vco = &gcc_apss_ddrpll_vco,
+};
+
+static struct clk_fepll gcc_fepll125_clk = {
+	.fixed_div = 32,
+	.cdiv.clkr = {
+		.hw.init = &(struct clk_init_data){
+			.name = "fepll125",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "xo",
+				.name = "xo",
+			},
+			.num_parents = 1,
+			.ops = &clk_fepll_div_ops,
+		},
+	},
+	.pll_vco = &gcc_fepll_vco,
+};
+
+static struct clk_fepll gcc_fepll125dly_clk = {
+	.fixed_div = 32,
+	.cdiv.clkr = {
+		.hw.init = &(struct clk_init_data){
+			.name = "fepll125dly",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "xo",
+				.name = "xo",
+			},
+			.num_parents = 1,
+			.ops = &clk_fepll_div_ops,
+		},
+	},
+	.pll_vco = &gcc_fepll_vco,
+};
+
+static struct clk_fepll gcc_fepll200_clk = {
+	.fixed_div = 20,
+	.cdiv.clkr = {
+		.hw.init = &(struct clk_init_data){
+			.name = "fepll200",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "xo",
+				.name = "xo",
+			},
+			.num_parents = 1,
+			.ops = &clk_fepll_div_ops,
+		},
+	},
+	.pll_vco = &gcc_fepll_vco,
+};
+
+static struct clk_fepll gcc_fepll500_clk = {
+	.fixed_div = 8,
+	.cdiv.clkr = {
+		.hw.init = &(struct clk_init_data){
+			.name = "fepll500",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "xo",
+				.name = "xo",
+			},
+			.num_parents = 1,
+			.ops = &clk_fepll_div_ops,
+		},
+	},
+	.pll_vco = &gcc_fepll_vco,
+};
+
+static const struct clk_div_table fepllwcss_clk_div_table[] = {
+	{ 0, 15 },
+	{ 1, 16 },
+	{ 2, 18 },
+	{ 3, 20 },
+	{ },
+};
+
+static struct clk_fepll gcc_fepllwcss2g_clk = {
+	.cdiv.reg = 0x2f020,
+	.cdiv.shift = 8,
+	.cdiv.width = 2,
+	.cdiv.clkr = {
+		.hw.init = &(struct clk_init_data){
+			.name = "fepllwcss2g",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "xo",
+				.name = "xo",
+			},
+			.num_parents = 1,
+			.ops = &clk_fepll_div_ops,
+		},
+	},
+	.div_table = fepllwcss_clk_div_table,
+	.pll_vco = &gcc_fepll_vco,
+};
+
+static struct clk_fepll gcc_fepllwcss5g_clk = {
+	.cdiv.reg = 0x2f020,
+	.cdiv.shift = 12,
+	.cdiv.width = 2,
+	.cdiv.clkr = {
+		.hw.init = &(struct clk_init_data){
+			.name = "fepllwcss5g",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "xo",
+				.name = "xo",
+			},
+			.num_parents = 1,
+			.ops = &clk_fepll_div_ops,
+		},
+	},
+	.div_table = fepllwcss_clk_div_table,
+	.pll_vco = &gcc_fepll_vco,
+};
+
 static const struct freq_tbl ftbl_gcc_audio_pwm_clk[] = {
 	F(48000000, P_XO, 1, 0, 0),
 	F(200000000, P_FEPLL200, 1, 0, 0),
@@ -874,248 +1202,39 @@ static struct clk_branch gcc_qpic_clk = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gcc_qpic_clk",
 			.parent_names = (const char *[]){
-				"pcnoc_clk_src",
-			},
-			.num_parents = 1,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_sdcc1_ahb_clk = {
-	.halt_reg = 0x18010,
-	.clkr = {
-		.enable_reg = 0x18010,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "gcc_sdcc1_ahb_clk",
-			.parent_names = (const char *[]){
-				"pcnoc_clk_src",
-			},
-			.num_parents = 1,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_sdcc1_apps_clk = {
-	.halt_reg = 0x1800c,
-	.clkr = {
-		.enable_reg = 0x1800c,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "gcc_sdcc1_apps_clk",
-			.parent_names = (const char *[]){
-				"sdcc1_apps_clk_src",
-			},
-			.num_parents = 1,
-			.ops = &clk_branch2_ops,
-			.flags = CLK_SET_RATE_PARENT,
-		},
-	},
-};
-
-static struct clk_branch gcc_tlmm_ahb_clk = {
-	.halt_reg = 0x5004,
-	.halt_check = BRANCH_HALT_VOTED,
-	.clkr = {
-		.enable_reg = 0x6000,
-		.enable_mask = BIT(5),
-		.hw.init = &(struct clk_init_data){
-			.name = "gcc_tlmm_ahb_clk",
-			.parent_names = (const char *[]){
-				"pcnoc_clk_src",
-			},
-			.num_parents = 1,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_usb2_master_clk = {
-	.halt_reg = 0x1e00c,
-	.clkr = {
-		.enable_reg = 0x1e00c,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "gcc_usb2_master_clk",
-			.parent_names = (const char *[]){
-				"pcnoc_clk_src",
-			},
-			.num_parents = 1,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_usb2_sleep_clk = {
-	.halt_reg = 0x1e010,
-	.clkr = {
-		.enable_reg = 0x1e010,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "gcc_usb2_sleep_clk",
-			.parent_data = &(const struct clk_parent_data){
-				.fw_name = "sleep_clk",
-				.name = "gcc_sleep_clk_src",
-			},
-			.num_parents = 1,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_usb2_mock_utmi_clk = {
-	.halt_reg = 0x1e014,
-	.clkr = {
-		.enable_reg = 0x1e014,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "gcc_usb2_mock_utmi_clk",
-			.parent_names = (const char *[]){
-				"usb30_mock_utmi_clk_src",
-			},
-			.num_parents = 1,
-			.ops = &clk_branch2_ops,
-			.flags = CLK_SET_RATE_PARENT,
-		},
-	},
-};
-
-static const struct freq_tbl ftbl_gcc_usb30_mock_utmi_clk[] = {
-	F(2000000, P_FEPLL200, 10, 0, 0),
-	{ }
-};
-
-static struct clk_rcg2 usb30_mock_utmi_clk_src = {
-	.cmd_rcgr = 0x1e000,
-	.hid_width = 5,
-	.parent_map = gcc_xo_200_map,
-	.freq_tbl = ftbl_gcc_usb30_mock_utmi_clk,
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "usb30_mock_utmi_clk_src",
-		.parent_names = gcc_xo_200,
-		.num_parents = 2,
-		.ops = &clk_rcg2_ops,
-	},
-};
-
-static struct clk_branch gcc_usb3_master_clk = {
-	.halt_reg = 0x1e028,
-	.clkr = {
-		.enable_reg = 0x1e028,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "gcc_usb3_master_clk",
-			.parent_names = (const char *[]){
-				"fepll125",
-			},
-			.num_parents = 1,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_usb3_sleep_clk = {
-	.halt_reg = 0x1e02C,
-	.clkr = {
-		.enable_reg = 0x1e02C,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "gcc_usb3_sleep_clk",
-			.parent_data = &(const struct clk_parent_data){
-				.fw_name = "sleep_clk",
-				.name = "gcc_sleep_clk_src",
-			},
-			.num_parents = 1,
-			.ops = &clk_branch2_ops,
-		},
-	},
-};
-
-static struct clk_branch gcc_usb3_mock_utmi_clk = {
-	.halt_reg = 0x1e030,
-	.clkr = {
-		.enable_reg = 0x1e030,
-		.enable_mask = BIT(0),
-		.hw.init = &(struct clk_init_data){
-			.name = "gcc_usb3_mock_utmi_clk",
-			.parent_names = (const char *[]){
-				"usb30_mock_utmi_clk_src",
-			},
-			.num_parents = 1,
-			.ops = &clk_branch2_ops,
-			.flags = CLK_SET_RATE_PARENT,
-		},
-	},
-};
-
-static const struct freq_tbl ftbl_gcc_fephy_dly_clk[] = {
-	F(125000000, P_FEPLL125DLY, 1, 0, 0),
-	{ }
-};
-
-static struct clk_rcg2 fephy_125m_dly_clk_src = {
-	.cmd_rcgr = 0x12000,
-	.hid_width = 5,
-	.parent_map = gcc_xo_125_dly_map,
-	.freq_tbl = ftbl_gcc_fephy_dly_clk,
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "fephy_125m_dly_clk_src",
-		.parent_names = gcc_xo_125_dly,
-		.num_parents = 2,
-		.ops = &clk_rcg2_ops,
-	},
-};
-
-
-static const struct freq_tbl ftbl_gcc_wcss2g_clk[] = {
-	F(48000000, P_XO, 1, 0, 0),
-	F(250000000, P_FEPLLWCSS2G, 1, 0, 0),
-	{ }
-};
-
-static struct clk_rcg2 wcss2g_clk_src = {
-	.cmd_rcgr = 0x1f000,
-	.hid_width = 5,
-	.freq_tbl = ftbl_gcc_wcss2g_clk,
-	.parent_map = gcc_xo_wcss2g_map,
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "wcss2g_clk_src",
-		.parent_names = gcc_xo_wcss2g,
-		.num_parents = 2,
-		.ops = &clk_rcg2_ops,
-		.flags = CLK_SET_RATE_PARENT,
+				"pcnoc_clk_src",
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
 	},
 };
 
-static struct clk_branch gcc_wcss2g_clk = {
-	.halt_reg = 0x1f00C,
+static struct clk_branch gcc_sdcc1_ahb_clk = {
+	.halt_reg = 0x18010,
 	.clkr = {
-		.enable_reg = 0x1f00C,
+		.enable_reg = 0x18010,
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
-			.name = "gcc_wcss2g_clk",
+			.name = "gcc_sdcc1_ahb_clk",
 			.parent_names = (const char *[]){
-				"wcss2g_clk_src",
+				"pcnoc_clk_src",
 			},
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
-			.flags = CLK_SET_RATE_PARENT,
 		},
 	},
 };
 
-static struct clk_branch gcc_wcss2g_ref_clk = {
-	.halt_reg = 0x1f00C,
+static struct clk_branch gcc_sdcc1_apps_clk = {
+	.halt_reg = 0x1800c,
 	.clkr = {
-		.enable_reg = 0x1f00C,
+		.enable_reg = 0x1800c,
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
-			.name = "gcc_wcss2g_ref_clk",
-			.parent_data = &(const struct clk_parent_data){
-				.fw_name = "xo",
-				.name = "xo",
+			.name = "gcc_sdcc1_apps_clk",
+			.parent_names = (const char *[]){
+				"sdcc1_apps_clk_src",
 			},
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
@@ -1124,16 +1243,16 @@ static struct clk_branch gcc_wcss2g_ref_clk = {
 	},
 };
 
-static struct clk_branch gcc_wcss2g_rtc_clk = {
-	.halt_reg = 0x1f010,
+static struct clk_branch gcc_tlmm_ahb_clk = {
+	.halt_reg = 0x5004,
+	.halt_check = BRANCH_HALT_VOTED,
 	.clkr = {
-		.enable_reg = 0x1f010,
-		.enable_mask = BIT(0),
+		.enable_reg = 0x6000,
+		.enable_mask = BIT(5),
 		.hw.init = &(struct clk_init_data){
-			.name = "gcc_wcss2g_rtc_clk",
-			.parent_data = &(const struct clk_parent_data){
-				.fw_name = "sleep_clk",
-				.name = "gcc_sleep_clk_src",
+			.name = "gcc_tlmm_ahb_clk",
+			.parent_names = (const char *[]){
+				"pcnoc_clk_src",
 			},
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
@@ -1141,70 +1260,48 @@ static struct clk_branch gcc_wcss2g_rtc_clk = {
 	},
 };
 
-static const struct freq_tbl ftbl_gcc_wcss5g_clk[] = {
-	F(48000000, P_XO, 1, 0, 0),
-	F(250000000, P_FEPLLWCSS5G, 1, 0, 0),
-	{ }
-};
-
-static struct clk_rcg2 wcss5g_clk_src = {
-	.cmd_rcgr = 0x20000,
-	.hid_width = 5,
-	.parent_map = gcc_xo_wcss5g_map,
-	.freq_tbl = ftbl_gcc_wcss5g_clk,
-	.clkr.hw.init = &(struct clk_init_data){
-		.name = "wcss5g_clk_src",
-		.parent_names = gcc_xo_wcss5g,
-		.num_parents = 2,
-		.ops = &clk_rcg2_ops,
-	},
-};
-
-static struct clk_branch gcc_wcss5g_clk = {
-	.halt_reg = 0x2000c,
+static struct clk_branch gcc_usb2_master_clk = {
+	.halt_reg = 0x1e00c,
 	.clkr = {
-		.enable_reg = 0x2000c,
+		.enable_reg = 0x1e00c,
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
-			.name = "gcc_wcss5g_clk",
+			.name = "gcc_usb2_master_clk",
 			.parent_names = (const char *[]){
-				"wcss5g_clk_src",
+				"pcnoc_clk_src",
 			},
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
-			.flags = CLK_SET_RATE_PARENT,
 		},
 	},
 };
 
-static struct clk_branch gcc_wcss5g_ref_clk = {
-	.halt_reg = 0x2000c,
+static struct clk_branch gcc_usb2_sleep_clk = {
+	.halt_reg = 0x1e010,
 	.clkr = {
-		.enable_reg = 0x2000c,
+		.enable_reg = 0x1e010,
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
-			.name = "gcc_wcss5g_ref_clk",
+			.name = "gcc_usb2_sleep_clk",
 			.parent_data = &(const struct clk_parent_data){
-				.fw_name = "xo",
-				.name = "xo",
+				.fw_name = "sleep_clk",
+				.name = "gcc_sleep_clk_src",
 			},
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
-			.flags = CLK_SET_RATE_PARENT,
 		},
 	},
 };
 
-static struct clk_branch gcc_wcss5g_rtc_clk = {
-	.halt_reg = 0x20010,
+static struct clk_branch gcc_usb2_mock_utmi_clk = {
+	.halt_reg = 0x1e014,
 	.clkr = {
-		.enable_reg = 0x20010,
+		.enable_reg = 0x1e014,
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
-			.name = "gcc_wcss5g_rtc_clk",
-			.parent_data = &(const struct clk_parent_data){
-				.fw_name = "sleep_clk",
-				.name = "gcc_sleep_clk_src",
+			.name = "gcc_usb2_mock_utmi_clk",
+			.parent_names = (const char *[]){
+				"usb30_mock_utmi_clk_src",
 			},
 			.num_parents = 1,
 			.ops = &clk_branch2_ops,
@@ -1213,332 +1310,235 @@ static struct clk_branch gcc_wcss5g_rtc_clk = {
 	},
 };
 
-/* Calculates the VCO rate for FEPLL. */
-static u64 clk_fepll_vco_calc_rate(struct clk_fepll *pll_div,
-				   unsigned long parent_rate)
-{
-	const struct clk_fepll_vco *pll_vco = pll_div->pll_vco;
-	u32 fdbkdiv, refclkdiv, cdiv;
-	u64 vco;
-
-	regmap_read(pll_div->cdiv.clkr.regmap, pll_vco->reg, &cdiv);
-	refclkdiv = (cdiv >> pll_vco->refclkdiv_shift) &
-		    (BIT(pll_vco->refclkdiv_width) - 1);
-	fdbkdiv = (cdiv >> pll_vco->fdbkdiv_shift) &
-		  (BIT(pll_vco->fdbkdiv_width) - 1);
-
-	vco = parent_rate / refclkdiv;
-	vco *= 2;
-	vco *= fdbkdiv;
-
-	return vco;
-}
-
-static const struct clk_fepll_vco gcc_apss_ddrpll_vco = {
-	.fdbkdiv_shift = 16,
-	.fdbkdiv_width = 8,
-	.refclkdiv_shift = 24,
-	.refclkdiv_width = 5,
-	.reg = 0x2e020,
-};
-
-static const struct clk_fepll_vco gcc_fepll_vco = {
-	.fdbkdiv_shift = 16,
-	.fdbkdiv_width = 8,
-	.refclkdiv_shift = 24,
-	.refclkdiv_width = 5,
-	.reg = 0x2f020,
-};
-
-/*
- * Round rate function for APSS CPU PLL Clock divider.
- * It looks up the frequency table and returns the next higher frequency
- * supported in hardware.
- */
-static long clk_cpu_div_round_rate(struct clk_hw *hw, unsigned long rate,
-				   unsigned long *p_rate)
-{
-	struct clk_fepll *pll = to_clk_fepll(hw);
-	struct clk_hw *p_hw;
-	const struct freq_tbl *f;
-
-	f = qcom_find_freq(pll->freq_tbl, rate);
-	if (!f)
-		return -EINVAL;
-
-	p_hw = clk_hw_get_parent_by_index(hw, f->src);
-	*p_rate = clk_hw_get_rate(p_hw);
-
-	return f->freq;
-};
-
-/*
- * Clock set rate function for APSS CPU PLL Clock divider.
- * It looks up the frequency table and updates the PLL divider to corresponding
- * divider value.
- */
-static int clk_cpu_div_set_rate(struct clk_hw *hw, unsigned long rate,
-				unsigned long parent_rate)
-{
-	struct clk_fepll *pll = to_clk_fepll(hw);
-	const struct freq_tbl *f;
-	u32 mask;
-
-	f = qcom_find_freq(pll->freq_tbl, rate);
-	if (!f)
-		return -EINVAL;
-
-	mask = (BIT(pll->cdiv.width) - 1) << pll->cdiv.shift;
-	regmap_update_bits(pll->cdiv.clkr.regmap,
-			   pll->cdiv.reg, mask,
-			   f->pre_div << pll->cdiv.shift);
-	/*
-	 * There is no status bit which can be checked for successful CPU
-	 * divider update operation so using delay for the same.
-	 */
-	udelay(1);
-
-	return 0;
-};
-
-/*
- * Clock frequency calculation function for APSS CPU PLL Clock divider.
- * This clock divider is nonlinear so this function calculates the actual
- * divider and returns the output frequency by dividing VCO Frequency
- * with this actual divider value.
- */
-static unsigned long
-clk_cpu_div_recalc_rate(struct clk_hw *hw,
-			unsigned long parent_rate)
-{
-	struct clk_fepll *pll = to_clk_fepll(hw);
-	u32 cdiv, pre_div;
-	u64 rate;
-
-	regmap_read(pll->cdiv.clkr.regmap, pll->cdiv.reg, &cdiv);
-	cdiv = (cdiv >> pll->cdiv.shift) & (BIT(pll->cdiv.width) - 1);
-
-	/*
-	 * Some dividers have value in 0.5 fraction so multiply both VCO
-	 * frequency(parent_rate) and pre_div with 2 to make integer
-	 * calculation.
-	 */
-	if (cdiv > 10)
-		pre_div = (cdiv + 1) * 2;
-	else
-		pre_div = cdiv + 12;
-
-	rate = clk_fepll_vco_calc_rate(pll, parent_rate) * 2;
-	do_div(rate, pre_div);
-
-	return rate;
-};
-
-static const struct clk_ops clk_regmap_cpu_div_ops = {
-	.round_rate = clk_cpu_div_round_rate,
-	.set_rate = clk_cpu_div_set_rate,
-	.recalc_rate = clk_cpu_div_recalc_rate,
+static const struct freq_tbl ftbl_gcc_usb30_mock_utmi_clk[] = {
+	F(2000000, P_FEPLL200, 10, 0, 0),
+	{ }
 };
 
-static const struct freq_tbl ftbl_apss_ddr_pll[] = {
-	{ 384000000, P_XO, 0xd, 0, 0 },
-	{ 413000000, P_XO, 0xc, 0, 0 },
-	{ 448000000, P_XO, 0xb, 0, 0 },
-	{ 488000000, P_XO, 0xa, 0, 0 },
-	{ 512000000, P_XO, 0x9, 0, 0 },
-	{ 537000000, P_XO, 0x8, 0, 0 },
-	{ 565000000, P_XO, 0x7, 0, 0 },
-	{ 597000000, P_XO, 0x6, 0, 0 },
-	{ 632000000, P_XO, 0x5, 0, 0 },
-	{ 672000000, P_XO, 0x4, 0, 0 },
-	{ 716000000, P_XO, 0x3, 0, 0 },
-	{ 768000000, P_XO, 0x2, 0, 0 },
-	{ 823000000, P_XO, 0x1, 0, 0 },
-	{ 896000000, P_XO, 0x0, 0, 0 },
-	{ }
+static struct clk_rcg2 usb30_mock_utmi_clk_src = {
+	.cmd_rcgr = 0x1e000,
+	.hid_width = 5,
+	.parent_map = gcc_xo_200_map,
+	.freq_tbl = ftbl_gcc_usb30_mock_utmi_clk,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "usb30_mock_utmi_clk_src",
+		.parent_names = gcc_xo_200,
+		.num_parents = 2,
+		.ops = &clk_rcg2_ops,
+	},
 };
 
-static struct clk_fepll gcc_apss_cpu_plldiv_clk = {
-	.cdiv.reg = 0x2e020,
-	.cdiv.shift = 4,
-	.cdiv.width = 4,
-	.cdiv.clkr = {
-		.enable_reg = 0x2e000,
+static struct clk_branch gcc_usb3_master_clk = {
+	.halt_reg = 0x1e028,
+	.clkr = {
+		.enable_reg = 0x1e028,
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
-			.name = "ddrpllapss",
+			.name = "gcc_usb3_master_clk",
+			.parent_names = (const char *[]){
+				"fepll125",
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_usb3_sleep_clk = {
+	.halt_reg = 0x1e02C,
+	.clkr = {
+		.enable_reg = 0x1e02C,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_usb3_sleep_clk",
 			.parent_data = &(const struct clk_parent_data){
-				.fw_name = "xo",
-				.name = "xo",
+				.fw_name = "sleep_clk",
+				.name = "gcc_sleep_clk_src",
 			},
 			.num_parents = 1,
-			.ops = &clk_regmap_cpu_div_ops,
+			.ops = &clk_branch2_ops,
 		},
 	},
-	.freq_tbl = ftbl_apss_ddr_pll,
-	.pll_vco = &gcc_apss_ddrpll_vco,
 };
 
-/* Calculates the rate for PLL divider.
- * If the divider value is not fixed then it gets the actual divider value
- * from divider table. Then, it calculate the clock rate by dividing the
- * parent rate with actual divider value.
- */
-static unsigned long
-clk_regmap_clk_div_recalc_rate(struct clk_hw *hw,
-			       unsigned long parent_rate)
-{
-	struct clk_fepll *pll = to_clk_fepll(hw);
-	u32 cdiv, pre_div = 1;
-	u64 rate;
-	const struct clk_div_table *clkt;
+static struct clk_branch gcc_usb3_mock_utmi_clk = {
+	.halt_reg = 0x1e030,
+	.clkr = {
+		.enable_reg = 0x1e030,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gcc_usb3_mock_utmi_clk",
+			.parent_names = (const char *[]){
+				"usb30_mock_utmi_clk_src",
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
+		},
+	},
+};
 
-	if (pll->fixed_div) {
-		pre_div = pll->fixed_div;
-	} else {
-		regmap_read(pll->cdiv.clkr.regmap, pll->cdiv.reg, &cdiv);
-		cdiv = (cdiv >> pll->cdiv.shift) & (BIT(pll->cdiv.width) - 1);
+static const struct freq_tbl ftbl_gcc_fephy_dly_clk[] = {
+	F(125000000, P_FEPLL125DLY, 1, 0, 0),
+	{ }
+};
 
-		for (clkt = pll->div_table; clkt->div; clkt++) {
-			if (clkt->val == cdiv)
-				pre_div = clkt->div;
-		}
-	}
+static struct clk_rcg2 fephy_125m_dly_clk_src = {
+	.cmd_rcgr = 0x12000,
+	.hid_width = 5,
+	.parent_map = gcc_xo_125_dly_map,
+	.freq_tbl = ftbl_gcc_fephy_dly_clk,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "fephy_125m_dly_clk_src",
+		.parent_names = gcc_xo_125_dly,
+		.num_parents = 2,
+		.ops = &clk_rcg2_ops,
+	},
+};
 
-	rate = clk_fepll_vco_calc_rate(pll, parent_rate);
-	do_div(rate, pre_div);
 
-	return rate;
+static const struct freq_tbl ftbl_gcc_wcss2g_clk[] = {
+	F(48000000, P_XO, 1, 0, 0),
+	F(250000000, P_FEPLLWCSS2G, 1, 0, 0),
+	{ }
 };
 
-static const struct clk_ops clk_fepll_div_ops = {
-	.recalc_rate = clk_regmap_clk_div_recalc_rate,
+static struct clk_rcg2 wcss2g_clk_src = {
+	.cmd_rcgr = 0x1f000,
+	.hid_width = 5,
+	.freq_tbl = ftbl_gcc_wcss2g_clk,
+	.parent_map = gcc_xo_wcss2g_map,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "wcss2g_clk_src",
+		.parent_names = gcc_xo_wcss2g,
+		.num_parents = 2,
+		.ops = &clk_rcg2_ops,
+		.flags = CLK_SET_RATE_PARENT,
+	},
 };
 
-static struct clk_fepll gcc_apss_sdcc_clk = {
-	.fixed_div = 28,
-	.cdiv.clkr = {
+static struct clk_branch gcc_wcss2g_clk = {
+	.halt_reg = 0x1f00C,
+	.clkr = {
+		.enable_reg = 0x1f00C,
+		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
-			.name = "ddrpllsdcc",
-			.parent_data = &(const struct clk_parent_data){
-				.fw_name = "xo",
-				.name = "xo",
+			.name = "gcc_wcss2g_clk",
+			.parent_names = (const char *[]){
+				"wcss2g_clk_src",
 			},
 			.num_parents = 1,
-			.ops = &clk_fepll_div_ops,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
 		},
 	},
-	.pll_vco = &gcc_apss_ddrpll_vco,
 };
 
-static struct clk_fepll gcc_fepll125_clk = {
-	.fixed_div = 32,
-	.cdiv.clkr = {
+static struct clk_branch gcc_wcss2g_ref_clk = {
+	.halt_reg = 0x1f00C,
+	.clkr = {
+		.enable_reg = 0x1f00C,
+		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
-			.name = "fepll125",
+			.name = "gcc_wcss2g_ref_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.fw_name = "xo",
 				.name = "xo",
 			},
 			.num_parents = 1,
-			.ops = &clk_fepll_div_ops,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
 		},
 	},
-	.pll_vco = &gcc_fepll_vco,
 };
 
-static struct clk_fepll gcc_fepll125dly_clk = {
-	.fixed_div = 32,
-	.cdiv.clkr = {
+static struct clk_branch gcc_wcss2g_rtc_clk = {
+	.halt_reg = 0x1f010,
+	.clkr = {
+		.enable_reg = 0x1f010,
+		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
-			.name = "fepll125dly",
+			.name = "gcc_wcss2g_rtc_clk",
 			.parent_data = &(const struct clk_parent_data){
-				.fw_name = "xo",
-				.name = "xo",
+				.fw_name = "sleep_clk",
+				.name = "gcc_sleep_clk_src",
 			},
 			.num_parents = 1,
-			.ops = &clk_fepll_div_ops,
+			.ops = &clk_branch2_ops,
 		},
 	},
-	.pll_vco = &gcc_fepll_vco,
 };
 
-static struct clk_fepll gcc_fepll200_clk = {
-	.fixed_div = 20,
-	.cdiv.clkr = {
-		.hw.init = &(struct clk_init_data){
-			.name = "fepll200",
-			.parent_data = &(const struct clk_parent_data){
-				.fw_name = "xo",
-				.name = "xo",
-			},
-			.num_parents = 1,
-			.ops = &clk_fepll_div_ops,
-		},
+static const struct freq_tbl ftbl_gcc_wcss5g_clk[] = {
+	F(48000000, P_XO, 1, 0, 0),
+	F(250000000, P_FEPLLWCSS5G, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 wcss5g_clk_src = {
+	.cmd_rcgr = 0x20000,
+	.hid_width = 5,
+	.parent_map = gcc_xo_wcss5g_map,
+	.freq_tbl = ftbl_gcc_wcss5g_clk,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "wcss5g_clk_src",
+		.parent_names = gcc_xo_wcss5g,
+		.num_parents = 2,
+		.ops = &clk_rcg2_ops,
 	},
-	.pll_vco = &gcc_fepll_vco,
 };
 
-static struct clk_fepll gcc_fepll500_clk = {
-	.fixed_div = 8,
-	.cdiv.clkr = {
+static struct clk_branch gcc_wcss5g_clk = {
+	.halt_reg = 0x2000c,
+	.clkr = {
+		.enable_reg = 0x2000c,
+		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
-			.name = "fepll500",
-			.parent_data = &(const struct clk_parent_data){
-				.fw_name = "xo",
-				.name = "xo",
+			.name = "gcc_wcss5g_clk",
+			.parent_names = (const char *[]){
+				"wcss5g_clk_src",
 			},
 			.num_parents = 1,
-			.ops = &clk_fepll_div_ops,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
 		},
 	},
-	.pll_vco = &gcc_fepll_vco,
-};
-
-static const struct clk_div_table fepllwcss_clk_div_table[] = {
-	{ 0, 15 },
-	{ 1, 16 },
-	{ 2, 18 },
-	{ 3, 20 },
-	{ },
 };
 
-static struct clk_fepll gcc_fepllwcss2g_clk = {
-	.cdiv.reg = 0x2f020,
-	.cdiv.shift = 8,
-	.cdiv.width = 2,
-	.cdiv.clkr = {
+static struct clk_branch gcc_wcss5g_ref_clk = {
+	.halt_reg = 0x2000c,
+	.clkr = {
+		.enable_reg = 0x2000c,
+		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
-			.name = "fepllwcss2g",
+			.name = "gcc_wcss5g_ref_clk",
 			.parent_data = &(const struct clk_parent_data){
 				.fw_name = "xo",
 				.name = "xo",
 			},
 			.num_parents = 1,
-			.ops = &clk_fepll_div_ops,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
 		},
 	},
-	.div_table = fepllwcss_clk_div_table,
-	.pll_vco = &gcc_fepll_vco,
 };
 
-static struct clk_fepll gcc_fepllwcss5g_clk = {
-	.cdiv.reg = 0x2f020,
-	.cdiv.shift = 12,
-	.cdiv.width = 2,
-	.cdiv.clkr = {
+static struct clk_branch gcc_wcss5g_rtc_clk = {
+	.halt_reg = 0x20010,
+	.clkr = {
+		.enable_reg = 0x20010,
+		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
-			.name = "fepllwcss5g",
+			.name = "gcc_wcss5g_rtc_clk",
 			.parent_data = &(const struct clk_parent_data){
-				.fw_name = "xo",
-				.name = "xo",
+				.fw_name = "sleep_clk",
+				.name = "gcc_sleep_clk_src",
 			},
 			.num_parents = 1,
-			.ops = &clk_fepll_div_ops,
+			.ops = &clk_branch2_ops,
+			.flags = CLK_SET_RATE_PARENT,
 		},
 	},
-	.div_table = fepllwcss_clk_div_table,
-	.pll_vco = &gcc_fepll_vco,
 };
 
 static const struct freq_tbl ftbl_gcc_pcnoc_ahb_clk[] = {
-- 
2.39.1

