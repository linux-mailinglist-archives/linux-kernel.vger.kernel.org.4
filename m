Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFDB5F324B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 17:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiJCPFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 11:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiJCPFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 11:05:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EB81400A;
        Mon,  3 Oct 2022 08:05:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 330D661132;
        Mon,  3 Oct 2022 15:05:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F02C433D6;
        Mon,  3 Oct 2022 15:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664809513;
        bh=kQRY7ykuDbE0o51P8UlIlK+aCXBweDG/nc36XgImZeE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2Pp1KEoROdEhqllwvsisChE7fLM6legHZc2Gh55GhMc68DvAEwW6aijJkqREMA5Pi
         FETIXJX5dZEP0im+US1hx67Hg7V2Hqi52BzwhzMVSNV8LcQIbi9YR2sqCRXrMJxd2J
         R9S1y6oRRUuNnYQtO5rJJMNzZ99OvnTaXpWxANhQ=
Date:   Mon, 3 Oct 2022 17:05:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Daniel Scally <djrscally@gmail.com>
Subject: Re: [PATCH v2 1/5] device property: Keep dev_fwnode() and
 dev_fwnode_const() separate
Message-ID: <Yzr6JjXVQTpky6GM@kroah.com>
References: <20220928105746.51208-1-andriy.shevchenko@linux.intel.com>
 <20220928105746.51208-2-andriy.shevchenko@linux.intel.com>
 <YzQqcFZtJn90URrJ@kroah.com>
 <Yzb9nXSxvgJ+Mj6z@paasikivi.fi.intel.com>
 <YzcAh/xtqQM1Qin4@kroah.com>
 <CAJZ5v0hHPjSN-369pagN3Mnxd1yvc6+4YGb0Kpx3=+aahV=AmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hHPjSN-369pagN3Mnxd1yvc6+4YGb0Kpx3=+aahV=AmQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 01:54:37PM +0200, Rafael J. Wysocki wrote:
> On Fri, Sep 30, 2022 at 4:43 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Sep 30, 2022 at 02:30:53PM +0000, Sakari Ailus wrote:
> > > Hi Greg,
> > >
> > > On Wed, Sep 28, 2022 at 01:05:20PM +0200, Greg Kroah-Hartman wrote:
> > > > On Wed, Sep 28, 2022 at 01:57:42PM +0300, Andy Shevchenko wrote:
> > > > > It's not fully correct to take a const parameter pointer to a struct
> > > > > and return a non-const pointer to a member of that struct.
> > > > >
> > > > > Instead, introduce a const version of the dev_fwnode() API which takes
> > > > > and returns const pointers and use it where it's applicable.
> > > > >
> > > > > Suggested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > > Fixes: aade55c86033 ("device property: Add const qualifier to device_get_match_data() parameter")
> > > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > > Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > > > Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > > ---
> > > > >  drivers/base/property.c  | 11 +++++++++--
> > > > >  include/linux/property.h |  3 ++-
> > > > >  2 files changed, 11 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/drivers/base/property.c b/drivers/base/property.c
> > > > > index 4d6278a84868..699f1b115e0a 100644
> > > > > --- a/drivers/base/property.c
> > > > > +++ b/drivers/base/property.c
> > > > > @@ -17,13 +17,20 @@
> > > > >  #include <linux/property.h>
> > > > >  #include <linux/phy.h>
> > > > >
> > > > > -struct fwnode_handle *dev_fwnode(const struct device *dev)
> > > > > +struct fwnode_handle *dev_fwnode(struct device *dev)
> > > > >  {
> > > > >   return IS_ENABLED(CONFIG_OF) && dev->of_node ?
> > > > >           of_fwnode_handle(dev->of_node) : dev->fwnode;
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(dev_fwnode);
> > > > >
> > > > > +const struct fwnode_handle *dev_fwnode_const(const struct device *dev)
> > > > > +{
> > > > > + return IS_ENABLED(CONFIG_OF) && dev->of_node ?
> > > > > +         of_fwnode_handle(dev->of_node) : dev->fwnode;
> > > > > +}
> > > > > +EXPORT_SYMBOL_GPL(dev_fwnode_const);
> > > >
> > > > Ick, no, this is a mess.
> > > >
> > > > Either always return a const pointer, or don't.  Ideally always return a
> > > > const pointer, so all we really need is:
> > > >
> > > > const struct fwnode_handle *dev_fwnode(const struct device *dev);
> > > >
> > > > right?
> > > >
> > > > Yes, it will take some unwinding backwards to get there, but please do
> > > > that instead of having 2 different functions where the parameter type is
> > > > part of the function name.  This isn't the 1980's...
> > >
> > > The problem with this approach is that sometimes non-const fwnode_handles
> > > are needed. On OF, for instance, anything that has something to do with
> > > refcounting requires this. Software nodes as well.
> >
> > If they are writable, then yes, let's keep them writable, and not create
> > two function paths where we have to pick and choose.
> >
> > > One option which I suggested earlier was to turn dev_fwnode() into a macro
> > > and use C11 _Generic() to check whether the device is const or not.
> >
> > As much fun as that would be, I don't think it would work well.
> >
> > Although, maybe it would, have an example of how that would look?
> >
> > I ask as I just went through a large refactoring of the kobject layer to
> > mark many things const * and I find it a bit "sad" that functions like
> > this:
> >         static inline struct device *kobj_to_dev(const struct kobject *kobj)
> >         {
> >                 return container_of(kobj, struct device, kobj);
> >         }
> > have the ability to take a read-only pointer and spit out a writable one
> > thanks to the pointer math in container_of() with no one being the
> > wiser.
> 
> Well, is this really a problem?
> 
> After all, if an immutable structure is embedded in another one, that
> doesn't automatically imply that the containing structure has to be
> immutable too.  Hence, a const pointer to the inner structure doesn't
> automatically yield a const pointer to the outer one.

That is true, but it's a _huge_ hint that we are throwing away here,
sometimes without even really realizing it.

Ideally, if you have a const * passed into container_of() you would get
a const * back, and then, if you _really_ know what you are doing with
it, feel free to cast it away.  That cast would be a huge sign that
"hey, something is happening here" and allow people to at least notice
it, while today, we loose all of that.

Let me play around with this a bit.  In talking with the Rust Linux
developers, a lot of "how do we know if this pointer is immutable or
not" discussions happen.  With many of our apis, right now we don't know
that, and perhaps that should change as it would make things not
necessarily more "safe", but more "obvious" as to what both the intent
is, and what is actually happening to pointers at times.

Especially in the mess that is kobjects and struct device where we cast
pointers around with abandon :)

thanks,

greg k-h
