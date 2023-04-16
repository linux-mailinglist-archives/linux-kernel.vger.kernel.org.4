Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91396E3BA8
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 21:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjDPTrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 15:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjDPTrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 15:47:41 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126B535A3;
        Sun, 16 Apr 2023 12:47:37 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id g6so6530785pjx.4;
        Sun, 16 Apr 2023 12:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681674457; x=1684266457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSrRFiyosuWW/GNoXp6d9t9RRxXJdRUwrLc5G51X3r4=;
        b=gxmMxbe4nvL+QW0NHprvSvcBsVjIgGir/LDWubXOXuVFXax5Nvftm2AGdfVbCil6sd
         QvFmj9NtnUTDM+AUWvmIkADgOg/onSgiyIcue4lr2BFMN6H03HvRXuIW0AsSomEARoFk
         s3+U7t+xGGrrCrx+FJac5fgPLdgwtWqCVwP0JdGOfuNEcL0upcjrezvVQI+J7RWxeWZU
         pFhlSbEIW0Ta+7H/gkz5lxTKGfBms3QzaYazNe3TYzNWkHUFVI/0Ss3sVotRKTmokCz1
         jrG29BDtxye7xDfSCXoxDb7SdQAns8vc7aAvECtNU06YXHyzm6lKksOTUCfreBOBBx49
         f/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681674457; x=1684266457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSrRFiyosuWW/GNoXp6d9t9RRxXJdRUwrLc5G51X3r4=;
        b=fQvWr6E0lHlbrQ2US98pJEnN0ry3gl9gwSma2m7ubbChD+oRyQ5wZjmE8j6QQAjJdu
         Eh85hEsqk6mPrc5I0ikK0mNMuVa0q0cP12CBbGXG672ah6wRswgVYXO8tidlOp9SC4UC
         Ezj4FAXYJQ/JVE3ZNt7q4Q4BPTatSOnN9KBoCW7vTk/XB/0oM0d5m6aq3x8lL675Ld19
         A7LRnWro2v5cZ3uFE7Zyr/v1Z2z+0GFFBTBnHdBmkp63//PHbTXRrbGa/O8uQ0AIWBOK
         EJ29b9DDiEO59eyj0M8/DawKWPThgj34Zw4dDRITkPz7HTziS3PEEaMioWD8C80PsDzz
         tJwg==
X-Gm-Message-State: AAQBX9dm5gteEVMad0nmgu49vq605babnfM3SwbfIcVvKZv9fleSftVa
        Mb44bHk/huSshRpiSOtmPBGWVnKcjAHmqsgR65Y=
X-Google-Smtp-Source: AKy350buBDqSEPzMK6gPKxwDpv7z0G++jROpu4Iptl5zv5uabF2Q9+fMpMjcIzElhJgdBsr75NU74Q==
X-Received: by 2002:a17:902:c943:b0:1a6:4fbd:d5c0 with SMTP id i3-20020a170902c94300b001a64fbdd5c0mr10335262pla.53.1681674457134;
        Sun, 16 Apr 2023 12:47:37 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.201])
        by smtp.gmail.com with ESMTPSA id jd9-20020a170903260900b001a69b28f5c5sm4490375plb.222.2023.04.16.12.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 12:47:36 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] clk: Add simple clock controller
Date:   Mon, 17 Apr 2023 03:46:20 +0800
Message-Id: <20230416194624.1258860-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230416194624.1258860-1-mmyangfl@gmail.com>
References: <20230416194624.1258860-1-mmyangfl@gmail.com>
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

Basic common clocks were provided in `include/linux/clk-provider.h`, but
lacks DT bindings for direct declaration. To use them, a lock is required
to avoid operation conflict on a same register.

Add a clock controller to manage this lock.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/clk/Makefile |   1 +
 drivers/clk/clk-of.c | 292 +++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/clk-of.h |  26 ++++
 3 files changed, 319 insertions(+)
 create mode 100644 drivers/clk/clk-of.c
 create mode 100644 drivers/clk/clk-of.h

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index e3ca0d058a25..6cf0a888b673 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_COMMON_CLK)	+= clk-fractional-divider.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-gpio.o
 ifeq ($(CONFIG_OF), y)
 obj-$(CONFIG_COMMON_CLK)	+= clk-conf.o
