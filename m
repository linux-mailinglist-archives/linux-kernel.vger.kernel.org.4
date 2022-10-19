Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCE0604B30
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbiJSPXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbiJSPXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:23:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35805181D81;
        Wed, 19 Oct 2022 08:16:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9BCA61926;
        Wed, 19 Oct 2022 15:15:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5250DC433C1;
        Wed, 19 Oct 2022 15:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666192529;
        bh=jh5ENpwOfOajzp/RAT8KoyE5+r8fU/7pYZZ4l1bhcY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tkz9T1EIZMo+85cUiKEcBcvYEi3uEo7GZQ5QNZFTHr9qNQZ+5Lh5pHWJZ45FOsvoi
         Utv8Qq+9N1SNXxbbSXx6sGawowMVM51e1/I/b63VbUoVZr0aP8JAoTr9BnW7PDaDSk
         TAGoDYr8xjHBjAsVKMHlC/1gAZFfXHglinXbDmYyYXtDC6A2L5rXobSzT6Cc9CWQNa
         mdPehRo1kjV9FOPfQDSTdgcAmhUwkyk4eXKrcAITibgXMJvtRyJQk0yAmU63Xtz2WS
         KFO1Y4tjsHhofW4TVWxe9SroP0YlMzUy+ghQsrfmKEPN9wBtal1vChOeV2Bdtl1/hk
         YI7QV7tSZDH5g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-watchdog@vger.kernel.org
Subject: [PATCH 12/17] ARM: footbridge: remove CATS
Date:   Wed, 19 Oct 2022 17:03:34 +0200
Message-Id: <20221019150410.3851944-12-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221019150410.3851944-1-arnd@kernel.org>
References: <20221019144119.3848027-1-arnd@kernel.org>
 <20221019150410.3851944-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Nobody seems to have a CATS machine any more, so remove
