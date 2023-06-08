Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DB1728995
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 22:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236129AbjFHUgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 16:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjFHUga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 16:36:30 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [IPv6:2001:4b7a:2000:18::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BE7172E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 13:36:27 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id E0389203B0;
        Thu,  8 Jun 2023 22:36:23 +0200 (CEST)
Date:   Thu, 8 Jun 2023 22:36:21 +0200
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
Subject: Re: [PATCH v5 2/5] drm/msm/dsi: Adjust pclk rate for compression
Message-ID: <js3mcglahq53mcyxa6deltjlu4xpc2pnafwz2rbk3dl4ovws2o@5xw2wzvfaj2v>
References: <20230405-add-dsc-support-v5-0-028c10850491@quicinc.com>
 <20230405-add-dsc-support-v5-2-028c10850491@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405-add-dsc-support-v5-2-028c10850491@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Same title suggestion as earlier: s/adjust/reduce

On 2023-05-22 18:08:56, Jessica Zhang wrote:
> Adjust the pclk rate to divide hdisplay by the compression ratio when DSC
> is enabled.
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index a448931af804..88f370dd2ea1 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -561,7 +561,18 @@ void dsi_link_clk_disable_v2(struct msm_dsi_host *msm_host)
>  	clk_disable_unprepare(msm_host->byte_clk);
>  }
>  
> -static unsigned long dsi_get_pclk_rate(const struct drm_display_mode *mode, bool is_bonded_dsi)
> +static unsigned long dsi_adjust_compressed_pclk(const struct drm_display_mode *mode,

Nit: adjust_pclk_for_compression

As discussed before we realized that this change is more-or-less a hack,
since downstream calculates pclk quite differently - at least for
command-mode panels.  Do you still intend to land this patch this way,
or go the proper route by introducing the right math from the get-go?
Or is the math at least correct for video-mode panels?

This function requires a documentation comment to explain that all.

> +		const struct drm_dsc_config *dsc)
> +{
> +	int new_hdisplay = DIV_ROUND_UP(mode->hdisplay * drm_dsc_get_bpp_int(dsc),

This sounds like a prime candidate for msm_dsc_get_bytes_per_line(), if
bits_per_component==8 is assumed.  In fact, it then becomes identical
to the following line in dsi_host.c which you added previously:

	hdisplay = DIV_ROUND_UP(msm_dsc_get_bytes_per_line(msm_host->dsc), 3);

If not, what is the difference between these two calculations?  Maybe
they both need to be in a properly-named helper.

> +			dsc->bits_per_component * 3);

As we established in the drm/msm issue [2] there is currently a
confusion whether this /3 (and the /3 in dsi_timing_setup) come from the
ratio between dsi_get_bpp() and dsc->bpp or something else.  Can you
clarify that with constants and comments?

[2]: https://gitlab.freedesktop.org/drm/msm/-/issues/24

> +
> +	return (new_hdisplay + (mode->htotal - mode->hdisplay))
> +			* mode->vtotal * drm_mode_vrefresh(mode);

As clarified in [1] I was not necessarily suggesting to move this math
to a separate helper, but to also use a few more properly-named
intermediate variables to not have multi-line math and self-documenting
code.  These lines could be split to be much more clear.

[1]: https://lore.kernel.org/linux-arm-msm/u4x2vldkzsokfcpbkz3dtwcllbdk4ljcz6kzuaxt5frx6g76o5@uku6abewvye7/

> +}
> +
> +static unsigned long dsi_get_pclk_rate(const struct drm_display_mode *mode,
> +		const struct drm_dsc_config *dsc, bool is_bonded_dsi)
>  {
>  	unsigned long pclk_rate;
>  
> @@ -576,6 +587,10 @@ static unsigned long dsi_get_pclk_rate(const struct drm_display_mode *mode, bool
>  	if (is_bonded_dsi)
>  		pclk_rate /= 2;
>  
> +	/* If DSC is enabled, divide hdisplay by compression ratio */
> +	if (dsc)
> +		pclk_rate = dsi_adjust_compressed_pclk(mode, dsc);

The confusion with this comment (and the reason the aforementioned
discussion [2] carried on so long) stems from the fact a division makes
sense for a bit/byte clock, but not for a pixel clock: we still intend
to send the same number of pixels, just spending less bytes on them.  So
as you clarify the /3 above, can you also clarify that here or drop this
comment completely when the function is correctly documented instead?

- Marijn

> +
>  	return pclk_rate;
>  }
>  
> @@ -585,7 +600,7 @@ unsigned long dsi_byte_clk_get_rate(struct mipi_dsi_host *host, bool is_bonded_d
>  	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
>  	u8 lanes = msm_host->lanes;
>  	u32 bpp = dsi_get_bpp(msm_host->format);
> -	unsigned long pclk_rate = dsi_get_pclk_rate(mode, is_bonded_dsi);
> +	unsigned long pclk_rate = dsi_get_pclk_rate(mode, msm_host->dsc, is_bonded_dsi);
>  	unsigned long pclk_bpp;
>  
>  	if (lanes == 0) {
> @@ -604,7 +619,7 @@ unsigned long dsi_byte_clk_get_rate(struct mipi_dsi_host *host, bool is_bonded_d
>  
>  static void dsi_calc_pclk(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>  {
> -	msm_host->pixel_clk_rate = dsi_get_pclk_rate(msm_host->mode, is_bonded_dsi);
> +	msm_host->pixel_clk_rate = dsi_get_pclk_rate(msm_host->mode, msm_host->dsc, is_bonded_dsi);
>  	msm_host->byte_clk_rate = dsi_byte_clk_get_rate(&msm_host->base, is_bonded_dsi,
>  							msm_host->mode);
>  
> 
> -- 
> 2.40.1
> 
