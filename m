Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1901367CC27
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236917AbjAZN2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236115AbjAZN2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:28:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DC865BD;
        Thu, 26 Jan 2023 05:28:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6EC7617D5;
        Thu, 26 Jan 2023 13:28:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64426C433EF;
        Thu, 26 Jan 2023 13:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674739702;
        bh=jxcMnfhyxChs+Qs+/oO6mhoGvEOqz9EkwgWaoWZcekc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QO2veeVyvDxgGnxxwYXJr3Q/tu2KFGf/XIsPHVlblFXE4ix9fdAKBiOly0Akp9H6p
         dbZGEPUknC6YcBk12pPknWw0vmv09Q9eaCRX7eUWiAU5COeL5MMNFYR74/3Cvg0E+O
         DQPGJcoeUW39blFCliWBc8DVK/S+jFMenvp4PDisWOzxw+KaEZ9GsxV/OTq845SxUD
         E/EnFmJl/IBqYi7VFgHq3WQ7qq4oTSFjbdlEk8gP3/JE5oiAbKSBHN9JwUJYfD/tDG
         /0+T+qAJXfDeW2QPFZuUddvM7WKAl5z80DZlqpdRDBlP1ABToomwIztzo4kscITGp2
         ngMcqZH456JLw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-gpio@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] gpiolib: split linux/gpio/driver.h out of linux/gpio.h
Date:   Thu, 26 Jan 2023 14:27:59 +0100
Message-Id: <20230126132801.2042371-7-arnd@kernel.org>
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

Almost all gpio drivers include linux/gpio/driver.h, and other
files should not rely on includes from this header.

Remove the indirect include from here and include the correct
headers directly from where they are used.

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
index c20163e6a8b4..c5aa4d8ed8bd 100644
--- a/arch/arm/mach-s3c/s3c64xx.c
+++ b/arch/arm/mach-s3c/s3c64xx.c
@@ -24,6 +24,7 @@
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
 #include <linux/io.h>
+#include <linux/of.h>
 #include <linux/clk/samsung.h>
 #include <linux/dma-mapping.h>
 #include <linux/irq.h>
diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index 04f8a1680bc1..06e7b1358226 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -12,6 +12,7 @@
 #include <linux/errno.h>
 #include <linux/gpio/gpio-reg.h>
 #include <linux/gpio/machine.h>
+#include <linux/gpio/driver.h>
 #include <linux/gpio_keys.h>
 #include <linux/ioport.h>
 #include <linux/platform_data/sa11x0-serial.h>
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
index 57ec3975b656..06a33339994e 100644
--- a/include/linux/gpio.h
+++ b/include/linux/gpio.h
@@ -54,8 +54,6 @@ struct gpio {
 };
 
 #ifdef CONFIG_GPIOLIB
-#include <linux/compiler.h>
-#include <linux/gpio/driver.h>
 #include <linux/gpio/consumer.h>
 
 /*
diff --git a/include/linux/mfd/ucb1x00.h b/include/linux/mfd/ucb1x00.h
index 9aed2797d3d5..2e65354fc7b8 100644
--- a/include/linux/mfd/ucb1x00.h
+++ b/include/linux/mfd/ucb1x00.h
@@ -9,6 +9,7 @@
 
 #include <linux/device.h>
 #include <linux/mfd/mcp.h>
+#include <linux/gpio/driver.h>
 #include <linux/gpio.h>
 #include <linux/mutex.h>
 
-- 
2.39.0