it now, leaving only NetWinder and EBSA285.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/kernel/head.S              |  2 +-
 arch/arm/mach-footbridge/Kconfig    | 12 ----
 arch/arm/mach-footbridge/Makefile   |  2 -
 arch/arm/mach-footbridge/cats-hw.c  | 98 -----------------------------
 arch/arm/mach-footbridge/cats-pci.c | 64 -------------------
 arch/arm/mach-footbridge/common.c   |  3 -
 drivers/watchdog/wdt285.c           |  2 -
 7 files changed, 1 insertion(+), 182 deletions(-)
 delete mode 100644 arch/arm/mach-footbridge/cats-hw.c
 delete mode 100644 arch/arm/mach-footbridge/cats-pci.c

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 29e2900178a1..656991055bc1 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -344,7 +344,7 @@ __create_page_tables:
 	ldr	r7, [r10, #PROCINFO_IO_MMUFLAGS] @ io_mmuflags
 #endif
 
-#if defined(CONFIG_ARCH_NETWINDER) || defined(CONFIG_ARCH_CATS)
+#if defined(CONFIG_ARCH_NETWINDER)
 	/*
 	 * If we're using the NetWinder or CATS, we also need to map
 	 * in the 16550-type serial port for the debug messages
diff --git a/arch/arm/mach-footbridge/Kconfig b/arch/arm/mach-footbridge/Kconfig
index b5e7cbfed119..78189997caa1 100644
--- a/arch/arm/mach-footbridge/Kconfig
+++ b/arch/arm/mach-footbridge/Kconfig
@@ -16,18 +16,6 @@ menuconfig ARCH_FOOTBRIDGE
 
 if ARCH_FOOTBRIDGE
 
-config ARCH_CATS
-	bool "CATS"
-	depends on UNUSED_BOARD_FILES
-	select CLKEVT_I8253
-	select CLKSRC_I8253
-	select ISA
-	select FORCE_PCI
-	help
-	  Say Y here if you intend to run this kernel on the CATS.
-
-	  Saying N will reduce the size of the Footbridge kernel.
-
 config ARCH_EBSA285_HOST
 	bool "EBSA285 (host mode)"
 	select ARCH_EBSA285
diff --git a/arch/arm/mach-footbridge/Makefile b/arch/arm/mach-footbridge/Makefile
index 55d570739f19..1553cc01b45c 100644
--- a/arch/arm/mach-footbridge/Makefile
+++ b/arch/arm/mach-footbridge/Makefile
@@ -8,11 +8,9 @@
 obj-y			:= common.o isa-irq.o isa.o isa-rtc.o dma-isa.o
 
 pci-y			+= dc21285.o
-pci-$(CONFIG_ARCH_CATS) += cats-pci.o
 pci-$(CONFIG_ARCH_EBSA285) += ebsa285-pci.o
 pci-$(CONFIG_ARCH_NETWINDER) += netwinder-pci.o
 
-obj-$(CONFIG_ARCH_CATS) += cats-hw.o isa-timer.o
 obj-$(CONFIG_ARCH_EBSA285) += ebsa285.o dc21285-timer.o
 obj-$(CONFIG_ARCH_NETWINDER) += netwinder-hw.o isa-timer.o
 
diff --git a/arch/arm/mach-footbridge/cats-hw.c b/arch/arm/mach-footbridge/cats-hw.c
deleted file mode 100644
index e575dc0698cd..000000000000
--- a/arch/arm/mach-footbridge/cats-hw.c
+++ /dev/null
@@ -1,98 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * linux/arch/arm/mach-footbridge/cats-hw.c
- *
- * CATS machine fixup
- *
- * Copyright (C) 1998, 1999 Russell King, Phil Blundell
- */
-#include <linux/ioport.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/screen_info.h>
-#include <linux/io.h>
-#include <linux/spinlock.h>
-
-#include <asm/hardware/dec21285.h>
-#include <asm/mach-types.h>
-#include <asm/setup.h>
-
-#include <asm/mach/arch.h>
-
-#include "common.h"
-
-#define CFG_PORT	0x370
-#define INDEX_PORT	(CFG_PORT)
-#define DATA_PORT	(CFG_PORT + 1)
-
-static int __init cats_hw_init(void)
-{
-	if (machine_is_cats()) {
-		/* Set Aladdin to CONFIGURE mode */
-		outb(0x51, CFG_PORT);
-		outb(0x23, CFG_PORT);
-
-		/* Select logical device 3 */
-		outb(0x07, INDEX_PORT);
-		outb(0x03, DATA_PORT);
-
-		/* Set parallel port to DMA channel 3, ECP+EPP1.9, 
-		   enable EPP timeout */
-		outb(0x74, INDEX_PORT);
-		outb(0x03, DATA_PORT);
-	
-		outb(0xf0, INDEX_PORT);
-		outb(0x0f, DATA_PORT);
-
-		outb(0xf1, INDEX_PORT);
-		outb(0x07, DATA_PORT);
-
-		/* Select logical device 4 */
-		outb(0x07, INDEX_PORT);
-		outb(0x04, DATA_PORT);
-
-		/* UART1 high speed mode */
-		outb(0xf0, INDEX_PORT);
-		outb(0x02, DATA_PORT);
-
-		/* Select logical device 5 */
-		outb(0x07, INDEX_PORT);
-		outb(0x05, DATA_PORT);
-
-		/* UART2 high speed mode */
-		outb(0xf0, INDEX_PORT);
-		outb(0x02, DATA_PORT);
-
-		/* Set Aladdin to RUN mode */
-		outb(0xbb, CFG_PORT);
-	}
-
-	return 0;
-}
-
-__initcall(cats_hw_init);
-
-/*
- * CATS uses soft-reboot by default, since
- * hard reboots fail on early boards.
- */
-static void __init
-fixup_cats(struct tag *tags, char **cmdline)
-{
-#if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_DUMMY_CONSOLE)
-	screen_info.orig_video_lines  = 25;
-	screen_info.orig_video_points = 16;
-	screen_info.orig_y = 24;
-#endif
-}
-
-MACHINE_START(CATS, "Chalice-CATS")
-	/* Maintainer: Philip Blundell */
-	.atag_offset	= 0x100,
-	.reboot_mode	= REBOOT_SOFT,
-	.fixup		= fixup_cats,
-	.map_io		= footbridge_map_io,
-	.init_irq	= footbridge_init_irq,
-	.init_time	= isa_timer_init,
-	.restart	= footbridge_restart,
-MACHINE_END
diff --git a/arch/arm/mach-footbridge/cats-pci.c b/arch/arm/mach-footbridge/cats-pci.c
deleted file mode 100644
index 90b1e9be430e..000000000000
--- a/arch/arm/mach-footbridge/cats-pci.c
+++ /dev/null
@@ -1,64 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * linux/arch/arm/mach-footbridge/cats-pci.c
- *
- * PCI bios-type initialisation for PCI machines
- *
- * Bits taken from various places.
- */
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/init.h>
-
-#include <asm/irq.h>
-#include <asm/mach/pci.h>
-#include <asm/mach-types.h>
-
-/* cats host-specific stuff */
-static int irqmap_cats[] = { IRQ_PCI, IRQ_IN0, IRQ_IN1, IRQ_IN3 };
-
-static u8 cats_no_swizzle(struct pci_dev *dev, u8 *pin)
-{
-	return 0;
-}
-
-static int cats_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
-{
-	if (dev->irq >= 255)
-		return -1;	/* not a valid interrupt. */
-
-	if (dev->irq >= 128)
-		return dev->irq & 0x1f;
-
-	if (dev->irq >= 1 && dev->irq <= 4)
-		return irqmap_cats[dev->irq - 1];
-
-	if (dev->irq != 0)
-		printk("PCI: device %02x:%02x has unknown irq line %x\n",
-		       dev->bus->number, dev->devfn, dev->irq);
-
-	return -1;
-}
-
-/*
- * why not the standard PCI swizzle?  does this prevent 4-port tulip
- * cards being used (ie, pci-pci bridge based cards)?
- */
-static struct hw_pci cats_pci __initdata = {
-	.swizzle		= cats_no_swizzle,
-	.map_irq		= cats_map_irq,
-	.nr_controllers		= 1,
-	.ops			= &dc21285_ops,
-	.setup			= dc21285_setup,
-	.preinit		= dc21285_preinit,
-	.postinit		= dc21285_postinit,
-};
-
-static int __init cats_pci_init(void)
-{
-	if (machine_is_cats())
-		pci_common_init(&cats_pci);
-	return 0;
-}
-
-subsys_initcall(cats_pci_init);
diff --git a/arch/arm/mach-footbridge/common.c b/arch/arm/mach-footbridge/common.c
index 629e4676ed77..85c598708c10 100644
--- a/arch/arm/mach-footbridge/common.c
+++ b/arch/arm/mach-footbridge/common.c
@@ -206,9 +206,6 @@ void __init footbridge_init_irq(void)
 		 */
 		isa_init_irq(IRQ_PCI);
 
-	if (machine_is_cats())
-		isa_init_irq(IRQ_IN2);
-
 	if (machine_is_netwinder())
 		isa_init_irq(IRQ_IN3);
 }
diff --git a/drivers/watchdog/wdt285.c b/drivers/watchdog/wdt285.c
index 110249e5f642..5b7be7a62d54 100644
--- a/drivers/watchdog/wdt285.c
+++ b/drivers/watchdog/wdt285.c
@@ -206,8 +206,6 @@ static int __init footbridge_watchdog_init(void)
 	pr_info("Footbridge Watchdog Timer: 0.01, timer margin: %d sec\n",
 		soft_margin);
 
-	if (machine_is_cats())
-		pr_warn("Warning: Watchdog reset may not work on this machine\n");
 	return 0;
 }
 
-- 
2.29.2

