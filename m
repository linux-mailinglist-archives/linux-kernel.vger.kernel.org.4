Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D9E721290
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 22:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjFCUNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 16:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjFCUNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 16:13:40 -0400
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77ECAE51
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 13:13:31 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id 1ad3b39f-024b-11ee-b972-005056bdfda7;
        Sat, 03 Jun 2023 23:13:29 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Sat, 3 Jun 2023 23:13:29 +0300
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 11/43] rtc: ep93xx: add DT support for Cirrus EP93xx
Message-ID: <ZHue6U8rzlcVko6w@surfacebook>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601053546.9574-12-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601053546.9574-12-nikita.shubin@maquefel.me>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Jun 01, 2023 at 08:34:02AM +0300, Nikita Shubin kirjoitti:
> - Find register range from the device tree.

It would be nice to be consistent with the commit messages of the same
semantics.

Nevertheless, LGTM,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
> 
> Notes:
>     v0 -> v1:
>     
>     - fixed headers
> 
>  drivers/rtc/rtc-ep93xx.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-ep93xx.c b/drivers/rtc/rtc-ep93xx.c
> index acae7f16808f..1fdd20d01560 100644
> --- a/drivers/rtc/rtc-ep93xx.c
> +++ b/drivers/rtc/rtc-ep93xx.c
> @@ -7,6 +7,7 @@
>   */
>  
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/rtc.h>
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
> @@ -148,9 +149,16 @@ static int ep93xx_rtc_probe(struct platform_device *pdev)
>  	return devm_rtc_register_device(ep93xx_rtc->rtc);
>  }
>  
> +static const struct of_device_id ep93xx_rtc_of_ids[] = {
> +	{ .compatible = "cirrus,ep9301-rtc" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, ep93xx_rtc_of_ids);
> +
>  static struct platform_driver ep93xx_rtc_driver = {
>  	.driver		= {
>  		.name	= "ep93xx-rtc",
> +		.of_match_table = ep93xx_rtc_of_ids,
>  	},
>  	.probe		= ep93xx_rtc_probe,
>  };
> -- 
> 2.37.4
> 

-- 
With Best Regards,
Andy Shevchenko


