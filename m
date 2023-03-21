Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C5E6C3B54
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 21:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjCUUKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 16:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjCUUKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:10:46 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576404C6DD;
        Tue, 21 Mar 2023 13:10:32 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id o11-20020a05600c4fcb00b003eb33ea29a8so10212456wmq.1;
        Tue, 21 Mar 2023 13:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679429430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=viHWNP8s4BI0z0vZNADv22A48oTfIdBG6AOV5RLn/v4=;
        b=qFIYQOZgV/KvbBYNrFJElcZIHZZyL/rcBKPBR6Y0+TZOS0MSJntGjGZfrEfoAq/Q7l
         x7wNZyHwq/Jv8YoWNovlOnCxk7dp0rAY8MmEM8867OAobxPwvenYRQw2k7HwptRQP8x4
         3oa93FJNNf2Z62vFYND2iZbITkb53amPthA/HqYxdZ5ePxb3QxJ+mIZQCd4Q1t4nzgdY
         FFUR3HCHjxbQgZ8FqECn5npnSFcnVmUUBjS9qEeXdSaQohODXZ3FQJya5n3kpQSfqbTc
         JtIQj7lCFR1/BD63GR9aWpso7uE4puT8l419MqlbAtlQ0DaptGSX/q075Z0iuuIP5CMH
         m2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679429430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=viHWNP8s4BI0z0vZNADv22A48oTfIdBG6AOV5RLn/v4=;
        b=mvxGhkKWDoPd0LtsT3FhhlQZJLzz8ryX3J7GDa+dbiAbebdjkLUV0OYUZbCSS6a6nP
         2L6r/+hT5N8VMDuFyIhH5aTn8NcaIRsIMBZkFkuFrJjCeggq2IuOj4jd0U5tUvwkD/s1
         ANDyAwNERUYG8YrJVcvA4hFwwdAB0ZbWHQjKb/cIj7dlcQdG3e2N0zid2SdZX20FjafF
         +258L09EU5gCeF+mmNP5LMnmod8b5fIi/QoLgzcYWLsCs+XP0KP4lElQGSFqYF7n7xs/
         HfM1HVu31smpMyQz4NaCY01rJjRBQv89gQLIb8nhTW2tSb44rRV2k/uKAYO9rsjw+au0
         95mg==
X-Gm-Message-State: AO0yUKXEWQ1p3zWcxHmT+0GMDcIqx8vEwkOEDiQDp+iF0N/vc9s2wn8m
        BMnw/S+2QXQCRMHnVDbNqRM=
X-Google-Smtp-Source: AK7set89DXSzpxj4qBQOvh0zoaFhuNNu8x3PeMw9mxOEUURcPtEzZSTAF7wd5RH1LYXTIHZUgznIDw==
X-Received: by 2002:a7b:c5c1:0:b0:3ed:b349:e473 with SMTP id n1-20020a7bc5c1000000b003edb349e473mr3389880wmk.37.1679429430648;
        Tue, 21 Mar 2023 13:10:30 -0700 (PDT)
Received: from atlantis.lan (255.red-79-146-124.dynamicip.rima-tde.net. [79.146.124.255])
        by smtp.gmail.com with ESMTPSA id b13-20020adff90d000000b002c54c92e125sm12107693wrr.46.2023.03.21.13.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 13:10:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, p.zabel@pengutronix.de,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        william.zhang@broadcom.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v3 4/4] clk: bcm: Add BCM63268 timer clock and reset driver
Date:   Tue, 21 Mar 2023 21:10:22 +0100
Message-Id: <20230321201022.1052743-5-noltari@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230321201022.1052743-1-noltari@gmail.com>
References: <20210315122605.28437-1-noltari@gmail.com>
 <20230321201022.1052743-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for BCM63268 timer clock and reset controller.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 v3: add missing <linux/io.h> include to fix build warning
 v2: add changes suggested by Stephen Boyd

 drivers/clk/bcm/Kconfig              |   9 ++
 drivers/clk/bcm/Makefile             |   1 +
 drivers/clk/bcm/clk-bcm63268-timer.c | 232 +++++++++++++++++++++++++++
 3 files changed, 242 insertions(+)
 create mode 100644 drivers/clk/bcm/clk-bcm63268-timer.c

diff --git a/drivers/clk/bcm/Kconfig b/drivers/clk/bcm/Kconfig
index 77266afb1c79..a972d763eb77 100644
--- a/drivers/clk/bcm/Kconfig
+++ b/drivers/clk/bcm/Kconfig
@@ -37,6 +37,15 @@ config CLK_BCM_63XX_GATE
 	  Enable common clock framework support for Broadcom BCM63xx DSL SoCs
 	  based on the MIPS architecture
 
