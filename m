Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6ECA5E5B84
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 08:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiIVGkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 02:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiIVGkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 02:40:20 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9961ACA2F;
        Wed, 21 Sep 2022 23:40:18 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id c11so5670167qtw.8;
        Wed, 21 Sep 2022 23:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=F/e1JPlHkuPobKR8svZ3nWeTTrTnp+M9ecDUY6t2TzI=;
        b=1QtR7/Y4f7Az3e7b+CjKoI2Bk/8emyGvxs8Z1F6jeuMB77HwLCSdTzi+bFL4qjKTdG
         MMmFaKNIvm7ROOfiedzq42s4luG3OibaJ5hmDTNDXtZsPWpPjmHOE5ezxN8aaTpOWyeR
         3gmY/mbukmv4VWxxADpgDZIByyWY7JvWddR6qpzDuHxcjzKaPDmgNQNOz6xcogdEJw99
         /cgY5+WNvHN9kBueBvuv7X9eV4K3qf3wKqkNsF2XkAEhHnqCOd/lRBz7PLL+wORbt1LQ
         9CTRCYxf7UcdEXXhEl8elE4FW5U52biDJeJ7h7EHMbEmL9QhIgia9RA2x7Y+ABojX0Ex
         G+3Q==
X-Gm-Message-State: ACrzQf0Y5KRJRZg0yFQwI87T0PzbZM/0fDaLp+KE3ogLO0J39Yx75Ks0
        gDgFlGhXpUmz0UvQGyVftwlw0O3B+Ce+jGDZ
X-Google-Smtp-Source: AMsMyM7Ugw+5yC7bz6vGKMvjekspJJwwk5g7b6VqfRuZRGaonOgPXhY0IoAX/bsDdu9ZxO+Wn60t6Q==
X-Received: by 2002:ac8:5c0b:0:b0:35c:e066:998d with SMTP id i11-20020ac85c0b000000b0035ce066998dmr1575511qti.336.1663828817401;
        Wed, 21 Sep 2022 23:40:17 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id bl21-20020a05620a1a9500b006ce30a5f892sm3191406qkb.102.2022.09.21.23.40.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 23:40:17 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-3450990b0aeso88276527b3.12;
        Wed, 21 Sep 2022 23:40:16 -0700 (PDT)
X-Received: by 2002:a0d:dd09:0:b0:344:fca5:9b44 with SMTP id
 g9-20020a0ddd09000000b00344fca59b44mr1713044ywe.358.1663828816340; Wed, 21
 Sep 2022 23:40:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdUPm36RsxHdVwspR3NCAR3C507AyB6R65W42N2gXWq0ag@mail.gmail.com>
 <45d2e6c2-3b4b-5720-0431-002c74b1f9cc@arm.com> <0603b2a5-6253-4c4b-8b30-aa0253ed0480@www.fastmail.com>
In-Reply-To: <0603b2a5-6253-4c4b-8b30-aa0253ed0480@www.fastmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 22 Sep 2022 08:40:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXmzS5prd0Q2ee7NgWSULW_SMiJbG_EqcyN-rNXeFy-Rw@mail.gmail.com>
Message-ID: <CAMuHMdXmzS5prd0Q2ee7NgWSULW_SMiJbG_EqcyN-rNXeFy-Rw@mail.gmail.com>
Subject: Re: Similar SoCs with different CPUs and interrupt bindings
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Atish Patra <atishp@atishpatra.org>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Thu, Sep 22, 2022 at 8:30 AM Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Sep 21, 2022, at 11:20 AM, Robin Murphy wrote:
> > On 2022-09-21 08:46, Geert Uytterhoeven wrote:
> >> This is a topic that came up at the RISC-V BoF at Plumbers, and it was
> >> suggested to bring it up with you.
> >>
> >> The same SoC may be available with either RISC-V or other (e.g. ARM) CPU
> >> cores (an example of this are the Renesas RZ/Five and RZ/G2UL SoCs).
> >> To avoid duplication, we would like to have:
> >>    - <riscv-soc>.dtsi includes <base-soc>.dtsi,
> >>    - <arm-soc>.dtsi includes <base-soc>.dtsi.
> >>
> >> Unfortunately RISC-V and ARM typically use different types of interrupt
> >> controllers, using different bindings (e.g. 2-cell vs. 3-cell), and
> >> possibly using different interrupt numbers.  Hence the interrupt-parent
> >> and interrupts{-extended} properties should be different, too.
> >>
> >> Possible solutions[1]:
> >>    1. interrupt-map
> >>
> >>    2. Use a SOC_PERIPHERAL_IRQ() macro in interrupts properties in
> >>       <base-soc>.dtsi, with
> >>         - #define SOC_PERIPHERAL_IRQ(nr, na) nr          // RISC-V
> >>         - #define SOC_PERIPHERAL_IRQ(nr, na) GIC_SPI na  // ARM
> >>       Note that the cpp/dtc combo does not support arithmetic, so even
> >>       the simple case where nr = 32 + na cannot be simplified.
> >>
> >>    3. Wrap inside RISCV() and ARM() macros, e.g.:
> >>
> >>          RISCV(interrupts = <412 IRQ_TYPE_LEVEL_HIGH>;)
> >>          ARM(interrupts = <GIC_SPI 380 IRQ_TYPE_LEVEL_HIGH>;)
> >>
> >>       Cfr. ARM() and THUMB() in arch/arm/include/asm/unified.h, as used
> >>       to express the same operation using plain ARM or ARM Thumb
> >>       instructions.
> >
> > 4. Put all the "interrupts" properties in the SoC-specific DTSI at the
> > same level as the interrupt controller to which they correspond. Works
> > out of the box with no horrible mystery macros, and is really no more or
> > less error-prone than any other approach. Yes, it means replicating a
> > bit of structure and/or having labels for everything (many of which may
> > be wanted anyway), but that's not necessarily a bad thing for
> > readability anyway. Hierarchical definitions are standard FDT practice
> > and should be well understood, so this is arguably the simplest and
> > least surprising approach :)
>
> FWIW, approaches 1, 2 and 4 all seem reasonable to me, but I don't
> like number 3 if this is only about the IRQ definitions.

We also have to handle interrupt-parent at the /soc level.
And of course you never know what pops up next ;-)

> It sounds like we're already converging on #2, so just one more
> idea from me: we could fold the IRQ type into the macro, and
> make it just take a single argument for extra flexibility:
>
> #define SOC_PERIPHERAL_IRQ_LEVEL_HIGH(nr) \
>         GIC_SPI (nr + offset) IRQ_TYPE_LEVEL_HIGH
>
> If all the irqs on the chip have the same type, the name
> can be shorter of course.

This is usually the case, but not always.
And the numbering may be the same (modulo the offset), but
not it really depends on the on-SoC wiring.

> Either way, some variation of the macro sounds like a good enough
> approach to me.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
