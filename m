Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1056296F3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiKOLPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiKOLOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:14:49 -0500
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6724F48;
        Tue, 15 Nov 2022 03:13:31 -0800 (PST)
Received: by mail-qk1-f178.google.com with SMTP id d7so6836355qkk.3;
        Tue, 15 Nov 2022 03:13:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=shAcRWILAJm2cGLIIwi6blyQz3hyqXRRFwP8TwIT5YM=;
        b=aLi+373dOeQ/WxPGp6l+pOD1OwLniHqgDAHvxAtDENaFnYVt0RBaM2TD/4QLm4dxft
         wmMbrMysZZl8/rDtkfZ2NDbOVtbwlk0l3pm5IQSj15+P+4jyWS6YJprUQE8YTcjUBmiJ
         xhVKijgFcx2Mqm26hBMfIKNnC24NKZitNRzIzuxY9x/bqrfR9g7NaLulG6pFIUZmDJRK
         wy7UIgxq9ds5len3FcRz+cdPu8I5dl96Uqpfv4CjxhLxspQx1RJDWOg7Kah+/7MQrXn9
         8YByLyaMmWIUjnZvK6r1K43FoQ9xeeeI40Fnim1ZEGfOkO86w7b9NbKI8w6x4KtmcOOZ
         X1xQ==
X-Gm-Message-State: ANoB5pmEphq8ImDb0FcZ/gxQQ4CSWSX5N5g/f4Heo9KGR7pGqHN6TRWQ
        niuQbaqhHCmyg7Nt1WE/zMQhRwpoIxLHtw==
X-Google-Smtp-Source: AA0mqf6f9ZsvBZAdCxTzJ9dRy//nVOhWUWAC+8B8u9LxFd33aESiktDN7jwY3hb/vASYkx8DZSOR8A==
X-Received: by 2002:ae9:e30d:0:b0:6f1:187c:8f79 with SMTP id v13-20020ae9e30d000000b006f1187c8f79mr14316594qkf.593.1668510810714;
        Tue, 15 Nov 2022 03:13:30 -0800 (PST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id ay40-20020a05620a17a800b006cbe3be300esm8015104qkb.12.2022.11.15.03.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 03:13:30 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-3704852322fso133635577b3.8;
        Tue, 15 Nov 2022 03:13:29 -0800 (PST)
X-Received: by 2002:a81:4dc3:0:b0:370:61f5:b19e with SMTP id
 a186-20020a814dc3000000b0037061f5b19emr16542249ywb.316.1668510809441; Tue, 15
 Nov 2022 03:13:29 -0800 (PST)
MIME-Version: 1.0
References: <20221111113732.461881-1-thierry.reding@gmail.com>
In-Reply-To: <20221111113732.461881-1-thierry.reding@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 15 Nov 2022 12:13:17 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW0uEaiigpsR+-qh=p508bKwaymau0TBDEo45dxfvQPaA@mail.gmail.com>
Message-ID: <CAMuHMdW0uEaiigpsR+-qh=p508bKwaymau0TBDEo45dxfvQPaA@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: of: Use correct fwnode for DT-probed chips
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

On Fri, Nov 11, 2022 at 12:40 PM Thierry Reding
<thierry.reding@gmail.com> wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> The OF node store in chip->fwnode is used to explicitly override the FW
> node for a GPIO chip. For chips that use the default FW node (i.e. that
> of their parent device), this will be NULL and cause the chip not to be
> fully registered.
>
> Instead, use the GPIO device's FW node, which is set to either the node
> of the parent device or the explicit override in chip->fwnode.
>
> Fixes: 8afe82550240 ("gpiolib: of: Prepare of_gpiochip_add() / of_gpiochip_remove() for fwnode")

Thank you, I bisected boot failures on Renesas platforms to that
commit, and then found your patch.

> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

> ---
>  drivers/gpio/gpiolib-of.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index 4be3c21aa718..55c3712592db 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -1067,7 +1067,7 @@ int of_gpiochip_add(struct gpio_chip *chip)
>         struct device_node *np;
>         int ret;
>
> -       np = to_of_node(chip->fwnode);
> +       np = to_of_node(dev_fwnode(&chip->gpiodev->dev));
>         if (!np)
>                 return 0;
>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
