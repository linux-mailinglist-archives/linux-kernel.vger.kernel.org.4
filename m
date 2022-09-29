Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D025EF9D0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236030AbiI2QJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236018AbiI2QJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:09:11 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11761D1E24;
        Thu, 29 Sep 2022 09:09:08 -0700 (PDT)
X-QQ-Spam: true
X-QQ-mid: bizesmtp84t1664461988tobq0a5b
Received: from localhost.localdomain ( [113.72.145.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 29 Sep 2022 22:33:07 +0800 (CST)
X-QQ-SSF: 01000000002000201000B00A0000000
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
Subject: [PATCH v1 10/30] reset: starfive: Rename 'reset-starfive-jh7100.c' to 'reset-starfive.c'
Date:   Thu, 29 Sep 2022 22:32:05 +0800
Message-Id: <20220929143225.17907-11-hal.feng@linux.starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:linux.starfivetech.com:qybglogicsvr:qybglogicsvr2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So this reset driver can be compatible with other StarFive SoCs.
No functional change.

Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
---
 MAINTAINERS                                   |  9 +--
 drivers/reset/Kconfig                         |  6 +-
 drivers/reset/Makefile                        |  2 +-
 ...set-starfive-jh7100.c => reset-starfive.c} | 68 +++++++++----------
 4 files changed, 43 insertions(+), 42 deletions(-)
 rename drivers/reset/{reset-starfive-jh7100.c => reset-starfive.c} (70%)

diff --git a/MAINTAINERS b/MAINTAINERS
index f5ca4aefd184..f2319a3b708b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19411,12 +19411,13 @@ F:	Documentation/devicetree/bindings/pinctrl/starfive,jh7100-pinctrl.yaml
 F:	drivers/pinctrl/pinctrl-starfive.c
 F:	include/dt-bindings/pinctrl/pinctrl-starfive.h
 
-STARFIVE JH7100 RESET CONTROLLER DRIVER
+STARFIVE RESET CONTROLLER DRIVER
 M:	Emil Renner Berthing <kernel@esmil.dk>
+M:	Hal Feng <hal.feng@linux.starfivetech.com>
 S:	Maintained
-F:	Documentation/devicetree/bindings/reset/starfive,jh7100-reset.yaml
-F:	drivers/reset/reset-starfive-jh7100.c
-F:	include/dt-bindings/reset/starfive-jh7100.h
+F:	Documentation/devicetree/bindings/reset/starfive*
+F:	drivers/reset/reset-starfive.c
+F:	include/dt-bindings/reset/starfive*
 
 STATIC BRANCH/CALL
 M:	Peter Zijlstra <peterz@infradead.org>
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 806773e88832..8121de5ecc3c 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -225,12 +225,12 @@ config RESET_SOCFPGA
 	  This enables the reset driver for the SoCFPGA ARMv7 platforms. This
 	  driver gets initialized early during platform init calls.
 
-config RESET_STARFIVE_JH7100
-	bool "StarFive JH7100 Reset Driver"
+config RESET_STARFIVE
+	bool "StarFive SoC Reset Driver"
 	depends on SOC_STARFIVE || COMPILE_TEST
 	default SOC_STARFIVE
 	help
-	  This enables the reset controller driver for the StarFive JH7100 SoC.
+	  This enables the reset controller driver for the StarFive SoCs.
 
 config RESET_SUNPLUS
 	bool "Sunplus SoCs Reset Driver" if COMPILE_TEST
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index cd5cf8e7c6a7..269268a48f56 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -29,7 +29,7 @@ obj-$(CONFIG_RESET_RZG2L_USBPHY_CTRL) += reset-rzg2l-usbphy-ctrl.o
 obj-$(CONFIG_RESET_SCMI) += reset-scmi.o
 obj-$(CONFIG_RESET_SIMPLE) += reset-simple.o
 obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
-obj-$(CONFIG_RESET_STARFIVE_JH7100) += reset-starfive-jh7100.o
+obj-$(CONFIG_RESET_STARFIVE) += reset-starfive.o
 obj-$(CONFIG_RESET_SUNPLUS) += reset-sunplus.o
 obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
 obj-$(CONFIG_RESET_TI_SCI) += reset-ti-sci.o
diff --git a/drivers/reset/reset-starfive-jh7100.c b/drivers/reset/reset-starfive.c
similarity index 70%
rename from drivers/reset/reset-starfive-jh7100.c
rename to drivers/reset/reset-starfive.c
index d3656e99ae0e..56d07bafadd7 100644
--- a/drivers/reset/reset-starfive-jh7100.c
+++ b/drivers/reset/reset-starfive.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Reset driver for the StarFive JH7100 SoC
+ * Reset driver for the StarFive SoC
  *
  * Copyright (C) 2021 Emil Renner Berthing <kernel@esmil.dk>
  * Copyright (C) 2021-2022 StarFive Technology Co., Ltd.
@@ -36,7 +36,7 @@ static const u32 jh7100_reset_asserted[4] = {
 	0,
 };
 
-struct jh7100_reset {
+struct starfive_reset {
 	struct reset_controller_dev rcdev;
 	struct regmap *regmap;
 	u32 assert_offset;
@@ -45,16 +45,16 @@ struct jh7100_reset {
 	const u32 *asserted;
 };
 
-static inline struct jh7100_reset *
-jh7100_reset_from(struct reset_controller_dev *rcdev)
+static inline struct starfive_reset *
+starfive_reset_from(struct reset_controller_dev *rcdev)
 {
-	return container_of(rcdev, struct jh7100_reset, rcdev);
+	return container_of(rcdev, struct starfive_reset, rcdev);
 }
 
-static int jh7100_reset_update(struct reset_controller_dev *rcdev,
-			       unsigned long id, bool assert)
+static int starfive_reset_update(struct reset_controller_dev *rcdev,
+				 unsigned long id, bool assert)
 {
-	struct jh7100_reset *data = jh7100_reset_from(rcdev);
+	struct starfive_reset *data = starfive_reset_from(rcdev);
 	u32 offset = id / 32;
 	u32 mask = BIT(id % 32);
 	u32 reg_assert = data->assert_offset + offset * sizeof(u32);
@@ -86,34 +86,34 @@ static int jh7100_reset_update(struct reset_controller_dev *rcdev,
 	return ret;
 }
 
-static int jh7100_reset_assert(struct reset_controller_dev *rcdev,
-			       unsigned long id)
+static int starfive_reset_assert(struct reset_controller_dev *rcdev,
+				 unsigned long id)
 {
-	return jh7100_reset_update(rcdev, id, true);
+	return starfive_reset_update(rcdev, id, true);
 }
 
-static int jh7100_reset_deassert(struct reset_controller_dev *rcdev,
-				 unsigned long id)
+static int starfive_reset_deassert(struct reset_controller_dev *rcdev,
+				   unsigned long id)
 {
-	return jh7100_reset_update(rcdev, id, false);
+	return starfive_reset_update(rcdev, id, false);
 }
 
-static int jh7100_reset_reset(struct reset_controller_dev *rcdev,
-			      unsigned long id)
+static int starfive_reset_reset(struct reset_controller_dev *rcdev,
+				unsigned long id)
 {
 	int ret;
 
-	ret = jh7100_reset_assert(rcdev, id);
+	ret = starfive_reset_assert(rcdev, id);
 	if (ret)
 		return ret;
 
-	return jh7100_reset_deassert(rcdev, id);
+	return starfive_reset_deassert(rcdev, id);
 }
 
-static int jh7100_reset_status(struct reset_controller_dev *rcdev,
-			       unsigned long id)
+static int starfive_reset_status(struct reset_controller_dev *rcdev,
+				 unsigned long id)
 {
-	struct jh7100_reset *data = jh7100_reset_from(rcdev);
+	struct starfive_reset *data = starfive_reset_from(rcdev);
 	u32 offset = id / 32;
 	u32 mask = BIT(id % 32);
 	u32 reg_status = data->status_offset + offset * sizeof(u32);
@@ -127,16 +127,16 @@ static int jh7100_reset_status(struct reset_controller_dev *rcdev,
 	return !((value ^ data->asserted[offset]) & mask);
 }
 
-static const struct reset_control_ops jh7100_reset_ops = {
-	.assert		= jh7100_reset_assert,
-	.deassert	= jh7100_reset_deassert,
-	.reset		= jh7100_reset_reset,
-	.status		= jh7100_reset_status,
+static const struct reset_control_ops starfive_reset_ops = {
+	.assert		= starfive_reset_assert,
+	.deassert	= starfive_reset_deassert,
+	.reset		= starfive_reset_reset,
+	.status		= starfive_reset_status,
 };
 
-static int __init jh7100_reset_probe(struct platform_device *pdev)
+static int __init starfive_reset_probe(struct platform_device *pdev)
 {
-	struct jh7100_reset *data;
+	struct starfive_reset *data;
 	int ret;
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
@@ -171,7 +171,7 @@ static int __init jh7100_reset_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	data->rcdev.ops = &jh7100_reset_ops;
+	data->rcdev.ops = &starfive_reset_ops;
 	data->rcdev.owner = THIS_MODULE;
 	data->rcdev.nr_resets = data->nr_resets;
 	data->rcdev.dev = &pdev->dev;
@@ -182,16 +182,16 @@ static int __init jh7100_reset_probe(struct platform_device *pdev)
 	return devm_reset_controller_register(&pdev->dev, &data->rcdev);
 }
 
-static const struct of_device_id jh7100_reset_dt_ids[] = {
+static const struct of_device_id starfive_reset_dt_ids[] = {
 	{ .compatible = "starfive,jh7100-reset" },
 	{ /* sentinel */ }
 };
 
-static struct platform_driver jh7100_reset_driver = {
+static struct platform_driver starfive_reset_driver = {
 	.driver = {
-		.name = "jh7100-reset",
-		.of_match_table = jh7100_reset_dt_ids,
+		.name = "starfive-reset",
+		.of_match_table = starfive_reset_dt_ids,
 		.suppress_bind_attrs = true,
 	},
 };
-builtin_platform_driver_probe(jh7100_reset_driver, jh7100_reset_probe);
+builtin_platform_driver_probe(starfive_reset_driver, starfive_reset_probe);
-- 
2.17.1

