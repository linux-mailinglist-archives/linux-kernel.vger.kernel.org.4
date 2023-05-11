Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A966FEE00
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 10:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235531AbjEKIrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 04:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbjEKIrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 04:47:19 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8061BFF;
        Thu, 11 May 2023 01:47:16 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QH57h18LPzsRb7;
        Thu, 11 May 2023 16:45:20 +0800 (CST)
Received: from [10.67.108.26] (10.67.108.26) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 11 May
 2023 16:47:13 +0800
Message-ID: <366da9fb-0a3c-ac62-3df3-7a7f328973a6@huawei.com>
Date:   Thu, 11 May 2023 16:47:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH -next v4 1/2] riscv: kdump: Implement
 crashkernel=X,[high,low]
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <conor.dooley@microchip.com>, <guoren@kernel.org>,
        <heiko@sntech.de>, <bjorn@rivosinc.com>, <alex@ghiti.fr>,
        <akpm@linux-foundation.org>, <atishp@rivosinc.com>,
        <thunder.leizhen@huawei.com>, <horms@kernel.org>
References: <20230410130553.3226347-1-chenjiahao16@huawei.com>
 <20230410130553.3226347-2-chenjiahao16@huawei.com>
 <ZEnaPzx3O9NWixIR@MiWiFi-R3L-srv>
From:   "chenjiahao (C)" <chenjiahao16@huawei.com>
In-Reply-To: <ZEnaPzx3O9NWixIR@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.26]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/4/27 10:13, Baoquan He wrote:
> On 04/10/23 at 09:05pm, Chen Jiahao wrote:
>> On riscv, the current crash kernel allocation logic is trying to
>> allocate within 32bit addressible memory region by default, if
>> failed, try to allocate without 4G restriction.
>>
>> In need of saving DMA zone memory while allocating a relatively large
>> crash kernel region, allocating the reserved memory top down in
>> high memory, without overlapping the DMA zone, is a mature solution.
>> Here introduce the parameter option crashkernel=X,[high,low].
>>
>> One can reserve the crash kernel from high memory above DMA zone range
>> by explicitly passing "crashkernel=X,high"; or reserve a memory range
>> below 4G with "crashkernel=X,low".
>>
>> Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>
>> Acked-by: Guo Ren <guoren@kernel.org>
>> Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>   arch/riscv/kernel/setup.c |  5 +++
>>   arch/riscv/mm/init.c      | 71 ++++++++++++++++++++++++++++++++++++---
>>   2 files changed, 71 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>> index 5d3184cbf518..ea84e5047c23 100644
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
>> index 478d6763a01a..70f6cb281ed1 100644
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
>> +	pr_info("crashkernel low memory reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
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
>> @@ -1163,8 +1185,12 @@ static void __init reserve_crashkernel(void)
>>   {
>>   	unsigned long long crash_base = 0;
>>   	unsigned long long crash_size = 0;
>> +	unsigned long long crash_low_size = 0;
>>   	unsigned long search_start = memblock_start_of_DRAM();
>>   	unsigned long search_end = memblock_end_of_DRAM();
>> +	unsigned long search_low_max = (unsigned long)dma32_phys_limit;
>> +	char *cmdline = boot_command_line;
>> +	bool fixed_base = false;
>>   
>>   	int ret = 0;
>>   
>> @@ -1180,14 +1206,34 @@ static void __init reserve_crashkernel(void)
>>   		return;
>>   	}
>>   
>> -	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
>> +	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
>>   				&crash_size, &crash_base);
>> -	if (ret || !crash_size)
>> +	if (ret == -ENOENT) {
>> +		/* Fallback to crashkernel=X,[high,low] */
>> +		ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
>> +		if (ret || !crash_size)
>> +			return;
>> +
>> +		/*
>> +		 * crashkernel=Y,low is valid only when crashkernel=X,high
>> +		 * is passed.
>> +		 */
>> +		ret = parse_crashkernel_low(cmdline, 0, &crash_low_size, &crash_base);
>> +		if (ret == -ENOENT)
>> +			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
>> +		else if (ret)
>> +			return;
>> +
>> +		search_start = search_low_max;
>> +	} else if (ret || !crash_size) {
>> +		/* Invalid argument value specified */
>>   		return;
>> +	}
>>   
>>   	crash_size = PAGE_ALIGN(crash_size);
>>   
>>   	if (crash_base) {
>> +		fixed_base = true;
>>   		search_start = crash_base;
>>   		search_end = crash_base + crash_size;
>>   	}
>> @@ -1201,16 +1247,31 @@ static void __init reserve_crashkernel(void)
>>   	 */
>>   	crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
>>   					       search_start,
>> -					       min(search_end, (unsigned long) SZ_4G));
>> +					       min(search_end, search_low_max));
> Here, it seems not right in case crashkernel=,high is specified. In that
> case, search_start == search_low_max, then the min(search_end,
> search_low_max) will get search_low_max too. Then you make the fallback
> in below code block to try to get crashkernel reservation above 4G. This
> doesn't comply with the crashkernel=,high grammer which has been
> implemented in other architectures.
>
> For crashkernel=,high, user explicitly require memory reservation above
> 4G. Why does crashkernel=,high is needed? E.g on big end server with
> huge memory, while the low memory under 4G is limited and precious.
> Hence, user want to put the main crashkernel reservation above 4G to
> contain kdump kernel/initrd and run user space program, while with few
> low memory for pci device driver. E.g crashkernel=2G,high, it won't
> impact much if there's huge memory above 4G and get crashkernel
> reservation there. However, it impacts a lot if it reserves memory
> below 4G.
>
> I would strongly suggest that risc-v also reserve memory from above 4G
> for crashkernel=,high, then fallback to below 4G. That's consistent with
> crashkernel=,high grammer.

Sorry for late response.

I have got the point here. So with the original implication of "crashkernel=,high",
there is even no need to try reserving low memory under 4G. I have arranged another
version of patchset, in which I updated the allocation logic in that case.

For example, when "crashkernel=1G,high" is specified, the previous logic is like:
alloc range: crash_size: 0x40000000 (1G), crash_base: 4G_limit,
              crash_max: 4G_limit
alloc range high: crash_size: 0x40000000 (1G), crash_base: 4G_limit,
                   crash_max: memblock_range_end
alloc range low: low_size: 0x8000000 (128MB,default), crash_base: 0x0,
                  crash_max: 4G_limit

After revision, the logic is like:
alloc range: crash_size: 0x40000000 (1G), crash_base: memblock_range_start,
              crash_max: memblock_range_end
alloc range low: low_size: 0x8000000 (128MB,default), crash_base: 0x0,
                  crash_max: 4G_limit

Please let me know if there is any problem exist.

Thanks,
Jiahao


>
>>   	if (crash_base == 0) {
>> -		/* Try again without restricting region to 32bit addressible memory */
>> +		if (fixed_base) {
>> +			pr_warn("crashkernel: allocating failed with given size@offset\n");
>> +			return;
>> +		}
>> +
>> +		/* Try again above the region of 32bit addressible memory */
>>   		crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
>> -						search_start, search_end);
>> +						       max(search_start, search_low_max),
>> +						       search_end);
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
>> +	    crash_low_size && reserve_crashkernel_low(crash_low_size)) {
>> +		memblock_phys_free(crash_base, crash_size);
>> +		return;
>>   	}
>>   
>>   	pr_info("crashkernel: reserved 0x%016llx - 0x%016llx (%lld MB)\n",
>> -- 
>> 2.31.1
>>
