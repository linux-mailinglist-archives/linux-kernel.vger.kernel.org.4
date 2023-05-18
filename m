Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E640770887A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 21:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjERTkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 15:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjERTkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 15:40:47 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [5.144.164.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A643198;
        Thu, 18 May 2023 12:40:46 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 448AB203AE;
        Thu, 18 May 2023 21:40:44 +0200 (CEST)
Date:   Thu, 18 May 2023 21:40:43 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, quic_jesszhan@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] drm/msm/dpu: remove GC and IGC related code from
 dpu catalog
Message-ID: <cwnoowgglhlsx7357sddgonyohj7vj3z23bqlgleaskozzpcu2@nnyxzzzyhgem>
References: <20230428223646.23595-1-quic_abhinavk@quicinc.com>
 <20230428223646.23595-3-quic_abhinavk@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428223646.23595-3-quic_abhinavk@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-28 15:36:45, Abhinav Kumar wrote:
> Gamma Correction (GC) and Inverse Gamma Correction(IGC) is
> currently unused. In addition dpu_dspp_sub_blks didn't even have an igc
> member describing the block.
> 
> Drop related code from the dpu hardware catalog otherwise this becomes a
> burden to carry across chipsets in the catalog.
> 
> changes in v3:
> 	- drop IGC related code from dpu_hw_catalog too
> 	- update commit text accordingly
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c |  4 +---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h | 10 ----------
>  2 files changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> index 5d994bce696f..791a6fc8bdbf 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> @@ -91,7 +91,7 @@
>  
>  #define MERGE_3D_SM8150_MASK (0)
>  
> -#define DSPP_MSM8998_MASK BIT(DPU_DSPP_PCC) | BIT(DPU_DSPP_GC)

Oops we weren't even using parenthesis here before...

> +#define DSPP_MSM8998_MASK BIT(DPU_DSPP_PCC)
>  
>  #define DSPP_SC7180_MASK BIT(DPU_DSPP_PCC)
>  
> @@ -449,8 +449,6 @@ static const struct dpu_lm_sub_blks qcm2290_lm_sblk = {
>  static const struct dpu_dspp_sub_blks msm8998_dspp_sblk = {
>  	.pcc = {.id = DPU_DSPP_PCC, .base = 0x1700,
>  		.len = 0x90, .version = 0x10007},
> -	.gc = { .id = DPU_DSPP_GC, .base = 0x17c0,
> -		.len = 0x90, .version = 0x10007},
>  };
>  
>  static const struct dpu_dspp_sub_blks sc7180_dspp_sblk = {
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> index 71584cd56fd7..1230739e37d4 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> @@ -127,13 +127,9 @@ enum {
>  /**
>   * DSPP sub-blocks
>   * @DPU_DSPP_PCC             Panel color correction block
> - * @DPU_DSPP_GC              Gamma correction block
> - * @DPU_DSPP_IGC             Inverse gamma correction block
>   */
>  enum {
>  	DPU_DSPP_PCC = 0x1,
> -	DPU_DSPP_GC,
> -	DPU_DSPP_IGC,
>  	DPU_DSPP_MAX
>  };
>  
> @@ -398,7 +394,6 @@ struct dpu_caps {
>   * @hsic:
>   * @memcolor:
>   * @pcc_blk:
> - * @igc_blk:
>   * @format_list: Pointer to list of supported formats
>   * @num_formats: Number of supported formats
>   * @virt_format_list: Pointer to list of supported formats for virtual planes
> @@ -419,7 +414,6 @@ struct dpu_sspp_sub_blks {
>  	struct dpu_pp_blk hsic_blk;
>  	struct dpu_pp_blk memcolor_blk;
>  	struct dpu_pp_blk pcc_blk;
> -	struct dpu_pp_blk igc_blk;
>  
>  	const u32 *format_list;
>  	u32 num_formats;
> @@ -433,22 +427,18 @@ struct dpu_sspp_sub_blks {
>   * @maxwidth:               Max pixel width supported by this mixer
>   * @maxblendstages:         Max number of blend-stages supported
>   * @blendstage_base:        Blend-stage register base offset
> - * @gc: gamma correction block
>   */
>  struct dpu_lm_sub_blks {
>  	u32 maxwidth;
>  	u32 maxblendstages;
>  	u32 blendstage_base[MAX_BLOCKS];
> -	struct dpu_pp_blk gc;
>  };
>  
>  /**
>   * struct dpu_dspp_sub_blks: Information of DSPP block
> - * @gc : gamma correction block
>   * @pcc: pixel color correction block
>   */
>  struct dpu_dspp_sub_blks {
> -	struct dpu_pp_blk gc;
>  	struct dpu_pp_blk pcc;
>  };
>  
> -- 
> 2.40.1
> 
