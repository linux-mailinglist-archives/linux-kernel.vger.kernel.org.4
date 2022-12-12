Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF99564A1BA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbiLLNoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbiLLNn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:43:56 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7A514087
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:43:42 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id c1so18643714lfi.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LlNSc60ZEW+VzadcTtuvtEZT642+BCsZkZyfuK93bU0=;
        b=vzxDbaRKh1TQ5/DeXhU54jbEFtJJE+Vtqu0Ns4nw492JK2svhI/svde87/WtSlBo0F
         /wp29d6vIDSHkgKEx64uYuFiVG4MJ4WsWG/PO0hjgCvKCmKh6893lyx/PFD+EABCucxl
         DZ2kOcttyZ68yFiCKQOcf1VWoDRuJiuhXov47Rfm1STzseTy9OAJxNWaKp2D2cSoUryX
         +vPOBYUSA2+pYHmThbSBVfZtWWdg+jzyfd/V7q8vbMtjiPliGon9Puz4geLE/bxesagK
         ME7ADxTICKrEBs5CBH/D8ipKJrKtouV2jJ3Hl47DxM+0z8lz0H9mVj019QCHXyTEVJrf
         19pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LlNSc60ZEW+VzadcTtuvtEZT642+BCsZkZyfuK93bU0=;
        b=cXHiF5Exk/aDvJM8mVDKqD1lc8JF/UhnYeqIve8v9LRuxkZG/WTk7TQHibVMbUEuvR
         D0jBdjpw7tEoW1ShVrhMnEKX6LyON/p+3yz9yqp1fPoWt+I9Zu84+itdEVRlcz63I7gq
         c5H+IScmXPMiN8+Ug33mocdhh4GIruqIjtwa80ckyRI8KI7uI0s5CzjTz3HEzbsoFiSO
         hgpyMAu6REKWSiRC/G7Gk8OJ+xeTews+hxi6SQ5dXZYd51r/JWPD1oA19BQpAPqgmgR8
         wSr564OVOShXvewZexklAYJaEvm8RsfNhp3anAfU219U/eeLrZG3WHKdgiLotOAe28Up
         D8Nw==
X-Gm-Message-State: ANoB5pkwx0RSn79GbpOukusay2EpvJ27RKyikjJ4iyx7b0eujSbBAMxv
        OvhCz1GutjOlJ6WYdld8BBTzOQ==
X-Google-Smtp-Source: AA0mqf6iieQPyfMoTtuY5t5RV7tMQk1d4Hxa8XKrKZzjh8dWgg3gVaJqHnbBTSXzYJRnJ+zrRQ+50Q==
X-Received: by 2002:a19:f00b:0:b0:4b5:7dd6:4df0 with SMTP id p11-20020a19f00b000000b004b57dd64df0mr3672610lfc.32.1670852621039;
        Mon, 12 Dec 2022 05:43:41 -0800 (PST)
Received: from [127.0.0.1] ([94.25.229.102])
        by smtp.gmail.com with ESMTPSA id w6-20020a05651234c600b004b5480edf67sm1653404lfr.36.2022.12.12.05.43.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Dec 2022 05:43:40 -0800 (PST)
Date:   Mon, 12 Dec 2022 16:43:36 +0300
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
CC:     marijn.suijten@somainline.org, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Emma Anholt <emma@anholt.net>,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/arm-smmu-qcom: Add SM8150 DPU compatible
User-Agent: K-9 Mail for Android
In-Reply-To: <20221212121054.193059-1-konrad.dybcio@linaro.org>
References: <20221212121054.193059-1-konrad.dybcio@linaro.org>
Message-ID: <B63B8438-BE40-4E75-8F61-29A507524D1E@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12 December 2022 15:10:53 GMT+03:00, Konrad Dybcio <konrad=2Edybcio@lin=
aro=2Eorg> wrote:
>From: Marijn Suijten <marijn=2Esuijten@somainline=2Eorg>
>
>Add the SM8150 DPU compatible to clients compatible list, as it also
>needs the workarounds=2E
>
>Signed-off-by: Marijn Suijten <marijn=2Esuijten@somainline=2Eorg>
>Signed-off-by: Konrad Dybcio <konrad=2Edybcio@linaro=2Eorg>

Reviewed-by: Dmitry Baryshkov<dmitry=2Ebaryshkov@linaro=2Eorg>

>---
>Changes since v1:
>- rebase on clean -next
>
> drivers/iommu/arm/arm-smmu/arm-smmu-qcom=2Ec | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom=2Ec b/drivers/iommu=
/arm/arm-smmu/arm-smmu-qcom=2Ec
>index 91d404deb115=2E=2Eed884c85e262 100644
>--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom=2Ec
>+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom=2Ec
>@@ -250,6 +250,7 @@ static const struct of_device_id qcom_smmu_client_of_=
match[] __maybe_unused =3D {
> 	{ =2Ecompatible =3D "qcom,sc7280-mdss" },
> 	{ =2Ecompatible =3D "qcom,sc7280-mss-pil" },
> 	{ =2Ecompatible =3D "qcom,sc8180x-mdss" },
>+	{ =2Ecompatible =3D "qcom,sm8150-mdss" },
> 	{ =2Ecompatible =3D "qcom,sm8250-mdss" },
> 	{ =2Ecompatible =3D "qcom,sdm845-mdss" },
> 	{ =2Ecompatible =3D "qcom,sdm845-mss-pil" },

--=20
With best wishes
Dmitry
