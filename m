Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4E87068E4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 15:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjEQNHA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 17 May 2023 09:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjEQNG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 09:06:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF3C10C6
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 06:06:53 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1pzGrN-0002yE-Fg; Wed, 17 May 2023 15:06:29 +0200
Message-ID: <c747c38ecd4a52ad51021cc0cb5ce9854b7378d3.camel@pengutronix.de>
Subject: Re: [PATCH V6 5/6] drm: bridge: samsung-dsim: Dynamically configure
 DPHY timing
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Adam Ford <aford173@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     aford@beaconembedded.com, Chen-Yu Tsai <wenst@chromium.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Marek Vasut <marex@denx.de>, linux-kernel@vger.kernel.org
Date:   Wed, 17 May 2023 15:06:26 +0200
In-Reply-To: <20230515235713.232939-6-aford173@gmail.com>
References: <20230515235713.232939-1-aford173@gmail.com>
         <20230515235713.232939-6-aford173@gmail.com>
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
> The DPHY timings are currently hard coded. Since the input
> clock can be variable, the phy timings need to be variable
> too.  To facilitate this, we need to cache the hs_clock
> based on what is generated from the PLL.
> 
> The phy_mipi_dphy_get_default_config_for_hsclk function
> configures the DPHY timings in pico-seconds, and a small macro
> converts those timings into clock cycles based on the hs_clk.
> 
I'm not going apply a review tag to a patch where I contributed myself,
but FWIW this looks good to me.

