Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41EC65EDA4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbjAENrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjAENqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:46:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC73B634B
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 05:46:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D8A1B81AD7
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 13:46:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB703C433F0;
        Thu,  5 Jan 2023 13:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672926408;
        bh=dZp/PMQ0dnDJGdJBctPRLkuGVQfjRlJ837CIMplBJMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lf5LeIh5/cjC9stwe+oc7u1sgoPCrG9pnCTg3KWHueKH0FeDb2zkKZpMNB97Qiyb7
         jrz1ENJkVrfQXQCb1pKLE59C1Ngwh2WYDfgP26VG92jy+KxtpiJN/wtF8Cf36Q3Bbo
         RmUaLgVcyZq2t4EhAagK1uINJZkMesW6vw+uNmDcoRmoBsk2QyWsaKvBl0dShamjbL
         3Xy7bKmg/ikuBA3hndWVoFlecwB4J+MEMcN+AlZOYqDXM0s2PxGfPEcxgcZF0KveOV
         zZVsj/90czLCg02sxw3Nz2ig1+FSPoIyN9ASsobK63qZPuPQaK3uV3YeFFvH/aPKOS
         RzoWqAOTXZ3Xw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 02/27] ARM: pxa: remove irda leftover
Date:   Thu,  5 Jan 2023 14:45:57 +0100
Message-Id: <20230105134622.254560-3-arnd@kernel.org>
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

irda support was removed a long time ago, so stop
registering the devices from the pxa machine.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/devices.c                | 42 ----------------------
 arch/arm/mach-pxa/devices.h                |  1 -
 arch/arm/mach-pxa/pxa2xx.c                 | 29 ---------------
 arch/arm/mach-pxa/spitz.c                  | 23 ------------
 include/linux/platform_data/irda-pxaficp.h | 26 --------------
 5 files changed, 121 deletions(-)
 delete mode 100644 include/linux/platform_data/irda-pxaficp.h

diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index a7b92dd1ca9e..72adaac9f332 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -15,7 +15,6 @@
 #include <linux/platform_data/usb-pxa3xx-ulpi.h>
 #include <linux/platform_data/video-pxafb.h>
 #include <linux/platform_data/mmc-pxamci.h>
-#include <linux/platform_data/irda-pxaficp.h>
 #include "irqs.h"
 #include <linux/platform_data/usb-ohci-pxa27x.h>
 #include <linux/platform_data/keypad-pxa27x.h>
@@ -378,47 +377,6 @@ struct platform_device pxa_device_asoc_platform = {
 	.id		= -1,
 };
 
