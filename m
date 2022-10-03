Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D5A5F2FDF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 13:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJCLy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 07:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiJCLyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 07:54:51 -0400
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1338413DF5;
        Mon,  3 Oct 2022 04:54:50 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id mg6so1449864qvb.10;
        Mon, 03 Oct 2022 04:54:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1lkZFjQAri374KxB7zXDUvCKUxqNzBm83pCNxaD3+Rg=;
        b=ewdLXwwaqREFoIQp5aUf52j5ZFe/t5gFNEhDrB0isigfW90zpDT7wgWgkOvkPiq1Mq
         iYZp9iZj9vBNkRUvFinqU3Mus8PLoi84XdbYjHxGt7WugYujrxEvm7M95SiMwnMRWyha
         bglLJyn/b28PV/z69I0dBioUxERx/LNyVyHiC5KgUbDli9FmVukuv3E876socrAIqwjq
         tx2v1IsnmYDTuoG2eOSpMSVjg8G4FbSqbPQnRlBisz7Vkzq9N6frk35k8Gn+lJJZXHdX
         y0wIY78lu/I3s7ZaLq/aCMnQKXPezq190x1pwQ/LCMDb97N9M3cXjN1JLm9g+lEks89N
         MVyg==
X-Gm-Message-State: ACrzQf3/+acmcBy/3B3iOKqYyFDs6YCL4iz31PqDDXvKfv1o+EpXVl1b
        2MxEICKRFnlqa30ffRvIhYzLLwlXNc0dgw0Uulg=
X-Google-Smtp-Source: AMsMyM7OsF5YlBA77p2Vey2B2ZDeKYFYlfHfTy13MIDE9YR22EJGB10E/7qRuxxGwywPFEQ740BEkbrflHD8xOWCM+o=
X-Received: by 2002:ad4:5beb:0:b0:4af:96ab:21e5 with SMTP id
 k11-20020ad45beb000000b004af96ab21e5mr15845072qvc.85.1664798088934; Mon, 03
 Oct 2022 04:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220928105746.51208-1-andriy.shevchenko@linux.intel.com>
 <20220928105746.51208-2-andriy.shevchenko@linux.intel.com>
 <YzQqcFZtJn90URrJ@kroah.com> <Yzb9nXSxvgJ+Mj6z@paasikivi.fi.intel.com> <YzcAh/xtqQM1Qin4@kroah.com>
In-Reply-To: <YzcAh/xtqQM1Qin4@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 3 Oct 2022 13:54:37 +0200
Message-ID: <CAJZ5v0hHPjSN-369pagN3Mnxd1yvc6+4YGb0Kpx3=+aahV=AmQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] device property: Keep dev_fwnode() and
 dev_fwnode_const() separate
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 4:43 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Sep 30, 2022 at 02:30:53PM +0000, Sakari Ailus wrote:
> > Hi Greg,
> >
> > On Wed, Sep 28, 2022 at 01:05:20PM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Sep 28, 2022 at 01:57:42PM +0300, Andy Shevchenko wrote:
> > > > It's not fully correct to take a const parameter pointer to a struct
> > > > and return a non-const pointer to a member of that struct.
> > > >
> > > > Instead, introduce a const version of the dev_fwnode() API which takes
> > > > and returns const pointers and use it where it's applicable.
> > > >
> > > > Suggested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > Fixes: aade55c86033 ("device property: Add const qualifier to device_get_match_data() parameter")
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > > Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > ---
> > > >  drivers/base/property.c  | 11 +++++++++--
> > > >  include/linux/property.h |  3 ++-
> > > >  2 files changed, 11 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/base/property.c b/drivers/base/property.c
> > > > index 4d6278a84868..699f1b115e0a 100644
> > > > --- a/drivers/base/property.c
> > > > +++ b/drivers/base/property.c
> > > > @@ -17,13 +17,20 @@
> > > >  #include <linux/property.h>
> > > >  #include <linux/phy.h>
> > > >
> > > > -struct fwnode_handle *dev_fwnode(const struct device *dev)
> > > > +struct fwnode_handle *dev_fwnode(struct device *dev)
> > > >  {
> > > >   return IS_ENABLED(CONFIG_OF) && dev->of_node ?
> > > >           of_fwnode_handle(dev->of_node) : dev->fwnode;
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(dev_fwnode);
> > > >
> > > > +const struct fwnode_handle *dev_fwnode_const(const struct device *dev)
> > > > +{
> > > > + return IS_ENABLED(CONFIG_OF) && dev->of_node ?
> > > > +         of_fwnode_handle(dev->of_node) : dev->fwnode;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(dev_fwnode_const);
> > >
> > > Ick, no, this is a mess.
> > >
> > > Either always return a const pointer, or don't.  Ideally always return a
> > > const pointer, so all we really need is:
> > >
> > > const struct fwnode_handle *dev_fwnode(const struct device *dev);
> > >
> > > right?
> > >
> > > Yes, it will take some unwinding backwards to get there, but please do
> > > that instead of having 2 different functions where the parameter type is
> > > part of the function name.  This isn't the 1980's...
> >
> > The problem with this approach is that sometimes non-const fwnode_handles
> > are needed. On OF, for instance, anything that has something to do with
> > refcounting requires this. Software nodes as well.
>
> If they are writable, then yes, let's keep them writable, and not create
> two function paths where we have to pick and choose.
>
> > One option which I suggested earlier was to turn dev_fwnode() into a macro
> > and use C11 _Generic() to check whether the device is const or not.
>
> As much fun as that would be, I don't think it would work well.
>
> Although, maybe it would, have an example of how that would look?
>
> I ask as I just went through a large refactoring of the kobject layer to
> mark many things const * and I find it a bit "sad" that functions like
> this:
>         static inline struct device *kobj_to_dev(const struct kobject *kobj)
>         {
>                 return container_of(kobj, struct device, kobj);
>         }
> have the ability to take a read-only pointer and spit out a writable one
> thanks to the pointer math in container_of() with no one being the
> wiser.

Well, is this really a problem?

After all, if an immutable structure is embedded in another one, that
doesn't automatically imply that the containing structure has to be
immutable too.  Hence, a const pointer to the inner structure doesn't
automatically yield a const pointer to the outer one.

> > Being able to turn struct device pointers const is certainly not worth
> > violating constness properties.
>
> Agreed, but we can do better...
