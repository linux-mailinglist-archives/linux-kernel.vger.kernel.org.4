Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2AD659A3D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 16:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbiL3P4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 10:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbiL3Pz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 10:55:57 -0500
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DE021B2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 07:55:55 -0800 (PST)
Received: by mail-vk1-xa2b.google.com with SMTP id b81so10254067vkf.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 07:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o7zb+TjyOCJ5Qv3IrJ07U93Hor1hao+xRRIpVMTYJ34=;
        b=sXRZXJyjtqPl1pLLhxIM2Bprko/93NJCyv2iToSKUrcfMjnYapW/R8FMjoDC4muljW
         PcmInvjhlsB/i6PAMqPcVxgyPvhFNCSaCXxCcdCiYVGeYlLN/rtnWbIsqfw3ixJNphs8
         o2E5ImzHY/f1xcxvc68UV541Z+4AUZqfxfWMap9wy+j+Bz6j/0U5K7wyo+Bpr3RmCdx0
         OR2NQP/XJ5+EO0NmEEblkiYGbFJYWj2tRmrMjVZRuXb58TDQE4gyd4mkPPdOOpJboEUa
         3b9cjZRogQLLKfvJlxf3CE+RQeRdVZGgqxNjt2uwRYZ97rz3ULcu000PiWT3oQfYGGZs
         1zNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o7zb+TjyOCJ5Qv3IrJ07U93Hor1hao+xRRIpVMTYJ34=;
        b=x3S572JvxRZ6cl4P5vzAluzYWI3OU0xSPP0CnRQD26hGLFCXcgEyZw7KHov1aPd9Ms
         q+7hym2bqQy/gYzSnAJYNBB5yKWEKKFj53h7i0wV+u3JUcQHsVHgEMkbO8tSbRoPaLrT
         nZCBzQSn3GbQrPQarzJvohT+DFmFYC/rRgDY6s3P8+A3KMrrRBUBjDM1TT4rt4DY6ZmC
         JUHpRD0cXtQ/DiybWzKIZD8DWuffSDyRT1PDmn9aUxddsTEJL44Xf/iSOUWFBs9aq4iV
         oa/pb9E84FdbnPFv6j2GxARQFOmXJtblpXXBYBg0DzsvtLg6K9IXor5YI/akFLrKsFrs
         7cCQ==
X-Gm-Message-State: AFqh2koOaX1snJOQaYctMBpCAz12V7SRCM4pd5N1Wg5h5Xg7r45+4kws
        Nd4/Ux8ChZE+yx3mRQ6ZZxS1HQj4l3wRM5/x/qqLPmbB4Ldy1Q==
X-Google-Smtp-Source: AMrXdXuykR6UjtrhR8E0rPTCaSKn77+wJWJFDWSlNmnqsysrri8SrWgpPgnvpWQ+tLAKGdS12NC0U2QDLuurNt7NZrc=
X-Received: by 2002:ac5:c382:0:b0:3bd:e0b8:e350 with SMTP id
 s2-20020ac5c382000000b003bde0b8e350mr3545220vkk.25.1672415755006; Fri, 30 Dec
 2022 07:55:55 -0800 (PST)
MIME-Version: 1.0
References: <20221219192016.1396950-1-dmitry.torokhov@gmail.com>
In-Reply-To: <20221219192016.1396950-1-dmitry.torokhov@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 30 Dec 2022 16:55:44 +0100
Message-ID: <CAMRc=Mdp39GpD8XJO4U5rJiU7t-C6jeNs37sp_JyKEaGf6y6rA@mail.gmail.com>
Subject: Re: [PATCH 1/5] gpiolib: of: remove of_gpio_count()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 8:20 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> There are no more users of of_gpio_count() in the mainline kernel,
> remove it.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>
> After 6.2-rc1 there should be no more users of the APIs mentioned in
> this series.
>
>  include/linux/of_gpio.h | 11 -----------
>  1 file changed, 11 deletions(-)
>
> diff --git a/include/linux/of_gpio.h b/include/linux/of_gpio.h
> index 6db627257a7b..39f16a960565 100644
> --- a/include/linux/of_gpio.h
> +++ b/include/linux/of_gpio.h
> @@ -105,17 +105,6 @@ static inline int of_gpio_named_count(const struct device_node *np,
>         return of_count_phandle_with_args(np, propname, "#gpio-cells");
>  }
>
> -/**
> - * of_gpio_count() - Count GPIOs for a device
> - * @np:                device node to count GPIOs for
> - *
> - * Same as of_gpio_named_count, but hard coded to use the 'gpios' property
> - */
> -static inline int of_gpio_count(const struct device_node *np)
> -{
> -       return of_gpio_named_count(np, "gpios");
> -}
> -
>  static inline int of_get_gpio_flags(const struct device_node *np, int index,
>                       enum of_gpio_flags *flags)
>  {
> --
> 2.39.0.314.g84b9a713c41-goog
>

I applied the entire series, thanks a lot for doing that!

Bart
