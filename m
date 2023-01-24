Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B083D679CE6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 16:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbjAXPGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 10:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjAXPGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 10:06:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6841457F6;
        Tue, 24 Jan 2023 07:06:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 606D0B811EC;
        Tue, 24 Jan 2023 15:06:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FE6C433D2;
        Tue, 24 Jan 2023 15:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674572760;
        bh=3OD487aODCZ8O2PP1vtAxHlZb/3WM0trzdY3u9yrrG8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=J/oLt1358Tizyc8ehlgoxAYw1Hf+6RJ71EBM+epLVN87LT32xPep1Tb6KSbRi/dma
         3nlgeyz7AQujCyC9es/yXgmeDoZ5s6sfKWGe+L0s+5zINCv9qssin5qyRf9Y1n+OFE
         20VkXvCCFwRkf7ySFZuUbyT+didImwO/cz0pwHwWTxyJvEGFZ1OY3RzZmhAVAW1x3+
         +QjwwxhE4Ttkut3BE3+sh0w68vEpYRzvVToyDtBU8X/jRltAZWw4yNp6cEU/hfF5yr
         aIixqNnmSbdbSW5RRCwsD8Eh4bE6Owm4yNpdop7Nxr/QhjUgGKyXoBWusnUWAIL/4h
         eQ2nvw3El/2nQ==
Date:   Tue, 24 Jan 2023 09:05:58 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PM: runtime: Simplify __rpm_get_callback()
Message-ID: <20230124150558.GA1061961@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j4m-=twN3oH-Q_MDHLi-VnktMhFcGbGbGCC-x+0TXM_w@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 03:45:50PM +0100, Rafael J. Wysocki wrote:
> On Tue, Jan 24, 2023 at 3:37 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, Jan 24, 2023 at 3:18 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > On Tue, Jan 24, 2023 at 12:20 PM Geert Uytterhoeven
> > > <geert@linux-m68k.org> wrote:
> > > > On Thu, Dec 15, 2022 at 7:23 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > > >
> > > > > Simplify __rpm_get_callback() slightly by returning as soon as the return
> > > > > value is known.  No functional change intended.
> > > > >
> > > > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > > >
> > > > Thanks for your patch, which is now commit 650bdddb6b311705 ("PM:
> > > > runtime: Simplify __rpm_get_callback()") in pm/linux-next.
> > > >
> > > > > --- a/drivers/base/power/runtime.c
> > > > > +++ b/drivers/base/power/runtime.c
> > > > > @@ -20,8 +20,7 @@ typedef int (*pm_callback_t)(struct device *);
> > > > >
> > > > >  static pm_callback_t __rpm_get_callback(struct device *dev, size_t cb_offset)
> > > > >  {
> > > > > -       pm_callback_t cb;
> > > > > -       const struct dev_pm_ops *ops;
> > > > > +       const struct dev_pm_ops *ops = NULL;
> > > > >
> > > > >         if (dev->pm_domain)
> > > > >                 ops = &dev->pm_domain->ops;
> > > > > @@ -31,18 +30,14 @@ static pm_callback_t __rpm_get_callback(struct device *dev, size_t cb_offset)
> > > > >                 ops = dev->class->pm;
> > > > >         else if (dev->bus && dev->bus->pm)
> > > > >                 ops = dev->bus->pm;
> > > > > -       else
> > > > > -               ops = NULL;
> > > > >
> > > > >         if (ops)
> > > > > -               cb = *(pm_callback_t *)((void *)ops + cb_offset);
> > > > > -       else
> > > > > -               cb = NULL;
> > > > > +               return *(pm_callback_t *)((void *)ops + cb_offset);
> > > >
> > > > This is a change in behavior in case the callback turns out to be NULL:
> > > >   - before, it would fall back to the driver-specific callback below,
> > > >   - after, it always returns NULL.
> > >
> > > Good point and sorry for missing this!
> > >
> > > > >
> > > > > -       if (!cb && dev->driver && dev->driver->pm)
> > > > > -               cb = *(pm_callback_t *)((void *)dev->driver->pm + cb_offset);
> > > > > +       if (dev->driver && dev->driver->pm)
> > > > > +               return *(pm_callback_t *)((void *)dev->driver->pm + cb_offset);
> > > > >
> > > > > -       return cb;
> > > > > +       return NULL;
> > > > >  }
> > > >
> > >
> > > Something like the patch below (modulo gmail-induced whitespace
> > > breakage) should restore the previous behavior if I'm not mistaken:
> > >
> > > ---
> > >  drivers/base/power/runtime.c |    9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > >
> > > Index: linux-pm/drivers/base/power/runtime.c
> > > ===================================================================
> > > --- linux-pm.orig/drivers/base/power/runtime.c
> > > +++ linux-pm/drivers/base/power/runtime.c
> > > @@ -31,8 +31,13 @@ static pm_callback_t __rpm_get_callback(
> > >      else if (dev->bus && dev->bus->pm)
> > >          ops = dev->bus->pm;
> > >
> > > -    if (ops)
> > > -        return *(pm_callback_t *)((void *)ops + cb_offset);
> > > +    if (ops) {
> > > +        pm_callback_t cb;
> > > +
> > > +        cb = *(pm_callback_t *)((void *)ops + cb_offset);
> > > +        if (cb)
> > > +            return cb;
> > > +    }
> > >
> > >      if (dev->driver && dev->driver->pm)
> > >          return *(pm_callback_t *)((void *)dev->driver->pm + cb_offset);
> >
> > Which is now more complex than the original?
> 
> Arguably so.
> 
> OK, I'll drop the commit in question then, sorry Bjorn.

Really sorry about this.  Think I'm all out of brown paper bags :(
Thanks for catching this, Geert, and sorry for all the time you had to
spend debugging it.

Bjorn
