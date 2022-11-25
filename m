Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE481638E37
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 17:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiKYQY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 11:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiKYQYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 11:24:55 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1ACC4A58C;
        Fri, 25 Nov 2022 08:24:54 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id j12so4398096plj.5;
        Fri, 25 Nov 2022 08:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O8M7ht2vbb/9fSe4jDPArRurwwIsch8HDAf5aJC1yqw=;
        b=bUy4j1cDJ7c18j7F2ZQvbcZ6Bp4tmARiHu3F4PT3Vm+UCBJwryaIsd3+dKuF69j4+Y
         jGs7C6/igSPksrOjHW4SW9QO8MfCSW4GSGAxDYeGhJc1EY/8uqCNX6fDBJLolClXEHFP
         qjCAX+7Rp2LVhyndBWHbdW4lcXeJ6jMdHaPB65xtXOTpNkyUBSyWhX/hQhmVpGsmcxHb
         z20JRNgJgNzrwKVH82Zl9pIFjQxZevyRvUywc+afPQ+CcnuvNqrwohZnuS+99egd6VKT
         B92RUnDboaj4ffkrPZGBIoy2oiUypPT3xNhKlx8pXl7dGM56Rxyxq1/SIrR/74rATp6v
         nOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8M7ht2vbb/9fSe4jDPArRurwwIsch8HDAf5aJC1yqw=;
        b=PIE5djpNSUIGWB959yfLnGrv9IQlRZFcO/ZEMs2bNXtWBb7AhjfRiQ9/QYSYPDcEPB
         EOHmEJb7v2vYHvhPecbW67v+GHNbOl1pw8Be+RD81tII1j+zKYrQg/lMma3bwF211J9u
         KX2E1g/0BqArJoZmLgj3yOIsftGC1P4eE1ab31JA2IkCCiWDzruEBBKIz8xJhC6DSQez
         3gTdrElxORmbJXBuLfHJ46jwceurm1GB+2/xfGjNz99lGtyKcTIu4EfuNbIIyr3a4UlO
         F7OTLsxVYzszPATEWc8hDdB+mNYj1p6lBhqMVANDkSMczhLfpWv9y2rOa3QIkMoriGBS
         ksmQ==
X-Gm-Message-State: ANoB5pkRicEfTpgiXt9Zg5i9p8mitMnxKA4lMFiCFxRWP/pW2XVnfipY
        iL+LLgbV1TNqvAUCrLsXOMg=
X-Google-Smtp-Source: AA0mqf5DHB+TJADByTdKrxpTP0xUl8iRHxztHKU+5gYZNrjTMneAdfVvVffJYHrYhz+68oAc7mZepg==
X-Received: by 2002:a17:90a:d145:b0:213:f465:14e7 with SMTP id t5-20020a17090ad14500b00213f46514e7mr41390547pjw.194.1669393494302;
        Fri, 25 Nov 2022 08:24:54 -0800 (PST)
Received: from sol (110-174-14-241.tpgi.com.au. [110.174.14.241])
        by smtp.gmail.com with ESMTPSA id o6-20020a62f906000000b00574345ee12csm3302039pfh.23.2022.11.25.08.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 08:24:53 -0800 (PST)
Date:   Sat, 26 Nov 2022 00:24:47 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpiolib: cdev: fix NULL-pointer dereferences
Message-ID: <Y4DsTxPH1tv5eEwf@sol>
References: <20221125153257.528826-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125153257.528826-1-brgl@bgdev.pl>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 04:32:57PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> There are several places where we can crash the kernel by requesting
> lines, unbinding the GPIO device, then calling any of the system calls
> relevant to the GPIO character device's annonymous file descriptors:
> ioctl(), read(), poll().
> 
> While I observed it with the GPIO simulator, it will also happen for any
> of the GPIO devices that can be hot-unplugged - for instance any HID GPIO
> expander (e.g. CP2112).
> 
> This affects both v1 and v2 uAPI.
> 
> Fix this by simply checking if the GPIO chip pointer is not NULL.
> 

Fixes: ??

And split for v1 and v2 as the Fixes for those will differ?

> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/gpio/gpiolib-cdev.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index 0cb6b468f364..d5632742942a 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -201,6 +201,9 @@ static long linehandle_ioctl(struct file *file, unsigned int cmd,
>  	unsigned int i;
>  	int ret;
>  
> +	if (!lh->gdev->chip)
> +		return -ENODEV;
> +

Is there anything to prevent the chip being removed by another thread
between this check and subsequent usage?

Cheers,
Kent.

>  	switch (cmd) {
>  	case GPIOHANDLE_GET_LINE_VALUES_IOCTL:
>  		/* NOTE: It's okay to read values of output lines */
> @@ -1384,6 +1387,9 @@ static long linereq_ioctl(struct file *file, unsigned int cmd,
>  	struct linereq *lr = file->private_data;
>  	void __user *ip = (void __user *)arg;
>  
> +	if (!lr->gdev->chip)
> +		return -ENODEV;
> +
>  	switch (cmd) {
>  	case GPIO_V2_LINE_GET_VALUES_IOCTL:
>  		return linereq_get_values(lr, ip);
> @@ -1716,6 +1722,9 @@ static __poll_t lineevent_poll(struct file *file,
>  	struct lineevent_state *le = file->private_data;
>  	__poll_t events = 0;
>  
> +	if (!le->gdev->chip)
> +		return -ENODEV;
> +
>  	poll_wait(file, &le->wait, wait);
>  
>  	if (!kfifo_is_empty_spinlocked_noirqsave(&le->events, &le->wait.lock))
> @@ -1740,6 +1749,9 @@ static ssize_t lineevent_read(struct file *file,
>  	ssize_t ge_size;
>  	int ret;
>  
> +	if (!le->gdev->chip)
> +		return -ENODEV;
> +
>  	/*
>  	 * When compatible system call is being used the struct gpioevent_data,
>  	 * in case of at least ia32, has different size due to the alignment
> @@ -1821,6 +1833,9 @@ static long lineevent_ioctl(struct file *file, unsigned int cmd,
>  	void __user *ip = (void __user *)arg;
>  	struct gpiohandle_data ghd;
>  
> +	if (!le->gdev->chip)
> +		return -ENODEV;
> +
>  	/*
>  	 * We can get the value for an event line but not set it,
>  	 * because it is input by definition.
> -- 
> 2.37.2
> 
