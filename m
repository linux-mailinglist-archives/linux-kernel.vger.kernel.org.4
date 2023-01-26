Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B351067CC1E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236540AbjAZN2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236115AbjAZN2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:28:36 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9066EB9;
        Thu, 26 Jan 2023 05:28:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 79ECFCE2416;
        Thu, 26 Jan 2023 13:28:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB13C4339B;
        Thu, 26 Jan 2023 13:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674739690;
        bh=scLxtXK0CI1WUEUBZxfzYBeAu1lVUR2nZItek9RfGPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eb5nAzH5T/TxENY0LOEZpwJKWaFDFs0PZZStspdRhY5tM7MU860AMxFSeMO7uAJUb
         plFmjeuagYwggzS9dvyqahIvfwFr2ig1Rp0firKWIOMzr8HmO98YhI3pVqYlT9DPEg
         smoLYJM7tdv9lSK1oYz9F26DL4DpOvRGQbtnDOxFwdjTcu4zE40BKqhWCE8ByS5iF5
         EXWzWGV1vPaXGB9RPXEoZ/gu4kkU+WwpF7HfTou6Ee8aDC++AVzfE7zj151Y9771Ud
         LTqFZRgtkmotXLhht80Mx3SwNOHOXbdoIerXVRI1EAMTbOf6+q/dFE3vukbI9hcVAL
         6nmeaYPCYiwwg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-gpio@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/8] gpiolib: remove empty asm/gpio.h files
Date:   Thu, 26 Jan 2023 14:27:54 +0100
Message-Id: <20230126132801.2042371-2-arnd@kernel.org>
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

The arm and sh versions of this file are identical to the generic
versions and can just be removed.

The drivers that actually use the sh3 specific version also include
cpu/gpio.h directly, with the exception of magicpanelr2, which is
easily fixed. This leaves coldfire as the only gpio driver
that needs something custom for gpiolib.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                    |  1 -
 arch/arm/include/asm/gpio.h         | 21 --------------
 arch/sh/Kconfig                     |  1 -
 arch/sh/boards/board-magicpanelr2.c |  1 +
 arch/sh/include/asm/gpio.h          | 45 -----------------------------
 5 files changed, 1 insertion(+), 68 deletions(-)
 delete mode 100644 arch/arm/include/asm/gpio.h
 delete mode 100644 arch/sh/include/asm/gpio.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5c8bab8d6009..b4447a055029 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -24,7 +24,6 @@ config ARM
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_TEARDOWN_DMA_OPS if MMU
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
-	select ARCH_HAVE_CUSTOM_GPIO_H
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG if CPU_LDREX
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_KEEP_MEMBLOCK
diff --git a/arch/arm/include/asm/gpio.h b/arch/arm/include/asm/gpio.h
deleted file mode 100644
index 4ebbb58f06ea..000000000000
--- a/arch/arm/include/asm/gpio.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ARCH_ARM_GPIO_H
-#define _ARCH_ARM_GPIO_H
-
-#include <asm-generic/gpio.h>
-
-/* The trivial gpiolib dispatchers */
-#define gpio_get_value  __gpio_get_value
-#define gpio_set_value  __gpio_set_value
-#define gpio_cansleep   __gpio_cansleep
-
-/*
- * Provide a default gpio_to_irq() which should satisfy every case.
- * However, some platforms want to do this differently, so allow them
- * to override it.
- */
-#ifndef gpio_to_irq
-#define gpio_to_irq	__gpio_to_irq
-#endif
-
-#endif /* _ARCH_ARM_GPIO_H */
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 0665ac0add0b..ccb866750a88 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -4,7 +4,6 @@ config SUPERH
 	select ARCH_32BIT_OFF_T
 	select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM && MMU
 	select ARCH_ENABLE_MEMORY_HOTREMOVE if SPARSEMEM && MMU
-	select ARCH_HAVE_CUSTOM_GPIO_H
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG if (GUSA_RB || CPU_SH4A)
 	select ARCH_HAS_BINFMT_FLAT if !MMU
 	select ARCH_HAS_CURRENT_STACK_POINTER
diff --git a/arch/sh/boards/board-magicpanelr2.c b/arch/sh/boards/board-magicpanelr2.c
index c3434f0ffc7d..626c716c086c 100644
--- a/arch/sh/boards/board-magicpanelr2.c
+++ b/arch/sh/boards/board-magicpanelr2.c
@@ -21,6 +21,7 @@
 #include <linux/sh_intc.h>
 #include <mach/magicpanelr2.h>
 #include <asm/heartbeat.h>
+#include <cpu/gpio.h>
 #include <cpu/sh7720.h>
 
 /* Dummy supplies, where voltage doesn't matter */
diff --git a/arch/sh/include/asm/gpio.h b/arch/sh/include/asm/gpio.h
deleted file mode 100644
index 588c1380e4cb..000000000000
--- a/arch/sh/include/asm/gpio.h
+++ /dev/null
@@ -1,45 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
- *  include/asm-sh/gpio.h
- *
- * Generic GPIO API and pinmux table support for SuperH.
- *
- * Copyright (c) 2008 Magnus Damm
- */
-#ifndef __ASM_SH_GPIO_H
-#define __ASM_SH_GPIO_H
-
-#include <linux/kernel.h>
-#include <linux/errno.h>
-
-#if defined(CONFIG_CPU_SH3)
-#include <cpu/gpio.h>
-#endif
-
-#include <asm-generic/gpio.h>
-
-#ifdef CONFIG_GPIOLIB
-
-static inline int gpio_get_value(unsigned gpio)
-{
-	return __gpio_get_value(gpio);
-}
-
-static inline void gpio_set_value(unsigned gpio, int value)
-{
-	__gpio_set_value(gpio, value);
-}
-
-static inline int gpio_cansleep(unsigned gpio)
-{
-	return __gpio_cansleep(gpio);
-}
-
-static inline int gpio_to_irq(unsigned gpio)
-{
-	return __gpio_to_irq(gpio);
-}
-
-#endif /* CONFIG_GPIOLIB */
-
-#endif /* __ASM_SH_GPIO_H */
-- 
2.39.0

