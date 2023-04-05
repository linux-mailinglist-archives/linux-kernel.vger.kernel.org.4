Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1956D812C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238811AbjDEPLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238780AbjDEPL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:11:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D7D6EA5;
        Wed,  5 Apr 2023 08:09:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6AE163E91;
        Wed,  5 Apr 2023 15:07:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06945C4339C;
        Wed,  5 Apr 2023 15:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680707231;
        bh=1AurvVwHlViuXGXwTa8b8BjeawfPMFB6eS5bRjGeI4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ulaXInmvt2FT+uvuFrk4WnXLkhP4GXvtNsP5s0BBeIxeFEX5QaXWargm3ep4zjI5g
         CRDNopuZwl5Tjod5yHruf+4k5wXQQBJ8w/oaRGiVdGVWqe7l48KSabHBf5DNnFCKpG
         /ysY0E6wV1fGdjpyDEUO5SJVIMkFokw7RaEsgqNu8rYIqo5X21oW6P1AAl/ojQ4x6c
         SfAmk683/9WDrD/ldlmCwpmuPhe+kSQcz0f683A2eZoxKahnSeRuebCK73KLMMZTVl
         zr5voeta6kVtPyHUR2UKcYjjxgvKt/u+7xQ1kZTT2GQgG5qTzJRIqNFVHRoD/YzTxZ
         u/TcswRkqu3KA==
Date:   Wed, 5 Apr 2023 16:07:06 +0100
From:   Lee Jones <lee@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v3 2/2] leds: max597x: Add support for max597x
Message-ID: <20230405150706.GM8371@google.com>
References: <20230328094416.3851801-1-Naresh.Solanki@9elements.com>
 <20230328094416.3851801-2-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230328094416.3851801-2-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2023, Naresh Solanki wrote:

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
>                     label = "led0";
>                     default-state = "on";
>                 };
>                 led@1 {
>                     reg = <1>;
>                     label = "led1";
>                     default-state = "on";
>                 };
>             };
>         };
>     };
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ...
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
>  drivers/leds/leds-max597x.c | 112 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 124 insertions(+)
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
> index 000000000000..83e4dfb617fb
> --- /dev/null
> +++ b/drivers/leds/leds-max597x.c
> @@ -0,0 +1,112 @@
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
> +#define ldev_to_maxled(c)       container_of(c, struct max597x_led, led)
> +
> +struct max597x_led {
> +	struct regmap *regmap;
> +	struct led_classdev led;
> +	unsigned int index;
> +};
> +
> +static int max597x_led_set_brightness(struct led_classdev *cdev,
> +				      enum led_brightness brightness)
> +{
> +	struct max597x_led *led = ldev_to_maxled(cdev);
> +	int ret, val = 0;

Why preinitialise?

> +	if (!led || !led->regmap)
> +		return -ENODEV;

Can !led actually happen?

> +	val = !brightness ? BIT(led->index) : 0;

Perhaps a comment?

> +	ret = regmap_update_bits(led->regmap, MAX5970_REG_LED_FLASH, BIT(led->index), val);
> +	if (ret < 0)
> +		dev_err(cdev->dev, "failed to set brightness %d\n", ret);

'\n'

> +	return ret;
> +}
> +
> +static int max597x_setup_led(struct device *dev, struct regmap *regmap, struct device_node *nc,
> +			     u32 reg)
> +{
> +	struct max597x_led *led;
> +	int ret;
> +
> +	led = devm_kzalloc(dev, sizeof(struct max597x_led),
> +			   GFP_KERNEL);

Consistently break at 100-chars please.

You have lines wayyyy longer than this elsewhere.

> +	if (!led)

'led' is confusing.  Either this or the member 'led' should be changed.

Perhaps ddata here and cdev for the member?

> +		return -ENOMEM;
> +
> +	if (of_property_read_string(nc, "label", &led->led.name))
> +		led->led.name = nc->name;
> +
> +	led->led.max_brightness = 1;
> +	led->led.brightness_set_blocking = max597x_led_set_brightness;
> +	led->led.default_trigger = "none";
> +	led->index = reg;
> +	led->regmap = regmap;
> +	ret = devm_led_classdev_register(dev, &led->led);
> +	if (ret)
> +		dev_err(dev, "Error in initializing led %s", led->led.name);

Drop the "in" and s/led/LED/

> +
> +	return ret;
> +}
> +
> +static int max597x_led_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = dev_of_node(pdev->dev.parent);

Why not have your own compatible string?

> +	struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);

These "big" API calls are usually done outside of the allocation block.

Please move it to just above the check for !regmap.

> +	struct device_node *led_node;
> +	struct device_node *child;
> +	int ret = 0;

Is it okay for an LED driver to not to register any LEDs?

Perhaps -ENODEV?

> +	if (!regmap)
> +		return -EPROBE_DEFER;
> +
> +	led_node = of_get_child_by_name(np, "leds");
> +	if (!led_node)
> +		return -ENODEV;

Ah, that's better.  So set ret to -ENODEV and use it here.

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

I think you (or I) are missing the point of the previous reviews.  It's
not okay to error out and continue executing.  Either this is okay (you
can warn and carry on) or it's not (return an error).  Your first
submission suggested that this was an error.  In which case you do need
to return.  I think Pavel was suggesting that you should unwind
(de-register) before retuning, rather than leaving things in an odd
half-registered state.  Not that you should blindly carry on as if the
issue never occurred.

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

Remove this line.
> +module_platform_driver(max597x_led_driver);
> +
> +MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");
> +MODULE_DESCRIPTION("MAX5970_hot-swap controller driver");

Odd.  I thought this was a LED driver?

> +MODULE_LICENSE("GPL");
> --
> 2.39.1
>

--
Lee Jones [李琼斯]
