Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3125F36DA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 22:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiJCUJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 16:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiJCUJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 16:09:04 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683BB220D6;
        Mon,  3 Oct 2022 13:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664827743; x=1696363743;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=fwDmqltDP9nwpwjGCWVKOVpQTn+Pfas7Da4E+mK5z2g=;
  b=TDw/pM2QdIn+Z+eLV2aR6YTAiAqbwFvYXWxVqmZTcnxxl8sA1g//AyqE
   ym2R3Pm9xAGBpP9veLCnalv8ogL6OrCAoQofMurvvR5t/CcJIBmyynGOY
   LYHqvi7a94XlEwpgTz44LCP3szHqMntCEQow4acUGtQh3hytSeVTGN/06
   SczTXmrMmasoan/qRjNtHYFSIfHFKW+I4RjE7hd30gBbuASnSvWaL7iRa
   mrN6sX5kky7eWgCwl7YZpqjWtCMm8qQYzJfT8tgMvLZ1yUreORxdgg3rJ
   lpxZdh2gZt7dY3g/bHzyBCcezOr+/WtWow7wtgdKNBDhX64m95JaboRh8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="302727484"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="302727484"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 13:09:03 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="686278807"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="686278807"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 13:09:00 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 470E92026C;
        Mon,  3 Oct 2022 23:08:58 +0300 (EEST)
Date:   Mon, 3 Oct 2022 20:08:58 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/5] device property: Keep dev_fwnode() and
 dev_fwnode_const() separate
Message-ID: <YztBWlmdgylsntgM@paasikivi.fi.intel.com>
References: <20220928105746.51208-1-andriy.shevchenko@linux.intel.com>
 <20220928105746.51208-2-andriy.shevchenko@linux.intel.com>
 <YzQqcFZtJn90URrJ@kroah.com>
 <Yzb9nXSxvgJ+Mj6z@paasikivi.fi.intel.com>
 <YzcAh/xtqQM1Qin4@kroah.com>
 <YzrBO2m/b1MHuKny@paasikivi.fi.intel.com>
 <Yzr6r5XtmPXCoQx7@kroah.com>
 <YzsLDUhjDCCVRy2G@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YzsLDUhjDCCVRy2G@kroah.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Oct 03, 2022 at 06:17:17PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Oct 03, 2022 at 05:07:27PM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Oct 03, 2022 at 11:02:19AM +0000, Sakari Ailus wrote:
> > > Hi Greg,
> > > 
> > > On Fri, Sep 30, 2022 at 04:43:19PM +0200, Greg Kroah-Hartman wrote:
> > > > On Fri, Sep 30, 2022 at 02:30:53PM +0000, Sakari Ailus wrote:
> > > > > Hi Greg,
> > > > > 
> > > > > On Wed, Sep 28, 2022 at 01:05:20PM +0200, Greg Kroah-Hartman wrote:
> > > > > > On Wed, Sep 28, 2022 at 01:57:42PM +0300, Andy Shevchenko wrote:
> > > > > > > It's not fully correct to take a const parameter pointer to a struct
> > > > > > > and return a non-const pointer to a member of that struct.
> > > > > > > 
> > > > > > > Instead, introduce a const version of the dev_fwnode() API which takes
> > > > > > > and returns const pointers and use it where it's applicable.
> > > > > > > 
> > > > > > > Suggested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > > > > Fixes: aade55c86033 ("device property: Add const qualifier to device_get_match_data() parameter")
> > > > > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > > > > Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > > > > > Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > > > > ---
> > > > > > >  drivers/base/property.c  | 11 +++++++++--
> > > > > > >  include/linux/property.h |  3 ++-
> > > > > > >  2 files changed, 11 insertions(+), 3 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/base/property.c b/drivers/base/property.c
> > > > > > > index 4d6278a84868..699f1b115e0a 100644
> > > > > > > --- a/drivers/base/property.c
> > > > > > > +++ b/drivers/base/property.c
> > > > > > > @@ -17,13 +17,20 @@
> > > > > > >  #include <linux/property.h>
> > > > > > >  #include <linux/phy.h>
> > > > > > >  
> > > > > > > -struct fwnode_handle *dev_fwnode(const struct device *dev)
> > > > > > > +struct fwnode_handle *dev_fwnode(struct device *dev)
> > > > > > >  {
> > > > > > >  	return IS_ENABLED(CONFIG_OF) && dev->of_node ?
> > > > > > >  		of_fwnode_handle(dev->of_node) : dev->fwnode;
> > > > > > >  }
> > > > > > >  EXPORT_SYMBOL_GPL(dev_fwnode);
> > > > > > >  
> > > > > > > +const struct fwnode_handle *dev_fwnode_const(const struct device *dev)
> > > > > > > +{
> > > > > > > +	return IS_ENABLED(CONFIG_OF) && dev->of_node ?
> > > > > > > +		of_fwnode_handle(dev->of_node) : dev->fwnode;
> > > > > > > +}
> > > > > > > +EXPORT_SYMBOL_GPL(dev_fwnode_const);
> > > > > > 
> > > > > > Ick, no, this is a mess.
> > > > > > 
> > > > > > Either always return a const pointer, or don't.  Ideally always return a
> > > > > > const pointer, so all we really need is:
> > > > > > 
> > > > > > const struct fwnode_handle *dev_fwnode(const struct device *dev);
> > > > > > 
> > > > > > right?
> > > > > > 
> > > > > > Yes, it will take some unwinding backwards to get there, but please do
> > > > > > that instead of having 2 different functions where the parameter type is
> > > > > > part of the function name.  This isn't the 1980's...
> > > > > 
> > > > > The problem with this approach is that sometimes non-const fwnode_handles
> > > > > are needed. On OF, for instance, anything that has something to do with
> > > > > refcounting requires this. Software nodes as well.
> > > > 
> > > > If they are writable, then yes, let's keep them writable, and not create
> > > > two function paths where we have to pick and choose.
> > > > 
> > > > > One option which I suggested earlier was to turn dev_fwnode() into a macro
> > > > > and use C11 _Generic() to check whether the device is const or not.
> > > > 
> > > > As much fun as that would be, I don't think it would work well.
> > > > 
> > > > Although, maybe it would, have an example of how that would look?
> > > 
> > > Similar to what container_of() could be, see below.
> > > 
> > > We could also partially revert aade55c86033bee868a93e4bf3843c9c99e84526
> > > which (also) made dev_fwnode() argument const (which is the source of the
> > > issue).
> > > 
> > > > 
> > > > I ask as I just went through a large refactoring of the kobject layer to
> > > > mark many things const * and I find it a bit "sad" that functions like
> > > > this:
> > > > 	static inline struct device *kobj_to_dev(const struct kobject *kobj)
> > > > 	{
> > > > 		return container_of(kobj, struct device, kobj);
> > > > 	}
> > > > have the ability to take a read-only pointer and spit out a writable one
> > > > thanks to the pointer math in container_of() with no one being the
> > > > wiser.
> > > 
> > > Yeah, container_of() is dangerous, especially in macros. It could of course
> > > be made safer. Something like this:
> > > 
> > > <URL:https://lore.kernel.org/linux-kernel/1495195570-5249-1-git-send-email-sakari.ailus@linux.intel.com/>
> > > 
> > > I can respin it, back in 2017 I got no replies.
> > 
> > I don't like how we loose the ability to do this in an inline C function
> > by being forced to do it in a macro (as it makes build errors harder to
> > understand), but I do like the intent here.
> > 
> > Let me play around with this a bit on some "smaller" uses of
> > container_of() and see how that works...
> 
> Odd, this doesn't work for me at all.
> 
> I tried the following change:
> 
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 424b55df0272..5575c87e6c3b 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -680,11 +680,21 @@ struct device_link {
>  	bool supplier_preactivated; /* Owned by consumer probe. */
>  };
>  
> -static inline struct device *kobj_to_dev(struct kobject *kobj)
> +static inline struct device *__kobj_to_dev(struct kobject *kobj)
>  {
>  	return container_of(kobj, struct device, kobj);
>  }
>  
> +static inline const struct device *__kobj_to_dev_const(const struct kobject *kobj)
> +{
> +	return container_of(kobj, const struct device, kobj);
> +}
> +
> +#define kobj_to_dev(kobj)						\
> +	_Generic((kobj),						\
> +		 const struct kobject *: __kobj_to_dev_const(kobj),	\
> +		 struct kobject *: __kobj_to_dev(kobj))
> +
>  /**
>   * device_iommu_mapped - Returns true when the device DMA is translated
>   *			 by an IOMMU
> 
> 
> which seems all is fine for normal kobject pointers passed in, but for
> the first 'const struct kobject *' the compiler hits, I get the
> following error:
> 
>   CC      drivers/base/core.o
> In file included from ./include/linux/acpi.h:15,
>                  from drivers/base/core.c:11:
> drivers/base/core.c: In function ‘dev_attr_show’:
> drivers/base/core.c:2193:48: error: passing argument 1 of ‘__kobj_to_dev’ discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
>  2193 |         const struct device *dev = kobj_to_dev(kobj);
>       |                                                ^~~~
> ./include/linux/device.h:696:50: note: in definition of macro ‘kobj_to_dev’
>   696 |                  struct kobject *: __kobj_to_dev(kobj))
>       |                                                  ^~~~
> ./include/linux/device.h:683:60: note: expected ‘struct kobject *’ but argument is of type ‘const struct kobject *’
>   683 | static inline struct device *__kobj_to_dev(struct kobject *kobj)
>       |                                            ~~~~~~~~~~~~~~~~^~~~
> 
> 
> (note, I faked up a constant pointer just to trip the compiler)
> 
> The selection of _Generic() seems not to be working here, any hints?  I tried
> playing around with 'default' and 'typeof' and the like, but all error out the
> same way.

Even though only one gets evaluated, it seems the compiler will still
perform type check on it. I think this problem was partially shared by the
original patch.

This should work if written as:

#define kobj_to_dev(kobj)						\
	(_Generic((kobj),						\
		  const struct kobject *: __kobj_to_dev_const,		\
		  struct kobject *: __kobj_to_dev)(kobj))

-- 
Kind regards,

Sakari Ailus
