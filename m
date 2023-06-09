Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75CF72909B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237142AbjFIHLX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 9 Jun 2023 03:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjFIHLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:11:19 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867802718;
        Fri,  9 Jun 2023 00:11:18 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-565f1145dc8so13012007b3.1;
        Fri, 09 Jun 2023 00:11:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686294677; x=1688886677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i4OrpWTk4CwSjK0GHc2r2JMDUni0s50dMtpQAaHpA7g=;
        b=bPpV1HIOhFUKLAggEplybsd57Oh+F/pfXLxu/oS9tQyHHjT/P8tCnL4HySxc3Clvik
         g6765Od4KcirIDPSHyfKhA1sErFyhvnhuJVawBbFi/cXXb82l0gLh+UF9iTKoXqqxUb1
         bdZZDOjAob2zeGdTDqNHz6SLcYK4829nJXhcXPFrhs1QGMWPJr5TIssfvQZ8TWa7lmGE
         qvsKa9mfl0wLd6NSfOlcD1mlaPh4ABg4YAETKjLZjtbqfYgGmWClr1HaHF2uIAEjrQYH
         UWO97AOZgvejXETysFQyklVLXEv1gMqopVD+Ue1mn9Tud0fJXNX67dL4aCNJdD6h5mUt
         kShA==
X-Gm-Message-State: AC+VfDyYT+4/UUBR4uSik3QOoyB3gXA1GKXwRVW4voOZMX6pk9gtEBK+
        zjPDz4p3zXYlHYX1X0ePusXTnq966bsbqA==
X-Google-Smtp-Source: ACHHUZ7pI32BhlDdFsOKfNEmU+VzqakjCA4zSNMRiFV8QHw24vFV4ZAg9lBjOlEX65WvNJv6cB2Yzw==
X-Received: by 2002:a0d:db4a:0:b0:56a:3b3e:bc6 with SMTP id d71-20020a0ddb4a000000b0056a3b3e0bc6mr550344ywe.14.1686294677486;
        Fri, 09 Jun 2023 00:11:17 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id x142-20020a0dd594000000b00559fb950d9fsm446460ywd.45.2023.06.09.00.11.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 00:11:16 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-565f1145dc8so13011837b3.1;
        Fri, 09 Jun 2023 00:11:16 -0700 (PDT)
X-Received: by 2002:a25:2fd5:0:b0:b9a:7cfe:9bed with SMTP id
 v204-20020a252fd5000000b00b9a7cfe9bedmr454382ybv.14.1686294676577; Fri, 09
 Jun 2023 00:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230608162130.55015-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230608162130.55015-1-andriy.shevchenko@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 9 Jun 2023 09:11:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXhcR0MTVVpm-2PiSZkCc+BnU6oEp_aVRj+rqvBbWLHMA@mail.gmail.com>
Message-ID: <CAMuHMdXhcR0MTVVpm-2PiSZkCc+BnU6oEp_aVRj+rqvBbWLHMA@mail.gmail.com>
Subject: Re: [rfc, rft, PATCH v1 1/1] gpio: aggregator: Introduce delay
 support for individual output pins
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Alexander Stein <linux@ew.tq-group.com>
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

On Thu, Jun 8, 2023 at 6:23 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> The aggregator mode can also handle properties of the platform, that
> do not belong to the GPIO controller itself. One of such a property
> is signal delay line. Intdoduce support of it.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>
> I don't like the idea of gpio-delay or similar. We have already GPIO
> aggregator that incorporates the GPIO proxy / forwarder functionality.

I think this makes sense.

> --- a/drivers/gpio/gpio-aggregator.c
> +++ b/drivers/gpio/gpio-aggregator.c

> @@ -333,11 +341,28 @@ static int gpio_fwd_get_multiple_locked(struct gpio_chip *chip,
>  static void gpio_fwd_set(struct gpio_chip *chip, unsigned int offset, int value)
>  {
>         struct gpiochip_fwd *fwd = gpiochip_get_data(chip);
> +       const struct gpiochip_fwd_timing *delay_timings;
> +       struct gpio_desc *desc = fwd->descs[offset];
> +       bool is_active_low = gpiod_is_active_low(desc);
> +       bool ramp_up;
>
> -       if (chip->can_sleep)
> -               gpiod_set_value_cansleep(fwd->descs[offset], value);
> -       else
> -               gpiod_set_value(fwd->descs[offset], value);
> +       delay_timings = &fwd->delay_timings[offset];
> +       ramp_up = (!is_active_low && value) || (is_active_low && !value);
> +       if (chip->can_sleep) {
> +               gpiod_set_value_cansleep(desc, value);
> +
> +               if (ramp_up && delay_timings->ramp_up_us)
> +                       fsleep(delay_timings->ramp_up_us);
> +               if (!ramp_up && delay_timings->ramp_down_us)
> +                       fsleep(delay_timings->ramp_down_us);
> +       } else {
> +               gpiod_set_value(desc, value);
> +
> +               if (ramp_up && delay_timings->ramp_up_us)
> +                       udelay(delay_timings->ramp_up_us);
> +               if (!ramp_up && delay_timings->ramp_down_us)
> +                       udelay(delay_timings->ramp_down_us);

I hope no one ever needs to use the values from the example in the
bindings

    enable-gpios = <&enable_delay 0 130000 30000>;

on a non-sleepable GPIO. Not only is a looping delay of 130 ms very bad
for system responsiveness, such large delays may not even be supported
on all systems (e.g. ARM implementation says < 2 ms).
So for large values, this should use mdelay().

This also applies to gpio-delay, of course.

> +       }
>  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
