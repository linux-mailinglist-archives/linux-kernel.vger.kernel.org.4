Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6866CA544
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjC0NLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbjC0NLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:11:15 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81BD212F;
        Mon, 27 Mar 2023 06:11:13 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PlXn80JgMzrVvN;
        Mon, 27 Mar 2023 20:53:48 +0800 (CST)
Received: from [10.67.108.26] (10.67.108.26) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 27 Mar
 2023 20:54:54 +0800
Message-ID: <39c36857-4452-0ccd-2cb8-da083e69124a@huawei.com>
Date:   Mon, 27 Mar 2023 20:54:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH -next 1/2] riscv: kdump: Implement
 crashkernel=X,[high,low]
Content-Language: en-US
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <conor.dooley@microchip.com>, <guoren@kernel.org>,
        <heiko@sntech.de>, <bjorn@rivosinc.com>, <alex@ghiti.fr>,
        <akpm@linux-foundation.org>, <atishp@rivosinc.com>,
        <bhe@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>
References: <20230320204244.1637821-1-chenjiahao16@huawei.com>
 <20230320204244.1637821-2-chenjiahao16@huawei.com>
 <be3ff2fa-39ea-8d36-0e11-e75195509a2e@huawei.com>
From:   "chenjiahao (C)" <chenjiahao16@huawei.com>
In-Reply-To: <be3ff2fa-39ea-8d36-0e11-e75195509a2e@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.26]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/3/21 9:42, Leizhen (ThunderTown) wrote:
>
> On 2023/3/21 4:42, Chen Jiahao wrote:
>> On riscv, the current crash kernel allocation logic is trying to
>> allocate within 32bit addressible memory region by default, if
>> failed, try to allocate without 4G restriction.
>>
>> In need of saving DMA zone memory while allocating a relatively large
>> crash kernel region, allocating the reserved memory top down in
>> high memory, without overlapping the DMA zone, is a mature solution.
>> Here introduce the parameter option crashkernel=X,[high,low].
>>
>> We can reserve the crash kernel from high memory above DMA zone range
>> by explicitly passing "crashkernel=X,high"; or reserve a memory range
>> below 4G with "crashkernel=X,low".
>>
>> Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>
>> ---
>>   arch/riscv/kernel/setup.c |  5 ++++
>>   arch/riscv/mm/init.c      | 56 ++++++++++++++++++++++++++++++++++++---
>>   2 files changed, 58 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>> index 376d2827e736..d867b1535da4 100644
>> --- a/arch/riscv/kernel/setup.c
>> +++ b/arch/riscv/kernel/setup.c
>> @@ -176,6 +176,11 @@ static void __init init_resources(void)
>>   		if (ret < 0)
>>   			goto error;
>>   	}
>> +	if (crashk_low_res.start != crashk_low_res.end) {
>> +		ret = add_resource(&iomem_resource, &crashk_low_res);
>> +		if (ret < 0)
>> +			goto error;
>> +	}
>>   #endif
>>   
>>   #ifdef CONFIG_CRASH_DUMP
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index 478d6763a01a..5def2174b243 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -1152,6 +1152,28 @@ static inline void setup_vm_final(void)
>>   }
>>   #endif /* CONFIG_MMU */
>>   
>> +/* Reserve 128M low memory by default for swiotlb buffer */
>> +#define DEFAULT_CRASH_KERNEL_LOW_SIZE	(128UL << 20)
>> +
>> +static int __init reserve_crashkernel_low(unsigned long long low_size)
>> +{
>> +	unsigned long long low_base;
>> +
>> +	low_base = memblock_phys_alloc_range(low_size, PMD_SIZE, 0, dma32_phys_limit);
>> +	if (!low_base) {
>> +		pr_err("cannot allocate crashkernel low memory (size:0x%llx).\n", low_size);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	pr_info("crashkernel low memory reserved: 0x%08llx - 0x%08llx (%lld MB)\n",
> For unsigned long long, 08 --> 016.

Sure, I will fix it soon in another version.

>
>> +		low_base, low_base + low_size, low_size >> 20);
>> +
>> +	crashk_low_res.start = low_base;
>> +	crashk_low_res.end = low_base + low_size - 1;
>> +
>> +	return 0;
>> +}
>> +
>>   /*
>>    * reserve_crashkernel() - reserves memory for crash kernel
>>    *
>> @@ -1163,6 +1185,7 @@ static void __init reserve_crashkernel(void)
>>   {
>>   	unsigned long long crash_base = 0;
>>   	unsigned long long crash_size = 0;
>> +	unsigned long long crash_low_size = 0;
>>   	unsigned long search_start = memblock_start_of_DRAM();
>>   	unsigned long search_end = memblock_end_of_DRAM();
>>   
>> @@ -1182,8 +1205,26 @@ static void __init reserve_crashkernel(void)
>>   
>>   	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
>>   				&crash_size, &crash_base);
>> -	if (ret || !crash_size)
>> +	if (ret == -ENOENT) {
>> +		ret = parse_crashkernel_high(boot_command_line, 0, &crash_size, &crash_base);
>> +		if (ret || !crash_size)
>> +			return;
>> +
>> +		/*
>> +		 * crashkernel=Y,low can be specified or not, but invalid value
>> +		 * is not allowed.
>> +		 */
>> +		ret = parse_crashkernel_low(boot_command_line, 0, &crash_low_size, &crash_base);
>> +		if (ret == -ENOENT)
>> +			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
>> +		else if (ret)
>> +			return;
>> +
>> +		search_start = dma32_phys_limit;
>> +	} else if (ret || !crash_size) {
>> +		/* Invalid argument value specified */
>>   		return;
>> +	}
>>   
>>   	crash_size = PAGE_ALIGN(crash_size);
>>   
>> @@ -1201,16 +1242,25 @@ static void __init reserve_crashkernel(void)
>>   	 */
>>   	crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
>>   					       search_start,
>> -					       min(search_end, (unsigned long) SZ_4G));
>> +					       min(search_end, (unsigned long) dma32_phys_limit));
>>   	if (crash_base == 0) {
>>   		/* Try again without restricting region to 32bit addressible memory */
>>   		crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
>> -						search_start, search_end);
>> +						       search_start, search_end);
>>   		if (crash_base == 0) {
>>   			pr_warn("crashkernel: couldn't allocate %lldKB\n",
>>   				crash_size >> 10);
>>   			return;
>>   		}
>> +
>> +		if (!crash_low_size)
>> +			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
>> +	}
>> +
>> +	if ((crash_base > dma32_phys_limit - crash_low_size) &&
>> +	     crash_low_size && reserve_crashkernel_low(crash_low_size)) {
>> +		memblock_phys_free(crash_base, crash_size);
>> +		return;
>>   	}
>>   
>>   	pr_info("crashkernel: reserved 0x%016llx - 0x%016llx (%lld MB)\n",
>>
BR,

Chen, Jiahao

