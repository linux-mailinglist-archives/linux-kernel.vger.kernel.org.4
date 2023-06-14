Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA70C72F6D2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243499AbjFNHu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243234AbjFNHtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:49:36 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0453710DA
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 00:49:35 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b203360d93so4470321fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 00:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686728973; x=1689320973;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=27eyuKXLzSmxU9wIv8izarpbo1JvKOXSZvqxo5m+b6E=;
        b=k7VCtEuvdXGbXRk5tm0RLthsEKEjNKDNUg9gFhXpAhEyMFq3PBJfYBfczX+OoBEhzZ
         ydSI3Dq8EqUoW3zeQOL8l+gT6P08zgtyp7fXFrORwquAbS7V1m+r1gU9/iEvZ2BMb+XL
         G3bmJi0XuPYhI0MIaj9pQz/aMCvRmgxG0fhTABtNWOzOufk0H+p2g2X/P1Ra5tWj/FjE
         Mbzd9hLJk0uSEbYFu/hb+UqzdoQefvUawpoAITm7JtlTBlfM3OPyBOyH+NTst81zJR45
         OZW3gZc66a6gq/HFamdHB0vsEsSFJtoSBt+bHzPjSqaXX8fHzjt2mci26IXpOazaOlbz
         UXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686728973; x=1689320973;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=27eyuKXLzSmxU9wIv8izarpbo1JvKOXSZvqxo5m+b6E=;
        b=PeGOq1tBN8uT0M8QqCJk7qr3XNACQSoTnZGiejPsxv0SvolwE7XZByL42aFoH1sLgQ
         jIqtUKStKFGXs29T5uYk3M1qewaoxfvN2Ts6jsqAD941gyLrxu5PY8NGYn23kCoFZu/k
         TF4KmNDEvrYhtuEbBs8kfU+xdm3FMXOyHgoT6jY1KQcSAUSbQnNhbTc8YPWLJ13NJzyz
         /TLDQoiuNbFKX7CfjFeJBPxNPIIuWAfXVFC7krcr8yUHeh2vmCMxppWGBQ4NTcVIhfIf
         RVAm3wHDmcQwqR1RU9nGCv3AM0uWKyVy5Y+Xkd7grPeqt5NpSmB8UvB8oMFNPKceuMyl
         yJLw==
X-Gm-Message-State: AC+VfDxxN/n5EsvF/i1Pxo8SVrLZ7V1uBOEFBvfHk4HaH9FjY38MpaLJ
        Cgs0Y6QuNz8c6Ggj5CQtbmJsQSP1rXJSzkIUgA0=
X-Google-Smtp-Source: ACHHUZ4tX1Lru/h/k7uXYdfmiypu/83JXDIzBpvoNKDLfhESReO/fJd0wkNKt6JjhYVZuJXm0Wf8fg==
X-Received: by 2002:a2e:83d6:0:b0:2af:8635:96a1 with SMTP id s22-20020a2e83d6000000b002af863596a1mr5395683ljh.33.1686728973188;
        Wed, 14 Jun 2023 00:49:33 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id v2-20020a2e7a02000000b002a9eba29c39sm2430936ljc.91.2023.06.14.00.49.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 00:49:32 -0700 (PDT)
Message-ID: <3a6cc492-6b54-2c70-402e-995c0b003c01@linaro.org>
Date:   Wed, 14 Jun 2023 10:49:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] drm/msm/dsi: Enable DATABUS_WIDEN for DSI command
 mode
Content-Language: en-GB
To:     Jessica Zhang <quic_jesszhan@quicinc.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc:     quic_abhinavk@quicinc.com, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230525-add-widebus-support-v1-0-c7069f2efca1@quicinc.com>
 <20230525-add-widebus-support-v1-3-c7069f2efca1@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230525-add-widebus-support-v1-3-c7069f2efca1@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2023 04:57, Jessica Zhang wrote:
