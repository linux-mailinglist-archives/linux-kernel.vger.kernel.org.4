Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CFD65EDCF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbjAENth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbjAENtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:49:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FC7479F5;
        Thu,  5 Jan 2023 05:47:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22B1BB81AEB;
        Thu,  5 Jan 2023 13:47:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E092C433F0;
        Thu,  5 Jan 2023 13:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672926453;
        bh=/FS8fBmu6pkebaZatQp3ZoSENMWZyiaJpwoCDpO4hWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jm+NeQGSKbwVMEHk1yxqRUvzXRIbut8bFNcg4c6VdmR+pP28NrpHrdFqm6pn/OZQN
         7X3Re7172JGOtRjUmutdHJ5nC6UL/H2z9BSBK0GSjllTTYb3BXOUurEULihRrDz17f
         LkXNElhBjKjYQZcWxsGC0GmA6W1MtGKqqCcwULz6p7MBV78UkZYtKlyVaADSy9dMHH
         LL6/d05bpTusmbbmzk3/w88r0oAlfG8BjLpFpQeKl9a0/EhjpVmGXTA/kjJzrOs/vA
         t2b0DVschHyxCL5qkMEPsWUv21IA7UOogug/q0dKML1/uQ/Qos44YVMSXpzLSxtIF2
         3MWFFvQ3GS0YQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Marek Vasut <marex@denx.de>,
        linux-gpio@vger.kernel.org, linux-input@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: [PATCH 19/27] mfd: remove ucb1400 support
Date:   Thu,  5 Jan 2023 14:46:14 +0100
Message-Id: <20230105134622.254560-20-arnd@kernel.org>
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

The ucb1400 MFD driver and its gpio and touchscreen child
drivers were only used on a few PXA machines that were unused
for a while and are now removed.

Removing these leaves the AC97 support as ALSA specific,
no other drivers are now connected through this interface.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Lee Jones <lee@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Marek Vasut <marex@denx.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
Cc: linux-input@vger.kernel.org
Cc: alsa-devel@alsa-project.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpio/Kconfig                   |   7 -
 drivers/gpio/Makefile                  |   1 -
 drivers/gpio/gpio-ucb1400.c            |  85 -----
 drivers/input/touchscreen/Kconfig      |  16 -
 drivers/input/touchscreen/Makefile     |   1 -
 drivers/input/touchscreen/ucb1400_ts.c | 458 -------------------------
 drivers/mfd/Kconfig                    |  11 -
 drivers/mfd/Makefile                   |   1 -
 drivers/mfd/ucb1400_core.c             | 158 ---------
 include/linux/ucb1400.h                | 160 ---------
 sound/Kconfig                          |   1 -
 sound/pci/ac97/ac97_codec.c            |   1 -
 sound/pci/ac97/ac97_patch.c            |  40 ---
 13 files changed, 940 deletions(-)
 delete mode 100644 drivers/gpio/gpio-ucb1400.c
 delete mode 100644 drivers/input/touchscreen/ucb1400_ts.c
 delete mode 100644 drivers/mfd/ucb1400_core.c
 delete mode 100644 include/linux/ucb1400.h

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 0148553790eb..df2dfbb2601e 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1428,13 +1428,6 @@ config GPIO_TWL6040
 	  Say yes here to access the GPO signals of twl6040
 	  audio chip from Texas Instruments.
 
-config GPIO_UCB1400
-	tristate "Philips UCB1400 GPIO"
-	depends on UCB1400_CORE
-	help
-	  This enables support for the Philips UCB1400 GPIO pins.
-	  The UCB1400 is an AC97 audio codec.
-
 config GPIO_WHISKEY_COVE
 	tristate "GPIO support for Whiskey Cove PMIC"
 	depends on (X86 || COMPILE_TEST) && INTEL_SOC_PMIC_BXTWC
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 59ac21054261..c048ba003367 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -165,7 +165,6 @@ obj-$(CONFIG_GPIO_TS4900)		+= gpio-ts4900.o
 obj-$(CONFIG_GPIO_TS5500)		+= gpio-ts5500.o
 obj-$(CONFIG_GPIO_TWL4030)		+= gpio-twl4030.o
 obj-$(CONFIG_GPIO_TWL6040)		+= gpio-twl6040.o
