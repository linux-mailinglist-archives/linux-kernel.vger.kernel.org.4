Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA4D6B4BDB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjCJQCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjCJQCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:02:17 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E44A620A27
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 07:57:38 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FB1F4B3;
        Fri, 10 Mar 2023 07:58:22 -0800 (PST)
Received: from [10.57.90.67] (unknown [10.57.90.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B72473F5A1;
        Fri, 10 Mar 2023 07:57:36 -0800 (PST)
Message-ID: <029bb2f5-78d5-a3f2-1ae7-97fc7147611d@arm.com>
Date:   Fri, 10 Mar 2023 15:57:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 02/14] iommufd: Add nesting related data structures for
 ARM SMMUv3
Content-Language: en-GB
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
        eric.auger@redhat.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, yi.l.liu@intel.com
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <364cfbe5b228ab178093db2de13fa3accf7a6120.1678348754.git.nicolinc@nvidia.com>
 <20230309134217.GA1673607@myrica> <ZAnx0lUkw02cVTi+@nvidia.com>
 <20230309182659.GA1710571@myrica> <ZApJGwPjHhlDwTDV@nvidia.com>
 <82f5b94b-01fe-5c99-608c-f7d124247b7c@arm.com> <ZAtL0Dx0QRbXOTfZ@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZAtL0Dx0QRbXOTfZ@nvidia.com>
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

On 2023-03-10 15:25, Jason Gunthorpe wrote:
> On Fri, Mar 10, 2023 at 02:52:42PM +0000, Robin Murphy wrote:
>> On 2023-03-09 21:01, Jason Gunthorpe wrote:
>>>> For a lot of SMMUv3 implementations that have a single queue and for
>>>> other architectures, we can do better than hardware emulation.
>>>
>>> How is using a SW emulated virtio formatted queue better than using a
>>> SW emulated SMMUv3 ECMDQ?
>>
>> Since it's not been said, the really big thing is that virtio explicitly
>> informs the host whenever the guest maps something. Emulating SMMUv3 means
>> the host has to chase all the pagetable pointers in guest memory and trap
>> writes such that it has visibility of invalid->valid transitions and can
>> update the physical shadow pagetable correspondingly.
> 
> Sorry, I mean in the context of future virtio-iommu that is providing
> nested translation.

Ah, that's probably me missing the context again.

> eg why would anyone want to use virtio to provide SMMUv3 based HW
> accelerated nesting?
> 
> Jean suggested that the invalidation flow for virtio-iommu could be
> faster because it is in kernel, but I'm saying that we could also make
> the SMMUv3 invalidation in-kernel with the same basic technique. (and
> actively wondering if we should put more focus on that)
> 
> I understand the appeal of the virtio scheme with its current
> map/unmap interface.
> 
> I could also see some appeal of a simple virtio-iommu SVA that could
> point map a CPU page table as an option. The guest already has to know
> how to manage these anyhow so it is nicely general.
> 
> If iommufd could provide a general cross-driver API to set exactly
> that scenario up then VMM code could also be general. That seems
> prettty interesting.

Indeed, I've always assumed the niche for virtio would be that kind of 
in-between use-case using nesting to accelerate simple translation, 
where we plug a guest-owned pagetable into a host-owned context. That 
way the guest retains the simple virtio interface and only needs to 
understand a pagetable format (or as you say, simply share a CPU 
pagetable) without having to care about the nitty-gritty of all the 
IOMMU-specific moving parts around it. For guests that want to get into 
more advanced stuff like managing their own PASID tables, pushing them 
towards "native" nesting probably does make more sense.

> But if the plan is to expose more detailed stuff like the CD or GCR3
> PASID tables as something the guest has to manipulate and then a bunch
> of special invalidation to support that, and VMM code to back it, then
> I'm questioning the whole point. We lost the generality.
> 
> Just use the normal HW accelerated SMMUv3 nesting model instead.
> 
> If virtio-iommu SVA is really important for ARM then I'd suggest
> SMMUv3 should gain a new HW capability to allowed the CD table to be
> in hypervisor memory so it works consistently for virtio-iommu SVA.

Oh, maybe I should have read this far before reasoning the exact same 
thing from scratch... oh well, this time I'm not going to go back and 
edit :)

Thanks,
Robin.
