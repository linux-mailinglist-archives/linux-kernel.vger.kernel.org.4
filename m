Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE666390F5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 22:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiKYVJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 16:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKYVJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 16:09:01 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D8C2982E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 13:09:00 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id c26so1918517uak.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 13:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VqUh3nU3SRcgOclun+gRgMDO5gYRQgy6WrNbTHAP11I=;
        b=gI6q31P8fsvL0dSuQOv35NK4zfSt+CfLns25q2oXH5BlC17D/6Rp+lxuR8CFok1Dp/
         PcTISkdqvW/APU0FuwjnaT2ajjaBLe6+29pgWNAbNkGwrICCf8kInqDqmjFS95T+ZlOy
         R41jfpZUpLcIPi4LF3AQ+wxq/CDTArUm9RwPNZ64xwaDL4FMIqTaeoo0oGBZwzJpYpel
         lCfNvIRBEdGpWH0psSo75VgW1SzEABxDEP5bfX2NOb8Z7qMkoHGZu/404VGokWRuIrLA
         p4E1yCwuR7DGDMPYPWZuRO2a//HORmzFpZS08QXwoEqKKTRlsmgtC4I4OPlGWMgGvsma
         6Hzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VqUh3nU3SRcgOclun+gRgMDO5gYRQgy6WrNbTHAP11I=;
        b=oGCKZFfJL/toPGCLS9e6/wvLB4vl4AJKzUJwZd27NCP5Rwlh6j2f8O3EnIGyIlPQ74
         vy/vnOjtkzwLtCCyIIc+spj7JqWMwh21prCpVgPotmPkXdqlonfOLJDloZN7pnk94b4F
         MZ8T3DM9Ch0iNkIyh1juHAbeAjWzB86+KYb1fO9SvBBvEIk+pnnaptLesI9vIm3tuNtP
         ti7rJwOJamWfHopKUF40IpIrwZuj3PNpb62fMmqT5tnz428xM7IV/iQwDb207Jr56Bmz
         6V5tXffUv/0rpDA+MgwLSfaOwadcYm+/2plPUrYFETe6byRM+QRlPBP8kiIs9G8PGaeS
         Cm/Q==
X-Gm-Message-State: ANoB5plxN74f3PTU2ply36yQepinT3QSRBvYfxgq3aOGIBoloh1+b7am
        bIAQr6VYdHQkMeBqPYVJx0Ln7kpU6SLWij1u2aPE3/s+Jqs=
X-Google-Smtp-Source: AA0mqf7NgmSaoMgXf9KynFQJ2AZTx5ugzQaXwaGF3yvjOyAeGTOER8626+/FoWtNgDOZcM0bLf/DXOQFG7FYN1HITp4=
X-Received: by 2002:ab0:5a6e:0:b0:415:715c:1e70 with SMTP id
 m43-20020ab05a6e000000b00415715c1e70mr15599039uad.81.1669410539200; Fri, 25
 Nov 2022 13:08:59 -0800 (PST)
