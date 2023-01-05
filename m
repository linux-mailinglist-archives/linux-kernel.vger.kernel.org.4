Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944D865F3E1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 19:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234968AbjAESjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 13:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235237AbjAESjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 13:39:16 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E985F49E;
        Thu,  5 Jan 2023 10:39:05 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-14fb7fdb977so37217913fac.12;
        Thu, 05 Jan 2023 10:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N0AB2x4qCilYXNN66qpiEjklcJr+ewmZBA/9Mtvh7+Y=;
        b=I4ymJC1LD9APlEXUMwtIT5TECUDlW7u6vpX4qge/EmRQCdkmAn1/3oUo+qWYty0Jl3
         hpoVUsUfASLZibDOcVc3ATfFV6UXHb4bd8N2mplIrS2KAKUtiM/OHl1TGgaWwVCu7Ewo
         E3thvCUbT5deEYkDzGiwVRnXFcJADeFJ6x6iRlyJ0DWFnjZiTuhOpVqSh3L7CbqeBcc9
         AAP2lOCt2xwkPAa73EC5hAn64oI4y98ZRvAQtOCwUV8iS1wSTbjc5J1bWX3cWk1bWNrb
         hZnrtafaaFAjqk5B+5WK9KePsCJjrB1q8wtPwu6y5U079El0JREX790ToHxPEaQvdLUC
         hZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0AB2x4qCilYXNN66qpiEjklcJr+ewmZBA/9Mtvh7+Y=;
        b=nOH1zMfbMcVX6bSC/HVmZU6TNgvO4YLdEqH2GepD+xGbVoY/Z+5Rympy22l5vJqVKD
         4o6FUKmsgmqIbt9cwHjaQ5Nm7u7fVD4grudRm8UNh4iNKCOvF8hMCVPQQDZvXorbxwcp
         PfxltPikrE9FB4SHoXL8a+j/thIHSLaSMaG4FCLG8Nbo7B1Ea2UwGGYIXSh9bNwMkepJ
         mxSWWuKE+S455x2RyVMlonA2+c8iKGt90MiBJxbFGwvybH5ri8zOw1Kc70tL7HF+07ff
         eYsy77/FhT7hvG487sUyMWePS8Gd82RHZcFL7MAYwpAakd/D7/jU3QkhsumFk2mMOfyk
         E3SQ==
X-Gm-Message-State: AFqh2kouzwqJpBjPoG2Xrc5gTXGa5LVTPkIQ2rHOv8gvg47I2ndCtOWm
        KCL7TYeTkLxfJk4aj/fc9AMnPpNdumf2Cfzt2iU=
X-Google-Smtp-Source: AMrXdXsdMfEt5J885g1j3Ot5GIl62/nRUiRrClg26yZH58s7d8RhcsuMZq2Q3v4IZVgAMMy7VsYYTksCGBjAyZF+/Gg=
X-Received: by 2002:a05:6870:1706:b0:144:dffd:8302 with SMTP id
 h6-20020a056870170600b00144dffd8302mr4104835oae.146.1672943945260; Thu, 05
 Jan 2023 10:39:05 -0800 (PST)
MIME-Version: 1.0
References: <20221230063528.41037-1-zh.nvgt@gmail.com> <2711de96-fcbe-5611-657a-ab29becd2ff6@gmx.de>
 <CAKMK7uEOX5n64cjzMt9GRQaS13HFPFyOeqdrkmzc035U5_T8tg@mail.gmail.com> <CAKMK7uE7CAXO50JPQ6ziQGGehqfDK2UanBQbfLdUH2RwrwXUvw@mail.gmail.com>
