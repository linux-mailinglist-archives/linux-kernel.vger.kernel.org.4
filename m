Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1436F5185
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 09:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjECHab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 03:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjECH3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 03:29:46 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE044EE6;
        Wed,  3 May 2023 00:29:02 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id BFD773F33A;
        Wed,  3 May 2023 09:28:59 +0200 (CEST)
Date:   Wed, 3 May 2023 09:28:58 +0200
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
Subject: Re: [PATCH 4/4] drm/msm/dpu: Enable compression for command mode
Message-ID: <hxqxnfcydzyfrlvihmil3gecan6p6xyjw44gielu63ltgtqul7@xwvoprzofq6g>
References: <20230405-add-dsc-support-v1-0-6bc6f03ae735@quicinc.com>
 <20230405-add-dsc-support-v1-4-6bc6f03ae735@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405-add-dsc-support-v1-4-6bc6f03ae735@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-02 18:19:15, Jessica Zhang wrote:
> Add a dpu_hw_intf op to enable data compression.
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c | 4 ++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c          | 7 +++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h          | 2 ++
>  3 files changed, 13 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> index 74470d068622..4321a1aba17f 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c

Can we have INTF DCE on video-mode encoders as well?

> @@ -72,6 +72,10 @@ static void _dpu_encoder_phys_cmd_update_intf_cfg(
>  				phys_enc->hw_intf,
>  				true,
>  				phys_enc->hw_pp->idx);
> +
> +	if (phys_enc->dpu_kms->catalog->caps->has_data_compress &&

As per my suggestion on patch 3/4, drop the flag and check above and
only check if the function is NULL (below).

> +			phys_enc->hw_intf->ops.enable_compression)
> +		phys_enc->hw_intf->ops.enable_compression(phys_enc->hw_intf);
>  }
>  
>  static void dpu_encoder_phys_cmd_pp_tx_done_irq(void *arg, int irq_idx)
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> index 671048a78801..4ce7ffdd7a05 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> @@ -64,10 +64,16 @@
>  
>  #define INTF_CFG2_DATABUS_WIDEN	BIT(0)
>  #define INTF_CFG2_DATA_HCTL_EN	BIT(4)

These should probably be reindented to match the below... And the rest
of the defines use spaces instead of tabs.

> +#define INTF_CFG2_DCE_DATA_COMPRESS	BIT(12)
>  
>  #define INTF_MISR_CTRL			0x180
>  #define INTF_MISR_SIGNATURE		0x184

This does not seem to apply on top of:
https://lore.kernel.org/linux-arm-msm/20230411-dpu-intf-te-v4-10-27ce1a5ab5c6@somainline.org/

>  
> +static inline void dpu_hw_intf_enable_compression(struct dpu_hw_intf *ctx)

Why inline?  This is used as a pointer callback.

> +{
> +	DPU_REG_WRITE(&ctx->hw, INTF_CONFIG2, INTF_CFG2_DCE_DATA_COMPRESS);

dpu_hw_intf_setup_timing_engine() also programs INTF_CONFIG2.  Is it
double-buffered, or is that config **always** unused when DSI CMD mode
is used in conjunction with DSC/DCE?  Otherwise this should perhaps OR
the bitflag into the register, or write the whole thing at once in
dpu_hw_intf_setup_timing_engine()?

> +}
> +
>  static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *ctx,
>  		const struct intf_timing_params *p,
>  		const struct dpu_format *fmt)
> @@ -325,6 +331,7 @@ static void _setup_intf_ops(struct dpu_hw_intf_ops *ops,
>  		ops->bind_pingpong_blk = dpu_hw_intf_bind_pingpong_blk;
>  	ops->setup_misr = dpu_hw_intf_setup_misr;
>  	ops->collect_misr = dpu_hw_intf_collect_misr;
> +	ops->enable_compression = dpu_hw_intf_enable_compression;

And per the same suggestion on patch 3/4, this is then wrapped in:

    if (cap & BIT(DPU_INTF_DATA_COMPRESS))

(or similary named) flag check.

>  }

This also doesn't seem to apply on top of the INTF TE [1] support
series, even though it depends on DSC 1.2 DPU support(s?) [2] which
mentions it was rebase(d) on top of that.

[1]: https://patchwork.freedesktop.org/series/112332/
[2]: https://patchwork.freedesktop.org/series/116789/

- Marijn

>  
>  struct dpu_hw_intf *dpu_hw_intf_init(const struct dpu_intf_cfg *cfg,
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
> index 102c4f0e812b..99528c735368 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h
> @@ -60,6 +60,7 @@ struct intf_status {
>   *                     feed pixels to this interface
>   * @setup_misr: enable/disable MISR
>   * @collect_misr: read MISR signature
> + * @enable_compression: Enable data compression
>   */
>  struct dpu_hw_intf_ops {
>  	void (*setup_timing_gen)(struct dpu_hw_intf *intf,
> @@ -82,6 +83,7 @@ struct dpu_hw_intf_ops {
>  			const enum dpu_pingpong pp);
>  	void (*setup_misr)(struct dpu_hw_intf *intf, bool enable, u32 frame_count);
>  	int (*collect_misr)(struct dpu_hw_intf *intf, u32 *misr_value);
> +	void (*enable_compression)(struct dpu_hw_intf *intf);
>  };
>  
>  struct dpu_hw_intf {
> 
> -- 
> 2.40.1
> 
