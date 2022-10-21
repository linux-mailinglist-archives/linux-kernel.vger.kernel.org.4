Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9947E608002
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 22:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiJUUmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 16:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiJUUlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 16:41:44 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04502F88C2;
        Fri, 21 Oct 2022 13:40:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 740C2CE2B9F;
        Fri, 21 Oct 2022 20:40:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A57DC433C1;
        Fri, 21 Oct 2022 20:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666384841;
        bh=/tNUPCdaK/wGTBtTeurL6EEh+F2g5m+QqSH0mpAq7so=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lPdQIgHF/bVJq/CxKjE0QCTfGAIN9wCHTL1VpCKKb/dyhzTWFdKlJlrhoCy+0DkKA
         6TQh5uvwbH7j12PCnqVTtlHM/4fPadFooX4P1BTEos3+jIz3Kv6jPL6EiRYyW0M9l7
         YXCeQnnNbAWPlJCLLOGnvTJPp0fxoc4MV//MBLhMB5nB2roWfotrWueJT4V6q0akqN
         tk9QGnstKaw1Kaph+gjanOxbbvLimGvt7IxuszYs2qzkcdrqmlW7Ehnok4NZg9xQRI
         tB4ooRPFyIiwk+tFyr5s93qy1ugJeaoHpI6Tm/S3qLGUlS1yea/j4VF4An3dZtjKzl
         h8vciH0ZBWLrw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 05/21] ARM: s3c: simplify platform code
Date:   Fri, 21 Oct 2022 22:27:38 +0200
Message-Id: <20221021203329.4143397-5-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221021202254.4142411-1-arnd@kernel.org>
References: <20221021202254.4142411-1-arnd@kernel.org>
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

Following down the now unused symbols and header files, some additional
content can be dropped that is used by neither the s3c64xx DT support
nor the crag6410 board.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-s3c/Kconfig                    |  50 --
 arch/arm/mach-s3c/Kconfig.s3c64xx            |   5 -
 arch/arm/mach-s3c/Makefile                   |   2 -
 arch/arm/mach-s3c/Makefile.s3c64xx           |   1 -
 arch/arm/mach-s3c/adc-core.h                 |  24 -
 arch/arm/mach-s3c/ata-core-s3c64xx.h         |  24 -
 arch/arm/mach-s3c/backlight-s3c64xx.h        |  22 -
 arch/arm/mach-s3c/cpu.h                      |  47 --
 arch/arm/mach-s3c/dev-audio-s3c64xx.c        | 127 ----
 arch/arm/mach-s3c/devs.c                     | 725 -------------------
 arch/arm/mach-s3c/devs.h                     |  37 -
 arch/arm/mach-s3c/dma-s3c64xx.h              |  57 --
 arch/arm/mach-s3c/dma.h                      |   2 -
 arch/arm/mach-s3c/gpio-cfg-helpers.h         | 124 ----
 arch/arm/mach-s3c/gpio-cfg.h                 |  19 -
 arch/arm/mach-s3c/gpio-core.h                |   3 -
 arch/arm/mach-s3c/gpio-samsung.c             | 443 +----------
 arch/arm/mach-s3c/iic-core.h                 |   7 -
 arch/arm/mach-s3c/init.c                     |  26 +-
 arch/arm/mach-s3c/map-s3c.h                  |  37 -
 arch/arm/mach-s3c/onenand-core-s3c64xx.h     |  32 -
 arch/arm/mach-s3c/otom.h                     |  25 -
 arch/arm/mach-s3c/pm-core-s3c64xx.h          |  17 -
 arch/arm/mach-s3c/pm-s3c64xx.c               |  83 ---
 arch/arm/mach-s3c/pm.c                       |   7 +-
 arch/arm/mach-s3c/pm.h                       |  12 -
 arch/arm/mach-s3c/regs-srom-s3c64xx.h        |  55 --
 arch/arm/mach-s3c/s3c6400.c                  |   6 -
 arch/arm/mach-s3c/s3c6410.c                  |   9 -
 arch/arm/mach-s3c/sdhci.h                    |  25 -
 arch/arm/mach-s3c/setup-ide-s3c64xx.c        |  40 -
 arch/arm/mach-s3c/sleep-s3c64xx.S            |  27 -
 include/linux/platform_data/media/s5p_hdmi.h |  32 -
 33 files changed, 6 insertions(+), 2146 deletions(-)
 delete mode 100644 arch/arm/mach-s3c/adc-core.h
 delete mode 100644 arch/arm/mach-s3c/ata-core-s3c64xx.h
 delete mode 100644 arch/arm/mach-s3c/backlight-s3c64xx.h
 delete mode 100644 arch/arm/mach-s3c/dma-s3c64xx.h
 delete mode 100644 arch/arm/mach-s3c/dma.h
 delete mode 100644 arch/arm/mach-s3c/onenand-core-s3c64xx.h
 delete mode 100644 arch/arm/mach-s3c/otom.h
 delete mode 100644 arch/arm/mach-s3c/regs-srom-s3c64xx.h
 delete mode 100644 arch/arm/mach-s3c/setup-ide-s3c64xx.c
 delete mode 100644 include/linux/platform_data/media/s5p_hdmi.h

diff --git a/arch/arm/mach-s3c/Kconfig b/arch/arm/mach-s3c/Kconfig
index 0dde4010aa64..b3656109f1f7 100644
--- a/arch/arm/mach-s3c/Kconfig
+++ b/arch/arm/mach-s3c/Kconfig
@@ -90,36 +90,6 @@ config S3C_DEV_I2C1
 	help
 	  Compile in platform device definitions for I2C channel 1
 
-config S3C_DEV_I2C2
-	bool
-	help
-	  Compile in platform device definitions for I2C channel 2
-
-config S3C_DEV_I2C3
-	bool
-	help
-	  Compile in platform device definition for I2C controller 3
-
-config S3C_DEV_I2C4
-	bool
-	help
-	  Compile in platform device definition for I2C controller 4
-
-config S3C_DEV_I2C5
-	bool
-	help
-	  Compile in platform device definition for I2C controller 5
-
-config S3C_DEV_I2C6
-	bool
-	help
-	  Compile in platform device definition for I2C controller 6
-
-config S3C_DEV_I2C7
-	bool
-	help
-	  Compile in platform device definition for I2C controller 7
-
 config S3C_DEV_FB
 	bool
 	help
@@ -135,26 +105,6 @@ config S3C_DEV_USB_HSOTG
 	help
 	  Compile in platform device definition for USB high-speed OtG
 
-config S3C_DEV_WDT
-	bool
-	help
-	  Compile in platform device definition for Watchdog Timer
-
-config S3C_DEV_NAND
-	bool
-	help
-	  Compile in platform device definition for NAND controller
-
-config S3C_DEV_ONENAND
-	bool
-	help
-	  Compile in platform device definition for OneNAND controller
-
-config S3C_DEV_RTC
-	bool
-	help
-	  Compile in platform device definition for RTC
-
 config S3C64XX_DEV_SPI0
 	bool
 	help
diff --git a/arch/arm/mach-s3c/Kconfig.s3c64xx b/arch/arm/mach-s3c/Kconfig.s3c64xx
index c403d7642f0a..c52c7ce1d8fa 100644
--- a/arch/arm/mach-s3c/Kconfig.s3c64xx
+++ b/arch/arm/mach-s3c/Kconfig.s3c64xx
@@ -15,12 +15,9 @@ menuconfig ARCH_S3C64XX
 	select HAVE_TCM
 	select PLAT_SAMSUNG
 	select PM_GENERIC_DOMAINS if PM
-	select S3C_DEV_NAND if ATAGS
 	select S3C_GPIO_TRACK if ATAGS
-	select S3C2410_WATCHDOG
 	select SAMSUNG_ATAGS if ATAGS
 	select SAMSUNG_WAKEMASK if PM
-	select WATCHDOG
 	help
 	  Samsung S3C64XX series based systems
 
@@ -121,10 +118,8 @@ config MACH_WLF_CRAGG_6410
 	select S3C_DEV_HSMMC1
 	select S3C_DEV_HSMMC2
 	select S3C_DEV_I2C1
-	select S3C_DEV_RTC
 	select S3C_DEV_USB_HOST
 	select S3C_DEV_USB_HSOTG
-	select S3C_DEV_WDT
 	select SAMSUNG_DEV_KEYPAD
 	select SAMSUNG_DEV_PWM
 	help
diff --git a/arch/arm/mach-s3c/Makefile b/arch/arm/mach-s3c/Makefile
index bae7316be5c7..988c49672715 100644
--- a/arch/arm/mach-s3c/Makefile
+++ b/arch/arm/mach-s3c/Makefile
@@ -11,7 +11,6 @@ obj-y				+= init.o cpu.o
 # devices
 
 obj-$(CONFIG_SAMSUNG_ATAGS)	+= platformdata.o
-
 obj-$(CONFIG_SAMSUNG_ATAGS)	+= devs.o
 obj-$(CONFIG_SAMSUNG_ATAGS)	+= dev-uart.o
 
@@ -21,5 +20,4 @@ obj-$(CONFIG_GPIO_SAMSUNG)     += gpio-samsung.o
 
 obj-$(CONFIG_SAMSUNG_PM)	+= pm.o pm-common.o
 obj-$(CONFIG_SAMSUNG_PM_GPIO)	+= pm-gpio.o
-
 obj-$(CONFIG_SAMSUNG_WAKEMASK)	+= wakeup-mask.o
diff --git a/arch/arm/mach-s3c/Makefile.s3c64xx b/arch/arm/mach-s3c/Makefile.s3c64xx
index ba179a22c2af..13cda2fe7b6c 100644
--- a/arch/arm/mach-s3c/Makefile.s3c64xx
+++ b/arch/arm/mach-s3c/Makefile.s3c64xx
@@ -33,7 +33,6 @@ obj-y				+= dev-audio-s3c64xx.o
 obj-$(CONFIG_S3C64XX_SETUP_FB_24BPP)	+= setup-fb-24bpp-s3c64xx.o
 obj-$(CONFIG_S3C64XX_SETUP_I2C0)	+= setup-i2c0-s3c64xx.o
 obj-$(CONFIG_S3C64XX_SETUP_I2C1)	+= setup-i2c1-s3c64xx.o
-obj-$(CONFIG_S3C64XX_SETUP_IDE)		+= setup-ide-s3c64xx.o
 obj-$(CONFIG_S3C64XX_SETUP_KEYPAD)	+= setup-keypad-s3c64xx.o
 obj-$(CONFIG_S3C64XX_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio-s3c64xx.o
 obj-$(CONFIG_S3C64XX_SETUP_SPI)		+= setup-spi-s3c64xx.o
diff --git a/arch/arm/mach-s3c/adc-core.h b/arch/arm/mach-s3c/adc-core.h
deleted file mode 100644
index 039f6862b6a7..000000000000
diff --git a/arch/arm/mach-s3c/ata-core-s3c64xx.h b/arch/arm/mach-s3c/ata-core-s3c64xx.h
deleted file mode 100644
index 4863ad9d3a42..000000000000
diff --git a/arch/arm/mach-s3c/backlight-s3c64xx.h b/arch/arm/mach-s3c/backlight-s3c64xx.h
deleted file mode 100644
index 2a2b35821d58..000000000000
diff --git a/arch/arm/mach-s3c/cpu.h b/arch/arm/mach-s3c/cpu.h
index 20ff98d05c53..d0adc9b40e25 100644
--- a/arch/arm/mach-s3c/cpu.h
+++ b/arch/arm/mach-s3c/cpu.h
@@ -16,15 +16,6 @@
 
 extern unsigned long samsung_cpu_id;
 
-#define S3C2410_CPU_ID		0x32410000
-#define S3C2410_CPU_MASK	0xFFFFFFFF
-
-#define S3C24XX_CPU_ID		0x32400000
-#define S3C24XX_CPU_MASK	0xFFF00000
-
-#define S3C2412_CPU_ID		0x32412000
-#define S3C2412_CPU_MASK	0xFFFFF000
-
 #define S3C6400_CPU_ID		0x36400000
 #define S3C6410_CPU_ID		0x36410000
 #define S3C64XX_CPU_MASK	0xFFFFF000
@@ -38,29 +29,9 @@ static inline int is_samsung_##name(void)	\
 	return ((samsung_cpu_id & mask) == (id & mask));	\
 }
 
-IS_SAMSUNG_CPU(s3c2410, S3C2410_CPU_ID, S3C2410_CPU_MASK)
-IS_SAMSUNG_CPU(s3c24xx, S3C24XX_CPU_ID, S3C24XX_CPU_MASK)
-IS_SAMSUNG_CPU(s3c2412, S3C2412_CPU_ID, S3C2412_CPU_MASK)
 IS_SAMSUNG_CPU(s3c6400, S3C6400_CPU_ID, S3C64XX_CPU_MASK)
 IS_SAMSUNG_CPU(s3c6410, S3C6410_CPU_ID, S3C64XX_CPU_MASK)
 