In-Reply-To: <CAKMK7uE7CAXO50JPQ6ziQGGehqfDK2UanBQbfLdUH2RwrwXUvw@mail.gmail.com>
From:   Hang Zhang <zh.nvgt@gmail.com>
Date:   Thu, 5 Jan 2023 13:38:54 -0500
Message-ID: <CAO2zrtYDcOfvxpG6wPghPnWZVks+NL6N9VaynsBVoX7nHBcxuw@mail.gmail.com>
Subject: Re: [PATCH] fbmem: prevent potential use-after-free issues with console_lock()
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 5, 2023 at 5:25 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Thu, 5 Jan 2023 at 11:21, Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > Hi Helge
> >
> > On Mon, 2 Jan 2023 at 16:28, Helge Deller <deller@gmx.de> wrote:
> > >
> > > On 12/30/22 07:35, Hang Zhang wrote:
> > > > In do_fb_ioctl(), user specified "fb_info" can be freed in the callee
> > > > fbcon_get_con2fb_map_ioctl() -> set_con2fb_map() ->
> > > > con2fb_release_oldinfo(), this free operation is protected by
> > > > console_lock() in fbcon_set_con2fb_map_ioctl(), it also results in
> > > > the change of certain states such as "minfo->dead" in matroxfb_remove(),
> > > > so that it can be checked to avoid use-after-free before the use sites
> > > > (e.g., the check at the beginning of matroxfb_ioctl()). However,
> > > > the problem is that the use site is not protected by the same locks
> > > > as for the free operation, e.g., "default" case in do_fb_ioctl()
> > > > can lead to "matroxfb_ioctl()" but it's not protected by console_lock(),
> > > > which can invalidate the aforementioned state set and check in a
> > > > concurrent setting.
> > > >
> > > > Prevent the potential use-after-free issues by protecting the "default"
> > > > case in do_fb_ioctl() with console_lock(), similarly as for many other
> > > > cases like "case FBIOBLANK" and "case FBIOPAN_DISPLAY".
> > > >
> > > > Signed-off-by: Hang Zhang <zh.nvgt@gmail.com>
> > >
> > > applied to fbdev git tree.
> >
> > The patch above makes no sense at all to me:
> >
> > - fb_info is protected by lock_fb_info and
> > - the lifetime of fb_info is protected by the get/put functions
> > - yes there's the interaction with con2fb, which is protected by
> > console_lock, but the lifetime guarantees are ensured by the device
> > removal
> > - which means any stuff happening in matroxfb_remove is also not a
> > concern here (unless matroxfb completely gets all the device lifetime
> > stuff wrong, but it doesn't look like it's any worse than any of the
> > other fbdev drivers that we haven't recently fixed up due to the
> > takeover issues with firmware drivers
>
> I have also a really hard timing finding the con2fb map use in the
> matroxfb ioctl code, but that just might be that I didn't look
> carefully enough. Maybe that would shed some light on this.
> -Daniel
>
>
> >
> > On the very clear downside this now means we take console_lock for the
> > vblank ioctl (which is a device driver extension for reasons, despite
> > that it's a standard fbdev ioctl), which is no good at all given how
> > console_lock() is a really expensive lock.
> >
> > Unless I'm massively missing something, can you pls push the revert
> > before this lands in Linus' tree?
> >
> > Thanks, Daniel

Hi, Daniel. Thank you for your feedback. We're not developers of the
video subsystem and thus may be short in domain knowledge (e.g., the
performance of console_lock() and the complex lifetime management).
This patch initially intended to bring up the potential use-after-free
issues here to the community - we have performed a best-effort code
review and cannot exclude the possibility based on our understanding.

What we have observed is that the call chain leading to the free site
(do_fb_ioctl()->fbcon_set_con2fb_map_ioctl()->set_con2fb_map()->
con2fb_release_oldinfo()-> ... ->matroxfb_remove()) is only protected
by console_lock() but not lock_fb_info(), while the potential use
site (call chain starts from the default case in do_fb_ioctl()) is
only protected by lock_fb_info() but not console_lock().
We thus propose to add this extra console_lock() to the default case,
which is inspired by the lock protection of many other existing
switch-case terms in the same function.

Since we do not have deep domain knowledge of this subsystem, we will
rely on the developers to make a decision regarding the patch. Thank
you again for your review and help!

Best,
Hang

> >
> > > Thanks,
> > > Helge
> > >
> > > > ---
> > > >   drivers/video/fbdev/core/fbmem.c | 2 ++
> > > >   1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> > > > index 1e70d8c67653..8b1a1527d18a 100644
> > > > --- a/drivers/video/fbdev/core/fbmem.c
> > > > +++ b/drivers/video/fbdev/core/fbmem.c
> > > > @@ -1182,6 +1182,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
> > > >               console_unlock();
> > > >               break;
> > > >       default:
> > > > +             console_lock();
> > > >               lock_fb_info(info);
> > > >               fb = info->fbops;
> > > >               if (fb->fb_ioctl)
> > > > @@ -1189,6 +1190,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
> > > >               else
> > > >                       ret = -ENOTTY;
> > > >               unlock_fb_info(info);
> > > > +             console_unlock();
> > > >       }
> > > >       return ret;
> > > >   }
> > >
> >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
>
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
