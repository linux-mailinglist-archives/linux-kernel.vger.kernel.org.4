Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E6B73F7FF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjF0JA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjF0JA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:00:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42D9F8F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 02:00:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 034F72F4;
        Tue, 27 Jun 2023 02:01:10 -0700 (PDT)
Received: from [10.57.37.32] (unknown [10.57.37.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 420293F73F;
        Tue, 27 Jun 2023 02:00:24 -0700 (PDT)
Message-ID: <826cbb86-ac7d-c40b-f7e3-51681cda50b8@arm.com>
Date:   Tue, 27 Jun 2023 10:00:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1] iommu/arm-smmu-v3: Allow default substream bypass with
 a pasid support
Content-Language: en-GB
To:     Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org
Cc:     jgg@nvidia.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com, yangyicong@hisilicon.com,
        jean-philippe@linaro.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230627033326.5236-1-nicolinc@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230627033326.5236-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-27 04:33, Nicolin Chen wrote:
> When an iommu_domain is set to IOMMU_DOMAIN_IDENTITY, the driver would
> skip the allocation of a CD table and set the CONFIG field of the STE
> to STRTAB_STE_0_CFG_BYPASS. This works well for devices that only have
> one substream, i.e. PASID disabled.
> 
> However, there could be a use case, for a pasid capable device, that
> allows bypassing the translation at the default substream while still
> enabling the pasid feature, which means the driver should not skip the
> allocation of a CD table nor simply bypass the CONFIG field. Instead,
> the S1DSS field should be set to STRTAB_STE_1_S1DSS_BYPASS and the
> SHCFG field should be set to STRTAB_STE_1_SHCFG_INCOMING.
> 
> Add s1dss and shcfg in struct arm_smmu_s1_cfg, to allow configurations
> in the finalise() to support that use case. Then, set them accordingly
> depending on the iommu_domain->type and the master->ssid_bits.
> 
> Also, add STRTAB_STE_1_SHCFG_NONSHAREABLE of the default configuration
> to distinguish from STRTAB_STE_1_SHCFG_INCOMING of the bypass one.

Why? The "default configuration" is that the S1 shareability attribute 
is determined by the S1 translation itself, so the incoming value is 
irrelevant.

> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 18 +++++++++++++++---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 +++
>   2 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 9b0dc3505601..8dc7934a0175 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1350,11 +1350,12 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>   
>   		BUG_ON(ste_live);
>   		dst[1] = cpu_to_le64(
> -			 FIELD_PREP(STRTAB_STE_1_S1DSS, STRTAB_STE_1_S1DSS_SSID0) |
> +			 FIELD_PREP(STRTAB_STE_1_S1DSS, s1_cfg->s1dss) |
>   			 FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_WBRA) |
>   			 FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_WBRA) |
>   			 FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_ISH) |
> -			 FIELD_PREP(STRTAB_STE_1_STRW, strw));
> +			 FIELD_PREP(STRTAB_STE_1_STRW, strw) |
> +			 FIELD_PREP(STRTAB_STE_1_SHCFG, s1_cfg->shcfg));
>   
>   		if (smmu->features & ARM_SMMU_FEAT_STALLS &&
>   		    !master->stall_enabled)
> @@ -2119,6 +2120,13 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
>   		goto out_unlock;
>   
>   	cfg->s1cdmax = master->ssid_bits;
> +	if (smmu_domain->domain.type == IOMMU_DOMAIN_IDENTITY) {
> +		cfg->s1dss = STRTAB_STE_1_S1DSS_BYPASS;
> +		cfg->shcfg = STRTAB_STE_1_SHCFG_INCOMING;
> +	} else {
> +		cfg->s1dss = STRTAB_STE_1_S1DSS_SSID0;
> +		cfg->shcfg = STRTAB_STE_1_SHCFG_NONSHAREABLE;
> +	}
>   
>   	smmu_domain->stall_enabled = master->stall_enabled;
>   
> @@ -2198,7 +2206,11 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
>   	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>   	struct arm_smmu_device *smmu = smmu_domain->smmu;
>   
> -	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
> +	/*
> +	 * A master with a pasid capability might need a CD table, so only set
> +	 * ARM_SMMU_DOMAIN_BYPASS if IOMMU_DOMAIN_IDENTITY and non-pasid master
> +	 */
> +	if (domain->type == IOMMU_DOMAIN_IDENTITY && !master->ssid_bits) {
>   		smmu_domain->stage = ARM_SMMU_DOMAIN_BYPASS;
>   		return 0;
>   	}

This means we'll now go on to allocate a pagetable for an identity 
domain, which doesn't seem ideal :/

Thanks,
Robin.

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index dcab85698a4e..8052d02770d0 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -244,6 +244,7 @@
>   #define STRTAB_STE_1_STRW_EL2		2UL
>   
>   #define STRTAB_STE_1_SHCFG		GENMASK_ULL(45, 44)
> +#define STRTAB_STE_1_SHCFG_NONSHAREABLE	0UL
>   #define STRTAB_STE_1_SHCFG_INCOMING	1UL
>   
>   #define STRTAB_STE_2_S2VMID		GENMASK_ULL(15, 0)
> @@ -601,6 +602,8 @@ struct arm_smmu_s1_cfg {
>   	struct arm_smmu_ctx_desc_cfg	cdcfg;
>   	struct arm_smmu_ctx_desc	cd;
>   	u8				s1fmt;
> +	u8				s1dss;
> +	u8				shcfg;
>   	u8				s1cdmax;
>   };
>   
