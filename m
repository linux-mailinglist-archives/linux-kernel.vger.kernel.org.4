Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7196C81B3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjCXPpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjCXPps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:45:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EB41BD8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679672706;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vRC1/VdP8QTnH2Qzmn0A62aZq5RTC7SBPX5Sc2dfmw4=;
        b=DYfZf5S4tcpgChyQh5Sb0yGovDLLQeRlQ2mBS0TURqfGOAiE3+XnpHbjpJoMEIe/GpA5/M
        q0GxcE6IBR/sswmZi8PtZRzN3mUpSz/BTJMjr5e8//gjq/ODGDQHveH/ib7giHVS0JurY/
        +codtgKgI/oaRfDL/KOJt6IP/DIWusc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-DuV1GfSeMVikcyW1T833Wg-1; Fri, 24 Mar 2023 11:45:04 -0400
X-MC-Unique: DuV1GfSeMVikcyW1T833Wg-1
Received: by mail-qt1-f199.google.com with SMTP id b11-20020ac87fcb000000b003e37d72d532so1245984qtk.18
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:45:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679672704;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vRC1/VdP8QTnH2Qzmn0A62aZq5RTC7SBPX5Sc2dfmw4=;
        b=mWcUez/crc8tEspWLLoTNbXawA3Zc67fOFXxhsKBq81Zn6yZbSTLYvHKHY3Yjtes81
         z4zLFbFVwUb9zhiuuM8fzEpQvi1eROzChdzEsCFiJy+3Wq+kaFZXkt9bm1HTwi12XMA1
         gLMtYqSH5juSIB5Mjr89TcV4rkpJcpwOPLxb+QrxPnQJQ+MSQlHJ3g02HyRDtH/OjNII
         cnljRWxuqF5Z8pR5Y7qH/s8d4urnTxHrps+nvYO0DOfA/s+4MGTKM+Y0WY9inS2YZ8Fi
         BVrEFwV2bajfKWYqWxjAHiwXj+LJF5maF53BwVyY8cAKWiMIYV9nmkoHSDs4KrGlqYOC
         Emnw==
X-Gm-Message-State: AO0yUKWPmHLVjU80LeWQfUIm38ofnIodPUR6depjqIBnvG2B1JeJuUmE
        gTUzD2DaS26ZbegSnB5/rlBRmCl2FhW+UzXyelQc0ge+7ZjbvvzYFa22ZfxsIM7JQsx+xCZws4C
        7403ozi/23rdWJX1BXal3z1ts
X-Received: by 2002:a05:622a:1a98:b0:3dc:a4e5:aef0 with SMTP id s24-20020a05622a1a9800b003dca4e5aef0mr5984976qtc.9.1679672703946;
        Fri, 24 Mar 2023 08:45:03 -0700 (PDT)
X-Google-Smtp-Source: AKy350YoDFgTJsdfo1CEzGHeBcuvWj1BI5zKHFdIUbVT2L0Ym7GunFU5QXEIokCQtmR0rSAjY4mzZg==
X-Received: by 2002:a05:622a:1a98:b0:3dc:a4e5:aef0 with SMTP id s24-20020a05622a1a9800b003dca4e5aef0mr5984944qtc.9.1679672703630;
        Fri, 24 Mar 2023 08:45:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id m124-20020a375882000000b0073b8745fd39sm14290433qkb.110.2023.03.24.08.45.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 08:45:02 -0700 (PDT)
Message-ID: <b870ec68-623c-df0c-3ea5-7fe6a95e2ef6@redhat.com>
Date:   Fri, 24 Mar 2023 16:44:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v1 12/14] iommu/arm-smmu-v3: Support IOMMU_DOMAIN_NESTED
 type of allocations
Content-Language: en-US
To:     Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com,
        robin.murphy@arm.com, will@kernel.org
Cc:     kevin.tian@intel.com, baolu.lu@linux.intel.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com, jean-philippe@linaro.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <b01b2bad6d0d34908812d964eba118a9cc1e89ab.1678348754.git.nicolinc@nvidia.com>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <b01b2bad6d0d34908812d964eba118a9cc1e89ab.1678348754.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolin,

On 3/9/23 11:53, Nicolin Chen wrote:
> Add domain allocation support for IOMMU_DOMAIN_NESTED type. This includes
> the "finalise" part to log in the user space Stream Table Entry info.

