Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8DE677665
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 09:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjAWIjQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 Jan 2023 03:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjAWIjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 03:39:14 -0500
X-Greylist: delayed 1556 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Jan 2023 00:39:11 PST
Received: from smtprelay02.ispgateway.de (smtprelay02.ispgateway.de [80.67.18.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED731CAFD;
        Mon, 23 Jan 2023 00:39:11 -0800 (PST)
Received: from [89.1.81.74] (helo=karo-electronics.de)
        by smtprelay02.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <LW@KARO-electronics.de>)
        id 1pJrxh-0005ss-PT; Mon, 23 Jan 2023 09:13:53 +0100
Date:   Mon, 23 Jan 2023 09:13:07 +0100
From:   Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        marex@denx.de, stefan@agner.ch, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
Subject: Re: [PATCH 2/2] drm: lcdif: Add i.MX93 LCDIF support
Message-ID: <20230123091307.46ace33f@karo-electronics.de>
In-Reply-To: <20230123072358.1060670-3-victor.liu@nxp.com>
References: <20230123072358.1060670-1-victor.liu@nxp.com>
        <20230123072358.1060670-3-victor.liu@nxp.com>
Organization: Ka-Ro electronics GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Df-Sender: bHdAa2Fyby1lbGVjdHJvbmljcy5kb21haW5mYWN0b3J5LWt1bmRlLmRl
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 23 Jan 2023 15:23:58 +0800 Liu Ying wrote:
> The LCDIF embedded in i.MX93 SoC is essentially the same to those
> in i.MX8mp SoC.  However, i.MX93 LCDIF may connect with MIPI DSI
> controller through LCDIF cross line pattern(controlled by mediamix
> blk-ctrl) or connect with LVDS display bridge(LDB) directly or a
> parallel display(also through mediamix blk-ctrl), so add multiple
> encoders(with DRM_MODE_ENCODER_NONE encoder type) support in the
> LCDIF DRM driver and find a bridge to attach the relevant encoder's
> chain when needed.  While at it, derive lcdif_crtc_state structure
> from drm_crtc_state structure to introduce bus_format and bus_flags
> states so that the next downstream bridges may use consistent bus
> format and bus flags.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
>  drivers/gpu/drm/mxsfb/lcdif_drv.c |  73 +++++++++--
>  drivers/gpu/drm/mxsfb/lcdif_drv.h |   6 +-
>  drivers/gpu/drm/mxsfb/lcdif_kms.c | 206 ++++++++++++++++++++----------
>  3 files changed, 208 insertions(+), 77 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mxsfb/lcdif_drv.c b/drivers/gpu/drm/mxsfb/lcdif_drv.c
> index cc2ceb301b96..4d41f6b6eb14 100644
> --- a/drivers/gpu/drm/mxsfb/lcdif_drv.c
> +++ b/drivers/gpu/drm/mxsfb/lcdif_drv.c
> @@ -9,13 +9,16 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/of_graph.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_bridge.h>
>  #include <drm/drm_drv.h>
> +#include <drm/drm_encoder.h>
>  #include <drm/drm_fbdev_generic.h>
>  #include <drm/drm_gem_dma_helper.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
> @@ -38,21 +41,70 @@ static const struct drm_mode_config_helper_funcs lcdif_mode_config_helpers = {
>  	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
>  };
>  
> +static const struct drm_encoder_funcs lcdif_encoder_funcs = {
> +	.destroy = drm_encoder_cleanup,
> +};
> +
>  static int lcdif_attach_bridge(struct lcdif_drm_private *lcdif)
>  {
> -	struct drm_device *drm = lcdif->drm;
> +	struct device *dev = lcdif->drm->dev;
> +	struct device_node *ep;
>  	struct drm_bridge *bridge;
>  	int ret;
>  
> -	bridge = devm_drm_of_get_bridge(drm->dev, drm->dev->of_node, 0, 0);
> -	if (IS_ERR(bridge))
> -		return PTR_ERR(bridge);
> -
> -	ret = drm_bridge_attach(&lcdif->encoder, bridge, NULL, 0);
> -	if (ret)
> -		return dev_err_probe(drm->dev, ret, "Failed to attach bridge\n");
> -
> -	lcdif->bridge = bridge;
> +	for_each_endpoint_of_node(dev->of_node, ep) {
> +		struct device_node *remote;
> +		struct of_endpoint of_ep;
> +		struct drm_encoder *encoder;
> +
> +		remote = of_graph_get_remote_port_parent(ep);
> +		if (!remote || !of_device_is_available(remote)) {
'!remote ||' is redundant, since of_device_is_available already checks
for a NULL pointer.

[...]

> diff --git a/drivers/gpu/drm/mxsfb/lcdif_kms.c b/drivers/gpu/drm/mxsfb/lcdif_kms.c
> index 262bc43b1079..ba36447ed900 100644
> --- a/drivers/gpu/drm/mxsfb/lcdif_kms.c
> +++ b/drivers/gpu/drm/mxsfb/lcdif_kms.c
[...]
> @@ -529,6 +580,46 @@ static void lcdif_crtc_atomic_disable(struct drm_crtc *crtc,
>  	pm_runtime_put_sync(drm->dev);
>  }
>  
> +static void lcdif_crtc_reset(struct drm_crtc *crtc)
> +{
> +	struct lcdif_crtc_state *state;
> +
> +	if (crtc->state)
> +		__drm_atomic_helper_crtc_destroy_state(crtc->state);
> +
> +	kfree(to_lcdif_crtc_state(crtc->state));
>
If crtc-state can be NULL at this point, this will only work as long as
'base' is the first member of the lcdif_crtc_state struct (which
currently is the case, but there is no guarantee that this will always
be this way), otherwise the if clause above is not needed.



Lothar Waßmann
