Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B44604B6D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbiJSPaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbiJSP3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:29:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE38E106E16
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:21:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5310D6184B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 15:21:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FACC433D7;
        Wed, 19 Oct 2022 15:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666192901;
        bh=eR60voGgjZ0JfRrxHEMJQ06aOT1Y9tisHlHTWeTdtWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cosxhlVJ3e1PjbvYh25SF7dLBjNOmA5czQCsC0BlfYfBczyi/5/yjSCnok+ax33+b
         7LVcIvgDR98FWQzWi4Agdkb6YUKfSmwB+4YhGTcuU97zPzMxpozbK7HQY/z4p2OyFa
         e+AE0sPHrQF+b3USOTv9GYc6IzQ9B6ftlwiwOIBQrLQcBZs0CoamLxf6WJ/adZgJqw
         S77x+yd+BcPEKASdZiZkRvoDto8/mqspBKl7NYzmI8e1hLCm7BYvKUqOhs82IGkjvB
         C05c2nls5DBNU+6C4vXDYlWP+S+x9bXBa4ZfZULyrpyPMzsiqyOgoTVQ+X7iCtXUUj
         3j6XeRNcCWsLg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH 17/17] mfd: remove htc-i2cpld driver
Date:   Wed, 19 Oct 2022 17:03:39 +0200
Message-Id: <20221019150410.3851944-17-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221019150410.3851944-1-arnd@kernel.org>
References: <20221019144119.3848027-1-arnd@kernel.org>
 <20221019150410.3851944-1-arnd@kernel.org>
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

The HTC Herald machine was removed, so this driver is no
longer used anywhere.

Cc: Cory Maccarrone <darkstar6262@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mfd/Kconfig      |   9 -
 drivers/mfd/Makefile     |   1 -
 drivers/mfd/htc-i2cpld.c | 627 ---------------------------------------
 include/linux/htcpld.h   |  23 --
 4 files changed, 660 deletions(-)
 delete mode 100644 drivers/mfd/htc-i2cpld.c
 delete mode 100644 include/linux/htcpld.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index c87aab27455f..11c3bd0bd669 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -547,15 +547,6 @@ config HTC_PASIC3
 	  HTC Magician devices, respectively. Actual functionality is
 	  handled by the leds-pasic3 and ds1wm drivers.
 
-config HTC_I2CPLD
-	bool "HTC I2C PLD chip support"
-	depends on I2C=y && GPIOLIB
-	help
-	  If you say yes here you get support for the supposed CPLD
-	  found on omap850 HTC devices like the HTC Wizard and HTC Herald.
-	  This device provides input and output GPIOs through an I2C
-	  interface to one or more sub-chips.
-
 config MFD_INTEL_QUARK_I2C_GPIO
 	tristate "Intel Quark MFD I2C GPIO"
 	depends on PCI
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 7ed3ef4a698c..d74bf111f88e 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -19,7 +19,6 @@ obj-$(CONFIG_MFD_EXYNOS_LPASS)	+= exynos-lpass.o
 obj-$(CONFIG_MFD_GATEWORKS_GSC)	+= gateworks-gsc.o
 
 obj-$(CONFIG_HTC_PASIC3)	+= htc-pasic3.o
-obj-$(CONFIG_HTC_I2CPLD)	+= htc-i2cpld.o
 
 obj-$(CONFIG_MFD_TI_LP873X)	+= lp873x.o
 obj-$(CONFIG_MFD_TI_LP87565)	+= lp87565.o