> DSI 6G v2.5.x+ supports a data-bus widen mode that allows DSI to send
> 48 bits of compressed data per pclk instead of 24.
> 
> For all chipsets that support this mode, enable it whenever DSC is
> enabled as recommend by the hardware programming guide.
> 
> Only enable this for command mode as we are currently unable to validate
> it for video mode.
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
> 
> Note: The dsi.xml.h changes were generated using the headergen2 script in
> envytools [1], but the changes to the copyright and rules-ng-ng source file
> paths were dropped.
> 
> [1] https://github.com/freedreno/envytools/
> 
>   drivers/gpu/drm/msm/dsi/dsi.xml.h  |  1 +
>   drivers/gpu/drm/msm/dsi/dsi_host.c | 19 ++++++++++++++++++-
>   2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi.xml.h b/drivers/gpu/drm/msm/dsi/dsi.xml.h
> index a4a154601114..2a7d980e12c3 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi.xml.h
> +++ b/drivers/gpu/drm/msm/dsi/dsi.xml.h
> @@ -664,6 +664,7 @@ static inline uint32_t DSI_CMD_MODE_MDP_CTRL2_INPUT_RGB_SWAP(enum dsi_rgb_swap v
>   	return ((val) << DSI_CMD_MODE_MDP_CTRL2_INPUT_RGB_SWAP__SHIFT) & DSI_CMD_MODE_MDP_CTRL2_INPUT_RGB_SWAP__MASK;
>   }
>   #define DSI_CMD_MODE_MDP_CTRL2_BURST_MODE			0x00010000
> +#define DSI_CMD_MODE_MDP_CTRL2_DATABUS_WIDEN			0x00100000
> 
>   #define REG_DSI_CMD_MODE_MDP_STREAM2_CTRL			0x000001b8
>   #define DSI_CMD_MODE_MDP_STREAM2_CTRL_DATA_TYPE__MASK		0x0000003f
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 5d7b4409e4e9..1da5238e7105 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -927,6 +927,9 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>   	u32 hdisplay = mode->hdisplay;
>   	u32 wc;
>   	int ret;
> +	bool widebus_supported = msm_host->cfg_hnd->major == MSM_DSI_VER_MAJOR_6G &&
> +			msm_host->cfg_hnd->minor >= MSM_DSI_6G_VER_MINOR_V2_5_0;
> +
> 
>   	DBG("");
> 
> @@ -973,8 +976,15 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>   		 *
>   		 * hdisplay will be divided by 3 here to account for the fact
>   		 * that DPU sends 3 bytes per pclk cycle to DSI.
> +		 *
> +		 * If widebus is supported, set DATABUS_WIDEN register and divide hdisplay by 6
> +		 * instead of 3

This is useless, it is already obvious from the code below. Instead 
there should be something like "wide bus extends that to 6 bytes per 
pclk cycle"

>   		 */
> -		hdisplay = DIV_ROUND_UP(msm_dsc_get_bytes_per_line(msm_host->dsc), 3);
> +		if (!(msm_host->mode_flags & MIPI_DSI_MODE_VIDEO) && widebus_supported)
> +			hdisplay = DIV_ROUND_UP(msm_dsc_get_bytes_per_line(msm_host->dsc), 6);
> +		else
> +			hdisplay = DIV_ROUND_UP(msm_dsc_get_bytes_per_line(msm_host->dsc), 3);
> +
>   		h_total += hdisplay;
>   		ha_end = ha_start + hdisplay;
>   	}
> @@ -1027,6 +1037,13 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>   		dsi_write(msm_host, REG_DSI_CMD_MDP_STREAM0_TOTAL,
>   			DSI_CMD_MDP_STREAM0_TOTAL_H_TOTAL(hdisplay) |
>   			DSI_CMD_MDP_STREAM0_TOTAL_V_TOTAL(mode->vdisplay));
> +
> +		if (msm_host->dsc && widebus_supported) {
> +			u32 mdp_ctrl2 = dsi_read(msm_host, REG_DSI_CMD_MODE_MDP_CTRL2);
> +
> +			mdp_ctrl2 |= DSI_CMD_MODE_MDP_CTRL2_DATABUS_WIDEN;
> +			dsi_write(msm_host, REG_DSI_CMD_MODE_MDP_CTRL2, mdp_ctrl2);

Is widebus applicable only to the CMD mode, or video mode can employ it too?

> +		}
>   	}
>   }
> 
> 
> --
> 2.40.1
> 

-- 
With best wishes
Dmitry

