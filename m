Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD84604BB5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJSPiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbiJSPhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:37:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82E8B76;
        Wed, 19 Oct 2022 08:33:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0218B824B9;
        Wed, 19 Oct 2022 15:32:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C99C433D6;
        Wed, 19 Oct 2022 15:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666193530;
        bh=82cKPvQWoiLgqK1oMyTW/GDI+OkzDuGCiLjkRqbHBXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZDdJdtG5R0XxjFJPvoIonjroGn8thLLo9SVb/TVU3ZhGnpLmtYCVPds7aaPhA2ZWB
         xCVRK7b1JA5cBkN1t5GSy/xxx5gDBAK6bklQI615zB91IsgaMeeTHvEshSD5f5DyGO
         tZHwuEbcw0XGo5H+osYmkUnszY74zPmrzllVtkXB69mUy8sNRKHfY/+tD4/e+2mSqA
         xpymiIHTCjq10Gv8Bq/5rK2LaUpZ8sxPBgIySjG0pwBfzMyrBAILCi4aJpZ7Lt9iez
         oG59VbcCkF7+yIdRorMmasWdEKZJl5uRz2jM3SrGRIkAphxmQKXk7/P3Cl/1+EyX+h
         r0Khc59YqWG6w==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Sekhar Nori <nsekhar@ti.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-arm-kernel@lists.infradead.org,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-clk@vger.kernel.org
Subject: [PATCH 02/14] ARM: davinci: drop DAVINCI_DMxxx references
Date:   Wed, 19 Oct 2022 17:29:28 +0200
Message-Id: <20221019152947.3857217-3-arnd@kernel.org>
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

Support for all the dm3xx/dm64xx SoCs is no longer
available, so drop all other references to those.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-davinci/cputype.h | 32 --------------------------------
 arch/arm/mach-davinci/serial.c  |  4 ----
 arch/arm/mach-davinci/usb.c     | 13 -------------
 drivers/clk/davinci/pll.c       |  8 --------
 drivers/clk/davinci/pll.h       |  5 -----
 drivers/clk/davinci/psc.c       |  6 ------
 drivers/clk/davinci/psc.h       |  7 -------
 include/linux/clk/davinci.h     |  9 ---------
 8 files changed, 84 deletions(-)

diff --git a/arch/arm/mach-davinci/cputype.h b/arch/arm/mach-davinci/cputype.h
index 4590afdbe449..87ee56068a16 100644
--- a/arch/arm/mach-davinci/cputype.h
+++ b/arch/arm/mach-davinci/cputype.h
@@ -25,10 +25,6 @@ struct davinci_id {
 };
 
 /* Can use lower 16 bits of cpu id  for a variant when required */
-#define	DAVINCI_CPU_ID_DM6446		0x64460000
-#define	DAVINCI_CPU_ID_DM6467		0x64670000
-#define	DAVINCI_CPU_ID_DM355		0x03550000
-#define	DAVINCI_CPU_ID_DM365		0x03650000
 #define	DAVINCI_CPU_ID_DA830		0x08300000
 #define	DAVINCI_CPU_ID_DA850		0x08500000
 
@@ -38,37 +34,9 @@ static inline int is_davinci_ ##type(void)				\
 	return (davinci_soc_info.cpu_id == (id));			\
 }
 
-IS_DAVINCI_CPU(dm644x, DAVINCI_CPU_ID_DM6446)
-IS_DAVINCI_CPU(dm646x, DAVINCI_CPU_ID_DM6467)
-IS_DAVINCI_CPU(dm355, DAVINCI_CPU_ID_DM355)
-IS_DAVINCI_CPU(dm365, DAVINCI_CPU_ID_DM365)
 IS_DAVINCI_CPU(da830, DAVINCI_CPU_ID_DA830)
 IS_DAVINCI_CPU(da850, DAVINCI_CPU_ID_DA850)
 
