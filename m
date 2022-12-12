Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0F9649D8B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 12:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiLLL11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 06:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbiLLL1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 06:27:12 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A864218
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 03:27:11 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id g14so8187793ljh.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 03:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SYgOtZw9znmM18Bxofo92UISYFqQiYZ/goOB6oLrU4M=;
        b=zDAKEQyHnBH4T7hWXM2iQ2ZyMscW0p/KFIhBpiS7UmSguj5AELRyIa5YqyabCec2KE
         uG7QN5KbP37b/o7I8KrZuB8MVRj2eAnNOyuu+g5YBVGf0noxtXiQzEZsGd9YBh3raAIo
         XXhYl3A8VjmT60Ia/YdrmeJqN6kIY2LxcaF9aNDkaaTW0OH/Kcj1KW2u4aVJv41EaFBI
         ZQUAtOFyYNRahYO40Ge5y5K1mWe5zq/X7Un4K6+Cu1pK0kAuqMUeYSmWsOfsCBBTxFor
         xFUgwJ8IWkAvqSqxbwy6c8x242LCwhkZWJvZbRZT0eNfSO47i4R0SiUYfeZPZ9ggo5q7
         nh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SYgOtZw9znmM18Bxofo92UISYFqQiYZ/goOB6oLrU4M=;
        b=ZxVh+2Ruod4zJCJoBqG28TfTrJj0zXxZd0Vfg1nY/pf0nvss+naQXJ4x6B3hE0J/Ah
         aUWtSRn4bIkEX6vDTtVILeLKbfGGgw2rvHF4L8NxSIXPUuuokZBQPlD2ImLz6vVTfc3U
         VnHA03vxV+kLheTpsNhWsAsaZd1M2ge03VNIQOQV8XnI2Ar4W4PKKfcuQtKSAdapvX7+
         oTbhUhzOZ40Uqnjuge25Qa/Ny7o6qPY0kWfxvYuVdKk9QxWXU+P/S9ZuyfVcUFlmWyQn
         PMRvcBBruGgVM2QL1poYVfcM4IaBnrb4RI2nIXhCf5grWJUaIh13XBtsI58Q/JQiUS5O
         xEqw==
X-Gm-Message-State: ANoB5pmIlvm1E3nkga4a/1rXhSuPsS98nlfPaABR4qWsCGNiquIp0rZ9
        d1vpW4E8MjwF7M9hCOWV18xgiA==
X-Google-Smtp-Source: AA0mqf7s6nDwJ0mujrNOuKHp86AEzHjfJ+El29BHWJ5OzsKN4xhfcRSPFhR71AsSPGS0MiT/otx7SQ==
X-Received: by 2002:a2e:a5c6:0:b0:277:8c98:3bc3 with SMTP id n6-20020a2ea5c6000000b002778c983bc3mr3583116ljp.41.1670844429530;
        Mon, 12 Dec 2022 03:27:09 -0800 (PST)
Received: from [127.0.0.1] ([94.25.229.102])
        by smtp.gmail.com with ESMTPSA id b11-20020a2e894b000000b0026bca725cd0sm1173323ljk.39.2022.12.12.03.27.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Dec 2022 03:27:09 -0800 (PST)
Date:   Mon, 12 Dec 2022 14:27:05 +0300
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
Message-ID: <72615A58-A0AB-4C3B-A97A-96144E391EBB@linaro.org>
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

Stupid me, you are right here=2E This part wasn't changed=2E Please ignore=
 the comment=2E

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
