Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF726607BA7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 17:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiJUP71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 11:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiJUP7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 11:59:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86FD209F85
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 08:59:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09CD6B82C8C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 15:59:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0EDC433D6;
        Fri, 21 Oct 2022 15:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666367953;
        bh=oBlzb1pxTw7HjqhUcT44Ri3LZmceOQEwe8GhLZ357P8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QB4Etj4Cs7UAMQ5ke7Z8QH1VPx4p9T4YMexlYu1uOVpF6E1d2OlYK1fkfgu59kPPf
         l4UoD7LW28bK7ljs9uUH6P1KnPDprgbEzNMfaDI/hovqdRkiit2cHOnQE81PZqeR9v
         NukXh+X34nilVYog8wjgf0rZhoDr8DDDfeBuI61SCKkFK9+P4rFOJoFh0x07v6ZlyU
         X34O1CXgiHK1yZ2kTa1lpTNAfheZnxSDgJTitzDS0ZofJmfoKjhoZmEy17TqYCkhK1
         ZG5tEVYkqDyNO1AeUrdua7z5OqqXdxe01Kof9A+C25/VgAdaZIGscEe2+138c8DKFp
         Zf4p2i8SelKOw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 10/11] ARM: mmp: remove device definitions
Date:   Fri, 21 Oct 2022 17:49:40 +0200
Message-Id: <20221021155000.4108406-11-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221021155000.4108406-1-arnd@kernel.org>
References: <20221021155000.4108406-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Since all board support is now gone, a lot of code in the
platform is no longer called and can be removed as well.
The remaining parts are:

 * The interrupt numbers for pxa910 are still needed for the
   power management support.

 * The 'mfp' device is still statically initialized from
   platform code, though this could be moved into the
   pinctrl code

 * The CPU identification code is used for the cpu_is_mmp*()
   macros.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-mmp/Makefile      |   2 +-
 arch/arm/mach-mmp/common.c      |   5 -
 arch/arm/mach-mmp/common.h      |   2 -
 arch/arm/mach-mmp/devices.c     | 359 --------------------------------
 arch/arm/mach-mmp/devices.h     |  57 -----
 arch/arm/mach-mmp/irqs.h        | 173 ---------------
 arch/arm/mach-mmp/mfp.h         |  35 ----
 arch/arm/mach-mmp/mmp2.c        |  71 +------
 arch/arm/mach-mmp/mmp2.h        |  83 --------
 arch/arm/mach-mmp/pm-mmp2.c     |  34 ---
 arch/arm/mach-mmp/pm-mmp2.h     |   2 +-
 arch/arm/mach-mmp/pm-pxa910.c   | 106 ----------
 arch/arm/mach-mmp/pxa168.c      | 126 +----------
 arch/arm/mach-mmp/pxa168.h      | 123 -----------
 arch/arm/mach-mmp/pxa910.c      |  99 +--------
 arch/arm/mach-mmp/pxa910.h      |  79 -------
 arch/arm/mach-mmp/regs-apbc.h   |  19 --
 arch/arm/mach-mmp/regs-apmu.h   |  28 ---
 arch/arm/mach-mmp/regs-timers.h |   5 -
 arch/arm/mach-mmp/regs-usb.h    | 155 --------------
 arch/arm/mach-mmp/time.c        |   9 +-
 21 files changed, 7 insertions(+), 1565 deletions(-)
 delete mode 100644 arch/arm/mach-mmp/devices.c
 delete mode 100644 arch/arm/mach-mmp/devices.h
 delete mode 100644 arch/arm/mach-mmp/mfp.h
 delete mode 100644 arch/arm/mach-mmp/regs-apbc.h
 delete mode 100644 arch/arm/mach-mmp/regs-apmu.h
 delete mode 100644 arch/arm/mach-mmp/regs-usb.h

diff --git a/arch/arm/mach-mmp/Makefile b/arch/arm/mach-mmp/Makefile
index cd874c5a6cb8..95d4217132eb 100644
--- a/arch/arm/mach-mmp/Makefile
+++ b/arch/arm/mach-mmp/Makefile
@@ -2,7 +2,7 @@
 #
 # Makefile for Marvell's PXA168 processors line
 #
-obj-y				+= common.o devices.o time.o
+obj-y				+= common.o time.o
 
 # SoC support
 obj-$(CONFIG_CPU_PXA168)	+= pxa168.o
diff --git a/arch/arm/mach-mmp/common.c b/arch/arm/mach-mmp/common.c
index e94349d4726c..b3c1a248db31 100644
--- a/arch/arm/mach-mmp/common.c
+++ b/arch/arm/mach-mmp/common.c
@@ -58,8 +58,3 @@ void __init mmp2_map_io(void)
 	mmp_map_io();
 	iotable_init(mmp2_io_desc, ARRAY_SIZE(mmp2_io_desc));
 }
-
-void mmp_restart(enum reboot_mode mode, const char *cmd)
-{
-	soft_restart(0);
-}
diff --git a/arch/arm/mach-mmp/common.h b/arch/arm/mach-mmp/common.h
index ed56b3f15b45..e18f05d5d68d 100644
--- a/arch/arm/mach-mmp/common.h
+++ b/arch/arm/mach-mmp/common.h
@@ -1,9 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/reboot.h>
-#define ARRAY_AND_SIZE(x)	(x), ARRAY_SIZE(x)
 
 extern void mmp_timer_init(int irq, unsigned long rate);
 
 extern void __init mmp_map_io(void);
 extern void __init mmp2_map_io(void);
