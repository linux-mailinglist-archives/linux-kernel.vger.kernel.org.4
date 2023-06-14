Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88D7730761
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 20:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbjFNShC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 14:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjFNSg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:36:59 -0400
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BC0B3;
        Wed, 14 Jun 2023 11:36:58 -0700 (PDT)
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1q9U5B-008GBC-Va; Wed, 14 Jun 2023 18:14:58 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
        (envelope-from <ben@rainbowdash>)
        id 1q9U5C-000I11-16;
        Wed, 14 Jun 2023 18:14:58 +0100
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.dooks@codethink.co.uk, u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH v8 5/5] pwm: dwc: add of/platform support
Date:   Wed, 14 Jun 2023 18:14:57 +0100
Message-Id: <20230614171457.69191-6-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230614171457.69191-1-ben.dooks@sifive.com>
References: <20230614171457.69191-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dwc pwm controller can be used in non-PCI systems, so allow
either platform or OF based probing.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
v8:
 - add compile test for of-case
 - add module namespace
 - move later in the series
v7:
 - fixup kconfig from previous pcie changes
v5:
 - fix missing " in kconfig
 - remove .remove method, devm already sorts this.
 - merge pwm-number code
 - split the of code out of the core
 - get bus clock
v4:
 - moved the compile test code earlier
 - fixed review comments
 - used NS_PER_SEC
 - use devm_clk_get_enabled
 - ensure we get the bus clock
v3:
 - changed compatible name
---
 drivers/pwm/Kconfig        | 10 +++++
 drivers/pwm/Makefile       |  1 +
 drivers/pwm/pwm-dwc-core.c |  6 +++
 drivers/pwm/pwm-dwc-of.c   | 78 ++++++++++++++++++++++++++++++++++++++
 drivers/pwm/pwm-dwc.c      |  1 +
 drivers/pwm/pwm-dwc.h      |  1 +
 6 files changed, 97 insertions(+)
 create mode 100644 drivers/pwm/pwm-dwc-of.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 7c54cdcb97a0..61f5d3f30fd7 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -205,6 +205,16 @@ config PWM_DWC
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-dwc.
 
+config PWM_DWC_OF
+	tristate "DesignWare PWM Controller (OF bus)"
+	depends on HAS_IOMEM && (OF || COMPILE_TEST)
+	select PWM_DWC_CORE
+	help
+	  PWM driver for Synopsys DWC PWM Controller on an OF bus.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-dwc-of.
+
 config PWM_EP93XX
 	tristate "Cirrus Logic EP93xx PWM support"
 	depends on ARCH_EP93XX || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index de3ed77e8d7c..d27dfbb850b7 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_PWM_CRC)		+= pwm-crc.o
 obj-$(CONFIG_PWM_CROS_EC)	+= pwm-cros-ec.o
 obj-$(CONFIG_PWM_DWC_CORE)	+= pwm-dwc-core.o
 obj-$(CONFIG_PWM_DWC)		+= pwm-dwc.o
+obj-$(CONFIG_PWM_DWC_OF)	+= pwm-dwc-of.o
 obj-$(CONFIG_PWM_EP93XX)	+= pwm-ep93xx.o
 obj-$(CONFIG_PWM_FSL_FTM)	+= pwm-fsl-ftm.o
 obj-$(CONFIG_PWM_HIBVT)		+= pwm-hibvt.o
diff --git a/drivers/pwm/pwm-dwc-core.c b/drivers/pwm/pwm-dwc-core.c
index 0f07e26e6c30..ed102fc4b30a 100644
--- a/drivers/pwm/pwm-dwc-core.c
+++ b/drivers/pwm/pwm-dwc-core.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/clk.h>
 #include <linux/pm_runtime.h>
 #include <linux/pwm.h>
 
