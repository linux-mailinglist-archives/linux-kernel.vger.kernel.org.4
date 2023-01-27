Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2805867E133
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbjA0KMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbjA0KMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:12:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DDA820D2;
        Fri, 27 Jan 2023 02:12:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36E0AB82008;
        Fri, 27 Jan 2023 10:12:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5F5C4339B;
        Fri, 27 Jan 2023 10:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674814341;
        bh=eaEqmjlD+Lv/FVOK9egayQf0KJ7RibJrGH3i8y4yudc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SNGCJlRq+ynRHKaOuBfF4/yY0L/R36vtOqjmstVT0l/K+lm5+iZY9cmfPQrMyJl9i
         2ZV+5qygFmwVphR8s3g/1Ko1Rr6ObqTignm4hKlXt3e5XKNvtpJzvTHyIaWPccZjHD
         h+SrOdmdgN7ujqOf3o0kRigcoOVM23zx65ZMBT+PgF6M7whCG9iuzsSCk2dTm4bgc7
         rZ9hrXR72Pe2MznQDlidRwvv30Jwr+bkOXNAsyZlWtvrJ/f3dpaywNPz89vlqtz9q3
         HTxuaPbB9gozwcOBDWQ0kklc0KXsMCkfN4I7+mab2oHpAP2l9SAS+rpYGKWCy+mGZn
         RqYJjvZmsAKpQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-gpio@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] gpiolib: split linux/gpio/driver.h out of linux/gpio.h
Date:   Fri, 27 Jan 2023 11:11:48 +0100
Message-Id: <20230127101149.3475929-7-arnd@kernel.org>
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

Almost all gpio drivers include linux/gpio/driver.h, and other
files should not rely on includes from this header.

Remove the indirect include from here and include the correct
headers directly from where they are used.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap1/irq.c                              | 1 +
 arch/arm/mach-orion5x/board-rd88f5182.c                | 1 +
 arch/arm/mach-s3c/s3c64xx.c                            | 1 +
 arch/arm/mach-sa1100/assabet.c                         | 1 +
 arch/arm/plat-orion/gpio.c                             | 1 +
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c | 1 +
 include/linux/gpio.h                                   | 2 --
 include/linux/mfd/ucb1x00.h                            | 1 +
 8 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/irq.c b/arch/arm/mach-omap1/irq.c
index 9ccc784fd614..bfc7ab010ae2 100644
--- a/arch/arm/mach-omap1/irq.c
+++ b/arch/arm/mach-omap1/irq.c
@@ -41,6 +41,7 @@
 #include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/irqdomain.h>
 
 #include <asm/irq.h>
 #include <asm/exception.h>
diff --git a/arch/arm/mach-orion5x/board-rd88f5182.c b/arch/arm/mach-orion5x/board-rd88f5182.c
index 596601367989..1c14e49a90a6 100644
--- a/arch/arm/mach-orion5x/board-rd88f5182.c
+++ b/arch/arm/mach-orion5x/board-rd88f5182.c
@@ -9,6 +9,7 @@
 #include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pci.h>
 #include <linux/irq.h>
diff --git a/arch/arm/mach-s3c/s3c64xx.c b/arch/arm/mach-s3c/s3c64xx.c
index c20163e6a8b4..bfd97f1b6288 100644
--- a/arch/arm/mach-s3c/s3c64xx.c
+++ b/arch/arm/mach-s3c/s3c64xx.c
@@ -21,6 +21,7 @@
 #include <linux/ioport.h>
 #include <linux/serial_core.h>
 #include <linux/serial_s3c.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
 #include <linux/io.h>
diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index 04f8a1680bc1..0c32b08a3a9c 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/errno.h>
+#include <linux/gpio/driver.h>
 #include <linux/gpio/gpio-reg.h>
 #include <linux/gpio/machine.h>
 #include <linux/gpio_keys.h>
diff --git a/arch/arm/plat-orion/gpio.c b/arch/arm/plat-orion/gpio.c
index 3ef9ecdd6343..4946d8066f6a 100644
--- a/arch/arm/plat-orion/gpio.c
+++ b/arch/arm/plat-orion/gpio.c
@@ -19,6 +19,7 @@
 #include <linux/bitops.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
+#include <linux/gpio/driver.h>
 #include <linux/leds.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
index 9540a05247c2..89c8829528c2 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <net/mac80211.h>
 #include <linux/bcma/bcma_driver_chipcommon.h>
+#include <linux/gpio.h>
 #include <linux/gpio/driver.h>
 #include <linux/gpio/machine.h>
 #include <linux/gpio/consumer.h>
diff --git a/include/linux/gpio.h b/include/linux/gpio.h
index a1271526e489..84bb49939d6e 100644
--- a/include/linux/gpio.h
+++ b/include/linux/gpio.h
@@ -54,9 +54,7 @@ struct gpio {
 };
 
 #ifdef CONFIG_GPIOLIB
-#include <linux/compiler.h>
 #include <linux/gpio/consumer.h>
-#include <linux/gpio/driver.h>
 
 /*
  * "valid" GPIO numbers are nonnegative and may be passed to
diff --git a/include/linux/mfd/ucb1x00.h b/include/linux/mfd/ucb1x00.h
index 9aed2797d3d5..3ebd7aa9227c 100644
--- a/include/linux/mfd/ucb1x00.h
+++ b/include/linux/mfd/ucb1x00.h
@@ -10,6 +10,7 @@
 #include <linux/device.h>
 #include <linux/mfd/mcp.h>
 #include <linux/gpio.h>
+#include <linux/gpio/driver.h>
 #include <linux/mutex.h>
 
 #define UCB_IO_DATA	0x00
-- 
2.39.0

