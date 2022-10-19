Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B4F604C0C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbiJSPrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbiJSPrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:47:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CDA7AC03
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:41:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 928D4B822B8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 15:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792A6C433D6;
        Wed, 19 Oct 2022 15:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666193592;
        bh=lPpiVyuP6vJH/Gr2VZZf0W2b61qKAF6ReCthbJ8sDPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Amq0BGgKtR7R+Qip5yPyxx19lCPpLghhodLlmf0VogZedpxVHtevJunFhoAp6iMc5
         6VM/UCJ6DnEp1sgZc6jTQwClVT30VUgQsgXzVWFP9RTTVPGX0fiw+TxPwsdPW2WBg+
         k7/1tSoCImbjsZoyCprfGyzVd0CWLgROFRs3zYKLYC2l+CTO1GhULUCxAF/Ig7k2Nr
         5UoAFk/qLFClywQ1iotXdyjQZogMRHOfKsUcv6fWIMZjFWxNoy1I9gB0vh+d6xNXVH
         OQmO7QsSdJiRSy26QQLyiING22LeTd5N+bkat/VKLNm6EO7zclxosAcPNT7X3nz0sn
         tjxiSWrhEjesQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Sekhar Nori <nsekhar@ti.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 03/14] ARM: davinci: clean up platform support
Date:   Wed, 19 Oct 2022 17:29:29 +0200
Message-Id: <20221019152947.3857217-4-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221019152947.3857217-1-arnd@kernel.org>
References: <20221019152947.3857217-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

With the board file support gone, and the platform using
DT only, a lot of the remaining code is no longer referenced
and can be removed.

Technically, the DT file only references DA850, but since that
is very similar to DA830, I'm leaving the latter.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-davinci/Kconfig         |   16 -
 arch/arm/mach-davinci/Makefile        |    9 +-
 arch/arm/mach-davinci/asp.h           |   57 --
 arch/arm/mach-davinci/common.h        |    7 +-
 arch/arm/mach-davinci/cputype.h       |   21 -
 arch/arm/mach-davinci/da830.c         |  274 -------
 arch/arm/mach-davinci/da850.c         |  400 +--------
 arch/arm/mach-davinci/da8xx.h         |   95 +--
 arch/arm/mach-davinci/davinci.h       |  136 ---
 arch/arm/mach-davinci/devices-da8xx.c | 1095 -------------------------
 arch/arm/mach-davinci/irqs.h          |  217 -----
 arch/arm/mach-davinci/mux.c           |   15 -
 arch/arm/mach-davinci/mux.h           |  315 -------
 arch/arm/mach-davinci/psc.h           |   64 --
 arch/arm/mach-davinci/serial.c        |   88 --
 arch/arm/mach-davinci/serial.h        |   35 -
 arch/arm/mach-davinci/usb-da8xx.c     |  146 ----
 arch/arm/mach-davinci/usb.c           |   74 --
 18 files changed, 11 insertions(+), 3053 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/asp.h
 delete mode 100644 arch/arm/mach-davinci/davinci.h
 delete mode 100644 arch/arm/mach-davinci/serial.c
 delete mode 100644 arch/arm/mach-davinci/serial.h
 delete mode 100644 arch/arm/mach-davinci/usb-da8xx.c
 delete mode 100644 arch/arm/mach-davinci/usb.c

diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index 588213583051..4316e1370627 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -18,8 +18,6 @@ comment "DaVinci Core Type"
 
 config ARCH_DAVINCI_DA830
 	bool "DA830/OMAP-L137/AM17x based system"
-	depends on AUTO_ZRELADDR && ARM_PATCH_PHYS_VIRT
-	depends on ATAGS
 	select ARCH_DAVINCI_DA8XX
 	# needed on silicon revs 1.0, 1.1:
 	select CPU_DCACHE_WRITETHROUGH if !CPU_DCACHE_DISABLE
@@ -27,25 +25,11 @@ config ARCH_DAVINCI_DA830
 
 config ARCH_DAVINCI_DA850
 	bool "DA850/OMAP-L138/AM18x based system"
-	depends on AUTO_ZRELADDR && ARM_PATCH_PHYS_VIRT
-	depends on ATAGS
-	select ARCH_DAVINCI_DA8XX
 	select DAVINCI_CP_INTC
 
 config ARCH_DAVINCI_DA8XX
 	bool
 
-comment "DaVinci Board Type"
-
-config MACH_DA8XX_DT
-	bool "Support DA8XX platforms using device tree"
-	default y
-	depends on ARCH_DAVINCI_DA850
-	select PINCTRL
-	help
-	  Say y here to include support for TI DaVinci DA850 based using
-	  Flattened Device Tree. More information at Documentation/devicetree
-
 config DAVINCI_MUX
 	bool "DAVINCI multiplexing support"
 	depends on ARCH_DAVINCI
diff --git a/arch/arm/mach-davinci/Makefile b/arch/arm/mach-davinci/Makefile
index 5b15a3bbf909..5ab1766fc306 100644
--- a/arch/arm/mach-davinci/Makefile
+++ b/arch/arm/mach-davinci/Makefile
@@ -5,16 +5,15 @@
 #
 #
 # Common objects
-obj-y 					:= serial.o usb.o common.o sram.o
+obj-y 					:= common.o sram.o devices-da8xx.o
 
 obj-$(CONFIG_DAVINCI_MUX)		+= mux.o
 
 # Chip specific
-obj-$(CONFIG_ARCH_DAVINCI_DA830)	+= da830.o devices-da8xx.o usb-da8xx.o
-obj-$(CONFIG_ARCH_DAVINCI_DA850)	+= da850.o devices-da8xx.o usb-da8xx.o
+obj-$(CONFIG_ARCH_DAVINCI_DA830)	+= da830.o
+obj-$(CONFIG_ARCH_DAVINCI_DA850)	+= da850.o
 
-# Board specific
-obj-$(CONFIG_MACH_DA8XX_DT)		+= da8xx-dt.o pdata-quirks.o
+obj-y					+= da8xx-dt.o pdata-quirks.o
 
 # Power Management
 obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
diff --git a/arch/arm/mach-davinci/asp.h b/arch/arm/mach-davinci/asp.h
deleted file mode 100644
index d0ecd1d0f084..000000000000
--- a/arch/arm/mach-davinci/asp.h
+++ /dev/null
@@ -1,57 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * TI DaVinci Audio definitions
- */
-#ifndef __ASM_ARCH_DAVINCI_ASP_H
-#define __ASM_ARCH_DAVINCI_ASP_H
-
-/* Bases of dm644x and dm355 register banks */
-#define DAVINCI_ASP0_BASE	0x01E02000
-#define DAVINCI_ASP1_BASE	0x01E04000
-
-/* Bases of dm365 register banks */
-#define DAVINCI_DM365_ASP0_BASE	0x01D02000
-
-/* Bases of dm646x register banks */
-#define DAVINCI_DM646X_MCASP0_REG_BASE		0x01D01000
-#define DAVINCI_DM646X_MCASP1_REG_BASE		0x01D01800
-
-/* Bases of da850/da830 McASP0  register banks */
-#define DAVINCI_DA8XX_MCASP0_REG_BASE	0x01D00000
-
-/* Bases of da830 McASP1 register banks */
-#define DAVINCI_DA830_MCASP1_REG_BASE	0x01D04000
-
-/* Bases of da830 McASP2 register banks */
-#define DAVINCI_DA830_MCASP2_REG_BASE	0x01D08000
-
-/* EDMA channels of dm644x and dm355 */
-#define DAVINCI_DMA_ASP0_TX	2
-#define DAVINCI_DMA_ASP0_RX	3
-#define DAVINCI_DMA_ASP1_TX	8
-#define DAVINCI_DMA_ASP1_RX	9
-
-/* EDMA channels of dm646x */
-#define DAVINCI_DM646X_DMA_MCASP0_AXEVT0	6
-#define DAVINCI_DM646X_DMA_MCASP0_AREVT0	9
-#define DAVINCI_DM646X_DMA_MCASP1_AXEVT1	12
-
-/* EDMA channels of da850/da830 McASP0 */
-#define DAVINCI_DA8XX_DMA_MCASP0_AREVT	0
-#define DAVINCI_DA8XX_DMA_MCASP0_AXEVT	1
-
-/* EDMA channels of da830 McASP1 */
-#define DAVINCI_DA830_DMA_MCASP1_AREVT	2
-#define DAVINCI_DA830_DMA_MCASP1_AXEVT	3
-
-/* EDMA channels of da830 McASP2 */
-#define DAVINCI_DA830_DMA_MCASP2_AREVT	4
-#define DAVINCI_DA830_DMA_MCASP2_AXEVT	5
-
-/* Interrupts */
-#define DAVINCI_ASP0_RX_INT	DAVINCI_INTC_IRQ(IRQ_MBRINT)
-#define DAVINCI_ASP0_TX_INT	DAVINCI_INTC_IRQ(IRQ_MBXINT)
-#define DAVINCI_ASP1_RX_INT	DAVINCI_INTC_IRQ(IRQ_MBRINT)
-#define DAVINCI_ASP1_TX_INT	DAVINCI_INTC_IRQ(IRQ_MBXINT)
-
-#endif /* __ASM_ARCH_DAVINCI_ASP_H */
diff --git a/arch/arm/mach-davinci/common.h b/arch/arm/mach-davinci/common.h
index 772b51e0ac5e..b4fd0e9acf6c 100644
--- a/arch/arm/mach-davinci/common.h
+++ b/arch/arm/mach-davinci/common.h
@@ -17,8 +17,8 @@
 
 #include <asm/irq.h>
 
-#define DAVINCI_INTC_START		NR_IRQS
-#define DAVINCI_INTC_IRQ(_irqnum)	(DAVINCI_INTC_START + (_irqnum))
+#define DAVINCI_INTC_START             NR_IRQS
+#define DAVINCI_INTC_IRQ(_irqnum)      (DAVINCI_INTC_START + (_irqnum))
 
 struct davinci_gpio_controller;
 
@@ -45,9 +45,6 @@ struct davinci_soc_info {
 	unsigned			gpio_num;
 	unsigned			gpio_irq;
 	unsigned			gpio_unbanked;
-	struct davinci_gpio_controller	*gpio_ctlrs;
-	int				gpio_ctlrs_num;
-	struct emac_platform_data	*emac_pdata;
 	dma_addr_t			sram_dma;
 	unsigned			sram_len;
 };