@@ -44,6 +45,9 @@ static int __dwc_pwm_configure_timer(struct dwc_pwm *dwc,
 	u32 high;
 	u32 low;
 
+	if (dwc->clk)
+		dwc->clk_rate = clk_get_rate(dwc->clk);
+
 	/*
 	 * Calculate width of low and high period in terms of input clock
 	 * periods and check are the result within HW limits between 1 and
@@ -128,6 +132,8 @@ static int dwc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	pm_runtime_get_sync(chip->dev);
 
+	if (dwc->clk)
+		dwc->clk_rate = clk_get_rate(dwc->clk);
 	clk_rate = dwc->clk_rate;
 
 	ctrl = dwc_pwm_readl(dwc, DWC_TIM_CTRL(pwm->hwpwm));
diff --git a/drivers/pwm/pwm-dwc-of.c b/drivers/pwm/pwm-dwc-of.c
new file mode 100644
index 000000000000..13a0b534b383
--- /dev/null
+++ b/drivers/pwm/pwm-dwc-of.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DesignWare PWM Controller driver OF
+ *
+ * Copyright (C) 2022 SiFive, Inc.
+ */
+
+#define DEFAULT_MODULE_NAMESACE dwc_pwm
+
+#include <linux/bitops.h>
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/pwm.h>
+#include <linux/io.h>
+
+#include "pwm-dwc.h"
+
+static int dwc_pwm_plat_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct dwc_pwm *dwc;
+	struct clk *bus;
+	u32 nr_pwm;
+
+	dwc = dwc_pwm_alloc(dev);
+	if (!dwc)
+		return -ENOMEM;
+
+	if (!device_property_read_u32(dev, "snps,pwm-number", &nr_pwm)) {
+		if (nr_pwm > DWC_TIMERS_TOTAL)
+			dev_err(dev, "too many PWMs (%d) specified, capping at %d\n",
+				nr_pwm, dwc->chip.npwm);
+		else
+			dwc->chip.npwm = nr_pwm;
+	}
+
+	dwc->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(dwc->base))
+		return PTR_ERR(dwc->base);
+
+	bus = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(bus))
+		return dev_err_probe(dev, PTR_ERR(bus),
+				     "failed to get clock\n");
+
+	dwc->clk = devm_clk_get_enabled(dev, "timer");
+	if (IS_ERR(dwc->clk))
+		return dev_err_probe(dev, PTR_ERR(dwc->clk),
+				     "failed to get timer clock\n");
+
+	dwc->clk_rate = clk_get_rate(dwc->clk);
+	return devm_pwmchip_add(dev, &dwc->chip);
+}
+
+static const struct of_device_id dwc_pwm_dt_ids[] = {
+	{ .compatible = "snps,dw-apb-timers-pwm2" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, dwc_pwm_dt_ids);
+
+static struct platform_driver dwc_pwm_plat_driver = {
+	.driver = {
+		.name		= "dwc-pwm",
+		.of_match_table  = dwc_pwm_dt_ids,
+	},
+	.probe	= dwc_pwm_plat_probe,
+};
+
+module_platform_driver(dwc_pwm_plat_driver);
+
+MODULE_ALIAS("platform:dwc-pwm-of");
+MODULE_AUTHOR("Ben Dooks <ben.dooks@sifive.com>");
+MODULE_DESCRIPTION("DesignWare PWM Controller");
+MODULE_LICENSE("GPL");
diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index bd9cadb497d7..7c32bd06ed33 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -20,6 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/clk.h>
 #include <linux/pm_runtime.h>
 #include <linux/pwm.h>
 
diff --git a/drivers/pwm/pwm-dwc.h b/drivers/pwm/pwm-dwc.h
index e0a940fd6e87..18e98c2c07d7 100644
--- a/drivers/pwm/pwm-dwc.h
+++ b/drivers/pwm/pwm-dwc.h
@@ -42,6 +42,7 @@ struct dwc_pwm_ctx {
 struct dwc_pwm {
 	struct pwm_chip chip;
 	void __iomem *base;
+	struct clk *clk;
 	unsigned long clk_rate;
 	struct dwc_pwm_ctx ctx[DWC_TIMERS_TOTAL];
 };
-- 
2.39.2

