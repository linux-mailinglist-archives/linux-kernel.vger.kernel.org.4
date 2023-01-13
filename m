Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92553669563
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 12:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240146AbjAMLTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 06:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241303AbjAMLST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:18:19 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1868F167FE;
        Fri, 13 Jan 2023 03:13:08 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id q9so14755564pgq.5;
        Fri, 13 Jan 2023 03:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMr4Jvjolvie1kNByVf6UHCHNtBM6onpmmgxU3+S8jI=;
        b=V2y/1I8By+07gjw7zSm79xEpz1tgmVdb7LxN6IeuPeUcPJ+Wwdz+gqfEWlkvR5JJZT
         H8aUS3VXqk5hPwviNMFU9c/IgHix6z8stoKp8V8gi6zcRVfKnUGqDXziOCMj+zs9cHMO
         lGwDjMewXy9v4md5vmCJMWAKUmYkhBfqXveBM6k8adVx/A7LwFfOFrPjaSrZgBFR6ft0
         CxBvtxInDXyvW66AAWqPs30I7JNmg/jXzhHnCrHo/XgulNu3CRuI4kiBUQq1XsSFhj4i
         eecbVA0uX1PtPplj2tT6Qo3YFKwqf8Uny/uW22HgDm53ktL0OCvhNflzIRetUffVyfko
         HF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bMr4Jvjolvie1kNByVf6UHCHNtBM6onpmmgxU3+S8jI=;
        b=34vEyXdz9+cgXKnk5tzqyhqlneNQYcHP3k6SOwOzoTZhW7LS/F5Pt0inX4Ko6zqmZc
         9oU32RbYikPOhQDPymp3tJrkQtY//AjeVBtT4aZSfaH9odlilv5Mu5mjUxOneJZJnbUx
         tD7w9JvVWpxMyWkqu/IahBA4kTt4TIdXSpzMpPdtAm3eGmhRTXDpTaZpAsMK/0PdJ7vJ
         o4O9OA99IsiU2HlavqzTxA/KHOD8aZ2s5QgvJwhAVoKHCGK74vxHxawQ//Y02sP5xQNF
         0SnTqJUuQipqD9NoYc5oyd6KeLjDTUFeETXYL3N+p9O9QBtMCVfpjZV/L/SYn1JPy59L
         jd3g==
X-Gm-Message-State: AFqh2kqAzAAf5fkO3oVGEkRYQ/iklKJXYxabMaWm8tc5Sl5Ac42wJNVe
        VoIcD331Rv2tQW6xQXwRlAzoLUCiJFR9XZ/h
X-Google-Smtp-Source: AMrXdXud3UbUI023npSkeIMsApnfxZpxH10XvutX0QsEUK/g6DUTqBHfieixW7INSz1c6y1AtwYYcg==
X-Received: by 2002:a05:6a00:1503:b0:589:8560:a39d with SMTP id q3-20020a056a00150300b005898560a39dmr18568666pfu.0.1673608387056;
        Fri, 13 Jan 2023 03:13:07 -0800 (PST)
Received: from kelvin-ThinkPad-L14-Gen-1.. (ec2-18-163-35-77.ap-east-1.compute.amazonaws.com. [18.163.35.77])
        by smtp.gmail.com with ESMTPSA id x189-20020a6263c6000000b00576259507c0sm13410597pfb.100.2023.01.13.03.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 03:13:06 -0800 (PST)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH 2/2] clk: loongson1: Refactor to add devicetree support
Date:   Fri, 13 Jan 2023 19:07:38 +0800
Message-Id: <20230113110738.1505973-3-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230113110738.1505973-1-keguang.zhang@gmail.com>
References: <20230113110738.1505973-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch refactors Loongson-1 clock driver.
- Use CLK_OF_DECLARE() to declare the "early clocks"
  required by of_clk_init()
- Merge clk-loongson1b.c and clk-loongson1c.c into one driver
  because most of the differences between them will be moved to DT
