Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316EE5E6654
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbiIVO7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbiIVO7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:59:10 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDA2E4DB5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 07:59:05 -0700 (PDT)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MYJLF3vx3z67NJj;
        Thu, 22 Sep 2022 22:57:57 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 16:59:03 +0200
Received: from [10.195.244.8] (10.195.244.8) by lhrpeml500003.china.huawei.com
 (7.191.162.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 15:59:02 +0100
Message-ID: <495de02c-59ce-917f-1cb4-5425a37063ed@huawei.com>
Date:   Thu, 22 Sep 2022 15:59:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] iommu: Optimise PCI SAC address trick
To:     Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>
CC:     <will@kernel.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <2b0ca6254dd0102bf559b2a73e9b51da089afbe3.1663764627.git.robin.murphy@arm.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <2b0ca6254dd0102bf559b2a73e9b51da089afbe3.1663764627.git.robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.244.8]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2022 13:53, Robin Murphy wrote:
> Per the reasoning in commit 4bf7fda4dce2 ("iommu/dma: Add config for
> PCI SAC address trick") and its subsequent revert, this mechanism no
> longer serves its original purpose, but now only works around broken
> hardware/drivers in a way that is unfortunately too impactful to remove.
> 
> This does not, however prevent us from solving the performance impact
> which that workaround has on large-scale systems that don't need it.
> That kicks in once the 32-bit IOVA space fills up and we keep
> unsuccessfully trying to allocate from it. However, if we get to that
> point then in fact it's already the endgame. The nature of the allocator
> is such that the first IOVA we give to a device after the 32-bit space
> runs out will be the highest possible address for that device, ever.
> If that works, then great, we know we can optimise for speed by always
> allocating from the full range. And if it doesn't, then the worst has
> already happened and any brokenness is now showing, so there's no point
> continuing to try to hide it.
> 
> To that end, implement a flag to refine this into a per-device policy
> that can automatically get itself out of the way if and when it stops
> being useful.
> 
> CC: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

FWIW,

Reviewed-by: John Garry <john.garry@huawei.com>

2x minor comments below.

Thanks,
John

> ---
> 
> v2: Refactor to avoid CONFIG_IOMMU_DMA=n breakage (oops)
> 
>   drivers/iommu/dma-iommu.c | 5 ++++-
>   drivers/iommu/dma-iommu.h | 8 ++++++++
>   drivers/iommu/iommu.c     | 3 +++
>   include/linux/iommu.h     | 2 ++
>   4 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 9297b741f5e8..1cebb16faa33 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -643,9 +643,12 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
>   		dma_limit = min(dma_limit, (u64)domain->geometry.aperture_end);
>   
>   	/* Try to get PCI devices a SAC address */
> -	if (dma_limit > DMA_BIT_MASK(32) && !iommu_dma_forcedac && dev_is_pci(dev))
> +	if (dma_limit > DMA_BIT_MASK(32) && dev->iommu->pci_workaround) {
>   		iova = alloc_iova_fast(iovad, iova_len,
>   				       DMA_BIT_MASK(32) >> shift, false);
> +		if (!iova)
> +			dev->iommu->pci_workaround = false;

maybe a warn/notice log would be useful for broken systems to give a 
hint what could have gone wrong when it breaks (if we ever get here).

> +	}
>   
>   	if (!iova)
>   		iova = alloc_iova_fast(iovad, iova_len, dma_limit >> shift,
> diff --git a/drivers/iommu/dma-iommu.h b/drivers/iommu/dma-iommu.h
> index 942790009292..c7be42d4f0cf 100644
> --- a/drivers/iommu/dma-iommu.h
> +++ b/drivers/iommu/dma-iommu.h
> @@ -17,6 +17,10 @@ int iommu_dma_init_fq(struct iommu_domain *domain);
>   void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
>   
>   extern bool iommu_dma_forcedac;
> +static inline void iommu_dma_set_pci_workaround(struct device *dev)

"pci_workaround" is quite a vague name

> +{
> +	dev->iommu->pci_workaround = !iommu_dma_forcedac;
> +}
>   
>   #else /* CONFIG_IOMMU_DMA */
>   
> @@ -38,5 +42,9 @@ static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_he
>   {
>   }
>   
> +static inline void iommu_dma_set_pci_workaround(struct device *dev)
> +{
> +}
> +
>   #endif	/* CONFIG_IOMMU_DMA */
>   #endif	/* __DMA_IOMMU_H */
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index edc768bf8976..ba8afea63ef1 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -323,6 +323,9 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>   
>   	iommu_device_link(iommu_dev, dev);
>   
> +	if (dev_is_pci(dev))
> +		iommu_dma_set_pci_workaround(dev);
> +
>   	return 0;
>   
>   out_release:
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 79cb6eb560a8..0eb0f808109c 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -368,6 +368,7 @@ struct iommu_fault_param {
>    * @fwspec:	 IOMMU fwspec data
>    * @iommu_dev:	 IOMMU device this device is linked to
>    * @priv:	 IOMMU Driver private data
> + * @pci_workaround: Limit DMA allocations to 32-bit IOVA >    *
>    * TODO: migrate other per device data pointers under iommu_dev_data, e.g.
>    *	struct iommu_group	*iommu_group;
> @@ -379,6 +380,7 @@ struct dev_iommu {
>   	struct iommu_fwspec		*fwspec;
>   	struct iommu_device		*iommu_dev;
>   	void				*priv;
> +	bool				pci_workaround;
>   };
>   
>   int iommu_device_register(struct iommu_device *iommu,

