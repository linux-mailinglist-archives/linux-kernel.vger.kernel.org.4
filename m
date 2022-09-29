Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B50C5EFC77
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 19:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbiI2R4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 13:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbiI2R4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 13:56:22 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AB7153EF4;
        Thu, 29 Sep 2022 10:56:18 -0700 (PDT)
X-QQ-mid: bizesmtp81t1664474169tp5891fl
Received: from localhost.localdomain ( [113.72.145.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Sep 2022 01:56:07 +0800 (CST)
X-QQ-SSF: 01000000002000303000B00A0000000
X-QQ-FEAT: 94bDzg3aFVmsA2wlf8vCJTd89GG/oKhQn8cTEwgw8vxFDBdqntyPz95Ed5uIj
        lXCsL7x7A5Mp48vnsVcOpKxneR+dQp4bkwzGZwaIx6KLWZc4brwGw3GHMKZdH7sTrLuiGXg
        9EjBN96kIFQuSQp4X5SPFKhMYMo6NWYEsrlztj0gui1J4CZXIJs2PI23GeEor7LoSXJJ8WV
        XUOVGrJlatmzdPiOmH/oIucZrC4Nf7Dk5lpjtd8bBkU3qE/1rx8huRvrzq5xrRxE+BXE4Le
        yBciAGunTTHMbCV+54NqcTBqUbWPu5Nz24jKWbqbI7dtVdYLRLA8CBXrBSFnMfF1XhxZXhY
        Np3dXvfUWOawGu/Weg+DBbHOWoOICeZ00ue2RIIVQexBDeGozSe8SWaRAVFlF5v8YoneyAX
        eMZLLU8KNag=
X-QQ-GoodBg: 0
From:   Hal Feng <hal.feng@linux.starfivetech.com>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@linux.starfivetech.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 15/30] clk: starfive: Use regmap APIs to operate registers
Date:   Fri, 30 Sep 2022 01:56:02 +0800
Message-Id: <20220929175602.19946-1-hal.feng@linux.starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:linux.starfivetech.com:qybglogicsvr:qybglogicsvr2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clock registers address region is shared with reset controller
on the new StarFive JH7110 SoC. Change to use regmap framework
to allow base address sharing and preparation for JH7110 clock
support.

Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
---
 .../clk/starfive/clk-starfive-jh7100-audio.c  | 11 ++--
 drivers/clk/starfive/clk-starfive-jh7100.c    | 11 ++--
 drivers/clk/starfive/clk-starfive.c           | 66 ++++++++++++-------
 drivers/clk/starfive/clk-starfive.h           |  4 +-
 4 files changed, 56 insertions(+), 36 deletions(-)

diff --git a/drivers/clk/starfive/clk-starfive-jh7100-audio.c b/drivers/clk/starfive/clk-starfive-jh7100-audio.c
index 41389cacfe03..4168209d6600 100644
--- a/drivers/clk/starfive/clk-starfive-jh7100-audio.c
+++ b/drivers/clk/starfive/clk-starfive-jh7100-audio.c
@@ -9,6 +9,7 @@
 #include <linux/clk-provider.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
@@ -108,11 +109,13 @@ static int jh7100_audclk_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	spin_lock_init(&priv->rmw_lock);
 	priv->dev = &pdev->dev;
-	priv->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(priv->base))
-		return PTR_ERR(priv->base);
+	priv->regmap = device_node_to_regmap(priv->dev->of_node);
+	if (IS_ERR(priv->regmap)) {
+		dev_err(priv->dev, "failed to get regmap (error %ld)\n",
+			PTR_ERR(priv->regmap));
+		return PTR_ERR(priv->regmap);
+	}
 
 	for (idx = 0; idx < JH7100_AUDCLK_END; idx++) {
 		u32 max = jh7100_audclk_data[idx].max;
diff --git a/drivers/clk/starfive/clk-starfive-jh7100.c b/drivers/clk/starfive/clk-starfive-jh7100.c
index 014e36f17595..410aa6e06842 100644
--- a/drivers/clk/starfive/clk-starfive-jh7100.c
+++ b/drivers/clk/starfive/clk-starfive-jh7100.c
@@ -10,6 +10,7 @@
 #include <linux/clk-provider.h>
 #include <linux/device.h>
 #include <linux/init.h>
+#include <linux/mfd/syscon.h>
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 
@@ -295,11 +296,13 @@ static int __init clk_starfive_jh7100_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	spin_lock_init(&priv->rmw_lock);
 	priv->dev = &pdev->dev;
-	priv->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(priv->base))
-		return PTR_ERR(priv->base);
+	priv->regmap = device_node_to_regmap(priv->dev->of_node);
+	if (IS_ERR(priv->regmap)) {
+		dev_err(priv->dev, "failed to get regmap (error %ld)\n",
+			PTR_ERR(priv->regmap));
+		return PTR_ERR(priv->regmap);
+	}
 
 	priv->pll[0] = devm_clk_hw_register_fixed_factor(priv->dev, "pll0_out",
 							 "osc_sys", 0, 40, 1);
