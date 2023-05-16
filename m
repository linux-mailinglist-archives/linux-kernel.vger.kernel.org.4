Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262B8705001
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbjEPNzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbjEPNzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:55:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4076E198B;
        Tue, 16 May 2023 06:55:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D221B623A6;
        Tue, 16 May 2023 13:55:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11530C433D2;
        Tue, 16 May 2023 13:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684245333;
        bh=wZ62vZSRS8wP66zvBvXFymljcnlfadcikGe0oxhN+BE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OAGr9szX1xMSABTUwVaAywEIAq0f/k7uM41GXb/FOyxdKxRLSQTL48v/6fRuqTbJj
         s0S1lR87KmWRD7cWf621kwk0q1PiwDpTRb3VFCVC/1dD9qHt0WooW2V+bzEnKNW9e+
         nsBYAtQwejfBMnw5/Fyg8NlPtl2GeVgdvRydyuVP0q381CCGfU6fJ7IvZvAInzSTAa
         cQVyzz6x9/nEhLIWKlazhJXZRcwDS3CK5O24v5VLxs2qJr0OOrKRgzFUvS+IHFDz4R
         19RqzkxRteJ3k8KQ+JbViNy2cy7P6eypNPoR+KgPdclq5HDMnaBUqEl6sgTvYRHsCN
         WiRZ1CjEyp6+A==
Date:   Tue, 16 May 2023 14:55:26 +0100
From:   Will Deacon <will@kernel.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Lepton Wu <lepton@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Adam Skladowski <a39.skl@gmail.com>,
        "moderated list:ARM SMMU DRIVERS" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] iommu/arm-smmu-qcom: Fix missing adreno_smmu's
Message-ID: <20230516135525.GC30894@willie-the-truck>
References: <20230511145908.597683-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511145908.597683-1-robdclark@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 07:59:05AM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> When the special handling of qcom,adreno-smmu was moved into
> qcom_smmu_create(), it was overlooked that we didn't have all the
> required entries in qcom_smmu_impl_of_match.  So we stopped getting
> adreno_smmu_priv on sc7180, breaking per-process pgtables.
> 
> Fixes: 30b912a03d91 ("iommu/arm-smmu-qcom: Move the qcom,adreno-smmu check into qcom_smmu_create")
> Suggested-by: Lepton Wu <lepton@chromium.org>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index d1b296b95c86..66e191773099 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -496,20 +496,21 @@ static const struct qcom_smmu_match_data qcom_smmu_500_impl0_data = {
>  /*
>   * Do not add any more qcom,SOC-smmu-500 entries to this list, unless they need
>   * special handling and can not be covered by the qcom,smmu-500 entry.
>   */
>  static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
>  	{ .compatible = "qcom,msm8996-smmu-v2", .data = &msm8996_smmu_data },
>  	{ .compatible = "qcom,msm8998-smmu-v2", .data = &qcom_smmu_v2_data },
>  	{ .compatible = "qcom,qcm2290-smmu-500", .data = &qcom_smmu_500_impl0_data },
>  	{ .compatible = "qcom,qdu1000-smmu-500", .data = &qcom_smmu_500_impl0_data  },
>  	{ .compatible = "qcom,sc7180-smmu-500", .data = &qcom_smmu_500_impl0_data },
> +	{ .compatible = "qcom,sc7180-smmu-v2", .data = &qcom_smmu_v2_data },
>  	{ .compatible = "qcom,sc7280-smmu-500", .data = &qcom_smmu_500_impl0_data },
>  	{ .compatible = "qcom,sc8180x-smmu-500", .data = &qcom_smmu_500_impl0_data },
>  	{ .compatible = "qcom,sc8280xp-smmu-500", .data = &qcom_smmu_500_impl0_data },
>  	{ .compatible = "qcom,sdm630-smmu-v2", .data = &qcom_smmu_v2_data },
>  	{ .compatible = "qcom,sdm845-smmu-v2", .data = &qcom_smmu_v2_data },
>  	{ .compatible = "qcom,sdm845-smmu-500", .data = &sdm845_smmu_500_data },
>  	{ .compatible = "qcom,sm6115-smmu-500", .data = &qcom_smmu_500_impl0_data},
>  	{ .compatible = "qcom,sm6125-smmu-500", .data = &qcom_smmu_500_impl0_data },
>  	{ .compatible = "qcom,sm6350-smmu-v2", .data = &qcom_smmu_v2_data },
>  	{ .compatible = "qcom,sm6350-smmu-500", .data = &qcom_smmu_500_impl0_data },
> @@ -540,12 +541,18 @@ struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
>  		/* Match platform for ACPI boot */
>  		if (acpi_match_platform_list(qcom_acpi_platlist) >= 0)
>  			return qcom_smmu_create(smmu, &qcom_smmu_500_impl0_data);
>  	}
>  #endif
>  
>  	match = of_match_node(qcom_smmu_impl_of_match, np);
>  	if (match)
>  		return qcom_smmu_create(smmu, match->data);
>  
> +	/* If you hit this WARN_ON() you are missing an entry in the
> +	 * qcom_smmu_impl_of_match[] table, and GPU per-process page-
> +	 * tables will be broken.
> +	 */
> +	WARN_ON(of_device_is_compatible(np, "qcom,adreno-smmu"));

Wouldn't it be better to print the information from the comment, rather
than force the user to diagnose a WARN_ON() back to the source?

Will