-#if defined(CONFIG_CPU_S3C2410) || defined(CONFIG_CPU_S3C2412) || \
-    defined(CONFIG_CPU_S3C2416) || defined(CONFIG_CPU_S3C2440) || \
-    defined(CONFIG_CPU_S3C2442) || defined(CONFIG_CPU_S3C244X) || \
-    defined(CONFIG_CPU_S3C2443)
-# define soc_is_s3c24xx()	is_samsung_s3c24xx()
-# define soc_is_s3c2410()	is_samsung_s3c2410()
-#else
-# define soc_is_s3c24xx()	0
-# define soc_is_s3c2410()	0
-#endif
-
-#if defined(CONFIG_CPU_S3C2412)
-# define soc_is_s3c2412()	is_samsung_s3c2412()
-#else
-# define soc_is_s3c2412()	0
-#endif
-
 #if defined(CONFIG_CPU_S3C6400) || defined(CONFIG_CPU_S3C6410)
 # define soc_is_s3c6400()	is_samsung_s3c6400()
 # define soc_is_s3c6410()	is_samsung_s3c6410()
@@ -71,12 +42,6 @@ IS_SAMSUNG_CPU(s3c6410, S3C6410_CPU_ID, S3C64XX_CPU_MASK)
 # define soc_is_s3c64xx()	0
 #endif
 
-#define IODESC_ENT(x) { (unsigned long)S3C24XX_VA_##x, __phys_to_pfn(S3C24XX_PA_##x), S3C24XX_SZ_##x, MT_DEVICE }
-
-#ifndef KHZ
-#define KHZ (1000)
-#endif
-
 #ifndef MHZ
 #define MHZ (1000*1000)
 #endif
@@ -96,7 +61,6 @@ struct cpu_table {
 	unsigned long	idmask;
 	void		(*map_io)(void);
 	void		(*init_uarts)(struct s3c2410_uartcfg *cfg, int no);
-	void		(*init_clocks)(int xtal);
 	int		(*init)(void);
 	const char	*name;
 };
@@ -105,24 +69,13 @@ extern void s3c_init_cpu(unsigned long idcode,
 			 struct cpu_table *cpus, unsigned int cputab_size);
 
 /* core initialisation functions */
-
-extern void s3c24xx_init_io(struct map_desc *mach_desc, int size);
-
 extern void s3c64xx_init_cpu(void);
 
 extern void s3c24xx_init_uarts(struct s3c2410_uartcfg *cfg, int no);
-
-extern void s3c24xx_init_clocks(int xtal);
-
 extern void s3c24xx_init_uartdevs(char *name,
 				  struct s3c24xx_uart_resources *res,
 				  struct s3c2410_uartcfg *cfg, int no);
 
-extern struct syscore_ops s3c2410_pm_syscore_ops;
-extern struct syscore_ops s3c2412_pm_syscore_ops;
-extern struct syscore_ops s3c2416_pm_syscore_ops;
-extern struct syscore_ops s3c244x_pm_syscore_ops;
-
 extern struct bus_type s3c6410_subsys;
 
 #endif
diff --git a/arch/arm/mach-s3c/dev-audio-s3c64xx.c b/arch/arm/mach-s3c/dev-audio-s3c64xx.c
index 909e82c148ba..7ce119dc3a72 100644
--- a/arch/arm/mach-s3c/dev-audio-s3c64xx.c
+++ b/arch/arm/mach-s3c/dev-audio-s3c64xx.c
@@ -83,130 +83,3 @@ struct platform_device s3c64xx_device_iis1 = {
 	},
 };
 EXPORT_SYMBOL(s3c64xx_device_iis1);
-
-static struct resource s3c64xx_iisv4_resource[] = {
-	[0] = DEFINE_RES_MEM(S3C64XX_PA_IISV4, SZ_256),
-};
-
-static struct s3c_audio_pdata i2sv4_pdata = {
-	.cfg_gpio = s3c64xx_i2s_cfg_gpio,
-	.type = {
-		.quirks = QUIRK_PRI_6CHAN,
-	},
-};
-
-struct platform_device s3c64xx_device_iisv4 = {
-	.name = "samsung-i2s",
-	.id = 2,
-	.num_resources	  = ARRAY_SIZE(s3c64xx_iisv4_resource),
-	.resource	  = s3c64xx_iisv4_resource,
-	.dev = {
-		.platform_data = &i2sv4_pdata,
-	},
-};
-EXPORT_SYMBOL(s3c64xx_device_iisv4);
-
-
-/* PCM Controller platform_devices */
-
-static int s3c64xx_pcm_cfg_gpio(struct platform_device *pdev)
-{
-	unsigned int base;
-
-	switch (pdev->id) {
-	case 0:
-		base = S3C64XX_GPD(0);
-		break;
-	case 1:
-		base = S3C64XX_GPE(0);
-		break;
-	default:
-		printk(KERN_DEBUG "Invalid PCM Controller number: %d\n",
-			pdev->id);
-		return -EINVAL;
-	}
-
-	s3c_gpio_cfgpin_range(base, 5, S3C_GPIO_SFN(2));
-	return 0;
-}
-
-static struct resource s3c64xx_pcm0_resource[] = {
-	[0] = DEFINE_RES_MEM(S3C64XX_PA_PCM0, SZ_256),
-};
-
-static struct s3c_audio_pdata s3c_pcm0_pdata = {
-	.cfg_gpio = s3c64xx_pcm_cfg_gpio,
-};
-
-struct platform_device s3c64xx_device_pcm0 = {
-	.name		  = "samsung-pcm",
-	.id		  = 0,
-	.num_resources	  = ARRAY_SIZE(s3c64xx_pcm0_resource),
-	.resource	  = s3c64xx_pcm0_resource,
-	.dev = {
-		.platform_data = &s3c_pcm0_pdata,
-	},
-};
-EXPORT_SYMBOL(s3c64xx_device_pcm0);
-
-static struct resource s3c64xx_pcm1_resource[] = {
-	[0] = DEFINE_RES_MEM(S3C64XX_PA_PCM1, SZ_256),
-};
-
-static struct s3c_audio_pdata s3c_pcm1_pdata = {
-	.cfg_gpio = s3c64xx_pcm_cfg_gpio,
-};
-
-struct platform_device s3c64xx_device_pcm1 = {
-	.name		  = "samsung-pcm",
-	.id		  = 1,
-	.num_resources	  = ARRAY_SIZE(s3c64xx_pcm1_resource),
-	.resource	  = s3c64xx_pcm1_resource,
-	.dev = {
-		.platform_data = &s3c_pcm1_pdata,
-	},
-};
-EXPORT_SYMBOL(s3c64xx_device_pcm1);
-
-/* AC97 Controller platform devices */
-
-static int s3c64xx_ac97_cfg_gpd(struct platform_device *pdev)
-{
-	return s3c_gpio_cfgpin_range(S3C64XX_GPD(0), 5, S3C_GPIO_SFN(4));
-}
-
-static int s3c64xx_ac97_cfg_gpe(struct platform_device *pdev)
-{
-	return s3c_gpio_cfgpin_range(S3C64XX_GPE(0), 5, S3C_GPIO_SFN(4));
-}
-
-static struct resource s3c64xx_ac97_resource[] = {
-	[0] = DEFINE_RES_MEM(S3C64XX_PA_AC97, SZ_256),
-	[1] = DEFINE_RES_IRQ(IRQ_AC97),
-};
-
-static struct s3c_audio_pdata s3c_ac97_pdata = {
-};
-
-static u64 s3c64xx_ac97_dmamask = DMA_BIT_MASK(32);
-
-struct platform_device s3c64xx_device_ac97 = {
-	.name		  = "samsung-ac97",
-	.id		  = -1,
-	.num_resources	  = ARRAY_SIZE(s3c64xx_ac97_resource),
-	.resource	  = s3c64xx_ac97_resource,
-	.dev = {
-		.platform_data = &s3c_ac97_pdata,
-		.dma_mask = &s3c64xx_ac97_dmamask,
-		.coherent_dma_mask = DMA_BIT_MASK(32),
-	},
-};
-EXPORT_SYMBOL(s3c64xx_device_ac97);
-
-void __init s3c64xx_ac97_setup_gpio(int num)
-{
-	if (num == S3C64XX_AC97_GPD)
-		s3c_ac97_pdata.cfg_gpio = s3c64xx_ac97_cfg_gpd;
-	else
-		s3c_ac97_pdata.cfg_gpio = s3c64xx_ac97_cfg_gpe;
-}
diff --git a/arch/arm/mach-s3c/devs.c b/arch/arm/mach-s3c/devs.c
index a31d1c3038e8..8c26d592d2a3 100644
--- a/arch/arm/mach-s3c/devs.c
+++ b/arch/arm/mach-s3c/devs.c
@@ -21,17 +21,11 @@
 #include <linux/dma-mapping.h>
 #include <linux/fb.h>
 #include <linux/gfp.h>
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/onenand.h>
-#include <linux/mtd/partitions.h>
 #include <linux/mmc/host.h>
 #include <linux/ioport.h>
 #include <linux/sizes.h>
-#include <linux/platform_data/s3c-hsudc.h>
 #include <linux/platform_data/s3c-hsotg.h>
 
-#include <linux/platform_data/media/s5p_hdmi.h>
-
 #include <asm/irq.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -42,104 +36,19 @@
 #include "gpio-samsung.h"
 #include "gpio-cfg.h"
 
-#ifdef CONFIG_PLAT_S3C24XX
-#include "regs-s3c2443-clock.h"
-#endif /* CONFIG_PLAT_S3C24XX */
-
 #include "cpu.h"
 #include "devs.h"
-#include <linux/soc/samsung/s3c-adc.h>
-#include <linux/platform_data/ata-samsung_cf.h>
 #include "fb.h"
-#include <linux/platform_data/fb-s3c2410.h>
-#include <linux/platform_data/hwmon-s3c.h>
 #include <linux/platform_data/i2c-s3c2410.h>
 #include "keypad.h"
-#include <linux/platform_data/mmc-s3cmci.h>
-#include <linux/platform_data/mtd-nand-s3c2410.h>
 #include "pwm-core.h"
 #include "sdhci.h"
-#include <linux/platform_data/touchscreen-s3c2410.h>
-#include <linux/platform_data/usb-s3c2410_udc.h>
-#include <linux/platform_data/usb-ohci-s3c2410.h>
 #include "usb-phy.h"
 #include <linux/platform_data/asoc-s3c.h>
 #include <linux/platform_data/spi-s3c64xx.h>
 
 #define samsung_device_dma_mask (*((u64[]) { DMA_BIT_MASK(32) }))
 
-/* AC97 */
-#ifdef CONFIG_CPU_S3C2440
-static struct resource s3c_ac97_resource[] = {
-	[0] = DEFINE_RES_MEM(S3C2440_PA_AC97, S3C2440_SZ_AC97),
-	[1] = DEFINE_RES_IRQ(IRQ_S3C244X_AC97),
-};
-
-struct platform_device s3c_device_ac97 = {
-	.name		= "samsung-ac97",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(s3c_ac97_resource),
-	.resource	= s3c_ac97_resource,
-	.dev		= {
-		.dma_mask		= &samsung_device_dma_mask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	}
-};
-#endif /* CONFIG_CPU_S3C2440 */
-
-/* ADC */
-
-#ifdef CONFIG_PLAT_S3C24XX
-static struct resource s3c_adc_resource[] = {
-	[0] = DEFINE_RES_MEM(S3C24XX_PA_ADC, S3C24XX_SZ_ADC),
-	[1] = DEFINE_RES_IRQ(IRQ_TC),
-	[2] = DEFINE_RES_IRQ(IRQ_ADC),
-};
-
-struct platform_device s3c_device_adc = {
-	.name		= "s3c24xx-adc",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(s3c_adc_resource),
-	.resource	= s3c_adc_resource,
-};
-#endif /* CONFIG_PLAT_S3C24XX */
-
-#if defined(CONFIG_SAMSUNG_DEV_ADC)
-static struct resource s3c_adc_resource[] = {
-	[0] = DEFINE_RES_MEM(SAMSUNG_PA_ADC, SZ_256),
-	[1] = DEFINE_RES_IRQ(IRQ_ADC),
-	[2] = DEFINE_RES_IRQ(IRQ_TC),
-};
-
-struct platform_device s3c_device_adc = {
-	.name		= "exynos-adc",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(s3c_adc_resource),
-	.resource	= s3c_adc_resource,
-};
-#endif /* CONFIG_SAMSUNG_DEV_ADC */
-
-/* Camif Controller */
-
-#ifdef CONFIG_CPU_S3C2440
-static struct resource s3c_camif_resource[] = {
-	[0] = DEFINE_RES_MEM(S3C2440_PA_CAMIF, S3C2440_SZ_CAMIF),
-	[1] = DEFINE_RES_IRQ(IRQ_S3C2440_CAM_C),
-	[2] = DEFINE_RES_IRQ(IRQ_S3C2440_CAM_P),
-};
-
-struct platform_device s3c_device_camif = {
-	.name		= "s3c2440-camif",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(s3c_camif_resource),
-	.resource	= s3c_camif_resource,
-	.dev		= {
-		.dma_mask		= &samsung_device_dma_mask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	}
-};
-#endif /* CONFIG_CPU_S3C2440 */
-
 /* FB */
 
 #ifdef CONFIG_S3C_DEV_FB
@@ -168,22 +77,6 @@ void __init s3c_fb_set_platdata(struct s3c_fb_platdata *pd)
 }
 #endif /* CONFIG_S3C_DEV_FB */
 
