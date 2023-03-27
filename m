Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452EC6CA491
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 14:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjC0Muv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 08:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjC0Mut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 08:50:49 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4DF1707;
        Mon, 27 Mar 2023 05:50:47 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PlXdt52LRznZ50;
        Mon, 27 Mar 2023 20:47:30 +0800 (CST)
Received: from [10.67.108.26] (10.67.108.26) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 27 Mar
 2023 20:50:44 +0800
Message-ID: <8bf91bee-e51c-90f6-b522-1db4094966f4@huawei.com>
Date:   Mon, 27 Mar 2023 20:50:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH -next 1/2] riscv: kdump: Implement
 crashkernel=X,[high,low]
Content-Language: en-US
To:     Simon Horman <horms@kernel.org>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <conor.dooley@microchip.com>, <guoren@kernel.org>,
        <heiko@sntech.de>, <bjorn@rivosinc.com>, <alex@ghiti.fr>,
        <akpm@linux-foundation.org>, <atishp@rivosinc.com>,
        <bhe@redhat.com>, <thunder.leizhen@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>
References: <20230320204244.1637821-1-chenjiahao16@huawei.com>
 <20230320204244.1637821-2-chenjiahao16@huawei.com>
 <ZBhvhBTQhAnN5qdm@kernel.org>
From:   "chenjiahao (C)" <chenjiahao16@huawei.com>
In-Reply-To: <ZBhvhBTQhAnN5qdm@kernel.org>
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


On 2023/3/20 22:36, Simon Horman wrote:
> On Tue, Mar 21, 2023 at 04:42:43AM +0800, Chen Jiahao wrote:
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
> Some minor nits, but I don't think there is any need to respin for them.
>
> Reviewed-by: Simon Horman <horms@kernel.org>

I will send another version and clean up these by the way, thanks.

Chen, Jiahao


>
> ...
>
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index 478d6763a01a..5def2174b243 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
> ...
>
>> @@ -1201,16 +1242,25 @@ static void __init reserve_crashkernel(void)
>>   	 */
>>   	crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
>>   					       search_start,
>> -					       min(search_end, (unsigned long) SZ_4G));
>> +					       min(search_end, (unsigned long) dma32_phys_limit));
> nit: While here, you could drop the space before 'ma32_phys_limit'.
>       Or perhaps use min_t, which seems appropriate here.
>
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
> nit: The line above should be aligned one character to the left
>       (remove one space in the indent).
>
>> +		memblock_phys_free(crash_base, crash_size);
>> +		return;
>>   	}
>>   
>>   	pr_info("crashkernel: reserved 0x%016llx - 0x%016llx (%lld MB)\n",
> ...
