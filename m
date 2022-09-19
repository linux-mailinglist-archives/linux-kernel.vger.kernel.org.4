Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7D35BC5D0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiISJyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiISJyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:54:21 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8D412AD1;
        Mon, 19 Sep 2022 02:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663581260; x=1695117260;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J84tZUNo70mPEn5i619JIcO867QIpVxzMSvGnO/5+I8=;
  b=bsKaM9zDaIbwkwleTrglfuDwMot7CaoLbHG9DnScRE3TePWPrxjw9SWl
   zFD+CVTPQNm7qODXYw5wnZzt5QkMWRmVvbIUscTkud5+7Iz2AZWBJWS57
   0GFHR/pdcQk1WRILBOCK7QgUe3zbEPcB3Z6ZK9GknTtIeQACQZQjL0Kmt
   FN2EXLqR1LEbhUmLPRkQmOwxa5Fgo8itoLg2OEEGA9xdTl6y4YluMSiD5
   OuSTSt8Q3kmeBDBlSh9jJvkYrncW9fr0p+qW/h9OxcTPnGs/XqEbwcRY8
   FTMIwH4zPfm+/hEZ/GXIKsvbxsqsb6exOKxzDYluJkaqWLU6JwHyAmGOD
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="363314046"
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="363314046"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 02:54:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="793795409"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 19 Sep 2022 02:54:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oaDTh-004VMM-2h;
        Mon, 19 Sep 2022 12:54:13 +0300
Date:   Mon, 19 Sep 2022 12:54:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org,
        jingle.wu@emc.com.tw, rafael@kernel.org, mario.limonciello@amd.com,
        hdegoede@redhat.com, linus.walleij@linaro.org, timvp@google.com,
        dmitry.torokhov@gmail.com, Bartosz Golaszewski <brgl@bgdev.pl>,
        Len Brown <lenb@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/13] gpiolib: acpi: Add wake_capable variants of
 acpi_dev_gpio_irq_get
Message-ID: <Yyg8RU2k6ZCRuqri@smile.fi.intel.com>
References: <20220914235801.1731478-1-rrangel@chromium.org>
 <20220914155914.v3.5.I4ff95ba7e884a486d7814ee888bf864be2ebdef4@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914155914.v3.5.I4ff95ba7e884a486d7814ee888bf864be2ebdef4@changeid>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 05:57:53PM -0600, Raul E Rangel wrote:
> The ACPI spec defines the SharedAndWake and ExclusiveAndWake share type
> keywords. This is an indication that the GPIO IRQ can also be used as a
> wake source. This change exposes the wake_capable bit so drivers can
> correctly enable wake functionality instead of making an assumption.

With two nit-picks below
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> ---
> 
> Changes in v3:
> - Kept `acpi_dev_gpio_irq_get_by` unchanged to avoid having to touch
>   unrelated drivers.
> - Converted wake_capable parameter to bool.
> 
> Changes in v2:
> - Fixed call site in mlxbf_gige_probe
> 
>  drivers/gpio/gpiolib-acpi.c | 17 ++++++++++++++---
>  drivers/gpio/gpiolib-acpi.h |  2 ++
>  include/linux/acpi.h        | 22 ++++++++++++++++++----
>  3 files changed, 34 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index 9be1376f9a627f..c703f095993a2c 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -741,6 +741,8 @@ static int acpi_populate_gpio_lookup(struct acpi_resource *ares, void *data)
>  		lookup->info.pin_config = agpio->pin_config;
>  		lookup->info.debounce = agpio->debounce_timeout;
>  		lookup->info.gpioint = gpioint;
> +		lookup->info.wake_capable = agpio->wake_capable ==
> +					    ACPI_WAKE_CAPABLE;

Can be still on one line.

