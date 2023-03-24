Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E954E6C814B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbjCXPeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbjCXPe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:34:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F75F766
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679672017;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fkXS0sIoRMAJHcWNzF7ISYz3rQWswPiQdvAtQdj1fbU=;
        b=Ui0N4jX8UJESGlImfE6ntC05NIjpGJTR05yuqMo+a7huWrv0oa5Dyo57F0vZ/nG8cEJq4V
        E/RpGdtuWQGcqZazmkvgnpsYPgEDzj9gHUvePxd1RvRitsttPGEcmW59Zc9nRPOJcxq5C9
        GPQa97uDlGdYOOx4VmlXPTTO3ECj8Vg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-NJvEowZtMv-chUAatVBCWw-1; Fri, 24 Mar 2023 11:33:36 -0400
X-MC-Unique: NJvEowZtMv-chUAatVBCWw-1
Received: by mail-qv1-f69.google.com with SMTP id y19-20020ad445b3000000b005a5123cb627so1164806qvu.20
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:33:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679672016;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fkXS0sIoRMAJHcWNzF7ISYz3rQWswPiQdvAtQdj1fbU=;
        b=EUvZ7B3ryTlCG9vzAS/Cj4Mf1p8mr2CqGfiJx8x3tvgZww9t79A68MCtIrblw84DcD
         QPU4iEncFhP3aPIVe3QmrXJNthX1qawDa5anTjKAIptHRdlriPp8FtQk2DiTOtSR4xD5
         tUb+7QRAs1fYfN5NwCpGYbM2S4NyPI/8mD9x1hDzk59hl5pE/nWJmxllV0bn+FvRneV0
         AJf+Drj7dtdHOFFQxFrcoS3U1oEIP8iEFuSLk4zfKM1fL8Vnwv0uIsO/OCFDcuYe2c7c
         NpLpAXU+Zr+lrsr6knxtzqahAGryU99s/tXFNnFVEP/Xak3st3Lom4yqIwPTTYCE5LuB
         1LTQ==
X-Gm-Message-State: AO0yUKVxuzQeED5Zr/xetJ3HWWd1UKhHyiLXTW+Wk1sxRzXDid5SktO1
        VqrWXHdZzBahkvoefKtdxb3E0S6si8ZrapJsJsFAfdCfrrKMsAJXmVm+Tp3iwgZFFYkIDlZ1IKA
        JsLxpCALsvsvK9e2pBL5MWdW9
X-Received: by 2002:a05:622a:211:b0:3e2:6d40:d28d with SMTP id b17-20020a05622a021100b003e26d40d28dmr6006141qtx.17.1679672015932;
        Fri, 24 Mar 2023 08:33:35 -0700 (PDT)
X-Google-Smtp-Source: AK7set9R4M6MUUqT4kpW6ZMWOhUuWCwAWASEY7K3cndQ4s1uFOvfXIP5vYAUUOe00Q3K0NwOaNoL8A==
X-Received: by 2002:a05:622a:211:b0:3e2:6d40:d28d with SMTP id b17-20020a05622a021100b003e26d40d28dmr6006101qtx.17.1679672015522;
        Fri, 24 Mar 2023 08:33:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id r80-20020a374453000000b007465ee178a3sm13066130qka.96.2023.03.24.08.33.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 08:33:34 -0700 (PDT)
Message-ID: <9700988d-ae86-06f7-33e6-f079722b63ff@redhat.com>
Date:   Fri, 24 Mar 2023 16:33:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v1 11/14] iommu/arm-smmu-v3: Add
 arm_smmu_domain_alloc_user
Content-Language: en-US
To:     Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com,
        robin.murphy@arm.com, will@kernel.org
Cc:     kevin.tian@intel.com, baolu.lu@linux.intel.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com, jean-philippe@linaro.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <7d26e897780bdc009b11bc0c0ddc7b755a769b24.1678348754.git.nicolinc@nvidia.com>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <7d26e897780bdc009b11bc0c0ddc7b755a769b24.1678348754.git.nicolinc@nvidia.com>
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



