Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C9F638008
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 21:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiKXUFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 15:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKXUFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 15:05:09 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 990466CE4F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 12:05:07 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACF3723A;
        Thu, 24 Nov 2022 12:05:13 -0800 (PST)
Received: from [10.57.71.118] (unknown [10.57.71.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D76A53F73B;
        Thu, 24 Nov 2022 12:05:04 -0800 (PST)
Message-ID: <93ad9b12-b5e7-de6c-af99-0f4c532dbb60@arm.com>
Date:   Thu, 24 Nov 2022 20:04:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFC PATCH] arm64: mm: Add invalidate back in
 arch_sync_dma_for_device when FROM_DEVICE
Content-Language: en-GB
To:     Nanyong Sun <sunnanyong@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     will@kernel.org, catalin.marinas@arm.com, sstabellini@kernel.org,
        jgross@suse.com, oleksandr_tyshchenko@epam.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        wangkefeng.wang@huawei.com, linux@armlinux.org.uk
References: <20221117072100.2720512-1-sunnanyong@huawei.com>
 <CAMj1kXENCa5TK9EnRa9Mtn+xGLrnV_X0sAkTC64GVOShDsTK1Q@mail.gmail.com>
 <2787aa42-5ba5-be84-3adc-3b24e6477439@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <2787aa42-5ba5-be84-3adc-3b24e6477439@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-20 02:59, Nanyong Sun wrote:
> On 2022/11/17 16:24, Ard Biesheuvel wrote:
> 
>> On Thu, 17 Nov 2022 at 07:33, Nanyong Sun <sunnanyong@huawei.com> wrote:
>>> The commit c50f11c6196f ("arm64: mm: Don't invalidate FROM_DEVICE
>>> buffers at start of DMA transfer") replaces invalidate with clean
>>> when DMA_FROM_DEVICE, this changes the behavior of functions like
>>> dma_map_single() and dma_sync_single_for_device(*, *, *, 
>>> DMA_FROM_DEVICE),
>>> then it may make some drivers works unwell because the implementation
>>> of these DMA APIs lose the original cache invalidation.
>>>
>>> Situation 1:
>> ...
>>> Situation 2:
>>> After backporting the above commit, we find a network card driver go
>>> wrong with cache inconsistency when doing DMA transfer: CPU got the
>>> stale data in cache when reading DMA data received from device.
>> I suppose this means those drivers may lack dma_sync_single_for_cpu()
>> calls after the inbound transfers complete, and are instead relying on
>> the cache invalidation performed before the transfer to make the DMA'd
>> data visible to the CPU.
>>
>> This is buggy and fragile, and should be fixed in any case. There is
>> no guarantee that the CPU will not preload parts of the buffer into
>> the cache while DMA is in progress, so the invalidation must occur
>> strictly after the device has finished transferring the data.
>>
>>> A similar phenomenon happens on sata disk drivers, it involves
>>> mainline modules like libata, scsi, ahci etc, and is hard to find
>>> out which line of code results in the error.
>>>
>> Could you identify the actual hardware and drivers that you are
>> observing the issue on? Claiming that everything is broken is not very
>> helpful in narrowing it down (although I am not saying you are wrong
>> :-))
> The hardware combination is ARM64 with SATA disk，but not every product of
> this combination has the DMA problem, and the related drivers seems right,
> so I am currently checking whether the DT or ACPI indicate device's 
> coherent attribute uncorrectly.
> (The scenario that Robin proposed in another email:
> ===============================================================
> It also commonly goes wrong the other way round when the drivers are 
> correct but DT/ACPI failed to indicate a coherent device as such.
> If writes from the device actually snoop, they hit the still-present 
> cache line, which then gets invalidated by unmap/sync_for_cpu and the 
> new data is lost.
> Robin.
> ===============================================================
> )
>>> It seems that some dirvers may go wrong and have to match the
>>> implementation changes of the DMA APIs, and it would be confused
>>> because the behavior of these DMA APIs on arm64 are different
>>> from other archs.
>>>
>>> Add invalidate back in arch_sync_dma_for_device() to keep drivers
>>> compatible by replace dcache_clean_poc with dcache_clean_inval_poc
>>> when DMA_FROM_DEVICE.
>>>
>> So notably, the patch in question removes cache invalidation *without*
>> clean, and what you are adding here is clean+invalidate. (Invalidation
>> without clean may undo the effect of, e.g., the memzero() of a secret
>> in memory, and so it is important that we don't add that back if we
>> can avoid it)
>>
>> Since we won't lose the benefits of that change, incorporating
>> invalidation at this point should be fine: clean+invalidate shouldn't
>> be more expensive than clean, and [correctly written] drivers will
>> invalidate those lines anyway, as the data has to come from DRAM in
>> any case.
>>
>> So unless fixing the drivers in question is feasible, this change
>> seems reasonable to me.
> Agree with you and I have some questions:
> 1. I am not very clear that how to fix the drivers? Before the patch in 
> question, the behaviors of DMA APIs are like this:
> 
>                       map        for_cpu         for_device unmap
> TO_DEV    writeback    none             writeback       none
> TO_CPU    invalidate    invalidate*    invalidate       invalidate*
> BIDIR        writeback    invalidate      writeback      invalidate
> 
> (Reference from: 
> https://lore.kernel.org/lkml/20180518175004.GF17671@n2100.armlinux.org.uk/)
> 
> and now the behaviors on arm64 become this:
> 
>                       map              for_cpu for_device            unmap
> TO_DEV    writeback          none writeback             none
> TO_CPU   -> [writeback]    invalidate* ->[writeback]       invalidate*
> BIDIR        writeback          invalidate writeback             invalidate
> 
> Can we confirm that these changes are acceptable on the ARM64?
> 
> I counted the drivers on the Linux mainline and there are at least 123 
> places of code have called
> dma_sync_single_for_device(*, *, *, DMA_FROM_DEVICE), one of them like 
> this:
> drivers/net/ethernet/sun/cassini.c:
>      cas_rx_process_pkt():
>                  dma_sync_single_for_cpu(&cp->pdev->dev, page->dma_addr 
> + off,
>                                          i, DMA_FROM_DEVICE);
>                  addr = cas_page_map(page->buffer);
>                  memcpy(p, addr + off, i);
>                  dma_sync_single_for_device(&cp->pdev->dev,
>                                             page->dma_addr + off, i,
>                                             DMA_FROM_DEVICE);
> 
> Are they correct?

Yes.

In the non-coherent scenario here, dma_sync_single_for_cpu() invalidates 
any previously-fetched cachelines to ensure that the latest data written 
to DRAM by the device is visible to the CPU. There is no writeback 
because those cachelines can only be clean, not dirty - the device is 
non-coherent, so is not updating the cache, and the contract of the DMA 
API says that nothing else may write to the same address at the same 
time. The subsequent dma_sync_single_for_device() doesn't actually need 
to do anything, because the whole transfer is DMA_FROM_DEVICE - even 
though the buffer was almost certainly fetched into some level of cache 
by the memcpy() reading from it, that's fine. The device will write the 
next packet to DRAM, and those (clean) cachelines will be invalidated by 
dma_sync_single_for_cpu() when we start the whole cycle again.

> - If they are, they may be affected by the implementation change, then 
> how to fix them?
> - Or these codes are needless on arm64 so they won't be affected?
> 
> 2. Finding the drivers which do not strictly follow the DMA API rule is 
> expensive, they used to run with no problem
> because they called the DMA APIs that will do the same invalidate thing 
> like dma_sync_single_for_cpu(), but now they have risks,
> so every DMA users should check the drivers, including in tree, 
> out-of-tree and binary-only drivers.
> We also need to check the DTS and ACPI to prevent the case that Robin 
> mentioned.
> And are there any other scenarios we haven't thought of that need to be 
> checked?
> 
> That will be a huge and difficult workload for DMA users, and based on 
> they know the influence of that patch.
> 
> So, adding invalidate back in arch_sync_dma_for_device() seems more 
> friendly, cheap and harmless,  the behaviors on arm64 will be this:
> 
>                       map              for_cpu for_device            unmap
> TO_DEV    writeback          none writeback             none
> TO_CPU    wback+inv        invalidate*        wback+inv invalidate*
> BIDIR        writeback          invalidate writeback             invalidate

But then DMA_BIDIRECTIONAL is still wrong, and even if you bodge the 
syncs even further to make that appear to work on an 
incorrectly-configured system, dma_alloc_coherent() will still be at 
risk of losing coherency in ways that cannot be fixed at all, except by 
fixing the firmware to remove the source of the problem.

In practice, driver bugs tend to be fairly easy to weed out with options 
like CONFIG_DMA_API_DEBUG and "swiotlb=force", and given that we can't 
reliably or completely work around broken firmware, I'd argue that it's 
better *not* to try to hide these issues, to increase the likelihood 
that they'll be noticed by developers earlier. As happened again today, 
in fact:

https://lore.kernel.org/linux-arm-kernel/20221124142501.29314-1-johan+linaro@kernel.org/

Thanks,
Robin.

>>> Fixes: c50f11c6196f ("arm64: mm: Don't invalidate FROM_DEVICE buffers 
>>> at start of DMA transfer")
>>> Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
>>> ---
>>>   arch/arm64/mm/dma-mapping.c | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
>>> index 3cb101e8cb29..07f6a3089c64 100644
>>> --- a/arch/arm64/mm/dma-mapping.c
>>> +++ b/arch/arm64/mm/dma-mapping.c
>>> @@ -18,7 +18,10 @@ void arch_sync_dma_for_device(phys_addr_t paddr, 
>>> size_t size,
>>>   {
>>>          unsigned long start = (unsigned long)phys_to_virt(paddr);
>>>
>>> -       dcache_clean_poc(start, start + size);
>>> +       if (dir == DMA_FROM_DEVICE)
>>> +               dcache_clean_inval_poc(start, start + size);
>>> +       else
>>> +               dcache_clean_poc(start, start + size);
>>>   }
>>>
>>>   void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
>>> -- 
>>> 2.25.1
>>>
>> .
