Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6D85E5886
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 04:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiIVCWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 22:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiIVCWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 22:22:52 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7ED870E5B;
        Wed, 21 Sep 2022 19:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663813371; x=1695349371;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WCVx5BaOJGdGW1cZNmlkP0ri8jdLdsjoqTq/enwzcKk=;
  b=X98DERy/bnxiXBB4NoI7/hq48Q8T4RBoFd1IvCc7FwsDEM3jGwF/BVZH
   yneFFCJ2M9MVRi4gjMDwt0lYqW0s0uvgB+pKBSCG7CirCM5bylfZk8tm6
   v2UAGCv3gft3KDskABQlmlNCSwGEUyPDHCd3aG4Gq2Z4/W3hyncnnIvHA
   DKV77aoou9Iqu1OcZVOgcqMjxfPaZiB6EOQFuMcSBb7w7X5Erdtwfhg2d
   NL5GQ4iC4UweUK6ZBTHblEkft8KRoSA2jin97hP526QKCZtq6CTKGRwZu
   1BiOhukryPLcH47hmsEnCvypckVoqtxqp5ddf0DCnHrJ704zngcgr09pz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="364153779"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="364153779"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 19:22:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="794910676"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga005.jf.intel.com with ESMTP; 21 Sep 2022 19:22:42 -0700
Message-ID: <055d057e-0074-9164-8958-c892c53361b8@linux.intel.com>
Date:   Thu, 22 Sep 2022 10:16:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc:     baolu.lu@linux.intel.com, jgg@nvidia.com, kevin.tian@intel.com,
        konrad.dybcio@somainline.org, yong.wu@mediatek.com,
        thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
        tglx@linutronix.de, shameerali.kolothum.thodi@huawei.com,
        christophe.jaillet@wanadoo.fr, thunder.leizhen@huawei.com,
        quic_saipraka@quicinc.com, jon@solid-run.com,
        yangyingliang@huawei.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-tegra@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v4 5/6] iommu: Use EINVAL for incompatible device/domain
 in ->attach_dev
Content-Language: en-US
To:     Nicolin Chen <nicolinc@nvidia.com>, joro@8bytes.org,
        suravee.suthikulpanit@amd.com, will@kernel.org,
        robin.murphy@arm.com, robdclark@gmail.com, dwmw2@infradead.org,
        agross@kernel.org, bjorn.andersson@linaro.org,
        matthias.bgg@gmail.com, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        jean-philippe@linaro.org, sricharan@codeaurora.org
References: <cover.1663744983.git.nicolinc@nvidia.com>
 <4469b88b4460fc230b8c394f806c134e627aa5bd.1663744983.git.nicolinc@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <4469b88b4460fc230b8c394f806c134e627aa5bd.1663744983.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/22 4:23 PM, Nicolin Chen wrote:
