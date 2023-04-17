Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3179A6E42DC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 10:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjDQIoC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Apr 2023 04:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjDQIn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 04:43:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77A8E49
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 01:43:53 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1poKSO-000303-Km; Mon, 17 Apr 2023 10:43:28 +0200
Message-ID: <3e47f0d1017fe4c9f71a5de65f32c6ba1662efe2.camel@pengutronix.de>
Subject: Re: [PATCH 1/6] drm: bridge: samsung-dsim: Support multi-lane
 calculations
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Adam Ford <aford173@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        aford@beaconembedded.com,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Fabio Estevam <festevam@gmail.com>, m.szyprowski@samsung.com,
        marex@denx.de, Robert Foss <rfoss@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Jonas Karlman <jonas@kwiboo.se>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Inki Dae <inki.dae@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Date:   Mon, 17 Apr 2023 10:43:25 +0200
In-Reply-To: <20230415104104.5537-1-aford173@gmail.com>
References: <20230415104104.5537-1-aford173@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

Am Samstag, dem 15.04.2023 um 05:40 -0500 schrieb Adam Ford:
> If there is more than one lane, the HFP, HBP, and HSA is calculated in
> bytes/pixel, then they are divided amongst the different lanes with some
> additional overhead. This is necessary to achieve higher resolutions while
> keeping the pixel clocks lower as the number of lanes increase.
> 

In the testing I did to come up with my patch "drm: bridge: samsung-
dsim: fix blanking packet size calculation" the number of lanes didn't
make any difference. My testing might be flawed, as I could only
measure the blanking after translation from MIPI DSI to DPI, so I'm
interested to know what others did here. How did you validate the
blanking with your patch? Would you have a chance to test my patch and
see if it works or breaks in your setup?

Regards,
Lucas

> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
>  drivers/gpu/drm/bridge/samsung-dsim.c | 40 +++++++++++++++++++++++----
>  1 file changed, 34 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
> index e0a402a85787..1ccbad4ea577 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -215,6 +215,7 @@
>  #define DSI_RX_FIFO_SIZE		256
>  #define DSI_XFER_TIMEOUT_MS		100
>  #define DSI_RX_FIFO_EMPTY		0x30800002
> +#define DSI_HSYNC_PKT_OVERHEAD	6
>  
>  #define OLD_SCLK_MIPI_CLK_NAME		"pll_clk"
>  
> @@ -879,13 +880,40 @@ static void samsung_dsim_set_display_mode(struct samsung_dsim *dsi)
>  			| DSIM_MAIN_VBP(m->vtotal - m->vsync_end);
>  		samsung_dsim_write(dsi, DSIM_MVPORCH_REG, reg);
>  
> -		reg = DSIM_MAIN_HFP(m->hsync_start - m->hdisplay)
> -			| DSIM_MAIN_HBP(m->htotal - m->hsync_end);
> -		samsung_dsim_write(dsi, DSIM_MHPORCH_REG, reg);
> +		/*
> +		 * If there is more than one lane, the HFP, HBP, and HSA
> +		 * is calculated in bytes/pixel, then they are divided
> +		 * amongst the different lanes with some additional
> +		 * overhead correction
> +		 */
> +		if (dsi->lanes > 1) {
> +			u32 hfp, hbp, hsa;
> +			int bpp = mipi_dsi_pixel_format_to_bpp(dsi->format) / 8;
> +
> +			hfp = ((m->hsync_start - m->hdisplay) * bpp) / dsi->lanes;
> +			hfp -= (hfp > DSI_HSYNC_PKT_OVERHEAD) ? DSI_HSYNC_PKT_OVERHEAD : 0;
> +
> +			hbp = ((m->htotal - m->hsync_end) * bpp) / dsi->lanes;
> +			hbp -= (hbp > DSI_HSYNC_PKT_OVERHEAD) ? DSI_HSYNC_PKT_OVERHEAD : 0;
>  
> -		reg = DSIM_MAIN_VSA(m->vsync_end - m->vsync_start)
> -			| DSIM_MAIN_HSA(m->hsync_end - m->hsync_start);
> -		samsung_dsim_write(dsi, DSIM_MSYNC_REG, reg);
> +			hsa = ((m->hsync_end - m->hsync_start) * bpp) / dsi->lanes;
> +			hsa -= (hsa > DSI_HSYNC_PKT_OVERHEAD) ? DSI_HSYNC_PKT_OVERHEAD : 0;
> +
> +			reg = DSIM_MAIN_HFP(hfp) | DSIM_MAIN_HBP(hbp);
> +			samsung_dsim_write(dsi, DSIM_MHPORCH_REG, reg);
> +
> +			reg = DSIM_MAIN_VSA(m->vsync_end - m->vsync_start)
> +				| DSIM_MAIN_HSA(hsa);
> +			samsung_dsim_write(dsi, DSIM_MSYNC_REG, reg);
> +		} else {
> +			reg = DSIM_MAIN_HFP(m->hsync_start - m->hdisplay)
> +				| DSIM_MAIN_HBP(m->htotal - m->hsync_end);
> +			samsung_dsim_write(dsi, DSIM_MHPORCH_REG, reg);
> +
> +			reg = DSIM_MAIN_VSA(m->vsync_end - m->vsync_start)
> +				| DSIM_MAIN_HSA(m->hsync_end - m->hsync_start);
> +			samsung_dsim_write(dsi, DSIM_MSYNC_REG, reg);
> +		}
>  	}
>  	reg =  DSIM_MAIN_HRESOL(m->hdisplay, num_bits_resol) |
>  		DSIM_MAIN_VRESOL(m->vdisplay, num_bits_resol);

