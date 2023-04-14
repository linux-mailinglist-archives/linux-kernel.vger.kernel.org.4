Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E83A6E29E3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 20:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjDNSNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 14:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDNSNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 14:13:37 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4FAB767;
        Fri, 14 Apr 2023 11:13:30 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id c3so20082076pjg.1;
        Fri, 14 Apr 2023 11:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681496009; x=1684088009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKYgZsnS1c5/V+9cdmbKsdn2UHaqy4HhIgk6bNRbvQU=;
        b=Bb92G1WVOCZuTxNJSWRyZHCZbUs3S9HNANyNSYN/RHXRriZn3TBUjWdpsqZPo8YTYn
         QLGnSORwWCeY0xLWL4lUvngIq+MrUy9+iKMtG6Y1elmrtRzARGXbYuJxE1NZklbZdMWl
         uQSc2m93olrmPRVRw+3xnIlWWdw044h3vG3gPw30odP4uylx4HiNODcRTjuj3lFrljAk
         VWH71g1VqLjRosERUL9KqBfUXVBTp8UxWqT350r3mAnXaxPDiuzit38sRz8hX6OxB0WD
         7yyQWPTk+JYmpUjGLVow5CIsqbcaPxmGIAx7aWqm6fZYXeyEZ3m2O6caICxKIWCe4epi
         QmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681496009; x=1684088009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cKYgZsnS1c5/V+9cdmbKsdn2UHaqy4HhIgk6bNRbvQU=;
        b=BXyD+Ad7ykCWGamuE+4XnnwX9eypUly7ILmKOk3YNKNKuTf56wGsS5U6UhWEARjm2q
         YvdhsWVZDSPy1X5O4RtGYX8ATRY44NsGmgKhWAW2a/ZjOVWgeTeGh2RvGmAmGmXf62tK
         PuGU8mNhKGmuhj2YggqqaO+87Js/p+XlvFmEV9tFkmgA6I2DKFpzdmRDYY3rknnYvd+6
         aABwYLO65cx8Fi/ZYYjhW+ZoHf8iCG0Vq+1xEcI7FEMDw6f/Q3OfiiesNfqCT0gP9Pla
         zccsAfwg44wtxBme/EsRwVlVcMxYgnGH32rp7V3TqlWsJg3La0rVemNVJQ4AQnnZn2bO
         Qe3Q==
X-Gm-Message-State: AAQBX9dRCkrHFbBoEQ4plNAGoS3ldbVHpI02tzaFrFe1DrILpa+ax1P6
        e7nfyjWY7lP0tfP7wg9fCN6KSsi9ZowWPLjVOA4=
X-Google-Smtp-Source: AKy350YpQjR25KYFXEVjkzIe+rB/tB6oXGVXUUvK8HInLeVDq7TQSvAwUrF5PnATp6lL6Kajrd924Q==
X-Received: by 2002:a17:902:da8d:b0:19a:9890:eac6 with SMTP id j13-20020a170902da8d00b0019a9890eac6mr3874863plx.24.1681496009159;
        Fri, 14 Apr 2023 11:13:29 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.200])
        by smtp.gmail.com with ESMTPSA id x11-20020a170902820b00b0019a593e45f1sm3309371pln.261.2023.04.14.11.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 11:13:28 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 2/2] clk: Add basic register clock controller
Date:   Sat, 15 Apr 2023 02:13:00 +0800
Message-Id: <20230414181302.986271-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230414181302.986271-1-mmyangfl@gmail.com>
References: <20230414181302.986271-1-mmyangfl@gmail.com>
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

These clocks were provided in `include/linux/clk-provider.h`, but lacks DT
bindings. Add a clock controller to avoid operation conflict on same
register.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/clk/Makefile  |   1 +
 drivers/clk/clk-reg.c | 638 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 639 insertions(+)
 create mode 100644 drivers/clk/clk-reg.c

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index e3ca0d058a25..9468b2028a5b 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_COMMON_CLK)	+= clk-fractional-divider.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-gpio.o
 ifeq ($(CONFIG_OF), y)
 obj-$(CONFIG_COMMON_CLK)	+= clk-conf.o
