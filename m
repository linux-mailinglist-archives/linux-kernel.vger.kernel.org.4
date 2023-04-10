Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1736DC521
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 11:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjDJJgQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Apr 2023 05:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjDJJgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 05:36:13 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A0730DC;
        Mon, 10 Apr 2023 02:36:11 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-54c0dd7e2f3so203178007b3.8;
        Mon, 10 Apr 2023 02:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681119370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FHSMM1KvEHdmSEiK3Kz5ib8QCRDoCzAK4drVjX0gWY8=;
        b=xFEOmO5biKX4K8VmCcWIReKJ0kQ3WE+kCWbXvrHNZlmTFhavAmRd+tp3bHod2dkEmM
         fuuQfKBvwYqS8t1nKVMsZsUV5FJN2kn16VIql7vzxI2B+wb++j7peAmkpSuuXcUqpoZB
         s3G1v2pHIg32RjxAzsZFLSC2sPD5G8i+zaKvm6HTTuijgrNuavAVwfmM6XGC1vuTQpsi
         OrSqmPp+P2x5wxIjLcx0oPtr8S9MesnXZu1nTBQY/D69xQJQNXNRc9MsKUZKdPeZRnuI
         VOo29M3cXCaNjGYyEkN17YDMOv3567S/MnM4DlTV1yAfsYweLNzyMYoVx7+8JHIhvKmn
         hqAQ==
X-Gm-Message-State: AAQBX9fkpvEY3CpF71HDE6b8szYUSea02MKkK88BFUh2YknuIgD18ZVz
        MixcUurIqElaqFQobdflF+3gYGowTNbvRA==
X-Google-Smtp-Source: AKy350Zh7MMYFhMtOGiU37qbcNnQ3Agy5/M0QsmCwExkxXKOdSoeGFIwtL3jd9aDhVzqUU8od9f9Yg==
X-Received: by 2002:a0d:e614:0:b0:546:209d:ee81 with SMTP id p20-20020a0de614000000b00546209dee81mr7960754ywe.2.1681119370581;
        Mon, 10 Apr 2023 02:36:10 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id p20-20020a0de614000000b00545a08184f3sm2697184ywe.131.2023.04.10.02.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 02:36:10 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 72so4099048ybe.6;
        Mon, 10 Apr 2023 02:36:10 -0700 (PDT)
X-Received: by 2002:a25:df0b:0:b0:b75:9519:dbcd with SMTP id
 w11-20020a25df0b000000b00b759519dbcdmr6808406ybg.12.1681119369989; Mon, 10
 Apr 2023 02:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1680273039.git.geert+renesas@glider.be> <df4099d79c985c73bdc890eb0e026494b7fa5c96.1680273039.git.geert+renesas@glider.be>
 <20230405035952.GI9915@pendragon.ideasonboard.com>
In-Reply-To: <20230405035952.GI9915@pendragon.ideasonboard.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Apr 2023 11:35:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUMEVYRr9oYBB=50WJtM4St1UfVkGMw09dchjgoUC2Q6A@mail.gmail.com>
Message-ID: <CAMuHMdUMEVYRr9oYBB=50WJtM4St1UfVkGMw09dchjgoUC2Q6A@mail.gmail.com>
Subject: Re: [PATCH 3/5] drm: shmobile: Switch to drm_crtc_init_with_planes()
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Thanks for your comments!

On Wed, Apr 5, 2023 at 5:59 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Fri, Mar 31, 2023 at 04:48:09PM +0200, Geert Uytterhoeven wrote:
> > The SH-Mobile DRM driver uses the legacy drm_crtc_init(), which
> > advertizes only the formats in safe_modeset_formats[] (XR24 and AR24) as
> > being supported.
> >
> > Switch to drm_crtc_init_with_planes(), and advertize all supported
> > (A)RGB modes, so we can use RGB565 as the default mode for the console.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > --- a/drivers/gpu/drm/shmobile/shmob_drm_crtc.c
> > +++ b/drivers/gpu/drm/shmobile/shmob_drm_crtc.c
> > @@ -18,6 +18,7 @@
> >  #include <drm/drm_gem_dma_helper.h>
> >  #include <drm/drm_modeset_helper.h>
> >  #include <drm/drm_modeset_helper_vtables.h>
> > +#include <drm/drm_plane_helper.h>
> >  #include <drm/drm_probe_helper.h>
> >  #include <drm/drm_simple_kms_helper.h>
> >  #include <drm/drm_vblank.h>
> > @@ -478,16 +479,41 @@ static const struct drm_crtc_funcs crtc_funcs = {
> >       .disable_vblank = shmob_drm_disable_vblank,
> >  };
> >
> > +static const uint32_t modeset_formats[] = {
> > +     DRM_FORMAT_RGB565,
> > +     DRM_FORMAT_RGB888,
> > +     DRM_FORMAT_ARGB8888,
> > +     DRM_FORMAT_XRGB8888,
> > +};
> > +
> > +static const struct drm_plane_funcs primary_plane_funcs = {
> > +     DRM_PLANE_NON_ATOMIC_FUNCS,
> > +};
> > +
> >  int shmob_drm_crtc_create(struct shmob_drm_device *sdev)
> >  {
> >       struct drm_crtc *crtc = &sdev->crtc.crtc;
> > +     struct drm_plane *primary;
> >       int ret;
> >
> >       sdev->crtc.dpms = DRM_MODE_DPMS_OFF;
> >
> > -     ret = drm_crtc_init(sdev->ddev, crtc, &crtc_funcs);
> > -     if (ret < 0)
> > +     primary = __drm_universal_plane_alloc(sdev->ddev, sizeof(*primary), 0,
> > +                                           0, &primary_plane_funcs,
> > +                                           modeset_formats,
> > +                                           ARRAY_SIZE(modeset_formats),
> > +                                           NULL, DRM_PLANE_TYPE_PRIMARY,
> > +                                           NULL);
> > +     if (IS_ERR(primary))
> > +             return PTR_ERR(primary);
>
> This seems like a bit of a hack to me. Why don't you use the planes

I'm following what Thomas did in the nouveau driver....

> created by shmob_drm_plane_create() instead of allocating a new one ?

Is that possible? shmob_drm_plane_create() creates overlay planes,
while this is for the primary plane.

>
> > +
> > +     ret = drm_crtc_init_with_planes(sdev->ddev, crtc, primary, NULL,
> > +                                     &crtc_funcs, NULL);
> > +     if (ret < 0) {
> > +             drm_plane_cleanup(primary);
> > +             kfree(primary);
> >               return ret;
> > +     }
> >
> >       drm_crtc_helper_add(crtc, &crtc_helper_funcs);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
