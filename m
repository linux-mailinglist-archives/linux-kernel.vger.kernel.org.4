Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6522A6E935E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 13:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjDTLuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 07:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjDTLum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 07:50:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262D710D3;
        Thu, 20 Apr 2023 04:50:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B438E6489D;
        Thu, 20 Apr 2023 11:50:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1721C433D2;
        Thu, 20 Apr 2023 11:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681991440;
        bh=jVQbttOtOBOEyBdp51qV3M7dU0i+DPTpQxC6Xg5TuYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BOYelbomoFYm1nJ3CijNPZx9lLegcBoNLdj3Omz9JaYuhJckS1fb2RatnIcSjG3xo
         DUH6T4hTbmus/DPAviSNOHqE9ihF/XcwQ2UyLPLcSj+SG7KnLDSia8z5wD4wMu2mSl
         uwE9bjGUkhJ3I2NnCF+jI8oOTRfusv7kFbvUNVDy5vZRZVg023KycpFoHaj9vwxrJc
         qA+WGUmSK0AshZ9OYbVReK4egDSFz8x66okIBPhroQRJD/oivtxoKRJqErC+H2G7wo
         nuLGK1yEOsL3ZYK3uaDGlRLIzHpk4aLG4voL31EgW8mrw77gZ3q510tlqRKZi7uqh5
         nWH+qxJr7XD4A==
Date:   Thu, 20 Apr 2023 12:50:35 +0100
From:   Lee Jones <lee@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v5] leds: max597x: Add support for max597x
Message-ID: <20230420115035.GE970483@google.com>
References: <20230417094035.998965-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230417094035.998965-1-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2023, Naresh Solanki wrote:

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
> 
>             leds {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 led@0 {
>                     reg = <0>;
>                     label = "ssd0:green";
>                     default-state = "on";
>                 };
>                 led@1 {
>                     reg = <1>;
>                     label = "ssd1:green";
>                     default-state = "on";
>                 };
>             };
>         };
>     };

Where is the DT binding document for this?

> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ...
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
>  drivers/leds/Kconfig        |  11 ++++
>  drivers/leds/Makefile       |   1 +
>  drivers/leds/leds-max597x.c | 115 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 127 insertions(+)
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
> index 000000000000..edbd43018822
> --- /dev/null
> +++ b/drivers/leds/leds-max597x.c
> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device driver for leds in MAX5970 and MAX5978 IC

"MAX5970 and MAX5978 IC LED support"

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
> +static int max597x_setup_led(struct device *dev, struct regmap *regmap, struct device_node *nc,
> +			     u32 reg)
> +{
> +	struct max597x_led *ddata;
> +	int ret;
> +
> +	ddata = devm_kzalloc(dev, sizeof(struct max597x_led), GFP_KERNEL);
> +	if (!ddata)
> +		return -ENOMEM;
> +
> +	if (of_property_read_string(nc, "label", &ddata->cdev.name))
> +		ddata->cdev.name = nc->name;
> +
> +	ddata->cdev.max_brightness = 1;
> +	ddata->cdev.brightness_set_blocking = max597x_led_set_brightness;
> +	ddata->cdev.default_trigger = "none";
> +	ddata->index = reg;
> +	ddata->regmap = regmap;
> +
> +	ret = devm_led_classdev_register(dev, &ddata->cdev);
> +	if (ret)
> +		dev_err(dev, "Error initializing LED %s", ddata->cdev.name);
> +
> +	return ret;
> +}
> +
> +static int max597x_led_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = dev_of_node(pdev->dev.parent);

My previous question about having its own compatible string was ignored.

> +	struct regmap *regmap;
> +	struct device_node *led_node;
> +	struct device_node *child;
> +	int ret = 0;
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
> +			dev_err(&pdev->dev, "invalid LED (%u >= %d)\n", reg,
> +				MAX597X_NUM_LEDS);
> +			continue;
> +		}
> +
> +		ret = max597x_setup_led(&pdev->dev, regmap, child, reg);
> +		if (ret < 0)
> +			dev_err(&pdev->dev, "Failed to initialize LED %u\n", reg);

You've ignored my previous review.

> +	}
> +
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
