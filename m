Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDE26EC694
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 08:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjDXGxs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Apr 2023 02:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbjDXGxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 02:53:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F652133
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 23:53:36 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1pqq4Z-0005EU-Cb; Mon, 24 Apr 2023 08:53:15 +0200
Message-ID: <59b186dc70934320e9af6b2b916b5253fdaff444.camel@pengutronix.de>
Subject: Re: [PATCH V2 2/6] drm: bridge: samsung-dsim: Fix PMS Calculator on
 imx8m[mnp]
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Adam Ford <aford173@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     m.szyprowski@samsung.com, aford@beaconembedded.com,
        dario.binacchi@amarulasolutions.com,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Marek Vasut <marex@denx.de>,
        linux-kernel@vger.kernel.org
Date:   Mon, 24 Apr 2023 08:53:00 +0200
In-Reply-To: <20230423121232.1345909-3-aford173@gmail.com>
References: <20230423121232.1345909-1-aford173@gmail.com>
         <20230423121232.1345909-3-aford173@gmail.com>
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

Am Sonntag, dem 23.04.2023 um 07:12 -0500 schrieb Adam Ford:
> According to Table 13-45 of the i.MX8M Mini Reference Manual, the min
> and max values for M and the frequency range for the VCO_out
> calculator were incorrect.  This information was contradicted in other
> parts of the mini, nano and plus manuals.  After reaching out to my
> NXP Rep, when confronting him about discrepencies in the Nano manual,
> he responded with:
>  "Yes it is definitely wrong, the one that is part
>   of the NOTE in MIPI_DPHY_M_PLLPMS register table against PMS_P,
>   PMS_M and PMS_S is not correct. I will report this to Doc team,
>   the one customer should be take into account is the Table 13-40
>   DPHY PLL Parameters and the Note above."
> 
> These updated values also match what is used in the NXP downstream
> kernel.
> 
> To fix this, make new variables to hold the min and max values of m
> and the minimum value of VCO_out, and update the PMS calculator to
> use these new variables instead of using hard-coded values to keep
> the backwards compatibility with other parts using this driver.
> 
> Fixes: 4d562c70c4dc ("drm: bridge: samsung-dsim: Add i.MX8M Mini/Nano support")
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/gpu/drm/bridge/samsung-dsim.c | 22 ++++++++++++++++++++--
>  include/drm/bridge/samsung-dsim.h     |  3 +++
>  2 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
> index 2be3b58624c3..adb9c13c5f7f 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -405,6 +405,9 @@ static const struct samsung_dsim_driver_data exynos3_dsi_driver_data = {
>  	.num_bits_resol = 11,
>  	.pll_p_offset = 13,
>  	.reg_values = reg_values,
> +	.m_min = 41,
> +	.m_max = 125,
> +	.vco_min = 500,
>  };
>  
>  static const struct samsung_dsim_driver_data exynos4_dsi_driver_data = {
> @@ -418,6 +421,9 @@ static const struct samsung_dsim_driver_data exynos4_dsi_driver_data = {
>  	.num_bits_resol = 11,
>  	.pll_p_offset = 13,
>  	.reg_values = reg_values,
> +	.m_min = 41,
> +	.m_max = 125,
> +	.vco_min = 500,
>  };
>  
>  static const struct samsung_dsim_driver_data exynos5_dsi_driver_data = {
> @@ -429,6 +435,9 @@ static const struct samsung_dsim_driver_data exynos5_dsi_driver_data = {
>  	.num_bits_resol = 11,
>  	.pll_p_offset = 13,
>  	.reg_values = reg_values,
> +	.m_min = 41,
> +	.m_max = 125,
> +	.vco_min = 500,
>  };
>  
>  static const struct samsung_dsim_driver_data exynos5433_dsi_driver_data = {
> @@ -441,6 +450,9 @@ static const struct samsung_dsim_driver_data exynos5433_dsi_driver_data = {
>  	.num_bits_resol = 12,
>  	.pll_p_offset = 13,
>  	.reg_values = exynos5433_reg_values,
> +	.m_min = 41,
> +	.m_max = 125,
> +	.vco_min = 500,
>  };
>  
>  static const struct samsung_dsim_driver_data exynos5422_dsi_driver_data = {
> @@ -453,6 +465,9 @@ static const struct samsung_dsim_driver_data exynos5422_dsi_driver_data = {
>  	.num_bits_resol = 12,
>  	.pll_p_offset = 13,
>  	.reg_values = exynos5422_reg_values,
> +	.m_min = 41,
> +	.m_max = 125,
> +	.vco_min = 500,
>  };
>  
>  static const struct samsung_dsim_driver_data imx8mm_dsi_driver_data = {
> @@ -469,6 +484,9 @@ static const struct samsung_dsim_driver_data imx8mm_dsi_driver_data = {
>  	 */
>  	.pll_p_offset = 14,
>  	.reg_values = imx8mm_dsim_reg_values,
> +	.m_min = 64,
> +	.m_max = 1023,
> +	.vco_min = 1050,
>  };
>  
>  static const struct samsung_dsim_driver_data *
> @@ -547,12 +565,12 @@ static unsigned long samsung_dsim_pll_find_pms(struct samsung_dsim *dsi,
>  			tmp = (u64)fout * (_p << _s);
>  			do_div(tmp, fin);
>  			_m = tmp;
> -			if (_m < 41 || _m > 125)
> +			if (_m < driver_data->m_min || _m > driver_data->m_max)
>  				continue;
>  
>  			tmp = (u64)_m * fin;
>  			do_div(tmp, _p);
> -			if (tmp < 500 * MHZ ||
> +			if (tmp < driver_data->vco_min  * MHZ ||
>  			    tmp > driver_data->max_freq * MHZ)
>  				continue;
>  
> diff --git a/include/drm/bridge/samsung-dsim.h b/include/drm/bridge/samsung-dsim.h
> index ba5484de2b30..a088d84579bc 100644
> --- a/include/drm/bridge/samsung-dsim.h
> +++ b/include/drm/bridge/samsung-dsim.h
> @@ -59,6 +59,9 @@ struct samsung_dsim_driver_data {
>  	unsigned int num_bits_resol;
>  	unsigned int pll_p_offset;
>  	const unsigned int *reg_values;
> +	u16 m_min;
> +	u16 m_max;
> +	u64 vco_min;
>  };
>  
>  struct samsung_dsim_host_ops {

