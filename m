Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E2E6D070D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjC3Nkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbjC3Nkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:40:45 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD281FFC;
        Thu, 30 Mar 2023 06:40:38 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PnPbZ2rqwzSqBR;
        Thu, 30 Mar 2023 21:36:58 +0800 (CST)
Received: from [10.67.108.26] (10.67.108.26) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 30 Mar
 2023 21:40:35 +0800
Message-ID: <b8a32e3c-c083-20de-16d1-f628b02b739b@huawei.com>
Date:   Thu, 30 Mar 2023 21:40:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH -next v2 1/2] riscv: kdump: Implement
 crashkernel=X,[high,low]
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <conor.dooley@microchip.com>, <guoren@kernel.org>,
        <heiko@sntech.de>, <bjorn@rivosinc.com>, <alex@ghiti.fr>,
        <akpm@linux-foundation.org>, <atishp@rivosinc.com>,
        <thunder.leizhen@huawei.com>, <horms@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>
References: <20230328115150.2700016-1-chenjiahao16@huawei.com>
 <20230328115150.2700016-2-chenjiahao16@huawei.com>
 <ZCQewkvSpaI52DSM@MiWiFi-R3L-srv>
From:   "chenjiahao (C)" <chenjiahao16@huawei.com>
In-Reply-To: <ZCQewkvSpaI52DSM@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.26]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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


On 2023/3/29 19:19, Baoquan He wrote:
> On 03/28/23 at 07:51pm, Chen Jiahao wrote:

Thanks for reviewing.

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
>> ---
>>   arch/riscv/kernel/setup.c |  5 ++++
>>   arch/riscv/mm/init.c      | 63 ++++++++++++++++++++++++++++++++++++---
>>   2 files changed, 64 insertions(+), 4 deletions(-)
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
>> index 478d6763a01a..b7708cc467fa 100644
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
>> @@ -1163,6 +1185,7 @@ static void __init reserve_crashkernel(void)
>>   {
>>   	unsigned long long crash_base = 0;
>>   	unsigned long long crash_size = 0;
>> +	unsigned long long crash_low_size = 0;
>>   	unsigned long search_start = memblock_start_of_DRAM();
>>   	unsigned long search_end = memblock_end_of_DRAM();
>>   
>> @@ -1182,8 +1205,30 @@ static void __init reserve_crashkernel(void)
>>   
>>   	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
>>   				&crash_size, &crash_base);
>> -	if (ret || !crash_size)
>> +	if (ret == -ENOENT) {
>> +		/*
>> +		 * crashkernel=X,[high,low] can be specified or not, but
>> +		 * invalid value is not allowed.
>> +		 */
>> +		ret = parse_crashkernel_high(boot_command_line, 0, &crash_size, &crash_base);
> I would add a local variable to assign boot_command_line to it just like
> arm64 does. Then these lines could be shorter.
>
> 	char *cmdline = boot_command_line;
Agreed, I will clean this up later in next version.
>> +		if (ret || !crash_size)
>> +			return;
>> +
>> +		/*
>> +		 * crashkernel=Y,low is valid only when crashkernel=X,high
>> +		 * is passed and high memory is reserved successful.
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
>> @@ -1201,16 +1246,26 @@ static void __init reserve_crashkernel(void)
>>   	 */
>>   	crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
>>   					       search_start,
>> -					       min(search_end, (unsigned long) SZ_4G));
>> +					       min(search_end, (unsigned long)dma32_phys_limit));
>>   	if (crash_base == 0) {
> The above conditional check isn't right. If crashkernel=size@offset
> specified, the reservation failure won't trigger retry. This seems to be
> originally introduced by old commit, while this need be fixed firstly.

Just a little curious about the rule to cope with this specific case. If 
"crashkernel=size@offset" was passed

but reserve failed, should try again to allocate in high memory, 
regardless the specified size@offset,

or just throw a warning and return? Since I noticed the current logic 
here on Arm64 is to check if !fixed_base first

before retrying.


Or have I missed anything else?

>> -		/* Try again without restricting region to 32bit addressible memory */
>> +		/* Try again above the region of 32bit addressible memory */
>>   		crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
>> -						search_start, search_end);
>> +						       max(search_start, (unsigned long)dma32_phys_limit),
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
BR,

Jiahao

