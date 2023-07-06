Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FA1749D2F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjGFNSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjGFNSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:18:10 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3708B1992;
        Thu,  6 Jul 2023 06:18:09 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-c5c8d00ced3so693272276.2;
        Thu, 06 Jul 2023 06:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688649488; x=1691241488;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Cgf43GhwD7b0csu2mfmmYfiuYsfy6eO/8hxUqbvqUJ4=;
        b=cMZFJB67wJDTRGG5QdoThR4MqF/I7e2w3zLRKyOAfDmVQw2liAOGwy7h3lQxm38tK1
         ZvcySuBmyORycZYLesYh74Pk/CBOm8MOKYAnfHtn+OXbv16l7fJJ2HVqM77NjVEnUa4m
         QfxqP1Jr/Cr7flT7cK8S6Dhfv9bIpzqCyKtZ4vUrkIFI1u6mZI7nriFRZklMHmo/kcAD
         28evqx94OXRXSweCYO/tIZLPugWilFzmXBQuTo3F4wj4wp72HQGFDx6yQcNDSo5Y1HEw
         ALCEZ6BafX5qvtdAFPv5RItZ2MEakqG99qXbNy7/CNSPS1f5NX1oBj3FTKCr4Fsgn2au
         P31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688649488; x=1691241488;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cgf43GhwD7b0csu2mfmmYfiuYsfy6eO/8hxUqbvqUJ4=;
        b=D5sZkS9yH04astUAfeE1p1GgT/kVM0VKWA2LS2hIF7MYHX4m5ZK2N1Q3JIZsJeXQtS
         o9ayqQPQztMZDAgUA+Y3uDgyeD6d0fzu1x2+LNVSeQi8ft4tTwJuQ1z35DtFBtwhbRHY
         I39UIt3+MN3t6fE6u0WOE/lvSWr5GpCdUAtt90OfpIrL1dhq00gKdHRQXhkZ+QYEFt+S
         PgkMYlBe7CAz+FAB+NDsNJM7v88X/uiL0gn6YTGbvySH7ZCwrCReUkE4w7mmWX4vUsDo
         74EnNftwlqdwWLKDFxXJFfPLPlnxxJqh0BYIBSleqwogLoTpiwxcZZ54pP5wY1D2Vg71
         lRnw==
X-Gm-Message-State: ABy/qLY7y+FixeIAyA39ElXUdRup5gsnzjPMO+9N+4a/PjzMMqPAuGZf
        lqDyUqeu8nt316G1Gp5is+N/z3l57zg=
X-Google-Smtp-Source: APBJJlFUDHEL5TcZ5ngPGylwaqkir988G2+TX7Jlrtnxz1bzhCimKfyywmT7eJeoCZUz27mOF/6RZw==
X-Received: by 2002:a25:b7ca:0:b0:bca:7da8:e37c with SMTP id u10-20020a25b7ca000000b00bca7da8e37cmr1768953ybj.15.1688649488224;
        Thu, 06 Jul 2023 06:18:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b8-20020a5b0088000000b00c6135ffd2fcsm308177ybp.15.2023.07.06.06.18.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 06:18:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <02b9ec14-bf69-ce61-4bd5-cac05563b855@roeck-us.net>
Date:   Thu, 6 Jul 2023 06:18:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] watchdog: starfive: Remove #ifdef guards for PM related
 functions
Content-Language: en-US
To:     Paul Cercueil <paul@crapouillou.net>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        Samin Guo <samin.guo@starfivetech.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230706082928.10869-1-paul@crapouillou.net>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230706082928.10869-1-paul@crapouillou.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/23 01:29, Paul Cercueil wrote:
> Use the new PM macros for the suspend and resume functions to be
> automatically dropped by the compiler when CONFIG_PM or
> CONFIG_PM_SLEEP are disabled, without having to use #ifdef guards.
> 
> This has the advantage of always compiling these functions in,
> independently of any Kconfig option. Thanks to that, bugs and other
> regressions are subsequently easier to catch.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/starfive-wdt.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
> index 8058fca4d05d..7c8a1c5e75be 100644
> --- a/drivers/watchdog/starfive-wdt.c
> +++ b/drivers/watchdog/starfive-wdt.c
> @@ -526,7 +526,6 @@ static void starfive_wdt_shutdown(struct platform_device *pdev)
>   	starfive_wdt_pm_stop(&wdt->wdd);
>   }
>   
> -#ifdef CONFIG_PM_SLEEP
>   static int starfive_wdt_suspend(struct device *dev)
>   {
>   	struct starfive_wdt *wdt = dev_get_drvdata(dev);
> @@ -556,9 +555,7 @@ static int starfive_wdt_resume(struct device *dev)
>   
>   	return starfive_wdt_start(wdt);
>   }
> -#endif /* CONFIG_PM_SLEEP */
>   
> -#ifdef CONFIG_PM
>   static int starfive_wdt_runtime_suspend(struct device *dev)
>   {
>   	struct starfive_wdt *wdt = dev_get_drvdata(dev);
> @@ -574,11 +571,10 @@ static int starfive_wdt_runtime_resume(struct device *dev)
>   
>   	return starfive_wdt_enable_clock(wdt);
>   }
> -#endif /* CONFIG_PM */
>   
>   static const struct dev_pm_ops starfive_wdt_pm_ops = {
> -	SET_RUNTIME_PM_OPS(starfive_wdt_runtime_suspend, starfive_wdt_runtime_resume, NULL)
> -	SET_SYSTEM_SLEEP_PM_OPS(starfive_wdt_suspend, starfive_wdt_resume)
> +	RUNTIME_PM_OPS(starfive_wdt_runtime_suspend, starfive_wdt_runtime_resume, NULL)
> +	SYSTEM_SLEEP_PM_OPS(starfive_wdt_suspend, starfive_wdt_resume)
>   };
>   
>   static const struct of_device_id starfive_wdt_match[] = {
> @@ -594,7 +590,7 @@ static struct platform_driver starfive_wdt_driver = {
>   	.shutdown = starfive_wdt_shutdown,
>   	.driver = {
>   		.name = "starfive-wdt",
> -		.pm = &starfive_wdt_pm_ops,
> +		.pm = pm_ptr(&starfive_wdt_pm_ops),
>   		.of_match_table = starfive_wdt_match,
>   	},
>   };

