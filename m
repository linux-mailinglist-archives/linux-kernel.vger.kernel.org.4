Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345F273BDF5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 19:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjFWRlz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Jun 2023 13:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjFWRlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 13:41:53 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524481FD2;
        Fri, 23 Jun 2023 10:41:52 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-57688a146ecso819277b3.2;
        Fri, 23 Jun 2023 10:41:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687542111; x=1690134111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4GSLUfapk4UnMTKHQdOWcrvCxbU4UKiakW9bjjA2Nu8=;
        b=jpiz3pbwvhwx7a1NCxTA4Ke1lbkUQjpW4bjFwpq08FBFUQqZ2yvw3xVN+HZRbZmZef
         G9vIGxbgS+3dTmpi81FXV0kJcbFKKeRd6kpKXpXSIcDo0MqIs5j5k+DmybApPPvE53BC
         ByW3IycWLKLe3sx378TisYlAhs0FQnm7prxtEIrnrPgOm2eMCY1nFqW4kpoN7tTUy8Bh
         t/IoSPYLoU+cdg3WWoyuT+BGbdsmaR9IB6B2B5L7t+2qHkN+r0W0mS+aESOYDRLruKNr
         NX4i/A41C4NDU4cZdkAVdg4nbi72h1XlqKWnnIz0gZX9kqqv672gznUiDDSD2959M/hj
         tGlg==
X-Gm-Message-State: AC+VfDxmG8LxoJXy6TuzXC48nf8KcXWvjMrztYlOUgr9mpby1rnohXDr
        4rsyjZOLzOO0ei8zMfgn+uglY91PgnRLTg==
X-Google-Smtp-Source: ACHHUZ5FqIMgwpZNCpel78Rh4Sl12ARkvsNpwwv5hYM/XO6bnRmra5nixIMCWnq74piW8c/Butq7Tw==
X-Received: by 2002:a0d:cad1:0:b0:570:8e80:5572 with SMTP id m200-20020a0dcad1000000b005708e805572mr21367684ywd.34.1687542109817;
        Fri, 23 Jun 2023 10:41:49 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id g2-20020a816b02000000b0056d2dd6c5bcsm2576352ywc.89.2023.06.23.10.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 10:41:49 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-bfee679b7efso797030276.0;
        Fri, 23 Jun 2023 10:41:48 -0700 (PDT)
X-Received: by 2002:a25:2c9:0:b0:bff:242b:78d0 with SMTP id
 192-20020a2502c9000000b00bff242b78d0mr7370299ybc.34.1687542108258; Fri, 23
 Jun 2023 10:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687423204.git.geert+renesas@glider.be> <742b3351c1aed1f546ac2dcc1de15e0d04cc24d4.1687423204.git.geert+renesas@glider.be>
 <20230623150742.GK2112@pendragon.ideasonboard.com> <20230623151109.GL2112@pendragon.ideasonboard.com>
 <CAMuHMdWn-V5b61t7SDDEW_fUt09Y=EVPdXCmAiht0c4uD67siA@mail.gmail.com> <20230623153425.GQ2112@pendragon.ideasonboard.com>
In-Reply-To: <20230623153425.GQ2112@pendragon.ideasonboard.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 23 Jun 2023 19:41:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU-2kfL1ysgriVg_2_y85YXr0v49mHuYxLJJGyLGr7V=w@mail.gmail.com>
Message-ID: <CAMuHMdU-2kfL1ysgriVg_2_y85YXr0v49mHuYxLJJGyLGr7V=w@mail.gmail.com>
Subject: Re: [PATCH 06/39] drm: renesas: shmobile: Add support for Runtime PM
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Fri, Jun 23, 2023 at 5:34 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Fri, Jun 23, 2023 at 05:22:45PM +0200, Geert Uytterhoeven wrote:
> > On Fri, Jun 23, 2023 at 5:11 PM Laurent Pinchart wrote:
> > > On Fri, Jun 23, 2023 at 06:07:44PM +0300, Laurent Pinchart wrote:
> > > > On Thu, Jun 22, 2023 at 11:21:18AM +0200, Geert Uytterhoeven wrote:
> > > > > The SH-Mobile LCD Controller is part of a PM Domain on all relevant SoCs
> > > > > (clock domain on all, power domain on some).  Hence it may not be
> > > > > sufficient to manage the LCDC module clock explicitly (e.g. if the
> > > > > selected clock source differs from SHMOB_DRM_CLK_BUS).
> > > > >
> > > > > Fix this by using Runtime PM instead.
> > > > >
> > > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > > ---
> > > > >  drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c | 11 ++++++++++-
> > > > >  drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c  |  5 +++++
> > > > >  2 files changed, 15 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> > > > > index fbfd906844da490c..84dbf35025d7be63 100644
> > > > > --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> > > > > +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> > > > > @@ -9,6 +9,7 @@
> > > > >
> > > > >  #include <linux/backlight.h>
> > > > >  #include <linux/clk.h>
> > > > > +#include <linux/pm_runtime.h>
> > > > >
> > > > >  #include <drm/drm_crtc.h>
> > > > >  #include <drm/drm_crtc_helper.h>
> > > > > @@ -170,10 +171,16 @@ static void shmob_drm_crtc_start(struct shmob_drm_crtc *scrtc)
> > > > >     if (WARN_ON(format == NULL))
> > > > >             return;
> > > > >
> > > > > +   ret = pm_runtime_resume_and_get(sdev->dev);
> > > > > +   if (ret)
> > > > > +           return;
> > > > > +
> > > > >     /* Enable clocks before accessing the hardware. */
> > > > >     ret = shmob_drm_clk_on(sdev);
> > > >
> > > > This would be best located in the runtime PM resume handler. Same for
> > > > disabling clocks in the runtime PM suspend handler.
> > >
> > > The driver should then depend on CONFIG_PM. There's no indirect
> > > dependency through CONFIG_DRM as far as I can tell, but there's one
> > > through ARCH_SHMOBILE. This then got me puzzled, as ARCH_SHMOBILE is
> > > defined in arch/sh/Kconfig, and this driver depends on ARM. Am I missing
> > > something ?
> >
> > Vommit 4bd65789ba847f39 ("drm: shmobile: Make DRM_SHMOBILE visible on
> > Renesas SoC platforms") in drm-next:
> >
> > -       depends on DRM && ARM
> > -       depends on ARCH_SHMOBILE || COMPILE_TEST
> > +       depends on DRM
> > +       depends on ARCH_RENESAS || ARCH_SHMOBILE || COMPILE_TEST
>
> That's better indeed :-)
>
> A dependency on CONFIG_PM is still needed as ARCH_RENESAS doesn't depend
> on it.

ARCH_RMOBILE selects PM, so PM will be enabled on affected platforms.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
