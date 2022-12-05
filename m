Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B26C6428B1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbiLEMnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiLEMni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:43:38 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1D255B9;
        Mon,  5 Dec 2022 04:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670244217; x=1701780217;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IUKqw4fNGwWQubPbN+4XH14TACNyuJfdZTat+2XlqW8=;
  b=WU2kTDrWsttsITxLBjRdI3F52EtiWL4aMcB4Fy/Y7fikFJXwRVZPYJ0i
   7bDCGOy9IDb4xRgZp2nvBaTPAMyk+qAObWbAsyY3zOra1+ZVCMkAN59+W
   cst6xvkKuwG9cXWrXk/MZoVmqFaFWUOjJjn1RD1FFl28xUAEWHruCJEdD
   CZD+uYnWWsePV5XZw9pkIRdrzQjhsybLCv5Bi17jQHz5lL7Br4RESVf6N
   UOlACld+yvXu/ut9Kodisp6lXWeR0tBCrcThuH9tUjVyEFcgQC2DPQAqz
   qTBMegozHFyVE0ur2l6a59+1nL1VNPMrINsW/8vaHBde679dYnQFfGdHa
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="402610082"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="402610082"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 04:43:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="974670732"
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="scan'208";a="974670732"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 05 Dec 2022 04:43:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p2Aol-004sBg-2w;
        Mon, 05 Dec 2022 14:43:31 +0200
Date:   Mon, 5 Dec 2022 14:43:31 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, soc@kernel.org,
        Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] soc: fsl: qe: request pins non-exclusively
Message-ID: <Y43ncwKEsZbej2tk@smile.fi.intel.com>
References: <Y400YXnWBdz1e/L5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y400YXnWBdz1e/L5@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2022 at 03:59:29PM -0800, Dmitry Torokhov wrote:
> Commit 84582f9ed090 ("soc: fsl: qe: Avoid using gpio_to_desc()") changed
> qe_pin_request() to request and hold GPIO corresponding to a given pin.
> Unfortunately this does not work, as fhci-hcd requests these GPIOs
> first, befor calling qe_pin_request() (see

before ?

> drivers/usb/host/fhci-hcd.c::of_fhci_probe()).
> To fix it change qe_pin_request() to request GPIOs non-exclusively, and
> free them once the code determines GPIO controller and offset for each
> GPIO/pin.
> 
> Also reaching deep into gpiolib implementation is not the best idea. We
> should either export gpio_chip_hwgpio() or keep converting to the global
> gpio numbers space until we fix the driver to implement proper pin

GPIO number

> control.

With or without being rebased on top of the PR that in conflict with this
change,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
(see some nit-picks below)

