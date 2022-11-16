Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B929562B67F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbiKPJ2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbiKPJ1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:27:55 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B0463E1;
        Wed, 16 Nov 2022 01:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668590874; x=1700126874;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aUkzbV52DIbKBJLObQADOQwqxsnvyFPJh49NM76nNpo=;
  b=GXNLh+POuZ/Nmgqx7EYt52VvWq7sJ/SjSyfhUrMClgXYxNN/tCEI3ai2
   bZ1GrDdIlWREG8u7EUXjTPL/zZ94AnP8mbemr3ORnTFiRqeTmluifDHQ9
   z5oQV7zA8t+/E55/E7g7llr+sghC3zlARHTgZCUXrhirlA5uuY3z2wjho
   IwQ5k1S4FCH0rFx8aECijjtJt1ovFLxjUPt5o1r8BtJn6wm0ADQdg50o+
   SgQ0P6hOg/Dd7IEkr87W99+sNwudNCKYlvPoyd/68wsfjfYvvZ6KRbmYT
   AV1QE6c6MHLxMZkYxlckLvP7Qw5N+6vxRBJYHMxVUbJbgvd0t8lk5xHaC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="398784131"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="398784131"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 01:27:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="728299218"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="728299218"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Nov 2022 01:27:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ovEhy-00D3uZ-1C;
        Wed, 16 Nov 2022 11:27:50 +0200