diff --git a/arch/arm/mach-davinci/cputype.h b/arch/arm/mach-davinci/cputype.h
index 87ee56068a16..148a738391dc 100644
--- a/arch/arm/mach-davinci/cputype.h
+++ b/arch/arm/mach-davinci/cputype.h
@@ -28,25 +28,4 @@ struct davinci_id {
 #define	DAVINCI_CPU_ID_DA830		0x08300000
 #define	DAVINCI_CPU_ID_DA850		0x08500000
 
-#define IS_DAVINCI_CPU(type, id)					\
-static inline int is_davinci_ ##type(void)				\
-{									\
-	return (davinci_soc_info.cpu_id == (id));			\
-}
-
-IS_DAVINCI_CPU(da830, DAVINCI_CPU_ID_DA830)
-IS_DAVINCI_CPU(da850, DAVINCI_CPU_ID_DA850)
-
-#ifdef CONFIG_ARCH_DAVINCI_DA830
-#define cpu_is_davinci_da830() is_davinci_da830()
-#else
-#define cpu_is_davinci_da830() 0
-#endif
-
-#ifdef CONFIG_ARCH_DAVINCI_DA850
-#define cpu_is_davinci_da850() is_davinci_da850()
-#else
-#define cpu_is_davinci_da850() 0
-#endif
-
 #endif
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index eab5fac18806..2e497745b624 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -12,7 +12,6 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/irqchip/irq-davinci-cp-intc.h>
-#include <linux/platform_data/gpio-davinci.h>
 
 #include <clocksource/timer-davinci.h>
 
@@ -448,181 +447,6 @@ static const struct mux_config da830_pins[] = {
 #endif
 };
 
-const short da830_emif25_pins[] __initconst = {
-	DA830_EMA_D_0, DA830_EMA_D_1, DA830_EMA_D_2, DA830_EMA_D_3,
-	DA830_EMA_D_4, DA830_EMA_D_5, DA830_EMA_D_6, DA830_EMA_D_7,
-	DA830_EMA_D_8, DA830_EMA_D_9, DA830_EMA_D_10, DA830_EMA_D_11,
-	DA830_EMA_D_12, DA830_EMA_D_13, DA830_EMA_D_14, DA830_EMA_D_15,
-	DA830_EMA_A_0, DA830_EMA_A_1, DA830_EMA_A_2, DA830_EMA_A_3,
-	DA830_EMA_A_4, DA830_EMA_A_5, DA830_EMA_A_6, DA830_EMA_A_7,
-	DA830_EMA_A_8, DA830_EMA_A_9, DA830_EMA_A_10, DA830_EMA_A_11,
-	DA830_EMA_A_12, DA830_EMA_BA_0, DA830_EMA_BA_1, DA830_EMA_CLK,
-	DA830_EMA_SDCKE, DA830_NEMA_CS_4, DA830_NEMA_CS_5, DA830_NEMA_WE,
-	DA830_NEMA_CS_0, DA830_NEMA_CS_2, DA830_NEMA_CS_3, DA830_NEMA_OE,
-	DA830_NEMA_WE_DQM_1, DA830_NEMA_WE_DQM_0, DA830_EMA_WAIT_0,
-	-1
-};
-
-const short da830_spi0_pins[] __initconst = {
-	DA830_SPI0_SOMI_0, DA830_SPI0_SIMO_0, DA830_SPI0_CLK, DA830_NSPI0_ENA,
-	DA830_NSPI0_SCS_0,
-	-1
-};
-
-const short da830_spi1_pins[] __initconst = {
-	DA830_SPI1_SOMI_0, DA830_SPI1_SIMO_0, DA830_SPI1_CLK, DA830_NSPI1_ENA,
-	DA830_NSPI1_SCS_0,
-	-1
-};
-
-const short da830_mmc_sd_pins[] __initconst = {
-	DA830_MMCSD_DAT_0, DA830_MMCSD_DAT_1, DA830_MMCSD_DAT_2,
-	DA830_MMCSD_DAT_3, DA830_MMCSD_DAT_4, DA830_MMCSD_DAT_5,
-	DA830_MMCSD_DAT_6, DA830_MMCSD_DAT_7, DA830_MMCSD_CLK,
-	DA830_MMCSD_CMD,
-	-1
-};
-
-const short da830_uart0_pins[] __initconst = {
-	DA830_NUART0_CTS, DA830_NUART0_RTS, DA830_UART0_RXD, DA830_UART0_TXD,
-	-1
-};
-
-const short da830_uart1_pins[] __initconst = {
-	DA830_UART1_RXD, DA830_UART1_TXD,
-	-1
-};
-
-const short da830_uart2_pins[] __initconst = {
-	DA830_UART2_RXD, DA830_UART2_TXD,
-	-1
-};
-
-const short da830_usb20_pins[] __initconst = {
-	DA830_USB0_DRVVBUS, DA830_USB_REFCLKIN,
-	-1
-};
-
-const short da830_usb11_pins[] __initconst = {
-	DA830_USB_REFCLKIN,
-	-1
-};
-
-const short da830_uhpi_pins[] __initconst = {
-	DA830_UHPI_HD_0, DA830_UHPI_HD_1, DA830_UHPI_HD_2, DA830_UHPI_HD_3,
-	DA830_UHPI_HD_4, DA830_UHPI_HD_5, DA830_UHPI_HD_6, DA830_UHPI_HD_7,
-	DA830_UHPI_HD_8, DA830_UHPI_HD_9, DA830_UHPI_HD_10, DA830_UHPI_HD_11,
-	DA830_UHPI_HD_12, DA830_UHPI_HD_13, DA830_UHPI_HD_14, DA830_UHPI_HD_15,
-	DA830_UHPI_HCNTL0, DA830_UHPI_HCNTL1, DA830_UHPI_HHWIL, DA830_UHPI_HRNW,
-	DA830_NUHPI_HAS, DA830_NUHPI_HCS, DA830_NUHPI_HDS1, DA830_NUHPI_HDS2,
-	DA830_NUHPI_HINT, DA830_NUHPI_HRDY,
-	-1
-};
-
-const short da830_cpgmac_pins[] __initconst = {
-	DA830_RMII_TXD_0, DA830_RMII_TXD_1, DA830_RMII_TXEN, DA830_RMII_CRS_DV,
-	DA830_RMII_RXD_0, DA830_RMII_RXD_1, DA830_RMII_RXER, DA830_MDIO_CLK,
-	DA830_MDIO_D,
-	-1
-};
-
-const short da830_emif3c_pins[] __initconst = {
-	DA830_EMB_SDCKE, DA830_EMB_CLK_GLUE, DA830_EMB_CLK, DA830_NEMB_CS_0,
-	DA830_NEMB_CAS, DA830_NEMB_RAS, DA830_NEMB_WE, DA830_EMB_BA_1,
-	DA830_EMB_BA_0, DA830_EMB_A_0, DA830_EMB_A_1, DA830_EMB_A_2,
-	DA830_EMB_A_3, DA830_EMB_A_4, DA830_EMB_A_5, DA830_EMB_A_6,
-	DA830_EMB_A_7, DA830_EMB_A_8, DA830_EMB_A_9, DA830_EMB_A_10,
-	DA830_EMB_A_11, DA830_EMB_A_12, DA830_NEMB_WE_DQM_3,
-	DA830_NEMB_WE_DQM_2, DA830_EMB_D_0, DA830_EMB_D_1, DA830_EMB_D_2,
-	DA830_EMB_D_3, DA830_EMB_D_4, DA830_EMB_D_5, DA830_EMB_D_6,
-	DA830_EMB_D_7, DA830_EMB_D_8, DA830_EMB_D_9, DA830_EMB_D_10,
-	DA830_EMB_D_11, DA830_EMB_D_12, DA830_EMB_D_13, DA830_EMB_D_14,
-	DA830_EMB_D_15, DA830_EMB_D_16, DA830_EMB_D_17, DA830_EMB_D_18,
-	DA830_EMB_D_19, DA830_EMB_D_20, DA830_EMB_D_21, DA830_EMB_D_22,
-	DA830_EMB_D_23, DA830_EMB_D_24, DA830_EMB_D_25, DA830_EMB_D_26,
-	DA830_EMB_D_27, DA830_EMB_D_28, DA830_EMB_D_29, DA830_EMB_D_30,
-	DA830_EMB_D_31, DA830_NEMB_WE_DQM_1, DA830_NEMB_WE_DQM_0,
-	-1
-};
-
-const short da830_mcasp0_pins[] __initconst = {
-	DA830_AHCLKX0, DA830_ACLKX0, DA830_AFSX0,
-	DA830_AHCLKR0, DA830_ACLKR0, DA830_AFSR0, DA830_AMUTE0,
-	DA830_AXR0_0, DA830_AXR0_1, DA830_AXR0_2, DA830_AXR0_3,
-	DA830_AXR0_4, DA830_AXR0_5, DA830_AXR0_6, DA830_AXR0_7,
-	DA830_AXR0_8, DA830_AXR0_9, DA830_AXR0_10, DA830_AXR0_11,
-	DA830_AXR0_12, DA830_AXR0_13, DA830_AXR0_14, DA830_AXR0_15,
-	-1
-};
-
-const short da830_mcasp1_pins[] __initconst = {
-	DA830_AHCLKX1, DA830_ACLKX1, DA830_AFSX1,
-	DA830_AHCLKR1, DA830_ACLKR1, DA830_AFSR1, DA830_AMUTE1,
-	DA830_AXR1_0, DA830_AXR1_1, DA830_AXR1_2, DA830_AXR1_3,
-	DA830_AXR1_4, DA830_AXR1_5, DA830_AXR1_6, DA830_AXR1_7,
-	DA830_AXR1_8, DA830_AXR1_9, DA830_AXR1_10, DA830_AXR1_11,
-	-1
-};
-
-const short da830_mcasp2_pins[] __initconst = {
-	DA830_AHCLKX2, DA830_ACLKX2, DA830_AFSX2,
-	DA830_AHCLKR2, DA830_ACLKR2, DA830_AFSR2, DA830_AMUTE2,
-	DA830_AXR2_0, DA830_AXR2_1, DA830_AXR2_2, DA830_AXR2_3,
-	-1
-};
-
-const short da830_i2c0_pins[] __initconst = {
-	DA830_I2C0_SDA, DA830_I2C0_SCL,
-	-1
-};
-
-const short da830_i2c1_pins[] __initconst = {
-	DA830_I2C1_SCL, DA830_I2C1_SDA,
-	-1
-};
-
-const short da830_lcdcntl_pins[] __initconst = {
-	DA830_LCD_D_0, DA830_LCD_D_1, DA830_LCD_D_2, DA830_LCD_D_3,
-	DA830_LCD_D_4, DA830_LCD_D_5, DA830_LCD_D_6, DA830_LCD_D_7,
-	DA830_LCD_D_8, DA830_LCD_D_9, DA830_LCD_D_10, DA830_LCD_D_11,
-	DA830_LCD_D_12, DA830_LCD_D_13, DA830_LCD_D_14, DA830_LCD_D_15,
-	DA830_LCD_PCLK, DA830_LCD_HSYNC, DA830_LCD_VSYNC, DA830_NLCD_AC_ENB_CS,
-	DA830_LCD_MCLK,
-	-1
-};
-
-const short da830_pwm_pins[] __initconst = {
-	DA830_ECAP0_APWM0, DA830_ECAP1_APWM1, DA830_EPWM0B, DA830_EPWM0A,
-	DA830_EPWMSYNCI, DA830_EPWMSYNC0, DA830_ECAP2_APWM2, DA830_EHRPWMGLUETZ,
-	DA830_EPWM2B, DA830_EPWM2A, DA830_EPWM1B, DA830_EPWM1A,
-	-1
-};
-
-const short da830_ecap0_pins[] __initconst = {
-	DA830_ECAP0_APWM0,
-	-1
-};
-
-const short da830_ecap1_pins[] __initconst = {
-	DA830_ECAP1_APWM1,
-	-1
-};
-
-const short da830_ecap2_pins[] __initconst = {
-	DA830_ECAP2_APWM2,
-	-1
-};
-
-const short da830_eqep0_pins[] __initconst = {
-	DA830_EQEP0I, DA830_EQEP0S, DA830_EQEP0A, DA830_EQEP0B,
-	-1
-};
-
-const short da830_eqep1_pins[] __initconst = {
-	DA830_EQEP1I, DA830_EQEP1S, DA830_EQEP1A, DA830_EQEP1B,
-	-1
-};
-
 static struct map_desc da830_io_desc[] = {
 	{
 		.virtual	= IO_VIRT,
@@ -663,30 +487,6 @@ static struct davinci_id da830_ids[] = {
 	},
 };
 
-static struct davinci_gpio_platform_data da830_gpio_platform_data = {
-	.no_auto_base	= true,
-	.base		= 0,
-	.ngpio		= 128,
-};
-
-int __init da830_register_gpio(void)
-{
-	return da8xx_register_gpio(&da830_gpio_platform_data);
-}
-
-/*
- * Bottom half of timer0 is used both for clock even and clocksource.
- * Top half is used by DSP.
- */
-static const struct davinci_timer_cfg da830_timer_cfg = {
-	.reg = DEFINE_RES_IO(DA8XX_TIMER64P0_BASE, SZ_4K),
-	.irq = {
-		DEFINE_RES_IRQ(DAVINCI_INTC_IRQ(IRQ_DA830_T12CMPINT0_0)),
-		DEFINE_RES_IRQ(DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT12_0)),
-	},
-	.cmp_off = DA830_CMP12_0,
-};
-
 static const struct davinci_soc_info davinci_soc_info_da830 = {
 	.io_desc		= da830_io_desc,
 	.io_desc_num		= ARRAY_SIZE(da830_io_desc),
@@ -696,7 +496,6 @@ static const struct davinci_soc_info davinci_soc_info_da830 = {
 	.pinmux_base		= DA8XX_SYSCFG0_BASE + 0x120,
 	.pinmux_pins		= da830_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(da830_pins),
-	.emac_pdata		= &da8xx_emac_pdata,
 };
 
 void __init da830_init(void)
@@ -706,76 +505,3 @@ void __init da830_init(void)
 	da8xx_syscfg0_base = ioremap(DA8XX_SYSCFG0_BASE, SZ_4K);
 	WARN(!da8xx_syscfg0_base, "Unable to map syscfg0 module");
 }
-
-static const struct davinci_cp_intc_config da830_cp_intc_config = {
-	.reg = {
-		.start		= DA8XX_CP_INTC_BASE,
-		.end		= DA8XX_CP_INTC_BASE + SZ_8K - 1,
-		.flags		= IORESOURCE_MEM,
-	},
-	.num_irqs		= DA830_N_CP_INTC_IRQ,
-};
-
-void __init da830_init_irq(void)
-{
-	davinci_cp_intc_init(&da830_cp_intc_config);
-}
-
-void __init da830_init_time(void)
-{
-	void __iomem *pll;
-	struct clk *clk;
-	int rv;
-
-	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DA830_REF_FREQ);
-
-	pll = ioremap(DA8XX_PLL0_BASE, SZ_4K);
-
-	da830_pll_init(NULL, pll, NULL);
-
-	clk = clk_get(NULL, "timer0");
-	if (WARN_ON(IS_ERR(clk))) {
-		pr_err("Unable to get the timer clock\n");
-		return;
-	}
-
-	rv = davinci_timer_register(clk, &da830_timer_cfg);
-	WARN(rv, "Unable to register the timer: %d\n", rv);
-}
-
-static struct resource da830_psc0_resources[] = {
-	{
-		.start	= DA8XX_PSC0_BASE,
-		.end	= DA8XX_PSC0_BASE + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device da830_psc0_device = {
-	.name		= "da830-psc0",
-	.id		= -1,
-	.resource	= da830_psc0_resources,
-	.num_resources	= ARRAY_SIZE(da830_psc0_resources),
-};
-
-static struct resource da830_psc1_resources[] = {
-	{
-		.start	= DA8XX_PSC1_BASE,
-		.end	= DA8XX_PSC1_BASE + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device da830_psc1_device = {
-	.name		= "da830-psc1",
-	.id		= -1,
-	.resource	= da830_psc1_resources,
-	.num_resources	= ARRAY_SIZE(da830_psc1_resources),
-};
-
-void __init da830_register_clocks(void)
-{
-	/* PLL is registered in da830_init_time() */
-	platform_device_register(&da830_psc0_device);
-	platform_device_register(&da830_psc1_device);
-}
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 635e88daf5dd..287dd987908e 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -10,19 +10,10 @@
  * 2009 (c) MontaVista Software, Inc.
  */
 
-#include <linux/clk-provider.h>
-#include <linux/clk/davinci.h>
-#include <linux/clkdev.h>
-#include <linux/cpufreq.h>
 #include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/io.h>
-#include <linux/irqchip/irq-davinci-cp-intc.h>
 #include <linux/mfd/da8xx-cfgchip.h>
-#include <linux/platform_data/clk-da8xx-cfgchip.h>
-#include <linux/platform_data/clk-davinci-pll.h>
-#include <linux/platform_data/davinci-cpufreq.h>
-#include <linux/platform_data/gpio-davinci.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
@@ -33,6 +24,7 @@
 #include "common.h"
 #include "cputype.h"
 #include "da8xx.h"
+#include "hardware.h"
 #include "pm.h"
 #include "irqs.h"
 #include "mux.h"
@@ -258,45 +250,6 @@ static const struct mux_config da850_pins[] = {
 #endif
 };
 
-const short da850_i2c0_pins[] __initconst = {
-	DA850_I2C0_SDA, DA850_I2C0_SCL,
-	-1
-};
-
-const short da850_i2c1_pins[] __initconst = {
-	DA850_I2C1_SCL, DA850_I2C1_SDA,
-	-1
-};
-
-const short da850_lcdcntl_pins[] __initconst = {
-	DA850_LCD_D_0, DA850_LCD_D_1, DA850_LCD_D_2, DA850_LCD_D_3,
-	DA850_LCD_D_4, DA850_LCD_D_5, DA850_LCD_D_6, DA850_LCD_D_7,
-	DA850_LCD_D_8, DA850_LCD_D_9, DA850_LCD_D_10, DA850_LCD_D_11,
-	DA850_LCD_D_12, DA850_LCD_D_13, DA850_LCD_D_14, DA850_LCD_D_15,
-	DA850_LCD_PCLK, DA850_LCD_HSYNC, DA850_LCD_VSYNC, DA850_NLCD_AC_ENB_CS,
-	-1
-};
-
-const short da850_vpif_capture_pins[] __initconst = {
-	DA850_VPIF_DIN0, DA850_VPIF_DIN1, DA850_VPIF_DIN2, DA850_VPIF_DIN3,
-	DA850_VPIF_DIN4, DA850_VPIF_DIN5, DA850_VPIF_DIN6, DA850_VPIF_DIN7,
-	DA850_VPIF_DIN8, DA850_VPIF_DIN9, DA850_VPIF_DIN10, DA850_VPIF_DIN11,
-	DA850_VPIF_DIN12, DA850_VPIF_DIN13, DA850_VPIF_DIN14, DA850_VPIF_DIN15,
-	DA850_VPIF_CLKIN0, DA850_VPIF_CLKIN1, DA850_VPIF_CLKIN2,
-	DA850_VPIF_CLKIN3,
-	-1
-};
-
-const short da850_vpif_display_pins[] __initconst = {
-	DA850_VPIF_DOUT0, DA850_VPIF_DOUT1, DA850_VPIF_DOUT2, DA850_VPIF_DOUT3,
-	DA850_VPIF_DOUT4, DA850_VPIF_DOUT5, DA850_VPIF_DOUT6, DA850_VPIF_DOUT7,
-	DA850_VPIF_DOUT8, DA850_VPIF_DOUT9, DA850_VPIF_DOUT10,
-	DA850_VPIF_DOUT11, DA850_VPIF_DOUT12, DA850_VPIF_DOUT13,
-	DA850_VPIF_DOUT14, DA850_VPIF_DOUT15, DA850_VPIF_CLKO2,
-	DA850_VPIF_CLKO3,
-	-1
-};
-
 static struct map_desc da850_io_desc[] = {
 	{
 		.virtual	= IO_VIRT,
@@ -330,204 +283,9 @@ static struct davinci_id da850_ids[] = {
 	},
 };
 
-/*
- * Bottom half of timer 0 is used for clock_event, top half for
- * clocksource.
- */
-static const struct davinci_timer_cfg da850_timer_cfg = {
-	.reg = DEFINE_RES_IO(DA8XX_TIMER64P0_BASE, SZ_4K),
-	.irq = {
-		DEFINE_RES_IRQ(DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT12_0)),
-		DEFINE_RES_IRQ(DAVINCI_INTC_IRQ(IRQ_DA8XX_TINT34_0)),
-	},
-};
-
-#ifdef CONFIG_CPU_FREQ
-/*
- * Notes:
- * According to the TRM, minimum PLLM results in maximum power savings.
- * The OPP definitions below should keep the PLLM as low as possible.
- *
- * The output of the PLLM must be between 300 to 600 MHz.
- */
-struct da850_opp {
-	unsigned int	freq;	/* in KHz */
-	unsigned int	prediv;
-	unsigned int	mult;
-	unsigned int	postdiv;
-	unsigned int	cvdd_min; /* in uV */
-	unsigned int	cvdd_max; /* in uV */
-};
-
-static const struct da850_opp da850_opp_456 = {
-	.freq		= 456000,
-	.prediv		= 1,
-	.mult		= 19,
-	.postdiv	= 1,
-	.cvdd_min	= 1300000,
-	.cvdd_max	= 1350000,
-};
-
-static const struct da850_opp da850_opp_408 = {
-	.freq		= 408000,
-	.prediv		= 1,
-	.mult		= 17,
-	.postdiv	= 1,
-	.cvdd_min	= 1300000,
-	.cvdd_max	= 1350000,
-};
-
-static const struct da850_opp da850_opp_372 = {
-	.freq		= 372000,
-	.prediv		= 2,
-	.mult		= 31,
-	.postdiv	= 1,
-	.cvdd_min	= 1200000,
-	.cvdd_max	= 1320000,
-};
-
-static const struct da850_opp da850_opp_300 = {
-	.freq		= 300000,
-	.prediv		= 1,
-	.mult		= 25,
-	.postdiv	= 2,
-	.cvdd_min	= 1200000,
-	.cvdd_max	= 1320000,
-};
-
-static const struct da850_opp da850_opp_200 = {
-	.freq		= 200000,
-	.prediv		= 1,
-	.mult		= 25,
-	.postdiv	= 3,
-	.cvdd_min	= 1100000,
-	.cvdd_max	= 1160000,
-};
-
-static const struct da850_opp da850_opp_96 = {
-	.freq		= 96000,
-	.prediv		= 1,
-	.mult		= 20,
-	.postdiv	= 5,
-	.cvdd_min	= 1000000,
-	.cvdd_max	= 1050000,
-};
-
-#define OPP(freq) 		\
-	{				\
-		.driver_data = (unsigned int) &da850_opp_##freq,	\
-		.frequency = freq * 1000, \
-	}
-
-static struct cpufreq_frequency_table da850_freq_table[] = {
-	OPP(456),
-	OPP(408),
-	OPP(372),
-	OPP(300),
-	OPP(200),
-	OPP(96),
-	{
-		.driver_data		= 0,
-		.frequency	= CPUFREQ_TABLE_END,
-	},
-};
-
-#ifdef CONFIG_REGULATOR
-static int da850_set_voltage(unsigned int index);
-static int da850_regulator_init(void);
-#endif
-
-static struct davinci_cpufreq_config cpufreq_info = {
-	.freq_table = da850_freq_table,
-#ifdef CONFIG_REGULATOR
-	.init = da850_regulator_init,
-	.set_voltage = da850_set_voltage,
-#endif
-};
-
-#ifdef CONFIG_REGULATOR
-static struct regulator *cvdd;
-
-static int da850_set_voltage(unsigned int index)
-{
-	struct da850_opp *opp;
-
-	if (!cvdd)
-		return -ENODEV;
-
-	opp = (struct da850_opp *) cpufreq_info.freq_table[index].driver_data;
-
-	return regulator_set_voltage(cvdd, opp->cvdd_min, opp->cvdd_max);
-}
-
-static int da850_regulator_init(void)
-{
-	cvdd = regulator_get(NULL, "cvdd");
-	if (WARN(IS_ERR(cvdd), "Unable to obtain voltage regulator for CVDD;"
-					" voltage scaling unsupported\n")) {
-		return PTR_ERR(cvdd);
-	}
-
-	return 0;
-}
-#endif
-
-static struct platform_device da850_cpufreq_device = {
-	.name			= "cpufreq-davinci",
-	.dev = {
-		.platform_data	= &cpufreq_info,
-	},
-	.id = -1,
-};
-
-unsigned int da850_max_speed = 300000;
-
-int da850_register_cpufreq(char *async_clk)
-{
-	int i;
-
-	/* cpufreq driver can help keep an "async" clock constant */
-	if (async_clk)
-		clk_add_alias("async", da850_cpufreq_device.name,
-							async_clk, NULL);
-	for (i = 0; i < ARRAY_SIZE(da850_freq_table); i++) {
-		if (da850_freq_table[i].frequency <= da850_max_speed) {
-			cpufreq_info.freq_table = &da850_freq_table[i];
-			break;
-		}
-	}
-
-	return platform_device_register(&da850_cpufreq_device);
-}
-#else
-int __init da850_register_cpufreq(char *async_clk)
-{
-	return 0;
-}
-#endif
-
 /* VPIF resource, platform data */
 static u64 da850_vpif_dma_mask = DMA_BIT_MASK(32);
 
-static struct resource da850_vpif_resource[] = {
-	{
-		.start = DA8XX_VPIF_BASE,
-		.end   = DA8XX_VPIF_BASE + 0xfff,
-		.flags = IORESOURCE_MEM,
-	}
-};
-
-static struct platform_device da850_vpif_dev = {
-	.name		= "vpif",
-	.id		= -1,
-	.dev		= {
-		.dma_mask		= &da850_vpif_dma_mask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.resource	= da850_vpif_resource,
-	.num_resources	= ARRAY_SIZE(da850_vpif_resource),
-};
-
 static struct resource da850_vpif_display_resource[] = {
 	{
 		.start = DAVINCI_INTC_IRQ(IRQ_DA850_VPIFINT),
@@ -571,11 +329,6 @@ static struct platform_device da850_vpif_capture_dev = {
 	.num_resources  = ARRAY_SIZE(da850_vpif_capture_resource),
 };
 
-int __init da850_register_vpif(void)
-{
-	return platform_device_register(&da850_vpif_dev);
-}
-
 int __init da850_register_vpif_display(struct vpif_display_config
 						*display_config)
 {
@@ -590,17 +343,6 @@ int __init da850_register_vpif_capture(struct vpif_capture_config
 	return platform_device_register(&da850_vpif_capture_dev);
 }
 
-static struct davinci_gpio_platform_data da850_gpio_platform_data = {
-	.no_auto_base	= true,
-	.base		= 0,
-	.ngpio		= 144,
-};
-
-int __init da850_register_gpio(void)
-{
-	return da8xx_register_gpio(&da850_gpio_platform_data);
-}
-
 static const struct davinci_soc_info davinci_soc_info_da850 = {
 	.io_desc		= da850_io_desc,
 	.io_desc_num		= ARRAY_SIZE(da850_io_desc),
@@ -610,7 +352,6 @@ static const struct davinci_soc_info davinci_soc_info_da850 = {
 	.pinmux_base		= DA8XX_SYSCFG0_BASE + 0x120,
 	.pinmux_pins		= da850_pins,
 	.pinmux_pins_num	= ARRAY_SIZE(da850_pins),
-	.emac_pdata		= &da8xx_emac_pdata,
 	.sram_dma		= DA8XX_SHARED_RAM_BASE,
 	.sram_len		= SZ_128K,
 };
@@ -626,142 +367,3 @@ void __init da850_init(void)
 	da8xx_syscfg1_base = ioremap(DA8XX_SYSCFG1_BASE, SZ_4K);
 	WARN(!da8xx_syscfg1_base, "Unable to map syscfg1 module");
 }
-
-static const struct davinci_cp_intc_config da850_cp_intc_config = {
-	.reg = {
-		.start		= DA8XX_CP_INTC_BASE,
-		.end		= DA8XX_CP_INTC_BASE + SZ_8K - 1,
-		.flags		= IORESOURCE_MEM,
-	},
-	.num_irqs		= DA850_N_CP_INTC_IRQ,
-};
-
-void __init da850_init_irq(void)
-{
-	davinci_cp_intc_init(&da850_cp_intc_config);
-}
-
-void __init da850_init_time(void)
-{
-	void __iomem *pll0;
-	struct regmap *cfgchip;
-	struct clk *clk;
-	int rv;
-
-	clk_register_fixed_rate(NULL, "ref_clk", NULL, 0, DA850_REF_FREQ);
-
-	pll0 = ioremap(DA8XX_PLL0_BASE, SZ_4K);
-	cfgchip = da8xx_get_cfgchip();
-
-	da850_pll0_init(NULL, pll0, cfgchip);
-
-	clk = clk_get(NULL, "timer0");
-	if (WARN_ON(IS_ERR(clk))) {
-		pr_err("Unable to get the timer clock\n");
-		return;
-	}
-
-	rv = davinci_timer_register(clk, &da850_timer_cfg);
-	WARN(rv, "Unable to register the timer: %d\n", rv);
-}
-
-static struct resource da850_pll1_resources[] = {
-	{
-		.start	= DA850_PLL1_BASE,
-		.end	= DA850_PLL1_BASE + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-static struct davinci_pll_platform_data da850_pll1_pdata;
-
-static struct platform_device da850_pll1_device = {
-	.name		= "da850-pll1",
-	.id		= -1,
-	.resource	= da850_pll1_resources,
-	.num_resources	= ARRAY_SIZE(da850_pll1_resources),
-	.dev		= {
-		.platform_data	= &da850_pll1_pdata,
-	},
-};
-
-static struct resource da850_psc0_resources[] = {
-	{
-		.start	= DA8XX_PSC0_BASE,
-		.end	= DA8XX_PSC0_BASE + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device da850_psc0_device = {
-	.name		= "da850-psc0",
-	.id		= -1,
-	.resource	= da850_psc0_resources,
-	.num_resources	= ARRAY_SIZE(da850_psc0_resources),
-};
-
-static struct resource da850_psc1_resources[] = {
-	{
-		.start	= DA8XX_PSC1_BASE,
-		.end	= DA8XX_PSC1_BASE + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device da850_psc1_device = {
-	.name		= "da850-psc1",
-	.id		= -1,
-	.resource	= da850_psc1_resources,
-	.num_resources	= ARRAY_SIZE(da850_psc1_resources),
-};
-
-static struct da8xx_cfgchip_clk_platform_data da850_async1_pdata;
-
-static struct platform_device da850_async1_clksrc_device = {
-	.name		= "da850-async1-clksrc",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= &da850_async1_pdata,
-	},
-};
-
-static struct da8xx_cfgchip_clk_platform_data da850_async3_pdata;
-
-static struct platform_device da850_async3_clksrc_device = {
-	.name		= "da850-async3-clksrc",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= &da850_async3_pdata,
-	},
-};
-
-static struct da8xx_cfgchip_clk_platform_data da850_tbclksync_pdata;
-
-static struct platform_device da850_tbclksync_device = {
-	.name		= "da830-tbclksync",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= &da850_tbclksync_pdata,
-	},
-};
-
-void __init da850_register_clocks(void)
-{
-	/* PLL0 is registered in da850_init_time() */
-
-	da850_pll1_pdata.cfgchip = da8xx_get_cfgchip();
-	platform_device_register(&da850_pll1_device);
-
-	da850_async1_pdata.cfgchip = da8xx_get_cfgchip();
-	platform_device_register(&da850_async1_clksrc_device);
-
-	da850_async3_pdata.cfgchip = da8xx_get_cfgchip();
-	platform_device_register(&da850_async3_clksrc_device);
-
-	platform_device_register(&da850_psc0_device);
-
-	platform_device_register(&da850_psc1_device);
-
-	da850_tbclksync_pdata.cfgchip = da8xx_get_cfgchip();
-	platform_device_register(&da850_tbclksync_device);
-}
diff --git a/arch/arm/mach-davinci/da8xx.h b/arch/arm/mach-davinci/da8xx.h
index 382811dbbc3b..54a255b8d8d8 100644
--- a/arch/arm/mach-davinci/da8xx.h
+++ b/arch/arm/mach-davinci/da8xx.h
@@ -9,38 +9,20 @@
 #ifndef __ASM_ARCH_DAVINCI_DA8XX_H
 #define __ASM_ARCH_DAVINCI_DA8XX_H
 
-#include <video/da8xx-fb.h>
-
+#include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
-#include <linux/davinci_emac.h>
-#include <linux/spi/spi.h>
-#include <linux/platform_data/davinci_asp.h>
+#include <linux/videodev2.h>
 #include <linux/reboot.h>
 #include <linux/regmap.h>
-#include <linux/videodev2.h>
 
-#include "serial.h"
+#include "hardware.h"
 #include "pm.h"
 
-#include <linux/platform_data/edma.h>
-#include <linux/platform_data/i2c-davinci.h>
-#include <linux/platform_data/mmc-davinci.h>
-#include <linux/platform_data/usb-davinci.h>
-#include <linux/platform_data/spi-davinci.h>
-#include <linux/platform_data/uio_pruss.h>
-
 #include <media/davinci/vpif_types.h>
 
 extern void __iomem *da8xx_syscfg0_base;
 extern void __iomem *da8xx_syscfg1_base;
 
-/*
- * If the DA850/OMAP-L138/AM18x SoC on board is of a higher speed grade
- * (than the regular 300MHz variant), the board code should set this up
- * with the supported speed before calling da850_register_cpufreq().
- */
-extern unsigned int da850_max_speed;
-
 /*
  * The cp_intc interrupt controller for the da8xx isn't in the same
  * chunk of physical memory space as the other registers (like it is
@@ -87,83 +69,14 @@ extern unsigned int da850_max_speed;
 #define DA8XX_ARM_RAM_BASE	0xffff0000
 
 void da830_init(void);
-void da830_init_irq(void);
-void da830_init_time(void);
-void da830_register_clocks(void);
 
 void da850_init(void);
-void da850_init_irq(void);
-void da850_init_time(void);
-void da850_register_clocks(void);
 
-int da830_register_edma(struct edma_rsv_info *rsv);
-int da850_register_edma(struct edma_rsv_info *rsv[2]);
-int da8xx_register_i2c(int instance, struct davinci_i2c_platform_data *pdata);
-int da8xx_register_spi_bus(int instance, unsigned num_chipselect);
-int da8xx_register_watchdog(void);
-int da8xx_register_usb_phy(void);
-int da8xx_register_usb20(unsigned mA, unsigned potpgt);
-int da8xx_register_usb11(struct da8xx_ohci_root_hub *pdata);
-int da8xx_register_usb_phy_clocks(void);
-int da850_register_sata_refclk(int rate);
-int da8xx_register_emac(void);
-int da8xx_register_uio_pruss(void);
-int da8xx_register_lcdc(struct da8xx_lcdc_platform_data *pdata);
-int da8xx_register_mmcsd0(struct davinci_mmc_config *config);
-int da850_register_mmcsd1(struct davinci_mmc_config *config);
-void da8xx_register_mcasp(int id, struct snd_platform_data *pdata);
-int da8xx_register_rtc(void);
-int da8xx_register_gpio(void *pdata);
-int da850_register_cpufreq(char *async_clk);
-int da8xx_register_cpuidle(void);
-void __iomem *da8xx_get_mem_ctlr(void);
-int da850_register_sata(unsigned long refclkpn);
-int da850_register_vpif(void);
 int da850_register_vpif_display
 			(struct vpif_display_config *display_config);
 int da850_register_vpif_capture
 			(struct vpif_capture_config *capture_config);
-void da8xx_rproc_reserve_cma(void);
-int da8xx_register_rproc(void);
-int da850_register_gpio(void);
-int da830_register_gpio(void);
 struct regmap *da8xx_get_cfgchip(void);
-
-extern struct platform_device da8xx_serial_device[];
-extern struct emac_platform_data da8xx_emac_pdata;
-extern struct da8xx_lcdc_platform_data sharp_lcd035q3dg01_pdata;
-extern struct da8xx_lcdc_platform_data sharp_lk043t1dg01_pdata;
-
-
-extern const short da830_emif25_pins[];
-extern const short da830_spi0_pins[];
-extern const short da830_spi1_pins[];
-extern const short da830_mmc_sd_pins[];
-extern const short da830_uart0_pins[];
-extern const short da830_uart1_pins[];
-extern const short da830_uart2_pins[];
-extern const short da830_usb20_pins[];
-extern const short da830_usb11_pins[];
-extern const short da830_uhpi_pins[];
-extern const short da830_cpgmac_pins[];
-extern const short da830_emif3c_pins[];
-extern const short da830_mcasp0_pins[];
-extern const short da830_mcasp1_pins[];
-extern const short da830_mcasp2_pins[];
-extern const short da830_i2c0_pins[];
-extern const short da830_i2c1_pins[];
-extern const short da830_lcdcntl_pins[];
-extern const short da830_pwm_pins[];
-extern const short da830_ecap0_pins[];
-extern const short da830_ecap1_pins[];
-extern const short da830_ecap2_pins[];
-extern const short da830_eqep0_pins[];
-extern const short da830_eqep1_pins[];
-extern const short da850_vpif_capture_pins[];
-extern const short da850_vpif_display_pins[];
-
-extern const short da850_i2c0_pins[];
-extern const short da850_i2c1_pins[];
-extern const short da850_lcdcntl_pins[];
+void __iomem *da8xx_get_mem_ctlr(void);
 
 #endif /* __ASM_ARCH_DAVINCI_DA8XX_H */
diff --git a/arch/arm/mach-davinci/davinci.h b/arch/arm/mach-davinci/davinci.h
deleted file mode 100644
index b7172797692b..000000000000
--- a/arch/arm/mach-davinci/davinci.h
+++ /dev/null
@@ -1,136 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * This file contains the processor specific definitions
- * of the TI DM644x, DM355, DM365, and DM646x.
- *
- * Copyright (C) 2011 Texas Instruments Incorporated
- * Copyright (c) 2007 Deep Root Systems, LLC
- */
-#ifndef __DAVINCI_H
-#define __DAVINCI_H
-
-#include <linux/clk.h>
-#include <linux/videodev2.h>
-#include <linux/davinci_emac.h>
-#include <linux/platform_device.h>
-#include <linux/spi/spi.h>
-#include <linux/platform_data/davinci_asp.h>
-#include <linux/platform_data/edma.h>
-#include <linux/platform_data/keyscan-davinci.h>
-
-#include "hardware.h"
-
-#include <media/davinci/vpfe_capture.h>
-#include <media/davinci/vpif_types.h>
-#include <media/davinci/vpss.h>
-#include <media/davinci/vpbe_types.h>
-#include <media/davinci/vpbe_venc.h>
-#include <media/davinci/vpbe.h>
-#include <media/davinci/vpbe_osd.h>
-
-#define DAVINCI_PLL1_BASE		0x01c40800
-#define DAVINCI_PLL2_BASE		0x01c40c00
-#define DAVINCI_PWR_SLEEP_CNTRL_BASE	0x01c41000
-
-#define DAVINCI_SYSTEM_MODULE_BASE	0x01c40000
-#define SYSMOD_VDAC_CONFIG		0x2c
-#define SYSMOD_VIDCLKCTL		0x38
-#define SYSMOD_VPSS_CLKCTL		0x44
-#define SYSMOD_VDD3P3VPWDN		0x48
-#define SYSMOD_VSCLKDIS			0x6c
-#define SYSMOD_PUPDCTL1			0x7c
-
-/* VPSS CLKCTL bit definitions */
-#define VPSS_MUXSEL_EXTCLK_ENABLE	BIT(1)
-#define VPSS_VENCCLKEN_ENABLE		BIT(3)
-#define VPSS_DACCLKEN_ENABLE		BIT(4)
-#define VPSS_PLLC2SYSCLK5_ENABLE	BIT(5)
-
-extern void __iomem *davinci_sysmod_base;
-#define DAVINCI_SYSMOD_VIRT(x)	(davinci_sysmod_base + (x))
-void davinci_map_sysmod(void);
-
-#define DAVINCI_GPIO_BASE 0x01C67000
-int davinci_gpio_register(struct resource *res, int size, void *pdata);
-
-#define DAVINCI_TIMER0_BASE		(IO_PHYS + 0x21400)
-#define DAVINCI_WDOG_BASE		(IO_PHYS + 0x21C00)
-
-/* DM355 base addresses */
-#define DM355_ASYNC_EMIF_CONTROL_BASE	0x01e10000
-#define DM355_ASYNC_EMIF_DATA_CE0_BASE	0x02000000
-
-#define ASP1_TX_EVT_EN	1
-#define ASP1_RX_EVT_EN	2
-
-/* DM365 base addresses */
-#define DM365_ASYNC_EMIF_CONTROL_BASE	0x01d10000
-#define DM365_ASYNC_EMIF_DATA_CE0_BASE	0x02000000
-#define DM365_ASYNC_EMIF_DATA_CE1_BASE	0x04000000
-
-/* DM644x base addresses */
-#define DM644X_ASYNC_EMIF_CONTROL_BASE	0x01e00000
-#define DM644X_ASYNC_EMIF_DATA_CE0_BASE 0x02000000
-#define DM644X_ASYNC_EMIF_DATA_CE1_BASE 0x04000000
-#define DM644X_ASYNC_EMIF_DATA_CE2_BASE 0x06000000
-#define DM644X_ASYNC_EMIF_DATA_CE3_BASE 0x08000000
-
-/* DM646x base addresses */
-#define DM646X_ASYNC_EMIF_CONTROL_BASE	0x20008000
-#define DM646X_ASYNC_EMIF_CS2_SPACE_BASE 0x42000000
-
-int davinci_init_wdt(void);
-
-/* DM355 function declarations */
-void dm355_init(void);
-void dm355_init_time(void);
-void dm355_init_irq(void);
-void dm355_register_clocks(void);
-void dm355_init_spi0(unsigned chipselect_mask,
-		const struct spi_board_info *info, unsigned len);
-void dm355_init_asp1(u32 evt_enable);
-int dm355_init_video(struct vpfe_config *, struct vpbe_config *);
-int dm355_gpio_register(void);
-
-/* DM365 function declarations */
-void dm365_init(void);
-void dm365_init_irq(void);
-void dm365_init_time(void);
-void dm365_register_clocks(void);
-void dm365_init_asp(void);
-void dm365_init_vc(void);
-void dm365_init_ks(struct davinci_ks_platform_data *pdata);
-void dm365_init_rtc(void);
-void dm365_init_spi0(unsigned chipselect_mask,
-			const struct spi_board_info *info, unsigned len);
-int dm365_init_video(struct vpfe_config *, struct vpbe_config *);
-int dm365_gpio_register(void);
-
-/* DM644x function declarations */
-void dm644x_init(void);
-void dm644x_init_irq(void);
-void dm644x_init_devices(void);
-void dm644x_init_time(void);
-void dm644x_register_clocks(void);
-void dm644x_init_asp(void);
-int dm644x_init_video(struct vpfe_config *, struct vpbe_config *);
-int dm644x_gpio_register(void);
-
-/* DM646x function declarations */
-void dm646x_init(void);
-void dm646x_init_irq(void);
-void dm646x_init_time(unsigned long ref_clk_rate, unsigned long aux_clkin_rate);
-void dm646x_register_clocks(void);
-void dm646x_init_mcasp0(struct snd_platform_data *pdata);
-void dm646x_init_mcasp1(struct snd_platform_data *pdata);
-int dm646x_init_edma(struct edma_rsv_info *rsv);
-void dm646x_video_init(void);
-void dm646x_setup_vpif(struct vpif_display_config *,
-		       struct vpif_capture_config *);
-int dm646x_gpio_register(void);
-
-extern struct platform_device dm365_serial_device[];
-extern struct platform_device dm355_serial_device[];
-extern struct platform_device dm644x_serial_device[];
-extern struct platform_device dm646x_serial_device[];
-#endif /*__DAVINCI_H */
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index ef9593558e5f..6939166c33c2 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -21,7 +21,6 @@
 #include "common.h"
 #include "cputype.h"
 #include "da8xx.h"
-#include "asp.h"
 #include "cpuidle.h"
 #include "irqs.h"
 #include "sram.h"
@@ -57,911 +56,6 @@
 void __iomem *da8xx_syscfg0_base;
 void __iomem *da8xx_syscfg1_base;
 
-static struct plat_serial8250_port da8xx_serial0_pdata[] = {
-	{
-		.mapbase	= DA8XX_UART0_BASE,
-		.irq		= DAVINCI_INTC_IRQ(IRQ_DA8XX_UARTINT0),
-		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
-					UPF_IOREMAP,
-		.iotype		= UPIO_MEM,
-		.regshift	= 2,
-	},
-	{
-		.flags	= 0,
-	}
-};
-static struct plat_serial8250_port da8xx_serial1_pdata[] = {
-	{
-		.mapbase	= DA8XX_UART1_BASE,
-		.irq		= DAVINCI_INTC_IRQ(IRQ_DA8XX_UARTINT1),
-		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
-					UPF_IOREMAP,
-		.iotype		= UPIO_MEM,
-		.regshift	= 2,
-	},
-	{
-		.flags	= 0,
-	}
-};
-static struct plat_serial8250_port da8xx_serial2_pdata[] = {
-	{
-		.mapbase	= DA8XX_UART2_BASE,
-		.irq		= DAVINCI_INTC_IRQ(IRQ_DA8XX_UARTINT2),
-		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST |
-					UPF_IOREMAP,
-		.iotype		= UPIO_MEM,
-		.regshift	= 2,
-	},
-	{
-		.flags	= 0,
-	}
-};
-
-struct platform_device da8xx_serial_device[] = {
-	{
-		.name	= "serial8250",
-		.id	= PLAT8250_DEV_PLATFORM,
-		.dev	= {
-			.platform_data	= da8xx_serial0_pdata,
-		}
-	},
-	{
-		.name	= "serial8250",
-		.id	= PLAT8250_DEV_PLATFORM1,
-		.dev	= {
-			.platform_data	= da8xx_serial1_pdata,
-		}
-	},
-	{
-		.name	= "serial8250",
-		.id	= PLAT8250_DEV_PLATFORM2,
-		.dev	= {
-			.platform_data	= da8xx_serial2_pdata,
-		}
-	},
-	{
-	}
-};
-
-static s8 da8xx_queue_priority_mapping[][2] = {
-	/* {event queue no, Priority} */
-	{0, 3},
-	{1, 7},
-	{-1, -1}
-};
-
-static s8 da850_queue_priority_mapping[][2] = {
-	/* {event queue no, Priority} */
-	{0, 3},
-	{-1, -1}
-};
-
-static struct edma_soc_info da8xx_edma0_pdata = {
-	.queue_priority_mapping	= da8xx_queue_priority_mapping,
-	.default_queue		= EVENTQ_1,
-};
-
-static struct edma_soc_info da850_edma1_pdata = {
-	.queue_priority_mapping	= da850_queue_priority_mapping,
-	.default_queue		= EVENTQ_0,
-};
-
-static struct resource da8xx_edma0_resources[] = {
-	{
-		.name	= "edma3_cc",
-		.start	= DA8XX_TPCC_BASE,
-		.end	= DA8XX_TPCC_BASE + SZ_32K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.name	= "edma3_tc0",
-		.start	= DA8XX_TPTC0_BASE,
-		.end	= DA8XX_TPTC0_BASE + SZ_1K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.name	= "edma3_tc1",
-		.start	= DA8XX_TPTC1_BASE,
-		.end	= DA8XX_TPTC1_BASE + SZ_1K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.name	= "edma3_ccint",
-		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_CCINT0),
-		.flags	= IORESOURCE_IRQ,
-	},
-	{
-		.name	= "edma3_ccerrint",
-		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_CCERRINT),
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct resource da850_edma1_resources[] = {
-	{
-		.name	= "edma3_cc",
-		.start	= DA850_TPCC1_BASE,
-		.end	= DA850_TPCC1_BASE + SZ_32K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.name	= "edma3_tc0",
-		.start	= DA850_TPTC2_BASE,
-		.end	= DA850_TPTC2_BASE + SZ_1K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.name	= "edma3_ccint",
-		.start	= DAVINCI_INTC_IRQ(IRQ_DA850_CCINT1),
-		.flags	= IORESOURCE_IRQ,
-	},
-	{
-		.name	= "edma3_ccerrint",
-		.start	= DAVINCI_INTC_IRQ(IRQ_DA850_CCERRINT1),
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static const struct platform_device_info da8xx_edma0_device __initconst = {
-	.name		= "edma",
-	.id		= 0,
-	.dma_mask	= DMA_BIT_MASK(32),
-	.res		= da8xx_edma0_resources,
-	.num_res	= ARRAY_SIZE(da8xx_edma0_resources),
-	.data		= &da8xx_edma0_pdata,
-	.size_data	= sizeof(da8xx_edma0_pdata),
-};
-
-static const struct platform_device_info da850_edma1_device __initconst = {
-	.name		= "edma",
-	.id		= 1,
-	.dma_mask	= DMA_BIT_MASK(32),
-	.res		= da850_edma1_resources,
-	.num_res	= ARRAY_SIZE(da850_edma1_resources),
-	.data		= &da850_edma1_pdata,
-	.size_data	= sizeof(da850_edma1_pdata),
-};
-
-static const struct dma_slave_map da830_edma_map[] = {
-	{ "davinci-mcasp.0", "rx", EDMA_FILTER_PARAM(0, 0) },
-	{ "davinci-mcasp.0", "tx", EDMA_FILTER_PARAM(0, 1) },
-	{ "davinci-mcasp.1", "rx", EDMA_FILTER_PARAM(0, 2) },
-	{ "davinci-mcasp.1", "tx", EDMA_FILTER_PARAM(0, 3) },
-	{ "davinci-mcasp.2", "rx", EDMA_FILTER_PARAM(0, 4) },
-	{ "davinci-mcasp.2", "tx", EDMA_FILTER_PARAM(0, 5) },
-	{ "spi_davinci.0", "rx", EDMA_FILTER_PARAM(0, 14) },
-	{ "spi_davinci.0", "tx", EDMA_FILTER_PARAM(0, 15) },
-	{ "da830-mmc.0", "rx", EDMA_FILTER_PARAM(0, 16) },
-	{ "da830-mmc.0", "tx", EDMA_FILTER_PARAM(0, 17) },
-	{ "spi_davinci.1", "rx", EDMA_FILTER_PARAM(0, 18) },
-	{ "spi_davinci.1", "tx", EDMA_FILTER_PARAM(0, 19) },
-};
-
-int __init da830_register_edma(struct edma_rsv_info *rsv)
-{
-	struct platform_device *edma_pdev;
-
-	da8xx_edma0_pdata.rsv = rsv;
-
-	da8xx_edma0_pdata.slave_map = da830_edma_map;
-	da8xx_edma0_pdata.slavecnt = ARRAY_SIZE(da830_edma_map);
-
-	edma_pdev = platform_device_register_full(&da8xx_edma0_device);
-	return PTR_ERR_OR_ZERO(edma_pdev);
-}
-
-static const struct dma_slave_map da850_edma0_map[] = {
-	{ "davinci-mcasp.0", "rx", EDMA_FILTER_PARAM(0, 0) },
-	{ "davinci-mcasp.0", "tx", EDMA_FILTER_PARAM(0, 1) },
-	{ "davinci-mcbsp.0", "rx", EDMA_FILTER_PARAM(0, 2) },
-	{ "davinci-mcbsp.0", "tx", EDMA_FILTER_PARAM(0, 3) },
-	{ "davinci-mcbsp.1", "rx", EDMA_FILTER_PARAM(0, 4) },
-	{ "davinci-mcbsp.1", "tx", EDMA_FILTER_PARAM(0, 5) },
-	{ "spi_davinci.0", "rx", EDMA_FILTER_PARAM(0, 14) },
-	{ "spi_davinci.0", "tx", EDMA_FILTER_PARAM(0, 15) },
-	{ "da830-mmc.0", "rx", EDMA_FILTER_PARAM(0, 16) },
-	{ "da830-mmc.0", "tx", EDMA_FILTER_PARAM(0, 17) },
-	{ "spi_davinci.1", "rx", EDMA_FILTER_PARAM(0, 18) },
-	{ "spi_davinci.1", "tx", EDMA_FILTER_PARAM(0, 19) },
-};
-
-static const struct dma_slave_map da850_edma1_map[] = {
-	{ "da830-mmc.1", "rx", EDMA_FILTER_PARAM(1, 28) },
-	{ "da830-mmc.1", "tx", EDMA_FILTER_PARAM(1, 29) },
-};
-
-int __init da850_register_edma(struct edma_rsv_info *rsv[2])
-{
-	struct platform_device *edma_pdev;
-
-	if (rsv) {
-		da8xx_edma0_pdata.rsv = rsv[0];
-		da850_edma1_pdata.rsv = rsv[1];
-	}
-
-	da8xx_edma0_pdata.slave_map = da850_edma0_map;
-	da8xx_edma0_pdata.slavecnt = ARRAY_SIZE(da850_edma0_map);
-
-	edma_pdev = platform_device_register_full(&da8xx_edma0_device);
-	if (IS_ERR(edma_pdev)) {
-		pr_warn("%s: Failed to register eDMA0\n", __func__);
-		return PTR_ERR(edma_pdev);
-	}
-
-	da850_edma1_pdata.slave_map = da850_edma1_map;
-	da850_edma1_pdata.slavecnt = ARRAY_SIZE(da850_edma1_map);
-
-	edma_pdev = platform_device_register_full(&da850_edma1_device);
-	return PTR_ERR_OR_ZERO(edma_pdev);
-}
-
-static struct resource da8xx_i2c_resources0[] = {
-	{
-		.start	= DA8XX_I2C0_BASE,
-		.end	= DA8XX_I2C0_BASE + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_I2CINT0),
-		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_I2CINT0),
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device da8xx_i2c_device0 = {
-	.name		= "i2c_davinci",
-	.id		= 1,
-	.num_resources	= ARRAY_SIZE(da8xx_i2c_resources0),
-	.resource	= da8xx_i2c_resources0,
-};
-
-static struct resource da8xx_i2c_resources1[] = {
-	{
-		.start	= DA8XX_I2C1_BASE,
-		.end	= DA8XX_I2C1_BASE + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_I2CINT1),
-		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_I2CINT1),
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device da8xx_i2c_device1 = {
-	.name		= "i2c_davinci",
-	.id		= 2,
-	.num_resources	= ARRAY_SIZE(da8xx_i2c_resources1),
-	.resource	= da8xx_i2c_resources1,
-};
-
-int __init da8xx_register_i2c(int instance,
-		struct davinci_i2c_platform_data *pdata)
-{
-	struct platform_device *pdev;
-
-	if (instance == 0)
-		pdev = &da8xx_i2c_device0;
-	else if (instance == 1)
-		pdev = &da8xx_i2c_device1;
-	else
-		return -EINVAL;
-
-	pdev->dev.platform_data = pdata;
-	return platform_device_register(pdev);
-}
-
-static struct resource da8xx_watchdog_resources[] = {
-	{
-		.start	= DA8XX_WDOG_BASE,
-		.end	= DA8XX_WDOG_BASE + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device da8xx_wdt_device = {
-	.name		= "davinci-wdt",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(da8xx_watchdog_resources),
-	.resource	= da8xx_watchdog_resources,
-};
-
-int __init da8xx_register_watchdog(void)
-{
-	return platform_device_register(&da8xx_wdt_device);
-}
-
-static struct resource da8xx_emac_resources[] = {
-	{
-		.start	= DA8XX_EMAC_CPPI_PORT_BASE,
-		.end	= DA8XX_EMAC_CPPI_PORT_BASE + SZ_16K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_C0_RX_THRESH_PULSE),
-		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_C0_RX_THRESH_PULSE),
-		.flags	= IORESOURCE_IRQ,
-	},
-	{
-		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_C0_RX_PULSE),
-		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_C0_RX_PULSE),
-		.flags	= IORESOURCE_IRQ,
-	},
-	{
-		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_C0_TX_PULSE),
-		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_C0_TX_PULSE),
-		.flags	= IORESOURCE_IRQ,
-	},
-	{
-		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_C0_MISC_PULSE),
-		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_C0_MISC_PULSE),
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct emac_platform_data da8xx_emac_pdata = {
-	.ctrl_reg_offset	= DA8XX_EMAC_CTRL_REG_OFFSET,
-	.ctrl_mod_reg_offset	= DA8XX_EMAC_MOD_REG_OFFSET,
-	.ctrl_ram_offset	= DA8XX_EMAC_RAM_OFFSET,
-	.ctrl_ram_size		= DA8XX_EMAC_CTRL_RAM_SIZE,
-	.version		= EMAC_VERSION_2,
-};
-
-static struct platform_device da8xx_emac_device = {
-	.name		= "davinci_emac",
-	.id		= 1,
-	.dev = {
-		.platform_data	= &da8xx_emac_pdata,
-	},
-	.num_resources	= ARRAY_SIZE(da8xx_emac_resources),
-	.resource	= da8xx_emac_resources,
-};
-
-static struct resource da8xx_mdio_resources[] = {
-	{
-		.start	= DA8XX_EMAC_MDIO_BASE,
-		.end	= DA8XX_EMAC_MDIO_BASE + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device da8xx_mdio_device = {
-	.name		= "davinci_mdio",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(da8xx_mdio_resources),
-	.resource	= da8xx_mdio_resources,
-};
-
-int __init da8xx_register_emac(void)
-{
-	int ret;
-
-	ret = platform_device_register(&da8xx_mdio_device);
-	if (ret < 0)
-		return ret;
-
-	return platform_device_register(&da8xx_emac_device);
-}
-
-static struct resource da830_mcasp1_resources[] = {
-	{
-		.name	= "mpu",
-		.start	= DAVINCI_DA830_MCASP1_REG_BASE,
-		.end	= DAVINCI_DA830_MCASP1_REG_BASE + (SZ_1K * 12) - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	/* TX event */
-	{
-		.name	= "tx",
-		.start	= DAVINCI_DA830_DMA_MCASP1_AXEVT,
-		.end	= DAVINCI_DA830_DMA_MCASP1_AXEVT,
-		.flags	= IORESOURCE_DMA,
-	},
-	/* RX event */
-	{
-		.name	= "rx",
-		.start	= DAVINCI_DA830_DMA_MCASP1_AREVT,
-		.end	= DAVINCI_DA830_DMA_MCASP1_AREVT,
-		.flags	= IORESOURCE_DMA,
-	},
-	{
-		.name	= "common",
-		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_MCASPINT),
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device da830_mcasp1_device = {
-	.name		= "davinci-mcasp",
-	.id		= 1,
-	.num_resources	= ARRAY_SIZE(da830_mcasp1_resources),
-	.resource	= da830_mcasp1_resources,
-};
-
-static struct resource da830_mcasp2_resources[] = {
-	{
-		.name	= "mpu",
-		.start	= DAVINCI_DA830_MCASP2_REG_BASE,
-		.end	= DAVINCI_DA830_MCASP2_REG_BASE + (SZ_1K * 12) - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	/* TX event */
-	{
-		.name	= "tx",
-		.start	= DAVINCI_DA830_DMA_MCASP2_AXEVT,
-		.end	= DAVINCI_DA830_DMA_MCASP2_AXEVT,
-		.flags	= IORESOURCE_DMA,
-	},
-	/* RX event */
-	{
-		.name	= "rx",
-		.start	= DAVINCI_DA830_DMA_MCASP2_AREVT,
-		.end	= DAVINCI_DA830_DMA_MCASP2_AREVT,
-		.flags	= IORESOURCE_DMA,
-	},
-	{
-		.name	= "common",
-		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_MCASPINT),
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device da830_mcasp2_device = {
-	.name		= "davinci-mcasp",
-	.id		= 2,
-	.num_resources	= ARRAY_SIZE(da830_mcasp2_resources),
-	.resource	= da830_mcasp2_resources,
-};
-
-static struct resource da850_mcasp_resources[] = {
-	{
-		.name	= "mpu",
-		.start	= DAVINCI_DA8XX_MCASP0_REG_BASE,
-		.end	= DAVINCI_DA8XX_MCASP0_REG_BASE + (SZ_1K * 12) - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	/* TX event */
-	{
-		.name	= "tx",
-		.start	= DAVINCI_DA8XX_DMA_MCASP0_AXEVT,
-		.end	= DAVINCI_DA8XX_DMA_MCASP0_AXEVT,
-		.flags	= IORESOURCE_DMA,
-	},
-	/* RX event */
-	{
-		.name	= "rx",
-		.start	= DAVINCI_DA8XX_DMA_MCASP0_AREVT,
-		.end	= DAVINCI_DA8XX_DMA_MCASP0_AREVT,
-		.flags	= IORESOURCE_DMA,
-	},
-	{
-		.name	= "common",
-		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_MCASPINT),
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device da850_mcasp_device = {
-	.name		= "davinci-mcasp",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(da850_mcasp_resources),
-	.resource	= da850_mcasp_resources,
-};
-
-void __init da8xx_register_mcasp(int id, struct snd_platform_data *pdata)
-{
-	struct platform_device *pdev;
-
-	switch (id) {
-	case 0:
-		/* Valid for DA830/OMAP-L137 or DA850/OMAP-L138 */
-		pdev = &da850_mcasp_device;
-		break;
-	case 1:
-		/* Valid for DA830/OMAP-L137 only */
-		if (!cpu_is_davinci_da830())
-			return;
-		pdev = &da830_mcasp1_device;
-		break;
-	case 2:
-		/* Valid for DA830/OMAP-L137 only */
-		if (!cpu_is_davinci_da830())
-			return;
-		pdev = &da830_mcasp2_device;
-		break;
-	default:
-		return;
-	}
-
-	pdev->dev.platform_data = pdata;
-	platform_device_register(pdev);
-}
-
-static struct resource da8xx_pruss_resources[] = {
-	{
-		.start	= DA8XX_PRUSS_MEM_BASE,
-		.end	= DA8XX_PRUSS_MEM_BASE + 0xFFFF,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_EVTOUT0),
-		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_EVTOUT0),
-		.flags	= IORESOURCE_IRQ,
-	},
-	{
-		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_EVTOUT1),
-		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_EVTOUT1),
-		.flags	= IORESOURCE_IRQ,
-	},
-	{
-		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_EVTOUT2),
-		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_EVTOUT2),
-		.flags	= IORESOURCE_IRQ,
-	},
-	{
-		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_EVTOUT3),
-		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_EVTOUT3),
-		.flags	= IORESOURCE_IRQ,
-	},
-	{
-		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_EVTOUT4),
-		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_EVTOUT4),
-		.flags	= IORESOURCE_IRQ,
-	},
-	{
-		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_EVTOUT5),
-		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_EVTOUT5),
-		.flags	= IORESOURCE_IRQ,
-	},
-	{
-		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_EVTOUT6),
-		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_EVTOUT6),
-		.flags	= IORESOURCE_IRQ,
-	},
-	{
-		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_EVTOUT7),
-		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_EVTOUT7),
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct uio_pruss_pdata da8xx_uio_pruss_pdata = {
-	.pintc_base	= 0x4000,
-};
-
-static struct platform_device da8xx_uio_pruss_dev = {
-	.name		= "pruss_uio",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(da8xx_pruss_resources),
-	.resource	= da8xx_pruss_resources,
-	.dev		= {
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-		.platform_data		= &da8xx_uio_pruss_pdata,
-	}
-};
-
-int __init da8xx_register_uio_pruss(void)
-{
-	da8xx_uio_pruss_pdata.sram_pool = sram_get_gen_pool();
-	return platform_device_register(&da8xx_uio_pruss_dev);
-}
-
-static struct lcd_ctrl_config lcd_cfg = {
-	.panel_shade		= COLOR_ACTIVE,
-	.bpp			= 16,
-};
-
-struct da8xx_lcdc_platform_data sharp_lcd035q3dg01_pdata = {
-	.manu_name		= "sharp",
-	.controller_data	= &lcd_cfg,
-	.type			= "Sharp_LCD035Q3DG01",
-};
-
-struct da8xx_lcdc_platform_data sharp_lk043t1dg01_pdata = {
-	.manu_name		= "sharp",
-	.controller_data	= &lcd_cfg,
-	.type			= "Sharp_LK043T1DG01",
-};
-
-static struct resource da8xx_lcdc_resources[] = {
-	[0] = { /* registers */
-		.start  = DA8XX_LCD_CNTRL_BASE,
-		.end    = DA8XX_LCD_CNTRL_BASE + SZ_4K - 1,
-		.flags  = IORESOURCE_MEM,
-	},
-	[1] = { /* interrupt */
-		.start  = DAVINCI_INTC_IRQ(IRQ_DA8XX_LCDINT),
-		.end    = DAVINCI_INTC_IRQ(IRQ_DA8XX_LCDINT),
-		.flags  = IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device da8xx_lcdc_device = {
-	.name		= "da8xx_lcdc",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(da8xx_lcdc_resources),
-	.resource	= da8xx_lcdc_resources,
-	.dev		= {
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	}
-};
-
-int __init da8xx_register_lcdc(struct da8xx_lcdc_platform_data *pdata)
-{
-	da8xx_lcdc_device.dev.platform_data = pdata;
-	return platform_device_register(&da8xx_lcdc_device);
-}
-
-static struct resource da8xx_gpio_resources[] = {
-	{ /* registers */
-		.start	= DA8XX_GPIO_BASE,
-		.end	= DA8XX_GPIO_BASE + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{ /* interrupt */
-		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_GPIO0),
-		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_GPIO0),
-		.flags	= IORESOURCE_IRQ,
-	},
-	{
-		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_GPIO1),
-		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_GPIO1),
-		.flags	= IORESOURCE_IRQ,
-	},
-	{
-		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_GPIO2),
-		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_GPIO2),
-		.flags	= IORESOURCE_IRQ,
-	},
-	{
-		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_GPIO3),
-		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_GPIO3),
-		.flags	= IORESOURCE_IRQ,
-	},
-	{
-		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_GPIO4),
-		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_GPIO4),
-		.flags	= IORESOURCE_IRQ,
-	},
-	{
-		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_GPIO5),
-		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_GPIO5),
-		.flags	= IORESOURCE_IRQ,
-	},
-	{
-		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_GPIO6),
-		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_GPIO6),
-		.flags	= IORESOURCE_IRQ,
-	},
-	{
-		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_GPIO7),
-		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_GPIO7),
-		.flags	= IORESOURCE_IRQ,
-	},
-	{
-		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_GPIO8),
-		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_GPIO8),
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device da8xx_gpio_device = {
-	.name		= "davinci_gpio",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(da8xx_gpio_resources),
-	.resource	= da8xx_gpio_resources,
-};
-
-int __init da8xx_register_gpio(void *pdata)
-{
-	da8xx_gpio_device.dev.platform_data = pdata;
-	return platform_device_register(&da8xx_gpio_device);
-}
-
-static struct resource da8xx_mmcsd0_resources[] = {
-	{		/* registers */
-		.start	= DA8XX_MMCSD0_BASE,
-		.end	= DA8XX_MMCSD0_BASE + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{		/* interrupt */
-		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_MMCSDINT0),
-		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_MMCSDINT0),
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device da8xx_mmcsd0_device = {
-	.name		= "da830-mmc",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(da8xx_mmcsd0_resources),
-	.resource	= da8xx_mmcsd0_resources,
-};
-
-int __init da8xx_register_mmcsd0(struct davinci_mmc_config *config)
-{
-	da8xx_mmcsd0_device.dev.platform_data = config;
-	return platform_device_register(&da8xx_mmcsd0_device);
-}
-
-#ifdef CONFIG_ARCH_DAVINCI_DA850
-static struct resource da850_mmcsd1_resources[] = {
-	{		/* registers */
-		.start	= DA850_MMCSD1_BASE,
-		.end	= DA850_MMCSD1_BASE + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{		/* interrupt */
-		.start	= DAVINCI_INTC_IRQ(IRQ_DA850_MMCSDINT0_1),
-		.end	= DAVINCI_INTC_IRQ(IRQ_DA850_MMCSDINT0_1),
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device da850_mmcsd1_device = {
-	.name		= "da830-mmc",
-	.id		= 1,
-	.num_resources	= ARRAY_SIZE(da850_mmcsd1_resources),
-	.resource	= da850_mmcsd1_resources,
-};
-
-int __init da850_register_mmcsd1(struct davinci_mmc_config *config)
-{
-	da850_mmcsd1_device.dev.platform_data = config;
-	return platform_device_register(&da850_mmcsd1_device);
-}
-#endif
-
-static struct resource da8xx_rproc_resources[] = {
-	{ /* DSP boot address */
-		.name		= "host1cfg",
-		.start		= DA8XX_SYSCFG0_BASE + DA8XX_HOST1CFG_REG,
-		.end		= DA8XX_SYSCFG0_BASE + DA8XX_HOST1CFG_REG + 3,
-		.flags		= IORESOURCE_MEM,
-	},
-	{ /* DSP interrupt registers */
-		.name		= "chipsig",
-		.start		= DA8XX_SYSCFG0_BASE + DA8XX_CHIPSIG_REG,
-		.end		= DA8XX_SYSCFG0_BASE + DA8XX_CHIPSIG_REG + 7,
-		.flags		= IORESOURCE_MEM,
-	},
-	{ /* DSP L2 RAM */
-		.name		= "l2sram",
-		.start		= DA8XX_DSP_L2_RAM_BASE,
-		.end		= DA8XX_DSP_L2_RAM_BASE + SZ_256K - 1,
-		.flags		= IORESOURCE_MEM,
-	},
-	{ /* DSP L1P RAM */
-		.name		= "l1pram",
-		.start		= DA8XX_DSP_L1P_RAM_BASE,
-		.end		= DA8XX_DSP_L1P_RAM_BASE + SZ_32K - 1,
-		.flags		= IORESOURCE_MEM,
-	},
-	{ /* DSP L1D RAM */
-		.name		= "l1dram",
-		.start		= DA8XX_DSP_L1D_RAM_BASE,
-		.end		= DA8XX_DSP_L1D_RAM_BASE + SZ_32K - 1,
-		.flags		= IORESOURCE_MEM,
-	},
-	{ /* dsp irq */
-		.start		= DAVINCI_INTC_IRQ(IRQ_DA8XX_CHIPINT0),
-		.end		= DAVINCI_INTC_IRQ(IRQ_DA8XX_CHIPINT0),
-		.flags		= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device da8xx_dsp = {
-	.name	= "davinci-rproc",
-	.dev	= {
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.num_resources	= ARRAY_SIZE(da8xx_rproc_resources),
-	.resource	= da8xx_rproc_resources,
-};
-
-static bool rproc_mem_inited __initdata;
-
-#if IS_ENABLED(CONFIG_DA8XX_REMOTEPROC)
-
-static phys_addr_t rproc_base __initdata;
-static unsigned long rproc_size __initdata;
-
-static int __init early_rproc_mem(char *p)
-{
-	char *endp;
-
-	if (p == NULL)
-		return 0;
-
-	rproc_size = memparse(p, &endp);
-	if (*endp == '@')
-		rproc_base = memparse(endp + 1, NULL);
-
-	return 0;
-}
-early_param("rproc_mem", early_rproc_mem);
-
-void __init da8xx_rproc_reserve_cma(void)
-{
-	struct cma *cma;
-	int ret;
-
-	if (!rproc_base || !rproc_size) {
-		pr_err("%s: 'rproc_mem=nn@address' badly specified\n"
-		       "    'nn' and 'address' must both be non-zero\n",
-		       __func__);
-
-		return;
-	}
-
-	pr_info("%s: reserving 0x%lx @ 0x%lx...\n",
-		__func__, rproc_size, (unsigned long)rproc_base);
-
-	ret = dma_contiguous_reserve_area(rproc_size, rproc_base, 0, &cma,
-			true);
-	if (ret) {
-		pr_err("%s: dma_contiguous_reserve_area failed %d\n",
-			__func__, ret);
-		return;
-	}
-	da8xx_dsp.dev.cma_area = cma;
-	rproc_mem_inited = true;
-}
-#else
-
-void __init da8xx_rproc_reserve_cma(void)
-{
-}
-
-#endif
-
-int __init da8xx_register_rproc(void)
-{
-	int ret;
-
-	if (!rproc_mem_inited) {
-		pr_warn("%s: memory not reserved for DSP, not registering DSP device\n",
-			__func__);
-		return -ENOMEM;
-	}
-
-	ret = platform_device_register(&da8xx_dsp);
-	if (ret)
-		pr_err("%s: can't register DSP device: %d\n", __func__, ret);
-
-	return ret;
-};
-
-static struct resource da8xx_rtc_resources[] = {
-	{
-		.start		= DA8XX_RTC_BASE,
-		.end		= DA8XX_RTC_BASE + SZ_4K - 1,
-		.flags		= IORESOURCE_MEM,
-	},
-	{ /* timer irq */
-		.start		= DAVINCI_INTC_IRQ(IRQ_DA8XX_RTC),
-		.end		= DAVINCI_INTC_IRQ(IRQ_DA8XX_RTC),
-		.flags		= IORESOURCE_IRQ,
-	},
-	{ /* alarm irq */
-		.start		= DAVINCI_INTC_IRQ(IRQ_DA8XX_RTC),
-		.end		= DAVINCI_INTC_IRQ(IRQ_DA8XX_RTC),
-		.flags		= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device da8xx_rtc_device = {
-	.name           = "da830-rtc",
-	.id             = -1,
-	.num_resources	= ARRAY_SIZE(da8xx_rtc_resources),
-	.resource	= da8xx_rtc_resources,
-};
-
-int da8xx_register_rtc(void)
-{
-	return platform_device_register(&da8xx_rtc_device);
-}
-
 static void __iomem *da8xx_ddr2_ctlr_base;
 void __iomem * __init da8xx_get_mem_ctlr(void)
 {
@@ -974,192 +68,3 @@ void __iomem * __init da8xx_get_mem_ctlr(void)
 
 	return da8xx_ddr2_ctlr_base;
 }
-
-static struct resource da8xx_cpuidle_resources[] = {
-	{
-		.start		= DA8XX_DDR2_CTL_BASE,
-		.end		= DA8XX_DDR2_CTL_BASE + SZ_32K - 1,
-		.flags		= IORESOURCE_MEM,
-	},
-};
-
-/* DA8XX devices support DDR2 power down */
-static struct davinci_cpuidle_config da8xx_cpuidle_pdata = {
-	.ddr2_pdown	= 1,
-};
-
-
-static struct platform_device da8xx_cpuidle_device = {
-	.name			= "cpuidle-davinci",
-	.num_resources		= ARRAY_SIZE(da8xx_cpuidle_resources),
-	.resource		= da8xx_cpuidle_resources,
-	.dev = {
-		.platform_data	= &da8xx_cpuidle_pdata,
-	},
-};
-
-int __init da8xx_register_cpuidle(void)
-{
-	da8xx_cpuidle_pdata.ddr2_ctlr_base = da8xx_get_mem_ctlr();
-
-	return platform_device_register(&da8xx_cpuidle_device);
-}
-
-static struct resource da8xx_spi0_resources[] = {
-	[0] = {
-		.start	= DA8XX_SPI0_BASE,
-		.end	= DA8XX_SPI0_BASE + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_SPINT0),
-		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_SPINT0),
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct resource da8xx_spi1_resources[] = {
-	[0] = {
-		.start	= DA830_SPI1_BASE,
-		.end	= DA830_SPI1_BASE + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_SPINT1),
-		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_SPINT1),
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct davinci_spi_platform_data da8xx_spi_pdata[] = {
-	[0] = {
-		.version	= SPI_VERSION_2,
-		.intr_line	= 1,
-		.dma_event_q	= EVENTQ_0,
-		.prescaler_limit = 2,
-	},
-	[1] = {
-		.version	= SPI_VERSION_2,
-		.intr_line	= 1,
-		.dma_event_q	= EVENTQ_0,
-		.prescaler_limit = 2,
-	},
-};
-
-static struct platform_device da8xx_spi_device[] = {
-	[0] = {
-		.name		= "spi_davinci",
-		.id		= 0,
-		.num_resources	= ARRAY_SIZE(da8xx_spi0_resources),
-		.resource	= da8xx_spi0_resources,
-		.dev		= {
-			.platform_data = &da8xx_spi_pdata[0],
-		},
-	},
-	[1] = {
-		.name		= "spi_davinci",
-		.id		= 1,
-		.num_resources	= ARRAY_SIZE(da8xx_spi1_resources),
-		.resource	= da8xx_spi1_resources,
-		.dev		= {
-			.platform_data = &da8xx_spi_pdata[1],
-		},
-	},
-};
-
-int __init da8xx_register_spi_bus(int instance, unsigned num_chipselect)
-{
-	if (instance < 0 || instance > 1)
-		return -EINVAL;
-
-	da8xx_spi_pdata[instance].num_chipselect = num_chipselect;
-
-	if (instance == 1 && cpu_is_davinci_da850()) {
-		da8xx_spi1_resources[0].start = DA850_SPI1_BASE;
-		da8xx_spi1_resources[0].end = DA850_SPI1_BASE + SZ_4K - 1;
-	}
-
-	return platform_device_register(&da8xx_spi_device[instance]);
-}
-
-#ifdef CONFIG_ARCH_DAVINCI_DA850
-int __init da850_register_sata_refclk(int rate)
-{
-	struct clk *clk;
-
-	clk = clk_register_fixed_rate(NULL, "sata_refclk", NULL, 0, rate);
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
-
-	return clk_register_clkdev(clk, "refclk", "ahci_da850");
-}
-
-static struct resource da850_sata_resources[] = {
-	{
-		.start	= DA850_SATA_BASE,
-		.end	= DA850_SATA_BASE + 0x1fff,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= DA8XX_SYSCFG1_BASE + DA8XX_PWRDN_REG,
-		.end	= DA8XX_SYSCFG1_BASE + DA8XX_PWRDN_REG + 0x3,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= DAVINCI_INTC_IRQ(IRQ_DA850_SATAINT),
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static u64 da850_sata_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device da850_sata_device = {
-	.name	= "ahci_da850",
-	.id	= -1,
-	.dev	= {
-		.dma_mask		= &da850_sata_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.num_resources	= ARRAY_SIZE(da850_sata_resources),
-	.resource	= da850_sata_resources,
-};
-
-int __init da850_register_sata(unsigned long refclkpn)
-{
-	int ret;
-
-	ret = da850_register_sata_refclk(refclkpn);
-	if (ret)
-		return ret;
-
-	return platform_device_register(&da850_sata_device);
-}
-#endif
-
-static struct regmap *da8xx_cfgchip;
-
-static const struct regmap_config da8xx_cfgchip_config __initconst = {
-	.name		= "cfgchip",
-	.reg_bits	= 32,
-	.val_bits	= 32,
-	.reg_stride	= 4,
-	.max_register	= DA8XX_CFGCHIP4_REG - DA8XX_CFGCHIP0_REG,
-};
-
-/**
- * da8xx_get_cfgchip - Lazy gets CFGCHIP as regmap
- *
- * This is for use on non-DT boards only. For DT boards, use
- * syscon_regmap_lookup_by_compatible("ti,da830-cfgchip")
- *
- * Returns: Pointer to the CFGCHIP regmap or negative error code.
- */
-struct regmap * __init da8xx_get_cfgchip(void)
-{
-	if (IS_ERR_OR_NULL(da8xx_cfgchip))
-		da8xx_cfgchip = regmap_init_mmio(NULL,
-					DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP0_REG),
-					&da8xx_cfgchip_config);
-
-	return da8xx_cfgchip;
-}
diff --git a/arch/arm/mach-davinci/irqs.h b/arch/arm/mach-davinci/irqs.h
index 8f9fc7a56ce8..b1ceed81e9fa 100644
--- a/arch/arm/mach-davinci/irqs.h
+++ b/arch/arm/mach-davinci/irqs.h
@@ -27,219 +27,6 @@
 #ifndef __ASM_ARCH_IRQS_H
 #define __ASM_ARCH_IRQS_H
 
-/* Base address */
-#define DAVINCI_ARM_INTC_BASE 0x01C48000
-
-/* Interrupt lines */
-#define IRQ_VDINT0       0
-#define IRQ_VDINT1       1
-#define IRQ_VDINT2       2
-#define IRQ_HISTINT      3
-#define IRQ_H3AINT       4
-#define IRQ_PRVUINT      5
-#define IRQ_RSZINT       6
-#define IRQ_VFOCINT      7
-#define IRQ_VENCINT      8
-#define IRQ_ASQINT       9
-#define IRQ_IMXINT       10
-#define IRQ_VLCDINT      11
-#define IRQ_USBINT       12
-#define IRQ_EMACINT      13
-
-#define IRQ_CCINT0       16
-#define IRQ_CCERRINT     17
-#define IRQ_TCERRINT0    18
-#define IRQ_TCERRINT     19
-#define IRQ_PSCIN        20
-
-#define IRQ_IDE          22
-#define IRQ_HPIINT       23
-#define IRQ_MBXINT       24
-#define IRQ_MBRINT       25
-#define IRQ_MMCINT       26
-#define IRQ_SDIOINT      27
-#define IRQ_MSINT        28
-#define IRQ_DDRINT       29
-#define IRQ_AEMIFINT     30
-#define IRQ_VLQINT       31
-#define IRQ_TINT0_TINT12 32
-#define IRQ_TINT0_TINT34 33
-#define IRQ_TINT1_TINT12 34
-#define IRQ_TINT1_TINT34 35
-#define IRQ_PWMINT0      36
-#define IRQ_PWMINT1      37
-#define IRQ_PWMINT2      38
-#define IRQ_I2C          39
-#define IRQ_UARTINT0     40
-#define IRQ_UARTINT1     41
-#define IRQ_UARTINT2     42
-#define IRQ_SPINT0       43
-#define IRQ_SPINT1       44
-
-#define IRQ_DSP2ARM0     46
-#define IRQ_DSP2ARM1     47
-#define IRQ_GPIO0        48
-#define IRQ_GPIO1        49
-#define IRQ_GPIO2        50
-#define IRQ_GPIO3        51
-#define IRQ_GPIO4        52
-#define IRQ_GPIO5        53
-#define IRQ_GPIO6        54
-#define IRQ_GPIO7        55
-#define IRQ_GPIOBNK0     56
-#define IRQ_GPIOBNK1     57
-#define IRQ_GPIOBNK2     58
-#define IRQ_GPIOBNK3     59
-#define IRQ_GPIOBNK4     60
-#define IRQ_COMMTX       61
-#define IRQ_COMMRX       62
-#define IRQ_EMUINT       63
-
-#define DAVINCI_N_AINTC_IRQ	64
-
-#define ARCH_TIMER_IRQ IRQ_TINT1_TINT34
-
-/* DaVinci DM6467-specific Interrupts */
-#define IRQ_DM646X_VP_VERTINT0  0
-#define IRQ_DM646X_VP_VERTINT1  1
-#define IRQ_DM646X_VP_VERTINT2  2
-#define IRQ_DM646X_VP_VERTINT3  3
-#define IRQ_DM646X_VP_ERRINT    4
-#define IRQ_DM646X_RESERVED_1   5
-#define IRQ_DM646X_RESERVED_2   6
-#define IRQ_DM646X_WDINT        7
-#define IRQ_DM646X_CRGENINT0    8
-#define IRQ_DM646X_CRGENINT1    9
-#define IRQ_DM646X_TSIFINT0     10
-#define IRQ_DM646X_TSIFINT1     11
-#define IRQ_DM646X_VDCEINT      12
-#define IRQ_DM646X_USBINT       13
-#define IRQ_DM646X_USBDMAINT    14
-#define IRQ_DM646X_PCIINT       15
-#define IRQ_DM646X_TCERRINT2    20
-#define IRQ_DM646X_TCERRINT3    21
-#define IRQ_DM646X_IDE          22
-#define IRQ_DM646X_HPIINT       23
-#define IRQ_DM646X_EMACRXTHINT  24
-#define IRQ_DM646X_EMACRXINT    25
-#define IRQ_DM646X_EMACTXINT    26
-#define IRQ_DM646X_EMACMISCINT  27
-#define IRQ_DM646X_MCASP0TXINT  28
-#define IRQ_DM646X_MCASP0RXINT  29
-#define IRQ_DM646X_MCASP1TXINT  30
-#define IRQ_DM646X_RESERVED_3   31
-#define IRQ_DM646X_VLQINT       38
-#define IRQ_DM646X_UARTINT2     42
-#define IRQ_DM646X_SPINT0       43
-#define IRQ_DM646X_SPINT1       44
-#define IRQ_DM646X_DSP2ARMINT   45
-#define IRQ_DM646X_RESERVED_4   46
-#define IRQ_DM646X_PSCINT       47
-#define IRQ_DM646X_GPIO0        48
-#define IRQ_DM646X_GPIO1        49
-#define IRQ_DM646X_GPIO2        50
-#define IRQ_DM646X_GPIO3        51
-#define IRQ_DM646X_GPIO4        52
-#define IRQ_DM646X_GPIO5        53
-#define IRQ_DM646X_GPIO6        54
-#define IRQ_DM646X_GPIO7        55
-#define IRQ_DM646X_GPIOBNK0     56
-#define IRQ_DM646X_GPIOBNK1     57
-#define IRQ_DM646X_GPIOBNK2     58
-#define IRQ_DM646X_DDRINT       59
-#define IRQ_DM646X_AEMIFINT     60
-
-/* DaVinci DM355-specific Interrupts */
-#define IRQ_DM355_CCDC_VDINT0	0
-#define IRQ_DM355_CCDC_VDINT1	1
-#define IRQ_DM355_CCDC_VDINT2	2
-#define IRQ_DM355_IPIPE_HST	3
-#define IRQ_DM355_H3AINT	4
-#define IRQ_DM355_IPIPE_SDR	5
-#define IRQ_DM355_IPIPEIFINT	6
-#define IRQ_DM355_OSDINT	7
-#define IRQ_DM355_VENCINT	8
-#define IRQ_DM355_IMCOPINT	11
-#define IRQ_DM355_RTOINT	13
-#define IRQ_DM355_TINT4		13
-#define IRQ_DM355_TINT2_TINT12	13
-#define IRQ_DM355_UARTINT2	14
-#define IRQ_DM355_TINT5		14
-#define IRQ_DM355_TINT2_TINT34	14
-#define IRQ_DM355_TINT6		15
-#define IRQ_DM355_TINT3_TINT12	15
-#define IRQ_DM355_SPINT1_0	17
-#define IRQ_DM355_SPINT1_1	18
-#define IRQ_DM355_SPINT2_0	19
-#define IRQ_DM355_SPINT2_1	21
-#define IRQ_DM355_TINT7		22
-#define IRQ_DM355_TINT3_TINT34	22
-#define IRQ_DM355_SDIOINT0	23
-#define IRQ_DM355_MMCINT0	26
-#define IRQ_DM355_MSINT		26
-#define IRQ_DM355_MMCINT1	27
-#define IRQ_DM355_PWMINT3	28
-#define IRQ_DM355_SDIOINT1	31
-#define IRQ_DM355_SPINT0_0	42
-#define IRQ_DM355_SPINT0_1	43
-#define IRQ_DM355_GPIO0		44
-#define IRQ_DM355_GPIO1		45
-#define IRQ_DM355_GPIO2		46
-#define IRQ_DM355_GPIO3		47
-#define IRQ_DM355_GPIO4		48
-#define IRQ_DM355_GPIO5		49
-#define IRQ_DM355_GPIO6		50
-#define IRQ_DM355_GPIO7		51
-#define IRQ_DM355_GPIO8		52
-#define IRQ_DM355_GPIO9		53
-#define IRQ_DM355_GPIOBNK0	54
-#define IRQ_DM355_GPIOBNK1	55
-#define IRQ_DM355_GPIOBNK2	56
-#define IRQ_DM355_GPIOBNK3	57
-#define IRQ_DM355_GPIOBNK4	58
-#define IRQ_DM355_GPIOBNK5	59
-#define IRQ_DM355_GPIOBNK6	60
-
-/* DaVinci DM365-specific Interrupts */
-#define IRQ_DM365_INSFINT	7
-#define IRQ_DM365_IMXINT1	8
-#define IRQ_DM365_IMXINT0	10
-#define IRQ_DM365_KLD_ARMINT	10
-#define IRQ_DM365_IMCOPINT	11
-#define IRQ_DM365_RTOINT	13
-#define IRQ_DM365_TINT5		14
-#define IRQ_DM365_TINT6		15
-#define IRQ_DM365_SPINT2_1	21
-#define IRQ_DM365_TINT7		22
-#define IRQ_DM365_SDIOINT0	23
-#define IRQ_DM365_MMCINT1	27
-#define IRQ_DM365_PWMINT3	28
-#define IRQ_DM365_RTCINT	29
-#define IRQ_DM365_SDIOINT1	31
-#define IRQ_DM365_SPIINT0_0	42
-#define IRQ_DM365_SPIINT3_0	43
-#define IRQ_DM365_GPIO0		44
-#define IRQ_DM365_GPIO1		45
-#define IRQ_DM365_GPIO2		46
-#define IRQ_DM365_GPIO3		47
-#define IRQ_DM365_GPIO4		48
-#define IRQ_DM365_GPIO5		49
-#define IRQ_DM365_GPIO6		50
-#define IRQ_DM365_GPIO7		51
-#define IRQ_DM365_EMAC_RXTHRESH	52
-#define IRQ_DM365_EMAC_RXPULSE	53
-#define IRQ_DM365_EMAC_TXPULSE	54
-#define IRQ_DM365_EMAC_MISCPULSE 55
-#define IRQ_DM365_GPIO12	56
-#define IRQ_DM365_GPIO13	57
-#define IRQ_DM365_GPIO14	58
-#define IRQ_DM365_GPIO15	59
-#define IRQ_DM365_ADCINT	59
-#define IRQ_DM365_KEYINT	60
-#define IRQ_DM365_TCERRINT2	61
-#define IRQ_DM365_TCERRINT3	62
-#define IRQ_DM365_EMUINT	63
-
 /* DA8XX interrupts */
 #define IRQ_DA8XX_COMMTX		0
 #define IRQ_DA8XX_COMMRX		1
@@ -398,8 +185,4 @@
 
 #define DA850_N_CP_INTC_IRQ		101
 
-/* da850 currently has the most gpio pins (144) */
-#define DAVINCI_N_GPIO			144
-/* da850 currently has the most irqs so use DA850_N_CP_INTC_IRQ */
-
 #endif /* __ASM_ARCH_IRQS_H */
diff --git a/arch/arm/mach-davinci/mux.c b/arch/arm/mach-davinci/mux.c
index 814a6b714010..37de35eb6e8b 100644
--- a/arch/arm/mach-davinci/mux.c
+++ b/arch/arm/mach-davinci/mux.c
@@ -97,18 +97,3 @@ int davinci_cfg_reg(const unsigned long index)
 
 	return 0;
 }
-EXPORT_SYMBOL(davinci_cfg_reg);
-
-int davinci_cfg_reg_list(const short pins[])
-{
-	int i, error = -EINVAL;
-
-	if (pins)
-		for (i = 0; pins[i] >= 0; i++) {
-			error = davinci_cfg_reg(pins[i]);
-			if (error)
-				break;
-		}
-
-	return error;
-}
diff --git a/arch/arm/mach-davinci/mux.h b/arch/arm/mach-davinci/mux.h
index b5effe16402c..38f0e427291e 100644
--- a/arch/arm/mach-davinci/mux.h
+++ b/arch/arm/mach-davinci/mux.h
@@ -21,321 +21,6 @@ struct mux_config {
 	bool debug;
 };
 
-enum davinci_dm644x_index {
-	/* ATA and HDDIR functions */
-	DM644X_HDIREN,
-	DM644X_ATAEN,
-	DM644X_ATAEN_DISABLE,
-
-	/* HPI functions */
-	DM644X_HPIEN_DISABLE,
-
-	/* AEAW functions */
-	DM644X_AEAW,
-	DM644X_AEAW0,
-	DM644X_AEAW1,
-	DM644X_AEAW2,
-	DM644X_AEAW3,
-	DM644X_AEAW4,
-
-	/* Memory Stick */
-	DM644X_MSTK,
-
-	/* I2C */
-	DM644X_I2C,
-
-	/* ASP function */
-	DM644X_MCBSP,
-
-	/* UART1 */
-	DM644X_UART1,
-
-	/* UART2 */
-	DM644X_UART2,
-
-	/* PWM0 */
-	DM644X_PWM0,
-
-	/* PWM1 */
-	DM644X_PWM1,
-
-	/* PWM2 */
-	DM644X_PWM2,
-
-	/* VLYNQ function */
-	DM644X_VLYNQEN,
-	DM644X_VLSCREN,
-	DM644X_VLYNQWD,
-
-	/* EMAC and MDIO function */
-	DM644X_EMACEN,
-
-	/* GPIO3V[0:16] pins */
-	DM644X_GPIO3V,
-
-	/* GPIO pins */
-	DM644X_GPIO0,
-	DM644X_GPIO3,
-	DM644X_GPIO43_44,
-	DM644X_GPIO46_47,
-
-	/* VPBE */
-	DM644X_RGB666,
-
-	/* LCD */
-	DM644X_LOEEN,
-	DM644X_LFLDEN,
-};
-
-enum davinci_dm646x_index {
-	/* ATA function */
-	DM646X_ATAEN,
-
-	/* AUDIO Clock */
-	DM646X_AUDCK1,
-	DM646X_AUDCK0,
-
-	/* CRGEN Control */
-	DM646X_CRGMUX,
-
-	/* VPIF Control */
-	DM646X_STSOMUX_DISABLE,
-	DM646X_STSIMUX_DISABLE,
-	DM646X_PTSOMUX_DISABLE,
-	DM646X_PTSIMUX_DISABLE,
-
-	/* TSIF Control */
-	DM646X_STSOMUX,
-	DM646X_STSIMUX,
-	DM646X_PTSOMUX_PARALLEL,
-	DM646X_PTSIMUX_PARALLEL,
-	DM646X_PTSOMUX_SERIAL,
-	DM646X_PTSIMUX_SERIAL,
-};
-
-enum davinci_dm355_index {
-	/* MMC/SD 0 */
-	DM355_MMCSD0,
-
-	/* MMC/SD 1 */
-	DM355_SD1_CLK,
-	DM355_SD1_CMD,
-	DM355_SD1_DATA3,
-	DM355_SD1_DATA2,
-	DM355_SD1_DATA1,
-	DM355_SD1_DATA0,
-
-	/* I2C */
-	DM355_I2C_SDA,
-	DM355_I2C_SCL,
-
-	/* ASP0 function */
-	DM355_MCBSP0_BDX,
-	DM355_MCBSP0_X,
-	DM355_MCBSP0_BFSX,
-	DM355_MCBSP0_BDR,
-	DM355_MCBSP0_R,
-	DM355_MCBSP0_BFSR,
-
-	/* SPI0 */
-	DM355_SPI0_SDI,
-	DM355_SPI0_SDENA0,
-	DM355_SPI0_SDENA1,
-
-	/* IRQ muxing */
-	DM355_INT_EDMA_CC,
-	DM355_INT_EDMA_TC0_ERR,
-	DM355_INT_EDMA_TC1_ERR,
-
-	/* EDMA event muxing */
-	DM355_EVT8_ASP1_TX,
-	DM355_EVT9_ASP1_RX,
-	DM355_EVT26_MMC0_RX,
-
-	/* Video Out */
-	DM355_VOUT_FIELD,
-	DM355_VOUT_FIELD_G70,
-	DM355_VOUT_HVSYNC,
-	DM355_VOUT_COUTL_EN,
-	DM355_VOUT_COUTH_EN,
-
-	/* Video In Pin Mux */
-	DM355_VIN_PCLK,
-	DM355_VIN_CAM_WEN,
-	DM355_VIN_CAM_VD,
-	DM355_VIN_CAM_HD,
-	DM355_VIN_YIN_EN,
-	DM355_VIN_CINL_EN,
-	DM355_VIN_CINH_EN,
-};
-
-enum davinci_dm365_index {
-	/* MMC/SD 0 */
-	DM365_MMCSD0,
-
-	/* MMC/SD 1 */
-	DM365_SD1_CLK,
-	DM365_SD1_CMD,
-	DM365_SD1_DATA3,
-	DM365_SD1_DATA2,
-	DM365_SD1_DATA1,
-	DM365_SD1_DATA0,
-
-	/* I2C */
-	DM365_I2C_SDA,
-	DM365_I2C_SCL,
-
-	/* AEMIF */
-	DM365_AEMIF_AR_A14,
-	DM365_AEMIF_AR_BA0,
-	DM365_AEMIF_A3,
-	DM365_AEMIF_A7,
-	DM365_AEMIF_D15_8,
-	DM365_AEMIF_CE0,
-	DM365_AEMIF_CE1,
-	DM365_AEMIF_WE_OE,
-
-	/* ASP0 function */
-	DM365_MCBSP0_BDX,
-	DM365_MCBSP0_X,
-	DM365_MCBSP0_BFSX,
-	DM365_MCBSP0_BDR,
-	DM365_MCBSP0_R,
-	DM365_MCBSP0_BFSR,
-
-	/* SPI0 */
-	DM365_SPI0_SCLK,
-	DM365_SPI0_SDI,
-	DM365_SPI0_SDO,
-	DM365_SPI0_SDENA0,
-	DM365_SPI0_SDENA1,
-
-	/* UART */
-	DM365_UART0_RXD,
-	DM365_UART0_TXD,
-	DM365_UART1_RXD,
-	DM365_UART1_TXD,
-	DM365_UART1_RTS,
-	DM365_UART1_CTS,
-
-	/* EMAC */
-	DM365_EMAC_TX_EN,
-	DM365_EMAC_TX_CLK,
-	DM365_EMAC_COL,
-	DM365_EMAC_TXD3,
-	DM365_EMAC_TXD2,
-	DM365_EMAC_TXD1,
-	DM365_EMAC_TXD0,
-	DM365_EMAC_RXD3,
-	DM365_EMAC_RXD2,
-	DM365_EMAC_RXD1,
-	DM365_EMAC_RXD0,
-	DM365_EMAC_RX_CLK,
-	DM365_EMAC_RX_DV,
-	DM365_EMAC_RX_ER,
-	DM365_EMAC_CRS,
-	DM365_EMAC_MDIO,
-	DM365_EMAC_MDCLK,
-
-	/* Key Scan */
-	DM365_KEYSCAN,
-
-	/* PWM */
-	DM365_PWM0,
-	DM365_PWM0_G23,
-	DM365_PWM1,
-	DM365_PWM1_G25,
-	DM365_PWM2_G87,
-	DM365_PWM2_G88,
-	DM365_PWM2_G89,
-	DM365_PWM2_G90,
-	DM365_PWM3_G80,
-	DM365_PWM3_G81,
-	DM365_PWM3_G85,
-	DM365_PWM3_G86,
-
-	/* SPI1 */
-	DM365_SPI1_SCLK,
-	DM365_SPI1_SDO,
-	DM365_SPI1_SDI,
-	DM365_SPI1_SDENA0,
-	DM365_SPI1_SDENA1,
-
-	/* SPI2 */
-	DM365_SPI2_SCLK,
-	DM365_SPI2_SDO,
-	DM365_SPI2_SDI,
-	DM365_SPI2_SDENA0,
-	DM365_SPI2_SDENA1,
-
-	/* SPI3 */
-	DM365_SPI3_SCLK,
-	DM365_SPI3_SDO,
-	DM365_SPI3_SDI,
-	DM365_SPI3_SDENA0,
-	DM365_SPI3_SDENA1,
-
-	/* SPI4 */
-	DM365_SPI4_SCLK,
-	DM365_SPI4_SDO,
-	DM365_SPI4_SDI,
-	DM365_SPI4_SDENA0,
-	DM365_SPI4_SDENA1,
-
-	/* Clock */
-	DM365_CLKOUT0,
-	DM365_CLKOUT1,
-	DM365_CLKOUT2,
-
-	/* GPIO */
-	DM365_GPIO20,
-	DM365_GPIO30,
-	DM365_GPIO31,
-	DM365_GPIO32,
-	DM365_GPIO33,
-	DM365_GPIO40,
-	DM365_GPIO64_57,
-
-	/* Video */
-	DM365_VOUT_FIELD,
-	DM365_VOUT_FIELD_G81,
-	DM365_VOUT_HVSYNC,
-	DM365_VOUT_COUTL_EN,
-	DM365_VOUT_COUTH_EN,
-	DM365_VIN_CAM_WEN,
-	DM365_VIN_CAM_VD,
-	DM365_VIN_CAM_HD,
-	DM365_VIN_YIN4_7_EN,
-	DM365_VIN_YIN0_3_EN,
-
-	/* IRQ muxing */
-	DM365_INT_EDMA_CC,
-	DM365_INT_EDMA_TC0_ERR,
-	DM365_INT_EDMA_TC1_ERR,
-	DM365_INT_EDMA_TC2_ERR,
-	DM365_INT_EDMA_TC3_ERR,
-	DM365_INT_PRTCSS,
-	DM365_INT_EMAC_RXTHRESH,
-	DM365_INT_EMAC_RXPULSE,
-	DM365_INT_EMAC_TXPULSE,
-	DM365_INT_EMAC_MISCPULSE,
-	DM365_INT_IMX0_ENABLE,
-	DM365_INT_IMX0_DISABLE,
-	DM365_INT_HDVICP_ENABLE,
-	DM365_INT_HDVICP_DISABLE,
-	DM365_INT_IMX1_ENABLE,
-	DM365_INT_IMX1_DISABLE,
-	DM365_INT_NSF_ENABLE,
-	DM365_INT_NSF_DISABLE,
-
-	/* EDMA event muxing */
-	DM365_EVT2_ASP_TX,
-	DM365_EVT3_ASP_RX,
-	DM365_EVT2_VC_TX,
-	DM365_EVT3_VC_RX,
-	DM365_EVT26_MMC0_RX,
-};
-
 enum da830_index {
 	DA830_GPIO7_14,
 	DA830_RTCK,
diff --git a/arch/arm/mach-davinci/psc.h b/arch/arm/mach-davinci/psc.h
index 68cd9d3fc82b..acfef063295f 100644
--- a/arch/arm/mach-davinci/psc.h
+++ b/arch/arm/mach-davinci/psc.h
@@ -70,70 +70,6 @@
 #define DAVINCI_LPSC_GEM		39
 #define DAVINCI_LPSC_IMCOP		40
 
-#define DM355_LPSC_TIMER3		5
-#define DM355_LPSC_SPI1			6
-#define DM355_LPSC_MMC_SD1		7
-#define DM355_LPSC_McBSP1		8
-#define DM355_LPSC_PWM3			10
-#define DM355_LPSC_SPI2			11
-#define DM355_LPSC_RTO			12
-#define DM355_LPSC_VPSS_DAC		41
-
-/* DM365 */
-#define DM365_LPSC_TIMER3	5
-#define DM365_LPSC_SPI1		6
-#define DM365_LPSC_MMC_SD1	7
-#define DM365_LPSC_McBSP1	8
-#define DM365_LPSC_PWM3		10
-#define DM365_LPSC_SPI2		11
-#define DM365_LPSC_RTO		12
-#define DM365_LPSC_TIMER4	17
-#define DM365_LPSC_SPI0		22
-#define DM365_LPSC_SPI3		38
-#define DM365_LPSC_SPI4		39
-#define DM365_LPSC_EMAC		40
-#define DM365_LPSC_VOICE_CODEC	44
-#define DM365_LPSC_DAC_CLK	46
-#define DM365_LPSC_VPSSMSTR	47
-#define DM365_LPSC_MJCP		50
-
-/*
- * LPSC Assignments
- */
-#define DM646X_LPSC_ARM		0
-#define DM646X_LPSC_C64X_CPU	1
-#define DM646X_LPSC_HDVICP0	2
-#define DM646X_LPSC_HDVICP1	3
-#define DM646X_LPSC_TPCC	4
-#define DM646X_LPSC_TPTC0	5
-#define DM646X_LPSC_TPTC1	6
-#define DM646X_LPSC_TPTC2	7
-#define DM646X_LPSC_TPTC3	8
-#define DM646X_LPSC_PCI		13
-#define DM646X_LPSC_EMAC	14
-#define DM646X_LPSC_VDCE	15
-#define DM646X_LPSC_VPSSMSTR	16
-#define DM646X_LPSC_VPSSSLV	17
-#define DM646X_LPSC_TSIF0	18
-#define DM646X_LPSC_TSIF1	19
-#define DM646X_LPSC_DDR_EMIF	20
-#define DM646X_LPSC_AEMIF	21
-#define DM646X_LPSC_McASP0	22
-#define DM646X_LPSC_McASP1	23
-#define DM646X_LPSC_CRGEN0	24
-#define DM646X_LPSC_CRGEN1	25
-#define DM646X_LPSC_UART0	26
-#define DM646X_LPSC_UART1	27
-#define DM646X_LPSC_UART2	28
-#define DM646X_LPSC_PWM0	29
-#define DM646X_LPSC_PWM1	30
-#define DM646X_LPSC_I2C		31
-#define DM646X_LPSC_SPI		32
-#define DM646X_LPSC_GPIO	33
-#define DM646X_LPSC_TIMER0	34
-#define DM646X_LPSC_TIMER1	35
-#define DM646X_LPSC_ARM_INTC	45
-
 /* PSC0 defines */
 #define DA8XX_LPSC0_TPCC		0
 #define DA8XX_LPSC0_TPTC0		1
diff --git a/arch/arm/mach-davinci/serial.c b/arch/arm/mach-davinci/serial.c
deleted file mode 100644
index ac1929bb0ef2..000000000000
--- a/arch/arm/mach-davinci/serial.c
+++ /dev/null
@@ -1,88 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * TI DaVinci serial driver
- *
- * Copyright (C) 2006 Texas Instruments.
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/serial_8250.h>
-#include <linux/serial_reg.h>
-#include <linux/platform_device.h>
-#include <linux/delay.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-
-#include "serial.h"
-#include "cputype.h"
-
-static inline void serial_write_reg(struct plat_serial8250_port *p, int offset,
-				    int value)
-{
-	offset <<= p->regshift;
-
-	WARN_ONCE(!p->membase, "unmapped write: uart[%d]\n", offset);
-
-	__raw_writel(value, p->membase + offset);
-}
-
-static void __init davinci_serial_reset(struct plat_serial8250_port *p)
-{
-	unsigned int pwremu = 0;
-
-	serial_write_reg(p, UART_IER, 0);  /* disable all interrupts */
-
-	/* reset both transmitter and receiver: bits 14,13 = UTRST, URRST */
-	serial_write_reg(p, UART_DAVINCI_PWREMU, pwremu);
-	mdelay(10);
-
-	pwremu |= (0x3 << 13);
-	pwremu |= 0x1;
-	serial_write_reg(p, UART_DAVINCI_PWREMU, pwremu);
-}
-
-int __init davinci_serial_init(struct platform_device *serial_dev)
-{
-	int i, ret = 0;
-	struct device *dev;
-	struct plat_serial8250_port *p;
-	struct clk *clk;
-
-	/*
-	 * Make sure the serial ports are muxed on at this point.
-	 * You have to mux them off in device drivers later on if not needed.
-	 */
-	for (i = 0; serial_dev[i].dev.platform_data != NULL; i++) {
-		dev = &serial_dev[i].dev;
-		p = dev->platform_data;
-
-		ret = platform_device_register(&serial_dev[i]);
-		if (ret)
-			continue;
-
-		clk = clk_get(dev, NULL);
-		if (IS_ERR(clk)) {
-			pr_err("%s:%d: failed to get UART%d clock\n",
-			       __func__, __LINE__, i);
-			continue;
-		}
-
-		clk_prepare_enable(clk);
-
-		p->uartclk = clk_get_rate(clk);
-
-		if (!p->membase && p->mapbase) {
-			p->membase = ioremap(p->mapbase, SZ_4K);
-
-			if (p->membase)
-				p->flags &= ~UPF_IOREMAP;
-			else
-				pr_err("uart regs ioremap failed\n");
-		}
-
-		if (p->membase && p->type != PORT_AR7)
-			davinci_serial_reset(p);
-	}
-	return ret;
-}
diff --git a/arch/arm/mach-davinci/serial.h b/arch/arm/mach-davinci/serial.h
deleted file mode 100644
index c4a4ba553d45..000000000000
--- a/arch/arm/mach-davinci/serial.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * DaVinci serial device definitions
- *
- * Author: Kevin Hilman, MontaVista Software, Inc. <source@mvista.com>
- *
- * 2007 (c) MontaVista Software, Inc.
- */
-#ifndef __ASM_ARCH_SERIAL_H
-#define __ASM_ARCH_SERIAL_H
-
-#include <asm/memory.h>
-
-#include "hardware.h"
-
-#define DAVINCI_UART0_BASE	(IO_PHYS + 0x20000)
-#define DAVINCI_UART1_BASE	(IO_PHYS + 0x20400)
-#define DAVINCI_UART2_BASE	(IO_PHYS + 0x20800)
-
-#define DA8XX_UART0_BASE	(IO_PHYS + 0x042000)
-#define DA8XX_UART1_BASE	(IO_PHYS + 0x10c000)
-#define DA8XX_UART2_BASE	(IO_PHYS + 0x10d000)
-
-/* DaVinci UART register offsets */
-#define UART_DAVINCI_PWREMU		0x0c
-#define UART_DM646X_SCR			0x10
-#define UART_DM646X_SCR_TX_WATERMARK	0x08
-
-#ifndef __ASSEMBLY__
-#include <linux/platform_device.h>
-
-extern int davinci_serial_init(struct platform_device *);
-#endif
-
-#endif /* __ASM_ARCH_SERIAL_H */
diff --git a/arch/arm/mach-davinci/usb-da8xx.c b/arch/arm/mach-davinci/usb-da8xx.c
deleted file mode 100644
index 9c8fc5031907..000000000000
--- a/arch/arm/mach-davinci/usb-da8xx.c
+++ /dev/null
@@ -1,146 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * DA8xx USB
- */
-#include <linux/clk-provider.h>
-#include <linux/delay.h>
-#include <linux/dma-mapping.h>
-#include <linux/init.h>
-#include <linux/mfd/da8xx-cfgchip.h>
-#include <linux/mfd/syscon.h>
-#include <linux/phy/phy.h>
-#include <linux/platform_data/clk-da8xx-cfgchip.h>
-#include <linux/platform_data/phy-da8xx-usb.h>
-#include <linux/platform_data/usb-davinci.h>
-#include <linux/platform_device.h>
-#include <linux/usb/musb.h>
-
-#include "common.h"
-#include "cputype.h"
-#include "da8xx.h"
-#include "irqs.h"
-
-#define DA8XX_USB0_BASE		0x01e00000
-#define DA8XX_USB1_BASE		0x01e25000
-
-#ifndef CONFIG_COMMON_CLK
-static struct clk *usb20_clk;
-#endif
-
-static struct da8xx_usb_phy_platform_data da8xx_usb_phy_pdata;
-
-static struct platform_device da8xx_usb_phy = {
-	.name		= "da8xx-usb-phy",
-	.id		= -1,
-	.dev		= {
-		/*
-		 * Setting init_name so that clock lookup will work in
-		 * da8xx_register_usb11_phy_clk() even if this device is not
-		 * registered yet.
-		 */
-		.init_name	= "da8xx-usb-phy",
-		.platform_data	= &da8xx_usb_phy_pdata,
-	},
-};
-
-int __init da8xx_register_usb_phy(void)
-{
-	da8xx_usb_phy_pdata.cfgchip = da8xx_get_cfgchip();
-
-	return platform_device_register(&da8xx_usb_phy);
-}
-
-static struct musb_hdrc_config musb_config = {
-	.multipoint	= true,
-	.num_eps	= 5,
-	.ram_bits	= 10,
-};
-
-static struct musb_hdrc_platform_data usb_data = {
-	/* OTG requires a Mini-AB connector */
-	.mode           = MUSB_OTG,
-	.clock		= "usb20",
-	.config		= &musb_config,
-};
-
-static struct resource da8xx_usb20_resources[] = {
-	{
-		.start		= DA8XX_USB0_BASE,
-		.end		= DA8XX_USB0_BASE + SZ_64K - 1,
-		.flags		= IORESOURCE_MEM,
-	},
-	{
-		.start		= DAVINCI_INTC_IRQ(IRQ_DA8XX_USB_INT),
-		.flags		= IORESOURCE_IRQ,
-		.name		= "mc",
-	},
-};
-
-static u64 usb_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device da8xx_usb20_dev = {
-	.name		= "musb-da8xx",
-	.id             = -1,
-	.dev = {
-		.platform_data		= &usb_data,
-		.dma_mask		= &usb_dmamask,
-		.coherent_dma_mask      = DMA_BIT_MASK(32),
-	},
-	.resource	= da8xx_usb20_resources,
-	.num_resources	= ARRAY_SIZE(da8xx_usb20_resources),
-};
-
-int __init da8xx_register_usb20(unsigned int mA, unsigned int potpgt)
-{
-	usb_data.power	= mA > 510 ? 255 : mA / 2;
-	usb_data.potpgt = (potpgt + 1) / 2;
-
-	return platform_device_register(&da8xx_usb20_dev);
-}
-
-static struct resource da8xx_usb11_resources[] = {
-	[0] = {
-		.start	= DA8XX_USB1_BASE,
-		.end	= DA8XX_USB1_BASE + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= DAVINCI_INTC_IRQ(IRQ_DA8XX_IRQN),
-		.end	= DAVINCI_INTC_IRQ(IRQ_DA8XX_IRQN),
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static u64 da8xx_usb11_dma_mask = DMA_BIT_MASK(32);
-
-static struct platform_device da8xx_usb11_device = {
-	.name		= "ohci-da8xx",
-	.id		= -1,
-	.dev = {
-		.dma_mask		= &da8xx_usb11_dma_mask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.num_resources	= ARRAY_SIZE(da8xx_usb11_resources),
-	.resource	= da8xx_usb11_resources,
-};
-
-int __init da8xx_register_usb11(struct da8xx_ohci_root_hub *pdata)
-{
-	da8xx_usb11_device.dev.platform_data = pdata;
-	return platform_device_register(&da8xx_usb11_device);
-}
-
-static struct platform_device da8xx_usb_phy_clks_device = {
-	.name		= "da830-usb-phy-clks",
-	.id		= -1,
-};
-
-int __init da8xx_register_usb_phy_clocks(void)
-{
-	struct da8xx_cfgchip_clk_platform_data pdata;
-
-	pdata.cfgchip = da8xx_get_cfgchip();
-	da8xx_usb_phy_clks_device.dev.platform_data = &pdata;
-
-	return platform_device_register(&da8xx_usb_phy_clks_device);
-}
diff --git a/arch/arm/mach-davinci/usb.c b/arch/arm/mach-davinci/usb.c
deleted file mode 100644
index 9dc14c7977b3..000000000000
--- a/arch/arm/mach-davinci/usb.c
+++ /dev/null
@@ -1,74 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * USB
- */
-#include <linux/dma-mapping.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/platform_data/usb-davinci.h>
-#include <linux/usb/musb.h>
-
-#include "common.h"
-#include "cputype.h"
-#include "irqs.h"
-
-#define DAVINCI_USB_OTG_BASE	0x01c64000
-
-#if IS_ENABLED(CONFIG_USB_MUSB_HDRC)
-static struct musb_hdrc_config musb_config = {
-	.multipoint	= true,
-
-	.num_eps	= 5,
-	.ram_bits	= 10,
-};
-
-static struct musb_hdrc_platform_data usb_data = {
-	/* OTG requires a Mini-AB connector */
-	.mode           = MUSB_OTG,
-	.clock		= "usb",
-	.config		= &musb_config,
-};
-
-static struct resource usb_resources[] = {
-	{
-		/* physical address */
-		.start          = DAVINCI_USB_OTG_BASE,
-		.end            = DAVINCI_USB_OTG_BASE + 0x5ff,
-		.flags          = IORESOURCE_MEM,
-	},
-	{
-		.start          = DAVINCI_INTC_IRQ(IRQ_USBINT),
-		.flags          = IORESOURCE_IRQ,
-		.name		= "mc"
-	},
-};
-
-static u64 usb_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device usb_dev = {
-	.name           = "musb-davinci",
-	.id             = -1,
-	.dev = {
-		.platform_data		= &usb_data,
-		.dma_mask		= &usb_dmamask,
-		.coherent_dma_mask      = DMA_BIT_MASK(32),
-	},
-	.resource       = usb_resources,
-	.num_resources  = ARRAY_SIZE(usb_resources),
-};
-
-void __init davinci_setup_usb(unsigned mA, unsigned potpgt_ms)
-{
-	usb_data.power = mA > 510 ? 255 : mA / 2;
-	usb_data.potpgt = (potpgt_ms + 1) / 2;
-
-	platform_device_register(&usb_dev);
-}
-
-#else
-
-void __init davinci_setup_usb(unsigned mA, unsigned potpgt_ms)
-{
-}
-
-#endif  /* CONFIG_USB_MUSB_HDRC */
-- 
2.29.2

