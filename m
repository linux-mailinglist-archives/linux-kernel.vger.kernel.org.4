Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC3F6995B2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjBPNZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 08:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBPNZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:25:14 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E8D54561;
        Thu, 16 Feb 2023 05:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676553913; x=1708089913;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=2H++iGRfR09wbs4iqdkBPck8cSAllR7ohEnhgO/4WCI=;
  b=lpIrJscX4Fac4jxOk4Mb8rNmUvC0xRlwTP0t/s4jqwhz87KS6hfy1hTS
   qIDdjNv3oyEH+iBfN6Bj+yf+KQ1GSW5n2o4Ifm3NqbY8opGSMLIzmWIYH
   HEk2Z9HXch39oqcMaX9L5M6/+3+y6AUmynwnAxIbsL1L8+8Ft5P+45hfd
   HWP7oQ+UU+cZoy/S8rYHd2VFCNBQNS7OhIl8jYE61WwqKpMBP14Wh6ev9
   Af2gBFhny7YpwLo2KYVkdvkI665hGHGZImld3eQQgD1uZith97S4Vab1O
   DH3bVxMYTyGbOqPvtgdIZ0MUIgwQhsYHT+UnXuVPwKB0/eE049e9gjatm
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="331711609"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="331711609"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 05:25:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="999033087"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="999033087"
Received: from inesxmail01.iind.intel.com ([10.223.154.20])
  by fmsmga005.fm.intel.com with ESMTP; 16 Feb 2023 05:25:08 -0800
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
        by inesxmail01.iind.intel.com (Postfix) with ESMTP id 095DE1A9F6;
        Thu, 16 Feb 2023 18:55:08 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
        id 061B9162; Thu, 16 Feb 2023 18:55:08 +0530 (IST)
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 3/3] gpio: elkhartlake: Introduce Elkhart Lake PSE GPIO
Date:   Thu, 16 Feb 2023 18:53:56 +0530
Message-Id: <20230216132356.29922-4-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230216132356.29922-1-raag.jadav@intel.com>
References: <20230216132356.29922-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pandith N <pandith.n@intel.com>

This driver adds support for Elkhart Lake PSE GPIO controller,
using Intel Tangier as a library driver.

Signed-off-by: Pandith N <pandith.n@intel.com>
Co-developed-by: Raag Jadav <raag.jadav@intel.com>
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 MAINTAINERS                     |  1 +
 drivers/gpio/Kconfig            | 12 +++++
 drivers/gpio/Makefile           |  1 +
 drivers/gpio/gpio-elkhartlake.c | 94 +++++++++++++++++++++++++++++++++
 drivers/gpio/gpio-tangier.h     |  5 ++
 5 files changed, 113 insertions(+)
 create mode 100644 drivers/gpio/gpio-elkhartlake.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e9d42b2747d..aec1a2040f32 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10389,6 +10389,7 @@ M:	Andy Shevchenko <andy@kernel.org>
 L:	linux-gpio@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-gpio-intel.git
+F:	drivers/gpio/gpio-elkhartlake.c
 F:	drivers/gpio/gpio-ich.c
 F:	drivers/gpio/gpio-merrifield.c
 F:	drivers/gpio/gpio-ml-ioh.c
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 7fc7a2768705..c60066d4cd72 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -242,6 +242,17 @@ config GPIO_DWAPB
 	  Say Y or M here to build support for the Synopsys DesignWare APB
 	  GPIO block.
 
+config GPIO_ELKHARTLAKE
+	tristate "Intel Elkhart Lake PSE GPIO support"
+	depends on (X86 && ACPI) || COMPILE_TEST
+	select GPIO_TANGIER
+	help
+	  Select this option to enable GPIO support for Intel Elkhart Lake
+	  PSE GPIO IP.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called gpio-elkhartlake.
+
 config GPIO_EIC_SPRD
 	tristate "Spreadtrum EIC support"
 	depends on ARCH_SPRD || COMPILE_TEST
@@ -632,6 +643,7 @@ config GPIO_TANGIER
 	help
 	  GPIO support for Intel Tangier and compatible platforms.
 	  Currently supported:
