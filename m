Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E7F613B05
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 17:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbiJaQLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 12:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiJaQLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 12:11:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F750DF61;
        Mon, 31 Oct 2022 09:11:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D2CF1FB;
        Mon, 31 Oct 2022 09:11:57 -0700 (PDT)
Received: from [10.57.38.12] (unknown [10.57.38.12])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6E153F5A1;
        Mon, 31 Oct 2022 09:11:48 -0700 (PDT)
Message-ID: <e789fcbe-fa3a-0286-c0f7-361762764a3e@arm.com>
Date:   Mon, 31 Oct 2022 16:11:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 2/5] iommu/s390: Add I/O TLB ops
To:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc:     Gerd Bayer <gbayer@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org
References: <20221018145132.998866-1-schnelle@linux.ibm.com>
 <20221018145132.998866-3-schnelle@linux.ibm.com>
 <7da1ab0b-e78a-2ed1-0263-e9174c3af256@linux.ibm.com>
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <7da1ab0b-e78a-2ed1-0263-e9174c3af256@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-28 17:03, Matthew Rosato wrote:
> On 10/18/22 10:51 AM, Niklas Schnelle wrote:
>> Currently s390-iommu does an I/O TLB flush (RPCIT) for every update of
>> the I/O translation table explicitly. For one this is wasteful since
>> RPCIT can be skipped after a mapping operation if zdev->tlb_refresh is
>> unset. Moreover we can do a single RPCIT for a range of pages including
>> whne doing lazy unmapping.
>>
>> Thankfully both of these optimizations can be achieved by implementing
>> the IOMMU operations common code provides for the different types of I/O
>> tlb flushes:
>>
>>   * flush_iotlb_all: Flushes the I/O TLB for the entire IOVA space
>>   * iotlb_sync:  Flushes the I/O TLB for a range of pages that can be
>>     gathered up, for example to implement lazy unmapping.
>>   * iotlb_sync_map: Flushes the I/O TLB after a mapping operation
>>
>> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>> ---
>>   drivers/iommu/s390-iommu.c | 76 ++++++++++++++++++++++++++++++++------
>>   1 file changed, 65 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
>> index ee88e717254b..a4c2e9bc6d83 100644
>> --- a/drivers/iommu/s390-iommu.c
>> +++ b/drivers/iommu/s390-iommu.c
>> @@ -199,14 +199,72 @@ static void s390_iommu_release_device(struct device *dev)
>>   		__s390_iommu_detach_device(zdev);
>>   }
>>   
>> +static void s390_iommu_flush_iotlb_all(struct iommu_domain *domain)
>> +{
>> +	struct s390_domain *s390_domain = to_s390_domain(domain);
>> +	struct zpci_dev *zdev;
>> +	unsigned long flags;
>> +	int rc;
>> +
>> +	spin_lock_irqsave(&s390_domain->list_lock, flags);
>> +	list_for_each_entry(zdev, &s390_domain->devices, iommu_list) {
>> +		rc = zpci_refresh_trans((u64)zdev->fh << 32, zdev->start_dma,
>> +					zdev->end_dma - zdev->start_dma + 1);
>> +		if (rc)
>> +			break;
>> +	}
>> +	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
>> +}
>> +
>> +static void s390_iommu_iotlb_sync(struct iommu_domain *domain,
>> +				  struct iommu_iotlb_gather *gather)
>> +{
>> +	struct s390_domain *s390_domain = to_s390_domain(domain);
>> +	size_t size = gather->end - gather->start + 1;
>> +	struct zpci_dev *zdev;
>> +	unsigned long flags;
>> +	int rc;
>> +
>> +	/* If gather was never added to there is nothing to flush */
>> +	if (gather->start == ULONG_MAX)
>> +		return;
> 
> Hmm, this seems a little awkward in that it depends on the init value in iommu_iotlb_gather_init never changing.  I don't see any other iommu drivers doing this -- Is there no other way to tell there's nothing to flush?
> 
> If we really need to do this, maybe some shared #define in iommu.h that is used in iommu_iotlb_gather_init and here?

If you can trust yourselves to never gather a single byte (which by 
construction should be impossible), "!gather->end" is perhaps a tiny bit 
more robust (and consistent with iommu_iotlb_gather_is_disjoint()), 
although given the way that iommu_iotlb_gather_add_*() work I don't 
think either initial value has much chance of changing in practice, 
short of some larger refactoring that would likely have to touch all the 
users anyway. If you still want to be as foolproof as possible, using 
"gather->start > gather->end" would represent the most general form of 
the initial conditions.

FWIW, SMMUv3 does also check for an empty range, but using 
gather->pgsize that is only relevant with add_page(). The other gather 
users seem happy to go ahead and just issue whatever wacky invalidation 
command those initial values end up looking like. I think an empty sync 
should really only happen in unexpected conditions like an unmap 
failing, so it shouldn't be a case that deserves a great deal of 
optimisation effort.

Thanks,
Robin.

>> +
>> +	spin_lock_irqsave(&s390_domain->list_lock, flags);
>> +	list_for_each_entry(zdev, &s390_domain->devices, iommu_list) {
>> +		rc = zpci_refresh_trans((u64)zdev->fh << 32, gather->start,
>> +					size);
>> +		if (rc)
>> +			break;
>> +	}
>> +	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
>> +}
>> +
>> +static void s390_iommu_iotlb_sync_map(struct iommu_domain *domain,
>> +				      unsigned long iova, size_t size)
>> +{
>> +	struct s390_domain *s390_domain = to_s390_domain(domain);
>> +	struct zpci_dev *zdev;
>> +	unsigned long flags;
>> +	int rc;
>> +
>> +	spin_lock_irqsave(&s390_domain->list_lock, flags);
>> +	list_for_each_entry(zdev, &s390_domain->devices, iommu_list) {
>> +		if (!zdev->tlb_refresh)
>> +			continue;
>> +		rc = zpci_refresh_trans((u64)zdev->fh << 32,
>> +					iova, size);
>> +		if (rc)
>> +			break;
>> +	}
>> +	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
>> +}
>> +
>>   static int s390_iommu_update_trans(struct s390_domain *s390_domain,
>>   				   phys_addr_t pa, dma_addr_t dma_addr,
>>   				   unsigned long nr_pages, int flags)
>>   {
>>   	phys_addr_t page_addr = pa & PAGE_MASK;
>> -	dma_addr_t start_dma_addr = dma_addr;
>>   	unsigned long irq_flags, i;
>> -	struct zpci_dev *zdev;
>>   	unsigned long *entry;
>>   	int rc = 0;
>>   
>> @@ -225,15 +283,6 @@ static int s390_iommu_update_trans(struct s390_domain *s390_domain,
>>   		dma_addr += PAGE_SIZE;
>>   	}
>>   
>> -	spin_lock(&s390_domain->list_lock);
>> -	list_for_each_entry(zdev, &s390_domain->devices, iommu_list) {
>> -		rc = zpci_refresh_trans((u64)zdev->fh << 32,
>> -					start_dma_addr, nr_pages * PAGE_SIZE);
>> -		if (rc)
>> -			break;
>> -	}
>> -	spin_unlock(&s390_domain->list_lock);
>> -
>>   undo_cpu_trans:
>>   	if (rc && ((flags & ZPCI_PTE_VALID_MASK) == ZPCI_PTE_VALID)) {
>>   		flags = ZPCI_PTE_INVALID;
>> @@ -340,6 +389,8 @@ static size_t s390_iommu_unmap_pages(struct iommu_domain *domain,
>>   	if (rc)
>>   		return 0;
>>   
>> +	iommu_iotlb_gather_add_range(gather, iova, size);
>> +
>>   	return size;
>>   }
>>   
>> @@ -384,6 +435,9 @@ static const struct iommu_ops s390_iommu_ops = {
>>   		.detach_dev	= s390_iommu_detach_device,
>>   		.map_pages	= s390_iommu_map_pages,
>>   		.unmap_pages	= s390_iommu_unmap_pages,
>> +		.flush_iotlb_all = s390_iommu_flush_iotlb_all,
>> +		.iotlb_sync      = s390_iommu_iotlb_sync,
>> +		.iotlb_sync_map  = s390_iommu_iotlb_sync_map,
>>   		.iova_to_phys	= s390_iommu_iova_to_phys,
>>   		.free		= s390_domain_free,
>>   	}
> 
