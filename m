Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6693660C07
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 03:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjAGCsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 21:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjAGCsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 21:48:42 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD768B535
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 18:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673059721; x=1704595721;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jeI+tFkLh+++AU1LMUIzjlxVEKuYd/d2QZDYvn5z6VU=;
  b=MFTcESiUkgK7HY3aj4DrKcOiOIqdHS0rYPrpJ8FeG/u2bSPzlFpgbY2n
   SZUi+wc9wAxz7BR96hVXOZRCFRctv9JtOlw+63ahKdTyd3t8x/uxu1lDb
   mJBwU1PZaXPUJ7m5fFxUEK95lJsk9gr47dgvagJTuUGiFfgjaX6N6bGwO
   XKDgD65+jREeREIaBwDxDJsK/t0Lz31VzB221P47HInNPgQCjMvnPNEDQ
   VLXHlGMRY/4HRspjAARVRKmZ+XmnS0EsBrJKkJdbqSrW4U6uT1yPE2fzD
   qnCEhctnYRR7kRuju7lZG4AeJfqbLMjViT/lvXvezsxJTLpyipOEOg4yn
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="387062688"
X-IronPort-AV: E=Sophos;i="5.96,307,1665471600"; 
   d="scan'208";a="387062688"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 18:48:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="984854342"
X-IronPort-AV: E=Sophos;i="5.96,307,1665471600"; 
   d="scan'208";a="984854342"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.209.158]) ([10.254.209.158])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 18:48:33 -0800
Message-ID: <5ce5a6a4-9397-9665-7352-862d89b3f228@linux.intel.com>
Date:   Sat, 7 Jan 2023 10:48:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 10/19] iommu: Add set_platform_dma_ops iommu ops
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
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
References: <20230104125725.271850-1-baolu.lu@linux.intel.com>
 <20230104125725.271850-11-baolu.lu@linux.intel.com>
 <Y7V8bcUF5zvGvCAP@nvidia.com>
 <1ef288af-885a-f724-ea37-199f181e4937@linux.intel.com>
 <Y7bNidP/px0NmvR+@nvidia.com>
 <0f6426c9-71bb-826a-78f0-bc8851b6468e@linux.intel.com>
 <Y7gveMpxJWmpYkk2@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y7gveMpxJWmpYkk2@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/2023 10:26 PM, Jason Gunthorpe wrote:
> On Fri, Jan 06, 2023 at 02:07:32PM +0800, Baolu Lu wrote:
> 
>> Above looks good to me. Thanks! I have updated this part of code like
>> below:
>>
>> @@ -2177,10 +2188,20 @@ static int __iommu_group_set_domain(struct
>> iommu_group *group,
>>           * platform specific behavior.
>>           */
>>          if (!new_domain) {
>> -               if (WARN_ON(!group->domain->ops->detach_dev))
>> -                       return -EINVAL;
>> -               __iommu_group_for_each_dev(group, group->domain,
>> -                                          iommu_group_do_detach_device);
>> +               struct group_device *grp_dev;
>> +
>> +               grp_dev = list_first_entry(&group->devices,
>> +                                          struct group_device, list);
> It seems OK - I hope we naturally can't ever get in a situation where
> a group has disjoint iommu drivers.

The final code after cleanup looks like below. We will WARN_ON the lack
of callback in the iommu_group_do_set_platform_dma() helper.

2152 static int iommu_group_do_set_platform_dma(struct device *dev, void 
*data)
2153 {
2154         const struct iommu_ops *ops = dev_iommu_ops(dev);
2155
2156         if (!WARN_ON(!ops->set_platform_dma_ops))
2157                 ops->set_platform_dma_ops(dev);
2158
2159         return 0;
2160 }
2161
2162 static int __iommu_group_set_domain(struct iommu_group *group,
2163                                     struct iommu_domain *new_domain)
2164 {
2165         int ret;
2166
2167         if (group->domain == new_domain)
2168                 return 0;
2169
2170         /*
2171          * New drivers should support default domains, so 
set_platform_dma()
2172          * op will never be called. Otherwise the NULL domain 
represents some
2173          * platform specific behavior.
2174          */
2175         if (!new_domain) {
2176                 __iommu_group_for_each_dev(group, NULL,
2177 
iommu_group_do_set_platform_dma);
2178                 group->domain = NULL;
2179                 return 0;
2180         }

How do you like this?

--
Best regards,
baolu
