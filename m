Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CC665B97E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 03:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236482AbjACCxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 21:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjACCxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 21:53:21 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C6CC41
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 18:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672714400; x=1704250400;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZnawkaIQRSyqmMXF2c3jHVfo9pYOC0DUPmp8CLyVqg8=;
  b=NZOtzNOpAtFrXvddMcxZ5ODXS4c3Ky2d5HsrL5s88T211FXPfFuYelwo
   SkBvSrppnRMaLrp2RftdnQSDa6zUUesXVSPyTS5eyuaLfJjARKkYpbpgm
   DHHBDOglW/rwXJnohWJIw9sBqWYobRX/onGS+lxFAZqej2kUSMBHFtRDQ
   bkRYMt/PgCYujfNhSXHFx3iaL+VA6mvivlAl1bqSG9jcEWeYIRPg02PxL
   SjDJcvO6iMOd7DPdszgFpvywly+t5Z2uXEioKl+9SfASJUgeoptnWNZEn
   ZNT2NVmUrSmW5je+GzVaMpeVL3cR76N1b/zsWol910nkfMfV2LIpdtr2D
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="319274405"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; 
   d="scan'208";a="319274405"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 18:53:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="654641915"
X-IronPort-AV: E=Sophos;i="5.96,295,1665471600"; 
   d="scan'208";a="654641915"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga002.jf.intel.com with ESMTP; 02 Jan 2023 18:53:08 -0800
Message-ID: <e51496f4-2874-04ad-818f-e4579cf3a1d3@linux.intel.com>
Date:   Tue, 3 Jan 2023 10:45:24 +0800
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
Subject: Re: [PATCH v3 18/20] iommu: Call set_platform_dma if default domain
 is unavailable
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
 <20221128064648.1934720-19-baolu.lu@linux.intel.com>
 <Y4TMQ7HazPWMdsNj@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y4TMQ7HazPWMdsNj@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On 11/28/22 10:57 PM, Jason Gunthorpe wrote:
> On Mon, Nov 28, 2022 at 02:46:46PM +0800, Lu Baolu wrote:
>> If the IOMMU driver has no default domain support, call set_platform_dma
>> explicitly to return the kernel DMA control back to the platform DMA ops.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/iommu.c | 28 ++++++++--------------------
>>   1 file changed, 8 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 7c99d8eb3182..e4966f088184 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -2040,16 +2040,6 @@ int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
>>   	return 0;
>>   }
>>   
>> -static void __iommu_detach_device(struct iommu_domain *domain,
>> -				  struct device *dev)
>> -{
>> -	if (iommu_is_attach_deferred(dev))
>> -		return;
> 
> This removal might want to be its own patch with an explanation.
> 
> It looks like at the current moment __iommu_detach_device() is only
> called via call chains that are after the device driver is attached -
> eg via explicit attach APIs called by the device driver.
> 
> So it should just unconditionally work. It is actually looks like a
> bug that we were blocking detach on these paths since the attach was
> unconditional and the caller is going to free the (probably) UNAMANGED
> domain once this returns.
> 
> The only place we should be testing for deferred attach is during the
> initial point the dma device is linked to the group, and then again
> during the dma api calls to check if the device
> 
> This maybe the patch that is needed to explain this:
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index d69ebba81bebd8..06f1fe6563bb30 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -993,8 +993,8 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
>   
>   	mutex_lock(&group->mutex);
>   	list_add_tail(&device->list, &group->devices);
> -	if (group->domain  && !iommu_is_attach_deferred(dev))
> -		ret = __iommu_attach_device(group->domain, dev);
> +	if (group->domain)
> +		ret = iommu_group_do_dma_first_attach(dev, group->domain);
>   	mutex_unlock(&group->mutex);
>   	if (ret)
>   		goto err_put_group;
> @@ -1760,21 +1760,24 @@ static void probe_alloc_default_domain(struct bus_type *bus,
>   
>   }
>   
> -static int iommu_group_do_dma_attach(struct device *dev, void *data)
> +static int iommu_group_do_dma_first_attach(struct device *dev, void *data)
>   {
>   	struct iommu_domain *domain = data;
> -	int ret = 0;
>   
> -	if (!iommu_is_attach_deferred(dev))
> -		ret = __iommu_attach_device(domain, dev);
> +	lockdep_assert_held(&dev->iommu_group->mutex);
>   
> -	return ret;
> +	if (iommu_is_attach_deferred(dev)) {
> +		dev->iommu->attach_deferred = 1;
> +		return 0;
> +	}
> +
> +	return __iommu_attach_device(domain, dev);
>   }
>   
> -static int __iommu_group_dma_attach(struct iommu_group *group)
> +static int __iommu_group_dma_first_attach(struct iommu_group *group)
>   {
>   	return __iommu_group_for_each_dev(group, group->default_domain,
> -					  iommu_group_do_dma_attach);
> +					  iommu_group_do_dma_first_attach);
>   }
>   
>   static int iommu_group_do_probe_finalize(struct device *dev, void *data)
> @@ -1839,7 +1842,7 @@ int bus_iommu_probe(struct bus_type *bus)
>   
>   		iommu_group_create_direct_mappings(group);
>   
> -		ret = __iommu_group_dma_attach(group);
> +		ret = __iommu_group_dma_first_attach(group);
>   
>   		mutex_unlock(&group->mutex);
>   
> @@ -1971,9 +1974,11 @@ static int __iommu_attach_device(struct iommu_domain *domain,
>   		return -ENODEV;
>   
>   	ret = domain->ops->attach_dev(domain, dev);
> -	if (!ret)
> -		trace_attach_device_to_domain(dev);
> -	return ret;
> +	if (ret)
> +		return ret;
> +	dev->iommu->attach_deferred = 0;
> +	trace_attach_device_to_domain(dev);
> +	return 0;
>   }
>   
>   /**
> @@ -2018,7 +2023,7 @@ EXPORT_SYMBOL_GPL(iommu_attach_device);
>   
>   int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
>   {
> -	if (iommu_is_attach_deferred(dev))
> +	if (dev->iommu && dev->iommu->attach_deferred)
>   		return __iommu_attach_device(domain, dev);
>   
>   	return 0;
> @@ -2027,9 +2032,6 @@ int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
>   static void __iommu_detach_device(struct iommu_domain *domain,
>   				  struct device *dev)
>   {
> -	if (iommu_is_attach_deferred(dev))
> -		return;
> -
>   	domain->ops->detach_dev(domain, dev);
>   	trace_detach_device_from_domain(dev);
>   }
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 1690c334e51631..ebac04a13fff68 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -413,6 +413,7 @@ struct dev_iommu {
>   	struct iommu_device		*iommu_dev;
>   	void				*priv;
>   	u32				max_pasids;
> +	u8				attach_deferred;
>   };
>   
>   int iommu_device_register(struct iommu_device *iommu,

Thanks for the patch! It seems that we also need to call
iommu_group_do_dma_first_attach() in the iommu_probe_device() path?

@@ -401,7 +425,7 @@ int iommu_probe_device(struct device *dev)
          * attach the default domain.
          */
         if (group->default_domain && !group->owner) {
-               ret = __iommu_attach_device(group->default_domain, dev);
+               ret = iommu_group_do_dma_first_attach(dev, 
group->default_domain);
                 if (ret) {
                         mutex_unlock(&group->mutex);
                         iommu_group_put(group);

By the way, I'd like to put above code in a separated patch of the next
version, can I add your signed-off-by?

--
Best regards,
baolu
