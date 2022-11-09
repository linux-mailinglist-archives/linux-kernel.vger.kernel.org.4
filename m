Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BCB6235A5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbiKIVTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiKIVTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:19:35 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D69BC02;
        Wed,  9 Nov 2022 13:19:34 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id v28so17852626pfi.12;
        Wed, 09 Nov 2022 13:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CDN2Kjk9sFP44u2icW4scvppHNpqfGQ8HN02CsgJWJc=;
        b=nOa4PjJDGPvcgGjEbHX25jixgJf6FfXTf0x1H7pLV89JmM44vhlD1YLtpbv8o2B/jI
         AuTmpdu0Q8Bmj8z/JbUK5sJ8X+3RjlZ2P7jQiVbvHxTVNpWJ/vyi0wJ4GDYK4UUo2cke
         9AIYhMh/hHmBjlW98/Bmcg1B2bzFuQbpX7/I8uih7j3sGjS7Pj+wwfexzCHHloCgL+Ya
         rwe++AoJ4ntSQTfu+WwbsTZMCsyrQsdHDvtfVbrVvdLnc1FXcE8lDL2z8JKUaxL7Ul4C
         65SwBOleUCpm+cnPfa3iS91kkeQXztraCR5C1n5b8EQaEEWCFWm210RWIh+JuAgyUO3G
         HWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDN2Kjk9sFP44u2icW4scvppHNpqfGQ8HN02CsgJWJc=;
        b=OteBx0zq7N51vAgLw9qxm8d8z45pN/SWAU758niTA2MutkQOZQ0RNDZhdPHY8THbD9
         pFjEwaLBZxbike2btaq2zz6hRwv/ZdfHhQQtDb/1RQzBni1r5piq2SaagSp4jhf4dfAz
         aLfKtkHENcGbodEeuZJHUbws3Gjag1R0AzNLdDV+SUF6rcCSuw0ZTA4Uc2ADzFAe2Y6v
         uLGmgthF3hxn3ZUvCBQscrCjYd3PTEO/CyHlJ6V2SgEtagCtkEJPOtcRtQlGTEk1IIu7
         IScAdv5cNr6Z7CA1xgV0/DLz2wOn1PJYcmYfiafiLOoUh39/6DBl2CroFicOdnCEmaOe
         uinQ==
X-Gm-Message-State: ACrzQf2DTHV60hPQZdZj/lFbCeOg1OVAqf7rbTKNLmutmMPrK8kaJ4m0
        0L9hTLUhoe+myOKL3pIACeY=
X-Google-Smtp-Source: AMsMyM7KW9+YoZkyJv4Zjqq8UfNiaIt0QNVN3qRdVwNCgYQen8AO2JT+9lKSXNpGgwMohSmFPL4uPw==
X-Received: by 2002:a63:2364:0:b0:46f:5de2:30d1 with SMTP id u36-20020a632364000000b0046f5de230d1mr52885222pgm.304.1668028774022;
        Wed, 09 Nov 2022 13:19:34 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:6af4:9e55:5482:c0de])
        by smtp.gmail.com with ESMTPSA id w7-20020a634747000000b0042b5095b7b4sm7945972pgk.5.2022.11.09.13.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 13:19:33 -0800 (PST)
Date:   Wed, 9 Nov 2022 13:19:30 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/2] gpiolib: of: Prepare of_mm_gpiochip_add_data()
 for fwnode
Message-ID: <Y2wZYuadSwbqxpge@google.com>
References: <20221109150734.38874-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109150734.38874-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 05:07:33PM +0200, Andy Shevchenko wrote:
> GPIO library is getting rid of of_node, fwnode should be utilized instead.
> Prepare of_mm_gpiochip_add_data() for fwnode.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpiolib-of.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index 4be3c21aa718..feeb9e8e846d 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -919,14 +919,15 @@ int of_mm_gpiochip_add_data(struct device_node *np,
>  			    struct of_mm_gpio_chip *mm_gc,
>  			    void *data)
>  {
> +	struct fwnode_handle *fwnode = of_fwnode_handle(np);
>  	int ret = -ENOMEM;
>  	struct gpio_chip *gc = &mm_gc->gc;
>  
> -	gc->label = kasprintf(GFP_KERNEL, "%pOF", np);
> +	gc->label = kasprintf(GFP_KERNEL, "%pfw", fwnode);
>  	if (!gc->label)
>  		goto err0;
>  
> -	mm_gc->regs = of_iomap(np, 0);
> +	mm_gc->regs = fwnode_iomap(fwnode, 0);
>  	if (!mm_gc->regs)
>  		goto err1;
>  
> @@ -935,8 +936,8 @@ int of_mm_gpiochip_add_data(struct device_node *np,
>  	if (mm_gc->save_regs)
>  		mm_gc->save_regs(mm_gc);
>  
> -	of_node_put(mm_gc->gc.of_node);
> -	mm_gc->gc.of_node = of_node_get(np);
> +	fwnode_handle_put(mm_gc->gc.fwnode);
> +	mm_gc->gc.fwnode = fwnode_handle_get(fwnode);

Can we reduce the patch to

	fwnode_handle_put(mm_gc->gc.fwnode);
	mm_gc->gc.fwnode = fwnode_handle_get(of_fwnode_handle(np));

?

I do not see a reason for converting the rest of invocations to fwnode
given that this is clearly an OF API.

Thanks.

-- 
Dmitry
