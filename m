Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8377649D74
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 12:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbiLLLWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 06:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbiLLLV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 06:21:58 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A0E656C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 03:20:21 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id z26so104537lfu.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 03:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ds1hOC+51hj11fCUViYpPSQxr8FkVZNzM9T5gdhTwsw=;
        b=Hz9qip5z9D0crBWl3/XgYxi+mLsK2KSsnlFR88ntWeICN92BM6ZwHYQ7TPyv7Etuge
         fjp4pe7399woH49S6PbAzSqyUOl0nueVSLyGpdNiJwJkomnNU2jHeSybvGyDYwsIAFG/
         oyhFmHBjCS6YLXw4Gmo5/KqCAbG+10UVMZwNSprBWrNw1pwGESe1pDmp++BLVqu/X6dA
         F1m9I5JOGMCbJeo++VTKT5v1iIudovZ5+F3WeALTZTi8XUBl6m4xtTtOQOQ/SEkU8p+V
         BC09pDfWmG9VsvTDRhyzKcxo6UcSHQzn+4Rt5L8apNNXv1C2edoaOTv5t17hMtuo2owW
         PyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ds1hOC+51hj11fCUViYpPSQxr8FkVZNzM9T5gdhTwsw=;
        b=55dLBDP9o9jOoKwL7r+3hK9EoNuqihb7hcp7M6kiLv26q/7umPtxkZxtd6Ntsdthrv
         KamXMXdDjxBt45KCQBtXFuR/mhmFRx5cKTSPHpvFrsbfQlskqsmRDqbgl877Z+4R/x+j
         /q7pTueEq/uijldHHEaGiiZBNlazm3JBVyL5VrMlQ5MKiUZr09jD1D99jHRPVPAgwi0D
         vUG3pKGiqJxaGA5FTEIPtwHKu6HOydhFCHIuH/QDIyT7KZLepU57Ot7lkpXyVcStATTH
         KV/pVER1o9qYlYtO3QYUlfsY9G5Spi14ULp16Q+e/JDodtlBFEss2AF/kf3w91jTc6BR
         RbLw==
X-Gm-Message-State: ANoB5plsrz3FqDg41+JTo33/s5uawI6HwRJfNBLjwbmvwuYXtUSCTdY5
        dyKF2iG3IeL0JqspLiM31cxsxw==
X-Google-Smtp-Source: AA0mqf6tLiVUJeAowyx3FkHUYgxKVqJXgW8BgWc3cNEaJy4ED+DeX/XFuIhf8Gp8WDB/EdtCjxInjg==
X-Received: by 2002:ac2:4f0e:0:b0:4a4:68b7:d655 with SMTP id k14-20020ac24f0e000000b004a468b7d655mr4481995lfr.60.1670844020358;
        Mon, 12 Dec 2022 03:20:20 -0800 (PST)
Received: from [127.0.0.1] ([94.25.229.102])
        by smtp.gmail.com with ESMTPSA id p23-20020a056512329700b004b5853f0fc6sm1593838lfe.246.2022.12.12.03.20.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Dec 2022 03:20:19 -0800 (PST)
Date:   Mon, 12 Dec 2022 14:20:16 +0300
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
CC:     marijn.suijten@somainline.org, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Rob Clark <robdclark@chromium.org>,
        Adam Skladowski <a39.skl@gmail.com>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Add SM8150 DPU compatible
User-Agent: K-9 Mail for Android
In-Reply-To: <57d3ba20-f1de-d7f3-d689-b25a02174379@linaro.org>
References: <20221212100617.18190-1-konrad.dybcio@linaro.org> <552EFDD5-4BBE-408D-90EA-C96F4A0876B7@linaro.org> <57d3ba20-f1de-d7f3-d689-b25a02174379@linaro.org>
Message-ID: <CAC2A315-5861-4324-849D-3EBF793146EA@linaro.org>
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



On 12 December 2022 14:00:10 GMT+03:00, Konrad Dybcio <konrad=2Edybcio@lin=
aro=2Eorg> wrote:
>
>
>On 12=2E12=2E2022 11:58, Dmitry Baryshkov wrote:
>>=20
>>=20
>> On 12 December 2022 13:06:16 GMT+03:00, Konrad Dybcio <konrad=2Edybcio@=
linaro=2Eorg> wrote:
>>> From: Marijn Suijten <marijn=2Esuijten@somainline=2Eorg>
>>>
>>> Add the SM8150 DPU compatible to clients compatible list, as it also
>>> needs the workarounds=2E
>>=20
>> Please rebase on top of linux-next, this part was rewritten=2E
>This one wasn't, but yeah it is based on some local changes
>(see 6350/6375)=2E=2E

It was,

https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/next/linux-next=2Egit/=
tree/drivers/iommu/arm/arm-smmu/arm-smmu-qcom=2Ec?h=3Dnext-20221208#n498

>
>Konrad
>>=20
>>=20
>>>
>>> Signed-off-by: Marijn Suijten <marijn=2Esuijten@somainline=2Eorg>
>>> Signed-off-by: Konrad Dybcio <konrad=2Edybcio@linaro=2Eorg>
>>> ---
>>> Depends on the binding here:
>>>
>>> [1] https://lore=2Ekernel=2Eorg/linux-arm-msm/20221212093315=2E11390-1=
-konrad=2Edybcio@linaro=2Eorg/T/#t
>>>
>>> drivers/iommu/arm/arm-smmu/arm-smmu-qcom=2Ec | 1 +
>>> 1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom=2Ec b/drivers/io=
mmu/arm/arm-smmu/arm-smmu-qcom=2Ec
>>> index 6610f5d2877d=2E=2Ecd74c1efcfde 100644
>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom=2Ec
>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom=2Ec
>>> @@ -255,6 +255,7 @@ static const struct of_device_id qcom_smmu_client_=
of_match[] __maybe_unused =3D {
>>> 	{ =2Ecompatible =3D "qcom,sdm845-mss-pil" },
>>> 	{ =2Ecompatible =3D "qcom,sm6350-mdss" },
>>> 	{ =2Ecompatible =3D "qcom,sm6375-mdss" },
>>> +	{ =2Ecompatible =3D "qcom,sm8150-mdss" },
>>> 	{ =2Ecompatible =3D "qcom,sm8250-mdss" },
>>> 	{ }
>>> };
>>=20

--=20
With best wishes
Dmitry
