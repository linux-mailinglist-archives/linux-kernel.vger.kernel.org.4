Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE4664587A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 12:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiLGLEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 06:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiLGLDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 06:03:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E00629366;
        Wed,  7 Dec 2022 03:02:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0674E610A4;
        Wed,  7 Dec 2022 11:02:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057FDC433C1;
        Wed,  7 Dec 2022 11:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670410968;
        bh=nrd//QuJh2tVBpg4w7u10MJm1628BI2rFvLr1dVdsRY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NNCKqWgATNep8Hp2ouH6GB0jRY+GGvXZalXyzAYOIqLx3y3Lu+RdonKERZUPqHm8I
         FB4c5uKzSjdrgHe37bpK8E6mLvES3kDYtFcj65abTRMSQLe6Re1sV8IteYzSv1p9De
         n5CdWFP4mnmMPtoYflAWzU849F+fg5coiAfUuH0vusJA6dAX7dpkv1CSraXV0lFtXJ
         GGr2yYLNIv7oDPXuRRu7d296Js67PSEmyyiejG1FQvnCnkbF3TQD6B4QxxR/ebAPbg
         UpJo+hl4u3yBTssWXZB41q8YNVszbhhxLI3MJ4wCxvTWizrZUIjGjIOKrQ0etuNpJs
         q3qWg+I+MNqLw==
Date:   Wed, 7 Dec 2022 11:02:41 +0000
From:   Lee Jones <lee@kernel.org>
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-leds@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] leds: add driver for SPI driven WorldSemi WS2812B
 RGB LEDs
Message-ID: <Y5By0YeGVlS5TlO3@google.com>
References: <20221207040904.582585-1-gch981213@gmail.com>
 <20221207040904.582585-4-gch981213@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221207040904.582585-4-gch981213@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Dec 2022, Chuanhong Guo wrote:

