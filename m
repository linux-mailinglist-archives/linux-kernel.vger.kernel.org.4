Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6BF627AE3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbiKNKqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235997AbiKNKqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:46:53 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00A2B2BD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:46:52 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A69223A;
        Mon, 14 Nov 2022 02:46:59 -0800 (PST)
Received: from [10.57.70.90] (unknown [10.57.70.90])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97DD83F73D;
        Mon, 14 Nov 2022 02:46:51 -0800 (PST)
Message-ID: <93e31bd7-890b-abd9-a75b-44e86df5bb6d@arm.com>
Date:   Mon, 14 Nov 2022 10:46:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] iommu/arm-smmu-v3: Optimize checking for invalid values
To:     Harry Song <jundongsong1@gmail.com>, will@kernel.org
Cc:     joro@8bytes.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221113133855.6219-1-jundongsong1@gmail.com>
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20221113133855.6219-1-jundongsong1@gmail.com>
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

On 2022-11-13 13:38, Harry Song wrote:
> Move the check of invalid value (iotlb_gather->pgsize = 0) from
> arm_smmu_iotlb_sync() to __arm_smmu_tlb_inv_range() for iotlb sync
> to make the code clearer.

How is this an optimisation? It adds a redundant check on paths that 
don't need it, and even the unmap error paths now have to do *more* work 
to figure out when there's nothing to sync. Furthermore, to me "clear 
code" means making decisions at the appropriate level of abstraction, 
not deliberately passing invalid arguments down through 3 more levels of 
callstack to eventually do nothing.

If you think that the gather->pgsize logic is hard to follow and needs 
more explanation then by all means add a comment to call out how 
iommu_iotlb_gather_init() and iommu_iotlb_gather_add_page() join it up, 
but I don't agree with this patch as it is, sorry.

Thanks,
Robin.

> Signed-off-by: Harry Song <jundongsong1@gmail.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 6d5df91c5..e51b9f506 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1873,7 +1873,7 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
>   	size_t inv_range = granule;
>   	struct arm_smmu_cmdq_batch cmds;
>   
> -	if (!size)
> +	if (!size || !inv_range)
>   		return;
>   
>   	if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
> @@ -2507,9 +2507,6 @@ static void arm_smmu_iotlb_sync(struct iommu_domain *domain,
>   {
>   	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>   
> -	if (!gather->pgsize)
> -		return;
> -
>   	arm_smmu_tlb_inv_range_domain(gather->start,
>   				      gather->end - gather->start + 1,
>   				      gather->pgsize, true, smmu_domain);
