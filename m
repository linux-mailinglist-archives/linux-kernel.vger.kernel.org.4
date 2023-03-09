Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A53D6B22D0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 12:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjCIL0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 06:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjCILZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:25:40 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 585791CBF8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 03:23:07 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97315C14;
        Thu,  9 Mar 2023 03:23:50 -0800 (PST)
Received: from [10.57.91.145] (unknown [10.57.91.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B46D43F67D;
        Thu,  9 Mar 2023 03:23:05 -0800 (PST)
Message-ID: <9a88b12e-7169-7c7f-09a1-eef86f75891c@arm.com>
Date:   Thu, 9 Mar 2023 11:23:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V2] iommu: sprd: release dma buffer to avoid memory leak
Content-Language: en-GB
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux.dev, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230308034158.509458-1-chunyan.zhang@unisoc.com>
 <af90fea4-5fa1-de7b-b80e-02fa8753b0fb@arm.com>
 <05fb17c7-397b-5b33-fbfa-df3bf48b0de8@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <05fb17c7-397b-5b33-fbfa-df3bf48b0de8@linux.intel.com>
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

On 2023-03-09 02:50, Baolu Lu wrote:
> On 3/8/23 8:37 PM, Robin Murphy wrote:
>> On 2023-03-08 03:41, Chunyan Zhang wrote:
>>> Release page table DMA buffer when the IOMMU domain is not used:
>>>
>>> - Domain freed.
>>>
>>> - IOMMU is attaching to a new domain.
>>>    Since one sprd IOMMU servers only one client device, if the IOMMU has
>>>    been attached to other domain, it has to be detached first, that's
>>>    saying the DMA buffer should be released, otherwise that would
>>>    cause memory leak issue.
>>
>> This is clearly wrong; domain resources should only be freed when the 
>> domain is freed. 
> 
> Agreed. Perhaps, in the attach path:
> 
>      if (!dom->pgt_va)
>          dom->pgt_va = dma_alloc_coherent(sdev->dev, pgt_size,
>                  &dom->pgt_pa, GFP_KERNEL);
> ?

Why? dom->pgt_va will always be NULL if dom->sdev is NULL, and once 
dom->sdev is set then that allocation is not reachable (of course this 
means the driver also has a separate bug where reattaching to a 
previously-used domain will erroneously fail, but that's not a memory 
leak as such). The only thing to recognise here is that the allocation 
is logically not part of the .attach_dev operation, but really a one-off 
deferred part of .domain_alloc, and thus it should be balanced in .free, 
not anywhere else.

Thanks,
Robin.

> 
> Best regards,
> baolu
> 
>> Just because a caller has detached from a domain doesn't mean that 
>> they can't reattach to it later and expect the previous mappings to 
>> still be in place - it has nothing to do with how many devices or 
>> domains can be active at once.
>>
>> Thanks,
>> Robin.
>>
>>> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
>>> ---
>>> V2:
>>> * Added some comment in sprd_iommu_attach_device() for the reason
>>>    of calling sprd_iommu_cleanup().
>>>
>>> V1: https://lkml.org/lkml/2023/2/10/198
>>> ---
>>>   drivers/iommu/sprd-iommu.c | 46 ++++++++++++++++++++++++++++++++------
>>>   1 file changed, 39 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
>>> index ae94d74b73f4..fb2f96df3bca 100644
>>> --- a/drivers/iommu/sprd-iommu.c
>>> +++ b/drivers/iommu/sprd-iommu.c
>>> @@ -62,6 +62,7 @@ enum sprd_iommu_version {
>>>    * @eb: gate clock which controls IOMMU access
>>>    */
>>>   struct sprd_iommu_device {
>>> +    struct sprd_iommu_domain    *dom;
>>>       enum sprd_iommu_version    ver;
>>>       u32            *prot_page_va;
>>>       dma_addr_t        prot_page_pa;
>>> @@ -151,13 +152,6 @@ static struct iommu_domain 
>>> *sprd_iommu_domain_alloc(unsigned int domain_type)
>>>       return &dom->domain;
>>>   }
>>> -static void sprd_iommu_domain_free(struct iommu_domain *domain)
>>> -{
>>> -    struct sprd_iommu_domain *dom = to_sprd_domain(domain);
>>> -
>>> -    kfree(dom);
>>> -}
>>> -
>>>   static void sprd_iommu_first_vpn(struct sprd_iommu_domain *dom)
>>>   {
>>>       struct sprd_iommu_device *sdev = dom->sdev;
>>> @@ -230,6 +224,29 @@ static void sprd_iommu_hw_en(struct 
>>> sprd_iommu_device *sdev, bool en)
>>>       sprd_iommu_update_bits(sdev, reg_cfg, mask, 0, val);
>>>   }
>>> +static void sprd_iommu_cleanup(struct sprd_iommu_device *sdev)
>>> +{
>>> +    struct sprd_iommu_domain *dom = sdev->dom;
>>> +    size_t pgt_size = sprd_iommu_pgt_size(&dom->domain);
>>> +
>>> +    dma_free_coherent(sdev->dev, pgt_size, dom->pgt_va, dom->pgt_pa);
>>> +    dom->sdev = NULL;
>>> +    sdev->dom = NULL;
>>> +    sprd_iommu_hw_en(sdev, false);
>>> +}
>>> +
>>> +static void sprd_iommu_domain_free(struct iommu_domain *domain)
>>> +{
>>> +    struct sprd_iommu_domain *dom = to_sprd_domain(domain);
>>> +    struct sprd_iommu_device *sdev = dom->sdev;
>>> +
>>> +    /* Free DMA buffer first if the domain has been attached */
>>> +    if (sdev)
>>> +        sprd_iommu_cleanup(sdev);
>>> +
>>> +    kfree(dom);
>>> +}
>>> +
>>>   static int sprd_iommu_attach_device(struct iommu_domain *domain,
>>>                       struct device *dev)
>>>   {
>>> @@ -237,14 +254,29 @@ static int sprd_iommu_attach_device(struct 
>>> iommu_domain *domain,
>>>       struct sprd_iommu_domain *dom = to_sprd_domain(domain);
>>>       size_t pgt_size = sprd_iommu_pgt_size(domain);
>>> +    /* Return directly if the domain attached to IOMMU already */
>>>       if (dom->sdev)
>>>           return -EINVAL;
>>> +    /* The IOMMU already attached to a domain */
>>> +    if (sdev->dom) {
>>> +        if (sdev->dom == dom)
>>> +            return 0;
>>> +
>>> +        /*
>>> +         * Clean up the previous domain, one sprd IOMMU servers only
>>> +         * one client device, if the IOMMU has been attached to other
>>> +         * domain, it has to be detached first.
>>> +         */
>>> +        sprd_iommu_cleanup(sdev);
>>> +    }
>>> +
>>>       dom->pgt_va = dma_alloc_coherent(sdev->dev, pgt_size, 
>>> &dom->pgt_pa, GFP_KERNEL);
>>>       if (!dom->pgt_va)
>>>           return -ENOMEM;
>>>       dom->sdev = sdev;
>>> +    sdev->dom = dom;
>>>       sprd_iommu_first_ppn(dom);
>>>       sprd_iommu_first_vpn(dom);
>>
