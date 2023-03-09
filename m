Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA676B1996
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 03:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjCICvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 21:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjCICvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 21:51:35 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8469C74DF0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 18:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678330293; x=1709866293;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Sfy3RVQkVhkdnycyamTPB5zwaWdOCpmY/IhZLW0fhXo=;
  b=XdW+A06TaAacb/wannolZ8LXbDRMhXHKZif1hFW/Mn2RaOOmN/KQ1lhH
   HmqgNTbwXq2ViSSe5yY05u1VPzuDX/q6fiBX8Ia60XGbRVjSlXDO8i7Q3
   gS922puSTktulXEpQ32WLqKSTXyWu6TsFuNs+syXER9bjj8Bk8RtdvjNL
   h6iqPkzsbrSbkIeOLaG01Sr1YaK4VNMTx3mZ+jBEmAWhHhi7QcXM4TDhA
   VaJbsT+k9l2T2SmJX+YdkpLjE/LFtf/VjoPP0ntcAcvWAm2OMzhIQi7/U
   jDld+OHYr+PrV6YC0LYKPBGy035S/71eCLUMfAu2NuSeBgWJYseB9Yjhj
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="335042956"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="335042956"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 18:51:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="670568731"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="670568731"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 08 Mar 2023 18:51:30 -0800
Message-ID: <05fb17c7-397b-5b33-fbfa-df3bf48b0de8@linux.intel.com>
Date:   Thu, 9 Mar 2023 10:50:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] iommu: sprd: release dma buffer to avoid memory leak
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
References: <20230308034158.509458-1-chunyan.zhang@unisoc.com>
 <af90fea4-5fa1-de7b-b80e-02fa8753b0fb@arm.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <af90fea4-5fa1-de7b-b80e-02fa8753b0fb@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/23 8:37 PM, Robin Murphy wrote:
> On 2023-03-08 03:41, Chunyan Zhang wrote:
>> Release page table DMA buffer when the IOMMU domain is not used:
>>
>> - Domain freed.
>>
>> - IOMMU is attaching to a new domain.
>>    Since one sprd IOMMU servers only one client device, if the IOMMU has
>>    been attached to other domain, it has to be detached first, that's
>>    saying the DMA buffer should be released, otherwise that would
>>    cause memory leak issue.
> 
> This is clearly wrong; domain resources should only be freed when the 
> domain is freed. 

Agreed. Perhaps, in the attach path:

	if (!dom->pgt_va)
		dom->pgt_va = dma_alloc_coherent(sdev->dev, pgt_size,
				&dom->pgt_pa, GFP_KERNEL);
?

Best regards,
baolu

> Just because a caller has detached from a domain 
> doesn't mean that they can't reattach to it later and expect the 
> previous mappings to still be in place - it has nothing to do with how 
> many devices or domains can be active at once.
> 
> Thanks,
> Robin.
> 
>> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
>> ---
>> V2:
>> * Added some comment in sprd_iommu_attach_device() for the reason
>>    of calling sprd_iommu_cleanup().
>>
>> V1: https://lkml.org/lkml/2023/2/10/198
>> ---
>>   drivers/iommu/sprd-iommu.c | 46 ++++++++++++++++++++++++++++++++------
>>   1 file changed, 39 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
>> index ae94d74b73f4..fb2f96df3bca 100644
>> --- a/drivers/iommu/sprd-iommu.c
>> +++ b/drivers/iommu/sprd-iommu.c
>> @@ -62,6 +62,7 @@ enum sprd_iommu_version {
>>    * @eb: gate clock which controls IOMMU access
>>    */
>>   struct sprd_iommu_device {
>> +    struct sprd_iommu_domain    *dom;
>>       enum sprd_iommu_version    ver;
>>       u32            *prot_page_va;
>>       dma_addr_t        prot_page_pa;
>> @@ -151,13 +152,6 @@ static struct iommu_domain 
>> *sprd_iommu_domain_alloc(unsigned int domain_type)
>>       return &dom->domain;
>>   }
>> -static void sprd_iommu_domain_free(struct iommu_domain *domain)
>> -{
>> -    struct sprd_iommu_domain *dom = to_sprd_domain(domain);
>> -
>> -    kfree(dom);
>> -}
>> -
>>   static void sprd_iommu_first_vpn(struct sprd_iommu_domain *dom)
>>   {
>>       struct sprd_iommu_device *sdev = dom->sdev;
>> @@ -230,6 +224,29 @@ static void sprd_iommu_hw_en(struct 
>> sprd_iommu_device *sdev, bool en)
>>       sprd_iommu_update_bits(sdev, reg_cfg, mask, 0, val);
>>   }
>> +static void sprd_iommu_cleanup(struct sprd_iommu_device *sdev)
>> +{
>> +    struct sprd_iommu_domain *dom = sdev->dom;
>> +    size_t pgt_size = sprd_iommu_pgt_size(&dom->domain);
>> +
>> +    dma_free_coherent(sdev->dev, pgt_size, dom->pgt_va, dom->pgt_pa);
>> +    dom->sdev = NULL;
>> +    sdev->dom = NULL;
>> +    sprd_iommu_hw_en(sdev, false);
>> +}
>> +
>> +static void sprd_iommu_domain_free(struct iommu_domain *domain)
>> +{
>> +    struct sprd_iommu_domain *dom = to_sprd_domain(domain);
>> +    struct sprd_iommu_device *sdev = dom->sdev;
>> +
>> +    /* Free DMA buffer first if the domain has been attached */
>> +    if (sdev)
>> +        sprd_iommu_cleanup(sdev);
>> +
>> +    kfree(dom);
>> +}
>> +
>>   static int sprd_iommu_attach_device(struct iommu_domain *domain,
>>                       struct device *dev)
>>   {
>> @@ -237,14 +254,29 @@ static int sprd_iommu_attach_device(struct 
>> iommu_domain *domain,
>>       struct sprd_iommu_domain *dom = to_sprd_domain(domain);
>>       size_t pgt_size = sprd_iommu_pgt_size(domain);
>> +    /* Return directly if the domain attached to IOMMU already */
>>       if (dom->sdev)
>>           return -EINVAL;
>> +    /* The IOMMU already attached to a domain */
>> +    if (sdev->dom) {
>> +        if (sdev->dom == dom)
>> +            return 0;
>> +
>> +        /*
>> +         * Clean up the previous domain, one sprd IOMMU servers only
>> +         * one client device, if the IOMMU has been attached to other
>> +         * domain, it has to be detached first.
>> +         */
>> +        sprd_iommu_cleanup(sdev);
>> +    }
>> +
>>       dom->pgt_va = dma_alloc_coherent(sdev->dev, pgt_size, 
>> &dom->pgt_pa, GFP_KERNEL);
>>       if (!dom->pgt_va)
>>           return -ENOMEM;
>>       dom->sdev = sdev;
>> +    sdev->dom = dom;
>>       sprd_iommu_first_ppn(dom);
>>       sprd_iommu_first_vpn(dom);
> 
