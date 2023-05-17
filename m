Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106FD707082
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjEQSOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 14:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjEQSOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:14:20 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0818697
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 11:14:01 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3f52009f79dso1824951cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 11:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20221208.gappssmtp.com; s=20221208; t=1684347240; x=1686939240;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cIsKo+Rm7KfIjye8eF4zvalj6Z+h8gM9MUxkgWOisgM=;
        b=ttwZeU9UZclhUw8/DU3vTFExjFlUH3xBwirqJeiOLP+HJvJTE/vhOwchnTwVUSkAiZ
         /EI9vWJUeAu8bt2KhnWQaCu2Je5oeQ5A4wCnDsrirgS46TRq1HLdVRfHIzDQTMeiKYtZ
         TWjrujI+Y2gArrRtyiO8BoCcwEZjJqmUsxFEWsftoprVIavuh0XOEA3jY/xmg2V6yQUA
         X8MFwijoQm44UsBWg4xAhP5CcTRaLXOAmvOqHW+FX8VHmp6NBjXjEn4Vky7HrEs2vgSK
         YX83o/sS4STCDW1Opm4/VeSq+KcNKc1rxn0hsBl0i8FOdaj9oP1IuI30+zQh6xMjqUwR
         FGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684347240; x=1686939240;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cIsKo+Rm7KfIjye8eF4zvalj6Z+h8gM9MUxkgWOisgM=;
        b=YFFRvx2LLDTi5oeqk4L40FlhgrF7EWANrTKTip4UBfka5Vk6z2JRZValXOY1QBPoRU
         wLvspysicVrG0NHIJ5nmuGVKnkUZSSeypjZLXEdgE0PlvBx31znQwq+lWZaVMDNhCOiA
         sfMdGrLW7zX+vIUTWT8Ihr4fqP1/1nubtMyzAijNC7b7ypf0UAxwCv23pBtSVeV6Gm80
         Hqg/VqejjiU//B5dPQbPHvtyOyJOGxcpom6rgTeEpZAqeSPbXm1nU/qvk0+uHFzxEDsZ
         y9UKtmPgcG0pXq+NND7shqXn6x69vTzyCHvzaYQCR4VCn+6Csa+qD8lG863XLAkAbYoH
         1Guw==
X-Gm-Message-State: AC+VfDwJ6v5x23+4mKHCDkMckhL0YuYTWLR9vGeTRj/3AWuckqmi1Tmj
        gam++MC1C/LiBuSL7WwDB/R7NoimWhMt/dUXvaM=
X-Google-Smtp-Source: ACHHUZ6xCvOPB/9FWAGC3QmUe2dmsJ2C7F8D+jHxYJqWVQxCnZoCMrOdI2fWSUBK41RXKygoHSjquA==
X-Received: by 2002:a05:622a:153:b0:3f5:954:3fbb with SMTP id v19-20020a05622a015300b003f509543fbbmr779808qtw.28.1684347240334;
        Wed, 17 May 2023 11:14:00 -0700 (PDT)
Received: from [192.168.0.189] (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id i23-20020a05620a145700b00759300a1ef9sm803029qkl.31.2023.05.17.11.13.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 11:13:59 -0700 (PDT)
Subject: Re: [Freedreno] [PATCH 5/6] drm/msm/a6xx: Use GMU_ALWAYS_ON_COUNTER
 for GMU-equipped GPUs in timestamp
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        freedreno@lists.freedesktop.org
References: <20230517-topic-a7xx_prep-v1-0-7a964f2e99c2@linaro.org>
 <20230517-topic-a7xx_prep-v1-5-7a964f2e99c2@linaro.org>
From:   Jonathan Marek <jonathan@marek.ca>
Message-ID: <aaab25be-3403-518d-e639-c80b0930906a@marek.ca>
Date:   Wed, 17 May 2023 14:09:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20230517-topic-a7xx_prep-v1-5-7a964f2e99c2@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AFAIK GMU_ALWAYS_ON_COUNTER does not have the same value as 
CP_ALWAYS_ON_COUNTER (only the same frequency), so changing this would 
break userspace expecting to be able to compare the value returned by 
MSM_PARAM_TIMESTAMP with CP timestamp values.

On 5/17/23 12:50 PM, Konrad Dybcio wrote:
> Use the always-on counter provided by the GMU to skip having to
> keep the GPU online.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> index 8707e8b6ac7e..d2a999b90589 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -1664,12 +1664,9 @@ static int a6xx_get_timestamp(struct msm_gpu *gpu, uint64_t *value)
>   
>   	mutex_lock(&a6xx_gpu->gmu.lock);
>   
> -	/* Force the GPU power on so we can read this register */
> -	a6xx_gmu_set_oob(&a6xx_gpu->gmu, GMU_OOB_PERFCOUNTER_SET);
> -
> -	*value = gpu_read64(gpu, REG_A6XX_CP_ALWAYS_ON_COUNTER);
> -
> -	a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_PERFCOUNTER_SET);
> +	*value = gmu_read64(&a6xx_gpu->gmu,
> +			    REG_A6XX_GMU_ALWAYS_ON_COUNTER_L,
> +			    REG_A6XX_GMU_ALWAYS_ON_COUNTER_H);
>   
>   	mutex_unlock(&a6xx_gpu->gmu.lock);
>   
> 
