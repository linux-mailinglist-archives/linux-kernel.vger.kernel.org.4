Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9196B2D53
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 20:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjCITEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 14:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjCITEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 14:04:37 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75503F8A48
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 11:04:30 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6961DC14;
        Thu,  9 Mar 2023 11:05:13 -0800 (PST)
Received: from [10.57.91.145] (unknown [10.57.91.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E89CF3F71A;
        Thu,  9 Mar 2023 11:04:27 -0800 (PST)
Message-ID: <64c7659b-9bd5-2239-cde9-f7b48f6877ca@arm.com>
Date:   Thu, 9 Mar 2023 19:04:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 01/14] iommu: Add iommu_get_unmanaged_domain helper
Content-Language: en-GB
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
        eric.auger@redhat.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com, jean-philippe@linaro.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <9b1077601cace998533129327f5e7ad946752d29.1678348754.git.nicolinc@nvidia.com>
 <2118a147-ac95-d846-ad6f-85d7cebca46a@arm.com> <ZAnq/8Ak75Dr7JM0@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZAnq/8Ak75Dr7JM0@nvidia.com>
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

On 2023-03-09 14:19, Jason Gunthorpe wrote:
> On Thu, Mar 09, 2023 at 12:51:20PM +0000, Robin Murphy wrote:
> 
>> Please note I stress "valid" since I'm not buying arbitrarily made-up
>> conceptual purity arguments. A nested domain cannot be the "one true domain"
>> that is an opaque combination of S1+S2; the IOMMU API view has to be more
>> like the device is attached to both the nested domain and the parent stage 2
>> domain somewhat in parallel.
> 
> I strongly disagree with this.
> 
> The design we have from the core perspective is an opaque domain that
> is a hidden combination of S1/S2 inside the driver. We do not want to
> change the basic design of the iommu core: there is only one domain
> attached to a device/group at a time.
> 
> This patch should be seen as a temporary hack to allow the ARM ITS
> stuff to hobble on a little longer. We already know that iommufd use
> cases are incompatible with the design and we need to fix it. The
> fixed solution must have iommufd install the ITS pages at domain
> allocation time and so it will not need these APIs at all. This
> tempoary code should not dictate the overall design of the iommu core.
> 
> If we belive exposing the S1/S2 relationships through the iommu core
> is necessary for another legitimate purpose I would like to hear about
> it. In my opinion using APIs to peek into these details is far more
> likely to be buggy and long term I prefer to block the ability to
> learn the S2 externally from iommufd completely.
> 
> Thus the overall design of the iommu core APIs is not being changed.
> The core API design follows this logic with and without nesting:
>     iommu_attach_device(domin);
>     WARN_ON(domain != iommu_get_domain_for_dev());

That is indeed one of many conditions that are true today, but the facts 
are that nothing makes that specific assertion, nothing should ever 
*need* to make that specific assertion, and any driver sufficiently dumb 
to not bother keeping track of its own domain and relying on 
iommu_get_domain_for_dev() to retrieve it should most definitely not be 
allowed anywhere near nesting.

The overall design of the iommu core APIs *is* being changed, because 
the current design is also that iommu_get_domain_for_dev() always 
returns the correct domain that iommu_dma_prepare_msi() needs, which 
breaks with nesting. You are literally insisting on changing this core 
API, to work around intentionally breaking an existing behaviour which 
could easily be preserved (far less invasively), for the sake of 
preserving some other theoretical behaviour that IS NOT USEFUL.

The overall design of the iommu core APIs *is* being changed, because 
the core API design also follows this logic for any domain type:

	domain = iommu_get_domain_for_dev();
	phys = iommu_iova_to_phys(domain, iova);
	//phys meaningfully represents whether iova was valid

Yes, even blocking and identity domains, because drivers ACTUALLY DO 
THIS. I'm not sure there even is a single correct thing that nesting 
domains could do to satisfy all the possible expectations that callers 
of iommu_iova_to_phys() may have. However if the grand design says it's 
not OK for iommu_get_domain_for_dev() to return what 
iommu_dma_prepare_msi() needs even though nobody else should ever be 
passing a nesting domain to it, then it's also not OK for 
iommu_iova_to_phys() to crash or lie and return 0 when a valid 
translation (by some notion) exists, even though nobody should ever pass 
a nesting domain in there either.

Forgive me for getting wound up, but I'm a pragmatist and my tolerance 
for ignoring reality is low.

> The hack in this patch gets its own special single-use APIs so we can
> purge them once they are not needed and do not confusingly contaminate
> the whole design. For this reason the ops call back should only be
> implemented by SMMUv3.
> 
>> Even when nesting is active, the S2 domain still exists as a domain
>> in its own right, and still needs to be visible and operated on as
>> such, for instance if memory is hotplugged in or out of the VM.
> 
> It exists in iommufd and iommufd will operate it. This is not a
> problem.
> 
> iommufd is not using a dual attach model.
> 
> The S2 is provided to the S1's domain allocation function as creation
> data. The returned S1 domain opaquely embeds the S2. The embedded S2
> cannot be changed once the S1 domain is allocated.
> 
> Attaching the S1 always causes the embedded S2 to be used too - they
> are not separable so we don't have APIs talking about about
> "attaching" the S2.

Yes, that is one way of viewing things, but it's far from the only way. 
The typical lifecycle will involve starting the VM with S2 alone, then 
enabling nesting later - we can view that as allocating a nested domain 
based on S2, then "replacing" S2 with nested, but we could equally view 
it as just attaching the nested domain on top of the existing S2, like 
pushing to a stack (I do agree that trying to model it as two completely 
independent and orthogonal attachments would not be sensible). It's 
really just semantics of how we prefer to describe things, and whether 
the s2_domain pointer is passed up-front to domain_alloc or later to 
attach_dev.

The opaque nested domain looks clean in some ways, but on the other hand 
it also heavily obfuscates how translations may be shared between one 
nested domain and other nested and non-nested domains, such that 
changing mappings in one may affect others. This is a major and 
potentially surprising paradigm shift away from the current notion that 
all domains represent individual isolated address spaces, so abstracting 
it more openly within the core API internals would be clearer about 
what's really going on. And putting common concepts at common levels of 
abstraction makes things simpler and is why we have core API code at all.

Frankly it's not like we don't already have various API-internal stuff 
in struct iommu_domain that nobody external should ever be looking at, 
but if that angst remains overwhelming then I can't imagine it being all 
that much work to move the definition to iommu-priv.h - AFAICS it 
shouldn't need much more than some helpers for the handful of 
iommu_get_domain_for_dev() users currently inspecting the type, 
pgsize_bitmap, or geometry - which would ultimately be a good deal 
neater and more productive than adding yet more special-case ops that 
every driver is just going to implement identically.

And to even imagine the future possibility of things like S2 pagetable 
sharing with KVM, or unpinned S2 with ATS/PRI or SMMU stalls, by 
tunnelling more private nesting interfaces directly between IOMMUFD and 
individual drivers without some degree of common IOMMU API abstraction 
in between... no. Just... no.

Thanks,
Robin.
