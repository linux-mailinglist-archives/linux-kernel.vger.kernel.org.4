Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570457068CF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 15:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjEQNBx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 17 May 2023 09:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjEQNBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 09:01:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36539AA
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 06:01:45 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1pzGmd-00020O-ER; Wed, 17 May 2023 15:01:35 +0200
Message-ID: <f67301f5870e78f65104618316d851feb25d9aa3.camel@pengutronix.de>
Subject: Re: [PATCH V6 6/6] drm: bridge: samsung-dsim: Support non-burst mode
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Adam Ford <aford173@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     Marek Vasut <marex@denx.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>, aford@beaconembedded.com,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 17 May 2023 15:01:33 +0200
In-Reply-To: <20230515235713.232939-7-aford173@gmail.com>
References: <20230515235713.232939-1-aford173@gmail.com>
         <20230515235713.232939-7-aford173@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, dem 15.05.2023 um 18:57 -0500 schrieb Adam Ford:
> The high-speed clock is hard-coded to the burst-clock
> frequency specified in the device tree.  However, when
> using devices like certain bridge chips without burst mode
> and varying resolutions and refresh rates, it may be
> necessary to set the high-speed clock dynamically based
> on the desired pixel clock for the connected device.
> 
> This also removes the need to set a clock speed from
> the device tree for non-burst mode operation, since the
> pixel clock rate is the rate requested from the attached
> device like a bridge chip. 
> 

Same as with the earlier patch, this needs to be documented in the DT
binding by moving "samsung,burst-clock-frequency" to be a optional
property.

Regards,
Lucas

>  This should have no impact
> for people using burst-mode and setting the burst clock
> rate is still required for those users.  If the burst
> clock is not present, change the error message to
> dev_info indicating the clock use the pixel clock.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
>  drivers/gpu/drm/bridge/samsung-dsim.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
> index 3944b7cfbbdf..03b21d13f067 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -655,16 +655,28 @@ static unsigned long samsung_dsim_set_pll(struct samsung_dsim *dsi,
>  
>  	dsi->hs_clock = fout;
>  
> +	dsi->hs_clock = fout;
> +
>  	return fout;
>  }
>  
>  static int samsung_dsim_enable_clock(struct samsung_dsim *dsi)
>  {
> -	unsigned long hs_clk, byte_clk, esc_clk;
> +	unsigned long hs_clk, byte_clk, esc_clk, pix_clk;
>  	unsigned long esc_div;
>  	u32 reg;
> +	struct drm_display_mode *m = &dsi->mode;
> +	int bpp = mipi_dsi_pixel_format_to_bpp(dsi->format);
> +
> +	/* m->clock is in KHz */
> +	pix_clk = m->clock * 1000;
> +
> +	/* Use burst_clk_rate if available, otherwise use the pix_clk */
> +	if (dsi->burst_clk_rate)
> +		hs_clk = samsung_dsim_set_pll(dsi, dsi->burst_clk_rate);
> +	else
> +		hs_clk = samsung_dsim_set_pll(dsi, DIV_ROUND_UP(pix_clk * bpp, dsi->lanes));
>  
> -	hs_clk = samsung_dsim_set_pll(dsi, dsi->burst_clk_rate);
>  	if (!hs_clk) {
>  		dev_err(dsi->dev, "failed to configure DSI PLL\n");
>  		return -EFAULT;
> @@ -935,7 +947,7 @@ static void samsung_dsim_set_display_mode(struct samsung_dsim *dsi)
>  	u32 reg;
>  
>  	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO) {
> -		int byte_clk_khz = dsi->burst_clk_rate / 1000 / 8;
> +		int byte_clk_khz = dsi->hs_clock / 1000 / 8;
>  		int hfp = (m->hsync_start - m->hdisplay) * byte_clk_khz / m->clock;
>  		int hbp = (m->htotal - m->hsync_end) * byte_clk_khz / m->clock;
>  		int hsa = (m->hsync_end - m->hsync_start) * byte_clk_khz / m->clock;
> @@ -1785,10 +1797,13 @@ static int samsung_dsim_parse_dt(struct samsung_dsim *dsi)
>  			return PTR_ERR(pll_clk);
>  	}
>  
> +	/* If it doesn't exist, use pixel clock instead of failing */
>  	ret = samsung_dsim_of_read_u32(node, "samsung,burst-clock-frequency",
> -				       &dsi->burst_clk_rate, 0);
> -	if (ret < 0)
> -		return ret;
> +				       &dsi->burst_clk_rate, 1);
> +	if (ret < 0) {
> +		dev_info(dev, "Using pixel clock for HS clock frequency\n");
> +		dsi->burst_clk_rate = 0;
> +	}
>  
>  	ret = samsung_dsim_of_read_u32(node, "samsung,esc-clock-frequency",
>  				       &dsi->esc_clk_rate, 0);