-#ifdef CONFIG_ARCH_DAVINCI_DM644x
-#define cpu_is_davinci_dm644x() is_davinci_dm644x()
-#else
-#define cpu_is_davinci_dm644x() 0
-#endif
-
-#ifdef CONFIG_ARCH_DAVINCI_DM646x
-#define cpu_is_davinci_dm646x() is_davinci_dm646x()
-#else
-#define cpu_is_davinci_dm646x() 0
-#endif
-
-#ifdef CONFIG_ARCH_DAVINCI_DM355
-#define cpu_is_davinci_dm355() is_davinci_dm355()
-#else
-#define cpu_is_davinci_dm355() 0
-#endif
-
-#ifdef CONFIG_ARCH_DAVINCI_DM365
-#define cpu_is_davinci_dm365() is_davinci_dm365()
-#else
-#define cpu_is_davinci_dm365() 0
-#endif
-
 #ifdef CONFIG_ARCH_DAVINCI_DA830
 #define cpu_is_davinci_da830() is_davinci_da830()
 #else
diff --git a/arch/arm/mach-davinci/serial.c b/arch/arm/mach-davinci/serial.c
index 7f7814807bb5..ac1929bb0ef2 100644
--- a/arch/arm/mach-davinci/serial.c
+++ b/arch/arm/mach-davinci/serial.c
@@ -40,10 +40,6 @@ static void __init davinci_serial_reset(struct plat_serial8250_port *p)
 	pwremu |= (0x3 << 13);
 	pwremu |= 0x1;
 	serial_write_reg(p, UART_DAVINCI_PWREMU, pwremu);
-
-	if (cpu_is_davinci_dm646x())
-		serial_write_reg(p, UART_DM646X_SCR,
-				 UART_DM646X_SCR_TX_WATERMARK);
 }
 
 int __init davinci_serial_init(struct platform_device *serial_dev)
diff --git a/arch/arm/mach-davinci/usb.c b/arch/arm/mach-davinci/usb.c
index a9e5c6e91e5d..9dc14c7977b3 100644
--- a/arch/arm/mach-davinci/usb.c
+++ b/arch/arm/mach-davinci/usb.c
@@ -41,11 +41,6 @@ static struct resource usb_resources[] = {
 		.flags          = IORESOURCE_IRQ,
 		.name		= "mc"
 	},
-	{
-		/* placeholder for the dedicated CPPI IRQ */
-		.flags          = IORESOURCE_IRQ,
-		.name		= "dma"
-	},
 };
 
 static u64 usb_dmamask = DMA_BIT_MASK(32);
@@ -67,14 +62,6 @@ void __init davinci_setup_usb(unsigned mA, unsigned potpgt_ms)
 	usb_data.power = mA > 510 ? 255 : mA / 2;
 	usb_data.potpgt = (potpgt_ms + 1) / 2;
 
-	if (cpu_is_davinci_dm646x()) {
-		/* Override the defaults as DM6467 uses different IRQs. */
-		usb_dev.resource[1].start = DAVINCI_INTC_IRQ(IRQ_DM646X_USBINT);
-		usb_dev.resource[2].start = DAVINCI_INTC_IRQ(
-							IRQ_DM646X_USBDMAINT);
-	} else	/* other devices don't have dedicated CPPI IRQ */
-		usb_dev.num_resources = 2;
-
 	platform_device_register(&usb_dev);
 }
 
diff --git a/drivers/clk/davinci/pll.c b/drivers/clk/davinci/pll.c
index f862f5e2b3fc..87bdf8879045 100644
--- a/drivers/clk/davinci/pll.c
+++ b/drivers/clk/davinci/pll.c
@@ -881,14 +881,6 @@ static const struct platform_device_id davinci_pll_id_table[] = {
 #ifdef CONFIG_ARCH_DAVINCI_DA850
 	{ .name = "da850-pll0",  .driver_data = (kernel_ulong_t)da850_pll0_init  },
 	{ .name = "da850-pll1",  .driver_data = (kernel_ulong_t)da850_pll1_init  },
-#endif
-#ifdef CONFIG_ARCH_DAVINCI_DM355
-	{ .name = "dm355-pll1",  .driver_data = (kernel_ulong_t)dm355_pll1_init  },
-	{ .name = "dm355-pll2",  .driver_data = (kernel_ulong_t)dm355_pll2_init  },
-#endif
-#ifdef CONFIG_ARCH_DAVINCI_DM365
-	{ .name = "dm365-pll1",  .driver_data = (kernel_ulong_t)dm365_pll1_init  },
-	{ .name = "dm365-pll2",  .driver_data = (kernel_ulong_t)dm365_pll2_init  },
 #endif
 	{ }
 };
