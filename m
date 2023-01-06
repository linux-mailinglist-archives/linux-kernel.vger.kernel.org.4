Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D35660101
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 14:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjAFNOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 08:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjAFNOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 08:14:39 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E5045656
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 05:14:38 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id a64so1421193vsc.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 05:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kRSichjsSpl7nn5VML7hlKwtWCxMGkZW9sF0ceCpu7Y=;
        b=7nOV/pGUMtVuAg1wKzMZoJfLp+ifawDysT1k1gSKBnWNmZxkNlDd+a9s4ja2CzEzdJ
         ewZnZ2O3WCbXCqHy6TZO/py3dGt2C+U7slBz7sP6qeoaOzc39Uuz5nGDLtwc3m099+Ba
         8Z9AHA/Cb6lncQEDvS6LzH3vDS3i79asj/1VypjVxg7qQuTGxAaWiuKvNl+4D6R1wmoK
         OHQYm1kXGZLLPW4mskl74LpBC2/eb1aYTC7BRu+SGUu/B84EQC58uVxczdDUNbnVT+ic
         QyYkKm88vf1vmOk4xMsEfWHHXrDXOXxha6SDlhxu4IBkwSrD7qs2X0/OdJai0afC9zxV
         Zs1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kRSichjsSpl7nn5VML7hlKwtWCxMGkZW9sF0ceCpu7Y=;
        b=dZhMoaQT1mRcg2NqynxpBTcJaz7TGIBfkEWJgRPOXZzSL7vKdmT3XIvHopKL6ShE+i
         mQdx2cPW+ALD6HSwBt9v6qdCKUishi0wGhI/izVLpuQGC66SHd4EtzNKLgUnxsp7Dphz
         SIzpDWbdqjsyP1NlN0e6OLig9+BKWlXnkCAoA+8fmdMGAMpB4/x9jVYpwYj/SqFgWpc+
         1CWiO/XSgI55m4ikDLH4OsM2TXn47SfDPFdS47BYdGUNILT5A1mBwwR9gqnZ8tz8iaNl
         Vg+rvwa+vM92ZVORdms3DM0beVFkxiuH1+jSRI+lZsPER7Nu5f86oFJAAFV88awG73BI
         XV0g==
X-Gm-Message-State: AFqh2krBiRSQ2IeExxWwpj6XynRlfslKV/BMBEdMMgeLeVT/r/I26LoE
        yudkSEjY2C/9IM4UqRICCG1ZeJ0zpvpJoi+4KXIrtg==
X-Google-Smtp-Source: AMrXdXu7UBvoVaA3py91tPW1+5NfFOXh7jkcGj9+qlFVxuoA0psBokCY/DlLkdH01j7W9wipaLbbX/zr3ecBEiacoO4=
X-Received: by 2002:a67:f642:0:b0:3c4:ec4b:b943 with SMTP id
 u2-20020a67f642000000b003c4ec4bb943mr6737873vso.17.1673010877549; Fri, 06 Jan
 2023 05:14:37 -0800 (PST)
MIME-Version: 1.0
References: <20230105150603.2810510-1-michael@walle.cc>
In-Reply-To: <20230105150603.2810510-1-michael@walle.cc>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 6 Jan 2023 14:14:26 +0100
Message-ID: <CAMRc=McEin9uXOFEeB1=oDKmUTu+hvKoaUGjCx-7Prc7RXubJw@mail.gmail.com>
Subject: Re: [PATCH RESEND] gpio: regmap: use new regmap_might_sleep()
To:     Michael Walle <michael@walle.cc>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 5, 2023 at 4:06 PM Michael Walle <michael@walle.cc> wrote:
>
> Now that the regmap can be queried whether it might sleep, we can get
> rid of the conservative setting "can_sleep = true". New drivers which
> want to use gpio-regmap and can access the registers memory-mapped won't
> have the restriction that their consumers have to use the
> gpiod_*cansleep() variants anymore.
>
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/gpio/gpio-regmap.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
> index f907c9c19fce..fca17d478984 100644
> --- a/drivers/gpio/gpio-regmap.c
> +++ b/drivers/gpio/gpio-regmap.c
> @@ -254,15 +254,7 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
>         chip->ngpio = config->ngpio;
>         chip->names = config->names;
>         chip->label = config->label ?: dev_name(config->parent);
> -
> -       /*
> -        * If our regmap is fast_io we should probably set can_sleep to false.
> -        * Right now, the regmap doesn't save this property, nor is there any
> -        * access function for it.
> -        * The only regmap type which uses fast_io is regmap-mmio. For now,
> -        * assume a safe default of true here.
> -        */
> -       chip->can_sleep = true;
> +       chip->can_sleep = regmap_might_sleep(config->regmap);
>
>         chip->get = gpio_regmap_get;
>         if (gpio->reg_set_base && gpio->reg_clr_base)
> --
> 2.30.2
>

Applied, thanks!

Bart
