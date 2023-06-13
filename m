Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBD772EB87
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjFMTEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240430AbjFMTEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:04:08 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5318192
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:04:06 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 6FF473F203;
        Tue, 13 Jun 2023 21:04:03 +0200 (CEST)
Date:   Tue, 13 Jun 2023 21:04:01 +0200
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
Subject: Re: [PATCH v6 4/6] drm/msm/dpu: Set DATA_COMPRESS on command mode
 for DCE/DSC 1.2
Message-ID: <uwwybxxx2hq6paewdumg7be7o6u4y5nrw2h6guk67ugt3gc2h4@azwe4ez6zuju>
References: <20230405-add-dsc-support-v6-0-95eab864d1b6@quicinc.com>
 <20230405-add-dsc-support-v6-4-95eab864d1b6@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405-add-dsc-support-v6-4-95eab864d1b6@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-09 15:57:16, Jessica Zhang wrote:
> Add a DPU INTF op to set the DCE_DATA_COMPRESS bit to enable the
> DCE/DSC 1.2 datapath
> 
> Note: For now, this op is called for command mode encoders only. Changes to
> set DATA_COMPRESS for video mode encoders will be posted along with DSC
> v1.2 support for DP.
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c |  3 +++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c          | 13 +++++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h          |  3 +++
>  3 files changed, 19 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> index 63ba0082b6ee..b856c6286c85 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> @@ -67,6 +67,9 @@ static void _dpu_encoder_phys_cmd_update_intf_cfg(
>  		phys_enc->hw_intf->ops.bind_pingpong_blk(
>  				phys_enc->hw_intf,
>  				phys_enc->hw_pp->idx);
> +
> +	if (intf_cfg.dsc != 0 && phys_enc->hw_intf->ops.enable_compression)
> +		phys_enc->hw_intf->ops.enable_compression(phys_enc->hw_intf);

It was probably not necessary to drop this after adding dsc!=0:

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

>  }
>  
>  static void dpu_encoder_phys_cmd_pp_tx_done_irq(void *arg, int irq_idx)
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> index 530f82e34c1e..5b0f6627e29b 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> @@ -91,6 +91,7 @@
>  
>  #define INTF_CFG2_DATABUS_WIDEN	BIT(0)
>  #define INTF_CFG2_DATA_HCTL_EN	BIT(4)
> +#define INTF_CFG2_DCE_DATA_COMPRESS     BIT(12)
>  
>  
>  static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
> @@ -512,6 +513,15 @@ static void dpu_hw_intf_disable_autorefresh(struct dpu_hw_intf *intf,
>  
>  }
>  
> +static void dpu_hw_intf_enable_compression(struct dpu_hw_intf *ctx)
> +{
> +	u32 intf_cfg2 = DPU_REG_READ(&ctx->hw, INTF_CONFIG2);
> +
> +	intf_cfg2 |= INTF_CFG2_DCE_DATA_COMPRESS;
> +
> +	DPU_REG_WRITE(&ctx->hw, INTF_CONFIG2, intf_cfg2);
> +}
> +
>  static void _setup_intf_ops(struct dpu_hw_intf_ops *ops,
>  		unsigned long cap)
>  {
> @@ -532,6 +542,9 @@ static void _setup_intf_ops(struct dpu_hw_intf_ops *ops,
>  		ops->vsync_sel = dpu_hw_intf_vsync_sel;
>  		ops->disable_autorefresh = dpu_hw_intf_disable_autorefresh;
>  	}
> +
> +	if (cap & BIT(DPU_INTF_DATA_COMPRESS))
> +		ops->enable_compression = dpu_hw_intf_enable_compression;
>  }
>  
>  struct dpu_hw_intf *dpu_hw_intf_init(const struct dpu_intf_cfg *cfg,
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
> index 33895eca1211..99e21c4137f9 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
> @@ -70,6 +70,7 @@ struct intf_status {
>   * @get_autorefresh:            Retrieve autorefresh config from hardware
>   *                              Return: 0 on success, -ETIMEDOUT on timeout
>   * @vsync_sel:                  Select vsync signal for tear-effect configuration
> + * @enable_compression:         Enable data compression
>   */
>  struct dpu_hw_intf_ops {
>  	void (*setup_timing_gen)(struct dpu_hw_intf *intf,
> @@ -106,6 +107,8 @@ struct dpu_hw_intf_ops {
>  	 * Disable autorefresh if enabled
>  	 */
>  	void (*disable_autorefresh)(struct dpu_hw_intf *intf, uint32_t encoder_id, u16 vdisplay);
> +
> +	void (*enable_compression)(struct dpu_hw_intf *intf);
>  };
>  
>  struct dpu_hw_intf {
> 
> -- 
> 2.40.1
> 
