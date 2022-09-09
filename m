Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA6D5B39AF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 15:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbiIINrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbiIINqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:46:45 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B849912E1AF;
        Fri,  9 Sep 2022 06:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662731194; x=1694267194;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tV01OCiZqy6nXlyR7eAfCljasS50nB/vF+IgCufZZUE=;
  b=maIfq4KDFkhkLOgbNbQ20ZzVuqE/nJllh6ru6GJ5a2LTFLErxWJpDIyy
   6BxShoSvqnIc3g/PkSbEXVkDfLaFRxGAL4pMDSYsPZ4+z1f3PmyK42p7a
   mK8hqzDNKeGGpPI0sBx5pfbOoA9z5vNT98orN2zlK3YWKWFgjCHS4puSn
   3vMo71QRQxMU18YJlP757iZXRTDquCFCgawbC7ZHnQm/2pNUtQH7uG8LI
   wXgeFmbUIra9Y8J79vrObfOJW9WIhAtNCbF5Kx9NKK9DIzgX4OpTxVmHx
   8cQYQoP5L48JO1Ka4BtNzKfMWYdHM2u91PrO8Giv+jTVqraXRVTJC5LCj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="383769238"
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="383769238"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 06:45:43 -0700
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="566371087"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 06:45:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oWeKA-00Aa6F-0b;
        Fri, 09 Sep 2022 16:45:38 +0300
Date:   Fri, 9 Sep 2022 16:45:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] gpiolib: un-inline gpiod_request_user()
Message-ID: <YxtDgUbdJnP3RHf7@smile.fi.intel.com>
References: <20220909121329.42004-1-brgl@bgdev.pl>
 <20220909121329.42004-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909121329.42004-2-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 02:13:28PM +0200, Bartosz Golaszewski wrote:
> Pull this bit of code into gpiolib.c as we're soon be calling certain
> symbols static in this compilation unit.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---
>  drivers/gpio/gpiolib.c | 11 +++++++++++
>  drivers/gpio/gpiolib.h | 12 +-----------
>  2 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index cc9c0a12259e..6768734b9e15 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -2009,6 +2009,17 @@ int gpiod_request(struct gpio_desc *desc, const char *label)
>  	return ret;
>  }
>  
> +int gpiod_request_user(struct gpio_desc *desc, const char *label)
> +{
> +	int ret;
> +
> +	ret = gpiod_request(desc, label);
> +	if (ret == -EPROBE_DEFER)
> +		ret = -ENODEV;
> +
> +	return ret;
> +}
> +
>  static bool gpiod_free_commit(struct gpio_desc *desc)
>  {
>  	bool			ret = false;
> diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
> index d900ecdbac46..b35deb08a7f5 100644
> --- a/drivers/gpio/gpiolib.h
> +++ b/drivers/gpio/gpiolib.h
> @@ -179,19 +179,9 @@ struct gpio_desc {
>  #define gpiod_not_found(desc)		(IS_ERR(desc) && PTR_ERR(desc) == -ENOENT)
>  
>  int gpiod_request(struct gpio_desc *desc, const char *label);
> +int gpiod_request_user(struct gpio_desc *desc, const char *label);
>  void gpiod_free(struct gpio_desc *desc);
>  
> -static inline int gpiod_request_user(struct gpio_desc *desc, const char *label)
> -{
> -	int ret;
> -
> -	ret = gpiod_request(desc, label);
> -	if (ret == -EPROBE_DEFER)
> -		ret = -ENODEV;
> -
> -	return ret;
> -}
> -
>  int gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
>  		unsigned long lflags, enum gpiod_flags dflags);
>  int gpio_set_debounce_timeout(struct gpio_desc *desc, unsigned int debounce);
> -- 
> 2.34.1
> 

-- 
With Best Regards,
Andy Shevchenko


