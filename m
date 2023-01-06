Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794976606DC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 20:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbjAFTB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 14:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbjAFTAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 14:00:52 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7058408B
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 10:59:23 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id k26-20020a05600c1c9a00b003d972646a7dso4192193wms.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 10:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EB9L09ZT4LgxH7QmAmuL+RfnfEH/uxZ6eOTsoZrqV8o=;
        b=OeMuE64xt4xVWOw9nP1xpX3iLXGeafnyHwy9SaHEmfX9v9V9FiOzmgFq1YmSrJiS9J
         ulyv5ERBj7lmm768N7P+UIpH7xy5DMfotJYCl8TOWdSc+QFwkOSgwrQEQBwDMONac4w7
         01maNjw9RfiQmM1r9Qg6h+qiDNIVIM44XEtNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EB9L09ZT4LgxH7QmAmuL+RfnfEH/uxZ6eOTsoZrqV8o=;
        b=amcP4zqiQTvQUFgHyS/38bwI3TGrNZJnXg1daQF8da4mcfSa2nqCHBi6tgrHLmUeKK
         sCHJqVBW1KEPkj6MkC0GjU+7CAwRs2TXV8CyC4P4X7SPQsuoRGiXTm8O8cb6E9FTRHxc
         qhj6ip803IgYigBLOGHQbAEq78nMvd1HzWSGI/X/o/JfI3Trid6CX8GaPLQSQ7p0Ysf3
         4rt8UuH0Pbdeua6+tfAXsaj+zf/kIcVMLc/3KwLQ8e0ajFwKk5/SjdHlQHukraCdhdbu
         yxfHeP7jZKjAAQRp7a3l+Y7Dd2h2qDROURitZOPIviXUpin224r5ZICX1LQhFp6PGUZa
         Vr6A==
X-Gm-Message-State: AFqh2kq5h5IZX+idKTjaYMCNjRoXZR4gl36INdgZS1mgughkW/ajGX0V
        7nXbZlm0hfM8XI7nbjipgW/Qxg==
X-Google-Smtp-Source: AMrXdXv8npyyRPhLx+WNOJ0Z/Earz2JzCqiyT8P3U7WshmLuQKfa7aDJ4qmoOG93cFMFeWY1CNkOYw==
X-Received: by 2002:a05:600c:3d8a:b0:3d3:4406:8a37 with SMTP id bi10-20020a05600c3d8a00b003d344068a37mr40421238wmb.41.1673031561708;
        Fri, 06 Jan 2023 10:59:21 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id m18-20020a05600c4f5200b003c71358a42dsm9665293wmq.18.2023.01.06.10.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 10:59:20 -0800 (PST)
Date:   Fri, 6 Jan 2023 19:59:18 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Hang Zhang <zh.nvgt@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbmem: prevent potential use-after-free issues with
 console_lock()
Message-ID: <Y7hvhtHeivfsnBtE@phenom.ffwll.local>
Mail-Followup-To: Hang Zhang <zh.nvgt@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20221230063528.41037-1-zh.nvgt@gmail.com>
 <2711de96-fcbe-5611-657a-ab29becd2ff6@gmx.de>
 <CAKMK7uEOX5n64cjzMt9GRQaS13HFPFyOeqdrkmzc035U5_T8tg@mail.gmail.com>
 <CAKMK7uE7CAXO50JPQ6ziQGGehqfDK2UanBQbfLdUH2RwrwXUvw@mail.gmail.com>
 <CAO2zrtYDcOfvxpG6wPghPnWZVks+NL6N9VaynsBVoX7nHBcxuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO2zrtYDcOfvxpG6wPghPnWZVks+NL6N9VaynsBVoX7nHBcxuw@mail.gmail.com>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 01:38:54PM -0500, Hang Zhang wrote:
> On Thu, Jan 5, 2023 at 5:25 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Thu, 5 Jan 2023 at 11:21, Daniel Vetter <daniel@ffwll.ch> wrote:
> > >
> > > Hi Helge
> > >
> > > On Mon, 2 Jan 2023 at 16:28, Helge Deller <deller@gmx.de> wrote:
> > > >
> > > > On 12/30/22 07:35, Hang Zhang wrote:
> > > > > In do_fb_ioctl(), user specified "fb_info" can be freed in the callee
> > > > > fbcon_get_con2fb_map_ioctl() -> set_con2fb_map() ->
> > > > > con2fb_release_oldinfo(), this free operation is protected by
> > > > > console_lock() in fbcon_set_con2fb_map_ioctl(), it also results in
> > > > > the change of certain states such as "minfo->dead" in matroxfb_remove(),
> > > > > so that it can be checked to avoid use-after-free before the use sites
> > > > > (e.g., the check at the beginning of matroxfb_ioctl()). However,
> > > > > the problem is that the use site is not protected by the same locks
> > > > > as for the free operation, e.g., "default" case in do_fb_ioctl()
> > > > > can lead to "matroxfb_ioctl()" but it's not protected by console_lock(),
> > > > > which can invalidate the aforementioned state set and check in a
> > > > > concurrent setting.
> > > > >
> > > > > Prevent the potential use-after-free issues by protecting the "default"
> > > > > case in do_fb_ioctl() with console_lock(), similarly as for many other
> > > > > cases like "case FBIOBLANK" and "case FBIOPAN_DISPLAY".
> > > > >
> > > > > Signed-off-by: Hang Zhang <zh.nvgt@gmail.com>
> > > >
> > > > applied to fbdev git tree.
> > >
> > > The patch above makes no sense at all to me:
> > >
> > > - fb_info is protected by lock_fb_info and
> > > - the lifetime of fb_info is protected by the get/put functions
> > > - yes there's the interaction with con2fb, which is protected by
> > > console_lock, but the lifetime guarantees are ensured by the device
> > > removal
> > > - which means any stuff happening in matroxfb_remove is also not a
> > > concern here (unless matroxfb completely gets all the device lifetime
> > > stuff wrong, but it doesn't look like it's any worse than any of the
> > > other fbdev drivers that we haven't recently fixed up due to the
> > > takeover issues with firmware drivers
> >
> > I have also a really hard timing finding the con2fb map use in the
> > matroxfb ioctl code, but that just might be that I didn't look
> > carefully enough. Maybe that would shed some light on this.
> > -Daniel
> >
> >
> > >
> > > On the very clear downside this now means we take console_lock for the
> > > vblank ioctl (which is a device driver extension for reasons, despite
> > > that it's a standard fbdev ioctl), which is no good at all given how
> > > console_lock() is a really expensive lock.
> > >
> > > Unless I'm massively missing something, can you pls push the revert
> > > before this lands in Linus' tree?
> > >
> > > Thanks, Daniel
> 
> Hi, Daniel. Thank you for your feedback. We're not developers of the
> video subsystem and thus may be short in domain knowledge (e.g., the
> performance of console_lock() and the complex lifetime management).
> This patch initially intended to bring up the potential use-after-free
> issues here to the community - we have performed a best-effort code
> review and cannot exclude the possibility based on our understanding.
> 
> What we have observed is that the call chain leading to the free site
> (do_fb_ioctl()->fbcon_set_con2fb_map_ioctl()->set_con2fb_map()->
> con2fb_release_oldinfo()-> ... ->matroxfb_remove()) is only protected
> by console_lock() but not lock_fb_info(), while the potential use
> site (call chain starts from the default case in do_fb_ioctl()) is
> only protected by lock_fb_info() but not console_lock().
> We thus propose to add this extra console_lock() to the default case,
> which is inspired by the lock protection of many other existing
> switch-case terms in the same function.
> 
> Since we do not have deep domain knowledge of this subsystem, we will
> rely on the developers to make a decision regarding the patch. Thank
> you again for your review and help!

Can you please elaborate where you've found this use-after-free and how?
I'm still not understanding how you even got here - this is orthogonal to
whether the patch is the right fix or not.
-Daniel

> 
> Best,
> Hang
> 
> > >
> > > > Thanks,
> > > > Helge
> > > >
> > > > > ---
> > > > >   drivers/video/fbdev/core/fbmem.c | 2 ++
> > > > >   1 file changed, 2 insertions(+)
> > > > >
> > > > > diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> > > > > index 1e70d8c67653..8b1a1527d18a 100644
> > > > > --- a/drivers/video/fbdev/core/fbmem.c
> > > > > +++ b/drivers/video/fbdev/core/fbmem.c
> > > > > @@ -1182,6 +1182,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
> > > > >               console_unlock();
> > > > >               break;
> > > > >       default:
> > > > > +             console_lock();
> > > > >               lock_fb_info(info);
> > > > >               fb = info->fbops;
> > > > >               if (fb->fb_ioctl)
> > > > > @@ -1189,6 +1190,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
> > > > >               else
> > > > >                       ret = -ENOTTY;
> > > > >               unlock_fb_info(info);
> > > > > +             console_unlock();
> > > > >       }
> > > > >       return ret;
> > > > >   }
> > > >
> > >
> > >
> > > --
> > > Daniel Vetter
> > > Software Engineer, Intel Corporation
> > > http://blog.ffwll.ch
> >
> >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
