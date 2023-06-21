Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EB5737CDC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbjFUIF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjFUIFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:05:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42649FE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:05:49 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qBsqQ-0008H8-EV; Wed, 21 Jun 2023 10:05:38 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qBsqN-00056Q-PQ; Wed, 21 Jun 2023 10:05:35 +0200
Date:   Wed, 21 Jun 2023 10:05:35 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Jonas Karlman <jonas@kwiboo.se>
Cc:     Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Yao <markyao0591@gmail.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] drm/rockchip: vop: Fix reset of state in duplicate
 state crtc funcs
Message-ID: <20230621080535.GV18491@pengutronix.de>
References: <20230620064732.1525594-1-jonas@kwiboo.se>
 <20230620064732.1525594-2-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620064732.1525594-2-jonas@kwiboo.se>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 06:47:36AM +0000, Jonas Karlman wrote:
> struct rockchip_crtc_state members such as output_type, output_bpc and
> enable_afbc is always reset to zero in the atomic_duplicate_state crtc
> funcs.
> 
> Fix this by using kmemdup on the subclass rockchip_crtc_state struct.
> 
> Fixes: 4e257d9eee23 ("drm/rockchip: get rid of rockchip_drm_crtc_mode_config")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index a530ecc4d207..60b23636a3fe 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> @@ -1614,7 +1614,8 @@ static struct drm_crtc_state *vop_crtc_duplicate_state(struct drm_crtc *crtc)
>  	if (WARN_ON(!crtc->state))
>  		return NULL;
>  
> -	rockchip_state = kzalloc(sizeof(*rockchip_state), GFP_KERNEL);
> +	rockchip_state = kmemdup(to_rockchip_crtc_state(crtc->state),
> +				 sizeof(*rockchip_state), GFP_KERNEL);
>  	if (!rockchip_state)
>  		return NULL;
>  
> -- 
> 2.41.0
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
