Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C4E73BB8B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbjFWPXG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Jun 2023 11:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjFWPXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:23:03 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7678AC2;
        Fri, 23 Jun 2023 08:22:57 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-570282233ceso6522497b3.1;
        Fri, 23 Jun 2023 08:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687533776; x=1690125776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lDiyFgY/P4UigW7QW8bCP4HR3ID78EGLq0qXlWW8WmE=;
        b=YS31wU9Q3tuw0LIK1A3OHIMTBb473Z6VpKc4uDsE71tG8ZqmTrk/lMu0nP79v1BZEp
         xYQyN0Em5HkGL1eCJlnDu2l6F6StBMUUtdo9ZwHHLXxesjaBSHXYMa/J6vcfh8ajMG7h
         NNKGKWrHvB6zxi1fcuQvEzrbUv0ytDBcBUwjM77ocpyT6hMK0zmOopfA03M5lE7KfbbL
         t2ZDGINt13ryBjtbq6zxyadB5RUULdDIAP1oDGIlFRo+gq/QBI4SOGrkcIOQPNFO2cXJ
         cjbhHOuKH3LflMJCxDqt8LLKYtJBYyHHYM14gC5V9xTjI8vdF1GhBNi0vYgI1OAuwarY
         cQoQ==
X-Gm-Message-State: AC+VfDxXUuC4WfheZSqnq3m4qVCuS0UVdiVMqw4x4S36eQ1LzBpU38tw
        wcmd8Bcm9EHR9F6TcaFXejCIodF7GmN5aw==
X-Google-Smtp-Source: ACHHUZ4UElqC7Vy3EKUT/W6Tkh5PCjCEwUEfd52nMxSeicHrrGDfgcElSyvHbrZxFxrRHiPZmNnP8Q==
X-Received: by 2002:a81:4fd7:0:b0:573:9e0a:b8bf with SMTP id d206-20020a814fd7000000b005739e0ab8bfmr8792657ywb.9.1687533776427;
        Fri, 23 Jun 2023 08:22:56 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id d12-20020a81ab4c000000b00545a08184cesm2479333ywk.94.2023.06.23.08.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 08:22:56 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5702415be17so6472877b3.2;
        Fri, 23 Jun 2023 08:22:56 -0700 (PDT)
X-Received: by 2002:a25:f802:0:b0:b9e:712f:4a17 with SMTP id
 u2-20020a25f802000000b00b9e712f4a17mr15639096ybd.6.1687533776073; Fri, 23 Jun
 2023 08:22:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687423204.git.geert+renesas@glider.be> <742b3351c1aed1f546ac2dcc1de15e0d04cc24d4.1687423204.git.geert+renesas@glider.be>
 <20230623150742.GK2112@pendragon.ideasonboard.com> <20230623151109.GL2112@pendragon.ideasonboard.com>
In-Reply-To: <20230623151109.GL2112@pendragon.ideasonboard.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 23 Jun 2023 17:22:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWn-V5b61t7SDDEW_fUt09Y=EVPdXCmAiht0c4uD67siA@mail.gmail.com>
Message-ID: <CAMuHMdWn-V5b61t7SDDEW_fUt09Y=EVPdXCmAiht0c4uD67siA@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Fri, Jun 23, 2023 at 5:11 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Fri, Jun 23, 2023 at 06:07:44PM +0300, Laurent Pinchart wrote:
> > On Thu, Jun 22, 2023 at 11:21:18AM +0200, Geert Uytterhoeven wrote:
> > > The SH-Mobile LCD Controller is part of a PM Domain on all relevant SoCs
> > > (clock domain on all, power domain on some).  Hence it may not be
> > > sufficient to manage the LCDC module clock explicitly (e.g. if the
> > > selected clock source differs from SHMOB_DRM_CLK_BUS).
> > >
> > > Fix this by using Runtime PM instead.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > ---
> > >  drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c | 11 ++++++++++-
> > >  drivers/gpu/drm/renesas/shmobile/shmob_drm_drv.c  |  5 +++++
> > >  2 files changed, 15 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> > > index fbfd906844da490c..84dbf35025d7be63 100644
> > > --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> > > +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> > > @@ -9,6 +9,7 @@
> > >
> > >  #include <linux/backlight.h>
> > >  #include <linux/clk.h>
> > > +#include <linux/pm_runtime.h>
> > >
> > >  #include <drm/drm_crtc.h>
> > >  #include <drm/drm_crtc_helper.h>
> > > @@ -170,10 +171,16 @@ static void shmob_drm_crtc_start(struct shmob_drm_crtc *scrtc)
> > >     if (WARN_ON(format == NULL))
> > >             return;
> > >
> > > +   ret = pm_runtime_resume_and_get(sdev->dev);
> > > +   if (ret)
> > > +           return;
> > > +
> > >     /* Enable clocks before accessing the hardware. */
> > >     ret = shmob_drm_clk_on(sdev);
> >
> > This would be best located in the runtime PM resume handler. Same for
> > disabling clocks in the runtime PM suspend handler.
>
> The driver should then depend on CONFIG_PM. There's no indirect
> dependency through CONFIG_DRM as far as I can tell, but there's one
> through ARCH_SHMOBILE. This then got me puzzled, as ARCH_SHMOBILE is
> defined in arch/sh/Kconfig, and this driver depends on ARM. Am I missing
> something ?

Vommit 4bd65789ba847f39 ("drm: shmobile: Make DRM_SHMOBILE visible on
Renesas SoC platforms") in drm-next:

-       depends on DRM && ARM
-       depends on ARCH_SHMOBILE || COMPILE_TEST
+       depends on DRM
+       depends on ARCH_RENESAS || ARCH_SHMOBILE || COMPILE_TEST

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
