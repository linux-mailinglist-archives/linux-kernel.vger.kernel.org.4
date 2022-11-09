Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F33622BB8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 13:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiKIMi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 07:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiKIMis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 07:38:48 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1217A45E;
        Wed,  9 Nov 2022 04:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667997526; x=1699533526;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=FRYAq5727Iy9j6OJKIbRQ5zEbSV8w9gZip6U3Jp63Fk=;
  b=SJNXMZ5BGXUD6LG8YSWlXon/DnL8TxUWBroWWgvJ7IiCwZw4az2xYzqq
   ekmOT0OYtz3FcwQZpBbbPAV0TyD1Ov189wJzQ8iKFNm3HZxpJ9K5PC/qZ
   CPbeRUeaWGqyjUXa57IiYsNMJe5XsK5VF+vgMXYbGgoubihAQ7mzSgfKk
   reTALT+kVKPTCnLYc1+Wp0wWWSagj7iRsBqblOEZM8Awy987MHEJ6uuUp
   ho3mjrYQftUrMLY9rPBT7i+/bH09X/boa26c+s2edONmPqyFcE/pUL5yt
   FEJWlcTUslrUKHR8QfqBXJsaXUEj+Ff4Sh/rL6sKlKbvFxEyj68XJV7/+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="397257847"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="397257847"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 04:38:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="631238228"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="631238228"
Received: from jsanche3-mobl1.ger.corp.intel.com ([10.251.219.48])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 04:38:44 -0800
Date:   Wed, 9 Nov 2022 14:38:38 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Sherry Sun <sherry.sun@nxp.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-imx@nxp.com
Subject: Re: [PATCH 2/2] tty: serial: fsl_lpuart: Add runtime pm support
In-Reply-To: <20221109105659.17381-3-sherry.sun@nxp.com>
Message-ID: <50752c1b-fea-af8b-6efd-ef0cd594cb@linux.intel.com>
References: <20221109105659.17381-1-sherry.sun@nxp.com> <20221109105659.17381-3-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Nov 2022, Sherry Sun wrote:

> Add runtime pm support to manage the lpuart clock.
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 60 +++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index 474943cb06b2..e678a7aaf7e4 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -19,6 +19,7 @@
>  #include <linux/of_device.h>
>  #include <linux/of_dma.h>
>  #include <linux/pinctrl/consumer.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/serial_core.h>
>  #include <linux/slab.h>
>  #include <linux/tty_flip.h>
> @@ -235,6 +236,7 @@
>  
>  /* Rx DMA timeout in ms, which is used to calculate Rx ring buffer size */
>  #define DMA_RX_TIMEOUT		(10)
> +#define UART_AUTOSUSPEND_TIMEOUT	3000
>  
>  #define DRIVER_NAME	"fsl-lpuart"
>  #define DEV_NAME	"ttyLP"
> @@ -795,6 +797,20 @@ static void lpuart32_start_tx(struct uart_port *port)
>  	}
>  }
>  
> +static void
> +lpuart_uart_pm(struct uart_port *port, unsigned int state, unsigned int oldstate)
> +{
> +	switch (state) {
> +	case UART_PM_STATE_OFF:
> +		pm_runtime_mark_last_busy(port->dev);
> +		pm_runtime_put_autosuspend(port->dev);
> +		break;
> +	default:
> +		pm_runtime_get_sync(port->dev);
> +		break;
> +	}
> +}
> +
>  /* return TIOCSER_TEMT when transmitter is not busy */
>  static unsigned int lpuart_tx_empty(struct uart_port *port)
>  {
> @@ -2243,6 +2259,7 @@ static const struct uart_ops lpuart_pops = {
>  	.startup	= lpuart_startup,
>  	.shutdown	= lpuart_shutdown,
>  	.set_termios	= lpuart_set_termios,
> +	.pm		= lpuart_uart_pm,
>  	.type		= lpuart_type,
>  	.request_port	= lpuart_request_port,
>  	.release_port	= lpuart_release_port,
> @@ -2267,6 +2284,7 @@ static const struct uart_ops lpuart32_pops = {
>  	.startup	= lpuart32_startup,
>  	.shutdown	= lpuart32_shutdown,
>  	.set_termios	= lpuart32_set_termios,
> +	.pm		= lpuart_uart_pm,
>  	.type		= lpuart_type,
>  	.request_port	= lpuart_request_port,
>  	.release_port	= lpuart_release_port,
> @@ -2747,6 +2765,11 @@ static int lpuart_probe(struct platform_device *pdev)
>  		handler = lpuart_int;
>  	}
>  
> +	pm_runtime_use_autosuspend(&pdev->dev);
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, UART_AUTOSUSPEND_TIMEOUT);
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +
>  	ret = lpuart_global_reset(sport);
>  	if (ret)
>  		goto failed_reset;
> @@ -2771,6 +2794,9 @@ static int lpuart_probe(struct platform_device *pdev)
>  failed_attach_port:
>  failed_get_rs485:
>  failed_reset:
> +	pm_runtime_disable(&pdev->dev);
> +	pm_runtime_set_suspended(&pdev->dev);
> +	pm_runtime_dont_use_autosuspend(&pdev->dev);
>  	lpuart_disable_clks(sport);
>  	return ret;
>  }
> @@ -2789,9 +2815,30 @@ static int lpuart_remove(struct platform_device *pdev)
>  	if (sport->dma_rx_chan)
>  		dma_release_channel(sport->dma_rx_chan);
>  
> +	pm_runtime_disable(&pdev->dev);
> +	pm_runtime_set_suspended(&pdev->dev);
> +	pm_runtime_dont_use_autosuspend(&pdev->dev);
>  	return 0;
>  }
>  
> +static int __maybe_unused lpuart_runtime_suspend(struct device *dev)

