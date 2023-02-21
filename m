Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F6269E210
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 15:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbjBUOMK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Feb 2023 09:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbjBUOL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 09:11:58 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3861327D4E;
        Tue, 21 Feb 2023 06:11:55 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id A975024E1D4;
        Tue, 21 Feb 2023 22:11:53 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 21 Feb
 2023 22:11:53 +0800
Received: from localhost.localdomain (183.27.98.67) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 21 Feb
 2023 22:11:52 +0800
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <kernel@esmil.dk>
CC:     Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: [PATCH v1 2/3] clk: starfive: Add StarFive JH7110 PLL clock driver
Date:   Tue, 21 Feb 2023 22:11:46 +0800
Message-ID: <20230221141147.303642-3-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230221141147.303642-1-xingyu.wu@starfivetech.com>
References: <20230221141147.303642-1-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.98.67]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for the StarFive JH7110 PLL clock controller and
modify the JH7110 system clock driver to rely on this PLL clocks.

Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 drivers/clk/starfive/Kconfig                  |   9 +
 drivers/clk/starfive/Makefile                 |   1 +
 .../clk/starfive/clk-starfive-jh7110-pll.c    | 433 ++++++++++++++++++
 .../clk/starfive/clk-starfive-jh7110-pll.h    | 286 ++++++++++++
 .../clk/starfive/clk-starfive-jh7110-sys.c    |  40 +-
 5 files changed, 742 insertions(+), 27 deletions(-)
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-pll.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-pll.h

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index 2aa664f2cdee..5bac840ba682 100644
--- a/drivers/clk/starfive/Kconfig
+++ b/drivers/clk/starfive/Kconfig
@@ -21,12 +21,21 @@ config CLK_STARFIVE_JH7100_AUDIO
 	  Say Y or M here to support the audio clocks on the StarFive JH7100
 	  SoC.
 
+config CLK_STARFIVE_JH7110_PLL
+	bool "StarFive JH7110 PLL clock support"
+	depends on SOC_STARFIVE || COMPILE_TEST
+	default SOC_STARFIVE
+	help
+	  Say yes here to support the PLL clock controller on the
+	  StarFive JH7110 SoC.
+
 config CLK_STARFIVE_JH7110_SYS
 	bool "StarFive JH7110 system clock support"
 	depends on SOC_STARFIVE || COMPILE_TEST
 	select AUXILIARY_BUS
 	select CLK_STARFIVE_JH71X0
 	select RESET_STARFIVE_JH7110