+config CLK_BCM63268_TIMER
+	bool "Broadcom BCM63268 timer clock and reset support"
+	depends on BMIPS_GENERIC || COMPILE_TEST
+	default BMIPS_GENERIC
+	select RESET_CONTROLLER
+	help
+	  Enable timer clock and reset support for Broadcom BCM63268 DSL SoCs
+	  based on the MIPS architecture.
+
 config CLK_BCM_KONA
 	bool "Broadcom Kona CCU clock support"
 	depends on ARCH_BCM_MOBILE || COMPILE_TEST
diff --git a/drivers/clk/bcm/Makefile b/drivers/clk/bcm/Makefile
index edb66b44cb27..d0b6f4b1fb08 100644
--- a/drivers/clk/bcm/Makefile
+++ b/drivers/clk/bcm/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CLK_BCM_63XX)	+= clk-bcm63xx.o
 obj-$(CONFIG_CLK_BCM_63XX_GATE)	+= clk-bcm63xx-gate.o
+obj-$(CONFIG_CLK_BCM63268_TIMER) += clk-bcm63268-timer.o
 obj-$(CONFIG_CLK_BCM_KONA)	+= clk-kona.o
 obj-$(CONFIG_CLK_BCM_KONA)	+= clk-kona-setup.o
 obj-$(CONFIG_CLK_BCM_KONA)	+= clk-bcm281xx.o
