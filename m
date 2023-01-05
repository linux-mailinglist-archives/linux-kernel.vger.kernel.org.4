Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6028A65E5AD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 07:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjAEGmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 01:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjAEGmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 01:42:02 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104EC30575
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 22:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672900921; x=1704436921;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tkEn4+iyBrYyM+BG70qzWehw5bgsW2jWNnwljwaqr/w=;
  b=XDOkdEwXLxonj7U2mCW7uP1gDKtkepabsCgIsHuM2PWHU9bLOwG0e5wh
   qVXl3KJdrQOsO271qb1JtTRjZQTGDmTgNIbiCO5Lrn7Q9kmYJV/h70I9o
   kyzPvzvZLpSTTokblD/bEMbR1OxIIJzLzNznv6sLAKTx0/n1KzMLBOGYt
   cX3n1KulfCWWhe7F9bc0z68EcWiir2kVCs89Of96NIcqpJqbYlUEYWEHh
   lfhVI5NjZcnaE6BgFfkcGpVxIpmJVwPLB2O8Pva4Xlpu/HvF4J1EVqygO
   1WYrQYTtd2ED8Z51WPalhZ0ydD77HFCsVCTMh94dNVTtVQ/rHNdfPmJaR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="349350129"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="349350129"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 22:41:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="723945456"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="723945456"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.211.114]) ([10.254.211.114])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 22:41:46 -0800
Message-ID: <d0dafb48-9c3f-834a-abc6-52cdb8f3ebf6@linux.intel.com>
Date:   Thu, 5 Jan 2023 14:41:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
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
Subject: Re: [PATCH v4 19/19] iommu: Remove detach_dev callback
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20230104125725.271850-1-baolu.lu@linux.intel.com>
 <20230104125725.271850-20-baolu.lu@linux.intel.com>
 <Y7V9rHPWoKvHTyrZ@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y7V9rHPWoKvHTyrZ@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/4 21:22, Jason Gunthorpe wrote:
> On Wed, Jan 04, 2023 at 08:57:25PM +0800, Lu Baolu wrote:
>> The detach_dev callback of domain ops is not called in the IOMMU core.
>> Remove this callback to avoid dead code. The trace event for detaching
>> domain from device is removed accordingly.
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   include/linux/iommu.h        |  2 --
>>   include/trace/events/iommu.h |  7 -------
>>   drivers/iommu/iommu-traces.c |  1 -
>>   drivers/iommu/iommu.c        | 29 +++++------------------------
>>   4 files changed, 5 insertions(+), 34 deletions(-)
>>
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 0d10566b3cb2..a8063f26ff69 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -299,7 +299,6 @@ struct iommu_ops {
>>    * * EBUSY	- device is attached to a domain and cannot be changed
>>    * * ENODEV	- device specific errors, not able to be attached
>>    * * <others>	- treated as ENODEV by the caller. Use is discouraged
>> - * @detach_dev: detach an iommu domain from a device
>>    * @set_dev_pasid: set an iommu domain to a pasid of device
>>    * @map: map a physically contiguous memory region to an iommu domain
>>    * @map_pages: map a physically contiguous set of pages of the same size to
>> @@ -320,7 +319,6 @@ struct iommu_ops {
>>    */
>>   struct iommu_domain_ops {
>>   	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
>> -	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
>>   	int (*set_dev_pasid)(struct iommu_domain *domain, struct device *dev,
>>   			     ioasid_t pasid);
>>   
>> diff --git a/include/trace/events/iommu.h b/include/trace/events/iommu.h
>> index 29096fe12623..70743db1fb75 100644
>> --- a/include/trace/events/iommu.h
>> +++ b/include/trace/events/iommu.h
>> @@ -76,13 +76,6 @@ DEFINE_EVENT(iommu_device_event, attach_device_to_domain,
>>   	TP_ARGS(dev)
>>   );
>>   
>> -DEFINE_EVENT(iommu_device_event, detach_device_from_domain,
>> -
>> -	TP_PROTO(struct device *dev),
>> -
>> -	TP_ARGS(dev)
>> -);
>> -
> did you want to add a trace for the set_platform_dma_ops in the
> earlier patch?

If necessary, we can add such a trace event. But I do hope to further
evolve the iommu drivers that need this callback. Finally, we should
remove it totally.

--
Best regards,
baolu
