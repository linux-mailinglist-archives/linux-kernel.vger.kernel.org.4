Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBF6679E59
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 17:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbjAXQO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 11:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjAXQOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:14:55 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538132BF23;
        Tue, 24 Jan 2023 08:14:54 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id g16so11400935qtu.2;
        Tue, 24 Jan 2023 08:14:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JX2JBJxQ8wkqLQs9Y080UKEGGFV8tzJcSA1x25jIm98=;
        b=ZTy6MDFsWoLrf7AviSCmOJVym00gpvpWV96kViedjIqDheDmCY1tVtm4kIfLT67lhW
         TRFh7dKwWHQoM/ZPtmqbR7Gu6W6ydj6Rh66FLWFULlmuotbd6FoNWq2EjeZeCN8Mpo/e
         yEwTWp5vQTVQIJ0EVFAQA4yubNy27IyeQoWJSWw4TPR/F5ZJu7CpuhKWCCvVhGNJ9AEh
         JsrdHEZ8M+F8Q+jUqjjm5+G+caraZvUZshIwigyvFxY7B7211iq00KagTndfdVwbOVm9
         F44/3TIajjGxg4pwGr9Ov+NELSshmk8Dh/zdfyMgdRzYaApehz94FzxQfP5hwylAMRme
         iaPw==
X-Gm-Message-State: AFqh2kqF2ztkQpSACOi1vE2UxruYjwQvo/3IRVkP6x95/8aAXO0SYk/b
        z4IWQ/YZrsVmgR5wrdz0pxh9Oc2hOJeUKA==
X-Google-Smtp-Source: AMrXdXvBgAFkrJ9Ra7GbeiDBFmKr3xQHrKX+/h8iWfiLpEVD9H21wt3LrVDRZISI61uPQvJQiD+2eg==
X-Received: by 2002:ac8:7ec2:0:b0:3b4:7efb:36a7 with SMTP id x2-20020ac87ec2000000b003b47efb36a7mr55377748qtj.27.1674576893289;
        Tue, 24 Jan 2023 08:14:53 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id n6-20020ac81e06000000b003b7ea9814b9sm1513687qtl.10.2023.01.24.08.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 08:14:52 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id t16so14827678ybk.2;
        Tue, 24 Jan 2023 08:14:52 -0800 (PST)
X-Received: by 2002:a25:37d4:0:b0:80b:8602:f3fe with SMTP id
 e203-20020a2537d4000000b0080b8602f3femr106304yba.36.1674576892426; Tue, 24
 Jan 2023 08:14:52 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0j4m-=twN3oH-Q_MDHLi-VnktMhFcGbGbGCC-x+0TXM_w@mail.gmail.com>
 <20230124150558.GA1061961@bhelgaas>
In-Reply-To: <20230124150558.GA1061961@bhelgaas>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 24 Jan 2023 17:14:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXjQqC41i5iJPNuOFdMYYgq+DOjaOGBn9uEG6heVCCKfA@mail.gmail.com>
Message-ID: <CAMuHMdXjQqC41i5iJPNuOFdMYYgq+DOjaOGBn9uEG6heVCCKfA@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: Simplify __rpm_get_callback()
To:     Bjorn Helgaas <helgaas@kernel.org>
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

Hi Bjorn,

