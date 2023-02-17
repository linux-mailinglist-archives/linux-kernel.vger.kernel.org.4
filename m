Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BBB69B2C2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 19:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjBQS6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 13:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjBQS6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 13:58:21 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D083C12F0C;
        Fri, 17 Feb 2023 10:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676660290; x=1708196290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zFdNYo/jZ5s31o3pUkRFRp4dgXxQK/XiqFx191Ifwss=;
  b=YQ/BLXhLXnJYvgaPFmx0U88Kcq/w9pymTuofmQpDK21buR8w5mkrxjHc
   XPPLwCfNbg6x/czJcUYnbs7vapque2eMH8yWUl9AHFm01YJw+ZcElZ0Zv
   ylbXN6gSTNSZH+FynbFJt/esI4scM7+osOQSnWHc80qPVIz9owRFmfqAG
   evc2yr7RSevxTEKDNCjA8BRjRGn1SVxqonhj/iIYxzVLVe3tYdwPZmDfF
   fo/F/hvHVipS2l00Or3wLCC13OriyElnUQ6eQzOZ5NZTRYXk8PNG2C5zz
   G4mkl09LIwmrRMXg+2UHoYAJAZgoJEdWF6UtdTUiDC/ZAxdN5nSdvmPAA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="330727277"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="330727277"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 10:58:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="779877589"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="779877589"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 17 Feb 2023 10:58:08 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pT5vr-008KPn-10;
        Fri, 17 Feb 2023 20:58:07 +0200
Date:   Fri, 17 Feb 2023 20:58:07 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, broonie@kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] gpio: 104-dio-48e: Utilize no_status regmap-irq flag
Message-ID: <Y+/OP5pj7OBZ9M8g@smile.fi.intel.com>
References: <cover.1675876659.git.william.gray@linaro.org>
 <0feb25265128808d4487c49238fdd9f3ca3bb725.1675876659.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0feb25265128808d4487c49238fdd9f3ca3bb725.1675876659.git.william.gray@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 12:18:17PM -0500, William Breathitt Gray wrote:
> The 104-DIO-48E lacks an IRQ status register. Rather than use the Clear
> Interrupt register as the status register, set the no_status flag to
> true and thus avoid such a hack.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
> ---
>  drivers/gpio/gpio-104-dio-48e.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-104-dio-48e.c b/drivers/gpio/gpio-104-dio-48e.c
> index a3846faf3780..fe3c93bfe4bd 100644
> --- a/drivers/gpio/gpio-104-dio-48e.c
> +++ b/drivers/gpio/gpio-104-dio-48e.c
> @@ -195,13 +195,9 @@ static int dio48e_probe(struct device *dev, unsigned int id)
>  		return -ENOMEM;
>  
>  	chip->name = name;
> -	/* No IRQ status register so use CLEAR_INTERRUPT register instead */
> -	chip->status_base = DIO48E_CLEAR_INTERRUPT;
>  	chip->mask_base = DIO48E_ENABLE_INTERRUPT;
>  	chip->ack_base = DIO48E_CLEAR_INTERRUPT;
> -	/* CLEAR_INTERRUPT doubles as status register so we need it cleared */
> -	chip->clear_ack = true;
> -	chip->status_invert = true;
> +	chip->no_status = true;
>  	chip->num_regs = 1;
>  	chip->irqs = dio48e_regmap_irqs;
>  	chip->num_irqs = ARRAY_SIZE(dio48e_regmap_irqs);
> -- 
> 2.39.1
> 

-- 
With Best Regards,
Andy Shevchenko


