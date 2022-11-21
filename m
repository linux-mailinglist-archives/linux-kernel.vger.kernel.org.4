Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38920631980
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 06:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiKUFay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 00:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiKUFau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 00:30:50 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86DD41C430
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 21:30:48 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CE941FB;
        Sun, 20 Nov 2022 21:30:54 -0800 (PST)
Received: from [10.162.41.8] (unknown [10.162.41.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4165C3F587;
        Sun, 20 Nov 2022 21:30:45 -0800 (PST)
Message-ID: <fd67eca3-59f4-4455-e3db-ba853c3f949b@arm.com>
Date:   Mon, 21 Nov 2022 11:00:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] arm64/mm: Drop redundant BUG_ON(!pgtable_alloc)
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20221118053102.500216-1-anshuman.khandual@arm.com>
 <Y3pS5fdZ3MdLZ00t@dev-arch.thelio-3990X>
Content-Language: en-US
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Y3pS5fdZ3MdLZ00t@dev-arch.thelio-3990X>
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

Hello Nathan,

Thanks for the report.

On 11/20/22 21:46, Nathan Chancellor wrote:
> Hi Anshuman,
> 
> On Fri, Nov 18, 2022 at 11:01:02AM +0530, Anshuman Khandual wrote:
>> __create_pgd_mapping_locked() expects a page allocator used while mapping a
>> virtual range. This page allocator function propagates down the call chain,
>> while building intermediate levels in the page table. Passed page allocator
>> is a necessary ingredient required to build the page table but its presence
>> can be asserted just once in the very beginning rather than in all the down
>> stream functions. This consolidates BUG_ON(!pgtable_alloc) checks just in a
>> single place i.e __create_pgd_mapping_locked().
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> This applies on v6.1-rc5
>>
>>  arch/arm64/mm/mmu.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 5a19950e7289..97ca82001089 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -207,7 +207,6 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>>  
>>  		if (flags & NO_EXEC_MAPPINGS)
>>  			pmdval |= PMD_TABLE_PXN;
>> -		BUG_ON(!pgtable_alloc);
>>  		pte_phys = pgtable_alloc(PAGE_SHIFT);
>>  		__pmd_populate(pmdp, pte_phys, pmdval);
>>  		pmd = READ_ONCE(*pmdp);
>> @@ -285,7 +284,6 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
>>  
>>  		if (flags & NO_EXEC_MAPPINGS)
>>  			pudval |= PUD_TABLE_PXN;
>> -		BUG_ON(!pgtable_alloc);
>>  		pmd_phys = pgtable_alloc(PMD_SHIFT);
>>  		__pud_populate(pudp, pmd_phys, pudval);
>>  		pud = READ_ONCE(*pudp);
>> @@ -324,7 +322,6 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
>>  
>>  		if (flags & NO_EXEC_MAPPINGS)
>>  			p4dval |= P4D_TABLE_PXN;
>> -		BUG_ON(!pgtable_alloc);
>>  		pud_phys = pgtable_alloc(PUD_SHIFT);
>>  		__p4d_populate(p4dp, pud_phys, p4dval);
>>  		p4d = READ_ONCE(*p4dp);
>> @@ -383,6 +380,7 @@ static void __create_pgd_mapping_locked(pgd_t *pgdir, phys_addr_t phys,
>>  	phys &= PAGE_MASK;
>>  	addr = virt & PAGE_MASK;
>>  	end = PAGE_ALIGN(virt + size);
>> +	BUG_ON(!pgtable_alloc);
>>  
>>  	do {
>>  		next = pgd_addr_end(addr, end);
>> -- 
>> 2.25.1
>>
>>
> I just bisected a boot failure in our QEMU-based continuous integration
> setup to this change as commit 9ed2b4616d4e ("arm64/mm: Drop redundant
> BUG_ON(!pgtable_alloc)") in the arm64 tree. There is no output so the
> panic clearly happens early at boot. If I move back to the previous
> commit and add a WARN_ON() like so:
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index d386033a074c..9280a92ff920 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -383,6 +383,7 @@ static void __create_pgd_mapping_locked(pgd_t *pgdir, phys_addr_t phys,
>  	phys &= PAGE_MASK;
>  	addr = virt & PAGE_MASK;
>  	end = PAGE_ALIGN(virt + size);
> +	WARN_ON(!pgtable_alloc);
>  
>  	do {
>  		next = pgd_addr_end(addr, end);
> 
> I do see some stacktraces. I have attached the boot log from QEMU.
> 
> If there is any additional information I can provide or patches I can
> test, I am more than happy to do so.

There are couple of instances, where __create_pgd_mapping() function gets called
without a valid pgtable alloc function (NULL is passed on instead), as it is not
expected to allocate page table pages, during the mapping process. The following
change after this patch should solve the reported problem.

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 9ea8e9039992..a00563122fcb 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -42,6 +42,7 @@
 #define NO_BLOCK_MAPPINGS      BIT(0)
 #define NO_CONT_MAPPINGS       BIT(1)
 #define NO_EXEC_MAPPINGS       BIT(2)  /* assumes FEAT_HPDS is not used */
+#define NO_ALLOC_MAPPINGS      BIT(3)  /* does not allocate page table pages */
 
 int idmap_t0sz __ro_after_init;
 
@@ -380,7 +381,7 @@ static void __create_pgd_mapping_locked(pgd_t *pgdir, phys_addr_t phys,
        phys &= PAGE_MASK;
        addr = virt & PAGE_MASK;
        end = PAGE_ALIGN(virt + size);
-       BUG_ON(!pgtable_alloc);
+       BUG_ON(!(flags & NO_ALLOC_MAPPINGS) && !pgtable_alloc);
 
        do {
                next = pgd_addr_end(addr, end);
@@ -453,7 +454,7 @@ static void __init create_mapping_noalloc(phys_addr_t phys, unsigned long virt,
                return;
        }
        __create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL,
-                            NO_CONT_MAPPINGS);
+                            NO_CONT_MAPPINGS | NO_ALLOC_MAPPINGS);
 }
 
 void __init create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
@@ -481,7 +482,7 @@ static void update_mapping_prot(phys_addr_t phys, unsigned long virt,
        }
 
        __create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL,
-                            NO_CONT_MAPPINGS);
+                            NO_CONT_MAPPINGS | NO_ALLOC_MAPPINGS);
 
        /* flush the TLBs after updating live kernel mappings */
        flush_tlb_kernel_range(virt, virt + size);