> This patch adds support for driving a chain of WS2812B LED chips
> using SPI bus.
> 
> WorldSemi WS2812B is a individually addressable LED chip that
> can be chained together and controlled individually using a
> single wire. The chip recognize a long pulse as a bit of 1 and
> a short pulse as a bit of 0. Host sends a continuous stream
> of 24-bits color values, each LED chip takes the first 3 byte
> it receives as its color value and passes the leftover bytes to
> the next LED on the chain.
> 
> This driver simulates this protocol using SPI bus by sending
> a long pulse as 3'b110 and a short pulse as 3'b100. The SPI
> frequency needs to be 2.105MHz~2.85MHz for the timing to be
> correct and the controller needs to transfer all the bytes
> continuously.
> 
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> ---
> Changes since v1:
> rename the driver to drop -spi suffix
> add support for default-brightness
> use fwnode apis for properties
> 
> Changes since v2:
> drop default-brightness and default-intensity
> 
>  drivers/leds/rgb/Kconfig        |  11 ++
>  drivers/leds/rgb/Makefile       |   1 +
>  drivers/leds/rgb/leds-ws2812b.c | 219 ++++++++++++++++++++++++++++++++
>  3 files changed, 231 insertions(+)
>  create mode 100644 drivers/leds/rgb/leds-ws2812b.c
> 
> diff --git a/drivers/leds/rgb/Kconfig b/drivers/leds/rgb/Kconfig
> index 204cf470beae..5c2081852f01 100644
> --- a/drivers/leds/rgb/Kconfig
> +++ b/drivers/leds/rgb/Kconfig
> @@ -26,4 +26,15 @@ config LEDS_QCOM_LPG
>  
>  	  If compiled as a module, the module will be named leds-qcom-lpg.
>  
> +config LEDS_WS2812B
> +	tristate "SPI driven WS2812B RGB LED support"
> +	depends on OF
> +	depends on SPI
> +	help
> +	  This option enables support for driving daisy-chained WS2812B RGB
> +	  LED chips using SPI bus. This driver simulates the single-wire
> +	  protocol by sending bits over the SPI MOSI pin. For this to work,
> +	  the SPI frequency should be 2.105MHz~2.85MHz and the controller
> +	  needs to transfer all the bytes continuously.
> +
>  endif # LEDS_CLASS_MULTICOLOR
> diff --git a/drivers/leds/rgb/Makefile b/drivers/leds/rgb/Makefile
> index 0675bc0f6e18..a6f855eaeb14 100644
> --- a/drivers/leds/rgb/Makefile
> +++ b/drivers/leds/rgb/Makefile
> @@ -2,3 +2,4 @@
>  
>  obj-$(CONFIG_LEDS_PWM_MULTICOLOR)	+= leds-pwm-multicolor.o
>  obj-$(CONFIG_LEDS_QCOM_LPG)		+= leds-qcom-lpg.o
> +obj-$(CONFIG_LEDS_WS2812B)		+= leds-ws2812b.o
> diff --git a/drivers/leds/rgb/leds-ws2812b.c b/drivers/leds/rgb/leds-ws2812b.c
> new file mode 100644
> index 000000000000..68c80beb304c
> --- /dev/null
> +++ b/drivers/leds/rgb/leds-ws2812b.c
> @@ -0,0 +1,219 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * WorldSemi WS2812B individually-addressable LED driver using SPI
> + *
> + * Copyright 2022 Chuanhong Guo <gch981213@gmail.com>
> + *
> + * This driver simulates WS2812B protocol using SPI MOSI pin. A one pulse
> + * is transferred as 3'b110 and a zero pulse is 3'b100. For this driver to
> + * work properly, the SPI frequency should be 2.105MHz~2.85MHz and it needs
> + * to transfer all the bytes continuously.
> + */
> +
> +#include <linux/led-class-multicolor.h>
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/property.h>
> +#include <linux/spi/spi.h>
> +#include <linux/mutex.h>
> +
> +#define WS2812B_BYTES_PER_COLOR 3
> +#define WS2812B_NUM_COLORS 3
> +#define WS2812B_RESET_LEN 18
> +
> +struct ws2812b_led {
> +	struct led_classdev_mc mc_cdev;
> +	struct mc_subled subled[WS2812B_NUM_COLORS];
> +	struct ws2812b_priv *priv;
> +	int reg;

Looks like you're leaking the Device Tree nomenclature into the
driver.  IIUC, this is not a reg(ister) value at all, but the LED
indices.  How does the datasheet describe / differentiate them?

> +};
> +
> +struct ws2812b_priv {
> +	struct led_classdev ldev;
> +	struct spi_device *spi;
> +	struct mutex mutex;
> +	int num_leds;
> +	size_t data_len;
> +	u8 *data_buf;
> +	struct ws2812b_led leds[];
> +};
> +
> +static void ws2812b_set_byte(u8 *p, u8 val)
> +{
> +	/*
> +	 * Every bit of data is represented using 3 bits: 3'b100 for
> +	 * 0 and 3'b110 for 1.
> +	 * 1 byte of data takes up 3 bytes in a SPI transfer. The higher
> +	 * 3 bits, middle 2 bits and lower 3 bits are represented
> +	 * with the 1st, 2nd and 3rd byte in the SPI transfer.
> +	 * Here's the lookup table for them.

Sometimes a little ASCII representation can help people visualise the
data stream / layout.

> +	 */
> +	const u8 h3b[] = { 0x92, 0x93, 0x9a, 0x9b, 0xd2, 0xd3, 0xda, 0xdb };
> +	const u8 m2b[] = { 0x49, 0x4d, 0x69, 0x6d };
> +	const u8 l3b[] = { 0x24, 0x26, 0x34, 0x36, 0xa4, 0xa6, 0xb4, 0xb6 };

It's taken me a couple of minutes to parse this, which leads me to
believe it requires more explanation.  The blurb you've written so
far is good, please keep going.  What do the values in the lookup
table represent?  I see that brightness is passed in (should val be
called brightness too?).  Is the returned data the register values to
set that brightness, or something else?

Please also consider adding these comments to further the clarity:

> +	p[0] = h3b[val >> 5];            /* 0-7 */
> +	p[1] = m2b[(val >> 3) & 0x3];    /* 0-3 */
> +	p[2] = l3b[val & 0x7];           /* 0-7 */
> +}
> +
> +static int ws2812b_set(struct led_classdev *cdev,
> +		       enum led_brightness brightness)
> +{
> +	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(cdev);
> +	struct ws2812b_led *led =
> +		container_of(mc_cdev, struct ws2812b_led, mc_cdev);
> +	struct ws2812b_priv *priv = led->priv;
> +	u8 *buf = priv->data_buf + WS2812B_RESET_LEN +
> +		  led->reg * WS2812B_NUM_COLORS * WS2812B_BYTES_PER_COLOR;

Please add some bracketing.  This also goes for the other places you
have complex BODMAS type arithmetic where ordering may cause issues.

Actually, I'm very comfortable with all of this, mostly unparsable (at
least quickly) pointer arithmetic happening in this driver.  We have
some very readable / maintainable ways of referencing registers /
offsets that does not involve register address hopping.  Would you
mind revisiting this please?  Have you considered Regmap for instance?