+	   - Elkhart Lake
 	   - Merrifield
 
 	  If built as a module its name will be gpio-tangier.
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index a6cea9d2c973..8c34d5e39eb8 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -54,6 +54,7 @@ obj-$(CONFIG_GPIO_DAVINCI)		+= gpio-davinci.o
 obj-$(CONFIG_GPIO_DLN2)			+= gpio-dln2.o
 obj-$(CONFIG_GPIO_DWAPB)		+= gpio-dwapb.o
 obj-$(CONFIG_GPIO_EIC_SPRD)		+= gpio-eic-sprd.o
+obj-$(CONFIG_GPIO_ELKHARTLAKE)		+= gpio-elkhartlake.o
 obj-$(CONFIG_GPIO_EM)			+= gpio-em.o
 obj-$(CONFIG_GPIO_EN7523)		+= gpio-en7523.o
 obj-$(CONFIG_GPIO_EP93XX)		+= gpio-ep93xx.o
diff --git a/drivers/gpio/gpio-elkhartlake.c b/drivers/gpio/gpio-elkhartlake.c
new file mode 100644
index 000000000000..cf728ff35857
--- /dev/null
+++ b/drivers/gpio/gpio-elkhartlake.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Intel Elkhart Lake PSE GPIO driver
+ *
+ * Copyright (c) 2023 Intel Corporation.
+ *
+ * Authors: Pandith N <pandith.n@intel.com>
+ *          Raag Jadav <raag.jadav@intel.com>
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+
+#include "gpio-tangier.h"
+
+/* Each Intel EHL PSE GPIO Controller has 30 GPIO pins */
+#define EHL_PSE_NGPIO		30
+
+static int ehl_gpio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct tng_gpio *priv;
+	int irq, ret;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->ctx = devm_kzalloc(dev, sizeof(*priv->ctx), GFP_KERNEL);
+	if (!priv->ctx)
+		return -ENOMEM;
+
+	priv->reg_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->reg_base))
+		return PTR_ERR(priv->reg_base);
+
+	priv->dev = dev;
+	priv->chip.base = -1;
+	priv->chip.ngpio = EHL_PSE_NGPIO;
+	priv->chip.can_sleep = false;
+	priv->irq = irq;
+
+	priv->reg.gwmr = GWMR_EHL;
+	priv->reg.gwsr = GWSR_EHL;
+	priv->reg.gsir = GSIR_EHL;
+
+	ret = tng_gpio_probe(priv);
+	if (ret)
+		return dev_err_probe(dev, ret, "tng_gpio_probe error %d\n", ret);
+
+	platform_set_drvdata(pdev, priv);
+	return 0;
+}
+
+static int ehl_gpio_suspend(struct device *dev)
+{
+	return tng_gpio_suspend(dev);
+}
+
+static int ehl_gpio_resume(struct device *dev)
+{
+	return tng_gpio_resume(dev);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(ehl_gpio_pm_ops, ehl_gpio_suspend, ehl_gpio_resume);
+
+static const struct platform_device_id ehl_gpio_ids[] = {
+	{ "gpio-elkhartlake" },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, ehl_gpio_ids);
+
+static struct platform_driver ehl_gpio_driver = {
+	.driver	= {
+		.name	= "gpio-elkhartlake",
+		.pm	= pm_sleep_ptr(&ehl_gpio_pm_ops),
+	},
+	.probe		= ehl_gpio_probe,
+	.id_table	= ehl_gpio_ids,
+};
+module_platform_driver(ehl_gpio_driver);
+
+MODULE_AUTHOR("Pandith N <pandith.n@intel.com>");
+MODULE_AUTHOR("Raag Jadav <raag.jadav@intel.com>");
+MODULE_DESCRIPTION("Intel Elkhart Lake PSE GPIO driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(GPIO_TANGIER);
diff --git a/drivers/gpio/gpio-tangier.h b/drivers/gpio/gpio-tangier.h
index 414530c60c5a..6390a14ed9de 100644
--- a/drivers/gpio/gpio-tangier.h
+++ b/drivers/gpio/gpio-tangier.h
@@ -18,6 +18,11 @@
 
 struct device;
 
+/* Elkhart Lake specific wake registers */
+#define GWMR_EHL	0x100	/* Wake mask */
+#define GWSR_EHL	0x118	/* Wake source */
+#define GSIR_EHL	0x130	/* Secure input */
+
 /* Merrifield specific wake registers */
 #define GWMR_MRFLD	0x400	/* Wake mask */
 #define GWSR_MRFLD	0x418	/* Wake source */
-- 
2.17.1

