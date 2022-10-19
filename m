Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65D2604BD7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbiJSPl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbiJSPks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:40:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F27313F45;
        Wed, 19 Oct 2022 08:37:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D37606174E;
        Wed, 19 Oct 2022 15:35:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82153C433C1;
        Wed, 19 Oct 2022 15:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666193734;
        bh=MHcJ8HZS/GggNKwC2jalHkoMLUqykbU/CG1lvW3RYxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rhrtsc13qr7/AFkhS/dIGyPDrMvL5k03JKgnF0xGg0fFD37OnaQsxW6QQ0P27Fuqp
         N8/R4P6sSYxd529CDxuZ/CnKq8UHrNRYrT+I5X3Rc70J1efk8C6U3mV6Tqmz2MmHuB
         yl6hdA10/PC0DDgWpdAXqvhuPFn+qOdo1ANcq53eV37W6VdMud7lKpz/+QNgMQhTlV
         nWlznMR/yYYtCLaL8TJMKnt/Id1+DtMvcMfEyTJ680lkJlWM6QP3iPFBWWPq4VYVNX
         dT30xgNmqzJjj8hP7e8edFTHbqLwMWo4zIPmWGq4WHkGsrU8vEQ+wkzHAHVgE7QAvX
         QYMWT+LgkC5Ew==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Sekhar Nori <nsekhar@ti.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-arm-kernel@lists.infradead.org, Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-input@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: [PATCH 06/14] mfd: remove dm355evm_msp driver
Date:   Wed, 19 Oct 2022 17:29:32 +0200
Message-Id: <20221019152947.3857217-7-arnd@kernel.org>
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

The DaVinci DM355EVM platform is gone after the removal of all
unused board files, so the MTD device along with its sub-devices
can be removed as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/misc/Kconfig         |  11 -
 drivers/input/misc/Makefile        |   1 -
 drivers/input/misc/dm355evm_keys.c | 238 ---------------
 drivers/mfd/Kconfig                |   8 -
 drivers/mfd/Makefile               |   1 -
 drivers/mfd/dm355evm_msp.c         | 454 -----------------------------
 drivers/rtc/Kconfig                |   6 -
 drivers/rtc/Makefile               |   1 -
 drivers/rtc/rtc-dm355evm.c         | 151 ----------
 include/linux/mfd/dm355evm_msp.h   |  79 -----
 10 files changed, 950 deletions(-)
 delete mode 100644 drivers/input/misc/dm355evm_keys.c
 delete mode 100644 drivers/mfd/dm355evm_msp.c
 delete mode 100644 drivers/rtc/rtc-dm355evm.c
 delete mode 100644 include/linux/mfd/dm355evm_msp.h

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 9f088900f863..540633b164d4 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -662,17 +662,6 @@ config INPUT_DA9063_ONKEY
 	  To compile this driver as a module, choose M here: the module
 	  will be called da9063_onkey.
 
-config INPUT_DM355EVM
-	tristate "TI DaVinci DM355 EVM Keypad and IR Remote"
-	depends on MFD_DM355EVM_MSP
-	select INPUT_SPARSEKMAP
-	help
-	  Supports the pushbuttons and IR remote used with
-	  the DM355 EVM board.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called dm355evm_keys.
-
 config INPUT_WM831X_ON
 	tristate "WM831X ON pin"
 	depends on MFD_WM831X
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 6abefc41037b..156f9c21f53b 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -31,7 +31,6 @@ obj-$(CONFIG_INPUT_DA7280_HAPTICS)	+= da7280.o
 obj-$(CONFIG_INPUT_DA9052_ONKEY)	+= da9052_onkey.o
 obj-$(CONFIG_INPUT_DA9055_ONKEY)	+= da9055_onkey.o
 obj-$(CONFIG_INPUT_DA9063_ONKEY)	+= da9063_onkey.o
-obj-$(CONFIG_INPUT_DM355EVM)		+= dm355evm_keys.o
 obj-$(CONFIG_INPUT_E3X0_BUTTON)		+= e3x0-button.o
 obj-$(CONFIG_INPUT_DRV260X_HAPTICS)	+= drv260x.o
 obj-$(CONFIG_INPUT_DRV2665_HAPTICS)	+= drv2665.o
