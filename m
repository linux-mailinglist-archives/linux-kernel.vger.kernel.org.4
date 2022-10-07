Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F334B5F7B5E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 18:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiJGQZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 12:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiJGQZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 12:25:00 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B77C2F38B;
        Fri,  7 Oct 2022 09:24:58 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id o22so2786265qkl.8;
        Fri, 07 Oct 2022 09:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iKT+wdRexw/JjQOAd3/flUgevUBDOrgkhpmB6roT2ak=;
        b=qj7ooJnN6e+ZwRZMl6qqsenjlYJ7OztD8FNgRYb6Fafep9VxsflFZ7Z2/SjBiBgs9Z
         RFDJPepY1mHfRjnzTu8p0C6WNyBzebyeZpzz5x9uR7nkdyP/dch9VDVqqRg5gkpfpf3W
         Qs4g7zb0XVgIk9e/QCEEr4UaD3adeOFxF1kTvitV3VGrKMFPjpuRDLZglOysK5nXLKCP
         cWYUwPgcK4wWoyasFU/ElKGT1dWQWYqnhsSJoqGYTuobsBJUb+nM00UyX6cZRVT8OU75
         IT0RgmpAQuoNFcIpzlSwlrmMuEUCkN0F483IN9zuiaPaKqp7Kbh6ehGl/SLAgF/5+Phs
         73Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iKT+wdRexw/JjQOAd3/flUgevUBDOrgkhpmB6roT2ak=;
        b=fkcHNYcSPO6hZpE9oJZqeu0M0c9A6Nief/C8iu0Vtp/n5I1XVt5OqczBY1TpIg2x7q
         czyXK8WAJUFhzT2G89Bgn1hxttjfjsyx+hogPz6+Op3LUeV2O4+hKcb70Dhop2OHgnzr
         l/6yw1vY8djdn1uHR4371fJEb8jXPMhePJ92Tdp2m4WeRJrvmKesIDj6Ga5sR2pjPwQ/
         aHR8FF/rQ2TQ2Vvw6zYBUy1JhUA3ZDMGYco2+3tyQQQGzucWaIOHL6dtRahq/jS5OVWq
         /LxhtPRR48RrOJmbKI1nXKqtRfMTctIc6DbTQWcGCW2PzLN1riYEyepgiGjo3xbiSgs1
         BSxQ==
X-Gm-Message-State: ACrzQf1Q3pRLkQugMIE0bpr69YPQRWqRBleQJ6h4YgG8Dhpv/NXLN+4o
        HyVFxWjVYZORWcxdNVlZP//68T6rntFIoY2ucC8=
X-Google-Smtp-Source: AMsMyM5pvo30eHPRQ5wPaC2Y7IDx7ogLgaibNazJSu09wD3RD1Y7tGassO91a0w40+9wGOy29vGvwRtmTvErS1eOdFI=
X-Received: by 2002:a05:620a:4454:b0:6ce:bfbf:7e3f with SMTP id
 w20-20020a05620a445400b006cebfbf7e3fmr4253002qkp.748.1665159897817; Fri, 07
 Oct 2022 09:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20221007145641.3307075-1-jjhiblot@traphandler.com> <20221007145641.3307075-4-jjhiblot@traphandler.com>
In-Reply-To: <20221007145641.3307075-4-jjhiblot@traphandler.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 7 Oct 2022 19:24:21 +0300
Message-ID: <CAHp75VdUt-SZxesD-f+647vG8ZANkC4mrtJ4VGu5b=q4PN+d-g@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] leds: provide devm_of_led_get_optional()
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     lee.jones@linaro.org, pavel@ucw.cz, robh+dt@kernel.org,
        sven.schwermer@disruptive-technologies.com,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        marijn.suijten@somainline.org, bjorn.andersson@linaro.org,
        jacek.anaszewski@gmail.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 7, 2022 at 5:56 PM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
>
> This version of devm_of_led_get() doesn't fail if a LED is not found.
> Instead it returns a NULL pointer.

Yep, thanks!

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> ---
>  drivers/leds/led-class.c | 25 +++++++++++++++++++++++++
>  include/linux/leds.h     |  2 ++
>  2 files changed, 27 insertions(+)
>
> diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
> index 2c0d979d0c8a..2fea79a2300d 100644
> --- a/drivers/leds/led-class.c
> +++ b/drivers/leds/led-class.c
> @@ -295,6 +295,31 @@ struct led_classdev *__must_check devm_of_led_get(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(devm_of_led_get);
>
> +/**
> + * devm_of_led_get_optional - Resource-managed request of an optional LED device

I'm not sure we need to keep "_of" here in the name, but it's not
harmful anyway.

> + * @dev:       LED consumer
> + * @index:     index of the LED to obtain in the consumer
> + *
> + * The device node of the device is parse to find the request LED device.

I guess you copy'n'pasted this, but this has some spelling issues, I
would change

parse --> parsed
request --> requested

> + * The LED device returned from this function is automatically released
> + * on driver detach.
> + *
> + * @return a pointer to a LED device, ERR_PTR(errno) on failure and NULL if the
> + * led was not found.
> + */
> +struct led_classdev *__must_check devm_of_led_get_optional(struct device *dev,
> +                                                       int index)
> +{
> +       struct led_classdev *led;
> +
> +       led = devm_of_led_get(dev, index);
> +       if (IS_ERR(led) && PTR_ERR(led) == -ENOENT)
> +               return NULL;
> +
> +       return led;
> +}
> +EXPORT_SYMBOL_GPL(devm_of_led_get_optional);
> +
>  static int led_classdev_next_name(const char *init_name, char *name,
>                                   size_t len)
>  {
> diff --git a/include/linux/leds.h b/include/linux/leds.h
> index ba4861ec73d3..41df18f42d00 100644
> --- a/include/linux/leds.h
> +++ b/include/linux/leds.h
> @@ -215,6 +215,8 @@ extern struct led_classdev *of_led_get(struct device_node *np, int index);
>  extern void led_put(struct led_classdev *led_cdev);
>  struct led_classdev *__must_check devm_of_led_get(struct device *dev,
>                                                   int index);
> +struct led_classdev *__must_check devm_of_led_get_optional(struct device *dev,
> +                                                 int index);
>
>  /**
>   * led_blink_set - set blinking with software fallback
> --
> 2.25.1
>


-- 
With Best Regards,
Andy Shevchenko