IIRC, the PM_OPS macros contain special logic to make __maybe_unused 
unnecessary for these functions.

-- 
 i.


> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct lpuart_port *sport = platform_get_drvdata(pdev);
> +
> +	lpuart_disable_clks(sport);
> +
> +	return 0;
> +};
> +
> +static int __maybe_unused lpuart_runtime_resume(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct lpuart_port *sport = platform_get_drvdata(pdev);
> +
> +	return lpuart_enable_clks(sport);
> +};
> +
>  static void serial_lpuart_enable_wakeup(struct lpuart_port *sport, bool on)
>  {
>  	unsigned int val, baud;
> @@ -2937,6 +2984,10 @@ static int __maybe_unused lpuart_suspend(struct device *dev)
>  			sport->dma_tx_in_progress = false;
>  			dmaengine_terminate_all(sport->dma_tx_chan);
>  		}
> +	} else if (pm_runtime_active(sport->port.dev)) {
> +		lpuart_disable_clks(sport);
> +		pm_runtime_disable(sport->port.dev);
> +		pm_runtime_set_suspended(sport->port.dev);
>  	}
>  
>  	return 0;
> @@ -2971,12 +3022,19 @@ static void lpuart_console_fixup(struct lpuart_port *sport)
>  static int __maybe_unused lpuart_resume(struct device *dev)
>  {
>  	struct lpuart_port *sport = dev_get_drvdata(dev);
> +	int ret;
>  
>  	if (lpuart_uport_is_active(sport)) {
>  		if (lpuart_is_32(sport))
>  			lpuart32_hw_setup(sport);
>  		else
>  			lpuart_hw_setup(sport);
> +	} else if (pm_runtime_active(sport->port.dev)) {
> +		ret = lpuart_enable_clks(sport);
> +		if (ret)
> +			return ret;
> +		pm_runtime_set_active(sport->port.dev);
> +		pm_runtime_enable(sport->port.dev);
>  	}
>  
>  	lpuart_console_fixup(sport);
> @@ -2986,6 +3044,8 @@ static int __maybe_unused lpuart_resume(struct device *dev)
>  }
>  
>  static const struct dev_pm_ops lpuart_pm_ops = {
> +	SET_RUNTIME_PM_OPS(lpuart_runtime_suspend,
> +			   lpuart_runtime_resume, NULL)
>  	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(lpuart_suspend_noirq,
>  				      lpuart_resume_noirq)
>  	SET_SYSTEM_SLEEP_PM_OPS(lpuart_suspend, lpuart_resume)
> 

