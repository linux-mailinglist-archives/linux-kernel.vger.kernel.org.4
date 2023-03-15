Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDCC6BB89F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 16:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjCOPxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 11:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbjCOPxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 11:53:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0E077E24;
        Wed, 15 Mar 2023 08:52:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8BC3EB81E65;
        Wed, 15 Mar 2023 15:52:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920A0C433EF;
        Wed, 15 Mar 2023 15:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678895567;
        bh=hZ/kfLncWqiBGT+JlvpggoKpZ/fY8C/8zObydqAY8yY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CZXpwwGOPLwCJAS64vcAgq9au0J143+TUpFFijXna2p1Bgj/3E/rkUjCAdh853xGV
         2DHDBqUTfHAQzEPD88pe3HOsNm8U0k388x3rijWhFxx63Y1aqNJ8JdLcx5J7kelX9J
         wmwHZ+Ecsom+o23izpSIJQ/WPaohU0KxS9KAWESNFVVzR0UlQgXDCqcUnoWFVlHYDq
         cbYw7nWd0HwR7SurPInZQ9lSpJlHPoXfVVeMsoDIvUJ9s4yE/PwlYvOtCGzqWEw0AY
         8qiVvL05yIgGjKIpIvSJCgbIfNqJM+tZn1NPezvmeQow6MU40DYEFTjCcOsCYKJICS
         zrxBvVFDYFDkQ==
Date:   Wed, 15 Mar 2023 15:52:41 +0000
From:   Lee Jones <lee@kernel.org>
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     lee.jones@linaro.org, pavel@ucw.cz, robh+dt@kernel.org,
        sven.schwermer@disruptive-technologies.com,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        marijn.suijten@somainline.org, andy.shevchenko@gmail.com,
        jacek.anaszewski@gmail.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 6/6] leds: Add a multicolor LED driver to group
 monochromatic LEDs
Message-ID: <20230315155241.GA9667@google.com>
References: <20230102081021.138648-1-jjhiblot@traphandler.com>
 <20230102081021.138648-7-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230102081021.138648-7-jjhiblot@traphandler.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Jan 2023, Jean-Jacques Hiblot wrote:

> By allowing to group multiple monochrome LED into multicolor LEDs,

Nit: s/LED/LEDs/

> all involved LEDs can be controlled in-sync. This enables using effects
> using triggers, etc.

Too many "using"s.  Please reword.

> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> ---
>  drivers/leds/rgb/Kconfig                 |  10 ++
>  drivers/leds/rgb/Makefile                |   1 +
>  drivers/leds/rgb/leds-group-multicolor.c | 166 +++++++++++++++++++++++
>  3 files changed, 177 insertions(+)
>  create mode 100644 drivers/leds/rgb/leds-group-multicolor.c
>
> diff --git a/drivers/leds/rgb/Kconfig b/drivers/leds/rgb/Kconfig
> index 204cf470beae..1a87f53faa8a 100644
> --- a/drivers/leds/rgb/Kconfig
> +++ b/drivers/leds/rgb/Kconfig
> @@ -2,6 +2,16 @@
>
>  if LEDS_CLASS_MULTICOLOR
>
> +config LEDS_GRP_MULTICOLOR

Shortening "GROUP" saves nothing here and hurts readability.

Please expand it.

> +	tristate "Multi-color LED grouping support"

Is it "multi-color group" or "group multi-color"?

Please be consistent throughout the whole driver.

I suggest "LEDs group multi-color" throughout.

> +	depends on COMPILE_TEST || OF

These usually appear the other way around.

> +	help
> +	  This option enables support for monochrome LEDs that are
> +	  grouped into multicolor LEDs.

Useful because ...

> +	  To compile this driver as a module, choose M here: the module
> +	  will be called leds-grp-multicolor.
> +
>  config LEDS_PWM_MULTICOLOR
>  	tristate "PWM driven multi-color LED Support"
>  	depends on PWM
> diff --git a/drivers/leds/rgb/Makefile b/drivers/leds/rgb/Makefile
> index 0675bc0f6e18..4de087ad79bc 100644
> --- a/drivers/leds/rgb/Makefile
> +++ b/drivers/leds/rgb/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
>
> +obj-$(CONFIG_LEDS_GRP_MULTICOLOR)	+= leds-group-multicolor.o
>  obj-$(CONFIG_LEDS_PWM_MULTICOLOR)	+= leds-pwm-multicolor.o
>  obj-$(CONFIG_LEDS_QCOM_LPG)		+= leds-qcom-lpg.o
> diff --git a/drivers/leds/rgb/leds-group-multicolor.c b/drivers/leds/rgb/leds-group-multicolor.c
> new file mode 100644
> index 000000000000..1c99bedf8979
> --- /dev/null
> +++ b/drivers/leds/rgb/leds-group-multicolor.c
> @@ -0,0 +1,166 @@
> +// SPDX-License-Identifier: GPL-2.0-only

Why "only"?

