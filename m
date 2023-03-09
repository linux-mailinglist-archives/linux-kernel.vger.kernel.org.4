Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2299A6B27C4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbjCIOvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbjCIOvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:51:24 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 258FFF401D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 06:50:03 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B20E2AD7;
        Thu,  9 Mar 2023 06:50:05 -0800 (PST)
Received: from [10.57.91.145] (unknown [10.57.91.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BDD63F5A1;
        Thu,  9 Mar 2023 06:49:20 -0800 (PST)
Message-ID: <1467e666-1b6c-c285-3f79-f8e8b088718b@arm.com>
Date:   Thu, 9 Mar 2023 14:49:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 14/14] iommu/arm-smmu-v3: Add
 arm_smmu_cache_invalidate_user
Content-Language: en-GB
To:     Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, will@kernel.org
Cc:     eric.auger@redhat.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com, jean-philippe@linaro.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <aa327f9ea61e5a4771c13e53639e33955b9acde3.1678348754.git.nicolinc@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <aa327f9ea61e5a4771c13e53639e33955b9acde3.1678348754.git.nicolinc@nvidia.com>
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
> Add arm_smmu_cache_invalidate_user() function for user space to invalidate
> TLB entries and Context Descriptors, since either an IO page table entrie
> or a Context Descriptor in the user space is still cached by the hardware.
> 
> The input user_data is defined in "struct iommu_hwpt_invalidate_arm_smmuv3"
> that contains the essential data for corresponding invalidation commands.
> 
> Co-developed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 56 +++++++++++++++++++++
>   1 file changed, 56 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index ac63185ae268..7d73eab5e7f4 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2880,9 +2880,65 @@ static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
>   	arm_smmu_sva_remove_dev_pasid(domain, dev, pasid);
>   }
>   
> +static void arm_smmu_cache_invalidate_user(struct iommu_domain *domain,
> +					   void *user_data)
> +{
> +	struct iommu_hwpt_invalidate_arm_smmuv3 *inv_info = user_data;
> +	struct arm_smmu_cmdq_ent cmd = { .opcode = inv_info->opcode };
> +	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
> +	size_t granule_size = inv_info->granule_size;
> +	unsigned long iova = 0;
> +	size_t size = 0;
> +	int ssid = 0;
> +
> +	if (!smmu || !smmu_domain->s2 || domain->type != IOMMU_DOMAIN_NESTED)
> +		return;
> +
> +	switch (inv_info->opcode) {
> +	case CMDQ_OP_CFGI_CD:
> +	case CMDQ_OP_CFGI_CD_ALL:
> +		return arm_smmu_sync_cd(smmu_domain, inv_info->ssid, true);

Since we let the guest choose its own S1Fmt (and S1CDMax, yet not 
S1DSS?), how can we assume leaf = true here?

> +	case CMDQ_OP_TLBI_NH_VA:
> +		cmd.tlbi.asid = inv_info->asid;
> +		fallthrough;
> +	case CMDQ_OP_TLBI_NH_VAA:
> +		if (!granule_size || !(granule_size & smmu->pgsize_bitmap) ||

Non-range invalidations with TG=0 are perfectly legal, and should not be 
ignored.

> +		    granule_size & ~(1ULL << __ffs(granule_size)))

If that's intended to mean is_power_of_2(), please just use is_power_of_2().

> +			return;
> +
> +		iova = inv_info->range.start;
> +		size = inv_info->range.last - inv_info->range.start + 1;

If the design here is that user_data is so deeply driver-specific and 
special to the point that it can't possibly be passed as a type-checked 
union of the known and publicly-visible UAPI types that it is, wouldn't 
it make sense to just encode the whole thing in the expected format and 
not have to make these kinds of niggling little conversions at both ends?

> +		if (!size)
> +			return;
> +
> +		cmd.tlbi.vmid = smmu_domain->s2->s2_cfg.vmid;
> +		cmd.tlbi.leaf = inv_info->flags & IOMMU_SMMUV3_CMDQ_TLBI_VA_LEAF;
> +		__arm_smmu_tlb_inv_range(&cmd, iova, size, granule_size, smmu_domain);
> +		break;
> +	case CMDQ_OP_TLBI_NH_ASID:
> +		cmd.tlbi.asid = inv_info->asid;
> +		fallthrough;
> +	case CMDQ_OP_TLBI_NH_ALL:
> +		cmd.tlbi.vmid = smmu_domain->s2->s2_cfg.vmid;
> +		arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
> +		break;
> +	case CMDQ_OP_ATC_INV:
> +		ssid = inv_info->ssid;
> +		iova = inv_info->range.start;
> +		size = inv_info->range.last - inv_info->range.start + 1;
> +		break;

Can we do any better than multiplying every single ATC_INV command, even 
for random bogus StreamIDs, into multiple commands across every physical 
device? In fact, I'm not entirely confident this isn't problematic, if 
the guest wishes to send invalidations for one device specifically while 
it's put some other device into a state where sending it a command would 
do something bad. At the very least, it's liable to be confusing if the 
guest sends a command for one StreamID but gets an error back for a 
different one.

And if we expect ATS, what about PRI? Per patch #4 you're currently 
offering that to the guest as well.

> +	default:
> +		return;

What about NSNH_ALL? That still needs to invalidate all the S1 context 
that the guest *thinks* it's invalidating.

Also, perhaps I've overlooked something obvious, but what's the 
procedure for reflecting illegal commands back to userspace? Some of the 
things we're silently ignoring here would be expected to raise 
CERROR_ILL. Same goes for all the other fault events which may occur due 
to invalid S1 config, come to think of it.

Thanks,
Robin.

> +	}
> +
> +	arm_smmu_atc_inv_domain(smmu_domain, ssid, iova, size);
> +}
> +
>   static const struct iommu_domain_ops arm_smmu_nested_domain_ops = {
>   	.attach_dev		= arm_smmu_attach_dev,
>   	.free			= arm_smmu_domain_free,
> +	.cache_invalidate_user	= arm_smmu_cache_invalidate_user,
>   };
>   
>   static struct iommu_domain *
