Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC455F0D94
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 16:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbiI3ObN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 10:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbiI3ObH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 10:31:07 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5F01117F;
        Fri, 30 Sep 2022 07:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664548259; x=1696084259;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j26v+IkUVM1DJvy8r/Kyk/ns4U7hnATbQsuziy7CbQw=;
  b=ahCe/e+E7nUf6WJnv6966rr4mcaG0MDeFCRA01ukZiaVP1JZWgckt6od
   rKgdFepihJsOD72MZSKTAil7cqYGdoWJKxzQpDqzXZxZyHoRzqydPUk8P
   Kv+UvCt/Vt0EyF5SWfto6HI1r8gTTbb9p43UOh4C46kqTSCJgtG9tBfOt
   cTNHLtNEGan75/mw5OOQ2LDXW+s7Eac9ZiBMYvbJtEJ5IZvLZDVHrxeNx
   9LgN5rPhiMYoX12+CKGsi1W+swAGjLsH46DvsfCEHH2a5oKYcX1bFck+A
   wXAFSJH0YWJgxhH+YlyaYI7/euuJconauNbpnNHK8s+MXFTwDFeTybe+r
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="366252407"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="366252407"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 07:30:58 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="867828260"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="867828260"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 07:30:55 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 436E82021B;
        Fri, 30 Sep 2022 17:30:53 +0300 (EEST)
Date:   Fri, 30 Sep 2022 14:30:53 +0000
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
Message-ID: <Yzb9nXSxvgJ+Mj6z@paasikivi.fi.intel.com>
References: <20220928105746.51208-1-andriy.shevchenko@linux.intel.com>
 <20220928105746.51208-2-andriy.shevchenko@linux.intel.com>
 <YzQqcFZtJn90URrJ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzQqcFZtJn90URrJ@kroah.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Wed, Sep 28, 2022 at 01:05:20PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Sep 28, 2022 at 01:57:42PM +0300, Andy Shevchenko wrote:
> > It's not fully correct to take a const parameter pointer to a struct
> > and return a non-const pointer to a member of that struct.
> > 
> > Instead, introduce a const version of the dev_fwnode() API which takes
> > and returns const pointers and use it where it's applicable.
> > 
> > Suggested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Fixes: aade55c86033 ("device property: Add const qualifier to device_get_match_data() parameter")
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  drivers/base/property.c  | 11 +++++++++--
> >  include/linux/property.h |  3 ++-
> >  2 files changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/base/property.c b/drivers/base/property.c
> > index 4d6278a84868..699f1b115e0a 100644
> > --- a/drivers/base/property.c
> > +++ b/drivers/base/property.c
> > @@ -17,13 +17,20 @@
> >  #include <linux/property.h>
> >  #include <linux/phy.h>
> >  
> > -struct fwnode_handle *dev_fwnode(const struct device *dev)
> > +struct fwnode_handle *dev_fwnode(struct device *dev)
> >  {
> >  	return IS_ENABLED(CONFIG_OF) && dev->of_node ?
> >  		of_fwnode_handle(dev->of_node) : dev->fwnode;
> >  }
> >  EXPORT_SYMBOL_GPL(dev_fwnode);
> >  
> > +const struct fwnode_handle *dev_fwnode_const(const struct device *dev)
> > +{
> > +	return IS_ENABLED(CONFIG_OF) && dev->of_node ?
> > +		of_fwnode_handle(dev->of_node) : dev->fwnode;
> > +}
> > +EXPORT_SYMBOL_GPL(dev_fwnode_const);
> 
> Ick, no, this is a mess.
> 
> Either always return a const pointer, or don't.  Ideally always return a
> const pointer, so all we really need is:
> 
> const struct fwnode_handle *dev_fwnode(const struct device *dev);
> 
> right?
> 
> Yes, it will take some unwinding backwards to get there, but please do
> that instead of having 2 different functions where the parameter type is
> part of the function name.  This isn't the 1980's...

The problem with this approach is that sometimes non-const fwnode_handles
are needed. On OF, for instance, anything that has something to do with
refcounting requires this. Software nodes as well.

One option which I suggested earlier was to turn dev_fwnode() into a macro
and use C11 _Generic() to check whether the device is const or not.

Being able to turn struct device pointers const is certainly not worth
violating constness properties.

-- 
Regards,

Sakari Ailus