diff --git a/drivers/mfd/htc-i2cpld.c b/drivers/mfd/htc-i2cpld.c
deleted file mode 100644
index b45b1346ab54..000000000000
--- a/drivers/mfd/htc-i2cpld.c
+++ /dev/null
@@ -1,627 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- *  htc-i2cpld.c
- *  Chip driver for an unknown CPLD chip found on omap850 HTC devices like
- *  the HTC Wizard and HTC Herald.
- *  The cpld is located on the i2c bus and acts as an input/output GPIO
- *  extender.
- *
- *  Copyright (C) 2009 Cory Maccarrone <darkstar6262@gmail.com>
- *
- *  Based on work done in the linwizard project
- *  Copyright (C) 2008-2009 Angelo Arrifano <miknix@gmail.com>
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <linux/i2c.h>
-#include <linux/irq.h>
-#include <linux/spinlock.h>
-#include <linux/htcpld.h>
-#include <linux/gpio/driver.h>
-#include <linux/gpio/machine.h>
-#include <linux/gpio/consumer.h>
-#include <linux/slab.h>
-
-struct htcpld_chip {
-	spinlock_t              lock;
-
-	/* chip info */
-	u8                      reset;
-	u8                      addr;
-	struct device           *dev;
-	struct i2c_client	*client;
-
-	/* Output details */
-	u8                      cache_out;
-	struct gpio_chip        chip_out;
-
-	/* Input details */
-	u8                      cache_in;
-	struct gpio_chip        chip_in;
-
-	u16                     irqs_enabled;
-	uint                    irq_start;
-	int                     nirqs;
-
-	unsigned int		flow_type;
-	/*
-	 * Work structure to allow for setting values outside of any
-	 * possible interrupt context
-	 */
-	struct work_struct set_val_work;
-};
-
-struct htcpld_data {
-	/* irq info */
-	u16                irqs_enabled;
-	uint               irq_start;
-	int                nirqs;
-	uint               chained_irq;
-	struct gpio_desc   *int_reset_gpio_hi;
-	struct gpio_desc   *int_reset_gpio_lo;
-
-	/* htcpld info */
-	struct htcpld_chip *chip;
-	unsigned int       nchips;
-};
-
-/* There does not appear to be a way to proactively mask interrupts
- * on the htcpld chip itself.  So, we simply ignore interrupts that
- * aren't desired. */
-static void htcpld_mask(struct irq_data *data)
-{
-	struct htcpld_chip *chip = irq_data_get_irq_chip_data(data);
-	chip->irqs_enabled &= ~(1 << (data->irq - chip->irq_start));
-	pr_debug("HTCPLD mask %d %04x\n", data->irq, chip->irqs_enabled);
-}
-static void htcpld_unmask(struct irq_data *data)
-{
-	struct htcpld_chip *chip = irq_data_get_irq_chip_data(data);
-	chip->irqs_enabled |= 1 << (data->irq - chip->irq_start);
-	pr_debug("HTCPLD unmask %d %04x\n", data->irq, chip->irqs_enabled);
-}
-
-static int htcpld_set_type(struct irq_data *data, unsigned int flags)
-{
-	struct htcpld_chip *chip = irq_data_get_irq_chip_data(data);
-
-	if (flags & ~IRQ_TYPE_SENSE_MASK)
-		return -EINVAL;
-
-	/* We only allow edge triggering */
-	if (flags & (IRQ_TYPE_LEVEL_LOW|IRQ_TYPE_LEVEL_HIGH))
-		return -EINVAL;
-
-	chip->flow_type = flags;
-	return 0;
-}
-
-static struct irq_chip htcpld_muxed_chip = {
-	.name         = "htcpld",
-	.irq_mask     = htcpld_mask,
-	.irq_unmask   = htcpld_unmask,
-	.irq_set_type = htcpld_set_type,
-};
-
-/* To properly dispatch IRQ events, we need to read from the
- * chip.  This is an I2C action that could possibly sleep
- * (which is bad in interrupt context) -- so we use a threaded
- * interrupt handler to get around that.
- */
-static irqreturn_t htcpld_handler(int irq, void *dev)
-{
-	struct htcpld_data *htcpld = dev;
-	unsigned int i;
-	unsigned long flags;
-	int irqpin;
-
-	if (!htcpld) {
-		pr_debug("htcpld is null in ISR\n");
-		return IRQ_HANDLED;
-	}
-
-	/*
-	 * For each chip, do a read of the chip and trigger any interrupts
-	 * desired.  The interrupts will be triggered from LSB to MSB (i.e.
-	 * bit 0 first, then bit 1, etc.)
-	 *
-	 * For chips that have no interrupt range specified, just skip 'em.
-	 */
-	for (i = 0; i < htcpld->nchips; i++) {
-		struct htcpld_chip *chip = &htcpld->chip[i];
-		struct i2c_client *client;
-		int val;
-		unsigned long uval, old_val;
-
-		if (!chip) {
-			pr_debug("chip %d is null in ISR\n", i);
-			continue;
-		}
-
-		if (chip->nirqs == 0)
-			continue;
-
-		client = chip->client;
-		if (!client) {
-			pr_debug("client %d is null in ISR\n", i);
-			continue;
-		}
-
-		/* Scan the chip */
-		val = i2c_smbus_read_byte_data(client, chip->cache_out);
-		if (val < 0) {
-			/* Throw a warning and skip this chip */
-			dev_warn(chip->dev, "Unable to read from chip: %d\n",
-				 val);
-			continue;
-		}
-
-		uval = (unsigned long)val;
-
-		spin_lock_irqsave(&chip->lock, flags);
-
-		/* Save away the old value so we can compare it */
-		old_val = chip->cache_in;
-
-		/* Write the new value */
-		chip->cache_in = uval;
-
-		spin_unlock_irqrestore(&chip->lock, flags);
-
-		/*
-		 * For each bit in the data (starting at bit 0), trigger
-		 * associated interrupts.
-		 */
-		for (irqpin = 0; irqpin < chip->nirqs; irqpin++) {
-			unsigned oldb, newb, type = chip->flow_type;
-
-			irq = chip->irq_start + irqpin;
-
-			/* Run the IRQ handler, but only if the bit value
-			 * changed, and the proper flags are set */
-			oldb = (old_val >> irqpin) & 1;
-			newb = (uval >> irqpin) & 1;
-
-			if ((!oldb && newb && (type & IRQ_TYPE_EDGE_RISING)) ||
-			    (oldb && !newb && (type & IRQ_TYPE_EDGE_FALLING))) {
-				pr_debug("fire IRQ %d\n", irqpin);
-				generic_handle_irq(irq);
-			}
-		}
-	}
-
-	/*
-	 * In order to continue receiving interrupts, the int_reset_gpio must
-	 * be asserted.
-	 */
-	if (htcpld->int_reset_gpio_hi)
-		gpiod_set_value(htcpld->int_reset_gpio_hi, 1);
-	if (htcpld->int_reset_gpio_lo)
-		gpiod_set_value(htcpld->int_reset_gpio_lo, 0);
-
-	return IRQ_HANDLED;
-}
-
-/*
- * The GPIO set routines can be called from interrupt context, especially if,
- * for example they're attached to the led-gpio framework and a trigger is
- * enabled.  As such, we declared work above in the htcpld_chip structure,
- * and that work is scheduled in the set routine.  The kernel can then run
- * the I2C functions, which will sleep, in process context.
- */
-static void htcpld_chip_set(struct gpio_chip *chip, unsigned offset, int val)
-{
-	struct i2c_client *client;
-	struct htcpld_chip *chip_data = gpiochip_get_data(chip);
-	unsigned long flags;
-
-	client = chip_data->client;
-	if (!client)
-		return;
-
-	spin_lock_irqsave(&chip_data->lock, flags);
-	if (val)
-		chip_data->cache_out |= (1 << offset);
-	else
-		chip_data->cache_out &= ~(1 << offset);
-	spin_unlock_irqrestore(&chip_data->lock, flags);
-
-	schedule_work(&(chip_data->set_val_work));
-}
-
-static void htcpld_chip_set_ni(struct work_struct *work)
-{
-	struct htcpld_chip *chip_data;
-	struct i2c_client *client;
-
-	chip_data = container_of(work, struct htcpld_chip, set_val_work);
-	client = chip_data->client;
-	i2c_smbus_read_byte_data(client, chip_data->cache_out);
-}
-
-static int htcpld_chip_get(struct gpio_chip *chip, unsigned offset)
-{
-	struct htcpld_chip *chip_data = gpiochip_get_data(chip);
-	u8 cache;
-
-	if (!strncmp(chip->label, "htcpld-out", 10)) {
-		cache = chip_data->cache_out;
-	} else if (!strncmp(chip->label, "htcpld-in", 9)) {
-		cache = chip_data->cache_in;
-	} else
-		return -EINVAL;
-
-	return (cache >> offset) & 1;
-}
-
-static int htcpld_direction_output(struct gpio_chip *chip,
-					unsigned offset, int value)
-{
-	htcpld_chip_set(chip, offset, value);
-	return 0;
-}
-
-static int htcpld_direction_input(struct gpio_chip *chip,
-					unsigned offset)
-{
-	/*
-	 * No-op: this function can only be called on the input chip.
-	 * We do however make sure the offset is within range.
-	 */
-	return (offset < chip->ngpio) ? 0 : -EINVAL;
-}
-
-static int htcpld_chip_to_irq(struct gpio_chip *chip, unsigned offset)
-{
-	struct htcpld_chip *chip_data = gpiochip_get_data(chip);
-
-	if (offset < chip_data->nirqs)
-		return chip_data->irq_start + offset;
-	else
-		return -EINVAL;
-}
-
-static void htcpld_chip_reset(struct i2c_client *client)
-{
-	struct htcpld_chip *chip_data = i2c_get_clientdata(client);
-	if (!chip_data)
-		return;
-
-	i2c_smbus_read_byte_data(
-		client, (chip_data->cache_out = chip_data->reset));
-}
-
-static int htcpld_setup_chip_irq(
-		struct platform_device *pdev,
-		int chip_index)
-{
-	struct htcpld_data *htcpld;
-	struct htcpld_chip *chip;
-	unsigned int irq, irq_end;
-
-	/* Get the platform and driver data */
-	htcpld = platform_get_drvdata(pdev);
-	chip = &htcpld->chip[chip_index];
-
-	/* Setup irq handlers */
-	irq_end = chip->irq_start + chip->nirqs;
-	for (irq = chip->irq_start; irq < irq_end; irq++) {
-		irq_set_chip_and_handler(irq, &htcpld_muxed_chip,
-					 handle_simple_irq);
-		irq_set_chip_data(irq, chip);
-		irq_clear_status_flags(irq, IRQ_NOREQUEST | IRQ_NOPROBE);
-	}
-
-	return 0;
-}
-
-static int htcpld_register_chip_i2c(
-		struct platform_device *pdev,
-		int chip_index)
-{
-	struct htcpld_data *htcpld;
-	struct device *dev = &pdev->dev;
-	struct htcpld_core_platform_data *pdata;
-	struct htcpld_chip *chip;
-	struct htcpld_chip_platform_data *plat_chip_data;
-	struct i2c_adapter *adapter;
-	struct i2c_client *client;
-	struct i2c_board_info info;
-
-	/* Get the platform and driver data */
-	pdata = dev_get_platdata(dev);
-	htcpld = platform_get_drvdata(pdev);
-	chip = &htcpld->chip[chip_index];
-	plat_chip_data = &pdata->chip[chip_index];
-
-	adapter = i2c_get_adapter(pdata->i2c_adapter_id);
-	if (!adapter) {
-		/* Eek, no such I2C adapter!  Bail out. */
-		dev_warn(dev, "Chip at i2c address 0x%x: Invalid i2c adapter %d\n",
-			 plat_chip_data->addr, pdata->i2c_adapter_id);
-		return -ENODEV;
-	}
-
-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_READ_BYTE_DATA)) {
-		dev_warn(dev, "i2c adapter %d non-functional\n",
-			 pdata->i2c_adapter_id);
-		i2c_put_adapter(adapter);
-		return -EINVAL;
-	}
-
-	memset(&info, 0, sizeof(struct i2c_board_info));
-	info.addr = plat_chip_data->addr;
-	strscpy(info.type, "htcpld-chip", I2C_NAME_SIZE);
-	info.platform_data = chip;
-
-	/* Add the I2C device.  This calls the probe() function. */
-	client = i2c_new_client_device(adapter, &info);
-	if (IS_ERR(client)) {
-		/* I2C device registration failed, contineu with the next */
-		dev_warn(dev, "Unable to add I2C device for 0x%x\n",
-			 plat_chip_data->addr);
-		i2c_put_adapter(adapter);
-		return PTR_ERR(client);
-	}
-
-	i2c_set_clientdata(client, chip);
-	snprintf(client->name, I2C_NAME_SIZE, "Chip_0x%x", client->addr);
-	chip->client = client;
-
-	/* Reset the chip */
-	htcpld_chip_reset(client);
-	chip->cache_in = i2c_smbus_read_byte_data(client, chip->cache_out);
-
-	return 0;
-}
-
-static void htcpld_unregister_chip_i2c(
-		struct platform_device *pdev,
-		int chip_index)
-{
-	struct htcpld_data *htcpld;
-	struct htcpld_chip *chip;
-
-	/* Get the platform and driver data */
-	htcpld = platform_get_drvdata(pdev);
-	chip = &htcpld->chip[chip_index];
-
-	i2c_unregister_device(chip->client);
-}
-
-static int htcpld_register_chip_gpio(
-		struct platform_device *pdev,
-		int chip_index)
-{
-	struct htcpld_data *htcpld;
-	struct device *dev = &pdev->dev;
-	struct htcpld_core_platform_data *pdata;
-	struct htcpld_chip *chip;
-	struct htcpld_chip_platform_data *plat_chip_data;
-	struct gpio_chip *gpio_chip;
-	int ret = 0;
-
-	/* Get the platform and driver data */
-	pdata = dev_get_platdata(dev);
-	htcpld = platform_get_drvdata(pdev);
-	chip = &htcpld->chip[chip_index];
-	plat_chip_data = &pdata->chip[chip_index];
-
-	/* Setup the GPIO chips */
-	gpio_chip = &(chip->chip_out);
-	gpio_chip->label           = "htcpld-out";
-	gpio_chip->parent             = dev;
-	gpio_chip->owner           = THIS_MODULE;
-	gpio_chip->get             = htcpld_chip_get;
-	gpio_chip->set             = htcpld_chip_set;
-	gpio_chip->direction_input = NULL;
-	gpio_chip->direction_output = htcpld_direction_output;
-	gpio_chip->base            = plat_chip_data->gpio_out_base;
-	gpio_chip->ngpio           = plat_chip_data->num_gpios;
-
-	gpio_chip = &(chip->chip_in);
-	gpio_chip->label           = "htcpld-in";
-	gpio_chip->parent             = dev;
-	gpio_chip->owner           = THIS_MODULE;
-	gpio_chip->get             = htcpld_chip_get;
-	gpio_chip->set             = NULL;
-	gpio_chip->direction_input = htcpld_direction_input;
-	gpio_chip->direction_output = NULL;
-	gpio_chip->to_irq          = htcpld_chip_to_irq;
-	gpio_chip->base            = plat_chip_data->gpio_in_base;
-	gpio_chip->ngpio           = plat_chip_data->num_gpios;
-
-	/* Add the GPIO chips */
-	ret = gpiochip_add_data(&(chip->chip_out), chip);
-	if (ret) {
-		dev_warn(dev, "Unable to register output GPIOs for 0x%x: %d\n",
-			 plat_chip_data->addr, ret);
-		return ret;
-	}
-
-	ret = gpiochip_add_data(&(chip->chip_in), chip);
-	if (ret) {
-		dev_warn(dev, "Unable to register input GPIOs for 0x%x: %d\n",
-			 plat_chip_data->addr, ret);
-		gpiochip_remove(&(chip->chip_out));
-		return ret;
-	}
-
-	return 0;
-}
-
-static int htcpld_setup_chips(struct platform_device *pdev)
-{
-	struct htcpld_data *htcpld;
-	struct device *dev = &pdev->dev;
-	struct htcpld_core_platform_data *pdata;
-	int i;
-
-	/* Get the platform and driver data */
-	pdata = dev_get_platdata(dev);
-	htcpld = platform_get_drvdata(pdev);
-
-	/* Setup each chip's output GPIOs */
-	htcpld->nchips = pdata->num_chip;
-	htcpld->chip = devm_kcalloc(dev,
-				    htcpld->nchips,
-				    sizeof(struct htcpld_chip),
-				    GFP_KERNEL);
-	if (!htcpld->chip)
-		return -ENOMEM;
-
-	/* Add the chips as best we can */
-	for (i = 0; i < htcpld->nchips; i++) {
-		int ret;
-
-		/* Setup the HTCPLD chips */
-		htcpld->chip[i].reset = pdata->chip[i].reset;
-		htcpld->chip[i].cache_out = pdata->chip[i].reset;
-		htcpld->chip[i].cache_in = 0;
-		htcpld->chip[i].dev = dev;
-		htcpld->chip[i].irq_start = pdata->chip[i].irq_base;
-		htcpld->chip[i].nirqs = pdata->chip[i].num_irqs;
-
-		INIT_WORK(&(htcpld->chip[i].set_val_work), &htcpld_chip_set_ni);
-		spin_lock_init(&(htcpld->chip[i].lock));
-
-		/* Setup the interrupts for the chip */
-		if (htcpld->chained_irq) {
-			ret = htcpld_setup_chip_irq(pdev, i);
-			if (ret)
-				continue;
-		}
-
-		/* Register the chip with I2C */
-		ret = htcpld_register_chip_i2c(pdev, i);
-		if (ret)
-			continue;
-
-
-		/* Register the chips with the GPIO subsystem */
-		ret = htcpld_register_chip_gpio(pdev, i);
-		if (ret) {
-			/* Unregister the chip from i2c and continue */
-			htcpld_unregister_chip_i2c(pdev, i);
-			continue;
-		}
-
-		dev_info(dev, "Registered chip at 0x%x\n", pdata->chip[i].addr);
-	}
-
-	return 0;
-}
-
-static int htcpld_core_probe(struct platform_device *pdev)
-{
-	struct htcpld_data *htcpld;
-	struct device *dev = &pdev->dev;
-	struct htcpld_core_platform_data *pdata;
-	struct resource *res;
-	int ret = 0;
-
-	if (!dev)
-		return -ENODEV;
-
-	pdata = dev_get_platdata(dev);
-	if (!pdata) {
-		dev_warn(dev, "Platform data not found for htcpld core!\n");
-		return -ENXIO;
-	}
-
-	htcpld = devm_kzalloc(dev, sizeof(struct htcpld_data), GFP_KERNEL);
-	if (!htcpld)
-		return -ENOMEM;
-
-	/* Find chained irq */
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (res) {
-		int flags;
-		htcpld->chained_irq = res->start;
-
-		/* Setup the chained interrupt handler */
-		flags = IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING |
-			IRQF_ONESHOT;
-		ret = request_threaded_irq(htcpld->chained_irq,
-					   NULL, htcpld_handler,
-					   flags, pdev->name, htcpld);
-		if (ret) {
-			dev_warn(dev, "Unable to setup chained irq handler: %d\n", ret);
-			return ret;
-		} else
-			device_init_wakeup(dev, 0);
-	}
-
-	/* Set the driver data */
-	platform_set_drvdata(pdev, htcpld);
-
-	/* Setup the htcpld chips */
-	ret = htcpld_setup_chips(pdev);
-	if (ret)
-		return ret;
-
-	/* Request the GPIO(s) for the int reset and set them up */
-	htcpld->int_reset_gpio_hi = gpiochip_request_own_desc(&htcpld->chip[2].chip_out,
-							      7, "htcpld-core", GPIO_ACTIVE_HIGH,
-							      GPIOD_OUT_HIGH);
-	if (IS_ERR(htcpld->int_reset_gpio_hi)) {
-		/*
-		 * If it failed, that sucks, but we can probably
-		 * continue on without it.
-		 */
-		htcpld->int_reset_gpio_hi = NULL;
-		dev_warn(dev, "Unable to request int_reset_gpio_hi -- interrupts may not work\n");
-	}
-
-	htcpld->int_reset_gpio_lo = gpiochip_request_own_desc(&htcpld->chip[2].chip_out,
-							      0, "htcpld-core", GPIO_ACTIVE_HIGH,
-							      GPIOD_OUT_LOW);
-	if (IS_ERR(htcpld->int_reset_gpio_lo)) {
-		/*
-		 * If it failed, that sucks, but we can probably
-		 * continue on without it.
-		 */
-		htcpld->int_reset_gpio_lo = NULL;
-		dev_warn(dev, "Unable to request int_reset_gpio_lo -- interrupts may not work\n");
-	}
-
-	dev_info(dev, "Initialized successfully\n");
-	return 0;
-}
-
-/* The I2C Driver -- used internally */
-static const struct i2c_device_id htcpld_chip_id[] = {
-	{ "htcpld-chip", 0 },
-	{ }
-};
-
-static struct i2c_driver htcpld_chip_driver = {
-	.driver = {
-		.name	= "htcpld-chip",
-	},
-	.id_table = htcpld_chip_id,
-};
-
-/* The Core Driver */
-static struct platform_driver htcpld_core_driver = {
-	.driver = {
-		.name = "i2c-htcpld",
-	},
-};
-
-static int __init htcpld_core_init(void)
-{
-	int ret;
-
-	/* Register the I2C Chip driver */
-	ret = i2c_add_driver(&htcpld_chip_driver);
-	if (ret)
-		return ret;
-
-	/* Probe for our chips */
-	return platform_driver_probe(&htcpld_core_driver, htcpld_core_probe);
-}
-device_initcall(htcpld_core_init);
diff --git a/include/linux/htcpld.h b/include/linux/htcpld.h
deleted file mode 100644
index 5f8ac9b1d724..000000000000
--- a/include/linux/htcpld.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __LINUX_HTCPLD_H
-#define __LINUX_HTCPLD_H
-
-struct htcpld_chip_platform_data {
-	unsigned int addr;
-	unsigned int reset;
-	unsigned int num_gpios;
-	unsigned int gpio_out_base;
-	unsigned int gpio_in_base;
-	unsigned int irq_base;
-	unsigned int num_irqs;
-};
-
-struct htcpld_core_platform_data {
-	unsigned int                      i2c_adapter_id;
-
-	struct htcpld_chip_platform_data  *chip;
-	unsigned int                      num_chip;
-};
-
-#endif /* __LINUX_HTCPLD_H */
-
-- 
2.29.2

