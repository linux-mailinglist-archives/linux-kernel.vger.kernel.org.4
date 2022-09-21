Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D175BFC15
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 12:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiIUKNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 06:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbiIUKNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 06:13:32 -0400
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC357FF84;
        Wed, 21 Sep 2022 03:13:31 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id c6so4060210qvn.6;
        Wed, 21 Sep 2022 03:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=9A/p6ZkdEYO1vNEWi1IhugiWPSS0Lp7RP7GaNC2clvU=;
        b=K/x1XSIRZ5t+HB+JVsvkRjQDFnbL2VVu8BCx61zoQCo9Jr5r0FrejptJLoiR5WBfoq
         UAhGcsVqb0v+Jh5P/SB5/Rcwc9TjDT8D2OW81HdPtr+GkycB7/mLMb1vZ/u6PArztIr3
         vJdaCObs36dHh2IBZU9kJauWalpQApOQn1x8YF6/obprEXf3BfUKw2EzgA6RWHJulHPn
         GPMcvTG6vOUBIW4pLC2s+twN/KwKCSogCpsbNR992AWAZ2/1IqhLC/VykOGtAcFI6dJe
         qX1cfl6KzToI79U8rkW08Eam59EuSHcqtOwzoFMs4PxFCK7ZA/S3tiPSAI4bVjf+E6G9
         H1IQ==
X-Gm-Message-State: ACrzQf2y+CDhv7T+Hn1nP6WMLFg2LIHl2jwj5ClDhravPZ3A41npkLk0
        VDSyylRinp81q/ThJFGGzroLz9/ISgEmvEP7
X-Google-Smtp-Source: AMsMyM6ZWzpzfyKU2lzy4ycJrV9h3j4IcW2XogqOCaIjetJtBoxuYyM5td6cajWRJkj9KspQWyBnTg==
X-Received: by 2002:a05:6214:5190:b0:4ad:41ed:80c7 with SMTP id kl16-20020a056214519000b004ad41ed80c7mr11741018qvb.53.1663755209954;
        Wed, 21 Sep 2022 03:13:29 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id fc11-20020a05622a488b00b003435bb7fe9csm1391920qtb.78.2022.09.21.03.13.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 03:13:29 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id a67so7350733ybb.3;
        Wed, 21 Sep 2022 03:13:28 -0700 (PDT)
X-Received: by 2002:a25:3746:0:b0:6b1:4a12:b2d5 with SMTP id
 e67-20020a253746000000b006b14a12b2d5mr20690282yba.89.1663755208456; Wed, 21
 Sep 2022 03:13:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdUPm36RsxHdVwspR3NCAR3C507AyB6R65W42N2gXWq0ag@mail.gmail.com>
 <45d2e6c2-3b4b-5720-0431-002c74b1f9cc@arm.com>
In-Reply-To: <45d2e6c2-3b4b-5720-0431-002c74b1f9cc@arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 21 Sep 2022 12:13:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWd5cmxgG8jdpDw3nrfrdSX6ecb+XwuJTLkkRgP5LbcHQ@mail.gmail.com>
Message-ID: <CAMuHMdWd5cmxgG8jdpDw3nrfrdSX6ecb+XwuJTLkkRgP5LbcHQ@mail.gmail.com>
Subject: Re: Similar SoCs with different CPUs and interrupt bindings
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Conor Dooley <conor.dooley@microchip.com>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Wed, Sep 21, 2022 at 11:20 AM Robin Murphy <robin.murphy@arm.com> wrote:
> On 2022-09-21 08:46, Geert Uytterhoeven wrote:
> > This is a topic that came up at the RISC-V BoF at Plumbers, and it was
> > suggested to bring it up with you.
> >
> > The same SoC may be available with either RISC-V or other (e.g. ARM) CPU
> > cores (an example of this are the Renesas RZ/Five and RZ/G2UL SoCs).
> > To avoid duplication, we would like to have:
> >    - <riscv-soc>.dtsi includes <base-soc>.dtsi,
> >    - <arm-soc>.dtsi includes <base-soc>.dtsi.
> >
> > Unfortunately RISC-V and ARM typically use different types of interrupt
> > controllers, using different bindings (e.g. 2-cell vs. 3-cell), and
> > possibly using different interrupt numbers.  Hence the interrupt-parent
> > and interrupts{-extended} properties should be different, too.
> >
> > Possible solutions[1]:
> >    1. interrupt-map
> >
> >    2. Use a SOC_PERIPHERAL_IRQ() macro in interrupts properties in
> >       <base-soc>.dtsi, with
> >         - #define SOC_PERIPHERAL_IRQ(nr, na) nr          // RISC-V
> >         - #define SOC_PERIPHERAL_IRQ(nr, na) GIC_SPI na  // ARM
> >       Note that the cpp/dtc combo does not support arithmetic, so even
> >       the simple case where nr = 32 + na cannot be simplified.
> >
> >    3. Wrap inside RISCV() and ARM() macros, e.g.:
> >
> >          RISCV(interrupts = <412 IRQ_TYPE_LEVEL_HIGH>;)
> >          ARM(interrupts = <GIC_SPI 380 IRQ_TYPE_LEVEL_HIGH>;)
> >
> >       Cfr. ARM() and THUMB() in arch/arm/include/asm/unified.h, as used
> >       to express the same operation using plain ARM or ARM Thumb
> >       instructions.
>
> 4. Put all the "interrupts" properties in the SoC-specific DTSI at the
> same level as the interrupt controller to which they correspond. Works
> out of the box with no horrible mystery macros, and is really no more or
> less error-prone than any other approach. Yes, it means replicating a
> bit of structure and/or having labels for everything (many of which may
> be wanted anyway), but that's not necessarily a bad thing for
> readability anyway. Hierarchical definitions are standard FDT practice
> and should be well understood, so this is arguably the simplest and
> least surprising approach :)

Thanks for the suggestion!

It does mean we have to update 3 .dtsi files when adding support
for a new device. As long as all DT changes go through the same (soc)
tree, we can easily manage the dependencies.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