On 3/9/23 11:53, Nicolin Chen wrote:
> The arm_smmu_domain_alloc_user callback function is used for userspace to
> allocate iommu_domains, such as standalone stage-1 domain, nested stage-1
> domain, and nested stage-2 domain. The input user_data is in the type of
> struct iommu_hwpt_arm_smmuv3 that contains the configurations of a nested
> stage-1 or a nested stage-2 iommu_domain. A NULL user_data will just opt
> in a standalone stage-1 domain allocation.
>
> Add a constitutive function __arm_smmu_domain_alloc to support that.
>
> Since ops->domain_alloc_user has a valid dev pointer, the master pointer
> is available when calling __arm_smmu_domain_alloc() in this case, meaning
> that arm_smmu_domain_finalise() can be done at the allocation stage. This
> allows IOMMUFD to initialize the hw_pagetable for the domain.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 95 ++++++++++++++-------
>  1 file changed, 65 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 2d29f7320570..5ff74edfbd68 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2053,36 +2053,6 @@ static void *arm_smmu_hw_info(struct device *dev, u32 *length)
>  	return info;
>  }
>  
> -static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
> -{
> -	struct arm_smmu_domain *smmu_domain;
> -
> -	if (type == IOMMU_DOMAIN_SVA)
> -		return arm_smmu_sva_domain_alloc();
> -
> -	if (type != IOMMU_DOMAIN_UNMANAGED &&
> -	    type != IOMMU_DOMAIN_DMA &&
> -	    type != IOMMU_DOMAIN_DMA_FQ &&
> -	    type != IOMMU_DOMAIN_IDENTITY)
> -		return NULL;
> -
> -	/*
> -	 * Allocate the domain and initialise some of its data structures.
> -	 * We can't really do anything meaningful until we've added a
> -	 * master.
> -	 */
> -	smmu_domain = kzalloc(sizeof(*smmu_domain), GFP_KERNEL);
> -	if (!smmu_domain)
> -		return NULL;
> -
> -	mutex_init(&smmu_domain->init_mutex);
> -	INIT_LIST_HEAD(&smmu_domain->devices);
> -	spin_lock_init(&smmu_domain->devices_lock);
> -	INIT_LIST_HEAD(&smmu_domain->mmu_notifiers);
> -
> -	return &smmu_domain->domain;
> -}
> -
>  static struct iommu_domain *arm_smmu_get_unmanaged_domain(struct device *dev)
>  {
>  	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> @@ -2893,10 +2863,75 @@ static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
>  	arm_smmu_sva_remove_dev_pasid(domain, dev, pasid);
>  }
>  
> +static struct iommu_domain *
> +__arm_smmu_domain_alloc(unsigned type,
> +			struct arm_smmu_domain *s2,
I think you should rather introduce s2 param in "iommu/arm-smmu-v3:
Support IOMMU_DOMAIN_NESTED type of allocations" because it is not use
at all in this patch nor really explained in the commit msg

Thanks

Eric
> +			struct arm_smmu_master *master,
> +			const struct iommu_hwpt_arm_smmuv3 *user_cfg)
> +{
> +	struct arm_smmu_domain *smmu_domain;
> +	struct iommu_domain *domain;
> +	int ret = 0;
> +
> +	if (type == IOMMU_DOMAIN_SVA)
> +		return arm_smmu_sva_domain_alloc();
> +
> +	if (type != IOMMU_DOMAIN_UNMANAGED &&
> +	    type != IOMMU_DOMAIN_DMA &&
> +	    type != IOMMU_DOMAIN_DMA_FQ &&
> +	    type != IOMMU_DOMAIN_IDENTITY)
> +		return NULL;
> +
> +	/*
> +	 * Allocate the domain and initialise some of its data structures.
> +	 * We can't really finalise the domain unless a master is given.
> +	 */
> +	smmu_domain = kzalloc(sizeof(*smmu_domain), GFP_KERNEL);
> +	if (!smmu_domain)
> +		return NULL;
> +	domain = &smmu_domain->domain;
> +
> +	domain->type = type;
> +	domain->ops = arm_smmu_ops.default_domain_ops;
> +
> +	mutex_init(&smmu_domain->init_mutex);
> +	INIT_LIST_HEAD(&smmu_domain->devices);
> +	spin_lock_init(&smmu_domain->devices_lock);
> +	INIT_LIST_HEAD(&smmu_domain->mmu_notifiers);
> +
> +	if (master) {
> +		smmu_domain->smmu = master->smmu;
> +		ret = arm_smmu_domain_finalise(domain, master, user_cfg);
> +		if (ret) {
> +			kfree(smmu_domain);
> +			return NULL;
> +		}
> +	}
> +
> +	return domain;
> +}
> +
> +static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
> +{
> +	return __arm_smmu_domain_alloc(type, NULL, NULL, NULL);
> +}
> +
> +static struct iommu_domain *
> +arm_smmu_domain_alloc_user(struct device *dev, struct iommu_domain *parent,
> +			   const void *user_data)
> +{
> +	const struct iommu_hwpt_arm_smmuv3 *user_cfg = user_data;
> +	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> +	unsigned type = IOMMU_DOMAIN_UNMANAGED;
> +
> +	return __arm_smmu_domain_alloc(type, NULL, master, user_cfg);
> +}
> +
>  static struct iommu_ops arm_smmu_ops = {
>  	.capable		= arm_smmu_capable,
>  	.hw_info		= arm_smmu_hw_info,
>  	.domain_alloc		= arm_smmu_domain_alloc,
> +	.domain_alloc_user	= arm_smmu_domain_alloc_user,
>  	.get_unmanaged_domain	= arm_smmu_get_unmanaged_domain,
>  	.probe_device		= arm_smmu_probe_device,
>  	.release_device		= arm_smmu_release_device,

