Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668A865ED9A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjAENrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjAENqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:46:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05BB3D9D7;
        Thu,  5 Jan 2023 05:46:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BCE261A0C;
        Thu,  5 Jan 2023 13:46:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDC4C433EF;
        Thu,  5 Jan 2023 13:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672926410;
        bh=G8P7Dlh0jvFyjoAJiE2Nwh9lRK7Adhw9b5koXsAYWs0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ejFxyqZdkIyc8w2gV3P0BUGzVpl19r73AB20FYQLC0ugf4mc8+x3Ph8o1LPh6aGdu
         8o0b7hOJKWIdFVFWkA1G4bdIVzVPNXoico9eYs2d3YfYvuXHeXfsbnn001lRTuvTKu
         KkxvEcYXpypdiMFbQ6GJ9gYrbBAuS2xNAxbm9zzXMV42tO4Rq2o2ncLFwtkogBwYT/
         p2ofra8UNIpATWuNA+8rmWAl7iQacvuJhH0LVN1jIJiQNpUvm/DKfMn6VtXFyWIjkR
         nggYYNCvHDLv+at6TiRKnAf2ovry3ZgeGPUByPAz5GNFb0+P6g2ecDjlx7IS40WMch
         JJes+Bb+ONo/Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH 03/27] ARM: pxa: remove unused pxa3xx-ulpi
Date:   Thu,  5 Jan 2023 14:45:58 +0100
Message-Id: <20230105134622.254560-4-arnd@kernel.org>
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

This was only used by the cm-x300 board, which is now gone.

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/Makefile                    |   2 +-
 arch/arm/mach-pxa/devices.c                   |  28 --
 arch/arm/mach-pxa/devices.h                   |   1 -
 arch/arm/mach-pxa/pxa3xx-ulpi.c               | 385 ------------------
 arch/arm/mach-pxa/regs-u2d.h                  | 199 ---------
 drivers/usb/host/ohci-pxa27x.c                |   9 -
 include/linux/platform_data/usb-pxa3xx-ulpi.h |  32 --
 7 files changed, 1 insertion(+), 655 deletions(-)
 delete mode 100644 arch/arm/mach-pxa/pxa3xx-ulpi.c
 delete mode 100644 arch/arm/mach-pxa/regs-u2d.h
 delete mode 100644 include/linux/platform_data/usb-pxa3xx-ulpi.h

diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
index 4ca8cac2e60f..9624f90d9ef6 100644
--- a/arch/arm/mach-pxa/Makefile
+++ b/arch/arm/mach-pxa/Makefile
@@ -12,7 +12,7 @@ obj-$(CONFIG_PM)		+= pm.o sleep.o standby.o
 # SoC-specific code
 obj-$(CONFIG_PXA25x)		+= mfp-pxa2xx.o pxa2xx.o pxa25x.o
 obj-$(CONFIG_PXA27x)		+= mfp-pxa2xx.o pxa2xx.o pxa27x.o
-obj-$(CONFIG_PXA3xx)		+= mfp-pxa3xx.o pxa3xx.o smemc.o pxa3xx-ulpi.o
+obj-$(CONFIG_PXA3xx)		+= mfp-pxa3xx.o pxa3xx.o smemc.o
 obj-$(CONFIG_CPU_PXA300)	+= pxa300.o
 
 # NOTE: keep the order of boards in accordance to their order in Kconfig
diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index 72adaac9f332..8e3bc56d2044 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -12,7 +12,6 @@
 #include <linux/soc/pxa/cpu.h>
 
 #include "udc.h"
-#include <linux/platform_data/usb-pxa3xx-ulpi.h>
 #include <linux/platform_data/video-pxafb.h>
 #include <linux/platform_data/mmc-pxamci.h>
 #include "irqs.h"
@@ -130,33 +129,6 @@ struct platform_device pxa27x_device_udc = {
 	}
 };
 
