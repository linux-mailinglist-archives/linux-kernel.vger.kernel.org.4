Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D5E5B7D5F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 01:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiIMXTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 19:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiIMXS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 19:18:58 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A829266110;
        Tue, 13 Sep 2022 16:18:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BDFB9CE1347;
        Tue, 13 Sep 2022 23:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4BDC433C1;
        Tue, 13 Sep 2022 23:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663111133;
        bh=/LcuPi8V7Ej7uvoNaew7dsD1eUxauxC0rf5elEG4pcY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=isGmkR8X+bqZCIZQIZToszbRwjKwXAksaJyyViRDQ/ma3/H6VFLPPnBz4H+I+C6Z1
         6k969mCZrmzJ/PvuMY9bfIh5gMSpa4U5DU+e9lUOE5415GUoFjRUDZLy9B6o1Sfnhm
         3EtgPvgMiLXEI9iAzPZ6EBkKHoMNjadHoRDyPZOk3tWbqMPuFIqDyGl9hIa45hm89L
         F/BlojPf6ZnPMR+WiolQWurOnGA0nbqbWlbZrE0JZ1mokMU4oSYFD6+IMLVQOPtkRJ
         CxhG7NRoOAS+mXX9yUN/d+qGKH5PXJyjUYxkpe2rJdJWPuBGrPaadHsfomM2bY93nQ
         TCPHDb5axgLdA==
Date:   Tue, 13 Sep 2022 16:18:51 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     Dan Carpenter <error27@gmail.com>, llvm@lists.linux.dev,
        Inki Dae <inki.dae@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/exynos: Fix return type for mixer_mode_valid and
 hdmi_mode_valid
Message-ID: <YyEP28J5O2Wlh4lS@dev-arch.thelio-3990X>
References: <20220913205449.154966-1-nhuck@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913205449.154966-1-nhuck@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 01:54:49PM -0700, Nathan Huckleberry wrote:
> The field mode_valid in exynos_drm_crtc_ops is expected to be of type
> enum drm_mode_status (*mode_valid)(struct exynos_drm_crtc *crtc,
>                                    const struct drm_display_mode *mode);
> 
> Likewise for mode_valid in drm_connector_helper_funcs.
> 
> The mismatched return type breaks forward edge kCFI since the underlying
> function definition does not match the function hook definition.
> 
> The return type of mixer_mode_valid and hdmi_mode_valid should be
> changed from int to enum drm_mode_status.
> 
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1703
> Cc: llvm@lists.linux.dev
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  drivers/gpu/drm/exynos/exynos_hdmi.c  | 4 ++--
>  drivers/gpu/drm/exynos/exynos_mixer.c | 5 +++--
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
> index 10b0036f8a2e..8453359c92e8 100644
> --- a/drivers/gpu/drm/exynos/exynos_hdmi.c
> +++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
> @@ -922,8 +922,8 @@ static int hdmi_find_phy_conf(struct hdmi_context *hdata, u32 pixel_clock)
>  	return -EINVAL;
>  }
>  
> -static int hdmi_mode_valid(struct drm_connector *connector,
> -			struct drm_display_mode *mode)
> +static enum drm_mode_status hdmi_mode_valid(struct drm_connector *connector,
> +					    struct drm_display_mode *mode)
>  {
>  	struct hdmi_context *hdata = connector_to_hdmi(connector);
>  	int ret;
> diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
> index 65260a658684..82f676e6d21b 100644
> --- a/drivers/gpu/drm/exynos/exynos_mixer.c
> +++ b/drivers/gpu/drm/exynos/exynos_mixer.c
> @@ -1045,8 +1045,9 @@ static void mixer_atomic_disable(struct exynos_drm_crtc *crtc)
>  	clear_bit(MXR_BIT_POWERED, &ctx->flags);
>  }
>  
> -static int mixer_mode_valid(struct exynos_drm_crtc *crtc,
> -		const struct drm_display_mode *mode)
> +static enum drm_mode_status
> +mixer_mode_valid(struct exynos_drm_crtc *crtc,
> +		 const struct drm_display_mode *mode)
>  {
>  	struct mixer_context *ctx = crtc->ctx;
>  	u32 w = mode->hdisplay, h = mode->vdisplay;
> -- 
> 2.37.2.789.g6183377224-goog
> 
