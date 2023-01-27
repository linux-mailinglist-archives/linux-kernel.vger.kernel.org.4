Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C73B67E134
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbjA0KMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbjA0KMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:12:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3674F361;
        Fri, 27 Jan 2023 02:12:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4CA561AC0;
        Fri, 27 Jan 2023 10:12:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DD9C4339C;
        Fri, 27 Jan 2023 10:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674814344;
        bh=8+jL/pc/kEgjyYK2IPop8mBZAygoG33RDbv3MKqpv0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n0cOIZwlonEzEPAo25k5B+KtWK15MvQWAv1uqVXO86s9V9sSX5ER4yESdrbcnBIYh
         lcBYDOXiRsK+lyz01yyj4RuT2MM0xpK8MZNpd+O8yNPE/0sqBMolc87XVDJX1kXUAu
         MefGnFYe9wWmPGW6u3ViaZhP2kuvAS4AnEyGZk7FB3whi6y1Z3cjvH4nksXctn+uuE
         ouGVCB0zfQ0j2FELkTtSXJ7+mFZnxH09gJ3Czs2Sl61xNl/dFq+qSb9AvRbd0uqzJ8
         3uzmqNG6KhZkPnW7NPQLxAlGJ0nIjZ/asA+qlivEGkCKfBDOORAiyIibUgZSbVmCSD
         59r+iE6Xu2ilQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-gpio@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] gpiolib: split of_mm_gpio_chip out of linux/of_gpio.h
Date:   Fri, 27 Jan 2023 11:11:49 +0100
Message-Id: <20230127101149.3475929-8-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230127101149.3475929-1-arnd@kernel.org>
References: <20230127101149.3475929-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This is a rarely used feature that has nothing to do with the
client-side of_gpio.h.

Split it out with a separate header file and Kconfig option
so it can be removed on its own timeline aside from removing
the of_gpio consumer interfaces.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/44x/Kconfig         |  1 +
 arch/powerpc/platforms/4xx/gpio.c          |  2 +-
 arch/powerpc/platforms/8xx/Kconfig         |  1 +
 arch/powerpc/platforms/8xx/cpm1.c          |  2 +-
 arch/powerpc/platforms/Kconfig             |  2 ++
 arch/powerpc/sysdev/cpm_common.c           |  2 +-
 drivers/gpio/Kconfig                       | 11 +++++++
 drivers/gpio/TODO                          | 15 ++++++---
 drivers/gpio/gpio-altera.c                 |  2 +-
 drivers/gpio/gpio-mm-lantiq.c              |  2 +-
 drivers/gpio/gpio-mpc5200.c                |  2 +-
 drivers/gpio/gpiolib-of.c                  |  3 ++
 drivers/soc/fsl/qe/gpio.c                  |  2 +-
 include/linux/gpio/legacy-of-mm-gpiochip.h | 36 ++++++++++++++++++++++
 include/linux/of_gpio.h                    | 21 -------------
 15 files changed, 71 insertions(+), 33 deletions(-)
 create mode 100644 include/linux/gpio/legacy-of-mm-gpiochip.h

diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index 25b80cd558f8..1624ebf95497 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -230,6 +230,7 @@ config PPC4xx_GPIO
 	bool "PPC4xx GPIO support"
 	depends on 44x
 	select GPIOLIB
+	select OF_GPIO_MM_GPIOCHIP
 	help
 	  Enable gpiolib support for ppc440 based boards
 
diff --git a/arch/powerpc/platforms/4xx/gpio.c b/arch/powerpc/platforms/4xx/gpio.c
index 49ee8d365852..e5f2319e5cbe 100644
--- a/arch/powerpc/platforms/4xx/gpio.c
+++ b/arch/powerpc/platforms/4xx/gpio.c
@@ -14,7 +14,7 @@
 #include <linux/spinlock.h>
 #include <linux/io.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
+#include <linux/gpio/legacy-of-mm-gpiochip.h>
 #include <linux/gpio/driver.h>
 #include <linux/types.h>
 #include <linux/slab.h>