> Following the new rules in include/linux/iommu.h kdocs, update all drivers
> ->attach_dev callback functions to return EINVAL in the failure paths that
> are related to domain incompatibility.
> 
> Also, drop adjacent error prints to prevent a kernel log spam.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 11 +----------
>   drivers/iommu/arm/arm-smmu/arm-smmu.c       |  3 ---
>   drivers/iommu/arm/arm-smmu/qcom_iommu.c     |  7 +------
>   drivers/iommu/intel/iommu.c                 | 10 +++-------
>   drivers/iommu/ipmmu-vmsa.c                  |  2 --
>   drivers/iommu/omap-iommu.c                  |  2 +-
>   drivers/iommu/sprd-iommu.c                  |  4 +---
>   drivers/iommu/tegra-gart.c                  |  2 +-
>   drivers/iommu/virtio-iommu.c                |  3 +--
>   9 files changed, 9 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index d32b02336411..f96f8aad8280 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2429,23 +2429,14 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>   			goto out_unlock;
>   		}
>   	} else if (smmu_domain->smmu != smmu) {
> -		dev_err(dev,
> -			"cannot attach to SMMU %s (upstream of %s)\n",
> -			dev_name(smmu_domain->smmu->dev),
> -			dev_name(smmu->dev));
> -		ret = -ENXIO;
> +		ret = -EINVAL;
>   		goto out_unlock;
>   	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
>   		   master->ssid_bits != smmu_domain->s1_cfg.s1cdmax) {
> -		dev_err(dev,
> -			"cannot attach to incompatible domain (%u SSID bits != %u)\n",
> -			smmu_domain->s1_cfg.s1cdmax, master->ssid_bits);
>   		ret = -EINVAL;
>   		goto out_unlock;
>   	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
>   		   smmu_domain->stall_enabled != master->stall_enabled) {
> -		dev_err(dev, "cannot attach to stall-%s domain\n",
> -			smmu_domain->stall_enabled ? "enabled" : "disabled");
>   		ret = -EINVAL;
>   		goto out_unlock;
>   	}
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index dfa82df00342..dbd12da31707 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -1167,9 +1167,6 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>   	 * different SMMUs.
>   	 */
>   	if (smmu_domain->smmu != smmu) {
> -		dev_err(dev,
> -			"cannot attach to SMMU %s whilst already attached to domain on SMMU %s\n",
> -			dev_name(smmu_domain->smmu->dev), dev_name(smmu->dev));
>   		ret = -EINVAL;
>   		goto rpm_put;
>   	}
> diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> index 17235116d3bb..37c5ddc212c1 100644
> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> @@ -381,13 +381,8 @@ static int qcom_iommu_attach_dev(struct iommu_domain *domain, struct device *dev
>   	 * Sanity check the domain. We don't support domains across
>   	 * different IOMMUs.
>   	 */
> -	if (qcom_domain->iommu != qcom_iommu) {
> -		dev_err(dev, "cannot attach to IOMMU %s while already "
> -			"attached to domain on IOMMU %s\n",
> -			dev_name(qcom_domain->iommu->dev),
> -			dev_name(qcom_iommu->dev));
> +	if (qcom_domain->iommu != qcom_iommu)
>   		return -EINVAL;
> -	}
>   
>   	return 0;
>   }
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 1f2cd43cf9bc..51ef42b1bd4e 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4158,19 +4158,15 @@ static int prepare_domain_attach_device(struct iommu_domain *domain,
>   		return -ENODEV;
>   
>   	if (dmar_domain->force_snooping && !ecap_sc_support(iommu->ecap))
> -		return -EOPNOTSUPP;
> +		return -EINVAL;
>   
>   	/* check if this iommu agaw is sufficient for max mapped address */
>   	addr_width = agaw_to_width(iommu->agaw);
>   	if (addr_width > cap_mgaw(iommu->cap))
>   		addr_width = cap_mgaw(iommu->cap);
>   
> -	if (dmar_domain->max_addr > (1LL << addr_width)) {
> -		dev_err(dev, "%s: iommu width (%d) is not "
> -		        "sufficient for the mapped address (%llx)\n",
> -		        __func__, addr_width, dmar_domain->max_addr);
> -		return -EFAULT;
> -	}
> +	if (dmar_domain->max_addr > (1LL << addr_width))
> +		return -EINVAL;
>   	dmar_domain->gaw = addr_width;
>   
>   	/*
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 1d42084d0276..f5217a4cb9b3 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -628,8 +628,6 @@ static int ipmmu_attach_device(struct iommu_domain *io_domain,
>   		 * Something is wrong, we can't attach two devices using
>   		 * different IOMMUs to the same domain.
>   		 */
> -		dev_err(dev, "Can't attach IPMMU %s to domain on IPMMU %s\n",
> -			dev_name(mmu->dev), dev_name(domain->mmu->dev));
>   		ret = -EINVAL;
>   	} else
>   		dev_info(dev, "Reusing IPMMU context %u\n", domain->context_id);
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index 447e40d55918..be12f49140c7 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -1472,7 +1472,7 @@ omap_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
>   	/* only a single client device can be attached to a domain */
>   	if (omap_domain->dev) {
>   		dev_err(dev, "iommu domain is already attached\n");
> -		ret = -EBUSY;
> +		ret = -EINVAL;
>   		goto out;
>   	}
>   
> diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
> index 511959c8a14d..945576039c9e 100644
> --- a/drivers/iommu/sprd-iommu.c
> +++ b/drivers/iommu/sprd-iommu.c
> @@ -237,10 +237,8 @@ static int sprd_iommu_attach_device(struct iommu_domain *domain,
>   	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
>   	size_t pgt_size = sprd_iommu_pgt_size(domain);
>   
> -	if (dom->sdev) {
> -		pr_err("There's already a device attached to this domain.\n");
> +	if (dom->sdev)
>   		return -EINVAL;
> -	}
>   
>   	dom->pgt_va = dma_alloc_coherent(sdev->dev, pgt_size, &dom->pgt_pa, GFP_KERNEL);
>   	if (!dom->pgt_va)
> diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
> index e5ca3cf1a949..ed53279d1106 100644
> --- a/drivers/iommu/tegra-gart.c
> +++ b/drivers/iommu/tegra-gart.c
> @@ -112,7 +112,7 @@ static int gart_iommu_attach_dev(struct iommu_domain *domain,
>   	spin_lock(&gart->dom_lock);
>   
>   	if (gart->active_domain && gart->active_domain != domain) {
> -		ret = -EBUSY;
> +		ret = -EINVAL;
>   	} else if (dev_iommu_priv_get(dev) != domain) {
>   		dev_iommu_priv_set(dev, domain);
>   		gart->active_domain = domain;
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 4c652773fd6c..87128266b6e3 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -733,8 +733,7 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
>   		 */
>   		ret = viommu_domain_finalise(vdev, domain);
>   	} else if (vdomain->viommu != vdev->viommu) {
> -		dev_err(dev, "cannot attach to foreign vIOMMU\n");
> -		ret = -EXDEV;
> +		ret = -EINVAL;
>   	}
>   	mutex_unlock(&vdomain->mutex);
>   

For iommu/vt-d changes:

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
