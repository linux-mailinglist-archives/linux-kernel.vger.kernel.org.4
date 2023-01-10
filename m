Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF3766412E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238591AbjAJNEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238589AbjAJNER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:04:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BBC53735
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:04:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC88061700
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:04:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567AEC433EF;
        Tue, 10 Jan 2023 13:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673355855;
        bh=/OtNMKf5MsJ6LGPoZ5UkfpwOMcQUsnLqREuwXWSZR5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O59H0EYRoEXtiAEWXmxLL7kFwiPozwWl0hpLefwj4SHVk/470Rs+rjXz8MehmRnrY
         8plaVanC3A6W0DBkpUUPXIgcMIrRzPqlT5Yyz3Kh9FApjJKQq3iHlXc9fZInvl8Ys5
         2/eVwe34Hulaq57xTHXVJm8o+/ZpOXIwNY/pjDxE=
Date:   Tue, 10 Jan 2023 14:04:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] driver core: bus: move bus notifier logic into bus.c
Message-ID: <Y71iSTMgO2i5cShl@kroah.com>
References: <20230110124256.1663859-1-gregkh@linuxfoundation.org>
 <20230110124256.1663859-2-gregkh@linuxfoundation.org>
 <CAJZ5v0gmG98awEVCU_TDK1kkuM6z6DQfRtGZGuKfj3oWpomgEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gmG98awEVCU_TDK1kkuM6z6DQfRtGZGuKfj3oWpomgEg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 01:55:51PM +0100, Rafael J. Wysocki wrote:
> On Tue, Jan 10, 2023 at 1:43 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > The logic to touch the bus notifier was open-coded in numberous places
> > in the driver core.  Clean that up by creating a local bus_notify()
> > function and have everyone call this function instead, making the
> > reading of the caller code simpler and easier to maintain over time.
> >
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/base/base.h |  1 +
> >  drivers/base/bus.c  |  8 ++++++++
> >  drivers/base/core.c | 13 +++----------
> >  drivers/base/dd.c   | 28 +++++++---------------------
> >  4 files changed, 19 insertions(+), 31 deletions(-)
> >
> > diff --git a/drivers/base/base.h b/drivers/base/base.h
> > index 7d4803c03d3e..2e08258ce82e 100644
> > --- a/drivers/base/base.h
> > +++ b/drivers/base/base.h
> > @@ -130,6 +130,7 @@ struct kobject *virtual_device_parent(struct device *dev);
> >  extern int bus_add_device(struct device *dev);
> >  extern void bus_probe_device(struct device *dev);
> >  extern void bus_remove_device(struct device *dev);
> > +void bus_notify(struct device *dev, enum bus_notifier_event value);
> >
> >  extern int bus_add_driver(struct device_driver *drv);
> >  extern void bus_remove_driver(struct device_driver *drv);
> > diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> > index 428c26c6b615..cf1b8f00b4c0 100644
> > --- a/drivers/base/bus.c
> > +++ b/drivers/base/bus.c
> > @@ -850,6 +850,14 @@ int bus_unregister_notifier(struct bus_type *bus, struct notifier_block *nb)
> >  }
> >  EXPORT_SYMBOL_GPL(bus_unregister_notifier);
> >
> > +void bus_notify(struct device *dev, enum bus_notifier_event value)
> > +{
> > +       struct bus_type *bus = dev->bus;
> > +
> > +       if (bus)
> > +               blocking_notifier_call_chain(&bus->p->bus_notifier, value, dev);
> 
> I'm not sure if the local var is really helpful.  Personally, I
> wouldn't use it, but anyway
> 
> Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

It will be helpful in the next set of patches I send out for this file
where I work to make all 'struct bus_type' variables in the kernel
constant so they can go into read-only memory.  Right now there are only
2 variables that we actually write to in the structure, one will move
out to the private field and then the private pointer can go away as we
already keep the reference in a different way.  This will also fix up
some layering violations that I know the platform driver code has, odds
are it's in other parts of the kernel too that will be unearthed over
time.

Sorry for not making that more obvious, that patch series it not yet
finished, more to come over the next few weeks...

thanks for the reviews of these patches!

greg k-h
