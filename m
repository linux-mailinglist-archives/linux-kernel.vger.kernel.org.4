Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC11374484E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 11:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjGAJvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 05:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGAJvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 05:51:32 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9135B1FE7;
        Sat,  1 Jul 2023 02:51:29 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QtS6k6rqTzMpVC;
        Sat,  1 Jul 2023 17:48:14 +0800 (CST)
Received: from [10.67.108.26] (10.67.108.26) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 1 Jul
 2023 17:51:27 +0800
Message-ID: <5c80666c-e6e2-8fa6-50b6-89536315925e@huawei.com>
Date:   Sat, 1 Jul 2023 17:51:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH -next v5 1/2] riscv: kdump: Implement
 crashkernel=X,[high,low]
Content-Language: en-US
From:   "chenjiahao (C)" <chenjiahao16@huawei.com>
To:     Baoquan He <bhe@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <conor.dooley@microchip.com>, <guoren@kernel.org>,
        <heiko@sntech.de>, <bjorn@rivosinc.com>, <alex@ghiti.fr>,
        <akpm@linux-foundation.org>, <atishp@rivosinc.com>,
        <thunder.leizhen@huawei.com>, <horms@kernel.org>
References: <20230511085139.1039088-1-chenjiahao16@huawei.com>
 <20230511085139.1039088-2-chenjiahao16@huawei.com>
 <ZHwKFADVXyNYJBCp@MiWiFi-R3L-srv>
 <852b8777-3c6e-f76b-0413-1c66629f33cd@huawei.com>
In-Reply-To: <852b8777-3c6e-f76b-0413-1c66629f33cd@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.108.26]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/6/15 17:49, chenjiahao (C) wrote:
>
> On 2023/6/4 11:50, Baoquan He wrote:
>> Hi Jiahao,
>>
>> On 05/11/23 at 04:51pm, Chen Jiahao wrote:
>> ......
>>> @@ -1300,14 +1325,34 @@ static void __init reserve_crashkernel(void)
>>>           return;
>>>       }
>>>   -    ret = parse_crashkernel(boot_command_line, 
>>> memblock_phys_mem_size(),
>>> +    ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
>>>                   &crash_size, &crash_base);
>>> -    if (ret || !crash_size)
>>> +    if (ret == -ENOENT) {
>>> +        /* Fallback to crashkernel=X,[high,low] */
>>> +        ret = parse_crashkernel_high(cmdline, 0, &crash_size, 
>>> &crash_base);
>>> +        if (ret || !crash_size)
>>> +            return;
>>> +
>>> +        /*
>>> +         * crashkernel=Y,low is valid only when crashkernel=X,high
>>> +         * is passed.
>>> +         */
>>> +        ret = parse_crashkernel_low(cmdline, 0, &crash_low_size, 
>>> &crash_base);
>>> +        if (ret == -ENOENT)
>>> +            crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
>>> +        else if (ret)
>>> +            return;
>>> +
>>> +        search_end = memblock_end_of_DRAM();
>>> +    } else if (ret || !crash_size) {
>>> +        /* Invalid argument value specified */
>>>           return;
>>> +    }
>> The parsing part looks great, while you didn't mark if it's specified
>> high reservation, please see later comment why it's needed.
>>
>>>         crash_size = PAGE_ALIGN(crash_size);
>>>         if (crash_base) {
>>> +        fixed_base = true;
>>>           search_start = crash_base;
>>>           search_end = crash_base + crash_size;
>>>       }
>>> @@ -1320,17 +1365,31 @@ static void __init reserve_crashkernel(void)
>>>        * swiotlb can work on the crash kernel.
>>>        */
>>>       crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
>>> -                           search_start,
>>> -                           min(search_end, (unsigned long) SZ_4G));
>>> +                           search_start, search_end);
>> If it's a specified high reservation, you have
>> search_start = memblock_start_of_DRAM();
>> search_end = memblock_end_of_DRAM();
>>
>> Then it attempts to search top down first time here.
>>
>>>       if (crash_base == 0) {
>>> -        /* Try again without restricting region to 32bit 
>>> addressible memory */
>>> +        if (fixed_base) {
>>> +            pr_warn("crashkernel: allocating failed with given 
>>> size@offset\n");
>>> +            return;
>>> +        }
>>> +        search_end = memblock_end_of_DRAM();
>>> +
>>> +        /* Try again above the region of 32bit addressible memory */
>>>           crash_base = memblock_phys_alloc_range(crash_size, PMD_SIZE,
>>> -                        search_start, search_end);
>>> +                               search_start, search_end);
>> If crashkernel=,high case, the first attempt failed, here it assigns
>> search_end with memblock_end_of_DRAM(). It's the exactly the same
>> attempt, why is that needed? Why don't you use a local variable 'high'
>> to mark the crashkernel=,hig, then judge when deciding how to adjsut the
>> reservation range.
>>
>> Do I misunderstand the code?
>>
>> Thanks
>> Baoquan
>
> You are right. Here I use search_end = memblock_end_of_DRAM() for the
> first attempt on "crashkernel=,high" case, but it will not distinct from
> other cases if the first attempt fails.
>
> I have read your latest refactor on Arm64, introducing the "high" flag
> is a good choice, the logic gets more straightforward when handling
> crashkernel=,high case and retrying.
>
> Following that logic, here introducing and set "high" flag when parsing
> cmdline, when the first attempt failed:
>
> if fixed_base:
>     failed and return;
>
> if set high:
>     search_start = memblock_start_of_DRAM();
>     search_end = (unsigned long)dma32_phys_limit;
> else:
>     search_start = (unsigned long)dma32_phys_limit;
>     search_end = memblock_end_of_DRAM();
>
> second attempt with new {search_start, search_end}
> ...
>
> This should handle "crashkernel=,high" case correctly and avoid cross
> 4G reservation.
>
> Is that logic correct, or is any other problem missed?
>
> Thanks,
> Jiahao

I have sent v6 patches, implementing the logic above. That fixes the 
retrying

logic and should be aligned with Arm64 code.


Please let me know if there is any problem remains.


Thanks,

Jiahao


>
>>
>>>           if (crash_base == 0) {
>>>               pr_warn("crashkernel: couldn't allocate %lldKB\n",
>>>                   crash_size >> 10);
>>>               return;
>>>           }
>>> +
>>> +        if (!crash_low_size)
>>> +            crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
>>> +    }
>>> +
>>> +    if ((crash_base > dma32_phys_limit - crash_low_size) &&
>>> +        crash_low_size && reserve_crashkernel_low(crash_low_size)) {
>>> +        memblock_phys_free(crash_base, crash_size);
>>> +        return;
>>>       }
>>>         pr_info("crashkernel: reserved 0x%016llx - 0x%016llx (%lld 
>>> MB)\n",
>>> -- 
>>> 2.31.1
>>>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
