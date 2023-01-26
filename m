Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F77167CC22
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236892AbjAZN2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236831AbjAZN2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:28:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D24E76A3;
        Thu, 26 Jan 2023 05:28:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A48D617D8;
        Thu, 26 Jan 2023 13:28:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90DEC433EF;
        Thu, 26 Jan 2023 13:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674739695;
        bh=ZiCadwRxGDjctdK2w5nb2qLUa4FE6fc5XUvA/+ZvbAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sLOZpNMhdzSOOXzyU1I6iNKrvqG0rXYNaxwI+5qXEzjpi7/l1zfulIJOqNvkAljuH
         HaybAj5oEelroDAebb8wnINJrtXlg5f6xfeDu5qN7I693yWdzo6bRGqJ6XSxY0KjDA
         k7MpCQtVdXoHP3DGb3Q2SaDp4/0UaSlbdgh8K8SV4g66SBMpatOQdzZMskQvEXcFgz
         hYL+68RVQwjPMlbxUOHw95WiCQmYtapjOdeePtHaCluDl33vRX0SXlSaq1JO2mW/qC
         vEO8O2hZM1eE3zrcjY/TBONI1E/L9pTVgCdHcpMQIv9+SGnmzUm7an9clP+gNnIHmk
         1+1CaFnduo/Fw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-gpio@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] gpiolib: remove asm-generic/gpio.h
Date:   Thu, 26 Jan 2023 14:27:56 +0100
Message-Id: <20230126132801.2042371-4-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230126132801.2042371-1-arnd@kernel.org>
References: <20230126132801.2042371-1-arnd@kernel.org>
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

The asm-generic/gpio.h file is now always included when
using gpiolib, so just move its contents into linux/gpio.h
with a few minor simplifications.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 MAINTAINERS                     |   1 -
 arch/m68k/include/asm/mcfgpio.h |   2 +-
 drivers/gpio/gpio-davinci.c     |   3 +-
 drivers/pinctrl/core.c          |   2 +-
 include/asm-generic/gpio.h      | 147 --------------------------------
 include/linux/gpio.h            |  93 ++++++++++++++++++--
 6 files changed, 87 insertions(+), 161 deletions(-)
 delete mode 100644 include/asm-generic/gpio.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d4677efcf02..acda33cbd689 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8729,7 +8729,6 @@ F:	Documentation/admin-guide/gpio/
 F:	Documentation/devicetree/bindings/gpio/
 F:	Documentation/driver-api/gpio/
 F:	drivers/gpio/
-F:	include/asm-generic/gpio.h
 F:	include/dt-bindings/gpio/
 F:	include/linux/gpio.h
 F:	include/linux/gpio/
diff --git a/arch/m68k/include/asm/mcfgpio.h b/arch/m68k/include/asm/mcfgpio.h
index 27f32cc81da6..2cefe8445980 100644
--- a/arch/m68k/include/asm/mcfgpio.h
+++ b/arch/m68k/include/asm/mcfgpio.h
@@ -9,7 +9,7 @@
 #define mcfgpio_h
 
 #ifdef CONFIG_GPIOLIB
-#include <asm-generic/gpio.h>
+#include <linux/gpio.h>
 #else
 
 int __mcfgpio_get_value(unsigned gpio);
diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index 26b1f7465e09..411b3102bc47 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/gpio/driver.h>
+#include <linux/gpio.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/clk.h>
@@ -24,8 +25,6 @@
 #include <linux/spinlock.h>
 #include <linux/pm_runtime.h>
 
-#include <asm-generic/gpio.h>
-
 #define MAX_REGS_BANKS 5
 #define MAX_INT_PER_BANK 32
 
diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index d6e6c751255f..6114affb642b 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -30,7 +30,7 @@
 
 #ifdef CONFIG_GPIOLIB
 #include "../gpio/gpiolib.h"
-#include <asm-generic/gpio.h>
+#include <linux/gpio.h>
 #endif
 
 #include "core.h"
diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
deleted file mode 100644
index 22cb8c9efc1d..000000000000
--- a/include/asm-generic/gpio.h
+++ /dev/null
@@ -1,147 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_GENERIC_GPIO_H
-#define _ASM_GENERIC_GPIO_H
-
-#include <linux/types.h>
-#include <linux/errno.h>
-
-#ifdef CONFIG_GPIOLIB
-
-#include <linux/compiler.h>
-#include <linux/gpio/driver.h>
-#include <linux/gpio/consumer.h>
-
-/*
- * Platforms may implement their GPIO interface with library code,
- * at a small performance cost for non-inlined operations and some
- * extra memory (for code and for per-GPIO table entries).
- */
-
-/*
- * At the end we want all GPIOs to be dynamically allocated from 0.
- * However, some legacy drivers still perform fixed allocation.
- * Until they are all fixed, leave 0-512 space for them.
- */
-#define GPIO_DYNAMIC_BASE	512
-
-struct device;
-struct gpio;
-struct seq_file;
-struct module;
-struct device_node;
-struct gpio_desc;
-
-/* Always use the library code for GPIO management calls,
- * or when sleeping may be involved.
- */
-extern int gpio_request(unsigned gpio, const char *label);
-extern void gpio_free(unsigned gpio);
-
-static inline int gpio_direction_input(unsigned gpio)
-{
-	return gpiod_direction_input(gpio_to_desc(gpio));
-}
-static inline int gpio_direction_output(unsigned gpio, int value)
-{
-	return gpiod_direction_output_raw(gpio_to_desc(gpio), value);
-}
-
-static inline int gpio_set_debounce(unsigned gpio, unsigned debounce)
-{
-	return gpiod_set_debounce(gpio_to_desc(gpio), debounce);
-}
-
-static inline int gpio_get_value_cansleep(unsigned gpio)
-{
-	return gpiod_get_raw_value_cansleep(gpio_to_desc(gpio));
-}
-static inline void gpio_set_value_cansleep(unsigned gpio, int value)
-{
-	return gpiod_set_raw_value_cansleep(gpio_to_desc(gpio), value);
-}
-
-
-/* A platform's <asm/gpio.h> code may want to inline the I/O calls when
- * the GPIO is constant and refers to some always-present controller,
- * giving direct access to chip registers and tight bitbanging loops.
- */
-static inline int __gpio_get_value(unsigned gpio)
-{
-	return gpiod_get_raw_value(gpio_to_desc(gpio));
-}
-static inline void __gpio_set_value(unsigned gpio, int value)
-{
-	return gpiod_set_raw_value(gpio_to_desc(gpio), value);
-}
-
-static inline int __gpio_cansleep(unsigned gpio)
-{
-	return gpiod_cansleep(gpio_to_desc(gpio));
-}
-
-static inline int __gpio_to_irq(unsigned gpio)
-{
-	return gpiod_to_irq(gpio_to_desc(gpio));
-}
-
-extern int gpio_request_one(unsigned gpio, unsigned long flags, const char *label);
-extern int gpio_request_array(const struct gpio *array, size_t num);
-extern void gpio_free_array(const struct gpio *array, size_t num);
-
-/*
- * A sysfs interface can be exported by individual drivers if they want,
- * but more typically is configured entirely from userspace.
- */
-static inline int gpio_export(unsigned gpio, bool direction_may_change)
-{
-	return gpiod_export(gpio_to_desc(gpio), direction_may_change);
-}
-
-static inline void gpio_unexport(unsigned gpio)
-{
-	gpiod_unexport(gpio_to_desc(gpio));
-}
-
-#else	/* !CONFIG_GPIOLIB */
-
-#include <linux/kernel.h>
-
-/* platforms that don't directly support access to GPIOs through I2C, SPI,
- * or other blocking infrastructure can use these wrappers.
- */
-
-static inline int gpio_cansleep(unsigned gpio)
-{
-	return 0;
-}
-
-static inline int gpio_get_value_cansleep(unsigned gpio)
-{
-	might_sleep();
-	return __gpio_get_value(gpio);
-}
-
-static inline void gpio_set_value_cansleep(unsigned gpio, int value)
-{
-	might_sleep();
-	__gpio_set_value(gpio, value);
-}
-
-#endif /* !CONFIG_GPIOLIB */
-
-/*
- * "valid" GPIO numbers are nonnegative and may be passed to
- * setup routines like gpio_request().  only some valid numbers
- * can successfully be requested and used.
- *
- * Invalid GPIO numbers are useful for indicating no-such-GPIO in
- * platform data and other tables.
- */
-
-static inline bool gpio_is_valid(int number)
-{
-	/* only non-negative numbers are valid */
-	return number >= 0;
-}
-
-#endif /* _ASM_GENERIC_GPIO_H */
diff --git a/include/linux/gpio.h b/include/linux/gpio.h
index 2b75017b3aad..e273a3287d8e 100644
--- a/include/linux/gpio.h
+++ b/include/linux/gpio.h
@@ -54,26 +54,101 @@ struct gpio {
 };
 
 #ifdef CONFIG_GPIOLIB