> Fixes: 84582f9ed090 ("soc: fsl: qe: Avoid using gpio_to_desc()")
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> v2:
> 
>  - rebased on top of soc/driver. This will conflict with
>    c9eb6e546a23 soc: fsl: qe: Switch to use fwnode instead of of_node
>    found in next, the resolution is trivial: accept
>    fwnode_device_is_compatible() line found in next.
>  - fixed leak of gpiod when gc is not found
>  - dropped Linus' reviewed-by as the patch changed
> 
>  drivers/soc/fsl/qe/gpio.c   | 51 +++++++++++++++++--------------------
>  drivers/usb/host/fhci-hcd.c |  2 +-
>  include/soc/fsl/qe/qe.h     |  5 ++--
>  3 files changed, 28 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qe/gpio.c b/drivers/soc/fsl/qe/gpio.c
> index af9193e7e49b..1440922341d8 100644
> --- a/drivers/soc/fsl/qe/gpio.c
> +++ b/drivers/soc/fsl/qe/gpio.c
> @@ -13,19 +13,12 @@
>  #include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/of.h>
> -#include <linux/of_gpio.h>
> +#include <linux/of_gpio.h>	/* for of_mm_gpio_chip */
>  #include <linux/gpio/consumer.h>
>  #include <linux/gpio/driver.h>
>  #include <linux/slab.h>
>  #include <linux/export.h>
>  #include <soc/fsl/qe/qe.h>
> -/*
> - * FIXME: this is legacy code that is accessing gpiolib internals in order
> - * to implement a custom pin controller. The proper solution is to create
> - * a real combined pin control and GPIO driver in drivers/pinctrl. However
> - * this hack is here for legacy code reasons.
> - */
> -#include "../../../gpio/gpiolib.h"
>  
>  struct qe_gpio_chip {
>  	struct of_mm_gpio_chip mm_gc;
> @@ -147,65 +140,70 @@ struct qe_pin {
>  	 * something like qe_pio_controller. Someday.
>  	 */
>  	struct qe_gpio_chip *controller;
> -	struct gpio_desc *gpiod;
>  	int num;
>  };
>  
>  /**
>   * qe_pin_request - Request a QE pin
> - * @np:		device node to get a pin from
> - * @index:	index of a pin in the device tree
> + * @dev:	device to get the pin from
> + * @index:	index of the pin in the device tree
>   * Context:	non-atomic
>   *
>   * This function return qe_pin so that you could use it with the rest of
>   * the QE Pin Multiplexing API.
>   */
> -struct qe_pin *qe_pin_request(struct device_node *np, int index)
> +struct qe_pin *qe_pin_request(struct device *dev, int index)
>  {
>  	struct qe_pin *qe_pin;
>  	struct gpio_chip *gc;
>  	struct gpio_desc *gpiod;
> +	int gpio_num;
>  	int err;
>  
>  	qe_pin = kzalloc(sizeof(*qe_pin), GFP_KERNEL);
>  	if (!qe_pin) {
> -		pr_debug("%s: can't allocate memory\n", __func__);
> +		dev_dbg(dev, "%s: can't allocate memory\n", __func__);
>  		return ERR_PTR(-ENOMEM);
>  	}
>  
> -	gpiod = fwnode_gpiod_get_index(of_fwnode_handle(np), NULL, index, GPIOD_ASIS, "qe");
> -	if (IS_ERR(gpiod)) {
> -		err = PTR_ERR(gpiod);
> -		goto err0;
> -	}
> -	if (!gpiod) {
> -		err = -EINVAL;
> +	/*
> +	 * Request gpio as nonexclusive as it was likely reserved by the

GPIO

> +	 * caller, and we are not planning on controlling it, we only need
> +	 * the descriptor to the to the gpio chip structure.

GPIO

> +	 */
> +	gpiod = gpiod_get_index(dev, NULL, index,
> +			        GPIOD_ASIS | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
> +	err = PTR_ERR_OR_ZERO(gpiod);
> +	if (err)
>  		goto err0;
> -	}
> +
>  	gc = gpiod_to_chip(gpiod);
> +	gpio_num = desc_to_gpio(gpiod);
> +	/* We no longer need this descriptor */
> +	gpiod_put(gpiod);
> +
>  	if (WARN_ON(!gc)) {
>  		err = -ENODEV;
>  		goto err0;
>  	}
> -	qe_pin->gpiod = gpiod;
> +
>  	qe_pin->controller = gpiochip_get_data(gc);
>  	/*
>  	 * FIXME: this gets the local offset on the gpio_chip so that the driver
>  	 * can manipulate pin control settings through its custom API. The real
>  	 * solution is to create a real pin control driver for this.
>  	 */
> -	qe_pin->num = gpio_chip_hwgpio(gpiod);
> +	qe_pin->num = gpio_num - gc->base;
>  
>  	if (!of_device_is_compatible(gc->of_node, "fsl,mpc8323-qe-pario-bank")) {
> -		pr_debug("%s: tried to get a non-qe pin\n", __func__);
> -		gpiod_put(gpiod);
> +		dev_dbg(dev, "%s: tried to get a non-qe pin\n", __func__);
>  		err = -EINVAL;
>  		goto err0;
>  	}
>  	return qe_pin;
>  err0:
>  	kfree(qe_pin);
> -	pr_debug("%s failed with status %d\n", __func__, err);

> +	dev_dbg(dev, "%s failed with status %d\n", __func__, err);

You can kill these __func__ in dev_dbg():s.

>  	return ERR_PTR(err);
>  }
>  EXPORT_SYMBOL(qe_pin_request);
> @@ -220,7 +218,6 @@ EXPORT_SYMBOL(qe_pin_request);
>   */
>  void qe_pin_free(struct qe_pin *qe_pin)
>  {
> -	gpiod_put(qe_pin->gpiod);
>  	kfree(qe_pin);
>  }
>  EXPORT_SYMBOL(qe_pin_free);
> diff --git a/drivers/usb/host/fhci-hcd.c b/drivers/usb/host/fhci-hcd.c
> index 95a44462bed0..1f666804fa91 100644
> --- a/drivers/usb/host/fhci-hcd.c
> +++ b/drivers/usb/host/fhci-hcd.c
> @@ -651,7 +651,7 @@ static int of_fhci_probe(struct platform_device *ofdev)
>  	}
>  
>  	for (j = 0; j < NUM_PINS; j++) {
> -		fhci->pins[j] = qe_pin_request(node, j);
> +		fhci->pins[j] = qe_pin_request(dev, j);
>  		if (IS_ERR(fhci->pins[j])) {
>  			ret = PTR_ERR(fhci->pins[j]);
>  			dev_err(dev, "can't get pin %d: %d\n", j, ret);
> diff --git a/include/soc/fsl/qe/qe.h b/include/soc/fsl/qe/qe.h
> index b02e9fe69146..eb5079904cc8 100644
> --- a/include/soc/fsl/qe/qe.h
> +++ b/include/soc/fsl/qe/qe.h
> @@ -172,14 +172,15 @@ static inline int par_io_data_set(u8 port, u8 pin, u8 val) { return -ENOSYS; }
>  /*
>   * Pin multiplexing functions.
>   */
> +struct device;
>  struct qe_pin;
>  #ifdef CONFIG_QE_GPIO
> -extern struct qe_pin *qe_pin_request(struct device_node *np, int index);
> +extern struct qe_pin *qe_pin_request(struct device *dev, int index);
>  extern void qe_pin_free(struct qe_pin *qe_pin);
>  extern void qe_pin_set_gpio(struct qe_pin *qe_pin);
>  extern void qe_pin_set_dedicated(struct qe_pin *pin);
>  #else
> -static inline struct qe_pin *qe_pin_request(struct device_node *np, int index)
> +static inline struct qe_pin *qe_pin_request(struct device *dev, int index)
>  {
>  	return ERR_PTR(-ENOSYS);
>  }
> -- 
> 2.39.0.rc0.267.gcb52ba06e7-goog
> 
> 
> -- 
> Dmitry

-- 
With Best Regards,
Andy Shevchenko


