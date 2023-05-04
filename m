Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF5D6F70FE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjEDRgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEDRgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:36:01 -0400
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [IPv6:2001:4b7a:2000:18::170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9970F40D5
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 10:36:00 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 384D820C74;
        Thu,  4 May 2023 19:35:57 +0200 (CEST)
Date:   Thu, 4 May 2023 19:35:55 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, dmitry.baryshkov@linaro.org,
        andersson@kernel.org, quic_abhinavk@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/7] drm/msm/dpu: add DPU_PINGPONG_DSC feature bit
Message-ID: <e42qmaqhejk6gcnhgtbuztmowsxqg6tcq6snvuikibximazfmm@jimsewkykwnt>
References: <1683218805-23419-1-git-send-email-quic_khsieh@quicinc.com>
 <1683218805-23419-3-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1683218805-23419-3-git-send-email-quic_khsieh@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-04 09:46:40, Kuogee Hsieh wrote:
> DPU < 7.0.0 requires the  PINGPONG block to be involved during

Nit: double space.

> DSC setting up. Since DPU < 7.0.0, enabling and starting the DSC

That should be >=.

> encoder engine moved to INTF with the help of the flush mechanism.
> Add a DPU_PINGPONG_DSC feature bit to restrict the availability of
> dpu_hw_pp_setup_dsc() and dpu_hw_pp_dsc_{enable,disable}() on the
> PINGPONG block to DPU < 7.0.0 hardware, as the registers are not
> available [in the PINGPONG block] on DPU 7.0.0 and higher anymore.
> Existing call-sites to these callbacks already skip calling into
> them if the function pointer is NULL.
> 
> Changes in v4:
> -- add more details commit text
> 
> Changes in v5:
> -- reword commit text suggested by Marijn
> -- delet comma
> -- use test_bit()
> 
> Reported-by: Marijn Suijten <marijn.suijten@somainline.org>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

This patch isn't strictly bisectable, but I'll explain in patch 3/7.
After addressing the '<' -> '>=' typo above, this is:

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h  | 4 +++-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c | 6 ++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> index 6ee48f0..dc0a4da 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> @@ -144,7 +144,8 @@ enum {
>   * @DPU_PINGPONG_TE2        Additional tear check block for split pipes
>   * @DPU_PINGPONG_SPLIT      PP block supports split fifo
>   * @DPU_PINGPONG_SLAVE      PP block is a suitable slave for split fifo
> - * @DPU_PINGPONG_DITHER,    Dither blocks
> + * @DPU_PINGPONG_DITHER     Dither blocks
> + * @DPU_PINGPONG_DSC        PP ops functions required for DSC
>   * @DPU_PINGPONG_MAX
>   */
>  enum {
> @@ -153,6 +154,7 @@ enum {
>  	DPU_PINGPONG_SPLIT,
>  	DPU_PINGPONG_SLAVE,
>  	DPU_PINGPONG_DITHER,
> +	DPU_PINGPONG_DSC,
>  	DPU_PINGPONG_MAX
>  };
>  
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
> index 79e4576..e7f47a4 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
> @@ -295,6 +295,12 @@ static void _setup_pingpong_ops(struct dpu_hw_pingpong *c,
>  	c->ops.enable_dsc = dpu_hw_pp_dsc_enable;
>  	c->ops.disable_dsc = dpu_hw_pp_dsc_disable;
>  
> +	if (test_bit(DPU_PINGPONG_DSC, &features)) {
> +		c->ops.setup_dsc = dpu_hw_pp_setup_dsc;
> +		c->ops.enable_dsc = dpu_hw_pp_dsc_enable;
> +		c->ops.disable_dsc = dpu_hw_pp_dsc_disable;
> +	}
> +
>  	if (test_bit(DPU_PINGPONG_DITHER, &features))
>  		c->ops.setup_dither = dpu_hw_pp_setup_dither;
>  };
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
