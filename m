Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0EC6ACA96
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjCFReV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjCFReR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:34:17 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D1547417;
        Mon,  6 Mar 2023 09:33:28 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-17671fb717cso10683271fac.8;
        Mon, 06 Mar 2023 09:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678123886;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GI1EgHIOtlBLUeCcar5f/nKm4Ohv4KoqJIyioLv7Plw=;
        b=bs67hZom2A5C+RBJixeEP8/kGS74ZxBt/uzt1ow+rvzGVPuh52yc2vjS9UYD2dNHaw
         pRY4mLdJgW4Emq7HwPyPwQ1hLH/+DXo9l+nD0MUrBd+lD4FYD95cFyr08BSLV/jgN+As
         REHmISvm7W4dLl6UbNWkB0Bdo5uKHj5TdY3VwR7EidhBJN2IgbWvRZYWD93Ynm0UtaX0
         tKCKs7L05WIV2QNoBwBsFzTiSKez7fAHQ/vDJUv7qH/ZJsi6RSvBSxnCppkpGOJz+OFD
         ou2enfiC2VFRHvU847bDKoFbT3ZRtFE+iWXKpQpyIW03QDJut0n17pGPKHvojyOgThq/
         /Rlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678123886;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GI1EgHIOtlBLUeCcar5f/nKm4Ohv4KoqJIyioLv7Plw=;
        b=35OmJgIyl2nARe1O8QXkDxzaNGAKgb4MUS+cY0/7OxKdTVDeAEGg5UgnHIFC1aoS5P
         TzalxQJ3TeNDGdKajJP9Vcd4PHCUiFh9KbQDlN8fInfc9lGNedvRLtDmUjCrDM2rETNa
         3ZO1vMLiLizTMwhZVoIMWZZT/tsFlEnV4bofO66PQ2dKc4CRBYvkiq+dbHpaDtZIN2PP
         mi9dd1Kq0Pgqxfi5runoNORp2ANQ7Jo3R8uC9OElxcmpsrK7klgL8q+Q7fBe7jin9H8+
         ZCwjGoQMctumpyb8ZLctUWAF2LV6ifkoAaFOxkSMfHyRaVPE3h33oW0TaLswU8qDKuOf
         rcaQ==
X-Gm-Message-State: AO0yUKXgQt7RXrl2Qm53RfwjFXfU4NIzOSdBZ/eTcF6Kxe0sJQL7rOa7
        0py1a8lTlPALxwrPIfGElWg=
X-Google-Smtp-Source: AK7set/OA1jz5f4e9DGjALJv/VYkdpvhhLitri/pqlbDkEx3wl75SQvhysK5esFweGTkygnPnv7mNg==
X-Received: by 2002:a05:6870:5250:b0:16e:800:9e05 with SMTP id o16-20020a056870525000b0016e08009e05mr8800530oai.12.1678123885984;
        Mon, 06 Mar 2023 09:31:25 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s27-20020a05683004db00b00684c5211c58sm4325456otd.60.2023.03.06.09.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 09:31:25 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 6 Mar 2023 09:31:24 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        patches@opensource.cirrus.com, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 3/3] watchdog: wm8350: Simplify using
 devm_watchdog_register_device()
Message-ID: <84cd135f-118e-4c61-8a80-0cd93159d106@roeck-us.net>
References: <20230306170901.2232323-1-u.kleine-koenig@pengutronix.de>
 <20230306170901.2232323-4-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230306170901.2232323-4-u.kleine-koenig@pengutronix.de>
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

On Mon, Mar 06, 2023 at 06:09:01PM +0100, Uwe Kleine-König wrote:
> This allows to drop the .remove() function as it only exists to
> unregister the watchdog device which is now done in a callback
> registered by devm_watchdog_register_device().
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/wm8350_wdt.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/watchdog/wm8350_wdt.c b/drivers/watchdog/wm8350_wdt.c
> index 33c62d51f00a..911ad64460a6 100644
> --- a/drivers/watchdog/wm8350_wdt.c
> +++ b/drivers/watchdog/wm8350_wdt.c
> @@ -153,18 +153,11 @@ static int wm8350_wdt_probe(struct platform_device *pdev)
>  	/* Default to 4s timeout */
>  	wm8350_wdt_set_timeout(&wm8350_wdt, 4);
>  
> -	return watchdog_register_device(&wm8350_wdt);
> -}
> -
> -static int wm8350_wdt_remove(struct platform_device *pdev)
> -{
> -	watchdog_unregister_device(&wm8350_wdt);
> -	return 0;
> +	return devm_watchdog_register_device(&wm8350_wdt);
>  }
>  
>  static struct platform_driver wm8350_wdt_driver = {
>  	.probe = wm8350_wdt_probe,
> -	.remove = wm8350_wdt_remove,
>  	.driver = {
>  		.name = "wm8350-wdt",
>  	},
> -- 
> 2.39.1
> 
