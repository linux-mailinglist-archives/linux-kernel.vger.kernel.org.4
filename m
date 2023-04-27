Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178D16F03A5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 11:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243326AbjD0JsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 05:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243388AbjD0JsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 05:48:13 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC5219A7;
        Thu, 27 Apr 2023 02:48:12 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso8090887a12.1;
        Thu, 27 Apr 2023 02:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682588891; x=1685180891;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=QbQDNFKjRytgCf+GesubNivdLWJXmKPSqFAAYcRK3AU=;
        b=AokQBJv1jf3ffsFZoWvwqevvIA6UtN78MIdTc1+F0ptj6kFitLPxjXUANZuG/fIgN2
         mWUnwT8WfY4Fab346smHbQ9R0Gz2Z7IalvJz2yRHrK4TlXoZNoVnSLlogL6Af3dBtEFg
         XFQY89ZGDKOfptCjyCPeNVJ8UqaWxeLDqrMN4HOWUPATaHiLQLPaS25U/1hyvawW6eIE
         9ulOackMZec3qoNHrmcKhEJ87eIFvRuEVv6drhhIB3vtj3o0rP2btQH118vEAgseszWv
         LPcrxnr/34Ns0IWiO90i4XJ5SbVmntk6MW7j42Gh7kDOuXFpvEJlu/jJTKRo9tMcW9ad
         VjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682588891; x=1685180891;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QbQDNFKjRytgCf+GesubNivdLWJXmKPSqFAAYcRK3AU=;
        b=ijy+ErXbMzB7mAiB+cnQuF0M3/v4PCjNYbI1ELmQt8VdvoaaXi2qWP/pRIH0pDQWuM
         zvrewqgFEeJFclwFoJAoXywrZ+5KPIoLOFvLtJ6CEuOun7DZHIJ4bQ3cSxy2LMHlJkZa
         O+M2TvDCto1YG1w2xiyQTIX1c4JmOiZjyTTORPb4cKg4SISn2w6tzOmFBpkIqFXVXi2W
         5md1K0Maxpt5UYCTffnlMT0jXjHIaV5ny4F6A1cT5au/hVtcZcz0nxEEOgHDzO0CF53H
         hqe0hx4f213Q4HvkvcIntyrzgIzGfHP2h05QkHT/AbtWD2WDZuK3ena1A8P/hRaF73uJ
         LP2A==
X-Gm-Message-State: AC+VfDzVwnRWj6FNrwu20QXGuABLQDAyQNl3WTVOPThADqOKYcZnn/5o
        j3+CVIaW6vvv5Gvj3YKnLB0PPq7wZbo=
X-Google-Smtp-Source: ACHHUZ4GaJ07HzHqmE3PHX/g78eaeGH2Dx0oA60Ib406Jcb95vkZS13uCUS+Y+SgmQl3I7mF8gctUQ==
X-Received: by 2002:a17:903:280e:b0:1a9:93fd:e853 with SMTP id kp14-20020a170903280e00b001a993fde853mr816565plb.19.1682588891201;
        Thu, 27 Apr 2023 02:48:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w14-20020a1709029a8e00b00183c6784704sm11290958plp.291.2023.04.27.02.48.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 02:48:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <fd96b2d6-69df-01e0-9784-5dfaddd28711@roeck-us.net>
Date:   Thu, 27 Apr 2023 02:48:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1] watchdog: starfive: Fix the warning of
 starfive_wdt_match
Content-Language: en-US
To:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        linux-watchdog@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Samin Guo <samin.guo@starfivetech.com>,
        linux-kernel@vger.kernel.org
References: <20230427074400.55380-1-xingyu.wu@starfivetech.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230427074400.55380-1-xingyu.wu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/23 00:44, Xingyu Wu wrote:
> Drop the function of of_match_ptr() to fix the warning of unused variable
> 'starfive_wdt_match'.
> 
> Fixes: db728ea9c7be ("drivers: watchdog: Add StarFive Watchdog driver")
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> 
> Hi, Guenter and Wim,
> 
> This patch fixes the compiler warning of StarFive watchdog driver and
> rebases on the master branch of linux-next.
> 
> Thanks.
> 
> ---
>   drivers/watchdog/starfive-wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
> index 1995cceca51e..64d1ad4d267a 100644
> --- a/drivers/watchdog/starfive-wdt.c
> +++ b/drivers/watchdog/starfive-wdt.c
> @@ -595,7 +595,7 @@ static struct platform_driver starfive_wdt_driver = {
>   	.driver = {
>   		.name = "starfive-wdt",
>   		.pm = &starfive_wdt_pm_ops,
> -		.of_match_table = of_match_ptr(starfive_wdt_match),
> +		.of_match_table = starfive_wdt_match,
>   	},
>   };
>   module_platform_driver(starfive_wdt_driver);

