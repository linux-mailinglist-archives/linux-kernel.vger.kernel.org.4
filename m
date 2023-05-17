Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40D47068BF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjEQM5H convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 17 May 2023 08:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjEQM5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:57:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50711A4
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 05:57:03 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1pzGi5-0001Dc-5f; Wed, 17 May 2023 14:56:53 +0200
Message-ID: <1c8997c7c72143d130ebbc9ba438cebddc9d35e0.camel@pengutronix.de>
Subject: Re: [PATCH V6 3/6] drm: bridge: samsung-dsim: Fetch
 pll-clock-frequency automatically
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
Date:   Wed, 17 May 2023 14:56:47 +0200
In-Reply-To: <20230515235713.232939-4-aford173@gmail.com>
References: <20230515235713.232939-1-aford173@gmail.com>
         <20230515235713.232939-4-aford173@gmail.com>
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

Hi Adam,

Am Montag, dem 15.05.2023 um 18:57 -0500 schrieb Adam Ford:
> Make the pll-clock-frequency optional.  If it's present, use it
> to maintain backwards compatibility with existing hardware.  If it
> is absent, read clock rate of "sclk_mipi" to determine the rate.
> Since it can be optional, change the message from an error to
> dev_info.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
>  drivers/gpu/drm/bridge/samsung-dsim.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
> index bf4b33d2de76..08266303c261 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -1712,11 +1712,11 @@ static const struct mipi_dsi_host_ops samsung_dsim_ops = {
>  };
>  
>  static int samsung_dsim_of_read_u32(const struct device_node *np,
> -				    const char *propname, u32 *out_value)
> +				    const char *propname, u32 *out_value, bool optional)
>  {
>  	int ret = of_property_read_u32(np, propname, out_value);
>  
> -	if (ret < 0)
> +	if (ret < 0 && !optional)
>  		pr_err("%pOF: failed to get '%s' property\n", np, propname);
>  
>  	return ret;
> @@ -1726,20 +1726,29 @@ static int samsung_dsim_parse_dt(struct samsung_dsim *dsi)
>  {
>  	struct device *dev = dsi->dev;
>  	struct device_node *node = dev->of_node;
> +	struct clk *pll_clk;
>  	int ret;
>  
>  	ret = samsung_dsim_of_read_u32(node, "samsung,pll-clock-frequency",
> -				       &dsi->pll_clk_rate);
> -	if (ret < 0)
> -		return ret;
> +				       &dsi->pll_clk_rate, 1);
> +
> +	/* If it doesn't exist, read it from the clock instead of failing */
> +	if (ret < 0) {
> +		dev_info(dev, "Using sclk_mipi for pll clock frequency\n");

While this is certainly helpful while debugging the driver, I don't
think it warrants a info print. Remove or downgrade to dev_dbg?

On the other hand the changed driver behavior should be documented in
the devicetree binding by moving "samsung,pll-clock-frequency" into the
optional properties and spelling out which clock rate is used when the
property is absent.

Regards,
Lucas

> +		pll_clk = devm_clk_get(dev, "sclk_mipi");
> +		if (!IS_ERR(pll_clk))
> +			dsi->pll_clk_rate = clk_get_rate(pll_clk);
> +		else
> +			return PTR_ERR(pll_clk);
> +	}
>  
>  	ret = samsung_dsim_of_read_u32(node, "samsung,burst-clock-frequency",
> -				       &dsi->burst_clk_rate);
> +				       &dsi->burst_clk_rate, 0);
>  	if (ret < 0)
>  		return ret;
>  
>  	ret = samsung_dsim_of_read_u32(node, "samsung,esc-clock-frequency",
> -				       &dsi->esc_clk_rate);
> +				       &dsi->esc_clk_rate, 0);
>  	if (ret < 0)
>  		return ret;
>  

