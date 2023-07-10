Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1F274CA1B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 04:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjGJCyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 22:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjGJCyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 22:54:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 65964E9;
        Sun,  9 Jul 2023 19:54:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 308571FB;
        Sun,  9 Jul 2023 19:54:56 -0700 (PDT)
Received: from [10.162.40.20] (a077893.blr.arm.com [10.162.40.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BEBB43F740;
        Sun,  9 Jul 2023 19:54:10 -0700 (PDT)
Message-ID: <bc9c2d09-8c6c-e5b2-a5be-545b4bb0a1b4@arm.com>
Date:   Mon, 10 Jul 2023 08:24:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC 1/4] arm64/mm: Add SW and HW dirty state helpers
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20230707053331.510041-1-anshuman.khandual@arm.com>
 <20230707053331.510041-2-anshuman.khandual@arm.com>
 <0d035a57-b502-32b3-0010-d029f62d7757@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <0d035a57-b502-32b3-0010-d029f62d7757@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/7/23 17:39, David Hildenbrand wrote:
> On 07.07.23 07:33, Anshuman Khandual wrote:
>> This factors out low level SW and HW state changes i.e make and clear into
>> separate helpers making them explicit improving readability. This also adds
>> pte_rdonly() helper as well. No functional change is intended.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   arch/arm64/include/asm/pgtable.h | 52 ++++++++++++++++++++++++++------
>>   1 file changed, 42 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index 0bd18de9fd97..fb03be697819 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -103,6 +103,7 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
>>   #define pte_young(pte)        (!!(pte_val(pte) & PTE_AF))
>>   #define pte_special(pte)    (!!(pte_val(pte) & PTE_SPECIAL))
>>   #define pte_write(pte)        (!!(pte_val(pte) & PTE_WRITE))
>> +#define pte_rdonly(pte)        (!!(pte_val(pte) & PTE_RDONLY))
>>   #define pte_user(pte)        (!!(pte_val(pte) & PTE_USER))
>>   #define pte_user_exec(pte)    (!(pte_val(pte) & PTE_UXN))
>>   #define pte_cont(pte)        (!!(pte_val(pte) & PTE_CONT))
>> @@ -120,7 +121,7 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
>>       (__boundary - 1 < (end) - 1) ? __boundary : (end);            \
>>   })
>>   -#define pte_hw_dirty(pte)    (pte_write(pte) && !(pte_val(pte) & PTE_RDONLY))
>> +#define pte_hw_dirty(pte)    (pte_write(pte) && !pte_rdonly(pte))
>>   #define pte_sw_dirty(pte)    (!!(pte_val(pte) & PTE_DIRTY))
>>   #define pte_dirty(pte)        (pte_sw_dirty(pte) || pte_hw_dirty(pte))
>>   @@ -174,6 +175,39 @@ static inline pmd_t clear_pmd_bit(pmd_t pmd, pgprot_t prot)
>>       return pmd;
>>   }
>>   +static inline pte_t pte_hw_mkdirty(pte_t pte)
> 
> I'd have called this "pte_mkhw_dirty", similar to "pte_mksoft_dirty".
> 
>> +{
>> +    if (pte_write(pte))
>> +        pte = clear_pte_bit(pte, __pgprot(PTE_RDONLY));
>> +
>> +    return pte;
>> +}
>> +
>> +static inline pte_t pte_sw_mkdirty(pte_t pte)
> 
> pte_mksw_dirty

Sure, will change them as pte_mkhw_dirty()/pte_mksw_dirty() instead.

> 
>> +{
>> +    return set_pte_bit(pte, __pgprot(PTE_DIRTY));
>> +}
>> +
>> +static inline __always_unused pte_t pte_hw_clr_dirty(pte_t pte)
> 
> pte_clear_hw_dirty (again, similar to pte_clear_soft_dirty )
> 
>> +{
>> +    return set_pte_bit(pte, __pgprot(PTE_RDONLY));
>> +}
>> +
>> +static inline pte_t pte_sw_clr_dirty(pte_t pte)
> 
> pte_clear_sw_dirty

Sure, will change them as pte_clear_hw_dirty()/pte_clear_sw_dirty() instead.

> 
>> +{
>> +    pte = clear_pte_bit(pte, __pgprot(PTE_DIRTY));
>> +
>> +    /*
>> +     * Clearing the software dirty state requires clearing
>> +     * the PTE_DIRTY bit along with setting the PTE_RDONLY
>> +     * ensuring a page fault on subsequent write access.
>> +     *
>> +     * NOTE: Setting the PTE_RDONLY (as a coincident) also
>> +     * implies clearing the HW dirty state.
>> +     */
>> +    return set_pte_bit(pte, __pgprot(PTE_RDONLY));
>> +}
>> +
>>   static inline pmd_t set_pmd_bit(pmd_t pmd, pgprot_t prot)
>>   {
>>       pmd_val(pmd) |= pgprot_val(prot);
>> @@ -189,19 +223,17 @@ static inline pte_t pte_mkwrite(pte_t pte)
>>     static inline pte_t pte_mkclean(pte_t pte)
>>   {
>> -    pte = clear_pte_bit(pte, __pgprot(PTE_DIRTY));
>> -    pte = set_pte_bit(pte, __pgprot(PTE_RDONLY));
>> -
>> -    return pte;
>> +    /*
>> +     * Subsequent call to pte_hw_clr_dirty() is not required
>> +     * because pte_sw_clr_dirty() in turn does that as well.
>> +     */
>> +    return pte_sw_clr_dirty(pte);
> 
> Hm, I'm not sure if that simplifies things.
> 
> You call pte_sw_clr_dirty() and suddenly your hw dirty bit is clear?

Because clearing HW dirty bit just needs setting PTE_RDONLY bit, which as
a coincidence is also required, after clearing the SW dirty bit to enable
a subsequent write fault. Here pte_sw_clr_dirty() just happen to contain
pte_hw_clr_dirty().

> 
> In that case I think the current implementation is clearer: it doesn't provide primitives that don't make any sense.

It actually does a SW dirty bit clearing which also takes care of HW dirty
bit clearing without saying so explicitly. These new helpers demonstrate
bit clearly what is happening.

> 
>>   }
>>     static inline pte_t pte_mkdirty(pte_t pte)
>>   {
>> -    pte = set_pte_bit(pte, __pgprot(PTE_DIRTY));
>> -
>> -    if (pte_write(pte))
>> -        pte = clear_pte_bit(pte, __pgprot(PTE_RDONLY));
>> -
>> +    pte = pte_sw_mkdirty(pte);
>> +    pte = pte_hw_mkdirty(pte);
> 
> That looks weird. Especially, pte_hw_mkdirty() only does something if pte_write().

pte_write() check asserts if DBM is implemented and being used before clearing
PTE_RDONLY making it a HW dirty state. If pte_write() is cleared, either DBM
is not implemented or it's a non-writable entry, either way dirty state cannot
be tracked in HW.

> 
> Shouldn't pte_hw_mkdirty() bail out if it cannot do anything reasonable (IOW, !writable)?

static inline pte_t pte_hw_mkdirty(pte_t pte)
{
	if (pte_write(pte))
		pte = clear_pte_bit(pte, __pgprot(PTE_RDONLY));

	return pte;
}

If pte_write() is not positive, it's in !writable state on DBM enabled systems.
Otherwise pte_write() state does not matter, as the bit position does not make
sense on non DBM enabled systems.

> 
>>       return pte;
>>   }
>>   
> 
