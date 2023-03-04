Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C456AACC7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 22:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjCDVqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 16:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCDVqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 16:46:43 -0500
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18EE13D4C
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 13:46:41 -0800 (PST)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id YZi6peXMSbVeoYZi6pIK01; Sat, 04 Mar 2023 22:46:39 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 04 Mar 2023 22:46:39 +0100
X-ME-IP: 86.243.2.178
Message-ID: <93d115a2-702d-7d68-cd88-98f1c9f03f95@wanadoo.fr>
Date:   Sat, 4 Mar 2023 22:46:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] watchdog: s3c2410_wdt: Use Use
 devm_clk_get[_optional]_enabled() helpers
To:     Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <20230304165653.2179835-1-linux@roeck-us.net>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230304165653.2179835-1-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 04/03/2023 à 17:56, Guenter Roeck a écrit :
> The devm_clk_get[_optional]_enabled() helpers:
>      - call devm_clk_get[_optional]()
>      - call clk_prepare_enable() and register what is needed in order to
>        call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code and avoids the calls to clk_disable_unprepare().
> 
> While at it, use dev_err_probe consistently, and use its return value
> to return the error code.
> 
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>   drivers/watchdog/s3c2410_wdt.c | 45 +++++++---------------------------
>   1 file changed, 9 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
> index 200ba236a72e..a1fcb79b0b7c 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -661,35 +661,17 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
>   	if (IS_ERR(wdt->reg_base))
>   		return PTR_ERR(wdt->reg_base);
>   
> -	wdt->bus_clk = devm_clk_get(dev, "watchdog");
> -	if (IS_ERR(wdt->bus_clk)) {
> -		dev_err(dev, "failed to find bus clock\n");
> -		return PTR_ERR(wdt->bus_clk);
> -	}
> -
> -	ret = clk_prepare_enable(wdt->bus_clk);
> -	if (ret < 0) {
> -		dev_err(dev, "failed to enable bus clock\n");
> -		return ret;
> -	}
> +	wdt->bus_clk = devm_clk_get_enabled(dev, "watchdog");
> +	if (IS_ERR(wdt->bus_clk))
> +		return dev_err_probe(dev, PTR_ERR(wdt->bus_clk), "failed to get bus clock\n");
>   
>   	/*
>   	 * "watchdog_src" clock is optional; if it's not present -- just skip it
>   	 * and use "watchdog" clock as both bus and source clock.
>   	 */
> -	wdt->src_clk = devm_clk_get_optional(dev, "watchdog_src");
> -	if (IS_ERR(wdt->src_clk)) {
> -		dev_err_probe(dev, PTR_ERR(wdt->src_clk),
> -			      "failed to get source clock\n");
> -		ret = PTR_ERR(wdt->src_clk);
> -		goto err_bus_clk;
> -	}
> -
> -	ret = clk_prepare_enable(wdt->src_clk);
> -	if (ret) {
> -		dev_err(dev, "failed to enable source clock\n");
> -		goto err_bus_clk;
> -	}
> +	wdt->src_clk = devm_clk_get_optional_enabled(dev, "watchdog_src");
> +	if (IS_ERR(wdt->src_clk))
> +		return dev_err_probe(dev, PTR_ERR(wdt->src_clk), "failed to get source clock\n");
>   
>   	wdt->wdt_device.min_timeout = 1;
>   	wdt->wdt_device.max_timeout = s3c2410wdt_max_timeout(wdt);
> @@ -710,7 +692,7 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
>   				 S3C2410_WATCHDOG_DEFAULT_TIME);
>   		} else {
>   			dev_err(dev, "failed to use default timeout\n");
> -			goto err_src_clk;
> +			return ret;

Hi,

Nit: this also could be "return dev_err_probe()"

>   		}
>   	}
>   
> @@ -718,7 +700,7 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
>   			       pdev->name, pdev);
>   	if (ret != 0) {
>   		dev_err(dev, "failed to install irq (%d)\n", ret);
> -		goto err_src_clk;
> +		return ret;

Nit: this also could be "return dev_err_probe()"

CJ

>   	}
>   
>   	watchdog_set_nowayout(&wdt->wdt_device, nowayout);
> @@ -744,7 +726,7 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
>   
>   	ret = watchdog_register_device(&wdt->wdt_device);
>   	if (ret)
> -		goto err_src_clk;
> +		return ret;
>   
>   	ret = s3c2410wdt_enable(wdt, true);
>   	if (ret < 0)
> @@ -766,12 +748,6 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
>    err_unregister:
>   	watchdog_unregister_device(&wdt->wdt_device);
>   
> - err_src_clk:
> -	clk_disable_unprepare(wdt->src_clk);
> -
> - err_bus_clk:
> -	clk_disable_unprepare(wdt->bus_clk);
> -
>   	return ret;
>   }
>   
> @@ -786,9 +762,6 @@ static int s3c2410wdt_remove(struct platform_device *dev)
>   
>   	watchdog_unregister_device(&wdt->wdt_device);
>   
> -	clk_disable_unprepare(wdt->src_clk);
> -	clk_disable_unprepare(wdt->bus_clk);
> -
>   	return 0;
>   }
>   

