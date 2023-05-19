Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F53708F8B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 07:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjESFoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 01:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjESFog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 01:44:36 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3B0F10C9;
        Thu, 18 May 2023 22:44:33 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 027F980F7;
        Fri, 19 May 2023 05:44:33 +0000 (UTC)
Date:   Fri, 19 May 2023 08:44:31 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] serial: 8250: omap: convert to modern PM ops
Message-ID: <20230519054431.GV14287@atomide.com>
References: <20230517202012.634386-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517202012.634386-1-arnd@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Arnd Bergmann <arnd@kernel.org> [230517 20:20]:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The new uart_write() function is only called from suspend/resume code, causing
> a build warning when those are left out:
> 
> drivers/tty/serial/8250/8250_omap.c:169:13: error: 'uart_write' defined but not used [-Werror=unused-function]
> 
> Remove the #ifdefs and use the modern pm_ops/pm_sleep_ops and their wrappers
> to let the compiler see where it's used but still drop the dead code.

This looks good to me as an alternative for Geert's fix. If Geert's
fix gets applied first, this needs to be rabased.

Reviewed-by: Tony Lindgren <tony@atomide.com>


> Fixes: 398cecc24846 ("serial: 8250: omap: Fix imprecise external abort for omap_8250_pm()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/tty/serial/8250/8250_omap.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index 5c093dfcee1d..00b2c35042ee 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -1571,7 +1571,6 @@ static int omap8250_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
>  static int omap8250_prepare(struct device *dev)
>  {
>  	struct omap8250_priv *priv = dev_get_drvdata(dev);
> @@ -1616,12 +1615,7 @@ static int omap8250_resume(struct device *dev)
>  	serial8250_resume_port(priv->line);
>  	return 0;
>  }
> -#else
> -#define omap8250_prepare NULL
> -#define omap8250_complete NULL
> -#endif
>  
> -#ifdef CONFIG_PM
>  static int omap8250_lost_context(struct uart_8250_port *up)
>  {
>  	u32 val;
> @@ -1738,7 +1732,6 @@ static int omap8250_runtime_resume(struct device *dev)
>  	schedule_work(&priv->qos_work);
>  	return 0;
>  }
> -#endif
>  
>  #ifdef CONFIG_SERIAL_8250_OMAP_TTYO_FIXUP
>  static int __init omap8250_console_fixup(void)
> @@ -1781,17 +1774,17 @@ console_initcall(omap8250_console_fixup);
>  #endif
>  
>  static const struct dev_pm_ops omap8250_dev_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(omap8250_suspend, omap8250_resume)
> -	SET_RUNTIME_PM_OPS(omap8250_runtime_suspend,
> +	SYSTEM_SLEEP_PM_OPS(omap8250_suspend, omap8250_resume)
> +	RUNTIME_PM_OPS(omap8250_runtime_suspend,
>  			   omap8250_runtime_resume, NULL)
> -	.prepare        = omap8250_prepare,
> -	.complete       = omap8250_complete,
> +	.prepare        = pm_sleep_ptr(omap8250_prepare),
> +	.complete       = pm_sleep_ptr(omap8250_complete),
>  };
>  
>  static struct platform_driver omap8250_platform_driver = {
>  	.driver = {
>  		.name		= "omap8250",
> -		.pm		= &omap8250_dev_pm_ops,
> +		.pm		= pm_ptr(&omap8250_dev_pm_ops),
>  		.of_match_table = omap8250_dt_ids,
>  	},
>  	.probe			= omap8250_probe,
> -- 
> 2.39.2
> 
