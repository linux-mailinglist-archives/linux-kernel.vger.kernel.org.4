Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC966EF84D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 18:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbjDZQVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 12:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbjDZQU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 12:20:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3EA7A99;
        Wed, 26 Apr 2023 09:20:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1233763056;
        Wed, 26 Apr 2023 16:20:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63377C433D2;
        Wed, 26 Apr 2023 16:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682526049;
        bh=ueDw44dfBVXk/pPjvnUNET6MEustXuruGTdVY/q5lRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uv0u/x05kqUV8es23xbe0G64y7tm2XpyppbyrhcP0cwUQDOCXiq9ZoUasW6Ob7wg0
         nIQ2QCP24MIOeObN4dt2D0tQl+rWKG2iCzKmHyowLJYMFCKzGMAumFIlewwN9Ve08U
         QulZgEZql+r1n/q+5buizqUVxNoIvwuFOaRNXAvtBMnbs1qCJj7PXkeC1JxKgxlwWz
         enLXvgwwtyGwkDa5duBrYY7IpWvuBHbG7LQS2/eggEeWM9yrJET7HJ/tbeorJRXtY+
         6bkxM+hu8FWDVykDnlLYEDTEdJIKdU7v7HlG0dpGOtsXLED5L7GYDQ2VVJTGsSt4zF
         As2syb5GvwCAw==
Date:   Wed, 26 Apr 2023 17:20:45 +0100
From:   Lee Jones <lee@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v6] leds: max597x: Add support for max597x
Message-ID: <20230426162045.GR50521@google.com>
References: <20230420181042.3553335-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230420181042.3553335-1-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Apr 2023, Naresh Solanki wrote:

> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> max597x is hot swap controller with indicator LED support.
> This driver uses DT property to configure led during boot time &
> also provide the LED control in sysfs.
> 
> DTS example:
>     i2c {
>         #address-cells = <1>;
>         #size-cells = <0>;
>         regulator@3a {
>             compatible = "maxim,max5978";
>             reg = <0x3a>;
>             vss1-supply = <&p3v3>;
> 
>             regulators {
>                 sw0_ref_0: sw0 {
>                     shunt-resistor-micro-ohms = <12000>;
>                 };
>             };
>         };
> 
>         leds {
>             #address-cells = <1>;
>             #size-cells = <0>;
>             led@0 {
>                 reg = <0>;
>                 label = "ssd0:green";
>                 default-state = "on";
>             };
>             led@1 {
>                 reg = <1>;
>                 label = "ssd1:green";
>                 default-state = "on";
>             };
>         };
>     };
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ...
> Change in V6:
> - Improve error handling in case of failure in LED setup
> Changes in V5:
> - Update commit message
> - Fix comments
> - Add necessary new line
> Changes in V4:
> - Remove unwanted preinitialise
> - Remove unneeded line breaks
> - Fix variable name to avoid confusion
> - Update module description to mention LED driver.
> Changes in V3:
> - Remove of_node_put as its handled by for loop
> - Print error if an LED fails to register.
> - Update driver name in Kconfig description
> - Remove unneeded variable assignment
> - Use devm_led_classdev_register to reget led
> Changes in V2:
> - Fix regmap update
> - Remove devm_kfree
> - Remove default-state
> - Add example dts in commit message
> - Fix whitespace in Kconfig
> - Fix comment
> ---
>  drivers/leds/Kconfig        |  11 +++
>  drivers/leds/Makefile       |   1 +
>  drivers/leds/leds-max597x.c | 133 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 145 insertions(+)
>  create mode 100644 drivers/leds/leds-max597x.c
> 
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 9dbce09eabac..60004cb8c257 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -590,6 +590,17 @@ config LEDS_ADP5520
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called leds-adp5520.
>  
> +config LEDS_MAX597X
> +	tristate "LED Support for Maxim 597x"
> +	depends on LEDS_CLASS
> +	depends on MFD_MAX597X
> +	help
> +	  This option enables support for the Maxim MAX5970 & MAX5978 smart
> +	  switch indication LEDs via the I2C bus.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called leds-max597x.
> +
>  config LEDS_MC13783
>  	tristate "LED Support for MC13XXX PMIC"
>  	depends on LEDS_CLASS
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index d30395d11fd8..da1192e40268 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -53,6 +53,7 @@ obj-$(CONFIG_LEDS_LP8501)		+= leds-lp8501.o
>  obj-$(CONFIG_LEDS_LP8788)		+= leds-lp8788.o
>  obj-$(CONFIG_LEDS_LP8860)		+= leds-lp8860.o
>  obj-$(CONFIG_LEDS_LT3593)		+= leds-lt3593.o
> +obj-$(CONFIG_LEDS_MAX597X)		+= leds-max597x.o
>  obj-$(CONFIG_LEDS_MAX77650)		+= leds-max77650.o
>  obj-$(CONFIG_LEDS_MAX8997)		+= leds-max8997.o
>  obj-$(CONFIG_LEDS_MC13783)		+= leds-mc13783.o
> diff --git a/drivers/leds/leds-max597x.c b/drivers/leds/leds-max597x.c
> new file mode 100644
> index 000000000000..8ba710d20bff
> --- /dev/null
> +++ b/drivers/leds/leds-max597x.c
> @@ -0,0 +1,133 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device driver for leds in MAX5970 and MAX5978 IC
> + *
> + * Copyright (c) 2022 9elements GmbH
> + *
> + * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
> + */
> +
> +#include <linux/leds.h>
> +#include <linux/mfd/max597x.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#define ldev_to_maxled(c)       container_of(c, struct max597x_led, cdev)
> +
> +struct max597x_led {
> +	struct device *dev;

This is already in cdev, no?

> +	struct regmap *regmap;
> +	struct led_classdev cdev;
> +	unsigned int index;
> +};
> +
> +static int max597x_led_set_brightness(struct led_classdev *cdev,
> +				      enum led_brightness brightness)
> +{
> +	struct max597x_led *ddata = ldev_to_maxled(cdev);
> +	int ret, val;
> +
> +	if (!ddata->regmap)
> +		return -ENODEV;
> +
> +	/* Set/clear corresponding bit for given led index */
> +	val = !brightness ? BIT(ddata->index) : 0;
> +
> +	ret = regmap_update_bits(ddata->regmap, MAX5970_REG_LED_FLASH, BIT(ddata->index), val);
> +	if (ret < 0)
> +		dev_err(cdev->dev, "failed to set brightness %d", ret);
> +
> +	return ret;
> +}
> +
> +static int max597x_setup_led(struct max597x_led *ddata, struct regmap *regmap,
> +			     struct device_node *nc, u32 reg)
> +{
> +	int ret;
> +
> +	if (of_property_read_string(nc, "label", &ddata->cdev.name))
> +		ddata->cdev.name = nc->name;
> +
> +	ddata->cdev.max_brightness = 1;
> +	ddata->cdev.brightness_set_blocking = max597x_led_set_brightness;
> +	ddata->cdev.default_trigger = "none";
> +
> +	ret = devm_led_classdev_register(ddata->dev, &ddata->cdev);

Pass the pointer to 'dev' as a param instead.

> +	if (ret)
> +		dev_err(ddata->dev, "Error initializing LED %s", ddata->cdev.name);
> +
> +	return ret;
> +}
> +
> +static int max597x_led_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev_of_node(dev->parent);
> +	struct regmap *regmap;
> +	struct device_node *led_node;
> +	struct device_node *child;
> +	struct max597x_led *ddata[MAX597X_NUM_LEDS];
> +	int ret = 0, i = 0;
> +	bool leds_found = false;
> +
> +	regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!regmap)
> +		return -EPROBE_DEFER;
> +
> +	led_node = of_get_child_by_name(np, "leds");
> +	if (!led_node)
> +		return -ENODEV;
> +
> +	for_each_available_child_of_node(led_node, child) {
> +		u32 reg;
> +
> +		if (of_property_read_u32(child, "reg", &reg))
> +			continue;
> +
> +		if (reg >= MAX597X_NUM_LEDS) {
> +			dev_err(dev, "invalid LED (%u >= %d)\n", reg, MAX597X_NUM_LEDS);
> +			continue;
> +		}
> +
> +		ddata[i] = devm_kzalloc(dev, sizeof(struct max597x_led), GFP_KERNEL);
> +		if (!ddata[i]) {
> +			ret = -ENOMEM;
> +			goto exit;
> +		}
> +
> +		ddata[i]->index = reg;
> +		ddata[i]->regmap = regmap;
> +		ddata[i]->dev = dev;
> +
> +		ret = max597x_setup_led(ddata[i], regmap, child, reg);
> +		if (ret < 0) {
> +			dev_err(dev, "Failed to initialize LED %u\n", reg);
> +			goto exit;
> +		}
> +		i++;
> +		leds_found = true;

You don't need both of these.

Swap them out for something like num_leds_found.

> +	}
> +
> +	if (!leds_found)
> +		return -ENODEV;

Initialise ret to -ENODEV when you declare it, then you can drop this.

> +exit:
> +	if (ret < 0)
> +		for (int j = 0; j < i; j++)
> +			devm_led_classdev_unregister(dev, &ddata[j]->cdev);

Place this section below the return, then you can omit the check.

> +	return ret;
> +}
> +
> +static struct platform_driver max597x_led_driver = {
> +	.driver = {
> +		.name = "max597x-led",
> +	},
> +	.probe = max597x_led_probe,
> +};
> +
> +module_platform_driver(max597x_led_driver);
> +MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");
> +MODULE_DESCRIPTION("MAX5970_hot-swap controller LED driver");
> +MODULE_LICENSE("GPL");
> 
> base-commit: 9d8d0d98885abba451d7ffc4885236d14ead3c9a
> -- 
> 2.39.1
> 

-- 
Lee Jones [李琼斯]