- Add set_rate callback for ls1x_clk_divider
- Update the Kconfig/Makefile accordingly
- Update copyright

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 drivers/clk/Makefile                   |   2 +-
 drivers/clk/clk-loongson1.c            | 348 +++++++++++++++++++++++++
 drivers/clk/loongson1/Makefile         |   4 -
 drivers/clk/loongson1/clk-loongson1b.c | 118 ---------
 drivers/clk/loongson1/clk-loongson1c.c |  95 -------
 drivers/clk/loongson1/clk.c            |  41 ---
 drivers/clk/loongson1/clk.h            |  15 --
 7 files changed, 349 insertions(+), 274 deletions(-)
 create mode 100644 drivers/clk/clk-loongson1.c
 delete mode 100644 drivers/clk/loongson1/Makefile
 delete mode 100644 drivers/clk/loongson1/clk-loongson1b.c
 delete mode 100644 drivers/clk/loongson1/clk-loongson1c.c
 delete mode 100644 drivers/clk/loongson1/clk.c
 delete mode 100644 drivers/clk/loongson1/clk.h

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index e3ca0d058a25..417bc27ab6e8 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_COMMON_CLK_K210)		+= clk-k210.o
 obj-$(CONFIG_LMK04832)			+= clk-lmk04832.o
 obj-$(CONFIG_COMMON_CLK_LAN966X)	+= clk-lan966x.o
 obj-$(CONFIG_COMMON_CLK_LOCHNAGAR)	+= clk-lochnagar.o
+obj-$(CONFIG_MACH_LOONGSON32)		+= clk-loongson1.o
 obj-$(CONFIG_COMMON_CLK_MAX77686)	+= clk-max77686.o
 obj-$(CONFIG_COMMON_CLK_MAX9485)	+= clk-max9485.o
 obj-$(CONFIG_ARCH_MILBEAUT_M10V)	+= clk-milbeaut.o
@@ -93,7 +94,6 @@ obj-y					+= imx/
 obj-y					+= ingenic/
 obj-$(CONFIG_ARCH_K3)			+= keystone/
 obj-$(CONFIG_ARCH_KEYSTONE)		+= keystone/
-obj-$(CONFIG_MACH_LOONGSON32)		+= loongson1/
 obj-y					+= mediatek/
 obj-$(CONFIG_ARCH_MESON)		+= meson/
 obj-y					+= microchip/
