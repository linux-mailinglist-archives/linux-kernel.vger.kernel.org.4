Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C7F5F1F55
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 22:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiJAUXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 16:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiJAUXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 16:23:17 -0400
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [5.144.164.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E52E3C8C2
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 13:23:16 -0700 (PDT)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id A6E70200A7;
        Sat,  1 Oct 2022 22:23:14 +0200 (CEST)
Date:   Sat, 1 Oct 2022 22:23:13 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Douglas Anderson <dianders@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Lyude Paul <lyude@redhat.com>
Subject: Re: [PATCH 5/5] drm/dsc: Prevent negative BPG offsets from shadowing
 adjacent bitfields
Message-ID: <20221001202313.fkdsv5ul4v6akhc3@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Douglas Anderson <dianders@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Lyude Paul <lyude@redhat.com>
References: <20221001190807.358691-1-marijn.suijten@somainline.org>
 <20221001190807.358691-6-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221001190807.358691-6-marijn.suijten@somainline.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-01 21:08:07, Marijn Suijten wrote:
> msm's dsi_host specifies negative BPG offsets which fill the full 8 bits
> of a char thanks to two's complement: this however results in those bits
> bleeding into the next parameter when the field is only expected to
> contain 6-bit wide values.
> As a consequence random slices appear corrupted on-screen (tested on a
> Sony Tama Akatsuki device with sdm845).
> 
> Use AND operators to limit all values that constitute the RC Range
> parameter fields to their expected size.
> 
> Fixes: b9080324d6ca ("drm/msm/dsi: add support for dsc data")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  drivers/gpu/drm/display/drm_dsc_helper.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/display/drm_dsc_helper.c b/drivers/gpu/drm/display/drm_dsc_helper.c
> index c869c6e51e2b..2e7ef242685d 100644
> --- a/drivers/gpu/drm/display/drm_dsc_helper.c
> +++ b/drivers/gpu/drm/display/drm_dsc_helper.c
> @@ -243,11 +243,11 @@ void drm_dsc_pps_payload_pack(struct drm_dsc_picture_parameter_set *pps_payload,
>  	 */
>  	for (i = 0; i < DSC_NUM_BUF_RANGES; i++) {
>  		pps_payload->rc_range_parameters[i] =
> -			cpu_to_be16((dsc_cfg->rc_range_params[i].range_min_qp <<
> +			cpu_to_be16(((dsc_cfg->rc_range_params[i].range_min_qp & 0x1f) <<
>  				     DSC_PPS_RC_RANGE_MINQP_SHIFT) |
> -				    (dsc_cfg->rc_range_params[i].range_max_qp <<
> +				    ((dsc_cfg->rc_range_params[i].range_max_qp & 0x1f) <<
>  				     DSC_PPS_RC_RANGE_MAXQP_SHIFT) |
> -				    (dsc_cfg->rc_range_params[i].range_bpg_offset));
> +				    (dsc_cfg->rc_range_params[i].range_bpg_offset & 0x3f));

Pre-empting the reviews: I was contemplating whether to use FIELD_PREP
here, given that it's not yet used anywhere else in this file.  For that
I'd remove the existing _SHIFT definitions and replace them with:

	#define DSC_PPS_RC_RANGE_MINQP_MASK		GENMASK(15, 11)
	#define DSC_PPS_RC_RANGE_MAXQP_MASK		GENMASK(10, 6)
	#define DSC_PPS_RC_RANGE_BPG_OFFSET_MASK	GENMASK(5, 0)

And turn this section of code into:

	cpu_to_be16(FIELD_PREP(DSC_PPS_RC_RANGE_MINQP_MASK,
			       dsc_cfg->rc_range_params[i].range_min_qp) |
		    FIELD_PREP(DSC_PPS_RC_RANGE_MAXQP_MASK,
			       dsc_cfg->rc_range_params[i].range_max_qp) |
		    FIELD_PREP(DSC_PPS_RC_RANGE_BPG_OFFSET_MASK,
			       dsc_cfg->rc_range_params[i].range_bpg_offset));

Is that okay/recommended?

- Marijn

>  	}
>  
>  	/* PPS 88 */
> -- 
> 2.37.3
> 
