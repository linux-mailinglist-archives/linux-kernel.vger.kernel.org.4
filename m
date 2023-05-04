Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901146F717E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjEDRtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEDRtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:49:20 -0400
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [IPv6:2001:4b7a:2000:18::164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60CD19B0
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 10:49:17 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 643C120CC1;
        Thu,  4 May 2023 19:49:15 +0200 (CEST)
Date:   Thu, 4 May 2023 19:49:14 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, dmitry.baryshkov@linaro.org,
        andersson@kernel.org, quic_abhinavk@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/7] drm/msm/dpu: add DPU_PINGPONG_DSC bits into
 PP_BLK and PP_BLK_TE marcos
Message-ID: <ljt5mp4ew5lcrrrdd7xyof3jv3friafbmr3im35ddwxjc42ekh@toez7xfdreg2>
References: <1683218805-23419-1-git-send-email-quic_khsieh@quicinc.com>
 <1683218805-23419-4-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1683218805-23419-4-git-send-email-quic_khsieh@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PP_BLK_TE is no longer there.

marcos -> macros.

On 2023-05-04 09:46:41, Kuogee Hsieh wrote:
> At legacy chipsets, it required DPU_PINGPONG_DSC bit be set to indicate

I may have not made this clear, but the comments on patch 2/7
(introducing the DPU_PINGPONG_DSC bit) also apply to this patch: clarify
DPU 7.0.0 exactly in favour of "legacy", which has no definition at all
and changes over time.

> pingpong ops functions are required to complete DSC data path setup if
> this chipset has DSC hardware block presented. This patch add
> DPU_PINGPONG_DSC bit to both PP_BLK and PP_BLK_TE marcos if it has DSC
> hardware block presented.

Strictly speaking this patch together with 2/7 is not bisectable, as 2/7
first disables the callbacks for _all_ hardware and then this patch adds
it back by adding the flag to all DPU < 7.0.0 catalog descriptions.

To solve that, as we do in other DPU patch-series, just squash this
patch into 2/7.  That way you also don't have to spend extra time
rewording this commit message either to match the improvements we made
in 2/7 (for example, you mention that "ops functions are required to
complete DSC data path setup", but those were already available before
2/7, despite sounding as if this is a new thing that was previously
missing entirely).

But please wait at least a couple days before sending v6.  I only have a
few hours every day/week but would appreciate to review and test all the
other patches.

> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  .../drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h    | 16 +++++++--------
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h | 16 +++++++--------
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h | 24 +++++++++++-----------
>  .../drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h    | 24 +++++++++++-----------
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h | 24 +++++++++++-----------
>  5 files changed, 52 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
> index 521cfd5..ef92545 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h
> @@ -112,17 +112,17 @@ static const struct dpu_lm_cfg msm8998_lm[] = {
>  };
>  
>  static const struct dpu_pingpong_cfg msm8998_pp[] = {
> -	PP_BLK("pingpong_0", PINGPONG_0, 0x70000, PINGPONG_SDM845_TE2_MASK, 0, sdm845_pp_sblk_te,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
> +	PP_BLK("pingpong_0", PINGPONG_0, 0x70000, PINGPONG_SDM845_TE2_MASK|BIT(DPU_PINGPONG_DSC),

This should be added to the MASK (add new #define's where necessary).

- Marijn

> +			0, sdm845_pp_sblk_te, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
>  			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 12)),
> -	PP_BLK("pingpong_1", PINGPONG_1, 0x70800, PINGPONG_SDM845_TE2_MASK, 0, sdm845_pp_sblk_te,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
> +	PP_BLK("pingpong_1", PINGPONG_1, 0x70800, PINGPONG_SDM845_TE2_MASK|BIT(DPU_PINGPONG_DSC),
> +			 0, sdm845_pp_sblk_te, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
>  			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 13)),
> -	PP_BLK("pingpong_2", PINGPONG_2, 0x71000, PINGPONG_SDM845_MASK, 0, sdm845_pp_sblk,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
> +	PP_BLK("pingpong_2", PINGPONG_2, 0x71000, PINGPONG_SDM845_MASK|BIT(DPU_PINGPONG_DSC),
> +			0, sdm845_pp_sblk, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
>  			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 14)),
> -	PP_BLK("pingpong_3", PINGPONG_3, 0x71800, PINGPONG_SDM845_MASK, 0, sdm845_pp_sblk,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11),
> +	PP_BLK("pingpong_3", PINGPONG_3, 0x71800, PINGPONG_SDM845_MASK|BIT(DPU_PINGPONG_DSC),
> +			0, sdm845_pp_sblk, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11),
>  			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 15)),
>  };
>  
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h
> index b109757..697fbd8 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h
> @@ -110,17 +110,17 @@ static const struct dpu_lm_cfg sdm845_lm[] = {
>  };
>  
>  static const struct dpu_pingpong_cfg sdm845_pp[] = {
> -	PP_BLK("pingpong_0", PINGPONG_0, 0x70000, PINGPONG_SDM845_TE2_MASK, 0, sdm845_pp_sblk_te,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
> +	PP_BLK("pingpong_0", PINGPONG_0, 0x70000, PINGPONG_SDM845_TE2_MASK|BIT(DPU_PINGPONG_DSC),
> +			0, sdm845_pp_sblk_te, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
>  			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 12)),
> -	PP_BLK("pingpong_1", PINGPONG_1, 0x70800, PINGPONG_SDM845_TE2_MASK, 0, sdm845_pp_sblk_te,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
> +	PP_BLK("pingpong_1", PINGPONG_1, 0x70800, PINGPONG_SDM845_TE2_MASK|BIT(DPU_PINGPONG_DSC),
> +			0, sdm845_pp_sblk_te, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
>  			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 13)),
> -	PP_BLK("pingpong_2", PINGPONG_2, 0x71000, PINGPONG_SDM845_MASK, 0, sdm845_pp_sblk,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
> +	PP_BLK("pingpong_2", PINGPONG_2, 0x71000, PINGPONG_SDM845_MASK|BIT(DPU_PINGPONG_DSC),
> +			0, sdm845_pp_sblk, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
>  			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 14)),
> -	PP_BLK("pingpong_3", PINGPONG_3, 0x71800, PINGPONG_SDM845_MASK, 0, sdm845_pp_sblk,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11),
> +	PP_BLK("pingpong_3", PINGPONG_3, 0x71800, PINGPONG_SDM845_MASK|BIT(DPU_PINGPONG_DSC),
> +			0, sdm845_pp_sblk, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11),
>  			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 15)),
>  };
>  
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h
> index 30aff2b..cb117ca 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h
> @@ -128,23 +128,23 @@ static const struct dpu_dspp_cfg sm8150_dspp[] = {
>  };
>  
>  static const struct dpu_pingpong_cfg sm8150_pp[] = {
> -	PP_BLK("pingpong_0", PINGPONG_0, 0x70000, PINGPONG_SM8150_MASK, MERGE_3D_0, sdm845_pp_sblk,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
> +	PP_BLK("pingpong_0", PINGPONG_0, 0x70000, PINGPONG_SM8150_MASK|BIT(DPU_PINGPONG_DSC),
> +			MERGE_3D_0, sdm845_pp_sblk, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
>  			-1),
> -	PP_BLK("pingpong_1", PINGPONG_1, 0x70800, PINGPONG_SM8150_MASK, MERGE_3D_0, sdm845_pp_sblk,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
> +	PP_BLK("pingpong_1", PINGPONG_1, 0x70800, PINGPONG_SM8150_MASK|BIT(DPU_PINGPONG_DSC),
> +			MERGE_3D_0, sdm845_pp_sblk, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
>  			-1),
> -	PP_BLK("pingpong_2", PINGPONG_2, 0x71000, PINGPONG_SM8150_MASK, MERGE_3D_1, sdm845_pp_sblk,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
> +	PP_BLK("pingpong_2", PINGPONG_2, 0x71000, PINGPONG_SM8150_MASK|BIT(DPU_PINGPONG_DSC),
> +			MERGE_3D_1, sdm845_pp_sblk, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
>  			-1),
> -	PP_BLK("pingpong_3", PINGPONG_3, 0x71800, PINGPONG_SM8150_MASK, MERGE_3D_1, sdm845_pp_sblk,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11),
> +	PP_BLK("pingpong_3", PINGPONG_3, 0x71800, PINGPONG_SM8150_MASK|BIT(DPU_PINGPONG_DSC),
> +			MERGE_3D_1, sdm845_pp_sblk, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11),
>  			-1),
> -	PP_BLK("pingpong_4", PINGPONG_4, 0x72000, PINGPONG_SM8150_MASK, MERGE_3D_2, sdm845_pp_sblk,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 30),
> +	PP_BLK("pingpong_4", PINGPONG_4, 0x72000, PINGPONG_SM8150_MASK|BIT(DPU_PINGPONG_DSC),
> +			MERGE_3D_2, sdm845_pp_sblk, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 30),
>  			-1),
> -	PP_BLK("pingpong_5", PINGPONG_5, 0x72800, PINGPONG_SM8150_MASK, MERGE_3D_2, sdm845_pp_sblk,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 31),
> +	PP_BLK("pingpong_5", PINGPONG_5, 0x72800, PINGPONG_SM8150_MASK|BIT(DPU_PINGPONG_DSC),
> +			MERGE_3D_2, sdm845_pp_sblk, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 31),
>  			-1),
>  };
>  
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
> index fec1665..27eda6a 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h
> @@ -116,23 +116,23 @@ static const struct dpu_lm_cfg sc8180x_lm[] = {
>  };
>  
>  static const struct dpu_pingpong_cfg sc8180x_pp[] = {
> -	PP_BLK("pingpong_0", PINGPONG_0, 0x70000, PINGPONG_SM8150_MASK, MERGE_3D_0, sdm845_pp_sblk,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
> +	PP_BLK("pingpong_0", PINGPONG_0, 0x70000, PINGPONG_SM8150_MASK|BIT(DPU_PINGPONG_DSC),
> +			MERGE_3D_0, sdm845_pp_sblk, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
>  			-1),
> -	PP_BLK("pingpong_1", PINGPONG_1, 0x70800, PINGPONG_SM8150_MASK, MERGE_3D_0, sdm845_pp_sblk,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
> +	PP_BLK("pingpong_1", PINGPONG_1, 0x70800, PINGPONG_SM8150_MASK|BIT(DPU_PINGPONG_DSC),
> +			MERGE_3D_0, sdm845_pp_sblk, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
>  			-1),
> -	PP_BLK("pingpong_2", PINGPONG_2, 0x71000, PINGPONG_SM8150_MASK, MERGE_3D_1, sdm845_pp_sblk,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
> +	PP_BLK("pingpong_2", PINGPONG_2, 0x71000, PINGPONG_SM8150_MASK|BIT(DPU_PINGPONG_DSC),
> +			MERGE_3D_1, sdm845_pp_sblk, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
>  			-1),
> -	PP_BLK("pingpong_3", PINGPONG_3, 0x71800, PINGPONG_SM8150_MASK, MERGE_3D_1, sdm845_pp_sblk,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11),
> +	PP_BLK("pingpong_3", PINGPONG_3, 0x71800, PINGPONG_SM8150_MASK|BIT(DPU_PINGPONG_DSC),
> +			MERGE_3D_1, sdm845_pp_sblk, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11),
>  			-1),
> -	PP_BLK("pingpong_4", PINGPONG_4, 0x72000, PINGPONG_SM8150_MASK, MERGE_3D_2, sdm845_pp_sblk,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 30),
> +	PP_BLK("pingpong_4", PINGPONG_4, 0x72000, PINGPONG_SM8150_MASK|BIT(DPU_PINGPONG_DSC),
> +			MERGE_3D_2, sdm845_pp_sblk, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 30),
>  			-1),
> -	PP_BLK("pingpong_5", PINGPONG_5, 0x72800, PINGPONG_SM8150_MASK, MERGE_3D_2, sdm845_pp_sblk,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 31),
> +	PP_BLK("pingpong_5", PINGPONG_5, 0x72800, PINGPONG_SM8150_MASK|BIT(DPU_PINGPONG_DSC),
> +			MERGE_3D_2, sdm845_pp_sblk, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 31),
>  			-1),
>  };
>  
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h
> index 37716b8..70fdd4d 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h
> @@ -129,23 +129,23 @@ static const struct dpu_dspp_cfg sm8250_dspp[] = {
>  };
>  
>  static const struct dpu_pingpong_cfg sm8250_pp[] = {
> -	PP_BLK("pingpong_0", PINGPONG_0, 0x70000, PINGPONG_SM8150_MASK, MERGE_3D_0, sdm845_pp_sblk,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
> +	PP_BLK("pingpong_0", PINGPONG_0, 0x70000, PINGPONG_SM8150_MASK|BIT(DPU_PINGPONG_DSC),
> +			MERGE_3D_0, sdm845_pp_sblk, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
>  			-1),
> -	PP_BLK("pingpong_1", PINGPONG_1, 0x70800, PINGPONG_SM8150_MASK, MERGE_3D_0, sdm845_pp_sblk,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
> +	PP_BLK("pingpong_1", PINGPONG_1, 0x70800, PINGPONG_SM8150_MASK|BIT(DPU_PINGPONG_DSC),
> +			MERGE_3D_0, sdm845_pp_sblk, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
>  			-1),
> -	PP_BLK("pingpong_2", PINGPONG_2, 0x71000, PINGPONG_SM8150_MASK, MERGE_3D_1, sdm845_pp_sblk,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
> +	PP_BLK("pingpong_2", PINGPONG_2, 0x71000, PINGPONG_SM8150_MASK|BIT(DPU_PINGPONG_DSC),
> +			MERGE_3D_1, sdm845_pp_sblk, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
>  			-1),
> -	PP_BLK("pingpong_3", PINGPONG_3, 0x71800, PINGPONG_SM8150_MASK, MERGE_3D_1, sdm845_pp_sblk,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11),
> +	PP_BLK("pingpong_3", PINGPONG_3, 0x71800, PINGPONG_SM8150_MASK|BIT(DPU_PINGPONG_DSC),
> +			MERGE_3D_1, sdm845_pp_sblk, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11),
>  			-1),
> -	PP_BLK("pingpong_4", PINGPONG_4, 0x72000, PINGPONG_SM8150_MASK, MERGE_3D_2, sdm845_pp_sblk,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 30),
> +	PP_BLK("pingpong_4", PINGPONG_4, 0x72000, PINGPONG_SM8150_MASK|BIT(DPU_PINGPONG_DSC),
> +			MERGE_3D_2, sdm845_pp_sblk, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 30),
>  			-1),
> -	PP_BLK("pingpong_5", PINGPONG_5, 0x72800, PINGPONG_SM8150_MASK, MERGE_3D_2, sdm845_pp_sblk,
> -			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 31),
> +	PP_BLK("pingpong_5", PINGPONG_5, 0x72800, PINGPONG_SM8150_MASK|BIT(DPU_PINGPONG_DSC),
> +			MERGE_3D_2, sdm845_pp_sblk, DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 31),
>  			-1),
>  };
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
