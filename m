Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321656B0303
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjCHJfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjCHJfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:35:05 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08DB97FDE;
        Wed,  8 Mar 2023 01:35:03 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id h17-20020a17090aea9100b0023739b10792so1330092pjz.1;
        Wed, 08 Mar 2023 01:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678268103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIp47ayWe59+VWKhH9jfCtYK/GFGqKCWyjnngDque6c=;
        b=Cc+E1Uks3GPCBi+uVQ8Q1bxA242495kRlYnjygJIcW0ttuukBE0hKfF/G4HtH0HGcw
         ZSLSv3maU9K8fpsnB/lasDILBMu+G66n2g28h8UzQLfYaVtRE/v9BpJumos/l+xT0QSg
         EXyKUlKn8IjZvK1CTaNIOI/O52HtQ0PEAlbcOBfjUrOyPuuW6qkh6//4YZSLROGOB62o
         FcrwecFPUocDjdxj4BEWrjdFLGV3eWfpzdygoyrp7LQFhgOMNw9Fbb6zObt/VK7hnvCo
         7bEyGflDAFixQfiteufSq2mu0o8ayAxucG6cpIGSMTxSCox6m8vnOMTIl3HVvsYAddbz
         OhTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678268103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CIp47ayWe59+VWKhH9jfCtYK/GFGqKCWyjnngDque6c=;
        b=i0csjnuQUYW2WIE/Mxd0z8XjnowBAdW5ZtqwWm5EmPdOcjtanE685uNdqK1LfLa7rL
         ODm0d9TBu0V4kxv8nTkGj0f6x8CqlFluF+3O780bCr6YBNNP4Cd+KiNsHO29O7PG5clw
         QnggCUoXnmQH3XwF+GG1SmPKJr0FKrwjknQCu8gYx29OckVWBIoovxflZXyUtDK9KXZZ
         5I6jnY24LF6YM4XA9MW7Ll2Gi2f8Lb4fyqP2yUsZ8y0fSvpYaSh4joNVzjorG/1QkDAp
         YJDqqjDC11Mu4LYjGsAzhLwsMsFWu5XXSI3iICEMFRBSsLTyMRGKcJ4PaygRTrFg2RBV
         gp8g==
X-Gm-Message-State: AO0yUKWMkaOAvSGyXjBOnfLEMlY19ti5HLzidYUAgdXzzm1zTc4bwPHa
        jZ25thBfOxyM+f0t2JOV6PgXcOxrgTpd773gqcQ=
X-Google-Smtp-Source: AK7set+g9/JXVrtZuGiSSDbXHvja+DfYo0/TVYxq59r9hAEn3FcwO4JpGiYOFO8cgm5MHGSE0G+q3mCbuRrCnu4w3+0=
X-Received: by 2002:a17:902:ab45:b0:19b:e4c:2039 with SMTP id
 ij5-20020a170902ab4500b0019b0e4c2039mr7130742plb.4.1678268103137; Wed, 08 Mar
 2023 01:35:03 -0800 (PST)
MIME-Version: 1.0
References: <20230308063628.15233-1-tiwai@suse.de> <CAMeQTsYSgXm=Sku99USE+Up+uuJHUFdE8zPj7_B=BUi5SH=6KQ@mail.gmail.com>
 <87v8jbhag1.wl-tiwai@suse.de>
In-Reply-To: <87v8jbhag1.wl-tiwai@suse.de>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Wed, 8 Mar 2023 10:34:51 +0100
Message-ID: <CAMeQTsYuD=umBxom7yha89ZS2GtuapEua28Uo+K1Wb1ApKKT6Q@mail.gmail.com>
Subject: Re: [PATCH] fbdev: Fix incorrect page mapping clearance at fb_deferred_io_release()
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-fbdev@vger.kernel.org, Miko Larsson <mikoxyzzz@gmail.com>,
        Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Patrik Jakobsson <pjakobsson@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 8, 2023 at 10:14=E2=80=AFAM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Wed, 08 Mar 2023 10:08:24 +0100,