Date:   Wed, 16 Nov 2022 11:27:50 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <treding@nvidia.com>
Subject: Re: [rft, PATCH v3 1/1] gpiolib: Get rid of not used of_node member
Message-ID: <Y3StFigB1t89u6CZ@smile.fi.intel.com>
References: <20221116091859.64725-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116091859.64725-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 11:18:59AM +0200, Andy Shevchenko wrote:
> All new drivers should use fwnode and / or parent to provide the
> necessary information to the GPIO library.
> 
> Cc: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> v3: rebased against latest Linux Next: expected not to fail now
>     (Also keeping in mind Thierry's report, so reworked a bit)
> v2: resent against latest Linux Next: expected not to fail now
>     (Linux Next has no more users of of_node member of gpio_chip)
> v1: to test for now (using CIs and build bots) what is left unconverted
>     (Expected to fail in some configurations!)
> 
> The idea is to send this after v6.2-rc1, so we will have a full cycle
> to test. Currently one patch is in pin control tree prevents us doing
> this during v6.1 cycle.
> 
>  drivers/gpio/gpiolib-acpi.c | 10 ----------
>  drivers/gpio/gpiolib-acpi.h |  4 ----
>  drivers/gpio/gpiolib-of.c   | 24 ++++--------------------
>  drivers/gpio/gpiolib-of.h   |  5 -----
>  drivers/gpio/gpiolib.c      | 11 +++--------
>  include/linux/gpio/driver.h |  7 -------
>  6 files changed, 7 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index bed0380c5136..466622a8fb36 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -1387,16 +1387,6 @@ void acpi_gpiochip_remove(struct gpio_chip *chip)
>  	kfree(acpi_gpio);
>  }
>  
> -void acpi_gpio_dev_init(struct gpio_chip *gc, struct gpio_device *gdev)
> -{
> -	/* Set default fwnode to parent's one if present */
> -	if (gc->parent)
> -		ACPI_COMPANION_SET(&gdev->dev, ACPI_COMPANION(gc->parent));
> -
> -	if (gc->fwnode)
> -		device_set_node(&gdev->dev, gc->fwnode);
> -}
> -
>  static int acpi_gpio_package_count(const union acpi_object *obj)
>  {
>  	const union acpi_object *element = obj->package.elements;
> diff --git a/drivers/gpio/gpiolib-acpi.h b/drivers/gpio/gpiolib-acpi.h
> index 9475f99a9694..5fa315b3c912 100644
> --- a/drivers/gpio/gpiolib-acpi.h
> +++ b/drivers/gpio/gpiolib-acpi.h
> @@ -26,8 +26,6 @@ struct gpio_device;
>  void acpi_gpiochip_add(struct gpio_chip *chip);
>  void acpi_gpiochip_remove(struct gpio_chip *chip);
>  
> -void acpi_gpio_dev_init(struct gpio_chip *gc, struct gpio_device *gdev);
> -
>  void acpi_gpiochip_request_interrupts(struct gpio_chip *chip);
>  void acpi_gpiochip_free_interrupts(struct gpio_chip *chip);
>  
> @@ -42,8 +40,6 @@ int acpi_gpio_count(struct device *dev, const char *con_id);
>  static inline void acpi_gpiochip_add(struct gpio_chip *chip) { }
>  static inline void acpi_gpiochip_remove(struct gpio_chip *chip) { }
>  
> -static inline void acpi_gpio_dev_init(struct gpio_chip *gc, struct gpio_device *gdev) { }
> -
>  static inline void
>  acpi_gpiochip_request_interrupts(struct gpio_chip *chip) { }
>  
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index 4fff7258ee41..00b55dbe0323 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -668,7 +668,7 @@ static struct gpio_desc *of_parse_own_gpio(struct device_node *np,
>  	u32 tmp;
>  	int ret;
>  
> -	chip_np = chip->of_node;
> +	chip_np = to_of_node(chip->fwnode);
>  	if (!chip_np)
>  		return ERR_PTR(-EINVAL);
>  
> @@ -760,7 +760,7 @@ static int of_gpiochip_scan_gpios(struct gpio_chip *chip)
>  	struct device_node *np;
>  	int ret;
>  
> -	for_each_available_child_of_node(chip->of_node, np) {
> +	for_each_available_child_of_node(to_of_node(chip->fwnode), np) {
>  		if (!of_property_read_bool(np, "gpio-hog"))
>  			continue;
>  
> @@ -970,7 +970,7 @@ EXPORT_SYMBOL_GPL(of_mm_gpiochip_remove);
>  #ifdef CONFIG_PINCTRL
>  static int of_gpiochip_add_pin_range(struct gpio_chip *chip)
>  {
> -	struct device_node *np = chip->of_node;
> +	struct device_node *np = to_of_node(chip->fwnode);
>  	struct of_phandle_args pinspec;
>  	struct pinctrl_dev *pctldev;
>  	int index = 0, ret;
> @@ -1063,7 +1063,7 @@ int of_gpiochip_add(struct gpio_chip *chip)
>  	struct device_node *np;
>  	int ret;
>  
> -	np = to_of_node(dev_fwnode(&chip->gpiodev->dev));
> +	np = to_of_node(chip->fwnode);
>  	if (!np)
>  		return 0;
>  
> @@ -1092,19 +1092,3 @@ void of_gpiochip_remove(struct gpio_chip *chip)
>  {
>  	fwnode_handle_put(chip->fwnode);
>  }
> -
> -void of_gpio_dev_init(struct gpio_chip *gc, struct gpio_device *gdev)
> -{
> -	/* Set default OF node to parent's one if present */
> -	if (gc->parent)
> -		gdev->dev.of_node = gc->parent->of_node;
> -
> -	if (gc->fwnode)
> -		gc->of_node = to_of_node(gc->fwnode);
> -
> -	/* If the gpiochip has an assigned OF node this takes precedence */
> -	if (gc->of_node)
> -		gdev->dev.of_node = gc->of_node;
> -	else
> -		gc->of_node = gdev->dev.of_node;
> -}
> diff --git a/drivers/gpio/gpiolib-of.h b/drivers/gpio/gpiolib-of.h
> index a6c593e6766c..e5bb065d82ef 100644
> --- a/drivers/gpio/gpiolib-of.h
> +++ b/drivers/gpio/gpiolib-of.h
> @@ -23,7 +23,6 @@ struct gpio_desc *of_find_gpio(struct device_node *np,
>  int of_gpiochip_add(struct gpio_chip *gc);
>  void of_gpiochip_remove(struct gpio_chip *gc);
>  int of_gpio_get_count(struct device *dev, const char *con_id);
> -void of_gpio_dev_init(struct gpio_chip *gc, struct gpio_device *gdev);
>  #else
>  static inline struct gpio_desc *of_find_gpio(struct device_node *np,
>  					     const char *con_id,
> @@ -38,10 +37,6 @@ static inline int of_gpio_get_count(struct device *dev, const char *con_id)
>  {
>  	return 0;
>  }
> -static inline void of_gpio_dev_init(struct gpio_chip *gc,
> -				    struct gpio_device *gdev)
> -{
> -}
>  #endif /* CONFIG_OF_GPIO */
>  
>  extern struct notifier_block gpio_of_notifier;
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 7936d54a2e30..3df482d36366 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -655,10 +655,12 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
>  	int ret = 0;
>  	u32 ngpios;
>  
> +	/* If the calling driver did not initialize firmware node, do it here */
>  	if (gc->fwnode)
>  		fwnode = gc->fwnode;
>  	else if (gc->parent)
>  		fwnode = dev_fwnode(gc->parent);
> +	gc->fwnode = fwnode;
>  
>  	/*
>  	 * First: allocate and populate the internal stat container, and
> @@ -672,14 +674,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
>  	gdev->chip = gc;
>  	gc->gpiodev = gdev;
>  
> -	of_gpio_dev_init(gc, gdev);
> -	acpi_gpio_dev_init(gc, gdev);
> -
> -	/*
> -	 * Assign fwnode depending on the result of the previous calls,
> -	 * if none of them succeed, assign it to the parent's one.
> -	 */
> -	gdev->dev.fwnode = dev_fwnode(&gdev->dev) ?: fwnode;
> +	device_set_node(&gdev->dev, gc->fwnode);
>  
>  	gdev->id = ida_alloc(&gpio_ida, GFP_KERNEL);
>  	if (gdev->id < 0) {
> diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
> index 2a44600b01f7..ee382712f066 100644
> --- a/include/linux/gpio/driver.h
> +++ b/include/linux/gpio/driver.h
> @@ -503,13 +503,6 @@ struct gpio_chip {
>  	 * the device tree automatically may have an OF translation
>  	 */
>  
> -	/**
> -	 * @of_node:
> -	 *
> -	 * Pointer to a device tree node representing this GPIO controller.
> -	 */
> -	struct device_node *of_node;
> -
>  	/**
>  	 * @of_gpio_n_cells:
>  	 *
> 
> base-commit: 8dab99c9eab3162bfb4326c35579a3388dbf68f2

Uhpffhh, sorry for this, the base is today's Linux Next.

-- 
With Best Regards,
Andy Shevchenko


