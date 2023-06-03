Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C053B72128E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 22:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjFCUNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 16:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjFCUNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 16:13:06 -0400
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE1810C0
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 13:12:45 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTP
        id e97ac4d9-024a-11ee-a9de-005056bdf889;
        Sat, 03 Jun 2023 23:12:06 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Sat, 3 Jun 2023 23:12:06 +0300
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 16/43] pwm: ep93xx: add DT support for Cirrus EP93xx
Message-ID: <ZHuelv6mZFhYXpPm@surfacebook>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601053546.9574-17-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601053546.9574-17-nikita.shubin@maquefel.me>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Jun 01, 2023 at 08:34:07AM +0300, Nikita Shubin kirjoitti:
> - find register range from the device tree

> - provide clock access via of

Not sure what does this supose to mean. Copy'n'paste mistake?

Please, revisit commit messages in *all* your patches.
With this addressed, for this patch
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
> 
> Notes:
>     v0 -> v1:
>     
>     - fixed headers
>     - fixed id table
> 
>  drivers/pwm/pwm-ep93xx.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-ep93xx.c b/drivers/pwm/pwm-ep93xx.c
> index c45a75e65c86..361984ef4c0b 100644
> --- a/drivers/pwm/pwm-ep93xx.c
> +++ b/drivers/pwm/pwm-ep93xx.c
> @@ -17,6 +17,7 @@
>   */
>  
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/clk.h>
> @@ -190,9 +191,16 @@ static int ep93xx_pwm_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct of_device_id ep93xx_pwm_of_ids[] = {
> +	{ .compatible = "cirrus,ep9301-pwm" },
> +	{ /* sentinel */}
> +};
> +MODULE_DEVICE_TABLE(of, ep93xx_pwm_of_ids);
> +
>  static struct platform_driver ep93xx_pwm_driver = {
>  	.driver = {
>  		.name = "ep93xx-pwm",
> +		.of_match_table = ep93xx_pwm_of_ids,
>  	},
>  	.probe = ep93xx_pwm_probe,
>  };
> -- 
> 2.37.4
> 

-- 
With Best Regards,
Andy Shevchenko


