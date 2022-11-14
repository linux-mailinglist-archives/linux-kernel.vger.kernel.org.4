Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51951628156
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 14:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236340AbiKNNcX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Nov 2022 08:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbiKNNcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 08:32:18 -0500
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417491DF36;
        Mon, 14 Nov 2022 05:32:17 -0800 (PST)
Received: by mail-qv1-f50.google.com with SMTP id x15so7753866qvp.1;
        Mon, 14 Nov 2022 05:32:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pMhSV0Cl1EFcHm2JcZW7TSJN/o+qIpdcOTKCD0tUyyw=;
        b=Z0sGqRNZfpC3637mrDyRBsKh3YdpcdVL9SA/FNR7afYaaGiuYjj1HUB7EnjDpu+4Ns
         9b6lA43KBYLlrG1ZJ6HRoCfp3wAphnXMApKZauTrR1LvhgGXaFmi0Kb07nxkB+qjMQFf
         jXbPX01aYc/oXcABL29jotVw+gLSbXTLA+L7BZKIt4rGfy9shaoIUi/Dob3HHM1yqkDc
         0Bh8T6gYUxo52y9wcqmD3J6Te2pzz1Y07qrAihYJ7ZyTD/oApQHc5DPSoQF5SzLJamA4
         fhk7MUVfL0dlLGKpeyHcs5ZSD8hGDBqDfZZU/csGhr8KN1jTRylGenMqdSd+CEkFv9Za
         bcFA==
X-Gm-Message-State: ANoB5plYgOISTMZG0uCmvz3XgsAMMbSIKbrQcKtV8TRDLiswmYdwNarh
        /zEZahieipYTVWX9Rnjw8t4pzjrU9m0YFA==
X-Google-Smtp-Source: AA0mqf6oFLmxXYoZKWmXAwRl78hgaAGu71UAhfAMwqP9V+/DIVGSmAMrFUUxqOLZPVZrPqF6ljQX2w==
X-Received: by 2002:a0c:e949:0:b0:4af:b750:b569 with SMTP id n9-20020a0ce949000000b004afb750b569mr12479468qvo.83.1668432736100;
        Mon, 14 Nov 2022 05:32:16 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id dm56-20020a05620a1d7800b006eeb51bb33dsm6443645qkb.78.2022.11.14.05.32.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 05:32:15 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id j2so13406451ybb.6;
        Mon, 14 Nov 2022 05:32:15 -0800 (PST)
X-Received: by 2002:a25:18c5:0:b0:6de:6183:c5c3 with SMTP id
 188-20020a2518c5000000b006de6183c5c3mr12383197yby.89.1668432735124; Mon, 14
 Nov 2022 05:32:15 -0800 (PST)
MIME-Version: 1.0
References: <20221114111513.1436165-1-herve.codina@bootlin.com> <20221114111513.1436165-4-herve.codina@bootlin.com>
In-Reply-To: <20221114111513.1436165-4-herve.codina@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 14 Nov 2022 14:32:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVrx3ug+RKuNXauCLKFYr5qZedrj7KmME0vzRysoqFzPQ@mail.gmail.com>
Message-ID: <CAMuHMdVrx3ug+RKuNXauCLKFYr5qZedrj7KmME0vzRysoqFzPQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] soc: renesas: r9a06g032-sysctrl: Handle h2mode
 device-tree property
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hervé,

On Mon, Nov 14, 2022 at 12:15 PM Herve Codina <herve.codina@bootlin.com> wrote:
>
> Handle the h2mode property and forces the CFG_USB[H2MODE] bit
> accordingly.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Thanks for the update!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Minor nit below.

> @@ -966,6 +967,26 @@ static int __init r9a06g032_clocks_probe(struct platform_device *pdev)
>         clocks->reg = of_iomap(np, 0);
>         if (WARN_ON(!clocks->reg))
>                 return -ENOMEM;
> +
> +       error = of_property_read_u32(np, "renesas,h2mode", &h2mode);
> +       if (!error) {
> +               usb = readl(clocks->reg + R9A06G032_SYSCTRL_USB);
> +               switch (h2mode) {
> +               case 0:
> +                       /* 1 host, 1 device */
> +                       usb &= ~R9A06G032_SYSCTRL_USB_H2MODE;
> +                       break;
> +               case 1:
> +                       /* 2 hosts */
> +                       usb |= R9A06G032_SYSCTRL_USB_H2MODE;
> +                       break;
> +               default:
> +                       dev_err(dev, "invalid h2mode %d\n", h2mode);

%u

> +                       return -EINVAL;
> +               }
> +               writel(usb, clocks->reg + R9A06G032_SYSCTRL_USB);
> +       }
> +
>         for (i = 0; i < ARRAY_SIZE(r9a06g032_clocks); ++i) {
>                 const struct r9a06g032_clkdesc *d = &r9a06g032_clocks[i];
>                 const char *parent_name = d->source ?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
