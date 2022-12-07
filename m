Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A461645438
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 07:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiLGGpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 01:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiLGGpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 01:45:43 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162672A723
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 22:45:42 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1p2oBE-0006IE-Kn; Wed, 07 Dec 2022 07:45:20 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1p2oB1-0008S8-Sx; Wed, 07 Dec 2022 07:45:07 +0100
Date:   Wed, 7 Dec 2022 07:45:07 +0100
From:   Sascha Hauer <sha@pengutronix.de>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 1/5] drm/rockchip: rgb: embed drm_encoder into
 rockchip_encoder
Message-ID: <20221207064507.GV29728@pengutronix.de>
References: <20221130140217.3196414-1-michael.riesch@wolfvision.net>
 <20221130140217.3196414-2-michael.riesch@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130140217.3196414-2-michael.riesch@wolfvision.net>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 03:02:13PM +0100, Michael Riesch wrote:
> Commit 540b8f271e53 ("drm/rockchip: Embed drm_encoder into
> rockchip_decoder") provides the means to pass the endpoint ID to the
> VOP2 driver, which sets the interface MUX accordingly. However, this
> step has not yet been carried out for the RGB output block. Embed the
> drm_encoder structure into the rockchip_encoder structure and set the
> endpoint ID correctly.
> 
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
>  drivers/gpu/drm/rockchip/rockchip_rgb.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_rgb.c b/drivers/gpu/drm/rockchip/rockchip_rgb.c
> index 75eb7cca3d82..16201a5cf1e8 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_rgb.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_rgb.c
> @@ -18,17 +18,17 @@
>  #include <drm/drm_probe_helper.h>
>  #include <drm/drm_simple_kms_helper.h>
>  
> +#include <dt-bindings/soc/rockchip,vop2.h>
> +
>  #include "rockchip_drm_drv.h"
>  #include "rockchip_drm_vop.h"
>  #include "rockchip_rgb.h"
>  
> -#define encoder_to_rgb(c) container_of(c, struct rockchip_rgb, encoder)
> -
>  struct rockchip_rgb {
>  	struct device *dev;
>  	struct drm_device *drm_dev;
>  	struct drm_bridge *bridge;
> -	struct drm_encoder encoder;
> +	struct rockchip_encoder encoder;
>  	struct drm_connector connector;
>  	int output_mode;
>  };
> @@ -125,7 +125,7 @@ struct rockchip_rgb *rockchip_rgb_init(struct device *dev,
>  		return ERR_PTR(ret);
>  	}
>  
> -	encoder = &rgb->encoder;
> +	encoder = &rgb->encoder.encoder;
>  	encoder->possible_crtcs = drm_crtc_mask(crtc);
>  
>  	ret = drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_NONE);
> @@ -161,6 +161,8 @@ struct rockchip_rgb *rockchip_rgb_init(struct device *dev,
>  		goto err_free_encoder;
>  	}
>  
> +	rgb->encoder.crtc_endpoint_id = ROCKCHIP_VOP2_EP_RGB0;

This is vop2 specific. This code is used with the vop1 as well, so it
doesn't look like it belongs here, at least not hidden in a patch titled
"embed drm_encoder into rockchip_encoder".

Normally the crtc_endpoint_id is set by the encoder, coming from the
encoder node, asking the question "To which port on the VOP am I
connected to?"

Here the situation is different. We are called from the VOP and the
question instead is: "Is there something connected to VPx endpoint id
ROCKCHIP_VOP2_EP_RGB0?"

You might need a vop2 specific entry to this code.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
