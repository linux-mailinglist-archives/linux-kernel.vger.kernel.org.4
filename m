Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F145A6AE6E2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjCGQkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbjCGQjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:39:47 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE659008E;
        Tue,  7 Mar 2023 08:37:11 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id bj30so10057817oib.6;
        Tue, 07 Mar 2023 08:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678207031;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q2JOb5kKOMDRqeX2vxiCKA6VX8yh3XwjyP2TdsrpV1U=;
        b=ISov41jyE0UedvwU6BAdypa9ab8UOuHF5640Xa2s7Z8Fa5ernDpCYhFkBvT0QpHrJO
         IoRDfp+3fi6XxqdkyK1RmOEEXX1wAzKpsWe2p9l5hXRdk73bIERSy+E8VjxluXIieCVj
         /kdmPgG062giu2hD2T0P57PyfW+ViFJM38h+1Tu5DEYRC1RTP4UAOlfFQ1gtxxQqs5vh
         ufZuRnQJ7IQN3bysFqVoWu9tUFjYPUxkeUp9imfyBGg8n3w4un+QLW1Get9LSGbGiZ6N
         20O1dcpz4P3iwQ55fkQapiRGxusvqrBjx9HEJkfTOIU3WD6tIDwOG3J8vqiAR9n5dU4J
         Xt1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678207031;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q2JOb5kKOMDRqeX2vxiCKA6VX8yh3XwjyP2TdsrpV1U=;
        b=8GA2YFPerVr5Ds1pMNjSqmTbYOQ2dDQQHHKCDHNIU8fogSaHLmoyICSwOpovQAXdJi
         iwvTgEldE9zm9YR6zGmSVzUAswO1WDJoXEcEl+ZEQLVaOVWV0+1+zK+e1ZwCZJeG3Zo4
         HKTPNj8YEKyxxcNCkd4TE5Zs92tClkM35uw/Po9Ncjz8lWH8LTWx5hnEhwhNXbGJuV4W
         Y7YJg2kmrvQoX8mkqeoR+EKTaPR1sc+4QWLpg6CTdyDQ3u99hnUi0DQwYgsUCIldwhXd
         dhVED3ilK+faxd4XcehIJMCJ8AhTcW7c8R6hmsE1NGjaUh68u9Y6GvvEGK3e1ZHB2FiP
         Oe/Q==
X-Gm-Message-State: AO0yUKVcBG2PKVNhP+9dKlUGAbyFetc2bukQQCW94mPfV3OLi/8EFEYO
        MQLh7/nc7qIhEwzcSDZeZU/RAoTfM14=
X-Google-Smtp-Source: AK7set98rKmyRdQp98boe/MffPQvNxuQmk5G3hOBz765iI8kUdckoS1xH6cl+dG3KlSLTtrohmwBRQ==
X-Received: by 2002:a05:6808:197:b0:384:311d:5664 with SMTP id w23-20020a056808019700b00384311d5664mr6411425oic.23.1678207030876;
        Tue, 07 Mar 2023 08:37:10 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h19-20020a056808015300b00384926684b8sm5204703oie.13.2023.03.07.08.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 08:37:10 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 7 Mar 2023 08:37:08 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 1/2] watchdog: s3c2410: Make
 s3c2410_get_wdt_drv_data() return an int
Message-ID: <84ba9412-d7f7-4102-93b0-372d4a5a06a0@roeck-us.net>
References: <20230307065603.2253054-1-u.kleine-koenig@pengutronix.de>
 <20230307065603.2253054-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230307065603.2253054-2-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 07:56:02AM +0100, Uwe Kleine-König wrote:
> This is a preparation for making more use of dev_err_probe(). The idea
> is that s3c2410_get_wdt_drv_data() (as it's called only by .probe()) can
> make effective use of dev_err_probe() only if it returns an int. For
> that the assignment to wdt->drv_data has to happen in the function. The
> caller can then just pass on the return value in the error case.
> 
> This seems to be nicer for the compiler: bloatometer reports for an
> ARCH=arm s3c6400_defconfig build:
> 
> 	add/remove: 1/1 grow/shrink: 0/1 up/down: 4/-64 (-60)
> 	Function                                     old     new   delta
> 	__initcall__kmod_s3c2410_wdt__209_821_s3c2410wdt_driver_init6       -       4      +4
> 	__initcall__kmod_s3c2410_wdt__209_819_s3c2410wdt_driver_init6       4       -      -4
> 	s3c2410wdt_probe                            1332    1272     -60
> 
> There is no semantical change. (Just one minor difference: Before this
> patch wdt->drv_data was always assigned, now that only happens in the
> non-error case. That doesn't matter however as *wdt is freed in the
> error case.)
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/s3c2410_wdt.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
> index 58b262ca4e88..f3de8ef499c3 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -579,8 +579,8 @@ static inline unsigned int s3c2410wdt_get_bootstatus(struct s3c2410_wdt *wdt)
>  	return 0;
>  }
>  
> -static inline const struct s3c2410_wdt_variant *
> -s3c2410_get_wdt_drv_data(struct platform_device *pdev)
> +static inline int
> +s3c2410_get_wdt_drv_data(struct platform_device *pdev, struct s3c2410_wdt *wdt)
>  {
>  	const struct s3c2410_wdt_variant *variant;
>  	struct device *dev = &pdev->dev;
> @@ -603,24 +603,26 @@ s3c2410_get_wdt_drv_data(struct platform_device *pdev)
>  					   "samsung,cluster-index", &index);
>  		if (err) {
>  			dev_err(dev, "failed to get cluster index\n");
> -			return NULL;
> +			return -EINVAL;
>  		}
>  
>  		switch (index) {
>  		case 0:
> -			return variant;
> +			break;
>  		case 1:
> -			return (variant == &drv_data_exynos850_cl0) ?
> +			variant = (variant == &drv_data_exynos850_cl0) ?
>  				&drv_data_exynos850_cl1 :
>  				&drv_data_exynosautov9_cl1;
> +			break;
>  		default:
>  			dev_err(dev, "wrong cluster index: %u\n", index);
> -			return NULL;
> +			return -EINVAL;
>  		}
>  	}
>  #endif
>  
> -	return variant;
> +	wdt->drv_data = variant;
> +	return 0;
>  }
>  
>  static void s3c2410wdt_wdt_disable_action(void *data)
> @@ -644,9 +646,9 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
>  	spin_lock_init(&wdt->lock);
>  	wdt->wdt_device = s3c2410_wdd;
>  
> -	wdt->drv_data = s3c2410_get_wdt_drv_data(pdev);
> -	if (!wdt->drv_data)
> -		return -EINVAL;
> +	ret = s3c2410_get_wdt_drv_data(pdev, wdt);
> +	if (ret)
> +		return ret;
>  
>  	if (wdt->drv_data->quirks & QUIRKS_HAVE_PMUREG) {
>  		wdt->pmureg = syscon_regmap_lookup_by_phandle(dev->of_node,
> -- 
> 2.39.1
> 
