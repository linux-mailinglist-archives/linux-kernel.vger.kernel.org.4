Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1299261F797
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbiKGP1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbiKGP04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:26:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB2EBC93;
        Mon,  7 Nov 2022 07:26:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57D2D6113D;
        Mon,  7 Nov 2022 15:26:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45829C433C1;
        Mon,  7 Nov 2022 15:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667834814;
        bh=W675gqNAfxBDemkU93uk7keZsNkIbPSTt12Mk3qnGOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CtQqMj5pvofsT6RL6c73nOHyJPNzYHtWR26lgwhR5lL+mFr3DLmnfXNOyM2ctk2EB
         DXSnyVmwBDVWCuh6t/jOYy4sGDpVuaah8fWod0gReT/fuEvZjRhpL+WKjRyfD3KxA5
         StyJ8iTVWr2AYevyJncv9jcjUdKTGN08CG+c4sb5sthZwvKGwtnyE5ke3jg/Iw5YSO
         IG58eDQv1Bu1n7fbiBR5ddQtysHqTwy/hn4mRBxbfYaLnb08KeHt4dh1qmmSMB2QnU
         Rbls6y5O+krcPIpTHylZ9sv6MHtZf+7JOJAm12EOSyHvBewer8sDqrAkrqaWflTupW
         qNvv+jC8xzkbQ==
Date:   Mon, 7 Nov 2022 15:26:45 +0000
From:   Will Deacon <will@kernel.org>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     joro@8bytes.org, robin.murphy@arm.com, jgg@nvidia.com,
        kevin.tian@intel.com, quic_jjohnson@quicinc.com,
        suravee.suthikulpanit@amd.com, robdclark@gmail.com,
        dwmw2@infradead.org, baolu.lu@linux.intel.com,
        yong.wu@mediatek.com, matthias.bgg@gmail.com, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
        jean-philippe@linaro.org, tglx@linutronix.de,
        shameerali.kolothum.thodi@huawei.com,
        christophe.jaillet@wanadoo.fr, yangyicong@hisilicon.com,
        yangyingliang@huawei.com, quic_saipraka@quicinc.com,
        jon@solid-run.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-tegra@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v7 4/5] iommu: Use EINVAL for incompatible device/domain
 in ->attach_dev
Message-ID: <20221107152645.GD21002@willie-the-truck>
References: <cover.1666042872.git.nicolinc@nvidia.com>
 <f52a07f7320da94afe575c9631340d0019a203a7.1666042873.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f52a07f7320da94afe575c9631340d0019a203a7.1666042873.git.nicolinc@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 04:02:21PM -0700, Nicolin Chen wrote:
> Following the new rules in include/linux/iommu.h kdocs, update all drivers
> ->attach_dev callback functions to return EINVAL in the failure paths that
> are related to domain incompatibility.
> 
> Also, drop adjacent error prints to prevent a kernel log spam.
> 
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 11 +----------
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       |  3 ---
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c     |  7 +------
>  drivers/iommu/intel/iommu.c                 | 10 +++-------
>  drivers/iommu/ipmmu-vmsa.c                  |  2 --
>  drivers/iommu/omap-iommu.c                  |  2 +-
>  drivers/iommu/sprd-iommu.c                  |  4 +---
>  drivers/iommu/tegra-gart.c                  |  2 +-
>  drivers/iommu/virtio-iommu.c                |  3 +--
>  9 files changed, 9 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index ba47c73f5b8c..01fd7df16cb9 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2430,23 +2430,14 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  			goto out_unlock;
>  		}
>  	} else if (smmu_domain->smmu != smmu) {
> -		dev_err(dev,
> -			"cannot attach to SMMU %s (upstream of %s)\n",
> -			dev_name(smmu_domain->smmu->dev),
> -			dev_name(smmu->dev));
> -		ret = -ENXIO;
> +		ret = -EINVAL;
>  		goto out_unlock;
>  	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
>  		   master->ssid_bits != smmu_domain->s1_cfg.s1cdmax) {
> -		dev_err(dev,
> -			"cannot attach to incompatible domain (%u SSID bits != %u)\n",
> -			smmu_domain->s1_cfg.s1cdmax, master->ssid_bits);
>  		ret = -EINVAL;
>  		goto out_unlock;
>  	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
>  		   smmu_domain->stall_enabled != master->stall_enabled) {
> -		dev_err(dev, "cannot attach to stall-%s domain\n",
> -			smmu_domain->stall_enabled ? "enabled" : "disabled");
>  		ret = -EINVAL;
>  		goto out_unlock;
>  	}

I think it would be helpful to preserve these messages using
dev_err_ratelimited() so that attach failure can be diagnosed without
having to hack the messages back into the driver.

With that:

Acked-by: Will Deacon <will@kernel.org>

Will
