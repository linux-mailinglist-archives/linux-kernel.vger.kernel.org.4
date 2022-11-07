Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8D361F477
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbiKGNgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbiKGNgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:36:45 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E59041CB36
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 05:36:44 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6D441FB;
        Mon,  7 Nov 2022 05:36:50 -0800 (PST)
Received: from [10.163.40.48] (unknown [10.163.40.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2798D3F73D;
        Mon,  7 Nov 2022 05:36:41 -0800 (PST)
Message-ID: <375f4f58-e071-c102-43d7-7fdff3970f72@arm.com>
Date:   Mon, 7 Nov 2022 19:06:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V2] arm64/mm: Simplify and document pte_to_phys() for 52
 bit addresses
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
References: <20221107114850.2902150-1-anshuman.khandual@arm.com>
 <CAMj1kXF2NyZS7cWiZiPBuySdFnpB_gcHa4KXieje4_G1-zCmog@mail.gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <CAMj1kXF2NyZS7cWiZiPBuySdFnpB_gcHa4KXieje4_G1-zCmog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/22 17:32, Ard Biesheuvel wrote:
> Hello Anshuman,
> 
> On Mon, 7 Nov 2022 at 12:49, Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>>
>> pte_to_phys() assembly definition does multiple bits field transformations
>> to derive physical address, embedded inside a page table entry. Unlike its
>> C counter part i.e __pte_to_phys(), pte_to_phys() is not very apparent. It
>> simplifies these operations via a new macro PTE_ADDR_HIGH_SHIFT indicating
>> how far the pte encoded higher address bits need to be left shifted. While
>> here, this also updates __pte_to_phys() and __phys_to_pte_val().
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Brown <broonie@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Ard Biesheuvel <ardb@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> With the nit below fixed, this looks good to me
> 
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> 
>> ---
>> This applies on v6.1-rc4
>>
>> Changes in V2:
>>
>> - Added PTE_ADDR_HIGH_SHIFT based method per Ard
>>
>> Changes in V1:
>>
>> https://lore.kernel.org/all/20221031082421.1957288-1-anshuman.khandual@arm.com/
>>
>>  arch/arm64/include/asm/assembler.h     | 8 +++-----
>>  arch/arm64/include/asm/pgtable-hwdef.h | 1 +
>>  arch/arm64/include/asm/pgtable.h       | 4 ++--
>>  3 files changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
>> index e5957a53be39..6a39a3601cf7 100644
>> --- a/arch/arm64/include/asm/assembler.h
>> +++ b/arch/arm64/include/asm/assembler.h
>> @@ -660,12 +660,10 @@ alternative_endif
>>         .endm
>>
>>         .macro  pte_to_phys, phys, pte
>> -#ifdef CONFIG_ARM64_PA_BITS_52
>> -       ubfiz   \phys, \pte, #(48 - 16 - 12), #16
>> -       bfxil   \phys, \pte, #16, #32
>> -       lsl     \phys, \phys, #16
>> -#else
>>         and     \phys, \pte, #PTE_ADDR_MASK
>> +#ifdef CONFIG_ARM64_PA_BITS_52
>> +       orr \phys, \phys, \phys, lsl #PTE_ADDR_HIGH_SHIFT
>> +       and \phys, \phys, GENMASK_ULL(PHYS_MASK_SHIFT - 1, PAGE_SHIFT)
> 
> Please use tabs between the mnemonics and the arguments.

Sure, will do that.