diff --git a/arch/powerpc/platforms/8xx/Kconfig b/arch/powerpc/platforms/8xx/Kconfig
index 60cc5b537a98..a14d9d8997a4 100644
--- a/arch/powerpc/platforms/8xx/Kconfig
+++ b/arch/powerpc/platforms/8xx/Kconfig
@@ -101,6 +101,7 @@ comment "Generic MPC8xx Options"
 config 8xx_GPIO
 	bool "GPIO API Support"
 	select GPIOLIB
+	select OF_GPIO_MM_GPIOCHIP
 	help
 	  Saying Y here will cause the ports on an MPC8xx processor to be used
 	  with the GPIO API.  If you say N here, the kernel needs less memory.
diff --git a/arch/powerpc/platforms/8xx/cpm1.c b/arch/powerpc/platforms/8xx/cpm1.c
index bb38c8d8f8de..56ca14f77543 100644
--- a/arch/powerpc/platforms/8xx/cpm1.c
+++ b/arch/powerpc/platforms/8xx/cpm1.c
@@ -44,7 +44,7 @@
 #include <asm/fs_pd.h>
 
 #ifdef CONFIG_8xx_GPIO
-#include <linux/of_gpio.h>
+#include <linux/gpio/legacy-of-mm-gpiochip.h>
 #endif
 
 #define CPM_MAP_SIZE    (0x4000)
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index d41dad227de8..8e4bbd19dec5 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -244,6 +244,7 @@ config QE_GPIO
 	bool "QE GPIO support"
 	depends on QUICC_ENGINE
 	select GPIOLIB
+	select OF_GPIO_MM_GPIOCHIP
 	help
 	  Say Y here if you're going to use hardware that connects to the
 	  QE GPIOs.
@@ -254,6 +255,7 @@ config CPM2
 	select CPM
 	select HAVE_PCI
 	select GPIOLIB
+	select OF_GPIO_MM_GPIOCHIP
 	help
 	  The CPM2 (Communications Processor Module) is a coprocessor on
 	  embedded CPUs made by Freescale.  Selecting this option means that
diff --git a/arch/powerpc/sysdev/cpm_common.c b/arch/powerpc/sysdev/cpm_common.c
index 7dc1960f8bdb..8234013a8772 100644
--- a/arch/powerpc/sysdev/cpm_common.c
+++ b/arch/powerpc/sysdev/cpm_common.c
@@ -31,7 +31,7 @@
 #include <mm/mmu_decl.h>
 
 #if defined(CONFIG_CPM2) || defined(CONFIG_8xx_GPIO)
-#include <linux/of_gpio.h>
+#include <linux/gpio/legacy-of-mm-gpiochip.h>
 #endif
 
 static int __init cpm_init(void)
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 06a268d56800..178025ca3b34 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -39,6 +39,14 @@ config GPIOLIB_IRQCHIP
 	select IRQ_DOMAIN
 	bool
 
+config OF_GPIO_MM_GPIOCHIP
+	bool
+	help
+	  This adds support for the legacy 'struct of_mm_gpio_chip' interface
+	  from PowerPC. Existing drivers using this interface need to select
+	  this symbol, but new drivers should use the generic gpio-regmap
+	  infrastructure instead.
+
 config DEBUG_GPIO
 	bool "Debug GPIO calls"
 	depends on DEBUG_KERNEL
@@ -131,6 +139,7 @@ config GPIO_ALTERA
 	tristate "Altera GPIO"
 	depends on OF_GPIO
 	select GPIOLIB_IRQCHIP
+	select OF_GPIO_MM_GPIOCHIP
 	help
 	  Say Y or M here to build support for the Altera PIO device.
 
@@ -403,6 +412,7 @@ config GPIO_MENZ127
 config GPIO_MM_LANTIQ
 	bool "Lantiq Memory mapped GPIOs"
 	depends on LANTIQ && SOC_XWAY
+	select OF_GPIO_MM_GPIOCHIP
 	help
 	  This enables support for memory mapped GPIOs on the External Bus Unit
 	  (EBU) found on Lantiq SoCs. The GPIOs are output only as they are
