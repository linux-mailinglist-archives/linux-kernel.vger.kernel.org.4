Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814E665FB47
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 07:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjAFGQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 01:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjAFGPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 01:15:35 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF0D6E0F4
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 22:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672985728; x=1704521728;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RmytUvZloFqZjLn+Gjei9YcPhUmpKmoSVMerW6+BRW0=;
  b=VVigBpj+bCrvbiD9eEHMO5U1xrbiHo+ICEcqbpmteS3d3C+d4gYcMcOE
   WAU2QUPCXSgWtq3vBjSVi4GMDE2kcs+Z9cyySdsrW91vcjW1YEgXu/WW4
   niCjK/O+oMNCQqcvCBGr7euNrzma7ayCND//Gu0HT97FsQXmCT2CngDJF
   vDSatjBaVsZX2a+UP03bR/a42NYeHQfbAIL2mZ1icJ3FVQA2q61UCBJyd
   zgTFPcyE+KwcdGZAXCb7HOWgQFh//IUqoWmPOvrKBrPohLyRABGhlAjef
   50fZNRSlSAoVGAmkwAYmDsP9/aQVfoWtK8yatzb+1x0YtXouiMCml5ehR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="323666454"
X-IronPort-AV: E=Sophos;i="5.96,304,1665471600"; 
   d="scan'208";a="323666454"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 22:15:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="724336090"
X-IronPort-AV: E=Sophos;i="5.96,304,1665471600"; 
   d="scan'208";a="724336090"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jan 2023 22:15:19 -0800
Message-ID: <0f6426c9-71bb-826a-78f0-bc8851b6468e@linux.intel.com>
Date:   Fri, 6 Jan 2023 14:07:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
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
Subject: Re: [PATCH v4 10/19] iommu: Add set_platform_dma_ops iommu ops
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20230104125725.271850-1-baolu.lu@linux.intel.com>
 <20230104125725.271850-11-baolu.lu@linux.intel.com>
 <Y7V8bcUF5zvGvCAP@nvidia.com>
 <1ef288af-885a-f724-ea37-199f181e4937@linux.intel.com>
 <Y7bNidP/px0NmvR+@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y7bNidP/px0NmvR+@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/23 9:15 PM, Jason Gunthorpe wrote:
> On Thu, Jan 05, 2023 at 01:58:42PM +0800, Baolu Lu wrote:
>> Hi Jason,
>>
>> On 2023/1/4 21:17, Jason Gunthorpe wrote:
>>> On Wed, Jan 04, 2023 at 08:57:16PM +0800, Lu Baolu wrote:
>>>
>>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>>> index de91dd88705b..4e35a9f94873 100644
>>>> --- a/drivers/iommu/iommu.c
>>>> +++ b/drivers/iommu/iommu.c
>>>> @@ -2163,6 +2163,17 @@ static int iommu_group_do_detach_device(struct device *dev, void *data)
>>>>    	return 0;
>>>>    }
>>>> +static int iommu_group_do_set_platform_dma(struct device *dev, void *data)
>>>> +{
>>>> +	const struct iommu_ops *ops = dev_iommu_ops(dev);
>>>> +
>>>> +	if (!ops->set_platform_dma_ops)
>>>> +		return -EINVAL;
>>>> +
>>>> +	ops->set_platform_dma_ops(dev);
>>>> +	return 0;
>>>> +}
>>>> +
>>>>    static int __iommu_group_set_domain(struct iommu_group *group,
>>>>    				    struct iommu_domain *new_domain)
>>>>    {
>>>> @@ -2177,10 +2188,14 @@ static int __iommu_group_set_domain(struct iommu_group *group,
>>>>    	 * platform specific behavior.
>>>>    	 */
>>>>    	if (!new_domain) {
>>>> -		if (WARN_ON(!group->domain->ops->detach_dev))
>>>> -			return -EINVAL;
>>> This should still have the WARN_ON..
>>>
>>> if (WARN_ON(!group->domain->ops->detach_dev && !dev_iommu_ops(dev)->set_platform_dma_ops)
>> This has been implicitly included in the code.
>>
>> iommu_group_do_set_platform_dma() returns -EINVAL if the iommu driver
>> doesn't support set_platform_dma_ops (otherwise always return success).
>> Then, the domain->ops->detach_dev is required and a WARN_ON was there.
>>
>>          if (!new_domain) {
>>                  ret = __iommu_group_for_each_dev(group, NULL,
>>                                  iommu_group_do_set_platform_dma);
>>                  if (ret) {
>>                          if (WARN_ON(!group->domain->ops->detach_dev))
>>                                  return -EINVAL;
>>                          __iommu_group_for_each_dev(group, group->domain,
>>                                  iommu_group_do_detach_device);
>>                  }
>>                  group->domain = NULL;
>>                  return 0;
>>          }
>>
>> Perhaps I should add a comment to explain this?
> But you delete this later when you remove this.
> 
> I think testing the op directly is much clearer, get rid of the whole
> ret and EINVAL thinig:
> 
> if (dev_iommu_ops(dev)->set_platform_dma_ops)
>     __iommu_group_for_each_dev(group, NULL,
>                                   iommu_group_do_set_platform_dma); //	 Can't fail!
> else if (group->domain->ops->detach_dev)
>       __iommu_group_for_each_dev(group, group->domain,
>                                   iommu_group_do_detach_device);
> else
>     WARN(true)

Above looks good to me. Thanks! I have updated this part of code like
below:

@@ -2177,10 +2188,20 @@ static int __iommu_group_set_domain(struct 
iommu_group *group,
          * platform specific behavior.
          */
         if (!new_domain) {
-               if (WARN_ON(!group->domain->ops->detach_dev))
-                       return -EINVAL;
-               __iommu_group_for_each_dev(group, group->domain,
-                                          iommu_group_do_detach_device);
+               struct group_device *grp_dev;
+
+               grp_dev = list_first_entry(&group->devices,
+                                          struct group_device, list);
+
+               if (dev_iommu_ops(grp_dev->dev)->set_platform_dma_ops)
+                       __iommu_group_for_each_dev(group, NULL,
+                                       iommu_group_do_set_platform_dma);
+               else if (group->domain->ops->detach_dev)
+                       __iommu_group_for_each_dev(group, group->domain,
+                                       iommu_group_do_detach_device);
+               else
+                       WARN_ON_ONCE(1);
+
                 group->domain = NULL;
                 return 0;
         }

--
Best regards,
baolu
