Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0536132FF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 10:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiJaJrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 05:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJaJrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 05:47:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5A4CE24
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 02:47:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C693B81212
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 09:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF220C433C1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 09:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667209650;
        bh=rad282IUjlavnJhQkjllJqEsmm5LKeYiYL25aKqwStY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A1AvzY2c+JfiDeu2NhcQ1u0/X2bsWxW3kzGFywUupIaxzt9IhAisHYtFobI0J14V5
         QBVoIZuSXqgDc5oHuEAxfY2/idV9rWixlxHgipVQsNGAGbfkTfro5+fWBgZ+yjNXpc
         9kUCiDlV9NljX5MbSmwVc75oOKpliO27MDcHnzoqhU/yW2PzEwBWW5wqj2kObrX3/H
         9dEjqjGXb+v/VG69EAh+RVZuY28d9yTbMp3mxGW7w0N5ig9TRX7xRcdN65a3Z5E8pU
         c/35lAPmIb368qv6Vz22NPzgmk4/2A3MDIjJy69mkJw0lIEDtx5AIrcB4nGyD1g6iN
         WdafaKMlLfS0A==
Received: by mail-lf1-f51.google.com with SMTP id f37so18352191lfv.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 02:47:29 -0700 (PDT)
X-Gm-Message-State: ACrzQf1ktbDotJEQhaoKjwYutM1qb0I5bcS0VDJnY0sx+j9yfIFgtNUE
        lqYlcR59zSgNf32CnOQGTEYVcu1aq6YrZfo9giY=
X-Google-Smtp-Source: AMsMyM60t45STS/opYgyo3fuMLm4g85mXQPHpvNdkREzVodd2siYaK2engkhU/8KML3/kEhwnkV/LCAWFriGNYuvSyg=
X-Received: by 2002:a19:6512:0:b0:4a9:32dd:39a4 with SMTP id
 z18-20020a196512000000b004a932dd39a4mr5098090lfb.539.1667209648001; Mon, 31
 Oct 2022 02:47:28 -0700 (PDT)
MIME-Version: 1.0
References: <20221031082421.1957288-1-anshuman.khandual@arm.com>
In-Reply-To: <20221031082421.1957288-1-anshuman.khandual@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 31 Oct 2022 10:47:16 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHmt=_LWLZP-sce0uCV5GsxQCNL+9y6vERuPc3tM2FrQQ@mail.gmail.com>
Message-ID: <CAMj1kXHmt=_LWLZP-sce0uCV5GsxQCNL+9y6vERuPc3tM2FrQQ@mail.gmail.com>
Subject: Re: [PATCH] arm64/mm: Simplify and document pte_to_phys() for 52 bit addresses
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Anshuman,

On Mon, 31 Oct 2022 at 09:24, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> pte_to_phys() assembly definition does multiple bits field transformations
> to derive physical address, embedded inside a page table entry. Unlike its
> C counter part i.e __pte_to_phys(), pte_to_phys() is not very apparent. It
> simplifies these operations, by deriving all positions and widths in macro
> format and documenting individual steps in the physical address extraction.
> While here, this also updates __pte_to_phys() and __phys_to_pte_val().
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on v6.1-rc3.
>
>  arch/arm64/include/asm/assembler.h     | 37 +++++++++++++++++++++++---
>  arch/arm64/include/asm/pgtable-hwdef.h |  5 ++++
>  arch/arm64/include/asm/pgtable.h       |  4 +--
>  3 files changed, 41 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index e5957a53be39..aea320b04d85 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -661,9 +661,40 @@ alternative_endif
>
>         .macro  pte_to_phys, phys, pte
>  #ifdef CONFIG_ARM64_PA_BITS_52
> -       ubfiz   \phys, \pte, #(48 - 16 - 12), #16
> -       bfxil   \phys, \pte, #16, #32
> -       lsl     \phys, \phys, #16
> +       /*
> +        * Physical address needs to be derived from the given page table
> +        * entry according to the following formula.
> +        *
> +        *      phys = pte[47..16] | (pte[15..12] << 36)
> +        *
> +        * These instructions here retrieve the embedded 52 bits physical
> +        * address in phys[51..0]. This involves copying over both higher
> +        * and lower addresses into phys[35..0] which is then followed by
> +        * 16 bit left shift.
> +        *
> +        * Get higher 4 bits
> +        *
> +        *      phys[35..20] = pte[15..0] i.e phys[35..32] = pte[15..12]
> +        *
> +        * Get lower 32 bits
> +        *
> +        *      phys[31..0] = pte[47..16]
> +        *
> +        * Till now
> +        *
> +        *      phys[35..0] = pte[51..16]
> +        *
> +        * Left shift
> +        *
> +        *      phys[51..0]  = phys[35..0] << 16
> +        *
> +        * Finally
> +        *
> +        *      phys[51..16] = pte[47..16] | (pte[15..12] << 36)
> +        */
> +       ubfiz   \phys, \pte, #HIGH_ADDR_SHIFT, #HIGH_ADDR_BITS_MAX
> +       bfxil   \phys, \pte, #PAGE_SHIFT, #(LOW_ADDR_BITS_MAX - PAGE_SHIFT)
> +       lsl     \phys, \phys, #PAGE_SHIFT


