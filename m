Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44DA70CBDD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 23:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbjEVVCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 17:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbjEVVBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 17:01:51 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [5.144.164.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12A39D
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 14:01:50 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 98EC93EED4;
        Mon, 22 May 2023 23:01:48 +0200 (CEST)
Date:   Mon, 22 May 2023 23:01:46 +0200
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
Subject: Re: [PATCH v4 5/5] drm/msm/dsi: Remove incorrect references to
 slice_count
Message-ID: <r3xfucsag7odjsmpdys2aibairgvocqrgg6inpcdr2yoz2ktkd@c24h7frzzzkj>
References: <20230405-add-dsc-support-v4-0-15daf84f8dcb@quicinc.com>
 <20230405-add-dsc-support-v4-5-15daf84f8dcb@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405-add-dsc-support-v4-5-15daf84f8dcb@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-22 13:30:24, Jessica Zhang wrote:
> Currently, slice_count is being used to calculate word count and
> pkt_per_line. Instead, these values should be calculated using slice per
> packet, which is not the same as slice_count.
> 
> Slice count represents the number of soft slices per interface, and its
> value will not always match that of slice per packet. For example, it is
> possible to have cases where there are multiple soft slices per interface
> but the panel specifies only one slice per packet.

As discussed in many patches before, there is no definition of "soft
slices" anyhwere.  Unless we can have that, and reference it, this
should more clearly explain what it means or leave out the word "soft"
altogether.

> Thus, use the default value of one slice per packet and remove slice_count
> from the aforementioned calculations.
> 
> Fixes: 08802f515c3c ("drm/msm/dsi: Add support for DSC configuration")
> Fixes: bc6b6ff8135c ("drm/msm/dsi: Use DSC slice(s) packet size to compute word count")
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index d04f8bbd707d..2eed99afdba9 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -866,18 +866,17 @@ static void dsi_update_dsc_timing(struct msm_dsi_host *msm_host, bool is_cmd_mod
>  	 */
>  	slice_per_intf = msm_dsc_get_slices_per_intf(dsc, hdisplay);
>  
> -	/*
> -	 * If slice_count is greater than slice_per_intf
> -	 * then default to 1. This can happen during partial
> -	 * update.
> -	 */
> -	if (dsc->slice_count > slice_per_intf)
> -		dsc->slice_count = 1;
> -
>  	total_bytes_per_intf = dsc->slice_chunk_size * slice_per_intf;
>  
>  	eol_byte_num = total_bytes_per_intf % 3;
> -	pkt_per_line = slice_per_intf / dsc->slice_count;
> +
> +	/*
> +	 * Typically, pkt_per_line = slice_per_intf * slice_per_pkt.
> +	 *
> +	 * Since the current driver only supports slice_per_pkt = 1,
> +	 * pkt_per_line will be equal to slice per intf for now.
> +	 */
> +	pkt_per_line = slice_per_intf;
>  
>  	if (is_cmd_mode) /* packet data type */
>  		reg = DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM0_DATATYPE(MIPI_DSI_DCS_LONG_WRITE);
> @@ -1001,7 +1000,14 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>  		if (!msm_host->dsc)
>  			wc = hdisplay * dsi_get_bpp(msm_host->format) / 8 + 1;
>  		else
> -			wc = msm_host->dsc->slice_chunk_size * msm_host->dsc->slice_count + 1;
> +			/*
> +			 * When DSC is enabled, WC = slice_chunk_size * slice_per_packet + 1.
> +			 * Currently, the driver only supports default value of slice_per_packet = 1
> +			 *
> +			 * TODO: Expand mipi_dsi_device struct to hold slice_per_packet info
> +			 *       and adjust DSC math to account for slice_per_packet.
> +			 */

Either rename this all to slice_per_pkt, or rename the above comment to
slice_per_packet.

After improving on that:

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>

We all learned the wrong thing initially, thanks for clearing up that
slice_count != slice_per_pkt.

- Marijn

> +			wc = msm_host->dsc->slice_chunk_size + 1;
>  
>  		dsi_write(msm_host, REG_DSI_CMD_MDP_STREAM0_CTRL,
>  			DSI_CMD_MDP_STREAM0_CTRL_WORD_COUNT(wc) |
> 
> -- 
> 2.40.1
> 
