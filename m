Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2166E5F3E46
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiJDI0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiJDI0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:26:04 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB8E22B12;
        Tue,  4 Oct 2022 01:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664871961; x=1696407961;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xFUr2CE7UnL6lwY/H1X/jHfUV8JBN2yFrKgPXcXepp8=;
  b=XwxblJojXcagw7MZJhb90l/4NaL5SRrq5y9gwYyM9AE6BPm71z+WpVrw
   /UQOTp3nw9JTIvTNZs3usmK6Bh82rgx6ervoozT7uTCs6FRXaL7h9I0PN
   CiUof5PDQ9v2ak47LUV2LAGfMXDV05ZWKWISB9g9hYGG0UjcW3ik7VIlq
   zIDnaJhWD64zb1qdfu7LOFa/EH4wwCNXMdvCDF+O3KTvGY3nZhLLfHQv+
   zRMnCCqsx1sq2fYcA4AJ3S5IwpbAjnqta2NDEoR0obkoziPB8NdPxMIEn
   6YskSD3qqOORZdcWIhNa5M/eVHKykPha3S5eceJp3rUSiAWIhqT1I0jeO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="329260816"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="329260816"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 01:26:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="574952833"
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="574952833"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 04 Oct 2022 01:25:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ofdFU-001yDG-1m;
        Tue, 04 Oct 2022 11:25:56 +0300
Date:   Tue, 4 Oct 2022 11:25:56 +0300
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
Message-ID: <YzvuFBo5Vd6S4QoO@smile.fi.intel.com>
References: <YzQqcFZtJn90URrJ@kroah.com>
 <Yzb9nXSxvgJ+Mj6z@paasikivi.fi.intel.com>
 <YzcAh/xtqQM1Qin4@kroah.com>
 <YzrBO2m/b1MHuKny@paasikivi.fi.intel.com>
 <Yzr6r5XtmPXCoQx7@kroah.com>
 <YzsLDUhjDCCVRy2G@kroah.com>
 <YztBWlmdgylsntgM@paasikivi.fi.intel.com>
 <Yzvm6XF0Ar35XZvT@kroah.com>
 <YzvrVoJ3BBhZmaZT@smile.fi.intel.com>
 <YzvtrXlv5X0LHAxa@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzvtrXlv5X0LHAxa@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 10:24:13AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Oct 04, 2022 at 11:14:14AM +0300, Andy Shevchenko wrote:
> > On Tue, Oct 04, 2022 at 09:55:21AM +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Oct 03, 2022 at 08:08:58PM +0000, Sakari Ailus wrote:
> > > > On Mon, Oct 03, 2022 at 06:17:17PM +0200, Greg Kroah-Hartman wrote:

...

> > > > #define kobj_to_dev(kobj)						\
> > > > 	(_Generic((kobj),						\
> > > > 		  const struct kobject *: __kobj_to_dev_const,		\
> > > > 		  struct kobject *: __kobj_to_dev)(kobj))
> > > 
> > > Ah, doh!  I had the (kobj) part in the wrong place, thanks for that
> > > fix...
> > > 
> > > Ok, this looks better, let me see how well the build breaks with some of
> > > these changes
> > 
> > I believe I can rewrite my patch like this and then it will be much nicer since
> > we may constify all the rest without calling __dev_fwnode_const() directly.
> > 
> > Are you agree?
> 
> Yes, I think this is a much better option, try it and see.  Below is the
> patch I'm running through my build systems at the moment, feel free to
> copy the style for your change as well.

Yep, thanks for sharing!

-- 
With Best Regards,
Andy Shevchenko


