Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2E5679C4D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbjAXOqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjAXOqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:46:04 -0500
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AA8BA;
        Tue, 24 Jan 2023 06:46:03 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id ss4so39504013ejb.11;
        Tue, 24 Jan 2023 06:46:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xM5j0uZ37ZwFA6dbSjXEuwR6b70pSS9hN9lzO/o8Vh0=;
        b=MHCZ1H8z5Zw1i6o5+26OhRZLFShJbfIaATqiKZdvv5Xpw6h3RyBZYD1QQxFCF/qoIg
         9cnVU6tgelHB+d+k7edsjRIW4JhtN46A4fUXgBBPtl/0yhlEuG2wPjxQyANNODPuxDX5
         HvKsWxNRMlmtIB8g3FtJTf7mo2r1plDwmQ+pPHide1P8X6Kf3kUuNy6SspsRtwUR65qk
         J8WhZxz4rpvQfuc7po5VboxhR5ZfU6Gwsbd939YYapullHDYQE3SlFdFUxBtB9aVcnDw
         /F5kEXKy4DAXO5EaOzxEvU387iJs+S0KsSqComKmOxBV55rUTdfigZjeLG7UswIkHp65
         PypQ==
X-Gm-Message-State: AFqh2kpMMPHELVEPOfG84M0X/+KAwA2l2yJL4AOylmJ0/+Bf7YiTKVud
        SeG8/za6kob8rlyAQTsSb2D6CpHanalux1VOmhw=
X-Google-Smtp-Source: AMrXdXvg/uyeR3Li1dzKUe3ORvlIbNdd6UZwtixUIGGLIyvTJakMfwWt6vqrSE02WTTJA8BcbCn5q22+IqqGBM4m7c0=
X-Received: by 2002:a17:906:514:b0:870:6768:ebcb with SMTP id
 j20-20020a170906051400b008706768ebcbmr3417156eja.13.1674571561873; Tue, 24
 Jan 2023 06:46:01 -0800 (PST)
MIME-Version: 1.0
References: <20221215181848.129326-1-helgaas@kernel.org> <CAMuHMdUuPKyMDwAHvUxC_s-Cqv_aui=1+eHCMypkpQSmvz=uuQ@mail.gmail.com>
 <CAJZ5v0jaFsGc23pNVumxnA955PtGpJjry07CU+2eMJEx=CDw4A@mail.gmail.com> <CAMuHMdVRnAVtff2ZrYzf4VGfhTPrUXmn+8o5NyXopLQFm4HuMQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVRnAVtff2ZrYzf4VGfhTPrUXmn+8o5NyXopLQFm4HuMQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 24 Jan 2023 15:45:50 +0100
Message-ID: <CAJZ5v0j4m-=twN3oH-Q_MDHLi-VnktMhFcGbGbGCC-x+0TXM_w@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: Simplify __rpm_get_callback()
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 3:37 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Rafael,
>
> On Tue, Jan 24, 2023 at 3:18 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Tue, Jan 24, 2023 at 12:20 PM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > >
> > > Hi Bjorn,
> > >
> > > On Thu, Dec 15, 2022 at 7:23 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > >
> > > > Simplify __rpm_get_callback() slightly by returning as soon as the return
> > > > value is known.  No functional change intended.
> > > >
> > > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > >
> > > Thanks for your patch, which is now commit 650bdddb6b311705 ("PM:
> > > runtime: Simplify __rpm_get_callback()") in pm/linux-next.
> > >
> > > > --- a/drivers/base/power/runtime.c
> > > > +++ b/drivers/base/power/runtime.c
> > > > @@ -20,8 +20,7 @@ typedef int (*pm_callback_t)(struct device *);
> > > >
> > > >  static pm_callback_t __rpm_get_callback(struct device *dev, size_t cb_offset)
> > > >  {
> > > > -       pm_callback_t cb;
> > > > -       const struct dev_pm_ops *ops;
> > > > +       const struct dev_pm_ops *ops = NULL;
> > > >
> > > >         if (dev->pm_domain)
> > > >                 ops = &dev->pm_domain->ops;
> > > > @@ -31,18 +30,14 @@ static pm_callback_t __rpm_get_callback(struct device *dev, size_t cb_offset)
> > > >                 ops = dev->class->pm;
> > > >         else if (dev->bus && dev->bus->pm)
> > > >                 ops = dev->bus->pm;
> > > > -       else
> > > > -               ops = NULL;
> > > >
> > > >         if (ops)
> > > > -               cb = *(pm_callback_t *)((void *)ops + cb_offset);
> > > > -       else
> > > > -               cb = NULL;
> > > > +               return *(pm_callback_t *)((void *)ops + cb_offset);
> > >
> > > This is a change in behavior in case the callback turns out to be NULL:
> > >   - before, it would fall back to the driver-specific callback below,
> > >   - after, it always returns NULL.
> >
> > Good point and sorry for missing this!
> >
> > > >
> > > > -       if (!cb && dev->driver && dev->driver->pm)
> > > > -               cb = *(pm_callback_t *)((void *)dev->driver->pm + cb_offset);
> > > > +       if (dev->driver && dev->driver->pm)
> > > > +               return *(pm_callback_t *)((void *)dev->driver->pm + cb_offset);
> > > >
> > > > -       return cb;
> > > > +       return NULL;
> > > >  }
> > >
> >
> > Something like the patch below (modulo gmail-induced whitespace
> > breakage) should restore the previous behavior if I'm not mistaken:
> >
> > ---
> >  drivers/base/power/runtime.c |    9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > Index: linux-pm/drivers/base/power/runtime.c
> > ===================================================================
> > --- linux-pm.orig/drivers/base/power/runtime.c
> > +++ linux-pm/drivers/base/power/runtime.c
> > @@ -31,8 +31,13 @@ static pm_callback_t __rpm_get_callback(
> >      else if (dev->bus && dev->bus->pm)
> >          ops = dev->bus->pm;
> >
> > -    if (ops)
> > -        return *(pm_callback_t *)((void *)ops + cb_offset);
> > +    if (ops) {
> > +        pm_callback_t cb;
> > +
> > +        cb = *(pm_callback_t *)((void *)ops + cb_offset);
> > +        if (cb)
> > +            return cb;
> > +    }
> >
> >      if (dev->driver && dev->driver->pm)
> >          return *(pm_callback_t *)((void *)dev->driver->pm + cb_offset);
>
> Which is now more complex than the original?

Arguably so.

OK, I'll drop the commit in question then, sorry Bjorn.
