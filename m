Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8D0731A7C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344567AbjFONvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344501AbjFONvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:51:31 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BEA1FDD;
        Thu, 15 Jun 2023 06:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686837090; x=1718373090;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YsZGaAObpjYqNJMe/OLLryZiMIHAEejOVbI/tTESdOw=;
  b=VEGcEzQF2RNKEFguWPvisjEpHVzJyBtI9BVLyh0VwdGcJSrpSJ59+2VG
   rdHrPPBzXHpGIBiAPQI3SPYn24BgRlO/4MSuzPBLQviBR/wiaHCUO1rps
   A/bdmL1NWveN5Q+q2RmYrB33llvU2burDVStXGoj42FRJj7ZKhjPZCmqt
   hwhqS2E7B5p21tvZlg9jbLCI6gOG9kP2N6kX2cKCGmZSbpJGElwv0w/X9
   lNAE9qG956kMowPd8Uz5HovfkJ8XDwXYq5CtWdvp/KuQzwFj942KWYxy4
   GXLGsuxBvUkDZvQuPpbWCQPhlAZQxDgYftS59uYieGw082kFAFMuW1NJW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="361404962"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="361404962"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 06:20:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="802338858"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="802338858"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Jun 2023 06:20:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7E05975A; Thu, 15 Jun 2023 16:20:28 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v3 5/5] gpio: delay: Remove duplicative functionality
Date:   Thu, 15 Jun 2023 16:20:23 +0300
Message-Id: <20230615132023.13801-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230615132023.13801-1-andriy.shevchenko@linux.intel.com>
References: <20230615132023.13801-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that GPIO aggregator supports a delay line, drop the duplicative
functionality, i.e. the entire gpio-delay driver.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/Kconfig      |   9 ---
 drivers/gpio/Makefile     |   1 -
 drivers/gpio/gpio-delay.c | 164 --------------------------------------
 3 files changed, 174 deletions(-)
 delete mode 100644 drivers/gpio/gpio-delay.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 209738ef1446..abaae68c88a4 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1748,15 +1748,6 @@ config GPIO_AGGREGATOR
 	      industrial control context, to be operated from userspace using
 	      the GPIO chardev interface.
 
-config GPIO_DELAY
-	tristate "GPIO delay"
-	depends on OF_GPIO
-	help
-	  Say yes here to enable the GPIO delay, which provides a way to
-	  configure platform specific delays for GPIO ramp-up or ramp-down
-	  delays. This can serve the following purposes:
-	    - Open-drain output using an RC filter
-
 config GPIO_LATCH
 	tristate "GPIO latch driver"
 	help
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 947c9cf9aba8..7843b16f5d59 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -52,7 +52,6 @@ obj-$(CONFIG_GPIO_DA9052)		+= gpio-da9052.o
 obj-$(CONFIG_GPIO_DA9055)		+= gpio-da9055.o
 obj-$(CONFIG_GPIO_DAVINCI)		+= gpio-davinci.o
 obj-$(CONFIG_GPIO_DLN2)			+= gpio-dln2.o
-obj-$(CONFIG_GPIO_DELAY)		+= gpio-delay.o
 obj-$(CONFIG_GPIO_DWAPB)		+= gpio-dwapb.o
 obj-$(CONFIG_GPIO_EIC_SPRD)		+= gpio-eic-sprd.o
 obj-$(CONFIG_GPIO_ELKHARTLAKE)		+= gpio-elkhartlake.o