+obj-$(CONFIG_COMMON_CLK)	+= clk-of.o
 endif
 
 # hardware specific clock types
diff --git a/drivers/clk/clk-of.c b/drivers/clk/clk-of.c
new file mode 100644
index 000000000000..3518ae848ed0
--- /dev/null
+++ b/drivers/clk/clk-of.c
@@ -0,0 +1,292 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) 2023 David Yang
+ *
+ * Simple straight-forward register clocks bindings
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <linux/slab.h>
+
+#include "clk-of.h"
+
+struct of_clk_ctrl_priv {
+	spinlock_t lock;
+
+	struct reset_controller_dev rcdev;
+	void __iomem *base;
+	bool rst_set_to_disable;
+};
+
+static const struct of_clk_flag of_clk_common_flags[] = {
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
+void __iomem *of_clk_get_reg(struct device_node *np)
+{
+	u32 offset;
+	void __iomem *reg;
+
+	if (of_property_read_u32(np, "offset", &offset))
+		return NULL;
+
+	reg = of_iomap(np->parent, 0);
+	if (!reg)
+		return NULL;
+
+	return reg + offset;
+}
+EXPORT_SYMBOL_GPL(of_clk_get_reg);
+
+const char *of_clk_get_name(struct device_node *np)
+{
+	const char *name;
+
+	if (!of_property_read_string(np, "clock-output-name", &name))
+		return name;
+
+	return of_node_full_name(np);
+}
+EXPORT_SYMBOL_GPL(of_clk_get_name);
+
+unsigned long
+of_clk_get_flags(struct device_node *np, const struct of_clk_flag *defs)
+{
+	unsigned long flags = 0;
+
+	if (!defs)
+		defs = of_clk_common_flags;
+
+	for (int i = 0; defs[i].prop; i++)
+		if (of_property_read_bool(np, defs[i].prop))
+			flags |= defs[i].flag;
+
+	return flags;
+}
+EXPORT_SYMBOL_GPL(of_clk_get_flags);
+
+int of_clk_remove(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+
+	of_clk_del_provider(np);
+	clk_hw_unregister(np->data);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_clk_remove);
+
+int of_clk_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = pdev->dev.of_node;
+	int (*setup)(struct device_node *np) = of_device_get_match_data(dev);
+
+	return setup(np);
+}
+EXPORT_SYMBOL_GPL(of_clk_probe);
+
+/** of_rst_ctrl **/
+
+#if IS_ENABLED(CONFIG_RESET_CONTROLLER)
+static int
+of_rst_ctrl_assert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	struct of_clk_ctrl_priv *priv = container_of(rcdev, struct of_clk_ctrl_priv, rcdev);
+	unsigned long flags;
+	u32 offset = id >> 16;
+	u8 index = id & 0x1f;
+	u32 val;
+
+	if (WARN_ON(!priv->base))
+		return 0;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	val = readl(priv->base + offset);
+	if (priv->rst_set_to_disable)
+		val &= ~BIT(index);
+	else
+		val |= BIT(index);
+	writel(val, priv->base + offset);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static int
+of_rst_ctrl_deassert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	struct of_clk_ctrl_priv *priv = container_of(rcdev, struct of_clk_ctrl_priv, rcdev);
+	unsigned long flags;
+	u32 offset = id >> 16;
+	u8 index = id & 0x1f;
+	u32 val;
+
+	if (WARN_ON(!priv->base))
+		return 0;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	val = readl(priv->base + offset);
+	if (priv->rst_set_to_disable)
+		val |= BIT(index);
+	else
+		val &= ~BIT(index);
+	writel(val, priv->base + offset);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static const struct reset_control_ops of_rst_ctrl_ops = {
+	.assert = of_rst_ctrl_assert,
+	.deassert = of_rst_ctrl_deassert,
+};
+
+static int of_rst_ctrl_of_xlate(struct reset_controller_dev *rcdev,
+				 const struct of_phandle_args *reset_spec)
+{
+	return (reset_spec->args[0] << 16) | (reset_spec->args[1] & 0x1f);
+}
+
+static void of_rst_ctrl_unsetup(struct device_node *np)
+{
+	struct of_clk_ctrl_priv *priv = np->data;
+
+	reset_controller_unregister(&priv->rcdev);
+}
+
+static int of_rst_ctrl_setup(struct device_node *np, struct of_clk_ctrl_priv *priv)
+{
+	priv->base = of_iomap(np, 0);
+	priv->rst_set_to_disable = of_property_read_bool(np, "set-to-disable");
+
+	/* register no matter whether reg exists, to detect dts bug */
+	priv->rcdev.ops = &of_rst_ctrl_ops;
+	priv->rcdev.of_node = np;
+	priv->rcdev.of_reset_n_cells = 2;
+	priv->rcdev.of_xlate = of_rst_ctrl_of_xlate;
+	return reset_controller_register(&priv->rcdev);
+}
+#else
+static void of_rst_ctrl_unsetup(struct device_node *np)
+{
+}
+
+static int of_rst_ctrl_setup(struct device_node *np, struct of_clk_ctrl_priv *priv)
+{
+	return 0;
+}
+#endif
+
+/** of_crg_ctrl **/
+
+static void of_crg_ctrl_unsetup(struct device_node *np, bool crg)
+{
+	if (crg)
+		of_rst_ctrl_unsetup(np);
+
+	kfree(np->data);
+	np->data = NULL;
+}
+
+static int of_crg_ctrl_setup(struct device_node *np, bool crg)
+{
+	struct of_clk_ctrl_priv *priv;
+	int ret;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	np->data = priv;
+
+	spin_lock_init(&priv->lock);
+
+	if (crg) {
+		ret = of_rst_ctrl_setup(np, priv);
+		if (ret)
+			goto err;
+	}
+
+	return 0;
+
+err:
+	kfree(np->data);
+	np->data = NULL;
+	return ret;
+}
+
+/** driver **/
+
+static void __init of_clk_ctrl_init(struct device_node *np)
+{
+	of_crg_ctrl_setup(np, false);
+}
+CLK_OF_DECLARE(of_clk_ctrl, "simple-clock-controller", of_clk_ctrl_init);
+
+static void __init of_crg_ctrl_init(struct device_node *np)
+{
+	of_crg_ctrl_setup(np, true);
+}
+CLK_OF_DECLARE(of_crg_ctrl, "simple-clock-reset-controller", of_crg_ctrl_init);
+
+static int of_crg_ctrl_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = pdev->dev.of_node;
+	bool crg = (bool) of_device_get_match_data(dev);
+
+	of_crg_ctrl_unsetup(np, crg);
+
+	return 0;
+}
+
+/* This function is not executed when of_clk_ctrl_init succeeded. */
+static int of_crg_ctrl_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = pdev->dev.of_node;
+	bool crg = (bool) of_device_get_match_data(dev);
+
+	return of_crg_ctrl_setup(np, crg);
+}
+
+static const struct of_device_id of_crg_ctrl_ids[] = {
+	{ .compatible = "simple-clock-controller", .data = (void *) false },
+	{ .compatible = "simple-clock-reset-controller", .data = (void *) true },
+	{ }
+};
+
+static struct platform_driver of_crg_ctrl_driver = {
+	.driver = {
+		.name = "clk_of",
+		.of_match_table = of_crg_ctrl_ids,
+	},
+	.probe = of_crg_ctrl_probe,
+	.remove = of_crg_ctrl_remove,
+};
+builtin_platform_driver(of_crg_ctrl_driver);
diff --git a/drivers/clk/clk-of.h b/drivers/clk/clk-of.h
new file mode 100644
index 000000000000..ddb1e57ec2f1
--- /dev/null
+++ b/drivers/clk/clk-of.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later OR MIT */
+/*
+ * Copyright (c) 2023 David Yang
+ */
+
+#include <linux/spinlock_types.h>
+
+struct device_node;
+struct platform_device;
+
+struct of_clk_ctrl {
+	spinlock_t lock;
+};
+
+struct of_clk_flag {
+	const char *prop;
+	unsigned long flag;
+};
+
+void __iomem *of_clk_get_reg(struct device_node *np);
+const char *of_clk_get_name(struct device_node *np);
+unsigned long
+of_clk_get_flags(struct device_node *np, const struct of_clk_flag *defs);
+
+int of_clk_remove(struct platform_device *pdev);
+int of_clk_probe(struct platform_device *pdev);
-- 
2.39.2