> Patrik Jakobsson wrote:
> >
> > On Wed, Mar 8, 2023 at 7:36=E2=80=AFAM Takashi Iwai <tiwai@suse.de> wro=
te:
> > >
> > > The recent fix for the deferred I/O by the commit
> > >   3efc61d95259 ("fbdev: Fix invalid page access after closing deferre=
d I/O devices")
> > > caused a regression when the same fb device is opened/closed while
> > > it's being used.  It resulted in a frozen screen even if something
> > > is redrawn there after the close.  The breakage is because the patch
> > > was made under a wrong assumption of a single open; in the current
> > > code, fb_deferred_io_release() cleans up the page mapping of the
> > > pageref list and it calls cancel_delayed_work_sync() unconditionally,
> > > where both are no correct behavior for multiple opens.
> > >
> > > This patch adds a refcount for the opens of the device, and applies
> > > the cleanup only when all files get closed.
> > >
> > > Fixes: 3efc61d95259 ("fbdev: Fix invalid page access after closing de=
ferred I/O devices")
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > ---
> > >  drivers/video/fbdev/core/fb_defio.c | 16 +++++++++++++---
> > >  include/linux/fb.h                  |  1 +
> > >  2 files changed, 14 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbde=
v/core/fb_defio.c
> > > index aa5f059d0222..9dcec9e020b6 100644
> > > --- a/drivers/video/fbdev/core/fb_defio.c
> > > +++ b/drivers/video/fbdev/core/fb_defio.c
> > > @@ -305,17 +305,19 @@ void fb_deferred_io_open(struct fb_info *info,
> > >                          struct inode *inode,
> > >                          struct file *file)
> > >  {
> > > +       struct fb_deferred_io *fbdefio =3D info->fbdefio;
> > > +
> > >         file->f_mapping->a_ops =3D &fb_deferred_io_aops;
> > > +       fbdefio->opens++;
> > >  }
> > >  EXPORT_SYMBOL_GPL(fb_deferred_io_open);
> > >
> > > -void fb_deferred_io_release(struct fb_info *info)
> > > +static void fb_deferred_io_release_internal(struct fb_info *info)
> >
> > Maybe a better name would be fb_deferred_io_lastclose() to be more in
> > line with DRM?
>
> Sounds good.
>
> > >  {
> > >         struct fb_deferred_io *fbdefio =3D info->fbdefio;
> > >         struct page *page;
> > >         int i;
> > >
> > > -       BUG_ON(!fbdefio);
> >
> > Should the BUG_ON be put back into fb_deferred_io_release()?
>
> It can be, but honestly speaking, such a BUG_ON() is utterly useless.
> It should be WARN_ON() and return, if the sanity check is inevitably
> needed.

I agree. It's rather pointless since it's already checked in fb_release().

>
> > >         cancel_delayed_work_sync(&info->deferred_work);
> > >
> > >         /* clear out the mapping that we setup */
> > > @@ -324,13 +326,21 @@ void fb_deferred_io_release(struct fb_info *inf=
o)
> > >                 page->mapping =3D NULL;
> > >         }
> > >  }
> > > +
> > > +void fb_deferred_io_release(struct fb_info *info)
> > > +{
> > > +       struct fb_deferred_io *fbdefio =3D info->fbdefio;
> > > +
> > > +       if (!--fbdefio->opens)
> > > +               fb_deferred_io_release_internal(info);
> >
> > I think this can race so we need locking.
>
> This one is fine, as it's always called inside the fb lock in the
> caller side.  Maybe worth to comment in the code.

Ah, yes, fb_release() locks around everything. Then we are fine. A
comment would be nice.

>
> > > +}
> > >  EXPORT_SYMBOL_GPL(fb_deferred_io_release);
> > >
> > >  void fb_deferred_io_cleanup(struct fb_info *info)
> > >  {
> > >         struct fb_deferred_io *fbdefio =3D info->fbdefio;
> > >
> > > -       fb_deferred_io_release(info);
> > > +       fb_deferred_io_release_internal(info);
> > >
> > >         kvfree(info->pagerefs);
> > >         mutex_destroy(&fbdefio->lock);
> > > diff --git a/include/linux/fb.h b/include/linux/fb.h
> > > index d8d20514ea05..29674a29d1c4 100644
> > > --- a/include/linux/fb.h
> > > +++ b/include/linux/fb.h
> > > @@ -212,6 +212,7 @@ struct fb_deferred_io {
> > >         /* delay between mkwrite and deferred handler */
> > >         unsigned long delay;
> > >         bool sort_pagereflist; /* sort pagelist by offset */
> > > +       int opens; /* number of opened files */
> >
> > I would prefer the name num_opens (or open_count as in DRM) instead of
> > opens since it can be interpreted as a verb.
>
> I don't mind either way.  I'd choose the latter.
>
> > Also, don't we need it to be atomic_t?
>
> It's always in the fb lock, so that should be fine with the standard
> int.

Yes

>
>
> thanks,
>
> Takashi
