Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7D26E5F39
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 12:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjDRK5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 06:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjDRK5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 06:57:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EFFAA40EF
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 03:57:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72EF4168F;
        Tue, 18 Apr 2023 03:58:14 -0700 (PDT)
Received: from [10.57.82.12] (unknown [10.57.82.12])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 712563F5A1;
        Tue, 18 Apr 2023 03:57:29 -0700 (PDT)
Message-ID: <54083e3b-cba3-c719-651d-bf99d6eca16d@arm.com>
Date:   Tue, 18 Apr 2023 11:57:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4] iommu: Optimise PCI SAC address trick
Content-Language: en-GB
To:     Vasant Hegde <vasant.hegde@amd.com>, joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        John Garry <john.g.garry@oracle.com>
References: <b8502b115b915d2a3fabde367e099e39106686c8.1681392791.git.robin.murphy@arm.com>
 <21e49cd7-ee15-5ebd-7805-37d5f347635f@amd.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <21e49cd7-ee15-5ebd-7805-37d5f347635f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-18 10:23, Vasant Hegde wrote:
> Robin,
> 
> 
> On 4/13/2023 7:10 PM, Robin Murphy wrote:
>> Per the reasoning in commit 4bf7fda4dce2 ("iommu/dma: Add config for
>> PCI SAC address trick") and its subsequent revert, this mechanism no
>> longer serves its original purpose, but now only works around broken
>> hardware/drivers in a way that is unfortunately too impactful to remove.
>>
>> This does not, however, prevent us from solving the performance impact
>> which that workaround has on large-scale systems that don't need it.
>> Once the 32-bit IOVA space fills up and a workload starts allocating and
>> freeing on both sides of the boundary, the opportunistic SAC allocation
>> can then end up spending significant time hunting down scattered
>> fragments of free 32-bit space, or just reestablishing max32_alloc_size.
>> This can easily be exacerbated by a change in allocation pattern, such
>> as by changing the network MTU, which can increase pressure on the
>> 32-bit space by leaving a large quantity of cached IOVAs which are now
>> the wrong size to be recycled, but also won't be freed since the
>> non-opportunistic allocations can still be satisfied from the whole
>> 64-bit space without triggering the reclaim path.
>>
>> However, in the context of a workaround where smaller DMA addresses
>> aren't simply a preference but a necessity, if we get to that point at
>> all then in fact it's already the endgame. The nature of the allocator
>> is currently such that the first IOVA we give to a device after the
>> 32-bit space runs out will be the highest possible address for that
>> device, ever. If that works, then great, we know we can optimise for
>> speed by always allocating from the full range. And if it doesn't, then
>> the worst has already happened and any brokenness is now showing, so
>> there's little point in continuing to try to hide it.
>>
>> To that end, implement a flag to refine the SAC business into a
>> per-device policy that can automatically get itself out of the way if
>> and when it stops being useful.
>>
>> CC: Linus Torvalds <torvalds@linux-foundation.org>
>> CC: Jakub Kicinski <kuba@kernel.org>
>> Reviewed-by: John Garry <john.g.garry@oracle.com>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> We hit kernel softlockup while running stress-ng test system having 384 CPU and
> NVMe disk. This patch helped to solve one soft lockup in allocation path.
> 
>> ---
>>
>> v4: Rebase to use the new bitfield in dev_iommu, expand commit message.
>>
>>   drivers/iommu/dma-iommu.c | 26 ++++++++++++++++++++------
>>   drivers/iommu/dma-iommu.h |  8 ++++++++
>>   drivers/iommu/iommu.c     |  3 +++
>>   include/linux/iommu.h     |  2 ++
>>   4 files changed, 33 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 99b2646cb5c7..9193ad5bc72f 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -630,7 +630,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
>>   {
>>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>>   	struct iova_domain *iovad = &cookie->iovad;
>> -	unsigned long shift, iova_len, iova = 0;
>> +	unsigned long shift, iova_len, iova;
>>   
>>   	if (cookie->type == IOMMU_DMA_MSI_COOKIE) {
>>   		cookie->msi_iova += size;
>> @@ -645,15 +645,29 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
>>   	if (domain->geometry.force_aperture)
>>   		dma_limit = min(dma_limit, (u64)domain->geometry.aperture_end);
>>   
>> -	/* Try to get PCI devices a SAC address */
>> -	if (dma_limit > DMA_BIT_MASK(32) && !iommu_dma_forcedac && dev_is_pci(dev))
>> +	/*
>> +	 * Try to use all the 32-bit PCI addresses first. The original SAC vs.
>> +	 * DAC reasoning loses relevance with PCIe, but enough hardware and
>> +	 * firmware bugs are still lurking out there that it's safest not to
>> +	 * venture into the 64-bit space until necessary.
>> +	 *
>> +	 * If your device goes wrong after seeing the notice then likely either
>> +	 * its driver is not setting DMA masks accurately, the hardware has
>> +	 * some inherent bug in handling >32-bit addresses, or not all the
>> +	 * expected address bits are wired up between the device and the IOMMU.
>> +	 */
>> +	if (dma_limit > DMA_BIT_MASK(32) && dev->iommu->pci_32bit_workaround) {
>>   		iova = alloc_iova_fast(iovad, iova_len,
>>   				       DMA_BIT_MASK(32) >> shift, false);
>> +		if (iova)
>> +			goto done;
>>   
>> -	if (!iova)
>> -		iova = alloc_iova_fast(iovad, iova_len, dma_limit >> shift,
>> -				       true);
>> +		dev->iommu->pci_32bit_workaround = false;
>> +		dev_notice(dev, "Using %d-bit DMA addresses\n", bits_per(dma_limit));
> 
> May be dev_notice_once? Otherwise we may see this message multiple time for same
> device like below:

Oh, that's a bit irritating. Of course multiple threads can reach this
in parallel, silly me :(

I would really prefer the notice to be once per device rather than once
globally, since there's clearly no guarantee that the first device to
hit this case is going to be the one which is liable to go wrong. Does
the (untested) diff below do any better?

> [  172.017120] nvme 0000:41:00.0: Using 64-bit DMA addresses
> [  172.022955] nvme 0000:41:00.0: Using 64-bit DMA addresses
> [  172.028720] nvme 0000:41:00.0: Using 64-bit DMA addresses
> [  172.031815] nvme 0000:41:00.0: Using 64-bit DMA addresses
> [  172.031816] nvme 0000:41:00.0: Using 64-bit DMA addresses
> [  172.038727] nvme 0000:41:00.0: Using 64-bit DMA addresses
> [  172.038726] nvme 0000:41:00.0: Using 64-bit DMA addresses
> [  172.038917] nvme 0000:41:00.0: Using 64-bit DMA addresses
> [  172.038968] nvme 0000:41:00.0: Using 64-bit DMA addresses
> [  172.038970] nvme 0000:41:00.0: Using 64-bit DMA addresses
> [  172.039007] nvme 0000:41:00.0: Using 64-bit DMA addresses
> [  172.039091] nvme 0000:41:00.0: Using 64-bit DMA addresses
> [  172.039102] nvme 0000:41:00.0: Using 64-bit DMA addresses
> 
> Otherwise patch worked fine for us.
> 
> Tested-by: Vasant Hegde <vasant.hegde@amd.com>

Thanks!

Robin.

----->8-----
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 9193ad5bc72f..db246fd3037f 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -662,8 +662,8 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
  		if (iova)
  			goto done;
  
-		dev->iommu->pci_32bit_workaround = false;
-		dev_notice(dev, "Using %d-bit DMA addresses\n", bits_per(dma_limit));
+		if (xchg(&dev->iommu->pci_32bit_workaround, false))
+			dev_notice(dev, "Using %d-bit DMA addresses\n", bits_per(dma_limit));
  	}
  
  	iova = alloc_iova_fast(iovad, iova_len, dma_limit >> shift, true);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 2575630d402d..8a12e923718f 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -419,7 +419,7 @@ struct dev_iommu {
  	void				*priv;
  	u32				max_pasids;
  	u32				attach_deferred:1;
-	u32				pci_32bit_workaround:1;
+	bool				pci_32bit_workaround;
  };
  
  int iommu_device_register(struct iommu_device *iommu,
