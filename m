Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289746B2481
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 13:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjCIMvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 07:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCIMv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 07:51:29 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EFADEDCA4F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 04:51:27 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8836AD7;
        Thu,  9 Mar 2023 04:52:10 -0800 (PST)
Received: from [10.57.91.145] (unknown [10.57.91.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FA8D3F67D;
        Thu,  9 Mar 2023 04:51:25 -0800 (PST)
Message-ID: <2118a147-ac95-d846-ad6f-85d7cebca46a@arm.com>
Date:   Thu, 9 Mar 2023 12:51:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 01/14] iommu: Add iommu_get_unmanaged_domain helper
Content-Language: en-GB
To:     Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, will@kernel.org
Cc:     eric.auger@redhat.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com, jean-philippe@linaro.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <9b1077601cace998533129327f5e7ad946752d29.1678348754.git.nicolinc@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <9b1077601cace998533129327f5e7ad946752d29.1678348754.git.nicolinc@nvidia.com>
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

On 2023-03-09 10:53, Nicolin Chen wrote:
> The nature of ITS virtualization on ARM is done via hypercalls, so kernel
> handles all IOVA mappings for the MSI doorbell in iommu_dma_prepare_msi()
> and iommu_dma_compose_msi_msg(). The current virtualization solution with
> a 2-stage nested translation setup is to do 1:1 IOVA mappings at stage-1
> guest-level IO page table via a RMR region in guest-level IORT, aligning
> with an IOVA region that's predefined and mapped in the host kernel:
> 
>    [stage-2 host level]
>    #define MSI_IOVA_BASE		0x8000000
>    #define MSI_IOVA_LENGTH	0x100000
>    ...
>    iommu_get_msi_cookie():
> 	cookie->msi_iova = MSI_IOVA_BASE;
>    ...
>    iommu_dma_prepare_msi(its_pa):
> 	domain = iommu_get_domain_for_dev(dev);
> 	iommu_dma_get_msi_page(its_pa, domain):
> 		cookie = domain->iova_cookie;
> 		iova = iommu_dma_alloc_iova():
> 			return cookie->msi_iova - size;
> 		iommu_map(iova, its_pa, ...);
> 
>    [stage-1 guest level]
>    // Define in IORT a RMR [MSI_IOVA_BASE, MSI_IOVA_LENGTH]
>    ...
>    iommu_create_device_direct_mappings():
> 	iommu_map(iova=MSI_IOVA_BASE, pa=MSI_IOVA_BASE, len=MSI_IOVA_LENGTH);
> 
> This solution calling iommu_get_domain_for_dev() needs the device to get
> attached to a host-level iommu_domain that has the msi_cookie.
> 
> On the other hand, IOMMUFD designs two iommu_domain objects to represent
> the two stages: a stage-1 domain (IOMMU_DOMAIN_NESTED type) and a stage-2
> domain (IOMMU_DOMAIN_UNMANAGED type). In this design, the device will be
> attached to the stage-1 domain representing a guest-level IO page table,
> or a Context Descriptor Table in SMMU's term.
> 
> This is obviously a mismatch, as the iommu_get_domain_for_dev() does not
> return the correct domain pointer in iommu_dma_prepare_msi().
> 
> Add an iommu_get_unmanaged_domain helper to allow drivers to return the
> correct IOMMU_DOMAIN_UNMANAGED iommu_domain having the IOVA mappings for
> the msi_cookie. Keep it in the iommu-priv header for internal use only.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/dma-iommu.c  |  5 +++--
>   drivers/iommu/iommu-priv.h | 15 +++++++++++++++
>   include/linux/iommu.h      |  2 ++
>   3 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 99b2646cb5c7..6b0409d0ff85 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -31,6 +31,7 @@
>   #include <linux/vmalloc.h>
>   
>   #include "dma-iommu.h"
> +#include "iommu-priv.h"
>   
>   struct iommu_dma_msi_page {
>   	struct list_head	list;
> @@ -1652,7 +1653,7 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
>   int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
>   {
>   	struct device *dev = msi_desc_to_dev(desc);
> -	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> +	struct iommu_domain *domain = iommu_get_unmanaged_domain(dev);

This still doesn't make sense - most of the time this will be expected 
to return the default DMA/identity domain if that's what the device is 
currently using. We can't know whether the current domain is managed or 
not until we look at it.

Just like every other caller of iommu_get_domain_for_dev(), what we want 
here is the current kernel-owned domain that we can inspect and maybe do 
standard IOMMU API things with. Why can't iommu_get_domain_for_dev() 
simply maintain that established usage model and return the kernel-owned 
s2_domain from a nested domain automatically? No IOMMU API user expects 
or needs it to return anything else (and IOMMUFD should certainly not be 
losing track of a nested domain within its own higher-level abstractions 
and needing to fall back on iommu_get_domain_for_dev()), so I really 
don't see a valid reason to overcomplicate things.

Please note I stress "valid" since I'm not buying arbitrarily made-up 
conceptual purity arguments. A nested domain cannot be the "one true 
domain" that is an opaque combination of S1+S2; the IOMMU API view has 
to be more like the device is attached to both the nested domain and the 
parent stage 2 domain somewhat in parallel. Even when nesting is active, 
the S2 domain still exists as a domain in its own right, and still needs 
to be visible and operated on as such, for instance if memory is 
hotplugged in or out of the VM.

TBH I'd also move the s2_domain pointer into the iommu_domain itself, 
since it's going to be a common feature for all nesting implementations, 
thus there seems little need to indirect lookups through the drivers at all.

Thanks,
Robin.

>   	struct iommu_dma_msi_page *msi_page;
>   	static DEFINE_MUTEX(msi_prepare_lock); /* see below */
>   
> @@ -1685,7 +1686,7 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
>   void iommu_dma_compose_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
>   {
>   	struct device *dev = msi_desc_to_dev(desc);
> -	const struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> +	const struct iommu_domain *domain = iommu_get_unmanaged_domain(dev);
>   	const struct iommu_dma_msi_page *msi_page;
>   
>   	msi_page = msi_desc_get_iommu_cookie(desc);
> diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
> index a6e694f59f64..da8044da9ad8 100644
> --- a/drivers/iommu/iommu-priv.h
> +++ b/drivers/iommu/iommu-priv.h
> @@ -15,6 +15,21 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
>   	return dev->iommu->iommu_dev->ops;
>   }
>   
> +static inline struct iommu_domain *iommu_get_unmanaged_domain(struct device *dev)
> +{
> +	const struct iommu_ops *ops;
> +
> +	if (!dev->iommu || !dev->iommu->iommu_dev)
> +		goto attached_domain;
> +
> +	ops = dev_iommu_ops(dev);
> +	if (ops->get_unmanaged_domain)
> +		return ops->get_unmanaged_domain(dev);
> +
> +attached_domain:
> +	return iommu_get_domain_for_dev(dev);
> +}
> +
>   int iommu_group_replace_domain(struct iommu_group *group,
>   			       struct iommu_domain *new_domain);
>   
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 080278c8154d..76c65cc4fc15 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -275,6 +275,8 @@ struct iommu_ops {
>   						  struct iommu_domain *parent,
>   						  const void *user_data);
>   
> +	struct iommu_domain *(*get_unmanaged_domain)(struct device *dev);
> +
>   	struct iommu_device *(*probe_device)(struct device *dev);
>   	void (*release_device)(struct device *dev);
>   	void (*probe_finalize)(struct device *dev);
