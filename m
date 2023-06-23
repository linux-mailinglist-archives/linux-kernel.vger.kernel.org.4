Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6137073BE15
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 19:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjFWRvX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Jun 2023 13:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjFWRvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 13:51:21 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933862133;
        Fri, 23 Jun 2023 10:51:20 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-bcd0226607bso3158590276.1;
        Fri, 23 Jun 2023 10:51:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687542679; x=1690134679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7quSJ3+jB/PSLZA5wSTCCL319u6birtQAJa6S9m7Do=;
        b=AZvYyygMpXPYN8MQblYyMD6hn8N0vwQT+ZA9l4bz+AoBgh2u5d09NWJlJi3IWH6sjg
         sevnA5mo/+yMu5kWgEc3jAspUJspPsdffmukbXy02ml4fMa0nEgh0U7sgjzb57rYjrNU
         rNj/gii0dsXyouKxcYX2Qo6NVeckuWntD3NDAH2v8oGfAAn/vh03LXQ2O536qBDoswdL
         62aYvLPltBgxFqbRvQ8JXczI5YDwXG1/JFmgH+Ven9OV/+iHgHg18PtSdary8CGMWSqp
         DKLSR2YELkWUcb3qcx4B4p4+xSpn4/fPoN9aw7z0TH3tD0hyPa5df0g1Pqu+c95ux1Mp
         UzJA==
X-Gm-Message-State: AC+VfDz+yoszWnNjEmWnUK4CCwuy59B5HFhzVhMCLp5mlyayDEdK1e5e
        noCCiefROnj/AvgIwJ4qJN6Eu5Ke71rjtg==
X-Google-Smtp-Source: ACHHUZ5HW2Z3QjzIGPk+Rs+UdW8cdfuV0RbA/myaA0MEj0UoundeyWzue+uD+csyRlCj5+vUVjYkKQ==
X-Received: by 2002:a25:dc91:0:b0:bce:bed4:29f6 with SMTP id y139-20020a25dc91000000b00bcebed429f6mr21286861ybe.17.1687542679561;
        Fri, 23 Jun 2023 10:51:19 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id q4-20020a25b004000000b00c00214d7944sm1384437ybf.63.2023.06.23.10.51.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 10:51:19 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-bc43a73ab22so1499489276.0;
        Fri, 23 Jun 2023 10:51:19 -0700 (PDT)
X-Received: by 2002:a25:32c1:0:b0:bc6:263a:2fe with SMTP id
 y184-20020a2532c1000000b00bc6263a02femr22491980yby.29.1687542678947; Fri, 23
 Jun 2023 10:51:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687423204.git.geert+renesas@glider.be> <0032f38b474a8ff63a7cdfdbc8b73766c3561729.1687423204.git.geert+renesas@glider.be>
 <20230623163950.GA2112@pendragon.ideasonboard.com>
In-Reply-To: <20230623163950.GA2112@pendragon.ideasonboard.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 23 Jun 2023 19:51:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU_gvs1+KtN14DxAMY+Qa2YTo8KL3L4VnL3yG2zYiH6JQ@mail.gmail.com>
Message-ID: <CAMuHMdU_gvs1+KtN14DxAMY+Qa2YTo8KL3L4VnL3yG2zYiH6JQ@mail.gmail.com>
Subject: Re: [PATCH 23/39] drm: renesas: shmobile: Move interface handling to
 connector setup
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