> Signed-off-by: Adam Ford <aford173@gmail.com>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Tested-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/gpu/drm/bridge/samsung-dsim.c | 57 +++++++++++++++++++++++----
>  include/drm/bridge/samsung-dsim.h     |  1 +
>  2 files changed, 51 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
> index 08266303c261..3944b7cfbbdf 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -218,6 +218,8 @@
>  
>  #define OLD_SCLK_MIPI_CLK_NAME		"pll_clk"
>  
> +#define PS_TO_CYCLE(ps, hz) DIV64_U64_ROUND_CLOSEST(((ps) * (hz)), 1000000000000ULL)
> +
>  static const char *const clk_names[5] = {
>  	"bus_clk",
>  	"sclk_mipi",
> @@ -651,6 +653,8 @@ static unsigned long samsung_dsim_set_pll(struct samsung_dsim *dsi,
>  		reg = samsung_dsim_read(dsi, DSIM_STATUS_REG);
>  	} while ((reg & DSIM_PLL_STABLE) == 0);
>  
> +	dsi->hs_clock = fout;
> +
>  	return fout;
>  }
>  
> @@ -698,13 +702,46 @@ static void samsung_dsim_set_phy_ctrl(struct samsung_dsim *dsi)
>  	const struct samsung_dsim_driver_data *driver_data = dsi->driver_data;
>  	const unsigned int *reg_values = driver_data->reg_values;
>  	u32 reg;
> +	struct phy_configure_opts_mipi_dphy cfg;
> +	int clk_prepare, lpx, clk_zero, clk_post, clk_trail;
> +	int hs_exit, hs_prepare, hs_zero, hs_trail;
> +	unsigned long long byte_clock = dsi->hs_clock / 8;
>  
>  	if (driver_data->has_freqband)
>  		return;
>  
> +	phy_mipi_dphy_get_default_config_for_hsclk(dsi->hs_clock,
> +						   dsi->lanes, &cfg);
> +
> +	/*
> +	 * TODO:
> +	 * The tech reference manual for i.MX8M Mini/Nano/Plus
> +	 * doesn't state what the definition of the PHYTIMING
> +	 * bits are beyond their address and bit position.
> +	 * After reviewing NXP's downstream code, it appears
> +	 * that the various PHYTIMING registers take the number
> +	 * of cycles and use various dividers on them.  This
> +	 * calculation does not result in an exact match to the
> +	 * downstream code, but it is very close, and it appears
> +	 * to sync at a variety of resolutions. If someone
> +	 * can get a more accurate mathematical equation needed
> +	 * for these registers, this should be updated.
> +	 */
> +
> +	lpx = PS_TO_CYCLE(cfg.lpx, byte_clock);
> +	hs_exit = PS_TO_CYCLE(cfg.hs_exit, byte_clock);
> +	clk_prepare = PS_TO_CYCLE(cfg.clk_prepare, byte_clock);
> +	clk_zero = PS_TO_CYCLE(cfg.clk_zero, byte_clock);
> +	clk_post = PS_TO_CYCLE(cfg.clk_post, byte_clock);
> +	clk_trail = PS_TO_CYCLE(cfg.clk_trail, byte_clock);
> +	hs_prepare = PS_TO_CYCLE(cfg.hs_prepare, byte_clock);
> +	hs_zero = PS_TO_CYCLE(cfg.hs_zero, byte_clock);
> +	hs_trail = PS_TO_CYCLE(cfg.hs_trail, byte_clock);
> +
>  	/* B D-PHY: D-PHY Master & Slave Analog Block control */
>  	reg = reg_values[PHYCTRL_ULPS_EXIT] | reg_values[PHYCTRL_VREG_LP] |
>  		reg_values[PHYCTRL_SLEW_UP];
> +
>  	samsung_dsim_write(dsi, DSIM_PHYCTRL_REG, reg);
>  
>  	/*
> @@ -712,7 +749,9 @@ static void samsung_dsim_set_phy_ctrl(struct samsung_dsim *dsi)
>  	 * T HS-EXIT: Time that the transmitter drives LP-11 following a HS
>  	 *	burst
>  	 */
> -	reg = reg_values[PHYTIMING_LPX] | reg_values[PHYTIMING_HS_EXIT];
> +
> +	reg  = DSIM_PHYTIMING_LPX(lpx) | DSIM_PHYTIMING_HS_EXIT(hs_exit);
> +
>  	samsung_dsim_write(dsi, DSIM_PHYTIMING_REG, reg);
>  
>  	/*
> @@ -728,10 +767,11 @@ static void samsung_dsim_set_phy_ctrl(struct samsung_dsim *dsi)
>  	 * T CLK-TRAIL: Time that the transmitter drives the HS-0 state after
>  	 *	the last payload clock bit of a HS transmission burst
>  	 */
> -	reg = reg_values[PHYTIMING_CLK_PREPARE] |
> -		reg_values[PHYTIMING_CLK_ZERO] |
> -		reg_values[PHYTIMING_CLK_POST] |
> -		reg_values[PHYTIMING_CLK_TRAIL];
> +
> +	reg = DSIM_PHYTIMING1_CLK_PREPARE(clk_prepare)	|
> +	      DSIM_PHYTIMING1_CLK_ZERO(clk_zero)	|
> +	      DSIM_PHYTIMING1_CLK_POST(clk_post)	|
> +	      DSIM_PHYTIMING1_CLK_TRAIL(clk_trail);
>  
>  	samsung_dsim_write(dsi, DSIM_PHYTIMING1_REG, reg);
>  
> @@ -744,8 +784,11 @@ static void samsung_dsim_set_phy_ctrl(struct samsung_dsim *dsi)
>  	 * T HS-TRAIL: Time that the transmitter drives the flipped differential
>  	 *	state after last payload data bit of a HS transmission burst
>  	 */
> -	reg = reg_values[PHYTIMING_HS_PREPARE] | reg_values[PHYTIMING_HS_ZERO] |
> -		reg_values[PHYTIMING_HS_TRAIL];
> +
> +	reg = DSIM_PHYTIMING2_HS_PREPARE(hs_prepare) |
> +	      DSIM_PHYTIMING2_HS_ZERO(hs_zero) |
> +	      DSIM_PHYTIMING2_HS_TRAIL(hs_trail);
> +
>  	samsung_dsim_write(dsi, DSIM_PHYTIMING2_REG, reg);
>  }
>  
> diff --git a/include/drm/bridge/samsung-dsim.h b/include/drm/bridge/samsung-dsim.h
> index a1a5b2b89a7a..d9d431e3b65a 100644
> --- a/include/drm/bridge/samsung-dsim.h
> +++ b/include/drm/bridge/samsung-dsim.h
> @@ -93,6 +93,7 @@ struct samsung_dsim {
>  
>  	u32 pll_clk_rate;
>  	u32 burst_clk_rate;
> +	u32 hs_clock;
>  	u32 esc_clk_rate;
>  	u32 lanes;
>  	u32 mode_flags;

