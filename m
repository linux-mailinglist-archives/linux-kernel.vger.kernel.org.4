Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CC462B273
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 05:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbiKPEmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 23:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbiKPEmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 23:42:42 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3A3631EC8;
        Tue, 15 Nov 2022 20:42:40 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D04E813D5;
        Tue, 15 Nov 2022 20:42:46 -0800 (PST)
Received: from [10.162.40.17] (unknown [10.162.40.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF4D93F73B;
        Tue, 15 Nov 2022 20:42:37 -0800 (PST)
Message-ID: <438ddc78-ded6-d464-f917-6b8749626f16@arm.com>
Date:   Wed, 16 Nov 2022 10:12:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V2 2/2] arm64: errata: Workaround possible Cortex-A715
 [ESR|FAR]_ELx corruption
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org
References: <20221113012645.190301-1-anshuman.khandual@arm.com>
 <20221113012645.190301-3-anshuman.khandual@arm.com>
 <Y3Ob2MmmuoXOs2In@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Y3Ob2MmmuoXOs2In@arm.com>
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



On 11/15/22 19:32, Catalin Marinas wrote:
> On Sun, Nov 13, 2022 at 06:56:45AM +0530, Anshuman Khandual wrote:
>> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
>> index 35e9a468d13e..6552947ca7fa 100644
>> --- a/arch/arm64/mm/hugetlbpage.c
>> +++ b/arch/arm64/mm/hugetlbpage.c
>> @@ -559,3 +559,24 @@ bool __init arch_hugetlb_valid_size(unsigned long size)
>>  {
>>  	return __hugetlb_valid_size(size);
>>  }
>> +
>> +pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
>> +{
>> +	if (IS_ENABLED(CONFIG_ARM64_WORKAROUND_2645198)) {
>> +		pte_t pte = READ_ONCE(*ptep);
> 
> Not sure whether the generated code would be any different but we should
> probably add the check for the CPU capability in the 'if' condition
> above, before the READ_ONCE (which expands to some asm volatile):

Sure, will do.

> 
> 	if (IS_ENABLED(CONFIG_ARM64_WORKAROUND_2645198) &&
> 	    cpus_have_const_cap(ARM64_WORKAROUND_2645198)) {
> 		pte_t pte = ...
> 		...
> 	}

The local variable 'pte_t pte' can be dropped as well.

> 
>> +		/*
>> +		 * Break-before-make (BBM) is required for all user space mappings
>> +		 * when the permission changes from executable to non-executable
>> +		 * in cases where cpu is affected with errata #2645198.
>> +		 */
>> +		if (pte_user_exec(pte) && cpus_have_const_cap(ARM64_WORKAROUND_2645198))
>> +			return huge_ptep_clear_flush(vma, addr, ptep);
>> +	}
>> +	return huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
>> +}
>> +
>> +void huge_ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep,
>> +				  pte_t old_pte, pte_t pte)
>> +{
>> +	set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
>> +}
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 9a7c38965154..c1fb0ce1473c 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -1702,3 +1702,24 @@ static int __init prevent_bootmem_remove_init(void)
>>  }
>>  early_initcall(prevent_bootmem_remove_init);
>>  #endif
>> +
>> +pte_t ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
>> +{
>> +	if (IS_ENABLED(CONFIG_ARM64_WORKAROUND_2645198)) {
>> +		pte_t pte = READ_ONCE(*ptep);
>> +		/*
>> +		 * Break-before-make (BBM) is required for all user space mappings
>> +		 * when the permission changes from executable to non-executable
>> +		 * in cases where cpu is affected with errata #2645198.
>> +		 */
>> +		if (pte_user_exec(pte) && cpus_have_const_cap(ARM64_WORKAROUND_2645198))
>> +			return ptep_clear_flush(vma, addr, ptep);
>> +	}
> 
> Same here.

Sure, will do.

> 
>> +	return ptep_get_and_clear(vma->vm_mm, addr, ptep);
>> +}
>> +
>> +void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep,
>> +			     pte_t old_pte, pte_t pte)
>> +{
>> +	__set_pte_at(vma->vm_mm, addr, ptep, pte);
>> +}
> 
Planning to apply the following change after this patch.

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 6552947ca7fa..cd8d96e1fa1a 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -562,14 +562,14 @@ bool __init arch_hugetlb_valid_size(unsigned long size)
 
 pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
 {
-       if (IS_ENABLED(CONFIG_ARM64_WORKAROUND_2645198)) {
-               pte_t pte = READ_ONCE(*ptep);
+       if (IS_ENABLED(CONFIG_ARM64_WORKAROUND_2645198) &&
+           cpus_have_const_cap(ARM64_WORKAROUND_2645198)) {
                /*
                 * Break-before-make (BBM) is required for all user space mappings
                 * when the permission changes from executable to non-executable
                 * in cases where cpu is affected with errata #2645198.
                 */
-               if (pte_user_exec(pte) && cpus_have_const_cap(ARM64_WORKAROUND_2645198))
+               if (pte_user_exec(READ_ONCE(*ptep)))
                        return huge_ptep_clear_flush(vma, addr, ptep);
        }
        return huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index c1fb0ce1473c..ec305ea3942c 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1705,14 +1705,14 @@ early_initcall(prevent_bootmem_remove_init);
 
 pte_t ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
 {
-       if (IS_ENABLED(CONFIG_ARM64_WORKAROUND_2645198)) {
-               pte_t pte = READ_ONCE(*ptep);
+       if (IS_ENABLED(CONFIG_ARM64_WORKAROUND_2645198) &&
+           cpus_have_const_cap(ARM64_WORKAROUND_2645198)) {
                /*
                 * Break-before-make (BBM) is required for all user space mappings
                 * when the permission changes from executable to non-executable
                 * in cases where cpu is affected with errata #2645198.
                 */
-               if (pte_user_exec(pte) && cpus_have_const_cap(ARM64_WORKAROUND_2645198))
+               if (pte_user_exec(READ_ONCE(*ptep)))
                        return ptep_clear_flush(vma, addr, ptep);
        }
        return ptep_get_and_clear(vma->vm_mm, addr, ptep);
