Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA4F73BBBF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbjFWPeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbjFWPe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:34:28 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13F01FC0;
        Fri, 23 Jun 2023 08:34:27 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CABB2838;
        Fri, 23 Jun 2023 17:33:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1687534430;
        bh=Lkq4FXI4Zx7ehHOm06R2q1AjaZcAkQ4pUJeFbYnNjgw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZhOVG6gdVVJMNBEAjOH08MEo2syxQ27VbmXUeiXe7eNwUI0vkepXtGO3YKi//qT3n
         5a0PRggHwJ8Tx39nnOFMEqcKRJMaBMtTmFpU8YGQxz2x7Qv7VKOnhfbpoN3lbfueoi
         mwSLnm6e3Hj/uCTRuQkLDI4iybYLmzd2h9IPXGtE=
Date:   Fri, 23 Jun 2023 18:34:25 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/39] drm: renesas: shmobile: Add support for Runtime PM
Message-ID: <20230623153425.GQ2112@pendragon.ideasonboard.com>
References: <cover.1687423204.git.geert+renesas@glider.be>
 <742b3351c1aed1f546ac2dcc1de15e0d04cc24d4.1687423204.git.geert+renesas@glider.be>
 <20230623150742.GK2112@pendragon.ideasonboard.com>
 <20230623151109.GL2112@pendragon.ideasonboard.com>
 <CAMuHMdWn-V5b61t7SDDEW_fUt09Y=EVPdXCmAiht0c4uD67siA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdWn-V5b61t7SDDEW_fUt09Y=EVPdXCmAiht0c4uD67siA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 05:22:45PM +0200, Geert Uytterhoeven wrote:
> On Fri, Jun 23, 2023 at 5:11 PM Laurent Pinchart wrote:
> > On Fri, Jun 23, 2023 at 06:07:44PM +0300, Laurent Pinchart wrote:
> > > On Thu, Jun 22, 2023 at 11:21:18AM +0200, Geert Uytterhoeven wrote:
> > > > The SH-Mobile LCD Controller is part of a PM Domain on all relevant SoCs
> > > > (clock domain on all, power domain on some).  Hence it may not be
> > > > sufficient to manage the LCDC module clock explicitly (e.g. if the
> > > > selected clock source differs from SHMOB_DRM_CLK_BUS).
> > > >
> > > > Fix this by using Runtime PM instead.
> > > >
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > ---
> > > >  drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c | 11 ++++++++++-
> > > >  drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c  |  5 +++++
> > > >  2 files changed, 15 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> > > > index fbfd906844da490c..84dbf35025d7be63 100644
> > > > --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> > > > +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> > > > @@ -9,6 +9,7 @@
> > > >
> > > >  #include <linux/backlight.h>
> > > >  #include <linux/clk.h>
> > > > +#include <linux/pm_runtime.h>
> > > >
> > > >  #include <drm/drm_crtc.h>
> > > >  #include <drm/drm_crtc_helper.h>
> > > > @@ -170,10 +171,16 @@ static void shmob_drm_crtc_start(struct shmob_drm_crtc *scrtc)
> > > >     if (WARN_ON(format == NULL))
> > > >             return;
> > > >
> > > > +   ret = pm_runtime_resume_and_get(sdev->dev);
> > > > +   if (ret)
> > > > +           return;
> > > > +
> > > >     /* Enable clocks before accessing the hardware. */
> > > >     ret = shmob_drm_clk_on(sdev);
> > >
> > > This would be best located in the runtime PM resume handler. Same for
> > > disabling clocks in the runtime PM suspend handler.
> >
> > The driver should then depend on CONFIG_PM. There's no indirect
> > dependency through CONFIG_DRM as far as I can tell, but there's one
> > through ARCH_SHMOBILE. This then got me puzzled, as ARCH_SHMOBILE is
> > defined in arch/sh/Kconfig, and this driver depends on ARM. Am I missing
> > something ?
> 
> Vommit 4bd65789ba847f39 ("drm: shmobile: Make DRM_SHMOBILE visible on
> Renesas SoC platforms") in drm-next:
> 
> -       depends on DRM && ARM
> -       depends on ARCH_SHMOBILE || COMPILE_TEST
> +       depends on DRM
> +       depends on ARCH_RENESAS || ARCH_SHMOBILE || COMPILE_TEST

That's better indeed :-)

A dependency on CONFIG_PM is still needed as ARCH_RENESAS doesn't depend
on it.

-- 
Regards,

Laurent Pinchart
