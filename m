Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5E66FF518
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238446AbjEKOxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238643AbjEKOwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:52:31 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1461163E
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 07:51:56 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50bc040c7b8so13293187a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 07:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683816715; x=1686408715;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0sCDEYQ+lAwwMEzBoHzHhTtsRYd3XM3A3Tyzt01HFvA=;
        b=mtPBUKQsWIlBp4e49W2yOkynlqDVHyfPbTN2fmMgQkVydDzOWHguXHqbQVzF+v+AAy
         9QG9Bap4DMMbaZTgBgScyK7fzfUv7oi1UazTId8pZ0kF72X6C1Bk0ZRpA/sCRpPSM6c7
         LlDEOs7ZHM4zxnAbSZk556uDtQxp7ZqwAA+8tw0DMcaG7G0x7WhaQBwIIF65AkErvfYg
         Wv9iWoNkWV+w5QkB2iR983OxWYQgJP8KCarY1JD74jznB+tX4BNZhQeo0zvS+ztL+5Hg
         MO1ncCKr8zzLXW6DYTDER1r3r8CUP2eLigJMFOYonulsPfpmApeajTXJYEOaPVN15iwh
         PDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683816715; x=1686408715;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0sCDEYQ+lAwwMEzBoHzHhTtsRYd3XM3A3Tyzt01HFvA=;
        b=OpaCiYS3xv2dxxhM5S//69S1bou7Wf2ZWmcKLWfyizYwTH+JEqdWQ6pYT9hltOsmlz
         oKUNQw5wie8BRcuWTqxuMVs+IxPl4MYoL3iDXJX9QwS2aAJCWqx6lbE2lmlcuxDSfW0e
         o3UplQVfQqCcUlgzufntbckIfTPmfkeRxUnR/MGig0/j94BKNVvvxsr6Gpu9O80S7CTq
         Y41JgbnIPgSLXOPHM5I3ykDL329eG/CUiJU4sLYaBbVSF3zRnlq2FDnltDkaeErOQnbD
         mbWsywa8CUUUZwgPRwC6NHsQhASQtnWoBmzwf4nBPD4AAJUtFw6uuUGxAh1r/hmH27a1
         eHuA==
X-Gm-Message-State: AC+VfDx5jXyB1BWcRH8fiTfA04jIk2CedLj9eFhYX0TVNyGmqisRw8Hp
        P2s/OxwCGkVlfSFWjsBqYa/H90Qgr97G/Rmfr8w6Xg==
X-Google-Smtp-Source: ACHHUZ5v+1zYrVOKi/Ghck/qxazn4S4a54LG3s/j3dKBOosBgCgbc+lcxrX3cV6IcluE1NS3v3DGkoZujZK00d/9fp0=
X-Received: by 2002:a17:907:d09:b0:961:8fcd:53ca with SMTP id
 gn9-20020a1709070d0900b009618fcd53camr21830645ejc.65.1683816715418; Thu, 11
 May 2023 07:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230509163712.376117-1-robdclark@gmail.com>
In-Reply-To: <20230509163712.376117-1-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 11 May 2023 17:51:43 +0300
Message-ID: <CAA8EJppVaCuh1kp7842pHt=5sWSBVaf18fZGC6ifmsQKgGNVSw@mail.gmail.com>
Subject: Re: [PATCH 1/2] iommu/arm-smmu-qcom: Fix missing adreno_smmu's
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Lepton Wu <lepton@chromium.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Emma Anholt <emma@anholt.net>,
        "moderated list:ARM SMMU DRIVERS" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 May 2023 at 19:37, Rob Clark <robdclark@gmail.com> wrote:
>
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
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index d1b296b95c86..760d9c43dbd2 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -496,20 +496,21 @@ static const struct qcom_smmu_match_data qcom_smmu_500_impl0_data = {
>  /*
>   * Do not add any more qcom,SOC-smmu-500 entries to this list, unless they need
>   * special handling and can not be covered by the qcom,smmu-500 entry.
>   */
>  static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
>         { .compatible = "qcom,msm8996-smmu-v2", .data = &msm8996_smmu_data },
>         { .compatible = "qcom,msm8998-smmu-v2", .data = &qcom_smmu_v2_data },
>         { .compatible = "qcom,qcm2290-smmu-500", .data = &qcom_smmu_500_impl0_data },
>         { .compatible = "qcom,qdu1000-smmu-500", .data = &qcom_smmu_500_impl0_data  },
>         { .compatible = "qcom,sc7180-smmu-500", .data = &qcom_smmu_500_impl0_data },
> +       { .compatible = "qcom,sc7180-smmu-v2", .data = &qcom_smmu_v2_data },
>         { .compatible = "qcom,sc7280-smmu-500", .data = &qcom_smmu_500_impl0_data },
>         { .compatible = "qcom,sc8180x-smmu-500", .data = &qcom_smmu_500_impl0_data },
>         { .compatible = "qcom,sc8280xp-smmu-500", .data = &qcom_smmu_500_impl0_data },
>         { .compatible = "qcom,sdm630-smmu-v2", .data = &qcom_smmu_v2_data },
>         { .compatible = "qcom,sdm845-smmu-v2", .data = &qcom_smmu_v2_data },
>         { .compatible = "qcom,sdm845-smmu-500", .data = &sdm845_smmu_500_data },
>         { .compatible = "qcom,sm6115-smmu-500", .data = &qcom_smmu_500_impl0_data},
>         { .compatible = "qcom,sm6125-smmu-500", .data = &qcom_smmu_500_impl0_data },
>         { .compatible = "qcom,sm6350-smmu-v2", .data = &qcom_smmu_v2_data },
>         { .compatible = "qcom,sm6350-smmu-500", .data = &qcom_smmu_500_impl0_data },
> @@ -540,12 +541,14 @@ struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
>                 /* Match platform for ACPI boot */
>                 if (acpi_match_platform_list(qcom_acpi_platlist) >= 0)
>                         return qcom_smmu_create(smmu, &qcom_smmu_500_impl0_data);
>         }
>  #endif
>
>         match = of_match_node(qcom_smmu_impl_of_match, np);
>         if (match)
>                 return qcom_smmu_create(smmu, match->data);
>
> +       WARN_ON(of_device_is_compatible(np, "qcom,adreno-smmu"));

Could you please add a comment here, noting the reason? Or maybe we
should  change that to:
if (WARN_ON(...))
  return ERR_PTR(-EINVAL);

> +
>         return smmu;
>  }
> --
> 2.40.1
>


-- 
With best wishes
Dmitry
