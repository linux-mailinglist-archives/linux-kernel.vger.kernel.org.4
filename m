Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC568626F80
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 13:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbiKMMk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 07:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbiKMMkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 07:40:23 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76BA1115D;
        Sun, 13 Nov 2022 04:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668343221; x=1699879221;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pjNiMa1Cy/F/7GAAO42rp/m2JLQqPKP6EMEtoOQqGQ0=;
  b=cQlImT4HYpjdFBdqe99mm6DDD08JhSHGxb6WaYCixRmqynJbp66WA9mN
   mmUe4tZyo344BTrGFn9iJVVKQuod1lZzKUJiX+TF1POgU2U9QY/5JuL8U
   uuD3fj5I2x796Qi0LXIbuZP2EidmVuUGrSqlHZncUlnlm70cj5AeQ5O1W
   odzw5OYHBRFso8+kXQ52b+NGTyvIx45hnTjYja1eqppsl1VEwszKGUV/i
   nKqPaH7UNQxm3IPDcedqgKovq8nDwU5UOPGCKzZmUnDyNXPaijWHOs4G8
   ksErjHmko49PsWcx71iIYHyo1BTYD9+jEoVh+v8Og7BsjSIxDesPlGDUX
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="295169330"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="295169330"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2022 04:40:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="640451724"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="640451724"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 13 Nov 2022 04:40:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ouCHZ-00Bg3n-0t;
        Sun, 13 Nov 2022 14:40:17 +0200
Date:   Sun, 13 Nov 2022 14:40:17 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        michael@walle.cc, broonie@kernel.org
Subject: Re: [PATCH v2 1/4] gpio: regmap: Always set gpio_chip get_direction
Message-ID: <Y3DlsTAQMi6kKObJ@smile.fi.intel.com>
References: <cover.1668129763.git.william.gray@linaro.org>
 <1805d1ddb5bbce8e86164e66421ddde481cce4f9.1668129763.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1805d1ddb5bbce8e86164e66421ddde481cce4f9.1668129763.git.william.gray@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 08:55:50PM -0500, William Breathitt Gray wrote:
> If you only have reg_dat_base set, then it is input-only; if you only
> have reg_set_base set, then it is output-only. Thus, we can always set
> gpio_chip get_direction to gpio_regmap_get_direction and return
> GPIO_LINE_DIRECTION_IN/GPIO_LINE_DIRECTION_OUT given the respective
> register base addresses configuration.

Seems legit to me. Have you checked if we have any gpio-regmap drivers that
have something like this in their configuration already? In such cases we need
to be sure they behave as expected.

From the code perspective:
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
> ---
>  drivers/gpio/gpio-regmap.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
> index 6383136cbe59..f907c9c19fce 100644
> --- a/drivers/gpio/gpio-regmap.c
> +++ b/drivers/gpio/gpio-regmap.c
> @@ -111,6 +111,11 @@ static int gpio_regmap_get_direction(struct gpio_chip *chip,
>  	unsigned int base, val, reg, mask;
>  	int invert, ret;
>  
> +	if (gpio->reg_dat_base && !gpio->reg_set_base)
> +		return GPIO_LINE_DIRECTION_IN;
> +	if (gpio->reg_set_base && !gpio->reg_dat_base)
> +		return GPIO_LINE_DIRECTION_OUT;
> +
>  	if (gpio->reg_dir_out_base) {
>  		base = gpio_regmap_addr(gpio->reg_dir_out_base);
>  		invert = 0;
> @@ -265,8 +270,8 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
>  	else if (gpio->reg_set_base)
>  		chip->set = gpio_regmap_set;
>  
> +	chip->get_direction = gpio_regmap_get_direction;
>  	if (gpio->reg_dir_in_base || gpio->reg_dir_out_base) {
> -		chip->get_direction = gpio_regmap_get_direction;
>  		chip->direction_input = gpio_regmap_direction_input;
>  		chip->direction_output = gpio_regmap_direction_output;
>  	}
> -- 
> 2.38.1
> 

-- 
With Best Regards,
Andy Shevchenko


