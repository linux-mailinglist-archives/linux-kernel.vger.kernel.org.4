Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A03729D43
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241574AbjFIOsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjFIOst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:48:49 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC9FE4A;
        Fri,  9 Jun 2023 07:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686322128; x=1717858128;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ag00HG+ddswN+udiIqMmON7qLqhMn08h14uJjkj3G3s=;
  b=XErKzVgvqtAKH/+T5Ch/vrxX1QcNdExvtYv/i2ASlvUHvLxQPUI+MQGB
   G4DqLtpvQEwBzg6bdQg8wqolLHwecKT40X4Bo6ugEhGjgRWINs4mASlXX
   eQNOuFkJfC9D7DAi4xoo7IMH25/aeAUdfzrH2ZBIazt+mkdx1vM3TFtSv
   Lx6fyWTv9Pgkf7YQiWgtBj/wlKIqmIpwPRjw6vFXNK5xFh/3zT3yfxruh
   EQ9ex7BqNlpE1WUvpOa8JzjZPqUJmNAQkRD1rrMnBAG0WjmPmob4t0R0A
   3hcABYRRz0xZ8xnGyGA4gdmhFaa1k5Meu3Q5l+mndOUnPSC834jQN2Pmy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="337246758"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="337246758"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 07:48:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="884610182"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="884610182"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 09 Jun 2023 07:48:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q7dPt-002QIA-11;
        Fri, 09 Jun 2023 17:48:41 +0300
Date:   Fri, 9 Jun 2023 17:48:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Helge Deller <deller@gmx.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        James Hilliard <james.hilliard1@gmail.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v4 2/2] serial: 8250: Apply FSL workarounds also without
 SERIAL_8250_CONSOLE
Message-ID: <ZIM7yRIFiVDgx4/q@smile.fi.intel.com>
References: <20230609133932.786117-1-u.kleine-koenig@pengutronix.de>
 <20230609133932.786117-3-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230609133932.786117-3-u.kleine-koenig@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 03:39:32PM +0200, Uwe Kleine-König wrote:
> The need to handle the FSL variant of 8250 in a special way is also
> present without console support. So soften the dependency for
> SERIAL_8250_FSL from SERIAL_8250_CONSOLE to SERIAL_8250. To handle
> SERIAL_8250=m, the FSL code can be modular, too, thus SERIAL_8250_FSL
> becomes tristate.
> 
> Compiling 8250_fsl as a module requires adding a module license so this
> is added, too. While add it also add a appropriate module description.
> 
> As then SERIAL_OF_PLATFORM=y + SERIAL_8250_FSL=m is a valid combination
> (if COMPILE_TEST is enabled on a platform that is neither PPC, ARM nor
> ARM64), the check in 8250_of.c must be weakened a bit.

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
thank you for fixing this!

> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/tty/serial/8250/8250_fsl.c | 3 +++
>  drivers/tty/serial/8250/8250_of.c  | 2 +-
>  drivers/tty/serial/8250/Kconfig    | 6 +++---
>  3 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8250_fsl.c
> index 00f46b9a8b09..6af4e1c1210a 100644
> --- a/drivers/tty/serial/8250/8250_fsl.c
> +++ b/drivers/tty/serial/8250/8250_fsl.c
> @@ -184,3 +184,6 @@ static struct platform_driver fsl8250_platform_driver = {
>  
>  module_platform_driver(fsl8250_platform_driver);
>  #endif
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Handling of Freescale specific 8250 variants");
> diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
> index c9f6bd7a7038..51329625c48a 100644
> --- a/drivers/tty/serial/8250/8250_of.c
> +++ b/drivers/tty/serial/8250/8250_of.c
> @@ -177,7 +177,7 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
>  		break;
>  	}
>  
> -	if (IS_ENABLED(CONFIG_SERIAL_8250_FSL) &&
> +	if (IS_REACHABLE(CONFIG_SERIAL_8250_FSL) &&
>  	    (of_device_is_compatible(np, "fsl,ns16550") ||
>  	     of_device_is_compatible(np, "fsl,16550-FIFO64"))) {
>  		port->handle_irq = fsl8250_handle_irq;
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index cf33e858b0be..ee17cf5c44c6 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -379,9 +379,9 @@ config SERIAL_8250_BCM2835AUX
>  	  If unsure, say N.
>  
>  config SERIAL_8250_FSL
> -	bool "Freescale 16550 UART support" if COMPILE_TEST && !(PPC || ARM || ARM64)
> -	depends on SERIAL_8250_CONSOLE
> -	default PPC || ARM || ARM64
> +	tristate "Freescale 16550 UART support" if COMPILE_TEST && !(PPC || ARM || ARM64)
> +	depends on SERIAL_8250
> +	default SERIAL_8250 if PPC || ARM || ARM64
>  	help
>  	  Selecting this option enables a workaround for a break-detection
>  	  erratum for Freescale 16550 UARTs in the 8250 driver. It also
> -- 
> 2.39.2
> 

-- 
With Best Regards,
Andy Shevchenko


