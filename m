Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E529645442
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 07:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiLGGvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 01:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiLGGvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 01:51:38 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23782DA9E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 22:51:37 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1p2oHE-0006zz-L7; Wed, 07 Dec 2022 07:51:32 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1p2oHD-0000Bu-FU; Wed, 07 Dec 2022 07:51:31 +0100
Date:   Wed, 7 Dec 2022 07:51:31 +0100
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
Subject: Re: [PATCH 4/5] drm/rockchip: vop2: add support for the rgb output
 block
Message-ID: <20221207065131.GW29728@pengutronix.de>
References: <20221130140217.3196414-1-michael.riesch@wolfvision.net>
 <20221130140217.3196414-5-michael.riesch@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130140217.3196414-5-michael.riesch@wolfvision.net>
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

On Wed, Nov 30, 2022 at 03:02:16PM +0100, Michael Riesch wrote:
> The Rockchip VOP2 features an internal RGB output block, which can be
> attached to the video port 2 of the VOP2. Add support for this output
> block.
> 
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 21 ++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> index 94fddbf70ff6..16041c79d228 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> @@ -39,6 +39,7 @@
>  #include "rockchip_drm_gem.h"
>  #include "rockchip_drm_fb.h"
>  #include "rockchip_drm_vop2.h"
> +#include "rockchip_rgb.h"
>  
>  /*
>   * VOP2 architecture
> @@ -212,6 +213,9 @@ struct vop2 {
>  	struct clk *hclk;
>  	struct clk *aclk;
>  
> +	/* optional internal rgb encoder */
> +	struct rockchip_rgb *rgb;
> +
>  	/* must be put at the end of the struct */
>  	struct vop2_win win[];
>  };
> @@ -2697,11 +2701,25 @@ static int vop2_bind(struct device *dev, struct device *master, void *data)
>  	if (ret)
>  		return ret;
>  
> +	vop2->rgb = rockchip_rgb_init(dev, &vop2->vps[2].crtc, vop2->drm, 2);

Here you assume that the RGB output can only be connected to VP2, but it
could be connected to any other VP as well, and we can find the
description where it actually shall be connected in the device tree.

As mentioned in my comment to patch 1, the question is "Is there
something connected to VPx at endpoint ROCKCHIP_VOP2_EP_RGB0?"

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
