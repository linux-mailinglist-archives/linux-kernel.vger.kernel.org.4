Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48264615B45
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 05:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiKBEF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 00:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiKBEF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 00:05:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CFAE2220EB
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 21:05:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90AC91FB;
        Tue,  1 Nov 2022 21:05:30 -0700 (PDT)
Received: from [10.162.42.7] (unknown [10.162.42.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1033C3F5A1;
        Tue,  1 Nov 2022 21:05:21 -0700 (PDT)
Message-ID: <7102f269-c3f9-f3e5-d5f3-da7eaf9a2e6d@arm.com>
Date:   Wed, 2 Nov 2022 09:35:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] arm64/mm: Simplify and document pte_to_phys() for 52 bit
 addresses
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
References: <20221031082421.1957288-1-anshuman.khandual@arm.com>
 <CAMj1kXHmt=_LWLZP-sce0uCV5GsxQCNL+9y6vERuPc3tM2FrQQ@mail.gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <CAMj1kXHmt=_LWLZP-sce0uCV5GsxQCNL+9y6vERuPc3tM2FrQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/31/22 15:17, Ard Biesheuvel wrote:
> Hello Anshuman,
> 
> On Mon, 31 Oct 2022 at 09:24, Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>>
>> pte_to_phys() assembly definition does multiple bits field transformations
>> to derive physical address, embedded inside a page table entry. Unlike its
>> C counter part i.e __pte_to_phys(), pte_to_phys() is not very apparent. It
>> simplifies these operations, by deriving all positions and widths in macro
>> format and documenting individual steps in the physical address extraction.
>> While here, this also updates __pte_to_phys() and __phys_to_pte_val().
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Brown <broonie@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Ard Biesheuvel <ardb@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> This applies on v6.1-rc3.
>>
>>  arch/arm64/include/asm/assembler.h     | 37 +++++++++++++++++++++++---
>>  arch/arm64/include/asm/pgtable-hwdef.h |  5 ++++
>>  arch/arm64/include/asm/pgtable.h       |  4 +--
>>  3 files changed, 41 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
>> index e5957a53be39..aea320b04d85 100644
>> --- a/arch/arm64/include/asm/assembler.h
>> +++ b/arch/arm64/include/asm/assembler.h
>> @@ -661,9 +661,40 @@ alternative_endif
>>
>>         .macro  pte_to_phys, phys, pte
>>  #ifdef CONFIG_ARM64_PA_BITS_52
>> -       ubfiz   \phys, \pte, #(48 - 16 - 12), #16
>> -       bfxil   \phys, \pte, #16, #32
>> -       lsl     \phys, \phys, #16
>> +       /*
>> +        * Physical address needs to be derived from the given page table
>> +        * entry according to the following formula.
>> +        *
>> +        *      phys = pte[47..16] | (pte[15..12] << 36)
>> +        *
>> +        * These instructions here retrieve the embedded 52 bits physical
>> +        * address in phys[51..0]. This involves copying over both higher
>> +        * and lower addresses into phys[35..0] which is then followed by
>> +        * 16 bit left shift.
>> +        *
>> +        * Get higher 4 bits
>> +        *
>> +        *      phys[35..20] = pte[15..0] i.e phys[35..32] = pte[15..12]
>> +        *
>> +        * Get lower 32 bits
>> +        *
>> +        *      phys[31..0] = pte[47..16]
>> +        *
>> +        * Till now
>> +        *
>> +        *      phys[35..0] = pte[51..16]
>> +        *
>> +        * Left shift
>> +        *
>> +        *      phys[51..0]  = phys[35..0] << 16
>> +        *
>> +        * Finally
>> +        *
>> +        *      phys[51..16] = pte[47..16] | (pte[15..12] << 36)
>> +        */
>> +       ubfiz   \phys, \pte, #HIGH_ADDR_SHIFT, #HIGH_ADDR_BITS_MAX
>> +       bfxil   \phys, \pte, #PAGE_SHIFT, #(LOW_ADDR_BITS_MAX - PAGE_SHIFT)
>> +       lsl     \phys, \phys, #PAGE_SHIFT
> 
> 
> I think the wall of text is unnecessary, tbh. And substituting every

Okay.

> occurrence of the constant value 16 with PAGE_SHIFT is slightly
> misleading, as the entire calculation only makes sense for 64k granule
> size, but that doesn't mean the constant is intrinsically tied to the
> page size.

The field shift operations are dependent on PAGE_SHIFT because lower
[(PAGE_SHIFT - 1)..0] bits just always get masked out in the end and
also the higher physical address bits are embedded inside these lower
bits in the PTE encoding. Same pattern emerges for FEAT_LPA2 as well.

> 
>>  #else
>>         and     \phys, \pte, #PTE_ADDR_MASK
>>  #endif
> 
> 
> If you want to clarify this and make it more self documenting, should
> we perhaps turn it into something like
> 
>   and \phys, \pte, #PTE_ADDR_MASK        // isolate PTE address bits
> #ifdef CONFIG_ARM64_PA_BITS_52
>   orr \phys, \phys, \phys, lsl #48 - 12  // copy bits [27:12] into [63:48]
>   and \phys, \phys, #0xfffffffff0000     // retain the address bits [51:16]
> #endif

Yes, this makes more sense.

Although, the constants can be derived

#0xfffffffff0000 could be GENMASK_ULL(PHYS_MASK_SHIFT - 1, PAGE_SHIFT)
#48 - 12	 could be LOW_ADDR_BITS_MAX - HIGH_ADDR_BITS_MIN (as per the current proposal)

On FEAT_LPA2, it would be

#0xffffffffff000 could be GENMASK_ULL(PHYS_MASK_SHIFT - 1, PAGE_SHIFT)
#50 - 8		 could be LOW_ADDR_BITS_MAX - HIGH_ADDR_BITS_MIN (as per the current proposal)

Is not making macros from these relevant bit positions make sense, which
can also be reasoned about for FEAT_LPA2 as well ?

> 
> 
>> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
>> index 5ab8d163198f..683ca2378960 100644
>> --- a/arch/arm64/include/asm/pgtable-hwdef.h
>> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
>> @@ -157,6 +157,11 @@
>>
>>  #define PTE_ADDR_LOW           (((_AT(pteval_t, 1) << (48 - PAGE_SHIFT)) - 1) << PAGE_SHIFT)
>>  #ifdef CONFIG_ARM64_PA_BITS_52
>> +#define LOW_ADDR_BITS_MAX      48
>> +#define HIGH_ADDR_BITS_MAX     16
>> +#define HIGH_ADDR_BITS_MIN     12
>> +#define HIGH_ADDR_WIDTH                (HIGH_ADDR_BITS_MAX - HIGH_ADDR_BITS_MIN)
>> +#define HIGH_ADDR_SHIFT                (LOW_ADDR_BITS_MAX - PAGE_SHIFT - PAGE_SHIFT + HIGH_ADDR_WIDTH)
> 
> Why are you subtracting PAGE_SHIFT twice here?
> 
>>  #define PTE_ADDR_HIGH          (_AT(pteval_t, 0xf) << 12)
>>  #define PTE_ADDR_MASK          (PTE_ADDR_LOW | PTE_ADDR_HIGH)
>>  #else
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index 71a1af42f0e8..014bac4a69e9 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -77,11 +77,11 @@ extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
>>  static inline phys_addr_t __pte_to_phys(pte_t pte)
>>  {
>>         return (pte_val(pte) & PTE_ADDR_LOW) |
>> -               ((pte_val(pte) & PTE_ADDR_HIGH) << 36);
>> +               ((pte_val(pte) & PTE_ADDR_HIGH) << (PHYS_MASK_SHIFT - PAGE_SHIFT));
> 
> Same here. PHYS_MASK_SHIFT - PAGE_SHIFT happens to equal 36, but that
> does not mean the placement of the high address bits in the PTE is
> fundamentally tied to the dimensions of the granule or physical
> address space.

Right, my bad. This move the higher address bits from their current
position some where inside [(PAGE_SHIFT - 1)..0], all the way after
LOW_ADDR_BITS_MAX.

So as per the current proposal, it should be

[LOW_ADDR_BITS_MAX (48) - HIGH_ADDR_BITS_MIN (12)]

The same can be reasoned about for FEAT_LPA2 as well.

[LOW_ADDR_BITS_MAX (50) - HIGH_ADDR_BITS_MIN (8)]

> 
> I think it makes sense to have a macro somewhere that specifies the
> shift of the high address bits between a PTE and a physical address,
> but it is just a property of how the ARM ARM happens to define the PTE
> format, so I don't think it makes sense to define it in terms of
> PAGE_SHIFT or PHYS_MASK_SHIFT.

Agreed, LOW_ADDR_BITS_MAX which specifies where the lower end address
ends and HIGH_ADDR_BITS_MIN which specifies where the higher end address
begins are good markers to define functions, to extract physical address
from a given page table entry. Thoughts ?

> 
> 
> 
>>  }
>>  static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
>>  {
>> -       return (phys | (phys >> 36)) & PTE_ADDR_MASK;
>> +       return (phys | (phys >> (PHYS_MASK_SHIFT - PAGE_SHIFT))) & PTE_ADDR_MASK;
>>  }
>>  #else
>>  #define __pte_to_phys(pte)     (pte_val(pte) & PTE_ADDR_MASK)
>> --
>> 2.25.1
>>
