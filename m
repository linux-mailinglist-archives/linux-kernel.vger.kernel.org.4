Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650DB69C01E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 13:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjBSMAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 07:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBSMAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 07:00:15 -0500
Received: from honk.sigxcpu.org (honk.sigxcpu.org [24.134.29.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458EA10A97
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 04:00:14 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 293C6FB03;
        Sun, 19 Feb 2023 13:00:10 +0100 (CET)
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KkTfTTsqszTv; Sun, 19 Feb 2023 13:00:09 +0100 (CET)
Date:   Sun, 19 Feb 2023 13:00:08 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <guido.gunther@puri.sm>
To:     Frank Oltmanns <frank@oltmanns.dev>
Cc:     Purism Kernel Team <kernel@puri.sm>,
        Ondrej Jirman <megous@megous.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] drm/panel: st7703: Fix vertical refresh rate of
 XBD599
Message-ID: <Y/IPSCeJVyS/sSQT@qwark.sigxcpu.org>
References: <20230219114553.288057-1-frank@oltmanns.dev>
 <20230219114553.288057-2-frank@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230219114553.288057-2-frank@oltmanns.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_FAIL,
        SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Sun, Feb 19, 2023 at 12:45:53PM +0100, Frank Oltmanns wrote:
> Fix the XBD599 panel's slight visual stutter by correcting the pixel
> clock speed so that the panel's 60Hz vertical refresh rate is met.
> 
> Set the clock speed using the underlying formula instead of a magic
> number. To have a consistent procedure for both panels, set the JH057N
> panel's clock also as a formula.
> ---
>  drivers/gpu/drm/panel/panel-sitronix-st7703.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
> index 6747ca237ced..cd7d631f7573 100644
> --- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
> +++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
> @@ -139,7 +139,7 @@ static const struct drm_display_mode jh057n00900_mode = {
>  	.vsync_start = 1440 + 20,
>  	.vsync_end   = 1440 + 20 + 4,
>  	.vtotal	     = 1440 + 20 + 4 + 12,
> -	.clock	     = 75276,
> +	.clock	     = (720 + 90 + 20 + 20) * (1440 + 20 + 4 + 12) * 60 / 1000,
>  	.flags	     = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
>  	.width_mm    = 65,
>  	.height_mm   = 130,
> @@ -324,7 +324,7 @@ static const struct drm_display_mode xbd599_mode = {
>  	.vsync_start = 1440 + 18,
>  	.vsync_end   = 1440 + 18 + 10,
>  	.vtotal	     = 1440 + 18 + 10 + 17,
> -	.clock	     = 69000,
> +	.clock	     = (720 + 40 + 40 + 40) * (1440 + 18 + 10 + 17) * 60 / 1000,
>  	.flags	     = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
>  	.width_mm    = 68,
>  	.height_mm   = 136,

Reviewed-by: Guido Günther <agx@sigxcpu.org>

(I've seen your other patches but it will be some days until I can test
the jh057n00900 panel).

Cheers,
 -- Guido

> -- 
> 2.39.1
> 
