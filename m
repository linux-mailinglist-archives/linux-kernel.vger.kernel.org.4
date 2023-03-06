Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECFE6AD1BB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjCFWhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 17:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjCFWhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:37:34 -0500
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F2772B05
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 14:37:31 -0800 (PST)
Received: from localhost (88-113-24-128.elisa-laajakaista.fi [88.113.24.128])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTP
        id 79ca04d7-bc6f-11ed-a9de-005056bdf889;
        Tue, 07 Mar 2023 00:37:29 +0200 (EET)
From:   andy.shevchenko@gmail.com
Date:   Tue, 7 Mar 2023 00:37:28 +0200
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     andy.shevchenko@gmail.com, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] gpio: mmio: handle "ngpios" properly in bgpio_init()
Message-ID: <ZAZrKPw38ERSbzXg@surfacebook>
References: <20230306211237.14876-1-asmaa@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306211237.14876-1-asmaa@nvidia.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Mar 06, 2023 at 04:12:37PM -0500, Asmaa Mnebhi kirjoitti:
> bgpio_init() uses "sz" argument to populate ngpio, which is not
> accurate. Instead, read the "ngpios" property from the DT and if it
> doesn't exist, use the "sz" argument. With this change, drivers no
> longer need to overwrite the ngpio variable after calling bgpio_init().

Thank you!

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Sorry it took a bit longer for us to settle on this.

> Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
> ---
>  drivers/gpio/gpio-mmio.c |  9 +++++-
>  drivers/gpio/gpiolib.c   | 68 ++++++++++++++++++++++------------------
>  drivers/gpio/gpiolib.h   |  1 +
>  3 files changed, 46 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-mmio.c b/drivers/gpio/gpio-mmio.c
> index d9dff3dc92ae..b52a3dd511ca 100644
> --- a/drivers/gpio/gpio-mmio.c
> +++ b/drivers/gpio/gpio-mmio.c
> @@ -60,6 +60,8 @@ o        `                     ~~~~\___/~~~~    ` controller in FPGA is ,.`
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  
> +#include "gpiolib.h"
> +
>  static void bgpio_write8(void __iomem *reg, unsigned long data)
>  {
>  	writeb(data, reg);
> @@ -614,10 +616,15 @@ int bgpio_init(struct gpio_chip *gc, struct device *dev,
>  	gc->parent = dev;
>  	gc->label = dev_name(dev);
>  	gc->base = -1;
> -	gc->ngpio = gc->bgpio_bits;
>  	gc->request = bgpio_request;
>  	gc->be_bits = !!(flags & BGPIOF_BIG_ENDIAN);
>  
> +	ret = gpiochip_get_ngpios(gc, dev);
> +	if (ret)
> +		gc->ngpio = gc->bgpio_bits;
> +	else
> +		gc->bgpio_bits = round_up(gc->ngpio, 8);
> +
>  	ret = bgpio_setup_io(gc, dat, set, clr, flags);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 939c776b9488..1964ec64e356 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -647,6 +647,40 @@ static void gpiochip_setup_devs(void)
>  	}
>  }
>  
> +int gpiochip_get_ngpios(struct gpio_chip *gc, struct device *dev)
> +{
> +	u32 ngpios = gc->ngpio;
> +	int ret;
> +
> +	if (ngpios == 0) {
> +		ret = device_property_read_u32(dev, "ngpios", &ngpios);
> +		if (ret == -ENODATA)
> +			/*
> +			 * -ENODATA means that there is no property found and
> +			 * we want to issue the error message to the user.
> +			 * Besides that, we want to return different error code
> +			 * to state that supplied value is not valid.
> +			 */
> +			ngpios = 0;
> +		else if (ret)
> +			return ret;
> +
> +		gc->ngpio = ngpios;
> +	}
> +
> +	if (gc->ngpio == 0) {
> +		chip_err(gc, "tried to insert a GPIO chip with zero lines\n");
> +		return -EINVAL;
> +	}
> +
> +	if (gc->ngpio > FASTPATH_NGPIO)
> +		chip_warn(gc, "line cnt %u is greater than fast path cnt %u\n",
> +			gc->ngpio, FASTPATH_NGPIO);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(gpiochip_get_ngpios);
> +
>  int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
>  			       struct lock_class_key *lock_key,
>  			       struct lock_class_key *request_key)
> @@ -655,7 +689,6 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
>  	struct gpio_device *gdev;
>  	unsigned long flags;
>  	unsigned int i;
> -	u32 ngpios = 0;
>  	int base = 0;
>  	int ret = 0;
>  
> @@ -704,36 +737,9 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
>  	else
>  		gdev->owner = THIS_MODULE;
>  
> -	/*
> -	 * Try the device properties if the driver didn't supply the number
> -	 * of GPIO lines.
> -	 */
> -	ngpios = gc->ngpio;
> -	if (ngpios == 0) {
> -		ret = device_property_read_u32(&gdev->dev, "ngpios", &ngpios);
> -		if (ret == -ENODATA)
> -			/*
> -			 * -ENODATA means that there is no property found and
> -			 * we want to issue the error message to the user.
> -			 * Besides that, we want to return different error code
> -			 * to state that supplied value is not valid.
> -			 */
> -			ngpios = 0;
> -		else if (ret)
> -			goto err_free_dev_name;
> -
> -		gc->ngpio = ngpios;
> -	}
> -
> -	if (gc->ngpio == 0) {
> -		chip_err(gc, "tried to insert a GPIO chip with zero lines\n");
> -		ret = -EINVAL;
> +	ret = gpiochip_get_ngpios(gc, &gdev->dev);
> +	if (ret)
>  		goto err_free_dev_name;
> -	}
> -
> -	if (gc->ngpio > FASTPATH_NGPIO)
> -		chip_warn(gc, "line cnt %u is greater than fast path cnt %u\n",
> -			  gc->ngpio, FASTPATH_NGPIO);
>  
>  	gdev->descs = kcalloc(gc->ngpio, sizeof(*gdev->descs), GFP_KERNEL);
>  	if (!gdev->descs) {
> @@ -903,7 +909,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
>  	/* failures here can mean systems won't boot... */
>  	if (ret != -EPROBE_DEFER) {
>  		pr_err("%s: GPIOs %d..%d (%s) failed to register, %d\n", __func__,
> -		       base, base + (int)ngpios - 1,
> +		       base, base + (int)gc->ngpio - 1,
>  		       gc->label ? : "generic", ret);
>  	}
>  	return ret;
> diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
> index b3c2db6eba80..c38cbf1b753b 100644
> --- a/drivers/gpio/gpiolib.h
> +++ b/drivers/gpio/gpiolib.h
> @@ -207,6 +207,7 @@ int gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
>  int gpio_set_debounce_timeout(struct gpio_desc *desc, unsigned int debounce);
>  int gpiod_hog(struct gpio_desc *desc, const char *name,
>  		unsigned long lflags, enum gpiod_flags dflags);
> +int gpiochip_get_ngpios(struct gpio_chip *gc, struct device *dev);
>  
>  /*
>   * Return the GPIO number of the passed descriptor relative to its chip
> -- 
> 2.30.1
> 

-- 
With Best Regards,
Andy Shevchenko


