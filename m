Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D50265E8FD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbjAEKZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjAEKZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:25:16 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6EC5F917
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:21:20 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id b12so24213648pgj.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZK4nzjpwYyPyn93IloxZTntg6CUAnuhsiuX1hJc/KI=;
        b=NuTSU+tAnwC8J4btJEi46FZKTDoZWSpXhsZZzvvEeCRUZI31x8P+7W/qyYZB6cEEZK
         0KfqehuBvr3rjXJk15PxC+x+93bMexZ1PTi8huCZmuuTQwSpPawXccgf2pmEghY9bMvX
         RzGNrLQAa48wSr1uQzuiAGZF/YjK7ZhJfA8YU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ZK4nzjpwYyPyn93IloxZTntg6CUAnuhsiuX1hJc/KI=;
        b=2pwBw11EAD7BDj9kSD2c8iNHbJKYnBPNJorgOB/tRgMDXJMvB7z1MWO8OWX7IGXJ2A
         fm1rClc6GxM3qQ0BrEwh2y2lAuBynpOdEhsRGLscwXLi7nOCWSlYlePUMFjS+flphceb
         W9owMw+WnmCD64+F3Nfaws6hRsfl2uAy+B4hY/GzJgU2KNKDTTXAKdBan9n2SziiVIyz
         ebu6X1aRYU+8nGv8ZvqB7vWtCO4NMEVu9chFwwMgpq0ZiDeWH6rXF8XrJibaBC9yIwJI
         o+9LFLvNqYaJXI4Y/ojiUoZqazp/SIIUMJV8Ib26K3jGX5bTff72nu239VBza03yVRSE
         PFxw==
X-Gm-Message-State: AFqh2kqPLftZexbdEI5/KiEcdFhFoD+igBBDMaeA6mM/CmSJ5uCkDTOW
        GD8feU2ywHE+4+3o63GCdZgt6koUusu3MD/MXS6lgQ==
X-Google-Smtp-Source: AMrXdXssy7ciG/1su3bGuzOuebGGe/Miuoaa+b1nRbxfY/bK92mfuvYqvrAxm2xmyTnyeF75o20imvtTyBVEbJ5RYRs=
X-Received: by 2002:a63:1b59:0:b0:478:b792:dea6 with SMTP id
 b25-20020a631b59000000b00478b792dea6mr3746828pgm.445.1672914077499; Thu, 05
 Jan 2023 02:21:17 -0800 (PST)
MIME-Version: 1.0
References: <20221230063528.41037-1-zh.nvgt@gmail.com> <2711de96-fcbe-5611-657a-ab29becd2ff6@gmx.de>
In-Reply-To: <2711de96-fcbe-5611-657a-ab29becd2ff6@gmx.de>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 5 Jan 2023 11:21:05 +0100
Message-ID: <CAKMK7uEOX5n64cjzMt9GRQaS13HFPFyOeqdrkmzc035U5_T8tg@mail.gmail.com>
Subject: Re: [PATCH] fbmem: prevent potential use-after-free issues with console_lock()
To:     Helge Deller <deller@gmx.de>
Cc:     Hang Zhang <zh.nvgt@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Helge

On Mon, 2 Jan 2023 at 16:28, Helge Deller <deller@gmx.de> wrote:
>
> On 12/30/22 07:35, Hang Zhang wrote:
> > In do_fb_ioctl(), user specified "fb_info" can be freed in the callee
> > fbcon_get_con2fb_map_ioctl() -> set_con2fb_map() ->
> > con2fb_release_oldinfo(), this free operation is protected by
> > console_lock() in fbcon_set_con2fb_map_ioctl(), it also results in
> > the change of certain states such as "minfo->dead" in matroxfb_remove(),
> > so that it can be checked to avoid use-after-free before the use sites
> > (e.g., the check at the beginning of matroxfb_ioctl()). However,
> > the problem is that the use site is not protected by the same locks
> > as for the free operation, e.g., "default" case in do_fb_ioctl()
> > can lead to "matroxfb_ioctl()" but it's not protected by console_lock(),
> > which can invalidate the aforementioned state set and check in a
> > concurrent setting.
> >
> > Prevent the potential use-after-free issues by protecting the "default"
> > case in do_fb_ioctl() with console_lock(), similarly as for many other
> > cases like "case FBIOBLANK" and "case FBIOPAN_DISPLAY".
> >
> > Signed-off-by: Hang Zhang <zh.nvgt@gmail.com>
>
> applied to fbdev git tree.

The patch above makes no sense at all to me:

- fb_info is protected by lock_fb_info and
- the lifetime of fb_info is protected by the get/put functions
- yes there's the interaction with con2fb, which is protected by
console_lock, but the lifetime guarantees are ensured by the device
removal
- which means any stuff happening in matroxfb_remove is also not a
concern here (unless matroxfb completely gets all the device lifetime
stuff wrong, but it doesn't look like it's any worse than any of the
other fbdev drivers that we haven't recently fixed up due to the
takeover issues with firmware drivers

On the very clear downside this now means we take console_lock for the
vblank ioctl (which is a device driver extension for reasons, despite
that it's a standard fbdev ioctl), which is no good at all given how
console_lock() is a really expensive lock.

Unless I'm massively missing something, can you pls push the revert
before this lands in Linus' tree?

Thanks, Daniel

> Thanks,
> Helge
>
> > ---
> >   drivers/video/fbdev/core/fbmem.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> > index 1e70d8c67653..8b1a1527d18a 100644
> > --- a/drivers/video/fbdev/core/fbmem.c
> > +++ b/drivers/video/fbdev/core/fbmem.c
> > @@ -1182,6 +1182,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
> >               console_unlock();
> >               break;
> >       default:
> > +             console_lock();
> >               lock_fb_info(info);
> >               fb = info->fbops;
> >               if (fb->fb_ioctl)
> > @@ -1189,6 +1190,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
> >               else
> >                       ret = -ENOTTY;
> >               unlock_fb_info(info);
> > +             console_unlock();
> >       }
> >       return ret;
> >   }
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
