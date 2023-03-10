Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6606B4A4B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjCJPVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234183AbjCJPUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:20:49 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5C312BDC;
        Fri, 10 Mar 2023 07:11:27 -0800 (PST)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 01FC946D;
        Fri, 10 Mar 2023 16:01:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1678460478;
        bh=cTpJb1a+SSpxJzWK29EE2rEdOl4zGiuIlFPihCIIxd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oD83KOYUmmnHR+XWWr7/Wwzdb0ZeYNG9kTRYwolbUK7VXCIjF2a/2F73U7nEuSmdx
         fR8+ONEn6COI5BO1sps/voMajtrIF6fI07a2aHdC6XBljXNezjONFmHFBPTxWzII1W
         LlaopDSq7+htewCk+xr4cRtpntf/t2GgBXi9Y5CQ=
Date:   Fri, 10 Mar 2023 17:01:22 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Liu Ying <victor.liu@nxp.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Emma Anholt <emma@anholt.net>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] drm: Use of_property_present() for testing DT property
 presence
Message-ID: <20230310150122.GJ5342@pendragon.ideasonboard.com>
References: <20230310144705.1542207-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230310144705.1542207-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thank you for the patch.

On Fri, Mar 10, 2023 at 08:47:05AM -0600, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/imx/imx8qxp-pixel-link.c | 2 +-
>  drivers/gpu/drm/drm_mipi_dsi.c                  | 2 +-
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c         | 2 +-
>  drivers/gpu/drm/sun4i/sun4i_backend.c           | 2 +-
>  drivers/gpu/drm/sun4i/sun8i_mixer.c             | 2 +-
>  drivers/gpu/drm/vc4/vc4_hdmi.c                  | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-link.c b/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-link.c
> index 9e5f2b4dc2e5..fab139b324af 100644
> --- a/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-link.c
> +++ b/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-link.c
> @@ -313,7 +313,7 @@ imx8qxp_pixel_link_find_next_bridge(struct imx8qxp_pixel_link *pl)
>  		}
>  
>  		/* specially select the next bridge with companion PXL2DPI */
> -		if (of_find_property(remote, "fsl,companion-pxl2dpi", NULL))
> +		if (of_property_present(remote, "fsl,companion-pxl2dpi"))
>  			bridge_sel = ep_cnt;
>  
>  		ep_cnt++;
> diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
> index b41aaf2bb9f1..7900a4707d7c 100644
> --- a/drivers/gpu/drm/drm_mipi_dsi.c
> +++ b/drivers/gpu/drm/drm_mipi_dsi.c
> @@ -329,7 +329,7 @@ int mipi_dsi_host_register(struct mipi_dsi_host *host)
>  
>  	for_each_available_child_of_node(host->dev->of_node, node) {
>  		/* skip nodes without reg property */
> -		if (!of_find_property(node, "reg", NULL))
> +		if (!of_property_present(node, "reg"))
>  			continue;
>  		of_mipi_dsi_device_add(host, node);
>  	}
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> index ce6b76c45b6f..2359dca80492 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -964,7 +964,7 @@ static void adreno_get_pwrlevels(struct device *dev,
>  	gpu->fast_rate = 0;
>  
>  	/* You down with OPP? */
> -	if (!of_find_property(dev->of_node, "operating-points-v2", NULL))
> +	if (!of_property_present(dev->of_node, "operating-points-v2"))
>  		ret = adreno_get_legacy_pwrlevels(dev);
>  	else {
>  		ret = devm_pm_opp_of_add_table(dev);
> diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
> index 38070fc261f3..b11dbd50d73e 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> @@ -792,7 +792,7 @@ static int sun4i_backend_bind(struct device *dev, struct device *master,
>  	dev_set_drvdata(dev, backend);
>  	spin_lock_init(&backend->frontend_lock);
>  
> -	if (of_find_property(dev->of_node, "interconnects", NULL)) {
> +	if (of_property_present(dev->of_node, "interconnects")) {
>  		/*
>  		 * This assume we have the same DMA constraints for all our the
>  		 * devices in our pipeline (all the backends, but also the
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> index bafee05f6b24..11d5244a5aa5 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> @@ -391,7 +391,7 @@ static int sun8i_mixer_bind(struct device *dev, struct device *master,
>  	mixer->engine.ops = &sun8i_engine_ops;
>  	mixer->engine.node = dev->of_node;
>  
> -	if (of_find_property(dev->of_node, "iommus", NULL)) {
> +	if (of_property_present(dev->of_node, "iommus")) {
>  		/*
>  		 * This assume we have the same DMA constraints for
>  		 * all our the mixers in our pipeline. This sounds
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index ea22c9bf223a..bec1e0cdddb3 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -3018,7 +3018,7 @@ static int vc4_hdmi_cec_init(struct vc4_hdmi *vc4_hdmi)
>  	struct device *dev = &pdev->dev;
>  	int ret;
>  
> -	if (!of_find_property(dev->of_node, "interrupts", NULL)) {
> +	if (!of_property_present(dev->of_node, "interrupts")) {
>  		dev_warn(dev, "'interrupts' DT property is missing, no CEC\n");
>  		return 0;
>  	}

-- 
Regards,

Laurent Pinchart
