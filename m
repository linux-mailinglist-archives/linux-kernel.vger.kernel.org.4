Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E28A62358C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbiKIVNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiKIVNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:13:46 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519995F90;
        Wed,  9 Nov 2022 13:13:46 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id q71so17262813pgq.8;
        Wed, 09 Nov 2022 13:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iDJQ6peS3kiEHrvFFH44FB8U+od29bkIu8vgabHG7n4=;
        b=ETDd++HS3hzTcmXRYL5ZepSjhBm/OtSfyHcB8P3+7A0Qvl4qD58ttVf/ySBrzqULzJ
         go5D8WUqkMoMdsgHSvUm0sMi07kJkZm2VLADbzn/MYVA4tdUETh3wqpEXCFQclCWsall
         /oW9GeG0c6xvm/nT6A2d/ksd0tvN22Vj8mEp/QPftCs4rWFVAUJLKy6Q/c8WdJniWUX6
         DnpjHj2jutPhxYvj4n5MLiApmqx9cPxti0KVIJh86XJrknds6sIR9Yr5T67pSCcLvLGJ
         dXRlJGrXCwnYIS4q9ybwg58FJwEEQEdgGPvTrfwstc46flLgHmjpAdPHOR313xmRITP5
         bApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDJQ6peS3kiEHrvFFH44FB8U+od29bkIu8vgabHG7n4=;
        b=RNBJVfavjEVeiMf334UATjSL+rDpjhlxFEbFLO41L4rXChs0mbNidupE48QhZGxZkX
         XxZyu3JdiIuKMmL3yNCKrQO2dYN5SbIj+ns4xueqWwFVxX0dDA0xtEEmb7w8p81qvl5o
         6mMF2CQghuWyIuDXaveETqCe8d/wecS0QTc/t5qMuSLiYS7iHntSolYEuciYMzSQg24l
         hV1qWFgpuFAqpPaUR2ErffEcUWuYbhdB2F30SOfshwnt63hMsnA0Z2resz2KsIYOGAyX
         v5vwJEf0IhEB4cda2LkbX6vnVUsxJ2bv4+B7Q58zxTAJ3Yc5hd1AIrwKKbRh9KjxJX86
         kPlQ==
X-Gm-Message-State: ACrzQf1JZEy5T1NWQfQPhtRQxi+6g+5cWVrh1FfM6paSsORrQi4FZwxK
        iKUw+l2kg/qjs6JGjoYCB6M=
X-Google-Smtp-Source: AMsMyM61jXzcJ+PnQBCAsIhkLIw76d+8COwedof/RrTyNDVIBgyU9Dg3RNjJwSKTgOicpqHou+6UsQ==
X-Received: by 2002:a63:914a:0:b0:46f:7e1c:6584 with SMTP id l71-20020a63914a000000b0046f7e1c6584mr52488405pge.562.1668028425616;
        Wed, 09 Nov 2022 13:13:45 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:6af4:9e55:5482:c0de])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902654400b00176c0e055f8sm9529732pln.64.2022.11.09.13.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 13:13:44 -0800 (PST)
Date:   Wed, 9 Nov 2022 13:13:42 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 2/2] gpiolib: of: Drop redundant check in
 of_mm_gpiochip_remove()
Message-ID: <Y2wYBoA+bkIlXyg3@google.com>
References: <20221109150734.38874-1-andriy.shevchenko@linux.intel.com>
 <20221109150734.38874-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109150734.38874-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 05:07:34PM +0200, Andy Shevchenko wrote:
> The callers never call the function with invalid pointer.
> Moreover, compiler quite likely dropped that check anyway
> because we use that pointer before the check.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  drivers/gpio/gpiolib-of.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index feeb9e8e846d..83997434215e 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -963,9 +963,6 @@ void of_mm_gpiochip_remove(struct of_mm_gpio_chip *mm_gc)
>  {
>  	struct gpio_chip *gc = &mm_gc->gc;
>  
> -	if (!mm_gc)
> -		return;
> -
>  	gpiochip_remove(gc);
>  	iounmap(mm_gc->regs);
>  	kfree(gc->label);
> -- 
> 2.35.1
> 

-- 
Dmitry