-#include <asm-generic/gpio.h>
+#include <linux/compiler.h>
+#include <linux/gpio/driver.h>
+#include <linux/gpio/consumer.h>
 
-static inline int gpio_get_value(unsigned int gpio)
+/*
+ * "valid" GPIO numbers are nonnegative and may be passed to
+ * setup routines like gpio_request().  only some valid numbers
+ * can successfully be requested and used.
+ *
+ * Invalid GPIO numbers are useful for indicating no-such-GPIO in
+ * platform data and other tables.
+ */
+static inline bool gpio_is_valid(int number)
+{
+	/* only non-negative numbers are valid */
+	return number >= 0;
+}
+
+/*
+ * Platforms may implement their GPIO interface with library code,
+ * at a small performance cost for non-inlined operations and some
+ * extra memory (for code and for per-GPIO table entries).
+ */
+
+/*
+ * At the end we want all GPIOs to be dynamically allocated from 0.
+ * However, some legacy drivers still perform fixed allocation.
+ * Until they are all fixed, leave 0-512 space for them.
+ */
+#define GPIO_DYNAMIC_BASE	512
+
+/* Always use the library code for GPIO management calls,
+ * or when sleeping may be involved.
+ */
+extern int gpio_request(unsigned gpio, const char *label);
+extern void gpio_free(unsigned gpio);
+
+static inline int gpio_direction_input(unsigned gpio)
+{
+	return gpiod_direction_input(gpio_to_desc(gpio));
+}
+static inline int gpio_direction_output(unsigned gpio, int value)
 {
-	return __gpio_get_value(gpio);
+	return gpiod_direction_output_raw(gpio_to_desc(gpio), value);
 }
 
-static inline void gpio_set_value(unsigned int gpio, int value)
+static inline int gpio_set_debounce(unsigned gpio, unsigned debounce)
 {
-	__gpio_set_value(gpio, value);
+	return gpiod_set_debounce(gpio_to_desc(gpio), debounce);
 }
 
-static inline int gpio_cansleep(unsigned int gpio)
+static inline int gpio_get_value_cansleep(unsigned gpio)
+{
+	return gpiod_get_raw_value_cansleep(gpio_to_desc(gpio));
+}
+static inline void gpio_set_value_cansleep(unsigned gpio, int value)
 {
-	return __gpio_cansleep(gpio);
+	return gpiod_set_raw_value_cansleep(gpio_to_desc(gpio), value);
 }
 
-static inline int gpio_to_irq(unsigned int gpio)
+static inline int gpio_get_value(unsigned gpio)
+{
+	return gpiod_get_raw_value(gpio_to_desc(gpio));
+}
+static inline void gpio_set_value(unsigned gpio, int value)
+{
+	return gpiod_set_raw_value(gpio_to_desc(gpio), value);
+}
+
+static inline int gpio_cansleep(unsigned gpio)
+{
+	return gpiod_cansleep(gpio_to_desc(gpio));
+}
+
+static inline int gpio_to_irq(unsigned gpio)
+{
+	return gpiod_to_irq(gpio_to_desc(gpio));
+}
+
+extern int gpio_request_one(unsigned gpio, unsigned long flags, const char *label);
+extern int gpio_request_array(const struct gpio *array, size_t num);
+extern void gpio_free_array(const struct gpio *array, size_t num);
+
+/*
+ * A sysfs interface can be exported by individual drivers if they want,
+ * but more typically is configured entirely from userspace.
+ */
+static inline int gpio_export(unsigned gpio, bool direction_may_change)
+{
+	return gpiod_export(gpio_to_desc(gpio), direction_may_change);
+}
+
+static inline void gpio_unexport(unsigned gpio)
 {
-	return __gpio_to_irq(gpio);
+	gpiod_unexport(gpio_to_desc(gpio));
 }
 
 /* CONFIG_GPIOLIB: bindings for managed devices that want to request gpios */
-- 
2.39.0

