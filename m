Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B05615D63
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 09:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiKBIMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 04:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiKBIMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 04:12:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AA215A22
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 01:12:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D51E61709
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 08:12:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05EEDC433D7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 08:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667376771;
        bh=6G+KTA2jVZEJYZuTREJrZXCowp4NyV9DK4fUztnusIY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q/G4U1dg5KlgxnAzSapp2OIAxejtnBTQDK7dbmV2YzY0tybOiVikZSNtlQ6OKLBkh
         jFYGhI972NZ+I3kUpKFEEi3MeD3MVbeV0z3sQQSwyWSXsdpKm9pxyMCg5TjRTp0GL/
         cx5yx5mN1xDoOUiLrDPHKKwWoUo2BKMQcpmnVCvm/ydZ3r3WbfFCKSSptU/+5zCFOI
         v8jre/YCJgq+W6L6pBm1NIWwoOqJW/HbOJAV5xfl5oKRCBnlPme0Et9sDMhU6UhcD7
         meqVxaz2O289AMgCH01TTPfDuOb++X3LlFIGZ51m4oPkzMFD3/gEDgKorhWv4xUSIy
         hUYTUY3rEIUSw==
Received: by mail-lj1-f173.google.com with SMTP id l8so13194247ljh.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 01:12:50 -0700 (PDT)
X-Gm-Message-State: ACrzQf26eiOxvYBKsnhlUyiRa8hnYU+Ih8wXZkjCrZgaLgZmPRDY0TUe
        5lznIiWggvq9k1SnsQtqB9bXJfPv86d3fF9SZZM=
X-Google-Smtp-Source: AMsMyM4Z/vSvirGnh/dpvahc0sTqAk0Yv1ebLNWC+083PUqNCyLnDHI4JL+fKjrdJC67AS6+eKYZk4LBufn8IurtUlU=
X-Received: by 2002:a2e:87cd:0:b0:277:3662:3be4 with SMTP id
 v13-20020a2e87cd000000b0027736623be4mr8405631ljj.415.1667376768938; Wed, 02
 Nov 2022 01:12:48 -0700 (PDT)
MIME-Version: 1.0
References: <20221031082421.1957288-1-anshuman.khandual@arm.com>
 <CAMj1kXHmt=_LWLZP-sce0uCV5GsxQCNL+9y6vERuPc3tM2FrQQ@mail.gmail.com> <7102f269-c3f9-f3e5-d5f3-da7eaf9a2e6d@arm.com>
