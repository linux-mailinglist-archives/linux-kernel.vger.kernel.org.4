Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A8A5BFAB8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiIUJVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiIUJVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:21:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3368E90C73;
        Wed, 21 Sep 2022 02:20:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22BC2139F;
        Wed, 21 Sep 2022 02:20:23 -0700 (PDT)
Received: from [10.57.18.118] (unknown [10.57.18.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 661D83F73D;
        Wed, 21 Sep 2022 02:20:14 -0700 (PDT)
Message-ID: <45d2e6c2-3b4b-5720-0431-002c74b1f9cc@arm.com>
Date:   Wed, 21 Sep 2022 10:20:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: Similar SoCs with different CPUs and interrupt bindings
Content-Language: en-GB
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAMuHMdUPm36RsxHdVwspR3NCAR3C507AyB6R65W42N2gXWq0ag@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAMuHMdUPm36RsxHdVwspR3NCAR3C507AyB6R65W42N2gXWq0ag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-21 08:46, Geert Uytterhoeven wrote:
>          Hi Rob, Krzysztof,
> 
> This is a topic that came up at the RISC-V BoF at Plumbers, and it was
> suggested to bring it up with you.
> 
> The same SoC may be available with either RISC-V or other (e.g. ARM) CPU
> cores (an example of this are the Renesas RZ/Five and RZ/G2UL SoCs).
> To avoid duplication, we would like to have:
>    - <riscv-soc>.dtsi includes <base-soc>.dtsi,
>    - <arm-soc>.dtsi includes <base-soc>.dtsi.
> 
> Unfortunately RISC-V and ARM typically use different types of interrupt
> controllers, using different bindings (e.g. 2-cell vs. 3-cell), and
> possibly using different interrupt numbers.  Hence the interrupt-parent
> and interrupts{-extended} properties should be different, too.
> 
> Possible solutions[1]:
>    1. interrupt-map
> 
>    2. Use a SOC_PERIPHERAL_IRQ() macro in interrupts properties in
>       <base-soc>.dtsi, with
>         - #define SOC_PERIPHERAL_IRQ(nr, na) nr          // RISC-V
>         - #define SOC_PERIPHERAL_IRQ(nr, na) GIC_SPI na  // ARM
>       Note that the cpp/dtc combo does not support arithmetic, so even
>       the simple case where nr = 32 + na cannot be simplified.
> 
>    3. Wrap inside RISCV() and ARM() macros, e.g.:
> 
>          RISCV(interrupts = <412 IRQ_TYPE_LEVEL_HIGH>;)
>          ARM(interrupts = <GIC_SPI 380 IRQ_TYPE_LEVEL_HIGH>;)
> 
>       Cfr. ARM() and THUMB() in arch/arm/include/asm/unified.h, as used
>       to express the same operation using plain ARM or ARM Thumb
>       instructions.

4. Put all the "interrupts" properties in the SoC-specific DTSI at the 
same level as the interrupt controller to which they correspond. Works 
out of the box with no horrible mystery macros, and is really no more or 
less error-prone than any other approach. Yes, it means replicating a 
bit of structure and/or having labels for everything (many of which may 
be wanted anyway), but that's not necessarily a bad thing for 
readability anyway. Hierarchical definitions are standard FDT practice 
and should be well understood, so this is arguably the simplest and 
least surprising approach :)

Cheers,
Robin.

> Personally, I'm leaning towards the third solution, as it is the most
> flexible, and allows us to extend to more than 2 interrupt controllers.
> 
> Note that this is actually not a new issue.  For years, ARM SoCs have
> existed with multiple types of cores on the same die, using Cortex-A
> cores for the application, and Cortex-R/SuperH/V850/... cores for
> real-time and/or baseband operation.  So far this wasn't an issue, as
> only the Cortex-A cores ran Linux, and we ignored the other cores (and
> the related interrupt controllers and hierarchy) in DT.
> 
> What do you think?
> Thanks for your comments!
> 
> [1] https://lore.kernel.org/lkml/20220815050815.22340-7-samuel@sholland.org
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
