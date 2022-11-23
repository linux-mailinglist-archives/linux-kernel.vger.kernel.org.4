Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5CE63667F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbiKWRFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 12:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237966AbiKWRF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:05:28 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0B1A65BF;
        Wed, 23 Nov 2022 09:05:27 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id h16so3185112qtu.2;
        Wed, 23 Nov 2022 09:05:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZaUOlJ3sjB7IWYce0/bjUUBOp0Vg9o09HXSbd2ZFOCw=;
        b=eu7aV3XaUpSZIm1uqkcNLeGbLY/2lr2PhOCuz/ATxrNDrZivdNGWqy1X2H8NtQwund
         eaImVPW2Ubfj11a6exKlFxBRIfYq6sIm1EfqKf+9BA0Mck3UJyNFhid52wgSl41gtcVa
         3Oqyu1cUYRO2WehMB9Eb+s9+avMkqz4tEICbNqcmVR8J5kxHdQrSB7orlRiQPpfmy+dQ
         pkAutjRwiCo+OPXJPhpT/Eht7o/inweI2gBqatxF5x8HQjYbcNS6zMZE0RJODvGwkwJr
         c0y9zUAsDqMm6VfT/G3gkDIj7jDqt2HiViSnxqCvQ4DyvV1/TLEvThweABVsW9RQMmO4
         eEHw==
X-Gm-Message-State: ANoB5pn9VXqv/orbjmNtEEh16m+cjJSdiSVtCb4EzHD2IzgGvjt4PvIS
        TnzGKJptvM4hpWXZL4ePkn3lrdowUB5dyA==
X-Google-Smtp-Source: AA0mqf4U4cQbP3lDDoIoPNW0lToxqJOLRkC1ZMEulZlnPD4J37SPwfDQmdLQgzeCpCX2yfF4AHJW6A==
X-Received: by 2002:a05:622a:1aa3:b0:35c:c042:914 with SMTP id s35-20020a05622a1aa300b0035cc0420914mr11391745qtc.179.1669223126503;
        Wed, 23 Nov 2022 09:05:26 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id fb13-20020a05622a480d00b003999d25e772sm10225888qtb.71.2022.11.23.09.05.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 09:05:25 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id d128so3090091ybf.10;
        Wed, 23 Nov 2022 09:05:24 -0800 (PST)
X-Received: by 2002:a25:9e84:0:b0:6de:6183:c5c3 with SMTP id
 p4-20020a259e84000000b006de6183c5c3mr9395618ybq.89.1669223124469; Wed, 23 Nov
 2022 09:05:24 -0800 (PST)
MIME-Version: 1.0
References: <3ee1f8144feb96c28742b22384189f1f83bcfc1a.1669221671.git.geert@linux-m68k.org>
 <Y35RCaEP0icg6San@phenom.ffwll.local>
In-Reply-To: <Y35RCaEP0icg6San@phenom.ffwll.local>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 23 Nov 2022 18:05:13 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVgqwHjm8Hxms04rg6YXiQacEwKiaRV80nNA_OM9mvZpA@mail.gmail.com>
Message-ID: <CAMuHMdVgqwHjm8Hxms04rg6YXiQacEwKiaRV80nNA_OM9mvZpA@mail.gmail.com>
Subject: Re: [PATCH resend v2] drm/fourcc: Add missing big-endian XRGB1555 and
 RGB565 formats
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Wed, Nov 23, 2022 at 5:57 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> On Wed, Nov 23, 2022 at 05:43:10PM +0100, Geert Uytterhoeven wrote:
> > As of commit eae06120f1974e1a ("drm: refuse ADDFB2 ioctl for broken
> > bigendian drivers"), drivers must set the
> > quirk_addfb_prefer_host_byte_order quirk to make the drm_mode_addfb()
> > compat code work correctly on big-endian machines.
> >
> > While that works fine for big-endian XRGB8888 and ARGB8888, which are
> > mapped to the existing little-endian BGRX8888 and BGRA8888 formats, it
> > does not work for big-endian XRGB1555 and RGB565, as the latter are not
> > listed in the format database.
> >
> > Fix this by adding the missing formats.  Limit this to big-endian
> > platforms, as there is currently no need to support these formats on
> > little-endian platforms.
> >
> > Fixes: 6960e6da9cec3f66 ("drm: fix drm_mode_addfb() on big endian machines.")
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> > v2:
> >   - Use "DRM_FORMAT_foo | DRM_FORMAT_BIG_ENDIAN" instead of
> >     "DRM_FORMAT_HOST_foo",
> >   - Turn into a lone patch, as all other patches from series
> >     https://lore.kernel.org/r/cover.1657300532.git.geert@linux-m68k.org
> >     were applied to drm-misc/for-linux-next.

> > --- a/drivers/gpu/drm/drm_fourcc.c
> > +++ b/drivers/gpu/drm/drm_fourcc.c
> > @@ -190,6 +190,10 @@ const struct drm_format_info *__drm_format_info(u32 format)
> >               { .format = DRM_FORMAT_BGRA5551,        .depth = 15, .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> >               { .format = DRM_FORMAT_RGB565,          .depth = 16, .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
> >               { .format = DRM_FORMAT_BGR565,          .depth = 16, .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
> > +#ifdef __BIG_ENDIAN
>
> Why do we need the #ifdef here? Iirc some hw has big endian flags in the
> scanout registers, so could supprt this unconditionally if there's no
> #ifdef around the format defines. Some drivers might then also want a
> DRM_FORMAT_FOO_BE define to simplify tables and stuff, but that's more a
> bikeshed.

 "Limit this to big-endian platforms, as there is currently no need
 to support these formats on little-endian platforms."

Will anyone make use of this? In theory, all of the 16-bpp formats
can have a big-endian counterpart.

I seem to be the first one running into this ;-)

> > +             { .format = DRM_FORMAT_XRGB1555 | DRM_FORMAT_BIG_ENDIAN, .depth = 15, .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
> > +             { .format = DRM_FORMAT_RGB565 | DRM_FORMAT_BIG_ENDIAN, .depth = 16, .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
> > +#endif
> >               { .format = DRM_FORMAT_RGB888,          .depth = 24, .num_planes = 1, .cpp = { 3, 0, 0 }, .hsub = 1, .vsub = 1 },
> >               { .format = DRM_FORMAT_BGR888,          .depth = 24, .num_planes = 1, .cpp = { 3, 0, 0 }, .hsub = 1, .vsub = 1 },
> >               { .format = DRM_FORMAT_XRGB8888,        .depth = 24, .num_planes = 1, .cpp = { 4, 0, 0 }, .hsub = 1, .vsub = 1 },

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
