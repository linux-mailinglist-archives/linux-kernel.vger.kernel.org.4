Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6F167CD4C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjAZOLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjAZOLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:11:19 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6DE3432B;
        Thu, 26 Jan 2023 06:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674742269; x=1706278269;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rt5JED4B0lDAC0xTSiVfXAJO+KOtICciC2D0CC8o56w=;
  b=g1a0j2gjGouxlisJ1uBOeP1WJMkUaWJmWUS8PyKe3Nc1KY2O6Yy5ADAC
   f5v/Y79yrId8mtX0AzOLDpLS+ndEvUZV1vzYEFBIF/rQuiPscVndMWTtu
   FSKX9B0qyCa7F1/0Rnr8NyaKqig0GoCzEHw9WIg8kZMPLjbqlfa4Fb5ON
   I/REdfAwOFn5Bj8bRTWRc2mGrj20xH8K5632mlFVK1Yir8BVZ/n4qeGoY
   yBvCSqZs4UpogIDGUZSzk/iFwcIQ8Cbwt820JuUhCPGByIg4xjG3kEV+b
   xLxciAgMc/tIPCYnChpoILp8vQ8doIiv2aEXrMlF+3C6AZS70LVMX+9pJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="310405017"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="310405017"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 06:04:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="693339569"
X-IronPort-AV: E=Sophos;i="5.97,248,1669104000"; 
   d="scan'208";a="693339569"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 26 Jan 2023 06:04:43 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pL2rp-00FQhI-2A;
        Thu, 26 Jan 2023 16:04:41 +0200
Date:   Thu, 26 Jan 2023 16:04:41 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-gpio@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] gpiolib: split linux/gpio/driver.h out of
 linux/gpio.h
Message-ID: <Y9KIeXq866C+VKV+@smile.fi.intel.com>
References: <20230126132801.2042371-1-arnd@kernel.org>
 <20230126132801.2042371-7-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126132801.2042371-7-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 02:27:59PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Almost all gpio drivers include linux/gpio/driver.h, and other
> files should not rely on includes from this header.
> 
> Remove the indirect include from here and include the correct
> headers directly from where they are used.

Some minor nit-picks below, otherwise
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-omap1/irq.c                              | 1 +
>  arch/arm/mach-orion5x/board-rd88f5182.c                | 1 +
>  arch/arm/mach-s3c/s3c64xx.c                            | 1 +
>  arch/arm/mach-sa1100/assabet.c                         | 1 +
>  arch/arm/plat-orion/gpio.c                             | 1 +
>  drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c | 1 +
>  include/linux/gpio.h                                   | 2 --
>  include/linux/mfd/ucb1x00.h                            | 1 +
>  8 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/irq.c b/arch/arm/mach-omap1/irq.c
> index 9ccc784fd614..bfc7ab010ae2 100644
> --- a/arch/arm/mach-omap1/irq.c
> +++ b/arch/arm/mach-omap1/irq.c
> @@ -41,6 +41,7 @@
>  #include <linux/sched.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> +#include <linux/irqdomain.h>
>  
>  #include <asm/irq.h>
>  #include <asm/exception.h>
> diff --git a/arch/arm/mach-orion5x/board-rd88f5182.c b/arch/arm/mach-orion5x/board-rd88f5182.c
> index 596601367989..1c14e49a90a6 100644
> --- a/arch/arm/mach-orion5x/board-rd88f5182.c
> +++ b/arch/arm/mach-orion5x/board-rd88f5182.c
> @@ -9,6 +9,7 @@
>  #include <linux/gpio.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pci.h>
>  #include <linux/irq.h>
> diff --git a/arch/arm/mach-s3c/s3c64xx.c b/arch/arm/mach-s3c/s3c64xx.c
> index c20163e6a8b4..c5aa4d8ed8bd 100644
> --- a/arch/arm/mach-s3c/s3c64xx.c
> +++ b/arch/arm/mach-s3c/s3c64xx.c
> @@ -24,6 +24,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/reboot.h>
>  #include <linux/io.h>

> +#include <linux/of.h>

Taking the limited context into account, I think this makes more sense to be
placed before platform_device.h as to keep longer _sorted_ chain.

>  #include <linux/clk/samsung.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/irq.h>
> diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
> index 04f8a1680bc1..06e7b1358226 100644
> --- a/arch/arm/mach-sa1100/assabet.c
> +++ b/arch/arm/mach-sa1100/assabet.c
> @@ -12,6 +12,7 @@
>  #include <linux/errno.h>
>  #include <linux/gpio/gpio-reg.h>
>  #include <linux/gpio/machine.h>
> +#include <linux/gpio/driver.h>

Similar. Keep it more sorted.

>  #include <linux/gpio_keys.h>
>  #include <linux/ioport.h>
>  #include <linux/platform_data/sa11x0-serial.h>
> diff --git a/arch/arm/plat-orion/gpio.c b/arch/arm/plat-orion/gpio.c
> index 3ef9ecdd6343..4946d8066f6a 100644
> --- a/arch/arm/plat-orion/gpio.c
> +++ b/arch/arm/plat-orion/gpio.c
> @@ -19,6 +19,7 @@
>  #include <linux/bitops.h>
>  #include <linux/io.h>
>  #include <linux/gpio.h>
> +#include <linux/gpio/driver.h>
>  #include <linux/leds.h>
>  #include <linux/of.h>
>  #include <linux/of_irq.h>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
> index 9540a05247c2..89c8829528c2 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/led.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <net/mac80211.h>
>  #include <linux/bcma/bcma_driver_chipcommon.h>
> +#include <linux/gpio.h>
>  #include <linux/gpio/driver.h>
>  #include <linux/gpio/machine.h>
>  #include <linux/gpio/consumer.h>
> diff --git a/include/linux/gpio.h b/include/linux/gpio.h
> index 57ec3975b656..06a33339994e 100644
> --- a/include/linux/gpio.h
> +++ b/include/linux/gpio.h
> @@ -54,8 +54,6 @@ struct gpio {
>  };
>  
>  #ifdef CONFIG_GPIOLIB
> -#include <linux/compiler.h>
> -#include <linux/gpio/driver.h>
>  #include <linux/gpio/consumer.h>
>  
>  /*
> diff --git a/include/linux/mfd/ucb1x00.h b/include/linux/mfd/ucb1x00.h
> index 9aed2797d3d5..2e65354fc7b8 100644
> --- a/include/linux/mfd/ucb1x00.h
> +++ b/include/linux/mfd/ucb1x00.h
> @@ -9,6 +9,7 @@
>  
>  #include <linux/device.h>
>  #include <linux/mfd/mcp.h>

> +#include <linux/gpio/driver.h>
>  #include <linux/gpio.h>

Here is the opposite ordering to the above similar cases. Swap?

>  #include <linux/mutex.h>
>  
> -- 
> 2.39.0
> 

-- 
With Best Regards,
Andy Shevchenko


