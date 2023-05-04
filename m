Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3816F70D9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjEDR2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjEDR2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:28:23 -0400
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [5.144.164.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1764ED7
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 10:28:20 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 1C82B20C3D;
        Thu,  4 May 2023 19:28:15 +0200 (CEST)
Date:   Thu, 4 May 2023 19:28:14 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, dmitry.baryshkov@linaro.org,
        andersson@kernel.org, quic_abhinavk@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/7] drm/msm/dpu: Introduce PINGPONG_NONE to
 disconnect DSC from PINGPONG
Message-ID: <j6fllkmd4e75hss6dwxdiiu4keocknt5zg2iu6jgj5nsfku6d6@5ec25ecgpvva>
References: <1683218805-23419-1-git-send-email-quic_khsieh@quicinc.com>
 <1683218805-23419-5-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1683218805-23419-5-git-send-email-quic_khsieh@quicinc.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-04 09:46:42, Kuogee Hsieh wrote:
> Disabling the crossbar mux between DSC and PINGPONG currently
> requires a bogus enum dpu_pingpong value to be passed when calling
> dsc_bind_pingpong_blk() with enable=false, even though the register
> value written is independent of the current PINGPONG block.  Replace
> that `bool enable` parameter with a new PINGPONG_NONE dpu_pingpong
> flag that triggers the write of the "special" 0xF "crossbar
> disabled" value to the register instead.
> 
> Changes in v4:
> -- more details to commit text
> 
> Changes in v5:
> -- rewording commit text suggested by Marijn
> -- add DRM_DEBUG_KMS for DSC unbinding case
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Thanks for bearing with all the comments thus far!

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c |  2 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c  | 15 ++++++++-------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h  |  1 -
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h |  3 ++-
>  4 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index cf1de5d..ffa6f04 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -1850,7 +1850,7 @@ static void dpu_encoder_dsc_pipe_cfg(struct dpu_hw_dsc *hw_dsc,
>  		hw_pp->ops.setup_dsc(hw_pp);
>  
>  	if (hw_dsc->ops.dsc_bind_pingpong_blk)
> -		hw_dsc->ops.dsc_bind_pingpong_blk(hw_dsc, true, hw_pp->idx);
> +		hw_dsc->ops.dsc_bind_pingpong_blk(hw_dsc, hw_pp->idx);
>  
>  	if (hw_pp->ops.enable_dsc)
>  		hw_pp->ops.enable_dsc(hw_pp);
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c
> index 4a6bbcc..47cb9f3 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c
> @@ -157,7 +157,6 @@ static void dpu_hw_dsc_config_thresh(struct dpu_hw_dsc *hw_dsc,
>  
>  static void dpu_hw_dsc_bind_pingpong_blk(
>  		struct dpu_hw_dsc *hw_dsc,
> -		bool enable,
>  		const enum dpu_pingpong pp)
>  {
>  	struct dpu_hw_blk_reg_map *c = &hw_dsc->hw;
> @@ -166,14 +165,16 @@ static void dpu_hw_dsc_bind_pingpong_blk(
>  
>  	dsc_ctl_offset = DSC_CTL(hw_dsc->idx);
>  
> -	if (enable)
> +	if (pp)
>  		mux_cfg = (pp - PINGPONG_0) & 0x7;
>  
> -	DRM_DEBUG_KMS("%s dsc:%d %s pp:%d\n",
> -			enable ? "Binding" : "Unbinding",
> -			hw_dsc->idx - DSC_0,
> -			enable ? "to" : "from",
> -			pp - PINGPONG_0);
> +	if (pp)
> +		DRM_DEBUG_KMS("Binding dsc:%d to pp:%d\n",
> +				hw_dsc->idx - DSC_0,
> +				pp - PINGPONG_0);
> +	else
> +		DRM_DEBUG_KMS("Unbinding dsc:%d from any pp\n",
> +				hw_dsc->idx - DSC_0);
>  
>  	DPU_REG_WRITE(c, dsc_ctl_offset, mux_cfg);
>  }
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h
> index 287ec5f..138080a 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h
> @@ -44,7 +44,6 @@ struct dpu_hw_dsc_ops {
>  				  struct drm_dsc_config *dsc);
>  
>  	void (*dsc_bind_pingpong_blk)(struct dpu_hw_dsc *hw_dsc,
> -				  bool enable,
>  				  enum dpu_pingpong pp);
>  };
>  
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> index 1913a19..02a0f48 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> @@ -191,7 +191,8 @@ enum dpu_dsc {
>  };
>  
>  enum dpu_pingpong {
> -	PINGPONG_0 = 1,
> +	PINGPONG_NONE,
> +	PINGPONG_0,
>  	PINGPONG_1,
>  	PINGPONG_2,
>  	PINGPONG_3,
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
