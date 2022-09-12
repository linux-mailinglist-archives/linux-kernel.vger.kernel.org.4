Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2805B6129
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 20:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiILSje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 14:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbiILSix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:38:53 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C483B2C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 11:37:23 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id y29so11622155ljq.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 11:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=mo0xYdjPNpZiahHOR94h5CTJKhNqWSHm+oWy5fg8cNI=;
        b=pHRztTxM4pWOgSvsoaFKzmPB9AvHg29ymH0gJF9MzsJE9BgHtsjDL1q35eLBhAoxPY
         HkNNw4IxRzUyqJCz060VxKoVLJE3d3tfyiULCc8ltdCdepERxn/BrINbFPJ3D3Fc6oXE
         Jwd2M8LB/nP7o7nfL0B6+tJa0IAIMMlAck54iffSl4PfGNQ1pTnqYIu+Rc7ZXoqcZ9CJ
         T7uel7Yb/V+pzHr9504GzFzAm2Y6yMSwwtyYDu7eTILDghqWlEkW66vfAHX9I4evEuWF
         SioVmBla2CsVEEGRWQgBYvHBXe8/d2NEAUK2Al19bTxRacYtFXn6CEllie2BTnGCHqrc
         BX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=mo0xYdjPNpZiahHOR94h5CTJKhNqWSHm+oWy5fg8cNI=;
        b=cr4Gh3lHQ1ZzKAN7RMG3W9jSU+qWICksQej1lp1tgTHyEhvTOa5iDcfDQbMbT8yd+L
         V62qpR/SDAelM8UXv1S0ZhWrB20NTD/pIUc1d0prah8QbBWFz9dSfRlK99LCh8WNiwVn
         fEKvA0F0WgueO8wsMWi3B5nZrX6MpADn5oP4y6JbNKo7CWx27YVv8R4/IuDLg/Y1nMqE
         GJZYfdYhDuiMhiDMOLwxmtd+aZUn1S2h94iQBZlCKA4LdV0ETKBzTYlh3QwwNahEJXHp
         kP/80WW4Lo1eVScqb9U5jGK54tXy2gVE8qGm5JTFhPifecVw/B4LFmQJuhJ8wPusQASC
         EvJg==
X-Gm-Message-State: ACgBeo2TK6MNoclzzsnqoNPMYJoygjvurc+oxXo8/I4Fdp4YjUj67BSh
        NUoVjjJdCKKUugcstN0i9tKClg==
X-Google-Smtp-Source: AA6agR7vubIG0+XIw39Zt1ct04GLvMTZSzuisgoMMfI1SDteYWNLf1sIBPKpN0mJUjoqodPB1z4XUw==
X-Received: by 2002:a2e:a787:0:b0:26b:ded1:7652 with SMTP id c7-20020a2ea787000000b0026bded17652mr5702450ljf.263.1663007841645;
        Mon, 12 Sep 2022 11:37:21 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id cf11-20020a056512280b00b00499b232875dsm1116793lfb.171.2022.09.12.11.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 11:37:21 -0700 (PDT)
Message-ID: <067c7bc0-4746-f714-db56-a3c9e4f25588@linaro.org>
Date:   Mon, 12 Sep 2022 21:37:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v5 3/3] drm/msm/dp: retry 3 times if set sink to D0 poweer
 state failed
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1662999830-13916-1-git-send-email-quic_khsieh@quicinc.com>
 <1662999830-13916-4-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1662999830-13916-4-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2022 19:23, Kuogee Hsieh wrote:
> Bring sink out of D3 (power down) mode into D0 (normal operation) mode
> by setting DP_SET_POWER_D0 bit to DP_SET_POWER dpcd register. This
> patch will retry 3 times if written to DP_SET_POWER register failed.

Could you please elaborate this change? Can the sink succeed in reading 
the DP_SET_POWER, but fail writing DP_SET_POWER?

> 
> Changes in v5:
> -- split into two patches
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dp/dp_link.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_link.c b/drivers/gpu/drm/msm/dp/dp_link.c
> index 9d5381d..4360728 100644
> --- a/drivers/gpu/drm/msm/dp/dp_link.c
> +++ b/drivers/gpu/drm/msm/dp/dp_link.c
> @@ -50,6 +50,7 @@ static int dp_aux_link_power_up(struct drm_dp_aux *aux,
>   {
>   	u8 value;
>   	ssize_t len;
> +	int i;
>   
>   	if (link->revision < 0x11)
>   		return 0;
> @@ -61,11 +62,13 @@ static int dp_aux_link_power_up(struct drm_dp_aux *aux,
>   	value &= ~DP_SET_POWER_MASK;
>   	value |= DP_SET_POWER_D0;
>   
> -	len = drm_dp_dpcd_writeb(aux, DP_SET_POWER, value);
> -	if (len < 0)
> -		return len;
> -
> -	usleep_range(1000, 2000);
> +	/* retry for 1ms to give the sink time to wake up */
> +	for (i = 0; i < 3; i++) {
> +		len = drm_dp_dpcd_writeb(aux, DP_SET_POWER, value);
> +		usleep_range(1000, 2000);
> +		if (len == 1)
> +			break;
> +	}
>   
>   	return 0;
>   }

-- 
With best wishes
Dmitry