-/* HWMON */
-
-#ifdef CONFIG_S3C_DEV_HWMON
-struct platform_device s3c_device_hwmon = {
-	.name		= "s3c-hwmon",
-	.id		= -1,
-	.dev.parent	= &s3c_device_adc.dev,
-};
-
-void __init s3c_hwmon_set_platdata(struct s3c_hwmon_pdata *pd)
-{
-	s3c_set_platdata(pd, sizeof(struct s3c_hwmon_pdata),
-			 &s3c_device_hwmon);
-}
-#endif /* CONFIG_S3C_DEV_HWMON */
-
 /* HSMMC */
 
 #ifdef CONFIG_S3C_DEV_HSMMC
@@ -373,220 +266,6 @@ void __init s3c_i2c1_set_platdata(struct s3c2410_platform_i2c *pd)
 }
 #endif /* CONFIG_S3C_DEV_I2C1 */
 
-#ifdef CONFIG_S3C_DEV_I2C2
-static struct resource s3c_i2c2_resource[] = {
-	[0] = DEFINE_RES_MEM(S3C_PA_IIC2, SZ_4K),
-	[1] = DEFINE_RES_IRQ(IRQ_IIC2),
-};
-
-struct platform_device s3c_device_i2c2 = {
-	.name		= "s3c2410-i2c",
-	.id		= 2,
-	.num_resources	= ARRAY_SIZE(s3c_i2c2_resource),
-	.resource	= s3c_i2c2_resource,
-};
-
-void __init s3c_i2c2_set_platdata(struct s3c2410_platform_i2c *pd)
-{
-	struct s3c2410_platform_i2c *npd;
-
-	if (!pd) {
-		pd = &default_i2c_data;
-		pd->bus_num = 2;
-	}
-
-	npd = s3c_set_platdata(pd, sizeof(*npd), &s3c_device_i2c2);
-
-	if (!npd->cfg_gpio)
-		npd->cfg_gpio = s3c_i2c2_cfg_gpio;
-}
-#endif /* CONFIG_S3C_DEV_I2C2 */
-
-#ifdef CONFIG_S3C_DEV_I2C3
-static struct resource s3c_i2c3_resource[] = {
-	[0] = DEFINE_RES_MEM(S3C_PA_IIC3, SZ_4K),
-	[1] = DEFINE_RES_IRQ(IRQ_IIC3),
-};
-
-struct platform_device s3c_device_i2c3 = {
-	.name		= "s3c2440-i2c",
-	.id		= 3,
-	.num_resources	= ARRAY_SIZE(s3c_i2c3_resource),
-	.resource	= s3c_i2c3_resource,
-};
-
-void __init s3c_i2c3_set_platdata(struct s3c2410_platform_i2c *pd)
-{
-	struct s3c2410_platform_i2c *npd;
-
-	if (!pd) {
-		pd = &default_i2c_data;
-		pd->bus_num = 3;
-	}
-
-	npd = s3c_set_platdata(pd, sizeof(*npd), &s3c_device_i2c3);
-
-	if (!npd->cfg_gpio)
-		npd->cfg_gpio = s3c_i2c3_cfg_gpio;
-}
-#endif /*CONFIG_S3C_DEV_I2C3 */
-
-#ifdef CONFIG_S3C_DEV_I2C4
-static struct resource s3c_i2c4_resource[] = {
-	[0] = DEFINE_RES_MEM(S3C_PA_IIC4, SZ_4K),
-	[1] = DEFINE_RES_IRQ(IRQ_IIC4),
-};
-
-struct platform_device s3c_device_i2c4 = {
-	.name		= "s3c2440-i2c",
-	.id		= 4,
-	.num_resources	= ARRAY_SIZE(s3c_i2c4_resource),
-	.resource	= s3c_i2c4_resource,
-};
-
-void __init s3c_i2c4_set_platdata(struct s3c2410_platform_i2c *pd)
-{
-	struct s3c2410_platform_i2c *npd;
-
-	if (!pd) {
-		pd = &default_i2c_data;
-		pd->bus_num = 4;
-	}
-
-	npd = s3c_set_platdata(pd, sizeof(*npd), &s3c_device_i2c4);
-
-	if (!npd->cfg_gpio)
-		npd->cfg_gpio = s3c_i2c4_cfg_gpio;
-}
-#endif /*CONFIG_S3C_DEV_I2C4 */
-
-#ifdef CONFIG_S3C_DEV_I2C5
-static struct resource s3c_i2c5_resource[] = {
-	[0] = DEFINE_RES_MEM(S3C_PA_IIC5, SZ_4K),
-	[1] = DEFINE_RES_IRQ(IRQ_IIC5),
-};
-
-struct platform_device s3c_device_i2c5 = {
-	.name		= "s3c2440-i2c",
-	.id		= 5,
-	.num_resources	= ARRAY_SIZE(s3c_i2c5_resource),
-	.resource	= s3c_i2c5_resource,
-};
-
-void __init s3c_i2c5_set_platdata(struct s3c2410_platform_i2c *pd)
-{
-	struct s3c2410_platform_i2c *npd;
-
-	if (!pd) {
-		pd = &default_i2c_data;
-		pd->bus_num = 5;
-	}
-
-	npd = s3c_set_platdata(pd, sizeof(*npd), &s3c_device_i2c5);
-
-	if (!npd->cfg_gpio)
-		npd->cfg_gpio = s3c_i2c5_cfg_gpio;
-}
-#endif /*CONFIG_S3C_DEV_I2C5 */
-
-#ifdef CONFIG_S3C_DEV_I2C6
-static struct resource s3c_i2c6_resource[] = {
-	[0] = DEFINE_RES_MEM(S3C_PA_IIC6, SZ_4K),
-	[1] = DEFINE_RES_IRQ(IRQ_IIC6),
-};
-
-struct platform_device s3c_device_i2c6 = {
-	.name		= "s3c2440-i2c",
-	.id		= 6,
-	.num_resources	= ARRAY_SIZE(s3c_i2c6_resource),
-	.resource	= s3c_i2c6_resource,
-};
-
-void __init s3c_i2c6_set_platdata(struct s3c2410_platform_i2c *pd)
-{
-	struct s3c2410_platform_i2c *npd;
-
-	if (!pd) {
-		pd = &default_i2c_data;
-		pd->bus_num = 6;
-	}
-
-	npd = s3c_set_platdata(pd, sizeof(*npd), &s3c_device_i2c6);
-
-	if (!npd->cfg_gpio)
-		npd->cfg_gpio = s3c_i2c6_cfg_gpio;
-}
-#endif /* CONFIG_S3C_DEV_I2C6 */
-
-#ifdef CONFIG_S3C_DEV_I2C7
-static struct resource s3c_i2c7_resource[] = {
-	[0] = DEFINE_RES_MEM(S3C_PA_IIC7, SZ_4K),
-	[1] = DEFINE_RES_IRQ(IRQ_IIC7),
-};
-
-struct platform_device s3c_device_i2c7 = {
-	.name		= "s3c2440-i2c",
-	.id		= 7,
-	.num_resources	= ARRAY_SIZE(s3c_i2c7_resource),
-	.resource	= s3c_i2c7_resource,
-};
-
-void __init s3c_i2c7_set_platdata(struct s3c2410_platform_i2c *pd)
-{
-	struct s3c2410_platform_i2c *npd;
-
-	if (!pd) {
-		pd = &default_i2c_data;
-		pd->bus_num = 7;
-	}
-
-	npd = s3c_set_platdata(pd, sizeof(*npd), &s3c_device_i2c7);
-
-	if (!npd->cfg_gpio)
-		npd->cfg_gpio = s3c_i2c7_cfg_gpio;
-}
-#endif /* CONFIG_S3C_DEV_I2C7 */
-
-/* I2S */
-
-#ifdef CONFIG_PLAT_S3C24XX
-static struct resource s3c_iis_resource[] = {
-	[0] = DEFINE_RES_MEM(S3C24XX_PA_IIS, S3C24XX_SZ_IIS),
-};
-
-struct platform_device s3c_device_iis = {
-	.name		= "s3c24xx-iis",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(s3c_iis_resource),
-	.resource	= s3c_iis_resource,
-	.dev		= {
-		.dma_mask		= &samsung_device_dma_mask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	}
-};
-#endif /* CONFIG_PLAT_S3C24XX */
-
-/* IDE CFCON */
-
-#ifdef CONFIG_SAMSUNG_DEV_IDE
-static struct resource s3c_cfcon_resource[] = {
-	[0] = DEFINE_RES_MEM(SAMSUNG_PA_CFCON, SZ_16K),
-	[1] = DEFINE_RES_IRQ(IRQ_CFCON),
-};
-
-struct platform_device s3c_device_cfcon = {
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(s3c_cfcon_resource),
-	.resource	= s3c_cfcon_resource,
-};
-
-void __init s3c_ide_set_platdata(struct s3c_ide_platdata *pdata)
-{
-	s3c_set_platdata(pdata, sizeof(struct s3c_ide_platdata),
-			 &s3c_device_cfcon);
-}
-#endif /* CONFIG_SAMSUNG_DEV_IDE */
-
 /* KEYPAD */
 
 #ifdef CONFIG_SAMSUNG_DEV_KEYPAD
@@ -613,175 +292,6 @@ void __init samsung_keypad_set_platdata(struct samsung_keypad_platdata *pd)
 }
 #endif /* CONFIG_SAMSUNG_DEV_KEYPAD */
 
-/* LCD Controller */
-
-#ifdef CONFIG_PLAT_S3C24XX
-static struct resource s3c_lcd_resource[] = {
-	[0] = DEFINE_RES_MEM(S3C24XX_PA_LCD, S3C24XX_SZ_LCD),
-	[1] = DEFINE_RES_IRQ(IRQ_LCD),
-};
-
-struct platform_device s3c_device_lcd = {
-	.name		= "s3c2410-lcd",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(s3c_lcd_resource),
-	.resource	= s3c_lcd_resource,
-	.dev		= {
-		.dma_mask		= &samsung_device_dma_mask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	}
-};
-
-void __init s3c24xx_fb_set_platdata(struct s3c2410fb_mach_info *pd)
-{
-	struct s3c2410fb_mach_info *npd;
-
-	npd = s3c_set_platdata(pd, sizeof(*npd), &s3c_device_lcd);
-	if (npd) {
-		npd->displays = kmemdup(pd->displays,
-			sizeof(struct s3c2410fb_display) * npd->num_displays,
-			GFP_KERNEL);
-		if (!npd->displays)
-			printk(KERN_ERR "no memory for LCD display data\n");
-	} else {
-		printk(KERN_ERR "no memory for LCD platform data\n");
-	}
-}
-#endif /* CONFIG_PLAT_S3C24XX */
-
-/* NAND */
-
-#ifdef CONFIG_S3C_DEV_NAND
-static struct resource s3c_nand_resource[] = {
-	[0] = DEFINE_RES_MEM(S3C_PA_NAND, SZ_1M),
-};
-
-struct platform_device s3c_device_nand = {
-	.name		= "s3c2410-nand",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(s3c_nand_resource),
-	.resource	= s3c_nand_resource,
-};
-
-/*
- * s3c_nand_copy_set() - copy nand set data
- * @set: The new structure, directly copied from the old.
- *
- * Copy all the fields from the NAND set field from what is probably __initdata
- * to new kernel memory. The code returns 0 if the copy happened correctly or
- * an error code for the calling function to display.
- *
- * Note, we currently do not try and look to see if we've already copied the
- * data in a previous set.
- */
-static int __init s3c_nand_copy_set(struct s3c2410_nand_set *set)
-{
-	void *ptr;
-	int size;
-
-	size = sizeof(struct mtd_partition) * set->nr_partitions;
-	if (size) {
-		ptr = kmemdup(set->partitions, size, GFP_KERNEL);
-		set->partitions = ptr;
-
-		if (!ptr)
-			return -ENOMEM;
-	}
-
-	if (set->nr_map && set->nr_chips) {
-		size = sizeof(int) * set->nr_chips;
-		ptr = kmemdup(set->nr_map, size, GFP_KERNEL);
-		set->nr_map = ptr;
-
-		if (!ptr)
-			return -ENOMEM;
-	}
-
-	return 0;
-}
-
-void __init s3c_nand_set_platdata(struct s3c2410_platform_nand *nand)
-{
-	struct s3c2410_platform_nand *npd;
-	int size;
-	int ret;
-
-	/* note, if we get a failure in allocation, we simply drop out of the
-	 * function. If there is so little memory available at initialisation
-	 * time then there is little chance the system is going to run.
-	 */
-
-	npd = s3c_set_platdata(nand, sizeof(*npd), &s3c_device_nand);
-	if (!npd)
-		return;
-
-	/* now see if we need to copy any of the nand set data */
-
-	size = sizeof(struct s3c2410_nand_set) * npd->nr_sets;
-	if (size) {
-		struct s3c2410_nand_set *from = npd->sets;
-		struct s3c2410_nand_set *to;
-		int i;
-
-		to = kmemdup(from, size, GFP_KERNEL);
-		npd->sets = to;	/* set, even if we failed */
-
-		if (!to) {
-			printk(KERN_ERR "%s: no memory for sets\n", __func__);
-			return;
-		}
-
-		for (i = 0; i < npd->nr_sets; i++) {
-			ret = s3c_nand_copy_set(to);
-			if (ret) {
-				printk(KERN_ERR "%s: failed to copy set %d\n",
-				__func__, i);
-				return;
-			}
-			to++;
-		}
-	}
-}
-#endif /* CONFIG_S3C_DEV_NAND */
-
-/* ONENAND */
-
-#ifdef CONFIG_S3C_DEV_ONENAND
-static struct resource s3c_onenand_resources[] = {
-	[0] = DEFINE_RES_MEM(S3C_PA_ONENAND, SZ_1K),
-	[1] = DEFINE_RES_MEM(S3C_PA_ONENAND_BUF, S3C_SZ_ONENAND_BUF),
-	[2] = DEFINE_RES_IRQ(IRQ_ONENAND),
-};
-
-struct platform_device s3c_device_onenand = {
-	.name		= "samsung-onenand",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(s3c_onenand_resources),
-	.resource	= s3c_onenand_resources,
-};
-#endif /* CONFIG_S3C_DEV_ONENAND */
-
-#ifdef CONFIG_S3C64XX_DEV_ONENAND1
-static struct resource s3c64xx_onenand1_resources[] = {
-	[0] = DEFINE_RES_MEM(S3C64XX_PA_ONENAND1, SZ_1K),
-	[1] = DEFINE_RES_MEM(S3C64XX_PA_ONENAND1_BUF, S3C64XX_SZ_ONENAND1_BUF),
-	[2] = DEFINE_RES_IRQ(IRQ_ONENAND1),
-};
-
-struct platform_device s3c64xx_device_onenand1 = {
-	.name		= "samsung-onenand",
-	.id		= 1,
-	.num_resources	= ARRAY_SIZE(s3c64xx_onenand1_resources),
-	.resource	= s3c64xx_onenand1_resources,
-};
-
-void __init s3c64xx_onenand1_set_platdata(struct onenand_platform_data *pdata)
-{
-	s3c_set_platdata(pdata, sizeof(struct onenand_platform_data),
-			 &s3c64xx_device_onenand1);
-}
-#endif /* CONFIG_S3C64XX_DEV_ONENAND1 */
-
 /* PWM Timer */
 
 #ifdef CONFIG_SAMSUNG_DEV_PWM