-extern void mmp_restart(enum reboot_mode, const char *);
diff --git a/arch/arm/mach-mmp/devices.c b/arch/arm/mach-mmp/devices.c
deleted file mode 100644
index 9968239d8041..000000000000
--- a/arch/arm/mach-mmp/devices.c
+++ /dev/null
@@ -1,359 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * linux/arch/arm/mach-mmp/devices.c
- */
-
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/dma-mapping.h>
-#include <linux/delay.h>
-
-#include <asm/irq.h>
-#include "irqs.h"
-#include "devices.h"
-#include <linux/soc/mmp/cputype.h>
-#include "regs-usb.h"
-
-int __init mmp_register_device(struct mmp_device_desc *desc,
-				void *data, size_t size)
-{
-	struct platform_device *pdev;
-	struct resource res[2 + MAX_RESOURCE_DMA];
-	int i, ret = 0, nres = 0;
-
-	pdev = platform_device_alloc(desc->drv_name, desc->id);
-	if (pdev == NULL)
-		return -ENOMEM;
-
-	pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
-
-	memset(res, 0, sizeof(res));
-
-	if (desc->start != -1ul && desc->size > 0) {
-		res[nres].start	= desc->start;
-		res[nres].end	= desc->start + desc->size - 1;
-		res[nres].flags	= IORESOURCE_MEM;
-		nres++;
-	}
-
-	if (desc->irq != NO_IRQ) {
-		res[nres].start	= desc->irq;
-		res[nres].end	= desc->irq;
-		res[nres].flags	= IORESOURCE_IRQ;
-		nres++;
-	}
-
-	for (i = 0; i < MAX_RESOURCE_DMA; i++, nres++) {
-		if (desc->dma[i] == 0)
-			break;
-
-		res[nres].start	= desc->dma[i];
-		res[nres].end	= desc->dma[i];
-		res[nres].flags	= IORESOURCE_DMA;
-	}
-
-	ret = platform_device_add_resources(pdev, res, nres);
-	if (ret) {
-		platform_device_put(pdev);
-		return ret;
-	}
-
-	if (data && size) {
-		ret = platform_device_add_data(pdev, data, size);
-		if (ret) {
-			platform_device_put(pdev);
-			return ret;
-		}
-	}
-
-	return platform_device_add(pdev);
-}
-
-#if IS_ENABLED(CONFIG_USB) || IS_ENABLED(CONFIG_USB_GADGET)
-#if IS_ENABLED(CONFIG_USB_MV_UDC) || IS_ENABLED(CONFIG_USB_EHCI_MV)
-#if IS_ENABLED(CONFIG_CPU_PXA910) || IS_ENABLED(CONFIG_CPU_PXA168)
-
-/*****************************************************************************
- * The registers read/write routines
- *****************************************************************************/
-
-static unsigned int u2o_get(void __iomem *base, unsigned int offset)
-{
-	return readl_relaxed(base + offset);
-}
-
-static void u2o_set(void __iomem *base, unsigned int offset,
-		unsigned int value)
-{
-	u32 reg;
-
-	reg = readl_relaxed(base + offset);
-	reg |= value;
-	writel_relaxed(reg, base + offset);
-	readl_relaxed(base + offset);
-}
-
-static void u2o_clear(void __iomem *base, unsigned int offset,
-		unsigned int value)
-{
-	u32 reg;
-
-	reg = readl_relaxed(base + offset);
-	reg &= ~value;
-	writel_relaxed(reg, base + offset);
-	readl_relaxed(base + offset);
-}
-
-static void u2o_write(void __iomem *base, unsigned int offset,
-		unsigned int value)
-{
-	writel_relaxed(value, base + offset);
-	readl_relaxed(base + offset);
-}
-
-
-static DEFINE_MUTEX(phy_lock);
-static int phy_init_cnt;
-
-static int usb_phy_init_internal(void __iomem *base)
-{
-	int loops;
-
-	pr_info("Init usb phy!!!\n");
-
-	/* Initialize the USB PHY power */
-	if (cpu_is_pxa910()) {
-		u2o_set(base, UTMI_CTRL, (1<<UTMI_CTRL_INPKT_DELAY_SOF_SHIFT)
-			| (1<<UTMI_CTRL_PU_REF_SHIFT));
-	}
-
-	u2o_set(base, UTMI_CTRL, 1<<UTMI_CTRL_PLL_PWR_UP_SHIFT);
-	u2o_set(base, UTMI_CTRL, 1<<UTMI_CTRL_PWR_UP_SHIFT);
-
-	/* UTMI_PLL settings */
-	u2o_clear(base, UTMI_PLL, UTMI_PLL_PLLVDD18_MASK
-		| UTMI_PLL_PLLVDD12_MASK | UTMI_PLL_PLLCALI12_MASK
-		| UTMI_PLL_FBDIV_MASK | UTMI_PLL_REFDIV_MASK
-		| UTMI_PLL_ICP_MASK | UTMI_PLL_KVCO_MASK);
-
-	u2o_set(base, UTMI_PLL, 0xee<<UTMI_PLL_FBDIV_SHIFT
-		| 0xb<<UTMI_PLL_REFDIV_SHIFT | 3<<UTMI_PLL_PLLVDD18_SHIFT
-		| 3<<UTMI_PLL_PLLVDD12_SHIFT | 3<<UTMI_PLL_PLLCALI12_SHIFT
-		| 1<<UTMI_PLL_ICP_SHIFT | 3<<UTMI_PLL_KVCO_SHIFT);
-
-	/* UTMI_TX */
-	u2o_clear(base, UTMI_TX, UTMI_TX_REG_EXT_FS_RCAL_EN_MASK
-		| UTMI_TX_TXVDD12_MASK | UTMI_TX_CK60_PHSEL_MASK
-		| UTMI_TX_IMPCAL_VTH_MASK | UTMI_TX_REG_EXT_FS_RCAL_MASK
-		| UTMI_TX_AMP_MASK);
-	u2o_set(base, UTMI_TX, 3<<UTMI_TX_TXVDD12_SHIFT
-		| 4<<UTMI_TX_CK60_PHSEL_SHIFT | 4<<UTMI_TX_IMPCAL_VTH_SHIFT
-		| 8<<UTMI_TX_REG_EXT_FS_RCAL_SHIFT | 3<<UTMI_TX_AMP_SHIFT);
-
-	/* UTMI_RX */
-	u2o_clear(base, UTMI_RX, UTMI_RX_SQ_THRESH_MASK
-		| UTMI_REG_SQ_LENGTH_MASK);
-	u2o_set(base, UTMI_RX, 7<<UTMI_RX_SQ_THRESH_SHIFT
-		| 2<<UTMI_REG_SQ_LENGTH_SHIFT);
-
-	/* UTMI_IVREF */
-	if (cpu_is_pxa168())
-		/* fixing Microsoft Altair board interface with NEC hub issue -
-		 * Set UTMI_IVREF from 0x4a3 to 0x4bf */
-		u2o_write(base, UTMI_IVREF, 0x4bf);
-
-	/* toggle VCOCAL_START bit of UTMI_PLL */
-	udelay(200);
-	u2o_set(base, UTMI_PLL, VCOCAL_START);
-	udelay(40);
-	u2o_clear(base, UTMI_PLL, VCOCAL_START);
-
-	/* toggle REG_RCAL_START bit of UTMI_TX */
-	udelay(400);
-	u2o_set(base, UTMI_TX, REG_RCAL_START);
-	udelay(40);
-	u2o_clear(base, UTMI_TX, REG_RCAL_START);
-	udelay(400);
-
-	/* Make sure PHY PLL is ready */
-	loops = 0;
-	while ((u2o_get(base, UTMI_PLL) & PLL_READY) == 0) {
-		mdelay(1);
-		loops++;
-		if (loops > 100) {
-			printk(KERN_WARNING "calibrate timeout, UTMI_PLL %x\n",
-				u2o_get(base, UTMI_PLL));
-			break;
-		}
-	}
-
-	if (cpu_is_pxa168()) {
-		u2o_set(base, UTMI_RESERVE, 1 << 5);
-		/* Turn on UTMI PHY OTG extension */
-		u2o_write(base, UTMI_OTG_ADDON, 1);
-	}
-
-	return 0;
-}
-
-static int usb_phy_deinit_internal(void __iomem *base)
-{
-	pr_info("Deinit usb phy!!!\n");
-
-	if (cpu_is_pxa168())
-		u2o_clear(base, UTMI_OTG_ADDON, UTMI_OTG_ADDON_OTG_ON);
-
-	u2o_clear(base, UTMI_CTRL, UTMI_CTRL_RXBUF_PDWN);
-	u2o_clear(base, UTMI_CTRL, UTMI_CTRL_TXBUF_PDWN);
-	u2o_clear(base, UTMI_CTRL, UTMI_CTRL_USB_CLK_EN);
-	u2o_clear(base, UTMI_CTRL, 1<<UTMI_CTRL_PWR_UP_SHIFT);
-	u2o_clear(base, UTMI_CTRL, 1<<UTMI_CTRL_PLL_PWR_UP_SHIFT);
-
-	return 0;
-}
-
-int pxa_usb_phy_init(void __iomem *phy_reg)
-{
-	mutex_lock(&phy_lock);
-	if (phy_init_cnt++ == 0)
-		usb_phy_init_internal(phy_reg);
-	mutex_unlock(&phy_lock);
-	return 0;
-}
-
-void pxa_usb_phy_deinit(void __iomem *phy_reg)
-{
-	WARN_ON(phy_init_cnt == 0);
-
-	mutex_lock(&phy_lock);
-	if (--phy_init_cnt == 0)
-		usb_phy_deinit_internal(phy_reg);
-	mutex_unlock(&phy_lock);
-}
-#endif
-#endif
-#endif
-
-#if IS_ENABLED(CONFIG_USB_SUPPORT)
-static u64 __maybe_unused usb_dma_mask = ~(u32)0;
-
-#if IS_ENABLED(CONFIG_PHY_PXA_USB)
-static struct resource pxa168_usb_phy_resources[] = {
-	[0] = {
-		.start	= PXA168_U2O_PHYBASE,
-		.end	= PXA168_U2O_PHYBASE + USB_PHY_RANGE,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-struct platform_device pxa168_device_usb_phy = {
-	.name		= "pxa-usb-phy",
-	.id		= -1,
-	.resource	= pxa168_usb_phy_resources,
-	.num_resources	= ARRAY_SIZE(pxa168_usb_phy_resources),
-	.dev		=  {
-		.dma_mask	= &usb_dma_mask,
-		.coherent_dma_mask = 0xffffffff,
-	}
-};
-#endif /* CONFIG_PHY_PXA_USB */
-
-#if IS_ENABLED(CONFIG_USB_MV_UDC)
-static struct resource pxa168_u2o_resources[] = {
-	/* regbase */
-	[0] = {
-		.start	= PXA168_U2O_REGBASE + U2x_CAPREGS_OFFSET,
-		.end	= PXA168_U2O_REGBASE + USB_REG_RANGE,
-		.flags	= IORESOURCE_MEM,
-		.name	= "capregs",
-	},
-	/* phybase */
-	[1] = {
-		.start	= PXA168_U2O_PHYBASE,
-		.end	= PXA168_U2O_PHYBASE + USB_PHY_RANGE,
-		.flags	= IORESOURCE_MEM,
-		.name	= "phyregs",
-	},
-	[2] = {
-		.start	= IRQ_PXA168_USB1,
-		.end	= IRQ_PXA168_USB1,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device pxa168_device_u2o = {
-	.name		= "mv-udc",
-	.id		= -1,
-	.resource	= pxa168_u2o_resources,
-	.num_resources	= ARRAY_SIZE(pxa168_u2o_resources),
-	.dev		=  {
-		.dma_mask	= &usb_dma_mask,
-		.coherent_dma_mask = 0xffffffff,
-	}
-};
-#endif /* CONFIG_USB_MV_UDC */
-
-#if IS_ENABLED(CONFIG_USB_EHCI_MV_U2O)
-static struct resource pxa168_u2oehci_resources[] = {
-	[0] = {
-		.start	= PXA168_U2O_REGBASE,
-		.end	= PXA168_U2O_REGBASE + USB_REG_RANGE,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_PXA168_USB1,
-		.end	= IRQ_PXA168_USB1,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device pxa168_device_u2oehci = {
-	.name		= "pxa-u2oehci",
-	.id		= -1,
-	.dev		= {
-		.dma_mask		= &usb_dma_mask,
-		.coherent_dma_mask	= 0xffffffff,
-	},
-
-	.num_resources	= ARRAY_SIZE(pxa168_u2oehci_resources),
-	.resource	= pxa168_u2oehci_resources,
-};
-#endif
-
-#if IS_ENABLED(CONFIG_USB_MV_OTG)
-static struct resource pxa168_u2ootg_resources[] = {
-	/* regbase */
-	[0] = {
-		.start	= PXA168_U2O_REGBASE + U2x_CAPREGS_OFFSET,
-		.end	= PXA168_U2O_REGBASE + USB_REG_RANGE,
-		.flags	= IORESOURCE_MEM,
-		.name	= "capregs",
-	},
-	/* phybase */
-	[1] = {
-		.start	= PXA168_U2O_PHYBASE,
-		.end	= PXA168_U2O_PHYBASE + USB_PHY_RANGE,
-		.flags	= IORESOURCE_MEM,
-		.name	= "phyregs",
-	},
-	[2] = {
-		.start	= IRQ_PXA168_USB1,
-		.end	= IRQ_PXA168_USB1,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device pxa168_device_u2ootg = {
-	.name		= "mv-otg",
-	.id		= -1,
-	.dev  = {
-		.dma_mask          = &usb_dma_mask,
-		.coherent_dma_mask = 0xffffffff,
-	},
-
-	.num_resources	= ARRAY_SIZE(pxa168_u2ootg_resources),
-	.resource      = pxa168_u2ootg_resources,
-};
-#endif /* CONFIG_USB_MV_OTG */
-
-#endif
diff --git a/arch/arm/mach-mmp/devices.h b/arch/arm/mach-mmp/devices.h
deleted file mode 100644
index d4920ebfebc5..000000000000
--- a/arch/arm/mach-mmp/devices.h
+++ /dev/null
@@ -1,57 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __MACH_DEVICE_H
-#define __MACH_DEVICE_H
-
-#include <linux/types.h>
-
-#define MAX_RESOURCE_DMA	2
-
-/* structure for describing the on-chip devices */
-struct mmp_device_desc {
-	const char	*dev_name;
-	const char	*drv_name;
-	int		id;
-	int		irq;
-	unsigned long	start;
-	unsigned long	size;
-	int		dma[MAX_RESOURCE_DMA];
-};
-
-#define PXA168_DEVICE(_name, _drv, _id, _irq, _start, _size, _dma...)	\
-struct mmp_device_desc pxa168_device_##_name __initdata = {		\
-	.dev_name	= "pxa168-" #_name,				\
-	.drv_name	= _drv,						\
-	.id		= _id,						\
-	.irq		= IRQ_PXA168_##_irq,				\
-	.start		= _start,					\
-	.size		= _size,					\
-	.dma		= { _dma },					\
-};
-
-#define PXA910_DEVICE(_name, _drv, _id, _irq, _start, _size, _dma...)	\
-struct mmp_device_desc pxa910_device_##_name __initdata = {		\
-	.dev_name	= "pxa910-" #_name,				\
-	.drv_name	= _drv,						\
-	.id		= _id,						\
-	.irq		= IRQ_PXA910_##_irq,				\
-	.start		= _start,					\
-	.size		= _size,					\
-	.dma		= { _dma },					\
-};
-
-#define MMP2_DEVICE(_name, _drv, _id, _irq, _start, _size, _dma...)	\
-struct mmp_device_desc mmp2_device_##_name __initdata = {		\
-	.dev_name	= "mmp2-" #_name,				\
-	.drv_name	= _drv,						\
-	.id		= _id,						\
-	.irq		= IRQ_MMP2_##_irq,				\
-	.start		= _start,					\
-	.size		= _size,					\
-	.dma		= { _dma },					\
-}
-
-extern int mmp_register_device(struct mmp_device_desc *, void *, size_t);
-extern int pxa_usb_phy_init(void __iomem *phy_reg);
-extern void pxa_usb_phy_deinit(void __iomem *phy_reg);
-
-#endif /* __MACH_DEVICE_H */
diff --git a/arch/arm/mach-mmp/irqs.h b/arch/arm/mach-mmp/irqs.h
index 5acc4d532a43..b8446a17ea55 100644
--- a/arch/arm/mach-mmp/irqs.h
+++ b/arch/arm/mach-mmp/irqs.h
@@ -2,56 +2,6 @@
 #ifndef __ASM_MACH_IRQS_H
 #define __ASM_MACH_IRQS_H
 
-/*
- * Interrupt numbers for PXA168
- */
-#define IRQ_PXA168_NONE			(-1)
-#define IRQ_PXA168_SSP4			0
-#define IRQ_PXA168_SSP3			1
-#define IRQ_PXA168_SSP2			2
-#define IRQ_PXA168_SSP1			3
-#define IRQ_PXA168_PMIC_INT		4
-#define IRQ_PXA168_RTC_INT		5
-#define IRQ_PXA168_RTC_ALARM		6
-#define IRQ_PXA168_TWSI0		7
-#define IRQ_PXA168_GPU			8
-#define IRQ_PXA168_KEYPAD		9
-#define IRQ_PXA168_ONEWIRE		12
-#define IRQ_PXA168_TIMER1		13
-#define IRQ_PXA168_TIMER2		14
-#define IRQ_PXA168_TIMER3		15
-#define IRQ_PXA168_CMU			16
-#define IRQ_PXA168_SSP5			17
-#define IRQ_PXA168_MSP_WAKEUP		19
-#define IRQ_PXA168_CF_WAKEUP		20
-#define IRQ_PXA168_XD_WAKEUP		21
-#define IRQ_PXA168_MFU			22
-#define IRQ_PXA168_MSP			23
-#define IRQ_PXA168_CF			24
-#define IRQ_PXA168_XD			25
-#define IRQ_PXA168_DDR_INT		26
-#define IRQ_PXA168_UART1		27
-#define IRQ_PXA168_UART2		28
-#define IRQ_PXA168_UART3		29
-#define IRQ_PXA168_WDT			35
-#define IRQ_PXA168_MAIN_PMU		36
-#define IRQ_PXA168_FRQ_CHANGE		38
-#define IRQ_PXA168_SDH1			39
-#define IRQ_PXA168_SDH2			40
-#define IRQ_PXA168_LCD			41
-#define IRQ_PXA168_CI			42
-#define IRQ_PXA168_USB1			44
-#define IRQ_PXA168_NAND			45
-#define IRQ_PXA168_HIFI_DMA		46
-#define IRQ_PXA168_DMA_INT0		47
-#define IRQ_PXA168_DMA_INT1		48
-#define IRQ_PXA168_GPIOX		49
-#define IRQ_PXA168_USB2			51
-#define IRQ_PXA168_AC97			57
-#define IRQ_PXA168_TWSI1		58
-#define IRQ_PXA168_AP_PMU		60
-#define IRQ_PXA168_SM_INT		63
-
 /*
  * Interrupt numbers for PXA910
  */
@@ -114,127 +64,4 @@
 #define IRQ_PXA910_AP_PMU		60
 #define IRQ_PXA910_SM_INT		63	/* from PinMux */
 
-/*
- * Interrupt numbers for MMP2
- */
-#define IRQ_MMP2_NONE			(-1)
-#define IRQ_MMP2_SSP1			0
-#define IRQ_MMP2_SSP2			1
-#define IRQ_MMP2_SSPA1			2
-#define IRQ_MMP2_SSPA2			3
-#define IRQ_MMP2_PMIC_MUX		4	/* PMIC & Charger */
-#define IRQ_MMP2_RTC_MUX		5
-#define IRQ_MMP2_TWSI1			7
-#define IRQ_MMP2_GPU			8
-#define IRQ_MMP2_KEYPAD_MUX		9
-#define IRQ_MMP2_ROTARY			10
-#define IRQ_MMP2_TRACKBALL		11
-#define IRQ_MMP2_ONEWIRE		12
-#define IRQ_MMP2_TIMER1			13
-#define IRQ_MMP2_TIMER2			14
-#define IRQ_MMP2_TIMER3			15
-#define IRQ_MMP2_RIPC			16
-#define IRQ_MMP2_TWSI_MUX		17	/* TWSI2 ~ TWSI6 */
-#define IRQ_MMP2_HDMI			19
-#define IRQ_MMP2_SSP3			20
-#define IRQ_MMP2_SSP4			21
-#define IRQ_MMP2_USB_HS1		22
-#define IRQ_MMP2_USB_HS2		23
-#define IRQ_MMP2_UART3			24
-#define IRQ_MMP2_UART1			27
-#define IRQ_MMP2_UART2			28
-#define IRQ_MMP2_MIPI_DSI		29
-#define IRQ_MMP2_CI2			30
-#define IRQ_MMP2_PMU_TIMER1		31
-#define IRQ_MMP2_PMU_TIMER2		32
-#define IRQ_MMP2_PMU_TIMER3		33
-#define IRQ_MMP2_USB_FS			34
-#define IRQ_MMP2_MISC_MUX		35
-#define IRQ_MMP2_WDT1			36
-#define IRQ_MMP2_NAND_DMA		37
-#define IRQ_MMP2_USIM			38
-#define IRQ_MMP2_MMC			39
-#define IRQ_MMP2_WTM			40
-#define IRQ_MMP2_LCD			41
-#define IRQ_MMP2_CI			42
-#define IRQ_MMP2_IRE			43
-#define IRQ_MMP2_USB_OTG		44
-#define IRQ_MMP2_NAND			45
-#define IRQ_MMP2_UART4			46
-#define IRQ_MMP2_DMA_FIQ		47
-#define IRQ_MMP2_DMA_RIQ		48
-#define IRQ_MMP2_GPIO			49
-#define IRQ_MMP2_MIPI_HSI1_MUX		51
-#define IRQ_MMP2_MMC2			52
-#define IRQ_MMP2_MMC3			53
-#define IRQ_MMP2_MMC4			54
-#define IRQ_MMP2_MIPI_HSI0_MUX		55
-#define IRQ_MMP2_MSP			58
-#define IRQ_MMP2_MIPI_SLIM_DMA		59
-#define IRQ_MMP2_PJ4_FREQ_CHG		60
-#define IRQ_MMP2_MIPI_SLIM		62
-#define IRQ_MMP2_SM			63
-
-#define IRQ_MMP2_MUX_BASE		64
-
-/* secondary interrupt of INT #4 */
-#define IRQ_MMP2_PMIC_BASE		(IRQ_MMP2_MUX_BASE)
-#define IRQ_MMP2_CHARGER		(IRQ_MMP2_PMIC_BASE + 0)
-#define IRQ_MMP2_PMIC			(IRQ_MMP2_PMIC_BASE + 1)
-
-/* secondary interrupt of INT #5 */
-#define IRQ_MMP2_RTC_BASE		(IRQ_MMP2_PMIC_BASE + 2)
-#define IRQ_MMP2_RTC_ALARM		(IRQ_MMP2_RTC_BASE + 0)
-#define IRQ_MMP2_RTC			(IRQ_MMP2_RTC_BASE + 1)
-
-/* secondary interrupt of INT #9 */
-#define IRQ_MMP2_KEYPAD_BASE		(IRQ_MMP2_RTC_BASE + 2)
-#define IRQ_MMP2_KPC			(IRQ_MMP2_KEYPAD_BASE + 0)
-#define IRQ_MMP2_ROTORY			(IRQ_MMP2_KEYPAD_BASE + 1)
-#define IRQ_MMP2_TBALL			(IRQ_MMP2_KEYPAD_BASE + 2)
-
-/* secondary interrupt of INT #17 */
-#define IRQ_MMP2_TWSI_BASE		(IRQ_MMP2_KEYPAD_BASE + 3)
-#define IRQ_MMP2_TWSI2			(IRQ_MMP2_TWSI_BASE + 0)
-#define IRQ_MMP2_TWSI3			(IRQ_MMP2_TWSI_BASE + 1)
-#define IRQ_MMP2_TWSI4			(IRQ_MMP2_TWSI_BASE + 2)
-#define IRQ_MMP2_TWSI5			(IRQ_MMP2_TWSI_BASE + 3)
-#define IRQ_MMP2_TWSI6			(IRQ_MMP2_TWSI_BASE + 4)
-
-/* secondary interrupt of INT #35 */
-#define IRQ_MMP2_MISC_BASE		(IRQ_MMP2_TWSI_BASE + 5)
-#define IRQ_MMP2_PERF			(IRQ_MMP2_MISC_BASE + 0)
-#define IRQ_MMP2_L2_PA_ECC		(IRQ_MMP2_MISC_BASE + 1)
-#define IRQ_MMP2_L2_ECC			(IRQ_MMP2_MISC_BASE + 2)
-#define IRQ_MMP2_L2_UECC		(IRQ_MMP2_MISC_BASE + 3)
-#define IRQ_MMP2_DDR			(IRQ_MMP2_MISC_BASE + 4)
-#define IRQ_MMP2_FAB0_TIMEOUT		(IRQ_MMP2_MISC_BASE + 5)
-#define IRQ_MMP2_FAB1_TIMEOUT		(IRQ_MMP2_MISC_BASE + 6)
-#define IRQ_MMP2_FAB2_TIMEOUT		(IRQ_MMP2_MISC_BASE + 7)
-#define IRQ_MMP2_THERMAL		(IRQ_MMP2_MISC_BASE + 9)
-#define IRQ_MMP2_MAIN_PMU		(IRQ_MMP2_MISC_BASE + 10)
-#define IRQ_MMP2_WDT2			(IRQ_MMP2_MISC_BASE + 11)
-#define IRQ_MMP2_CORESIGHT		(IRQ_MMP2_MISC_BASE + 12)
-#define IRQ_MMP2_COMMTX			(IRQ_MMP2_MISC_BASE + 13)
-#define IRQ_MMP2_COMMRX			(IRQ_MMP2_MISC_BASE + 14)
-
-/* secondary interrupt of INT #51 */
-#define IRQ_MMP2_MIPI_HSI1_BASE		(IRQ_MMP2_MISC_BASE + 15)
-#define IRQ_MMP2_HSI1_CAWAKE		(IRQ_MMP2_MIPI_HSI1_BASE + 0)
-#define IRQ_MMP2_MIPI_HSI_INT1		(IRQ_MMP2_MIPI_HSI1_BASE + 1)
-
-/* secondary interrupt of INT #55 */
-#define IRQ_MMP2_MIPI_HSI0_BASE		(IRQ_MMP2_MIPI_HSI1_BASE + 2)
-#define IRQ_MMP2_HSI0_CAWAKE		(IRQ_MMP2_MIPI_HSI0_BASE + 0)
-#define IRQ_MMP2_MIPI_HSI_INT0		(IRQ_MMP2_MIPI_HSI0_BASE + 1)
-
-#define IRQ_MMP2_MUX_END		(IRQ_MMP2_MIPI_HSI0_BASE + 2)
-
-#define IRQ_GPIO_START			128
-#define MMP_NR_BUILTIN_GPIO		192
-#define MMP_GPIO_TO_IRQ(gpio)		(IRQ_GPIO_START + (gpio))
-
-#define IRQ_BOARD_START			(IRQ_GPIO_START + MMP_NR_BUILTIN_GPIO)
-#define MMP_NR_IRQS			IRQ_BOARD_START
-
 #endif /* __ASM_MACH_IRQS_H */
diff --git a/arch/arm/mach-mmp/mfp.h b/arch/arm/mach-mmp/mfp.h
deleted file mode 100644
index 6f3057987756..000000000000
--- a/arch/arm/mach-mmp/mfp.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_MACH_MFP_H
-#define __ASM_MACH_MFP_H
-
-#include <linux/soc/pxa/mfp.h>
-
-/*
- * NOTE: the MFPR register bit definitions on PXA168 processor lines are a
- * bit different from those on PXA3xx.  Bit [7:10] are now reserved, which
- * were SLEEP_OE_N, SLEEP_DATA, SLEEP_SEL and the LSB of DRIVE bits.
- *
- * To cope with this difference and re-use the pxa3xx mfp code as much as
- * possible, we make the following compromise:
- *
- * 1. SLEEP_OE_N will always be programmed to '1' (by MFP_LPM_FLOAT)
- * 2. DRIVE strength definitions redefined to include the reserved bit
- *    - the reserved bit differs between pxa168 and pxa910, and the
- *      MFP_DRIVE_* macros are individually defined in mfp-pxa{168,910}.h
- * 3. Override MFP_CFG() and MFP_CFG_DRV()
- * 4. Drop the use of MFP_CFG_LPM() and MFP_CFG_X()
- */
-
-#undef MFP_CFG
-#undef MFP_CFG_DRV
-#undef MFP_CFG_LPM
-#undef MFP_CFG_X
-#undef MFP_CFG_DEFAULT
-
-#define MFP_CFG(pin, af)		\
-	(MFP_LPM_FLOAT | MFP_PIN(MFP_PIN_##pin) | MFP_##af | MFP_DRIVE_MEDIUM)
-
-#define MFP_CFG_DRV(pin, af, drv)	\
-	(MFP_LPM_FLOAT | MFP_PIN(MFP_PIN_##pin) | MFP_##af | MFP_DRIVE_##drv)
-
-#endif /* __ASM_MACH_MFP_H */
diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index bbc4c2274de3..8ee6a4547731 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -19,11 +19,8 @@
 
 #include <asm/mach/time.h>
 #include "addr-map.h"
-#include "regs-apbc.h"
 #include <linux/soc/mmp/cputype.h>
-#include "irqs.h"
-#include "mfp.h"
-#include "devices.h"
+#include <linux/soc/pxa/mfp.h>
 #include "mmp2.h"
 #include "pm-mmp2.h"
 
@@ -91,14 +88,6 @@ void mmp2_clear_pmic_int(void)
 	__raw_writel(data, mfpr_pmic);
 }
 
-void __init mmp2_init_irq(void)
-{
-	mmp2_init_icu();
-#ifdef CONFIG_PM
-	icu_irq_chip.irq_set_wake = mmp2_set_wake;
-#endif
-}
-
 static int __init mmp2_init(void)
 {
 	if (cpu_is_mmp2()) {
@@ -115,61 +104,3 @@ static int __init mmp2_init(void)
 	return 0;
 }
 postcore_initcall(mmp2_init);
-
-#define APBC_TIMERS	APBC_REG(0x024)
-
-void __init mmp2_timer_init(void)
-{
-	unsigned long clk_rst;
-
-	__raw_writel(APBC_APBCLK | APBC_RST, APBC_TIMERS);
-
-	/*
-	 * enable bus/functional clock, enable 6.5MHz (divider 4),
-	 * release reset
-	 */
-	clk_rst = APBC_APBCLK | APBC_FNCLK | APBC_FNCLKSEL(1);
-	__raw_writel(clk_rst, APBC_TIMERS);
-
-	mmp_timer_init(IRQ_MMP2_TIMER1, 6500000);
-}
-
-/* on-chip devices */
-MMP2_DEVICE(uart1, "pxa2xx-uart", 0, UART1, 0xd4030000, 0x30, 4, 5);
-MMP2_DEVICE(uart2, "pxa2xx-uart", 1, UART2, 0xd4017000, 0x30, 20, 21);
-MMP2_DEVICE(uart3, "pxa2xx-uart", 2, UART3, 0xd4018000, 0x30, 22, 23);
-MMP2_DEVICE(uart4, "pxa2xx-uart", 3, UART4, 0xd4016000, 0x30, 18, 19);
-MMP2_DEVICE(twsi1, "pxa2xx-i2c", 0, TWSI1, 0xd4011000, 0x70);
-MMP2_DEVICE(twsi2, "pxa2xx-i2c", 1, TWSI2, 0xd4031000, 0x70);
-MMP2_DEVICE(twsi3, "pxa2xx-i2c", 2, TWSI3, 0xd4032000, 0x70);
-MMP2_DEVICE(twsi4, "pxa2xx-i2c", 3, TWSI4, 0xd4033000, 0x70);
-MMP2_DEVICE(twsi5, "pxa2xx-i2c", 4, TWSI5, 0xd4033800, 0x70);
-MMP2_DEVICE(twsi6, "pxa2xx-i2c", 5, TWSI6, 0xd4034000, 0x70);
-MMP2_DEVICE(nand, "pxa3xx-nand", -1, NAND, 0xd4283000, 0x100, 28, 29);
-MMP2_DEVICE(sdh0, "sdhci-pxav3", 0, MMC, 0xd4280000, 0x120);
-MMP2_DEVICE(sdh1, "sdhci-pxav3", 1, MMC2, 0xd4280800, 0x120);
-MMP2_DEVICE(sdh2, "sdhci-pxav3", 2, MMC3, 0xd4281000, 0x120);
-MMP2_DEVICE(sdh3, "sdhci-pxav3", 3, MMC4, 0xd4281800, 0x120);
-MMP2_DEVICE(asram, "asram", -1, NONE, 0xe0000000, 0x4000);
-/* 0xd1000000 ~ 0xd101ffff is reserved for secure processor */
-MMP2_DEVICE(isram, "isram", -1, NONE, 0xd1020000, 0x18000);
-
-struct resource mmp2_resource_gpio[] = {
-	{
-		.start	= 0xd4019000,
-		.end	= 0xd4019fff,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start	= IRQ_MMP2_GPIO,
-		.end	= IRQ_MMP2_GPIO,
-		.name	= "gpio_mux",
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device mmp2_device_gpio = {
-	.name		= "mmp2-gpio",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(mmp2_resource_gpio),
-	.resource	= mmp2_resource_gpio,
-};
diff --git a/arch/arm/mach-mmp/mmp2.h b/arch/arm/mach-mmp/mmp2.h
index 5c80836aea76..6616d3f7a0ac 100644
--- a/arch/arm/mach-mmp/mmp2.h
+++ b/arch/arm/mach-mmp/mmp2.h
@@ -2,90 +2,7 @@
 #ifndef __ASM_MACH_MMP2_H
 #define __ASM_MACH_MMP2_H
 
-#include <linux/platform_data/pxa_sdhci.h>
-
-extern void mmp2_timer_init(void);
-extern void __init mmp2_init_irq(void);
 extern void mmp2_clear_pmic_int(void);
 
-#include <linux/i2c.h>
-#include <linux/platform_data/i2c-pxa.h>
-#include <linux/irqchip/mmp.h>
-
-#include "devices.h"
-
-extern struct mmp_device_desc mmp2_device_uart1;
-extern struct mmp_device_desc mmp2_device_uart2;
-extern struct mmp_device_desc mmp2_device_uart3;
-extern struct mmp_device_desc mmp2_device_uart4;
-extern struct mmp_device_desc mmp2_device_twsi1;
-extern struct mmp_device_desc mmp2_device_twsi2;
-extern struct mmp_device_desc mmp2_device_twsi3;
-extern struct mmp_device_desc mmp2_device_twsi4;
-extern struct mmp_device_desc mmp2_device_twsi5;
-extern struct mmp_device_desc mmp2_device_twsi6;
-extern struct mmp_device_desc mmp2_device_sdh0;
-extern struct mmp_device_desc mmp2_device_sdh1;
-extern struct mmp_device_desc mmp2_device_sdh2;
-extern struct mmp_device_desc mmp2_device_sdh3;
-
-extern struct platform_device mmp2_device_gpio;
-
-static inline int mmp2_add_uart(int id)
-{
-	struct mmp_device_desc *d = NULL;
-
-	switch (id) {
-	case 1: d = &mmp2_device_uart1; break;
-	case 2: d = &mmp2_device_uart2; break;
-	case 3: d = &mmp2_device_uart3; break;
-	case 4: d = &mmp2_device_uart4; break;
-	default:
-		return -EINVAL;
-	}
-
-	return mmp_register_device(d, NULL, 0);
-}
-
-static inline int mmp2_add_twsi(int id, struct i2c_pxa_platform_data *data,
-				  struct i2c_board_info *info, unsigned size)
-{
-	struct mmp_device_desc *d = NULL;
-	int ret;
-
-	switch (id) {
-	case 1: d = &mmp2_device_twsi1; break;
-	case 2: d = &mmp2_device_twsi2; break;
-	case 3: d = &mmp2_device_twsi3; break;
-	case 4: d = &mmp2_device_twsi4; break;
-	case 5: d = &mmp2_device_twsi5; break;
-	case 6: d = &mmp2_device_twsi6; break;
-	default:
-		return -EINVAL;
-	}
-
-	ret = i2c_register_board_info(id - 1, info, size);
-	if (ret)
-		return ret;
-
-	return mmp_register_device(d, data, sizeof(*data));
-}
-
-static inline int mmp2_add_sdhost(int id, struct sdhci_pxa_platdata *data)
-{
-	struct mmp_device_desc *d = NULL;
-
-	switch (id) {
-	case 0: d = &mmp2_device_sdh0; break;
-	case 1: d = &mmp2_device_sdh1; break;
-	case 2: d = &mmp2_device_sdh2; break;
-	case 3: d = &mmp2_device_sdh3; break;
-	default:
-		return -EINVAL;
-	}
-
-	return mmp_register_device(d, data, sizeof(*data));
-}
-
 #endif /* __ASM_MACH_MMP2_H */
 
diff --git a/arch/arm/mach-mmp/pm-mmp2.c b/arch/arm/mach-mmp/pm-mmp2.c
index 7a6f74c32d42..bd6563962d77 100644
--- a/arch/arm/mach-mmp/pm-mmp2.c
+++ b/arch/arm/mach-mmp/pm-mmp2.c
@@ -21,40 +21,6 @@
 #include "addr-map.h"
 #include "pm-mmp2.h"
 #include "regs-icu.h"
-#include "irqs.h"
-
-int mmp2_set_wake(struct irq_data *d, unsigned int on)
-{
-	unsigned long data = 0;
-	int irq = d->irq;
-
-	/* enable wakeup sources */
-	switch (irq) {
-	case IRQ_MMP2_RTC:
-	case IRQ_MMP2_RTC_ALARM:
-		data = MPMU_WUCRM_PJ_WAKEUP(4) | MPMU_WUCRM_PJ_RTC_ALARM;
-		break;
-	case IRQ_MMP2_PMIC:
-		data = MPMU_WUCRM_PJ_WAKEUP(7);
-		break;
-	case IRQ_MMP2_MMC2:
-		/* mmc use WAKEUP2, same as GPIO wakeup source */
-		data = MPMU_WUCRM_PJ_WAKEUP(2);
-		break;
-	}
-	if (on) {
-		if (data) {
-			data |= __raw_readl(MPMU_WUCRM_PJ);
-			__raw_writel(data, MPMU_WUCRM_PJ);
-		}
-	} else {
-		if (data) {
-			data = ~data & __raw_readl(MPMU_WUCRM_PJ);
-			__raw_writel(data, MPMU_WUCRM_PJ);
-		}
-	}
-	return 0;
-}
 
 static void pm_scu_clk_disable(void)
 {
diff --git a/arch/arm/mach-mmp/pm-mmp2.h b/arch/arm/mach-mmp/pm-mmp2.h
index 70299a9450d3..70cff8bf0cc8 100644
--- a/arch/arm/mach-mmp/pm-mmp2.h
+++ b/arch/arm/mach-mmp/pm-mmp2.h
@@ -55,5 +55,5 @@ enum {
 };
 
 extern void mmp2_pm_enter_lowpower_mode(int state);
-extern int mmp2_set_wake(struct irq_data *d, unsigned int on);
+
 #endif
diff --git a/arch/arm/mach-mmp/pm-pxa910.c b/arch/arm/mach-mmp/pm-pxa910.c
index 1d71d73c1862..f6ba6db0aa36 100644
--- a/arch/arm/mach-mmp/pm-pxa910.c
+++ b/arch/arm/mach-mmp/pm-pxa910.c
@@ -22,112 +22,6 @@
 #include "addr-map.h"
 #include "pm-pxa910.h"
 #include "regs-icu.h"
-#include "irqs.h"
-
-int pxa910_set_wake(struct irq_data *data, unsigned int on)
-{
-	uint32_t awucrm = 0, apcr = 0;
-	int irq = data->irq;
-
-	/* setting wakeup sources */
-	switch (irq) {
-	/* wakeup line 2 */
-	case IRQ_PXA910_AP_GPIO:
-		awucrm = MPMU_AWUCRM_WAKEUP(2);
-		apcr |= MPMU_APCR_SLPWP2;
-		break;
-	/* wakeup line 3 */
-	case IRQ_PXA910_KEYPAD:
-		awucrm = MPMU_AWUCRM_WAKEUP(3) | MPMU_AWUCRM_KEYPRESS;
-		apcr |= MPMU_APCR_SLPWP3;
-		break;
-	case IRQ_PXA910_ROTARY:
-		awucrm = MPMU_AWUCRM_WAKEUP(3) | MPMU_AWUCRM_NEWROTARY;
-		apcr |= MPMU_APCR_SLPWP3;
-		break;
-	case IRQ_PXA910_TRACKBALL:
-		awucrm = MPMU_AWUCRM_WAKEUP(3) | MPMU_AWUCRM_TRACKBALL;
-		apcr |= MPMU_APCR_SLPWP3;
-		break;
-	/* wakeup line 4 */
-	case IRQ_PXA910_AP1_TIMER1:
-		awucrm = MPMU_AWUCRM_WAKEUP(4) | MPMU_AWUCRM_AP1_TIMER_1;
-		apcr |= MPMU_APCR_SLPWP4;
-		break;
-	case IRQ_PXA910_AP1_TIMER2:
-		awucrm = MPMU_AWUCRM_WAKEUP(4) | MPMU_AWUCRM_AP1_TIMER_2;
-		apcr |= MPMU_APCR_SLPWP4;
-		break;
-	case IRQ_PXA910_AP1_TIMER3:
-		awucrm = MPMU_AWUCRM_WAKEUP(4) | MPMU_AWUCRM_AP1_TIMER_3;
-		apcr |= MPMU_APCR_SLPWP4;
-		break;
-	case IRQ_PXA910_AP2_TIMER1:
-		awucrm = MPMU_AWUCRM_WAKEUP(4) | MPMU_AWUCRM_AP2_TIMER_1;
-		apcr |= MPMU_APCR_SLPWP4;
-		break;
-	case IRQ_PXA910_AP2_TIMER2:
-		awucrm = MPMU_AWUCRM_WAKEUP(4) | MPMU_AWUCRM_AP2_TIMER_2;
-		apcr |= MPMU_APCR_SLPWP4;
-		break;
-	case IRQ_PXA910_AP2_TIMER3:
-		awucrm = MPMU_AWUCRM_WAKEUP(4) | MPMU_AWUCRM_AP2_TIMER_3;
-		apcr |= MPMU_APCR_SLPWP4;
-		break;
-	case IRQ_PXA910_RTC_ALARM:
-		awucrm = MPMU_AWUCRM_WAKEUP(4) | MPMU_AWUCRM_RTC_ALARM;
-		apcr |= MPMU_APCR_SLPWP4;
-		break;
-	/* wakeup line 5 */
-	case IRQ_PXA910_USB1:
-	case IRQ_PXA910_USB2:
-		awucrm = MPMU_AWUCRM_WAKEUP(5);
-		apcr |= MPMU_APCR_SLPWP5;
-		break;
-	/* wakeup line 6 */
-	case IRQ_PXA910_MMC:
-		awucrm = MPMU_AWUCRM_WAKEUP(6)
-			| MPMU_AWUCRM_SDH1
-			| MPMU_AWUCRM_SDH2;
-		apcr |= MPMU_APCR_SLPWP6;
-		break;
-	/* wakeup line 7 */
-	case IRQ_PXA910_PMIC_INT:
-		awucrm = MPMU_AWUCRM_WAKEUP(7);
-		apcr |= MPMU_APCR_SLPWP7;
-		break;
-	default:
-		if (irq >= IRQ_GPIO_START && irq < IRQ_BOARD_START) {
-			awucrm = MPMU_AWUCRM_WAKEUP(2);
-			apcr |= MPMU_APCR_SLPWP2;
-		} else {
-			/* FIXME: This should return a proper error code ! */
-			printk(KERN_ERR "Error: no defined wake up source irq: %d\n",
-				irq);
-		}
-	}
-
-	if (on) {
-		if (awucrm) {
-			awucrm |= __raw_readl(MPMU_AWUCRM);
-			__raw_writel(awucrm, MPMU_AWUCRM);
-		}
-		if (apcr) {
-			apcr = ~apcr & __raw_readl(MPMU_APCR);
-			__raw_writel(apcr, MPMU_APCR);
-		}
-	} else {
-		if (awucrm) {
-			awucrm = ~awucrm & __raw_readl(MPMU_AWUCRM);
-			__raw_writel(awucrm, MPMU_AWUCRM);
-		}
-		if (apcr) {
-			apcr |= __raw_readl(MPMU_APCR);
-			__raw_writel(apcr, MPMU_APCR);
-		}
-	}
-	return 0;
-}
 
 void pxa910_pm_enter_lowpower_mode(int state)
 {
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 1e9389245d0e..565d4a6c3bd5 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -12,7 +12,6 @@
 #include <linux/clk.h>
 #include <linux/clk/mmp.h>
 #include <linux/platform_device.h>
-#include <linux/platform_data/mv_usb.h>
 #include <linux/dma-mapping.h>
 
 #include <asm/mach/time.h>
@@ -21,13 +20,9 @@
 #include "addr-map.h"
 #include "common.h"
 #include <linux/soc/mmp/cputype.h>
+#include <linux/soc/pxa/mfp.h>
 #include "devices.h"
-#include "irqs.h"
-#include "mfp.h"
 #include "pxa168.h"
-#include "regs-apbc.h"
-#include "regs-apmu.h"
-#include "regs-usb.h"
 
 #define MFPR_VIRT_BASE	(APB_VIRT_BASE + 0x1e000)
 
@@ -41,11 +36,6 @@ static struct mfp_addr_map pxa168_mfp_addr_map[] __initdata =
 	MFP_ADDR_END,
 };
 
-void __init pxa168_init_irq(void)
-{
-	icu_init_irq();
-}
-
 static int __init pxa168_init(void)
 {
 	if (cpu_is_pxa168()) {
@@ -59,117 +49,3 @@ static int __init pxa168_init(void)
 	return 0;
 }
 postcore_initcall(pxa168_init);
-
-/* system timer - clock enabled, 3.25MHz */
-#define TIMER_CLK_RST	(APBC_APBCLK | APBC_FNCLK | APBC_FNCLKSEL(3))
-#define APBC_TIMERS	APBC_REG(0x34)
-
-void __init pxa168_timer_init(void)
-{
-	/* this is early, we have to initialize the CCU registers by
-	 * ourselves instead of using clk_* API. Clock rate is defined
-	 * by APBC_TIMERS_CLK_RST (3.25MHz) and enabled free-running
-	 */
-	__raw_writel(APBC_APBCLK | APBC_RST, APBC_TIMERS);
-
-	/* 3.25MHz, bus/functional clock enabled, release reset */
-	__raw_writel(TIMER_CLK_RST, APBC_TIMERS);
-
-	mmp_timer_init(IRQ_PXA168_TIMER1, 3250000);
-}
-
-void pxa168_clear_keypad_wakeup(void)
-{
-	uint32_t val;
-	uint32_t mask = APMU_PXA168_KP_WAKE_CLR;
-
-	/* wake event clear is needed in order to clear keypad interrupt */
-	val = __raw_readl(APMU_WAKE_CLR);
-	__raw_writel(val |  mask, APMU_WAKE_CLR);
-}
-
-/* on-chip devices */
-PXA168_DEVICE(uart1, "pxa2xx-uart", 0, UART1, 0xd4017000, 0x30, 21, 22);
-PXA168_DEVICE(uart2, "pxa2xx-uart", 1, UART2, 0xd4018000, 0x30, 23, 24);
-PXA168_DEVICE(uart3, "pxa2xx-uart", 2, UART3, 0xd4026000, 0x30, 23, 24);
-PXA168_DEVICE(twsi0, "pxa2xx-i2c", 0, TWSI0, 0xd4011000, 0x28);
-PXA168_DEVICE(twsi1, "pxa2xx-i2c", 1, TWSI1, 0xd4025000, 0x28);
-PXA168_DEVICE(pwm1, "pxa168-pwm", 0, NONE, 0xd401a000, 0x10);
-PXA168_DEVICE(pwm2, "pxa168-pwm", 1, NONE, 0xd401a400, 0x10);
-PXA168_DEVICE(pwm3, "pxa168-pwm", 2, NONE, 0xd401a800, 0x10);
-PXA168_DEVICE(pwm4, "pxa168-pwm", 3, NONE, 0xd401ac00, 0x10);
-PXA168_DEVICE(nand, "pxa3xx-nand", -1, NAND, 0xd4283000, 0x80, 97, 99);
-PXA168_DEVICE(ssp1, "pxa168-ssp", 0, SSP1, 0xd401b000, 0x40, 52, 53);
-PXA168_DEVICE(ssp2, "pxa168-ssp", 1, SSP2, 0xd401c000, 0x40, 54, 55);
-PXA168_DEVICE(ssp3, "pxa168-ssp", 2, SSP3, 0xd401f000, 0x40, 56, 57);
-PXA168_DEVICE(ssp4, "pxa168-ssp", 3, SSP4, 0xd4020000, 0x40, 58, 59);
-PXA168_DEVICE(ssp5, "pxa168-ssp", 4, SSP5, 0xd4021000, 0x40, 60, 61);
-PXA168_DEVICE(fb, "pxa168-fb", -1, LCD, 0xd420b000, 0x1c8);
-PXA168_DEVICE(keypad, "pxa27x-keypad", -1, KEYPAD, 0xd4012000, 0x4c);
-PXA168_DEVICE(eth, "pxa168-eth", -1, MFU, 0xc0800000, 0x0fff);
-
-struct resource pxa168_resource_gpio[] = {
-	{
-		.start	= 0xd4019000,
-		.end	= 0xd4019fff,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start	= IRQ_PXA168_GPIOX,
-		.end	= IRQ_PXA168_GPIOX,
-		.name	= "gpio_mux",
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device pxa168_device_gpio = {
-	.name		= "mmp-gpio",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(pxa168_resource_gpio),
-	.resource	= pxa168_resource_gpio,
-};
-
-struct resource pxa168_usb_host_resources[] = {
-	/* USB Host conroller register base */
-	[0] = {
-		.start	= PXA168_U2H_REGBASE + U2x_CAPREGS_OFFSET,
-		.end	= PXA168_U2H_REGBASE + USB_REG_RANGE,
-		.flags	= IORESOURCE_MEM,
-		.name	= "capregs",
-	},
-	/* USB PHY register base */
-	[1] = {
-		.start	= PXA168_U2H_PHYBASE,
-		.end	= PXA168_U2H_PHYBASE + USB_PHY_RANGE,
-		.flags	= IORESOURCE_MEM,
-		.name	= "phyregs",
-	},
-	[2] = {
-		.start	= IRQ_PXA168_USB2,
-		.end	= IRQ_PXA168_USB2,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static u64 pxa168_usb_host_dmamask = DMA_BIT_MASK(32);
-struct platform_device pxa168_device_usb_host = {
-	.name = "pxa-sph",
-	.id   = -1,
-	.dev  = {
-		.dma_mask = &pxa168_usb_host_dmamask,
-		.coherent_dma_mask = DMA_BIT_MASK(32),
-	},
-
-	.num_resources = ARRAY_SIZE(pxa168_usb_host_resources),
-	.resource      = pxa168_usb_host_resources,
-};
-
-int __init pxa168_add_usb_host(struct mv_usb_platform_data *pdata)
-{
-	pxa168_device_usb_host.dev.platform_data = pdata;
-	return platform_device_register(&pxa168_device_usb_host);
-}
-
-void pxa168_restart(enum reboot_mode mode, const char *cmd)
-{
-	soft_restart(0xffff0000);
-}
diff --git a/arch/arm/mach-mmp/pxa168.h b/arch/arm/mach-mmp/pxa168.h
index c1547e098f09..279783ef239d 100644
--- a/arch/arm/mach-mmp/pxa168.h
+++ b/arch/arm/mach-mmp/pxa168.h
@@ -10,130 +10,7 @@ extern void pxa168_restart(enum reboot_mode, const char *);
 extern void pxa168_clear_keypad_wakeup(void);
 
 #include <linux/i2c.h>
-#include <linux/platform_data/i2c-pxa.h>
-#include <linux/platform_data/mtd-nand-pxa3xx.h>
-#include <video/pxa168fb.h>
-#include <linux/platform_data/keypad-pxa27x.h>
-#include <linux/pxa168_eth.h>
-#include <linux/platform_data/mv_usb.h>
 #include <linux/soc/mmp/cputype.h>
 #include <linux/irqchip/mmp.h>
 
-#include "devices.h"
-
-extern struct mmp_device_desc pxa168_device_uart1;
-extern struct mmp_device_desc pxa168_device_uart2;
-extern struct mmp_device_desc pxa168_device_uart3;
-extern struct mmp_device_desc pxa168_device_twsi0;
-extern struct mmp_device_desc pxa168_device_twsi1;
-extern struct mmp_device_desc pxa168_device_pwm1;
-extern struct mmp_device_desc pxa168_device_pwm2;
-extern struct mmp_device_desc pxa168_device_pwm3;
-extern struct mmp_device_desc pxa168_device_pwm4;
-extern struct mmp_device_desc pxa168_device_ssp1;
-extern struct mmp_device_desc pxa168_device_ssp2;
-extern struct mmp_device_desc pxa168_device_ssp3;
-extern struct mmp_device_desc pxa168_device_ssp4;
-extern struct mmp_device_desc pxa168_device_ssp5;
-extern struct mmp_device_desc pxa168_device_nand;
-extern struct mmp_device_desc pxa168_device_fb;
-extern struct mmp_device_desc pxa168_device_keypad;
-extern struct mmp_device_desc pxa168_device_eth;
-
-/* pdata can be NULL */
-extern int __init pxa168_add_usb_host(struct mv_usb_platform_data *pdata);
-
-
-extern struct platform_device pxa168_device_gpio;
-
-static inline int pxa168_add_uart(int id)
-{
-	struct mmp_device_desc *d = NULL;
-
-	switch (id) {
-	case 1: d = &pxa168_device_uart1; break;
-	case 2: d = &pxa168_device_uart2; break;
-	case 3: d = &pxa168_device_uart3; break;
-	}
-
-	if (d == NULL)
-		return -EINVAL;
-
-	return mmp_register_device(d, NULL, 0);
-}
-
-static inline int pxa168_add_twsi(int id, struct i2c_pxa_platform_data *data,
-				  struct i2c_board_info *info, unsigned size)
-{
-	struct mmp_device_desc *d = NULL;
-	int ret;
-
-	switch (id) {
-	case 0: d = &pxa168_device_twsi0; break;
-	case 1: d = &pxa168_device_twsi1; break;
-	default:
-		return -EINVAL;
-	}
-
-	ret = i2c_register_board_info(id, info, size);
-	if (ret)
-		return ret;
-
-	return mmp_register_device(d, data, sizeof(*data));
-}
-
-static inline int pxa168_add_pwm(int id)
-{
-	struct mmp_device_desc *d = NULL;
-
-	switch (id) {
-	case 1: d = &pxa168_device_pwm1; break;
-	case 2: d = &pxa168_device_pwm2; break;
-	case 3: d = &pxa168_device_pwm3; break;
-	case 4: d = &pxa168_device_pwm4; break;
-	default:
-		return -EINVAL;
-	}
-
-	return mmp_register_device(d, NULL, 0);
-}
-
-static inline int pxa168_add_ssp(int id)
-{
-	struct mmp_device_desc *d = NULL;
-
-	switch (id) {
-	case 1: d = &pxa168_device_ssp1; break;
-	case 2: d = &pxa168_device_ssp2; break;
-	case 3: d = &pxa168_device_ssp3; break;
-	case 4: d = &pxa168_device_ssp4; break;
-	case 5: d = &pxa168_device_ssp5; break;
-	default:
-		return -EINVAL;
-	}
-	return mmp_register_device(d, NULL, 0);
-}
-
-static inline int pxa168_add_nand(struct pxa3xx_nand_platform_data *info)
-{
-	return mmp_register_device(&pxa168_device_nand, info, sizeof(*info));
-}
-
-static inline int pxa168_add_fb(struct pxa168fb_mach_info *mi)
-{
-	return mmp_register_device(&pxa168_device_fb, mi, sizeof(*mi));
-}
-
-static inline int pxa168_add_keypad(struct pxa27x_keypad_platform_data *data)
-{
-	if (cpu_is_pxa168())
-		data->clear_wakeup_event = pxa168_clear_keypad_wakeup;
-
-	return mmp_register_device(&pxa168_device_keypad, data, sizeof(*data));
-}
-
-static inline int pxa168_add_eth(struct pxa168_eth_platform_data *data)
-{
-	return mmp_register_device(&pxa168_device_eth, data, sizeof(*data));
-}
 #endif /* __ASM_MACH_PXA168_H */
diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
index b19a069d9fab..f389b99cd9bd 100644
--- a/arch/arm/mach-mmp/pxa910.c
+++ b/arch/arm/mach-mmp/pxa910.c
@@ -17,13 +17,10 @@
 #include <asm/hardware/cache-tauros2.h>
 #include <asm/mach/time.h>
 #include "addr-map.h"
-#include "regs-apbc.h"
 #include <linux/soc/mmp/cputype.h>
+#include <linux/soc/pxa/mfp.h>
 #include "irqs.h"
-#include "mfp.h"
-#include "devices.h"
 #include "pm-pxa910.h"
-#include "pxa910.h"
 
 #include "common.h"
 
@@ -77,14 +74,6 @@ static struct mfp_addr_map pxa910_mfp_addr_map[] __initdata =
 	MFP_ADDR_END,
 };
 
-void __init pxa910_init_irq(void)
-{
-	icu_init_irq();
-#ifdef CONFIG_PM
-	icu_irq_chip.irq_set_wake = pxa910_set_wake;
-#endif
-}
-
 static int __init pxa910_init(void)
 {
 	if (cpu_is_pxa910()) {
@@ -102,89 +91,3 @@ static int __init pxa910_init(void)
 	return 0;
 }
 postcore_initcall(pxa910_init);
-
-/* system timer - clock enabled, 3.25MHz */
-#define TIMER_CLK_RST	(APBC_APBCLK | APBC_FNCLK | APBC_FNCLKSEL(3))
-#define APBC_TIMERS	APBC_REG(0x34)
-
-void __init pxa910_timer_init(void)
-{
-	/* reset and configure */
-	__raw_writel(APBC_APBCLK | APBC_RST, APBC_TIMERS);
-	__raw_writel(TIMER_CLK_RST, APBC_TIMERS);
-
-	mmp_timer_init(IRQ_PXA910_AP1_TIMER1, 3250000);
-}
-
-/* on-chip devices */
-
-/* NOTE: there are totally 3 UARTs on PXA910:
- *
- *   UART1   - Slow UART (can be used both by AP and CP)
- *   UART2/3 - Fast UART
- *
- * To be backward compatible with the legacy FFUART/BTUART/STUART sequence,
- * they are re-ordered as:
- *
- *   pxa910_device_uart1 - UART2 as FFUART
- *   pxa910_device_uart2 - UART3 as BTUART
- *
- * UART1 is not used by AP for the moment.
- */
-PXA910_DEVICE(uart1, "pxa2xx-uart", 0, UART2, 0xd4017000, 0x30, 21, 22);
-PXA910_DEVICE(uart2, "pxa2xx-uart", 1, UART3, 0xd4018000, 0x30, 23, 24);
-PXA910_DEVICE(twsi0, "pxa2xx-i2c", 0, TWSI0, 0xd4011000, 0x28);
-PXA910_DEVICE(twsi1, "pxa2xx-i2c", 1, TWSI1, 0xd4025000, 0x28);
-PXA910_DEVICE(pwm1, "pxa910-pwm", 0, NONE, 0xd401a000, 0x10);
-PXA910_DEVICE(pwm2, "pxa910-pwm", 1, NONE, 0xd401a400, 0x10);
-PXA910_DEVICE(pwm3, "pxa910-pwm", 2, NONE, 0xd401a800, 0x10);
-PXA910_DEVICE(pwm4, "pxa910-pwm", 3, NONE, 0xd401ac00, 0x10);
-PXA910_DEVICE(nand, "pxa3xx-nand", -1, NAND, 0xd4283000, 0x80, 97, 99);
-PXA910_DEVICE(disp, "mmp-disp", 0, LCD, 0xd420b000, 0x1ec);
-PXA910_DEVICE(fb, "mmp-fb", -1, NONE, 0, 0);
-PXA910_DEVICE(panel, "tpo-hvga", -1, NONE, 0, 0);
-
-struct resource pxa910_resource_gpio[] = {
-	{
-		.start	= 0xd4019000,
-		.end	= 0xd4019fff,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start	= IRQ_PXA910_AP_GPIO,
-		.end	= IRQ_PXA910_AP_GPIO,
-		.name	= "gpio_mux",
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device pxa910_device_gpio = {
-	.name		= "mmp-gpio",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(pxa910_resource_gpio),
-	.resource	= pxa910_resource_gpio,
-};
-
-static struct resource pxa910_resource_rtc[] = {
-	{
-		.start	= 0xd4010000,
-		.end	= 0xd401003f,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start	= IRQ_PXA910_RTC_INT,
-		.end	= IRQ_PXA910_RTC_INT,
-		.name	= "rtc 1Hz",
-		.flags	= IORESOURCE_IRQ,
-	}, {
-		.start	= IRQ_PXA910_RTC_ALARM,
-		.end	= IRQ_PXA910_RTC_ALARM,
-		.name	= "rtc alarm",
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device pxa910_device_rtc = {
-	.name		= "sa1100-rtc",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(pxa910_resource_rtc),
-	.resource	= pxa910_resource_rtc,
-};
diff --git a/arch/arm/mach-mmp/pxa910.h b/arch/arm/mach-mmp/pxa910.h
index 7d229214065a..66a691d89ae1 100644
--- a/arch/arm/mach-mmp/pxa910.h
+++ b/arch/arm/mach-mmp/pxa910.h
@@ -6,85 +6,6 @@ extern void pxa910_timer_init(void);
 extern void __init pxa910_init_irq(void);
 
 #include <linux/i2c.h>
-#include <linux/platform_data/i2c-pxa.h>
-#include <linux/platform_data/mtd-nand-pxa3xx.h>
-#include <video/mmp_disp.h>
 #include <linux/irqchip/mmp.h>
 
-#include "devices.h"
-
-extern struct mmp_device_desc pxa910_device_uart1;
-extern struct mmp_device_desc pxa910_device_uart2;
-extern struct mmp_device_desc pxa910_device_twsi0;
-extern struct mmp_device_desc pxa910_device_twsi1;
-extern struct mmp_device_desc pxa910_device_pwm1;
-extern struct mmp_device_desc pxa910_device_pwm2;
-extern struct mmp_device_desc pxa910_device_pwm3;
-extern struct mmp_device_desc pxa910_device_pwm4;
-extern struct mmp_device_desc pxa910_device_nand;
-extern struct platform_device pxa168_device_usb_phy;
-extern struct platform_device pxa168_device_u2o;
-extern struct platform_device pxa168_device_u2ootg;
-extern struct platform_device pxa168_device_u2oehci;
-extern struct mmp_device_desc pxa910_device_disp;
-extern struct mmp_device_desc pxa910_device_fb;
-extern struct mmp_device_desc pxa910_device_panel;
-extern struct platform_device pxa910_device_gpio;
-extern struct platform_device pxa910_device_rtc;
-
-static inline int pxa910_add_uart(int id)
-{
-	struct mmp_device_desc *d = NULL;
-
-	switch (id) {
-	case 1: d = &pxa910_device_uart1; break;
-	case 2: d = &pxa910_device_uart2; break;
-	}
-
-	if (d == NULL)
-		return -EINVAL;
-
-	return mmp_register_device(d, NULL, 0);
-}
-
-static inline int pxa910_add_twsi(int id, struct i2c_pxa_platform_data *data,
-				  struct i2c_board_info *info, unsigned size)
-{
-	struct mmp_device_desc *d = NULL;
-	int ret;
-
-	switch (id) {
-	case 0: d = &pxa910_device_twsi0; break;
-	case 1: d = &pxa910_device_twsi1; break;
-	default:
-		return -EINVAL;
-	}
-
-	ret = i2c_register_board_info(id, info, size);
-	if (ret)
-		return ret;
-
-	return mmp_register_device(d, data, sizeof(*data));
-}
-
-static inline int pxa910_add_pwm(int id)
-{
-	struct mmp_device_desc *d = NULL;
-
-	switch (id) {
-	case 1: d = &pxa910_device_pwm1; break;
-	case 2: d = &pxa910_device_pwm2; break;
-	case 3: d = &pxa910_device_pwm3; break;
-	case 4: d = &pxa910_device_pwm4; break;
-	default:
-		return -EINVAL;
-	}
-
-	return mmp_register_device(d, NULL, 0);
-}
-
-static inline int pxa910_add_nand(struct pxa3xx_nand_platform_data *info)
-{
-	return mmp_register_device(&pxa910_device_nand, info, sizeof(*info));
-}
 #endif /* __ASM_MACH_PXA910_H */
diff --git a/arch/arm/mach-mmp/regs-apbc.h b/arch/arm/mach-mmp/regs-apbc.h
deleted file mode 100644
index d0d00c2cce38..000000000000
--- a/arch/arm/mach-mmp/regs-apbc.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- *   Application Peripheral Bus Clock Unit
- */
-
-#ifndef __ASM_MACH_REGS_APBC_H
-#define __ASM_MACH_REGS_APBC_H
-
-#include "addr-map.h"
-
-/* Common APB clock register bit definitions */
-#define APBC_APBCLK	(1 << 0)  /* APB Bus Clock Enable */
-#define APBC_FNCLK	(1 << 1)  /* Functional Clock Enable */
-#define APBC_RST	(1 << 2)  /* Reset Generation */
-
-/* Functional Clock Selection Mask */
-#define APBC_FNCLKSEL(x)	(((x) & 0xf) << 4)
-
-#endif /* __ASM_MACH_REGS_APBC_H */
diff --git a/arch/arm/mach-mmp/regs-apmu.h b/arch/arm/mach-mmp/regs-apmu.h
deleted file mode 100644
index e36f6503adfb..000000000000
--- a/arch/arm/mach-mmp/regs-apmu.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- *   Application Subsystem Power Management Unit
- */
-
-#ifndef __ASM_MACH_REGS_APMU_H
-#define __ASM_MACH_REGS_APMU_H
-
-#include "addr-map.h"
-
-#define APMU_FNCLK_EN	(1 << 4)
-#define APMU_AXICLK_EN	(1 << 3)
-#define APMU_FNRST_DIS	(1 << 1)
-#define APMU_AXIRST_DIS	(1 << 0)
-
-/* Wake Clear Register */
-#define APMU_WAKE_CLR	APMU_REG(0x07c)
-
-#define APMU_PXA168_KP_WAKE_CLR		(1 << 7)
-#define APMU_PXA168_CFI_WAKE_CLR	(1 << 6)
-#define APMU_PXA168_XD_WAKE_CLR		(1 << 5)
-#define APMU_PXA168_MSP_WAKE_CLR	(1 << 4)
-#define APMU_PXA168_SD4_WAKE_CLR	(1 << 3)
-#define APMU_PXA168_SD3_WAKE_CLR	(1 << 2)
-#define APMU_PXA168_SD2_WAKE_CLR	(1 << 1)
-#define APMU_PXA168_SD1_WAKE_CLR	(1 << 0)
-
-#endif /* __ASM_MACH_REGS_APMU_H */
diff --git a/arch/arm/mach-mmp/regs-timers.h b/arch/arm/mach-mmp/regs-timers.h
index a69f4d7e3443..0cc4aca40e2c 100644
--- a/arch/arm/mach-mmp/regs-timers.h
+++ b/arch/arm/mach-mmp/regs-timers.h
@@ -6,11 +6,6 @@
 #ifndef __ASM_MACH_REGS_TIMERS_H
 #define __ASM_MACH_REGS_TIMERS_H
 
-#include "addr-map.h"
-
-#define TIMERS1_VIRT_BASE	(APB_VIRT_BASE + 0x14000)
-#define TIMERS2_VIRT_BASE	(APB_VIRT_BASE + 0x16000)
-
 #define TMR_CCR		(0x0000)
 #define TMR_TN_MM(n, m)	(0x0004 + ((n) << 3) + (((n) + (m)) << 2))
 #define TMR_CR(n)	(0x0028 + ((n) << 2))
diff --git a/arch/arm/mach-mmp/regs-usb.h b/arch/arm/mach-mmp/regs-usb.h
deleted file mode 100644
index ed0d1aa0ad6c..000000000000
--- a/arch/arm/mach-mmp/regs-usb.h
+++ /dev/null
@@ -1,155 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2011 Marvell International Ltd. All rights reserved.
- */
-
-#ifndef __ASM_ARCH_REGS_USB_H
-#define __ASM_ARCH_REGS_USB_H
-
-#define PXA168_U2O_REGBASE	(0xd4208000)
-#define PXA168_U2O_PHYBASE	(0xd4207000)
-
-#define PXA168_U2H_REGBASE      (0xd4209000)
-#define PXA168_U2H_PHYBASE      (0xd4206000)
-
-#define MMP3_HSIC1_REGBASE	(0xf0001000)
-#define MMP3_HSIC1_PHYBASE	(0xf0001800)
-
-#define MMP3_HSIC2_REGBASE	(0xf0002000)
-#define MMP3_HSIC2_PHYBASE	(0xf0002800)
-
-#define MMP3_FSIC_REGBASE	(0xf0003000)
-#define MMP3_FSIC_PHYBASE	(0xf0003800)
-
-
-#define USB_REG_RANGE		(0x1ff)
-#define USB_PHY_RANGE		(0xff)
-
-/* registers */
-#define U2x_CAPREGS_OFFSET       0x100
-
-/* phy regs */
-#define UTMI_REVISION		0x0
-#define UTMI_CTRL		0x4
-#define UTMI_PLL		0x8
-#define UTMI_TX			0xc
-#define UTMI_RX			0x10
-#define UTMI_IVREF		0x14
-#define UTMI_T0			0x18
-#define UTMI_T1			0x1c
-#define UTMI_T2			0x20
-#define UTMI_T3			0x24
-#define UTMI_T4			0x28
-#define UTMI_T5			0x2c
-#define UTMI_RESERVE		0x30
-#define UTMI_USB_INT		0x34
-#define UTMI_DBG_CTL		0x38
-#define UTMI_OTG_ADDON		0x3c
-
-/* For UTMICTRL Register */
-#define UTMI_CTRL_USB_CLK_EN                    (1 << 31)
-/* pxa168 */
-#define UTMI_CTRL_SUSPEND_SET1                  (1 << 30)
-#define UTMI_CTRL_SUSPEND_SET2                  (1 << 29)
-#define UTMI_CTRL_RXBUF_PDWN                    (1 << 24)
-#define UTMI_CTRL_TXBUF_PDWN                    (1 << 11)
-
-#define UTMI_CTRL_INPKT_DELAY_SHIFT             30
-#define UTMI_CTRL_INPKT_DELAY_SOF_SHIFT		28
-#define UTMI_CTRL_PU_REF_SHIFT			20
-#define UTMI_CTRL_ARC_PULLDN_SHIFT              12
-#define UTMI_CTRL_PLL_PWR_UP_SHIFT              1
-#define UTMI_CTRL_PWR_UP_SHIFT                  0
-
-/* For UTMI_PLL Register */
-#define UTMI_PLL_PLLCALI12_SHIFT		29
-#define UTMI_PLL_PLLCALI12_MASK			(0x3 << 29)
-
-#define UTMI_PLL_PLLVDD18_SHIFT			27
-#define UTMI_PLL_PLLVDD18_MASK			(0x3 << 27)
-
-#define UTMI_PLL_PLLVDD12_SHIFT			25
-#define UTMI_PLL_PLLVDD12_MASK			(0x3 << 25)
-
-#define UTMI_PLL_CLK_BLK_EN_SHIFT               24
-#define CLK_BLK_EN                              (0x1 << 24)
-#define PLL_READY                               (0x1 << 23)
-#define KVCO_EXT                                (0x1 << 22)
-#define VCOCAL_START                            (0x1 << 21)
-
-#define UTMI_PLL_KVCO_SHIFT			15
-#define UTMI_PLL_KVCO_MASK                      (0x7 << 15)
-
-#define UTMI_PLL_ICP_SHIFT			12
-#define UTMI_PLL_ICP_MASK                       (0x7 << 12)
-
-#define UTMI_PLL_FBDIV_SHIFT                    4
-#define UTMI_PLL_FBDIV_MASK                     (0xFF << 4)
-
-#define UTMI_PLL_REFDIV_SHIFT                   0
-#define UTMI_PLL_REFDIV_MASK                    (0xF << 0)
-
-/* For UTMI_TX Register */
-#define UTMI_TX_REG_EXT_FS_RCAL_SHIFT		27
-#define UTMI_TX_REG_EXT_FS_RCAL_MASK		(0xf << 27)
-
-#define UTMI_TX_REG_EXT_FS_RCAL_EN_SHIFT	26
-#define UTMI_TX_REG_EXT_FS_RCAL_EN_MASK		(0x1 << 26)
-
-#define UTMI_TX_TXVDD12_SHIFT                   22
-#define UTMI_TX_TXVDD12_MASK                    (0x3 << 22)
-
-#define UTMI_TX_CK60_PHSEL_SHIFT                17
-#define UTMI_TX_CK60_PHSEL_MASK                 (0xf << 17)
-
-#define UTMI_TX_IMPCAL_VTH_SHIFT                14
-#define UTMI_TX_IMPCAL_VTH_MASK                 (0x7 << 14)
-
-#define REG_RCAL_START                          (0x1 << 12)
-
-#define UTMI_TX_LOW_VDD_EN_SHIFT                11
-
-#define UTMI_TX_AMP_SHIFT			0
-#define UTMI_TX_AMP_MASK			(0x7 << 0)
-
-/* For UTMI_RX Register */
-#define UTMI_REG_SQ_LENGTH_SHIFT                15
-#define UTMI_REG_SQ_LENGTH_MASK                 (0x3 << 15)
-
-#define UTMI_RX_SQ_THRESH_SHIFT                 4
-#define UTMI_RX_SQ_THRESH_MASK                  (0xf << 4)
-
-#define UTMI_OTG_ADDON_OTG_ON			(1 << 0)
-
-/* fsic registers */
-#define FSIC_MISC			0x4
-#define FSIC_INT			0x28
-#define FSIC_CTRL			0x30
-
-/* HSIC registers */
-#define HSIC_PAD_CTRL			0x4
-
-#define HSIC_CTRL			0x8
-#define HSIC_CTRL_HSIC_ENABLE		(1<<7)
-#define HSIC_CTRL_PLL_BYPASS		(1<<4)
-
-#define TEST_GRP_0			0xc
-#define TEST_GRP_1			0x10
-
-#define HSIC_INT			0x14
-#define HSIC_INT_READY_INT_EN		(1<<10)
-#define HSIC_INT_CONNECT_INT_EN		(1<<9)
-#define HSIC_INT_CORE_INT_EN		(1<<8)
-#define HSIC_INT_HS_READY		(1<<2)
-#define HSIC_INT_CONNECT		(1<<1)
-#define HSIC_INT_CORE			(1<<0)
-
-#define HSIC_CONFIG			0x18
-#define USBHSIC_CTRL			0x20
-
-#define HSIC_USB_CTRL			0x28
-#define HSIC_USB_CTRL_CLKEN		1
-#define	HSIC_USB_CLK_PHY		0x0
-#define HSIC_USB_CLK_PMU		0x1
-
-#endif /* __ASM_ARCH_PXA_U2O_H */
diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
index 41b2e8abc9e6..0f0ed2428595 100644
--- a/arch/arm/mach-mmp/time.c
+++ b/arch/arm/mach-mmp/time.c
@@ -29,18 +29,13 @@
 #include <linux/sched_clock.h>
 #include <asm/mach/time.h>
 
-#include "addr-map.h"
 #include "regs-timers.h"
-#include "regs-apbc.h"
-#include "irqs.h"
 #include <linux/soc/mmp/cputype.h>
 
-#define TIMERS_VIRT_BASE	TIMERS1_VIRT_BASE
-
 #define MAX_DELTA		(0xfffffffe)
 #define MIN_DELTA		(16)
 
-static void __iomem *mmp_timer_base = TIMERS_VIRT_BASE;
+static void __iomem *mmp_timer_base;
 
 /*
  * FIXME: the timer needs some delay to stablize the counter capture
@@ -174,7 +169,7 @@ static void __init timer_config(void)
 	__raw_writel(0x2, mmp_timer_base + TMR_CER);
 }
 
-void __init mmp_timer_init(int irq, unsigned long rate)
+static void __init mmp_timer_init(int irq, unsigned long rate)
 {
 	timer_config();
 
-- 
2.29.2

