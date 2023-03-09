Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C226B25B4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 14:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjCINop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 08:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCINom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:44:42 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 559C43B3FD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 05:44:41 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 902AAC14;
        Thu,  9 Mar 2023 05:45:24 -0800 (PST)
Received: from [10.57.91.145] (unknown [10.57.91.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F03D3F71A;
        Thu,  9 Mar 2023 05:44:39 -0800 (PST)
Message-ID: <510e6e1a-884f-ae5a-35f3-4f4db997abfd@arm.com>
Date:   Thu, 9 Mar 2023 13:44:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 13/14] iommu/arm-smmu-v3: Add CMDQ_OP_TLBI_NH_VAA and
 CMDQ_OP_TLBI_NH_ALL
Content-Language: en-GB
To:     Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, will@kernel.org
Cc:     eric.auger@redhat.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com, jean-philippe@linaro.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <3b059f4b0bda1e83d402248114a774186f678387.1678348754.git.nicolinc@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <3b059f4b0bda1e83d402248114a774186f678387.1678348754.git.nicolinc@nvidia.com>
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
> With a nested translation setup, a stage-1 Context Descriptor table can be
> managed by a guest OS in the user space. So, the kernel driver should not
> assume that the guest OS will use a user space device driver that doesn't
> support TLBI_NH_VAA and TLBI_NH_ALL commands.
> 
> Add them in the arm_smmu_cmdq_build_cmd(), to prepare for support of these
> two TLBI invalidation requests from the guest level.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 ++++
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 2 ++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 1f318b5e0921..ac63185ae268 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -277,6 +277,9 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>   		/* Cover the entire SID range */
>   		cmd[1] |= FIELD_PREP(CMDQ_CFGI_1_RANGE, 31);
>   		break;
> +	case CMDQ_OP_TLBI_NH_VAA:
> +		ent->tlbi.asid = 0;

This is backwards - NH_VA is a superset of NH_VAA (not to mention that 
quietly modifying the input argument is ugly; in fact it might be nice 
if ent was const here).

Please follow the existing pattern, and decouple NH_VA from EL2_VA if 
necessary.

Thanks,
Robin.

> +		fallthrough;
>   	case CMDQ_OP_TLBI_NH_VA:
>   		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_VMID, ent->tlbi.vmid);
>   		fallthrough;
> @@ -301,6 +304,7 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>   	case CMDQ_OP_TLBI_NH_ASID:
>   		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_ASID, ent->tlbi.asid);
>   		fallthrough;
> +	case CMDQ_OP_TLBI_NH_ALL:
>   	case CMDQ_OP_TLBI_S12_VMALL:
>   		cmd[0] |= FIELD_PREP(CMDQ_TLBI_0_VMID, ent->tlbi.vmid);
>   		break;
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 6cf516852721..6181d6cd8b51 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -454,8 +454,10 @@ struct arm_smmu_cmdq_ent {
>   			};
>   		} cfgi;
>   
> +		#define CMDQ_OP_TLBI_NH_ALL	0x10
>   		#define CMDQ_OP_TLBI_NH_ASID	0x11
>   		#define CMDQ_OP_TLBI_NH_VA	0x12
> +		#define CMDQ_OP_TLBI_NH_VAA	0x13
>   		#define CMDQ_OP_TLBI_EL2_ALL	0x20
>   		#define CMDQ_OP_TLBI_EL2_ASID	0x21
>   		#define CMDQ_OP_TLBI_EL2_VA	0x22
