Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638A563B10D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 19:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbiK1SUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 13:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbiK1STN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 13:19:13 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 517B02AE18;
        Mon, 28 Nov 2022 10:03:58 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87553D6E;
        Mon, 28 Nov 2022 10:04:04 -0800 (PST)
Received: from [10.57.71.118] (unknown [10.57.71.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30E293F73B;
        Mon, 28 Nov 2022 10:03:55 -0800 (PST)
Message-ID: <bc1e4fd5-bf96-f579-8190-fda9b41d1547@arm.com>
Date:   Mon, 28 Nov 2022 18:03:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 3/7] s390/pci: Use dma-iommu layer
Content-Language: en-GB
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>
Cc:     Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, linux-kernel@vger.kernel.org,
        Julian Ruess <julianr@linux.ibm.com>
References: <20221116171656.4128212-1-schnelle@linux.ibm.com>
 <20221116171656.4128212-4-schnelle@linux.ibm.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20221116171656.4128212-4-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-16 17:16, Niklas Schnelle wrote:
[...]
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index dc5f7a156ff5..804fb8f42d61 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -93,7 +93,7 @@ config IOMMU_DEBUGFS
>   choice
>   	prompt "IOMMU default domain type"
>   	depends on IOMMU_API
> -	default IOMMU_DEFAULT_DMA_LAZY if X86 || IA64
> +	default IOMMU_DEFAULT_DMA_LAZY if X86 || IA64 || S390
>   	default IOMMU_DEFAULT_DMA_STRICT
>   	help
>   	  Choose the type of IOMMU domain used to manage DMA API usage by
> @@ -412,6 +412,7 @@ config ARM_SMMU_V3_SVA
>   config S390_IOMMU
>   	def_bool y if S390 && PCI
>   	depends on S390 && PCI
> +	select IOMMU_DMA

Please add S390 to the condition under config IOMMU_DMA instead.

>   	select IOMMU_API
>   	help
>   	  Support for the IOMMU API for s390 PCI devices.
[...]
> @@ -45,9 +329,14 @@ static struct iommu_domain *s390_domain_alloc(unsigned domain_type)
>   {
>   	struct s390_domain *s390_domain;
>   
> -	if (domain_type != IOMMU_DOMAIN_UNMANAGED)
> +	switch (domain_type) {
> +	case IOMMU_DOMAIN_DMA:
> +	case IOMMU_DOMAIN_DMA_FQ:

I was about to question adding this without any visible treatment of 
iommu_iotlb_gather_queued() or domain->type == IOMMU_DOMAIN_DMA_FQ as a 
whole, but I guess if you never actually free any pagetables it does 
work out OK. Bit of a timebomb if there's a chance of that ever changing 
in future, though.

> +	case IOMMU_DOMAIN_UNMANAGED:
> +		break;
> +	default:
>   		return NULL;
> -
> +	}
>   	s390_domain = kzalloc(sizeof(*s390_domain), GFP_KERNEL);
>   	if (!s390_domain)
>   		return NULL;
[...]
> @@ -397,12 +678,29 @@ static size_t s390_iommu_unmap_pages(struct iommu_domain *domain,
>   		return 0;
>   
>   	iommu_iotlb_gather_add_range(gather, iova, size);
> +	atomic64_add(pgcount, &s390_domain->ctrs.unmapped_pages);
>   
>   	return size;
>   }
>   
> +static void s390_iommu_probe_finalize(struct device *dev)
> +{
> +	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> +
> +	iommu_dma_forcedac = true;
> +	iommu_setup_dma_ops(dev, domain->geometry.aperture_start, domain->geometry.aperture_end);

For consistency with all but one other caller now, just pass 0 and 
U64_MAX for base and size to make it clear that they're meaningless 
(they will eventually go away as part of a bigger refactoring).

Thanks,
Robin.
