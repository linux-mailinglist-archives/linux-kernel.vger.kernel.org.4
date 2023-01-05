Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABAF65EDA6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbjAENrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbjAENrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:47:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E17D634B
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 05:46:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97100B81AD0
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 13:46:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D867FC43392;
        Thu,  5 Jan 2023 13:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672926416;
        bh=/YTFxMpRgty9v/I0GLC8pgjg57PL6GmuZISrLWV/U8I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FTrAw01gPlVtEIq/fuN0vW9LwVxjqjgQKoItBFhaR93V6EvYMsTYUBnlRecNp0aee
         4arwb4iNCtOGM1ZKJrg/Tf+V83Em+Xt7XgP0GE63qoTr81me/cepRQp/eRcx7Ho4uw
         rMhqsziF9t+ub+MeX/J9enVq8xNr6LBSUWpn2oMMPTRCcK6JCARVC8FkbIN6cZzmdw
         KuzCdhlluOLAT06bOBrYyxsAN+qIP+yhxtRIqFBjz9fEwWHpyTyW5HleMdd+KH2h1T
         gGVePhCAg88Y4rNy3tVQEQzpOeYtQCK2KV+OR74ezi520NV9zoIvXnNqIPyW3sd5OQ
         mYf9mCJg+dEmA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 05/27] ARM: pxa: prune unused device support
Date:   Thu,  5 Jan 2023 14:46:00 +0100
Message-Id: <20230105134622.254560-6-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105134622.254560-1-arnd@kernel.org>
References: <20230105134622.254560-1-arnd@kernel.org>
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

pxa3xx is now DT-only, and the remaining pxa2xx board files
only use a subset of the possible devices, so remove all
definitions that are not referenced any more.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/devices.c    | 338 ---------------------------------
 arch/arm/mach-pxa/mfp-pxa25x.h |  33 ----
 arch/arm/mach-pxa/mfp-pxa2xx.c |   4 -
 arch/arm/mach-pxa/pm.c         |   2 -
 arch/arm/mach-pxa/pm.h         |  10 -
 arch/arm/mach-pxa/pxa25x.c     |   7 -
 arch/arm/mach-pxa/pxa27x.c     |  18 +-
 arch/arm/mach-pxa/pxa27x.h     |   3 -
 arch/arm/mach-pxa/pxa3xx.c     |  89 ---------
 9 files changed, 3 insertions(+), 501 deletions(-)

diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index 8e3bc56d2044..661b3fc43275 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -16,11 +16,7 @@
 #include <linux/platform_data/mmc-pxamci.h>
 #include "irqs.h"
 #include <linux/platform_data/usb-ohci-pxa27x.h>
-#include <linux/platform_data/keypad-pxa27x.h>
-#include <linux/platform_data/media/camera-pxa.h>
-#include <linux/platform_data/asoc-pxa.h>
 #include <linux/platform_data/mmp_dma.h>
-#include <linux/platform_data/mtd-nand-pxa3xx.h>
 
 #include "regs-ost.h"
 #include "reset.h"
@@ -82,16 +78,10 @@ void __init pxa_set_mci_info(struct pxamci_platform_data *info)
 	pxa_register_device(&pxa_device_mci, info);
 }
 
-
 static struct pxa2xx_udc_mach_info pxa_udc_info = {
 	.gpio_pullup = -1,
 };
 
