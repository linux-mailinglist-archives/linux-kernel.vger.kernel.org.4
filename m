Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB08063CD98
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 03:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbiK3C57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 21:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbiK3C5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 21:57:53 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EAFAA22BC8;
        Tue, 29 Nov 2022 18:57:52 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04F80D6E;
        Tue, 29 Nov 2022 18:57:59 -0800 (PST)
Received: from [10.162.43.8] (unknown [10.162.43.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F4943F67D;
        Tue, 29 Nov 2022 18:57:43 -0800 (PST)
Message-ID: <dd01a9d2-4b9b-8edc-1195-40a3624f9a8a@arm.com>
Date:   Wed, 30 Nov 2022 08:27:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v7 1/2] mm/tlbbatch: Introduce
 arch_tlbbatch_should_defer()
Content-Language: en-US
To:     Yicong Yang <yangyicong@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     yangyicong@hisilicon.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        catalin.marinas@arm.com, will@kernel.org,
        linux-doc@vger.kernel.org, corbet@lwn.net, peterz@infradead.org,
        arnd@arndb.de, punit.agrawal@bytedance.com,
        linux-kernel@vger.kernel.org, darren@os.amperecomputing.com,
        huzhanyuan@oppo.com, lipeifeng@oppo.com, zhangshiming@oppo.com,
        guojian@oppo.com, realmz6@gmail.com, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        Barry Song <21cnbao@gmail.com>, wangkefeng.wang@huawei.com,
        xhao@linux.alibaba.com, prime.zeng@hisilicon.com,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Barry Song <baohua@kernel.org>
References: <20221117082648.47526-1-yangyicong@huawei.com>
 <20221117082648.47526-2-yangyicong@huawei.com>
 <20221129152306.54b6d439e2a0ca7ece1d1afa@linux-foundation.org>
 <9999b87d-5f7e-275b-d99f-b51ef19361eb@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <9999b87d-5f7e-275b-d99f-b51ef19361eb@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/30/22 07:53, Yicong Yang wrote:
> On 2022/11/30 7:23, Andrew Morton wrote:
>> On Thu, 17 Nov 2022 16:26:47 +0800 Yicong Yang <yangyicong@huawei.com> wrote:
>>
>>> From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>>>
>>> The entire scheme of deferred TLB flush in reclaim path rests on the
>>> fact that the cost to refill TLB entries is less than flushing out
>>> individual entries by sending IPI to remote CPUs. But architecture
>>> can have different ways to evaluate that. Hence apart from checking
>>> TTU_BATCH_FLUSH in the TTU flags, rest of the decision should be
>>> architecture specific.
>>>
>>> ...
>>>
>>> --- a/arch/x86/include/asm/tlbflush.h
>>> +++ b/arch/x86/include/asm/tlbflush.h
>>> @@ -240,6 +240,18 @@ static inline void flush_tlb_page(struct vm_area_struct *vma, unsigned long a)
>>>  	flush_tlb_mm_range(vma->vm_mm, a, a + PAGE_SIZE, PAGE_SHIFT, false);
>>>  }
>>>  
>>> +static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
>>> +{
>>> +	bool should_defer = false;
>>> +
>>> +	/* If remote CPUs need to be flushed then defer batch the flush */
>>> +	if (cpumask_any_but(mm_cpumask(mm), get_cpu()) < nr_cpu_ids)
>>> +		should_defer = true;
>>> +	put_cpu();
>>> +
>>> +	return should_defer;
>>> +}
>>> +
>>>  static inline u64 inc_mm_tlb_gen(struct mm_struct *mm)
>>>  {
>>>  	/*
>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>> index 2ec925e5fa6a..a9ab10bc0144 100644
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -685,17 +685,10 @@ static void set_tlb_ubc_flush_pending(struct mm_struct *mm, bool writable)
>>>   */
>>>  static bool should_defer_flush(struct mm_struct *mm, enum ttu_flags flags)
>>>  {
>>> -	bool should_defer = false;
>>> -
>>>  	if (!(flags & TTU_BATCH_FLUSH))
>>>  		return false;
>>>  
>>> -	/* If remote CPUs need to be flushed then defer batch the flush */
>>> -	if (cpumask_any_but(mm_cpumask(mm), get_cpu()) < nr_cpu_ids)
>>> -		should_defer = true;
>>> -	put_cpu();
>>> -
>>> -	return should_defer;
>>> +	return arch_tlbbatch_should_defer(mm);
>>>  }
>>
>> I think this conversion could have been done better.
>>
>> should_defer_flush() is compiled if
>> CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH.  So the patch implicitly
>> assumes that only x86 implements
>> CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH.  Presently true, but what
>> happens if sparc (for example) wants to set
>> CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH?  Now sparc needs its private
>> version of arch_tlbbatch_should_defer(), even if that is identical to
>> x86's.
>>
> 
> The current logic is if architecture want to enable batched TLB flush, they
> need to implement their own version of arch_tlbbatch_should_defer() (for the
> hint to defer the TLB flush) and arch_tlbbatch_add_mm() (for pending TLB flush)
> and select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH. That's what we do in Patch 2/2 for
> enabling this on arm64.
> 
> Since it is architecture specific, we must rely on the architecture to implement
> these two functions. Only select the ARCH_HAS_ARCH_TLBBATCH_SHOULD_DEFER is not
> enough.
> 
>> Wouldn't it be better to make should_defer_flush() a __weak
>> function in rmap.c, or a static inline inside #ifndef
>> ARCH_HAS_ARCH_TLBBATCH_SHOULD_DEFER, or whatever technique best fits?
>>
> 
> When ARCH_HAS_ARCH_TLBBATCH_SHOULD_DEFER is not selected, should_defer_flush()
> is implemented to only return false. I think this match what you want already.

Right, platform needs to provide both the helpers arch_tlbbatch_should_defer() and
arch_tlbbatch_add_mm() before ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH can be selected.
Otherwise there is a fallback should_defer_flush() definition which always return
negative when ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH is not selected.
