Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC57966B923
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 09:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbjAPIiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 03:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbjAPIiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 03:38:15 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC72CC02
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 00:38:14 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id i185so28333217vsc.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 00:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=55ylo4QA2CaqLzL7CkyGNxJVenH2KK56GDg8IKBuTQM=;
        b=M84BtYPXkppktUdcm4COHXtqJrKlgGrsInsukvff6NymdkuYX39pF0KhLgxzSxdpQG
         XS3NsOndmHHtdH4S6I97/JhCeJ8Z2VEHJvb8n+/xNQ4KygKw5B7mbMThO9JdSX1xxHzd
         IBL9oRUNOplbtd1vSFN9QBQ6STRQAskTe1jzOs3zcLMHdtn1P1ad5C/DoI0deq93s9wL
         EivsMtOQKxC92k2AEc5WM3uef0lXUF8b/IavhtLpBZKPGdeqbY8DnxxZDXCo/dOTGwGW
         YFhW1IcHU02PeQdUwKx7kPoWeo32BDZ9deIK7J7BfD6RorltvJFDzVKwP6A9SaKUmmVf
         cnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=55ylo4QA2CaqLzL7CkyGNxJVenH2KK56GDg8IKBuTQM=;
        b=1BZVpEJ4rPTQO7bwvOTKlmfVTKMnQuPlT4PIr75ZWPJl7vZqhPFkoFEwSq2WyNKxho
         bKjtJ3G8owBmNKeWUAKFWdnanq6Xut4KXK23tN7OlKrJSoSlH2EDgUyeDZUkjFieZcxx
         +7hHmTW4KFeMfCT3roKBnZ0ZzO90PlTc91ZCawKsqP8vJTVW8erLrpJGKu66ziKzQFvH
         fUTtE5HGt6RRs7FRf6Qw0PzDI3yUQJ84e/mGqaGJkUsNRLeqU4vq3vmHBSPl9E1Vj1zy
         cozs6QjF7u4gtnDBclHaA0pD+84CTBVU4fcfBb+DVi8LiIVToXHWcCp04OkBerqiYzJs
         IqdQ==
X-Gm-Message-State: AFqh2kokt9GWYZJmpTovRBK3NAhqzIf0sRtY28baxecdB0daeiuaka/u
        5p4eYiMaWcNSpzavq9QfTUH1LlWl1X3CLVG4ujEXzyn0mNGKgA==
X-Google-Smtp-Source: AMrXdXsVSfp5doi7+lR/ANoXc3k1b1awjO1u8RDetJnzyM+m53fSWwvRcTK7nrhs8zRASOtIU6ZOJ1Fo6iYKTHgNZAo=
X-Received: by 2002:a05:6102:1141:b0:3d2:3577:2d05 with SMTP id
 j1-20020a056102114100b003d235772d05mr811406vsg.9.1673858293353; Mon, 16 Jan
 2023 00:38:13 -0800 (PST)
MIME-Version: 1.0
References: <20230113205922.2312951-1-andreas@kemnade.info>
In-Reply-To: <20230113205922.2312951-1-andreas@kemnade.info>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 16 Jan 2023 09:38:02 +0100
Message-ID: <CAMRc=Mf4-8AfTHLrvaF14tc2TJatxZJWnMOF-1G8HmDhPKSFAw@mail.gmail.com>
Subject: Re: [PATCH] gpio: omap: use dynamic allocation of base
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org,
        linus.walleij@linaro.org, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 9:59 PM Andreas Kemnade <andreas@kemnade.info> wrote:
>
> Static allocatin is deprecated and may cause probe mess,
> if probe order is unusual.
>
> like this example
> [    2.553833] twl4030_gpio twl4030-gpio: gpio (irq 145) chaining IRQs 161..178
> [    2.561401] gpiochip_find_base: found new base at 160
> [    2.564392] gpio gpiochip5: (twl4030): added GPIO chardev (254:5)
> [    2.564544] gpio gpiochip5: registered GPIOs 160 to 177 on twl4030
> [...]
> [    2.692169] omap-gpmc 6e000000.gpmc: GPMC revision 5.0
> [    2.697357] gpmc_mem_init: disabling cs 0 mapped at 0x0-0x1000000
> [    2.703643] gpiochip_find_base: found new base at 178
> [    2.704376] gpio gpiochip6: (omap-gpmc): added GPIO chardev (254:6)
> [    2.704589] gpio gpiochip6: registered GPIOs 178 to 181 on omap-gpmc
> [...]
> [    2.840393] gpio gpiochip7: Static allocation of GPIO base is deprecated, use dynamic allocation.
> [    2.849365] gpio gpiochip7: (gpio-160-191): GPIO integer space overlap, cannot add chip
> [    2.857513] gpiochip_add_data_with_key: GPIOs 160..191 (gpio-160-191) failed to register, -16
> [    2.866149] omap_gpio 48310000.gpio: error -EBUSY: Could not register gpio chip
>
> So probing was done in an unusual order, causing mess
> and chips not getting their gpio in the end.
>
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> maybe CC stable? not sure about good fixes tag.
>
>  drivers/gpio/gpio-omap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 80ddc43fd875..f5f3d4b22452 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1020,7 +1020,7 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc,
>                 if (!label)
>                         return -ENOMEM;
>                 bank->chip.label = label;
> -               bank->chip.base = gpio;
> +               bank->chip.base = -1;
>         }
>         bank->chip.ngpio = bank->width;
>
> --
> 2.30.2
>

This could potentially break some legacy user-space programs using
sysfs but whatever, let's apply it and see if anyone complains.

Bart
