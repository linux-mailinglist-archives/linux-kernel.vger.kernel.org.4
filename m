Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DC76B3BD3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 11:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjCJKQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 05:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjCJKQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 05:16:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0065110F857
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 02:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678443304;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ETwri0Lb5u/XoTqkQ552K4Q0/ZV79dpN0E7lfbInptY=;
        b=LGQLRDaz/YHD7tjsHX6aRy7/sZV1czQ0BqwjtkojCi03WLnfTvNcpfnXFuQSDu8scq23+s
        xnklF4Eh/srdm7ZToxA1oI4Nec4FlChPGKR1iNjbx0tN112i1n35luPNnDdBFmHV+7qYFo
        51Avn9/FfcIGqheKRvibmNUaxYzsJ2s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-INoPo8fFMfiHtrZs_Qrn-g-1; Fri, 10 Mar 2023 05:15:02 -0500
X-MC-Unique: INoPo8fFMfiHtrZs_Qrn-g-1
Received: by mail-wr1-f69.google.com with SMTP id r14-20020a0560001b8e00b002cdb76f7e80so965060wru.19
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 02:15:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678443301;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ETwri0Lb5u/XoTqkQ552K4Q0/ZV79dpN0E7lfbInptY=;
        b=Fkwk8PVyiPdOoTO8agIN1GrtChH7sAr4QLJR0bhdyM9wcDvtgmJFYktAfgbT8/L9hD
         M+RbLaagqQqANkSggKZ4NknwvTiKRkTe8oWqoxedkujOkYSGM/d+OSKjy055BHpdOuIc
         X3skPFXJ5WiVMNkLYiJZQTddGKhBq7jHD+tPuYoMKMZhhrS3pECOeDMyMlRL11m6ifl9
         r5aBQG07MzDiPYwxiLR6T5r/mOGj/Z7+GMMQ3Om7/21G8+w37VMdiXpGId1i7CwkbkhU
         HpsV74pDmZbawhir3BVypEmewEVF3eZMGhR4FI2Mje1defQ/1YO1iaCRjGzOgSupyr4J
         NrXQ==
X-Gm-Message-State: AO0yUKVvCHh4gdT1hwYM2+jNBA6JuVJBa1a37EChIRHUCLg5vMDzfmVB
        oHC7f/Vmo/Fbmf0M3t+JXcrAM7Prbg1YEYaSi8Y24uIbbxsZcgJ1mwJeQL6vfFv5SkOA0uUQGxI
        n4Vs7J6SrV4rfr1S+f0iv8utA
X-Received: by 2002:a05:6000:118e:b0:2ca:e4ac:5089 with SMTP id g14-20020a056000118e00b002cae4ac5089mr16054754wrx.30.1678443301430;
        Fri, 10 Mar 2023 02:15:01 -0800 (PST)
X-Google-Smtp-Source: AK7set/RSIo4dqLWNAC2JYIQOcjcrJak1jBI4P4lDS7Q+nG9frkPuYJUc3dJzQYBO/nndN83PdPYOw==
X-Received: by 2002:a05:6000:118e:b0:2ca:e4ac:5089 with SMTP id g14-20020a056000118e00b002cae4ac5089mr16054734wrx.30.1678443301160;
        Fri, 10 Mar 2023 02:15:01 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id e15-20020a056000120f00b002c5493a17efsm1744232wrx.25.2023.03.10.02.14.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 02:15:00 -0800 (PST)
Message-ID: <eddde530-cd37-f493-7f0f-c97905f0de64@redhat.com>
Date:   Fri, 10 Mar 2023 11:14:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v1 01/14] iommu: Add iommu_get_unmanaged_domain helper
Content-Language: en-US
To:     Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com,
        robin.murphy@arm.com, will@kernel.org
Cc:     kevin.tian@intel.com, baolu.lu@linux.intel.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com, jean-philippe@linaro.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <9b1077601cace998533129327f5e7ad946752d29.1678348754.git.nicolinc@nvidia.com>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <9b1077601cace998533129327f5e7ad946752d29.1678348754.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolin,

