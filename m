Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600A86374B9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 10:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiKXJEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 04:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiKXJEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 04:04:37 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C641121DB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:04:34 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id fy37so2665062ejc.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcMMrNexMg7uk5V07y6ofHZRaGMFOJAdVNWM7NvAom8=;
        b=c6ZFFMxPziWGEih6OnzFHJWQjimPOB+VTcv7M55W96qIhRsMA9iYuK2Zne80r9r8Te
         ghZefKeRzP2yj2a0TGWmlmzZNCl8sijGM9rSs3aGaFrDv39pwcxFPvxveLiJApl5ZYwd
         kUQi4nvT0r1sn4RfbaeCZgTsM3mxERsLLq1P4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pcMMrNexMg7uk5V07y6ofHZRaGMFOJAdVNWM7NvAom8=;
        b=3QXfUE3ZkoyDl4F+dxyXLRaTM5FlwXRkkw1QKqOrNCu+hq7LVUOy9i9ggUtS978sFK
         cugT8Ub7vVpbp96S6k8Hvde6y7mkqTTqWoyTHoL7ZahXNS8pgRNaJoxPmzEp7i6Q2yxu
         F+crbPpN5gHoXnQ+8v1i2l8bFXSzCHKlY6NPp8pmiv50VhavXKm+G1pAQ9GrOkhbSv6Q
         LV/RgmMIo4SF9pb1kcHLXcXt4fGMMsovjbi/Eig1oEJ4kh8Uasyl974eXPCNu5ueX+84
         /G4g8yFeChTJ7cAWZMs7o/0H2TvhFsca6kv2Zm1drLc9eVeQ9cf+wLhx4ddxV0wRrvDX
         q1xg==
X-Gm-Message-State: ANoB5pn790uOFngFOhJ6R8dsnxlTYL8NrOg3zgVtUKwDMgH7Jkq6bi0v
        FVFKzUqaPp7HdtgVLgtVNJHjEB9MbAGQBw==
X-Google-Smtp-Source: AA0mqf5YqGkNGskmrDFzq3+eFN3Y6OY0f7bSR7ohOOG2Q/QaVAUliYK9jJg4fzmfR/0SXkM+XsDyhw==
X-Received: by 2002:a17:907:8c0d:b0:7ae:70f9:114 with SMTP id ta13-20020a1709078c0d00b007ae70f90114mr26594367ejc.44.1669280672953;
        Thu, 24 Nov 2022 01:04:32 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id i25-20020a056402055900b0046730154ccbsm271694edx.42.2022.11.24.01.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 01:04:32 -0800 (PST)
Date:   Thu, 24 Nov 2022 10:04:30 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gerd Hoffmann <kraxel@redhat.com>, linux-fbdev@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend v2] drm/fourcc: Add missing big-endian XRGB1555
 and RGB565 formats
Message-ID: <Y38znirlUpFoQRqX@phenom.ffwll.local>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
        linux-fbdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <3ee1f8144feb96c28742b22384189f1f83bcfc1a.1669221671.git.geert@linux-m68k.org>
 <e2ef753e-8527-1fc6-f2f0-bc10aa744463@suse.de>
 <CAMuHMdXHOGz6Q9jsp9+Y6Op5qw3E-qUnHzYv3rxkVO5Bd2bKjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXHOGz6Q9jsp9+Y6Op5qw3E-qUnHzYv3rxkVO5Bd2bKjw@mail.gmail.com>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 09:55:18AM +0100, Geert Uytterhoeven wrote:
> Hi Thomas,
> 
> On Thu, Nov 24, 2022 at 9:47 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> > Am 23.11.22 um 17:43 schrieb Geert Uytterhoeven:
> > > As of commit eae06120f1974e1a ("drm: refuse ADDFB2 ioctl for broken
> > > bigendian drivers"), drivers must set the
> > > quirk_addfb_prefer_host_byte_order quirk to make the drm_mode_addfb()
> > > compat code work correctly on big-endian machines.
> > >
> > > While that works fine for big-endian XRGB8888 and ARGB8888, which are
> > > mapped to the existing little-endian BGRX8888 and BGRA8888 formats, it
> > > does not work for big-endian XRGB1555 and RGB565, as the latter are not
> > > listed in the format database.
> > >
> > > Fix this by adding the missing formats.  Limit this to big-endian
> > > platforms, as there is currently no need to support these formats on
> > > little-endian platforms.
> > >
> > > Fixes: 6960e6da9cec3f66 ("drm: fix drm_mode_addfb() on big endian machines.")
> > > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > ---
> > > v2:
> > >    - Use "DRM_FORMAT_foo | DRM_FORMAT_BIG_ENDIAN" instead of
> > >      "DRM_FORMAT_HOST_foo",
> > >    - Turn into a lone patch, as all other patches from series
> > >      https://lore.kernel.org/r/cover.1657300532.git.geert@linux-m68k.org
> > >      were applied to drm-misc/for-linux-next.
> > > ---
> > >   drivers/gpu/drm/drm_fourcc.c | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
> > > index e09331bb3bc73f21..265671a7f9134c1f 100644
> > > --- a/drivers/gpu/drm/drm_fourcc.c
> > > +++ b/drivers/gpu/drm/drm_fourcc.c
> > > @@ -190,6 +190,10 @@ const struct drm_format_info *__drm_format_info(u32 format)
> > >               { .format = DRM_FORMAT_BGRA5551,        .depth = 15, .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> > >               { .format = DRM_FORMAT_RGB565,          .depth = 16, .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
> > >               { .format = DRM_FORMAT_BGR565,          .depth = 16, .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
> > > +#ifdef __BIG_ENDIAN
> > > +             { .format = DRM_FORMAT_XRGB1555 | DRM_FORMAT_BIG_ENDIAN, .depth = 15, .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
> > > +             { .format = DRM_FORMAT_RGB565 | DRM_FORMAT_BIG_ENDIAN, .depth = 16, .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
> >
> > Getting back to the discussion on endianess, I don't understand why the
> > BIG_ENDIAN flag is set here.  AFAIK these formats are always little
> > endian.  And the BE flag is set by drivers/userspace if a framebuffer
> > has a BE ordering.
> >
> > It would be better to filter the BE flag in __drm_format_info() before
> > the function does the lookup.
> 
> I mentioned that alternative in [2], but rejected it because of the
> disadvantages:
>   - {,__}drm_format_info() returns a pointer to a const object,
>     whose .format field won't have the DRM_FORMAT_BIG_ENDIAN flag set,
>     complicating callers,
>   - All callers need to be updated,
>   - It is difficult to know which big-endian formats are really
>     supported, especially as only a few are needed.

fwiw this last point is why I think this is the right approach. Long term
we might want to add _BE variants of these #defines so that they can be
used everywhere and are easy to grep. As long as it's just a handful of
places then the very verboy | DRM_FORMAT_BIG_ENDIAN is ok too.

With this approach we can make it _very_ explicit what big endian formats
are supported by a driver or other piece in the stack (like fbdev
emulation), and I think explicit is what we want with be because it's
become such an exception. Otherwise we'll just end up with more terrible
cruft like the host endian hacks in the addfb compat code.
-Daniel
> 
> [2] [PATCH 1/3] drm/fourcc: Add missing big-endian XRGB1555 and RGB565 formats
> https://lore.kernel.org/all/0744671ac096a12f0d538906bd324efa71b11400.1657300532.git.geert@linux-m68k.org
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
