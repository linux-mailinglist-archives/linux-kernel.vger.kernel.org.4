Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99B16BD1B6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjCPOGJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 16 Mar 2023 10:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjCPOGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:06:07 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46B21EFEB
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:06:02 -0700 (PDT)
Received: from [62.91.42.93] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pcoEl-0001uw-A0; Thu, 16 Mar 2023 15:05:47 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     hjc@rock-chips.com, airlied@gmail.com, daniel@ffwll.ch,
        nathan@kernel.org, ndesaulniers@google.com,
        michael.riesch@wolfvision.net, s.hauer@pengutronix.de,
        Tom Rix <trix@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: Re: [PATCH] drm/rockchip: vop2: fix uninitialized variable possible_crtcs
Date:   Thu, 16 Mar 2023 15:05:46 +0100
Message-ID: <8664878.T7Z3S40VBb@phil>
In-Reply-To: <20230316132302.531724-1-trix@redhat.com>
References: <20230316132302.531724-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 16. März 2023, 14:23:02 CET schrieb Tom Rix:
> clang reportes this error
> drivers/gpu/drm/rockchip/rockchip_drm_vop2.c:2322:8: error:
>   variable 'possible_crtcs' is used uninitialized whenever 'if'
>   condition is false [-Werror,-Wsometimes-uninitialized]
>                         if (vp) {
>                             ^~
> drivers/gpu/drm/rockchip/rockchip_drm_vop2.c:2336:36: note:
>   uninitialized use occurs here
>                 ret = vop2_plane_init(vop2, win, possible_crtcs);
>                                                  ^~~~~~~~~~~~~~
> drivers/gpu/drm/rockchip/rockchip_drm_vop2.c:2322:4:
>   note: remove the 'if' if its condition is always true
>                         if (vp) {
>                         ^~~~~~~~
> 
> The else-statement changes the win->type to OVERLAY without setting the
> possible_crtcs variable.  Rework the block, initialize possible_crtcs to
> 0 to remove the else-statement.  Split the else-if-statement out to its
> own if-statement so the OVERLAY check will catch when the win-type has
> been changed.
> 
> Fixes: 368419a2d429 ("drm/rockchip: vop2: initialize possible_crtcs properly")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> index 03ca32cd2050..fce992c3506f 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> @@ -2301,7 +2301,7 @@ static int vop2_create_crtcs(struct vop2 *vop2)
>  	nvp = 0;
>  	for (i = 0; i < vop2->registered_num_wins; i++) {
>  		struct vop2_win *win = &vop2->win[i];
> -		u32 possible_crtcs;
> +		u32 possible_crtcs = 0;
>  
>  		if (vop2->data->soc_id == 3566) {
>  			/*
> @@ -2327,12 +2327,11 @@ static int vop2_create_crtcs(struct vop2 *vop2)
>  				/* change the unused primary window to overlay window */
>  				win->type = DRM_PLANE_TYPE_OVERLAY;
>  			}
> -		} else if (win->type == DRM_PLANE_TYPE_OVERLAY) {
> -			possible_crtcs = (1 << nvps) - 1;
> -		} else {
> -			possible_crtcs = 0;
>  		}
>  
> +		if (win->type == DRM_PLANE_TYPE_OVERLAY)
> +			possible_crtcs = (1 << nvps) - 1;
> +

After a long hard stare at the code in question, I think doing it this
way looks like the correct one, as as you mention in the commit message
the first "if" will change the win->type to OVERLAY in one case, but this
then will never be added.

Michael, do you agree/disagree?


Thanks
Heiko

https://lore.kernel.org/r/20230315090158.2442771-1-michael.riesch@wolfvision.net

>  		ret = vop2_plane_init(vop2, win, possible_crtcs);
>  		if (ret) {
>  			drm_err(vop2->drm, "failed to init plane %s: %d\n",
> 




