Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD095BF502
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 05:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiIUDwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 23:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiIUDwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 23:52:38 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D99211831;
        Tue, 20 Sep 2022 20:52:37 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id w10so3518993pll.11;
        Tue, 20 Sep 2022 20:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=FYKWLF91wqHBSNDwklandVe9xWbG7lTxuRtXEgU2cDU=;
        b=OBHMYwgOPsEJor10qwN9qEnWeiIslJgFlhiKEz468aZwmBAwBB0xgF3AihVFij6CPL
         1rNIfE6rt27sJ7BNNMUMPB3xtiALfxZEBlC3ig2d1rPUGJ/TOynBX1SH9HmKDLHh6S9F
         jesBnw1UFDBju+OxZrIystsgRoW6FPh8vKtgQlShJpzC7v0z7DQb1wTEMIGKrRP9mt7k
         7g8Io6FqgrAIRNEb5m2X27c8QvUfomVhsi+EQvKHiu9s0WUhk8eOnZWLHd3/q0Sk5cUS
         /X+hwFZpDG0BY3q/XijkvOtuHaxa3GdFDhcmHQurNfTcJpdVWAwfUArz6ALDCg+3MANe
         YE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=FYKWLF91wqHBSNDwklandVe9xWbG7lTxuRtXEgU2cDU=;
        b=QGRQZOEVf4/J6VwbMWpyUs4vz+lSnj6H95QT55tI5PAWatz9/78htVoyBloPJ+3WL+
         q1hGVSGbhbJi1nwW47u/Jhbq55tu4Vwa3PFH9UgnOFWStlyUkhsV+Hvikehz8bPM2V32
         tFb+8yPlzxe9dxJnrq3xPnvup86BLHXvqLVZJaHATuvqbfbtX7SZuQhV9hhjHv3lUY7X
         iuBTnYoley3WMplPjd6hWWxhfPAvSLwnjQYR9aGA4kb06yBz422QVlWMDk1mMyLu8uFl
         ayUzoVyJzZjisWBiwl21CBe5hKt7WApgS4DaFkVECxRVEXgmhReSXgMJwMZjHx/cJd0i
         yTcQ==
X-Gm-Message-State: ACrzQf1fxzz/osIZtC8nfj/kWwob3uBJd48PtObDIH5QMzI77rXVkYSh
        0Qr1FFD1C1xKZreQ7d3k30xpPsudeSI=
X-Google-Smtp-Source: AMsMyM5MjLaUDFRaLdEJPoa0Bvidig/FWrKczchthEHb8tgNJ9zLEOZzdPsIJSMAUU3ebQV2yZ5TTw==
X-Received: by 2002:a17:902:bd8e:b0:178:25ab:56cc with SMTP id q14-20020a170902bd8e00b0017825ab56ccmr2784637pls.86.1663732356738;
        Tue, 20 Sep 2022 20:52:36 -0700 (PDT)
Received: from sol (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id v10-20020a17090a0c8a00b002002fb120d7sm755724pja.8.2022.09.20.20.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 20:52:36 -0700 (PDT)
Date:   Wed, 21 Sep 2022 11:52:31 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Meng Li <Meng.Li@windriver.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: cdev: Set lineevent_state::irq after IRQ
 register successfully
Message-ID: <YyqKfxpAjdSU9r+2@sol>
References: <20220921032020.25398-1-Meng.Li@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921032020.25398-1-Meng.Li@windriver.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 11:20:20AM +0800, Meng Li wrote:
> When running gpio test on nxp-ls1028 platform with below command
> gpiomon --num-events=3 --rising-edge gpiochip1 25
> There will be a warning trace as below:
> Call trace:
> free_irq+0x204/0x360
> lineevent_free+0x64/0x70
> gpio_ioctl+0x598/0x6a0
> __arm64_sys_ioctl+0xb4/0x100
> invoke_syscall+0x5c/0x130
> ......
> el0t_64_sync+0x1a0/0x1a4
> The reason of this issue is that calling request_threaded_irq()
> function failed, and then lineevent_free() is invoked to release
> the resource. Since the lineevent_state::irq was already set, so
> the subsequent invocation of free_irq() would trigger the above
> warning call trace. To fix this issue, set the lineevent_state::irq
> after the IRQ register successfully.
> 
> Fixes: 468242724143 ("gpiolib: cdev: refactor lineevent cleanup into lineevent_free")
> Cc: stable@vger.kernel.org
> Signed-off-by: Meng Li <Meng.Li@windriver.com>

Good pick up - the IRQ shouldn't be freed if it hasn't been successfully requested.

Signed-off-by: Kent Gibson <warthog618@gmail.com>

> ---
>  drivers/gpio/gpiolib-cdev.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index ffa0256cad5a..937e7a8dd8a9 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -1784,7 +1784,6 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
>  		ret = -ENODEV;
>  		goto out_free_le;
>  	}
> -	le->irq = irq;
>  
>  	if (eflags & GPIOEVENT_REQUEST_RISING_EDGE)
>  		irqflags |= test_bit(FLAG_ACTIVE_LOW, &desc->flags) ?
> @@ -1798,7 +1797,7 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
>  	init_waitqueue_head(&le->wait);
>  
>  	/* Request a thread to read the events */
> -	ret = request_threaded_irq(le->irq,
> +	ret = request_threaded_irq(irq,
>  				   lineevent_irq_handler,
>  				   lineevent_irq_thread,
>  				   irqflags,
> @@ -1807,6 +1806,8 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
>  	if (ret)
>  		goto out_free_le;
>  
> +	le->irq = irq;
> +
>  	fd = get_unused_fd_flags(O_RDONLY | O_CLOEXEC);
>  	if (fd < 0) {
>  		ret = fd;
> -- 
> 2.36.1
> 
