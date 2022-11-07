Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7B861F76B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbiKGPSY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Nov 2022 10:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbiKGPSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:18:20 -0500
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5511EAF8;
        Mon,  7 Nov 2022 07:18:19 -0800 (PST)
Received: by mail-qk1-f173.google.com with SMTP id x21so7347308qkj.0;
        Mon, 07 Nov 2022 07:18:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=41bg/V6C1tOqJ9fv/+V5kseVmkby+8ASnDXXHqgf6AE=;
        b=hkxDvyO+0SCcHx91eVSw3gekw9enTCquiYlFuwhhUNBLUWoi1dcv50pmkPJEv8uuwr
         UnhvKtn+0y3IueZgVauD4WGNfzjN06InZqTqzejtl0jlHa9QjKA58JHbzUqxPq5oom3n
         dikm/O48geOI2Ji5HyF9RtDj4FRUTvCM7/IJvV6VagCwX74+POKq3Ktld0Ry6qBG9/wx
         ZwDjfdvEHYKW3PPqMtqxUo5iFobZYD6iFvAfkLi0Nl+w1B5aopdbhLDfFE1r1S/r4+8d
         3S+1AX9g71LZ7Ox+qLFw8egrBOxa39YAEXpwY2+SQyNqjvBIAT8+NUqj3aXDeH63knof
         kfMw==
X-Gm-Message-State: ACrzQf3zyVR0/BgyvhMduLvtLhc9qEIFHIBMCLRyfEBHvYxENE3F8Vlm
        NgS+i13phnNZxCMDei+IV2iNl6/LNfB+CGOw
X-Google-Smtp-Source: AMsMyM6vfARP7bAuXyS/rlS0frMt7k8RaJi0Mf1YB8l/LMgJiXieGO/dOYMmV6RgeMDdZVvzCVzPDw==
X-Received: by 2002:a05:620a:458a:b0:6fa:2522:9c56 with SMTP id bp10-20020a05620a458a00b006fa25229c56mr733423qkb.22.1667834298659;
        Mon, 07 Nov 2022 07:18:18 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id k1-20020ac81401000000b003434d3b5938sm6231877qtj.2.2022.11.07.07.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 07:18:18 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id g127so13980445ybg.8;
        Mon, 07 Nov 2022 07:18:17 -0800 (PST)
X-Received: by 2002:a25:6b07:0:b0:6cd:3a43:bfe5 with SMTP id
 g7-20020a256b07000000b006cd3a43bfe5mr37368541ybc.89.1667834297660; Mon, 07
 Nov 2022 07:18:17 -0800 (PST)
MIME-Version: 1.0
References: <20221107135825.583877-1-herve.codina@bootlin.com> <20221107135825.583877-4-herve.codina@bootlin.com>
In-Reply-To: <20221107135825.583877-4-herve.codina@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Nov 2022 16:18:06 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX17=GJgn3=gYUHo7=1r3amXnPYE4h-45pEH=neAV4oKQ@mail.gmail.com>
Message-ID: <CAMuHMdX17=GJgn3=gYUHo7=1r3amXnPYE4h-45pEH=neAV4oKQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] soc: renesas: r9a06g032-sysctrl: Handle h2mode
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hervé,

On Mon, Nov 7, 2022 at 2:59 PM Herve Codina <herve.codina@bootlin.com> wrote:
> Handle the h2mode property and forces the CFG_USB[H2MODE] bit
> accordingly.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Thanks for your patch!

> --- a/drivers/clk/renesas/r9a06g032-clocks.c
> +++ b/drivers/clk/renesas/r9a06g032-clocks.c
> @@ -946,6 +946,7 @@ static int __init r9a06g032_clocks_probe(struct platform_device *pdev)
>         struct clk *mclk;
>         unsigned int i;
>         u16 uart_group_sel[2];
> +       u32 usb, h2mode;
>         int error;
>
>         clocks = devm_kzalloc(dev, sizeof(*clocks), GFP_KERNEL);
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
> +                       return -EINVAL;
> +               }
> +               writel(usb, clocks->reg + R9A06G032_SYSCTRL_USB);

Reading the big fat warnings in the documentation about changing
this at runtime (disconnect nodes, reset clocks, ...), I'm wondering if
the above is sufficient?

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
