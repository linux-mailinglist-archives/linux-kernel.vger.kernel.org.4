Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20C16871CC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 00:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjBAXTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 18:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjBAXTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 18:19:38 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BDD1EFCB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 15:19:37 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 7so110786pga.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 15:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UfvfdYoklJloAro8ZE+SRmZ2YsAYATSVu+Qj+tuYXzs=;
        b=ndoZUIiiXWibJX2FI3qUcRHP9YcXJd3NDudb2WUoXWuvbltA3Ox2R7fcgJIg2rgSWB
         C4HtH9soZJG4frvEWKXm61nj0xe8Qrz7qBMV9k/DZsQb4go6lyojJhqNYiPj211zca5o
         BMKNteONR293rcXzYN5HKQPV58Ke4WUud+StdtLyuKqeriV9ZSQQPfCX/3zQKt76Mp6o
         hvcu5ZrnVpstxJ/h0Ns3wrXJcBP3LKy4EbBYEqWYk1miTpLjyVOXq2fh+XD8Bl58+34U
         GJ24GI8dk26Dm/DUphHrG3VIDsfVw5u812C/8X/BBX4WD7gtLVFJB8SOYLcF335lMBPc
         J6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UfvfdYoklJloAro8ZE+SRmZ2YsAYATSVu+Qj+tuYXzs=;
        b=Yrk+lz1W8mcKFXR/nn9FijU25XVZLmGcl0kRW3M1II7Q6+DrHOqyzbfMk2QFXc9QhX
         q6jUZUY4b7zWP2pfudT4D75TU/fPRyNA9/ETtG2VIDWjXvRLpL8+1ZeOrZ1EJL2H0bLu
         6cB51QckC140+x6hVuortrS1B9vgfxYrzJiSsf2+NMZ0E8LepbzOpotrr8pQg8yqncTO
         /ViGoVSPGRBggebne6qWIHnNV9im1pBtYGp2K6/0NP7GBap3dfCIBnAZ25RHkDh+OjMp
         T4J3AyK2GrdBEcs/DeOZJMcPL8o7/G8Gk8R/ypjOoMM3d9ZCnH5dltd68rOikyN+NnMb
         pBoA==
X-Gm-Message-State: AO0yUKWgVZTqHbefmtYuczYC+pGstunHZq32TCQw5AxGMECkjUb5KPp3
        JvK3aTdjOZyN8H1MrkjJnDIc/A==
X-Google-Smtp-Source: AK7set9inbJv/M/vfdju8z207Qoxp12XibCyhHzDRAcGnrVUKe0FvFj3EQzothiblU4uGo1rVlTICQ==
X-Received: by 2002:a62:b41a:0:b0:593:d7fd:aaf7 with SMTP id h26-20020a62b41a000000b00593d7fdaaf7mr413693pfn.16.1675293576923;
        Wed, 01 Feb 2023 15:19:36 -0800 (PST)
Received: from google.com ([2620:15c:2d1:203:341e:6979:102e:c9d9])
        by smtp.gmail.com with ESMTPSA id t26-20020aa7947a000000b0058bbe1240easm349789pfq.190.2023.02.01.15.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 15:19:36 -0800 (PST)
Date:   Wed, 1 Feb 2023 15:19:31 -0800
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Robin Murphy <robin.murphy@arm.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] gpu: host1x: fix uninitialized variable use
Message-ID: <Y9rzg9Mizckjf+Fp@google.com>
References: <20230127221418.2522612-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127221418.2522612-1-arnd@kernel.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 11:14:00PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The error handling for platform_get_irq() failing no longer
> works after a recent change, clang now points this out with
> a warning:
> 
> drivers/gpu/host1x/dev.c:520:6: error: variable 'syncpt_irq' is uninitialized when used here [-Werror,-Wuninitialized]
>         if (syncpt_irq < 0)
>             ^~~~~~~~~~
> 
> Fix this by removing the variable and checking the correct
> error status.
> 
> Fixes: 625d4ffb438c ("gpu: host1x: Rewrite syncpoint interrupt handling")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks Arnd, I saw some reports from kernelci about this, too.
https://lore.kernel.org/linux-next/?q=warning%3A+variable+%27syncpt_irq%27+is+uninitialized+when+used+here

Reported-by: "kernelci.org bot" <bot@kernelci.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/gpu/host1x/dev.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
> index 4872d183d860..aae2efeef503 100644
> --- a/drivers/gpu/host1x/dev.c
> +++ b/drivers/gpu/host1x/dev.c
> @@ -487,7 +487,6 @@ static int host1x_get_resets(struct host1x *host)
>  static int host1x_probe(struct platform_device *pdev)
>  {
>  	struct host1x *host;
> -	int syncpt_irq;
>  	int err;
>  
>  	host = devm_kzalloc(&pdev->dev, sizeof(*host), GFP_KERNEL);
> @@ -517,8 +516,8 @@ static int host1x_probe(struct platform_device *pdev)
>  	}
>  
>  	host->syncpt_irq = platform_get_irq(pdev, 0);
> -	if (syncpt_irq < 0)
> -		return syncpt_irq;
> +	if (host->syncpt_irq < 0)
> +		return host->syncpt_irq;
>  
>  	mutex_init(&host->devices_lock);
>  	INIT_LIST_HEAD(&host->devices);
> -- 
> 2.39.0
> 
> 
