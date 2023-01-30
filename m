Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0477B681771
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 18:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237782AbjA3RTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 12:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237784AbjA3RTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 12:19:12 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF3A301B3;
        Mon, 30 Jan 2023 09:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675099145; x=1706635145;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NLztemHsCaq3ewHaqoaHpGUNGwM//4YiZi1XpQPenT8=;
  b=msVbkiew7cvJUGGghomXgP9CcGSpnbMh0nxxy/TIkAgRxP2vUbAT59/h
   Of7HIz9RgATwl2KQ5p1qxqwSvT/0g7knd8aE/gVefGgPvUY6gVKaCLDiz
   1w3pxtQUy2uNgXFZySNUkVJjJ3rzYRDfqRO4CQzbcCSMEOHm0Z1qW/UMx
   LlDKVr1rUWVlNhBBGeepktLqx2pNLwnHILS3kl1LUJ9ZDy7sY01SMB+U3
   L+6hI46lgBWsnTH04ms87YVkhZQdAjE+D0ew1zJa1xsZxmbEW57nUU2v3
   4EKVpy5+Epi7SwEbV1Cd1h4mVZiXKLs5NKWpBxooLjCmh0k8AMt8/2hVn
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="311240489"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="311240489"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 09:19:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="614116523"
X-IronPort-AV: E=Sophos;i="5.97,258,1669104000"; 
   d="scan'208";a="614116523"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 30 Jan 2023 09:18:59 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pMXnz-00HS34-1D;
        Mon, 30 Jan 2023 19:18:55 +0200
Date:   Mon, 30 Jan 2023 19:18:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Hugues Fruchet <hugues.fruchet@st.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: c8sectpfe: convert to gpio descriptors
Message-ID: <Y9f7/q3aS5nlY7nJ@smile.fi.intel.com>
References: <20230130131003.668888-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130131003.668888-1-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 02:09:47PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The gpio usage in the function is fairly straightforward,
> but the normal gpiod_get() interface cannot be used here
> since the gpio is referenced by a child node of the device.
> 
> Using devm_fwnode_gpiod_get_index() is the best alternative
> here.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

One topic to discuss below (but I'm fine with this version).

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  .../st/sti/c8sectpfe/c8sectpfe-core.c         | 30 ++++++++-----------
>  .../st/sti/c8sectpfe/c8sectpfe-core.h         |  2 +-
>  2 files changed, 13 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c b/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c
> index c38b62d4f1ae..86a2c77c5471 100644
> --- a/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c
> +++ b/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c
> @@ -22,7 +22,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> -#include <linux/of_gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/of_platform.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/pinctrl/pinctrl.h>
> @@ -812,30 +812,24 @@ static int c8sectpfe_probe(struct platform_device *pdev)
>  		}
>  		of_node_put(i2c_bus);
>  
> -		tsin->rst_gpio = of_get_named_gpio(child, "reset-gpios", 0);
> -
> -		ret = gpio_is_valid(tsin->rst_gpio);
> -		if (!ret) {
> -			dev_err(dev,
> -				"reset gpio for tsin%d not valid (gpio=%d)\n",
> -				tsin->tsin_id, tsin->rst_gpio);
> -			ret = -EINVAL;
> -			goto err_node_put;
> -		}
> -
> -		ret = devm_gpio_request_one(dev, tsin->rst_gpio,
> -					GPIOF_OUT_INIT_LOW, "NIM reset");
> +		tsin->rst_gpio = devm_fwnode_gpiod_get_index(dev,
> +							     of_node_to_fwnode(child),
> +							     "reset-gpios",
> +							     0, GPIOD_OUT_LOW,
> +							     "NIM reset");

> +		ret = PTR_ERR_OR_ZERO(tsin->rst_gpio);
>  		if (ret && ret != -EBUSY) {
> -			dev_err(dev, "Can't request tsin%d reset gpio\n"
> -				, fei->channel_data[index]->tsin_id);
> +			dev_err_probe(dev, ret,
> +				      "reset gpio for tsin%d not valid\n",
> +				      tsin->tsin_id);
>  			goto err_node_put;
>  		}
>  
>  		if (!ret) {

Can be 

	if (IS_ERR() && PTR_ERR() != -EBUSY) {
		ret = dev_err_probe(dev, PTR_ERR(), ...);
		...
	}

	if (!IS_ERR())

(Up to you)

But -EBUSY check seems strange to me. What was the motivation behind?
(As far as I can read the code the possibility to get this if and only
 if we have requested GPIO too early at initcall level. Would it be
 ever a possibility to get it in real life?)

>  			/* toggle reset lines */
> -			gpio_direction_output(tsin->rst_gpio, 0);
> +			gpiod_direction_output(tsin->rst_gpio, 0);
>  			usleep_range(3500, 5000);
> -			gpio_direction_output(tsin->rst_gpio, 1);
> +			gpiod_direction_output(tsin->rst_gpio, 1);
>  			usleep_range(3000, 5000);
>  		}
>  
> diff --git a/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.h b/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.h
> index c9d6021904cd..f2a6991e064e 100644
> --- a/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.h
> +++ b/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.h
> @@ -25,7 +25,7 @@ struct channel_info {
>  	int i2c;
>  	int dvb_card;
>  
> -	int rst_gpio;
> +	struct gpio_desc *rst_gpio;
>  
>  	struct i2c_adapter  *i2c_adapter;
>  	struct i2c_adapter  *tuner_i2c;
> -- 
> 2.39.0
> 

-- 
With Best Regards,
Andy Shevchenko


