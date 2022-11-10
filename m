Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1FE623A45
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 04:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbiKJDPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 22:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiKJDPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 22:15:14 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4AFBCDED5;
        Wed,  9 Nov 2022 19:15:13 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 261531FB;
        Wed,  9 Nov 2022 19:15:19 -0800 (PST)
Received: from [10.162.41.6] (unknown [10.162.41.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B0FE3F73D;
        Wed,  9 Nov 2022 19:15:10 -0800 (PST)
Message-ID: <73c40107-0d7a-d988-c817-7bba6d72c371@arm.com>
Date:   Thu, 10 Nov 2022 08:45:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/2] arm64: errata: Workaround possible Cortex-A715
 [ESR|FAR]_ELx corruption
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org
References: <20221027023915.1318100-1-anshuman.khandual@arm.com>
 <20221027023915.1318100-3-anshuman.khandual@arm.com>
 <Y2v9EiNR40x/cCQm@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Y2v9EiNR40x/cCQm@arm.com>
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



On 11/10/22 00:48, Catalin Marinas wrote:
> On Thu, Oct 27, 2022 at 08:09:15AM +0530, Anshuman Khandual wrote:
>> +#define __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION
>> +static inline pte_t ptep_modify_prot_start(struct vm_area_struct *vma,
>> +					   unsigned long addr,
>> +					   pte_t *ptep)
>> +{
>> +	pte_t pte = ptep_get_and_clear(vma->vm_mm, addr, ptep);
>>  
>> +	if (IS_ENABLED(CONFIG_ARM64_WORKAROUND_2645198)) {
>> +		/*
>> +		 * Break-before-make (BBM) is required for all user space mappings
>> +		 * when the permission changes from executable to non-executable
>> +		 * in cases where cpu is affected with errata #2645198.
>> +		 */
>> +		if (pte_user_exec(pte) && cpus_have_const_cap(ARM64_WORKAROUND_2645198))
>> +			__flush_tlb_range(vma, addr, addr + PAGE_SIZE, PAGE_SIZE, false, 3);
> 
> Why not flush_tlb_page() here?
> 
> But more importantly, can we not use ptep_clear_flush() instead (and

Something like ...

ptep_modify_prot_start -

if (IS_ENABLED(CONFIG_ARM64_WORKAROUND_2645198)) {
	if (pte_user_exec(READ_ONCE(*ptep)) && cpus_have_const_cap(ARM64_WORKAROUND_2645198))
		return ptep_clear_flush(vma, addr, ptep);
} else {
	return ptep_get_and_clear(vma->vm_mm, addr, ptep);
}

> huge_ptep_clear_flush())? They return the pte and do the TLBI.

huge_ptep_modify_prot_start -

if (IS_ENABLED(CONFIG_ARM64_WORKAROUND_2645198)) {
	if (pte_user_exec(READ_ONCE(*ptep)) && cpus_have_const_cap(ARM64_WORKAROUND_2645198))
		return huge_ptep_clear_flush(vma, addr, ptep);
} else {
	return huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
}

pte_user_exec(READ_ONCE(*ptep) should identify an user exec mapping even though
ptep represents a cont PTE/PMD huge page ? OR should huge_ptep_get() helper be
used instead ? Regardless, using [huge_]ptep_clear_flush() here seems better.