-void __init pxa_set_udc_info(struct pxa2xx_udc_mach_info *info)
-{
-	memcpy(&pxa_udc_info, info, sizeof *info);
-}
-
 static struct resource pxa2xx_udc_resources[] = {
 	[0] = {
 		.start	= 0x40600000,
@@ -383,49 +373,6 @@ struct platform_device sa1100_device_rtc = {
 	.resource       = pxa_rtc_resources,
 };
 
-static struct resource pxa_ac97_resources[] = {
-	[0] = {
-		.start  = 0x40500000,
-		.end	= 0x40500000 + 0xfff,
-		.flags  = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start  = IRQ_AC97,
-		.end    = IRQ_AC97,
-		.flags  = IORESOURCE_IRQ,
-	},
-};
-
-static u64 pxa_ac97_dmamask = 0xffffffffUL;
-
-struct platform_device pxa_device_ac97 = {
-	.name           = "pxa2xx-ac97",
-	.id             = -1,
-	.dev            = {
-		.dma_mask = &pxa_ac97_dmamask,
-		.coherent_dma_mask = 0xffffffff,
-	},
-	.num_resources  = ARRAY_SIZE(pxa_ac97_resources),
-	.resource       = pxa_ac97_resources,
-};
-
-void __init pxa_set_ac97_info(pxa2xx_audio_ops_t *ops)
-{
-	int ret;
-
-	ret = clk_add_alias("ac97_clk", "pxa2xx-ac97:0", "AC97CLK",
-			   &pxa_device_ac97.dev);
-	if (ret)
-		pr_err("PXA AC97 clock1 alias error: %d\n", ret);
-
-	ret = clk_add_alias("ac97_clk", "pxa2xx-ac97:1", "AC97CLK",
-			    &pxa_device_ac97.dev);
-	if (ret)
-		pr_err("PXA AC97 clock2 alias error: %d\n", ret);
-
-	pxa_register_device(&pxa_device_ac97, ops);
-}
-
 #ifdef CONFIG_PXA25x
 
 static struct resource pxa25x_resource_pwm0[] = {
@@ -539,44 +486,6 @@ struct platform_device pxa25x_device_assp = {
 #endif /* CONFIG_PXA25x */
 
 #if defined(CONFIG_PXA27x) || defined(CONFIG_PXA3xx)
-static struct resource pxa27x_resource_camera[] = {
-	[0] = {
-		.start	= 0x50000000,
-		.end	= 0x50000fff,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_CAMERA,
-		.end	= IRQ_CAMERA,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static u64 pxa27x_dma_mask_camera = DMA_BIT_MASK(32);
-
-static struct platform_device pxa27x_device_camera = {
-	.name		= "pxa27x-camera",
-	.id		= 0, /* This is used to put cameras on this interface */
-	.dev		= {
-		.dma_mask      		= &pxa27x_dma_mask_camera,
-		.coherent_dma_mask	= 0xffffffff,
-	},
-	.num_resources	= ARRAY_SIZE(pxa27x_resource_camera),
-	.resource	= pxa27x_resource_camera,
-};
-
-void __init pxa_set_camera_info(struct pxacamera_platform_data *info)
-{
-	struct clk *mclk;
-
-	/* Register a fixed-rate clock for camera sensors. */
-	mclk = clk_register_fixed_rate(NULL, "pxa_camera_clk", NULL, 0,
-					     info->mclk_10khz * 10000);
-	if (!IS_ERR(mclk))
-		clkdev_create(mclk, "mclk", NULL);
-	pxa_register_device(&pxa27x_device_camera, info);
-}
-
 static u64 pxa27x_ohci_dma_mask = DMA_BIT_MASK(32);
 
 static struct resource pxa27x_resource_ohci[] = {
@@ -610,31 +519,6 @@ void __init pxa_set_ohci_info(struct pxaohci_platform_data *info)
 #endif /* CONFIG_PXA27x || CONFIG_PXA3xx */
 
 #if defined(CONFIG_PXA27x) || defined(CONFIG_PXA3xx)
-static struct resource pxa27x_resource_keypad[] = {
-	[0] = {
-		.start	= 0x41500000,
-		.end	= 0x4150004c,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_KEYPAD,
-		.end	= IRQ_KEYPAD,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device pxa27x_device_keypad = {
-	.name		= "pxa27x-keypad",
-	.id		= -1,
-	.resource	= pxa27x_resource_keypad,
-	.num_resources	= ARRAY_SIZE(pxa27x_resource_keypad),
-};
-
-void __init pxa_set_keypad_info(struct pxa27x_keypad_platform_data *info)
-{
-	pxa_register_device(&pxa27x_device_keypad, info);
-}
-
 static u64 pxa27x_ssp1_dma_mask = DMA_BIT_MASK(32);
 
 static struct resource pxa27x_resource_ssp1[] = {
@@ -744,210 +628,6 @@ struct platform_device pxa27x_device_pwm1 = {
 };
 #endif /* CONFIG_PXA27x || CONFIG_PXA3xx */
 
-#ifdef CONFIG_PXA3xx
-static struct resource pxa3xx_resources_mci2[] = {
-	[0] = {
-		.start	= 0x42000000,
-		.end	= 0x42000fff,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_MMC2,
-		.end	= IRQ_MMC2,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device pxa3xx_device_mci2 = {
-	.name		= "pxa2xx-mci",
-	.id		= 1,
-	.dev		= {
-		.dma_mask = &pxamci_dmamask,
-		.coherent_dma_mask =	0xffffffff,
-	},
-	.num_resources	= ARRAY_SIZE(pxa3xx_resources_mci2),
-	.resource	= pxa3xx_resources_mci2,
-};
-
-void __init pxa3xx_set_mci2_info(struct pxamci_platform_data *info)
-{
-	pxa_register_device(&pxa3xx_device_mci2, info);
-}
-
-static struct resource pxa3xx_resources_mci3[] = {
-	[0] = {
-		.start	= 0x42500000,
-		.end	= 0x42500fff,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_MMC3,
-		.end	= IRQ_MMC3,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device pxa3xx_device_mci3 = {
-	.name		= "pxa2xx-mci",
-	.id		= 2,
-	.dev		= {
-		.dma_mask = &pxamci_dmamask,
-		.coherent_dma_mask = 0xffffffff,
-	},
-	.num_resources	= ARRAY_SIZE(pxa3xx_resources_mci3),
-	.resource	= pxa3xx_resources_mci3,
-};
-
-void __init pxa3xx_set_mci3_info(struct pxamci_platform_data *info)
-{
-	pxa_register_device(&pxa3xx_device_mci3, info);
-}
-
-static struct resource pxa3xx_resources_gcu[] = {
-	{
-		.start	= 0x54000000,
-		.end	= 0x54000fff,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= IRQ_GCU,
-		.end	= IRQ_GCU,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static u64 pxa3xx_gcu_dmamask = DMA_BIT_MASK(32);
-
-struct platform_device pxa3xx_device_gcu = {
-	.name		= "pxa3xx-gcu",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(pxa3xx_resources_gcu),
-	.resource	= pxa3xx_resources_gcu,
-	.dev		= {
-		.dma_mask = &pxa3xx_gcu_dmamask,
-		.coherent_dma_mask = 0xffffffff,
-	},
-};
-
-#endif /* CONFIG_PXA3xx */
-
-#if defined(CONFIG_PXA3xx)
-static struct resource pxa3xx_resources_i2c_power[] = {
-	{
-		.start  = 0x40f500c0,
-		.end    = 0x40f500d3,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start	= IRQ_PWRI2C,
-		.end	= IRQ_PWRI2C,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device pxa3xx_device_i2c_power = {
-	.name		= "pxa3xx-pwri2c",
-	.id		= 1,
-	.resource	= pxa3xx_resources_i2c_power,
-	.num_resources	= ARRAY_SIZE(pxa3xx_resources_i2c_power),
-};
-
-static struct resource pxa3xx_resources_nand[] = {
-	[0] = {
-		.start	= 0x43100000,
-		.end	= 0x43100053,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_NAND,
-		.end	= IRQ_NAND,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static u64 pxa3xx_nand_dma_mask = DMA_BIT_MASK(32);
-
-struct platform_device pxa3xx_device_nand = {
-	.name		= "pxa3xx-nand",
-	.id		= -1,
-	.dev		= {
-		.dma_mask = &pxa3xx_nand_dma_mask,
-		.coherent_dma_mask = DMA_BIT_MASK(32),
-	},
-	.num_resources	= ARRAY_SIZE(pxa3xx_resources_nand),
-	.resource	= pxa3xx_resources_nand,
-};
-
-void __init pxa3xx_set_nand_info(struct pxa3xx_nand_platform_data *info)
-{
-	pxa_register_device(&pxa3xx_device_nand, info);
-}
-
-static u64 pxa3xx_ssp4_dma_mask = DMA_BIT_MASK(32);
-
-static struct resource pxa3xx_resource_ssp4[] = {
-	[0] = {
-		.start	= 0x41a00000,
-		.end	= 0x41a0003f,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_SSP4,
-		.end	= IRQ_SSP4,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-/*
- * PXA3xx SSP is basically equivalent to PXA27x.
- * However, we need to register the device by the correct name in order to
- * make the driver set the correct internal type, hence we provide specific
- * platform_devices for each of them.
- */
-struct platform_device pxa3xx_device_ssp1 = {
-	.name		= "pxa3xx-ssp",
-	.id		= 0,
-	.dev		= {
-		.dma_mask = &pxa27x_ssp1_dma_mask,
-		.coherent_dma_mask = DMA_BIT_MASK(32),
-	},
-	.resource	= pxa27x_resource_ssp1,
-	.num_resources	= ARRAY_SIZE(pxa27x_resource_ssp1),
-};
-
-struct platform_device pxa3xx_device_ssp2 = {
-	.name		= "pxa3xx-ssp",
-	.id		= 1,
-	.dev		= {
-		.dma_mask = &pxa27x_ssp2_dma_mask,
-		.coherent_dma_mask = DMA_BIT_MASK(32),
-	},
-	.resource	= pxa27x_resource_ssp2,
-	.num_resources	= ARRAY_SIZE(pxa27x_resource_ssp2),
-};
-
-struct platform_device pxa3xx_device_ssp3 = {
-	.name		= "pxa3xx-ssp",
-	.id		= 2,
-	.dev		= {
-		.dma_mask = &pxa27x_ssp3_dma_mask,
-		.coherent_dma_mask = DMA_BIT_MASK(32),
-	},
-	.resource	= pxa27x_resource_ssp3,
-	.num_resources	= ARRAY_SIZE(pxa27x_resource_ssp3),
-};
-
-struct platform_device pxa3xx_device_ssp4 = {
-	.name		= "pxa3xx-ssp",
-	.id		= 3,
-	.dev		= {
-		.dma_mask = &pxa3xx_ssp4_dma_mask,
-		.coherent_dma_mask = DMA_BIT_MASK(32),
-	},
-	.resource	= pxa3xx_resource_ssp4,
-	.num_resources	= ARRAY_SIZE(pxa3xx_resource_ssp4),
-};
-#endif /* CONFIG_PXA3xx */
-
 struct resource pxa_resource_gpio[] = {
 	{
 		.start	= 0x40e00000,
@@ -972,11 +652,7 @@ struct resource pxa_resource_gpio[] = {
 };
 
 struct platform_device pxa25x_device_gpio = {
-#ifdef CONFIG_CPU_PXA26x
-	.name		= "pxa26x-gpio",
-#else
 	.name		= "pxa25x-gpio",
-#endif
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(pxa_resource_gpio),
 	.resource	= pxa_resource_gpio,
@@ -989,20 +665,6 @@ struct platform_device pxa27x_device_gpio = {
 	.resource	= pxa_resource_gpio,
 };
 
-struct platform_device pxa3xx_device_gpio = {
-	.name		= "pxa3xx-gpio",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(pxa_resource_gpio),
-	.resource	= pxa_resource_gpio,
-};
-
-struct platform_device pxa93x_device_gpio = {
-	.name		= "pxa93x-gpio",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(pxa_resource_gpio),
-	.resource	= pxa_resource_gpio,
-};
-
 /* pxa2xx-spi platform-device ID equals respective SSP platform-device ID + 1.
  * See comment in arch/arm/mach-pxa/ssp.c::ssp_probe() */
 void __init pxa2xx_set_spi_info(unsigned id, struct pxa2xx_spi_controller *info)
diff --git a/arch/arm/mach-pxa/mfp-pxa25x.h b/arch/arm/mach-pxa/mfp-pxa25x.h
index d0ebb2154503..3dc5c833e28f 100644
--- a/arch/arm/mach-pxa/mfp-pxa25x.h
+++ b/arch/arm/mach-pxa/mfp-pxa25x.h
@@ -158,39 +158,6 @@
 #define GPIO76_LCD_PCLK		MFP_CFG_OUT(GPIO76, AF2, DRIVE_LOW)
 #define GPIO77_LCD_BIAS		MFP_CFG_OUT(GPIO77, AF2, DRIVE_LOW)
 
-#ifdef CONFIG_CPU_PXA26x
-/* GPIO */
-#define GPIO85_GPIO		MFP_CFG_IN(GPIO85, AF0)
-#define GPIO86_GPIO		MFP_CFG_IN(GPIO86, AF1)
-#define GPIO87_GPIO		MFP_CFG_IN(GPIO87, AF1)
-#define GPIO88_GPIO		MFP_CFG_IN(GPIO88, AF1)
-#define GPIO89_GPIO		MFP_CFG_IN(GPIO89, AF1)
-
-/* SDRAM */
-#define GPIO86_nSDCS2		MFP_CFG_OUT(GPIO86, AF0, DRIVE_HIGH)
-#define GPIO87_nSDCS3		MFP_CFG_OUT(GPIO87, AF0, DRIVE_HIGH)
-#define GPIO88_RDnWR		MFP_CFG_OUT(GPIO88, AF0, DRIVE_HIGH)
-
-/* USB */
-#define GPIO9_USB_RCV		MFP_CFG_IN(GPIO9, AF1)
-#define GPIO32_USB_VP		MFP_CFG_IN(GPIO32, AF2)
-#define GPIO34_USB_VM		MFP_CFG_IN(GPIO34, AF2)
-#define GPIO39_USB_VPO		MFP_CFG_OUT(GPIO39, AF3, DRIVE_LOW)
-#define GPIO56_USB_VMO		MFP_CFG_OUT(GPIO56, AF1, DRIVE_LOW)
-#define GPIO57_USB_nOE		MFP_CFG_OUT(GPIO57, AF1, DRIVE_HIGH)
-
-/* ASSP */
-#define GPIO28_ASSP_BITCLK_IN	MFP_CFG_IN(GPIO28, AF3)
-#define GPIO28_ASSP_BITCLK_OUT	MFP_CFG_OUT(GPIO28, AF3, DRIVE_LOW)
-#define GPIO29_ASSP_RXD		MFP_CFG_IN(GPIO29, AF3)
-#define GPIO30_ASSP_TXD		MFP_CFG_OUT(GPIO30, AF3, DRIVE_LOW)
-#define GPIO31_ASSP_SFRM_IN	MFP_CFG_IN(GPIO31, AF1)
-#define GPIO31_ASSP_SFRM_OUT	MFP_CFG_OUT(GPIO31, AF3, DRIVE_LOW)
-
-/* AC97 */
-#define GPIO89_AC97_nRESET	MFP_CFG_OUT(GPIO89, AF0, DRIVE_HIGH)
-#endif	/* CONFIG_CPU_PXA26x */
-
 /* commonly used pin configurations */
 #define GPIOxx_LCD_16BPP	\
 	GPIO58_LCD_LDD_0,	\
diff --git a/arch/arm/mach-pxa/mfp-pxa2xx.c b/arch/arm/mach-pxa/mfp-pxa2xx.c
index 57b0782880de..b556452dfcf9 100644
--- a/arch/arm/mach-pxa/mfp-pxa2xx.c
+++ b/arch/arm/mach-pxa/mfp-pxa2xx.c
@@ -226,11 +226,7 @@ static void __init pxa25x_mfp_init(void)
 	int i;
 
 	/* running before pxa_gpio_probe() */
-#ifdef CONFIG_CPU_PXA26x
-	pxa_last_gpio = 89;
-#else
 	pxa_last_gpio = 84;
-#endif
 	for (i = 0; i <= pxa_last_gpio; i++)
 		gpio_desc[i].valid = 1;
 
diff --git a/arch/arm/mach-pxa/pm.c b/arch/arm/mach-pxa/pm.c
index f2237f471750..c63e854921ea 100644
--- a/arch/arm/mach-pxa/pm.c
+++ b/arch/arm/mach-pxa/pm.c
@@ -51,8 +51,6 @@ int pxa_pm_enter(suspend_state_t state)
 		/* if invalid, display message and wait for a hardware reset */
 		if (checksum != sleep_save_checksum) {
 
-			lubbock_set_hexled(0xbadbadc5);
-
 			while (1)
 				pxa_cpu_pm_fns->enter(state);
 		}
diff --git a/arch/arm/mach-pxa/pm.h b/arch/arm/mach-pxa/pm.h
index 00ea3529e30e..a16fa140883c 100644
--- a/arch/arm/mach-pxa/pm.h
+++ b/arch/arm/mach-pxa/pm.h
@@ -27,13 +27,3 @@ extern void pxa_pm_finish(void);
 
 extern const char pm_enter_standby_start[], pm_enter_standby_end[];
 extern int pxa3xx_finish_suspend(unsigned long);
-
-/* NOTE: this is for PM debugging on Lubbock,  it's really a big
- * ugly, but let's keep the crap minimum here, instead of direct
- * accessing the LUBBOCK CPLD registers in arch/arm/mach-pxa/pm.c
- */
-#ifdef CONFIG_ARCH_LUBBOCK
-extern void lubbock_set_hexled(uint32_t value);
-#else
-#define lubbock_set_hexled(x)
-#endif
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index 6b34d7c169ea..1b83be181bab 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -145,13 +145,6 @@ void __init pxa25x_init_irq(void)
 	pxa_init_irq(32, pxa25x_set_wake);
 }
 
-#ifdef CONFIG_CPU_PXA26x
-void __init pxa26x_init_irq(void)
-{
-	pxa_init_irq(32, pxa25x_set_wake);
-}
-#endif
-
 static int __init __init
 pxa25x_dt_init_irq(struct device_node *node, struct device_node *parent)
 {
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index eea507fd5095..4135ba2877c4 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -85,18 +85,6 @@ EXPORT_SYMBOL_GPL(pxa27x_configure_ac97reset);
  */
 static unsigned int pwrmode = PWRMODE_SLEEP;
 
-int pxa27x_set_pwrmode(unsigned int mode)
-{
-	switch (mode) {
-	case PWRMODE_SLEEP:
-	case PWRMODE_DEEPSLEEP:
-		pwrmode = mode;
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
 /*
  * List of global PXA peripheral registers to preserve.
  * More ones like CP and general purpose register values are preserved
@@ -109,7 +97,7 @@ enum {
 	SLEEP_SAVE_COUNT
 };
 
-void pxa27x_cpu_pm_save(unsigned long *sleep_save)
+static void pxa27x_cpu_pm_save(unsigned long *sleep_save)
 {
 	sleep_save[SLEEP_SAVE_MDREFR] = __raw_readl(MDREFR);
 	SAVE(PCFR);
@@ -117,7 +105,7 @@ void pxa27x_cpu_pm_save(unsigned long *sleep_save)
 	SAVE(PSTR);
 }
 
-void pxa27x_cpu_pm_restore(unsigned long *sleep_save)
+static void pxa27x_cpu_pm_restore(unsigned long *sleep_save)
 {
 	__raw_writel(sleep_save[SLEEP_SAVE_MDREFR], MDREFR);
 	RESTORE(PCFR);
@@ -127,7 +115,7 @@ void pxa27x_cpu_pm_restore(unsigned long *sleep_save)
 	RESTORE(PSTR);
 }
 
-void pxa27x_cpu_pm_enter(suspend_state_t state)
+static void pxa27x_cpu_pm_enter(suspend_state_t state)
 {
 	extern void pxa_cpu_standby(void);
 #ifndef CONFIG_IWMMXT
diff --git a/arch/arm/mach-pxa/pxa27x.h b/arch/arm/mach-pxa/pxa27x.h
index ede96f3f7214..c9d9948ae7d1 100644
--- a/arch/arm/mach-pxa/pxa27x.h
+++ b/arch/arm/mach-pxa/pxa27x.h
@@ -20,7 +20,4 @@
 #define ARB_CORE_PARK		(1<<24)	   /* Be parked with core when idle */
 #define ARB_LOCK_FLAG		(1<<23)	   /* Only Locking masters gain access to the bus */
 
-extern int pxa27x_set_pwrmode(unsigned int mode);
-extern void pxa27x_cpu_pm_enter(suspend_state_t state);
-
 #endif /* __MACH_PXA27x_H */
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 7a02ddb30969..5441b778a081 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -363,13 +363,6 @@ static void __init __pxa3xx_init_irq(void)
 	pxa_init_ext_wakeup_irq(pxa3xx_set_wake);
 }
 
-void __init pxa3xx_init_irq(void)
-{
-	__pxa3xx_init_irq();
-	pxa_init_irq(56, pxa3xx_set_wake);
-}
-
-#ifdef CONFIG_OF
 static int __init __init
 pxa3xx_dt_init_irq(struct device_node *node, struct device_node *parent)
 {
@@ -380,7 +373,6 @@ pxa3xx_dt_init_irq(struct device_node *node, struct device_node *parent)
 	return 0;
 }
 IRQCHIP_DECLARE(pxa3xx_intc, "marvell,pxa-intc", pxa3xx_dt_init_irq);
-#endif	/* CONFIG_OF */
 
 static struct map_desc pxa3xx_io_desc[] __initdata = {
 	{	/* Mem Ctl */
@@ -403,73 +395,6 @@ void __init pxa3xx_map_io(void)
 	pxa3xx_get_clk_frequency_khz(1);
 }
 
-/*
- * device registration specific to PXA3xx.
- */
-
-void __init pxa3xx_set_i2c_power_info(struct i2c_pxa_platform_data *info)
-{
-	pxa_register_device(&pxa3xx_device_i2c_power, info);
-}
-
-static struct pxa_gpio_platform_data pxa3xx_gpio_pdata = {
-	.irq_base	= PXA_GPIO_TO_IRQ(0),
-};
-
-static struct platform_device *devices[] __initdata = {
-	&pxa27x_device_udc,
-	&pxa_device_pmu,
-	&pxa_device_i2s,
-	&pxa_device_asoc_ssp1,
-	&pxa_device_asoc_ssp2,
-	&pxa_device_asoc_ssp3,
-	&pxa_device_asoc_ssp4,
-	&pxa_device_asoc_platform,
-	&pxa_device_rtc,
-	&pxa3xx_device_ssp1,
-	&pxa3xx_device_ssp2,
-	&pxa3xx_device_ssp3,
-	&pxa3xx_device_ssp4,
-	&pxa27x_device_pwm0,
-	&pxa27x_device_pwm1,
-};
-
-static const struct dma_slave_map pxa3xx_slave_map[] = {
-	/* PXA25x, PXA27x and PXA3xx common entries */
-	{ "pxa2xx-ac97", "pcm_pcm_mic_mono", PDMA_FILTER_PARAM(LOWEST, 8) },
-	{ "pxa2xx-ac97", "pcm_pcm_aux_mono_in", PDMA_FILTER_PARAM(LOWEST, 9) },
-	{ "pxa2xx-ac97", "pcm_pcm_aux_mono_out",
-	  PDMA_FILTER_PARAM(LOWEST, 10) },
-	{ "pxa2xx-ac97", "pcm_pcm_stereo_in", PDMA_FILTER_PARAM(LOWEST, 11) },
-	{ "pxa2xx-ac97", "pcm_pcm_stereo_out", PDMA_FILTER_PARAM(LOWEST, 12) },
-	{ "pxa-ssp-dai.0", "rx", PDMA_FILTER_PARAM(LOWEST, 13) },
-	{ "pxa-ssp-dai.0", "tx", PDMA_FILTER_PARAM(LOWEST, 14) },
-	{ "pxa-ssp-dai.1", "rx", PDMA_FILTER_PARAM(LOWEST, 15) },
-	{ "pxa-ssp-dai.1", "tx", PDMA_FILTER_PARAM(LOWEST, 16) },
-	{ "pxa2xx-ir", "rx", PDMA_FILTER_PARAM(LOWEST, 17) },
-	{ "pxa2xx-ir", "tx", PDMA_FILTER_PARAM(LOWEST, 18) },
-	{ "pxa2xx-mci.0", "rx", PDMA_FILTER_PARAM(LOWEST, 21) },
-	{ "pxa2xx-mci.0", "tx", PDMA_FILTER_PARAM(LOWEST, 22) },
-	{ "pxa-ssp-dai.2", "rx", PDMA_FILTER_PARAM(LOWEST, 66) },
-	{ "pxa-ssp-dai.2", "tx", PDMA_FILTER_PARAM(LOWEST, 67) },
-
-	/* PXA3xx specific map */
-	{ "pxa-ssp-dai.3", "rx", PDMA_FILTER_PARAM(LOWEST, 2) },
-	{ "pxa-ssp-dai.3", "tx", PDMA_FILTER_PARAM(LOWEST, 3) },
-	{ "pxa2xx-mci.1", "rx", PDMA_FILTER_PARAM(LOWEST, 93) },
-	{ "pxa2xx-mci.1", "tx", PDMA_FILTER_PARAM(LOWEST, 94) },
-	{ "pxa3xx-nand", "data", PDMA_FILTER_PARAM(LOWEST, 97) },
-	{ "pxa2xx-mci.2", "rx", PDMA_FILTER_PARAM(LOWEST, 100) },
-	{ "pxa2xx-mci.2", "tx", PDMA_FILTER_PARAM(LOWEST, 101) },
-};
-
-static struct mmp_dma_platdata pxa3xx_dma_pdata = {
-	.dma_channels	= 32,
-	.nb_requestors	= 100,
-	.slave_map	= pxa3xx_slave_map,
-	.slave_map_cnt	= ARRAY_SIZE(pxa3xx_slave_map),
-};
-
 static int __init pxa3xx_init(void)
 {
 	int ret = 0;
@@ -499,20 +424,6 @@ static int __init pxa3xx_init(void)
 
 		register_syscore_ops(&pxa_irq_syscore_ops);
 		register_syscore_ops(&pxa3xx_mfp_syscore_ops);
-
-		if (of_have_populated_dt())
-			return 0;
-
-		pxa2xx_set_dmac_info(&pxa3xx_dma_pdata);
-		ret = platform_add_devices(devices, ARRAY_SIZE(devices));
-		if (ret)
-			return ret;
-		if (cpu_is_pxa300()) {
-			platform_device_add_data(&pxa3xx_device_gpio,
-						 &pxa3xx_gpio_pdata,
-						 sizeof(pxa3xx_gpio_pdata));
-			ret = platform_device_register(&pxa3xx_device_gpio);
-		}
 	}
 
 	return ret;
-- 
2.39.0

