Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1976B5212
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 21:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjCJUjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 15:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjCJUjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:39:33 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2A6A133A7C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 12:39:28 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13872AD7;
        Fri, 10 Mar 2023 12:40:12 -0800 (PST)
Received: from [10.57.90.67] (unknown [10.57.90.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E55623F71A;
        Fri, 10 Mar 2023 12:39:25 -0800 (PST)
Message-ID: <0d1e585d-9a11-3f7b-4faa-dc2aa8f961cc@arm.com>
Date:   Fri, 10 Mar 2023 20:39:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 08/14] iommu/arm-smmu-v3: Prepare for nested domain
 support
Content-Language: en-GB
To:     Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, will@kernel.org
Cc:     eric.auger@redhat.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com, jean-philippe@linaro.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <4740f8a40caf68ccc1f9fee5fcdf1604546fb354.1678348754.git.nicolinc@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <4740f8a40caf68ccc1f9fee5fcdf1604546fb354.1678348754.git.nicolinc@nvidia.com>
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
> In a nested translation setup, the device is attached to a stage-1 domain
> that represents the guest-level Context Descriptor table. A Stream Table
> Entry for a 2-stage translation needs both the stage-1 Context Descriptor
> table info and the stage-2 Translation table information, i.e. a pair of
> s1_cfg and s2_cfg.
> 
> Add an "s2" pointer in struct arm_smmu_domain, so a nested stage-1 domain
> can simply navigate its stage-2 domain for the s2_cfg pointer. Also, add
> a to_s2_cfg() helper for this purpose, and use it at proper places.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 25 +++++++++++++++++++--
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
>   2 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 21d819979865..fee5977feef3 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -100,6 +100,24 @@ static void parse_driver_options(struct arm_smmu_device *smmu)
>   	} while (arm_smmu_options[++i].opt);
>   }
>   
> +static struct arm_smmu_s2_cfg *to_s2_cfg(struct arm_smmu_domain *smmu_domain)
> +{
> +	if (!smmu_domain)
> +		return NULL;
> +
> +	switch (smmu_domain->stage) {
> +	case ARM_SMMU_DOMAIN_S1:
> +		if (smmu_domain->s2)
> +			return &smmu_domain->s2->s2_cfg;
> +		return NULL;
> +	case ARM_SMMU_DOMAIN_S2:
> +		return &smmu_domain->s2_cfg;
> +	case ARM_SMMU_DOMAIN_BYPASS:
> +	default:
> +		return NULL;
> +	}
> +}
> +
>   /* Low-level queue manipulation functions */
>   static bool queue_has_space(struct arm_smmu_ll_queue *q, u32 n)
>   {
> @@ -1277,6 +1295,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>   		switch (smmu_domain->stage) {
>   		case ARM_SMMU_DOMAIN_S1:
>   			s1_cfg = &smmu_domain->s1_cfg;
> +			s2_cfg = to_s2_cfg(smmu_domain);

TBH I'd say you only need a 2-line change here. All the other cases 
below are when the stage is guaranteed to be ARM_SMMU_DOMAIN_S2 (once 
ARM_SMMU_DOMAIN_NESTED is gone), so pretending it might be otherwise 
seems unnecessarily confusing.

Thanks,
Robin.

>   			break;
>   		case ARM_SMMU_DOMAIN_S2:
>   			s2_cfg = &smmu_domain->s2_cfg;
> @@ -1846,6 +1865,7 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
>   static void arm_smmu_tlb_inv_context(void *cookie)
>   {
>   	struct arm_smmu_domain *smmu_domain = cookie;
> +	struct arm_smmu_s2_cfg *s2_cfg = to_s2_cfg(smmu_domain);
>   	struct arm_smmu_device *smmu = smmu_domain->smmu;
>   	struct arm_smmu_cmdq_ent cmd;
>   
> @@ -1860,7 +1880,7 @@ static void arm_smmu_tlb_inv_context(void *cookie)
>   		arm_smmu_tlb_inv_asid(smmu, smmu_domain->s1_cfg.cd.asid);
>   	} else {
>   		cmd.opcode	= CMDQ_OP_TLBI_S12_VMALL;
> -		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
> +		cmd.tlbi.vmid	= s2_cfg->vmid;
>   		arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
>   	}
>   	arm_smmu_atc_inv_domain(smmu_domain, 0, 0, 0);
> @@ -1931,6 +1951,7 @@ static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
>   					  size_t granule, bool leaf,
>   					  struct arm_smmu_domain *smmu_domain)
>   {
> +	struct arm_smmu_s2_cfg *s2_cfg = to_s2_cfg(smmu_domain);
>   	struct arm_smmu_cmdq_ent cmd = {
>   		.tlbi = {
>   			.leaf	= leaf,
> @@ -1943,7 +1964,7 @@ static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
>   		cmd.tlbi.asid	= smmu_domain->s1_cfg.cd.asid;
>   	} else {
>   		cmd.opcode	= CMDQ_OP_TLBI_S2_IPA;
> -		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
> +		cmd.tlbi.vmid	= s2_cfg->vmid;
>   	}
>   	__arm_smmu_tlb_inv_range(&cmd, iova, size, granule, smmu_domain);
>   
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 1a93eeb993ea..6cf516852721 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -709,6 +709,7 @@ enum arm_smmu_domain_stage {
>   };
>   
>   struct arm_smmu_domain {
> +	struct arm_smmu_domain		*s2;
>   	struct arm_smmu_device		*smmu;
>   	struct mutex			init_mutex; /* Protects smmu pointer */
>   