On Fri, Jun 23, 2023 at 6:39 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Thu, Jun 22, 2023 at 11:21:35AM +0200, Geert Uytterhoeven wrote:
> > Move legacy interface handling to the connector setup code.
> > Set up bus_flags and bus_formats in display_info according to the
> > bus format and panel information from platform data, to make it more
> > similar with DT-based connector/bridge/panel setup.
> > This will allows us to use the same LCD interface setup code for both
>
> s/allows/allow/
>
> > legacy and DT-based systems.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > --- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> > +++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
> > @@ -8,6 +8,7 @@
> >   */
> >
> >  #include <linux/clk.h>
> > +#include <linux/media-bus-format.h>
> >  #include <linux/pm_runtime.h>
> >
> >  #include <drm/drm_crtc.h>
> > @@ -66,15 +67,65 @@ static void shmob_drm_crtc_setup_geometry(struct shmob_drm_crtc *scrtc)
> >  {
> >       struct drm_crtc *crtc = &scrtc->crtc;
> >       struct shmob_drm_device *sdev = to_shmob_device(crtc->dev);
> > -     enum display_flags dpy_flags = sdev->connector.mode->flags;
> > +     const struct drm_display_info *info = &sdev->connector->display_info;
> >       const struct drm_display_mode *mode = &crtc->mode;
> >       u32 value;
> >
> > -     value = sdev->ldmt1r
> > -           | ((mode->flags & DRM_MODE_FLAG_PVSYNC) ? 0 : LDMT1R_VPOL)
> > -           | ((mode->flags & DRM_MODE_FLAG_PHSYNC) ? 0 : LDMT1R_HPOL)
> > -           | ((dpy_flags & DISPLAY_FLAGS_PIXDATA_POSEDGE) ? LDMT1R_DWPOL : 0)
> > -           | ((dpy_flags & DISPLAY_FLAGS_DE_LOW) ? LDMT1R_DIPOL : 0);
> > +     if (!info->num_bus_formats || !info->bus_formats) {
> > +             dev_warn(sdev->dev, "No bus format reported, using RGB888\n");
> > +             value = LDMT1R_MIFTYP_RGB24;
> > +     } else {
> > +             switch (info->bus_formats[0]) {
> > +             case MEDIA_BUS_FMT_RGB888_3X8:
> > +                     value = LDMT1R_MIFTYP_RGB8;
> > +                     break;
> > +
> > +             case MEDIA_BUS_FMT_RGB666_2X9_BE:
> > +                     value = LDMT1R_MIFTYP_RGB9;
> > +                     break;
> > +
> > +             case MEDIA_BUS_FMT_RGB888_2X12_BE:
> > +                     value = LDMT1R_MIFTYP_RGB12A;
> > +                     break;
> > +
> > +             case MEDIA_BUS_FMT_RGB444_1X12:
> > +                     value = LDMT1R_MIFTYP_RGB12B;
> > +                     break;
> > +
> > +             case MEDIA_BUS_FMT_RGB565_1X16:
> > +                     value = LDMT1R_MIFTYP_RGB16;
> > +                     break;
> > +
> > +             case MEDIA_BUS_FMT_RGB666_1X18:
> > +                     value = LDMT1R_MIFTYP_RGB18;
> > +                     break;
> > +
> > +             case MEDIA_BUS_FMT_RGB888_1X24:
> > +                     value = LDMT1R_MIFTYP_RGB24;
> > +                     break;
> > +
> > +             case MEDIA_BUS_FMT_UYVY8_1X16:
> > +                     value = LDMT1R_MIFTYP_YCBCR;
> > +                     break;
> > +
> > +             default:
> > +                     dev_warn(sdev->dev,
> > +                              "unsupported bus format 0x%x, using RGB888\n",
> > +                              info->bus_formats[0]);
> > +                     value = LDMT1R_MIFTYP_RGB24;
> > +                     break;
> > +             }
>
> It's a bit annoying to lose the ability to validate the bus format at
> probe time. Can it be kept. I'm also OK with restoring it later in the
> series if it gets in the way of the conversion, in which case a mention
> in the commit message would be nice.

I guess I can keep it, somewhere.
Probably it should be validated for the DT case later, too.
BTW, drivers/gpu/drm/renesas/rcar-du/rcar_lvds.s doesn't check this
either, so I copied the bad example from the expert ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
