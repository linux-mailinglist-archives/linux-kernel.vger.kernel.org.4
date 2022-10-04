Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B3D5F3AA5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 02:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiJDAai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 20:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiJDAad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 20:30:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100D7167FF;
        Mon,  3 Oct 2022 17:30:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CC9B61155;
        Tue,  4 Oct 2022 00:30:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1546EC433D6;
        Tue,  4 Oct 2022 00:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664843430;
        bh=oazTfsFDNvT2Iz6N7NI+gpkBcG9p2DmNk1jSJYgpP2k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NQ35wMlT3S54e72vo+EytanCuWVMEhbhjQr779jzFBQXZ1k2l6lwYAugejfkTewtn
         SKVbKue79GjDtCzBGDTQaXFlDQuS7tyhViby6VveExlP9Ox2bvv3m9D4trX74NQPtU
         QenGKJj5n8PXIGTzRConO33yvAcU8tNLlTZPvpF/u7/GBM+15QDp/90xh4/5nNYEc9
         BLXjjgQPtP360/6dYn44QGQ7R0mOMwB9YhyxBg32COC4X6WXos0dkxfsPG6rg6gjZb
         KdAmpTorBSLUsQ0vSyxDhHDiVog2FBBv4sQNlnUxVXwHUEIs9q8982O5wi/erdWAWg
         3t1HS91i1dyLg==
Date:   Mon, 3 Oct 2022 19:30:25 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
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
        Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 2/5] drm/msm/dsi: Remove repeated calculation of
 slice_per_intf
Message-ID: <20221004003025.vyd5rnswpdb5n5g3@baldur>
References: <20221001190807.358691-1-marijn.suijten@somainline.org>
 <20221001190807.358691-3-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221001190807.358691-3-marijn.suijten@somainline.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 01, 2022 at 09:08:04PM +0200, Marijn Suijten wrote:
> slice_per_intf is already computed for intf_width, which holds the same
> value as hdisplay.
> 
> Fixes: 08802f515c3c ("drm/msm/dsi: Add support for DSC configuration")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index e05bae647431..cb6f2fa11f58 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -842,7 +842,7 @@ static void dsi_ctrl_config(struct msm_dsi_host *msm_host, bool enable,
>  static void dsi_update_dsc_timing(struct msm_dsi_host *msm_host, bool is_cmd_mode, u32 hdisplay)
>  {
>  	struct drm_dsc_config *dsc = msm_host->dsc;
> -	u32 reg, intf_width, reg_ctrl, reg_ctrl2;
> +	u32 reg, reg_ctrl, reg_ctrl2;
>  	u32 slice_per_intf, total_bytes_per_intf;
>  	u32 pkt_per_line;
>  	u32 bytes_in_slice;
> @@ -851,8 +851,7 @@ static void dsi_update_dsc_timing(struct msm_dsi_host *msm_host, bool is_cmd_mod
>  	/* first calculate dsc parameters and then program
>  	 * compress mode registers
>  	 */
> -	intf_width = hdisplay;
> -	slice_per_intf = DIV_ROUND_UP(intf_width, dsc->slice_width);
> +	slice_per_intf = DIV_ROUND_UP(hdisplay, dsc->slice_width);
>  
>  	/* If slice_per_pkt is greater than slice_per_intf
>  	 * then default to 1. This can happen during partial
> @@ -861,7 +860,6 @@ static void dsi_update_dsc_timing(struct msm_dsi_host *msm_host, bool is_cmd_mod
>  	if (slice_per_intf > dsc->slice_count)
>  		dsc->slice_count = 1;
>  
> -	slice_per_intf = DIV_ROUND_UP(hdisplay, dsc->slice_width);
>  	bytes_in_slice = DIV_ROUND_UP(dsc->slice_width * dsc->bits_per_pixel, 8);
>  
>  	dsc->slice_chunk_size = bytes_in_slice;
> -- 
> 2.37.3
> 
