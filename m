Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E529C739F8A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 13:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjFVLf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 07:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjFVLfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 07:35:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36ED42132
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 04:34:54 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qCIZs-0004YH-U2; Thu, 22 Jun 2023 13:34:16 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qCIZp-0001NE-H1; Thu, 22 Jun 2023 13:34:13 +0200
Date:   Thu, 22 Jun 2023 13:34:13 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Jonas Karlman <jonas@kwiboo.se>
Cc:     Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andy Yan <andy.yan@rock-chips.com>,
        Rob Herring <robh@kernel.org>,
        Mark Yao <markyao0591@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] drm/rockchip: vop2: Add missing call to crtc
 reset helper
Message-ID: <20230622113413.GL18491@pengutronix.de>
References: <20230621223311.2239547-1-jonas@kwiboo.se>
 <20230621223311.2239547-6-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621223311.2239547-6-jonas@kwiboo.se>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
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

On Wed, Jun 21, 2023 at 10:33:23PM +0000, Jonas Karlman wrote:
> Add missing call to crtc reset helper to properly vblank reset.
> 
> Also move vop2_crtc_reset and call vop2_crtc_destroy_state to simplify
> and remove duplicated code.
> 
> Fixes: 604be85547ce ("drm/rockchip: Add VOP2 driver")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v2:
> - Add check for allocation failure (Sascha)

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> 
>  drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 31 +++++++++-----------
>  1 file changed, 14 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> index f725487d02ef..5ba83121a1b9 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> @@ -2080,23 +2080,6 @@ static const struct drm_crtc_helper_funcs vop2_crtc_helper_funcs = {
>  	.atomic_disable = vop2_crtc_atomic_disable,
>  };
>  
> -static void vop2_crtc_reset(struct drm_crtc *crtc)
> -{
> -	struct rockchip_crtc_state *vcstate = to_rockchip_crtc_state(crtc->state);
> -
> -	if (crtc->state) {
> -		__drm_atomic_helper_crtc_destroy_state(crtc->state);
> -		kfree(vcstate);
> -	}
> -
> -	vcstate = kzalloc(sizeof(*vcstate), GFP_KERNEL);
> -	if (!vcstate)
> -		return;
> -
> -	crtc->state = &vcstate->base;
> -	crtc->state->crtc = crtc;
> -}
> -
>  static struct drm_crtc_state *vop2_crtc_duplicate_state(struct drm_crtc *crtc)
>  {
>  	struct rockchip_crtc_state *vcstate;
> @@ -2123,6 +2106,20 @@ static void vop2_crtc_destroy_state(struct drm_crtc *crtc,
>  	kfree(vcstate);
>  }
>  
> +static void vop2_crtc_reset(struct drm_crtc *crtc)
> +{
> +	struct rockchip_crtc_state *vcstate =
> +		kzalloc(sizeof(*vcstate), GFP_KERNEL);
> +
> +	if (crtc->state)
> +		vop2_crtc_destroy_state(crtc, crtc->state);
> +
> +	if (vcstate)
> +		__drm_atomic_helper_crtc_reset(crtc, &vcstate->base);
> +	else
> +		__drm_atomic_helper_crtc_reset(crtc, NULL);
> +}
> +
>  static const struct drm_crtc_funcs vop2_crtc_funcs = {
>  	.set_config = drm_atomic_helper_set_config,
>  	.page_flip = drm_atomic_helper_page_flip,
> -- 
> 2.41.0
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
