Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A086ACEFF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 21:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjCFURo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 15:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCFURm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 15:17:42 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200802CC74;
        Mon,  6 Mar 2023 12:17:42 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-17671fb717cso11243583fac.8;
        Mon, 06 Mar 2023 12:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678133861;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=H6iNhP+WryT/rObff/l5NG10IiCzongLQj2pyPqmaqY=;
        b=lk26gdv5IgDCYF6vy0dIOeLDlURNdXe+ITlwixDFs8SJQ+CdgEx/xSBLU7iEqb2wjA
         kG0NN2S7xNHKSdpXUG3d8wKL/SOKxe5OLcU+wr/zBOulugmgZecQK5q4xjVMy1H8Ugv1
         xlOeN+iau/jlvYn85MCA+BX9m39KlbC3uvxPRs39C7gSxRs3b4C8igSB+1++xJ48UAu2
         Mx2OjfKgq4UAcLt+NAM/tfV9cg89g6amUSi1PETnGvl+KyqJB22Zn7t6XloIaj6L6dRX
         /o0LDDHiwqaQZKIsqGH5pa6Q0k1LoC9UVnW9hkdUg2gSEe57mb4eFO5YHcIhFpTnLwUA
         0cbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678133861;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H6iNhP+WryT/rObff/l5NG10IiCzongLQj2pyPqmaqY=;
        b=fwCDzZFHEOoq8vSQavdTaLAbgYsNfSQdlNHDKV/JPZqUbuel4X/ezfElJghIUmBLoa
         ymTGiTdMF+N8Uspti5BlcB3mDW19nfVaRPsNyaBox3quCeKQQmGZkg2TDJu4OxGgtJEN
         S8PKl0b0rEK/q/cbFI2KZetH0ImM7Di9AVH0Ufa3CuDpgowA3Z+mKS3uDoJW8Ld4gp+C
         cVsndnHL8qmDPjJu+w4UlOhyhiPQjfNBmfmWWXmebbmoHIgZrkagS54IBwmC/MZpRnxX
         aVMGYKPU6b9DvrOtuF7WMbE835CJ6FEANpNB5iUSlBqbAJF0dalsBuQYzqKKmbY5zQqF
         fyfw==
X-Gm-Message-State: AO0yUKXVYmlx1soWcQdOFh6E22XdCOW8QrdP/VALUI/DfrwZEwyHBk74
        JEiQi0rjDm+qHwZa28rjtiaMpWjReHs=
X-Google-Smtp-Source: AK7set+3/KytYsX3vJySSeyTX8gx9ImJGr+bLzayBgrhwNp8DixB8bExuqOqadNTM3u+8H8343A5lw==
X-Received: by 2002:a05:6870:8193:b0:176:2420:d09b with SMTP id k19-20020a056870819300b001762420d09bmr8250629oae.53.1678133861475;
        Mon, 06 Mar 2023 12:17:41 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id dw48-20020a056870773000b001765b2f6c53sm4332260oab.9.2023.03.06.12.17.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 12:17:40 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ea4bcac7-e78d-d051-21fe-1014d39cd52a@roeck-us.net>
Date:   Mon, 6 Mar 2023 12:17:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/3] watchdog: bcm47xx: Simplify using
 devm_watchdog_register_device()
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
References: <20230306170901.2232323-1-u.kleine-koenig@pengutronix.de>
 <20230306170901.2232323-2-u.kleine-koenig@pengutronix.de>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230306170901.2232323-2-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/23 09:08, Uwe Kleine-König wrote:
> This allows to drop the .remove() function as it only exists to
> unregister the watchdog device which is now done in a callback
> registered by devm_watchdog_register_device().
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/watchdog/bcm47xx_wdt.c | 12 +-----------
>   1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/watchdog/bcm47xx_wdt.c b/drivers/watchdog/bcm47xx_wdt.c
> index 05425c1dfd4c..8698ef94dddf 100644
> --- a/drivers/watchdog/bcm47xx_wdt.c
> +++ b/drivers/watchdog/bcm47xx_wdt.c
> @@ -202,7 +202,7 @@ static int bcm47xx_wdt_probe(struct platform_device *pdev)
>   	watchdog_set_restart_priority(&wdt->wdd, 64);
>   	watchdog_stop_on_reboot(&wdt->wdd);
>   
> -	ret = watchdog_register_device(&wdt->wdd);
> +	ret = devm_watchdog_register_device(&wdt->wdd);

Oops, all those need &pdev->dev as first argument. Please resend with that fixed.

Thanks,
Guenter

>   	if (ret)
>   		goto err_timer;
>   
> @@ -218,21 +218,11 @@ static int bcm47xx_wdt_probe(struct platform_device *pdev)
>   	return ret;
>   }
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
>   static struct platform_driver bcm47xx_wdt_driver = {
>   	.driver		= {
>   		.name	= "bcm47xx-wdt",
>   	},
>   	.probe		= bcm47xx_wdt_probe,
> -	.remove		= bcm47xx_wdt_remove,
>   };
>   
>   module_platform_driver(bcm47xx_wdt_driver);