-static u64 pxaficp_dmamask = ~(u32)0;
-
-static struct resource pxa_ir_resources[] = {
-	[0] = {
-		.start  = IRQ_STUART,
-		.end    = IRQ_STUART,
-		.flags  = IORESOURCE_IRQ,
-	},
-	[1] = {
-		.start  = IRQ_ICP,
-		.end    = IRQ_ICP,
-		.flags  = IORESOURCE_IRQ,
-	},
-	[3] = {
-		.start  = 0x40800000,
-		.end	= 0x4080001b,
-		.flags  = IORESOURCE_MEM,
-	},
-	[4] = {
-		.start  = 0x40700000,
-		.end	= 0x40700023,
-		.flags  = IORESOURCE_MEM,
-	},
-};
-
-struct platform_device pxa_device_ficp = {
-	.name		= "pxa2xx-ir",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(pxa_ir_resources),
-	.resource	= pxa_ir_resources,
-	.dev		= {
-		.dma_mask = &pxaficp_dmamask,
-		.coherent_dma_mask = 0xffffffff,
-	},
-};
-
-void __init pxa_set_ficp_info(struct pxaficp_platform_data *info)
-{
-	pxa_register_device(&pxa_device_ficp, info);
-}
-
 static struct resource pxa_rtc_resources[] = {
 	[0] = {
 		.start  = 0x40900000,
diff --git a/arch/arm/mach-pxa/devices.h b/arch/arm/mach-pxa/devices.h
index 498b07bc6a3e..2828bea76cd7 100644
--- a/arch/arm/mach-pxa/devices.h
+++ b/arch/arm/mach-pxa/devices.h
@@ -17,7 +17,6 @@ extern struct platform_device pxa_device_stuart;
 extern struct platform_device pxa_device_hwuart;
 extern struct platform_device pxa_device_i2c;
 extern struct platform_device pxa_device_i2s;
-extern struct platform_device pxa_device_ficp;
 extern struct platform_device sa1100_device_rtc;
 extern struct platform_device pxa_device_rtc;
 extern struct platform_device pxa_device_ac97;
diff --git a/arch/arm/mach-pxa/pxa2xx.c b/arch/arm/mach-pxa/pxa2xx.c
index 4aafd692c1e8..35c23a5d73a3 100644
--- a/arch/arm/mach-pxa/pxa2xx.c
+++ b/arch/arm/mach-pxa/pxa2xx.c
@@ -18,7 +18,6 @@
 #include "reset.h"
 #include "smemc.h"
 #include <linux/soc/pxa/smemc.h>
-#include <linux/platform_data/irda-pxaficp.h>
 
 void pxa2xx_clear_reset_status(unsigned int mask)
 {
@@ -26,34 +25,6 @@ void pxa2xx_clear_reset_status(unsigned int mask)
 	RCSR = mask;
 }
 
-static unsigned long pxa2xx_mfp_fir[] = {
-	GPIO46_FICP_RXD,
-	GPIO47_FICP_TXD,
-};
-
-static unsigned long pxa2xx_mfp_sir[] = {
-	GPIO46_STUART_RXD,
-	GPIO47_STUART_TXD,
-};
-
-static unsigned long pxa2xx_mfp_off[] = {
-	GPIO46_GPIO | MFP_LPM_DRIVE_LOW,
-	GPIO47_GPIO | MFP_LPM_DRIVE_LOW,
-};
-
-void pxa2xx_transceiver_mode(struct device *dev, int mode)
-{
-	if (mode & IR_OFF) {
-		pxa2xx_mfp_config(pxa2xx_mfp_off, ARRAY_SIZE(pxa2xx_mfp_off));
-	} else if (mode & IR_SIRMODE) {
-		pxa2xx_mfp_config(pxa2xx_mfp_sir, ARRAY_SIZE(pxa2xx_mfp_sir));
-	} else if (mode & IR_FIRMODE) {
-		pxa2xx_mfp_config(pxa2xx_mfp_fir, ARRAY_SIZE(pxa2xx_mfp_fir));
-	} else
-		BUG();
-}
-EXPORT_SYMBOL_GPL(pxa2xx_transceiver_mode);
-
 #define MDCNFG_DRAC2(mdcnfg)	(((mdcnfg) >> 21) & 0x3)
 #define MDCNFG_DRAC0(mdcnfg)	(((mdcnfg) >> 5) & 0x3)
 
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 9964729cd428..26f0ebc4d136 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -40,7 +40,6 @@
 #include "pxa27x.h"
 #include "pxa27x-udc.h"
 #include "reset.h"
-#include <linux/platform_data/irda-pxaficp.h>
 #include <linux/platform_data/mmc-pxamci.h>
 #include <linux/platform_data/usb-ohci-pxa27x.h>
 #include <linux/platform_data/video-pxafb.h>
@@ -687,27 +686,6 @@ static void __init spitz_uhc_init(void)
 static inline void spitz_uhc_init(void) {}
 #endif
 
-/******************************************************************************
- * IrDA
- ******************************************************************************/
-#if defined(CONFIG_PXA_FICP) || defined(CONFIG_PXA_FICP_MODULE)
-static struct pxaficp_platform_data spitz_ficp_platform_data = {
-	.transceiver_cap	= IR_SIRMODE | IR_OFF,
-};
-
-static void __init spitz_irda_init(void)
-{
-	if (machine_is_akita())
-		spitz_ficp_platform_data.gpio_pwdown = AKITA_GPIO_IR_ON;
-	else
-		spitz_ficp_platform_data.gpio_pwdown = SPITZ_GPIO_IR_ON;
-
-	pxa_set_ficp_info(&spitz_ficp_platform_data);
-}
-#else
-static inline void spitz_irda_init(void) {}
-#endif
-
 /******************************************************************************
  * Framebuffer
  ******************************************************************************/
@@ -1042,7 +1020,6 @@ static void __init spitz_init(void)
 	spitz_leds_init();
 	spitz_mmc_init();
 	spitz_pcmcia_init();
-	spitz_irda_init();
 	spitz_uhc_init();
 	spitz_lcd_init();
 	spitz_nor_init();
diff --git a/include/linux/platform_data/irda-pxaficp.h b/include/linux/platform_data/irda-pxaficp.h
deleted file mode 100644
index bd35ddcf3068..000000000000
-- 
2.39.0