On Tue, Jan 24, 2023 at 4:06 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Tue, Jan 24, 2023 at 03:45:50PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Jan 24, 2023 at 3:37 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Tue, Jan 24, 2023 at 3:18 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > On Tue, Jan 24, 2023 at 12:20 PM Geert Uytterhoeven
> > > > <geert@linux-m68k.org> wrote:
> > > > > On Thu, Dec 15, 2022 at 7:23 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > > > >
> > > > > > Simplify __rpm_get_callback() slightly by returning as soon as the return
> > > > > > value is known.  No functional change intended.
> > > > > >
> > > > > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > > > >
> > > > > Thanks for your patch, which is now commit 650bdddb6b311705 ("PM:
> > > > > runtime: Simplify __rpm_get_callback()") in pm/linux-next.
> > > > >
> > > > > > --- a/drivers/base/power/runtime.c
> > > > > > +++ b/drivers/base/power/runtime.c
> > > > > > @@ -20,8 +20,7 @@ typedef int (*pm_callback_t)(struct device *);
> > > > > >
> > > > > >  static pm_callback_t __rpm_get_callback(struct device *dev, size_t cb_offset)
> > > > > >  {
> > > > > > -       pm_callback_t cb;
> > > > > > -       const struct dev_pm_ops *ops;
> > > > > > +       const struct dev_pm_ops *ops = NULL;
> > > > > >
> > > > > >         if (dev->pm_domain)
> > > > > >                 ops = &dev->pm_domain->ops;
> > > > > > @@ -31,18 +30,14 @@ static pm_callback_t __rpm_get_callback(struct device *dev, size_t cb_offset)
> > > > > >                 ops = dev->class->pm;
> > > > > >         else if (dev->bus && dev->bus->pm)
> > > > > >                 ops = dev->bus->pm;
> > > > > > -       else
> > > > > > -               ops = NULL;
> > > > > >
> > > > > >         if (ops)
> > > > > > -               cb = *(pm_callback_t *)((void *)ops + cb_offset);
> > > > > > -       else
> > > > > > -               cb = NULL;
> > > > > > +               return *(pm_callback_t *)((void *)ops + cb_offset);
> > > > >
> > > > > This is a change in behavior in case the callback turns out to be NULL:
> > > > >   - before, it would fall back to the driver-specific callback below,
> > > > >   - after, it always returns NULL.
> > > >
> > > > Good point and sorry for missing this!
> > > >
> > > > > >
> > > > > > -       if (!cb && dev->driver && dev->driver->pm)
> > > > > > -               cb = *(pm_callback_t *)((void *)dev->driver->pm + cb_offset);
> > > > > > +       if (dev->driver && dev->driver->pm)
> > > > > > +               return *(pm_callback_t *)((void *)dev->driver->pm + cb_offset);
> > > > > >
> > > > > > -       return cb;
> > > > > > +       return NULL;
> > > > > >  }
> > > > >
> > > >
> > > > Something like the patch below (modulo gmail-induced whitespace
> > > > breakage) should restore the previous behavior if I'm not mistaken:
> > > >
> > > > ---
> > > >  drivers/base/power/runtime.c |    9 +++++++--
> > > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > > >
> > > > Index: linux-pm/drivers/base/power/runtime.c
> > > > ===================================================================
> > > > --- linux-pm.orig/drivers/base/power/runtime.c
> > > > +++ linux-pm/drivers/base/power/runtime.c
> > > > @@ -31,8 +31,13 @@ static pm_callback_t __rpm_get_callback(
> > > >      else if (dev->bus && dev->bus->pm)
> > > >          ops = dev->bus->pm;
> > > >
> > > > -    if (ops)
> > > > -        return *(pm_callback_t *)((void *)ops + cb_offset);
> > > > +    if (ops) {
> > > > +        pm_callback_t cb;
> > > > +
> > > > +        cb = *(pm_callback_t *)((void *)ops + cb_offset);
> > > > +        if (cb)
> > > > +            return cb;
> > > > +    }
> > > >
> > > >      if (dev->driver && dev->driver->pm)
> > > >          return *(pm_callback_t *)((void *)dev->driver->pm + cb_offset);
> > >
> > > Which is now more complex than the original?
> >
> > Arguably so.
> >
> > OK, I'll drop the commit in question then, sorry Bjorn.
>
> Really sorry about this.  Think I'm all out of brown paper bags :(
> Thanks for catching this, Geert, and sorry for all the time you had to

Np, no time was wasted on debugging.
I just noticed because I have some local debug code on top, which no
longer applied 8^)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
