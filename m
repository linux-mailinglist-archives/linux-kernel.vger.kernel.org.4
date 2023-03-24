Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE106C7604
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 03:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjCXCrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 22:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCXCrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 22:47:08 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06384166D5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 19:47:06 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PjRPp3tqPzKsGJ;
        Fri, 24 Mar 2023 10:44:46 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 24 Mar 2023 10:47:04 +0800
Subject: Re: [PATCH v4] arm64: kdump: simplify the reservation behaviour of
 crashkernel=,high
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Baoquan He <bhe@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <horms@kernel.org>,
        <John.p.donnelly@oracle.com>, <will@kernel.org>,
        <kexec@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>
References: <20230306084124.300584-1-bhe@redhat.com>
 <ZBHbw3Vp4dxukGOD@arm.com> <ZBLlyGxGk33yrA+2@MiWiFi-R3L-srv>
 <ZBNTRBqqb74T3RMx@arm.com> <ZBSCeWtHvqc/iJZg@MiWiFi-R3L-srv>
 <ZBSr/kIIuxmC/INY@arm.com> <ZBhbqAOsHFj5cheI@MiWiFi-R3L-srv>
 <ZByLga6FS5o8Syug@arm.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <4d4ecdd6-9716-570d-5595-e47bfbb58cdf@huawei.com>
Date:   Fri, 24 Mar 2023 10:47:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ZByLga6FS5o8Syug@arm.com>
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



On 2023/3/24 1:25, Catalin Marinas wrote:
> On Mon, Mar 20, 2023 at 09:12:08PM +0800, Baoquan He wrote:
>> On 03/17/23 at 06:05pm, Catalin Marinas wrote:
>>> On Fri, Mar 17, 2023 at 11:09:13PM +0800, Baoquan He wrote:
>>>> In fact, what I want to achieve is we set CRASH_ADDR_LOW_MAX to 4G
>>>> fixedly on arm64, just like what we do on x86_64. As for RPi4 platform,
>>>> we leave it to crashkernel=size@offset syntax. Two reasons for this:
>>>> 1) crashkernel is needed on enterprise platform, such as workstation or
>>>> server. While RPi4 is obviously not the target. I contacted several RPi4
>>>> players in Redhat and my friends, none of them ever played kdump
>>>> testing. If they really have to, crashkernel=size@offset is enough for
>>>> them to set.
>>>
>>> I'd like crashkernel=size (without @offset) on RPi4 to still do the
>>> right thing: a low allocation at least as we had until recently (or
>>> high+low where high here is maybe above 1GB). IOW, no regression for
>>> this crashkernel=size case. We can then change the explicit
>>> crashkernel=x,high to mean only above 4GB irrespective of the platform
>>> and crashkernel=x,low to be below arm64_dma_phys_limit.
>>
>> Since crashkernel=,high and crashkernel=size fallback was added in arm64
>> recently, with my understanding, you are suggesting:
>>
>> on arm64:
>> RPi4:
>> crashkernel=size
>> 0~1G: low memory (no regression introduced)
> 
> And, if not enough low memory, fall back to memory above 1GB (for RPi4;
> it would be above 4GB for any other system).
> 
>> crashkernel=size,high
>> 0~1G: low memory | 4G~top: high memory
> 
> Yes.
> 
>> Other normal system:
>> crashkernel=size|crashkernel=size,high
>> 0~4G: low memory | 4G~top: high memory
> 
> Yes.
> 
> IOW, specifying 'high' only forces the high allocation above 4GB instead
> of arm64_dma_phys_limit, irrespective of the platform. If no 'high'
> specified search_base remains CRASH_ADDR_LOW_MAX (1GB on RPi4, 4GB for
> the rest).
> 
>>>> 2) with the fixed CRASH_ADDR_LOW_MAX as 4G, we can easily fix the
>>>> problem of base page mapping for the whole linear mapping if crsahkernel=
>>>> is set in kernel parameter shown in [1] at bottom. 
>>>
>>> That's a different problem ;). I should re-read that thread, forgot most
>>> of the details but I recall one of the counter arguments was that there
>>> isn't a strong case to unmap the crashkernel reservation. Now, if we
>>> place crashdump kernel image goes in the 'high' reservation, can we not
>>> leave the 'low' reservation mapped? We don't really care about it as it
>>> wouldn't have any meaningful code/data to be preserved. If the 'high'
>>> one goes above 4G always, we don't depend on the arm64_dma_phys_limit.
>>
>> Yes, this looks ideal. While it only works when crashkernel=,high case and
>> it succeeds to reserve a memory region for the specified size of crashkernel
>> high memory. At below, we have 4 cases of crashkernel= syntax:
>>
>> crashkernel=size
>> 1)first attempt:  low memory under arm64_dma_phys_limit
>> 2)fallback:       finding memory above 4G
> 
> (2) should be 'finding memory above arm64_dma_phys_limit' to keep the
> current behaviour for RPi4.
> 
>> crashkernel=size,high
>> 3)first attempt:  finding memory above 4G
>> 4)fallback:       low memory under arm64_dma_phys_limit
> 
> Yes.
> 
>> case 3) works with your suggestion. However, 1), 2), 4) all need to
>> defer to bootmem_init(). With these cases and different handling,
>> reserve_crashkernel() could be too complicated.
> 
> Ah, because of the fallback below arm64_dma_phys_limit as in (4), we
> still can't move the full crashkernel reservation early. Well, we could
> do it in two steps: (a) early attempt at crashkernel reservation above
> 4G if 'high' was specified and we avoid mapping it if successful and (b)
> do the late crashkernel reservation below arm64_dma_phys_limit and skip
> unmapping as being too late. This way most server-like platforms would
> get a reservation above 4G, unmapped.
> 
>> I am wondering if we can cancel the protection of crashkernel memory
>> region on arm64 for now. In earlier discussion, people questioned if the
>> protection is necessary on arm64. After comparison, I would rather take
>> away the protection method of crashkernel region since they try to
>> protect in a chance in one million , while the base page mapping for the
>> whole linear mapping is mitigating arm64 high end server always.
> 
> This works for me. We can add the protection later for addresses above
> 4GB only as mentioned above.

Recently, I've also been rethinking the performance issues when kdump is
enabled. I have a new idea. For crashkernel=X, we can temporarily search
for free memory from the low address to the high address. As below:

save_bottom_up = memblock_bottom_up();
if (!high)
	memblock_set_bottom_up(true);
crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN, crash_base, crash_max);
memblock_set_bottom_up(save_bottom_up);

The final code change should be small, and I'll try it today.

> 

-- 
Regards,
  Zhen Lei
