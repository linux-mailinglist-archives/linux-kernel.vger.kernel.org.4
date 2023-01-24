Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF3B679C1A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbjAXOiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233939AbjAXOiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:38:10 -0500
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20B91BF2;
        Tue, 24 Jan 2023 06:37:51 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id x4so17317986ybp.1;
        Tue, 24 Jan 2023 06:37:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fwQfABfjeUpAENjvZS1Bzp2l/oFZWuf9OyqZm9wvBas=;
        b=ZzZR7L8fiD6YcAE7qKBa2/A6NUxjN+DrzmAFSoIYXQIEj6gBtAtCB4HmOBlQl8eGj8
         PL/OmRwwEfy9kPX0A7rzZ+L8nyGkkKwe7wj0seehgPDhvtlT50AjzbuAp37hVgu6CX34
         4LKmtLiXtLNx3gydVQpw70OXg70O55jC5UJGTn1DQV3+8kJMma1FHgVCGwlNljpxh5D3
         YW9hvkIl8PYfmDTNMcw9f5dsmBy+oYoeQ0jzSxVxtImCybR1FjrU9SCsHNEZAK4r77zL
         Vqm+YSWL9bN2QLTebVfEBxMMfC2hlL0455VJCLUfW2GUz+uPXqJnze2J2vBBbt/2xYAf
         4HWw==
X-Gm-Message-State: AFqh2kqKap9o7TgGIYSS1N14vdqNacd0E/srUm3HyzgiCOhsE374rZAc
        oUXiWdoYRv1yInBReIh2jWCj+fFf+a7IFw==
X-Google-Smtp-Source: AMrXdXsfhmnJBXFIpMWrzBVwBnsCiSV2sT1O2ffB00DL/nq9QVFHKd5uf/B5U0tuPC6yxrNjJxnZQA==
X-Received: by 2002:a05:6902:1406:b0:706:f09b:5297 with SMTP id z6-20020a056902140600b00706f09b5297mr39143664ybu.12.1674571070643;
        Tue, 24 Jan 2023 06:37:50 -0800 (PST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id k6-20020a05620a0b8600b00705b4001fbasm1456516qkh.128.2023.01.24.06.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 06:37:50 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-506609635cbso6046507b3.4;
        Tue, 24 Jan 2023 06:37:50 -0800 (PST)
X-Received: by 2002:a05:690c:851:b0:480:fa10:459e with SMTP id
 bz17-20020a05690c085100b00480fa10459emr2280374ywb.283.1674571069883; Tue, 24
 Jan 2023 06:37:49 -0800 (PST)
MIME-Version: 1.0
References: <20221215181848.129326-1-helgaas@kernel.org> <CAMuHMdUuPKyMDwAHvUxC_s-Cqv_aui=1+eHCMypkpQSmvz=uuQ@mail.gmail.com>
 <CAJZ5v0jaFsGc23pNVumxnA955PtGpJjry07CU+2eMJEx=CDw4A@mail.gmail.com>
In-Reply-To: <CAJZ5v0jaFsGc23pNVumxnA955PtGpJjry07CU+2eMJEx=CDw4A@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 24 Jan 2023 15:37:38 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVRnAVtff2ZrYzf4VGfhTPrUXmn+8o5NyXopLQFm4HuMQ@mail.gmail.com>
Message-ID: <CAMuHMdVRnAVtff2ZrYzf4VGfhTPrUXmn+8o5NyXopLQFm4HuMQ@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: Simplify __rpm_get_callback()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Tue, Jan 24, 2023 at 3:18 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Tue, Jan 24, 2023 at 12:20 PM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> >
> > Hi Bjorn,
> >
> > On Thu, Dec 15, 2022 at 7:23 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > From: Bjorn Helgaas <bhelgaas@google.com>
> > >
> > > Simplify __rpm_get_callback() slightly by returning as soon as the return
> > > value is known.  No functional change intended.
> > >
> > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> >
> > Thanks for your patch, which is now commit 650bdddb6b311705 ("PM:
> > runtime: Simplify __rpm_get_callback()") in pm/linux-next.
> >
> > > --- a/drivers/base/power/runtime.c
> > > +++ b/drivers/base/power/runtime.c
> > > @@ -20,8 +20,7 @@ typedef int (*pm_callback_t)(struct device *);
> > >
> > >  static pm_callback_t __rpm_get_callback(struct device *dev, size_t cb_offset)
> > >  {
> > > -       pm_callback_t cb;
> > > -       const struct dev_pm_ops *ops;
> > > +       const struct dev_pm_ops *ops = NULL;
> > >
> > >         if (dev->pm_domain)
> > >                 ops = &dev->pm_domain->ops;
> > > @@ -31,18 +30,14 @@ static pm_callback_t __rpm_get_callback(struct device *dev, size_t cb_offset)
> > >                 ops = dev->class->pm;
> > >         else if (dev->bus && dev->bus->pm)
> > >                 ops = dev->bus->pm;
> > > -       else
> > > -               ops = NULL;
> > >
> > >         if (ops)
> > > -               cb = *(pm_callback_t *)((void *)ops + cb_offset);
> > > -       else
> > > -               cb = NULL;
> > > +               return *(pm_callback_t *)((void *)ops + cb_offset);
> >
> > This is a change in behavior in case the callback turns out to be NULL:
> >   - before, it would fall back to the driver-specific callback below,
> >   - after, it always returns NULL.
>
> Good point and sorry for missing this!
>
> > >
> > > -       if (!cb && dev->driver && dev->driver->pm)
> > > -               cb = *(pm_callback_t *)((void *)dev->driver->pm + cb_offset);
> > > +       if (dev->driver && dev->driver->pm)
> > > +               return *(pm_callback_t *)((void *)dev->driver->pm + cb_offset);
> > >
> > > -       return cb;
> > > +       return NULL;
> > >  }
> >
>
> Something like the patch below (modulo gmail-induced whitespace
> breakage) should restore the previous behavior if I'm not mistaken:
>
> ---
>  drivers/base/power/runtime.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> Index: linux-pm/drivers/base/power/runtime.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/runtime.c
> +++ linux-pm/drivers/base/power/runtime.c
> @@ -31,8 +31,13 @@ static pm_callback_t __rpm_get_callback(
>      else if (dev->bus && dev->bus->pm)
>          ops = dev->bus->pm;
>
> -    if (ops)
> -        return *(pm_callback_t *)((void *)ops + cb_offset);
> +    if (ops) {
> +        pm_callback_t cb;
> +
> +        cb = *(pm_callback_t *)((void *)ops + cb_offset);
> +        if (cb)
> +            return cb;
> +    }
>
>      if (dev->driver && dev->driver->pm)
>          return *(pm_callback_t *)((void *)dev->driver->pm + cb_offset);

Which is now more complex than the original?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