Please explain the domain ops specialization.
>
> Co-developed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 38 +++++++++++++++++++--
>  1 file changed, 36 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 5ff74edfbd68..1f318b5e0921 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2214,6 +2214,19 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
>  		return 0;
>  	}
>  
> +	if (domain->type == IOMMU_DOMAIN_NESTED) {
> +		if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S1) ||
> +		    !(smmu->features & ARM_SMMU_FEAT_TRANS_S2)) {
> +			dev_dbg(smmu->dev, "does not implement two stages\n");
> +			return -EINVAL;
> +		}
> +		smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
> +		smmu_domain->s1_cfg.s1fmt = user_cfg->s1fmt;
> +		smmu_domain->s1_cfg.s1cdmax = user_cfg->s1cdmax;
> +		smmu_domain->s1_cfg.cdcfg.cdtab_dma = user_cfg->s1ctxptr;
> +		return 0;
> +	}
> +
>  	if (user_cfg_s2 && !(smmu->features & ARM_SMMU_FEAT_TRANS_S2))
>  		return -EINVAL;
>  	if (user_cfg_s2)
> @@ -2863,6 +2876,11 @@ static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
>  	arm_smmu_sva_remove_dev_pasid(domain, dev, pasid);
>  }
>  
> +static const struct iommu_domain_ops arm_smmu_nested_domain_ops = {
> +	.attach_dev		= arm_smmu_attach_dev,
> +	.free			= arm_smmu_domain_free,
> +};
> +
>  static struct iommu_domain *
>  __arm_smmu_domain_alloc(unsigned type,
>  			struct arm_smmu_domain *s2,
> @@ -2877,11 +2895,15 @@ __arm_smmu_domain_alloc(unsigned type,
>  		return arm_smmu_sva_domain_alloc();
>  
>  	if (type != IOMMU_DOMAIN_UNMANAGED &&
> +	    type != IOMMU_DOMAIN_NESTED &&
>  	    type != IOMMU_DOMAIN_DMA &&
>  	    type != IOMMU_DOMAIN_DMA_FQ &&
>  	    type != IOMMU_DOMAIN_IDENTITY)
>  		return NULL;
>  
> +	if (s2 && s2->stage != ARM_SMMU_DOMAIN_S2)
> +		return NULL;
> +
>  	/*
>  	 * Allocate the domain and initialise some of its data structures.
>  	 * We can't really finalise the domain unless a master is given.
> @@ -2889,10 +2911,14 @@ __arm_smmu_domain_alloc(unsigned type,
>  	smmu_domain = kzalloc(sizeof(*smmu_domain), GFP_KERNEL);
>  	if (!smmu_domain)
>  		return NULL;
> +	smmu_domain->s2 = s2;
>  	domain = &smmu_domain->domain;
>  
>  	domain->type = type;
> -	domain->ops = arm_smmu_ops.default_domain_ops;
> +	if (s2)
> +		domain->ops = &arm_smmu_nested_domain_ops;
> +	else
> +		domain->ops = arm_smmu_ops.default_domain_ops;
>  
>  	mutex_init(&smmu_domain->init_mutex);
>  	INIT_LIST_HEAD(&smmu_domain->devices);
> @@ -2923,8 +2949,16 @@ arm_smmu_domain_alloc_user(struct device *dev, struct iommu_domain *parent,
>  	const struct iommu_hwpt_arm_smmuv3 *user_cfg = user_data;
>  	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
>  	unsigned type = IOMMU_DOMAIN_UNMANAGED;
> +	struct arm_smmu_domain *s2 = NULL;
> +
> +	if (parent) {
> +		if (parent->ops != arm_smmu_ops.default_domain_ops)
> +			return NULL;
> +		type = IOMMU_DOMAIN_NESTED;
> +		s2 = to_smmu_domain(parent);
> +	}
Please can you explain the (use) case where !parent. This creates an
unmanaged S1?

Thanks

Eric
>  
> -	return __arm_smmu_domain_alloc(type, NULL, master, user_cfg);
> +	return __arm_smmu_domain_alloc(type, s2, master, user_cfg);
>  }
>  
>  static struct iommu_ops arm_smmu_ops = {