-obj-$(CONFIG_GPIO_UCB1400)		+= gpio-ucb1400.o
 obj-$(CONFIG_GPIO_UNIPHIER)		+= gpio-uniphier.o
 obj-$(CONFIG_GPIO_VF610)		+= gpio-vf610.o
 obj-$(CONFIG_GPIO_VIPERBOARD)		+= gpio-viperboard.o
diff --git a/drivers/gpio/gpio-ucb1400.c b/drivers/gpio/gpio-ucb1400.c
deleted file mode 100644
index 676adf1f198a..000000000000
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index ca00f55eaf45..1a2049b336a6 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -827,22 +827,6 @@ config TOUCHSCREEN_TI_AM335X_TSC
 	  To compile this driver as a module, choose M here: the
 	  module will be called ti_am335x_tsc.
 
-config TOUCHSCREEN_UCB1400
-	tristate "Philips UCB1400 touchscreen"
-	depends on AC97_BUS
-	depends on UCB1400_CORE
-	help
-	  This enables support for the Philips UCB1400 touchscreen interface.
-	  The UCB1400 is an AC97 audio codec.  The touchscreen interface
-	  will be initialized only after the ALSA subsystem has been
-	  brought up and the UCB1400 detected.  You therefore have to
-	  configure ALSA support as well (either built-in or modular,
-	  independently of whether this driver is itself built-in or
-	  modular) for this driver to work.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ucb1400_ts.
-
 config TOUCHSCREEN_PIXCIR
 	tristate "PIXCIR I2C touchscreens"
 	depends on I2C
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 7053fede594e..f2fd28cc34a6 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -97,7 +97,6 @@ obj-$(CONFIG_TOUCHSCREEN_TSC2005)	+= tsc2005.o
 tsc2007-y := tsc2007_core.o
 tsc2007-$(CONFIG_TOUCHSCREEN_TSC2007_IIO)	+= tsc2007_iio.o
 obj-$(CONFIG_TOUCHSCREEN_TSC2007)	+= tsc2007.o
-obj-$(CONFIG_TOUCHSCREEN_UCB1400)	+= ucb1400_ts.o
 obj-$(CONFIG_TOUCHSCREEN_WACOM_W8001)	+= wacom_w8001.o
 obj-$(CONFIG_TOUCHSCREEN_WACOM_I2C)	+= wacom_i2c.o
 obj-$(CONFIG_TOUCHSCREEN_WDT87XX_I2C)	+= wdt87xx_i2c.o
diff --git a/drivers/input/touchscreen/ucb1400_ts.c b/drivers/input/touchscreen/ucb1400_ts.c
deleted file mode 100644
index dfd3b35590c3..000000000000
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index da57ebf22630..5ea07a65f150 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1071,17 +1071,6 @@ config PCF50633_GPIO
 	  Say yes here if you want to include support GPIO for pins on
 	  the PCF50633 chip.
 
-config UCB1400_CORE
-	tristate "Philips UCB1400 Core driver"
-	depends on AC97_BUS
-	depends on GPIOLIB
-	help
-	  This enables support for the Philips UCB1400 core functions.
-	  The UCB1400 is an AC97 audio codec.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ucb1400_core.
-
 config MFD_PM8XXX
 	tristate "Qualcomm PM8xxx PMIC chips driver"
 	depends on (ARM || HEXAGON || COMPILE_TEST)
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 9ba9d711c492..4969ea6e24f1 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -127,7 +127,6 @@ obj-$(CONFIG_MCP_UCB1200_TS)	+= ucb1x00-ts.o
 ifeq ($(CONFIG_SA1100_ASSABET),y)
 obj-$(CONFIG_MCP_UCB1200)	+= ucb1x00-assabet.o
 endif
-obj-$(CONFIG_UCB1400_CORE)	+= ucb1400_core.o
 
 obj-$(CONFIG_PMIC_DA903X)	+= da903x.o
 
