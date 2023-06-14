Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8DB72F9E6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240126AbjFNJ4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243143AbjFNJ4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:56:44 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B66173C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 02:56:38 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 655E63F2DD;
        Wed, 14 Jun 2023 11:56:36 +0200 (CEST)
Date:   Wed, 14 Jun 2023 11:56:35 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, quic_abhinavk@quicinc.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] drm/msm/dsi: Enable DATABUS_WIDEN for DSI command
 mode
Message-ID: <ky7sgsaohak2pcdf6pbhedfyrwk4ea7y3ekfqlw7rn6cpk4rhe@rjuhb23n37oz>
References: <20230525-add-widebus-support-v1-0-c7069f2efca1@quicinc.com>
 <20230525-add-widebus-support-v1-3-c7069f2efca1@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525-add-widebus-support-v1-3-c7069f2efca1@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-13 18:57:13, Jessica Zhang wrote:
> DSI 6G v2.5.x+ supports a data-bus widen mode that allows DSI to send
> 48 bits of compressed data per pclk instead of 24.
> 
> For all chipsets that support this mode, enable it whenever DSC is
> enabled as recommend by the hardware programming guide.
> 
> Only enable this for command mode as we are currently unable to validate
> it for video mode.
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
> 
> Note: The dsi.xml.h changes were generated using the headergen2 script in
> envytools [1], but the changes to the copyright and rules-ng-ng source file
> paths were dropped.
> 
> [1] https://github.com/freedreno/envytools/

More interesting would be a link to the Mesa MR upstreaming this
bitfield to dsi.xml [2] (which I have not found on my own yet).

[2]: https://gitlab.freedesktop.org/mesa/mesa/-/blame/main/src/freedreno/registers/dsi/dsi.xml

>  drivers/gpu/drm/msm/dsi/dsi.xml.h  |  1 +
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 19 ++++++++++++++++++-
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi.xml.h b/drivers/gpu/drm/msm/dsi/dsi.xml.h
> index a4a154601114..2a7d980e12c3 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi.xml.h
> +++ b/drivers/gpu/drm/msm/dsi/dsi.xml.h
> @@ -664,6 +664,7 @@ static inline uint32_t DSI_CMD_MODE_MDP_CTRL2_INPUT_RGB_SWAP(enum dsi_rgb_swap v
>  	return ((val) << DSI_CMD_MODE_MDP_CTRL2_INPUT_RGB_SWAP__SHIFT) & DSI_CMD_MODE_MDP_CTRL2_INPUT_RGB_SWAP__MASK;
>  }
>  #define DSI_CMD_MODE_MDP_CTRL2_BURST_MODE			0x00010000
> +#define DSI_CMD_MODE_MDP_CTRL2_DATABUS_WIDEN			0x00100000
> 
>  #define REG_DSI_CMD_MODE_MDP_STREAM2_CTRL			0x000001b8
>  #define DSI_CMD_MODE_MDP_STREAM2_CTRL_DATA_TYPE__MASK		0x0000003f
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 5d7b4409e4e9..1da5238e7105 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -927,6 +927,9 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>  	u32 hdisplay = mode->hdisplay;
>  	u32 wc;
>  	int ret;
> +	bool widebus_supported = msm_host->cfg_hnd->major == MSM_DSI_VER_MAJOR_6G &&
> +			msm_host->cfg_hnd->minor >= MSM_DSI_6G_VER_MINOR_V2_5_0;
> +
> 
>  	DBG("");
> 
> @@ -973,8 +976,15 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>  		 *
>  		 * hdisplay will be divided by 3 here to account for the fact
>  		 * that DPU sends 3 bytes per pclk cycle to DSI.
> +		 *
> +		 * If widebus is supported, set DATABUS_WIDEN register and divide hdisplay by 6
> +		 * instead of 3

So this should allow us to divide pclk by 2, or have much lower latency?
Otherwise it'll tick enough times to transmit the data twice.

Note that I brought up the exact same concerns when you used the 3:1
ratio from dsi_bpp / dsc_bpp in your pclk reduction patch (instad of the
number of bits/bytes that DPU sends to DSI per pclk), but no-one has
replied to my inquiry yet.

>  		 */
> -		hdisplay = DIV_ROUND_UP(msm_dsc_get_bytes_per_line(msm_host->dsc), 3);
> +		if (!(msm_host->mode_flags & MIPI_DSI_MODE_VIDEO) && widebus_supported)
> +			hdisplay = DIV_ROUND_UP(msm_dsc_get_bytes_per_line(msm_host->dsc), 6);
> +		else
> +			hdisplay = DIV_ROUND_UP(msm_dsc_get_bytes_per_line(msm_host->dsc), 3);

Nit: I wonder if this is more concise when written as:

    u32 bytes_per_pclk;
    ...
    if (!video && widebus)
        bytes_per_pclk = 6;
    else
        bytes_per_pclk = 3;

    hdisplay = DIV_ROUND_UP(msm_dsc_get_bytes_per_line(msm_host->dsc),
                            bytes_per_pclk);

That is less duplication, **and** the value becomes self-documenting!

> +
>  		h_total += hdisplay;
>  		ha_end = ha_start + hdisplay;
>  	}
> @@ -1027,6 +1037,13 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>  		dsi_write(msm_host, REG_DSI_CMD_MDP_STREAM0_TOTAL,
>  			DSI_CMD_MDP_STREAM0_TOTAL_H_TOTAL(hdisplay) |
>  			DSI_CMD_MDP_STREAM0_TOTAL_V_TOTAL(mode->vdisplay));
> +
> +		if (msm_host->dsc && widebus_supported) {

Can we also support widebus for uncompressed streams (sending 2 pixels
of bpp=24 per pclk), and if so, is that something you want to add in the
future (a comment would be nice)?

> +			u32 mdp_ctrl2 = dsi_read(msm_host, REG_DSI_CMD_MODE_MDP_CTRL2);
> +
> +			mdp_ctrl2 |= DSI_CMD_MODE_MDP_CTRL2_DATABUS_WIDEN;
> +			dsi_write(msm_host, REG_DSI_CMD_MODE_MDP_CTRL2, mdp_ctrl2);
> +		}

Same comment as on your BURST_MODE patch (which this'll conflict with):
does this belong to the timing setup or is it better moved to
dsi_ctrl_config?

- Marijn

>  	}
>  }
> 
> 
> --
> 2.40.1
> 
