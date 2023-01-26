Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C4A67CC8C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjAZNqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjAZNqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:46:31 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FD53C2C;
        Thu, 26 Jan 2023 05:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674740789; x=1706276789;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vrS30aIV2IHHyAksZ/6zJl0RtGur8hynqjqn0BJeecU=;
  b=I867bbOPTP6+tc71LUYe1Sz7xkb1l8pFHrW56tx9J23Cowx9gKi46EdQ
   eW2r4hQKpwXiSGOduUHWFk7whkWbcLfwgecVvcC1Qgzq5Jb4VrL5nX/nI
   Hd8MsWHUvM9YVuDxOyIw54DqAQ/gvf/dHjfxAbxxIrFj51xAeI0qyO9ka
   uYIWN2/2dNE/pY75L6N13pP7sHBsWCD/4mPmigj7iEnwCwudPk0l2frOy
   fYrAUaJMLt2ilRd2+uZ6KtmdiMJQg68RliRRg8l1XDxpq91+LP+4dYJ83
   MH2xb1hXoqZ4Bkxr5g2Ni4zsRE76nPoZqnvpamleNUu5IDYtKIoY5b7PL
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="307159279"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="307159279"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 05:46:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="693337328"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="693337328"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 26 Jan 2023 05:46:25 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pL2a8-00FQB8-0A;
        Thu, 26 Jan 2023 15:46:24 +0200
Date:   Thu, 26 Jan 2023 15:46:23 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-gpio@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] gpiolib: remove asm-generic/gpio.h
Message-ID: <Y9KELwugMhV1TCiK@smile.fi.intel.com>
References: <20230126132801.2042371-1-arnd@kernel.org>
 <20230126132801.2042371-4-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126132801.2042371-4-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 02:27:56PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The asm-generic/gpio.h file is now always included when
> using gpiolib, so just move its contents into linux/gpio.h
> with a few minor simplifications.

Thanks! Very appreciated, my comments below.

...

> --- a/drivers/gpio/gpio-davinci.c
> +++ b/drivers/gpio/gpio-davinci.c
> @@ -7,6 +7,7 @@
>   */

>  #include <linux/gpio/driver.h>


> +#include <linux/gpio.h>

I believe the driver does not need this.

I have briefly checked all gpio_ places in it and found nothing that requires
this inclusion to be done.

>  #include <linux/errno.h>
>  #include <linux/kernel.h>
>  #include <linux/clk.h>
> @@ -24,8 +25,6 @@
>  #include <linux/spinlock.h>
>  #include <linux/pm_runtime.h>
>  
> -#include <asm-generic/gpio.h>
> -
>  #define MAX_REGS_BANKS 5
>  #define MAX_INT_PER_BANK 32

Thanks for this, that was a PITA!

...

> --- a/drivers/pinctrl/core.c
> +++ b/drivers/pinctrl/core.c
> @@ -30,7 +30,7 @@
>  
>  #ifdef CONFIG_GPIOLIB
>  #include "../gpio/gpiolib.h"
> -#include <asm-generic/gpio.h>
> +#include <linux/gpio.h>

Can we actually swap them?

#include <linux/gpio.h>
#include "../gpio/gpiolib.h"

But hold on, why do we even need gpio.h here?!

>  #endif
>  
>  #include "core.h"

...

> --- a/include/linux/gpio.h
> +++ b/include/linux/gpio.h
> @@ -54,26 +54,101 @@ struct gpio {
>  };
>  
>  #ifdef CONFIG_GPIOLIB
> -#include <asm-generic/gpio.h>
> +#include <linux/compiler.h>

> +#include <linux/gpio/driver.h>
> +#include <linux/gpio/consumer.h>

#include <linux/gpio/consumer.h>
#include <linux/gpio/driver.h>

...

> +/*
> + * "valid" GPIO numbers are nonnegative and may be passed to
> + * setup routines like gpio_request().  only some valid numbers

While at it, '.  only' --> '. Only'.

> + * can successfully be requested and used.
> + *
> + * Invalid GPIO numbers are useful for indicating no-such-GPIO in
> + * platform data and other tables.
> + */

...

> +extern int gpio_request(unsigned gpio, const char *label);
> +extern void gpio_free(unsigned gpio);

While at it, s/extern//.

...

> +extern int gpio_request_one(unsigned gpio, unsigned long flags, const char *label);
> +extern int gpio_request_array(const struct gpio *array, size_t num);
> +extern void gpio_free_array(const struct gpio *array, size_t num);

Ditto.

-- 
With Best Regards,
Andy Shevchenko