I think the wall of text is unnecessary, tbh. And substituting every
occurrence of the constant value 16 with PAGE_SHIFT is slightly
misleading, as the entire calculation only makes sense for 64k granule
size, but that doesn't mean the constant is intrinsically tied to the
page size.

>  #else
>         and     \phys, \pte, #PTE_ADDR_MASK
>  #endif


If you want to clarify this and make it more self documenting, should
we perhaps turn it into something like

  and \phys, \pte, #PTE_ADDR_MASK        // isolate PTE address bits
#ifdef CONFIG_ARM64_PA_BITS_52
  orr \phys, \phys, \phys, lsl #48 - 12  // copy bits [27:12] into [63:48]
  and \phys, \phys, #0xfffffffff0000     // retain the address bits [51:16]
#endif


> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
> index 5ab8d163198f..683ca2378960 100644
> --- a/arch/arm64/include/asm/pgtable-hwdef.h
> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> @@ -157,6 +157,11 @@
>
>  #define PTE_ADDR_LOW           (((_AT(pteval_t, 1) << (48 - PAGE_SHIFT)) - 1) << PAGE_SHIFT)
>  #ifdef CONFIG_ARM64_PA_BITS_52
> +#define LOW_ADDR_BITS_MAX      48
> +#define HIGH_ADDR_BITS_MAX     16
> +#define HIGH_ADDR_BITS_MIN     12
> +#define HIGH_ADDR_WIDTH                (HIGH_ADDR_BITS_MAX - HIGH_ADDR_BITS_MIN)
> +#define HIGH_ADDR_SHIFT                (LOW_ADDR_BITS_MAX - PAGE_SHIFT - PAGE_SHIFT + HIGH_ADDR_WIDTH)

Why are you subtracting PAGE_SHIFT twice here?

>  #define PTE_ADDR_HIGH          (_AT(pteval_t, 0xf) << 12)
>  #define PTE_ADDR_MASK          (PTE_ADDR_LOW | PTE_ADDR_HIGH)
>  #else
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 71a1af42f0e8..014bac4a69e9 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -77,11 +77,11 @@ extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
>  static inline phys_addr_t __pte_to_phys(pte_t pte)
>  {
>         return (pte_val(pte) & PTE_ADDR_LOW) |
> -               ((pte_val(pte) & PTE_ADDR_HIGH) << 36);
> +               ((pte_val(pte) & PTE_ADDR_HIGH) << (PHYS_MASK_SHIFT - PAGE_SHIFT));

Same here. PHYS_MASK_SHIFT - PAGE_SHIFT happens to equal 36, but that
does not mean the placement of the high address bits in the PTE is
fundamentally tied to the dimensions of the granule or physical
address space.

I think it makes sense to have a macro somewhere that specifies the
shift of the high address bits between a PTE and a physical address,
but it is just a property of how the ARM ARM happens to define the PTE
format, so I don't think it makes sense to define it in terms of
PAGE_SHIFT or PHYS_MASK_SHIFT.



>  }
>  static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
>  {
> -       return (phys | (phys >> 36)) & PTE_ADDR_MASK;
> +       return (phys | (phys >> (PHYS_MASK_SHIFT - PAGE_SHIFT))) & PTE_ADDR_MASK;
>  }
>  #else
>  #define __pte_to_phys(pte)     (pte_val(pte) & PTE_ADDR_MASK)
> --
> 2.25.1
>
