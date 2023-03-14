Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86516B9AB0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 17:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjCNQIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 12:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCNQI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:08:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E602B296;
        Tue, 14 Mar 2023 09:08:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0AD60B81A31;
        Tue, 14 Mar 2023 16:08:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2D7C4339B;
        Tue, 14 Mar 2023 16:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678810104;
        bh=wA9DCnSggZ7AMT9yojgtSsTiqRDWjhLpUyEUud8IvmE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dAbWryZpUw6TZWSzeXV/L6G7XErOuD5W4Xe6WLiyuLNeL5oEXrwhuvOWjDanp/69q
         hgoQeZ5BmogcMEB440DbybHqh9Egk7TDdok25Z9tVdHbNLFe3es76W8aPjqv6FZ0wq
         kUmqHRPOsl67nHr1DQqXGxnXQcqheiprkRAhmfm6xlwY6nN/6z4kGsPjPhaACjCjHk
         cbEtMPzPOssPONhgcuAWztD9X5JkNuK+AN/wX3wPmtVss/ayeNF1dBIqjd8YBZoe+k
         BdIy+OoFmSKUHA0dV4YWkvvGdkLgebsG+aJ8geyRfS4suXrOTRHAlII9BwhvPH6i+o
         sBBgS3bHSLV9g==
Date:   Tue, 14 Mar 2023 09:08:21 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sascha Hauer <sha@pengutronix.de>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>, llvm@lists.linux.dev
Subject: Re: [PATCH v3 1/6] drm/rockchip: vop2: initialize possible_crtcs
 properly
Message-ID: <20230314160821.GA13416@dev-arch.thelio-3990X>
References: <20230124054706.3921383-1-michael.riesch@wolfvision.net>
 <20230124054706.3921383-2-michael.riesch@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124054706.3921383-2-michael.riesch@wolfvision.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Tue, Jan 24, 2023 at 06:47:01AM +0100, Michael Riesch wrote:
> The variable possible_crtcs is only initialized for primary and
> overlay planes. Since the VOP2 driver only supports these plane
> types at the moment, the current code is safe. However, in order
> to provide a future-proof solution, fix the initialization of
> the variable.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
> v3:
>  - no changes
> v2:
>  - new patch
> 
>  drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> index 8cecf81a5ae0..374ef821b453 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> @@ -2322,10 +2322,11 @@ static int vop2_create_crtc(struct vop2 *vop2)
>  				/* change the unused primary window to overlay window */
>  				win->type = DRM_PLANE_TYPE_OVERLAY;
>  			}
> -		}
> -
> -		if (win->type == DRM_PLANE_TYPE_OVERLAY)
> +		} else if (win->type == DRM_PLANE_TYPE_OVERLAY) {
>  			possible_crtcs = (1 << nvps) - 1;
> +		} else {
> +			possible_crtcs = 0;
> +		}
>  
>  		ret = vop2_plane_init(vop2, win, possible_crtcs);
>  		if (ret) {
> -- 
> 2.30.2
> 

This patch is now in -next as commit 368419a2d429 ("drm/rockchip: vop2:
initialize possible_crtcs properly") and it actually appears to
introduce a path where possible_crtcs could be used uninitialized.

  drivers/gpu/drm/rockchip/rockchip_drm_vop2.c:2316:8: error: variable 'possible_crtcs' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
                          if (vp) {
                              ^~
  drivers/gpu/drm/rockchip/rockchip_drm_vop2.c:2330:36: note: uninitialized use occurs here
                  ret = vop2_plane_init(vop2, win, possible_crtcs);
                                                   ^~~~~~~~~~~~~~
  drivers/gpu/drm/rockchip/rockchip_drm_vop2.c:2316:4: note: remove the 'if' if its condition is always true
                          if (vp) {
                          ^~~~~~~~
  drivers/gpu/drm/rockchip/rockchip_drm_vop2.c:2298:21: note: initialize the variable 'possible_crtcs' to silence this warning
                  u32 possible_crtcs;
                                    ^
                                     = 0
  1 error generated.

Prior to this change, if that else path was hit, clang recognized based on
the assignment that the next if statement would always be true. Now, if
the else path is taken, the possible_crtcs assignment will be missed. Is
that intentional?

Cheers,
Nathan
