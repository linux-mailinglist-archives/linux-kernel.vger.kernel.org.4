Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6223B6BABE6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjCOJQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjCOJQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:16:17 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9A61F912;
        Wed, 15 Mar 2023 02:16:16 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id j10so6466788qkg.12;
        Wed, 15 Mar 2023 02:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678871775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzIIgw7yN+Q6/b/qd+jJvK07cHovtHSbs9Wq8woUHy0=;
        b=egT23glLgty1DpOum/hx1NeUXuD+cEBHJF5ecFDE5WLTVfuD1XruLvqv5pN30UbRil
         JsWxI85ibZ/VJZAbTbsL9nOD11P0Ib5v6AGRYGEniBWXF0gFp3qEcF5a2YK4iuyYh7Hd
         HURvJg/JrTcGF1Zf6OpQlFjBin5mvxCIMmlflLMXP1rW0fUpkovBqXW+4gWIqX46AhaG
         IqLot3gRb1oP/LkYgOitoHK2b7q9qnXSPFyCwUihjOT6exCjxox71z/ZDPiJvmdZkt1s
         X7O3Yudhkw+a8LqmOUbVZxaYmsL5QNjYDyrGBzBnDtbyxzahOWllqcgAjkqSq0W+KIaF
         w3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678871775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LzIIgw7yN+Q6/b/qd+jJvK07cHovtHSbs9Wq8woUHy0=;
        b=TOc513srDCjWE7cQOM/7S8kBBwrqUHQa6zquohpAwtmzCSgucM8CryYH4v8z7H1YNE
         xmKWNdhTXfniI6GRfa+fVOyIEFkzYlv+m4EbGRuk3lXhoabp2xz1SAoxnmWsVqsBondK
         4+m40kF5o6uzQuBHNyWmMKxU//KWIGpaBBppLlmMKWtlz8Z6x+Ts4MkFsOT7v528WdVF
         JXbQ3khXnN012NR4TablOHjt7mHc4r2/EpxTKSBO3/uTKoECbLzW99W2D+F8EjwmYEw9
         jguxfHh00m6PxvB8etujFFBxkbbtUf6oC7eB2lRUjAeup7nXGwt5KO/qZ/u6JgadMugH
         +eEA==
X-Gm-Message-State: AO0yUKVJLYwP9zfDntUxjUB2lv1PiTTElvfgR4azkIbJreIsBFp1u6t8
        6SSeNCruBlt4Eb0jNSkB3A7p346w8oU6SuwtitbVJJtvnOQ=
X-Google-Smtp-Source: AK7set8slAWSdnWlrDBWh7O9CO9qc2Hdj8pKVtV4pKnWrGF1NsT4Q1T9Z+jea0Jh7qQdYQ0Xmr624v4o8OS8KcIrWCM=
X-Received: by 2002:a37:6407:0:b0:745:bd3d:51df with SMTP id
 y7-20020a376407000000b00745bd3d51dfmr1548293qkb.3.1678871775668; Wed, 15 Mar
 2023 02:16:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230314221609.22433-1-asmaa@nvidia.com> <20230314221609.22433-2-asmaa@nvidia.com>
In-Reply-To: <20230314221609.22433-2-asmaa@nvidia.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 15 Mar 2023 11:15:38 +0200
Message-ID: <CAHp75Vd5NhPcgUokJ0i8ftqVXjSB10q4VfxH9A7wcYhei-s2wA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] gpio: gpio-mlxbf3: Add gpio driver support
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 12:16=E2=80=AFAM Asmaa Mnebhi <asmaa@nvidia.com> wr=
ote:
>
> Add support for the BlueField-3 SoC GPIO driver.
> This driver configures and handles GPIO interrupts. It also enables a use=
r
> to manipulate certain GPIO pins via libgpiod tools or other kernel driver=
s.
> The usables pins are defined via the "gpio-reserved-ranges" property.

Thank you for the update, my comments below.

...

> +         This controller should be used in parallel with pinctrl-mlxbf t=
o
> +         control the desired gpios.

GPIOs

Btw, have you considered renaming that driver to pinctrl-mlxbf3?

...

> +#include <linux/resource.h>

I dunno why you added this one.

The missing ones are:
err.h
io.h

...

> +       raw_spin_lock_irqsave(&gs->gc.bgpio_lock, flags);
> +       gpiochip_enable_irq(gc, offset);

No need to call this under the spin lock, or must be explained why.

> +       writel(BIT(offset), gs->gpio_cause_io + MLXBF_GPIO_CAUSE_OR_CLRCA=
USE);
> +
> +       val =3D readl(gs->gpio_cause_io + MLXBF_GPIO_CAUSE_OR_EVTEN0);
> +       val |=3D BIT(offset);
> +       writel(val, gs->gpio_cause_io + MLXBF_GPIO_CAUSE_OR_EVTEN0);
> +       raw_spin_unlock_irqrestore(&gs->gc.bgpio_lock, flags);

...

> +       raw_spin_lock_irqsave(&gs->gc.bgpio_lock, flags);
> +       val =3D readl(gs->gpio_cause_io + MLXBF_GPIO_CAUSE_OR_EVTEN0);
> +       val &=3D ~BIT(offset);
> +       writel(val, gs->gpio_cause_io + MLXBF_GPIO_CAUSE_OR_EVTEN0);
> +       gpiochip_disable_irq(gc, offset);

Ditto.

> +       raw_spin_unlock_irqrestore(&gs->gc.bgpio_lock, flags);
> +}

...

> +/* This function needs to be defined for handle_edge_irq */

handle_edge_irq()

...

> +static const struct acpi_device_id __maybe_unused mlxbf3_gpio_acpi_match=
[] =3D {

Why __maybe_unused?

> +       { "MLNXBF33", 0 },
> +       {}
> +};

--=20
With Best Regards,
Andy Shevchenko
