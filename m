Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772C1642FE0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbiLESY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbiLESY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:24:27 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BAE9F1F2D0;
        Mon,  5 Dec 2022 10:24:23 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71ACED6E;
        Mon,  5 Dec 2022 10:24:23 -0800 (PST)
Received: from [10.57.71.118] (unknown [10.57.71.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B37F3F73B;
        Mon,  5 Dec 2022 10:24:10 -0800 (PST)
Message-ID: <fa9729b7-5d20-fb3d-4bf9-e073d18235b3@arm.com>
Date:   Mon, 5 Dec 2022 18:24:04 +0000
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
 <6cd52999-7b01-a613-a9fb-f09a845a27b3@arm.com>
 <c6c4458bb49d1144a304e34c65a70dc2ebbb4082.camel@linux.ibm.com>
 <c06dc451129127b660d40886afe89c92471a913a.camel@linux.ibm.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <c06dc451129127b660d40886afe89c92471a913a.camel@linux.ibm.com>
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

On 2022-12-02 14:29, Niklas Schnelle wrote:
> On Tue, 2022-11-29 at 15:40 +0100, Niklas Schnelle wrote:
>> On Tue, 2022-11-29 at 12:53 +0000, Robin Murphy wrote:
>>> On 2022-11-29 12:00, Niklas Schnelle wrote:
>>>> On Mon, 2022-11-28 at 14:52 +0000, Robin Murphy wrote:
>>>>> On 2022-11-16 17:16, Niklas Schnelle wrote:
>>>>>> When RPCIT indicates that the underlying hypervisor has run out of
>>>>>> resources it often means that its IOVA space is exhausted and IOVAs need
>>>>>> to be freed before new ones can be created. By triggering a flush of the
>>>>>> IOVA queue we can get the queued IOVAs freed and also get the new
>>>>>> mapping established during the global flush.
>>>>>
>>>>> Shouldn't iommu_dma_alloc_iova() already see that the IOVA space is
>>>>> exhausted and fail the DMA API call before even getting as far as
>>>>> iommu_map(), though? Or is there some less obvious limitation like a
>>>>> maximum total number of distinct IOVA regions regardless of size?
>>>>
>>>> Well, yes and no. Your thinking is of course correct if the advertised
>>>> available IOVA space can be fully utilized without exhausting
>>>> hypervisor resources we won't trigger this case. However sadly there
>>>> are complications. The most obvious being that in QEMU/KVM the
>>>> restriction of the IOVA space to what QEMU can actually have mapped at
>>>> once was just added recently[0] prior to that we would regularly go
>>>> through this "I'm out of resources free me some IOVAs" dance with our
>>>> existing DMA API implementation where this just triggers an early cycle
>>>> of freeing all unused IOVAs followed by a global flush. On z/VM I know
>>>> of no situations where this is triggered. That said this signalling is
>>>> architected so z/VM may have corner cases where it does this. On our
>>>> bare metal hypervisor (no paging) this return code is unused and IOTLB
>>>> flushes are simply hardware cache flushes as on bare metal platforms.
>>>>
>>>> [0]
>>>> https://lore.kernel.org/qemu-devel/20221028194758.204007-4-mjrosato@linux.ibm.com/
>>>
>>> That sheds a bit more light, thanks, although I'm still not confident I
>>> fully understand the whole setup. AFAICS that patch looks to me like
>>> it's putting a fixed limit on the size of the usable address space. That
>>> in turn implies that "free some IOVAs and try again" might be a red
>>> herring and never going to work; for your current implementation, what
>>> that presumably means in reality is "free some IOVAs, resetting the
>>> allocator to start allocating lower down in the address space where it
>>> will happen to be below that limit, and try again", but the iommu-dma
>>> allocator won't do that. If it doesn't know that some arbitrary range
>>> below the top of the driver-advertised aperture is unusable, it will
>>> just keep allocating IOVAs up there and mappings will always fail.
>>>
>>> If the driver can't accurately represent the usable IOVA space via the
>>> aperture and/or reserved regions, then this whole approach seems doomed.
>>> If on the other hand I've misunderstood and you can actually still use
>>> any address, just not all of them at the same time,
>>
>>
>> This is exactly it, the problem is a limit on the number of IOVAs that
>> are concurrently mapped. In QEMU pass-through the tightest limit is
>> usually the one set by the host kernel parameter
>> vfio_iommu_type1.dma_entry_limit which defaults to 65535 mappings. With
>> IOMMU_DOMAIN_DMA we stay under this limit without extra action but once
>> there is a flush queue (including the existing per-CPU one) where each
>> entry may keep many pages lazily unmapped this is easly hit with fio
>> bandwidth tests on an NVMe. For this case this patch works reliably
>> because of course the number of actually active mappings without the
>> lazily freed ones is similar to the number of active ones with
>> IOMMU_DOMAIN_DMA.
>>
>>>   then it might in
>>> fact be considerably easier to skip the flush queue mechanism entirely
>>> and implement this internally to the driver - basically make .iotlb_sync
>>> a no-op for non-strict DMA domains,
>>
>> I'm assuming you mean .iotlb_sync_map above.

No, I did mean .iotlb_sync, however on reflection that was under the 
assumption that it's OK for the hypervisor to see a new mapping for a 
previously-used IOVA without having seen it explicitly unmapped in 
between. Fair enough if that isn't the case, but if it is then your 
pagetable can essentially act as the "flush queue" by itself.

>>>   put the corresponding RPCIT flush
>>> and retry in .sync_map, then allow that to propagate an error back to
>>> iommu_map() if the new mapping still hasn't taken.
>>>
>>> Thanks,
>>> Robin.
>>
>> Hmm, interesting. This would leave the IOVAs in the flush queue lazily
>> unmapped and thus still block their re-use but free their host
>> resources via a global RPCIT allowing the guest to use a different
>> porition of the IOVA space with those resources. It could work, though
>> I need to test it, but it feels a bit clunky.
>>
>> Maybe we can go cleaner while using this idea of not having to flush
>> the queue but just freeing their host side resources. If we allowed
>> .iotlb_sync_map to return an error that fails the mapping operation,
>> then we could do it all in there. In the normal case it just does the
>> RPCIT but if that returns that the hypervisor ran out of resources it
>> does another global RPCIT allowing the hypervisor to free IOVAs that
>> were lazily unmapped. If the latter succeeds all is good if not then
>> the mapping operation failed. Logically it makes sense too,
>> .iotlb_sync_map is the final step of syncing the mapping to the host
>> which can fail just like the mapping operation itself.
>>
>> Apart from the out of active IOVAs case this would also handle the
>> other useful error case when using .iotlb_sync_map for shadowing where
>> it fails because the host ran against a pinned pages limit or out of
>> actual memory. Not by fixing it but at least we would get a failed
>> mapping operation.
>>
>> The other callbacks .flush_iotlb_all and .iotlb_sync
>> could stay the same as they are only used for unmapped pages where we
>> can't reasonably run out of resources in the host neither active IOVAs
>> nor pinned pages.
>>
> 
> Ok, I've done some testing with the above idea and this seems to work
> great. I've verified that my version of QEMU (without Matt's IOVA
> aperture resrtriction patch) creates the RPCIT out of resource
> indications and then the global flush in .iotlb_sync_map is triggered
> and allows QEMU to unpin pages and free IOVAs while the guest still has
> them lazily unpapeg (sitting in the flush queue) and thus uses
> different IOVAs.
> 
> @Robin @Joerg, if you are open to changing .iotlb_sync_map such that it
> can return and error and then failing the mapping operation I think
> this is a great approach. One advantage over the previous approach of
> flushing the queue isthat this should work for the pure IOMMU API too.

Whatever happens I think allowing .iotlb_sync_map to propagate an error 
out through iommu_map() is an appropriate thing to do - it sounds like 
s390 might technically need that for regular IOMMU API correctness in 
some circumstances anyway. Besides, even in the cases where it 
represents "simple" TLB maintenance, there are potentially ways that 
could fail (like timing out if the IOMMU has gone completely wrong), so 
it wouldn't seem entirely unreasonable if a driver might want to report 
overall failure if it can't guarantee that the new mapping will actually 
be usable.

Thanks,
Robin.

> If you don't want to change the signature of .iotlb_sync_map I think we
> can do Robin's idea and have .iotlb_sync_map as a no-op and do the
> RPCIT sync as part of the s390_iommu_map_pages(). This would hide what
> really is our variant of .iotlb_sync_map in the mapping code though
> which I don't super like. Besides that it would also cause more RPCITs
> in __iommu_map_sg() as we could no longer use a single RPCIT for the
> entire range.
> 
> Thanks,
> Niklas
