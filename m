Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326E069B872
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 08:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjBRHHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 02:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjBRHHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 02:07:48 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EC32ED59
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 23:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676704066; x=1708240066;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vdv4kLuHF123wAtdJgGSHLW0CZwF0d95pX5SQj9BcYc=;
  b=ak5D0URuwnImNy0Qrungz6tdOT5M6I1aKNZ87eqXW2QtFp5jtQj13Hz7
   OH2jcKfwNrb8gpj2Hy+3v7cLGURe1zEENJbLVtOZCHuD9R97jb1wNxDZy
   D4sjRLPWjS4mpl4D7uUB24giUfW/hj7QtRCTUDuiBbZzyuJDbgsp7govd
   iSuuAP3kxGZ/w60dHtnbgYFSE+8Y/bSCtzEQp10YksITwGJY2qTZrcAAK
   jeaLbMN7ArHxJ/UqSKIx+lQXi+1FLC69tPHaJf33jKYoMhQFGSXB9M8EI
   ZGjo24oXmXc0Dt0uO69WCY/9NlZpvY+KfKffX/fSTGHerz1ixY7UumCdS
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="329868577"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="329868577"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 23:07:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="670802956"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="670802956"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga002.jf.intel.com with ESMTP; 17 Feb 2023 23:07:42 -0800
Message-ID: <6be2aa16-817a-fb85-5371-08e656a29217@linux.intel.com>
Date:   Sat, 18 Feb 2023 14:59:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] ARM/dma-mapping: Remove iommu_detach_device()
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20230217094736.159005-1-baolu.lu@linux.intel.com>
 <20230217094736.159005-2-baolu.lu@linux.intel.com>
 <Y++fqH7Eeq3Njoa9@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y++fqH7Eeq3Njoa9@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/23 11:39 PM, Jason Gunthorpe wrote:
> On Fri, Feb 17, 2023 at 05:47:31PM +0800, Lu Baolu wrote:
>> iommu_detach_device() attaches the default domain to the device, or if
>> default domain is not supported by the IOMMU driver, it calls its
>> set_platform_dma_ops callback. If the default domain is supported or
>> the IOMMU driver is not iommu-dma aware, iommu_detach_device() is
>> actually a noop.
>>
>> The 64-bit ARM drivers always support default domain and iommu-dma is
>> even not enabled for 32-bit ARM. This turns out that iommu_detach_device()
>> is always a noop in arm_iommu_detach_device(). Remove it to avoid dead
>> code.
> 
> This isn't entirely right..
> 
> The purpose of the iommu_detach_device here should be to make the
> iommu driver stop using the domain that it is about to free. It cannot
> be a NOP or it is a UAF.
> 
> I think things have become confused.
> 
> What we decided is that NULL domain is supposed to mean the DMA
> translation is controlled by the platform, the concept is modeled
> after S390's private iommu implementation. This means the current
> IOMMU translation is invisibly set to something that matches the
> device's dma_ops.

Yes. This matches what I understood.

> 
> arm_iommu doesn't work that way, it allocates and assigns domains so
> when the platform DMA ops are in control the group->domain is not NULL

This is what the iommu core assumes, right? Any iommu group should
always has a domain attached, default domain, blocking domain or driver-
owned unmanaged domain. The iommu core just switches between different
domains.

> - which is the opposite of S390's design. Further when arm_iommu asks
> for a NULL domain it doesn't mean "put it back to platform DMA ops" it
> really means "park the IOMMU it is not being used anymore"

This is what identity domain and blocking domains were designed to do,
right?

If my understanding is right, ARM presumably could implement the
identity default domain and blocking domain. With that implemented,
iommu_attach/detac_device() could be removed from drivers and everything
then could go through the iommu core.

Best regards,
baolu