On 3/9/23 11:53, Nicolin Chen wrote:
> The nature of ITS virtualization on ARM is done via hypercalls, so kernel
> handles all IOVA mappings for the MSI doorbell in iommu_dma_prepare_msi()
> and iommu_dma_compose_msi_msg(). The current virtualization solution with
> a 2-stage nested translation setup is to do 1:1 IOVA mappings at stage-1
Note that if we still intend to use that trick there is a known issue at
kernel side that needs to be fixed.

ARM DEN 0049E.b IORT specification mandates that when
RMRs are present, the OS must preserve PCIe configuration
performed by the boot FW.

As discussed in the past, enforcing this causes issue with PCI devices
with IO ports. See qemu commit
40c3472a29c9 ("Revert "acpi/gpex: Inform os to keep firmware resource
map"). This seemed to require a fix at kernel level. I am not sure this
fix has been worked on.

Thanks

Eric

> guest-level IO page table via a RMR region in guest-level IORT, aligning
> with an IOVA region that's predefined and mapped in the host kernel:
>
>   [stage-2 host level]
>   #define MSI_IOVA_BASE		0x8000000
>   #define MSI_IOVA_LENGTH	0x100000
>   ...
>   iommu_get_msi_cookie():
> 	cookie->msi_iova = MSI_IOVA_BASE;
>   ...
>   iommu_dma_prepare_msi(its_pa):
> 	domain = iommu_get_domain_for_dev(dev);
> 	iommu_dma_get_msi_page(its_pa, domain):
> 		cookie = domain->iova_cookie;
> 		iova = iommu_dma_alloc_iova():
> 			return cookie->msi_iova - size;
> 		iommu_map(iova, its_pa, ...);
>
>   [stage-1 guest level]
>   // Define in IORT a RMR [MSI_IOVA_BASE, MSI_IOVA_LENGTH]
>   ...
>   iommu_create_device_direct_mappings():
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
>  drivers/iommu/dma-iommu.c  |  5 +++--
>  drivers/iommu/iommu-priv.h | 15 +++++++++++++++
>  include/linux/iommu.h      |  2 ++
>  3 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 99b2646cb5c7..6b0409d0ff85 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -31,6 +31,7 @@
>  #include <linux/vmalloc.h>
>  
>  #include "dma-iommu.h"
> +#include "iommu-priv.h"
>  
>  struct iommu_dma_msi_page {
>  	struct list_head	list;
> @@ -1652,7 +1653,7 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
>  int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
>  {
>  	struct device *dev = msi_desc_to_dev(desc);
> -	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> +	struct iommu_domain *domain = iommu_get_unmanaged_domain(dev);
>  	struct iommu_dma_msi_page *msi_page;
>  	static DEFINE_MUTEX(msi_prepare_lock); /* see below */
>  
> @@ -1685,7 +1686,7 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
>  void iommu_dma_compose_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
>  {
>  	struct device *dev = msi_desc_to_dev(desc);
> -	const struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> +	const struct iommu_domain *domain = iommu_get_unmanaged_domain(dev);
>  	const struct iommu_dma_msi_page *msi_page;
>  
>  	msi_page = msi_desc_get_iommu_cookie(desc);
> diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
> index a6e694f59f64..da8044da9ad8 100644
> --- a/drivers/iommu/iommu-priv.h
> +++ b/drivers/iommu/iommu-priv.h
> @@ -15,6 +15,21 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
>  	return dev->iommu->iommu_dev->ops;
>  }
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
>  int iommu_group_replace_domain(struct iommu_group *group,
>  			       struct iommu_domain *new_domain);
>  
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 080278c8154d..76c65cc4fc15 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -275,6 +275,8 @@ struct iommu_ops {
>  						  struct iommu_domain *parent,
>  						  const void *user_data);
>  
> +	struct iommu_domain *(*get_unmanaged_domain)(struct device *dev);
> +
>  	struct iommu_device *(*probe_device)(struct device *dev);
>  	void (*release_device)(struct device *dev);
>  	void (*probe_finalize)(struct device *dev);