diff --git a/drivers/clk/bcm/clk-bcm63268-timer.c b/drivers/clk/bcm/clk-bcm63268-timer.c
new file mode 100644
index 000000000000..6a1fdd193cb5
--- /dev/null
+++ b/drivers/clk/bcm/clk-bcm63268-timer.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * BCM63268 Timer Clock and Reset Controller Driver
+ *
+ * Copyright (C) 2023 Álvaro Fernández Rojas <noltari@gmail.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+
+#include <dt-bindings/clock/bcm63268-clock.h>
+
+#define BCM63268_TIMER_RESET_SLEEP_MIN_US	10000
+#define BCM63268_TIMER_RESET_SLEEP_MAX_US	20000
+
+struct bcm63268_tclkrst_hw {
+	void __iomem *regs;
+	spinlock_t lock;
+
+	struct reset_controller_dev rcdev;
+	struct clk_hw_onecell_data data;
+};
+
+struct bcm63268_tclk_table_entry {
+	const char * const name;
+	u8 bit;
+};
+
+static const struct bcm63268_tclk_table_entry bcm63268_timer_clocks[] = {
+	{
+		.name = "ephy1",
+		.bit = BCM63268_TCLK_EPHY1,
+	}, {
+		.name = "ephy2",
+		.bit = BCM63268_TCLK_EPHY2,
+	}, {
+		.name = "ephy3",
+		.bit = BCM63268_TCLK_EPHY3,
+	}, {
+		.name = "gphy1",
+		.bit = BCM63268_TCLK_GPHY1,
+	}, {
+		.name = "dsl",
+		.bit = BCM63268_TCLK_DSL,
+	}, {
+		.name = "wakeon_ephy",
+		.bit = BCM63268_TCLK_WAKEON_EPHY,
+	}, {
+		.name = "wakeon_dsl",
+		.bit = BCM63268_TCLK_WAKEON_DSL,
+	}, {
+		.name = "fap1_pll",
+		.bit = BCM63268_TCLK_FAP1,
+	}, {
+		.name = "fap2_pll",
+		.bit = BCM63268_TCLK_FAP2,
+	}, {
+		.name = "uto_50",
+		.bit = BCM63268_TCLK_UTO_50,
+	}, {
+		.name = "uto_extin",
+		.bit = BCM63268_TCLK_UTO_EXTIN,
+	}, {
+		.name = "usb_ref",
+		.bit = BCM63268_TCLK_USB_REF,
+	}, {
+		/* sentinel */
+	}
+};
+
+static inline struct bcm63268_tclkrst_hw *
+to_bcm63268_timer_reset(struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct bcm63268_tclkrst_hw, rcdev);
+}
+
+static int bcm63268_timer_reset_update(struct reset_controller_dev *rcdev,
+				unsigned long id, bool assert)
+{
+	struct bcm63268_tclkrst_hw *reset = to_bcm63268_timer_reset(rcdev);
+	unsigned long flags;
+	uint32_t val;
+
+	spin_lock_irqsave(&reset->lock, flags);
+	val = __raw_readl(reset->regs);
+	if (assert)
+		val &= ~BIT(id);
+	else
+		val |= BIT(id);
+	__raw_writel(val, reset->regs);
+	spin_unlock_irqrestore(&reset->lock, flags);
+
+	return 0;
+}
+
+static int bcm63268_timer_reset_assert(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	return bcm63268_timer_reset_update(rcdev, id, true);
+}
+
+static int bcm63268_timer_reset_deassert(struct reset_controller_dev *rcdev,
+				  unsigned long id)
+{
+	return bcm63268_timer_reset_update(rcdev, id, false);
+}
+
+static int bcm63268_timer_reset_reset(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	bcm63268_timer_reset_update(rcdev, id, true);
+	usleep_range(BCM63268_TIMER_RESET_SLEEP_MIN_US,
+		     BCM63268_TIMER_RESET_SLEEP_MAX_US);
+
+	bcm63268_timer_reset_update(rcdev, id, false);
+	/*
+	 * Ensure component is taken out reset state by sleeping also after
+	 * deasserting the reset. Otherwise, the component may not be ready
+	 * for operation.
+	 */
+	usleep_range(BCM63268_TIMER_RESET_SLEEP_MIN_US,
+		     BCM63268_TIMER_RESET_SLEEP_MAX_US);
+
+	return 0;
+}
+
+static int bcm63268_timer_reset_status(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	struct bcm63268_tclkrst_hw *reset = to_bcm63268_timer_reset(rcdev);
+
+	return !(__raw_readl(reset->regs) & BIT(id));
+}
+
+static struct reset_control_ops bcm63268_timer_reset_ops = {
+	.assert = bcm63268_timer_reset_assert,
+	.deassert = bcm63268_timer_reset_deassert,
+	.reset = bcm63268_timer_reset_reset,
+	.status = bcm63268_timer_reset_status,
+};
+
+static int bcm63268_tclk_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct bcm63268_tclk_table_entry *entry, *table;
+	struct bcm63268_tclkrst_hw *hw;
+	struct clk_hw *clk;
+	u8 maxbit = 0;
+	int i, ret;
+
+	table = of_device_get_match_data(dev);
+	if (!table)
+		return -EINVAL;
+
+	for (entry = table; entry->name; entry++)
+		maxbit = max(maxbit, entry->bit);
+	maxbit++;
+
+	hw = devm_kzalloc(&pdev->dev, struct_size(hw, data.hws, maxbit),
+			  GFP_KERNEL);
+	if (!hw)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, hw);
+
+	spin_lock_init(&hw->lock);
+
+	hw->data.num = maxbit;
+	for (i = 0; i < maxbit; i++)
+		hw->data.hws[i] = ERR_PTR(-ENODEV);
+
+	hw->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(hw->regs))
+		return PTR_ERR(hw->regs);
+
+	for (entry = table; entry->name; entry++) {
+		clk = clk_hw_register_gate(dev, entry->name, NULL, 0,
+					   hw->regs, entry->bit,
+					   CLK_GATE_BIG_ENDIAN, &hw->lock);
+		if (IS_ERR(clk)) {
+			ret = PTR_ERR(clk);
+			goto out_err;
+		}
+
+		hw->data.hws[entry->bit] = clk;
+	}
+
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					  &hw->data);
+	if (ret)
+		return ret;
+
+	hw->rcdev.of_node = dev->of_node;
+	hw->rcdev.ops = &bcm63268_timer_reset_ops;
+
+	ret = devm_reset_controller_register(dev, &hw->rcdev);
+	if (ret)
+		dev_err(dev, "Failed to register reset controller\n");
+
+	return 0;
+
+out_err:
+	for (i = 0; i < hw->data.num; i++) {
+		if (!IS_ERR(hw->data.hws[i]))
+			clk_hw_unregister_gate(hw->data.hws[i]);
+	}
+
+	return ret;
+}
+
+static const struct of_device_id bcm63268_tclk_dt_ids[] = {
+	{
+		.compatible = "brcm,bcm63268-timer-clocks",
+		.data = &bcm63268_timer_clocks,
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver bcm63268_tclk = {
+	.probe = bcm63268_tclk_probe,
+	.driver = {
+		.name = "bcm63268-timer-clock",
+		.of_match_table = bcm63268_tclk_dt_ids,
+	},
+};
+builtin_platform_driver(bcm63268_tclk);
-- 
2.30.2