@@ -411,6 +421,7 @@ config GPIO_MM_LANTIQ
 config GPIO_MPC5200
 	def_bool y
 	depends on PPC_MPC52xx
+	select OF_GPIO_MM_GPIOCHIP
 
 config GPIO_MPC8XXX
 	bool "MPC512x/MPC8xxx/QorIQ GPIO support"
diff --git a/drivers/gpio/TODO b/drivers/gpio/TODO
index 68ada1066941..189c3abe7e79 100644
--- a/drivers/gpio/TODO
+++ b/drivers/gpio/TODO
@@ -59,11 +59,6 @@ the device tree back-end. It is legacy and should not be used in new code.
 
 Work items:
 
-- Get rid of struct of_mm_gpio_chip altogether: use the generic  MMIO
-  GPIO for all current users (see below). Delete struct of_mm_gpio_chip,
-  to_of_mm_gpio_chip(), of_mm_gpiochip_add_data(), of_mm_gpiochip_remove()
-  from the kernel.
-
 - Change all consumer drivers that #include <linux/of_gpio.h> to
   #include <linux/gpio/consumer.h> and stop doing custom parsing of the
   GPIO lines from the device tree. This can be tricky and often ivolves
@@ -81,6 +76,16 @@ Work items:
   uses <linux/gpio/consumer.h> or <linux/gpio/driver.h> instead.
 
 
+Get rid of <linux/gpio/legacy-of-mm-gpiochip.h>
+
+Work items:
+
+- Get rid of struct of_mm_gpio_chip altogether: use the generic  MMIO
+  GPIO for all current users (see below). Delete struct of_mm_gpio_chip,
+  to_of_mm_gpio_chip(), of_mm_gpiochip_add_data(), of_mm_gpiochip_remove(),
+  CONFIG_OF_GPIO_MM_GPIOCHIP from the kernel.
+
+
 Get rid of <linux/gpio.h>
 
 This legacy header is a one stop shop for anything GPIO is closely tied
diff --git a/drivers/gpio/gpio-altera.c b/drivers/gpio/gpio-altera.c
index b59fae993626..99e137f8097e 100644
--- a/drivers/gpio/gpio-altera.c
+++ b/drivers/gpio/gpio-altera.c
@@ -7,7 +7,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/gpio/driver.h>
-#include <linux/of_gpio.h> /* For of_mm_gpio_chip */
+#include <linux/gpio/legacy-of-mm-gpiochip.h>
 #include <linux/platform_device.h>
 
 #define ALTERA_GPIO_MAX_NGPIO		32
diff --git a/drivers/gpio/gpio-mm-lantiq.c b/drivers/gpio/gpio-mm-lantiq.c
index 538e31fe8903..27ff84c5d162 100644
--- a/drivers/gpio/gpio-mm-lantiq.c
+++ b/drivers/gpio/gpio-mm-lantiq.c
@@ -10,8 +10,8 @@
 #include <linux/platform_device.h>
 #include <linux/mutex.h>
 #include <linux/gpio/driver.h>
+#include <linux/gpio/legacy-of-mm-gpiochip.h.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/io.h>
 #include <linux/slab.h>
 
diff --git a/drivers/gpio/gpio-mpc5200.c b/drivers/gpio/gpio-mpc5200.c
index 000494e0c533..3b0bfff8c778 100644
--- a/drivers/gpio/gpio-mpc5200.c
+++ b/drivers/gpio/gpio-mpc5200.c
@@ -8,7 +8,7 @@
 #include <linux/of.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
-#include <linux/of_gpio.h>
+#include <linux/gpio/legacy-of-mm-gpiochip.h>
 #include <linux/io.h>
 #include <linux/of_platform.h>
 #include <linux/module.h>
diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 266352b1a966..0f699af438b0 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -892,6 +892,8 @@ static int of_gpio_simple_xlate(struct gpio_chip *gc,
 	return gpiospec->args[0];
 }
 
