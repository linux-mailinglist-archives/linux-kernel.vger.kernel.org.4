Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C3263CD55
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 03:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiK3CYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 21:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbiK3CX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 21:23:58 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB256037F;
        Tue, 29 Nov 2022 18:23:50 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NMNFY6J5yzqSpv;
        Wed, 30 Nov 2022 10:19:45 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 30 Nov 2022 10:23:47 +0800
CC:     <yangyicong@hisilicon.com>, <linux-mm@kvack.org>,
        <linux-arm-kernel@lists.infradead.org>, <x86@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <anshuman.khandual@arm.com>, <linux-doc@vger.kernel.org>,
        <corbet@lwn.net>, <peterz@infradead.org>, <arnd@arndb.de>,
        <punit.agrawal@bytedance.com>, <linux-kernel@vger.kernel.org>,
        <darren@os.amperecomputing.com>, <huzhanyuan@oppo.com>,
        <lipeifeng@oppo.com>, <zhangshiming@oppo.com>, <guojian@oppo.com>,
        <realmz6@gmail.com>, <linux-mips@vger.kernel.org>,
        <openrisc@lists.librecores.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-riscv@lists.infradead.org>, <linux-s390@vger.kernel.org>,
        Barry Song <21cnbao@gmail.com>, <wangkefeng.wang@huawei.com>,
        <xhao@linux.alibaba.com>, <prime.zeng@hisilicon.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Barry Song <baohua@kernel.org>
Subject: Re: [PATCH v7 1/2] mm/tlbbatch: Introduce
 arch_tlbbatch_should_defer()
To:     Andrew Morton <akpm@linux-foundation.org>
References: <20221117082648.47526-1-yangyicong@huawei.com>
 <20221117082648.47526-2-yangyicong@huawei.com>
 <20221129152306.54b6d439e2a0ca7ece1d1afa@linux-foundation.org>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <9999b87d-5f7e-275b-d99f-b51ef19361eb@huawei.com>
Date:   Wed, 30 Nov 2022 10:23:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20221129152306.54b6d439e2a0ca7ece1d1afa@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/30 7:23, Andrew Morton wrote:
> On Thu, 17 Nov 2022 16:26:47 +0800 Yicong Yang <yangyicong@huawei.com> wrote:
> 
>> From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>>
>> The entire scheme of deferred TLB flush in reclaim path rests on the
>> fact that the cost to refill TLB entries is less than flushing out
>> individual entries by sending IPI to remote CPUs. But architecture
>> can have different ways to evaluate that. Hence apart from checking
>> TTU_BATCH_FLUSH in the TTU flags, rest of the decision should be
>> architecture specific.
>>
>> ...
>>
>> --- a/arch/x86/include/asm/tlbflush.h
>> +++ b/arch/x86/include/asm/tlbflush.h
>> @@ -240,6 +240,18 @@ static inline void flush_tlb_page(struct vm_area_struct *vma, unsigned long a)
>>  	flush_tlb_mm_range(vma->vm_mm, a, a + PAGE_SIZE, PAGE_SHIFT, false);
>>  }
>>  
>> +static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
>> +{
>> +	bool should_defer = false;
>> +
>> +	/* If remote CPUs need to be flushed then defer batch the flush */
>> +	if (cpumask_any_but(mm_cpumask(mm), get_cpu()) < nr_cpu_ids)
>> +		should_defer = true;
>> +	put_cpu();
>> +
>> +	return should_defer;
>> +}
>> +
>>  static inline u64 inc_mm_tlb_gen(struct mm_struct *mm)
>>  {
>>  	/*
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 2ec925e5fa6a..a9ab10bc0144 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -685,17 +685,10 @@ static void set_tlb_ubc_flush_pending(struct mm_struct *mm, bool writable)
>>   */
>>  static bool should_defer_flush(struct mm_struct *mm, enum ttu_flags flags)
>>  {
>> -	bool should_defer = false;
>> -
>>  	if (!(flags & TTU_BATCH_FLUSH))
>>  		return false;
>>  
>> -	/* If remote CPUs need to be flushed then defer batch the flush */
>> -	if (cpumask_any_but(mm_cpumask(mm), get_cpu()) < nr_cpu_ids)
>> -		should_defer = true;
>> -	put_cpu();
>> -
>> -	return should_defer;
>> +	return arch_tlbbatch_should_defer(mm);
>>  }
> 
> I think this conversion could have been done better.
> 
> should_defer_flush() is compiled if
> CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH.  So the patch implicitly
> assumes that only x86 implements
> CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH.  Presently true, but what
> happens if sparc (for example) wants to set
> CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH?  Now sparc needs its private
> version of arch_tlbbatch_should_defer(), even if that is identical to
> x86's.
> 

The current logic is if architecture want to enable batched TLB flush, they
need to implement their own version of arch_tlbbatch_should_defer() (for the
hint to defer the TLB flush) and arch_tlbbatch_add_mm() (for pending TLB flush)
and select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH. That's what we do in Patch 2/2 for
enabling this on arm64.

Since it is architecture specific, we must rely on the architecture to implement
these two functions. Only select the ARCH_HAS_ARCH_TLBBATCH_SHOULD_DEFER is not
enough.

> Wouldn't it be better to make should_defer_flush() a __weak
> function in rmap.c, or a static inline inside #ifndef
> ARCH_HAS_ARCH_TLBBATCH_SHOULD_DEFER, or whatever technique best fits?
> 

When ARCH_HAS_ARCH_TLBBATCH_SHOULD_DEFER is not selected, should_defer_flush()
is implemented to only return false. I think this match what you want already.

Thanks.