@@ -802,162 +312,6 @@ void __init samsung_pwm_set_platdata(struct samsung_pwm_variant *pd)
 }
 #endif /* CONFIG_SAMSUNG_DEV_PWM */
 
-/* RTC */
-
-#ifdef CONFIG_PLAT_S3C24XX
-static struct resource s3c_rtc_resource[] = {
-	[0] = DEFINE_RES_MEM(S3C24XX_PA_RTC, SZ_256),
-	[1] = DEFINE_RES_IRQ(IRQ_RTC),
-	[2] = DEFINE_RES_IRQ(IRQ_TICK),
-};
-
-struct platform_device s3c_device_rtc = {
-	.name		= "s3c2410-rtc",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(s3c_rtc_resource),
-	.resource	= s3c_rtc_resource,
-};
-#endif /* CONFIG_PLAT_S3C24XX */
-
-#ifdef CONFIG_S3C_DEV_RTC
-static struct resource s3c_rtc_resource[] = {
-	[0] = DEFINE_RES_MEM(S3C_PA_RTC, SZ_256),
-	[1] = DEFINE_RES_IRQ(IRQ_RTC_ALARM),
-	[2] = DEFINE_RES_IRQ(IRQ_RTC_TIC),
-};
-
-struct platform_device s3c_device_rtc = {
-	.name		= "s3c64xx-rtc",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(s3c_rtc_resource),
-	.resource	= s3c_rtc_resource,
-};
-#endif /* CONFIG_S3C_DEV_RTC */
-
-/* SDI */
-
-#ifdef CONFIG_PLAT_S3C24XX
-void s3c24xx_mci_def_set_power(unsigned char power_mode, unsigned short vdd)
-{
-	switch (power_mode) {
-	case MMC_POWER_ON:
-	case MMC_POWER_UP:
-		/* Configure GPE5...GPE10 pins in SD mode */
-		s3c_gpio_cfgall_range(S3C2410_GPE(5), 6, S3C_GPIO_SFN(2),
-				      S3C_GPIO_PULL_NONE);
-		break;
-
-	case MMC_POWER_OFF:
-	default:
-		gpio_direction_output(S3C2410_GPE(5), 0);
-		break;
-	}
-}
-
-static struct resource s3c_sdi_resource[] = {
-	[0] = DEFINE_RES_MEM(S3C24XX_PA_SDI, S3C24XX_SZ_SDI),
-	[1] = DEFINE_RES_IRQ(IRQ_SDI),
-};
-
-static struct s3c24xx_mci_pdata s3cmci_def_pdata = {
-	/* This is currently here to avoid a number of if (host->pdata)
-	 * checks. Any zero fields to ensure reasonable defaults are picked. */
-	.no_wprotect = 1,
-	.no_detect = 1,
-	.set_power = s3c24xx_mci_def_set_power,
-};
-
-struct platform_device s3c_device_sdi = {
-	.name		= "s3c2410-sdi",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(s3c_sdi_resource),
-	.resource	= s3c_sdi_resource,
-	.dev.platform_data = &s3cmci_def_pdata,
-};
-
-void __init s3c24xx_mci_set_platdata(struct s3c24xx_mci_pdata *pdata)
-{
-	s3c_set_platdata(pdata, sizeof(struct s3c24xx_mci_pdata),
-			 &s3c_device_sdi);
-}
-#endif /* CONFIG_PLAT_S3C24XX */
-
-/* SPI */
-
-#ifdef CONFIG_PLAT_S3C24XX
-static struct resource s3c_spi0_resource[] = {
-	[0] = DEFINE_RES_MEM(S3C24XX_PA_SPI, SZ_32),
-	[1] = DEFINE_RES_IRQ(IRQ_SPI0),
-};
-
-struct platform_device s3c_device_spi0 = {
-	.name		= "s3c2410-spi",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(s3c_spi0_resource),
-	.resource	= s3c_spi0_resource,
-	.dev		= {
-		.dma_mask		= &samsung_device_dma_mask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	}
-};
-
-static struct resource s3c_spi1_resource[] = {
-	[0] = DEFINE_RES_MEM(S3C24XX_PA_SPI1, SZ_32),
-	[1] = DEFINE_RES_IRQ(IRQ_SPI1),
-};
-
-struct platform_device s3c_device_spi1 = {
-	.name		= "s3c2410-spi",
-	.id		= 1,
-	.num_resources	= ARRAY_SIZE(s3c_spi1_resource),
-	.resource	= s3c_spi1_resource,
-	.dev		= {
-		.dma_mask		= &samsung_device_dma_mask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	}
-};
-#endif /* CONFIG_PLAT_S3C24XX */
-
-/* Touchscreen */
-
-#ifdef CONFIG_PLAT_S3C24XX
-static struct resource s3c_ts_resource[] = {
-	[0] = DEFINE_RES_MEM(S3C24XX_PA_ADC, S3C24XX_SZ_ADC),
-	[1] = DEFINE_RES_IRQ(IRQ_TC),
-};
-
-struct platform_device s3c_device_ts = {
-	.name		= "s3c2410-ts",
-	.id		= -1,
-	.dev.parent	= &s3c_device_adc.dev,
-	.num_resources	= ARRAY_SIZE(s3c_ts_resource),
-	.resource	= s3c_ts_resource,
-};
-
-void __init s3c24xx_ts_set_platdata(struct s3c2410_ts_mach_info *hard_s3c2410ts_info)
-{
-	s3c_set_platdata(hard_s3c2410ts_info,
-			 sizeof(struct s3c2410_ts_mach_info), &s3c_device_ts);
-}
-#endif /* CONFIG_PLAT_S3C24XX */
-
-#ifdef CONFIG_SAMSUNG_DEV_TS
-static struct s3c2410_ts_mach_info default_ts_data __initdata = {
-	.delay			= 10000,
-	.presc			= 49,
-	.oversampling_shift	= 2,
-};
-
-void __init s3c64xx_ts_set_platdata(struct s3c2410_ts_mach_info *pd)
-{
-	if (!pd)
-		pd = &default_ts_data;
-
-	s3c_set_platdata(pd, sizeof(struct s3c2410_ts_mach_info),
-			 &s3c_device_adc);
-}
-#endif /* CONFIG_SAMSUNG_DEV_TS */
-
 /* USB */
 
 #ifdef CONFIG_S3C_DEV_USB_HOST
@@ -976,44 +330,8 @@ struct platform_device s3c_device_ohci = {
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
 	}
 };
-
-/*
- * s3c_ohci_set_platdata - initialise OHCI device platform data
- * @info: The platform data.
- *
- * This call copies the @info passed in and sets the device .platform_data
- * field to that copy. The @info is copied so that the original can be marked
- * __initdata.
- */
-
-void __init s3c_ohci_set_platdata(struct s3c2410_hcd_info *info)
-{
-	s3c_set_platdata(info, sizeof(struct s3c2410_hcd_info),
-			 &s3c_device_ohci);
-}
 #endif /* CONFIG_S3C_DEV_USB_HOST */
 
-/* USB Device (Gadget) */
-
-#ifdef CONFIG_PLAT_S3C24XX
-static struct resource s3c_usbgadget_resource[] = {
-	[0] = DEFINE_RES_MEM(S3C24XX_PA_USBDEV, S3C24XX_SZ_USBDEV),
-	[1] = DEFINE_RES_IRQ(IRQ_USBD),
-};
-
-struct platform_device s3c_device_usbgadget = {
-	.name		= "s3c2410-usbgadget",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(s3c_usbgadget_resource),
-	.resource	= s3c_usbgadget_resource,
-};
-
-void __init s3c24xx_udc_set_platdata(struct s3c2410_udc_mach_info *pd)
-{
-	s3c_set_platdata(pd, sizeof(*pd), &s3c_device_usbgadget);
-}
-#endif /* CONFIG_PLAT_S3C24XX */
-
 /* USB HSOTG */
 
 #ifdef CONFIG_S3C_DEV_USB_HSOTG
@@ -1046,49 +364,6 @@ void __init dwc2_hsotg_set_platdata(struct dwc2_hsotg_plat *pd)
 }
 #endif /* CONFIG_S3C_DEV_USB_HSOTG */
 
