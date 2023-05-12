Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066036FFEF0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 04:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239857AbjELCWt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 11 May 2023 22:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbjELCWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 22:22:24 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481055583;
        Thu, 11 May 2023 19:22:21 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id EE3B024E28F;
        Fri, 12 May 2023 10:22:14 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 12 May
 2023 10:22:15 +0800
Received: from localhost.localdomain (113.72.146.187) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 12 May
 2023 10:22:13 +0800
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>
CC:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v4 2/7] clk: starfive: Add StarFive JH7110 PLL clock driver
Date:   Fri, 12 May 2023 10:20:31 +0800
Message-ID: <20230512022036.97987-3-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230512022036.97987-1-xingyu.wu@starfivetech.com>
References: <20230512022036.97987-1-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.146.187]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for the StarFive JH7110 PLL clock controller
and they work by reading and setting syscon registers.

Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 MAINTAINERS                                   |   6 +
 drivers/clk/starfive/Kconfig                  |   8 +
 drivers/clk/starfive/Makefile                 |   1 +
 .../clk/starfive/clk-starfive-jh7110-pll.c    | 309 ++++++++++++++++
 .../clk/starfive/clk-starfive-jh7110-pll.h    | 331 ++++++++++++++++++
 5 files changed, 655 insertions(+)
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-pll.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-pll.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 7e0b87d5aa2e..0fb4a703f66f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20087,6 +20087,12 @@ S:	Supported
 F:	Documentation/devicetree/bindings/mmc/starfive*
 F:	drivers/mmc/host/dw_mmc-starfive.c
 
+STARFIVE JH7110 PLL CLOCK DRIVER
+M:	Xingyu Wu <xingyu.wu@starfivetech.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/clock/starfive,jh7110-pll.yaml
+F:	drivers/clk/starfive/clk-starfive-jh7110-pll.*
+
 STARFIVE JH71X0 CLOCK DRIVERS
 M:	Emil Renner Berthing <kernel@esmil.dk>
 M:	Hal Feng <hal.feng@starfivetech.com>
diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index 5d2333106f13..5195f7be5213 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -21,6 +21,14 @@ config CLK_STARFIVE_JH7100_AUDIO
 	  Say Y or M here to support the audio clocks on the StarFive JH7100
 	  SoC.
 
+config CLK_STARFIVE_JH7110_PLL
+	bool "StarFive JH7110 PLL clock support"
+	depends on ARCH_STARFIVE || COMPILE_TEST
+	default ARCH_STARFIVE
+	help
+	  Say yes here to support the PLL clock controller on the
+	  StarFive JH7110 SoC.
+
 config CLK_STARFIVE_JH7110_SYS
 	bool "StarFive JH7110 system clock support"
 	depends on ARCH_STARFIVE || COMPILE_TEST
diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
index f3df7d957b1e..b48e539e52b0 100644
--- a/drivers/clk/starfive/Makefile
+++ b/drivers/clk/starfive/Makefile
@@ -4,5 +4,6 @@ obj-$(CONFIG_CLK_STARFIVE_JH71X0)	+= clk-starfive-jh71x0.o
 obj-$(CONFIG_CLK_STARFIVE_JH7100)	+= clk-starfive-jh7100.o
 obj-$(CONFIG_CLK_STARFIVE_JH7100_AUDIO)	+= clk-starfive-jh7100-audio.o
 
+obj-$(CONFIG_CLK_STARFIVE_JH7110_PLL)	+= clk-starfive-jh7110-pll.o
 obj-$(CONFIG_CLK_STARFIVE_JH7110_SYS)	+= clk-starfive-jh7110-sys.o
 obj-$(CONFIG_CLK_STARFIVE_JH7110_AON)	+= clk-starfive-jh7110-aon.o
