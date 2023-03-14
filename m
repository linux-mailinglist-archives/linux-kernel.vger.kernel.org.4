Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185156B9161
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbjCNLRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjCNLRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:17:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076161EFD3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:16:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 264C3616FC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:16:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F55C433D2;
        Tue, 14 Mar 2023 11:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678792595;
        bh=X79Nu2WajvAG3kli7S5MqWpdmAMN0QzyYnzwzhO4DiQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rNE0y1y2KTBBZNwv8LIEziaJnVts65bVWMcZFkN4LOMqucsm+9GLRotYVlSBKkzHq
         LNxX3Dv8lO4mCn5e4NlsmtnCd27Djfrxvj6ar3nxsHI4YtE6GHw1soHtBRrx4GYp++
         AmoaE00KaCYFF6XArFU+hvJ/Ex3FF17mmuW+uz9IqGpeDG8OI+V8bW4+Rs+WKhyqaf
         zVwKLdKA/3/XeLd/YuLttb6/j+uHtyNbCcjh1uNx9dV1cWjjBtrofsL8CLHURaYsb1
         aA76qu9Ty+5XZfkNa+iXw6Z8xIT7pW21xQD+SGZifTxZNxxozfvgyu+e2la4as6OGY
         +gFdKkShEgBNg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pc2ew-0006CO-B7; Tue, 14 Mar 2023 12:17:39 +0100
Date:   Tue, 14 Mar 2023 12:17:38 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     will@kernel.org, joro@8bytes.org, robin.murphy@arm.com,
        andersson@kernel.org, johan+linaro@kernel.org, steev@kali.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/arm-smmu-qcom: Rework the logic finding the
 bypass quirk
Message-ID: <ZBBX0n4S2QBYB3Pi@hovoldconsulting.com>
References: <20230314105905.137241-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314105905.137241-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 04:29:05PM +0530, Manivannan Sadhasivam wrote:
> The logic used to find the quirky firmware that intercepts the writes to
> S2CR register to replace bypass type streams with a fault, and ignore the
> fault type, is not working with the firmware on newer SoCs like SC8280XP.
> 
> The current logic uses the last stream mapping group (num_mapping_groups
> - 1) as an index for finding quirky firmware. But on SC8280XP, NUSMRG
> reports a value of 162 (possibly emulated by the hypervisor) and logic is
> not working for stream mapping groups > 128. (Note that the ARM SMMU
> architecture specification defines NUMSMRG in the range of 0-127).
> 
> So the current logic that checks the (162-1)th S2CR entry fails to detect
> the quirky firmware on these devices and SMMU triggers invalid context
> fault for bypass streams.
> 
> To fix this issue, rework the logic to find the first non-valid (free)
> stream mapping register group (SMR) within 128 groups and use that index
> to access S2CR for detecting the bypass quirk. If no free groups are
> available, then just skip the quirk detection.
> 
> While at it, let's move the quirk detection logic to a separate function
> and change the local variable name from last_s2cr to free_s2cr.
> 
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> 
> Changes in v2:
> 
> * Limited the check to 128 groups as per ARM SMMU spec's NUMSMRG range
> * Moved the quirk handling to its own function
> * Collected review tag from Bjorn
> 
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 48 ++++++++++++++++++----
>  1 file changed, 40 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index d1b296b95c86..48362d7ef451 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -266,25 +266,49 @@ static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>  	return 0;
>  }
>  
> -static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
> +static void qcom_smmu_bypass_quirk(struct arm_smmu_device *smmu)
>  {
> -	unsigned int last_s2cr = ARM_SMMU_GR0_S2CR(smmu->num_mapping_groups - 1);
>  	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
> -	u32 reg;
> -	u32 smr;
> +	u32 free_s2cr;
> +	u32 reg, smr;
>  	int i;
>  
> +	/*
> +	 * Find the first non-valid (free) stream mapping register group and
> +	 * use that index to access S2CR for detecting the bypass quirk.
> +	 *
> +	 * Note that only the first 128 stream mapping groups are considered for
> +	 * the check. This is because the ARM SMMU architecture specification
> +	 * defines NUMSMRG (Number of Stream Mapping Register Groups) in the
> +	 * range of 0-127, but some Qcom platforms emulate more stream mapping
> +	 * groups with the help of hypervisor. And those groups don't exhibit
> +	 * the quirky behavior.
> +	 */
> +	for (i = 0; i < 128; i++) {

This may now access registers beyond smmu->num_mapping_groups. Should
you not use the minimum of these two values here (and below)?

> +		smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
> +
> +		if (!FIELD_GET(ARM_SMMU_SMR_VALID, smr))
> +			break;
> +	}
> +
> +	/* If no free stream mapping register group is available, skip the check */
> +	if (i == 128)
> +		return;

Johan
