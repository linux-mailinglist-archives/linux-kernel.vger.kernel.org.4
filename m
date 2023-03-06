Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFB66ACA8F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCFRdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjCFRdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:33:10 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CED67810;
        Mon,  6 Mar 2023 09:32:27 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1755e639b65so12226597fac.3;
        Mon, 06 Mar 2023 09:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678123860;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bpPySNrFktwfW3/lKaJBMls0+D8onD1cvgHfQEGhWIQ=;
        b=b4r2oVjSTG3SM/z+06gA4SQhWT6jHN1p1/nCGki+YyyIBxUOQZpaOOIawyrG+t6FmY
         CESUE7UoZT1ZHjezC3bJndNh26f8As67R6pV1uXXiozVXSyCGmzgfk6G2xhcMwRHRZ4w
         w90yuK8yF2zQtI3tEtrMhuI3OJ+Kb5cxsMOcvDfg+ay7dpdssJ2s0wdPv3kRcQ1QTN0J
         nohQKIFYwMQGme2LLUy2o4ZCzQadyd2qD/BGfTsZNNn14Rh2EExjk3dRei/nV+KAHcJF
         etAQLdsXa4KInlJuHt6y2xBGy4o7Fy5CLkmKc56rzpZZPZELxAK0k22HuukmpFCHcj23
         siHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678123860;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bpPySNrFktwfW3/lKaJBMls0+D8onD1cvgHfQEGhWIQ=;
        b=adDjoY6U5NiwS/levYIw/n1GumjCCLpXbjdpzjKsIHrSy4z7KulceUqpDHssO76DDJ
         HWYl0qXydeeaXWM9OZyPwhdAJ22gN8Dzy9hj9GqR6GrbrT954Y6MdCVhdSgjFQFNzcma
         tOTKnktBDeJh6edSyz/45ImzxUJipJblY/VSlw6j6r2mYeQps5hdkjpfkutkJ5vyQhef
         qfcufsG1l2F/pOs5SIqjvP1t56Wg+FCbAL98lI3qK5qJBpmLmIbGt4+J92uody/7HoRm
         a+/ExZVYD3IBKuBSvBCQBdPGwuRXyc36XdnUKA6OpTv8atUubta+1nKlBEuCOCm2hZBZ
         +/Yw==
X-Gm-Message-State: AO0yUKUTiHGiVACKL6XjSZLjOsYCk6E2hQ5w+HtnBGcEm8pHpjH0yth8
        PEil3i8JH4cSX7fRdUrQdCcA0eyN9NU=
X-Google-Smtp-Source: AK7set+31MsgiIyY8tTNZLIwZ9wlA3EDyBnwTlnucdPW+Q43l4mkLh6p7JDzpWQ/LnlwT/q3qH+M6A==
X-Received: by 2002:a05:6870:4393:b0:144:3ed1:1ec2 with SMTP id r19-20020a056870439300b001443ed11ec2mr6998491oah.43.1678123860654;
        Mon, 06 Mar 2023 09:31:00 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b26-20020a9d479a000000b0068bcb44e7f5sm4329019otf.68.2023.03.06.09.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 09:31:00 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 6 Mar 2023 09:30:59 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 1/3] watchdog: bcm47xx: Simplify using
 devm_watchdog_register_device()
Message-ID: <459657e0-5351-451c-bd39-f8fb8dca6b51@roeck-us.net>
References: <20230306170901.2232323-1-u.kleine-koenig@pengutronix.de>
 <20230306170901.2232323-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230306170901.2232323-2-u.kleine-koenig@pengutronix.de>
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

On Mon, Mar 06, 2023 at 06:08:59PM +0100, Uwe Kleine-König wrote:
> This allows to drop the .remove() function as it only exists to
> unregister the watchdog device which is now done in a callback
> registered by devm_watchdog_register_device().
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/bcm47xx_wdt.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/watchdog/bcm47xx_wdt.c b/drivers/watchdog/bcm47xx_wdt.c
> index 05425c1dfd4c..8698ef94dddf 100644
> --- a/drivers/watchdog/bcm47xx_wdt.c
> +++ b/drivers/watchdog/bcm47xx_wdt.c
> @@ -202,7 +202,7 @@ static int bcm47xx_wdt_probe(struct platform_device *pdev)
>  	watchdog_set_restart_priority(&wdt->wdd, 64);
>  	watchdog_stop_on_reboot(&wdt->wdd);
>  
> -	ret = watchdog_register_device(&wdt->wdd);
> +	ret = devm_watchdog_register_device(&wdt->wdd);
>  	if (ret)
>  		goto err_timer;
>  
> @@ -218,21 +218,11 @@ static int bcm47xx_wdt_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int bcm47xx_wdt_remove(struct platform_device *pdev)
> -{
> -	struct bcm47xx_wdt *wdt = dev_get_platdata(&pdev->dev);
> -
> -	watchdog_unregister_device(&wdt->wdd);
> -
> -	return 0;
> -}
> -
>  static struct platform_driver bcm47xx_wdt_driver = {
>  	.driver		= {
>  		.name	= "bcm47xx-wdt",
>  	},
>  	.probe		= bcm47xx_wdt_probe,
> -	.remove		= bcm47xx_wdt_remove,
>  };
>  
>  module_platform_driver(bcm47xx_wdt_driver);
> -- 
> 2.39.1
> 
