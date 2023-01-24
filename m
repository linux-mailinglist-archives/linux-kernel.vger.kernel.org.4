Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA28D679B1D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbjAXOHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbjAXOH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:07:28 -0500
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62082118;
        Tue, 24 Jan 2023 06:07:27 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id x36so18334283ede.13;
        Tue, 24 Jan 2023 06:07:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vhqNjsUMR/wQl2JOVYvrO/As/K1uYd+JaqmxQNnVzYo=;
        b=WRYARnClHI62qwBps2luvVY4ZdhzqAqp45y0vHOOlF2Vl2afRYURgPerEABnKKpNkP
         hg8ApiQmmLXMRO/5i1KiXi6738OFv6yQilKWawLRf3mwvj0osL99RC6pweiT4OTdAp38
         mFhxuGHkmowjWuaCCJNcMie8GkP74Yw5CMsxrTLnL4ROS1Wv5QcWyzrBSKofEbaTouN6
         2LF0OXv42hnG7PgliWlsw6z9bPOfl+/iBZt3J6azz6hs6ryMxFJlsDRQ8jbRTraD8tTr
         QNzSOQ9Sl02TG0netTU08IqE8qPc3c5kmE7ZUgWZddVjEdcnDLfx7sg0rHcg4H3ZW1Vs
         56AA==
X-Gm-Message-State: AFqh2kpDNrUOUNQ2Zfs0p51cSApc/oNTGHdV3WMMCmFYAT8Uicc68Fum
        vC9MeVxqLTrUAdK0LJsmLe9yFiePO5mUnF3I+6StcpD6xvE=
X-Google-Smtp-Source: AMrXdXtdK6EczqynYVUM/iCe1GvKWGH4VnuUKio0M21NBoKvI9VVetXeNd5n0Vt6s2fx5DfQtDzFk/jjfghUK7XZ9yg=
X-Received: by 2002:a05:6402:5023:b0:49e:3526:5671 with SMTP id
 p35-20020a056402502300b0049e35265671mr3836064eda.22.1674569246383; Tue, 24
 Jan 2023 06:07:26 -0800 (PST)
MIME-Version: 1.0
References: <20221215181848.129326-1-helgaas@kernel.org> <CAMuHMdUuPKyMDwAHvUxC_s-Cqv_aui=1+eHCMypkpQSmvz=uuQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUuPKyMDwAHvUxC_s-Cqv_aui=1+eHCMypkpQSmvz=uuQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 24 Jan 2023 15:07:14 +0100
Message-ID: <CAJZ5v0jaFsGc23pNVumxnA955PtGpJjry07CU+2eMJEx=CDw4A@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: Simplify __rpm_get_callback()
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
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

On Tue, Jan 24, 2023 at 12:20 PM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Bjorn,
>
> On Thu, Dec 15, 2022 at 7:23 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > Simplify __rpm_get_callback() slightly by returning as soon as the return
> > value is known.  No functional change intended.
> >
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
> Thanks for your patch, which is now commit 650bdddb6b311705 ("PM:
> runtime: Simplify __rpm_get_callback()") in pm/linux-next.
>
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -20,8 +20,7 @@ typedef int (*pm_callback_t)(struct device *);
> >
> >  static pm_callback_t __rpm_get_callback(struct device *dev, size_t cb_offset)
> >  {
> > -       pm_callback_t cb;
> > -       const struct dev_pm_ops *ops;
> > +       const struct dev_pm_ops *ops = NULL;
> >
> >         if (dev->pm_domain)
> >                 ops = &dev->pm_domain->ops;
> > @@ -31,18 +30,14 @@ static pm_callback_t __rpm_get_callback(struct device *dev, size_t cb_offset)
> >                 ops = dev->class->pm;
> >         else if (dev->bus && dev->bus->pm)
> >                 ops = dev->bus->pm;
> > -       else
> > -               ops = NULL;
> >
> >         if (ops)
> > -               cb = *(pm_callback_t *)((void *)ops + cb_offset);
> > -       else
> > -               cb = NULL;
> > +               return *(pm_callback_t *)((void *)ops + cb_offset);
>
> This is a change in behavior in case the callback turns out to be NULL:
>   - before, it would fall back to the driver-specific callback below,
>   - after, it always returns NULL.

Good point and sorry for missing this!

> >
> > -       if (!cb && dev->driver && dev->driver->pm)
> > -               cb = *(pm_callback_t *)((void *)dev->driver->pm + cb_offset);
> > +       if (dev->driver && dev->driver->pm)
> > +               return *(pm_callback_t *)((void *)dev->driver->pm + cb_offset);
> >
> > -       return cb;
> > +       return NULL;
> >  }
>

Something like the patch below (modulo gmail-induced whitespace
breakage) should restore the previous behavior if I'm not mistaken:

---
 drivers/base/power/runtime.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/base/power/runtime.c
===================================================================
--- linux-pm.orig/drivers/base/power/runtime.c
+++ linux-pm/drivers/base/power/runtime.c
@@ -31,8 +31,13 @@ static pm_callback_t __rpm_get_callback(
     else if (dev->bus && dev->bus->pm)
         ops = dev->bus->pm;

-    if (ops)
-        return *(pm_callback_t *)((void *)ops + cb_offset);
+    if (ops) {
+        pm_callback_t cb;
+
+        cb = *(pm_callback_t *)((void *)ops + cb_offset);
+        if (cb)
+            return cb;
+    }

     if (dev->driver && dev->driver->pm)
         return *(pm_callback_t *)((void *)dev->driver->pm + cb_offset);
