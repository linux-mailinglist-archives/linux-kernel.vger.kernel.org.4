Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2196B53D7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 23:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjCJWGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 17:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbjCJWFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:05:20 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7C50E07F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 14:04:25 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E55EAD7;
        Fri, 10 Mar 2023 14:05:08 -0800 (PST)
Received: from [10.57.90.67] (unknown [10.57.90.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA8AA3F5A1;
        Fri, 10 Mar 2023 14:04:23 -0800 (PST)
Message-ID: <7b248ba1-3967-5cd8-82e9-0268c706d320@arm.com>
Date:   Fri, 10 Mar 2023 22:04:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 1/6] ARM/dma-mapping: Add arm_iommu_release_device()
Content-Language: en-GB
To:     Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
References: <20230306025804.13912-1-baolu.lu@linux.intel.com>
 <20230306025804.13912-2-baolu.lu@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230306025804.13912-2-baolu.lu@linux.intel.com>
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

On 2023-03-06 02:57, Lu Baolu wrote:
> It is like arm_iommu_detach_device() except it handles the special case
> of being called under an iommu driver's release operation. In this case
> the driver must have already detached the device from any attached
> domain before calling this function.
> 
> Replace arm_iommu_detach_device() with arm_iommu_release_device() in the
> release path of the ipmmu-vmsa driver.
> 
> The bonus is that it also removes a obstacle of arm_iommu_detach_device()
> re-entering the iommu core during release_device. With this removed, the
> iommu core code could be simplified a lot.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   arch/arm/include/asm/dma-iommu.h |  1 +
>   arch/arm/mm/dma-mapping.c        | 25 +++++++++++++++++++++++++
>   drivers/iommu/ipmmu-vmsa.c       | 15 +++++++++++++--
>   3 files changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/asm/dma-iommu.h b/arch/arm/include/asm/dma-iommu.h
> index fe9ef6f79e9c..ea7198a17861 100644
> --- a/arch/arm/include/asm/dma-iommu.h
> +++ b/arch/arm/include/asm/dma-iommu.h
> @@ -31,6 +31,7 @@ void arm_iommu_release_mapping(struct dma_iommu_mapping *mapping);
>   int arm_iommu_attach_device(struct device *dev,
>   					struct dma_iommu_mapping *mapping);
>   void arm_iommu_detach_device(struct device *dev);
> +void arm_iommu_release_device(struct device *dev);
>   
>   #endif /* __KERNEL__ */
>   #endif
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 8bc01071474a..96fa27f4a164 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -1682,6 +1682,31 @@ int arm_iommu_attach_device(struct device *dev,
>   }
>   EXPORT_SYMBOL_GPL(arm_iommu_attach_device);
>   
> +/**
> + * arm_iommu_release_device
> + * @dev: valid struct device pointer
> + *
> + * This is like arm_iommu_detach_device() except it handles the special
> + * case of being called under an iommu driver's release operation. In this
> + * case the driver must have already detached the device from any attached
> + * domain before calling this function.
> + */
> +void arm_iommu_release_device(struct device *dev)
> +{
> +	struct dma_iommu_mapping *mapping;
> +
> +	mapping = to_dma_iommu_mapping(dev);
> +	if (!mapping) {
> +		dev_warn(dev, "Not attached\n");
> +		return;
> +	}
> +
> +	kref_put(&mapping->kref, release_iommu_mapping);
> +	to_dma_iommu_mapping(dev) = NULL;
> +	set_dma_ops(dev, NULL);
> +}
> +EXPORT_SYMBOL_GPL(arm_iommu_release_device);
> +
>   /**
>    * arm_iommu_detach_device
>    * @dev: valid struct device pointer
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index bdf1a4e5eae0..de9c74cf61a4 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -30,7 +30,7 @@
>   #define arm_iommu_create_mapping(...)	NULL
>   #define arm_iommu_attach_device(...)	-ENODEV
>   #define arm_iommu_release_mapping(...)	do {} while (0)
> -#define arm_iommu_detach_device(...)	do {} while (0)
> +#define arm_iommu_release_device(...)	do {} while (0)
>   #endif
>   
>   #define IPMMU_CTX_MAX		16U
> @@ -820,7 +820,18 @@ static void ipmmu_probe_finalize(struct device *dev)
>   
>   static void ipmmu_release_device(struct device *dev)
>   {
> -	arm_iommu_detach_device(dev);
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
> +	unsigned int i;
> +
> +	for (i = 0; i < fwspec->num_ids; ++i) {
> +		unsigned int utlb = fwspec->ids[i];
> +
> +		ipmmu_imuctr_write(mmu, utlb, 0);
> +		mmu->utlb_ctx[utlb] = IPMMU_CTX_INVALID;
> +	}
> +
> +	arm_iommu_release_device(dev);

Just call the existing arm_iommu_release_mapping(). Look at where the 
BUS_NOTIFY_REMOVED_DEVICE point is in device_del(); this device is not 
coming back. Zeroing out pointers and testing for a condition which 
cannot be true by construction is simply a waste of time and code.

Thanks,
Robin.

>   }
>   
>   static struct iommu_group *ipmmu_find_group(struct device *dev)
