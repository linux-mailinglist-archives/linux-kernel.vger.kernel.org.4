Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC65637541
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 10:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiKXJfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 04:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiKXJfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 04:35:46 -0500
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3F6109589;
        Thu, 24 Nov 2022 01:35:45 -0800 (PST)
Received: by mail-qv1-f43.google.com with SMTP id mx15so667261qvb.1;
        Thu, 24 Nov 2022 01:35:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1XR49b+yg+C7gT3kofJlHlh8rfvgaOOr3pljl0Lz0OA=;
        b=pTgY5YTemo0SS1SA++wQa9aBqz4szE8ZRPYApc/BkMvYxD42eTdSFnrptEXyMmGIgL
         xCSGeCNtcKKDnUk2DZMt3R3GxL5D6W0XnFFjEqeVkXCDfF5eQ1J9hpSVWILFun0cE+0/
         UAR5tvxNzpIh8MyyfNMIeEltYYNuDizm8G6wdPk6h7utxSxWlKicYeAyjIH5kmUMzkFp
         oQYWUQB0uJUXYL6Md12B2iH7rHxC20ZyED2WkkrEdW1DpNv9Kd4aE8A75bxgC0+FK5Xc
         fEQNTHQu04Gq7PAWyv7MZIhtVlcrc20aOdX7GFxYNgfLzMtkzN1F+5X9ifrJz9JRYBgC
         LBeA==
X-Gm-Message-State: ANoB5plZZ68ucQFTD8XcEpcB7zhS4mO5mT7+VYHDp1vOOHwI8Zw0Hhoh
        6CISV1EM9JGBU58SbtEM/3E0l3tg0duZyQ==
X-Google-Smtp-Source: AA0mqf5OXrkcoug+ETkL2tfd7wHOroW7L2LnDfgn4tExxQflkJPI9JMeWFwuy4mMFyioPukYtmbk9A==
X-Received: by 2002:a05:6214:5693:b0:4bb:59c1:3ded with SMTP id lm19-20020a056214569300b004bb59c13dedmr13531240qvb.68.1669282544283;
        Thu, 24 Nov 2022 01:35:44 -0800 (PST)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id s14-20020a05620a29ce00b006cf38fd659asm559378qkp.103.2022.11.24.01.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 01:35:43 -0800 (PST)
Received: by mail-yb1-f181.google.com with SMTP id z192so1261734yba.0;
        Thu, 24 Nov 2022 01:35:43 -0800 (PST)
X-Received: by 2002:a25:ad8b:0:b0:6de:6c43:3991 with SMTP id
 z11-20020a25ad8b000000b006de6c433991mr11015229ybi.604.1669282543207; Thu, 24
 Nov 2022 01:35:43 -0800 (PST)
MIME-Version: 1.0
References: <3ee1f8144feb96c28742b22384189f1f83bcfc1a.1669221671.git.geert@linux-m68k.org>
 <e2ef753e-8527-1fc6-f2f0-bc10aa744463@suse.de> <CAMuHMdXHOGz6Q9jsp9+Y6Op5qw3E-qUnHzYv3rxkVO5Bd2bKjw@mail.gmail.com>
 <Y38znirlUpFoQRqX@phenom.ffwll.local> <9f069800-f536-e262-1914-bec03e11f57c@suse.de>
In-Reply-To: <9f069800-f536-e262-1914-bec03e11f57c@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 24 Nov 2022 10:35:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXD38dYwYqDV8sSyoAmFF8haMYVH3r5y-5jnNeJtBWqbg@mail.gmail.com>
Message-ID: <CAMuHMdXD38dYwYqDV8sSyoAmFF8haMYVH3r5y-5jnNeJtBWqbg@mail.gmail.com>
Subject: Re: [PATCH resend v2] drm/fourcc: Add missing big-endian XRGB1555 and
 RGB565 formats
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
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

