Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA894686768
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 14:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjBANsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 08:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbjBANsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:48:07 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8793755D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 05:48:05 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id bk15so51518235ejb.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 05:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+ls5wtJ6Hfc+JvUhlGR4xji5YGsJ7LEo3VaBr3I5PfU=;
        b=qR2yX5Y+aRZrBkYeonU56wiifAgLOsoqz6bKynEf5uErCKArEXxPvKYYWDc5GmfE6S
         52hlSedvFXg+DMsJCSJ8ZoidCU4JOsjvKcNvVtW9pVu5XQXsbKZchlCsmqDmN3tke71b
         dYKy1lmIPKfWsWnH482VI1Dn1PzVw3Ck0NPi01U9nIkL96fCzyuLdc9Paeg2XCOhh435
         KZ6SAzn4SgZxlwhdNEUzLPvYh48rd2CVrdyJfpcdqXJySBVH8GK2Si+2m002xzcRQqp9
         W6D8XbBKHK+M52AeUv4oXXCjmHJiSVBLIE+pdwrODBCtGi4sp28TsjtArLD+7t5b4qJ9
         2kIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ls5wtJ6Hfc+JvUhlGR4xji5YGsJ7LEo3VaBr3I5PfU=;
        b=bozN8cZiTEjHUs1fHCNUfQBK6xt2Kl78tCVwP1zaT3vzWiUDeYyCQ3bpGAP8tfDQBd
         TkXVjG9cMGi776EenGKLjoWkqPrg+gk81/Q4JSQUgrOBmQXAnsiBxLVELoXe14YvinPf
         D86P39SaLrp60Sa36ylJqF662ZruPapSNyxGaGb40vbUOE60CBBUVrGxyeeAH9mYdYj+
         FjgCCHAsN9K+A3ttnliCDuqA8q8InUUbKNfdf/UD1+ayTzfRAo0My2d06KP8xkGUE8Es
         1MV/lg9QemoAxDRU3m0h5fVsnk8+upeYy1U7lqXWksehirot6FS27XaikVIwRNwpLjis
         9v1g==
X-Gm-Message-State: AO0yUKWWo59nbMKNUV+uqoI6NI7IN29jPTKXTPYtsY/obX6JDVmTqYeF
        IDlKC1nmblP5fHrqIFk6yVuBMQ==
X-Google-Smtp-Source: AK7set/X5KevUerlVy7HuQadHyk1nRFk3U/EKr6KdRWVgUB4dwlQ/WlSDZaUoJD+MefWqOsdrT+q9Q==
X-Received: by 2002:a17:906:184a:b0:87f:e07d:ce5f with SMTP id w10-20020a170906184a00b0087fe07dce5fmr2474217eje.9.1675259284443;
        Wed, 01 Feb 2023 05:48:04 -0800 (PST)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id z2-20020a170906714200b00888161349desm5103078ejj.182.2023.02.01.05.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 05:48:03 -0800 (PST)
Message-ID: <38466a0f-686d-ab19-2669-e81ca6d6ec17@linaro.org>
Date:   Wed, 1 Feb 2023 15:48:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [v1 2/3] drm/msm/disp/dpu1: add dspps into reservation if there
 is a ctm request
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Kalyan Thota <quic_kalyant@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@chromium.org,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, quic_abhinavk@quicinc.com
References: <1675092092-26412-1-git-send-email-quic_kalyant@quicinc.com>
 <1675092092-26412-3-git-send-email-quic_kalyant@quicinc.com>
 <20230201111604.htgczy6yvdkywhvl@SoMainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230201111604.htgczy6yvdkywhvl@SoMainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2023 13:16, Marijn Suijten wrote:
> On 2023-01-30 07:21:31, Kalyan Thota wrote:
>> Add dspp blocks into the topology for reservation, if there is a ctm
>> request for that composition.
> 
> DSPP
> 
>> Changes in v1:
>> - Minor nits (Dmitry)
> 
> This should go below the triple dashes, so that it /does not/ become
> part of the patch/commit that is applied to the tree (where review
> history is irrelevant as it can be searched for separately).

This is one of DRM peculiarities which we have to live with.

> 
>> Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 13 ++++++-------
>>   1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>> index 9c6817b..3bd46b4 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
>> @@ -545,7 +545,8 @@ bool dpu_encoder_use_dsc_merge(struct drm_encoder *drm_enc)
>>   static struct msm_display_topology dpu_encoder_get_topology(
>>   			struct dpu_encoder_virt *dpu_enc,
>>   			struct dpu_kms *dpu_kms,
>> -			struct drm_display_mode *mode)
>> +			struct drm_display_mode *mode,
>> +			struct drm_crtc_state *crtc_state)
>>   {
>>   	struct msm_display_topology topology = {0};
>>   	int i, intf_count = 0;
>> @@ -573,11 +574,9 @@ static struct msm_display_topology dpu_encoder_get_topology(
>>   	else
>>   		topology.num_lm = (mode->hdisplay > MAX_HDISPLAY_SPLIT) ? 2 : 1;
>>   
>> -	if (dpu_enc->disp_info.intf_type == DRM_MODE_ENCODER_DSI) {
>> -		if (dpu_kms->catalog->dspp &&
>> -			(dpu_kms->catalog->dspp_count >= topology.num_lm))
>> -			topology.num_dspp = topology.num_lm;
>> -	}
>> +	if (dpu_kms->catalog->dspp &&
>> +	    crtc_state->ctm && (dpu_kms->catalog->dspp_count >= topology.num_lm))
> 
> Multiline-if-clause is typically indented with two tabs, not a half tab
> (4 spaces).

I tend to disagree here. Lately I have mostly seen it being indented to 
the opening parenthesis, so that nested statements also indent nicely.

> Nit: swap the && here?  dspp and dspp_count are related, so check ctm
> first or last but not in the middle - makes reading easier.

I think we can ignore dpu_kms->catalog->dspp completely. checking 
dspp_count should be enough for the purpose of the check (and note, the 
check for dspp/dspp_count is misleading and should be omitted).

> 
>> +		topology.num_dspp = topology.num_lm;
>>   
>>   	topology.num_enc = 0;
>>   	topology.num_intf = intf_count;
>> @@ -643,7 +642,7 @@ static int dpu_encoder_virt_atomic_check(
>>   		}
>>   	}
>>   
>> -	topology = dpu_encoder_get_topology(dpu_enc, dpu_kms, adj_mode);
>> +	topology = dpu_encoder_get_topology(dpu_enc, dpu_kms, adj_mode, crtc_state);
>>   
>>   	/* Reserve dynamic resources now. */
>>   	if (!ret) {
>> -- 
>> 2.7.4
>>

-- 
With best wishes
Dmitry