> +	int ret = 0;

No need to pre-initialise.

> +	int i;
> +
> +	led_mc_calc_color_components(mc_cdev, brightness);
> +
> +	mutex_lock(&priv->mutex);
> +	for (i = 0; i < WS2812B_NUM_COLORS; i++)
> +		ws2812b_set_byte(buf + i * WS2812B_BYTES_PER_COLOR,
> +				 led->subled[i].brightness);
> +	ret = spi_write(priv->spi, priv->data_buf, priv->data_len);
> +	mutex_unlock(&priv->mutex);
> +
> +	return ret;
> +}
> +
> +static int ws2812b_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	int ret = 0, cur_led = 0;

No need to pre-initialise.

> +	struct ws2812b_priv *priv;
> +	struct fwnode_handle *led_node;
> +	int num_leds, i, cnt;
> +
> +	num_leds = device_get_child_node_count(dev);
> +
> +	priv = devm_kzalloc(dev, struct_size(priv, leds, num_leds), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +	priv->data_len =
> +		num_leds * WS2812B_BYTES_PER_COLOR * WS2812B_NUM_COLORS +
> +		WS2812B_RESET_LEN;
> +	priv->data_buf = kzalloc(priv->data_len, GFP_KERNEL);
> +	if (!priv->data_buf)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < num_leds * WS2812B_NUM_COLORS; i++)
> +		ws2812b_set_byte(priv->data_buf + WS2812B_RESET_LEN +
> +					 i * WS2812B_BYTES_PER_COLOR,
> +				 0);

At which point do you usually line-wrap?  This one looks out of place
when compared to the devm_kzalloc() above for instance.  Generally, so
long as checkpatch.pl is happy, we're happy.  So let's stick with
line-wrapping at 100-chars for now.  This should aid readability in a
number of places here.