In-Reply-To: <7102f269-c3f9-f3e5-d5f3-da7eaf9a2e6d@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 2 Nov 2022 09:12:37 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFuM=amSMozPBA=mFiZKMVOqN1Z9quknq0LWE-vCw=aNQ@mail.gmail.com>
Message-ID: <CAMj1kXFuM=amSMozPBA=mFiZKMVOqN1Z9quknq0LWE-vCw=aNQ@mail.gmail.com>
Subject: Re: [PATCH] arm64/mm: Simplify and document pte_to_phys() for 52 bit addresses
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2022 at 05:05, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 10/31/22 15:17, Ard Biesheuvel wrote:
> > Hello Anshuman,
> >
> > On Mon, 31 Oct 2022 at 09:24, Anshuman Khandual
> > <anshuman.khandual@arm.com> wrote:
> >>
> >> pte_to_phys() assembly definition does multiple bits field transformations
> >> to derive physical address, embedded inside a page table entry. Unlike its
> >> C counter part i.e __pte_to_phys(), pte_to_phys() is not very apparent. It
> >> simplifies these operations, by deriving all positions and widths in macro
> >> format and documenting individual steps in the physical address extraction.
> >> While here, this also updates __pte_to_phys() and __phys_to_pte_val().
> >>
> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> Cc: Will Deacon <will@kernel.org>
> >> Cc: Mark Brown <broonie@kernel.org>
> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >> Cc: Ard Biesheuvel <ardb@kernel.org>
> >> Cc: linux-arm-kernel@lists.infradead.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> >> ---
> >> This applies on v6.1-rc3.
> >>
> >>  arch/arm64/include/asm/assembler.h     | 37 +++++++++++++++++++++++---
> >>  arch/arm64/include/asm/pgtable-hwdef.h |  5 ++++
> >>  arch/arm64/include/asm/pgtable.h       |  4 +--
> >>  3 files changed, 41 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> >> index e5957a53be39..aea320b04d85 100644
> >> --- a/arch/arm64/include/asm/assembler.h
> >> +++ b/arch/arm64/include/asm/assembler.h
> >> @@ -661,9 +661,40 @@ alternative_endif
> >>
> >>         .macro  pte_to_phys, phys, pte
> >>  #ifdef CONFIG_ARM64_PA_BITS_52
> >> -       ubfiz   \phys, \pte, #(48 - 16 - 12), #16
> >> -       bfxil   \phys, \pte, #16, #32
> >> -       lsl     \phys, \phys, #16
> >> +       /*
> >> +        * Physical address needs to be derived from the given page table
> >> +        * entry according to the following formula.
> >> +        *
> >> +        *      phys = pte[47..16] | (pte[15..12] << 36)
> >> +        *
> >> +        * These instructions here retrieve the embedded 52 bits physical
> >> +        * address in phys[51..0]. This involves copying over both higher
> >> +        * and lower addresses into phys[35..0] which is then followed by
> >> +        * 16 bit left shift.
> >> +        *
> >> +        * Get higher 4 bits
> >> +        *
> >> +        *      phys[35..20] = pte[15..0] i.e phys[35..32] = pte[15..12]
> >> +        *
> >> +        * Get lower 32 bits
> >> +        *
> >> +        *      phys[31..0] = pte[47..16]
> >> +        *
> >> +        * Till now
> >> +        *
> >> +        *      phys[35..0] = pte[51..16]
> >> +        *
> >> +        * Left shift
> >> +        *
> >> +        *      phys[51..0]  = phys[35..0] << 16
> >> +        *
> >> +        * Finally
> >> +        *
> >> +        *      phys[51..16] = pte[47..16] | (pte[15..12] << 36)
> >> +        */
> >> +       ubfiz   \phys, \pte, #HIGH_ADDR_SHIFT, #HIGH_ADDR_BITS_MAX
> >> +       bfxil   \phys, \pte, #PAGE_SHIFT, #(LOW_ADDR_BITS_MAX - PAGE_SHIFT)
> >> +       lsl     \phys, \phys, #PAGE_SHIFT
> >
> >
> > I think the wall of text is unnecessary, tbh. And substituting every
>
> Okay.
>
> > occurrence of the constant value 16 with PAGE_SHIFT is slightly
> > misleading, as the entire calculation only makes sense for 64k granule
> > size, but that doesn't mean the constant is intrinsically tied to the
> > page size.
>
> The field shift operations are dependent on PAGE_SHIFT because lower
> [(PAGE_SHIFT - 1)..0] bits just always get masked out in the end and
> also the higher physical address bits are embedded inside these lower
> bits in the PTE encoding. Same pattern emerges for FEAT_LPA2 as well.
>

Yes, so PTE_ADDR_LOW is derived from PAGE_SHIFT because the low
address bits happen to appear in the same position inside a PTE as
they do inside a physical address. But that still does not mean every
occurrence of 16 should be replaced with PAGE_SHIFT.

> >
> >>  #else
> >>         and     \phys, \pte, #PTE_ADDR_MASK
> >>  #endif
> >
> >
> > If you want to clarify this and make it more self documenting, should
> > we perhaps turn it into something like
> >
> >   and \phys, \pte, #PTE_ADDR_MASK        // isolate PTE address bits
> > #ifdef CONFIG_ARM64_PA_BITS_52
> >   orr \phys, \phys, \phys, lsl #48 - 12  // copy bits [27:12] into [63:48]
> >   and \phys, \phys, #0xfffffffff0000     // retain the address bits [51:16]
> > #endif
>
> Yes, this makes more sense.
>
> Although, the constants can be derived
>
> #0xfffffffff0000 could be GENMASK_ULL(PHYS_MASK_SHIFT - 1, PAGE_SHIFT)

Indeed

> #48 - 12         could be LOW_ADDR_BITS_MAX - HIGH_ADDR_BITS_MIN (as per the current proposal)
>

We are dealing with a set of bits that appear shifted inside a PTE,
and need to be shifted left by a fixed constant.

So could we perhaps use PTE_ADDR_HIGH_SHIFT to convey how far to left
shift those bits?

