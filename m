Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BB063BF90
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 12:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbiK2L7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 06:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbiK2L6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 06:58:31 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F022D65C1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 03:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669723110; x=1701259110;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=U3Tl4S3Ip9ci59HnrcRegp2OrXY5p8eKKuV4kx7lCKE=;
  b=A39i6VWYpsnsT2tm20Z524lCk2gbzwuJ4E1NiWObHdxGb9IpHLCNWjtZ
   b/uM48eEnj7Hmluru6HMhwYM0W2T+MulFHhSTdJRonFK9eWWuQI8/UIe5
   Qg4P6aBpisWwhWINhoPnlQTBh1I8vHnzZfxegK1fBn4dh3sahv8OFXDId
   ioy5QoHdxCp79JGj2LzEyfTqAoOzKEiuUexWORdg8HssUzDUKqOVXpEXJ
   ojn9NqLVxtbsvVtN4rEYnjzHAXf8+fehOF/73cedI7siJp+MlmQoA11o3
   V2ZcreViakTe5NuyOKtoYl4bbZ1ofukdOesL8jbW2hwEwt0v2Pk68sKAa
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="315121078"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="315121078"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 03:58:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="888819302"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="888819302"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.214.73]) ([10.254.214.73])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 03:58:24 -0800
Message-ID: <953f2282-9459-d301-7766-a252703114f5@linux.intel.com>
Date:   Tue, 29 Nov 2022 19:58:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Rob Clark <robdclark@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/20] iommu/mtk: Remove detach_dev callback
To:     Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
 <20221128064648.1934720-7-baolu.lu@linux.intel.com>
 <Y4S8elzfzdTJGtyK@nvidia.com> <cb1b825c-55f1-d305-0727-ce8180d5a79e@arm.com>
 <4a979bdc-d7b4-77b4-490a-5f3e691e3df3@linux.intel.com>
 <f9d005e2-9fc6-bbf4-53fb-95f18201ce2d@arm.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <f9d005e2-9fc6-bbf4-53fb-95f18201ce2d@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/29 19:45, Robin Murphy wrote:
> On 2022-11-29 02:07, Baolu Lu wrote:
>> On 11/28/22 9:59 PM, Robin Murphy wrote:
>>> On 2022-11-28 13:49, Jason Gunthorpe wrote:
>>>> On Mon, Nov 28, 2022 at 02:46:34PM +0800, Lu Baolu wrote:
>>>>> The IOMMU driver supports default domain, so the detach_dev op will 
>>>>> never
>>>>> be called. Remove it to avoid dead code.
>>>>>
>>>>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>>>> ---
>>>>>   drivers/iommu/mtk_iommu.c | 9 ---------
>>>>>   1 file changed, 9 deletions(-)
>>>>
>>>> I listed this driver as not supporting default domains:
>>>>
>>>> https://lore.kernel.org/linux-iommu/20220516135741.GV1343366@nvidia.com/
>>>>
>>>> ?
>>>>
>>>> Has something changed? Did I get it wrong?
>>>
>>> static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
>>> {
>>>      struct mtk_iommu_domain *dom;
>>>
>>>      if (type != IOMMU_DOMAIN_DMA && type != IOMMU_DOMAIN_UNMANAGED)
>>>          return NULL;
>>> ...
>>>
>>>
>>> This one runs on arm64, so has always supported default domains for 
>>> iommu-dma to work.
>>
>> This, together with several other ones, only support IOMMU_DOMAIN_DMA
>> type of default domain. The iommu core handle this by falling back to
>> IOMMU_DOMAIN_DMA if other types fail.
>>
>>          dom = __iommu_domain_alloc(bus, type);
>>          if (!dom && type != IOMMU_DOMAIN_DMA) {
>>                  dom = __iommu_domain_alloc(bus, IOMMU_DOMAIN_DMA);
>>                  if (dom)
>>                          pr_warn("Failed to allocate default IOMMU 
>> domain of type %u for group %s - Falling back to IOMMU_DOMAIN_DMA",
>>                                  type, group->name);
>>          }
>>
>> I have another cleanup series:
>>
>> https://github.com/LuBaolu/intel-iommu/commits/iommu-use-def_default_type-wip
>>
>> which adds IOMMU_DOMAIN_DMA default domain type requirement in the
>> def_domain_type callback. I planed to bring that to discussion after
>> this one.
> 
> Per the discussion over on the s390 thread, I think that would be a step 
> in the wrong direction. I'd prefer to keep .def_domain_type for 
> device-specific requirements and express general driver domain support a 
> different way. If the IOMMU_DOMAIN_DMA fallback is worth removing then 
> the one for IOMMU_DOMAIN_BLOCKED is as well - no point doing half the 
> job ;)

Get you. Thanks for pointing this out. Sure, let's keep the code.

Best regards,
baolu