-#ifdef CONFIG_PXA3xx
-static struct resource pxa3xx_u2d_resources[] = {
-	[0] = {
-		.start	= 0x54100000,
-		.end	= 0x54100fff,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_USB2,
-		.end	= IRQ_USB2,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device pxa3xx_device_u2d = {
-	.name		= "pxa3xx-u2d",
-	.id		= -1,
-	.resource	= pxa3xx_u2d_resources,
-	.num_resources	= ARRAY_SIZE(pxa3xx_u2d_resources),
-};
-
-void __init pxa3xx_set_u2d_info(struct pxa3xx_u2d_platform_data *info)
-{
-	pxa_register_device(&pxa3xx_device_u2d, info);
-}
-#endif /* CONFIG_PXA3xx */
-
 static struct resource pxafb_resources[] = {
 	[0] = {
 		.start	= 0x44000000,
diff --git a/arch/arm/mach-pxa/devices.h b/arch/arm/mach-pxa/devices.h
index 2828bea76cd7..82c83939017a 100644
--- a/arch/arm/mach-pxa/devices.h
+++ b/arch/arm/mach-pxa/devices.h
@@ -9,7 +9,6 @@ extern struct platform_device pxa3xx_device_mci2;
 extern struct platform_device pxa3xx_device_mci3;
 extern struct platform_device pxa25x_device_udc;
 extern struct platform_device pxa27x_device_udc;
-extern struct platform_device pxa3xx_device_u2d;
 extern struct platform_device pxa_device_fb;
 extern struct platform_device pxa_device_ffuart;
 extern struct platform_device pxa_device_btuart;
diff --git a/arch/arm/mach-pxa/pxa3xx-ulpi.c b/arch/arm/mach-pxa/pxa3xx-ulpi.c
deleted file mode 100644
index c29a7f0fa1b0..000000000000
diff --git a/arch/arm/mach-pxa/regs-u2d.h b/arch/arm/mach-pxa/regs-u2d.h
deleted file mode 100644
index ab517ba62c9a..000000000000
diff --git a/drivers/usb/host/ohci-pxa27x.c b/drivers/usb/host/ohci-pxa27x.c
index a1dad8745622..0bc7e96bcc93 100644
--- a/drivers/usb/host/ohci-pxa27x.c
+++ b/drivers/usb/host/ohci-pxa27x.c
@@ -29,7 +29,6 @@
 #include <linux/of_platform.h>
 #include <linux/of_gpio.h>
 #include <linux/platform_data/usb-ohci-pxa27x.h>
-#include <linux/platform_data/usb-pxa3xx-ulpi.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/signal.h>
@@ -275,7 +274,6 @@ static int pxa27x_start_hc(struct pxa27x_ohci *pxa_ohci, struct device *dev)
 	int retval;
 	struct pxaohci_platform_data *inf;
 	uint32_t uhchr;
-	struct usb_hcd *hcd = dev_get_drvdata(dev);
 
 	inf = dev_get_platdata(dev);
 
@@ -301,9 +299,6 @@ static int pxa27x_start_hc(struct pxa27x_ohci *pxa_ohci, struct device *dev)
 		return retval;
 	}
 
-	if (cpu_is_pxa3xx())
-		pxa3xx_u2d_start_hc(&hcd->self);
-
 	uhchr = __raw_readl(pxa_ohci->mmio_base + UHCHR) & ~UHCHR_SSE;
 	__raw_writel(uhchr, pxa_ohci->mmio_base + UHCHR);
 	__raw_writel(UHCHIE_UPRIE | UHCHIE_RWIE, pxa_ohci->mmio_base + UHCHIE);
@@ -316,14 +311,10 @@ static int pxa27x_start_hc(struct pxa27x_ohci *pxa_ohci, struct device *dev)
 static void pxa27x_stop_hc(struct pxa27x_ohci *pxa_ohci, struct device *dev)
 {
 	struct pxaohci_platform_data *inf;
-	struct usb_hcd *hcd = dev_get_drvdata(dev);
 	uint32_t uhccoms;
 
 	inf = dev_get_platdata(dev);
 
-	if (cpu_is_pxa3xx())
-		pxa3xx_u2d_stop_hc(&hcd->self);
-
 	if (inf->exit)
 		inf->exit(dev);
 
diff --git a/include/linux/platform_data/usb-pxa3xx-ulpi.h b/include/linux/platform_data/usb-pxa3xx-ulpi.h
deleted file mode 100644
index 4d31a5cbdeb1..000000000000
-- 
2.39.0

