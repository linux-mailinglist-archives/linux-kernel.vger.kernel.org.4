Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290BA5B68E0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 09:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbiIMHqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 03:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiIMHqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 03:46:18 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76262228C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 00:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663055177; x=1694591177;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5YI+JLZRgLoXDuyL7o1YQrDHovYKcc0104J2ZeSfHc0=;
  b=faFjGNfri1Emh1W+R3muom1zHLiq0DtNkNms3HnJg8l0QKDH/w0SBqVI
   H2c3acof/GWZV6KYh6VSHJKVcomnX44Nmf9j2ZhB3x5NWuHAGtarilabM
   yM2aNVD6SVZUdU08PSpwNxncVgd/ovAEAPEIgzYpH0h9wSQUDcgFXk2pl
   nsYFpWP17K0syqKf9e7Fa+m4Gl+RsVRgWY/0tFuLhziDwNGl5q6hoa+T+
   XdWkWk1uNt//LlBOJT7S8H9VKRggdOOWn1BsbXxBbcqOJpjG6hFWhyWL7
   gsYJo/hEnzsokTY+/DGorXVlJoDtqVwLMu1ERbzb+B4eOrLQWxe6hoF8P
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="362020169"
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="362020169"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 00:46:17 -0700
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="593835521"
Received: from zhaohaif-mobl1.ccr.corp.intel.com (HELO [10.254.209.86]) ([10.254.209.86])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 00:46:15 -0700
Message-ID: <046916aa-980c-c40d-1163-6ab839248201@linux.intel.com>
Date:   Tue, 13 Sep 2022 15:46:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/1] iommu/vt-d: Enable PASID during iommu device probe
To:     Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org
References: <20220912024826.1684913-1-baolu.lu@linux.intel.com>
From:   Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20220912024826.1684913-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baolu,

在 2022/9/12 10:48, Lu Baolu 写道:
> Previously PASID supports on both IOMMU and PCI devices are enabled in the
> iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) path. It's functionally
> correct as the SVA is the only feature that requires PASID setup. However,
> looking ahead, we will add more features that need to enable pasid (for
> example, kernel DMA with PASID, SIOV, VM guest SVA, etc.). It makes more
> sense to enable PASID during iommu probing device.
>
> This enables PASID during iommu probing device and deprecates the
> intel_iommu_enable_pasid() helper. This is safe because the IOMMU hardware
> will block any PCI TLP with a PASID prefix if there is no IOMMU domain
> attached to the PASID of the device.

What the error path would be if this code runs on some old platforms don't

support PASID, would you print out "this platform doesn't suppor PASID" and

give users an interface function to query if the PASID cap of iommu is 
enabled

and if not why ?


Thanks,

Ethan

> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.h |  1 -
>   drivers/iommu/intel/iommu.c | 74 +++++++------------------------------
>   drivers/iommu/intel/Kconfig |  4 +-
>   3 files changed, 16 insertions(+), 63 deletions(-)
>
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index fae45bbb0c7f..ce5f343ca864 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -737,7 +737,6 @@ extern int dmar_ir_support(void);
>   void *alloc_pgtable_page(int node);
>   void free_pgtable_page(void *vaddr);
>   void iommu_flush_write_buffer(struct intel_iommu *iommu);
> -int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev);
>   struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devfn);
>   
>   #ifdef CONFIG_INTEL_IOMMU_SVM
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 7cca030a508e..69357c7c8c39 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -231,6 +231,11 @@ static inline void context_set_domain_id(struct context_entry *context,
>   	context->hi |= (value & ((1 << 16) - 1)) << 8;
>   }
>   
> +static inline void context_set_pasid(struct context_entry *context)
> +{
> +	context->lo |= CONTEXT_PASIDE;
> +}
> +
>   static inline int context_domain_id(struct context_entry *c)
>   {
>   	return((c->hi >> 8) & 0xffff);
> @@ -1341,20 +1346,17 @@ static void __iommu_flush_iotlb(struct intel_iommu *iommu, u16 did,
>   }
>   
>   static struct device_domain_info *
> -iommu_support_dev_iotlb(struct dmar_domain *domain, struct intel_iommu *iommu,
> -			u8 bus, u8 devfn)
> +domain_lookup_dev_info(struct dmar_domain *domain,
> +		       struct intel_iommu *iommu, u8 bus, u8 devfn)
>   {
>   	struct device_domain_info *info;
>   
> -	if (!iommu->qi)
> -		return NULL;
> -
>   	spin_lock(&domain->lock);
>   	list_for_each_entry(info, &domain->devices, link) {
>   		if (info->iommu == iommu && info->bus == bus &&
>   		    info->devfn == devfn) {
>   			spin_unlock(&domain->lock);
> -			return info->ats_supported ? info : NULL;
> +			return info;
>   		}
>   	}
>   	spin_unlock(&domain->lock);
> @@ -1401,7 +1403,6 @@ static void iommu_enable_dev_iotlb(struct device_domain_info *info)
>   		info->pfsid = pci_dev_id(pf_pdev);
>   	}
>   
> -#ifdef CONFIG_INTEL_IOMMU_SVM
>   	/* The PCIe spec, in its wisdom, declares that the behaviour of
>   	   the device if you enable PASID support after ATS support is
>   	   undefined. So always enable PASID support on devices which
> @@ -1414,7 +1415,7 @@ static void iommu_enable_dev_iotlb(struct device_domain_info *info)
>   	    (info->pasid_enabled ? pci_prg_resp_pasid_required(pdev) : 1)  &&
>   	    !pci_reset_pri(pdev) && !pci_enable_pri(pdev, PRQ_DEPTH))
>   		info->pri_enabled = 1;
> -#endif
> +
>   	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
>   	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
>   		info->ats_enabled = 1;
> @@ -1437,16 +1438,16 @@ static void iommu_disable_dev_iotlb(struct device_domain_info *info)
>   		info->ats_enabled = 0;
>   		domain_update_iotlb(info->domain);
>   	}
> -#ifdef CONFIG_INTEL_IOMMU_SVM
> +
>   	if (info->pri_enabled) {
>   		pci_disable_pri(pdev);
>   		info->pri_enabled = 0;
>   	}
> +
>   	if (info->pasid_enabled) {
>   		pci_disable_pasid(pdev);
>   		info->pasid_enabled = 0;
>   	}
> -#endif
>   }
>   
>   static void __iommu_flush_dev_iotlb(struct device_domain_info *info,
> @@ -1890,7 +1891,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
>   				      u8 bus, u8 devfn)
>   {
>   	struct device_domain_info *info =
> -			iommu_support_dev_iotlb(domain, iommu, bus, devfn);
> +			domain_lookup_dev_info(domain, iommu, bus, devfn);
>   	u16 did = domain_id_iommu(domain, iommu);
>   	int translation = CONTEXT_TT_MULTI_LEVEL;
>   	struct context_entry *context;
> @@ -1961,6 +1962,8 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
>   			context_set_sm_dte(context);
>   		if (info && info->pri_supported)
>   			context_set_sm_pre(context);
> +		if (info && info->pasid_supported)
> +			context_set_pasid(context);
>   	} else {
>   		struct dma_pte *pgd = domain->pgd;
>   		int agaw;
> @@ -4566,52 +4569,6 @@ static void intel_iommu_get_resv_regions(struct device *device,
>   	list_add_tail(&reg->list, head);
>   }
>   
> -int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev)
> -{
> -	struct device_domain_info *info = dev_iommu_priv_get(dev);
> -	struct context_entry *context;
> -	struct dmar_domain *domain;
> -	u64 ctx_lo;
> -	int ret;
> -
> -	domain = info->domain;
> -	if (!domain)
> -		return -EINVAL;
> -
> -	spin_lock(&iommu->lock);
> -	ret = -EINVAL;
> -	if (!info->pasid_supported)
> -		goto out;
> -
> -	context = iommu_context_addr(iommu, info->bus, info->devfn, 0);
> -	if (WARN_ON(!context))
> -		goto out;
> -
> -	ctx_lo = context[0].lo;
> -
> -	if (!(ctx_lo & CONTEXT_PASIDE)) {
> -		ctx_lo |= CONTEXT_PASIDE;
> -		context[0].lo = ctx_lo;
> -		wmb();
> -		iommu->flush.flush_context(iommu,
> -					   domain_id_iommu(domain, iommu),
> -					   PCI_DEVID(info->bus, info->devfn),
> -					   DMA_CCMD_MASK_NOBIT,
> -					   DMA_CCMD_DEVICE_INVL);
> -	}
> -
> -	/* Enable PASID support in the device, if it wasn't already */
> -	if (!info->pasid_enabled)
> -		iommu_enable_dev_iotlb(info);
> -
> -	ret = 0;
> -
> - out:
> -	spin_unlock(&iommu->lock);
> -
> -	return ret;
> -}
> -
>   static struct iommu_group *intel_iommu_device_group(struct device *dev)
>   {
>   	if (dev_is_pci(dev))
> @@ -4635,9 +4592,6 @@ static int intel_iommu_enable_sva(struct device *dev)
>   	if (!(iommu->flags & VTD_FLAG_SVM_CAPABLE))
>   		return -ENODEV;
>   
> -	if (intel_iommu_enable_pasid(iommu, dev))
> -		return -ENODEV;
> -
>   	if (!info->pasid_enabled || !info->pri_enabled || !info->ats_enabled)
>   		return -EINVAL;
>   
> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
> index 39a06d245f12..b3f40375f214 100644
> --- a/drivers/iommu/intel/Kconfig
> +++ b/drivers/iommu/intel/Kconfig
> @@ -21,6 +21,8 @@ config INTEL_IOMMU
>   	select IOASID
>   	select IOMMU_DMA
>   	select PCI_ATS
> +	select PCI_PRI
> +	select PCI_PASID
>   	help
>   	  DMA remapping (DMAR) devices support enables independent address
>   	  translations for Direct Memory Access (DMA) from devices.
> @@ -48,8 +50,6 @@ config INTEL_IOMMU_DEBUGFS
>   config INTEL_IOMMU_SVM
>   	bool "Support for Shared Virtual Memory with Intel IOMMU"
>   	depends on X86_64
> -	select PCI_PASID
> -	select PCI_PRI
>   	select MMU_NOTIFIER
>   	select IOASID
>   	select IOMMU_SVA

-- 
"firm, enduring, strong, and long-lived"

