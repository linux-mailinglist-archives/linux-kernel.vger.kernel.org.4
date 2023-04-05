Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A0D6D72D9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 06:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbjDEED0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 00:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjDEEDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 00:03:24 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818AE2D50;
        Tue,  4 Apr 2023 21:03:19 -0700 (PDT)
Received: from pendragon.ideasonboard.com (fp76f193f3.tkyc206.ap.nuro.jp [118.241.147.243])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3B3FE905;
        Wed,  5 Apr 2023 06:03:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1680667398;
        bh=SLHOckHvMGRAwVUJoKjXIrUROsWklviE2bzEckKRICk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cmHUhuFhyc5s/hvJQxsLSLJynbeAksWvmhSNyN77i8r5moPt9vGyxsw2RR/miPFjN
         AKsXaMyIrqvlqZHEpSjOZU1zDm5YSlXGL7CZn1c2RsqybuylgbehxavaXgKGdLc0NF
         fIEEWasq34FDP7igQYku4AApreajzH/z3jJUW5rk=
Date:   Wed, 5 Apr 2023 07:03:25 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] drm: shmobile: Fixes and enhancements
Message-ID: <20230405040325.GL9915@pendragon.ideasonboard.com>
References: <cover.1680273039.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1680273039.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Fri, Mar 31, 2023 at 04:48:06PM +0200, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> Currently, there are two drivers for the LCD controller on Renesas
> SuperH-based and ARM-based SH-Mobile and R-Mobile SoCs:
>   1. sh_mobile_lcdcfb, using the fbdev framework,
>   2. shmob_drm, using the DRM framework.
> However, only the former driver can be used, as all platform support
> integrates the former.  None of these drivers support DT-based systems.
> 
> This patch series is a first step to enable the SH-Mobile DRM driver for
> Renesas ARM-based SH-Mobile and R-Mobile SoCs.  The next step planned is
> to add DT support.
> 
> This has been tested on the R-Mobile A1-based Atmark Techno
> Armadillo-800-EVA development board, using a temporary
> platform-enablement patch[1].
> 
> Thanks for your comments!

Thanks for reviving this driver. I'm looking forward to DT and KMS
atomic support :-)

Will you get these patches merged through drm-misc ?

> [1] https://lore.kernel.org/r/c03d4edbd650836bf6a96504df82338ec6d800ff.1680272980.git.geert+renesas@glider.be
> 
> Geert Uytterhoeven (5):
>   drm: shmobile: Use %p4cc to print fourcc codes
>   drm: shmobile: Add support for DRM_FORMAT_XRGB8888
>   drm: shmobile: Switch to drm_crtc_init_with_planes()
>   drm: shmobile: Add missing call to drm_fbdev_generic_setup()
>   drm: shmobile: Make DRM_SHMOBILE visible on Renesas SoC platforms
> 
>  drivers/gpu/drm/shmobile/Kconfig           |  2 +-
>  drivers/gpu/drm/shmobile/shmob_drm_crtc.c  | 35 +++++++++++++++++++---
>  drivers/gpu/drm/shmobile/shmob_drm_drv.c   |  3 ++
>  drivers/gpu/drm/shmobile/shmob_drm_kms.c   |  9 ++++--
>  drivers/gpu/drm/shmobile/shmob_drm_plane.c |  5 ++++
>  5 files changed, 47 insertions(+), 7 deletions(-)

-- 
Regards,

Laurent Pinchart
