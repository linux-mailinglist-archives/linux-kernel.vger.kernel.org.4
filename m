Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600546259B6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 12:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbiKKLp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 06:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbiKKLpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 06:45:09 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCD113F20;
        Fri, 11 Nov 2022 03:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668167108; x=1699703108;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PSNfh98I49bV8L7DfrxLC+bzZknfDJgPD+SQpUDJ/xE=;
  b=UJLaHQM/pn60iWDT3KtqeLodYrFNAXkQvh4Xe/OAesXiLLQfb7oGDs+V
   X+y7efy3WzrhEZ2+zVeFzWbaTq0OzCMZ0YfMw1D7By//bWJBYKPMB2Zwu
   0SXIV6n3VkbOclgw6hL1n/QXXLFwbpJQVzAQQzeK8mX9GoblKkLGQUL7W
   i8Y7okJZI10chIcZ0Hrz4TFWbnRF7X6Geah/CKkcOI5gb3/+kZdhrD/Hq
   mm2uodbDGHdZ3V6u+06qDfJSYFVTt+sML8NViQqeWYVeuZt7Yl2v/gjzg
   atBpPDUKvnwtio4eMiQ5/Kj9k9YWXj1fkEaMfjPJXHDYIkkeoXEnbVGMl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="397877021"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="397877021"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 03:45:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="639991303"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="639991303"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 11 Nov 2022 03:45:05 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1otST1-00Ag3K-38;
        Fri, 11 Nov 2022 13:45:03 +0200
Date:   Fri, 11 Nov 2022 13:45:03 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] gpiolib: of: Use correct fwnode for DT-probed chips
Message-ID: <Y241vwu47PbjrbBQ@smile.fi.intel.com>
References: <20221111113732.461881-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111113732.461881-1-thierry.reding@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 12:37:32PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The OF node store in chip->fwnode is used to explicitly override the FW
> node for a GPIO chip. For chips that use the default FW node (i.e. that
> of their parent device), this will be NULL and cause the chip not to be
> fully registered.
> 
> Instead, use the GPIO device's FW node, which is set to either the node
> of the parent device or the explicit override in chip->fwnode.

Thank you!

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

P.S.
It's good we have this report, which means I have to reconsider the
followup I'm cooking. In any case I will send it after v6.2-rc1 for
broader testing.

> Fixes: 8afe82550240 ("gpiolib: of: Prepare of_gpiochip_add() / of_gpiochip_remove() for fwnode")
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/gpio/gpiolib-of.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index 4be3c21aa718..55c3712592db 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -1067,7 +1067,7 @@ int of_gpiochip_add(struct gpio_chip *chip)
>  	struct device_node *np;
>  	int ret;
>  
> -	np = to_of_node(chip->fwnode);
> +	np = to_of_node(dev_fwnode(&chip->gpiodev->dev));
>  	if (!np)
>  		return 0;
>  
> -- 
> 2.38.1
> 

-- 
With Best Regards,
Andy Shevchenko


