Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF796AEBFD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjCGRut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbjCGRuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:50:22 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6943F9FBC3;
        Tue,  7 Mar 2023 09:45:21 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="335943009"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="335943009"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 09:45:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="922456193"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="922456193"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 07 Mar 2023 09:45:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1pZbNF-00H2Vx-2b;
        Tue, 07 Mar 2023 19:45:17 +0200
Date:   Tue, 7 Mar 2023 19:45:17 +0200
From:   Andy Shevchenko <andy@kernel.org>
To:     Andrew Davis <afd@ti.com>
Cc:     Peter Tyser <ptyser@xes-inc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] gpio: twl4030: Use devm_gpiochip_add_data() to
 simplify remove path
Message-ID: <ZAd4LcM4BOyRBWWb@smile.fi.intel.com>
References: <20230307165432.25484-1-afd@ti.com>
 <20230307165432.25484-2-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307165432.25484-2-afd@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 10:54:28AM -0600, Andrew Davis wrote:
> Use devm version of gpiochip add function to handle removal for us.

I do not see this change in the below code.
Can you shed a light?

> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  drivers/gpio/gpio-twl4030.c | 16 ----------------
>  1 file changed, 16 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-twl4030.c b/drivers/gpio/gpio-twl4030.c
> index c1bb2c3ca6f2..23f58bf3a415 100644
> --- a/drivers/gpio/gpio-twl4030.c
> +++ b/drivers/gpio/gpio-twl4030.c
> @@ -492,18 +492,6 @@ static struct twl4030_gpio_platform_data *of_gpio_twl4030(struct device *dev,
>  	return omap_twl_info;
>  }
>  
> -/* Cannot use as gpio_twl4030_probe() calls us */
> -static int gpio_twl4030_remove(struct platform_device *pdev)
> -{
> -	struct gpio_twl4030_priv *priv = platform_get_drvdata(pdev);
> -
> -	gpiochip_remove(&priv->gpio_chip);
> -
> -	/* REVISIT no support yet for deregistering all the IRQs */
> -	WARN_ON(!is_module());
> -	return 0;
> -}
> -
>  static int gpio_twl4030_probe(struct platform_device *pdev)
>  {
>  	struct twl4030_gpio_platform_data *pdata = dev_get_platdata(&pdev->dev);
> @@ -581,12 +569,9 @@ static int gpio_twl4030_probe(struct platform_device *pdev)
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "could not register gpiochip, %d\n", ret);
>  		priv->gpio_chip.ngpio = 0;
> -		gpio_twl4030_remove(pdev);
>  		goto out;
>  	}
>  
> -	platform_set_drvdata(pdev, priv);
> -
>  	if (pdata->setup) {
>  		int status;
>  
> @@ -615,7 +600,6 @@ static struct platform_driver gpio_twl4030_driver = {
>  		.of_match_table = twl_gpio_match,
>  	},
>  	.probe		= gpio_twl4030_probe,
> -	.remove		= gpio_twl4030_remove,
>  };
>  
>  static int __init gpio_twl4030_init(void)

-- 
With Best Regards,
Andy Shevchenko


