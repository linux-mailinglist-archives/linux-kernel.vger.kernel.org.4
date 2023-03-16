Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C466BC433
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 04:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjCPDFn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Mar 2023 23:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjCPDFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 23:05:25 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D35D1FD4;
        Wed, 15 Mar 2023 20:05:19 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 2F42A24E208;
        Thu, 16 Mar 2023 11:05:18 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 16 Mar
 2023 11:05:18 +0800
Received: from localhost.localdomain (113.72.145.194) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 16 Mar
 2023 11:05:16 +0800
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
Subject: [PATCH v2 2/6] clk: starfive: Add StarFive JH7110 PLL clock driver
Date:   Thu, 16 Mar 2023 11:05:10 +0800
Message-ID: <20230316030514.137427-3-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230316030514.137427-1-xingyu.wu@starfivetech.com>
References: <20230316030514.137427-1-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.145.194]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for the StarFive JH7110 PLL clock controller.

Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 drivers/clk/starfive/Kconfig                  |   8 +
 drivers/clk/starfive/Makefile                 |   1 +
 .../clk/starfive/clk-starfive-jh7110-pll.c    | 420 ++++++++++++++++++
 .../clk/starfive/clk-starfive-jh7110-pll.h    | 293 ++++++++++++
 4 files changed, 722 insertions(+)
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-pll.c
 create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-pll.h

diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
index 71c1148ee5f6..e306edf4defa 100644
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
index 000000000000..b947861065db
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jh7110-pll.c
@@ -0,0 +1,420 @@
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
+/* Read register value from syscon and calculate PLL(x) frequency */
+static unsigned long jh7110_pll_get_freq(struct jh7110_clk_pll_data *data,
+					 unsigned long parent_rate)
+{
+	struct jh7110_clk_pll_priv *priv = jh7110_pll_priv_from(data);
+	struct jh7110_pll_syscon_offset *offset = &data->offset;
+	struct jh7110_pll_syscon_mask *mask = &data->mask;
+	struct jh7110_pll_syscon_shift *shift = &data->shift;
+	unsigned long freq = 0;
+	unsigned long frac_cal;
+	u32 dacpd;
+	u32 dsmpd;
+	u32 fbdiv;
+	u32 prediv;
+	u32 postdiv1;
+	u32 frac;
+	u32 reg_value;
+
+	if (regmap_read(priv->syscon_regmap, offset->dacpd, &reg_value))
+		goto read_register_error;
+	dacpd = (reg_value & mask->dacpd) >> shift->dacpd;
+
+	if (regmap_read(priv->syscon_regmap, offset->dsmpd, &reg_value))
+		goto read_register_error;
+	dsmpd = (reg_value & mask->dsmpd) >> shift->dsmpd;
+
+	if (regmap_read(priv->syscon_regmap, offset->fbdiv, &reg_value))
+		goto read_register_error;
+	fbdiv = (reg_value & mask->fbdiv) >> shift->fbdiv;
+	/* fbdiv value should be 8 to 4095 */
+	if (fbdiv < 8)
+		goto read_register_error;
+
+	if (regmap_read(priv->syscon_regmap, offset->prediv, &reg_value))
+		goto read_register_error;
+	prediv = (reg_value & mask->prediv) >> shift->prediv;
+
+	if (regmap_read(priv->syscon_regmap, offset->postdiv1, &reg_value))
+		goto read_register_error;
+	/* postdiv1 = 2 ^ reg_value */
+	postdiv1 = 1 << ((reg_value & mask->postdiv1) >> shift->postdiv1);
+
+	if (regmap_read(priv->syscon_regmap, offset->frac, &reg_value))
+		goto read_register_error;
+	frac = (reg_value & mask->frac) >> shift->frac;
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
+		goto read_register_error;
+
+	if (frac_cal)
+		/* fraction mode: Fvco = Fref * (NI + NF) / M / Q1 */
+		freq = parent_rate / STARFIVE_PLL_FRAC_PATR_SIZE *
+		       (fbdiv * STARFIVE_PLL_FRAC_PATR_SIZE + frac_cal) / prediv / postdiv1;
+	else
+		/* integer mode: Fvco = Fref * NI / M / Q1 */
+		freq = parent_rate * fbdiv / prediv / postdiv1;
+
+read_register_error:
+	return freq;
+}
+
+/* Select the appropriate frequency from the already configured registers value */
+static int jh7110_pll_select_freq_syscon(struct jh7110_clk_pll_data *data,
+					 unsigned long target_rate)
+{
+	struct jh7110_clk_pll_priv *priv = jh7110_pll_priv_from(data);
+	const struct starfive_pll_syscon_value *syscon_value;
+	unsigned int id;
+	unsigned int pll_arry_size;
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
+			goto select_succeed;
+	}
+
+	dev_err(priv->dev, "pll%d frequency:%ld do not match, please check it.\n",
+		data->idx, target_rate);
+	return -EINVAL;
+
+select_succeed:
+	data->freq_select_idx = id;
+	return 0;
+}
+
+static int jh7110_pll_set_freq_syscon(struct jh7110_clk_pll_data *data)
+{
+	struct jh7110_clk_pll_priv *priv = jh7110_pll_priv_from(data);
+	struct jh7110_pll_syscon_offset *offset = &data->offset;
+	struct jh7110_pll_syscon_mask *mask = &data->mask;
+	struct jh7110_pll_syscon_shift *shift = &data->shift;
+	unsigned int freq_idx = data->freq_select_idx;
+	const struct starfive_pll_syscon_value *syscon_value;
+	int ret;
+
+	if (data->idx == JH7110_CLK_PLL0_OUT)
+		syscon_value = &jh7110_pll0_syscon_freq[freq_idx];
+	else if (data->idx == JH7110_CLK_PLL1_OUT)
+		syscon_value = &jh7110_pll1_syscon_freq[freq_idx];
+	else
+		syscon_value = &jh7110_pll2_syscon_freq[freq_idx];
+
+	ret = regmap_update_bits(priv->syscon_regmap, offset->dacpd, mask->dacpd,
+				 (syscon_value->dacpd << shift->dacpd));
+	if (ret)
+		goto set_failed;
+
+	ret = regmap_update_bits(priv->syscon_regmap, offset->dsmpd, mask->dsmpd,
+				 (syscon_value->dsmpd << shift->dsmpd));
+	if (ret)
+		goto set_failed;
+
+	ret = regmap_update_bits(priv->syscon_regmap, offset->prediv, mask->prediv,
+				 (syscon_value->prediv << shift->prediv));
+	if (ret)
+		goto set_failed;
+
+	ret = regmap_update_bits(priv->syscon_regmap, offset->fbdiv, mask->fbdiv,
+				 (syscon_value->fbdiv << shift->fbdiv));
+	if (ret)
+		goto set_failed;
+
+	ret = regmap_update_bits(priv->syscon_regmap, offset->postdiv1, mask->postdiv1,
+				 ((syscon_value->postdiv1 >> 1) << shift->postdiv1));
+	if (ret)
+		goto set_failed;
+
+	/* frac: Integer Mode (Both 1) or Fraction Mode (Both 0) */
+	if (syscon_value->dacpd == 0 && syscon_value->dsmpd == 0)
+		ret = regmap_update_bits(priv->syscon_regmap, offset->frac, mask->frac,
+					 (syscon_value->frac << shift->frac));
+	else if (syscon_value->dacpd != syscon_value->dsmpd)
+		ret = -EINVAL;
+
+set_failed:
+	return ret;
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
+	int ret = jh7110_pll_select_freq_syscon(data, req->rate);
+
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
+/* get offset, mask and shift of PLL(x) syscon */
+static int jh7110_pll_data_get(struct jh7110_clk_pll_data *data, int index)
+{
+	struct jh7110_pll_syscon_offset *offset = &data->offset;
+	struct jh7110_pll_syscon_mask *mask = &data->mask;
+	struct jh7110_pll_syscon_shift *shift = &data->shift;
+
+	if (index == JH7110_CLK_PLL0_OUT) {
+		offset->dacpd = STARFIVE_JH7110_PLL0_DACPD_OFFSET;
+		offset->dsmpd = STARFIVE_JH7110_PLL0_DSMPD_OFFSET;
+		offset->fbdiv = STARFIVE_JH7110_PLL0_FBDIV_OFFSET;
+		offset->frac = STARFIVE_JH7110_PLL0_FRAC_OFFSET;
+		offset->prediv = STARFIVE_JH7110_PLL0_PREDIV_OFFSET;
+		offset->postdiv1 = STARFIVE_JH7110_PLL0_POSTDIV1_OFFSET;
+
+		mask->dacpd = STARFIVE_JH7110_PLL0_DACPD_MASK;
+		mask->dsmpd = STARFIVE_JH7110_PLL0_DSMPD_MASK;
+		mask->fbdiv = STARFIVE_JH7110_PLL0_FBDIV_MASK;
+		mask->frac = STARFIVE_JH7110_PLL0_FRAC_MASK;
+		mask->prediv = STARFIVE_JH7110_PLL0_PREDIV_MASK;
+		mask->postdiv1 = STARFIVE_JH7110_PLL0_POSTDIV1_MASK;
+
+		shift->dacpd = STARFIVE_JH7110_PLL0_DACPD_SHIFT;
+		shift->dsmpd = STARFIVE_JH7110_PLL0_DSMPD_SHIFT;
+		shift->fbdiv = STARFIVE_JH7110_PLL0_FBDIV_SHIFT;
+		shift->frac = STARFIVE_JH7110_PLL0_FRAC_SHIFT;
+		shift->prediv = STARFIVE_JH7110_PLL0_PREDIV_SHIFT;
+		shift->postdiv1 = STARFIVE_JH7110_PLL0_POSTDIV1_SHIFT;
+
+	} else if (index == JH7110_CLK_PLL1_OUT) {
+		offset->dacpd = STARFIVE_JH7110_PLL1_DACPD_OFFSET;
+		offset->dsmpd = STARFIVE_JH7110_PLL1_DSMPD_OFFSET;
+		offset->fbdiv = STARFIVE_JH7110_PLL1_FBDIV_OFFSET;
+		offset->frac = STARFIVE_JH7110_PLL1_FRAC_OFFSET;
+		offset->prediv = STARFIVE_JH7110_PLL1_PREDIV_OFFSET;
+		offset->postdiv1 = STARFIVE_JH7110_PLL1_POSTDIV1_OFFSET;
+
+		mask->dacpd = STARFIVE_JH7110_PLL1_DACPD_MASK;
+		mask->dsmpd = STARFIVE_JH7110_PLL1_DSMPD_MASK;
+		mask->fbdiv = STARFIVE_JH7110_PLL1_FBDIV_MASK;
+		mask->frac = STARFIVE_JH7110_PLL1_FRAC_MASK;
+		mask->prediv = STARFIVE_JH7110_PLL1_PREDIV_MASK;
+		mask->postdiv1 = STARFIVE_JH7110_PLL1_POSTDIV1_MASK;
+
+		shift->dacpd = STARFIVE_JH7110_PLL1_DACPD_SHIFT;
+		shift->dsmpd = STARFIVE_JH7110_PLL1_DSMPD_SHIFT;
+		shift->fbdiv = STARFIVE_JH7110_PLL1_FBDIV_SHIFT;
+		shift->frac = STARFIVE_JH7110_PLL1_FRAC_SHIFT;
+		shift->prediv = STARFIVE_JH7110_PLL1_PREDIV_SHIFT;
+		shift->postdiv1 = STARFIVE_JH7110_PLL1_POSTDIV1_SHIFT;
+
+	} else if (index == JH7110_CLK_PLL2_OUT) {
+		offset->dacpd = STARFIVE_JH7110_PLL2_DACPD_OFFSET;
+		offset->dsmpd = STARFIVE_JH7110_PLL2_DSMPD_OFFSET;
+		offset->fbdiv = STARFIVE_JH7110_PLL2_FBDIV_OFFSET;
+		offset->frac = STARFIVE_JH7110_PLL2_FRAC_OFFSET;
+		offset->prediv = STARFIVE_JH7110_PLL2_PREDIV_OFFSET;
+		offset->postdiv1 = STARFIVE_JH7110_PLL2_POSTDIV1_OFFSET;
+
+		mask->dacpd = STARFIVE_JH7110_PLL2_DACPD_MASK;
+		mask->dsmpd = STARFIVE_JH7110_PLL2_DSMPD_MASK;
+		mask->fbdiv = STARFIVE_JH7110_PLL2_FBDIV_MASK;
+		mask->frac = STARFIVE_JH7110_PLL2_FRAC_MASK;
+		mask->prediv = STARFIVE_JH7110_PLL2_PREDIV_MASK;
+		mask->postdiv1 = STARFIVE_JH7110_PLL2_POSTDIV1_MASK;
+
+		shift->dacpd = STARFIVE_JH7110_PLL2_DACPD_SHIFT;
+		shift->dsmpd = STARFIVE_JH7110_PLL2_DSMPD_SHIFT;
+		shift->fbdiv = STARFIVE_JH7110_PLL2_FBDIV_SHIFT;
+		shift->frac = STARFIVE_JH7110_PLL2_FRAC_SHIFT;
+		shift->prediv = STARFIVE_JH7110_PLL2_PREDIV_SHIFT;
+		shift->postdiv1 = STARFIVE_JH7110_PLL2_POSTDIV1_SHIFT;
+
+	} else {
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
+static struct clk_hw *jh7110_pll_get(struct of_phandle_args *clkspec, void *data)
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
+static int jh7110_pll_probe(struct platform_device *pdev)
+{
+	const char *pll_name[JH7110_PLLCLK_END] = {
+		"pll0_out",
+		"pll1_out",
+		"pll2_out"
+	};
+	struct jh7110_clk_pll_priv *priv;
+	struct jh7110_clk_pll_data *data;
+	int ret;
+	unsigned int idx;
+
+	priv = devm_kzalloc(&pdev->dev, struct_size(priv, data, JH7110_PLLCLK_END),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = &pdev->dev;
+	priv->syscon_regmap = syscon_node_to_regmap(priv->dev->of_node->parent);
+	if (IS_ERR(priv->syscon_regmap))
+		return PTR_ERR(priv->syscon_regmap);
+
+	for (idx = 0; idx < JH7110_PLLCLK_END; idx++) {
+		struct clk_parent_data parents = {
+			.index = 0,
+		};
+		struct clk_init_data init = {
+			.name = pll_name[idx],
+			.ops = &jh7110_pll_ops,
+			.parent_data = &parents,
+			.num_parents = 1,
+			.flags = 0,
+		};
+
+		data = &priv->data[idx];
+
+		ret = jh7110_pll_data_get(data, idx);
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
+	return devm_of_clk_add_hw_provider(&pdev->dev, jh7110_pll_get, priv);
+}
+
+static const struct of_device_id jh7110_pll_match[] = {
+	{ .compatible = "starfive,jh7110-pll" },
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
index 000000000000..3deb35f144dc
--- /dev/null
+++ b/drivers/clk/starfive/clk-starfive-jh7110-pll.h
@@ -0,0 +1,293 @@
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
+#include <linux/bits.h>
+
+/* The decimal places are counted by expanding them by a factor of STARFIVE_PLL_FRAC_PATR_SIZE. */
+#define STARFIVE_PLL_FRAC_PATR_SIZE		1000
+
+#define STARFIVE_JH7110_PLL0_DACPD_OFFSET	0x18
+#define STARFIVE_JH7110_PLL0_DACPD_SHIFT	24
+#define STARFIVE_JH7110_PLL0_DACPD_MASK		BIT(24)
+#define STARFIVE_JH7110_PLL0_DSMPD_OFFSET	0x18
+#define STARFIVE_JH7110_PLL0_DSMPD_SHIFT	25
+#define STARFIVE_JH7110_PLL0_DSMPD_MASK		BIT(25)
+#define STARFIVE_JH7110_PLL0_FBDIV_OFFSET	0x1c
+#define STARFIVE_JH7110_PLL0_FBDIV_SHIFT	0
+#define STARFIVE_JH7110_PLL0_FBDIV_MASK		GENMASK(11, 0)
+#define STARFIVE_JH7110_PLL0_FRAC_OFFSET	0x20
+#define STARFIVE_JH7110_PLL0_FRAC_SHIFT		0
+#define STARFIVE_JH7110_PLL0_FRAC_MASK		GENMASK(23, 0)
+#define STARFIVE_JH7110_PLL0_POSTDIV1_OFFSET	0x20
+#define STARFIVE_JH7110_PLL0_POSTDIV1_SHIFT	28
+#define STARFIVE_JH7110_PLL0_POSTDIV1_MASK	GENMASK(29, 28)
+#define STARFIVE_JH7110_PLL0_PREDIV_OFFSET	0x24
+#define STARFIVE_JH7110_PLL0_PREDIV_SHIFT	0
+#define STARFIVE_JH7110_PLL0_PREDIV_MASK	GENMASK(5, 0)
+
+#define STARFIVE_JH7110_PLL1_DACPD_OFFSET	0x24
+#define STARFIVE_JH7110_PLL1_DACPD_SHIFT	15
+#define STARFIVE_JH7110_PLL1_DACPD_MASK		BIT(15)
+#define STARFIVE_JH7110_PLL1_DSMPD_OFFSET	0x24
+#define STARFIVE_JH7110_PLL1_DSMPD_SHIFT	16
+#define STARFIVE_JH7110_PLL1_DSMPD_MASK		BIT(16)
+#define STARFIVE_JH7110_PLL1_FBDIV_OFFSET	0x24
+#define STARFIVE_JH7110_PLL1_FBDIV_SHIFT	17
+#define STARFIVE_JH7110_PLL1_FBDIV_MASK		GENMASK(28, 17)
+#define STARFIVE_JH7110_PLL1_FRAC_OFFSET	0x28
+#define STARFIVE_JH7110_PLL1_FRAC_SHIFT		0
+#define STARFIVE_JH7110_PLL1_FRAC_MASK		GENMASK(23, 0)
+#define STARFIVE_JH7110_PLL1_POSTDIV1_OFFSET	0x28
+#define STARFIVE_JH7110_PLL1_POSTDIV1_SHIFT	28
+#define STARFIVE_JH7110_PLL1_POSTDIV1_MASK	GENMASK(29, 28)
+#define STARFIVE_JH7110_PLL1_PREDIV_OFFSET	0x2c
+#define STARFIVE_JH7110_PLL1_PREDIV_SHIFT	0
+#define STARFIVE_JH7110_PLL1_PREDIV_MASK	GENMASK(5, 0)
+
+#define STARFIVE_JH7110_PLL2_DACPD_OFFSET	0x2c
+#define STARFIVE_JH7110_PLL2_DACPD_SHIFT	15
+#define STARFIVE_JH7110_PLL2_DACPD_MASK		BIT(15)
+#define STARFIVE_JH7110_PLL2_DSMPD_OFFSET	0x2c
+#define STARFIVE_JH7110_PLL2_DSMPD_SHIFT	16
+#define STARFIVE_JH7110_PLL2_DSMPD_MASK		BIT(16)
+#define STARFIVE_JH7110_PLL2_FBDIV_OFFSET	0x2c
+#define STARFIVE_JH7110_PLL2_FBDIV_SHIFT	17
+#define STARFIVE_JH7110_PLL2_FBDIV_MASK		GENMASK(28, 17)
+#define STARFIVE_JH7110_PLL2_FRAC_OFFSET	0x30
+#define STARFIVE_JH7110_PLL2_FRAC_SHIFT		0
+#define STARFIVE_JH7110_PLL2_FRAC_MASK		GENMASK(23, 0)
+#define STARFIVE_JH7110_PLL2_POSTDIV1_OFFSET	0x30
+#define STARFIVE_JH7110_PLL2_POSTDIV1_SHIFT	28
+#define STARFIVE_JH7110_PLL2_POSTDIV1_MASK	GENMASK(29, 28)
+#define STARFIVE_JH7110_PLL2_PREDIV_OFFSET	0x34
+#define STARFIVE_JH7110_PLL2_PREDIV_SHIFT	0
+#define STARFIVE_JH7110_PLL2_PREDIV_MASK	GENMASK(5, 0)
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
+struct jh7110_clk_pll_data {
+	struct clk_hw hw;
+	unsigned int idx;
+	unsigned int freq_select_idx;
+
+	struct jh7110_pll_syscon_offset offset;
+	struct jh7110_pll_syscon_mask mask;
+	struct jh7110_pll_syscon_shift shift;
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
+enum starfive_pll0_freq_index {
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
+enum starfive_pll1_freq_index {
+	PLL1_FREQ_1066 = 0,
+	PLL1_FREQ_1200,
+	PLL1_FREQ_1400,
+	PLL1_FREQ_1600,
+	PLL1_FREQ_MAX
+};
+
+enum starfive_pll2_freq_index {
+	PLL2_FREQ_1188 = 0,
+	PLL2_FREQ_12288,
+	PLL2_FREQ_MAX
+};
+
+/*
+ * Because the pll frequency is relatively fixed,
+ * it cannot be set arbitrarily, so it needs a specific configuration.
+ * PLL0 frequency should be multiple of 125MHz (USB frequency).
+ */
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
-- 
2.25.1