> +	mutex_init(&priv->mutex);
> +	priv->num_leds = num_leds;
> +	priv->spi = spi;
> +
> +	device_for_each_child_node(dev, led_node) {
> +		u32 reg = -1;
> +		struct led_init_data init_data = {
> +			.fwnode = led_node,
> +		};
> +		/* WS2812B LEDs usually come with GRB color */
> +		u32 color_idx[WS2812B_NUM_COLORS] = {
> +			LED_COLOR_ID_GREEN,
> +			LED_COLOR_ID_RED,
> +			LED_COLOR_ID_BLUE,
> +		};
> +
> +		ret = fwnode_property_read_u32(led_node, "reg", &reg);
> +		if (ret) {
> +			dev_err(dev, "failed to get reg of the %dth led.",

"Failed to obtain numerical LED index for %s"

> +				cur_led);

I would drop the whole cur_led concept and simply use the 'reg' value.

For this print, you can use the node name for identification instead.

> +			goto ERR_UNREG_LEDS;
> +		}
> +		if (reg >= num_leds) {
> +			dev_err(dev, "reg of the %dth led is too big.",

"Numerical LED index greater than the maximum allowable"

> +				cur_led);
> +			ret = -EINVAL;
> +			goto ERR_UNREG_LEDS;
> +		}
> +
> +		cnt = fwnode_property_count_u32(led_node, "color-index");
> +		if (cnt > 0 && cnt <= WS2812B_NUM_COLORS)
> +			fwnode_property_read_u32_array(led_node, "color-index",
> +						       color_idx, (size_t)cnt);

In the DT example, you have 4 LEDs, correct?

Why does the 0th one have a different colour indexes?

> +		priv->leds[cur_led].mc_cdev.subled_info =
> +			priv->leds[cur_led].subled;
> +		priv->leds[cur_led].mc_cdev.num_colors = WS2812B_NUM_COLORS;
> +		priv->leds[cur_led].mc_cdev.led_cdev.max_brightness = 255;
> +		priv->leds[cur_led].mc_cdev.led_cdev.brightness_set_blocking =
> +			ws2812b_set;
> +
> +		for (i = 0; i < WS2812B_NUM_COLORS; i++) {
> +			priv->leds[cur_led].subled[i].color_index =
> +				color_idx[i];
> +			priv->leds[cur_led].subled[i].intensity = 255;
> +		}
> +
> +		priv->leds[cur_led].priv = priv;

You're saving priv in priv.  What is this used for?

There must be a way around this.

In fact, doesn't the spi_set_drvdata() below already save priv to
cdev->dev->driver_data?  If you move to devm_*() you may have to
rename this to dev_set_drvdata() to the APIs are symmetrical, but it's
better than this incestuous solution.

> +		priv->leds[cur_led].reg = reg;
> +
> +		ret = led_classdev_multicolor_register_ext(
> +			dev, &priv->leds[cur_led].mc_cdev, &init_data);
> +		if (ret) {
> +			dev_err(dev, "registration of led@%d failed.", reg);

"Failed to register LED %d"

> +			goto ERR_UNREG_LEDS;
> +		}
> +		cur_led++;
> +	}
> +
> +	spi_set_drvdata(spi, priv);
> +
> +	return 0;
> +ERR_UNREG_LEDS:
> +	for (; cur_led >= 0; cur_led--)
> +		led_classdev_multicolor_unregister(
> +			&priv->leds[cur_led].mc_cdev);
> +	mutex_destroy(&priv->mutex);
> +	kfree(priv->data_buf);
> +	return ret;
> +}
> +
> +static void ws2812b_remove(struct spi_device *spi)
> +{
> +	struct ws2812b_priv *priv = spi_get_drvdata(spi);
> +	int cur_led;
> +
> +	for (cur_led = priv->num_leds - 1; cur_led >= 0; cur_led--)
> +		led_classdev_multicolor_unregister(
> +			&priv->leds[cur_led].mc_cdev);
> +	kfree(priv->data_buf);

If you use devm_* for led_classdev_multicolor_unregister() and
kzalloc(), you can omit .remove() entirely.  I see that you do use
them for some things, but not others.  Was this merely overlooked or
is there a good reason for this that I missed?

> +	mutex_destroy(&priv->mutex);
> +}
> +
> +static const struct spi_device_id ws2812b_spi_ids[] = {
> +	{ "ws2812b" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(spi, ws2812b_spi_ids);
> +
> +static const struct of_device_id ws2812b_dt_ids[] = {
> +	{ .compatible = "worldsemi,ws2812b" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, ws2812b_dt_ids);
> +
> +static struct spi_driver ws2812b_driver = {
> +	.probe		= ws2812b_probe,
> +	.remove		= ws2812b_remove,
> +	.id_table	= ws2812b_spi_ids,
> +	.driver = {
> +		.name		= KBUILD_MODNAME,
> +		.of_match_table	= ws2812b_dt_ids,
> +	},
> +};
> +
> +module_spi_driver(ws2812b_driver);
> +
> +MODULE_AUTHOR("Chuanhong Guo <gch981213@gmail.com>");
> +MODULE_DESCRIPTION("WS2812B LED driver using SPI");
> +MODULE_LICENSE("GPL");

-- 
Lee Jones [李琼斯]
