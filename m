Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD1C731BE0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345128AbjFOOyj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 15 Jun 2023 10:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344980AbjFOOya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:54:30 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CD0273D;
        Thu, 15 Jun 2023 07:54:29 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-bb167972cffso1825933276.1;
        Thu, 15 Jun 2023 07:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686840868; x=1689432868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pSYZW9Ic0ZUjs7I0R7WkG+kButHO3oEwKmEXzQ8pRqY=;
        b=k7UtgOpcgLzMTA6nB8gRrHmYHidsuUhknM0yVsqeoum24+qmkpoRBFhEYdw53joGav
         hs5fW88/1/B4Ez/FKjCFCXBZ9Lw9EzBNY3jv9fSnTFwyJn+vaJ5hAvhtuaD6tf65Jgq+
         YwRcgPpHBAaZlK0a2ROr0BnEgWDnTyo5uCJ0AyQhwGmBJR9VNHAR3NJAlhwZtqfA/L9P
         +0NeGRz+ohDQkScPkDWyNPpI+K7N3Vfb1NAqAoZaempyLdiQY1GUwIidoYu2M1ahDPcR
         YtC0bznxzSTLqp15qsB1I340Na8F/WLrrJv+OkTYVDcjQWWuIV9Txu1cOt1KEpknLWQF
         1acA==
X-Gm-Message-State: AC+VfDyYvYUd9OPSPWT7lOJjGtfjoxJfWupRj86TmiFjNE1NA4CQt40R
        sTVtlGxeRhKIp/0d6w+oeFqFKzOEkez4ig==
X-Google-Smtp-Source: ACHHUZ4P3Cv+HaI+1JkcQ7Bq0adMusjtvhtlT/9+7HGkS8on9LM3vKfcDlRW7kZqjMI7Nq41w1YQRg==
X-Received: by 2002:a25:e056:0:b0:bc2:b993:848f with SMTP id x83-20020a25e056000000b00bc2b993848fmr5145534ybg.35.1686840868448;
        Thu, 15 Jun 2023 07:54:28 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id d17-20020a258891000000b00b99768e3b83sm3982828ybl.25.2023.06.15.07.54.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 07:54:28 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-57045429f76so4856297b3.0;
        Thu, 15 Jun 2023 07:54:27 -0700 (PDT)
X-Received: by 2002:a81:d34f:0:b0:56d:2bab:947e with SMTP id
 d15-20020a81d34f000000b0056d2bab947emr5000726ywl.43.1686840867726; Thu, 15
 Jun 2023 07:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230615132023.13801-1-andriy.shevchenko@linux.intel.com> <20230615132023.13801-4-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230615132023.13801-4-andriy.shevchenko@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 15 Jun 2023 16:54:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVAwKCUnOeuz_PE6ijtfTVf8a3rTQZ=JvThOmqytu5HCA@mail.gmail.com>
Message-ID: <CAMuHMdVAwKCUnOeuz_PE6ijtfTVf8a3rTQZ=JvThOmqytu5HCA@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] gpio: aggregator: Prevent collisions between DT
 and user device IDs
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thanks for your patch!

On Thu, Jun 15, 2023 at 3:51 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> In case we have a device instantiated via DT or other means than
> via new_device sysfs node, the collision with the latter is possible.
> Prevent such collisions by allocating user instantiated devices with
> higher IDs, currently set to 1024.

Can you please elaborate? How exactly is this possible?

Aggregators instantiated through sysfs are named "gpio-aggregator.<n>",
and are IDR-based.
Aggregators instantiated from DT are named "<unit-address>.<node-name>".
How can this conflict? When instantiated from ACPI?
What am I missing?

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> --- a/drivers/gpio/gpio-aggregator.c
> +++ b/drivers/gpio/gpio-aggregator.c
> @@ -26,6 +26,7 @@
>  #include <linux/gpio/driver.h>
>  #include <linux/gpio/machine.h>
>
> +#define AGGREGATOR_MIN_DEVID 1024
>  #define AGGREGATOR_MAX_GPIOS 512
>
>  /*
> @@ -135,7 +136,7 @@ static ssize_t new_device_store(struct device_driver *driver, const char *buf,
>         }
>
>         mutex_lock(&gpio_aggregator_lock);
> -       id = idr_alloc(&gpio_aggregator_idr, aggr, 0, 0, GFP_KERNEL);
> +       id = idr_alloc(&gpio_aggregator_idr, aggr, AGGREGATOR_MIN_DEVID, 0, GFP_KERNEL);

Iff this would solve an issue, it would be only temporarily, until someone
instantiates 1024 aggregators through some other means ;-)

>         mutex_unlock(&gpio_aggregator_lock);
>
>         if (id < 0) {

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
