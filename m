Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1439172B48B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 00:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjFKWDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 18:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjFKWDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 18:03:23 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [IPv6:2001:4b7a:2000:18::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7832AE48;
        Sun, 11 Jun 2023 15:03:22 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id BA2A01F9B4;
        Mon, 12 Jun 2023 00:03:20 +0200 (CEST)
Date:   Mon, 12 Jun 2023 00:03:19 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/6] drm/msm/dsi: Document DSC related pclk_rate and
 hdisplay calculations
Message-ID: <6uiyqgggt2a3gkcihtyzr4rvq5igbe3ojpeiqnji22663bhh2l@3jifgk7bw4u5>
References: <20230405-add-dsc-support-v6-0-95eab864d1b6@quicinc.com>
 <20230405-add-dsc-support-v6-6-95eab864d1b6@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405-add-dsc-support-v6-6-95eab864d1b6@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-09 15:57:18, Jessica Zhang wrote:
> Add documentation comments explaining the pclk_rate and hdisplay math
> related to DSC.
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index fb1d3a25765f..aeaadc18bc7b 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -564,6 +564,13 @@ void dsi_link_clk_disable_v2(struct msm_dsi_host *msm_host)
>  static unsigned long dsi_adjust_pclk_for_compression(const struct drm_display_mode *mode,
>  		const struct drm_dsc_config *dsc)
>  {
> +	/*
> +	 * Adjust the pclk rate by calculating a new hdisplay proportional to
> +	 * the compression ratio such that:
> +	 *     new_hdisplay = old_hdisplay * target_bpp / source_bpp
> +	 *
> +	 * Porches need not be adjusted during compression.
> +	 */
>  	int new_hdisplay = DIV_ROUND_UP(mode->hdisplay * drm_dsc_get_bpp_int(dsc),
>  			dsc->bits_per_component * 3);

I won't reiterate my original troubles with this logic and the comment
as that has well been described in v5 replies.

Just want to ask why this comment couldn't be added in patch 5/6
immediately when the logic is introduced?  Now readers won't have a clue
what is going on until they skip one patch ahead.

Furthermore it is lacking any explanation that this is a workaround for
cmd-mode, and that porches are currently used to represent "transfer
time" until those calculations are implemented.  At that point there is
no concept of "not adjusting porches for compressed signals" anymore.

>  
> @@ -961,6 +968,9 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>  
>  		/* Divide the display by 3 but keep back/font porch and
>  		 * pulse width same
> +		 *
> +		 * hdisplay will be divided by 3 here to account for the fact
> +		 * that DPU sends 3 bytes per pclk cycle to DSI.
>  		 */
>  		h_total -= hdisplay;
>  		hdisplay = DIV_ROUND_UP(msm_dsc_get_bytes_per_line(msm_host->dsc), 3);

Still very glad to have this, thank you for adding it.  Note that it
only further undermines the pclk adjustments, as I just explained in v5
review.

- Marijn

> 
> -- 
> 2.40.1
> 