On Thu, Nov 24, 2022 at 10:20 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 24.11.22 um 10:04 schrieb Daniel Vetter:
> > On Thu, Nov 24, 2022 at 09:55:18AM +0100, Geert Uytterhoeven wrote:
> >> Hi Thomas,
> >>
> >> On Thu, Nov 24, 2022 at 9:47 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >>> Am 23.11.22 um 17:43 schrieb Geert Uytterhoeven:
> >>>> As of commit eae06120f1974e1a ("drm: refuse ADDFB2 ioctl for broken
> >>>> bigendian drivers"), drivers must set the
> >>>> quirk_addfb_prefer_host_byte_order quirk to make the drm_mode_addfb()
> >>>> compat code work correctly on big-endian machines.
> >>>>
> >>>> While that works fine for big-endian XRGB8888 and ARGB8888, which are
> >>>> mapped to the existing little-endian BGRX8888 and BGRA8888 formats, it
> >>>> does not work for big-endian XRGB1555 and RGB565, as the latter are not
> >>>> listed in the format database.
> >>>>
> >>>> Fix this by adding the missing formats.  Limit this to big-endian
> >>>> platforms, as there is currently no need to support these formats on
> >>>> little-endian platforms.
> >>>>
> >>>> Fixes: 6960e6da9cec3f66 ("drm: fix drm_mode_addfb() on big endian machines.")
> >>>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >>>> ---
> >>>> v2:
> >>>>     - Use "DRM_FORMAT_foo | DRM_FORMAT_BIG_ENDIAN" instead of
> >>>>       "DRM_FORMAT_HOST_foo",
> >>>>     - Turn into a lone patch, as all other patches from series
> >>>>       https://lore.kernel.org/r/cover.1657300532.git.geert@linux-m68k.org
> >>>>       were applied to drm-misc/for-linux-next.
> >>>> ---
> >>>>    drivers/gpu/drm/drm_fourcc.c | 4 ++++
> >>>>    1 file changed, 4 insertions(+)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
> >>>> index e09331bb3bc73f21..265671a7f9134c1f 100644
> >>>> --- a/drivers/gpu/drm/drm_fourcc.c
> >>>> +++ b/drivers/gpu/drm/drm_fourcc.c
> >>>> @@ -190,6 +190,10 @@ const struct drm_format_info *__drm_format_info(u32 format)
> >>>>                { .format = DRM_FORMAT_BGRA5551,        .depth = 15, .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> >>>>                { .format = DRM_FORMAT_RGB565,          .depth = 16, .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
> >>>>                { .format = DRM_FORMAT_BGR565,          .depth = 16, .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
> >>>> +#ifdef __BIG_ENDIAN
> >>>> +             { .format = DRM_FORMAT_XRGB1555 | DRM_FORMAT_BIG_ENDIAN, .depth = 15, .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
> >>>> +             { .format = DRM_FORMAT_RGB565 | DRM_FORMAT_BIG_ENDIAN, .depth = 16, .num_planes = 1, .cpp = { 2, 0, 0 }, .hsub = 1, .vsub = 1 },
> >>>
> >>> Getting back to the discussion on endianess, I don't understand why the
> >>> BIG_ENDIAN flag is set here.  AFAIK these formats are always little
> >>> endian.  And the BE flag is set by drivers/userspace if a framebuffer
> >>> has a BE ordering.
> >>>
> >>> It would be better to filter the BE flag in __drm_format_info() before
> >>> the function does the lookup.
> >>
> >> I mentioned that alternative in [2], but rejected it because of the
> >> disadvantages:
> >>    - {,__}drm_format_info() returns a pointer to a const object,
> >>      whose .format field won't have the DRM_FORMAT_BIG_ENDIAN flag set,
> >>      complicating callers,
> >>    - All callers need to be updated,
> >>    - It is difficult to know which big-endian formats are really
> >>      supported, especially as only a few are needed.
> >
> > fwiw this last point is why I think this is the right approach. Long term
> > we might want to add _BE variants of these #defines so that they can be
> > used everywhere and are easy to grep. As long as it's just a handful of
> > places then the very verboy | DRM_FORMAT_BIG_ENDIAN is ok too.
>
> Doesn't that contradict the comment at [1] to some extend? 'DRM formats
> are little endian.' and extra defines are only made for simplifying drivers.
>
> [1]
> https://elixir.bootlin.com/linux/latest/source/include/drm/drm_fourcc.h#L33
>
> >
> > With this approach we can make it _very_ explicit what big endian formats
> > are supported by a driver or other piece in the stack (like fbdev
> > emulation), and I think explicit is what we want with be because it's
> > become such an exception. Otherwise we'll just end up with more terrible
> > cruft like the host endian hacks in the addfb compat code.
>
> To give a different perspective, with format-conversion helpers the
> destination buffer is usually a hardware buffer that can have big-endian
> ordering. So we sometimes have to swap byteorder to make output colors
> look correct. That is the easiest if all formats are in LE and the
> BIG_ENDIAN flag tells us when the swap. With the current multitude of
> formats and B_E flags that can describe the same result, it's all just
> more complicated.

I'm happy to _not_ export the big-endian RGB565 format in atari_drm, and
just do the byte swapping when copying to the hardware frame buffer ;-)
(although that would preclude some (future) optimization handing out
buffers allocated from graphics memory to avoid any copying at all)

But currently, drivers on big-endian platforms must set the
quirk_addfb_prefer_host_byte_order quirk flag, and doing so forces
the frame buffer console emulation to use big-endian RGB565, requiring
the big-endian RGB565 format to be present in the formats[] array.

P.S. Ext2fs used have a big-endian variant.  It was dropped, and
     everyone settled on the little-endian variant, as it was much
     faster to always do the byte swapping on big-endian, than to handle
     both the little-endian and big-endian variants dynamically.
     Likewise, XFS stayed big-endian.
     DRM settled on little-endian-with-exceptions...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