> +/*
> + * multi-color LED built with monochromatic LED devices

Please expand a little.

> + * Copyright 2022 Jean-Jacques Hiblot <jjhiblot@traphandler.com>

Please update.

> + */
> +
> +#include <linux/err.h>
> +#include <linux/leds.h>
> +#include <linux/led-class-multicolor.h>
> +#include <linux/math.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +
> +struct led_mcg_priv {

Open out "mcg" everywhere.

Readability / maintainability is a high priority.

> +	struct led_classdev_mc mc_cdev;
> +	struct led_classdev **monochromatics;

If this is an array, better to be explicit.

*monochromatics[];

> +};
> +
> +static int led_mcg_set(struct led_classdev *cdev,
> +			  enum led_brightness brightness)
> +{
> +	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(cdev);
> +	struct led_mcg_priv *priv = container_of(mc_cdev, struct led_mcg_priv, mc_cdev);
> +	const unsigned int mc_max_brightness = mc_cdev->led_cdev.max_brightness;
> +	int i;
> +
> +	for (i = 0; i < mc_cdev->num_colors; i++) {
> +		struct led_classdev *mono = priv->monochromatics[i];
> +		const unsigned int mono_max = mono->max_brightness;

You lose the meaning of the variable here.

"mono_max" max what?

> +		unsigned int rel_intensity = mc_cdev->subled_info[i].intensity;
> +		int b;

'b' is a terrible name for a variable.

> +		/*
> +		 * Scale the brightness according to relative intensity of the
> +		 * color AND the max brightness of the monochromatic LED.
> +		 */
> +		b = DIV_ROUND_CLOSEST(brightness * rel_intensity * mono_max,
> +			mc_max_brightness * mc_max_brightness);
> +
> +		led_set_brightness(mono, b);
> +	}
> +
> +	return 0;
> +}
> +
> +static void restore_sysfs_access(void *data)
> +{
> +	struct led_classdev *led_cdev = data;
> +
> +	mutex_lock(&led_cdev->led_access);
> +	led_sysfs_enable(led_cdev);
> +	mutex_unlock(&led_cdev->led_access);
> +}
> +
> +static int led_mcg_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct led_init_data init_data = {};
> +	struct led_classdev *cdev;
> +	struct mc_subled *subled;
> +	struct led_mcg_priv *priv;
> +	unsigned int max_brightness;
> +	int i, count, ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	count = 0;
> +	max_brightness = 0;

Initialise these during definition.

> +	for (;;) {
> +		struct led_classdev *led_cdev;
> +
> +		led_cdev = devm_of_led_get_optional(dev, count);
> +		if (IS_ERR(led_cdev))

Doesn't devm_of_led_get_optional() return NULL on failure?

> +			return dev_err_probe(dev, PTR_ERR(led_cdev),
> +					     "Unable to get led #%d", count);
> +		/* Reached the end of the list ?*/

Besides the incorrect formatting, that '?' isn't filling me with
confidence.

> +		if (!led_cdev)
> +			break;
> +
> +		priv->monochromatics = devm_krealloc_array(dev, priv->monochromatics,
> +					count + 1, sizeof(*priv->monochromatics),
> +					GFP_KERNEL);
> +		if (!priv->monochromatics)
> +			return -ENOMEM;
> +
> +		priv->monochromatics[count] = led_cdev;
> +
> +		max_brightness = max(max_brightness, led_cdev->max_brightness);
> +		count++;
> +	}
> +
> +	subled = devm_kcalloc(dev, count, sizeof(*subled), GFP_KERNEL);
> +	if (!subled)
> +		return -ENOMEM;
> +	priv->mc_cdev.subled_info = subled;
> +
> +	for (i = 0; i < count; i++) {
> +		struct led_classdev *led_cdev = priv->monochromatics[i];
> +
> +		subled[i].color_index = led_cdev->color;

'\n'

> +		/* configure the LED intensity to its maximum */

Use correct grammar in comments please.

Start with an uppercase char.

> +		subled[i].intensity = max_brightness;
> +	}
> +
> +	/* init the multicolor's LED class device */

As above and please be fully forthcoming in comments: "Initialise".

> +	cdev = &priv->mc_cdev.led_cdev;
> +	cdev->flags = LED_CORE_SUSPENDRESUME;
> +	cdev->brightness_set_blocking = led_mcg_set;
> +	cdev->max_brightness = max_brightness;
> +	cdev->color = LED_COLOR_ID_MULTI;
> +	priv->mc_cdev.num_colors = count;
> +
> +	init_data.fwnode = dev_fwnode(dev);
> +	ret = devm_led_classdev_multicolor_register_ext(dev, &priv->mc_cdev,
> +							&init_data);

Use the full 100-char limit everywhere please.

> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +			"failed to register multicolor led for %s.\n",

"LED"

> +			cdev->name);
> +
> +	ret = led_mcg_set(cdev, cdev->brightness);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to set led value for %s.",
> +				     cdev->name);
> +
> +	for (i = 0; i < count; i++) {
> +		struct led_classdev *led_cdev = priv->monochromatics[i];
> +
> +		/* Make the sysfs of the monochromatic LED read-only */
> +		mutex_lock(&led_cdev->led_access);
> +		led_sysfs_disable(led_cdev);
> +		mutex_unlock(&led_cdev->led_access);
> +
> +		/* Restore sysfs access when the multicolor LED is released */
> +		devm_add_action_or_reset(dev, restore_sysfs_access, led_cdev);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id of_led_mcg_match[] = {
> +	{ .compatible = "leds-group-multicolor" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, of_led_mcg_match);
> +
> +static struct platform_driver led_mcg_driver = {
> +	.probe		= led_mcg_probe,
> +	.driver		= {
> +		.name	= "leds_group_multicolor",
> +		.of_match_table = of_led_mcg_match,
> +	}
> +};
> +module_platform_driver(led_mcg_driver);
> +
> +MODULE_AUTHOR("Jean-Jacques Hiblot <jjhiblot@traphandler.com>");
> +MODULE_DESCRIPTION("multi-color LED group driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:leds-group-multicolor");
> --
> 2.25.1
>

--
Lee Jones [李琼斯]