diff --git a/drivers/clk/davinci/pll.h b/drivers/clk/davinci/pll.h
index 1773277bc690..20bfcec2d3b5 100644
--- a/drivers/clk/davinci/pll.h
+++ b/drivers/clk/davinci/pll.h
@@ -122,13 +122,8 @@ int of_davinci_pll_init(struct device *dev, struct device_node *node,
 
 /* Platform-specific callbacks */
 
-#ifdef CONFIG_ARCH_DAVINCI_DA850
 int da850_pll1_init(struct device *dev, void __iomem *base, struct regmap *cfgchip);
 void of_da850_pll0_init(struct device_node *node);
 int of_da850_pll1_init(struct device *dev, void __iomem *base, struct regmap *cfgchip);
-#endif
-#ifdef CONFIG_ARCH_DAVINCI_DM355
-int dm355_pll2_init(struct device *dev, void __iomem *base, struct regmap *cfgchip);
-#endif
 
 #endif /* __CLK_DAVINCI_PLL_H___ */
diff --git a/drivers/clk/davinci/psc.c b/drivers/clk/davinci/psc.c
index 42a59dbd49c8..cd85d9f158b0 100644
--- a/drivers/clk/davinci/psc.c
+++ b/drivers/clk/davinci/psc.c
@@ -510,12 +510,6 @@ static const struct platform_device_id davinci_psc_id_table[] = {
 #ifdef CONFIG_ARCH_DAVINCI_DA850
 	{ .name = "da850-psc0", .driver_data = (kernel_ulong_t)&da850_psc0_init_data },
 	{ .name = "da850-psc1", .driver_data = (kernel_ulong_t)&da850_psc1_init_data },
-#endif
-#ifdef CONFIG_ARCH_DAVINCI_DM355
-	{ .name = "dm355-psc",  .driver_data = (kernel_ulong_t)&dm355_psc_init_data  },
-#endif
-#ifdef CONFIG_ARCH_DAVINCI_DM365
-	{ .name = "dm365-psc",  .driver_data = (kernel_ulong_t)&dm365_psc_init_data  },
 #endif
 	{ }
 };
diff --git a/drivers/clk/davinci/psc.h b/drivers/clk/davinci/psc.h
index 5e382b675518..bd23f6fd56df 100644
--- a/drivers/clk/davinci/psc.h
+++ b/drivers/clk/davinci/psc.h
@@ -104,11 +104,4 @@ extern const struct davinci_psc_init_data da850_psc1_init_data;
 extern const struct davinci_psc_init_data of_da850_psc0_init_data;
 extern const struct davinci_psc_init_data of_da850_psc1_init_data;
 #endif
-#ifdef CONFIG_ARCH_DAVINCI_DM355
-extern const struct davinci_psc_init_data dm355_psc_init_data;
-#endif
-#ifdef CONFIG_ARCH_DAVINCI_DM365
-extern const struct davinci_psc_init_data dm365_psc_init_data;
-#endif
-
 #endif /* __CLK_DAVINCI_PSC_H__ */
diff --git a/include/linux/clk/davinci.h b/include/linux/clk/davinci.h
index f6ebab6228c2..e1d37451e03f 100644
--- a/include/linux/clk/davinci.h
+++ b/include/linux/clk/davinci.h
@@ -19,14 +19,5 @@ int da830_pll_init(struct device *dev, void __iomem *base, struct regmap *cfgchi
 #ifdef CONFIG_ARCH_DAVINCI_DA850
 int da850_pll0_init(struct device *dev, void __iomem *base, struct regmap *cfgchip);
 #endif
-#ifdef CONFIG_ARCH_DAVINCI_DM355
-int dm355_pll1_init(struct device *dev, void __iomem *base, struct regmap *cfgchip);
-int dm355_psc_init(struct device *dev, void __iomem *base);
-#endif
-#ifdef CONFIG_ARCH_DAVINCI_DM365
-int dm365_pll1_init(struct device *dev, void __iomem *base, struct regmap *cfgchip);
-int dm365_pll2_init(struct device *dev, void __iomem *base, struct regmap *cfgchip);
-int dm365_psc_init(struct device *dev, void __iomem *base);
-#endif
 
 #endif /* __LINUX_CLK_DAVINCI_PLL_H___ */
-- 
2.29.2

