Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0965BF7C5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 09:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiIUHdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 03:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiIUHdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 03:33:17 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55DB8305F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 00:33:15 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z13so7262201edb.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 00:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=rTQHRpCuYWTF0TW7ZqPRytz1miu1sr94XDRZMIsgnL4=;
        b=SoG1y4ffqJysqfAETOiLczIeeg0p+5834Zi5KDxCo+qQTGQhPSdFKfVGTOogBy8ymo
         97xDbl+VLIxe5GtnP560IpvbcKvVxU+PW/d3pqbY6pLFu97p64yn4ieKfQgVE35YluP3
         Ks4sQBv5pm3TvaL4j+f4Bzhcjhkxwy48AETBioAgFRWXcvSfJer8F+t6HcS1JtCMlemQ
         McDv+5IaGlJBQw1GPGlrbYBiNl+/1HN4bVIluYsLGo0xKouVnsNRzFTCJaiV/mEZgdYn
         TfE1zZUxmGMSmH0bXwWBeDncqufpR5fBA5unv2uS8CjaLceXGWE6+ojI3um07JxSHtxV
         UStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=rTQHRpCuYWTF0TW7ZqPRytz1miu1sr94XDRZMIsgnL4=;
        b=AasPEtCsYZ2ADoNozVeUpGRk3sJgfyaF31khoqrdX50ScA3VJTNegSNiqDB8pMUF7t
         I8HhJKGIDc2hj3oGrqamouv58AKVJKsntjPyEntDHMU5WngSmzhLTf5Cdgv2Mu/2OqGL
         a8ROW/z1M6QNWdW8PWpHnXYUHF0rGf4RIG9ZzVcmyrbIl+6WvjSxK6zGD0faCsXQWMgM
         MbF8Pab1/+nFX/83FDDB0QUQwUravX/o4obVH9UnDDtL7vLbmntfTNBpvDZGqqzwQwUz
         7LjJKEYPPSZJYzoh6UBtWK7XUCUkjFBtZkxqWRQmrsqSbaGtrmsrlSfourtihUed1lGF
         fU+Q==
X-Gm-Message-State: ACrzQf17UVfymzi45T60SsQl+Jx2Y5WPdAqVAfBQ344m040LbJvyFr7J
        XMcP3HTnsmVTofbn5ExNbsCuNhVMea2ZGesXMah5Kw==
X-Google-Smtp-Source: AMsMyM6KUo0g4SGhIWfZVj6dctZadODYk2rB4I7ebaJRb0iTeabclBUImzA9WGWuRD3KERMnJXDKWRJPtNPlsI42zRI=
X-Received: by 2002:aa7:d488:0:b0:454:646a:4f98 with SMTP id
 b8-20020aa7d488000000b00454646a4f98mr7041993edr.408.1663745594398; Wed, 21
 Sep 2022 00:33:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220921032020.25398-1-Meng.Li@windriver.com>
In-Reply-To: <20220921032020.25398-1-Meng.Li@windriver.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 21 Sep 2022 09:33:03 +0200
Message-ID: <CAMRc=MdYxX4ZsTQDmAQy5pmzDFBTKnw8qwVVHdcDK2Ui+b569w@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: cdev: Set lineevent_state::irq after IRQ
 register successfully
To:     Meng Li <Meng.Li@windriver.com>
Cc:     linus.walleij@linaro.org, warthog618@gmail.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 5:23 AM Meng Li <Meng.Li@windriver.com> wrote:
>
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
> ---
>  drivers/gpio/gpiolib-cdev.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index ffa0256cad5a..937e7a8dd8a9 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -1784,7 +1784,6 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
>                 ret = -ENODEV;
>                 goto out_free_le;
>         }
> -       le->irq = irq;
>
>         if (eflags & GPIOEVENT_REQUEST_RISING_EDGE)
>                 irqflags |= test_bit(FLAG_ACTIVE_LOW, &desc->flags) ?
> @@ -1798,7 +1797,7 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
>         init_waitqueue_head(&le->wait);
>
>         /* Request a thread to read the events */
> -       ret = request_threaded_irq(le->irq,
> +       ret = request_threaded_irq(irq,
>                                    lineevent_irq_handler,
>                                    lineevent_irq_thread,
>                                    irqflags,
> @@ -1807,6 +1806,8 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
>         if (ret)
>                 goto out_free_le;
>
> +       le->irq = irq;
> +
>         fd = get_unused_fd_flags(O_RDONLY | O_CLOEXEC);
>         if (fd < 0) {
>                 ret = fd;
> --
> 2.36.1
>

Applied, thanks!

Bart
