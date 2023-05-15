Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67210704010
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 23:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245322AbjEOVwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 17:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243395AbjEOVwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 17:52:36 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318B4A275;
        Mon, 15 May 2023 14:52:33 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 7E5223F327;
        Mon, 15 May 2023 23:52:31 +0200 (CEST)
Date:   Mon, 15 May 2023 23:52:30 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, dmitry.baryshkov@linaro.org,
        andersson@kernel.org, quic_abhinavk@quicinc.com,
        quic_jesszhan@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 6/8] drm/msm/dpu: separate DSC flush update out of
 interface
Message-ID: <r5rbbaz5gms5d2wdheuvqoij4ld5qiyz2kxrjjqkpyzy4v2zdq@44q2zgkrxpgt>
References: <1683914423-17612-1-git-send-email-quic_khsieh@quicinc.com>
 <1683914423-17612-7-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1683914423-17612-7-git-send-email-quic_khsieh@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-12 11:00:21, Kuogee Hsieh wrote:
> 
> Current DSC flush update is piggyback inside dpu_hw_ctl_intf_cfg_v1().

Can you rewrite "is piggyback"?  Something like "Currently DSC flushing
happens during interface configuration".  And it's intf configuration
**on the CTL**, which makes this extra confusing.

> This patch separates DSC flush away from dpu_hw_ctl_intf_cfg_v1() by

Drop "This patch".  Then, separates -> Separate

> adding dpu_hw_ctl_update_pending_flush_dsc_v1() to handle both per
> DSC engine and DSC flush bits at same time to make it consistent with

Make that per-DSC with a hyphen.

> the location of flush programming of other dpu sub blocks.

DPU sub-blocks.

> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 14 ++++++++++++--
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c  | 22 ++++++++++++++++------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h  | 10 ++++++++++
>  3 files changed, 38 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index ffa6f04..5cae70e 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -1834,12 +1834,18 @@ dpu_encoder_dsc_initial_line_calc(struct drm_dsc_config *dsc,
>  	return DIV_ROUND_UP(total_pixels, dsc->slice_width);
>  }
>  
> -static void dpu_encoder_dsc_pipe_cfg(struct dpu_hw_dsc *hw_dsc,
> +static void dpu_encoder_dsc_pipe_cfg(struct dpu_encoder_virt *dpu_enc,

Why not pass hw_ctl directly?  The other blocks are directly passed as
well, and the caller already has cur_master.  Otherwise we might as well
inline the for loops.  Same question for the new _clr call added in
patch 8/8.

> +				     struct dpu_hw_dsc *hw_dsc,
>  				     struct dpu_hw_pingpong *hw_pp,
>  				     struct drm_dsc_config *dsc,
>  				     u32 common_mode,
>  				     u32 initial_lines)
>  {
> +	struct dpu_encoder_phys *cur_master = dpu_enc->cur_master;
> +	struct dpu_hw_ctl *ctl;
> +
> +	ctl = cur_master->hw_ctl;

Assign this directly at declaration, just like cur_master (but
irrelevant if you pass this directly instead).

> +
>  	if (hw_dsc->ops.dsc_config)
>  		hw_dsc->ops.dsc_config(hw_dsc, dsc, common_mode, initial_lines);
>  
> @@ -1854,6 +1860,9 @@ static void dpu_encoder_dsc_pipe_cfg(struct dpu_hw_dsc *hw_dsc,
>  
>  	if (hw_pp->ops.enable_dsc)
>  		hw_pp->ops.enable_dsc(hw_pp);
> +
> +	if (ctl->ops.update_pending_flush_dsc)
> +		ctl->ops.update_pending_flush_dsc(ctl, hw_dsc->idx);
>  }
>  
>  static void dpu_encoder_prep_dsc(struct dpu_encoder_virt *dpu_enc,
> @@ -1898,7 +1907,8 @@ static void dpu_encoder_prep_dsc(struct dpu_encoder_virt *dpu_enc,
>  	initial_lines = dpu_encoder_dsc_initial_line_calc(dsc, enc_ip_w);
>  
>  	for (i = 0; i < MAX_CHANNELS_PER_ENC; i++)
> -		dpu_encoder_dsc_pipe_cfg(hw_dsc[i], hw_pp[i], dsc, dsc_common_mode, initial_lines);
> +		dpu_encoder_dsc_pipe_cfg(dpu_enc, hw_dsc[i], hw_pp[i], dsc,
> +					 dsc_common_mode, initial_lines);
>  }
>  
>  void dpu_encoder_prepare_for_kickoff(struct drm_encoder *drm_enc)
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> index 4f7cfa9..f3a50cc 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> @@ -139,6 +139,11 @@ static inline void dpu_hw_ctl_trigger_flush_v1(struct dpu_hw_ctl *ctx)
>  				CTL_DSPP_n_FLUSH(dspp - DSPP_0),
>  				ctx->pending_dspp_flush_mask[dspp - DSPP_0]);
>  		}
> +
> +	if (ctx->pending_flush_mask & BIT(DSC_IDX))
> +		DPU_REG_WRITE(&ctx->hw, CTL_DSC_FLUSH,
> +			      ctx->pending_dsc_flush_mask);

When are we setting this to zero again?

Same question for the other masks, only the global pending_flush_mask
and pending_dspp_flush_mask are reset in dpu_hw_ctl_clear_pending_flush.

> +
>  	DPU_REG_WRITE(&ctx->hw, CTL_FLUSH, ctx->pending_flush_mask);
>  }
>  
> @@ -285,6 +290,13 @@ static void dpu_hw_ctl_update_pending_flush_merge_3d_v1(struct dpu_hw_ctl *ctx,
>  	ctx->pending_flush_mask |= BIT(MERGE_3D_IDX);
>  }
>  
> +static void dpu_hw_ctl_update_pending_flush_dsc_v1(struct dpu_hw_ctl *ctx,
> +						   enum dpu_dsc dsc_num)
> +{
> +	ctx->pending_dsc_flush_mask |= BIT(dsc_num - DSC_0);
> +	ctx->pending_flush_mask |= BIT(DSC_IDX);
> +}
> +
>  static void dpu_hw_ctl_update_pending_flush_dspp(struct dpu_hw_ctl *ctx,
>  	enum dpu_dspp dspp, u32 dspp_sub_blk)
>  {
> @@ -502,9 +514,6 @@ static void dpu_hw_ctl_intf_cfg_v1(struct dpu_hw_ctl *ctx,
>  	if ((test_bit(DPU_CTL_VM_CFG, &ctx->caps->features)))
>  		mode_sel = CTL_DEFAULT_GROUP_ID  << 28;
>  
> -	if (cfg->dsc)
> -		DPU_REG_WRITE(&ctx->hw, CTL_DSC_FLUSH, cfg->dsc);
> -
>  	if (cfg->intf_mode_sel == DPU_CTL_MODE_SEL_CMD)
>  		mode_sel |= BIT(17);
>  
> @@ -524,10 +533,8 @@ static void dpu_hw_ctl_intf_cfg_v1(struct dpu_hw_ctl *ctx,
>  	if (cfg->merge_3d)
>  		DPU_REG_WRITE(c, CTL_MERGE_3D_ACTIVE,
>  			      BIT(cfg->merge_3d - MERGE_3D_0));

Can we have a newline here?

> -	if (cfg->dsc) {
> -		DPU_REG_WRITE(&ctx->hw, CTL_FLUSH, DSC_IDX);

Found the reason why this patch (as one of the few) is needed to get
display working on my SM8150/SM8250 devices: the semantic change is that
BIT() was missing around DSC_IDX here.
(It wasn't hampering SDM845 because it doesn't have a configurable
 crossbar, i.e. DPU_CTL_ACTIVE_CFG)

Manually reverting this patch and adding BIT() indeed also fixes the
issue.

This semantic change should be documented in the description and with a
Fixes: (and Reported-by:?), or as a separate preliminary patch for
clarity.

> +	if (cfg->dsc)
>  		DPU_REG_WRITE(c, CTL_DSC_ACTIVE, cfg->dsc);
> -	}
>  }
>  
>  static void dpu_hw_ctl_intf_cfg(struct dpu_hw_ctl *ctx,
> @@ -630,6 +637,9 @@ static void _setup_ctl_ops(struct dpu_hw_ctl_ops *ops,
>  		ops->update_pending_flush_merge_3d =
>  			dpu_hw_ctl_update_pending_flush_merge_3d_v1;
>  		ops->update_pending_flush_wb = dpu_hw_ctl_update_pending_flush_wb_v1;
> +

And while adding a newline above, drop the one here.

> +		ops->update_pending_flush_dsc =
> +			dpu_hw_ctl_update_pending_flush_dsc_v1;
>  	} else {
>  		ops->trigger_flush = dpu_hw_ctl_trigger_flush;
>  		ops->setup_intf_cfg = dpu_hw_ctl_intf_cfg;
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
> index 6292002..d4869a0 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
> @@ -158,6 +158,15 @@ struct dpu_hw_ctl_ops {
>  		enum dpu_dspp blk, u32 dspp_sub_blk);
>  
>  	/**
> +	 * OR in the given flushbits to the cached pending_(dsc_)flush_mask
> +	 * No effect on hardware
> +	 * @ctx       : ctl path ctx pointer
> +	 * @blk       : interface block index

Can you drop the spaces before the colon (:)?  That's wrong and will be
fixed elsewhere later.

> +	 */
> +	void (*update_pending_flush_dsc)(struct dpu_hw_ctl *ctx,
> +					 enum dpu_dsc blk);

Indent with a single tab to match the rest.

> +
> +	/**
>  	 * Write the value of the pending_flush_mask to hardware
>  	 * @ctx       : ctl path ctx pointer
>  	 */
> @@ -245,6 +254,7 @@ struct dpu_hw_ctl {
>  	u32 pending_wb_flush_mask;
>  	u32 pending_merge_3d_flush_mask;
>  	u32 pending_dspp_flush_mask[DSPP_MAX - DSPP_0];
> +	u32 pending_dsc_flush_mask;

Don't forget to add this to the doc-comment, or did you skip it by
intention because pending_merge_3d_flush_mask and
pending_dspp_flush_mask are missing as well?

- Marijn

>  
>  	/* ops */
>  	struct dpu_hw_ctl_ops ops;
> -- 
> 2.7.4
> 
