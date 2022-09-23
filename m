Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7BB5E77E9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 12:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbiIWKHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 06:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiIWKG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 06:06:56 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8982512FF3F;
        Fri, 23 Sep 2022 03:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663927615; x=1695463615;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+oSd0PfS7j323D9c8ig+E+YN3x+3W01efVkSFG2V1Y0=;
  b=cKHaGShbndR9CcIG4oJkaf7Cxk27KxjX2wcmV64onmtH34pW+M/cZJsH
   7gK1bFNXVJIYIOq572Ph35H9mPyUIXEWsnmmdmsVaK3Xia2CDB//iB61a
   0jqPtyhkxoU9YJFrGWjWhe1jhpGzf15EISKNH1utcMaK/RpFYwU48PnTa
   MLCqSAwJPKImMT0GEv6Te4bk76b2Q+QiqBSQASZpU3BjLW54Tw41/f3zs
   sJGw5JKHsaX8XOjcMmvfOD0sD7DOVNXvSAVi3D5IGCo4wdRFGlUDGFVlI
   MkWC/MFCFwboVayTWNkgW7xitw3lZmb/XJPIYsrqEgBJWRhjXph3JPAG/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="302006324"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="302006324"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 03:06:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="795457481"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 23 Sep 2022 03:06:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1obfa8-006Pgq-1q;
        Fri, 23 Sep 2022 13:06:52 +0300
Date:   Fri, 23 Sep 2022 13:06:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spi-mpc52xx: switch to using gpiod API
Message-ID: <Yy2FPMoyQS+U6AWX@smile.fi.intel.com>
References: <Yy07WbMAG4bPgYNd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yy07WbMAG4bPgYNd@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 09:51:37PM -0700, Dmitry Torokhov wrote:
> This switches the driver to use gpiod API instead of legacy gpio API,
> which will brings us close to removing of_get_gpio() and other
> OF-specific old APIs.
> 
> No functional change intended beyond some differences in error messages.

Fine to me:

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks!

One nit-pick below.

> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/spi/spi-mpc52xx.c | 32 +++++++++++++-------------------
>  1 file changed, 13 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/spi/spi-mpc52xx.c b/drivers/spi/spi-mpc52xx.c
> index 97cdd6545ee1..cb075c1acbee 100644
> --- a/drivers/spi/spi-mpc52xx.c
> +++ b/drivers/spi/spi-mpc52xx.c
> @@ -11,6 +11,7 @@
>   */
>  
>  #include <linux/module.h>
> +#include <linux/err.h>
>  #include <linux/errno.h>
>  #include <linux/of_platform.h>
>  #include <linux/interrupt.h>
> @@ -18,7 +19,6 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/spi/spi.h>
>  #include <linux/io.h>
> -#include <linux/of_gpio.h>
>  #include <linux/slab.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
> @@ -90,7 +90,7 @@ struct mpc52xx_spi {
>  	const u8 *tx_buf;
>  	int cs_change;
>  	int gpio_cs_count;
> -	unsigned int *gpio_cs;
> +	struct gpio_desc **gpio_cs;
>  };
>  
>  /*
> @@ -102,9 +102,10 @@ static void mpc52xx_spi_chipsel(struct mpc52xx_spi *ms, int value)
>  
>  	if (ms->gpio_cs_count > 0) {
>  		cs = ms->message->spi->chip_select;
> -		gpio_set_value(ms->gpio_cs[cs], value ? 0 : 1);
> -	} else
> +		gpiod_set_value(ms->gpio_cs[cs], value);
> +	} else {
>  		out_8(ms->regs + SPI_PORTDATA, value ? 0 : 0x08);
> +	}
>  }
>  
>  /*
> @@ -386,10 +387,10 @@ static int mpc52xx_spi_probe(struct platform_device *op)
>  {
>  	struct spi_master *master;
>  	struct mpc52xx_spi *ms;
> +	struct gpio_desc *gpio_cs;
>  	void __iomem *regs;
>  	u8 ctrl1;
>  	int rc, i = 0;
> -	int gpio_cs;
>  
>  	/* MMIO registers */
>  	dev_dbg(&op->dev, "probing mpc5200 SPI device\n");
> @@ -451,23 +452,16 @@ static int mpc52xx_spi_probe(struct platform_device *op)
>  		}
>  
>  		for (i = 0; i < ms->gpio_cs_count; i++) {
> -			gpio_cs = of_get_gpio(op->dev.of_node, i);
> -			if (!gpio_is_valid(gpio_cs)) {
> -				dev_err(&op->dev,
> -					"could not parse the gpio field in oftree\n");
> -				rc = -ENODEV;
> -				goto err_gpio;
> -			}
> -
> -			rc = gpio_request(gpio_cs, dev_name(&op->dev));
> +			gpio_cs = gpiod_get_index(&op->dev,
> +						  NULL, i, GPIOD_OUT_LOW);

More parameters can be placed on the previous line, but I think you can even
put everything on one line (it's only 85 characters long).

> +			rc = PTR_ERR_OR_ZERO(gpio_cs);
>  			if (rc) {
>  				dev_err(&op->dev,
> -					"can't request spi cs gpio #%d on gpio line %d\n",
> -					i, gpio_cs);
> +					"failed to get spi cs gpio #%d: %d\n",
> +					i, rc);
>  				goto err_gpio;
>  			}
>  
> -			gpio_direction_output(gpio_cs, 1);
>  			ms->gpio_cs[i] = gpio_cs;
>  		}
>  	}
> @@ -508,7 +502,7 @@ static int mpc52xx_spi_probe(struct platform_device *op)
>  	dev_err(&ms->master->dev, "initialization failed\n");
>   err_gpio:
>  	while (i-- > 0)
> -		gpio_free(ms->gpio_cs[i]);
> +		gpiod_put(ms->gpio_cs[i]);
>  
>  	kfree(ms->gpio_cs);
>   err_alloc_gpio:
> @@ -529,7 +523,7 @@ static int mpc52xx_spi_remove(struct platform_device *op)
>  	free_irq(ms->irq1, ms);
>  
>  	for (i = 0; i < ms->gpio_cs_count; i++)
> -		gpio_free(ms->gpio_cs[i]);
> +		gpiod_put(ms->gpio_cs[i]);
>  
>  	kfree(ms->gpio_cs);
>  	spi_unregister_master(master);
> -- 
> 2.37.3.998.g577e59143f-goog
> 
> 
> -- 
> Dmitry

-- 
With Best Regards,
Andy Shevchenko


