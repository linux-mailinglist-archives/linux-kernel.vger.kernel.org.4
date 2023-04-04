Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30726D671B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 17:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235625AbjDDPUv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Apr 2023 11:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235618AbjDDPUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 11:20:49 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B9340CD;
        Tue,  4 Apr 2023 08:20:48 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id m16so18791731ybk.0;
        Tue, 04 Apr 2023 08:20:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680621647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RwpxyD/L/JdRbsDbYgifY/Bzo8+RV7g8PvhEjly15kU=;
        b=R6lmXyIAkkTsrqGKETrIHPf1+RPGMatsUicAqE5PIJsEOIOf/mkxr6LQsh6axvKUv7
         OeXjQFUUXDrjKE3oY5F/PiMt5KldisX0bc8PJv77VeQYCc33oY3rXeO24C+u+Efs2d73
         8ShCTy2GS5RzLXUA8AZezQJ0ciwCJLOA762QA/0MVaQkoNBz+FIgrZJzgFJr2REa99/p
         Mk3az4gWuBUrUrJJY/yg3K5I1K/FVcCOaCQc1ZHwNjkT5CcIR120FyVSUZ8s9trfCTz8
         +F0Y+Z7UlL2ULLbvJEpCHt0loBwaXFIuYSeTtVEUTjNJKtRfKZbiQuYtS/JAg2VzYh5b
         048A==
X-Gm-Message-State: AAQBX9fbDkA2QQIr+SkDtC5X6QTgGLepPZ9n+o8p8W5b6BVFC4amD2GH
        Bh8qcC19AcOL+i3veG9t8GVxjf7349E5bTRU
X-Google-Smtp-Source: AKy350bu8q8dQfxRkGCj/JF4FZ4ecJo+4xVzLiTPZzdaL08859XR5aSqsv0u8/cKUQ+a+sY//gNs6A==
X-Received: by 2002:a05:6902:154d:b0:b73:ef29:bcdd with SMTP id r13-20020a056902154d00b00b73ef29bcddmr3989263ybu.38.1680621647350;
        Tue, 04 Apr 2023 08:20:47 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id 127-20020a251285000000b00b7767ca7486sm3386804ybs.35.2023.04.04.08.20.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 08:20:47 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id p204so39116190ybc.12;
        Tue, 04 Apr 2023 08:20:47 -0700 (PDT)
X-Received: by 2002:a25:734d:0:b0:b67:d295:d614 with SMTP id
 o74-20020a25734d000000b00b67d295d614mr1786237ybc.12.1680621646854; Tue, 04
 Apr 2023 08:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220629105658.1373770-1-geert@linux-m68k.org>
 <d27c08a3-0f2f-c0f2-143f-482a33a6a4ce@gmx.de> <YvJ3R2HnTSXDF7lx@phenom.ffwll.local>
In-Reply-To: <YvJ3R2HnTSXDF7lx@phenom.ffwll.local>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Apr 2023 17:20:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUaHd1jgrsCSxCqF-HP2rAo2ODM_ZOjhk7Q4vjuqvt36w@mail.gmail.com>
Message-ID: <CAMuHMdUaHd1jgrsCSxCqF-HP2rAo2ODM_ZOjhk7Q4vjuqvt36w@mail.gmail.com>
Subject: Re: [PATCH] drm/fb-helper: Remove helpers to change frame buffer config
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Tomi Valkeinen <tomba@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hi Daniel,

On Tue, Aug 9, 2022 at 5:03 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> On Sat, Jul 02, 2022 at 08:05:54PM +0200, Helge Deller wrote:
> > On 6/29/22 12:56, Geert Uytterhoeven wrote:
> > > The DRM fbdev emulation layer does not support pushing back
> > > changes to fb_var_screeninfo to KMS.
> > >
> > > However, drm_fb_helper still implements the fb_ops.fb_check_var() and
> > > fb_ops.fb_set_par() callbacks, but the former fails to validate various
> > > parameters passed from userspace.  Hence unsanitized and possible
> > > invaled values are passed up through the fbdev, fbcon, and console
> > > stack, which has become an endless source of security issues reported
> > > against fbdev.
> > >
> > > Fix this by not populating the fb_ops.fb_check_var() and
> > > fb_ops.fb_set_par() callbacks, as there is no point in providing them if
> > > the frame buffer config cannot be changed anyway.  This makes the fbdev
> > > core aware that making changes to the frame buffer config is not
> > > supported, so it will always return the current config.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >
> > It's unfortunate that DRM currently isn't able to switch resolutions
> > at runtime.
> >
> > With that in mind I agree with Geert that it's probably better to
> > disable (or drop) that code until DRM can cope with fbdev's
> > interface to switch resolutions.
> >
> > Furthermore, with the upcoming patches to fbcon (which prevents crashes on
> > invalid userspace input), you will face a kernel WARNING if you call fbset
> > to switch screen resolutions with DRM drivers.
> >
> > So, from my side (although I'd prefer a better fix for DRM):
> >
> > Acked-by: Helge Deller <deller@gmx.de>
>
> So maybe I'm missing something, but I think this breaks a lot of stuff.
> The issue is that fbdev is only a subordinate owner of the kms device, if
> there's a real drm kms owner around that wins.
>
> Which means when you switch back then set_par needs to restore the fbdev
> framebuffer. So that might break some recovery/use-cases.

Upon closer look, I think I was a bit too over-eager, and we can keep
the implementation of fb_ops.fb_set_par().

> The other thing is that I think this also breaks the scanout offset, and
> people do use that for double-buffering on top of fbdev on top of drm
> drivers. So we can't just nuke it completely.

You mean panning? That does not need fb_ops.fb_check_var(), as it
should be done through fb_ops.fb_pan_display().

> For better or worse I think we need to keep playing the whack-a-mole game.
> Or do I miss something here?

With the above fixed, we can continue whacking the drm bugs in
implementing the fbdev API?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
