Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25EC5F3250
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 17:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiJCPHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 11:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiJCPHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 11:07:36 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53871DF24;
        Mon,  3 Oct 2022 08:07:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E9FD9CE0B66;
        Mon,  3 Oct 2022 15:07:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88ADC433C1;
        Mon,  3 Oct 2022 15:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664809650;
        bh=PdX/nPKrNPTp0ZdNS3WGJ8How6vXL5Mgadn85s37+j4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UH/Ao6w2+mc3UXOJByPOpqKtfaeqcMdr+yRLSHFEF+nC+uC2tmEVNfF/BgEGw0D3X
         0h15AE4p2Hujc/56F4Qw97r/cByNk1hDJ6Y1uKV3C8wsSvCTeh68HS8wjPc3fgAN5A
         AJVUPKqKl5Swug/bs6iYdnB3GUmuiGQWqlxXUP+Y=
Date:   Mon, 3 Oct 2022 17:07:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/5] device property: Keep dev_fwnode() and
 dev_fwnode_const() separate
Message-ID: <Yzr6r5XtmPXCoQx7@kroah.com>
References: <20220928105746.51208-1-andriy.shevchenko@linux.intel.com>
 <20220928105746.51208-2-andriy.shevchenko@linux.intel.com>
 <YzQqcFZtJn90URrJ@kroah.com>
 <Yzb9nXSxvgJ+Mj6z@paasikivi.fi.intel.com>
 <YzcAh/xtqQM1Qin4@kroah.com>
 <YzrBO2m/b1MHuKny@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzrBO2m/b1MHuKny@paasikivi.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 11:02:19AM +0000, Sakari Ailus wrote:
> Hi Greg,
> 
> On Fri, Sep 30, 2022 at 04:43:19PM +0200, Greg Kroah-Hartman wrote:
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
> > > > >  	return IS_ENABLED(CONFIG_OF) && dev->of_node ?
> > > > >  		of_fwnode_handle(dev->of_node) : dev->fwnode;
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(dev_fwnode);
> > > > >  
> > > > > +const struct fwnode_handle *dev_fwnode_const(const struct device *dev)
> > > > > +{
> > > > > +	return IS_ENABLED(CONFIG_OF) && dev->of_node ?
> > > > > +		of_fwnode_handle(dev->of_node) : dev->fwnode;
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
> 
> Similar to what container_of() could be, see below.
> 
> We could also partially revert aade55c86033bee868a93e4bf3843c9c99e84526
> which (also) made dev_fwnode() argument const (which is the source of the
> issue).
> 
> > 
> > I ask as I just went through a large refactoring of the kobject layer to
> > mark many things const * and I find it a bit "sad" that functions like
> > this:
> > 	static inline struct device *kobj_to_dev(const struct kobject *kobj)
> > 	{
> > 		return container_of(kobj, struct device, kobj);
> > 	}
> > have the ability to take a read-only pointer and spit out a writable one
> > thanks to the pointer math in container_of() with no one being the
> > wiser.
> 
> Yeah, container_of() is dangerous, especially in macros. It could of course
> be made safer. Something like this:
> 
> <URL:https://lore.kernel.org/linux-kernel/1495195570-5249-1-git-send-email-sakari.ailus@linux.intel.com/>
> 
> I can respin it, back in 2017 I got no replies.

I don't like how we loose the ability to do this in an inline C function
by being forced to do it in a macro (as it makes build errors harder to
understand), but I do like the intent here.

Let me play around with this a bit on some "smaller" uses of
container_of() and see how that works...

thanks,

greg k-h