diff --git a/drivers/clk/starfive/clk-starfive.c b/drivers/clk/starfive/clk-starfive.c
index 76e3d45b5d86..e428476417c5 100644
--- a/drivers/clk/starfive/clk-starfive.c
+++ b/drivers/clk/starfive/clk-starfive.c
@@ -9,6 +9,9 @@
 #include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/regmap.h>
 
 #include "clk-starfive.h"
 
@@ -25,36 +28,36 @@ static struct starfive_clk_priv *starfive_priv_from(struct starfive_clk *clk)
 static u32 starfive_clk_reg_get(struct starfive_clk *clk)
 {
 	struct starfive_clk_priv *priv = starfive_priv_from(clk);
-	void __iomem *reg = priv->base + 4 * clk->idx;
+	unsigned int reg = sizeof(u32) * clk->idx;
+	unsigned int value;
+	int ret;
 
-	return readl_relaxed(reg);
-}
-
-static void starfive_clk_reg_rmw(struct starfive_clk *clk, u32 mask, u32 value)
-{
-	struct starfive_clk_priv *priv = starfive_priv_from(clk);
-	void __iomem *reg = priv->base + 4 * clk->idx;
-	unsigned long flags;
+	ret = regmap_read(priv->regmap, reg, &value);
+	if (ret) {
+		dev_warn(priv->dev, "Failed to read clock register: %d\n", ret);
+		value = 0;
+	}
 
-	spin_lock_irqsave(&priv->rmw_lock, flags);
-	value |= readl_relaxed(reg) & ~mask;
-	writel_relaxed(value, reg);
-	spin_unlock_irqrestore(&priv->rmw_lock, flags);
+	return value;
 }
 
 static int starfive_clk_enable(struct clk_hw *hw)
 {
 	struct starfive_clk *clk = starfive_clk_from(hw);
+	struct starfive_clk_priv *priv = starfive_priv_from(clk);
+	unsigned int reg = sizeof(u32) * clk->idx;
 
-	starfive_clk_reg_rmw(clk, STARFIVE_CLK_ENABLE, STARFIVE_CLK_ENABLE);
-	return 0;
+	return regmap_update_bits(priv->regmap, reg,
+				  STARFIVE_CLK_ENABLE, STARFIVE_CLK_ENABLE);
 }
 
 static void starfive_clk_disable(struct clk_hw *hw)
 {
 	struct starfive_clk *clk = starfive_clk_from(hw);
+	struct starfive_clk_priv *priv = starfive_priv_from(clk);
+	unsigned int reg = sizeof(u32) * clk->idx;
 
-	starfive_clk_reg_rmw(clk, STARFIVE_CLK_ENABLE, 0);
+	regmap_update_bits(priv->regmap, reg, STARFIVE_CLK_ENABLE, 0);
 }
 
 static int starfive_clk_is_enabled(struct clk_hw *hw)