MIME-Version: 1.0
References: <20221118194508.50686-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221118194508.50686-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 25 Nov 2022 22:08:48 +0100
Message-ID: <CAMRc=MeJNCPobQmR-46aj1GGqAe0urgHuRzvyu7EN=y2fT5pgA@mail.gmail.com>
Subject: Re: [rft, PATCH v5 1/1] gpiolib: fix memory leak in gpiochip_setup_dev()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Zeng Heng <zengheng4@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 8:44 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> From: Zeng Heng <zengheng4@huawei.com>
>
> Here is a backtrace report about memory leak detected in
> gpiochip_setup_dev():
>
> unreferenced object 0xffff88810b406400 (size 512):
>   comm "python3", pid 1682, jiffies 4295346908 (age 24.090s)
>   backtrace:
>     kmalloc_trace
>     device_add          device_private_init at drivers/base/core.c:3361
>                         (inlined by) device_add at drivers/base/core.c:3411
>     cdev_device_add
>     gpiolib_cdev_register
>     gpiochip_setup_dev
>     gpiochip_add_data_with_key
>
> gcdev_register() & gcdev_unregister() would call device_add() &
> device_del() (no matter CONFIG_GPIO_CDEV is enabled or not) to
> register/unregister device.
>
> However, if device_add() succeeds, some resource (like
> struct device_private allocated by device_private_init())
> is not released by device_del().
>
> Therefore, after device_add() succeeds by gcdev_register(), it
> needs to call put_device() to release resource in the error handle
> path.
>
> Here we move forward the register of release function, and let it
> release every piece of resource by put_device() instead of kfree().
>
> While at it, fix another subtle issue, i.e. when gc->ngpio is equal
> to 0, we still call kcalloc() and, in case of further error, kfree()
> on the ZERO_PTR pointer, which is not NULL. It's not a bug per se,
> but rather waste of the resources and potentially wrong expectation
> about contents of the gdev->descs variable.
>
> Fixes: 159f3cd92f17 ("gpiolib: Defer gpio device setup until after gpiolib initialization")
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
> Co-developed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> changes in v5 (done by Andy):
>   - refactored to avoid double checks on the same conditionals
>   - moved kcalloc() after validating its parameter
>   - compiled tested only by me (Andy)
> changes in v4:
>   - add gpiochip_print_register_fail()
> changes in v3:
>   - use put_device() instead of kfree() explicitly
> changes in v2:
>   - correct fixes tag
>
>  drivers/gpio/gpiolib.c | 42 ++++++++++++++++++++++++++----------------
>  1 file changed, 26 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index caa747fdcb72..119c9c3a2a50 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -580,12 +580,13 @@ static int gpiochip_setup_dev(struct gpio_device *gdev)
>         if (ret)
>                 return ret;
>
> +       /* From this point, the .release() function cleans up gpio_device */
> +       gdev->dev.release = gpiodevice_release;
> +
>         ret = gpiochip_sysfs_register(gdev);
>         if (ret)
>                 goto err_remove_device;
>
> -       /* From this point, the .release() function cleans up gpio_device */
> -       gdev->dev.release = gpiodevice_release;
>         dev_dbg(&gdev->dev, "registered GPIOs %d to %d on %s\n", gdev->base,
>                 gdev->base + gdev->ngpio - 1, gdev->chip->label ? : "generic");
>
> @@ -651,10 +652,10 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
>         struct fwnode_handle *fwnode = NULL;
>         struct gpio_device *gdev;
>         unsigned long flags;
> -       int base = gc->base;
>         unsigned int i;
> +       u32 ngpios = 0;
> +       int base = 0;
>         int ret = 0;
> -       u32 ngpios;
>
>         /* If the calling driver did not initialize firmware node, do it here */
>         if (gc->fwnode)
> @@ -696,17 +697,12 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
>         else
>                 gdev->owner = THIS_MODULE;
>
> -       gdev->descs = kcalloc(gc->ngpio, sizeof(gdev->descs[0]), GFP_KERNEL);
> -       if (!gdev->descs) {
> -               ret = -ENOMEM;
> -               goto err_free_dev_name;
> -       }
> -
>         /*
>          * Try the device properties if the driver didn't supply the number
>          * of GPIO lines.
>          */
> -       if (gc->ngpio == 0) {
> +       ngpios = gc->ngpio;
> +       if (ngpios == 0) {
>                 ret = device_property_read_u32(&gdev->dev, "ngpios", &ngpios);
>                 if (ret == -ENODATA)
>                         /*
> @@ -717,7 +713,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
>                          */
>                         ngpios = 0;
>                 else if (ret)
> -                       goto err_free_descs;
> +                       goto err_free_dev_name;
>
>                 gc->ngpio = ngpios;
>         }
> @@ -725,13 +721,19 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
>         if (gc->ngpio == 0) {
>                 chip_err(gc, "tried to insert a GPIO chip with zero lines\n");
>                 ret = -EINVAL;
> -               goto err_free_descs;
> +               goto err_free_dev_name;
>         }
>
>         if (gc->ngpio > FASTPATH_NGPIO)
>                 chip_warn(gc, "line cnt %u is greater than fast path cnt %u\n",
>                           gc->ngpio, FASTPATH_NGPIO);
>
> +       gdev->descs = kcalloc(gc->ngpio, sizeof(*gdev->descs), GFP_KERNEL);
> +       if (!gdev->descs) {
> +               ret = -ENOMEM;
> +               goto err_free_dev_name;
> +       }
> +
>         gdev->label = kstrdup_const(gc->label ?: "unknown", GFP_KERNEL);
>         if (!gdev->label) {
>                 ret = -ENOMEM;
> @@ -750,11 +752,13 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
>          * it may be a pipe dream. It will not happen before we get rid
>          * of the sysfs interface anyways.
>          */
> +       base = gc->base;
>         if (base < 0) {
>                 base = gpiochip_find_base(gc->ngpio);
>                 if (base < 0) {
> -                       ret = base;
>                         spin_unlock_irqrestore(&gpio_lock, flags);
> +                       ret = base;
> +                       base = 0;
>                         goto err_free_label;
>                 }
>                 /*
> @@ -868,6 +872,11 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
>  err_free_gpiochip_mask:
>         gpiochip_remove_pin_ranges(gc);
>         gpiochip_free_valid_mask(gc);
> +       if (gdev->dev.release) {
> +               /* release() has been registered by gpiochip_setup_dev() */
> +               put_device(&gdev->dev);
> +               goto err_print_message;
> +       }
>  err_remove_from_list:
>         spin_lock_irqsave(&gpio_lock, flags);
>         list_del(&gdev->list);
> @@ -881,13 +890,14 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
>  err_free_ida:
>         ida_free(&gpio_ida, gdev->id);
>  err_free_gdev:
> +       kfree(gdev);
> +err_print_message:
>         /* failures here can mean systems won't boot... */
>         if (ret != -EPROBE_DEFER) {
>                 pr_err("%s: GPIOs %d..%d (%s) failed to register, %d\n", __func__,
> -                      gdev->base, gdev->base + gdev->ngpio - 1,
> +                      base, base + (int)ngpios - 1,
>                        gc->label ? : "generic", ret);
>         }
> -       kfree(gdev);
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(gpiochip_add_data_with_key);
> --
> 2.35.1
>

Queued for fixes, thanks!

Bartosz