-/* USB High Spped 2.0 Device (Gadget) */
-
-#ifdef CONFIG_PLAT_S3C24XX
-static struct resource s3c_hsudc_resource[] = {
-	[0] = DEFINE_RES_MEM(S3C2416_PA_HSUDC, S3C2416_SZ_HSUDC),
-	[1] = DEFINE_RES_IRQ(IRQ_USBD),
-};
-
-struct platform_device s3c_device_usb_hsudc = {
-	.name		= "s3c-hsudc",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(s3c_hsudc_resource),
-	.resource	= s3c_hsudc_resource,
-	.dev		= {
-		.dma_mask		= &samsung_device_dma_mask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-};
-
-void __init s3c24xx_hsudc_set_platdata(struct s3c24xx_hsudc_platdata *pd)
-{
-	s3c_set_platdata(pd, sizeof(*pd), &s3c_device_usb_hsudc);
-	pd->phy_init = s3c_hsudc_init_phy;
-	pd->phy_uninit = s3c_hsudc_uninit_phy;
-}
-#endif /* CONFIG_PLAT_S3C24XX */
-
-/* WDT */
-
-#ifdef CONFIG_S3C_DEV_WDT
-static struct resource s3c_wdt_resource[] = {
-	[0] = DEFINE_RES_MEM(S3C_PA_WDT, SZ_1K),
-	[1] = DEFINE_RES_IRQ(IRQ_WDT),
-};
-
-struct platform_device s3c_device_wdt = {
-	.name		= "s3c2410-wdt",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(s3c_wdt_resource),
-	.resource	= s3c_wdt_resource,
-};
-#endif /* CONFIG_S3C_DEV_WDT */
-
 #ifdef CONFIG_S3C64XX_DEV_SPI0
 static struct resource s3c64xx_spi0_resource[] = {
 	[0] = DEFINE_RES_MEM(S3C_PA_SPI0, SZ_256),
diff --git a/arch/arm/mach-s3c/devs.h b/arch/arm/mach-s3c/devs.h
index 991b9b2006a1..21c00786c264 100644
--- a/arch/arm/mach-s3c/devs.h
+++ b/arch/arm/mach-s3c/devs.h
@@ -25,60 +25,23 @@ extern struct s3c24xx_uart_resources s3c64xx_uart_resources[];
 extern struct platform_device *s3c24xx_uart_devs[];
 extern struct platform_device *s3c24xx_uart_src[];
 
-extern struct platform_device s3c64xx_device_ac97;
 extern struct platform_device s3c64xx_device_iis0;
 extern struct platform_device s3c64xx_device_iis1;
-extern struct platform_device s3c64xx_device_iisv4;
-extern struct platform_device s3c64xx_device_onenand1;
-extern struct platform_device s3c64xx_device_pcm0;
-extern struct platform_device s3c64xx_device_pcm1;
 extern struct platform_device s3c64xx_device_spi0;
 
-extern struct platform_device s3c_device_adc;
-extern struct platform_device s3c_device_cfcon;
 extern struct platform_device s3c_device_fb;
-extern struct platform_device s3c_device_hwmon;
 extern struct platform_device s3c_device_hsmmc0;
 extern struct platform_device s3c_device_hsmmc1;
 extern struct platform_device s3c_device_hsmmc2;
 extern struct platform_device s3c_device_hsmmc3;
 extern struct platform_device s3c_device_i2c0;
 extern struct platform_device s3c_device_i2c1;
-extern struct platform_device s3c_device_i2c2;
-extern struct platform_device s3c_device_i2c3;
-extern struct platform_device s3c_device_i2c4;
-extern struct platform_device s3c_device_i2c5;
-extern struct platform_device s3c_device_i2c6;
-extern struct platform_device s3c_device_i2c7;
-extern struct platform_device s3c_device_iis;
-extern struct platform_device s3c_device_lcd;
-extern struct platform_device s3c_device_nand;
 extern struct platform_device s3c_device_ohci;
-extern struct platform_device s3c_device_onenand;
-extern struct platform_device s3c_device_rtc;
-extern struct platform_device s3c_device_sdi;
-extern struct platform_device s3c_device_spi0;
-extern struct platform_device s3c_device_spi1;
-extern struct platform_device s3c_device_ts;
-extern struct platform_device s3c_device_timer[];
-extern struct platform_device s3c_device_usbgadget;
 extern struct platform_device s3c_device_usb_hsotg;
-extern struct platform_device s3c_device_usb_hsudc;
-extern struct platform_device s3c_device_wdt;
 
-extern struct platform_device samsung_asoc_idma;
 extern struct platform_device samsung_device_keypad;
 extern struct platform_device samsung_device_pwm;
 
-/* s3c2440 specific devices */
-
-#ifdef CONFIG_CPU_S3C2440
-
-extern struct platform_device s3c_device_camif;
-extern struct platform_device s3c_device_ac97;
-
-#endif
-
 /**
  * s3c_set_platdata() - helper for setting platform data
  * @pd: The default platform data for this device.
diff --git a/arch/arm/mach-s3c/dma-s3c64xx.h b/arch/arm/mach-s3c/dma-s3c64xx.h
deleted file mode 100644
index 40ca8de21096..000000000000
diff --git a/arch/arm/mach-s3c/dma.h b/arch/arm/mach-s3c/dma.h
deleted file mode 100644
index 48057cb90070..000000000000
diff --git a/arch/arm/mach-s3c/gpio-cfg-helpers.h b/arch/arm/mach-s3c/gpio-cfg-helpers.h
index db0c56f5ca15..9d6f6319ae3e 100644
--- a/arch/arm/mach-s3c/gpio-cfg-helpers.h
+++ b/arch/arm/mach-s3c/gpio-cfg-helpers.h
@@ -26,134 +26,10 @@ static inline int samsung_gpio_do_setcfg(struct samsung_gpio_chip *chip,
 	return (chip->config->set_config)(chip, off, config);
 }
 
-static inline unsigned samsung_gpio_do_getcfg(struct samsung_gpio_chip *chip,
-					      unsigned int off)
-{
-	return (chip->config->get_config)(chip, off);
-}
-
 static inline int samsung_gpio_do_setpull(struct samsung_gpio_chip *chip,
 					  unsigned int off, samsung_gpio_pull_t pull)
 {
 	return (chip->config->set_pull)(chip, off, pull);
 }
 
-static inline samsung_gpio_pull_t samsung_gpio_do_getpull(struct samsung_gpio_chip *chip,
-							  unsigned int off)
-{
-	return chip->config->get_pull(chip, off);
-}
-
-/* Pull-{up,down} resistor controls.
- *
- * S3C2410,S3C2440 = Pull-UP,
- * S3C2412,S3C2413 = Pull-Down
- * S3C6400,S3C6410 = Pull-Both [None,Down,Up,Undef]
- * S3C2443 = Pull-Both [not same as S3C6400]
- */
-
-/**
- * s3c24xx_gpio_setpull_1up() - Pull configuration for choice of up or none.
- * @chip: The gpio chip that is being configured.
- * @off: The offset for the GPIO being configured.
- * @param: pull: The pull mode being requested.
- *
- * This is a helper function for the case where we have GPIOs with one
- * bit configuring the presence of a pull-up resistor.
- */
-extern int s3c24xx_gpio_setpull_1up(struct samsung_gpio_chip *chip,
-				    unsigned int off, samsung_gpio_pull_t pull);
-
-/**
- * s3c24xx_gpio_setpull_1down() - Pull configuration for choice of down or none
- * @chip: The gpio chip that is being configured
- * @off: The offset for the GPIO being configured
- * @param: pull: The pull mode being requested
- *
- * This is a helper function for the case where we have GPIOs with one
- * bit configuring the presence of a pull-down resistor.
- */
-extern int s3c24xx_gpio_setpull_1down(struct samsung_gpio_chip *chip,
-				      unsigned int off, samsung_gpio_pull_t pull);
-
-/**
- * samsung_gpio_setpull_upown() - Pull configuration for choice of up,
- * down or none
- *
- * @chip: The gpio chip that is being configured.
- * @off: The offset for the GPIO being configured.
- * @param: pull: The pull mode being requested.
- *
- * This is a helper function for the case where we have GPIOs with two
- * bits configuring the presence of a pull resistor, in the following
- * order:
- *	00 = No pull resistor connected
- *	01 = Pull-up resistor connected
- *	10 = Pull-down resistor connected
- */
-extern int samsung_gpio_setpull_updown(struct samsung_gpio_chip *chip,
-				       unsigned int off, samsung_gpio_pull_t pull);
-
-/**
- * samsung_gpio_getpull_updown() - Get configuration for choice of up,
- * down or none
- *
- * @chip: The gpio chip that the GPIO pin belongs to
- * @off: The offset to the pin to get the configuration of.
- *
- * This helper function reads the state of the pull-{up,down} resistor
- * for the given GPIO in the same case as samsung_gpio_setpull_upown.
-*/
-extern samsung_gpio_pull_t samsung_gpio_getpull_updown(struct samsung_gpio_chip *chip,
-						       unsigned int off);
-
-/**
- * s3c24xx_gpio_getpull_1up() - Get configuration for choice of up or none
- * @chip: The gpio chip that the GPIO pin belongs to
- * @off: The offset to the pin to get the configuration of.
- *
- * This helper function reads the state of the pull-up resistor for the
- * given GPIO in the same case as s3c24xx_gpio_setpull_1up.
-*/
-extern samsung_gpio_pull_t s3c24xx_gpio_getpull_1up(struct samsung_gpio_chip *chip,
-						    unsigned int off);
-
-/**
- * s3c24xx_gpio_getpull_1down() - Get configuration for choice of down or none
- * @chip: The gpio chip that the GPIO pin belongs to
- * @off: The offset to the pin to get the configuration of.
- *
- * This helper function reads the state of the pull-down resistor for the
- * given GPIO in the same case as s3c24xx_gpio_setpull_1down.
-*/
-extern samsung_gpio_pull_t s3c24xx_gpio_getpull_1down(struct samsung_gpio_chip *chip,
-						      unsigned int off);
-
-/**
- * s3c2443_gpio_setpull() - Pull configuration for s3c2443.
- * @chip: The gpio chip that is being configured.
- * @off: The offset for the GPIO being configured.
- * @param: pull: The pull mode being requested.
- *
- * This is a helper function for the case where we have GPIOs with two
- * bits configuring the presence of a pull resistor, in the following
- * order:
- *	00 = Pull-up resistor connected
- *	10 = Pull-down resistor connected
- *	x1 = No pull up resistor
- */
-extern int s3c2443_gpio_setpull(struct samsung_gpio_chip *chip,
-				unsigned int off, samsung_gpio_pull_t pull);
-
-/**
- * s3c2443_gpio_getpull() - Get configuration for s3c2443 pull resistors
- * @chip: The gpio chip that the GPIO pin belongs to.
- * @off: The offset to the pin to get the configuration of.
- *
- * This helper function reads the state of the pull-{up,down} resistor for the
- * given GPIO in the same case as samsung_gpio_setpull_upown.
-*/
-extern samsung_gpio_pull_t s3c2443_gpio_getpull(struct samsung_gpio_chip *chip,
-						unsigned int off);
-
 #endif /* __PLAT_GPIO_CFG_HELPERS_H */
diff --git a/arch/arm/mach-s3c/gpio-cfg.h b/arch/arm/mach-s3c/gpio-cfg.h
index 469c220e092b..2dfb0561001e 100644
--- a/arch/arm/mach-s3c/gpio-cfg.h
+++ b/arch/arm/mach-s3c/gpio-cfg.h
@@ -94,17 +94,6 @@ struct samsung_gpio_cfg {
  */
 extern int s3c_gpio_cfgpin(unsigned int pin, unsigned int to);
 
-/**
- * s3c_gpio_getcfg - Read the current function for a GPIO pin
- * @pin: The pin to read the configuration value for.
- *
- * Read the configuration state of the given @pin, returning a value that
- * could be passed back to s3c_gpio_cfgpin().
- *
- * @sa s3c_gpio_cfgpin
- */
-extern unsigned s3c_gpio_getcfg(unsigned int pin);
-
 /**
  * s3c_gpio_cfgpin_range() - Change the GPIO function for configuring pin range
  * @start: The pin number to start at
@@ -142,14 +131,6 @@ extern int s3c_gpio_cfgpin_range(unsigned int start, unsigned int nr,
 */
 extern int s3c_gpio_setpull(unsigned int pin, samsung_gpio_pull_t pull);
 
-/**
- * s3c_gpio_getpull() - get the pull resistor state of a gpio pin
- * @pin: The pin number to get the settings for
- *
- * Read the pull resistor value for the specified pin.
-*/
-extern samsung_gpio_pull_t s3c_gpio_getpull(unsigned int pin);
-
 /* configure `all` aspects of an gpio */
 
 /**
diff --git a/arch/arm/mach-s3c/gpio-core.h b/arch/arm/mach-s3c/gpio-core.h
index b361c8c0d669..6801c85fb9da 100644
--- a/arch/arm/mach-s3c/gpio-core.h
+++ b/arch/arm/mach-s3c/gpio-core.h
@@ -93,9 +93,6 @@ static inline struct samsung_gpio_chip *to_samsung_gpio(struct gpio_chip *gpc)
  */
 extern int samsung_gpiolib_to_irq(struct gpio_chip *chip, unsigned int offset);
 
-/* exported for core SoC support to change */
-extern struct samsung_gpio_cfg s3c24xx_gpiocfg_default;
-
 #ifdef CONFIG_S3C_GPIO_TRACK
 extern struct samsung_gpio_chip *s3c_gpios[S3C_GPIO_END];
 
diff --git a/arch/arm/mach-s3c/gpio-samsung.c b/arch/arm/mach-s3c/gpio-samsung.c
index b7fc7c41309c..87daaa09e2c3 100644
--- a/arch/arm/mach-s3c/gpio-samsung.c
+++ b/arch/arm/mach-s3c/gpio-samsung.c
@@ -35,10 +35,9 @@
 #include "gpio-core.h"
 #include "gpio-cfg.h"
 #include "gpio-cfg-helpers.h"
-#include "hardware-s3c24xx.h"
 #include "pm.h"
 
-int samsung_gpio_setpull_updown(struct samsung_gpio_chip *chip,
+static int samsung_gpio_setpull_updown(struct samsung_gpio_chip *chip,
 				unsigned int off, samsung_gpio_pull_t pull)
 {
 	void __iomem *reg = chip->base + 0x08;
@@ -53,7 +52,7 @@ int samsung_gpio_setpull_updown(struct samsung_gpio_chip *chip,
 	return 0;
 }
 
-samsung_gpio_pull_t samsung_gpio_getpull_updown(struct samsung_gpio_chip *chip,
+static samsung_gpio_pull_t samsung_gpio_getpull_updown(struct samsung_gpio_chip *chip,
 						unsigned int off)
 {
 	void __iomem *reg = chip->base + 0x08;
@@ -66,113 +65,6 @@ samsung_gpio_pull_t samsung_gpio_getpull_updown(struct samsung_gpio_chip *chip,
 	return (__force samsung_gpio_pull_t)pup;
 }
 
-int s3c2443_gpio_setpull(struct samsung_gpio_chip *chip,
-			 unsigned int off, samsung_gpio_pull_t pull)
-{
-	switch (pull) {
-	case S3C_GPIO_PULL_NONE:
-		pull = 0x01;
-		break;
-	case S3C_GPIO_PULL_UP:
-		pull = 0x00;
-		break;
-	case S3C_GPIO_PULL_DOWN:
-		pull = 0x02;
-		break;
-	}
-	return samsung_gpio_setpull_updown(chip, off, pull);
-}
-
-samsung_gpio_pull_t s3c2443_gpio_getpull(struct samsung_gpio_chip *chip,
-					 unsigned int off)
-{
-	samsung_gpio_pull_t pull;
-
-	pull = samsung_gpio_getpull_updown(chip, off);
-
-	switch (pull) {
-	case 0x00:
-		pull = S3C_GPIO_PULL_UP;
-		break;
-	case 0x01:
-	case 0x03:
-		pull = S3C_GPIO_PULL_NONE;
-		break;
-	case 0x02:
-		pull = S3C_GPIO_PULL_DOWN;
-		break;
-	}
-
-	return pull;
-}
-
-static int s3c24xx_gpio_setpull_1(struct samsung_gpio_chip *chip,
-				  unsigned int off, samsung_gpio_pull_t pull,
-				  samsung_gpio_pull_t updown)
-{
-	void __iomem *reg = chip->base + 0x08;
-	u32 pup = __raw_readl(reg);
-
-	if (pull == updown)
-		pup &= ~(1 << off);
-	else if (pull == S3C_GPIO_PULL_NONE)
-		pup |= (1 << off);
-	else
-		return -EINVAL;
-
-	__raw_writel(pup, reg);
-	return 0;
-}
-
-static samsung_gpio_pull_t s3c24xx_gpio_getpull_1(struct samsung_gpio_chip *chip,
-						  unsigned int off,
-						  samsung_gpio_pull_t updown)
-{
-	void __iomem *reg = chip->base + 0x08;
-	u32 pup = __raw_readl(reg);
-
-	pup &= (1 << off);
-	return pup ? S3C_GPIO_PULL_NONE : updown;
-}
-
-samsung_gpio_pull_t s3c24xx_gpio_getpull_1up(struct samsung_gpio_chip *chip,
-					     unsigned int off)
-{
-	return s3c24xx_gpio_getpull_1(chip, off, S3C_GPIO_PULL_UP);
-}
-
-int s3c24xx_gpio_setpull_1up(struct samsung_gpio_chip *chip,
-			     unsigned int off, samsung_gpio_pull_t pull)
-{
-	return s3c24xx_gpio_setpull_1(chip, off, pull, S3C_GPIO_PULL_UP);
-}
-
-samsung_gpio_pull_t s3c24xx_gpio_getpull_1down(struct samsung_gpio_chip *chip,
-					       unsigned int off)
-{
-	return s3c24xx_gpio_getpull_1(chip, off, S3C_GPIO_PULL_DOWN);
-}
-
-int s3c24xx_gpio_setpull_1down(struct samsung_gpio_chip *chip,
-			       unsigned int off, samsung_gpio_pull_t pull)
-{
-	return s3c24xx_gpio_setpull_1(chip, off, pull, S3C_GPIO_PULL_DOWN);
-}
-
-/*
- * samsung_gpio_setcfg_2bit - Samsung 2bit style GPIO configuration.
- * @chip: The gpio chip that is being configured.
- * @off: The offset for the GPIO being configured.
- * @cfg: The configuration value to set.
- *
- * This helper deal with the GPIO cases where the control register
- * has two bits of configuration per gpio, which have the following
- * functions:
- *	00 = input
- *	01 = output
- *	1x = special function
- */
-
 static int samsung_gpio_setcfg_2bit(struct samsung_gpio_chip *chip,
 				    unsigned int off, unsigned int cfg)
 {
@@ -289,70 +181,6 @@ static unsigned samsung_gpio_getcfg_4bit(struct samsung_gpio_chip *chip,
 	return S3C_GPIO_SPECIAL(con);
 }
 
-#ifdef CONFIG_PLAT_S3C24XX
-/*
- * s3c24xx_gpio_setcfg_abank - S3C24XX style GPIO configuration (Bank A)
- * @chip: The gpio chip that is being configured.
- * @off: The offset for the GPIO being configured.
- * @cfg: The configuration value to set.
- *
- * This helper deal with the GPIO cases where the control register
- * has one bit of configuration for the gpio, where setting the bit
- * means the pin is in special function mode and unset means output.
- */
-
-static int s3c24xx_gpio_setcfg_abank(struct samsung_gpio_chip *chip,
-				     unsigned int off, unsigned int cfg)
-{
-	void __iomem *reg = chip->base;
-	unsigned int shift = off;
-	u32 con;
-
-	if (samsung_gpio_is_cfg_special(cfg)) {
-		cfg &= 0xf;
-
-		/* Map output to 0, and SFN2 to 1 */
-		cfg -= 1;
-		if (cfg > 1)
-			return -EINVAL;
-
-		cfg <<= shift;
-	}
-
-	con = __raw_readl(reg);
-	con &= ~(0x1 << shift);
-	con |= cfg;
-	__raw_writel(con, reg);
-
-	return 0;
-}
-
-/*
- * s3c24xx_gpio_getcfg_abank - S3C24XX style GPIO configuration read (Bank A)
- * @chip: The gpio chip that is being configured.
- * @off: The offset for the GPIO being configured.
- *
- * The reverse of s3c24xx_gpio_setcfg_abank() turning an GPIO into a usable
- * GPIO configuration value.
- *
- * @sa samsung_gpio_getcfg_2bit
- * @sa samsung_gpio_getcfg_4bit
- */
-
-static unsigned s3c24xx_gpio_getcfg_abank(struct samsung_gpio_chip *chip,
-					  unsigned int off)
-{
-	u32 con;
-
-	con = __raw_readl(chip->base);
-	con >>= off;
-	con &= 1;
-	con++;
-
-	return S3C_GPIO_SFN(con);
-}
-#endif
-
 static void __init samsung_gpiolib_set_cfg(struct samsung_gpio_cfg *chipcfg,
 					   int nr_chips)
 {
@@ -368,18 +196,6 @@ static void __init samsung_gpiolib_set_cfg(struct samsung_gpio_cfg *chipcfg,
 	}
 }
 
-struct samsung_gpio_cfg s3c24xx_gpiocfg_default = {
-	.set_config	= samsung_gpio_setcfg_2bit,
-	.get_config	= samsung_gpio_getcfg_2bit,
-};
-
-#ifdef CONFIG_PLAT_S3C24XX
-static struct samsung_gpio_cfg s3c24xx_gpiocfg_banka = {
-	.set_config	= s3c24xx_gpio_setcfg_abank,
-	.get_config	= s3c24xx_gpio_getcfg_abank,
-};
-#endif
-
 static struct samsung_gpio_cfg samsung_gpio_cfgs[] = {
 	[0] = {
 		.cfg_eint	= 0x0,
@@ -614,44 +430,6 @@ static int samsung_gpiolib_4bit2_output(struct gpio_chip *chip,
 	return 0;
 }
 
-#ifdef CONFIG_PLAT_S3C24XX
-/* The next set of routines are for the case of s3c24xx bank a */
-
-static int s3c24xx_gpiolib_banka_input(struct gpio_chip *chip, unsigned offset)
-{
-	return -EINVAL;
-}
-
-static int s3c24xx_gpiolib_banka_output(struct gpio_chip *chip,
-					unsigned offset, int value)
-{
-	struct samsung_gpio_chip *ourchip = to_samsung_gpio(chip);
-	void __iomem *base = ourchip->base;
-	unsigned long flags;
-	unsigned long dat;
-	unsigned long con;
-
-	local_irq_save(flags);
-
-	con = __raw_readl(base + 0x00);
-	dat = __raw_readl(base + 0x04);
-
-	dat &= ~(1 << offset);
-	if (value)
-		dat |= 1 << offset;
-
-	__raw_writel(dat, base + 0x04);
-
-	con &= ~(1 << offset);
-
-	__raw_writel(con, base + 0x00);
-	__raw_writel(dat, base + 0x04);
-
-	local_irq_restore(flags);
-	return 0;
-}
-#endif
-
 static void samsung_gpiolib_set(struct gpio_chip *chip,
 				unsigned offset, int value)
 {
@@ -756,33 +534,6 @@ static void __init samsung_gpiolib_add(struct samsung_gpio_chip *chip)
 		s3c_gpiolib_track(chip);
 }
 
-static void __init s3c24xx_gpiolib_add_chips(struct samsung_gpio_chip *chip,
-					     int nr_chips, void __iomem *base)
-{
-	int i;
-	struct gpio_chip *gc = &chip->chip;
-
-	for (i = 0 ; i < nr_chips; i++, chip++) {
-		/* skip banks not present on SoC */
-		if (chip->chip.base >= S3C_GPIO_END)
-			continue;
-
-		if (!chip->config)
-			chip->config = &s3c24xx_gpiocfg_default;
-		if (!chip->pm)
-			chip->pm = __gpio_pm(&samsung_gpio_pm_2bit);
-		if ((base != NULL) && (chip->base == NULL))
-			chip->base = base + ((i) * 0x10);
-
-		if (!gc->direction_input)
-			gc->direction_input = samsung_gpiolib_2bit_input;
-		if (!gc->direction_output)
-			gc->direction_output = samsung_gpiolib_2bit_output;
-
-		samsung_gpiolib_add(chip);
-	}
-}
-
 static void __init samsung_gpiolib_add_2bit_chips(struct samsung_gpio_chip *chip,
 						  int nr_chips, void __iomem *base,
 						  unsigned int offset)
@@ -865,24 +616,6 @@ int samsung_gpiolib_to_irq(struct gpio_chip *chip, unsigned int offset)
 	return samsung_chip->irq_base + offset;
 }
 
-#ifdef CONFIG_PLAT_S3C24XX
-static int s3c24xx_gpiolib_fbank_to_irq(struct gpio_chip *chip, unsigned offset)
-{
-	if (offset < 4) {
-		if (soc_is_s3c2412())
-			return IRQ_EINT0_2412 + offset;
-		else
-			return IRQ_EINT0 + offset;
-	}
-
-	if (offset < 8)
-		return IRQ_EINT4 + offset - 4;
-
-	return -EINVAL;
-}
-#endif
-
-#ifdef CONFIG_ARCH_S3C64XX
 static int s3c64xx_gpiolib_mbank_to_irq(struct gpio_chip *chip, unsigned pin)
 {
 	return pin < 5 ? IRQ_EINT(23) + pin : -ENXIO;
@@ -892,109 +625,6 @@ static int s3c64xx_gpiolib_lbank_to_irq(struct gpio_chip *chip, unsigned pin)
 {
 	return pin >= 8 ? IRQ_EINT(16) + pin - 8 : -ENXIO;
 }
-#endif
-
-struct samsung_gpio_chip s3c24xx_gpios[] = {
-#ifdef CONFIG_PLAT_S3C24XX
-	{
-		.config	= &s3c24xx_gpiocfg_banka,
-		.chip	= {
-			.base			= S3C2410_GPA(0),
-			.owner			= THIS_MODULE,
-			.label			= "GPIOA",
-			.ngpio			= 27,
-			.direction_input	= s3c24xx_gpiolib_banka_input,
-			.direction_output	= s3c24xx_gpiolib_banka_output,
-		},
-	}, {
-		.chip	= {
-			.base	= S3C2410_GPB(0),
-			.owner	= THIS_MODULE,
-			.label	= "GPIOB",
-			.ngpio	= 11,
-		},
-	}, {
-		.chip	= {
-			.base	= S3C2410_GPC(0),
-			.owner	= THIS_MODULE,
-			.label	= "GPIOC",
-			.ngpio	= 16,
-		},
-	}, {
-		.chip	= {
-			.base	= S3C2410_GPD(0),
-			.owner	= THIS_MODULE,
-			.label	= "GPIOD",
-			.ngpio	= 16,
-		},
-	}, {
-		.chip	= {
-			.base	= S3C2410_GPE(0),
-			.label	= "GPIOE",
-			.owner	= THIS_MODULE,
-			.ngpio	= 16,
-		},
-	}, {
-		.chip	= {
-			.base	= S3C2410_GPF(0),
-			.owner	= THIS_MODULE,
-			.label	= "GPIOF",
-			.ngpio	= 8,
-			.to_irq	= s3c24xx_gpiolib_fbank_to_irq,
-		},
-	}, {
-		.irq_base = IRQ_EINT8,
-		.chip	= {
-			.base	= S3C2410_GPG(0),
-			.owner	= THIS_MODULE,
-			.label	= "GPIOG",
-			.ngpio	= 16,
-			.to_irq	= samsung_gpiolib_to_irq,
-		},
-	}, {
-		.chip	= {
-			.base	= S3C2410_GPH(0),
-			.owner	= THIS_MODULE,
-			.label	= "GPIOH",
-			.ngpio	= 15,
-		},
-	},
-		/* GPIOS for the S3C2443 and later devices. */
-	{
-		.base	= S3C2440_GPJCON,
-		.chip	= {
-			.base	= S3C2410_GPJ(0),
-			.owner	= THIS_MODULE,
-			.label	= "GPIOJ",
-			.ngpio	= 16,
-		},
-	}, {
-		.base	= S3C2443_GPKCON,
-		.chip	= {
-			.base	= S3C2410_GPK(0),
-			.owner	= THIS_MODULE,
-			.label	= "GPIOK",
-			.ngpio	= 16,
-		},
-	}, {
-		.base	= S3C2443_GPLCON,
-		.chip	= {
-			.base	= S3C2410_GPL(0),
-			.owner	= THIS_MODULE,
-			.label	= "GPIOL",
-			.ngpio	= 15,
-		},
-	}, {
-		.base	= S3C2443_GPMCON,
-		.chip	= {
-			.base	= S3C2410_GPM(0),
-			.owner	= THIS_MODULE,
-			.label	= "GPIOM",
-			.ngpio	= 2,
-		},
-	},
-#endif
-};
 
 /*
  * GPIO bank summary:
@@ -1023,7 +653,6 @@ struct samsung_gpio_chip s3c24xx_gpios[] = {
  */
 
 static struct samsung_gpio_chip s3c64xx_gpios_4bit[] = {
-#ifdef CONFIG_ARCH_S3C64XX
 	{
 		.chip	= {
 			.base	= S3C64XX_GPA(0),
@@ -1072,11 +701,9 @@ static struct samsung_gpio_chip s3c64xx_gpios_4bit[] = {
 			.to_irq = s3c64xx_gpiolib_mbank_to_irq,
 		},
 	},
-#endif
 };
 
 static struct samsung_gpio_chip s3c64xx_gpios_4bit2[] = {
-#ifdef CONFIG_ARCH_S3C64XX
 	{
 		.base	= S3C64XX_GPH_BASE + 0x4,
 		.chip	= {
@@ -1102,11 +729,9 @@ static struct samsung_gpio_chip s3c64xx_gpios_4bit2[] = {
 			.to_irq = s3c64xx_gpiolib_lbank_to_irq,
 		},
 	},
-#endif
 };
 
 static struct samsung_gpio_chip s3c64xx_gpios_2bit[] = {
-#ifdef CONFIG_ARCH_S3C64XX
 	{
 		.base	= S3C64XX_GPF_BASE,
 		.config	= &samsung_gpio_cfgs[6],
@@ -1161,7 +786,6 @@ static struct samsung_gpio_chip s3c64xx_gpios_2bit[] = {
 			.to_irq = samsung_gpiolib_to_irq,
 		},
 	},
-#endif
 };
 
 /* TODO: cleanup soc_is_* */
@@ -1176,12 +800,7 @@ static __init int samsung_gpiolib_init(void)
 	if (of_have_populated_dt())
 		return 0;
 
-	if (soc_is_s3c24xx()) {
-		samsung_gpiolib_set_cfg(samsung_gpio_cfgs,
-				ARRAY_SIZE(samsung_gpio_cfgs));
-		s3c24xx_gpiolib_add_chips(s3c24xx_gpios,
-				ARRAY_SIZE(s3c24xx_gpios), S3C24XX_VA_GPIO);
-	} else if (soc_is_s3c64xx()) {
+	if (soc_is_s3c64xx()) {
 		samsung_gpiolib_set_cfg(samsung_gpio_cfgs,
 				ARRAY_SIZE(samsung_gpio_cfgs));
 		samsung_gpiolib_add_2bit_chips(s3c64xx_gpios_2bit,
@@ -1249,25 +868,6 @@ int s3c_gpio_cfgall_range(unsigned int start, unsigned int nr,
 }
 EXPORT_SYMBOL_GPL(s3c_gpio_cfgall_range);
 
-unsigned s3c_gpio_getcfg(unsigned int pin)
-{
-	struct samsung_gpio_chip *chip = samsung_gpiolib_getchip(pin);
-	unsigned long flags;
-	unsigned ret = 0;
-	int offset;
-
-	if (chip) {
-		offset = pin - chip->chip.base;
-
-		samsung_gpio_lock(chip, flags);
-		ret = samsung_gpio_do_getcfg(chip, offset);
-		samsung_gpio_unlock(chip, flags);
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL(s3c_gpio_getcfg);
-
 int s3c_gpio_setpull(unsigned int pin, samsung_gpio_pull_t pull)
 {
 	struct samsung_gpio_chip *chip = samsung_gpiolib_getchip(pin);
@@ -1286,40 +886,3 @@ int s3c_gpio_setpull(unsigned int pin, samsung_gpio_pull_t pull)
 	return ret;
 }
 EXPORT_SYMBOL(s3c_gpio_setpull);
-
-samsung_gpio_pull_t s3c_gpio_getpull(unsigned int pin)
-{
-	struct samsung_gpio_chip *chip = samsung_gpiolib_getchip(pin);
-	unsigned long flags;
-	int offset;
-	u32 pup = 0;
-
-	if (chip) {
-		offset = pin - chip->chip.base;
-
-		samsung_gpio_lock(chip, flags);
-		pup = samsung_gpio_do_getpull(chip, offset);
-		samsung_gpio_unlock(chip, flags);
-	}
-
-	return (__force samsung_gpio_pull_t)pup;
-}
-EXPORT_SYMBOL(s3c_gpio_getpull);
-
-#ifdef CONFIG_PLAT_S3C24XX
-unsigned int s3c2410_modify_misccr(unsigned int clear, unsigned int change)
-{
-	unsigned long flags;
-	unsigned long misccr;
-
-	local_irq_save(flags);
-	misccr = __raw_readl(S3C24XX_MISCCR);
-	misccr &= ~clear;
-	misccr ^= change;
-	__raw_writel(misccr, S3C24XX_MISCCR);
-	local_irq_restore(flags);
-
-	return misccr;
-}
-EXPORT_SYMBOL(s3c2410_modify_misccr);
-#endif
diff --git a/arch/arm/mach-s3c/iic-core.h b/arch/arm/mach-s3c/iic-core.h
index c5cfd5af3874..6672691bd7b8 100644
--- a/arch/arm/mach-s3c/iic-core.h
+++ b/arch/arm/mach-s3c/iic-core.h
@@ -28,11 +28,4 @@ static inline void s3c_i2c1_setname(char *name)
 #endif
 }
 
-static inline void s3c_i2c2_setname(char *name)
-{
-#ifdef CONFIG_S3C_DEV_I2C2
-	s3c_device_i2c2.name = name;
-#endif
-}
-
 #endif /* __ASM_ARCH_IIC_H */
diff --git a/arch/arm/mach-s3c/init.c b/arch/arm/mach-s3c/init.c
index bf513616f55d..0ac079f23d51 100644
--- a/arch/arm/mach-s3c/init.c
+++ b/arch/arm/mach-s3c/init.c
@@ -63,29 +63,6 @@ void __init s3c_init_cpu(unsigned long idcode,
 	pr_err("The platform is deprecated and scheduled for removal. Please reach to the maintainers of the platform and linux-samsung-soc@vger.kernel.org if you still use it.  Without such feedback, the platform will be removed after 2022.\n");
 }
 
-/* s3c24xx_init_clocks
- *
- * Initialise the clock subsystem and associated information from the
- * given master crystal value.
- *
- * xtal  = 0 -> use default PLL crystal value (normally 12MHz)
- *      != 0 -> PLL crystal value in Hz
-*/
-
-void __init s3c24xx_init_clocks(int xtal)
-{
-	if (xtal == 0)
-		xtal = 12*1000*1000;
-
-	if (cpu == NULL)
-		panic("s3c24xx_init_clocks: no cpu setup?\n");
-
-	if (cpu->init_clocks == NULL)
-		panic("s3c24xx_init_clocks: cpu has no clock init\n");
-	else
-		(cpu->init_clocks)(xtal);
-}
-
 /* uart management */
 #if IS_ENABLED(CONFIG_SAMSUNG_ATAGS)
 static int nr_uarts __initdata = 0;
@@ -150,8 +127,7 @@ static int __init s3c_arch_init(void)
 	int ret;
 
 	/* init is only needed for ATAGS based platforms */
-	if (!IS_ENABLED(CONFIG_ATAGS) ||
-	    (!soc_is_s3c24xx() && !soc_is_s3c64xx()))
+	if (!IS_ENABLED(CONFIG_ATAGS))
 		return 0;
 
 	// do the correct init for cpu
diff --git a/arch/arm/mach-s3c/map-s3c.h b/arch/arm/mach-s3c/map-s3c.h
index a18fdd3d6ae2..b5f5bdba384f 100644
--- a/arch/arm/mach-s3c/map-s3c.h
+++ b/arch/arm/mach-s3c/map-s3c.h
@@ -11,20 +11,6 @@
 
 #include "map.h"
 
-#define S3C24XX_VA_IRQ		S3C_VA_IRQ
-#define S3C24XX_VA_MEMCTRL	S3C_VA_MEM
-#define S3C24XX_VA_UART		S3C_VA_UART
-
-#define S3C24XX_VA_TIMER	S3C_VA_TIMER
-#define S3C24XX_VA_CLKPWR	S3C_VA_SYS
-#define S3C24XX_VA_WATCHDOG	S3C_VA_WATCHDOG
-
-#define S3C2412_VA_SSMC		S3C_ADDR_CPU(0x00000000)
-#define S3C2412_VA_EBI		S3C_ADDR_CPU(0x00100000)
-
-#define S3C2410_PA_UART		(0x50000000)
-#define S3C24XX_PA_UART		S3C2410_PA_UART
-
 /*
  * GPIO ports
  *
@@ -35,11 +21,6 @@
  * 0xFA800000, which is not in the way of any current mapping
  * by the base system.
 */
-
-#define S3C2410_PA_GPIO		(0x56000000)
-#define S3C24XX_PA_GPIO		S3C2410_PA_GPIO
-
-#define S3C24XX_VA_GPIO		((S3C24XX_PA_GPIO - S3C24XX_PA_UART) + S3C24XX_VA_UART)
 #define S3C64XX_VA_GPIO		S3C_ADDR_CPU(0x00000000)
 
 #define S3C64XX_VA_MODEM	S3C_ADDR_CPU(0x00100000)
@@ -47,24 +28,6 @@
 
 #define S3C_VA_USB_HSPHY	S3C64XX_VA_USB_HSPHY
 
-#define S3C2410_ADDR(x)		S3C_ADDR(x)
-
-/* deal with the registers that move under the 2412/2413 */
-
-#if defined(CONFIG_CPU_S3C2412)
-#ifndef __ASSEMBLY__
-extern void __iomem *s3c24xx_va_gpio2;
-#endif
-#ifdef CONFIG_CPU_S3C2412_ONLY
-#define S3C24XX_VA_GPIO2	(S3C24XX_VA_GPIO + 0x10)
-#else
-#define S3C24XX_VA_GPIO2 s3c24xx_va_gpio2
-#endif
-#else
-#define s3c24xx_va_gpio2 S3C24XX_VA_GPIO
-#define S3C24XX_VA_GPIO2 S3C24XX_VA_GPIO
-#endif
-
 #include "map-s5p.h"
 
 #endif /* __ASM_PLAT_MAP_S3C_H */
diff --git a/arch/arm/mach-s3c/onenand-core-s3c64xx.h b/arch/arm/mach-s3c/onenand-core-s3c64xx.h
deleted file mode 100644
index e2dfdd1fec93..000000000000
diff --git a/arch/arm/mach-s3c/otom.h b/arch/arm/mach-s3c/otom.h
deleted file mode 100644
index c800f67d03d4..000000000000
diff --git a/arch/arm/mach-s3c/pm-core-s3c64xx.h b/arch/arm/mach-s3c/pm-core-s3c64xx.h
index 06f564e5cf63..24933c4ea1a2 100644
--- a/arch/arm/mach-s3c/pm-core-s3c64xx.h
+++ b/arch/arm/mach-s3c/pm-core-s3c64xx.h
@@ -20,23 +20,6 @@
 
 static inline void s3c_pm_debug_init_uart(void)
 {
-#ifdef CONFIG_SAMSUNG_PM_DEBUG
-	u32 tmp = __raw_readl(S3C_PCLK_GATE);
-
-	/* As a note, since the S3C64XX UARTs generally have multiple
-	 * clock sources, we simply enable PCLK at the moment and hope
-	 * that the resume settings for the UART are suitable for the
-	 * use with PCLK.
-	 */
-
-	tmp |= S3C_CLKCON_PCLK_UART0;
-	tmp |= S3C_CLKCON_PCLK_UART1;
-	tmp |= S3C_CLKCON_PCLK_UART2;
-	tmp |= S3C_CLKCON_PCLK_UART3;
-
-	__raw_writel(tmp, S3C_PCLK_GATE);
-	udelay(10);
-#endif
 }
 
 static inline void s3c_pm_arch_prepare_irqs(void)
diff --git a/arch/arm/mach-s3c/pm-s3c64xx.c b/arch/arm/mach-s3c/pm-s3c64xx.c
index 7bc7417fd803..284d5f462513 100644
--- a/arch/arm/mach-s3c/pm-s3c64xx.c
+++ b/arch/arm/mach-s3c/pm-s3c64xx.c
@@ -173,23 +173,6 @@ static struct s3c64xx_pm_domain *s3c64xx_pm_domains[] = {
 	&s3c64xx_pm_f,
 };
 
-#ifdef CONFIG_S3C_PM_DEBUG_LED_SMDK
-void s3c_pm_debug_smdkled(u32 set, u32 clear)
-{
-	unsigned long flags;
-	int i;
-
-	local_irq_save(flags);
-	for (i = 0; i < 4; i++) {
-		if (clear & (1 << i))
-			gpio_set_value(S3C64XX_GPN(12 + i), 0);
-		if (set & (1 << i))
-			gpio_set_value(S3C64XX_GPN(12 + i), 1);
-	}
-	local_irq_restore(flags);
-}
-#endif
-
 #ifdef CONFIG_PM_SLEEP
 static struct sleep_save core_save[] = {
 	SAVE_ITEM(S3C64XX_MEM0DRVCON),
@@ -224,8 +207,6 @@ void s3c_pm_restore_core(void)
 {
 	__raw_writel(0, S3C64XX_EINT_MASK);
 
-	s3c_pm_debug_smdkled(1 << 2, 0);
-
 	s3c_pm_do_restore_core(core_save, ARRAY_SIZE(core_save));
 	s3c_pm_do_restore(misc_save, ARRAY_SIZE(misc_save));
 }
@@ -258,9 +239,6 @@ static int s3c64xx_cpu_suspend(unsigned long arg)
 	__raw_writel(__raw_readl(S3C64XX_WAKEUP_STAT),
 		     S3C64XX_WAKEUP_STAT);
 
-	/* set the LED state to 0110 over sleep */
-	s3c_pm_debug_smdkled(3 << 1, 0xf);
-
 	/* issue the standby signal into the pm unit. Note, we
 	 * issue a write-buffer drain just in case */
 
@@ -305,56 +283,6 @@ static void s3c64xx_pm_prepare(void)
 	__raw_writel(__raw_readl(S3C64XX_WAKEUP_STAT), S3C64XX_WAKEUP_STAT);
 }
 
-#ifdef CONFIG_SAMSUNG_PM_DEBUG
-void s3c_pm_arch_update_uart(void __iomem *regs, struct pm_uart_save *save)
-{
-	u32 ucon;
-	u32 ucon_clk
-	u32 save_clk;
-	u32 new_ucon;
-	u32 delta;
-
-	if (!soc_is_s3c64xx())
-		return;
-
-	ucon = __raw_readl(regs + S3C2410_UCON);
-	ucon_clk = ucon & S3C6400_UCON_CLKMASK;
-	sav_clk = save->ucon & S3C6400_UCON_CLKMASK;
-
-	/* S3C64XX UART blocks only support level interrupts, so ensure that
-	 * when we restore unused UART blocks we force the level interrupt
-	 * settings. */
-	save->ucon |= S3C2410_UCON_TXILEVEL | S3C2410_UCON_RXILEVEL;
-
-	/* We have a constraint on changing the clock type of the UART
-	 * between UCLKx and PCLK, so ensure that when we restore UCON
-	 * that the CLK field is correctly modified if the bootloader
-	 * has changed anything.
-	 */
-	if (ucon_clk != save_clk) {
-		new_ucon = save->ucon;
-		delta = ucon_clk ^ save_clk;
-
-		/* change from UCLKx => wrong PCLK,
-		 * either UCLK can be tested for by a bit-test
-		 * with UCLK0 */
-		if (ucon_clk & S3C6400_UCON_UCLK0 &&
-		    !(save_clk & S3C6400_UCON_UCLK0) &&
-		    delta & S3C6400_UCON_PCLK2) {
-			new_ucon &= ~S3C6400_UCON_UCLK0;
-		} else if (delta == S3C6400_UCON_PCLK2) {
-			/* as an precaution, don't change from
-			 * PCLK2 => PCLK or vice-versa */
-			new_ucon ^= S3C6400_UCON_PCLK2;
-		}
-
-		S3C_PMDBG("ucon change %04x => %04x (save=%04x)\n",
-			  ucon, new_ucon, save->ucon);
-		save->ucon = new_ucon;
-	}
-}
-#endif
-
 int __init s3c64xx_pm_init(void)
 {
 	int i;
@@ -384,17 +312,6 @@ static __init int s3c64xx_pm_initcall(void)
 	pm_cpu_prep = s3c64xx_pm_prepare;
 	pm_cpu_sleep = s3c64xx_cpu_suspend;
 
-#ifdef CONFIG_S3C_PM_DEBUG_LED_SMDK
-	gpio_request(S3C64XX_GPN(12), "DEBUG_LED0");
-	gpio_request(S3C64XX_GPN(13), "DEBUG_LED1");
-	gpio_request(S3C64XX_GPN(14), "DEBUG_LED2");
-	gpio_request(S3C64XX_GPN(15), "DEBUG_LED3");
-	gpio_direction_output(S3C64XX_GPN(12), 0);
-	gpio_direction_output(S3C64XX_GPN(13), 0);
-	gpio_direction_output(S3C64XX_GPN(14), 0);
-	gpio_direction_output(S3C64XX_GPN(15), 0);
-#endif
-
 	return 0;
 }
 arch_initcall(s3c64xx_pm_initcall);
diff --git a/arch/arm/mach-s3c/pm.c b/arch/arm/mach-s3c/pm.c
index 06f019690d81..5698cbceaf7a 100644
--- a/arch/arm/mach-s3c/pm.c
+++ b/arch/arm/mach-s3c/pm.c
@@ -100,7 +100,7 @@ static int s3c_pm_enter(suspend_state_t state)
 		samsung_pm_saved_gpios();
 	}
 
-	s3c_pm_save_uarts(soc_is_s3c2410());
+	s3c_pm_save_uarts(false);
 	s3c_pm_save_core();
 
 	/* set the irq configuration for wake */
@@ -137,7 +137,7 @@ static int s3c_pm_enter(suspend_state_t state)
 	/* restore the system state */
 
 	s3c_pm_restore_core();
-	s3c_pm_restore_uarts(soc_is_s3c2410());
+	s3c_pm_restore_uarts(false);
 
 	if (!of_have_populated_dt()) {
 		samsung_pm_restore_gpios();
@@ -152,9 +152,6 @@ static int s3c_pm_enter(suspend_state_t state)
 
 	S3C_PMDBG("%s: post sleep, preparing to return\n", __func__);
 
-	/* LEDs should now be 1110 */
-	s3c_pm_debug_smdkled(1 << 1, 0);
-
 	s3c_pm_check_restore();
 
 	/* ok, let's return from sleep */
diff --git a/arch/arm/mach-s3c/pm.h b/arch/arm/mach-s3c/pm.h
index eed61e585457..35d266ab6958 100644
--- a/arch/arm/mach-s3c/pm.h
+++ b/arch/arm/mach-s3c/pm.h
@@ -64,18 +64,6 @@ extern int s3c_irqext_wake(struct irq_data *data, unsigned int state);
 #define s3c_irqext_wake NULL
 #endif
 
-#ifdef CONFIG_S3C_PM_DEBUG_LED_SMDK
-/**
- * s3c_pm_debug_smdkled() - Debug PM suspend/resume via SMDK Board LEDs
- * @set: set bits for the state of the LEDs
- * @clear: clear bits for the state of the LEDs.
- */
-extern void s3c_pm_debug_smdkled(u32 set, u32 clear);
-
-#else
-static inline void s3c_pm_debug_smdkled(u32 set, u32 clear) { }
-#endif /* CONFIG_S3C_PM_DEBUG_LED_SMDK */
-
 /**
  * s3c_pm_configure_extint() - ensure pins are correctly set for IRQ
  *
diff --git a/arch/arm/mach-s3c/regs-srom-s3c64xx.h b/arch/arm/mach-s3c/regs-srom-s3c64xx.h
deleted file mode 100644
index 2b37988bdf94..000000000000
diff --git a/arch/arm/mach-s3c/s3c6400.c b/arch/arm/mach-s3c/s3c6400.c
index 802f4fb7462d..d47f1d6067b4 100644
--- a/arch/arm/mach-s3c/s3c6400.c
+++ b/arch/arm/mach-s3c/s3c6400.c
@@ -36,7 +36,6 @@
 #include "iic-core.h"
 
 #include "s3c64xx.h"
-#include "onenand-core-s3c64xx.h"
 
 void __init s3c6400_map_io(void)
 {
@@ -48,11 +47,6 @@ void __init s3c6400_map_io(void)
 
 	/* the i2c devices are directly compatible with s3c2440 */
 	s3c_i2c0_setname("s3c2440-i2c");
-
-	s3c_device_nand.name = "s3c6400-nand";
-
-	s3c_onenand_setname("s3c6400-onenand");
-	s3c64xx_onenand1_setname("s3c6400-onenand");
 }
 
 void __init s3c6400_init_irq(void)
diff --git a/arch/arm/mach-s3c/s3c6410.c b/arch/arm/mach-s3c/s3c6410.c
index dae17d5fd092..e79f18d0ca81 100644
--- a/arch/arm/mach-s3c/s3c6410.c
+++ b/arch/arm/mach-s3c/s3c6410.c
@@ -35,12 +35,9 @@
 #include "cpu.h"
 #include "devs.h"
 #include "sdhci.h"
-#include "adc-core.h"
 #include "iic-core.h"
 
-#include "ata-core-s3c64xx.h"
 #include "s3c64xx.h"
-#include "onenand-core-s3c64xx.h"
 
 void __init s3c6410_map_io(void)
 {
@@ -52,12 +49,6 @@ void __init s3c6410_map_io(void)
 	/* the i2c devices are directly compatible with s3c2440 */
 	s3c_i2c0_setname("s3c2440-i2c");
 	s3c_i2c1_setname("s3c2440-i2c");
-
-	s3c_adc_setname("s3c64xx-adc");
-	s3c_device_nand.name = "s3c6400-nand";
-	s3c_onenand_setname("s3c6410-onenand");
-	s3c64xx_onenand1_setname("s3c6410-onenand");
-	s3c_cfcon_setname("s3c64xx-pata");
 }
 
 void __init s3c6410_init_irq(void)
diff --git a/arch/arm/mach-s3c/sdhci.h b/arch/arm/mach-s3c/sdhci.h
index 9f9d419e58d7..1010f94d4a18 100644
--- a/arch/arm/mach-s3c/sdhci.h
+++ b/arch/arm/mach-s3c/sdhci.h
@@ -48,35 +48,10 @@ extern struct s3c_sdhci_platdata s3c_hsmmc3_def_platdata;
 
 /* Helper function availability */
 
-extern void s3c2416_setup_sdhci0_cfg_gpio(struct platform_device *, int w);
-extern void s3c2416_setup_sdhci1_cfg_gpio(struct platform_device *, int w);
 extern void s3c64xx_setup_sdhci0_cfg_gpio(struct platform_device *, int w);
 extern void s3c64xx_setup_sdhci1_cfg_gpio(struct platform_device *, int w);
 extern void s3c64xx_setup_sdhci2_cfg_gpio(struct platform_device *, int w);
 
-/* S3C2416 SDHCI setup */
-
-#ifdef CONFIG_S3C2416_SETUP_SDHCI
-static inline void s3c2416_default_sdhci0(void)
-{
-#ifdef CONFIG_S3C_DEV_HSMMC
-	s3c_hsmmc0_def_platdata.cfg_gpio = s3c2416_setup_sdhci0_cfg_gpio;
-#endif /* CONFIG_S3C_DEV_HSMMC */
-}
-
-static inline void s3c2416_default_sdhci1(void)
-{
-#ifdef CONFIG_S3C_DEV_HSMMC1
-	s3c_hsmmc1_def_platdata.cfg_gpio = s3c2416_setup_sdhci1_cfg_gpio;
-#endif /* CONFIG_S3C_DEV_HSMMC1 */
-}
-
-#else
-static inline void s3c2416_default_sdhci0(void) { }
-static inline void s3c2416_default_sdhci1(void) { }
-
-#endif /* CONFIG_S3C2416_SETUP_SDHCI */
-
 /* S3C64XX SDHCI setup */
 
 #ifdef CONFIG_S3C64XX_SETUP_SDHCI
diff --git a/arch/arm/mach-s3c/setup-ide-s3c64xx.c b/arch/arm/mach-s3c/setup-ide-s3c64xx.c
deleted file mode 100644
index f11f2b02e49f..000000000000
diff --git a/arch/arm/mach-s3c/sleep-s3c64xx.S b/arch/arm/mach-s3c/sleep-s3c64xx.S
index 739e53fbce09..908aa76b1062 100644
--- a/arch/arm/mach-s3c/sleep-s3c64xx.S
+++ b/arch/arm/mach-s3c/sleep-s3c64xx.S
@@ -39,31 +39,4 @@
 ENTRY(s3c_cpu_resume)
 	msr	cpsr_c, #PSR_I_BIT | PSR_F_BIT | SVC_MODE
 	ldr	r2, =LL_UART		/* for debug */
-
-#ifdef CONFIG_S3C_PM_DEBUG_LED_SMDK
-
-#define S3C64XX_GPNCON			(S3C64XX_GPN_BASE + 0x00)
-#define S3C64XX_GPNDAT			(S3C64XX_GPN_BASE + 0x04)
-
-#define S3C64XX_GPN_CONMASK(__gpio)	(0x3 << ((__gpio) * 2))
-#define S3C64XX_GPN_OUTPUT(__gpio)	(0x1 << ((__gpio) * 2))
-
-	/* Initialise the GPIO state if we are debugging via the SMDK LEDs,
-	 * as the uboot version supplied resets these to inputs during the
-	 * resume checks.
-	*/
-
-	ldr	r3, =S3C64XX_PA_GPIO
-	ldr	r0, [ r3, #S3C64XX_GPNCON ]
-	bic	r0, r0, #(S3C64XX_GPN_CONMASK(12) | S3C64XX_GPN_CONMASK(13) | \
-			  S3C64XX_GPN_CONMASK(14) | S3C64XX_GPN_CONMASK(15))
-	orr	r0, r0, #(S3C64XX_GPN_OUTPUT(12) | S3C64XX_GPN_OUTPUT(13) | \
-			  S3C64XX_GPN_OUTPUT(14) | S3C64XX_GPN_OUTPUT(15))
-	str	r0, [ r3, #S3C64XX_GPNCON ]
-
-	ldr	r0, [ r3, #S3C64XX_GPNDAT ]
-	bic	r0, r0, #0xf << 12			@ GPN12..15
-	orr	r0, r0, #1 << 15			@ GPN15
-	str	r0, [ r3, #S3C64XX_GPNDAT ]
-#endif
 	b	cpu_resume
diff --git a/include/linux/platform_data/media/s5p_hdmi.h b/include/linux/platform_data/media/s5p_hdmi.h
deleted file mode 100644
index 457321e917b9..000000000000
-- 
2.29.2

