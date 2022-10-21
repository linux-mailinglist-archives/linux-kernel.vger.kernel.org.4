Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE20607752
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 14:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiJUMxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 08:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJUMxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 08:53:43 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327462639E3;
        Fri, 21 Oct 2022 05:53:42 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id f8-20020a17090a664800b00212464cd49fso2770270pjm.4;
        Fri, 21 Oct 2022 05:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pT1o9kqIltk7ZKL7Tu5WfqsXDrhfDokaIOWcgHyIEiw=;
        b=ZrsfS3xN6RCS5WKPg2c5leRsUt4fdfk//OoFozxjvdPQKLGMhmtD8rI9ngnbfwRyIW
         dzabdvxvxLQSQW43SBr5Dg/Ge/m86ce+2ZKFj0modIcUtkRoz+mAPjXGHBlbF0AfO9PC
         IH2MxVcecWmhIEOlD/0ERURbDVz9+ne7wJv6mDloodOfGjzQjZGlV53aKQq99lXPK+2W
         tI7tVWp4muVk8Q/R6z81Se48tgOVYQY/CmvDbuRsVVIziQXyYSTmf8hvqQ8KlXBPgmM3
         ch7U0hmR3vQsjSPxQMkx8xr2BRyBtvOpzHvIxuM11DdaZdIiJXPXgZwuxnKsGgKl58Ox
         DiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pT1o9kqIltk7ZKL7Tu5WfqsXDrhfDokaIOWcgHyIEiw=;
        b=jLsjwlAQKsIMAVqDMebO07A27V7zL5vZiNZZI3kbhdaBC38nc8J4htBYDntx5lBg3V
         3dgMZA01Kb1O9Xu1p+y9slfR5a5Zi13iuX/C6WsxkiK5H7/XIWqtKfadi6eEGypf6Zeg
         BPnuKkVzMaEbr7e8vwjF/cTiUqvZyLMWnXlBLNdIRVko7xExv+r4XDHQWazJ0ih49QUp
         RiP6PTW76h4Y3Af7W+BhyvjsTAmuEY3xQd406aK7qN1U9tPZdQ33QbDTkEaHskRp8gLD
         iOlEZ/1AD5VIBVl3GHPDTQTqB6pjhCH4THp8IDctBMznZsspKLST5Q+wu8bmCG6SrXdS
         AspA==
X-Gm-Message-State: ACrzQf3CHRpLxZ6ml6FDwRrlHo4CCPRfmftvt1ONiXCCJ3pkHnWS6EUb
        upsJI14uHBbJmGuRKhFkhpg=
X-Google-Smtp-Source: AMsMyM5YPBLfSlrT7YSI2ggdctMXp08tYqatA2M13f6pm4t/Bd0vHCQcZzkmbJBxDUBeaQ1wlnEamg==
X-Received: by 2002:a17:90b:1a88:b0:20d:8df0:ac64 with SMTP id ng8-20020a17090b1a8800b0020d8df0ac64mr21787422pjb.140.1666356821683;
        Fri, 21 Oct 2022 05:53:41 -0700 (PDT)
Received: from sol (14-203-42-90.tpgi.com.au. [14.203.42.90])
        by smtp.gmail.com with ESMTPSA id i13-20020a170902c94d00b0017f48a9e2d6sm14826611pla.292.2022.10.21.05.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 05:53:41 -0700 (PDT)
Date:   Fri, 21 Oct 2022 20:53:36 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/1] gpiolib: cdev: Fix typo in kernel doc for struct
 line
Message-ID: <Y1KWULsdyTvmuN/k@sol>
References: <20221020153914.63260-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020153914.63260-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 06:39:14PM +0300, Andy Shevchenko wrote:
> When eflags has been renamed to the edflags, the kernel doc change were
> missed. Update kernel doc accordingly.
> 
> Fixes: b1a92e94560d ("gpiolib: cdev: consolidate edge detector configuration flags")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Kent Gibson <warthog618@gmail.com>

> ---
>  drivers/gpio/gpiolib-cdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index 0c84b011a64a..f9288e41e3a7 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -412,7 +412,7 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
>   * @desc: the GPIO descriptor for this line.
>   * @req: the corresponding line request
>   * @irq: the interrupt triggered in response to events on this GPIO
> - * @eflags: the edge flags, GPIO_V2_LINE_FLAG_EDGE_RISING and/or
> + * @edflags: the edge flags, GPIO_V2_LINE_FLAG_EDGE_RISING and/or
>   * GPIO_V2_LINE_FLAG_EDGE_FALLING, indicating the edge detection applied
>   * @timestamp_ns: cache for the timestamp storing it between hardirq and
>   * IRQ thread, used to bring the timestamp close to the actual event
> -- 
> 2.35.1
> 
