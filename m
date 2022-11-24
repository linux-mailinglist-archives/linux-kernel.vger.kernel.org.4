Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9646637493
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 09:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiKXI4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 03:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiKXIzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:55:55 -0500
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA2111A72C;
        Thu, 24 Nov 2022 00:55:33 -0800 (PST)
Received: by mail-qk1-f176.google.com with SMTP id c2so638609qko.1;
        Thu, 24 Nov 2022 00:55:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ltDWhcn3gZTnH4uku4/njf53RbMuOe2j1J0ZvvamyfA=;
        b=N4giKjJd0Iqpf52KGNe60VWHEkJ2VmGZ/zDQA7XaBI+sh3kVt3sl7zLelG5CMZcBMC
         7phZmWU/kuktXV84UoDdda3u0mgSe7MtATb/pb4aT/yJD80V/idMhHJEz0uaGoLfZ2kB
         m+X6keIbcybnjbnUdiutiSElfBxQsKbcvnOhlMZZfQGkdeox0ktzvx9EvbEadKaqBjD/
         ZYUagPTMBwkwSWM47scOWXRpulH7s19xSp0QFOlafMZhdOpvNdXrkyy5nNIrQnbedITb
         rqqZ6LVPYJD04rCnae3zR32pZkM168rrgmoo/vfIqd4aj5DQwzHxCPVjtqEBVTxJKUO9
         SZsA==
X-Gm-Message-State: ANoB5plOx4zBuWlNj4hBdEPpc0FdnN9WEHhJDqoAbuFbro93t+kBNKbH
        rukMVgHiahd6OHy5sE9JYoThj0vQhRAaEg==
X-Google-Smtp-Source: AA0mqf5BaMz4t/r8WDt1gqq5nATajG+kLGl1JP2BTbUwJrbQTHbL7sO0ZovhDAQvCf+DQtOArhO+eA==
X-Received: by 2002:a05:620a:10b4:b0:6fb:f17e:c8f8 with SMTP id h20-20020a05620a10b400b006fbf17ec8f8mr18180106qkk.404.1669280131950;
        Thu, 24 Nov 2022 00:55:31 -0800 (PST)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id a3-20020a05620a438300b006ce0733caebsm538159qkp.14.2022.11.24.00.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 00:55:30 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id i131so1103715ybc.9;
        Thu, 24 Nov 2022 00:55:30 -0800 (PST)
X-Received: by 2002:a25:9e84:0:b0:6de:6183:c5c3 with SMTP id
 p4-20020a259e84000000b006de6183c5c3mr12337016ybq.89.1669280130150; Thu, 24
 Nov 2022 00:55:30 -0800 (PST)
MIME-Version: 1.0
References: <3ee1f8144feb96c28742b22384189f1f83bcfc1a.1669221671.git.geert@linux-m68k.org>
 <e2ef753e-8527-1fc6-f2f0-bc10aa744463@suse.de>
In-Reply-To: <e2ef753e-8527-1fc6-f2f0-bc10aa744463@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 24 Nov 2022 09:55:18 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXHOGz6Q9jsp9+Y6Op5qw3E-qUnHzYv3rxkVO5Bd2bKjw@mail.gmail.com>
Message-ID: <CAMuHMdXHOGz6Q9jsp9+Y6Op5qw3E-qUnHzYv3rxkVO5Bd2bKjw@mail.gmail.com>
Subject: Re: [PATCH resend v2] drm/fourcc: Add missing big-endian XRGB1555 and
 RGB565 formats
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gerd Hoffmann <kraxel@redhat.com>, linux-fbdev@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Thu, Nov 24, 2022 at 9:47 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 23.11.22 um 17:43 schrieb Geert Uytterhoeven:
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
> >    - Use "DRM_FORMAT_foo | DRM_FORMAT_BIG_ENDIAN" instead of
> >      "DRM_FORMAT_HOST_foo",
> >    - Turn into a lone patch, as all other patches from series
> >      https://lore.kernel.org/r/cover.1657300532.git.geert@linux-m68k.org
> >      were applied to drm-misc/for-linux-next.
> > ---
> >   drivers/gpu/drm/drm_fourcc.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
> > index e09331bb3bc73f21..265671a7f9134c1f 100644
> > --- a/drivers/gpu/drm/drm_fourcc.c
> > +++ b/drivers/gpu/drm/drm_fourcc.c
> > @@ -190,6 +190,10 @@ const struct drm_format_info *__drm_format_info(u32 format)
> >               { .format = DRM_FORMAT_BGRA5551,        .depth = 15, .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> >               { .format = DRM_FORMAT_RGB565,          .depth = 16, .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
> >               { .format = DRM_FORMAT_BGR565,          .depth = 16, .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
> > +#ifdef __BIG_ENDIAN
> > +             { .format = DRM_FORMAT_XRGB1555 | DRM_FORMAT_BIG_ENDIAN, .depth = 15, .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
> > +             { .format = DRM_FORMAT_RGB565 | DRM_FORMAT_BIG_ENDIAN, .depth = 16, .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
>
> Getting back to the discussion on endianess, I don't understand why the
> BIG_ENDIAN flag is set here.  AFAIK these formats are always little
> endian.  And the BE flag is set by drivers/userspace if a framebuffer
> has a BE ordering.
>
> It would be better to filter the BE flag in __drm_format_info() before
> the function does the lookup.

I mentioned that alternative in [2], but rejected it because of the
disadvantages:
  - {,__}drm_format_info() returns a pointer to a const object,
    whose .format field won't have the DRM_FORMAT_BIG_ENDIAN flag set,
    complicating callers,
  - All callers need to be updated,
  - It is difficult to know which big-endian formats are really
    supported, especially as only a few are needed.

[2] [PATCH 1/3] drm/fourcc: Add missing big-endian XRGB1555 and RGB565 formats
https://lore.kernel.org/all/0744671ac096a12f0d538906bd324efa71b11400.1657300532.git.geert@linux-m68k.org

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
