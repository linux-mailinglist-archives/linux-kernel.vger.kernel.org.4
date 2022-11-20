Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573416315CB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 20:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiKTTQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 14:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKTTQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 14:16:32 -0500
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DE529359;
        Sun, 20 Nov 2022 11:16:29 -0800 (PST)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 16FDC3EE6C;
        Sun, 20 Nov 2022 20:16:24 +0100 (CET)
Date:   Sun, 20 Nov 2022 20:16:22 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Brian Masney <bmasney@redhat.com>
Subject: Re: [PATCH v1 1/1] gpiolib: Unify access to the device properties
Message-ID: <20221120191622.kngdz462bmns7fwe@SoMainline.org>
References: <20221116141728.72491-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116141728.72491-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-16 16:17:28, Andy Shevchenko wrote:
> Some of the functions are using struct fwnode_handle, some struct device
> pointer. In the GPIO library the firmware node of the GPIO device is the
> same as GPIO node of the GPIO chip. Due to this fact we may use former
> to access properties everywhere in the code.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I presume this is a more complete version of [1], as this also happens
to address the crash on MSM [1], hence:

Tested-by: Marijn Suijten <marijn.suijten@somainline.org>

Just in case, this seems to depend on [3] or it fails to apply cleanly
because of the `const` change on `fwnode` (consider this irrelevant if
it has already been applied, I'm still on -next-20221115 for this
integration branch).

[1]: https://lore.kernel.org/all/Y3S62i7OzocP5QrT@orome/
[2]: https://lore.kernel.org/linux-arm-msm/20221115110800.35gl3j43lmbxm3jb@SoMainline.org/
[3]: https://lore.kernel.org/linux-gpio/20221031-gpiolib-swnode-v3-0-0282162b0fa4@gmail.com/

- Marijn

> ---
>  drivers/gpio/gpiolib.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 51afdc6ac919..c163b354e727 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -367,12 +367,12 @@ static int gpiochip_set_desc_names(struct gpio_chip *gc)
>  static int devprop_gpiochip_set_names(struct gpio_chip *chip)
>  {
>  	struct gpio_device *gdev = chip->gpiodev;
> -	const struct fwnode_handle *fwnode = dev_fwnode(&gdev->dev);
> +	struct device *dev = &gdev->dev;
>  	const char **names;
>  	int ret, i;
>  	int count;
>  
> -	count = fwnode_property_string_array_count(fwnode, "gpio-line-names");
> +	count = device_property_string_array_count(dev, "gpio-line-names");
>  	if (count < 0)
>  		return 0;
>  
> @@ -385,7 +385,7 @@ static int devprop_gpiochip_set_names(struct gpio_chip *chip)
>  	 * gpiochips.
>  	 */
>  	if (count <= chip->offset) {
> -		dev_warn(&gdev->dev, "gpio-line-names too short (length %d), cannot map names for the gpiochip at offset %u\n",
> +		dev_warn(dev, "gpio-line-names too short (length %d), cannot map names for the gpiochip at offset %u\n",
>  			 count, chip->offset);
>  		return 0;
>  	}
> @@ -394,10 +394,9 @@ static int devprop_gpiochip_set_names(struct gpio_chip *chip)
>  	if (!names)
>  		return -ENOMEM;
>  
> -	ret = fwnode_property_read_string_array(fwnode, "gpio-line-names",
> -						names, count);
> +	ret = device_property_read_string_array(dev, "gpio-line-names", names, count);
>  	if (ret < 0) {
> -		dev_warn(&gdev->dev, "failed to read GPIO line names\n");
> +		dev_warn(dev, "failed to read GPIO line names\n");
>  		kfree(names);
>  		return ret;
>  	}
> @@ -448,10 +447,11 @@ static unsigned long *gpiochip_allocate_mask(struct gpio_chip *gc)
>  
>  static unsigned int gpiochip_count_reserved_ranges(struct gpio_chip *gc)
>  {
> +	struct device *dev = &gc->gpiodev->dev;
>  	int size;
>  
>  	/* Format is "start, count, ..." */
> -	size = fwnode_property_count_u32(gc->fwnode, "gpio-reserved-ranges");
> +	size = device_property_count_u32(dev, "gpio-reserved-ranges");
>  	if (size > 0 && size % 2 == 0)
>  		return size;
>  
> @@ -472,6 +472,7 @@ static int gpiochip_alloc_valid_mask(struct gpio_chip *gc)
>  
>  static int gpiochip_apply_reserved_ranges(struct gpio_chip *gc)
>  {
> +	struct device *dev = &gc->gpiodev->dev;
>  	unsigned int size;
>  	u32 *ranges;
>  	int ret;
> @@ -484,7 +485,7 @@ static int gpiochip_apply_reserved_ranges(struct gpio_chip *gc)
>  	if (!ranges)
>  		return -ENOMEM;
>  
> -	ret = fwnode_property_read_u32_array(gc->fwnode, "gpio-reserved-ranges", ranges, size);
> +	ret = device_property_read_u32_array(dev, "gpio-reserved-ranges", ranges, size);
>  	if (ret) {
>  		kfree(ranges);
>  		return ret;
> 
> base-commit: 40059212f99c31f26c69763e560325e59eac02c6
> -- 
> 2.35.1
> 
