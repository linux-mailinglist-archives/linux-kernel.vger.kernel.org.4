Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E028773203F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 21:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjFOTEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 15:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjFOTEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 15:04:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A706D2137;
        Thu, 15 Jun 2023 12:04:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49E191FB;
        Thu, 15 Jun 2023 12:05:03 -0700 (PDT)
Received: from [10.57.85.251] (unknown [10.57.85.251])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1DFC3F663;
        Thu, 15 Jun 2023 12:04:16 -0700 (PDT)
Message-ID: <34c7c65f-e09f-fa55-c1b9-de08d71a1ac7@arm.com>
Date:   Thu, 15 Jun 2023 20:04:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] Revert "Revert "Revert "arm64: dma: Drop cache
 invalidation from arch_dma_prep_coherent()"""
Content-Language: en-GB
To:     Doug Anderson <dianders@chromium.org>
Cc:     Will Deacon <will@kernel.org>, andersson@kernel.org,
        amit.pundir@linaro.org, linux-arm-msm@vger.kernel.org,
        konrad.dybcio@somainline.org, Sibi Sankar <quic_sibis@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        sumit.semwal@linaro.org, Stephen Boyd <swboyd@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230614165904.1.I279773c37e2c1ed8fbb622ca6d1397aea0023526@changeid>
 <36565295-ebaa-2a66-3389-ba5eb714ab34@arm.com>
 <CAD=FV=W7HXYRJ7RUeVH0hQ7KjYtEvNABCi-F4iN_wRO6uuC34w@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAD=FV=W7HXYRJ7RUeVH0hQ7KjYtEvNABCi-F4iN_wRO6uuC34w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-15 18:42, Doug Anderson wrote:
> Hi,
> 
> On Thu, Jun 15, 2023 at 3:13 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2023-06-15 00:59, Douglas Anderson wrote:
>>> This reverts commit 7bd6680b47fa4cd53ee1047693c09825e212a6f5.
>>>
>>> When booting a sc7180-trogdor based device on mainline, I see errors
>>> that look like this:
>>>
>>>    qcom_scm firmware:scm: Assign memory protection call failed -22
>>>    qcom_rmtfs_mem 94600000.memory: assign memory failed
>>>    qcom_rmtfs_mem: probe of 94600000.memory failed with error -22
>>>
>>> The device still boots OK, but WiFi doesn't work.
>>>
>>> The failure only seems to happen when
>>> CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y. When I don't have that set then
>>> everything is peachy. Presumably something about the extra
>>> initialization disagrees with the change to drop cache invalidation.
>>
>> AFAICS init_on_alloc essentially just adds __GFP_ZERO to the page
>> allocation.
> 
> Right, but it does so without `__GFP_ZERO` getting into the page
> flags. That means that this removal of "__GFP_ZERO" in
> dma_direct_alloc() doesn't actually remove the zeroing when
> CONFIG_INIT_ON_ALLOC_DEFAULT_ON IS USED:
> 
>    /* we always manually zero the memory once we are done */
>    page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true);
> 
> 
>> This should make no difference to a DMA allocation given
>> that dma_alloc_attrs explicitly zeros its allocation anyway. However...
>> for the non-coherent case, the DMA API's memset will be done through the
>> non-cacheable remap, while __GFP_ZERO can leave behind cached zeros for
>> the linear map alias. Thus what I assume must be happening here is that
>> "DMA" from the firmware is still making cacheable accesses to the buffer
>> and getting those zeros instead of whatever actual data which was
>> subsequently written non-cacheably direct to RAM. So either the firmware
>> still needs fixing to make non-cacheable accesses, or the SCM driver
>> needs to correctly describe it as coherent.
> 
> I'm a little confused, but that's pretty normal for me. :-P Looking at
> the SCM driver, I see it doing the allocation in qcom_scm_assign_mem()
> as:
> 
>    dma_alloc_coherent(__scm->dev, ptr_sz, &ptr_phys, GFP_KERNEL);
> 
> Isn't that the SCM driver describing it as coherent?

The name of the API means that the *buffer* is coherent, i.e. both the 
device and CPU can access it at any time without needing any special 
synchronisation. How that is achieved depends on the device - if it is 
capable of snooping caches (i.e. marked as "dma-coherent" in DT) then 
that coherency is provided by hardware and the allocator doesn't need to 
do anything special; otherwise, it achieves coherency by making the CPU 
accesses non-cacheable.

> I guess the reason that the SCM driver is doing this is that it's
> passing a chunk of memory to the firmware but it passes it to firmware
> via a _physical_ address, not a virtual one. I guess this makes sense
> to do when passing a chunk of memory to firmware since you wouldn't
> want to pass the kernel's virtual address there...

Correct.

> Presumably the fact that the firmware gets a physical address means
> that the firmware needs to map this address somehow itself. I can try
> to dig up what the firmware is doing if needed (what attributes it
> uses to map), but I guess the hope is that it shouldn't matter.

It absolutely matters. Linux has been told (by DT) that this device does 
not snoop caches, and therefore is acting on that information by using 
the non-cacheable remap. There is nothing inherently wrong with that, 
even when the "device" is actually firmware running on the same CPU - 
EL3 could well run with the MMU off, or just make a point of not 
accessing Non-Secure memory with cacheable attributes to avoid 
side-channels. However if in this case the SCM firmware *is* using 
cacheable attributes, as the symptoms would suggest, then either the 
firmware or the DT is wrong, and there is nothing Linux can do to 
completely fix that.

> As
> long as the kernel can guarantee that the contents that it needs have
> been flushed out to memory then I think we're supposed to be good,
> right?

Right, and that's what the cache clean does. What Linux *cannot* 
guarantee is that said contents don't subsequently get pulled back into 
a cache in a manner which would break coherency if anyone was actually 
looking at the cache rather than RAM.

> In any case, I dumped a stack crawl to try to show the path where the
> init happens, since there are lots of conditionals. I see this:
> 
>   kernel_init_pages+0x68/0x6c
>   post_alloc_hook+0x40/0x90
>   prep_new_page+0x34/0x68
>   get_page_from_freelist+0x894/0xe64
>   __alloc_pages+0x12c/0xd24
>   __dma_direct_alloc_pages+0x9c/0x170
>   dma_direct_alloc+0x254/0x4bc
>   dma_alloc_attrs+0xe4/0x1e4
>   qcom_scm_assign_mem+0xb0/0x258
> 
> 
> So looking at dma_direct_alloc(), I guess:
> 
> 1. We call __dma_direct_alloc_pages() to allocate the page. We try to
> turn off __GFP_ZERO but CONFIG_INIT_ON_ALLOC_DEFAULT_ON overrides us.
> 
> 2. As part of __dma_direct_alloc_pages(), we use the existing
> (cachable) mapping of the page and write zeros.
> 
> 3. The "remap" variable is set for arm64 so we call
> arch_dma_prep_coherent(). That used to do a "clean and invalidate" but
> now does just a "clean" and that's what broke me.
> 
> 
> Talking out of my rear end, I guess the issue here might be that it
> _does_ matter how the firmware maps this memory because it has to
> match how the kernel has it mapped because if you map the same
> physical memory twice then the attributes need to match. Maybe the old
> "invalidate" just worked around this issue?

See the comment that the revert brings back - indeed it makes it less 
likely, but it's still possible that, say, the qcom_scm_assign_mem() 
thread gets preempted by an interrupt after dma_alloc_coherent() 
invalidates but before the buffer is completely written, and some access 
to an adjacent page during that period causes incomplete data to be 
prefetched back into the cache, and you're back to square one.

If Linux were actually expecting to get data back from the firmware, 
that would likely be even more broken (presuming it would use cacheable 
writes without a subsequent cache clean, given the implication that it's 
already doing cacheable reads without any maintenance of its own).

> If this wild guessing is
> correct, maybe a more correct solution would be to simply unmap the
> memory from the kernel before passing the physical address to the
> firmware, if that's possible...

Having now looked at the SCM driver, TBH it doesn't make an awful lot of 
sense for it to be using dma_alloc_coherent() there anyway - it's not 
using it as a coherent buffer, it's doing a one-off unidirectional 
transfer of a relatively small amount of data in a manner which seems to 
be exactly the usage model for the streaming DMA API. And I think using 
the latter would happen to mitigate this problem too - with streaming 
DMA you'd put the dma_map_page() call *after* all the buffer data has 
been written, right before the SMC call, so even with a coherency 
mismatch there would essentially be no opportunity for the caches to get 
out of sync.

Thanks,
Robin.