diff --git a/drivers/mfd/ucb1400_core.c b/drivers/mfd/ucb1400_core.c
deleted file mode 100644
index ac1d18039568..000000000000
diff --git a/include/linux/ucb1400.h b/include/linux/ucb1400.h
deleted file mode 100644
index 2516082cd3a9..000000000000
diff --git a/sound/Kconfig b/sound/Kconfig
index e56d96d2b11c..0ddfb717b81d 100644
--- a/sound/Kconfig
+++ b/sound/Kconfig
@@ -107,7 +107,6 @@ endif # !UML
 
 endif # SOUND
 
-# AC97_BUS is used from both sound and ucb1400
 config AC97_BUS
 	tristate
 	help
diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
index ff685321f1a1..9afc5906d662 100644
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -152,7 +152,6 @@ static const struct ac97_codec_id snd_ac97_codec_ids[] = {
 { 0x4e534300, 0xffffffff, "LM4540,43,45,46,48",	NULL,		NULL }, // only guess --jk
 { 0x4e534331, 0xffffffff, "LM4549",		NULL,		NULL },
 { 0x4e534350, 0xffffffff, "LM4550",		patch_lm4550,  	NULL }, // volume wrap fix 
-{ 0x50534304, 0xffffffff, "UCB1400",		patch_ucb1400,	NULL },
 { 0x53494c20, 0xffffffe0, "Si3036,8",		mpatch_si3036,	mpatch_si3036, AC97_MODEM_PATCH },
 { 0x53544d02, 0xffffffff, "ST7597",		NULL,		NULL },
 { 0x54524102, 0xffffffff, "TR28022",		NULL,		NULL },
diff --git a/sound/pci/ac97/ac97_patch.c b/sound/pci/ac97/ac97_patch.c
index 025c1666c1fc..4b5f33de70d5 100644
--- a/sound/pci/ac97/ac97_patch.c
+++ b/sound/pci/ac97/ac97_patch.c
@@ -3937,43 +3937,3 @@ static int patch_lm4550(struct snd_ac97 *ac97)
 	ac97->res_table = lm4550_restbl;
 	return 0;
 }
-
-/* 
- *  UCB1400 codec (http://www.semiconductors.philips.com/acrobat_download/datasheets/UCB1400-02.pdf)
- */
-static const struct snd_kcontrol_new snd_ac97_controls_ucb1400[] = {
-/* enable/disable headphone driver which allows direct connection to
-   stereo headphone without the use of external DC blocking
-   capacitors */
-AC97_SINGLE("Headphone Driver", 0x6a, 6, 1, 0),
-/* Filter used to compensate the DC offset is added in the ADC to remove idle
-   tones from the audio band. */
-AC97_SINGLE("DC Filter", 0x6a, 4, 1, 0),
-/* Control smart-low-power mode feature. Allows automatic power down
-   of unused blocks in the ADC analog front end and the PLL. */
-AC97_SINGLE("Smart Low Power Mode", 0x6c, 4, 3, 0),
-};
-
-static int patch_ucb1400_specific(struct snd_ac97 * ac97)
-{
-	int idx, err;
-	for (idx = 0; idx < ARRAY_SIZE(snd_ac97_controls_ucb1400); idx++) {
-		err = snd_ctl_add(ac97->bus->card, snd_ctl_new1(&snd_ac97_controls_ucb1400[idx], ac97));
-		if (err < 0)
-			return err;
-	}
-	return 0;
-}
-
-static const struct snd_ac97_build_ops patch_ucb1400_ops = {
-	.build_specific	= patch_ucb1400_specific,
-};
-
-static int patch_ucb1400(struct snd_ac97 * ac97)
-{
-	ac97->build_ops = &patch_ucb1400_ops;
-	/* enable headphone driver and smart low power mode by default */
-	snd_ac97_write_cache(ac97, 0x6a, 0x0050);
-	snd_ac97_write_cache(ac97, 0x6c, 0x0030);
-	return 0;
-}
-- 
2.39.0

