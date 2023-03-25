Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC726C8A0E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 02:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjCYBxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 21:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjCYBxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 21:53:41 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CCC2129
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 18:53:39 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Pk2C52DV1zrWWm;
        Sat, 25 Mar 2023 09:52:33 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 25 Mar 2023 09:53:36 +0800
Subject: Re: [PATCH v4] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
To:     Baoquan He <bhe@redhat.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        <linux-kernel@vger.kernel.org>, <horms@kernel.org>,
        <John.p.donnelly@oracle.com>, <will@kernel.org>,
        <kexec@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>
References: <20230306084124.300584-1-bhe@redhat.com>
 <ZBHbw3Vp4dxukGOD@arm.com> <ZBLlyGxGk33yrA+2@MiWiFi-R3L-srv>
 <ZBNTRBqqb74T3RMx@arm.com> <ZBSCeWtHvqc/iJZg@MiWiFi-R3L-srv>
 <ZBSr/kIIuxmC/INY@arm.com> <ZBhbqAOsHFj5cheI@MiWiFi-R3L-srv>
 <ZByLga6FS5o8Syug@arm.com> <4d4ecdd6-9716-570d-5595-e47bfbb58cdf@huawei.com>
 <ZB25WN02AHOS8RTT@MiWiFi-R3L-srv>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <cac9bb78-18b3-6f7d-8f35-db15de7c9b80@huawei.com>
Date:   Sat, 25 Mar 2023 09:53:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ZB25WN02AHOS8RTT@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/24 22:53, Baoquan He wrote:
> Hi Leizhen,
> 
> On 03/24/23 at 10:47am, Leizhen (ThunderTown) wrote:
> ...... 
>>>>>> 2) with the fixed CRASH_ADDR_LOW_MAX as 4G, we can easily fix the
>>>>>> problem of base page mapping for the whole linear mapping if crsahkernel=
>>>>>> is set in kernel parameter shown in [1] at bottom. 
>>>>>
>>>>> That's a different problem ;). I should re-read that thread, forgot most
>>>>> of the details but I recall one of the counter arguments was that there
>>>>> isn't a strong case to unmap the crashkernel reservation. Now, if we
>>>>> place crashdump kernel image goes in the 'high' reservation, can we not
>>>>> leave the 'low' reservation mapped? We don't really care about it as it
>>>>> wouldn't have any meaningful code/data to be preserved. If the 'high'
>>>>> one goes above 4G always, we don't depend on the arm64_dma_phys_limit.
>>>>
>>>> Yes, this looks ideal. While it only works when crashkernel=,high case and
>>>> it succeeds to reserve a memory region for the specified size of crashkernel
>>>> high memory. At below, we have 4 cases of crashkernel= syntax:
>>>>
>>>> crashkernel=size
>>>> 1)first attempt:  low memory under arm64_dma_phys_limit
>>>> 2)fallback:       finding memory above 4G
>>>
>>> (2) should be 'finding memory above arm64_dma_phys_limit' to keep the
>>> current behaviour for RPi4.
>>>
>>>> crashkernel=size,high
>>>> 3)first attempt:  finding memory above 4G
>>>> 4)fallback:       low memory under arm64_dma_phys_limit
>>>
>>> Yes.
>>>
>>>> case 3) works with your suggestion. However, 1), 2), 4) all need to
>>>> defer to bootmem_init(). With these cases and different handling,
>>>> reserve_crashkernel() could be too complicated.
>>>
>>> Ah, because of the fallback below arm64_dma_phys_limit as in (4), we
>>> still can't move the full crashkernel reservation early. Well, we could
>>> do it in two steps: (a) early attempt at crashkernel reservation above
>>> 4G if 'high' was specified and we avoid mapping it if successful and (b)
>>> do the late crashkernel reservation below arm64_dma_phys_limit and skip
>>> unmapping as being too late. This way most server-like platforms would
>>> get a reservation above 4G, unmapped.
>>>
>>>> I am wondering if we can cancel the protection of crashkernel memory
>>>> region on arm64 for now. In earlier discussion, people questioned if the
>>>> protection is necessary on arm64. After comparison, I would rather take
>>>> away the protection method of crashkernel region since they try to
>>>> protect in a chance in one million , while the base page mapping for the
>>>> whole linear mapping is mitigating arm64 high end server always.
>>>
>>> This works for me. We can add the protection later for addresses above
>>> 4GB only as mentioned above.
>>
>> Recently, I've also been rethinking the performance issues when kdump is
>> enabled. I have a new idea. For crashkernel=X, we can temporarily search
>> for free memory from the low address to the high address. As below:
>>
>> save_bottom_up = memblock_bottom_up();
>> if (!high)
>> 	memblock_set_bottom_up(true);
>> crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN, crash_base, crash_max);
>> memblock_set_bottom_up(save_bottom_up);
>>
>> The final code change should be small, and I'll try it today.
> 
> I have sent a patchset to remove the crashkernel region protection code
> as per Catalin's confirmation. I personally like the code conciseness w/o
> protection because kinds of crahskernel reservation has been complex,
> the situation on arm64 will makes it worse if we try to keep the
> protection and fix the performance issue. While I am glad to see any
> attempt to achieve the two goals if it's satisfactory.

I saw the patchset. No protection is also a good idea, the code is
simplified a lot.

> 
> .
> 

-- 
Regards,
  Zhen Lei