+#if IS_ENABLED(CONFIG_OF_GPIO_MM_GPIOCHIP)
+#include <linux/gpio/legacy-of-mm-gpiochip.h>
 /**
  * of_mm_gpiochip_add_data - Add memory mapped GPIO chip (bank)
  * @np:		device node of the GPIO chip
@@ -964,6 +966,7 @@ void of_mm_gpiochip_remove(struct of_mm_gpio_chip *mm_gc)
 	kfree(gc->label);
 }
 EXPORT_SYMBOL_GPL(of_mm_gpiochip_remove);
+#endif
 
 #ifdef CONFIG_PINCTRL
 static int of_gpiochip_add_pin_range(struct gpio_chip *chip)
diff --git a/drivers/soc/fsl/qe/gpio.c b/drivers/soc/fsl/qe/gpio.c
index 1c41eb49d5a7..3ef24ba0245b 100644
--- a/drivers/soc/fsl/qe/gpio.c
+++ b/drivers/soc/fsl/qe/gpio.c
@@ -13,7 +13,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>	/* for of_mm_gpio_chip */
+#include <linux/gpio/legacy-of-mm-gpiochip.h>
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
 #include <linux/slab.h>
diff --git a/include/linux/gpio/legacy-of-mm-gpiochip.h b/include/linux/gpio/legacy-of-mm-gpiochip.h
new file mode 100644
index 000000000000..2e2bd3b19cc3
--- /dev/null
+++ b/include/linux/gpio/legacy-of-mm-gpiochip.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * OF helpers for the old of_mm_gpio_chip, used on ppc32 and nios2,
+ * do not use in new code.
+ *
+ * Copyright (c) 2007-2008  MontaVista Software, Inc.
+ *
+ * Author: Anton Vorontsov <avorontsov@ru.mvista.com>
+ */
+
+#ifndef __LINUX_GPIO_LEGACY_OF_MM_GPIO_CHIP_H
+#define __LINUX_GPIO_LEGACY_OF_MM_GPIO_CHIP_H
+
+#include <linux/gpio/driver.h>
+#include <linux/of.h>
+
+/*
+ * OF GPIO chip for memory mapped banks
+ */
+struct of_mm_gpio_chip {
+	struct gpio_chip gc;
+	void (*save_regs)(struct of_mm_gpio_chip *mm_gc);
+	void __iomem *regs;
+};
+
+static inline struct of_mm_gpio_chip *to_of_mm_gpio_chip(struct gpio_chip *gc)
+{
+	return container_of(gc, struct of_mm_gpio_chip, gc);
+}
+
+extern int of_mm_gpiochip_add_data(struct device_node *np,
+				   struct of_mm_gpio_chip *mm_gc,
+				   void *data);
+extern void of_mm_gpiochip_remove(struct of_mm_gpio_chip *mm_gc);
+
+#endif /* __LINUX_GPIO_LEGACY_OF_MM_GPIO_CHIP_H */
diff --git a/include/linux/of_gpio.h b/include/linux/of_gpio.h
index 5d58b3b0a97e..d0f66a5e1b2a 100644
--- a/include/linux/of_gpio.h
+++ b/include/linux/of_gpio.h
@@ -19,30 +19,9 @@ struct device_node;
 
 #ifdef CONFIG_OF_GPIO
 
-#include <linux/container_of.h>
-
-/*
- * OF GPIO chip for memory mapped banks
- */
-struct of_mm_gpio_chip {
-	struct gpio_chip gc;
-	void (*save_regs)(struct of_mm_gpio_chip *mm_gc);
-	void __iomem *regs;
-};
-
-static inline struct of_mm_gpio_chip *to_of_mm_gpio_chip(struct gpio_chip *gc)
-{
-	return container_of(gc, struct of_mm_gpio_chip, gc);
-}
-
 extern int of_get_named_gpio(const struct device_node *np,
 			     const char *list_name, int index);
 
-extern int of_mm_gpiochip_add_data(struct device_node *np,
-				   struct of_mm_gpio_chip *mm_gc,
-				   void *data);
-extern void of_mm_gpiochip_remove(struct of_mm_gpio_chip *mm_gc);
-
 #else /* CONFIG_OF_GPIO */
 
 #include <linux/errno.h>
-- 
2.39.0

