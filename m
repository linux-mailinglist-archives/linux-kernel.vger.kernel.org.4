Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159376790A3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 07:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbjAXGDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 01:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjAXGDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 01:03:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A6E29162;
        Mon, 23 Jan 2023 22:03:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 935E8B81012;
        Tue, 24 Jan 2023 06:03:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8C2C433EF;
        Tue, 24 Jan 2023 06:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674540195;
        bh=Cy73BGSYSI6DnKddy5tVdl8T0Y7C31PI+ZUw4kgG1ew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=njgY2SE5M5U26+ZvWfhPmU7eBHDZshjd1PgcuvXd63+l2RYMvHC3n7MOVqn+qYQf+
         IIg64RzGoc97J9h3bSoEWF9p4vzTX3xuBfM79SCob7TlcbgaRridkwoIrPorTlmoat
         YHyLqjpd4wT/RAnRRbc5WZN9JbqAyWUxzOwbqxGQ=
Date:   Tue, 24 Jan 2023 07:03:12 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v1 2/2] thermal: Fail object registration if thermal
 class is not registered
Message-ID: <Y890oFSRSG4G2kp6@kroah.com>
References: <5905717.lOV4Wx5bFT@kreacher>
 <4780418.GXAFRqVoOG@kreacher>
 <Y8uW374CM37m0/wI@kroah.com>
 <CAJZ5v0heCTm+1sv9taAoMe8PGgLPEzsTxh9ZdOGjdhDLuvc-Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0heCTm+1sv9taAoMe8PGgLPEzsTxh9ZdOGjdhDLuvc-Zw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 09:16:33PM +0100, Rafael J. Wysocki wrote:
> On Sat, Jan 21, 2023 at 8:40 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Jan 20, 2023 at 08:48:07PM +0100, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > If thermal_class is not registered with the driver core, there is no way
> > > to expose the interfaces used by the thermal control framework, so
> > > prevent thermal zones and cooling devices from being registered in
> > > that case by returning an error from object registration functions.
> > >
> > > For this purpose, introduce class_is_registered() that checks the
> > > private pointer of the given class and returns 'false' if it is NULL,
> > > which means that the class has not been registered, and use it in the
> > > thermal framework.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  drivers/thermal/thermal_core.c |    6 ++++++
> > >  include/linux/device/class.h   |    5 +++++
> > >  2 files changed, 11 insertions(+)
> > >
> > > Index: linux-pm/include/linux/device/class.h
> > > ===================================================================
> > > --- linux-pm.orig/include/linux/device/class.h
> > > +++ linux-pm/include/linux/device/class.h
> > > @@ -82,6 +82,11 @@ struct class_dev_iter {
> > >       const struct device_type        *type;
> > >  };
> > >
> > > +static inline bool class_is_registered(struct class *class)
> > > +{
> > > +     return !!class->p;
> >
> > I really do not like this as it is exposing internals to drivers and
> > whenever we do that, it gets abused and we have to unwind the mess in a
> > few years.
> >
> > Overall, I'm trying to remove the ->p usage, but that's a longterm goal
> > of mine (to allow class and bus structures to be in read-only memory),
> > which isn't your issue here, but it's good to think about why you want
> > to know this information (more below.)
> >
> > > +}
> > > +
> > >  extern struct kobject *sysfs_dev_block_kobj;
> > >  extern struct kobject *sysfs_dev_char_kobj;
> > >  extern int __must_check __class_register(struct class *class,
> > > Index: linux-pm/drivers/thermal/thermal_core.c
> > > ===================================================================
> > > --- linux-pm.orig/drivers/thermal/thermal_core.c
> > > +++ linux-pm/drivers/thermal/thermal_core.c
> > > @@ -880,6 +880,9 @@ __thermal_cooling_device_register(struct
> > >           !ops->set_cur_state)
> > >               return ERR_PTR(-EINVAL);
> > >
> > > +     if (!class_is_registered(&thermal_class))
> > > +             return ERR_PTR(-ENODEV);
> >
> > If the class isn't registered, then sommething went wrong with the
> > thermal core code, right?  So why isn't the thermal core keeping a local
> > variable of "class was registered" and relying on the driver core to
> > know this?
> >
> > The number of individual users that should be doing one thing or another
> > if a class is not registered feels very very slim.  How come this code
> > is being called at all if the thermal class was not registered in the
> > first place?  What would have prevented that from happening?  Is it an
> > ordering issue, or a kernel configuration issue?
> 
> It's basically a matter of class_register() returning an error.

Ok, so not a real problem then :)

> Yes, we could use an extra variable for this purpose, but that would
> be a bit wasteful, because thermal_class will then sit unused and
> occupy memory in vain.

How would it retain memory if class_register() failed?

> Oh well, we may as well just allocate it dynamically.

Allocate what?

confused,

greg k-h