diff --git a/drivers/input/misc/dm355evm_keys.c b/drivers/input/misc/dm355evm_keys.c
deleted file mode 100644
index 397ca7c787cc..000000000000
--- a/drivers/input/misc/dm355evm_keys.c
+++ /dev/null
@@ -1,238 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * dm355evm_keys.c - support buttons and IR remote on DM355 EVM board
- *
- * Copyright (c) 2008 by David Brownell
- */
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/input.h>
-#include <linux/input/sparse-keymap.h>
-#include <linux/platform_device.h>
-#include <linux/interrupt.h>
-
-#include <linux/mfd/dm355evm_msp.h>
-#include <linux/module.h>
-
-
-/*
- * The MSP430 firmware on the DM355 EVM monitors on-board pushbuttons
- * and an IR receptor used for the remote control.  When any key is
- * pressed, or its autorepeat kicks in, an event is sent.  This driver
- * read those events from the small (32 event) queue and reports them.
- *
- * Note that physically there can only be one of these devices.
- *
- * This driver was tested with firmware revision A4.
- */
-struct dm355evm_keys {
-	struct input_dev	*input;
-	struct device		*dev;
-};
-
-/* These initial keycodes can be remapped */
-static const struct key_entry dm355evm_keys[] = {
-	/*
-	 * Pushbuttons on the EVM board ... note that the labels for these
-	 * are SW10/SW11/etc on the PC board.  The left/right orientation
-	 * comes only from the firmware's documentation, and presumes the
-	 * power connector is immediately in front of you and the IR sensor
-	 * is to the right.  (That is, rotate the board counter-clockwise
-	 * by 90 degrees from the SW10/etc and "DM355 EVM" labels.)
-	 */
-	{ KE_KEY, 0x00d8, { KEY_OK } },		/* SW12 */
-	{ KE_KEY, 0x00b8, { KEY_UP } },		/* SW13 */
-	{ KE_KEY, 0x00e8, { KEY_DOWN } },	/* SW11 */
-	{ KE_KEY, 0x0078, { KEY_LEFT } },	/* SW14 */
-	{ KE_KEY, 0x00f0, { KEY_RIGHT } },	/* SW10 */
-
-	/*
-	 * IR buttons ... codes assigned to match the universal remote
-	 * provided with the EVM (Philips PM4S) using DVD code 0020.
-	 *
-	 * These event codes match firmware documentation, but other
-	 * remote controls could easily send more RC5-encoded events.
-	 * The PM4S manual was used in several cases to help select
-	 * a keycode reflecting the intended usage.
-	 *
-	 * RC5 codes are 14 bits, with two start bits (0x3 prefix)
-	 * and a toggle bit (masked out below).
-	 */
-	{ KE_KEY, 0x300c, { KEY_POWER } },	/* NOTE: docs omit this */
-	{ KE_KEY, 0x3000, { KEY_NUMERIC_0 } },
-	{ KE_KEY, 0x3001, { KEY_NUMERIC_1 } },
-	{ KE_KEY, 0x3002, { KEY_NUMERIC_2 } },
-	{ KE_KEY, 0x3003, { KEY_NUMERIC_3 } },
-	{ KE_KEY, 0x3004, { KEY_NUMERIC_4 } },
-	{ KE_KEY, 0x3005, { KEY_NUMERIC_5 } },
-	{ KE_KEY, 0x3006, { KEY_NUMERIC_6 } },
-	{ KE_KEY, 0x3007, { KEY_NUMERIC_7 } },
-	{ KE_KEY, 0x3008, { KEY_NUMERIC_8 } },
-	{ KE_KEY, 0x3009, { KEY_NUMERIC_9 } },
-	{ KE_KEY, 0x3022, { KEY_ENTER } },
-	{ KE_KEY, 0x30ec, { KEY_MODE } },	/* "tv/vcr/..." */
-	{ KE_KEY, 0x300f, { KEY_SELECT } },	/* "info" */
-	{ KE_KEY, 0x3020, { KEY_CHANNELUP } },	/* "up" */
-	{ KE_KEY, 0x302e, { KEY_MENU } },	/* "in/out" */
-	{ KE_KEY, 0x3011, { KEY_VOLUMEDOWN } },	/* "left" */
-	{ KE_KEY, 0x300d, { KEY_MUTE } },	/* "ok" */
-	{ KE_KEY, 0x3010, { KEY_VOLUMEUP } },	/* "right" */
-	{ KE_KEY, 0x301e, { KEY_SUBTITLE } },	/* "cc" */
-	{ KE_KEY, 0x3021, { KEY_CHANNELDOWN } },/* "down" */
-	{ KE_KEY, 0x3022, { KEY_PREVIOUS } },
-	{ KE_KEY, 0x3026, { KEY_SLEEP } },
-	{ KE_KEY, 0x3172, { KEY_REWIND } },	/* NOTE: docs wrongly say 0x30ca */
-	{ KE_KEY, 0x3175, { KEY_PLAY } },
-	{ KE_KEY, 0x3174, { KEY_FASTFORWARD } },
-	{ KE_KEY, 0x3177, { KEY_RECORD } },
-	{ KE_KEY, 0x3176, { KEY_STOP } },
-	{ KE_KEY, 0x3169, { KEY_PAUSE } },
-};
-
-/*
- * Because we communicate with the MSP430 using I2C, and all I2C calls
- * in Linux sleep, we use a threaded IRQ handler.  The IRQ itself is
- * active low, but we go through the GPIO controller so we can trigger
- * on falling edges and not worry about enabling/disabling the IRQ in
- * the keypress handling path.
- */
-static irqreturn_t dm355evm_keys_irq(int irq, void *_keys)
-{
-	static u16 last_event;
-	struct dm355evm_keys *keys = _keys;
-	const struct key_entry *ke;
-	unsigned int keycode;
-	int status;
-	u16 event;
-
-	/* For simplicity we ignore INPUT_COUNT and just read
-	 * events until we get the "queue empty" indicator.
-	 * Reading INPUT_LOW decrements the count.
-	 */
-	for (;;) {
-		status = dm355evm_msp_read(DM355EVM_MSP_INPUT_HIGH);
-		if (status < 0) {
-			dev_dbg(keys->dev, "input high err %d\n",
-					status);
-			break;
-		}
-		event = status << 8;
-
-		status = dm355evm_msp_read(DM355EVM_MSP_INPUT_LOW);
-		if (status < 0) {
-			dev_dbg(keys->dev, "input low err %d\n",
-					status);
-			break;
-		}
-		event |= status;
-		if (event == 0xdead)
-			break;
-
-		/* Press and release a button:  two events, same code.
-		 * Press and hold (autorepeat), then release: N events
-		 * (N > 2), same code.  For RC5 buttons the toggle bits
-		 * distinguish (for example) "1-autorepeat" from "1 1";
-		 * but PCB buttons don't support that bit.
-		 *
-		 * So we must synthesize release events.  We do that by
-		 * mapping events to a press/release event pair; then
-		 * to avoid adding extra events, skip the second event
-		 * of each pair.
-		 */
-		if (event == last_event) {
-			last_event = 0;
-			continue;
-		}
-		last_event = event;
-
-		/* ignore the RC5 toggle bit */
-		event &= ~0x0800;
-
-		/* find the key, or report it as unknown */
-		ke = sparse_keymap_entry_from_scancode(keys->input, event);
-		keycode = ke ? ke->keycode : KEY_UNKNOWN;
-		dev_dbg(keys->dev,
-			"input event 0x%04x--> keycode %d\n",
-			event, keycode);
-
-		/* report press + release */
-		input_report_key(keys->input, keycode, 1);
-		input_sync(keys->input);
-		input_report_key(keys->input, keycode, 0);
-		input_sync(keys->input);
-	}
-
-	return IRQ_HANDLED;
-}
-
-/*----------------------------------------------------------------------*/
-
-static int dm355evm_keys_probe(struct platform_device *pdev)
-{
-	struct dm355evm_keys	*keys;
-	struct input_dev	*input;
-	int			irq;
-	int			error;
-
-	keys = devm_kzalloc(&pdev->dev, sizeof (*keys), GFP_KERNEL);
-	if (!keys)
-		return -ENOMEM;
-
-	input = devm_input_allocate_device(&pdev->dev);
-	if (!input)
-		return -ENOMEM;
-
-	keys->dev = &pdev->dev;
-	keys->input = input;
-
-	input->name = "DM355 EVM Controls";
-	input->phys = "dm355evm/input0";
-
-	input->id.bustype = BUS_I2C;
-	input->id.product = 0x0355;
-	input->id.version = dm355evm_msp_read(DM355EVM_MSP_FIRMREV);
-
-	error = sparse_keymap_setup(input, dm355evm_keys, NULL);
-	if (error)
-		return error;
-
-	/* REVISIT:  flush the event queue? */
-
-	/* set up "threaded IRQ handler" */
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
-
-	error = devm_request_threaded_irq(&pdev->dev, irq,
-					  NULL, dm355evm_keys_irq,
-					  IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-					  dev_name(&pdev->dev), keys);
-	if (error)
-		return error;
-
-	/* register */
-	error = input_register_device(input);
-	if (error)
-		return error;
-
-	return 0;
-}
-
-/* REVISIT:  add suspend/resume when DaVinci supports it.  The IRQ should
- * be able to wake up the system.  When device_may_wakeup(&pdev->dev), call
- * enable_irq_wake() on suspend, and disable_irq_wake() on resume.
- */
-
-/*
- * I2C is used to talk to the MSP430, but this platform device is
- * exposed by an MFD driver that manages I2C communications.
- */
-static struct platform_driver dm355evm_keys_driver = {
-	.probe		= dm355evm_keys_probe,
-	.driver		= {
-		.name	= "dm355evm_keys",
-	},
-};
-module_platform_driver(dm355evm_keys_driver);
-
-MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 11c3bd0bd669..31751cd3c4ed 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1439,14 +1439,6 @@ config MFD_TI_AM335X_TSCADC
 	  To compile this driver as a module, choose M here: the
 	  module will be called ti_am335x_tscadc.
 
