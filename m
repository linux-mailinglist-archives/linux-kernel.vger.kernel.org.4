Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B7F5F3F7A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiJDJXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiJDJWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:22:14 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC40E023;
        Tue,  4 Oct 2022 02:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664875307; x=1696411307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6C1wn4VpHnxwWmqYZoBN4fkhztrWvlQuE4Ow78yD49E=;
  b=RM+J6YMTEC742JbACvzmNjKVKNA0ZjJXwmQ5k9RSzviNVPGOSZpoqHK1
   nuT+r0MMtKxvOcsd68NqaHbjfzIgCB6dR9qUQepl/Qfq7SiyeWIk+1CTW
   CVVZUfXpEiEQbyTLS4ZBrcCCzVjHbWuSlHztW+rBS5LMq2TmPdCmXvam2
   eDoMV9rIMhR+5q9A/vt1rsjqMFoy7CybaEys1WUtdOU1tqpCq8YxD8jjm
   +dunaZ/z/Mq+A5VHhHnu01ASdY7cKA1NnLvoqFAbo6tw/QxoJ2l2HYGoV
   ts6Vvs5QNB2dGJh8V/0AyDLawK7XBfZ4JyJan9GJtT9+eVHuzT9rZ9edg
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="302843615"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="302843615"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 02:21:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="868932506"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="868932506"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 04 Oct 2022 02:21:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ofe7T-001zQw-0f;
        Tue, 04 Oct 2022 12:21:43 +0300
Date:   Tue, 4 Oct 2022 12:21:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/5] device property: Keep dev_fwnode() and
 dev_fwnode_const() separate
Message-ID: <Yzv7JqVRWU8Hq5wF@smile.fi.intel.com>
References: <Yzb9nXSxvgJ+Mj6z@paasikivi.fi.intel.com>
 <YzcAh/xtqQM1Qin4@kroah.com>
 <YzrBO2m/b1MHuKny@paasikivi.fi.intel.com>
 <Yzr6r5XtmPXCoQx7@kroah.com>
 <YzsLDUhjDCCVRy2G@kroah.com>
 <YztBWlmdgylsntgM@paasikivi.fi.intel.com>
 <Yzvm6XF0Ar35XZvT@kroah.com>
 <YzvrVoJ3BBhZmaZT@smile.fi.intel.com>
 <YzvtrXlv5X0LHAxa@kroah.com>
 <YzvuFBo5Vd6S4QoO@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzvuFBo5Vd6S4QoO@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 11:25:56AM +0300, Andy Shevchenko wrote:
> On Tue, Oct 04, 2022 at 10:24:13AM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Oct 04, 2022 at 11:14:14AM +0300, Andy Shevchenko wrote:
> > > On Tue, Oct 04, 2022 at 09:55:21AM +0200, Greg Kroah-Hartman wrote:
> > > > On Mon, Oct 03, 2022 at 08:08:58PM +0000, Sakari Ailus wrote:
> > > > > On Mon, Oct 03, 2022 at 06:17:17PM +0200, Greg Kroah-Hartman wrote:

...

> > > > > #define kobj_to_dev(kobj)						\
> > > > > 	(_Generic((kobj),						\
> > > > > 		  const struct kobject *: __kobj_to_dev_const,		\
> > > > > 		  struct kobject *: __kobj_to_dev)(kobj))
> > > > 
> > > > Ah, doh!  I had the (kobj) part in the wrong place, thanks for that
> > > > fix...
> > > > 
> > > > Ok, this looks better, let me see how well the build breaks with some of
> > > > these changes
> > > 
> > > I believe I can rewrite my patch like this and then it will be much nicer since
> > > we may constify all the rest without calling __dev_fwnode_const() directly.
> > > 
> > > Are you agree?
> > 
> > Yes, I think this is a much better option, try it and see.  Below is the
> > patch I'm running through my build systems at the moment, feel free to
> > copy the style for your change as well.
> 
> Yep, thanks for sharing!

v3 has been just sent out.

-- 
With Best Regards,
Andy Shevchenko


