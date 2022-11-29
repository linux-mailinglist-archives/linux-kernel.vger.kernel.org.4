Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A60A63C05A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 13:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbiK2MyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 07:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbiK2MyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 07:54:03 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A30822AC7D;
        Tue, 29 Nov 2022 04:54:01 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8579BD6E;
        Tue, 29 Nov 2022 04:54:07 -0800 (PST)
Received: from [10.57.71.118] (unknown [10.57.71.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 366043F73D;
        Tue, 29 Nov 2022 04:53:58 -0800 (PST)
Message-ID: <6cd52999-7b01-a613-a9fb-f09a845a27b3@arm.com>
Date:   Tue, 29 Nov 2022 12:53:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 7/7] iommu/s390: flush queued IOVAs on RPCIT out of
 resource indication
Content-Language: en-GB
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>
Cc:     Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Julian Ruess <julianr@linux.ibm.com>
References: <20221116171656.4128212-1-schnelle@linux.ibm.com>
 <20221116171656.4128212-8-schnelle@linux.ibm.com>
 <cf0fed35-2d9d-3d19-3538-1ddcbfd563b0@arm.com>
 <8ae4c9b196aec34df4644ffecb66cfa4ce953244.camel@linux.ibm.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <8ae4c9b196aec34df4644ffecb66cfa4ce953244.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-29 12:00, Niklas Schnelle wrote:
> On Mon, 2022-11-28 at 14:52 +0000, Robin Murphy wrote:
>> On 2022-11-16 17:16, Niklas Schnelle wrote:
>>> When RPCIT indicates that the underlying hypervisor has run out of
>>> resources it often means that its IOVA space is exhausted and IOVAs need
>>> to be freed before new ones can be created. By triggering a flush of the
>>> IOVA queue we can get the queued IOVAs freed and also get the new
>>> mapping established during the global flush.
>>
>> Shouldn't iommu_dma_alloc_iova() already see that the IOVA space is
>> exhausted and fail the DMA API call before even getting as far as
>> iommu_map(), though? Or is there some less obvious limitation like a
>> maximum total number of distinct IOVA regions regardless of size?
> 
> Well, yes and no. Your thinking is of course correct if the advertised
> available IOVA space can be fully utilized without exhausting
> hypervisor resources we won't trigger this case. However sadly there
> are complications. The most obvious being that in QEMU/KVM the
> restriction of the IOVA space to what QEMU can actually have mapped at
> once was just added recently[0] prior to that we would regularly go
> through this "I'm out of resources free me some IOVAs" dance with our
> existing DMA API implementation where this just triggers an early cycle
> of freeing all unused IOVAs followed by a global flush. On z/VM I know
> of no situations where this is triggered. That said this signalling is
> architected so z/VM may have corner cases where it does this. On our
> bare metal hypervisor (no paging) this return code is unused and IOTLB
> flushes are simply hardware cache flushes as on bare metal platforms.
> 
> [0]
> https://lore.kernel.org/qemu-devel/20221028194758.204007-4-mjrosato@linux.ibm.com/

That sheds a bit more light, thanks, although I'm still not confident I 
fully understand the whole setup. AFAICS that patch looks to me like 
it's putting a fixed limit on the size of the usable address space. That 
in turn implies that "free some IOVAs and try again" might be a red 
herring and never going to work; for your current implementation, what 
that presumably means in reality is "free some IOVAs, resetting the 
allocator to start allocating lower down in the address space where it 
will happen to be below that limit, and try again", but the iommu-dma 
allocator won't do that. If it doesn't know that some arbitrary range 
below the top of the driver-advertised aperture is unusable, it will 
just keep allocating IOVAs up there and mappings will always fail.

If the driver can't accurately represent the usable IOVA space via the 
aperture and/or reserved regions, then this whole approach seems doomed. 
If on the other hand I've misunderstood and you can actually still use 
any address, just not all of them at the same time, then it might in 
fact be considerably easier to skip the flush queue mechanism entirely 
and implement this internally to the driver - basically make .iotlb_sync 
a no-op for non-strict DMA domains, put the corresponding RPCIT flush 
and retry in .sync_map, then allow that to propagate an error back to 
iommu_map() if the new mapping still hasn't taken.

Thanks,
Robin.

>> Other than the firmware reserved region helpers which are necessarily a
>> bit pick-and-mix, I've been trying to remove all the iommu-dma details
>> from drivers, so I'd really like to maintain that separation if at all
>> possible.
> 
> Hmm, tough one. Having a flush queue implies that we're holding on to
> IOVAs that we could free and this is kind of directly architected into
> our IOTLB flush with this "free some IOVAs and try again" error return.
> 
>>
>>> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>>> ---
>>>    drivers/iommu/dma-iommu.c  | 14 +++++++++-----
>>>    drivers/iommu/dma-iommu.h  |  1 +
>>>    drivers/iommu/s390-iommu.c |  7 +++++--
>>>    3 files changed, 15 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>>> index 3801cdf11aa8..54e7f63fd0d9 100644
>>> --- a/drivers/iommu/dma-iommu.c
>>> +++ b/drivers/iommu/dma-iommu.c
>>> @@ -188,19 +188,23 @@ static void fq_flush_single(struct iommu_dma_cookie *cookie)
>>>    	spin_unlock_irqrestore(&fq->lock, flags);
>>>    }
>>>    
>>> -static void fq_flush_timeout(struct timer_list *t)
>>> +void iommu_dma_flush_fq(struct iommu_dma_cookie *cookie)
>>>    {
>>> -	struct iommu_dma_cookie *cookie = from_timer(cookie, t, fq_timer);
>>> -
>>> -	atomic_set(&cookie->fq_timer_on, 0);
>>>    	fq_flush_iotlb(cookie);
>>> -
>>>    	if (cookie->fq_domain->type == IOMMU_DOMAIN_DMA_FQ)
>>>    		fq_flush_percpu(cookie);
>>>    	else
>>>    		fq_flush_single(cookie);
>>>    }
>>>    
>>> +static void fq_flush_timeout(struct timer_list *t)
>>> +{
>>> +	struct iommu_dma_cookie *cookie = from_timer(cookie, t, fq_timer);
>>> +
>>> +	atomic_set(&cookie->fq_timer_on, 0);
>>> +	iommu_dma_flush_fq(cookie);
>>> +}
>>> +
>>>    static void queue_iova(struct iommu_dma_cookie *cookie,
>>>    		unsigned long pfn, unsigned long pages,
>>>    		struct list_head *freelist)
>>> diff --git a/drivers/iommu/dma-iommu.h b/drivers/iommu/dma-iommu.h
>>> index 942790009292..cac06030aa26 100644
>>> --- a/drivers/iommu/dma-iommu.h
>>> +++ b/drivers/iommu/dma-iommu.h
>>> @@ -13,6 +13,7 @@ int iommu_get_dma_cookie(struct iommu_domain *domain);
>>>    void iommu_put_dma_cookie(struct iommu_domain *domain);
>>>    
>>>    int iommu_dma_init_fq(struct iommu_domain *domain);
>>> +void iommu_dma_flush_fq(struct iommu_dma_cookie *cookie);
>>>    
>>>    void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
>>>    
>>> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
>>> index 087bb2acff30..9c2782c4043e 100644
>>> --- a/drivers/iommu/s390-iommu.c
>>> +++ b/drivers/iommu/s390-iommu.c
>>> @@ -538,14 +538,17 @@ static void s390_iommu_iotlb_sync_map(struct iommu_domain *domain,
>>>    {
>>>    	struct s390_domain *s390_domain = to_s390_domain(domain);
>>>    	struct zpci_dev *zdev;
>>> +	int rc;
>>>    
>>>    	rcu_read_lock();
>>>    	list_for_each_entry_rcu(zdev, &s390_domain->devices, iommu_list) {
>>>    		if (!zdev->tlb_refresh)
>>>    			continue;
>>>    		atomic64_inc(&s390_domain->ctrs.sync_map_rpcits);
>>> -		zpci_refresh_trans((u64)zdev->fh << 32,
>>> -				   iova, size);
>>> +		rc = zpci_refresh_trans((u64)zdev->fh << 32,
>>> +					iova, size);
>>> +		if (rc == -ENOMEM)
>>> +			iommu_dma_flush_fq(domain->iova_cookie);
>>
>> Could -ENOMEM ever be returned for some reason on an IOMMU_DOMAIN_DMA or
>> IOMMU_DOMAIN_UNMANAGED domain?
> 
> In theory yes and then iommu_dma_flush_fq() still does the
> .flush_iotlb_all to give the hypervisor a chance to look for freed
> IOVAs but without flush queues you're really just running out of IOVA
> space and that's futile.
> 
> This does highlight an important missed issue though. As we don't
> return the resulting error from the subsequent .flush_iotlb_all we only
> find out if this didn't work once the mapping is used while in our
> current DMA API implementation we correctly return DMA_MAPPING_ERROR in
> this case. I guess this means we do need error returns from the IOTLB
> helpers since in a paged guest this is where we finally find out that
> our mapping couldn't be synced to the hypervisor's  shadow table and I
> don't really see a way around that. Also there are other error
> conditions implied in this shadowing too, for example the hypervisor
> could simply fail to pin guest memory and while we can't do anything
> about that at least we should fail the mapping operation.
> 
>>
>> However I can't figure out how this is supposed to work anyway -
>> .sync_map only gets called if .map claimed that the actual mapping(s)
>> succeeded, it can't fail itself, and even if it does free up some IOVAs
>> at this point by draining the flush queue, I don't see how the mapping
>> then gets retried, or what happens if it still fails after that :/
>>
>> Thanks,
>> Robin.
> 
> Yeah, this is a bit non obvious and you are correct in that the
> architecture requires a subseqeunt IOTLB flush i.e. retry for the range
> that returned the error. And your last point is then exactly the issue
> above that we miss if the retry still failed.
> 
> As for the good path, in the mapping operation but before the .sync_map
> we have updated the IOMMU translation table so the translation is the
> recorded but not synced to the hypervisor's shadow table. Now when the
> .sync_map is called and the IOTLB flush returns -ENOMEM then
> iommu_dma_flush_fq() will call .flush_iotlb_all which causes the
> hypervisor to look at the entire guest translation table and shadow all
> translations that were not yet shadowed. I.e. the .flush_iotlb_all
> "retries" the failed .sync_map.
> 
>>
>>>    	}
>>>    	rcu_read_unlock();
>>>    }
> 
> 
