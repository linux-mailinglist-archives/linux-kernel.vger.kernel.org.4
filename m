Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C426FF41A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237798AbjEKO0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237976AbjEKO0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:26:07 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E89E72;
        Thu, 11 May 2023 07:25:59 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3943fdc59f9so831550b6e.0;
        Thu, 11 May 2023 07:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683815158; x=1686407158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUMshOhJ/jCmOAXf0wSXeoJInJRRSEiHUd4QhJk0RRA=;
        b=DBl+lObSFhApj2jZOTQrUAOrwRIAf4xArfq5YCzK0SszrY7+8QX++/DM1qlgt14Z4R
         qEopsANTv+hPnlePep+XdcNtxdNulvw4P5qNfXchJTTbUCd4MSP29UPZAWuBhn0ffsNe
         uhXM+8dw1jy9CJHT+Ql38XqBeVvflRY7TBo3m4f6CCuzjIKoMFKj/JS2HWrh7bdfKWuB
         jUFxRKvMdOMAQoKc0pJI563yjY1+zqSRmyDiRVXpx0HsB3WrccNCpvBiX+VEv4xtPcB7
         UtSTAo8Q5KxkKiY0EdMzMlhESgiq2VDLZO4Z51EjGPKslAyjqv3+PuBbQGS8w2KckX/T
         1POw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683815158; x=1686407158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EUMshOhJ/jCmOAXf0wSXeoJInJRRSEiHUd4QhJk0RRA=;
        b=cmePXZSwbzSMfEkHOcuhmkK7qY0voJGx3ke0/hqLx7FVrXsM9Jr8mDSd+PEjVdf944
         AzFWHkBUAhX6Qrx+Q+hH8MWWkUzb7I6Lo3+GGGtJDbUFEeoxZGnhQLG/op71J+64AbfK
         9yprxpe3fVbqAP79xhDT7SkOE+ayMxSc99BlUNlNtZwjyIOvOjD+eUk3XbFqLZ1cN4WW
         5RBGnbkmMAhj7CwCXdeoUjCnh8Pvmn7+ZS1ySutDW/iF45aAdwZyXprrrdolj+dG99rI
         iAOs9+yzNvcXTBHPf4vbVb/aA56GqpDEj1++RBG34RazBjkoTWgKLWiGU0TcaNNyt4fF
         antA==
X-Gm-Message-State: AC+VfDyjChrB4ZWBHCFIlDl9K03HamgtrOhI80UnXMA6G5BZci66IqMW
        gns5wVPccCSqJVJu2J6Fy4UtUTztjPnoK8GAf+A=
X-Google-Smtp-Source: ACHHUZ7poZgOitdfQqtIlPzYx5Qk56gFW9JRYK0fJ/hsY7AKW7RFp3/ZwhYX+SOn+yAUhmAJCncEuRY5yF/6vgL4jRQ=
X-Received: by 2002:a05:6808:59:b0:38e:eaf:cf29 with SMTP id
 v25-20020a056808005900b0038e0eafcf29mr4889151oic.29.1683815157913; Thu, 11
 May 2023 07:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230509163712.376117-1-robdclark@gmail.com>
In-Reply-To: <20230509163712.376117-1-robdclark@gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 11 May 2023 07:25:46 -0700
Message-ID: <CAF6AEGv4kThhyCEhf3NeqTSwVT5X7rgxM5nuM_jq3aFbfUHpqA@mail.gmail.com>
Subject: Re: [PATCH 1/2] iommu/arm-smmu-qcom: Fix missing adreno_smmu's
To:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 9, 2023 at 9:37=E2=80=AFAM Rob Clark <robdclark@gmail.com> wrot=
e:
>
> From: Rob Clark <robdclark@chromium.org>
>
> When the special handling of qcom,adreno-smmu was moved into
> qcom_smmu_create(), it was overlooked that we didn't have all the
> required entries in qcom_smmu_impl_of_match.  So we stopped getting
> adreno_smmu_priv on sc7180, breaking per-process pgtables.
>
> Fixes: 30b912a03d91 ("iommu/arm-smmu-qcom: Move the qcom,adreno-smmu chec=
k into qcom_smmu_create")
> Suggested-by: Lepton Wu <lepton@chromium.org>
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Any chance I could get an ack for landing this fix via msm-fixes?
Broken per-process pgtables is kind of a serious regression..

BR,
-R

> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/a=
rm/arm-smmu/arm-smmu-qcom.c
> index d1b296b95c86..760d9c43dbd2 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -496,20 +496,21 @@ static const struct qcom_smmu_match_data qcom_smmu_=
500_impl0_data =3D {
>  /*
>   * Do not add any more qcom,SOC-smmu-500 entries to this list, unless th=
ey need
>   * special handling and can not be covered by the qcom,smmu-500 entry.
>   */
>  static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[=
] =3D {
>         { .compatible =3D "qcom,msm8996-smmu-v2", .data =3D &msm8996_smmu=
_data },
>         { .compatible =3D "qcom,msm8998-smmu-v2", .data =3D &qcom_smmu_v2=
_data },
>         { .compatible =3D "qcom,qcm2290-smmu-500", .data =3D &qcom_smmu_5=
00_impl0_data },
>         { .compatible =3D "qcom,qdu1000-smmu-500", .data =3D &qcom_smmu_5=
00_impl0_data  },
>         { .compatible =3D "qcom,sc7180-smmu-500", .data =3D &qcom_smmu_50=
0_impl0_data },
> +       { .compatible =3D "qcom,sc7180-smmu-v2", .data =3D &qcom_smmu_v2_=
data },
>         { .compatible =3D "qcom,sc7280-smmu-500", .data =3D &qcom_smmu_50=
0_impl0_data },
>         { .compatible =3D "qcom,sc8180x-smmu-500", .data =3D &qcom_smmu_5=
00_impl0_data },
>         { .compatible =3D "qcom,sc8280xp-smmu-500", .data =3D &qcom_smmu_=
500_impl0_data },
>         { .compatible =3D "qcom,sdm630-smmu-v2", .data =3D &qcom_smmu_v2_=
data },
>         { .compatible =3D "qcom,sdm845-smmu-v2", .data =3D &qcom_smmu_v2_=
data },
>         { .compatible =3D "qcom,sdm845-smmu-500", .data =3D &sdm845_smmu_=
500_data },
>         { .compatible =3D "qcom,sm6115-smmu-500", .data =3D &qcom_smmu_50=
0_impl0_data},
>         { .compatible =3D "qcom,sm6125-smmu-500", .data =3D &qcom_smmu_50=
0_impl0_data },
>         { .compatible =3D "qcom,sm6350-smmu-v2", .data =3D &qcom_smmu_v2_=
data },
>         { .compatible =3D "qcom,sm6350-smmu-500", .data =3D &qcom_smmu_50=
0_impl0_data },
> @@ -540,12 +541,14 @@ struct arm_smmu_device *qcom_smmu_impl_init(struct =
arm_smmu_device *smmu)
>                 /* Match platform for ACPI boot */
>                 if (acpi_match_platform_list(qcom_acpi_platlist) >=3D 0)
>                         return qcom_smmu_create(smmu, &qcom_smmu_500_impl=
0_data);
>         }
>  #endif
>
>         match =3D of_match_node(qcom_smmu_impl_of_match, np);
>         if (match)
>                 return qcom_smmu_create(smmu, match->data);
>
> +       WARN_ON(of_device_is_compatible(np, "qcom,adreno-smmu"));
> +
>         return smmu;
>  }
> --
> 2.40.1
>