diff --git a/drivers/clk/clk-loongson1.c b/drivers/clk/clk-loongson1.c
new file mode 100644
index 000000000000..5ce23079a590
--- /dev/null
+++ b/drivers/clk/clk-loongson1.c
@@ -0,0 +1,348 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Clock driver for Loongson-1 SoC
+ *
+ * Copyright (c) 2012-2023 Keguang Zhang <keguang.zhang@gmail.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+
+struct ls1x_clk_pll {
+	struct clk_hw hw;
+	void __iomem *reg;
+};
+
+#define to_ls1x_clk_pll(p) container_of(p, struct ls1x_clk_pll, hw)
+
+struct ls1x_clk_divider {
+	struct clk_hw hw;
+	void __iomem *reg;
+	u8 shift;
+	u8 width;
+	u8 flags;
+	const struct clk_div_table *table;
+	u8 bypass_shift;
+	u8 bypass_inv;
+	spinlock_t lock;	/* protect access to DIV registers */
+};
+
+#define to_ls1x_clk_divider(_hw) container_of(_hw, struct ls1x_clk_divider, hw)
+
+struct ls1x_clk_div_factor {
+	u8 shift;
+	u8 width;
+	unsigned long flags;
+	const struct clk_div_table *table;
+	u8 bypass_shift;
+	u8 bypass_inv;
+};
+
+static const struct ls1x_clk_div_factor ls1b_clk_cpu_div = {
+	.shift = 20,
+	.width = 4,
+	.flags = CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ROUND_CLOSEST,
+	.bypass_shift = 8,
+	.bypass_inv = 0,
+};
+
+static const struct ls1x_clk_div_factor ls1c_clk_cpu_div = {
+	.shift = 8,
+	.width = 7,
+	.flags = CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ROUND_CLOSEST,
+	.bypass_shift = 0,
+	.bypass_inv = 1,
+};
+
+static const struct ls1x_clk_div_factor ls1b_clk_ahb_div = {
+	.shift = 14,
+	.width = 4,
+	.flags = CLK_DIVIDER_ONE_BASED,
+};
+
+static const struct clk_div_table ls1c_ahb_div_table[] = {
+	[0] = { .val = 0, .div = 2 },
+	[1] = { .val = 1, .div = 4 },
+	[2] = { .val = 2, .div = 3 },
+	[3] = { .val = 3, .div = 3 },
+	[4] = { /* sentinel */ }
+};
+
+static const struct ls1x_clk_div_factor ls1c_clk_ahb_div = {
+	.shift = 0,
+	.width = 2,
+	.table = ls1c_ahb_div_table,
+	.flags = CLK_DIVIDER_ALLOW_ZERO,
+};
+
+static unsigned long ls1b_pll_recalc_rate(struct clk_hw *hw,
+					  unsigned long parent_rate)
+{
+	struct ls1x_clk_pll *pll = to_ls1x_clk_pll(hw);
+	u32 val, rate;
+
+	val = readl(pll->reg);
+	rate = 12 + (val & GENMASK(5, 0));
+	rate *= parent_rate;
+	rate >>= 1;
+
+	return rate;
+}
+
+static unsigned long ls1c_pll_recalc_rate(struct clk_hw *hw,
+					  unsigned long parent_rate)
+{
+	struct ls1x_clk_pll *pll = to_ls1x_clk_pll(hw);
+	u32 val, rate;
+
+	val = readl(pll->reg);
+	rate = ((val >> 8) & 0xff) + ((val >> 16) & 0xff);
+	rate *= parent_rate;
+	rate >>= 2;
+
+	return rate;
+}
+
+static const struct clk_ops ls1b_pll_clk_ops = {
+	.recalc_rate = ls1b_pll_recalc_rate,
+};
+
+static const struct clk_ops ls1c_pll_clk_ops = {
+	.recalc_rate = ls1c_pll_recalc_rate,
+};
+
+struct clk_hw *__init ls1x_clk_hw_register_pll(struct device *dev,
+					       const char *name,
+					       const char *parent_name,
+					       void __iomem *reg,
+					       const struct clk_ops *ops)
+{
+	struct ls1x_clk_pll *pll;
+	struct clk_hw *hw;
+	struct clk_init_data init = {};
+	int ret;
+
+	/* allocate the clock pll */
+	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = ops;
+	init.parent_names = parent_name ? &parent_name : NULL;
+	init.num_parents = parent_name ? 1 : 0;
+
+	/* struct ls1x_clk_pll assignments */
+	pll->reg = reg;
+	pll->hw.init = &init;
+
+	/* register the clock */
+	hw = &pll->hw;
+	ret = clk_hw_register(dev, hw);
+	if (ret) {
+		kfree(hw);
+		hw = ERR_PTR(ret);
+	}
+
+	return hw;
+}
+
+static unsigned long ls1x_divider_recalc_rate(struct clk_hw *hw,
+					      unsigned long parent_rate)
+{
+	struct ls1x_clk_divider *divider = to_ls1x_clk_divider(hw);
+	unsigned int val;
+
+	val = readl(divider->reg) >> divider->shift;
+	val &= clk_div_mask(divider->width);
+
+	return divider_recalc_rate(hw, parent_rate, val, divider->table,
+				   divider->flags, divider->width);
+}
+
+static long ls1x_divider_round_rate(struct clk_hw *hw, unsigned long rate,
+				    unsigned long *prate)
+{
+	struct ls1x_clk_divider *divider = to_ls1x_clk_divider(hw);
+
+	return divider_round_rate(hw, rate, prate, divider->table,
+				  divider->width, divider->flags);
+}
+
+static int ls1x_divider_set_rate(struct clk_hw *hw, unsigned long rate,
+				 unsigned long parent_rate)
+{
+	struct ls1x_clk_divider *divider = to_ls1x_clk_divider(hw);
+	int value;
+	unsigned long flags = 0;
+	u32 val;
+
+	value = divider_get_val(rate, parent_rate, divider->table,
+				divider->width, divider->flags);
+	if (value < 0)
+		return value;
+
+	if (&divider->lock)
+		spin_lock_irqsave(&divider->lock, flags);
+	else
+		__acquire(&divider->lock);
+
+	/* Bypass the clock */
+	val = readl(divider->reg);
+	if (divider->bypass_inv)
+		val &= ~BIT(divider->bypass_shift);
+	else
+		val |= BIT(divider->bypass_shift);
+	writel(val, divider->reg);
+
+	val = readl(divider->reg);
+	val &= ~(clk_div_mask(divider->width) << divider->shift);
+	val |= (u32)value << divider->shift;
+	writel(val, divider->reg);
+
+	/* Restore the clock */
+	val = readl(divider->reg);
+	if (divider->bypass_inv)
+		val |= BIT(divider->bypass_shift);
+	else
+		val &= ~BIT(divider->bypass_shift);
+	writel(val, divider->reg);
+
+	if (&divider->lock)
+		spin_unlock_irqrestore(&divider->lock, flags);
+	else
+		__release(&divider->lock);
+
+	return 0;
+}
+
+static const struct clk_ops ls1x_clk_divider_ops = {
+	.recalc_rate = ls1x_divider_recalc_rate,
+	.round_rate = ls1x_divider_round_rate,
+	.set_rate = ls1x_divider_set_rate,
+};
+
+struct clk_hw *__init ls1x_clk_hw_register_divider(struct device *dev,
+						   const char *name,
+						   const char *parent_name,
+						   unsigned long flags,
+						   void __iomem *reg,
+						   const struct
+						   ls1x_clk_div_factor *factor)
+{
+	struct ls1x_clk_divider *div;
+	struct clk_hw *hw;
+	struct clk_init_data init = {};
+	int ret;
+
+	/* allocate the clock divider */
+	div = kzalloc(sizeof(*div), GFP_KERNEL);
+	if (!div)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &ls1x_clk_divider_ops;
+	init.flags = flags;
+	init.parent_names = parent_name ? &parent_name : NULL;
+	if (parent_name)
+		init.num_parents = 1;
+	else
+		init.num_parents = 0;
+
+	/* struct ls1x_clk_divider assignments */
+	div->reg = reg;
+	div->shift = factor->shift;
+	div->width = factor->width;
+	div->flags = factor->flags;
+	div->hw.init = &init;
+	div->table = factor->table;
+	div->bypass_shift = factor->bypass_shift;
+	div->bypass_inv = factor->bypass_inv;
+	spin_lock_init(&div->lock);
+
+	/* register the clock */
+	hw = &div->hw;
+	ret = clk_hw_register(dev, hw);
+	if (ret) {
+		kfree(div);
+		hw = ERR_PTR(ret);
+	}
+
+	return hw;
+}
+
+static const struct of_device_id ls1x_pll_match[] __initconst = {
+	{ .compatible = "loongson,ls1b-clk-pll", .data = &ls1b_pll_clk_ops, },
+	{ .compatible = "loongson,ls1c-clk-pll", .data = &ls1c_pll_clk_ops, },
+	{ /* sentinel */ }
+};
+
+static void __init of_ls1x_pll_init(struct device_node *np)
+{
+	struct clk_hw *hw;
+	const char *clk_name = np->name;
+	const char *parent_name;
+	const struct of_device_id *match;
+	void __iomem *reg;
+
+	reg = of_iomap(np, 0);
+	if (!reg) {
+		pr_err("Unable to map PLL register for %pOF\n", np);
+		return;
+	}
+
+	parent_name = of_clk_get_parent_name(np, 0);
+
+	match = of_match_node(ls1x_pll_match, np);
+	if (WARN_ON(!match))
+		return;
+
+	hw = ls1x_clk_hw_register_pll(NULL, clk_name, parent_name,
+				      reg, match->data);
+	if (!IS_ERR(hw))
+		of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
+}
+
+CLK_OF_DECLARE(ls1b_clk_pll, "loongson,ls1b-clk-pll", of_ls1x_pll_init);
+CLK_OF_DECLARE(ls1c_clk_pll, "loongson,ls1c-clk-pll", of_ls1x_pll_init);
+
+static const struct of_device_id ls1x_divider_match[] __initconst = {
+	{ .compatible = "loongson,ls1b-clk-cpu", .data = &ls1b_clk_cpu_div, },
+	{ .compatible = "loongson,ls1b-clk-ahb", .data = &ls1b_clk_ahb_div, },
+	{ .compatible = "loongson,ls1c-clk-cpu", .data = &ls1c_clk_cpu_div, },
+	{ .compatible = "loongson,ls1c-clk-ahb", .data = &ls1c_clk_ahb_div, },
+	{ /* sentinel */ }
+};
+
+static void __init of_ls1x_divider_init(struct device_node *np)
+{
+	struct clk_hw *hw;
+	const char *clk_name = np->name;
+	const char *parent_name;
+	const struct of_device_id *match;
+	void __iomem *reg;
+
+	reg = of_iomap(np, 0);
+	if (!reg) {
+		pr_err("Unable to map DIV register for %pOF\n", np);
+		return;
+	}
+
+	parent_name = of_clk_get_parent_name(np, 0);
+
+	match = of_match_node(ls1x_divider_match, np);
+	if (!match)
+		return;
+
+	hw = ls1x_clk_hw_register_divider(NULL, clk_name, parent_name,
+					  CLK_GET_RATE_NOCACHE, reg,
+					  match->data);
+	if (!IS_ERR(hw))
+		of_clk_add_hw_provider(np, of_clk_hw_simple_get, hw);
+}
+
+CLK_OF_DECLARE(ls1b_clk_cpu, "loongson,ls1b-clk-cpu", of_ls1x_divider_init);
+CLK_OF_DECLARE(ls1b_clk_ahb, "loongson,ls1b-clk-ahb", of_ls1x_divider_init);
+CLK_OF_DECLARE(ls1c_clk_cpu, "loongson,ls1c-clk-cpu", of_ls1x_divider_init);
+CLK_OF_DECLARE(ls1c_clk_ahb, "loongson,ls1c-clk-ahb", of_ls1x_divider_init);
diff --git a/drivers/clk/loongson1/Makefile b/drivers/clk/loongson1/Makefile
deleted file mode 100644
index 251d0fe9dcd1..000000000000
--- a/drivers/clk/loongson1/Makefile
+++ /dev/null
@@ -1,4 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-obj-y				+= clk.o
-obj-$(CONFIG_LOONGSON1_LS1B)	+= clk-loongson1b.o
-obj-$(CONFIG_LOONGSON1_LS1C)	+= clk-loongson1c.o
diff --git a/drivers/clk/loongson1/clk-loongson1b.c b/drivers/clk/loongson1/clk-loongson1b.c
deleted file mode 100644
index 13a2ca23a159..000000000000
--- a/drivers/clk/loongson1/clk-loongson1b.c
+++ /dev/null
@@ -1,118 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) 2012-2016 Zhang, Keguang <keguang.zhang@gmail.com>
- */
-
-#include <linux/clkdev.h>
-#include <linux/clk-provider.h>
-#include <linux/io.h>
-#include <linux/err.h>
-
-#include <loongson1.h>
-#include "clk.h"
-
-#define OSC		(33 * 1000000)
-#define DIV_APB		2
-
-static DEFINE_SPINLOCK(_lock);
-
-static unsigned long ls1x_pll_recalc_rate(struct clk_hw *hw,
-					  unsigned long parent_rate)
-{
-	u32 pll, rate;
-
-	pll = __raw_readl(LS1X_CLK_PLL_FREQ);
-	rate = 12 + (pll & GENMASK(5, 0));
-	rate *= OSC;
-	rate >>= 1;
-
-	return rate;
-}
-
-static const struct clk_ops ls1x_pll_clk_ops = {
-	.recalc_rate = ls1x_pll_recalc_rate,
-};
-
-static const char *const cpu_parents[] = { "cpu_clk_div", "osc_clk", };
-static const char *const ahb_parents[] = { "ahb_clk_div", "osc_clk", };
-static const char *const dc_parents[] = { "dc_clk_div", "osc_clk", };
-
-void __init ls1x_clk_init(void)
-{
-	struct clk_hw *hw;
-
-	hw = clk_hw_register_fixed_rate(NULL, "osc_clk", NULL, 0, OSC);
-	clk_hw_register_clkdev(hw, "osc_clk", NULL);
-
-	/* clock derived from 33 MHz OSC clk */
-	hw = clk_hw_register_pll(NULL, "pll_clk", "osc_clk",
-				 &ls1x_pll_clk_ops, 0);
-	clk_hw_register_clkdev(hw, "pll_clk", NULL);
-
-	/* clock derived from PLL clk */
-	/*                                 _____
-	 *         _______________________|     |
-	 * OSC ___/                       | MUX |___ CPU CLK
-	 *        \___ PLL ___ CPU DIV ___|     |
-	 *                                |_____|
-	 */
-	hw = clk_hw_register_divider(NULL, "cpu_clk_div", "pll_clk",
-				   CLK_GET_RATE_NOCACHE, LS1X_CLK_PLL_DIV,
-				   DIV_CPU_SHIFT, DIV_CPU_WIDTH,
-				   CLK_DIVIDER_ONE_BASED |
-				   CLK_DIVIDER_ROUND_CLOSEST, &_lock);
-	clk_hw_register_clkdev(hw, "cpu_clk_div", NULL);
-	hw = clk_hw_register_mux(NULL, "cpu_clk", cpu_parents,
-			       ARRAY_SIZE(cpu_parents),
-			       CLK_SET_RATE_NO_REPARENT, LS1X_CLK_PLL_DIV,
-			       BYPASS_CPU_SHIFT, BYPASS_CPU_WIDTH, 0, &_lock);
-	clk_hw_register_clkdev(hw, "cpu_clk", NULL);
-
-	/*                                 _____
-	 *         _______________________|     |
-	 * OSC ___/                       | MUX |___ DC  CLK
-	 *        \___ PLL ___ DC  DIV ___|     |
-	 *                                |_____|
-	 */
-	hw = clk_hw_register_divider(NULL, "dc_clk_div", "pll_clk",
-				   0, LS1X_CLK_PLL_DIV, DIV_DC_SHIFT,
-				   DIV_DC_WIDTH, CLK_DIVIDER_ONE_BASED, &_lock);
-	clk_hw_register_clkdev(hw, "dc_clk_div", NULL);
-	hw = clk_hw_register_mux(NULL, "dc_clk", dc_parents,
-			       ARRAY_SIZE(dc_parents),
-			       CLK_SET_RATE_NO_REPARENT, LS1X_CLK_PLL_DIV,
-			       BYPASS_DC_SHIFT, BYPASS_DC_WIDTH, 0, &_lock);
-	clk_hw_register_clkdev(hw, "dc_clk", NULL);
-
-	/*                                 _____
-	 *         _______________________|     |
-	 * OSC ___/                       | MUX |___ DDR CLK
-	 *        \___ PLL ___ DDR DIV ___|     |
-	 *                                |_____|
-	 */
-	hw = clk_hw_register_divider(NULL, "ahb_clk_div", "pll_clk",
-				   0, LS1X_CLK_PLL_DIV, DIV_DDR_SHIFT,
-				   DIV_DDR_WIDTH, CLK_DIVIDER_ONE_BASED,
-				   &_lock);
-	clk_hw_register_clkdev(hw, "ahb_clk_div", NULL);
-	hw = clk_hw_register_mux(NULL, "ahb_clk", ahb_parents,
-			       ARRAY_SIZE(ahb_parents),
-			       CLK_SET_RATE_NO_REPARENT, LS1X_CLK_PLL_DIV,
-			       BYPASS_DDR_SHIFT, BYPASS_DDR_WIDTH, 0, &_lock);
-	clk_hw_register_clkdev(hw, "ahb_clk", NULL);
-	clk_hw_register_clkdev(hw, "ls1x-dma", NULL);
-	clk_hw_register_clkdev(hw, "stmmaceth", NULL);
-
-	/* clock derived from AHB clk */
-	/* APB clk is always half of the AHB clk */
-	hw = clk_hw_register_fixed_factor(NULL, "apb_clk", "ahb_clk", 0, 1,
-					DIV_APB);
-	clk_hw_register_clkdev(hw, "apb_clk", NULL);
-	clk_hw_register_clkdev(hw, "ls1x-ac97", NULL);
-	clk_hw_register_clkdev(hw, "ls1x-i2c", NULL);
-	clk_hw_register_clkdev(hw, "ls1x-nand", NULL);
-	clk_hw_register_clkdev(hw, "ls1x-pwmtimer", NULL);
-	clk_hw_register_clkdev(hw, "ls1x-spi", NULL);
-	clk_hw_register_clkdev(hw, "ls1x-wdt", NULL);
-	clk_hw_register_clkdev(hw, "serial8250", NULL);
-}
diff --git a/drivers/clk/loongson1/clk-loongson1c.c b/drivers/clk/loongson1/clk-loongson1c.c
deleted file mode 100644
index 1ebf740380ef..000000000000
--- a/drivers/clk/loongson1/clk-loongson1c.c
+++ /dev/null
@@ -1,95 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) 2016 Yang Ling <gnaygnil@gmail.com>
- */
-
-#include <linux/clkdev.h>
-#include <linux/clk-provider.h>
-#include <linux/io.h>
-
-#include <loongson1.h>
-#include "clk.h"
-
-#define OSC		(24 * 1000000)
-#define DIV_APB		1
-
-static DEFINE_SPINLOCK(_lock);
-
-static unsigned long ls1x_pll_recalc_rate(struct clk_hw *hw,
-					  unsigned long parent_rate)
-{
-	u32 pll, rate;
-
-	pll = __raw_readl(LS1X_CLK_PLL_FREQ);
-	rate = ((pll >> 8) & 0xff) + ((pll >> 16) & 0xff);
-	rate *= OSC;
-	rate >>= 2;
-
-	return rate;
-}
-
-static const struct clk_ops ls1x_pll_clk_ops = {
-	.recalc_rate = ls1x_pll_recalc_rate,
-};
-
-static const struct clk_div_table ahb_div_table[] = {
-	[0] = { .val = 0, .div = 2 },
-	[1] = { .val = 1, .div = 4 },
-	[2] = { .val = 2, .div = 3 },
-	[3] = { .val = 3, .div = 3 },
-	[4] = { /* sentinel */ }
-};
-
-void __init ls1x_clk_init(void)
-{
-	struct clk_hw *hw;
-
-	hw = clk_hw_register_fixed_rate(NULL, "osc_clk", NULL, 0, OSC);
-	clk_hw_register_clkdev(hw, "osc_clk", NULL);
-
-	/* clock derived from 24 MHz OSC clk */
-	hw = clk_hw_register_pll(NULL, "pll_clk", "osc_clk",
-				&ls1x_pll_clk_ops, 0);
-	clk_hw_register_clkdev(hw, "pll_clk", NULL);
-
-	hw = clk_hw_register_divider(NULL, "cpu_clk_div", "pll_clk",
-				   CLK_GET_RATE_NOCACHE, LS1X_CLK_PLL_DIV,
-				   DIV_CPU_SHIFT, DIV_CPU_WIDTH,
-				   CLK_DIVIDER_ONE_BASED |
-				   CLK_DIVIDER_ROUND_CLOSEST, &_lock);
-	clk_hw_register_clkdev(hw, "cpu_clk_div", NULL);
-	hw = clk_hw_register_fixed_factor(NULL, "cpu_clk", "cpu_clk_div",
-					0, 1, 1);
-	clk_hw_register_clkdev(hw, "cpu_clk", NULL);
-
-	hw = clk_hw_register_divider(NULL, "dc_clk_div", "pll_clk",
-				   0, LS1X_CLK_PLL_DIV, DIV_DC_SHIFT,
-				   DIV_DC_WIDTH, CLK_DIVIDER_ONE_BASED, &_lock);
-	clk_hw_register_clkdev(hw, "dc_clk_div", NULL);
-	hw = clk_hw_register_fixed_factor(NULL, "dc_clk", "dc_clk_div",
-					0, 1, 1);
-	clk_hw_register_clkdev(hw, "dc_clk", NULL);
-
-	hw = clk_hw_register_divider_table(NULL, "ahb_clk_div", "cpu_clk_div",
-				0, LS1X_CLK_PLL_FREQ, DIV_DDR_SHIFT,
-				DIV_DDR_WIDTH, CLK_DIVIDER_ALLOW_ZERO,
-				ahb_div_table, &_lock);
-	clk_hw_register_clkdev(hw, "ahb_clk_div", NULL);
-	hw = clk_hw_register_fixed_factor(NULL, "ahb_clk", "ahb_clk_div",
-					0, 1, 1);
-	clk_hw_register_clkdev(hw, "ahb_clk", NULL);
-	clk_hw_register_clkdev(hw, "ls1x-dma", NULL);
-	clk_hw_register_clkdev(hw, "stmmaceth", NULL);
-
-	/* clock derived from AHB clk */
-	hw = clk_hw_register_fixed_factor(NULL, "apb_clk", "ahb_clk", 0, 1,
-					DIV_APB);
-	clk_hw_register_clkdev(hw, "apb_clk", NULL);
-	clk_hw_register_clkdev(hw, "ls1x-ac97", NULL);
-	clk_hw_register_clkdev(hw, "ls1x-i2c", NULL);
-	clk_hw_register_clkdev(hw, "ls1x-nand", NULL);
-	clk_hw_register_clkdev(hw, "ls1x-pwmtimer", NULL);
-	clk_hw_register_clkdev(hw, "ls1x-spi", NULL);
-	clk_hw_register_clkdev(hw, "ls1x-wdt", NULL);
-	clk_hw_register_clkdev(hw, "serial8250", NULL);
-}
diff --git a/drivers/clk/loongson1/clk.c b/drivers/clk/loongson1/clk.c
deleted file mode 100644
index f336a3126d31..000000000000
--- a/drivers/clk/loongson1/clk.c
+++ /dev/null
@@ -1,41 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) 2012-2016 Zhang, Keguang <keguang.zhang@gmail.com>
- */
-
-#include <linux/clk-provider.h>
-#include <linux/slab.h>
-
-#include "clk.h"
-
-struct clk_hw *__init clk_hw_register_pll(struct device *dev,
-					  const char *name,
-					  const char *parent_name,
-					  const struct clk_ops *ops,
-					  unsigned long flags)
-{
-	int ret;
-	struct clk_hw *hw;
-	struct clk_init_data init;
-
-	/* allocate the divider */
-	hw = kzalloc(sizeof(*hw), GFP_KERNEL);
-	if (!hw)
-		return ERR_PTR(-ENOMEM);
-
-	init.name = name;
-	init.ops = ops;
-	init.flags = flags;
-	init.parent_names = parent_name ? &parent_name : NULL;
-	init.num_parents = parent_name ? 1 : 0;
-	hw->init = &init;
-
-	/* register the clock */
-	ret = clk_hw_register(dev, hw);
-	if (ret) {
-		kfree(hw);
-		hw = ERR_PTR(ret);
-	}
-
-	return hw;
-}
diff --git a/drivers/clk/loongson1/clk.h b/drivers/clk/loongson1/clk.h
deleted file mode 100644
index 124642302b12..000000000000
--- a/drivers/clk/loongson1/clk.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (c) 2012-2016 Zhang, Keguang <keguang.zhang@gmail.com>
- */
-
-#ifndef __LOONGSON1_CLK_H
-#define __LOONGSON1_CLK_H
-
-struct clk_hw *clk_hw_register_pll(struct device *dev,
-				   const char *name,
-				   const char *parent_name,
-				   const struct clk_ops *ops,
-				   unsigned long flags);
-
-#endif /* __LOONGSON1_CLK_H */
-- 
2.34.1