diff --git a/drivers/clk/starfive/clk-starfive-jh7110-pll.c b/drivers/clk/starfive/clk-starfive-jh7110-pll.c
new file mode 100644
index 000000000000..f86deddd4bef
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jh7110-pll.c
@@ -0,0 +1,309 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive JH7110 PLL Clock Generator Driver
+ *
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ *
+ * This driver is about to register JH7110 PLL clock generator and support ops.
+ * The JH7110 have three PLL clock, PLL0, PLL1 and PLL2.
+ * Each PLL clocks work in integer mode or fraction mode by some dividers,
+ * and the configuration registers and dividers are set in several syscon registers.
+ * The formula for calculating frequency is:
+ * Fvco = Fref * (NI + NF) / M / Q1
+ * Fref: OSC source clock rate
+ * NI: integer frequency dividing ratio of feedback divider, set by fbdiv[11:0].
+ * NF: fractional frequency dividing ratio, set by frac[23:0]. NF = frac[23:0] / 2^24 = 0 ~ 0.999.
+ * M: frequency dividing ratio of pre-divider, set by prediv[5:0].
+ * Q1: frequency dividing ratio of post divider, set by postdiv1[1:0], Q1= 1,2,4,8.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/clock/starfive,jh7110-crg.h>
+
+#include "clk-starfive-jh7110-pll.h"
+
+struct jh7110_pll_conf_variant {
+	unsigned int pll_nums;
+	struct jh7110_pll_syscon_conf conf[];
+};
+
+static const struct jh7110_pll_conf_variant jh7110_pll_variant = {
+	.pll_nums = JH7110_PLLCLK_END,
+	.conf = {
+		JH7110_PLL(JH7110_CLK_PLL0_OUT, "pll0_out",
+			   JH7110_PLL0_FREQ_MAX, jh7110_pll0_syscon_val_preset),
+		JH7110_PLL(JH7110_CLK_PLL1_OUT, "pll1_out",
+			   JH7110_PLL1_FREQ_MAX, jh7110_pll1_syscon_val_preset),
+		JH7110_PLL(JH7110_CLK_PLL2_OUT, "pll2_out",
+			   JH7110_PLL2_FREQ_MAX, jh7110_pll2_syscon_val_preset),
+	},
+};
+
+static struct jh7110_clk_pll_data *jh7110_pll_data_from(struct clk_hw *hw)
+{
+	return container_of(hw, struct jh7110_clk_pll_data, hw);
+}
+
+static struct jh7110_clk_pll_priv *jh7110_pll_priv_from(struct jh7110_clk_pll_data *data)
+{
+	return container_of(data, struct jh7110_clk_pll_priv, data[data->idx]);
+}
+
+/* Read register value from syscon and calculate PLL(x) frequency */
+static unsigned long jh7110_pll_get_freq(struct jh7110_clk_pll_data *data,
+					 unsigned long parent_rate)
+{
+	struct jh7110_clk_pll_priv *priv = jh7110_pll_priv_from(data);
+	struct jh7110_pll_syscon_offset *offset = &data->conf.offsets;
+	struct jh7110_pll_syscon_mask *mask = &data->conf.masks;
+	struct jh7110_pll_syscon_shift *shift = &data->conf.shifts;
+	unsigned long frac_cal;
+	u32 dacpd;
+	u32 dsmpd;
+	u32 fbdiv;
+	u32 prediv;
+	u32 postdiv1;
+	u32 frac;
+	u32 reg_val;
+
+	regmap_read(priv->syscon_regmap, offset->dacpd, &reg_val);
+	dacpd = (reg_val & mask->dacpd) >> shift->dacpd;
+
+	regmap_read(priv->syscon_regmap, offset->dsmpd, &reg_val);
+	dsmpd = (reg_val & mask->dsmpd) >> shift->dsmpd;
+
+	regmap_read(priv->syscon_regmap, offset->fbdiv, &reg_val);
+	fbdiv = (reg_val & mask->fbdiv) >> shift->fbdiv;
+
+	regmap_read(priv->syscon_regmap, offset->prediv, &reg_val);
+	prediv = (reg_val & mask->prediv) >> shift->prediv;
+
+	regmap_read(priv->syscon_regmap, offset->postdiv1, &reg_val);
+	/* postdiv1 = 2 ^ reg_val */
+	postdiv1 = 1 << ((reg_val & mask->postdiv1) >> shift->postdiv1);
+
+	regmap_read(priv->syscon_regmap, offset->frac, &reg_val);
+	frac = (reg_val & mask->frac) >> shift->frac;
+
+	/*
+	 * Integer Mode (Both 1) or Fraction Mode (Both 0).
+	 * And the decimal places are counted by expanding them by
+	 * a factor of STARFIVE_PLL_FRAC_PATR_SIZE.
+	 */
+	if (dacpd == 1 && dsmpd == 1)
+		frac_cal = 0;
+	else if (dacpd == 0 && dsmpd == 0)
+		frac_cal = (unsigned long)frac * STARFIVE_PLL_FRAC_PATR_SIZE / (1 << 24);
+	else
+		return 0;
+
+	/* Fvco = Fref * (NI + NF) / M / Q1 */
+	return (parent_rate / STARFIVE_PLL_FRAC_PATR_SIZE *
+		(fbdiv * STARFIVE_PLL_FRAC_PATR_SIZE + frac_cal) / prediv / postdiv1);
+}
+
+static unsigned long jh7110_pll_rate_sub_fabs(unsigned long rate1, unsigned long rate2)
+{
+	return rate1 > rate2 ? (rate1 - rate2) : (rate2 - rate1);
+}
+
+/* Select the appropriate frequency from the already configured registers value */
+static void jh7110_pll_select_near_freq_id(struct jh7110_clk_pll_data *data,
+					   unsigned long rate)
+{
+	const struct jh7110_pll_syscon_val *val;
+	unsigned int id;
+	unsigned long rate_diff;
+
+	/* compare the frequency one by one from small to large in order */
+	for (id = 0; id < data->conf.preset_val_nums; id++) {
+		val = &data->conf.preset_val[id];
+
+		if (rate == val->freq)
+			goto match_end;
+
+		/* select near frequency */
+		if (rate < val->freq) {
+			/* The last frequency is closer to the target rate than this time. */
+			if (id > 0)
+				if (rate_diff < jh7110_pll_rate_sub_fabs(rate, val->freq))
+					id--;
+
+			goto match_end;
+		} else {
+			rate_diff = jh7110_pll_rate_sub_fabs(rate, val->freq);
+		}
+	}
+
+match_end:
+	data->freq_select_idx = id;
+}
+
+static int jh7110_pll_set_freq_syscon(struct jh7110_clk_pll_data *data)
+{
+	struct jh7110_clk_pll_priv *priv = jh7110_pll_priv_from(data);
+	struct jh7110_pll_syscon_offset *offset = &data->conf.offsets;
+	struct jh7110_pll_syscon_mask *mask = &data->conf.masks;
+	struct jh7110_pll_syscon_shift *shift = &data->conf.shifts;
+	const struct jh7110_pll_syscon_val *val = &data->conf.preset_val[data->freq_select_idx];
+
+	/* frac: Integer Mode (Both 1) or Fraction Mode (Both 0) */
+	if (val->dacpd == 0 && val->dsmpd == 0)
+		regmap_update_bits(priv->syscon_regmap, offset->frac, mask->frac,
+				   (val->frac << shift->frac));
+	else if (val->dacpd != val->dsmpd)
+		return -EINVAL;
+
+	/* fbdiv value should be 8 to 4095 */
+	if (val->fbdiv < 8)
+		return -EINVAL;
+
+	regmap_update_bits(priv->syscon_regmap, offset->dacpd, mask->dacpd,
+			   (val->dacpd << shift->dacpd));
+	regmap_update_bits(priv->syscon_regmap, offset->dsmpd, mask->dsmpd,
+			   (val->dsmpd << shift->dsmpd));
+	regmap_update_bits(priv->syscon_regmap, offset->prediv, mask->prediv,
+			   (val->prediv << shift->prediv));
+	regmap_update_bits(priv->syscon_regmap, offset->fbdiv, mask->fbdiv,
+			   (val->fbdiv << shift->fbdiv));
+	regmap_update_bits(priv->syscon_regmap, offset->postdiv1, mask->postdiv1,
+			   ((val->postdiv1 >> 1) << shift->postdiv1));
+
+	return 0;
+}
+
+static unsigned long jh7110_pll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct jh7110_clk_pll_data *data = jh7110_pll_data_from(hw);
+
+	return jh7110_pll_get_freq(data, parent_rate);
+}
+
+static int jh7110_pll_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
+{
+	struct jh7110_clk_pll_data *data = jh7110_pll_data_from(hw);
+
+	jh7110_pll_select_near_freq_id(data, req->rate);
+	req->rate = data->conf.preset_val[data->freq_select_idx].freq;
+
+	return 0;
+}
+
+static int jh7110_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long parent_rate)
+{
+	struct jh7110_clk_pll_data *data = jh7110_pll_data_from(hw);
+
+	return jh7110_pll_set_freq_syscon(data);
+}
+
+#ifdef CONFIG_DEBUG_FS
+static void jh7110_pll_debug_init(struct clk_hw *hw, struct dentry *dentry)
+{
+	static const struct debugfs_reg32 jh7110_clk_pll_reg = {
+		.name = "CTRL",
+		.offset = 0,
+	};
+	struct jh7110_clk_pll_data *data = jh7110_pll_data_from(hw);
+	struct jh7110_clk_pll_priv *priv = jh7110_pll_priv_from(data);
+	struct debugfs_regset32 *regset;
+
+	regset = devm_kzalloc(priv->dev, sizeof(*regset), GFP_KERNEL);
+	if (!regset)
+		return;
+
+	regset->regs = &jh7110_clk_pll_reg;
+	regset->nregs = 1;
+
+	debugfs_create_regset32("registers", 0400, dentry, regset);
+}
+#else
+#define jh7110_pll_debug_init NULL
+#endif
+
+static const struct clk_ops jh7110_pll_ops = {
+	.recalc_rate = jh7110_pll_recalc_rate,
+	.determine_rate = jh7110_pll_determine_rate,
+	.set_rate = jh7110_pll_set_rate,
+	.debug_init = jh7110_pll_debug_init,
+};
+
+static struct clk_hw *jh7110_pll_get(struct of_phandle_args *clkspec, void *data)
+{
+	struct jh7110_clk_pll_priv *priv = data;
+	unsigned int idx = clkspec->args[0];
+
+	if (idx < priv->pll_nums)
+		return &priv->data[idx].hw;
+
+	return ERR_PTR(-EINVAL);
+}
+
+static int jh7110_pll_probe(struct platform_device *pdev)
+{
+	const struct jh7110_pll_conf_variant *variant;
+	struct jh7110_clk_pll_priv *priv;
+	struct jh7110_clk_pll_data *data;
+	int ret;
+	unsigned int idx;
+
+	variant = of_device_get_match_data(&pdev->dev);
+	if (!variant)
+		return -ENOMEM;
+
+	priv = devm_kzalloc(&pdev->dev, struct_size(priv, data, variant->pll_nums),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = &pdev->dev;
+	priv->syscon_regmap = syscon_node_to_regmap(priv->dev->of_node->parent);
+	if (IS_ERR(priv->syscon_regmap))
+		return PTR_ERR(priv->syscon_regmap);
+
+	priv->pll_nums = variant->pll_nums;
+	for (idx = 0; idx < priv->pll_nums; idx++) {
+		struct clk_parent_data parents = {
+			.index = 0,
+		};
+		struct clk_init_data init = {
+			.name = variant->conf[idx].name,
+			.ops = &jh7110_pll_ops,
+			.parent_data = &parents,
+			.num_parents = 1,
+			.flags = 0,
+		};
+
+		data = &priv->data[idx];
+		data->conf = variant->conf[idx];
+		data->hw.init = &init;
+		data->idx = idx;
+
+		ret = devm_clk_hw_register(&pdev->dev, &data->hw);
+		if (ret)
+			return ret;
+	}
+
+	return devm_of_clk_add_hw_provider(&pdev->dev, jh7110_pll_get, priv);
+}
+
+static const struct of_device_id jh7110_pll_match[] = {
+	{ .compatible = "starfive,jh7110-pll", .data = &jh7110_pll_variant },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, jh7110_pll_match);
+
+static struct platform_driver jh7110_pll_driver = {
+	.driver = {
+		.name = "clk-starfive-jh7110-pll",
+		.of_match_table = jh7110_pll_match,
+	},
+};
+builtin_platform_driver_probe(jh7110_pll_driver, jh7110_pll_probe);
diff --git a/drivers/clk/starfive/clk-starfive-jh7110-pll.h b/drivers/clk/starfive/clk-starfive-jh7110-pll.h
new file mode 100644
index 000000000000..526f21670fe3
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jh7110-pll.h
@@ -0,0 +1,331 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ * StarFive JH7110 PLL Clock Generator Driver
+ *
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ */
+
+#ifndef _CLK_STARFIVE_JH7110_PLL_H_
+#define _CLK_STARFIVE_JH7110_PLL_H_
+
+#include <linux/bits.h>
+
+/* The decimal places are counted by expanding them by a factor of STARFIVE_PLL_FRAC_PATR_SIZE */
+#define STARFIVE_PLL_FRAC_PATR_SIZE		1000
+
+#define STARFIVE_JH7110_CLK_PLL0_OUT_DACPD_OFFSET	0x18
+#define STARFIVE_JH7110_CLK_PLL0_OUT_DACPD_SHIFT	24
+#define STARFIVE_JH7110_CLK_PLL0_OUT_DACPD_MASK		BIT(24)
+#define STARFIVE_JH7110_CLK_PLL0_OUT_DSMPD_OFFSET	0x18
+#define STARFIVE_JH7110_CLK_PLL0_OUT_DSMPD_SHIFT	25
+#define STARFIVE_JH7110_CLK_PLL0_OUT_DSMPD_MASK		BIT(25)
+#define STARFIVE_JH7110_CLK_PLL0_OUT_FBDIV_OFFSET	0x1c
+#define STARFIVE_JH7110_CLK_PLL0_OUT_FBDIV_SHIFT	0
+#define STARFIVE_JH7110_CLK_PLL0_OUT_FBDIV_MASK		GENMASK(11, 0)
+#define STARFIVE_JH7110_CLK_PLL0_OUT_FRAC_OFFSET	0x20
+#define STARFIVE_JH7110_CLK_PLL0_OUT_FRAC_SHIFT		0
+#define STARFIVE_JH7110_CLK_PLL0_OUT_FRAC_MASK		GENMASK(23, 0)
+#define STARFIVE_JH7110_CLK_PLL0_OUT_POSTDIV1_OFFSET	0x20
+#define STARFIVE_JH7110_CLK_PLL0_OUT_POSTDIV1_SHIFT	28
+#define STARFIVE_JH7110_CLK_PLL0_OUT_POSTDIV1_MASK	GENMASK(29, 28)
+#define STARFIVE_JH7110_CLK_PLL0_OUT_PREDIV_OFFSET	0x24
+#define STARFIVE_JH7110_CLK_PLL0_OUT_PREDIV_SHIFT	0
+#define STARFIVE_JH7110_CLK_PLL0_OUT_PREDIV_MASK	GENMASK(5, 0)
+
+#define STARFIVE_JH7110_CLK_PLL1_OUT_DACPD_OFFSET	0x24
+#define STARFIVE_JH7110_CLK_PLL1_OUT_DACPD_SHIFT	15
+#define STARFIVE_JH7110_CLK_PLL1_OUT_DACPD_MASK		BIT(15)
+#define STARFIVE_JH7110_CLK_PLL1_OUT_DSMPD_OFFSET	0x24
+#define STARFIVE_JH7110_CLK_PLL1_OUT_DSMPD_SHIFT	16
+#define STARFIVE_JH7110_CLK_PLL1_OUT_DSMPD_MASK		BIT(16)
+#define STARFIVE_JH7110_CLK_PLL1_OUT_FBDIV_OFFSET	0x24
+#define STARFIVE_JH7110_CLK_PLL1_OUT_FBDIV_SHIFT	17
+#define STARFIVE_JH7110_CLK_PLL1_OUT_FBDIV_MASK		GENMASK(28, 17)
+#define STARFIVE_JH7110_CLK_PLL1_OUT_FRAC_OFFSET	0x28
+#define STARFIVE_JH7110_CLK_PLL1_OUT_FRAC_SHIFT		0
+#define STARFIVE_JH7110_CLK_PLL1_OUT_FRAC_MASK		GENMASK(23, 0)
+#define STARFIVE_JH7110_CLK_PLL1_OUT_POSTDIV1_OFFSET	0x28
+#define STARFIVE_JH7110_CLK_PLL1_OUT_POSTDIV1_SHIFT	28
+#define STARFIVE_JH7110_CLK_PLL1_OUT_POSTDIV1_MASK	GENMASK(29, 28)
+#define STARFIVE_JH7110_CLK_PLL1_OUT_PREDIV_OFFSET	0x2c
+#define STARFIVE_JH7110_CLK_PLL1_OUT_PREDIV_SHIFT	0
+#define STARFIVE_JH7110_CLK_PLL1_OUT_PREDIV_MASK	GENMASK(5, 0)
+
+#define STARFIVE_JH7110_CLK_PLL2_OUT_DACPD_OFFSET	0x2c
+#define STARFIVE_JH7110_CLK_PLL2_OUT_DACPD_SHIFT	15
+#define STARFIVE_JH7110_CLK_PLL2_OUT_DACPD_MASK		BIT(15)
+#define STARFIVE_JH7110_CLK_PLL2_OUT_DSMPD_OFFSET	0x2c
+#define STARFIVE_JH7110_CLK_PLL2_OUT_DSMPD_SHIFT	16
+#define STARFIVE_JH7110_CLK_PLL2_OUT_DSMPD_MASK		BIT(16)
+#define STARFIVE_JH7110_CLK_PLL2_OUT_FBDIV_OFFSET	0x2c
+#define STARFIVE_JH7110_CLK_PLL2_OUT_FBDIV_SHIFT	17
+#define STARFIVE_JH7110_CLK_PLL2_OUT_FBDIV_MASK		GENMASK(28, 17)
+#define STARFIVE_JH7110_CLK_PLL2_OUT_FRAC_OFFSET	0x30
+#define STARFIVE_JH7110_CLK_PLL2_OUT_FRAC_SHIFT		0
+#define STARFIVE_JH7110_CLK_PLL2_OUT_FRAC_MASK		GENMASK(23, 0)
+#define STARFIVE_JH7110_CLK_PLL2_OUT_POSTDIV1_OFFSET	0x30
+#define STARFIVE_JH7110_CLK_PLL2_OUT_POSTDIV1_SHIFT	28
+#define STARFIVE_JH7110_CLK_PLL2_OUT_POSTDIV1_MASK	GENMASK(29, 28)
+#define STARFIVE_JH7110_CLK_PLL2_OUT_PREDIV_OFFSET	0x34
+#define STARFIVE_JH7110_CLK_PLL2_OUT_PREDIV_SHIFT	0
+#define STARFIVE_JH7110_CLK_PLL2_OUT_PREDIV_MASK	GENMASK(5, 0)
+
+#define JH7110_PLL(_idx, _name, _nums, _val)			\
+[_idx] = {							\
+	.name = _name,						\
+	.offsets = {						\
+		.dacpd = STARFIVE_##_idx##_DACPD_OFFSET,	\
+		.dsmpd = STARFIVE_##_idx##_DSMPD_OFFSET,	\
+		.fbdiv = STARFIVE_##_idx##_FBDIV_OFFSET,	\
+		.frac = STARFIVE_##_idx##_FRAC_OFFSET,		\
+		.prediv = STARFIVE_##_idx##_PREDIV_OFFSET,	\
+		.postdiv1 = STARFIVE_##_idx##_POSTDIV1_OFFSET,	\
+	},							\
+	.masks = {						\
+		.dacpd = STARFIVE_##_idx##_DACPD_MASK,		\
+		.dsmpd = STARFIVE_##_idx##_DSMPD_MASK,		\
+		.fbdiv = STARFIVE_##_idx##_FBDIV_MASK,		\
+		.frac = STARFIVE_##_idx##_FRAC_MASK,		\
+		.prediv = STARFIVE_##_idx##_PREDIV_MASK,	\
+		.postdiv1 = STARFIVE_##_idx##_POSTDIV1_MASK,	\
+	},							\
+	.shifts = {						\
+		.dacpd = STARFIVE_##_idx##_DACPD_SHIFT,		\
+		.dsmpd = STARFIVE_##_idx##_DSMPD_SHIFT,		\
+		.fbdiv = STARFIVE_##_idx##_FBDIV_SHIFT,		\
+		.frac = STARFIVE_##_idx##_FRAC_SHIFT,		\
+		.prediv = STARFIVE_##_idx##_PREDIV_SHIFT,	\
+		.postdiv1 = STARFIVE_##_idx##_POSTDIV1_SHIFT,	\
+	},							\
+	.preset_val_nums = _nums,				\
+	.preset_val = _val,					\
+}
+
+struct jh7110_pll_syscon_offset {
+	unsigned int dacpd;
+	unsigned int dsmpd;
+	unsigned int fbdiv;
+	unsigned int frac;
+	unsigned int prediv;
+	unsigned int postdiv1;
+};
+
+struct jh7110_pll_syscon_mask {
+	u32 dacpd;
+	u32 dsmpd;
+	u32 fbdiv;
+	u32 frac;
+	u32 prediv;
+	u32 postdiv1;
+};
+
+struct jh7110_pll_syscon_shift {
+	char dacpd;
+	char dsmpd;
+	char fbdiv;
+	char frac;
+	char prediv;
+	char postdiv1;
+};
+
+struct jh7110_pll_syscon_val {
+	unsigned long freq;
+	u32 prediv;
+	u32 fbdiv;
+	u32 postdiv1;
+/* Both daxpd and dsmpd set 1 while integer mode */
+/* Both daxpd and dsmpd set 0 while fraction mode */
+	u32 dacpd;
+	u32 dsmpd;
+/* frac value should be decimals multiplied by 2^24 */
+	u32 frac;
+};
+
+struct jh7110_pll_syscon_conf {
+	char *name;
+	struct jh7110_pll_syscon_offset offsets;
+	struct jh7110_pll_syscon_mask masks;
+	struct jh7110_pll_syscon_shift shifts;
+	unsigned int preset_val_nums;
+	const struct jh7110_pll_syscon_val *preset_val;
+};
+
+struct jh7110_clk_pll_data {
+	struct clk_hw hw;
+	unsigned int idx;
+	unsigned int freq_select_idx;
+	struct jh7110_pll_syscon_conf conf;
+};
+
+struct jh7110_clk_pll_priv {
+	unsigned int pll_nums;
+	struct device *dev;
+	struct regmap *syscon_regmap;
+	struct jh7110_clk_pll_data data[];
+};
+
+enum jh7110_pll0_freq_index {
+	JH7110_PLL0_FREQ_375 = 0,
+	JH7110_PLL0_FREQ_500,
+	JH7110_PLL0_FREQ_625,
+	JH7110_PLL0_FREQ_750,
+	JH7110_PLL0_FREQ_875,
+	JH7110_PLL0_FREQ_1000,
+	JH7110_PLL0_FREQ_1250,
+	JH7110_PLL0_FREQ_1375,
+	JH7110_PLL0_FREQ_1500,
+	JH7110_PLL0_FREQ_MAX
+};
+
+enum jh7110_pll1_freq_index {
+	JH7110_PLL1_FREQ_1066 = 0,
+	JH7110_PLL1_FREQ_1200,
+	JH7110_PLL1_FREQ_1400,
+	JH7110_PLL1_FREQ_1600,
+	JH7110_PLL1_FREQ_MAX
+};
+
+enum jh7110_pll2_freq_index {
+	JH7110_PLL2_FREQ_1188 = 0,
+	JH7110_PLL2_FREQ_12288,
+	JH7110_PLL2_FREQ_MAX
+};
+
+/*
+ * Because the pll frequency is relatively fixed,
+ * it cannot be set arbitrarily, so it needs a specific configuration.
+ * PLL0 frequency should be multiple of 125MHz (USB frequency).
+ */
+static const struct jh7110_pll_syscon_val
+	jh7110_pll0_syscon_val_preset[] = {
+	[JH7110_PLL0_FREQ_375] = {
+		.freq = 375000000,
+		.prediv = 8,
+		.fbdiv = 125,
+		.postdiv1 = 1,
+		.dacpd = 1,
+		.dsmpd = 1,
+	},
+	[JH7110_PLL0_FREQ_500] = {
+		.freq = 500000000,
+		.prediv = 6,
+		.fbdiv = 125,
+		.postdiv1 = 1,
+		.dacpd = 1,
+		.dsmpd = 1,
+	},
+	[JH7110_PLL0_FREQ_625] = {
+		.freq = 625000000,
+		.prediv = 24,
+		.fbdiv = 625,
+		.postdiv1 = 1,
+		.dacpd = 1,
+		.dsmpd = 1,
+	},
+	[JH7110_PLL0_FREQ_750] = {
+		.freq = 750000000,
+		.prediv = 4,
+		.fbdiv = 125,
+		.postdiv1 = 1,
+		.dacpd = 1,
+		.dsmpd = 1,
+	},
+	[JH7110_PLL0_FREQ_875] = {
+		.freq = 875000000,
+		.prediv = 24,
+		.fbdiv = 875,
+		.postdiv1 = 1,
+		.dacpd = 1,
+		.dsmpd = 1,
+	},
+	[JH7110_PLL0_FREQ_1000] = {
+		.freq = 1000000000,
+		.prediv = 3,
+		.fbdiv = 125,
+		.postdiv1 = 1,
+		.dacpd = 1,
+		.dsmpd = 1,
+	},
+	[JH7110_PLL0_FREQ_1250] = {
+		.freq = 1250000000,
+		.prediv = 12,
+		.fbdiv = 625,
+		.postdiv1 = 1,
+		.dacpd = 1,
+		.dsmpd = 1,
+	},
+	[JH7110_PLL0_FREQ_1375] = {
+		.freq = 1375000000,
+		.prediv = 24,
+		.fbdiv = 1375,
+		.postdiv1 = 1,
+		.dacpd = 1,
+		.dsmpd = 1,
+	},
+	[JH7110_PLL0_FREQ_1500] = {
+		.freq = 1500000000,
+		.prediv = 2,
+		.fbdiv = 125,
+		.postdiv1 = 1,
+		.dacpd = 1,
+		.dsmpd = 1,
+	},
+};
+
+static const struct jh7110_pll_syscon_val
+	jh7110_pll1_syscon_val_preset[] = {
+	[JH7110_PLL1_FREQ_1066] = {
+		.freq = 1066000000,
+		.prediv = 12,
+		.fbdiv = 533,
+		.postdiv1 = 1,
+		.dacpd = 1,
+		.dsmpd = 1,
+	},
+	[JH7110_PLL1_FREQ_1200] = {
+		.freq = 1200000000,
+		.prediv = 1,
+		.fbdiv = 50,
+		.postdiv1 = 1,
+		.dacpd = 1,
+		.dsmpd = 1,
+	},
+	[JH7110_PLL1_FREQ_1400] = {
+		.freq = 1400000000,
+		.prediv = 6,
+		.fbdiv = 350,
+		.postdiv1 = 1,
+		.dacpd = 1,
+		.dsmpd = 1,
+	},
+	[JH7110_PLL1_FREQ_1600] = {
+		.freq = 1600000000,
+		.prediv = 3,
+		.fbdiv = 200,
+		.postdiv1 = 1,
+		.dacpd = 1,
+		.dsmpd = 1,
+	},
+};
+
+static const struct jh7110_pll_syscon_val
+	jh7110_pll2_syscon_val_preset[] = {
+	[JH7110_PLL2_FREQ_1188] = {
+		.freq = 1188000000,
+		.prediv = 2,
+		.fbdiv = 99,
+		.postdiv1 = 1,
+		.dacpd = 1,
+		.dsmpd = 1,
+	},
+	[JH7110_PLL2_FREQ_12288] = {
+		.freq = 1228800000,
+		.prediv = 5,
+		.fbdiv = 256,
+		.postdiv1 = 1,
+		.dacpd = 1,
+		.dsmpd = 1,
+	},
+};
+
+#endif
-- 
2.25.1