+	select CLK_STARFIVE_JH7110_PLL
 	default SOC_STARFIVE
 	help
 	  Say yes here to support the system clock controller on the
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
index 000000000000..320297859a23
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jh7110-pll.c
@@ -0,0 +1,433 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive JH7110 PLL Clock Generator Driver
+ *
+ * Copyright (C) 2022 StarFive Technology Co., Ltd.
+ * Copyright (C) 2022 Xingyu Wu <xingyu.wu@starfivetech.com>
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
+#include <linux/mfd/syscon.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/clock/starfive,jh7110-crg.h>
+
+#include "clk-starfive-jh7110-pll.h"
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
+static unsigned long pll_get_freq(struct jh7110_clk_pll_data *data, unsigned long parent_rate)
+{
+	u32 dacpd;
+	u32 dsmpd;
+	u32 fbdiv;
+	u32 prediv;
+	u32 postdiv1;
+	u32 frac;
+	u32 reg_value;
+	unsigned long frac_cal;
+	unsigned long freq;
+	struct pll_syscon_offset *offset = &data->offset;
+	struct pll_syscon_mask *mask = &data->mask;
+	struct pll_syscon_shift *shift = &data->shift;
+	struct jh7110_clk_pll_priv *priv = jh7110_pll_priv_from(data);
+
+	if (regmap_read(priv->syscon_regmap,
+			offset->dacpd_offset, &reg_value))
+		goto read_register_error;
+	dacpd = (reg_value & mask->dacpd_mask) >> shift->dacpd_shift;
+
+	if (regmap_read(priv->syscon_regmap,
+			offset->dsmpd_offset, &reg_value))
+		goto read_register_error;
+	dsmpd = (reg_value & mask->dsmpd_mask) >> shift->dsmpd_shift;
+
+	if (regmap_read(priv->syscon_regmap,
+			offset->fbdiv_offset, &reg_value))
+		goto read_register_error;
+	fbdiv = (reg_value & mask->fbdiv_mask) >> shift->fbdiv_shift;
+	/* fbdiv value should be 8 to 4095 */
+	if (fbdiv < 8)
+		goto read_register_error;
+
+	if (regmap_read(priv->syscon_regmap,
+			offset->prediv_offset, &reg_value))
+		goto read_register_error;
+	prediv = (reg_value & mask->prediv_mask) >> shift->prediv_shift;
+
+	if (regmap_read(priv->syscon_regmap,
+			offset->postdiv1_offset, &reg_value))
+		goto read_register_error;
+	/* postdiv1 = 2 ^ reg_value */
+	postdiv1 = 1 << ((reg_value & mask->postdiv1_mask) >>
+			shift->postdiv1_shift);
+
+	if (regmap_read(priv->syscon_regmap,
+			offset->frac_offset, &reg_value))
+		goto read_register_error;
+	frac = (reg_value & mask->frac_mask) >> shift->frac_shift;
+
+	/* Integer Mode or Fraction Mode */
+	/* The decimal places are counted by expanding them by a factor of FRAC_PATR_SIZE. */
+	if (dacpd == 1 && dsmpd == 1)
+		frac_cal = 0;
+	else
+		frac_cal = (unsigned long)frac * FRAC_PATR_SIZE / (1 << 24);
+
+	freq = parent_rate / FRAC_PATR_SIZE *
+	       (fbdiv * FRAC_PATR_SIZE + frac_cal) / prediv / postdiv1;
+
+	dev_dbg(priv->dev, "pll%d calculate freq:%ld\n", data->idx, freq);
+	return freq;
+
+read_register_error:
+	dev_err(priv->dev, "PLL read syscon error.\n");
+	return 0;
+}
+
+static int pll_select_freq_syscon(struct jh7110_clk_pll_data *data, unsigned long target_rate)
+{
+	unsigned int id;
+	unsigned int pll_arry_size;
+	const struct starfive_pll_syscon_value *syscon_value;
+	struct jh7110_clk_pll_priv *priv = jh7110_pll_priv_from(data);
+
+	if (data->idx == JH7110_CLK_PLL0_OUT)
+		pll_arry_size = ARRAY_SIZE(jh7110_pll0_syscon_freq);
+	else if (data->idx == JH7110_CLK_PLL1_OUT)
+		pll_arry_size = ARRAY_SIZE(jh7110_pll1_syscon_freq);
+	else
+		pll_arry_size = ARRAY_SIZE(jh7110_pll2_syscon_freq);
+
+	for (id = 0; id < pll_arry_size; id++) {
+		if (data->idx == JH7110_CLK_PLL0_OUT)
+			syscon_value = &jh7110_pll0_syscon_freq[id];
+		else if (data->idx == JH7110_CLK_PLL1_OUT)
+			syscon_value = &jh7110_pll1_syscon_freq[id];
+		else
+			syscon_value = &jh7110_pll2_syscon_freq[id];
+
+		if (target_rate == syscon_value->freq)
+			goto select_end;
+	}
+
+	dev_err(priv->dev, "pll%d frequency:%ld do not match, please check it.\n",
+		data->idx, target_rate);
+	return -EINVAL;
+
+select_end:
+	data->freq_select_idx = id;
+	return 0;
+}
+
+static int pll_set_freq_syscon(struct jh7110_clk_pll_data *data)
+{
+	int ret;
+	const struct starfive_pll_syscon_value *syscon_value;
+	unsigned int freq_idx = data->freq_select_idx;
+	struct pll_syscon_offset *offset = &data->offset;
+	struct pll_syscon_mask *mask = &data->mask;
+	struct pll_syscon_shift *shift = &data->shift;
+	struct jh7110_clk_pll_priv *priv = jh7110_pll_priv_from(data);
+
+	if (data->idx == JH7110_CLK_PLL0_OUT)
+		syscon_value = &jh7110_pll0_syscon_freq[freq_idx];
+	else if (data->idx == JH7110_CLK_PLL1_OUT)
+		syscon_value = &jh7110_pll1_syscon_freq[freq_idx];
+	else
+		syscon_value = &jh7110_pll2_syscon_freq[freq_idx];
+
+	ret = regmap_update_bits(priv->syscon_regmap, offset->dacpd_offset, mask->dacpd_mask,
+				 (syscon_value->dacpd << shift->dacpd_shift));
+	if (ret)
+		goto set_failed;
+
+	ret = regmap_update_bits(priv->syscon_regmap, offset->dsmpd_offset, mask->dsmpd_mask,
+				 (syscon_value->dsmpd << shift->dsmpd_shift));
+	if (ret)
+		goto set_failed;
+
+	ret = regmap_update_bits(priv->syscon_regmap, offset->prediv_offset, mask->prediv_mask,
+				 (syscon_value->prediv << shift->prediv_shift));
+	if (ret)
+		goto set_failed;
+
+	ret = regmap_update_bits(priv->syscon_regmap, offset->fbdiv_offset, mask->fbdiv_mask,
+				 (syscon_value->fbdiv << shift->fbdiv_shift));
+	if (ret)
+		goto set_failed;
+
+	ret = regmap_update_bits(priv->syscon_regmap, offset->postdiv1_offset,
+				 mask->postdiv1_mask,
+				 ((syscon_value->postdiv1 >> 1) << shift->postdiv1_shift));
+	if (ret)
+		goto set_failed;
+	/* frac */
+	if (syscon_value->dacpd == 0 && syscon_value->dsmpd == 0) {
+		ret = regmap_update_bits(priv->syscon_regmap, offset->frac_offset,
+					 mask->frac_mask,
+					 (syscon_value->frac << shift->frac_shift));
+		if (ret)
+			goto set_failed;
+	}
+
+	dev_dbg(priv->dev, "pll%d set syscon register done and rate is %ld\n",
+		data->idx, syscon_value->freq);
+	return 0;
+
+set_failed:
+	dev_err(priv->dev, "pll set syscon failed:%d\n", ret);
+	return ret;
+}
+
+static unsigned long jh7110_clk_pll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct jh7110_clk_pll_data *data = jh7110_pll_data_from(hw);
+
+	return pll_get_freq(data, parent_rate);
+}
+
+static int jh7110_clk_pll_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
+{
+	int ret;
+	struct jh7110_clk_pll_data *data = jh7110_pll_data_from(hw);
+
+	ret = pll_select_freq_syscon(data, req->rate);
+	if (ret)
+		return ret;
+
+	if (data->idx == JH7110_CLK_PLL0_OUT)
+		req->rate = jh7110_pll0_syscon_freq[data->freq_select_idx].freq;
+	else if (data->idx == JH7110_CLK_PLL1_OUT)
+		req->rate = jh7110_pll1_syscon_freq[data->freq_select_idx].freq;
+	else
+		req->rate = jh7110_pll2_syscon_freq[data->freq_select_idx].freq;
+
+	return 0;
+}
+
+static int jh7110_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+				   unsigned long parent_rate)
+{
+	struct jh7110_clk_pll_data *data = jh7110_pll_data_from(hw);
+
+	return pll_set_freq_syscon(data);
+}
+
+#ifdef CONFIG_DEBUG_FS
+static void jh7110_clk_pll_debug_init(struct clk_hw *hw, struct dentry *dentry)
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
+#define jh7110_clk_pll_debug_init NULL
+#endif
+
+static const struct clk_ops jh7110_clk_pll_ops = {
+	.recalc_rate = jh7110_clk_pll_recalc_rate,
+	.determine_rate = jh7110_clk_pll_determine_rate,
+	.set_rate = jh7110_clk_pll_set_rate,
+	.debug_init = jh7110_clk_pll_debug_init,
+};
+
+static int pll_data_offset_get(struct jh7110_clk_pll_data *data, int index)
+{
+	struct pll_syscon_offset *offset = &data->offset;
+	struct pll_syscon_mask *mask = &data->mask;
+	struct pll_syscon_shift *shift = &data->shift;
+
+	if (index == JH7110_CLK_PLL0_OUT) {
+		offset->dacpd_offset = PLL0_DACPD_OFFSET;
+		offset->dsmpd_offset = PLL0_DSMPD_OFFSET;
+		offset->fbdiv_offset = PLL0_FBDIV_OFFSET;
+		offset->frac_offset = PLL0_FRAC_OFFSET;
+		offset->prediv_offset = PLL0_PREDIV_OFFSET;
+		offset->postdiv1_offset = PLL0_POSTDIV1_OFFSET;
+
+		mask->dacpd_mask = PLL0_DACPD_MASK;
+		mask->dsmpd_mask = PLL0_DSMPD_MASK;
+		mask->fbdiv_mask = PLL0_FBDIV_MASK;
+		mask->frac_mask = PLL0_FRAC_MASK;
+		mask->prediv_mask = PLL0_PREDIV_MASK;
+		mask->postdiv1_mask = PLL0_POSTDIV1_MASK;
+
+		shift->dacpd_shift = PLL0_DACPD_SHIFT;
+		shift->dsmpd_shift = PLL0_DSMPD_SHIFT;
+		shift->fbdiv_shift = PLL0_FBDIV_SHIFT;
+		shift->frac_shift = PLL0_FRAC_SHIFT;
+		shift->prediv_shift = PLL0_PREDIV_SHIFT;
+		shift->postdiv1_shift = PLL0_POSTDIV1_SHIFT;
+	} else if (index == JH7110_CLK_PLL1_OUT) {
+		offset->dacpd_offset = PLL1_DACPD_OFFSET;
+		offset->dsmpd_offset = PLL1_DSMPD_OFFSET;
+		offset->fbdiv_offset = PLL1_FBDIV_OFFSET;
+		offset->frac_offset = PLL1_FRAC_OFFSET;
+		offset->prediv_offset = PLL1_PREDIV_OFFSET;
+		offset->postdiv1_offset = PLL1_POSTDIV1_OFFSET;
+
+		mask->dacpd_mask = PLL1_DACPD_MASK;
+		mask->dsmpd_mask = PLL1_DSMPD_MASK;
+		mask->fbdiv_mask = PLL1_FBDIV_MASK;
+		mask->frac_mask = PLL1_FRAC_MASK;
+		mask->prediv_mask = PLL1_PREDIV_MASK;
+		mask->postdiv1_mask = PLL1_POSTDIV1_MASK;
+
+		shift->dacpd_shift = PLL1_DACPD_SHIFT;
+		shift->dsmpd_shift = PLL1_DSMPD_SHIFT;
+		shift->fbdiv_shift = PLL1_FBDIV_SHIFT;
+		shift->frac_shift = PLL1_FRAC_SHIFT;
+		shift->prediv_shift = PLL1_PREDIV_SHIFT;
+		shift->postdiv1_shift = PLL1_POSTDIV1_SHIFT;
+	} else if (index == JH7110_CLK_PLL2_OUT) {
+		offset->dacpd_offset = PLL2_DACPD_OFFSET;
+		offset->dsmpd_offset = PLL2_DSMPD_OFFSET;
+		offset->fbdiv_offset = PLL2_FBDIV_OFFSET;
+		offset->frac_offset = PLL2_FRAC_OFFSET;
+		offset->prediv_offset = PLL2_PREDIV_OFFSET;
+		offset->postdiv1_offset = PLL2_POSTDIV1_OFFSET;
+
+		mask->dacpd_mask = PLL2_DACPD_MASK;
+		mask->dsmpd_mask = PLL2_DSMPD_MASK;
+		mask->fbdiv_mask = PLL2_FBDIV_MASK;
+		mask->frac_mask = PLL2_FRAC_MASK;
+		mask->prediv_mask = PLL2_PREDIV_MASK;
+		mask->postdiv1_mask = PLL2_POSTDIV1_MASK;
+
+		shift->dacpd_shift = PLL2_DACPD_SHIFT;
+		shift->dsmpd_shift = PLL2_DSMPD_SHIFT;
+		shift->fbdiv_shift = PLL2_FBDIV_SHIFT;
+		shift->frac_shift = PLL2_FRAC_SHIFT;
+		shift->prediv_shift = PLL2_PREDIV_SHIFT;
+		shift->postdiv1_shift = PLL2_POSTDIV1_SHIFT;
+	} else {
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
+static struct clk_hw *jh7110_pll_clk_get(struct of_phandle_args *clkspec, void *data)
+{
+	struct jh7110_clk_pll_priv *priv = data;
+	unsigned int idx = clkspec->args[0];
+
+	if (idx < JH7110_PLLCLK_END)
+		return &priv->data[idx].hw;
+
+	return ERR_PTR(-EINVAL);
+}
+
+static int jh7110_pll_clk_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct of_phandle_args args;
+	struct regmap *pll_syscon_regmap;
+	unsigned int idx;
+	struct jh7110_clk_pll_priv *priv;
+	struct jh7110_clk_pll_data *data;
+	char *pll_name[JH7110_PLLCLK_END] = {
+		"pll0_out",
+		"pll1_out",
+		"pll2_out"
+	};
+
+	priv = devm_kzalloc(&pdev->dev,
+			    struct_size(priv, data, JH7110_PLLCLK_END),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = &pdev->dev;
+	ret = of_parse_phandle_with_fixed_args(pdev->dev.of_node, "starfive,sysreg", 0, 0, &args);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to parse starfive,sys-syscon : %d\n", ret);
+		return ret;
+	}
+
+	pll_syscon_regmap = syscon_node_to_regmap(args.np);
+	of_node_put(args.np);
+	if (IS_ERR(pll_syscon_regmap))
+		return PTR_ERR(pll_syscon_regmap);
+
+	priv->syscon_regmap = pll_syscon_regmap;
+
+	for (idx = 0; idx < JH7110_PLLCLK_END; idx++) {
+		struct clk_parent_data parents = {
+			.index = 0,
+		};
+		struct clk_init_data init = {
+			.name = pll_name[idx],
+			.ops = &jh7110_clk_pll_ops,
+			.parent_data = &parents,
+			.num_parents = 1,
+			.flags = 0,
+		};
+
+		data = &priv->data[idx];
+
+		ret = pll_data_offset_get(data, idx);
+		if (ret)
+			return ret;
+
+		data->hw.init = &init;
+		data->idx = idx;
+
+		ret = devm_clk_hw_register(&pdev->dev, &data->hw);
+		if (ret)
+			return ret;
+	}
+
+	return devm_of_clk_add_hw_provider(&pdev->dev, jh7110_pll_clk_get, priv);
+}
+
+static const struct of_device_id jh7110_pll_clk_match[] = {
+	{ .compatible = "starfive,jh7110-pll" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, jh7110_pll_clk_match);
+
+static struct platform_driver jh7110_pll_clk_driver = {
+	.driver = {
+		.name = "clk-starfive-jh7110-pll",
+		.of_match_table = jh7110_pll_clk_match,
+	},
+};
+builtin_platform_driver_probe(jh7110_pll_clk_driver, jh7110_pll_clk_probe);
diff --git a/drivers/clk/starfive/clk-starfive-jh7110-pll.h b/drivers/clk/starfive/clk-starfive-jh7110-pll.h
new file mode 100644
index 000000000000..813477e29514
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jh7110-pll.h
@@ -0,0 +1,286 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ * StarFive JH7110 PLL Clock Generator Driver
+ *
+ * Copyright (C) 2022 Xingyu Wu <xingyu.wu@starfivetech.com>
+ */
+
+#ifndef _CLK_STARFIVE_JH7110_PLL_H_
+#define _CLK_STARFIVE_JH7110_PLL_H_
+
+/* The decimal places are counted by expanding them by a factor of FRAC_PATR_SIZE. */
+#define FRAC_PATR_SIZE		1000
+
+#define PLL0_DACPD_OFFSET	0x18
+#define PLL0_DACPD_SHIFT	24
+#define PLL0_DACPD_MASK		0x1000000
+#define PLL0_DSMPD_OFFSET	0x18
+#define PLL0_DSMPD_SHIFT	25
+#define PLL0_DSMPD_MASK		0x2000000
+#define PLL0_FBDIV_OFFSET	0x1c
+#define PLL0_FBDIV_SHIFT	0
+#define PLL0_FBDIV_MASK		0xFFF
+#define PLL0_FRAC_OFFSET	0x20
+#define PLL0_FRAC_SHIFT		0
+#define PLL0_FRAC_MASK		0xFFFFFF
+#define PLL0_POSTDIV1_OFFSET	0x20
+#define PLL0_POSTDIV1_SHIFT	28
+#define PLL0_POSTDIV1_MASK	0x30000000
+#define PLL0_PREDIV_OFFSET	0x24
+#define PLL0_PREDIV_SHIFT	0
+#define PLL0_PREDIV_MASK	0x3F
+
+#define PLL1_DACPD_OFFSET	0x24
+#define PLL1_DACPD_SHIFT	15
+#define PLL1_DACPD_MASK		0x8000
+#define PLL1_DSMPD_OFFSET	0x24
+#define PLL1_DSMPD_SHIFT	16
+#define PLL1_DSMPD_MASK		0x10000
+#define PLL1_FBDIV_OFFSET	0x24
+#define PLL1_FBDIV_SHIFT	17
+#define PLL1_FBDIV_MASK		0x1FFE0000
+#define PLL1_FRAC_OFFSET	0x28
+#define PLL1_FRAC_SHIFT		0
+#define PLL1_FRAC_MASK		0xFFFFFF
+#define PLL1_POSTDIV1_OFFSET	0x28
+#define PLL1_POSTDIV1_SHIFT	28
+#define PLL1_POSTDIV1_MASK	0x30000000
+#define PLL1_PREDIV_OFFSET	0x2c
+#define PLL1_PREDIV_SHIFT	0
+#define PLL1_PREDIV_MASK	0x3F
+
+#define PLL2_DACPD_OFFSET	0x2c
+#define PLL2_DACPD_SHIFT	15
+#define PLL2_DACPD_MASK		0x8000
+#define PLL2_DSMPD_OFFSET	0x2c
+#define PLL2_DSMPD_SHIFT	16
+#define PLL2_DSMPD_MASK		0x10000
+#define PLL2_FBDIV_OFFSET	0x2c
+#define PLL2_FBDIV_SHIFT	17
+#define PLL2_FBDIV_MASK		0x1FFE0000
+#define PLL2_FRAC_OFFSET	0x30
+#define PLL2_FRAC_SHIFT		0
+#define PLL2_FRAC_MASK		0xFFFFFF
+#define PLL2_POSTDIV1_OFFSET	0x30
+#define PLL2_POSTDIV1_SHIFT	28
+#define PLL2_POSTDIV1_MASK	0x30000000
+#define PLL2_PREDIV_OFFSET	0x34
+#define PLL2_PREDIV_SHIFT	0
+#define PLL2_PREDIV_MASK	0x3F
+
+struct pll_syscon_offset {
+	u32 dacpd_offset;
+	u32 dsmpd_offset;
+	u32 fbdiv_offset;
+	u32 frac_offset;
+	u32 prediv_offset;
+	u32 postdiv1_offset;
+};
+
+struct pll_syscon_mask {
+	u32 dacpd_mask;
+	u32 dsmpd_mask;
+	u32 fbdiv_mask;
+	u32 frac_mask;
+	u32 prediv_mask;
+	u32 postdiv1_mask;
+};
+
+struct pll_syscon_shift {
+	u32 dacpd_shift;
+	u32 dsmpd_shift;
+	u32 fbdiv_shift;
+	u32 frac_shift;
+	u32 prediv_shift;
+	u32 postdiv1_shift;
+};
+
+struct jh7110_clk_pll_data {
+	struct clk_hw hw;
+	unsigned int idx;
+	unsigned int freq_select_idx;
+
+	struct pll_syscon_offset offset;
+	struct pll_syscon_mask mask;
+	struct pll_syscon_shift shift;
+};
+
+struct jh7110_clk_pll_priv {
+	struct device *dev;
+	struct regmap *syscon_regmap;
+	struct jh7110_clk_pll_data data[];
+};
+
+struct starfive_pll_syscon_value {
+	unsigned long freq;
+	u32 prediv;
+	u32 fbdiv;
+	u32 postdiv1;
+/* Both daxpd and dsmpd set 1 while integer multiple mode */
+/* Both daxpd and dsmpd set 0 while fraction multiple mode */
+	u32 dacpd;
+	u32 dsmpd;
+/* frac value should be decimals multiplied by 2^24 */
+	u32 frac;
+};
+
+enum starfive_pll0_freq {
+	PLL0_FREQ_375 = 0,
+	PLL0_FREQ_500,
+	PLL0_FREQ_625,
+	PLL0_FREQ_750,
+	PLL0_FREQ_875,
+	PLL0_FREQ_1000,
+	PLL0_FREQ_1250,
+	PLL0_FREQ_1375,
+	PLL0_FREQ_1500,
+	PLL0_FREQ_MAX
+};
+
+enum starfive_pll1_freq {
+	PLL1_FREQ_1066 = 0,
+	PLL1_FREQ_1200,
+	PLL1_FREQ_1400,
+	PLL1_FREQ_1600,
+	PLL1_FREQ_MAX
+};
+
+enum starfive_pll2_freq {
+	PLL2_FREQ_1188 = 0,
+	PLL2_FREQ_12288,
+	PLL2_FREQ_MAX
+};
+
+static const struct starfive_pll_syscon_value
+	jh7110_pll0_syscon_freq[] = {
+	[PLL0_FREQ_375] = {
+		.freq = 375000000,
+		.prediv = 8,
+		.fbdiv = 125,
+		.postdiv1 = 1,
+		.dacpd = 1,
+		.dsmpd = 1,
+	},
+	[PLL0_FREQ_500] = {
+		.freq = 500000000,
+		.prediv = 6,
+		.fbdiv = 125,
+		.postdiv1 = 1,
+		.dacpd = 1,
+		.dsmpd = 1,
+	},
+	[PLL0_FREQ_625] = {
+		.freq = 625000000,
+		.prediv = 24,
+		.fbdiv = 625,
+		.postdiv1 = 1,
+		.dacpd = 1,
+		.dsmpd = 1,
+	},
+	[PLL0_FREQ_750] = {
+		.freq = 750000000,
+		.prediv = 4,
+		.fbdiv = 125,
+		.postdiv1 = 1,
+		.dacpd = 1,
+		.dsmpd = 1,
+	},
+	[PLL0_FREQ_875] = {
+		.freq = 875000000,
+		.prediv = 24,
+		.fbdiv = 875,
+		.postdiv1 = 1,
+		.dacpd = 1,
+		.dsmpd = 1,
+	},
+	[PLL0_FREQ_1000] = {
+		.freq = 1000000000,
+		.prediv = 3,
+		.fbdiv = 125,
+		.postdiv1 = 1,
+		.dacpd = 1,
+		.dsmpd = 1,
+	},
+	[PLL0_FREQ_1250] = {
+		.freq = 1250000000,
+		.prediv = 12,
+		.fbdiv = 625,
+		.postdiv1 = 1,
+		.dacpd = 1,
+		.dsmpd = 1,
+	},
+	[PLL0_FREQ_1375] = {
+		.freq = 1375000000,
+		.prediv = 24,
+		.fbdiv = 1375,
+		.postdiv1 = 1,
+		.dacpd = 1,
+		.dsmpd = 1,
+	},
+	[PLL0_FREQ_1500] = {
+		.freq = 1500000000,
+		.prediv = 2,
+		.fbdiv = 125,
+		.postdiv1 = 1,
+		.dacpd = 1,
+		.dsmpd = 1,
+	},
+};
+
+static const struct starfive_pll_syscon_value
+	jh7110_pll1_syscon_freq[] = {
+	[PLL1_FREQ_1066] = {
+		.freq = 1066000000,
+		.prediv = 12,
+		.fbdiv = 533,
+		.postdiv1 = 1,
+		.dacpd = 1,
+		.dsmpd = 1,
+	},
+	[PLL1_FREQ_1200] = {
+		.freq = 1200000000,
+		.prediv = 1,
+		.fbdiv = 50,
+		.postdiv1 = 1,
+		.dacpd = 1,
+		.dsmpd = 1,
+	},
+	[PLL1_FREQ_1400] = {
+		.freq = 1400000000,
+		.prediv = 6,
+		.fbdiv = 350,
+		.postdiv1 = 1,
+		.dacpd = 1,
+		.dsmpd = 1,
+	},
+	[PLL1_FREQ_1600] = {
+		.freq = 1600000000,
+		.prediv = 3,
+		.fbdiv = 200,
+		.postdiv1 = 1,
+		.dacpd = 1,
+		.dsmpd = 1,
+	},
+};
+
+static const struct starfive_pll_syscon_value
+	jh7110_pll2_syscon_freq[] = {
+	[PLL2_FREQ_1188] = {
+		.freq = 1188000000,
+		.prediv = 2,
+		.fbdiv = 99,
+		.postdiv1 = 1,
+		.dacpd = 1,
+		.dsmpd = 1,
+	},
+	[PLL2_FREQ_12288] = {
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
diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
index 6e230b81a387..228119b55a93 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
@@ -26,6 +26,9 @@
 #define JH7110_SYSCLK_I2SRX_LRCK_EXT		(JH7110_SYSCLK_END + 6)
 #define JH7110_SYSCLK_TDM_EXT			(JH7110_SYSCLK_END + 7)
 #define JH7110_SYSCLK_MCLK_EXT			(JH7110_SYSCLK_END + 8)
+#define JH7110_SYSCLK_PLL0_OUT			(JH7110_SYSCLK_END + 9)
+#define JH7110_SYSCLK_PLL1_OUT			(JH7110_SYSCLK_END + 10)
+#define JH7110_SYSCLK_PLL2_OUT			(JH7110_SYSCLK_END + 11)
 
 static const struct jh71x0_clk_data jh7110_sysclk_data[] __initconst = {
 	/* root */
@@ -329,11 +332,8 @@ static struct clk_hw *jh7110_sysclk_get(struct of_phandle_args *clkspec, void *d
 	struct jh71x0_clk_priv *priv = data;
 	unsigned int idx = clkspec->args[0];
 
-	if (idx < JH7110_SYSCLK_PLL0_OUT)
-		return &priv->reg[idx].hw;
-
 	if (idx < JH7110_SYSCLK_END)
-		return priv->pll[idx - JH7110_SYSCLK_PLL0_OUT];
+		return &priv->reg[idx].hw;
 
 	return ERR_PTR(-EINVAL);
 }
@@ -345,7 +345,7 @@ static int __init jh7110_syscrg_probe(struct platform_device *pdev)
 	int ret;
 
 	priv = devm_kzalloc(&pdev->dev,
-			    struct_size(priv, reg, JH7110_SYSCLK_PLL0_OUT),
+			    struct_size(priv, reg, JH7110_SYSCLK_END),
 			    GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
@@ -358,25 +358,7 @@ static int __init jh7110_syscrg_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(priv->dev, (void *)(&priv->base));
 
-	/* 24MHz -> 1000.0MHz */
-	priv->pll[0] = devm_clk_hw_register_fixed_factor(priv->dev, "pll0_out",
-							 "osc", 0, 125, 3);
-	if (IS_ERR(priv->pll[0]))
-		return PTR_ERR(priv->pll[0]);
-
-	/* 24MHz -> 1066.0MHz */
-	priv->pll[1] = devm_clk_hw_register_fixed_factor(priv->dev, "pll1_out",
-							 "osc", 0, 533, 12);
-	if (IS_ERR(priv->pll[1]))
-		return PTR_ERR(priv->pll[1]);
-
-	/* 24MHz -> 1188.0MHz */
-	priv->pll[2] = devm_clk_hw_register_fixed_factor(priv->dev, "pll2_out",
-							 "osc", 0, 99, 2);
-	if (IS_ERR(priv->pll[2]))
-		return PTR_ERR(priv->pll[2]);
-
-	for (idx = 0; idx < JH7110_SYSCLK_PLL0_OUT; idx++) {
+	for (idx = 0; idx < JH7110_SYSCLK_END; idx++) {
 		u32 max = jh7110_sysclk_data[idx].max;
 		struct clk_parent_data parents[4] = {};
 		struct clk_init_data init = {
@@ -393,10 +375,8 @@ static int __init jh7110_syscrg_probe(struct platform_device *pdev)
 		for (i = 0; i < init.num_parents; i++) {
 			unsigned int pidx = jh7110_sysclk_data[idx].parents[i];
 
-			if (pidx < JH7110_SYSCLK_PLL0_OUT)
+			if (pidx < JH7110_SYSCLK_END)
 				parents[i].hw = &priv->reg[pidx].hw;
-			else if (pidx < JH7110_SYSCLK_END)
-				parents[i].hw = priv->pll[pidx - JH7110_SYSCLK_PLL0_OUT];
 			else if (pidx == JH7110_SYSCLK_OSC)
 				parents[i].fw_name = "osc";
 			else if (pidx == JH7110_SYSCLK_GMAC1_RMII_REFIN)
@@ -415,6 +395,12 @@ static int __init jh7110_syscrg_probe(struct platform_device *pdev)
 				parents[i].fw_name = "tdm_ext";
 			else if (pidx == JH7110_SYSCLK_MCLK_EXT)
 				parents[i].fw_name = "mclk_ext";
+			else if (pidx == JH7110_SYSCLK_PLL0_OUT)
+				parents[i].fw_name = "pll0_out";
+			else if (pidx == JH7110_SYSCLK_PLL1_OUT)
+				parents[i].fw_name = "pll1_out";
+			else if (pidx == JH7110_SYSCLK_PLL2_OUT)
+				parents[i].fw_name = "pll2_out";
 		}
 
 		clk->hw.init = &init;
-- 
2.25.1

