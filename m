Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CE06B24DC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 14:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjCINEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 08:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjCINDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:03:52 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 99C5E66D3B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 05:03:48 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D493EC14;
        Thu,  9 Mar 2023 05:04:31 -0800 (PST)
Received: from [10.57.91.145] (unknown [10.57.91.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91B513F67D;
        Thu,  9 Mar 2023 05:03:46 -0800 (PST)
Message-ID: <bfa43614-c052-4bed-b87e-691141f41909@arm.com>
Date:   Thu, 9 Mar 2023 13:03:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 04/14] iommu/arm-smmu-v3: Add arm_smmu_hw_info
Content-Language: en-GB
To:     Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, will@kernel.org
Cc:     eric.auger@redhat.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com, jean-philippe@linaro.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <494e36cbb77d49e11427b308868dbc1b0e19fe18.1678348754.git.nicolinc@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <494e36cbb77d49e11427b308868dbc1b0e19fe18.1678348754.git.nicolinc@nvidia.com>
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
> This is used to forward the host IDR values to the user space, so the
> hypervisor and the guest VM can learn about the underlying hardware's
> capabilities.
> 
> Also, set the driver_type to IOMMU_HW_INFO_TYPE_ARM_SMMUV3 to pass the
> corresponding type sanity in the core.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 25 +++++++++++++++++++++
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 ++
>   include/uapi/linux/iommufd.h                | 14 ++++++++++++
>   3 files changed, 41 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index f2425b0f0cd6..c1aac695ae0d 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2005,6 +2005,29 @@ static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
>   	}
>   }
>   
> +static void *arm_smmu_hw_info(struct device *dev, u32 *length)
> +{
> +	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> +	struct iommu_hw_info_smmuv3 *info;
> +	void *base_idr;
> +	int i;
> +
> +	if (!master || !master->smmu)
> +		return ERR_PTR(-ENODEV);
> +
> +	info = kzalloc(sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return ERR_PTR(-ENOMEM);
> +
> +	base_idr = master->smmu->base + ARM_SMMU_IDR0;
> +	for (i = 0; i <= 5; i++)
> +		info->idr[i] = readl_relaxed(base_idr + 0x4 * i);

You need to take firmware overrides etc. into account here. In 
particular, features like BTM may need to be hidden to work around 
errata either in the system integration or the SMMU itself. It isn't 
reasonable to expect every VMM to be aware of every erratum and 
workaround, and there may even be workarounds where we need to go out of 
our way to prevent guests from trying to use certain features in order 
to maintain correctness at S2.

In general this should probably follow the same principle as KVM, where 
we only expose sanitised feature registers representing the 
functionality the host understands. Code written today is almost 
guaranteed to be running on hardware released in 2030, at least *somewhere*.

Thanks,
Robin.

> +
> +	*length = sizeof(*info);
> +
> +	return info;
> +}
> +
>   static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
>   {
>   	struct arm_smmu_domain *smmu_domain;
> @@ -2845,6 +2868,7 @@ static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
>   
>   static struct iommu_ops arm_smmu_ops = {
>   	.capable		= arm_smmu_capable,
> +	.hw_info		= arm_smmu_hw_info,
>   	.domain_alloc		= arm_smmu_domain_alloc,
>   	.probe_device		= arm_smmu_probe_device,
>   	.release_device		= arm_smmu_release_device,
> @@ -2857,6 +2881,7 @@ static struct iommu_ops arm_smmu_ops = {
>   	.page_response		= arm_smmu_page_response,
>   	.def_domain_type	= arm_smmu_def_domain_type,
>   	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
> +	.driver_type		= IOMMU_HW_INFO_TYPE_ARM_SMMUV3,
>   	.owner			= THIS_MODULE,
>   	.default_domain_ops = &(const struct iommu_domain_ops) {
>   		.attach_dev		= arm_smmu_attach_dev,
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 8d772ea8a583..ba2b4562f4b2 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -14,6 +14,8 @@
>   #include <linux/mmzone.h>
>   #include <linux/sizes.h>
>   
> +#include <uapi/linux/iommufd.h>
> +
>   /* MMIO registers */
>   #define ARM_SMMU_IDR0			0x0
>   #define IDR0_ST_LVL			GENMASK(28, 27)
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index 0d5551b1b2be..c7a37915b49c 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -519,6 +519,20 @@ struct iommu_hw_info_vtd {
>   	__aligned_u64 ecap_reg;
>   };
>   
> +/**
> + * struct iommu_hw_info_smmuv3 - ARM SMMUv3 device info
> + *
> + * @flags: Must be set to 0
> + * @__reserved: Must be 0
> + * @idr: Implemented features for the SMMU Non-secure programming interface.
> + *       Please refer to the chapters from 6.3.1 to 6.3.6 in the SMMUv3 Spec.
> + */
> +struct iommu_hw_info_smmuv3 {
> +	__u32 flags;
> +	__u32 __reserved;
> +	__u32 idr[6];
> +};
> +
>   /**
>    * struct iommu_hw_info - ioctl(IOMMU_DEVICE_GET_HW_INFO)
>    * @size: sizeof(struct iommu_hw_info)
