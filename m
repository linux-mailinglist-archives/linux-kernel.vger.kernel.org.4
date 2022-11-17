Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6004162D919
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239241AbiKQLK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239821AbiKQLKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:10:06 -0500
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469D351328;
        Thu, 17 Nov 2022 03:09:24 -0800 (PST)
Received: by mail-qk1-f175.google.com with SMTP id k4so876777qkj.8;
        Thu, 17 Nov 2022 03:09:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2upcs92zfHGktv5GNk5iEF5H7csK3b8TJwFhjPNnSO0=;
        b=PUnUKD8suTSfxsdSC7i5AwKDWJu0WSWIsrvv/MxC0ysFKMAOUlKw4VnsXVVfp6m/0w
         1h/kU0z0l4jnam1tkOcd+X5KAhWoIJCWp7aTbMgGqNXfJNQIEnUg/tdDce4++WVYh8uY
         8pb7XXM6dcghAk1ja/Mx6pgjCofmTB/F94WD3hbdVrgf9oJusoPXEeKYreKPfcou5M8d
         EFPvVs+Gzf2VW/R/zsytbywEf4rSGZ3lhZG7FQ8dPPjRRTxavwZbHimZM5Oafas8Nk3O
         99+n727dltIH65SqK4EUCBlbaMv5GxBDYIxBWfAqdXanjKnDCbGoJpURtEA4dvhCuBX7
         F1Rw==
X-Gm-Message-State: ANoB5pkvwjIqeKCCxkRK5nkGIifQlpIjijpgWVHtSunccvDxTk41QHve
        OGAFdybHOFqIPjtbe280rggyAj3YUoihag==
X-Google-Smtp-Source: AA0mqf6v6w1P4R8JnDjLVm4zuWA1AytWJdlmMGCh9w8oRthjj4C9SdeHG91RJYfGF6KbKT3djEyl1w==
X-Received: by 2002:a37:ad0c:0:b0:6ee:91b3:2484 with SMTP id f12-20020a37ad0c000000b006ee91b32484mr1076992qkm.648.1668683363904;
        Thu, 17 Nov 2022 03:09:23 -0800 (PST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id cc16-20020a05622a411000b003a606428a59sm187236qtb.91.2022.11.17.03.09.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 03:09:23 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-381662c78a9so15324287b3.7;
        Thu, 17 Nov 2022 03:09:22 -0800 (PST)
X-Received: by 2002:a81:f80f:0:b0:38e:e541:d8ca with SMTP id
 z15-20020a81f80f000000b0038ee541d8camr1380062ywm.283.1668683362483; Thu, 17
 Nov 2022 03:09:22 -0800 (PST)
MIME-Version: 1.0
References: <20221107175305.63975-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221107175305.63975-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221107175305.63975-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 17 Nov 2022 12:09:11 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW9K=gd7F-G-7v0J5Mz8jyZa_Vu3UZWsNZin76tff7f3g@mail.gmail.com>
Message-ID: <CAMuHMdW9K=gd7F-G-7v0J5Mz8jyZa_Vu3UZWsNZin76tff7f3g@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] pinctrl: renesas: rzg2l: Fix configuring the GPIO
 pins as interrupts
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Prabhakar,

On Mon, Nov 7, 2022 at 6:53 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> On the RZ/G2UL SoC we have less number of pins compared to RZ/G2L and also
> the pin configs are completely different. This patch makes sure we use the
> appropriate pin configs for each SoC (which is passed as part of the OF
> data) while configuring the GPIO pin as interrupts instead of using
> rzg2l_gpio_configs[] for all the SoCs.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
But I do think there is room for improvement...

> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -127,6 +127,7 @@ struct rzg2l_dedicated_configs {
>  struct rzg2l_pinctrl_data {
>         const char * const *port_pins;
>         const u32 *port_pin_configs;
> +       unsigned int n_port_pin_configs;

n_ports?

>         struct rzg2l_dedicated_configs *dedicated_pins;
>         unsigned int n_port_pins;

n_port_pins is now always n_port_pin_configs * RZG2L_PINS_PER_PORT,
right?

>         unsigned int n_dedicated_pins;

> @@ -1517,6 +1518,7 @@ static int rzg2l_pinctrl_probe(struct platform_device *pdev)
>  static struct rzg2l_pinctrl_data r9a07g043_data = {
>         .port_pins = rzg2l_gpio_names,
>         .port_pin_configs = r9a07g043_gpio_configs,
> +       .n_port_pin_configs = ARRAY_SIZE(r9a07g043_gpio_configs),
>         .dedicated_pins = rzg2l_dedicated_pins.common,
>         .n_port_pins = ARRAY_SIZE(r9a07g043_gpio_configs) * RZG2L_PINS_PER_PORT,
>         .n_dedicated_pins = ARRAY_SIZE(rzg2l_dedicated_pins.common),
> @@ -1525,6 +1527,7 @@ static struct rzg2l_pinctrl_data r9a07g043_data = {
>  static struct rzg2l_pinctrl_data r9a07g044_data = {
>         .port_pins = rzg2l_gpio_names,

.port_pins is always rzg2l_gpio_names

>         .port_pin_configs = rzg2l_gpio_configs,
> +       .n_port_pin_configs = ARRAY_SIZE(rzg2l_gpio_configs),
>         .dedicated_pins = rzg2l_dedicated_pins.common,
>         .n_port_pins = ARRAY_SIZE(rzg2l_gpio_names),

I think this should have become
ARRAY_SIZE(rzg2l_gpio_configs) * RZG2L_PINS_PER_PORT)
when support for r9a07g043 was introduced.

To avoid overflows when adding support for more SoCs, you can add a
bunch of checks like

    BUILD_BUG_ON(ARRAY_SIZE(r9a07g043_gpio_configs) *
RZG2L_PINS_PER_PORT > ARRAY_SIZE(rzg2l_gpio_names))
    BUILD_BUG_ON(ARRAY_SIZE(rzg2l_gpio_configs) * RZG2L_PINS_PER_PORT
> ARRAY_SIZE(rzg2l_gpio_names))

>         .n_dedicated_pins = ARRAY_SIZE(rzg2l_dedicated_pins.common) +

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
