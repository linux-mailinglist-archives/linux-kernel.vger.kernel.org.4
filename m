Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5947C5BDD7C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 08:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiITGlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 02:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiITGkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 02:40:52 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A885EDDF
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 23:40:11 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id u9so3774564ejy.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 23:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=4qHBWtvtS5lv+YsJJQWO+VtMhZZyJ3/vvKihmFXgE4c=;
        b=s9GRZmt6oE99PBnCD69nEa0OtMPNMBCXBROmbHOgv3pI5cVvMlWko4awt/p/+0LSgA
         3fQhDh1UJ7KHNTJ1+1S2I6yRk9uVlHpOOmgT08wPxFf8InZ+35dTxucAb2aRpjZONSdM
         mls0wwf1yF9zQU2lpdgpGubdSI/LAVDenIaNWFFk1fwVq8zXhqGYaqcjaUXH0AbKl76N
         Vwl1OFzj0fH/vvMSbT1pZKIHLNV81tNxcpvSRW2YxGyO5JaqAaCdu7RjRzRkPm6deaDU
         3xrVKoMPiXYY1BdprHzQ/Z2JLw5PyAoXzG5QXZTWGJpssL5sN+XHtj6KOUoZobqY6cew
         EbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=4qHBWtvtS5lv+YsJJQWO+VtMhZZyJ3/vvKihmFXgE4c=;
        b=JDuf1AfMZFY1Ek81NR8OlFV6EZo40e1sFOD+kv/2FMo4f7gNuv7PRz1MU/mbJHFCha
         fWdu6USb+Y6DwyGK8UjLMgC4Dg9xcskEY6kUuQ41S4YuZ8YUZQhvtz6am4KnqDoePjIx
         tM7YXxVbMYgrUtKoB1Oo64no21mYoH4Uz44dbqFHnOVUvldV/QxYDBhSSzby98xIfxe6
         GkmYvsz+9qnQt7MTnZj3XSIsIQQ7goiuYtxwN9DqKYD7f6wlx4Ga3QUBfwjXF6x8KmLs
         MDRexODbrMUyLdafR4dkf+hPKsiqSswF4W8s+2dOW29rsl0H40ZqG0h1KfIAStUltr7N
         3/KQ==
X-Gm-Message-State: ACrzQf20kl4LGJU3WT+NwHfwWy71+Y6QvgEQ0O5laIgaFfqc0lq8HP+H
        JiLDM1x2iKvuKTew1Vh4Lp5GVdZaxSeSDZVxkhvDXotEWGxLgQ==
X-Google-Smtp-Source: AMsMyM4wXLZE7czB9+kEBQruymKBBlA5zawUrElq5yiHE772/SyraHfS4uoXzUlBNMZsrpRNhTXL+be5gpfBaPowmkM=
X-Received: by 2002:a17:907:1c96:b0:780:602c:677c with SMTP id
 nb22-20020a1709071c9600b00780602c677cmr15587856ejc.736.1663656009634; Mon, 19
 Sep 2022 23:40:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220920011747.824280-1-jay.xu@rock-chips.com>
In-Reply-To: <20220920011747.824280-1-jay.xu@rock-chips.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 20 Sep 2022 08:39:59 +0200
Message-ID: <CAMRc=McYhs8yoJ=_TQEcjr=-6UaYkGuZOpZnAGOTFs_oMOQrUw@mail.gmail.com>
Subject: Re: [PATCH RESEND] gpiolib: make gpiochip_find_by_name to be common function
To:     Jianqun Xu <jay.xu@rock-chips.com>
Cc:     linus.walleij@linaro.org, andriy.shevchenko@linux.intel.com,
        linux-gpio@vger.kernel.or, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 3:17 AM Jianqun Xu <jay.xu@rock-chips.com> wrote:
>
> Move find_chip_by_name from gpiolib to the gpio/driver.h, also rename to
> gpiochip_find_by_name, make it to be a common function.
>

Why did you resend it immediately? And what is the reason for this change?

Bart

> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
> ---
>  drivers/gpio/gpiolib.c      | 16 ++--------------
>  include/linux/gpio/driver.h | 12 ++++++++++++
>  2 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index cc9c0a12259e..c06334772c47 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -935,18 +935,6 @@ struct gpio_chip *gpiochip_find(void *data,
>  }
>  EXPORT_SYMBOL_GPL(gpiochip_find);
>
> -static int gpiochip_match_name(struct gpio_chip *gc, void *data)
> -{
> -       const char *name = data;
> -
> -       return !strcmp(gc->label, name);
> -}
> -
> -static struct gpio_chip *find_chip_by_name(const char *name)
> -{
> -       return gpiochip_find((void *)name, gpiochip_match_name);
> -}
> -
>  #ifdef CONFIG_GPIOLIB_IRQCHIP
>
>  /*
> @@ -3660,7 +3648,7 @@ void gpiod_add_hogs(struct gpiod_hog *hogs)
>                  * The chip may have been registered earlier, so check if it
>                  * exists and, if so, try to hog the line now.
>                  */
> -               gc = find_chip_by_name(hog->chip_label);
> +               gc = gpiochip_find_by_name(hog->chip_label);
>                 if (gc)
>                         gpiochip_machine_hog(gc, hog);
>         }
> @@ -3745,7 +3733,7 @@ static struct gpio_desc *gpiod_find(struct device *dev, const char *con_id,
>                         return ERR_PTR(-EPROBE_DEFER);
>                 }
>
> -               gc = find_chip_by_name(p->key);
> +               gc = gpiochip_find_by_name(p->key);
>
>                 if (!gc) {
>                         /*
> diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
> index 6aeea1071b1b..4ed26a7d98ff 100644
> --- a/include/linux/gpio/driver.h
> +++ b/include/linux/gpio/driver.h
> @@ -618,6 +618,18 @@ extern int devm_gpiochip_add_data_with_key(struct device *dev, struct gpio_chip
>  extern struct gpio_chip *gpiochip_find(void *data,
>                               int (*match)(struct gpio_chip *gc, void *data));
>
> +static int gpiochip_match_name(struct gpio_chip *gc, void *data)
> +{
> +       const char *name = data;
> +
> +       return !strcmp(gc->label, name);
> +}
> +
> +static inline struct gpio_chip *gpiochip_find_by_name(const char *name)
> +{
> +       return gpiochip_find((void *)name, gpiochip_match_name);
> +}
> +
>  bool gpiochip_line_is_irq(struct gpio_chip *gc, unsigned int offset);
>  int gpiochip_reqres_irq(struct gpio_chip *gc, unsigned int offset);
>  void gpiochip_relres_irq(struct gpio_chip *gc, unsigned int offset);
> --
> 2.25.1
>
