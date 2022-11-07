Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5554461F254
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 13:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbiKGMCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 07:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbiKGMCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 07:02:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27B91AD87
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 04:02:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B40CB81094
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 12:02:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D2FC43470
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 12:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667822534;
        bh=sMrVEIn/6RFB5zzer5oz4OA0rD8Fs/O31fttuhh2ODI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A+IsNmCCXPx77cjN8lAbm0Dlf8bwhj4P+kc4hkZwAcTEhv3+vexmH2jV9K2WpihAi
         lCF8/iEik17YKNgKWm/9r67c3T5uufyhwgbfCiG1RKGCv+bIL5mMfDcLiej98K0Tta
         YgvqClDYDYe+4dJEulVVMUr+ezuFvMDta0IV9zricBmogcIsMpkOHM4mnwDbdsCc9A
         SO6DqtsYK+0OplfyqImRtnsNg7q17g03VuampXlgejeODv7f8OsPIe1btkpD//pOsM
         WV6VGosHD6jxJjYSexEoasu+vq9M8TU4AUT1t3Yi7twM5TWOTeHcAM29jZBe/fC2FZ
         pTR5RWUtERPAQ==
Received: by mail-lf1-f47.google.com with SMTP id be13so16432775lfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 04:02:14 -0800 (PST)
X-Gm-Message-State: ACrzQf3TiElDu1TuUXZgP+IIVdSTNALy/T7TXdgFpZbbzoNDZsWWEZVS
        N1/ggmzq84HjDSs1S1N87VnbbJcCFs1dkb+hC/I=
X-Google-Smtp-Source: AMsMyM6+E+32jdFkc+LUViYKxp7Bf55P8TksZfxa7MpXuoyBTXfc0PbhVTfOVwlYjKTJgx+PeZHeEzDWtRRWNkvdF0s=
X-Received: by 2002:ac2:4c47:0:b0:4a2:c07b:4b62 with SMTP id
 o7-20020ac24c47000000b004a2c07b4b62mr16704586lfk.426.1667822532193; Mon, 07
 Nov 2022 04:02:12 -0800 (PST)
MIME-Version: 1.0
References: <20221107114850.2902150-1-anshuman.khandual@arm.com>
In-Reply-To: <20221107114850.2902150-1-anshuman.khandual@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 7 Nov 2022 13:02:00 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF2NyZS7cWiZiPBuySdFnpB_gcHa4KXieje4_G1-zCmog@mail.gmail.com>
Message-ID: <CAMj1kXF2NyZS7cWiZiPBuySdFnpB_gcHa4KXieje4_G1-zCmog@mail.gmail.com>
Subject: Re: [PATCH V2] arm64/mm: Simplify and document pte_to_phys() for 52
 bit addresses
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Anshuman,

On Mon, 7 Nov 2022 at 12:49, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> pte_to_phys() assembly definition does multiple bits field transformations
> to derive physical address, embedded inside a page table entry. Unlike its
> C counter part i.e __pte_to_phys(), pte_to_phys() is not very apparent. It
> simplifies these operations via a new macro PTE_ADDR_HIGH_SHIFT indicating
> how far the pte encoded higher address bits need to be left shifted. While
> here, this also updates __pte_to_phys() and __phys_to_pte_val().
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

With the nit below fixed, this looks good to me

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

> ---
> This applies on v6.1-rc4
>
> Changes in V2:
>
> - Added PTE_ADDR_HIGH_SHIFT based method per Ard
>
> Changes in V1:
>
> https://lore.kernel.org/all/20221031082421.1957288-1-anshuman.khandual@arm.com/
>
>  arch/arm64/include/asm/assembler.h     | 8 +++-----
>  arch/arm64/include/asm/pgtable-hwdef.h | 1 +
>  arch/arm64/include/asm/pgtable.h       | 4 ++--
>  3 files changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index e5957a53be39..6a39a3601cf7 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -660,12 +660,10 @@ alternative_endif
>         .endm
>
>         .macro  pte_to_phys, phys, pte
> -#ifdef CONFIG_ARM64_PA_BITS_52
> -       ubfiz   \phys, \pte, #(48 - 16 - 12), #16
> -       bfxil   \phys, \pte, #16, #32
> -       lsl     \phys, \phys, #16
> -#else
>         and     \phys, \pte, #PTE_ADDR_MASK
> +#ifdef CONFIG_ARM64_PA_BITS_52
> +       orr \phys, \phys, \phys, lsl #PTE_ADDR_HIGH_SHIFT
> +       and \phys, \phys, GENMASK_ULL(PHYS_MASK_SHIFT - 1, PAGE_SHIFT)

Please use tabs between the mnemonics and the arguments.

>  #endif
>         .endm
>
> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
> index 5ab8d163198f..f658aafc47df 100644
> --- a/arch/arm64/include/asm/pgtable-hwdef.h
> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> @@ -159,6 +159,7 @@
>  #ifdef CONFIG_ARM64_PA_BITS_52
>  #define PTE_ADDR_HIGH          (_AT(pteval_t, 0xf) << 12)
>  #define PTE_ADDR_MASK          (PTE_ADDR_LOW | PTE_ADDR_HIGH)
> +#define PTE_ADDR_HIGH_SHIFT    36
>  #else
>  #define PTE_ADDR_MASK          PTE_ADDR_LOW
>  #endif
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 71a1af42f0e8..daedd6172227 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -77,11 +77,11 @@ extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
>  static inline phys_addr_t __pte_to_phys(pte_t pte)
>  {
>         return (pte_val(pte) & PTE_ADDR_LOW) |
> -               ((pte_val(pte) & PTE_ADDR_HIGH) << 36);
> +               ((pte_val(pte) & PTE_ADDR_HIGH) << PTE_ADDR_HIGH_SHIFT);
>  }
>  static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
>  {
> -       return (phys | (phys >> 36)) & PTE_ADDR_MASK;
> +       return (phys | (phys >> PTE_ADDR_HIGH_SHIFT)) & PTE_ADDR_MASK;
>  }
>  #else
>  #define __pte_to_phys(pte)     (pte_val(pte) & PTE_ADDR_MASK)
> --
> 2.25.1
>