+obj-$(CONFIG_COMMON_CLK)	+= clk-reg.o
 endif
 
 # hardware specific clock types
diff --git a/drivers/clk/clk-reg.c b/drivers/clk/clk-reg.c
new file mode 100644
index 000000000000..a115921a9cbd
--- /dev/null
+++ b/drivers/clk/clk-reg.c
@@ -0,0 +1,638 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) 2023 David Yang
+ *
+ * Simple straight-forward register clocks bindings
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_clk.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <linux/slab.h>
+
+struct regclk_ctrl {
+	spinlock_t lock;
+
+	void __iomem *base;
+	struct reset_controller_dev rcdev;
+	bool rst_set_to_disable;
+};
+
+struct regclk_flag {
+	const char *prop;
+	unsigned long flag;
+};
+
+static const struct regclk_flag regclk_flags[] = {
+	{ "set-rate-gate", CLK_SET_RATE_GATE },
+	{ "set-parent-gate", CLK_SET_PARENT_GATE },
+	{ "set-rate-parent", CLK_SET_RATE_PARENT },
+	{ "ignore-unused", CLK_IGNORE_UNUSED },
+	{ "get-rate-nocache", CLK_GET_RATE_NOCACHE },
+	{ "set-rate-no-reparent", CLK_SET_RATE_NO_REPARENT },
+	{ "get-accuracy-nocache", CLK_GET_ACCURACY_NOCACHE },
+	{ "recalc-new-rates", CLK_RECALC_NEW_RATES },
+	{ "set-rate-ungate", CLK_SET_RATE_UNGATE },
+	{ "critical", CLK_IS_CRITICAL },
+	{ "ops-parent-enable", CLK_OPS_PARENT_ENABLE },
+	{ "duty-cycle-parent", CLK_DUTY_CYCLE_PARENT },
+	{ }
+};
+
+static const struct regclk_flag regclk_gate_flags[] = {
+	{ "set-to-disable", CLK_GATE_SET_TO_DISABLE },
+	{ "hiword-mask", CLK_GATE_HIWORD_MASK },
+	{ "big-endian", CLK_GATE_BIG_ENDIAN },
+	{ }
+};
+
+static const struct regclk_flag regclk_divider_flags[] = {
+	{ "one-based", CLK_DIVIDER_ONE_BASED },
+	{ "power-of-two", CLK_DIVIDER_POWER_OF_TWO },
+	{ "allow-zero", CLK_DIVIDER_ALLOW_ZERO },
+	{ "hiword-mask", CLK_DIVIDER_HIWORD_MASK },
+	{ "round-closest", CLK_DIVIDER_ROUND_CLOSEST },
+	{ "read-only", CLK_DIVIDER_READ_ONLY },
+	{ "max-at-zero", CLK_DIVIDER_MAX_AT_ZERO },
+	{ "big-endian", CLK_DIVIDER_BIG_ENDIAN },
+	{ }
+};
+
+static const struct regclk_flag regclk_mux_flags[] = {
+	{ "index-one", CLK_MUX_INDEX_ONE },
+	{ "index-bit", CLK_MUX_INDEX_BIT },
+	{ "hiword-mask", CLK_MUX_HIWORD_MASK },
+	{ "read-only", CLK_MUX_READ_ONLY },
+	{ "round-closest", CLK_MUX_ROUND_CLOSEST },
+	{ "big-endian", CLK_MUX_BIG_ENDIAN },
+	{ }
+};
+
+static const struct regclk_flag regclk_fractional_divider_flags[] = {
+	{ "zero-based", CLK_FRAC_DIVIDER_ZERO_BASED },
+	{ "big-endian", CLK_FRAC_DIVIDER_BIG_ENDIAN },
+	{ "power-of-two-ps", CLK_FRAC_DIVIDER_POWER_OF_TWO_PS },
+	{ }
+};
+
+static unsigned long
+regclk_get_flags(struct device_node *np, const struct regclk_flag *defs)
+{
+	unsigned long flags = 0;
+
+	for (int i = 0; defs[i].prop; i++)
+		if (of_property_read_bool(np, defs[i].prop))
+			flags |= defs[i].flag;
+
+	return flags;
+}
+
+static const char *regclk_name(struct device_node *np)
+{
+	const char *name;
+
+	if (!of_property_read_string(np, "clock-output-name", &name))
+		return name;
+
+	return of_node_full_name(np);
+}
+
+static struct clk_hw *
+regclk_register_gate(struct device_node *np, struct regclk_ctrl *priv)
+{
+	const char *name;
+	const char *parent_name;
+	unsigned long flags;
+	void __iomem *reg;
+	u32 bit_idx;
+	unsigned long clk_gate_flags;
+
+	const char *property;
+	struct clk_hw *hw;
+	struct clk_hw *retptr;
+	int ret;
+
+	reg = of_iomap(np, 0);
+	if (!reg)
+		return ERR_PTR(-ENOMEM);
+	name = regclk_name(np);
+	if (!name)
+		return ERR_PTR(-EINVAL);
+
+	property = "bit-index";
+	if (of_property_read_u32(np, property, &bit_idx))
+		goto err_property;
+
+	parent_name = of_clk_get_parent_name(np, 0);
+	flags = regclk_get_flags(np, regclk_flags);
+	clk_gate_flags = regclk_get_flags(np, regclk_gate_flags);
+
+	hw = __clk_hw_register_gate(NULL, np, name, parent_name,
+				    NULL, NULL, flags, reg, bit_idx,
+				    clk_gate_flags, &priv->lock);
+	if (IS_ERR(hw))
+		return hw;
+
+	ret = of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
+	if (ret) {
+		retptr = ERR_PTR(ret);
+		goto err_register;
+	}
+
+	return hw;
+
+err_register:
+	clk_hw_unregister(hw);
+	return retptr;
+
+err_property:
+	pr_err("%s: clock %s missing required property \"%s\"\n",
+	       __func__, name, property);
+	return ERR_PTR(-EINVAL);
+}
+
+static struct clk_hw *
+regclk_register_divider(struct device_node *np, struct regclk_ctrl *priv)
+{
+	const char *name;
+	const char *parent_name;
+	unsigned long flags;
+	void __iomem *reg;
+	u32 shift;
+	u32 width;
+	unsigned long clk_divider_flags;
+	struct clk_div_table *table = NULL;
+
+	struct property *prop;
+	const char *property;
+	struct clk_hw *hw;
+	struct clk_hw *retptr;
+	int ret;
+
+	reg = of_iomap(np, 0);
+	if (!reg)
+		return ERR_PTR(-ENOMEM);
+
+	name = regclk_name(np);
+	if (!name)
+		return ERR_PTR(-EINVAL);
+
+	property = "shift";
+	if (of_property_read_u32(np, property, &shift))
+		goto err_property;
+	property = "width";
+	if (of_property_read_u32(np, property, &width))
+		goto err_property;
+
+	prop = of_find_property(np, "dividers", NULL);
+	if (prop) {
+		unsigned int len = (prop->length / sizeof(u32) + 1) / 2;
+
+		table = kmalloc_array(len + 1, sizeof(*table), GFP_KERNEL);
+		if (!table)
+			return ERR_PTR(-ENOMEM);
+
+		for (unsigned int i = 0; i <= len; i++) {
+			u32 val;
+			u32 div;
+
+			if (of_property_read_u32_index(np, "dividers",
+						       2 * i + 0, &val)) {
+				retptr = ERR_PTR(-EINVAL);
+				goto err_table;
+			}
+			if (of_property_read_u32_index(np, "dividers",
+						       2 * i + 1, &div)) {
+				if (i == len)
+					div = 0;
+				retptr = ERR_PTR(-EINVAL);
+				goto err_table;
+			}
+
+			table[i].val = val;
+			table[i].div = div;
+		}
+
+		memset(&table[len], 0, sizeof(table[len]));
+	}
+
+	parent_name = of_clk_get_parent_name(np, 0);
+	flags = regclk_get_flags(np, regclk_flags);
+	clk_divider_flags = regclk_get_flags(np, regclk_divider_flags);
+
+	hw = __clk_hw_register_divider(NULL, np, name, parent_name,
+				       NULL, NULL, flags, reg, shift, width,
+				       clk_divider_flags, table, &priv->lock);
+	if (IS_ERR(hw)) {
+		retptr = hw;
+		goto err_table;
+	}
+
+	ret = of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
+	if (ret) {
+		retptr = ERR_PTR(ret);
+		goto err_register;
+	}
+
+	return hw;
+
+err_register:
+	clk_hw_unregister(hw);
+err_table:
+	kfree(table);
+	return retptr;
+
+err_property:
+	pr_err("%s: clock %s missing required property \"%s\"\n",
+	       __func__, name, property);
+	return ERR_PTR(-EINVAL);
+}
+
+static struct clk_hw *
+regclk_register_mux(struct device_node *np, struct regclk_ctrl *priv)
+{
+	const char *name;
+	u8 num_parents;
+	const char **parent_names;
+	unsigned long flags;
+	void __iomem *reg;
+	u32 shift;
+	u32 mask;
+	unsigned long clk_mux_flags;
+	u32 *table;
+
+	const char *property;
+	struct clk_hw *hw;
+	struct clk_hw *retptr;
+	int ret;
+
+	reg = of_iomap(np, 0);
+	if (!reg)
+		return ERR_PTR(-ENOMEM);
+	name = regclk_name(np);
+	if (!name)
+		return ERR_PTR(-EINVAL);
+
+	property = "shift";
+	if (of_property_read_u32(np, property, &shift))
+		goto err_property;
+	property = "mask";
+	if (of_property_read_u32(np, property, &mask))
+		goto err_property;
+
+	num_parents = of_clk_get_parent_count(np);
+
+	parent_names = kmalloc_array(num_parents, sizeof(*parent_names),
+				     GFP_KERNEL);
+	if (!parent_names)
+		return ERR_PTR(-ENOMEM);
+	for (int i = 0; i < num_parents; i++) {
+		parent_names[i] = of_clk_get_parent_name(np, i);
+		if (!parent_names[i]) {
+			retptr = ERR_PTR(-EINVAL);
+			goto err_parents;
+		}
+	}
+
+	table = kmalloc_array(num_parents, sizeof(*table), GFP_KERNEL);
+	if (!table) {
+		retptr = ERR_PTR(-ENOMEM);
+		goto err_parents;
+	}
+	for (int i = 0; i < num_parents; i++) {
+		if (of_property_read_u32(np, "table", &table[i])) {
+			retptr = ERR_PTR(-EINVAL);
+			goto err_table;
+		}
+	}
+
+	flags = regclk_get_flags(np, regclk_flags);
+	clk_mux_flags = regclk_get_flags(np, regclk_mux_flags);
+
+	hw = __clk_hw_register_mux(NULL, np, name, num_parents, parent_names,
+				   NULL, NULL, flags, reg, shift, mask,
+				   clk_mux_flags, table, &priv->lock);
+	if (IS_ERR(hw))
+		goto err_table;
+
+	ret = of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
+	if (ret) {
+		retptr = ERR_PTR(ret);
+		goto err_register;
+	}
+
+	return hw;
+
+err_register:
+	clk_hw_unregister(hw);
+err_table:
+	kfree(table);
+err_parents:
+	kfree(parent_names);
+	return retptr;
+
+err_property:
+	pr_err("%s: clock %s missing required property \"%s\"\n",
+	       __func__, name, property);
+	return ERR_PTR(-EINVAL);
+}
+
+static struct clk_hw *
+regclk_register_fractional_divider(struct device_node *np, struct regclk_ctrl *priv)
+{
+	const char *name;
+	const char *parent_name;
+	unsigned long flags;
+	void __iomem *reg;
+	u32 mshift;
+	u32 mwidth;
+	u32 nshift;
+	u32 nwidth;
+	unsigned long clk_divider_flags;
+
+	const char *property;
+	struct clk_hw *hw;
+	struct clk_hw *retptr;
+	int ret;
+
+	reg = of_iomap(np, 0);
+	if (!reg)
+		return ERR_PTR(-ENOMEM);
+	name = regclk_name(np);
+	if (!name)
+		return ERR_PTR(-EINVAL);
+
+	property = "numerator-shift";
+	if (of_property_read_u32(np, property, &mshift))
+		goto err_property;
+	property = "numerator-width";
+	if (of_property_read_u32(np, property, &mwidth))
+		goto err_property;
+	property = "denominator-shift";
+	if (of_property_read_u32(np, property, &nshift))
+		goto err_property;
+	property = "denominator-width";
+	if (of_property_read_u32(np, property, &nwidth))
+		goto err_property;
+
+	parent_name = of_clk_get_parent_name(np, 0);
+	flags = regclk_get_flags(np, regclk_flags);
+	clk_divider_flags = regclk_get_flags(np, regclk_fractional_divider_flags);
+
+	hw = clk_hw_register_fractional_divider(NULL, name, parent_name,
+						flags, reg, mshift, mwidth,
+						nshift, nwidth,
+						clk_divider_flags, &priv->lock);
+	if (IS_ERR(hw))
+		return hw;
+
+	ret = of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
+	if (ret) {
+		retptr = ERR_PTR(ret);
+		goto err_register;
+	}
+
+	return hw;
+
+err_register:
+	clk_hw_unregister(hw);
+	return retptr;
+
+err_property:
+	pr_err("%s: clock %s missing required property \"%s\"\n",
+	       __func__, name, property);
+	return ERR_PTR(-EINVAL);
+}
+
+/** regclk **/
+
+static void regclk_unsetup(struct device_node *np)
+{
+	struct clk_hw *hw = np->data;
+
+	if (!hw)
+		return;
+
+	if (of_device_is_compatible(np, "gate-clock"))
+		clk_hw_unregister_gate(hw);
+	else if (of_device_is_compatible(np, "divider-clock"))
+		clk_hw_unregister_divider(hw);
+	else if (of_device_is_compatible(np, "mux-clock"))
+		clk_hw_unregister_mux(hw);
+	else if (of_device_is_compatible(np, "fractional-divider-clock"))
+		clk_hw_unregister_fractional_divider(hw);
+}
+
+static int regclk_setup(struct device_node *np, struct regclk_ctrl *priv)
+{
+	struct clk_hw *hw = np->data;
+
+	if (of_device_is_compatible(np, "gate-clock"))
+		hw = regclk_register_gate(np, priv);
+	else if (of_device_is_compatible(np, "divider-clock"))
+		hw = regclk_register_divider(np, priv);
+	else if (of_device_is_compatible(np, "mux-clock"))
+		hw = regclk_register_mux(np, priv);
+	else if (of_device_is_compatible(np, "fractional-divider-clock"))
+		hw = regclk_register_fractional_divider(np, priv);
+	else {
+		pr_warn("%s: starnge node %s ...\n",
+		       __func__, of_node_full_name(np));
+		return 0;
+	}
+
+	if (IS_ERR(hw)) {
+		int ret = PTR_ERR(hw);
+
+		pr_err("%s: cannot register clock %s, ret %d\n",
+		       __func__, of_node_full_name(np), ret);
+		return ret;
+	}
+
+	np->data = hw;
+	return 0;
+}
+
+/** regclk_reset **/
+
+#if IS_ENABLED(CONFIG_RESET_CONTROLLER)
+static int
+regclk_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	struct regclk_ctrl *priv = container_of(rcdev, struct regclk_ctrl, rcdev);
+	unsigned long flags;
+	u32 offset = id >> 5;
+	u8 bit = id & 0x1f;
+	u32 val;
+
+	if (WARN_ON(!priv->base))
+		return 0;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	val = readl(priv->base + offset);
+	if (priv->rst_set_to_disable)
+		val &= ~BIT(bit);
+	else
+		val |= BIT(bit);
+	writel(val, priv->base + offset);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static int
+regclk_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	struct regclk_ctrl *priv = container_of(rcdev, struct regclk_ctrl, rcdev);
+	unsigned long flags;
+	u32 offset = id >> 5;
+	u8 bit = id & 0x1f;
+	u32 val;
+
+	if (WARN_ON(!priv->base))
+		return 0;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	val = readl(priv->base + offset);
+	if (priv->rst_set_to_disable)
+		val |= BIT(bit);
+	else
+		val &= ~BIT(bit);
+	writel(val, priv->base + offset);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static const struct reset_control_ops regclk_reset_ops = {
+	.assert = regclk_reset_assert,
+	.deassert = regclk_reset_deassert,
+};
+
+static int regclk_reset_of_xlate(struct reset_controller_dev *rcdev,
+				 const struct of_phandle_args *reset_spec)
+{
+	return (reset_spec->args[0] << 5) | (reset_spec->args[1] & 0x1f);
+}
+
+static void regclk_reset_unsetup(struct device_node *np)
+{
+	struct regclk_ctrl *priv = np->data;
+
+	reset_controller_unregister(&priv->rcdev);
+}
+
+static int regclk_reset_setup(struct device_node *np, struct regclk_ctrl *priv)
+{
+	priv->base = of_iomap(np, 0);
+	priv->rst_set_to_disable = of_property_read_bool(np, "set-to-disable");
+
+	/* register no matter whether reg exists, to detect dts bug */
+	priv->rcdev.ops = &regclk_reset_ops;
+	priv->rcdev.of_node = np;
+	priv->rcdev.of_reset_n_cells = 2;
+	priv->rcdev.of_xlate = regclk_reset_of_xlate;
+	return reset_controller_register(&priv->rcdev);
+}
+#else
+static void regclk_reset_unsetup(struct device_node *np)
+{
+}
+
+static int regclk_reset_setup(struct device_node *np, struct regclk_ctrl *priv)
+{
+	return 0;
+}
+#endif
+
+/** regclk_ctrl **/
+
+static void regclk_ctrl_unsetup(struct device_node *np)
+{
+	struct device_node *child;
+
+	regclk_reset_unsetup(np);
+
+	for_each_child_of_node(np, child)
+		regclk_unsetup(child);
+
+	kfree(np->data);
+}
+
+static int regclk_ctrl_setup(struct device_node *np)
+{
+	struct regclk_ctrl *priv;
+	struct device_node *child;
+	int ret;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	spin_lock_init(&priv->lock);
+	np->data = priv;
+
+	for_each_child_of_node(np, child) {
+		ret = regclk_setup(child, priv);
+		if (ret)
+			goto err;
+	}
+
+	ret = regclk_reset_setup(np, priv);
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	regclk_ctrl_unsetup(np);
+	return ret;
+}
+
+/** driver **/
+
+static void __init regclk_ctrl_init(struct device_node *np)
+{
+	regclk_ctrl_setup(np);
+}
+CLK_OF_DECLARE(regclk_ctrl, "reg-clock-controller", regclk_ctrl_init);
+
+static int regclk_ctrl_remove(struct platform_device *pdev)
+{
+	regclk_ctrl_unsetup(pdev->dev.of_node);
+
+	return 0;
+}
+
+/* This function is not executed when regclk_ctrl_init succeeded. */
+static int regclk_ctrl_probe(struct platform_device *pdev)
+{
+	return regclk_ctrl_setup(pdev->dev.of_node);
+}
+
+static const struct of_device_id regclk_ctrl_ids[] = {
+	{ .compatible = "reg-clock-controller" },
+	{ }
+};
+
+static struct platform_driver regclk_ctrl_driver = {
+	.driver = {
+		.name = "reg_clk_controller",
+		.of_match_table = regclk_ctrl_ids,
+	},
+	.probe = regclk_ctrl_probe,
+	.remove = regclk_ctrl_remove,
+};
+builtin_platform_driver(regclk_ctrl_driver);
-- 
2.39.2

