Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74666A68E0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 09:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjCAI1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 03:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjCAI1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 03:27:10 -0500
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [5.144.164.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F7136FEC;
        Wed,  1 Mar 2023 00:27:08 -0800 (PST)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id AC8942038B;
        Wed,  1 Mar 2023 09:27:06 +0100 (CET)
Date:   Wed, 1 Mar 2023 09:27:05 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Kalyan Thota <quic_kalyant@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@chromium.org,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, dmitry.baryshkov@linaro.org,
        quic_abhinavk@quicinc.com
Subject: Re: [PATCH v4 3/4] drm/msm/dpu: avoid unnecessary check in DPU
 reservations
Message-ID: <20230301082705.ugbaov2kr75fygnr@SoMainline.org>
References: <1676286704-818-1-git-send-email-quic_kalyant@quicinc.com>
 <1676286704-818-4-git-send-email-quic_kalyant@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1676286704-818-4-git-send-email-quic_kalyant@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-13 03:11:43, Kalyan Thota wrote:
> Return immediately on failure, this will make dpu reservations
> part look cleaner.
> 
> Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 46d2a5c..3920efd 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -636,25 +636,22 @@ static int dpu_encoder_virt_atomic_check(
>  		if (ret) {
>  			DPU_ERROR_ENC(dpu_enc,
>  					"mode unsupported, phys idx %d\n", i);
> -			break;
> +			return ret;
>  		}
>  	}
>  
>  	topology = dpu_encoder_get_topology(dpu_enc, dpu_kms, adj_mode, crtc_state);
>  
> -	/* Reserve dynamic resources now. */
> -	if (!ret) {
> -		/*
> -		 * Release and Allocate resources on every modeset
> -		 * Dont allocate when active is false.
> -		 */
> -		if (drm_atomic_crtc_needs_modeset(crtc_state)) {
> -			dpu_rm_release(global_state, drm_enc);
> +	/*
> +	 * Release and Allocate resources on every modeset
> +	 * Dont allocate when active is false.
> +	 */
> +	if (drm_atomic_crtc_needs_modeset(crtc_state)) {
> +		dpu_rm_release(global_state, drm_enc);
>  
> -			if (!crtc_state->active_changed || crtc_state->active)
> -				ret = dpu_rm_reserve(&dpu_kms->rm, global_state,
> -						drm_enc, crtc_state, topology);
> -		}
> +		if (!crtc_state->active_changed || crtc_state->active)
> +			ret = dpu_rm_reserve(&dpu_kms->rm, global_state,
> +					drm_enc, crtc_state, topology);
>  	}
>  
>  	trace_dpu_enc_atomic_check_flags(DRMID(drm_enc), adj_mode->flags);
> -- 
> 2.7.4
> 
