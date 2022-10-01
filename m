Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270585F1F5A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 22:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiJAU2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 16:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiJAU2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 16:28:17 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [IPv6:2001:4b7a:2000:18::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B661A41995
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 13:28:15 -0700 (PDT)
Received: from [192.168.1.101] (95.49.31.201.neoplus.adsl.tpnet.pl [95.49.31.201])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id C97B8202FB;
        Sat,  1 Oct 2022 22:28:12 +0200 (CEST)
Message-ID: <6b76b7a4-cf18-345b-629f-f10d608433a1@somainline.org>
Date:   Sat, 1 Oct 2022 22:28:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 3/5] drm/msm/dsi: Account for DSC's bits_per_pixel having
 4 fractional bits
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
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
References: <20221001190807.358691-1-marijn.suijten@somainline.org>
 <20221001190807.358691-4-marijn.suijten@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20221001190807.358691-4-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1.10.2022 21:08, Marijn Suijten wrote:
> drm_dsc_config's bits_per_pixel field holds a fractional value with 4
> bits, which all panel drivers should adhere to for
> drm_dsc_pps_payload_pack() to generate a valid payload.  All code in the
> DSI driver here seems to assume that this field doesn't contain any
> fractional bits, hence resulting in the wrong values being computed.
> Since none of the calculations leave any room for fractional bits or
> seem to indicate any possible area of support, disallow such values
> altogether.
> 
> Fixes: b9080324d6ca ("drm/msm/dsi: add support for dsc data")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 34 +++++++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index cb6f2fa11f58..42a5c9776f52 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -847,6 +847,11 @@ static void dsi_update_dsc_timing(struct msm_dsi_host *msm_host, bool is_cmd_mod
>  	u32 pkt_per_line;
>  	u32 bytes_in_slice;
>  	u32 eol_byte_num;
> +	int bpp = dsc->bits_per_pixel >> 4;
> +
> +	if (dsc->bits_per_pixel & 0xf)
> +		/* dsi_populate_dsc_params() already caught this case */
> +		pr_err("DSI does not support fractional bits_per_pixel\n");
>  
>  	/* first calculate dsc parameters and then program
>  	 * compress mode registers
> @@ -860,7 +865,7 @@ static void dsi_update_dsc_timing(struct msm_dsi_host *msm_host, bool is_cmd_mod
>  	if (slice_per_intf > dsc->slice_count)
>  		dsc->slice_count = 1;
>  
> -	bytes_in_slice = DIV_ROUND_UP(dsc->slice_width * dsc->bits_per_pixel, 8);
> +	bytes_in_slice = DIV_ROUND_UP(dsc->slice_width * bpp, 8);
>  
>  	dsc->slice_chunk_size = bytes_in_slice;
>  
> @@ -913,6 +918,7 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>  	u32 va_end = va_start + mode->vdisplay;
>  	u32 hdisplay = mode->hdisplay;
>  	u32 wc;
> +	int ret;
>  
>  	DBG("");
>  
> @@ -948,7 +954,9 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>  		/* we do the calculations for dsc parameters here so that
>  		 * panel can use these parameters
>  		 */
> -		dsi_populate_dsc_params(dsc);
> +		ret = dsi_populate_dsc_params(dsc);
> +		if (ret)
> +			return;
>  
>  		/* Divide the display by 3 but keep back/font porch and
>  		 * pulse width same
> @@ -1229,6 +1237,10 @@ static int dsi_cmd_dma_add(struct msm_dsi_host *msm_host,
>  	if (packet.size < len)
>  		memset(data + packet.size, 0xff, len - packet.size);
>  
> +	if (msg->type == MIPI_DSI_PICTURE_PARAMETER_SET)
> +		print_hex_dump(KERN_DEBUG, "ALL:", DUMP_PREFIX_NONE,
> +				16, 1, data, len, false);
> +
>  	if (cfg_hnd->ops->tx_buf_put)
>  		cfg_hnd->ops->tx_buf_put(msm_host);
>  
> @@ -1786,6 +1798,12 @@ static int dsi_populate_dsc_params(struct drm_dsc_config *dsc)
>  	int data;
>  	int final_value, final_scale;
>  	int i;
> +	int bpp = dsc->bits_per_pixel >> 4;
> +
> +	if (dsc->bits_per_pixel & 0xf) {
> +		pr_err("DSI does not support fractional bits_per_pixel\n");
> +		return -EINVAL;
> +	}
>  
>  	dsc->rc_model_size = 8192;
>  	dsc->first_line_bpg_offset = 12;
> @@ -1807,7 +1825,7 @@ static int dsi_populate_dsc_params(struct drm_dsc_config *dsc)
>  	}
>  
>  	dsc->initial_offset = 6144; /* Not bpp 12 */
> -	if (dsc->bits_per_pixel != 8)
> +	if (bpp != 8)
>  		dsc->initial_offset = 2048;	/* bpp = 12 */
>  
>  	mux_words_size = 48;		/* bpc == 8/10 */
> @@ -1830,16 +1848,16 @@ static int dsi_populate_dsc_params(struct drm_dsc_config *dsc)
>  	 * params are calculated
>  	 */
>  	groups_per_line = DIV_ROUND_UP(dsc->slice_width, 3);
> -	dsc->slice_chunk_size = dsc->slice_width * dsc->bits_per_pixel / 8;
> -	if ((dsc->slice_width * dsc->bits_per_pixel) % 8)
> +	dsc->slice_chunk_size = dsc->slice_width * bpp / 8;
> +	if ((dsc->slice_width * bpp) % 8)
>  		dsc->slice_chunk_size++;
>  
>  	/* rbs-min */
>  	min_rate_buffer_size =  dsc->rc_model_size - dsc->initial_offset +
> -				dsc->initial_xmit_delay * dsc->bits_per_pixel +
> +				dsc->initial_xmit_delay * bpp +
>  				groups_per_line * dsc->first_line_bpg_offset;
>  
> -	hrd_delay = DIV_ROUND_UP(min_rate_buffer_size, dsc->bits_per_pixel);
> +	hrd_delay = DIV_ROUND_UP(min_rate_buffer_size, bpp);
>  
>  	dsc->initial_dec_delay = hrd_delay - dsc->initial_xmit_delay;
>  
> @@ -1862,7 +1880,7 @@ static int dsi_populate_dsc_params(struct drm_dsc_config *dsc)
>  	data = 2048 * (dsc->rc_model_size - dsc->initial_offset + num_extra_mux_bits);
>  	dsc->slice_bpg_offset = DIV_ROUND_UP(data, groups_total);
>  
> -	target_bpp_x16 = dsc->bits_per_pixel * 16;
> +	target_bpp_x16 = bpp * 16;
>  
>  	data = (dsc->initial_xmit_delay * target_bpp_x16) / 16;
>  	final_value =  dsc->rc_model_size - data + num_extra_mux_bits;