>  		/*
>  		 * Polarity and triggering are only specified for GpioInt
> @@ -987,10 +989,12 @@ struct gpio_desc *acpi_node_get_gpiod(struct fwnode_handle *fwnode,
>  }
>  
>  /**
> - * acpi_dev_gpio_irq_get_by() - Find GpioInt and translate it to Linux IRQ number
> + * acpi_dev_gpio_irq_wake_get_by() - Find GpioInt and translate it to Linux IRQ
> + *                                   number
>   * @adev: pointer to a ACPI device to get IRQ from
>   * @name: optional name of GpioInt resource
>   * @index: index of GpioInt resource (starting from %0)
> + * @wake_capable: Set to true if the IRQ is wake capable
>   *
>   * If the device has one or more GpioInt resources, this function can be
>   * used to translate from the GPIO offset in the resource to the Linux IRQ
> @@ -1002,9 +1006,13 @@ struct gpio_desc *acpi_node_get_gpiod(struct fwnode_handle *fwnode,
>   * The function takes optional @name parameter. If the resource has a property
>   * name, then only those will be taken into account.
>   *
> + * The GPIO is considered wake capable if the GpioInt resource specifies
> + * SharedAndWake or ExclusiveAndWake.
> + *
>   * Return: Linux IRQ number (> %0) on success, negative errno on failure.
>   */
> -int acpi_dev_gpio_irq_get_by(struct acpi_device *adev, const char *name, int index)
> +int acpi_dev_gpio_irq_wake_get_by(struct acpi_device *adev, const char *name,
> +				  int index, bool *wake_capable)
>  {
>  	int idx, i;
>  	unsigned int irq_flags;
> @@ -1061,13 +1069,16 @@ int acpi_dev_gpio_irq_get_by(struct acpi_device *adev, const char *name, int ind
>  				dev_dbg(&adev->dev, "IRQ %d already in use\n", irq);
>  			}
>  
> +			if (wake_capable)
> +				*wake_capable = info.wake_capable;
> +
>  			return irq;
>  		}
>  
>  	}
>  	return -ENOENT;
>  }
> -EXPORT_SYMBOL_GPL(acpi_dev_gpio_irq_get_by);
> +EXPORT_SYMBOL_GPL(acpi_dev_gpio_irq_wake_get_by);
>  
>  static acpi_status
>  acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
> diff --git a/drivers/gpio/gpiolib-acpi.h b/drivers/gpio/gpiolib-acpi.h
> index e476558d947136..1ac6816839dbce 100644
> --- a/drivers/gpio/gpiolib-acpi.h
> +++ b/drivers/gpio/gpiolib-acpi.h
> @@ -18,6 +18,7 @@ struct acpi_device;
>   * @pin_config: pin bias as provided by ACPI
>   * @polarity: interrupt polarity as provided by ACPI
>   * @triggering: triggering type as provided by ACPI
> + * @wake_capable: wake capability as provided by ACPI
>   * @debounce: debounce timeout as provided by ACPI
>   * @quirks: Linux specific quirks as provided by struct acpi_gpio_mapping
>   */
> @@ -28,6 +29,7 @@ struct acpi_gpio_info {
>  	int pin_config;
>  	int polarity;
>  	int triggering;
> +	bool wake_capable;
>  	unsigned int debounce;
>  	unsigned int quirks;
>  };
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 6f64b2f3dc5479..d3121cef6cc3bc 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1202,7 +1202,8 @@ bool acpi_gpio_get_irq_resource(struct acpi_resource *ares,
>  				struct acpi_resource_gpio **agpio);
>  bool acpi_gpio_get_io_resource(struct acpi_resource *ares,
>  			       struct acpi_resource_gpio **agpio);
> -int acpi_dev_gpio_irq_get_by(struct acpi_device *adev, const char *name, int index);
> +int acpi_dev_gpio_irq_wake_get_by(struct acpi_device *adev, const char *name,
> +				  int index, bool *wake_capable);
>  #else
>  static inline bool acpi_gpio_get_irq_resource(struct acpi_resource *ares,
>  					      struct acpi_resource_gpio **agpio)
> @@ -1214,16 +1215,29 @@ static inline bool acpi_gpio_get_io_resource(struct acpi_resource *ares,
>  {
>  	return false;
>  }
> -static inline int acpi_dev_gpio_irq_get_by(struct acpi_device *adev,
> -					   const char *name, int index)
> +static inline int acpi_dev_gpio_irq_wake_get_by(struct acpi_device *adev,
> +						const char *name, int index,
> +						bool *wake_capable)
>  {
>  	return -ENXIO;
>  }
>  #endif
>  
> +static inline int acpi_dev_gpio_irq_get_by(struct acpi_device *adev,
> +					   const char *name, int index)
> +{
> +	return acpi_dev_gpio_irq_wake_get_by(adev, name, index, NULL);
> +}
> +
>  static inline int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index)
>  {
> -	return acpi_dev_gpio_irq_get_by(adev, NULL, index);
> +	return acpi_dev_gpio_irq_wake_get_by(adev, NULL, index, NULL);
> +}

> +static inline int acpi_dev_gpio_irq_wake_get(struct acpi_device *adev,
> +					     int index, bool *wake_capable)
> +{
> +	return acpi_dev_gpio_irq_wake_get_by(adev, NULL, index, wake_capable);
>  }

I would put this first in the group of these three helpers, so irq_get_by and
irq_get will be the last (from more parameters to less parameters).

>  /* Device properties */
> -- 
> 2.37.3.968.ga6b4b080e4-goog
> 

-- 
With Best Regards,
Andy Shevchenko