diff --git a/drivers/gpio/gpio-delay.c b/drivers/gpio/gpio-delay.c
deleted file mode 100644
index b489b561b225..000000000000
--- a/drivers/gpio/gpio-delay.c
+++ /dev/null
@@ -1,164 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright 2022 TQ-Systems GmbH
- * Author: Alexander Stein <linux@ew.tq-group.com>
- */
-
-#include <linux/err.h>
-#include <linux/gpio/consumer.h>
-#include <linux/gpio/driver.h>
-#include <linux/module.h>
-#include <linux/mod_devicetable.h>
-#include <linux/platform_device.h>
-#include <linux/delay.h>
-
-#include "gpiolib.h"
-
-struct gpio_delay_timing {
-	unsigned long ramp_up_delay_us;
-	unsigned long ramp_down_delay_us;
-};
-
-struct gpio_delay_priv {
-	struct gpio_chip gc;
-	struct gpio_descs *input_gpio;
-	struct gpio_delay_timing *delay_timings;
-};
-
-static int gpio_delay_get_direction(struct gpio_chip *gc, unsigned int offset)
-{
-	return GPIO_LINE_DIRECTION_OUT;
-}
-
-static void gpio_delay_set(struct gpio_chip *gc, unsigned int offset, int val)
-{
-	struct gpio_delay_priv *priv = gpiochip_get_data(gc);
-	struct gpio_desc *gpio_desc = priv->input_gpio->desc[offset];
-	const struct gpio_delay_timing *delay_timings;
-	bool ramp_up;
-
-	gpiod_set_value(gpio_desc, val);
-
-	delay_timings = &priv->delay_timings[offset];
-	ramp_up = (!gpiod_is_active_low(gpio_desc) && val) ||
-		  (gpiod_is_active_low(gpio_desc) && !val);
-
-	if (ramp_up && delay_timings->ramp_up_delay_us)
-		udelay(delay_timings->ramp_up_delay_us);
-	if (!ramp_up && delay_timings->ramp_down_delay_us)
-		udelay(delay_timings->ramp_down_delay_us);
-}
-
-static void gpio_delay_set_can_sleep(struct gpio_chip *gc, unsigned int offset, int val)
-{
-	struct gpio_delay_priv *priv = gpiochip_get_data(gc);
-	struct gpio_desc *gpio_desc = priv->input_gpio->desc[offset];
-	const struct gpio_delay_timing *delay_timings;
-	bool ramp_up;
-
-	gpiod_set_value_cansleep(gpio_desc, val);
-
-	delay_timings = &priv->delay_timings[offset];
-	ramp_up = (!gpiod_is_active_low(gpio_desc) && val) ||
-		  (gpiod_is_active_low(gpio_desc) && !val);
-
-	if (ramp_up && delay_timings->ramp_up_delay_us)
-		fsleep(delay_timings->ramp_up_delay_us);
-	if (!ramp_up && delay_timings->ramp_down_delay_us)
-		fsleep(delay_timings->ramp_down_delay_us);
-}
-
-static int gpio_delay_of_xlate(struct gpio_chip *gc,
-			       const struct of_phandle_args *gpiospec,
-			       u32 *flags)
-{
-	struct gpio_delay_priv *priv = gpiochip_get_data(gc);
-	struct gpio_delay_timing *timings;
-	u32 line;
-
-	if (gpiospec->args_count != gc->of_gpio_n_cells)
-		return -EINVAL;
-
-	line = gpiospec->args[0];
-	if (line >= gc->ngpio)
-		return -EINVAL;
-
-	timings = &priv->delay_timings[line];
-	timings->ramp_up_delay_us = gpiospec->args[1];
-	timings->ramp_down_delay_us = gpiospec->args[2];
-
-	return line;
-}
-
-static bool gpio_delay_can_sleep(const struct gpio_delay_priv *priv)
-{
-	int i;
-
-	for (i = 0; i < priv->input_gpio->ndescs; i++)
-		if (gpiod_cansleep(priv->input_gpio->desc[i]))
-			return true;
-
-	return false;
-}
-
-static int gpio_delay_probe(struct platform_device *pdev)
-{
-	struct gpio_delay_priv *priv;
-
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	priv->input_gpio = devm_gpiod_get_array(&pdev->dev, NULL, GPIOD_OUT_LOW);
-	if (IS_ERR(priv->input_gpio))
-		return dev_err_probe(&pdev->dev, PTR_ERR(priv->input_gpio),
-				     "Failed to get input-gpios");
-
-	priv->delay_timings = devm_kcalloc(&pdev->dev,
-					   priv->input_gpio->ndescs,
-					   sizeof(*priv->delay_timings),
-					   GFP_KERNEL);
-	if (!priv->delay_timings)
-		return -ENOMEM;
-
-	if (gpio_delay_can_sleep(priv)) {
-		priv->gc.can_sleep = true;
-		priv->gc.set = gpio_delay_set_can_sleep;
-	} else {
-		priv->gc.can_sleep = false;
-		priv->gc.set = gpio_delay_set;
-	}
-
-	priv->gc.get_direction = gpio_delay_get_direction;
-	priv->gc.of_xlate = gpio_delay_of_xlate;
-	priv->gc.of_gpio_n_cells = 3;
-	priv->gc.ngpio = priv->input_gpio->ndescs;
-	priv->gc.owner = THIS_MODULE;
-	priv->gc.base = -1;
-	priv->gc.parent = &pdev->dev;
-
-	platform_set_drvdata(pdev, priv);
-
-	return devm_gpiochip_add_data(&pdev->dev, &priv->gc, priv);
-}
-
-static const struct of_device_id gpio_delay_ids[] = {
-	{
-		.compatible = "gpio-delay",
-	},
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(of, gpio_delay_ids);
-
-static struct platform_driver gpio_delay_driver = {
-	.driver	= {
-		.name		= "gpio-delay",
-		.of_match_table	= gpio_delay_ids,
-	},
-	.probe	= gpio_delay_probe,
-};
-module_platform_driver(gpio_delay_driver);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Alexander Stein <alexander.stein@ew.tq-group.com>");
-MODULE_DESCRIPTION("GPIO delay driver");
-- 
2.40.0.1.gaa8946217a0b

