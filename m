Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD6A67BA01
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 19:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235642AbjAYS7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 13:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235373AbjAYS7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 13:59:08 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A286C156;
        Wed, 25 Jan 2023 10:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674673146; x=1706209146;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i/dG9BPNtmvD1DBHyErBH0kW0J5xRIeSnjq4ULQtyhk=;
  b=cimyNrmgHuhL3/0EGsFG56Dbul/yUouinFPK3w4BcERAN7qAjLXl/IZJ
   fEmXRUR6ncCz3fu+D5NpOT+4qXkxLThYyQSPetc+eEThvK09pRfVLLBie
   T31dfuYg4DKkpED5O8GIsAwDk8zuIrgcUqi9xFYQmorCN5m5DEJJs1nJo
   5FktAYwg4lJtMmdha9ribLiUx3s3ycs7IPlUASsRa4oPy6WlpRS46voXK
   1AwKbik4OrbS5N+aRxLbuqUvNLQ1pLX5NByH0I+wYBktAR2Wf4UTfPv80
   /uLjZ5UQCcCN3KQ9qXOc6F5k9E1aFnInWvgqeNJ7Gytjq0pFf6Y7O9bvv
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="324346664"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="324346664"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 10:59:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="662588896"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="662588896"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 25 Jan 2023 10:59:02 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pKkz6-00F2PQ-2N;
        Wed, 25 Jan 2023 20:59:00 +0200
Date:   Wed, 25 Jan 2023 20:59:00 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Pierluigi Passaro <pierluigi.p@variscite.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        yamada.masahiro@socionext.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, sfr@canb.auug.org.au,
        eran.m@variscite.com, nate.d@variscite.com,
        francesco.f@variscite.com, pierluigi.passaro@gmail.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3] gpiolib: fix linker errors when GPIOLIB is disabled
Message-ID: <Y9F79GvU1a+CjmLr@smile.fi.intel.com>
References: <20230124013138.358595-1-pierluigi.p@variscite.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124013138.358595-1-pierluigi.p@variscite.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 02:31:38AM +0100, Pierluigi Passaro wrote:
> Both the functions gpiochip_request_own_desc and
> gpiochip_free_own_desc are exported from
>     drivers/gpio/gpiolib.c
> but this file is compiled only when CONFIG_GPIOLIB is enabled.
> Move the prototypes under "#ifdef CONFIG_GPIOLIB" and provide
> reasonable definitions and includes in the "#else" branch.

So far as a quick fix I can agree on the change with a caveat that inclusion
hell should be untangled in the future.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

P.S. The root cause of this problem is that some drivers without being GPIO chips
abuse this API. Better fix can be to go through each of such drivers and add ugly
ifdeffery with a FIXME comment that this shouldn't be actually used to begin with.

> Fixes: 9091373ab7ea ("gpio: remove less important #ifdef around declarations")
> Signed-off-by: Pierluigi Passaro <pierluigi.p@variscite.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
> Changes in v2:
> - add Fixes tag
> Changes in v3:
> - add includes to fix builds against x86_64-defconfig
> 
>  include/linux/gpio/driver.h | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
> index 44783fc16125..e00eaba724dc 100644
> --- a/include/linux/gpio/driver.h
> +++ b/include/linux/gpio/driver.h
> @@ -758,6 +758,8 @@ gpiochip_remove_pin_ranges(struct gpio_chip *gc)
>  
>  #endif /* CONFIG_PINCTRL */
>  
> +#ifdef CONFIG_GPIOLIB
> +
>  struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *gc,
>  					    unsigned int hwnum,
>  					    const char *label,
> @@ -765,8 +767,6 @@ struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *gc,
>  					    enum gpiod_flags dflags);
>  void gpiochip_free_own_desc(struct gpio_desc *desc);
>  
> -#ifdef CONFIG_GPIOLIB
> -
>  /* lock/unlock as IRQ */
>  int gpiochip_lock_as_irq(struct gpio_chip *gc, unsigned int offset);
>  void gpiochip_unlock_as_irq(struct gpio_chip *gc, unsigned int offset);
> @@ -776,6 +776,25 @@ struct gpio_chip *gpiod_to_chip(const struct gpio_desc *desc);
>  
>  #else /* CONFIG_GPIOLIB */
>  
> +#include <linux/gpio/machine.h>
> +#include <linux/gpio/consumer.h>
> +
> +static inline struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *gc,
> +					    unsigned int hwnum,
> +					    const char *label,
> +					    enum gpio_lookup_flags lflags,
> +					    enum gpiod_flags dflags)
> +{
> +	/* GPIO can never have been requested */
> +	WARN_ON(1);
> +	return ERR_PTR(-ENODEV);
> +}
> +
> +static inline void gpiochip_free_own_desc(struct gpio_desc *desc)
> +{
> +	WARN_ON(1);
> +}
> +
>  static inline struct gpio_chip *gpiod_to_chip(const struct gpio_desc *desc)
>  {
>  	/* GPIO can never have been requested */
> -- 
> 2.34.1
> 
> 

-- 
With Best Regards,
Andy Shevchenko