@@ -107,11 +110,12 @@ static int starfive_clk_set_rate(struct clk_hw *hw,
 				 unsigned long parent_rate)
 {
 	struct starfive_clk *clk = starfive_clk_from(hw);
+	struct starfive_clk_priv *priv = starfive_priv_from(clk);
+	unsigned int reg = sizeof(u32) * clk->idx;
 	unsigned long div = clamp(DIV_ROUND_CLOSEST(parent_rate, rate),
 				  1UL, (unsigned long)clk->max_div);
 
-	starfive_clk_reg_rmw(clk, STARFIVE_CLK_DIV_MASK, div);
-	return 0;
+	return regmap_update_bits(priv->regmap, reg, STARFIVE_CLK_DIV_MASK, div);
 }
 
 static unsigned long starfive_clk_frac_recalc_rate(struct clk_hw *hw,
@@ -149,12 +153,13 @@ static int starfive_clk_frac_set_rate(struct clk_hw *hw,
 				      unsigned long parent_rate)
 {
 	struct starfive_clk *clk = starfive_clk_from(hw);
+	struct starfive_clk_priv *priv = starfive_priv_from(clk);
+	unsigned int reg = sizeof(u32) * clk->idx;
 	unsigned long div100 = clamp(DIV_ROUND_CLOSEST(100 * parent_rate, rate),
 				     STARFIVE_CLK_FRAC_MIN, STARFIVE_CLK_FRAC_MAX);
 	u32 value = ((div100 % 100) << STARFIVE_CLK_FRAC_SHIFT) | (div100 / 100);
 
-	starfive_clk_reg_rmw(clk, STARFIVE_CLK_DIV_MASK, value);
-	return 0;
+	return regmap_update_bits(priv->regmap, reg, STARFIVE_CLK_DIV_MASK, value);
 }
 
 static u8 starfive_clk_get_parent(struct clk_hw *hw)
@@ -168,10 +173,11 @@ static u8 starfive_clk_get_parent(struct clk_hw *hw)
 static int starfive_clk_set_parent(struct clk_hw *hw, u8 index)
 {
 	struct starfive_clk *clk = starfive_clk_from(hw);
+	struct starfive_clk_priv *priv = starfive_priv_from(clk);
+	unsigned int reg = sizeof(u32) * clk->idx;
 	u32 value = (u32)index << STARFIVE_CLK_MUX_SHIFT;
 
-	starfive_clk_reg_rmw(clk, STARFIVE_CLK_MUX_MASK, value);
-	return 0;
+	return regmap_update_bits(priv->regmap, reg, STARFIVE_CLK_MUX_MASK, value);
 }
 
 static int starfive_clk_mux_determine_rate(struct clk_hw *hw,
@@ -191,6 +197,8 @@ static int starfive_clk_get_phase(struct clk_hw *hw)
 static int starfive_clk_set_phase(struct clk_hw *hw, int degrees)
 {
 	struct starfive_clk *clk = starfive_clk_from(hw);
+	struct starfive_clk_priv *priv = starfive_priv_from(clk);
+	unsigned int reg = sizeof(u32) * clk->idx;
 	u32 value;
 
 	if (degrees == 0)
@@ -200,8 +208,7 @@ static int starfive_clk_set_phase(struct clk_hw *hw, int degrees)
 	else
 		return -EINVAL;
 
-	starfive_clk_reg_rmw(clk, STARFIVE_CLK_INVERT, value);
-	return 0;
+	return regmap_update_bits(priv->regmap, reg, STARFIVE_CLK_INVERT, value);
 }
 
 #ifdef CONFIG_DEBUG_FS
@@ -214,6 +221,7 @@ static void starfive_clk_debug_init(struct clk_hw *hw, struct dentry *dentry)
 	struct starfive_clk *clk = starfive_clk_from(hw);
 	struct starfive_clk_priv *priv = starfive_priv_from(clk);
 	struct debugfs_regset32 *regset;
+	void __iomem *base;
 
 	regset = devm_kzalloc(priv->dev, sizeof(*regset), GFP_KERNEL);
 	if (!regset)
@@ -221,7 +229,15 @@ static void starfive_clk_debug_init(struct clk_hw *hw, struct dentry *dentry)
 
 	regset->regs = &starfive_clk_reg;
 	regset->nregs = 1;
-	regset->base = priv->base + 4 * clk->idx;
+
+	base = of_iomap(priv->dev->of_node, 0);
+	if (!base) {
+		base = of_iomap(priv->dev->of_node->parent, 0);
+		if (!base)
+			return;
+	}
+
+	regset->base = base + sizeof(u32) * clk->idx;
 
 	debugfs_create_regset32("registers", 0400, dentry, regset);
 }
diff --git a/drivers/clk/starfive/clk-starfive.h b/drivers/clk/starfive/clk-starfive.h
index 6b05cf1bfbb6..99cf74e8cbde 100644
--- a/drivers/clk/starfive/clk-starfive.h
+++ b/drivers/clk/starfive/clk-starfive.h
@@ -101,10 +101,8 @@ struct starfive_clk {
 };
 
 struct starfive_clk_priv {
-	/* protect clk enable and set rate/parent from happening at the same time */
-	spinlock_t rmw_lock;
 	struct device *dev;
-	void __iomem *base;
+	struct regmap *regmap;
 	struct clk_hw *pll[3];
 	struct starfive_clk reg[];
 };
-- 
2.17.1

