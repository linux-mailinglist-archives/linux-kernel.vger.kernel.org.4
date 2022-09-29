Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051375EF982
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 17:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbiI2Pvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 11:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234352AbiI2Pvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:51:35 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548B94E846;
        Thu, 29 Sep 2022 08:51:32 -0700 (PDT)
X-QQ-Spam: true
X-QQ-mid: bizesmtp84t1664461974tg6jmmmc
Received: from localhost.localdomain ( [113.72.145.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 29 Sep 2022 22:32:53 +0800 (CST)
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
Subject: [PATCH v1 06/30] soc: sifive: l2 cache: Add StarFive JH71x0 support
Date:   Thu, 29 Sep 2022 22:32:01 +0800
Message-Id: <20220929143225.17907-7-hal.feng@linux.starfivetech.com>
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

From: Emil Renner Berthing <kernel@esmil.dk>

This adds support for the StarFive JH7100 and JH7110 SoCs which also
feature this SiFive cache controller.

Unfortunately the interrupt for uncorrected data is broken on the JH7100
and fires continuously, so add a quirk to not register a handler for it.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Hal Feng <hal.feng@linux.starfivetech.com>
---
 arch/riscv/Kconfig.socs              | 1 +
 drivers/soc/Makefile                 | 2 +-
 drivers/soc/sifive/Kconfig           | 2 +-
 drivers/soc/sifive/sifive_l2_cache.c | 7 +++++++
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 69774bb362d6..10f68a4359f9 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -22,6 +22,7 @@ config SOC_STARFIVE
 	bool "StarFive SoCs"
 	select PINCTRL
 	select RESET_CONTROLLER
+	select SIFIVE_L2
 	select SIFIVE_PLIC
 	help
 	  This enables support for StarFive SoC platform hardware.
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 69ba6508cf2c..534669840858 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -26,7 +26,7 @@ obj-y				+= qcom/
 obj-y				+= renesas/
 obj-y				+= rockchip/
 obj-$(CONFIG_SOC_SAMSUNG)	+= samsung/
-obj-$(CONFIG_SOC_SIFIVE)	+= sifive/
+obj-y				+= sifive/
 obj-y				+= sunxi/
 obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
 obj-y				+= ti/
diff --git a/drivers/soc/sifive/Kconfig b/drivers/soc/sifive/Kconfig
index 58cf8c40d08d..776b30723c04 100644
--- a/drivers/soc/sifive/Kconfig
+++ b/drivers/soc/sifive/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-if SOC_SIFIVE
+if SOC_SIFIVE || SOC_STARFIVE
 
 config SIFIVE_L2
 	bool "Sifive L2 Cache controller"
diff --git a/drivers/soc/sifive/sifive_l2_cache.c b/drivers/soc/sifive/sifive_l2_cache.c
index 010d612f7420..d6637254977f 100644
--- a/drivers/soc/sifive/sifive_l2_cache.c
+++ b/drivers/soc/sifive/sifive_l2_cache.c
@@ -10,6 +10,7 @@
 #include <linux/io.h>
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <asm/cacheinfo.h>
 #include <soc/sifive/sifive_l2_cache.h>
 
@@ -189,6 +190,7 @@ static irqreturn_t l2_int_handler(int irq, void *device)
 static int __init sifive_l2_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	unsigned long quirks = (uintptr_t)device_get_match_data(dev);
 	int nirqs;
 	int ret;
 	int i;
@@ -206,6 +208,9 @@ static int __init sifive_l2_probe(struct platform_device *pdev)
 		if (g_irq[i] < 0)
 			return g_irq[i];
 
+		if (quirks & BIT(i))
+			continue;
+
 		ret = devm_request_irq(dev, g_irq[i], l2_int_handler, 0, pdev->name, NULL);
 		if (ret)
 			return dev_err_probe(dev, ret, "Could not request IRQ %d\n", g_irq[i]);
@@ -225,6 +230,8 @@ static int __init sifive_l2_probe(struct platform_device *pdev)
 static const struct of_device_id sifive_l2_match[] = {
 	{ .compatible = "sifive,fu540-c000-ccache" },
 	{ .compatible = "sifive,fu740-c000-ccache" },
+	{ .compatible = "starfive,jh7100-ccache", .data = (void *)BIT(DATA_UNCORR) },
+	{ .compatible = "starfive,jh7110-ccache" },
 	{ /* sentinel */ }
 };
 
-- 
2.17.1