> On FEAT_LPA2, it would be
>
> #0xffffffffff000 could be GENMASK_ULL(PHYS_MASK_SHIFT - 1, PAGE_SHIFT)
> #50 - 8          could be LOW_ADDR_BITS_MAX - HIGH_ADDR_BITS_MIN (as per the current proposal)
>
> Is not making macros from these relevant bit positions make sense, which
> can also be reasoned about for FEAT_LPA2 as well ?
>

Agreed.

> >
> >
> >> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
> >> index 5ab8d163198f..683ca2378960 100644
> >> --- a/arch/arm64/include/asm/pgtable-hwdef.h
> >> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> >> @@ -157,6 +157,11 @@
> >>
> >>  #define PTE_ADDR_LOW           (((_AT(pteval_t, 1) << (48 - PAGE_SHIFT)) - 1) << PAGE_SHIFT)
> >>  #ifdef CONFIG_ARM64_PA_BITS_52
> >> +#define LOW_ADDR_BITS_MAX      48
> >> +#define HIGH_ADDR_BITS_MAX     16
> >> +#define HIGH_ADDR_BITS_MIN     12
> >> +#define HIGH_ADDR_WIDTH                (HIGH_ADDR_BITS_MAX - HIGH_ADDR_BITS_MIN)
> >> +#define HIGH_ADDR_SHIFT                (LOW_ADDR_BITS_MAX - PAGE_SHIFT - PAGE_SHIFT + HIGH_ADDR_WIDTH)
> >
> > Why are you subtracting PAGE_SHIFT twice here?
> >
> >>  #define PTE_ADDR_HIGH          (_AT(pteval_t, 0xf) << 12)
> >>  #define PTE_ADDR_MASK          (PTE_ADDR_LOW | PTE_ADDR_HIGH)
> >>  #else
> >> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> >> index 71a1af42f0e8..014bac4a69e9 100644
> >> --- a/arch/arm64/include/asm/pgtable.h
> >> +++ b/arch/arm64/include/asm/pgtable.h
> >> @@ -77,11 +77,11 @@ extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
> >>  static inline phys_addr_t __pte_to_phys(pte_t pte)
> >>  {
> >>         return (pte_val(pte) & PTE_ADDR_LOW) |
> >> -               ((pte_val(pte) & PTE_ADDR_HIGH) << 36);
> >> +               ((pte_val(pte) & PTE_ADDR_HIGH) << (PHYS_MASK_SHIFT - PAGE_SHIFT));
> >
> > Same here. PHYS_MASK_SHIFT - PAGE_SHIFT happens to equal 36, but that
> > does not mean the placement of the high address bits in the PTE is
> > fundamentally tied to the dimensions of the granule or physical
> > address space.
>
> Right, my bad. This move the higher address bits from their current
> position some where inside [(PAGE_SHIFT - 1)..0], all the way after
> LOW_ADDR_BITS_MAX.
>
> So as per the current proposal, it should be
>
> [LOW_ADDR_BITS_MAX (48) - HIGH_ADDR_BITS_MIN (12)]
>
> The same can be reasoned about for FEAT_LPA2 as well.
>
> [LOW_ADDR_BITS_MAX (50) - HIGH_ADDR_BITS_MIN (8)]
>

PTE_ADDR_HIGH_SHIFT as above

> >
> > I think it makes sense to have a macro somewhere that specifies the
> > shift of the high address bits between a PTE and a physical address,
> > but it is just a property of how the ARM ARM happens to define the PTE
> > format, so I don't think it makes sense to define it in terms of
> > PAGE_SHIFT or PHYS_MASK_SHIFT.
>
> Agreed, LOW_ADDR_BITS_MAX which specifies where the lower end address
> ends and HIGH_ADDR_BITS_MIN which specifies where the higher end address
> begins are good markers to define functions, to extract physical address
> from a given page table entry. Thoughts ?
>
> >
> >
> >
> >>  }
> >>  static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
> >>  {
> >> -       return (phys | (phys >> 36)) & PTE_ADDR_MASK;
> >> +       return (phys | (phys >> (PHYS_MASK_SHIFT - PAGE_SHIFT))) & PTE_ADDR_MASK;
> >>  }
> >>  #else
> >>  #define __pte_to_phys(pte)     (pte_val(pte) & PTE_ADDR_MASK)
> >> --
> >> 2.25.1
> >>
