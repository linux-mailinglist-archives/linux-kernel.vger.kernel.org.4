Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E0B6281A4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 14:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbiKNNvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 08:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiKNNvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 08:51:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC631E3E1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 05:51:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72A5361195
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 13:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AD5C433C1;
        Mon, 14 Nov 2022 13:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668433863;
        bh=ugtcmt7FyPihhJ5NcM21Bx302D5wCzUkW8Okfg6RYvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V8onaSjHBRHzE8wxh5vslXQpRI4NRb3sBz31h0p92zvb4qVsENG1qmK+olWrWD6e2
         1xyLH14xUBfssEMvnKDJD+AZIaP55MHe2Lb6lCsOLaYBqv2y864dbbRvckC1CaE1A1
         bzpEc+RonbXCltx3H71Zm7iKa+0p/vCMSznz31SLiL3BMjEHHwEat/I36CEyHtlTDe
         Q0odXn13SjXBG46audjKy1Ru3qO6MY9Jln9+LuU51+5sXhtOrwTuCc/SkXH/cyZCCW
         6633Qoo+XuB1f5OI50TvZqcZRzTqYaLNV2DdFZwAEoB51gtgO6lyVuoIzYfYAaZlkt
         REI43axuPvQpw==
Date:   Mon, 14 Nov 2022 13:50:58 +0000
From:   Will Deacon <will@kernel.org>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     joro@8bytes.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        jgg@nvidia.com, robin.murphy@arm.com
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Restore prints in
 arm_smmu_attach_dev()
Message-ID: <20221114135057.GE30263@willie-the-truck>
References: <20221109184636.14264-1-nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109184636.14264-1-nicolinc@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 10:46:36AM -0800, Nicolin Chen wrote:
> The prints for incompatible failures in arm_smmu_attach_dev() might be
> still useful for error diagnosis. As VFIO and IOMMUFD would do testing
> attach() call, having previous dev_err() isn't ideal either.
> 
> Add the prints back using dev_dbg().
> 
> Fixes: f4a147735793 ("iommu: Use EINVAL for incompatible device/domain in ->attach_dev")
> Suggested-by: Will Deacon <will@kernel.org>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
> Changelog
> v1->v2:
>  * Add "Fixes" line and Reviewed-by from Jason
> 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index ab160198edd6..076d3710b1fe 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2433,14 +2433,21 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  			goto out_unlock;
>  		}
>  	} else if (smmu_domain->smmu != smmu) {
> +		dev_dbg(dev, "cannot attach to SMMU %s (upstream of %s)\n",
> +			dev_name(smmu_domain->smmu->dev), dev_name(smmu->dev));
>  		ret = -EINVAL;
>  		goto out_unlock;
>  	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
>  		   master->ssid_bits != smmu_domain->s1_cfg.s1cdmax) {
> +		dev_dbg(dev,
> +			"cannot attach to incompatible domain (%u SSID bits != %u)\n",
> +			smmu_domain->s1_cfg.s1cdmax, master->ssid_bits);
>  		ret = -EINVAL;
>  		goto out_unlock;
>  	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
>  		   smmu_domain->stall_enabled != master->stall_enabled) {
> +		dev_dbg(dev, "cannot attach to stall-%s domain\n",
> +			smmu_domain->stall_enabled ? "enabled" : "disabled");
>  		ret = -EINVAL;
>  		goto out_unlock;

Thanks!

Acked-by: Will Deacon <will@kernel.org>

Will