> 
> So.. Blah - we had two meanings for group->domain = NULL and didn't
> quite get it right.
> 
> IMHO the way to make sense of this is to always have a domain attached
> and remove group->domain = NULL and set_platform_dma entirely. If the
> driver doesn't want to use dma_iommu then it should provide its own
> iommu_domain that it wants attached whenever the iommu API is not
> being used.
> 
> You can see this in the exynos fix because what it is doing is calling
> __sysmmu_disable() from set_platform_dma which is either IDENTITY or
> BLOCKING IOMMU behavior.
> 
> Then we can document what the idle domain is supposed to be doing in
> each of the drivers, but the core code is logical and doesn't have a
> confusing overloaded domain = NULL case.
> 
> Something like this as a starting idea of how the drivers could look.
> 
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index b0cde22119875e..143d1abcae2641 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -948,6 +948,20 @@ static void exynos_iommu_detach_device(struct iommu_domain *iommu_domain,
>   		&pagetable);
>   }
>   
> +static struct iommu_domain_ops exynos_private_ops = {
> +	.attach_dev_nofail = &exynos_iommu_detach_device,
> +};
> +
> +static struct iommu_domain exynos_private_domain = {
> +	/*
> +	 * This is private because nobody knew what __sysmmu_disable() does.
> +	 * When someone figures that out this should be made blocking or
> +	 * identity
> +	 */
> +	.type = IOMMU_DOMAN_PRIVATE,
> +	.ops = &exynos_private_ops,
> +};
> +
>   static int exynos_iommu_attach_device(struct iommu_domain *iommu_domain,
>   				   struct device *dev)
>   {
> @@ -1400,11 +1414,11 @@ static const struct iommu_ops exynos_iommu_ops = {
>   	.device_group = generic_device_group,
>   	.probe_device = exynos_iommu_probe_device,
>   	.release_device = exynos_iommu_release_device,
> +	.idle_domain = IS_ENABLED(CONFIG_ARM) ? &exynos_private_domain : NULL,
>   	.pgsize_bitmap = SECT_SIZE | LPAGE_SIZE | SPAGE_SIZE,
>   	.of_xlate = exynos_iommu_of_xlate,
>   	.default_domain_ops = &(const struct iommu_domain_ops) {
>   		.attach_dev	= exynos_iommu_attach_device,
> -		.detach_dev	= exynos_iommu_detach_device,
>   		.map		= exynos_iommu_map,
>   		.unmap		= exynos_iommu_unmap,
>   		.iova_to_phys	= exynos_iommu_iova_to_phys,
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index de91dd88705bd3..b71a1667f43bd5 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -387,14 +387,13 @@ int iommu_probe_device(struct device *dev)
>   		goto err_release;
>   	}
>   
> -	/*
> -	 * Try to allocate a default domain - needs support from the
> -	 * IOMMU driver. There are still some drivers which don't
> -	 * support default domains, so the return value is not yet
> -	 * checked.
> -	 */
>   	mutex_lock(&group->mutex);
> -	iommu_alloc_default_domain(group, dev);
> +	ret = iommu_alloc_default_domain(group, dev);
> +	if (ret) {
> +		mutex_unlock(&group->mutex);
> +		iommu_group_put(group);
> +		goto err_release;
> +	}
>   
>   	/*
>   	 * If device joined an existing group which has been claimed, don't
> @@ -1645,7 +1644,15 @@ static int iommu_alloc_default_domain(struct iommu_group *group,
>   
>   	type = iommu_get_def_domain_type(dev) ? : iommu_def_domain_type;
>   
> -	return iommu_group_alloc_default_domain(dev->bus, group, type);
> +	if (!iommu_group_alloc_default_domain(dev->bus, group, type))
> +		return 0;
> +
> +	/*
> +	 * Driver must support default domains or provide an legacy idle domain
> +	 */
> +	if (WARN_ON(!dev_iommu_ops(dev)->idle_domain))
> +		return -EINVAL;
> +	return 0;
>   }
>   
>   /**
> @@ -2172,17 +2179,22 @@ static int __iommu_group_set_domain(struct iommu_group *group,
>   		return 0;
>   
>   	/*
> -	 * New drivers should support default domains and so the detach_dev() op
> -	 * will never be called. Otherwise the NULL domain represents some
> -	 * platform specific behavior.
> +	 * New drivers should support default domains, otherwise the driver
> +	 * must provide a domain to be attached when the iommu subsystem
> +	 * is not using the device. The purpose of this domain depends
> +	 * on how the iommu driver is operating the dma_ops.
>   	 */
>   	if (!new_domain) {
> -		if (WARN_ON(!group->domain->ops->detach_dev))
> +		struct group_device *grp_dev;
> +		const struct iommu_ops *ops;
> +
> +		grp_dev = list_first_entry(&group->devices, struct group_device,
> +					   list);
> +		ops = dev_iommu_ops(grp_dev->dev);
> +
> +		if (WARN_ON(!ops->idle_domain))
>   			return -EINVAL;
> -		__iommu_group_for_each_dev(group, group->domain,
> -					   iommu_group_do_detach_device);
> -		group->domain = NULL;
> -		return 0;
> +		new_domain = ops->idle_domain;
>   	}
>   
>   	/*
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 46e1347bfa2286..a17069368d70d9 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -91,6 +91,7 @@ struct iommu_domain_geometry {
>   				 __IOMMU_DOMAIN_DMA_API |	\
>   				 __IOMMU_DOMAIN_DMA_FQ)
>   #define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SVA)
> +#define IOMMU_DOMAN_PRIVATE	(1 << 5)
>   
>   struct iommu_domain {
>   	unsigned type;
> @@ -272,7 +273,18 @@ struct iommu_ops {
>   			     struct iommu_fault_event *evt,
>   			     struct iommu_page_response *msg);
>   
> +	/*
> +	 * driver wants to use dma_ops provided by dma-iommu.c, return
> +	 * the recommended initial IDENTITY/DMA domain.
> +	 */
>   	int (*def_domain_type)(struct device *dev);
> +
> +	/*
> +	 * Driver is not using dma-iommu.c, when the iommu core is not
> +	 * using the device it will attach it to this domain.
> +	 */
> +	struct iommu_domain *idle_domain;
> +
>   	void (*remove_dev_pasid)(struct device *dev, ioasid_t pasid);
>   
>   	const struct iommu_domain_ops *default_domain_ops;
> @@ -315,6 +327,7 @@ struct iommu_ops {
>    * @free: Release the domain after use.
>    */
>   struct iommu_domain_ops {
> +	void (*attach_dev_nofail)(struct iommu_domain *domain, struct device *dev);
>   	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
>   	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
>   	int (*set_dev_pasid)(struct iommu_domain *domain, struct device *dev,