-config MFD_DM355EVM_MSP
-	bool "TI DaVinci DM355 EVM microcontroller"
-	depends on I2C=y && MACH_DAVINCI_DM355_EVM
-	help
-	  This driver supports the MSP430 microcontroller used on these
-	  boards.  MSP430 firmware manages resets and power sequencing,
-	  inputs from buttons and the IR remote, LEDs, an RTC, and more.
-
 config MFD_LP3943
 	tristate "TI/National Semiconductor LP3943 MFD Driver"
 	depends on I2C
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index d74bf111f88e..a3a304f8c762 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -24,7 +24,6 @@ obj-$(CONFIG_MFD_TI_LP873X)	+= lp873x.o
 obj-$(CONFIG_MFD_TI_LP87565)	+= lp87565.o
 
 obj-$(CONFIG_MFD_DAVINCI_VOICECODEC)	+= davinci_voicecodec.o
-obj-$(CONFIG_MFD_DM355EVM_MSP)	+= dm355evm_msp.o
 obj-$(CONFIG_MFD_TI_AM335X_TSCADC)	+= ti_am335x_tscadc.o
 
 obj-$(CONFIG_MFD_STA2X11)	+= sta2x11-mfd.o
diff --git a/drivers/mfd/dm355evm_msp.c b/drivers/mfd/dm355evm_msp.c
deleted file mode 100644
index 759c59690680..000000000000
--- a/drivers/mfd/dm355evm_msp.c
+++ /dev/null
@@ -1,454 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * dm355evm_msp.c - driver for MSP430 firmware on DM355EVM board
- *
- * Copyright (C) 2008 David Brownell
- */
-
-#include <linux/init.h>
-#include <linux/mutex.h>
-#include <linux/platform_device.h>
-#include <linux/clk.h>
-#include <linux/module.h>
-#include <linux/err.h>
-#include <linux/gpio.h>
-#include <linux/gpio/machine.h>
-#include <linux/leds.h>
-#include <linux/i2c.h>
-#include <linux/mfd/dm355evm_msp.h>
-
-
-/*
- * The DM355 is a DaVinci chip with video support but no C64+ DSP.  Its
- * EVM board has an MSP430 programmed with firmware for various board
- * support functions.  This driver exposes some of them directly, and
- * supports other drivers (e.g. RTC, input) for more complex access.
- *
- * Because this firmware is entirely board-specific, this file embeds
- * knowledge that would be passed as platform_data in a generic driver.
- *
- * This driver was tested with firmware revision A4.
- */
-
-#if IS_ENABLED(CONFIG_INPUT_DM355EVM)
-#define msp_has_keyboard()	true
-#else
-#define msp_has_keyboard()	false
-#endif
-
-#if IS_ENABLED(CONFIG_LEDS_GPIO)
-#define msp_has_leds()		true
-#else
-#define msp_has_leds()		false
-#endif
-
-#if IS_ENABLED(CONFIG_RTC_DRV_DM355EVM)
-#define msp_has_rtc()		true
-#else
-#define msp_has_rtc()		false
-#endif
-
-#if IS_ENABLED(CONFIG_VIDEO_TVP514X)
-#define msp_has_tvp()		true
-#else
-#define msp_has_tvp()		false
-#endif
-
-
-/*----------------------------------------------------------------------*/
-
-/* REVISIT for paranoia's sake, retry reads/writes on error */
-
-static struct i2c_client *msp430;
-
-/**
- * dm355evm_msp_write - Writes a register in dm355evm_msp
- * @value: the value to be written
- * @reg: register address
- *
- * Returns result of operation - 0 is success, else negative errno
- */
-int dm355evm_msp_write(u8 value, u8 reg)
-{
-	return i2c_smbus_write_byte_data(msp430, reg, value);
-}
-EXPORT_SYMBOL(dm355evm_msp_write);
-
-/**
- * dm355evm_msp_read - Reads a register from dm355evm_msp
- * @reg: register address
- *
- * Returns result of operation - value, or negative errno
- */
-int dm355evm_msp_read(u8 reg)
-{
-	return i2c_smbus_read_byte_data(msp430, reg);
-}
-EXPORT_SYMBOL(dm355evm_msp_read);
-
-/*----------------------------------------------------------------------*/
-
-/*
- * Many of the msp430 pins are just used as fixed-direction GPIOs.
- * We could export a few more of them this way, if we wanted.
- */
-#define MSP_GPIO(bit, reg)	((DM355EVM_MSP_ ## reg) << 3 | (bit))
-
-static const u8 msp_gpios[] = {
-	/* eight leds */
-	MSP_GPIO(0, LED), MSP_GPIO(1, LED),
-	MSP_GPIO(2, LED), MSP_GPIO(3, LED),
-	MSP_GPIO(4, LED), MSP_GPIO(5, LED),
-	MSP_GPIO(6, LED), MSP_GPIO(7, LED),
-	/* SW6 and the NTSC/nPAL jumper */
-	MSP_GPIO(0, SWITCH1), MSP_GPIO(1, SWITCH1),
-	MSP_GPIO(2, SWITCH1), MSP_GPIO(3, SWITCH1),
-	MSP_GPIO(4, SWITCH1),
-	/* switches on MMC/SD sockets */
-	/*
-	 * Note: EVMDM355_ECP_VA4.pdf suggests that Bit 2 and 4 should be
-	 * checked for card detection. However on the EVM bit 1 and 3 gives
-	 * this status, for 0 and 1 instance respectively. The pdf also
-	 * suggests that Bit 1 and 3 should be checked for write protection.
-	 * However on the EVM bit 2 and 4 gives this status,for 0 and 1
-	 * instance respectively.
-	 */
-	MSP_GPIO(2, SDMMC), MSP_GPIO(1, SDMMC),	/* mmc0 WP, nCD */
-	MSP_GPIO(4, SDMMC), MSP_GPIO(3, SDMMC),	/* mmc1 WP, nCD */
-};
-
-static struct gpio_led evm_leds[] = {
-	{ .name = "dm355evm::ds14",
-	  .default_trigger = "heartbeat", },
-	{ .name = "dm355evm::ds15",
-	  .default_trigger = "mmc0", },
-	{ .name = "dm355evm::ds16",
-	  /* could also be a CE-ATA drive */
-	  .default_trigger = "mmc1", },
-	{ .name = "dm355evm::ds17",
-	  .default_trigger = "nand-disk", },
-	{ .name = "dm355evm::ds18", },
-	{ .name = "dm355evm::ds19", },
-	{ .name = "dm355evm::ds20", },
-	{ .name = "dm355evm::ds21", },
-};
-
-static struct gpio_led_platform_data evm_led_data = {
-	.num_leds	= ARRAY_SIZE(evm_leds),
-	.leds		= evm_leds,
-};
-
-static struct gpiod_lookup_table evm_leds_gpio_table = {
-	.dev_id = "leds-gpio",
-	.table = {
-		/*
-		 * These GPIOs are on the dm355evm_msp
-		 * GPIO chip at index 0..7
-		 */
-		GPIO_LOOKUP_IDX("dm355evm_msp", 0, NULL,
-				0, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("dm355evm_msp", 1, NULL,
-				1, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("dm355evm_msp", 2, NULL,
-				2, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("dm355evm_msp", 3, NULL,
-				3, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("dm355evm_msp", 4, NULL,
-				4, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("dm355evm_msp", 5, NULL,
-				5, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("dm355evm_msp", 6, NULL,
-				6, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX("dm355evm_msp", 7, NULL,
-				7, GPIO_ACTIVE_LOW),
-		{ },
-	},
-};
-
-#define MSP_GPIO_REG(offset)	(msp_gpios[(offset)] >> 3)
-#define MSP_GPIO_MASK(offset)	BIT(msp_gpios[(offset)] & 0x07)
-
-static int msp_gpio_in(struct gpio_chip *chip, unsigned offset)
-{
-	switch (MSP_GPIO_REG(offset)) {
-	case DM355EVM_MSP_SWITCH1:
-	case DM355EVM_MSP_SWITCH2:
-	case DM355EVM_MSP_SDMMC:
-		return 0;
-	default:
-		return -EINVAL;
-	}
-}
-
-static u8 msp_led_cache;
-
-static int msp_gpio_get(struct gpio_chip *chip, unsigned offset)
-{
-	int reg, status;
-
-	reg = MSP_GPIO_REG(offset);
-	status = dm355evm_msp_read(reg);
-	if (status < 0)
-		return status;
-	if (reg == DM355EVM_MSP_LED)
-		msp_led_cache = status;
-	return !!(status & MSP_GPIO_MASK(offset));
-}
-
-static int msp_gpio_out(struct gpio_chip *chip, unsigned offset, int value)
-{
-	int mask, bits;
-
-	/* NOTE:  there are some other signals that could be
-	 * packaged as output GPIOs, but they aren't as useful
-	 * as the LEDs ... so for now we don't.
-	 */
-	if (MSP_GPIO_REG(offset) != DM355EVM_MSP_LED)
-		return -EINVAL;
-
-	mask = MSP_GPIO_MASK(offset);
-	bits = msp_led_cache;
-
-	bits &= ~mask;
-	if (value)
-		bits |= mask;
-	msp_led_cache = bits;
-
-	return dm355evm_msp_write(bits, DM355EVM_MSP_LED);
-}
-
-static void msp_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
-{
-	msp_gpio_out(chip, offset, value);
-}
-
-static struct gpio_chip dm355evm_msp_gpio = {
-	.label			= "dm355evm_msp",
-	.owner			= THIS_MODULE,
-	.direction_input	= msp_gpio_in,
-	.get			= msp_gpio_get,
-	.direction_output	= msp_gpio_out,
-	.set			= msp_gpio_set,
-	.base			= -EINVAL,		/* dynamic assignment */
-	.ngpio			= ARRAY_SIZE(msp_gpios),
-	.can_sleep		= true,
-};
-
-/*----------------------------------------------------------------------*/
-
-static struct device *add_child(struct i2c_client *client, const char *name,
-		void *pdata, unsigned pdata_len,
-		bool can_wakeup, int irq)
-{
-	struct platform_device	*pdev;
-	int			status;
-
-	pdev = platform_device_alloc(name, -1);
-	if (!pdev)
-		return ERR_PTR(-ENOMEM);
-
-	device_init_wakeup(&pdev->dev, can_wakeup);
-	pdev->dev.parent = &client->dev;
-
-	if (pdata) {
-		status = platform_device_add_data(pdev, pdata, pdata_len);
-		if (status < 0) {
-			dev_dbg(&pdev->dev, "can't add platform_data\n");
-			goto put_device;
-		}
-	}
-
-	if (irq) {
-		struct resource r = {
-			.start = irq,
-			.flags = IORESOURCE_IRQ,
-		};
-
-		status = platform_device_add_resources(pdev, &r, 1);
-		if (status < 0) {
-			dev_dbg(&pdev->dev, "can't add irq\n");
-			goto put_device;
-		}
-	}
-
-	status = platform_device_add(pdev);
-	if (status)
-		goto put_device;
-
-	return &pdev->dev;
-
-put_device:
-	platform_device_put(pdev);
-	dev_err(&client->dev, "failed to add device %s\n", name);
-	return ERR_PTR(status);
-}
-
-static int add_children(struct i2c_client *client)
-{
-	static const struct {
-		int offset;
-		char *label;
-	} config_inputs[] = {
-		/* 8 == right after the LEDs */
-		{ 8 + 0, "sw6_1", },
-		{ 8 + 1, "sw6_2", },
-		{ 8 + 2, "sw6_3", },
-		{ 8 + 3, "sw6_4", },
-		{ 8 + 4, "NTSC/nPAL", },
-	};
-
-	struct device	*child;
-	int		status;
-	int		i;
-
-	/* GPIO-ish stuff */
-	dm355evm_msp_gpio.parent = &client->dev;
-	status = gpiochip_add_data(&dm355evm_msp_gpio, NULL);
-	if (status < 0)
-		return status;
-
-	/* LED output */
-	if (msp_has_leds()) {
-		gpiod_add_lookup_table(&evm_leds_gpio_table);
-		/* NOTE:  these are the only fully programmable LEDs
-		 * on the board, since GPIO-61/ds22 (and many signals
-		 * going to DC7) must be used for AEMIF address lines
-		 * unless the top 1 GB of NAND is unused...
-		 */
-		child = add_child(client, "leds-gpio",
-				&evm_led_data, sizeof(evm_led_data),
-				false, 0);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-	}
-
-	/* configuration inputs */
-	for (i = 0; i < ARRAY_SIZE(config_inputs); i++) {
-		int gpio = dm355evm_msp_gpio.base + config_inputs[i].offset;
-
-		gpio_request_one(gpio, GPIOF_IN, config_inputs[i].label);
-
-		/* make it easy for userspace to see these */
-		gpio_export(gpio, false);
-	}
-
-	/* MMC/SD inputs -- right after the last config input */
-	if (dev_get_platdata(&client->dev)) {
-		void (*mmcsd_setup)(unsigned) = dev_get_platdata(&client->dev);
-
-		mmcsd_setup(dm355evm_msp_gpio.base + 8 + 5);
-	}
-
-	/* RTC is a 32 bit counter, no alarm */
-	if (msp_has_rtc()) {
-		child = add_child(client, "rtc-dm355evm",
-				NULL, 0, false, 0);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-	}
-
-	/* input from buttons and IR remote (uses the IRQ) */
-	if (msp_has_keyboard()) {
-		child = add_child(client, "dm355evm_keys",
-				NULL, 0, true, client->irq);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-	}
-
-	return 0;
-}
-
-/*----------------------------------------------------------------------*/
-
-static void dm355evm_command(unsigned command)
-{
-	int status;
-
-	status = dm355evm_msp_write(command, DM355EVM_MSP_COMMAND);
-	if (status < 0)
-		dev_err(&msp430->dev, "command %d failure %d\n",
-				command, status);
-}
-
-static void dm355evm_power_off(void)
-{
-	dm355evm_command(MSP_COMMAND_POWEROFF);
-}
-
-static void dm355evm_msp_remove(struct i2c_client *client)
-{
-	pm_power_off = NULL;
-	msp430 = NULL;
-}
-
-static int
-dm355evm_msp_probe(struct i2c_client *client, const struct i2c_device_id *id)
-{
-	int		status;
-	const char	*video = msp_has_tvp() ? "TVP5146" : "imager";
-
-	if (msp430)
-		return -EBUSY;
-	msp430 = client;
-
-	/* display revision status; doubles as sanity check */
-	status = dm355evm_msp_read(DM355EVM_MSP_FIRMREV);
-	if (status < 0)
-		goto fail;
-	dev_info(&client->dev, "firmware v.%02X, %s as video-in\n",
-			status, video);
-
-	/* mux video input:  either tvp5146 or some external imager */
-	status = dm355evm_msp_write(msp_has_tvp() ? 0 : MSP_VIDEO_IMAGER,
-			DM355EVM_MSP_VIDEO_IN);
-	if (status < 0)
-		dev_warn(&client->dev, "error %d muxing %s as video-in\n",
-			status, video);
-
-	/* init LED cache, and turn off the LEDs */
-	msp_led_cache = 0xff;
-	dm355evm_msp_write(msp_led_cache, DM355EVM_MSP_LED);
-
-	/* export capabilities we support */
-	status = add_children(client);
-	if (status < 0)
-		goto fail;
-
-	/* PM hookup */
-	pm_power_off = dm355evm_power_off;
-
-	return 0;
-
-fail:
-	/* FIXME remove children ... */
-	dm355evm_msp_remove(client);
-	return status;
-}
-
-static const struct i2c_device_id dm355evm_msp_ids[] = {
-	{ "dm355evm_msp", 0 },
-	{ /* end of list */ },
-};
-MODULE_DEVICE_TABLE(i2c, dm355evm_msp_ids);
-
-static struct i2c_driver dm355evm_msp_driver = {
-	.driver.name	= "dm355evm_msp",
-	.id_table	= dm355evm_msp_ids,
-	.probe		= dm355evm_msp_probe,
-	.remove		= dm355evm_msp_remove,
-};
-
-static int __init dm355evm_msp_init(void)
-{
-	return i2c_add_driver(&dm355evm_msp_driver);
-}
-subsys_initcall(dm355evm_msp_init);
-
-static void __exit dm355evm_msp_exit(void)
-{
-	i2c_del_driver(&dm355evm_msp_driver);
-}
-module_exit(dm355evm_msp_exit);
-
-MODULE_DESCRIPTION("Interface to MSP430 firmware on DM355EVM");
-MODULE_LICENSE("GPL");
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index bb63edb507da..35298c651730 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -540,12 +540,6 @@ config RTC_DRV_BQ32K
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-bq32k.
 
-config RTC_DRV_DM355EVM
-	tristate "TI DaVinci DM355 EVM RTC"
-	depends on MFD_DM355EVM_MSP
-	help
-	  Supports the RTC firmware in the MSP430 on the DM355 EVM.
-
 config RTC_DRV_TWL92330
 	bool "TI TWL92330/Menelaus"
 	depends on MENELAUS
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index aab22bc63432..c2d474985919 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -46,7 +46,6 @@ obj-$(CONFIG_RTC_DRV_DA9055)	+= rtc-da9055.o
 obj-$(CONFIG_RTC_DRV_DA9063)	+= rtc-da9063.o
 obj-$(CONFIG_RTC_DRV_DAVINCI)	+= rtc-davinci.o
 obj-$(CONFIG_RTC_DRV_DIGICOLOR)	+= rtc-digicolor.o
-obj-$(CONFIG_RTC_DRV_DM355EVM)	+= rtc-dm355evm.o
 obj-$(CONFIG_RTC_DRV_DS1216)	+= rtc-ds1216.o
 obj-$(CONFIG_RTC_DRV_DS1286)	+= rtc-ds1286.o
 obj-$(CONFIG_RTC_DRV_DS1302)	+= rtc-ds1302.o
diff --git a/drivers/rtc/rtc-dm355evm.c b/drivers/rtc/rtc-dm355evm.c
deleted file mode 100644
index 94fb16ac3e0f..000000000000
--- a/drivers/rtc/rtc-dm355evm.c
+++ /dev/null
@@ -1,151 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * rtc-dm355evm.c - access battery-backed counter in MSP430 firmware
- *
- * Copyright (c) 2008 by David Brownell
- */
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/rtc.h>
-#include <linux/platform_device.h>
-
-#include <linux/mfd/dm355evm_msp.h>
-#include <linux/module.h>
-
-
-/*
- * The MSP430 firmware on the DM355 EVM uses a watch crystal to feed
- * a 1 Hz counter.  When a backup battery is supplied, that makes a
- * reasonable RTC for applications where alarms and non-NTP drift
- * compensation aren't important.
- *
- * The only real glitch is the inability to read or write all four
- * counter bytes atomically:  the count may increment in the middle
- * of an operation, causing trouble when the LSB rolls over.
- *
- * This driver was tested with firmware revision A4.
- */
-union evm_time {
-	u8	bytes[4];
-	u32	value;
-};
-
-static int dm355evm_rtc_read_time(struct device *dev, struct rtc_time *tm)
-{
-	union evm_time	time;
-	int		status;
-	int		tries = 0;
-
-	do {
-		/*
-		 * Read LSB(0) to MSB(3) bytes.  Defend against the counter
-		 * rolling over by re-reading until the value is stable,
-		 * and assuming the four reads take at most a few seconds.
-		 */
-		status = dm355evm_msp_read(DM355EVM_MSP_RTC_0);
-		if (status < 0)
-			return status;
-		if (tries && time.bytes[0] == status)
-			break;
-		time.bytes[0] = status;
-
-		status = dm355evm_msp_read(DM355EVM_MSP_RTC_1);
-		if (status < 0)
-			return status;
-		if (tries && time.bytes[1] == status)
-			break;
-		time.bytes[1] = status;
-
-		status = dm355evm_msp_read(DM355EVM_MSP_RTC_2);
-		if (status < 0)
-			return status;
-		if (tries && time.bytes[2] == status)
-			break;
-		time.bytes[2] = status;
-
-		status = dm355evm_msp_read(DM355EVM_MSP_RTC_3);
-		if (status < 0)
-			return status;
-		if (tries && time.bytes[3] == status)
-			break;
-		time.bytes[3] = status;
-
-	} while (++tries < 5);
-
-	dev_dbg(dev, "read timestamp %08x\n", time.value);
-
-	rtc_time64_to_tm(le32_to_cpu(time.value), tm);
-	return 0;
-}
-
-static int dm355evm_rtc_set_time(struct device *dev, struct rtc_time *tm)
-{
-	union evm_time	time;
-	unsigned long	value;
-	int		status;
-
-	value = rtc_tm_to_time64(tm);
-	time.value = cpu_to_le32(value);
-
-	dev_dbg(dev, "write timestamp %08x\n", time.value);
-
-	/*
-	 * REVISIT handle non-atomic writes ... maybe just retry until
-	 * byte[1] sticks (no rollover)?
-	 */
-	status = dm355evm_msp_write(time.bytes[0], DM355EVM_MSP_RTC_0);
-	if (status < 0)
-		return status;
-
-	status = dm355evm_msp_write(time.bytes[1], DM355EVM_MSP_RTC_1);
-	if (status < 0)
-		return status;
-
-	status = dm355evm_msp_write(time.bytes[2], DM355EVM_MSP_RTC_2);
-	if (status < 0)
-		return status;
-
-	status = dm355evm_msp_write(time.bytes[3], DM355EVM_MSP_RTC_3);
-	if (status < 0)
-		return status;
-
-	return 0;
-}
-
-static const struct rtc_class_ops dm355evm_rtc_ops = {
-	.read_time	= dm355evm_rtc_read_time,
-	.set_time	= dm355evm_rtc_set_time,
-};
-
-/*----------------------------------------------------------------------*/
-
-static int dm355evm_rtc_probe(struct platform_device *pdev)
-{
-	struct rtc_device *rtc;
-
-	rtc = devm_rtc_allocate_device(&pdev->dev);
-	if (IS_ERR(rtc))
-		return PTR_ERR(rtc);
-
-	platform_set_drvdata(pdev, rtc);
-
-	rtc->ops = &dm355evm_rtc_ops;
-	rtc->range_max = U32_MAX;
-
-	return devm_rtc_register_device(rtc);
-}
-
-/*
- * I2C is used to talk to the MSP430, but this platform device is
- * exposed by an MFD driver that manages I2C communications.
- */
-static struct platform_driver rtc_dm355evm_driver = {
-	.probe		= dm355evm_rtc_probe,
-	.driver		= {
-		.name	= "rtc-dm355evm",
-	},
-};
-
-module_platform_driver(rtc_dm355evm_driver);
-
-MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/dm355evm_msp.h b/include/linux/mfd/dm355evm_msp.h
deleted file mode 100644
index 372470350fab..000000000000
--- a/include/linux/mfd/dm355evm_msp.h
+++ /dev/null
@@ -1,79 +0,0 @@
-/*
- * dm355evm_msp.h - support MSP430 microcontroller on DM355EVM board
- */
-#ifndef __LINUX_I2C_DM355EVM_MSP
-#define __LINUX_I2C_DM355EVM_MSP
-
-/*
- * Written against Spectrum's writeup for the A4 firmware revision,
- * and tweaked to match source and rev D2 schematics by removing CPLD
- * and NOR flash hooks (which were last appropriate in rev B boards).
- *
- * Note that the firmware supports a flavor of write posting ... to be
- * sure a write completes, issue another read or write.
- */
-
-/* utilities to access "registers" emulated by msp430 firmware */
-extern int dm355evm_msp_write(u8 value, u8 reg);
-extern int dm355evm_msp_read(u8 reg);
-
-
-/* command/control registers */
-#define DM355EVM_MSP_COMMAND		0x00
-#	define MSP_COMMAND_NULL		0
-#	define MSP_COMMAND_RESET_COLD	1
-#	define MSP_COMMAND_RESET_WARM	2
-#	define MSP_COMMAND_RESET_WARM_I	3
-#	define MSP_COMMAND_POWEROFF	4
-#	define MSP_COMMAND_IR_REINIT	5
-#define DM355EVM_MSP_STATUS		0x01
-#	define MSP_STATUS_BAD_OFFSET	BIT(0)
-#	define MSP_STATUS_BAD_COMMAND	BIT(1)
-#	define MSP_STATUS_POWER_ERROR	BIT(2)
-#	define MSP_STATUS_RXBUF_OVERRUN	BIT(3)
-#define DM355EVM_MSP_RESET		0x02	/* 0 bits == in reset */
-#	define MSP_RESET_DC5		BIT(0)
-#	define MSP_RESET_TVP5154	BIT(2)
-#	define MSP_RESET_IMAGER		BIT(3)
-#	define MSP_RESET_ETHERNET	BIT(4)
-#	define MSP_RESET_SYS		BIT(5)
-#	define MSP_RESET_AIC33		BIT(7)
-
-/* GPIO registers ... bit patterns mostly match the source MSP ports */
-#define DM355EVM_MSP_LED		0x03	/* active low (MSP P4) */
-#define DM355EVM_MSP_SWITCH1		0x04	/* (MSP P5, masked) */
-#	define MSP_SWITCH1_SW6_1	BIT(0)
-#	define MSP_SWITCH1_SW6_2	BIT(1)
-#	define MSP_SWITCH1_SW6_3	BIT(2)
-#	define MSP_SWITCH1_SW6_4	BIT(3)
-#	define MSP_SWITCH1_J1		BIT(4)	/* NTSC/PAL */
-#	define MSP_SWITCH1_MSP_INT	BIT(5)	/* active low */
-#define DM355EVM_MSP_SWITCH2		0x05	/* (MSP P6, masked) */
-#	define MSP_SWITCH2_SW10		BIT(3)
-#	define MSP_SWITCH2_SW11		BIT(4)
-#	define MSP_SWITCH2_SW12		BIT(5)
-#	define MSP_SWITCH2_SW13		BIT(6)
-#	define MSP_SWITCH2_SW14		BIT(7)
-#define DM355EVM_MSP_SDMMC		0x06	/* (MSP P2, masked) */
-#	define MSP_SDMMC_0_WP		BIT(1)
-#	define MSP_SDMMC_0_CD		BIT(2)	/* active low */
-#	define MSP_SDMMC_1_WP		BIT(3)
-#	define MSP_SDMMC_1_CD		BIT(4)	/* active low */
-#define DM355EVM_MSP_FIRMREV		0x07	/* not a GPIO (out of order) */
-#define DM355EVM_MSP_VIDEO_IN		0x08	/* (MSP P3, masked) */
-#	define MSP_VIDEO_IMAGER		BIT(7)	/* low == tvp5146 */
-
-/* power supply registers are currently omitted */
-
-/* RTC registers */
-#define DM355EVM_MSP_RTC_0		0x12	/* LSB */
-#define DM355EVM_MSP_RTC_1		0x13
-#define DM355EVM_MSP_RTC_2		0x14
-#define DM355EVM_MSP_RTC_3		0x15	/* MSB */
-
-/* input event queue registers; code == ((HIGH << 8) | LOW) */
-#define DM355EVM_MSP_INPUT_COUNT	0x16	/* decrement by reading LOW */
-#define DM355EVM_MSP_INPUT_HIGH		0x17
-#define DM355EVM_MSP_INPUT_LOW		0x18
-
-#endif /* __LINUX_I2C_DM355EVM_MSP */
-- 
2.29.2

