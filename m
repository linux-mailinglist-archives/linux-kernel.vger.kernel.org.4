Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7382B60C646
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 10:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbiJYIUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 04:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbiJYIUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 04:20:23 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F915C2CBC
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 01:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666686020; x=1698222020;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2vbx9VKGR+WsQTZs7kfvgkSH5+IhUUxGpx8wAw0zx7A=;
  b=BIdsJuAdqnmmTsqYOV4dw3X+7coojxk0HxBODIc6D+iWxfJwmzWcvmzd
   A0+Us1pU+HNZQqyJ8VY14LZ8T45ypW/rW2V9XazIUSu0cEx3KzZjBemkS
   w8xsHGY9iEP/Hj0gZxKsMT9dJX/RW+V/vUChBBCHxM8JzJlOVbx7gSNjf
   DthcsXx0Gg2XqjBfGPXlcNXez0xxDQMIQi+tpvLgkZawjJ2snfviDjndI
   i8F6yi0cNBLwDx1Ye3AQPGstb3e0jJraw7j7tWP86J8YYc9/Oo5ti6Kop
   44zmC7eWMqXjCqsM42WnT/XyELcOrsmYAE9oEt6PORfQAxlzS9x3dX+gZ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="369687767"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="369687767"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 01:20:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="774112810"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="774112810"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 25 Oct 2022 01:20:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1onFAQ-001tmJ-38;
        Tue, 25 Oct 2022 11:20:10 +0300
Date:   Tue, 25 Oct 2022 11:20:10 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     mingo@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [rft, PATCH v1 4/4] kernel.h: Split out ARRAY_SZIE()
Message-ID: <Y1ecOl+UGdBV1ce3@smile.fi.intel.com>
References: <Y1ay8k75fegxTcuG@x99>
 <Y1a3vpiy8RBGfbsI@smile.fi.intel.com>
 <Y1bWBedax9lP2E3K@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1bWBedax9lP2E3K@p183>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 09:14:29PM +0300, Alexey Dobriyan wrote:
> On Mon, Oct 24, 2022 at 07:05:18PM +0300, Andy Shevchenko wrote:
> > On Mon, Oct 24, 2022 at 06:44:50PM +0300, Alexey Dobriyan wrote:
> > > > include/linux/array_size.h | 13 +++++++++++++
> > > 
> > > All of this is pessimisation unless you're removing
> > > 
> > > 	+#include <linux/array_size.h>
> > > 
> > > from kernel.h which you aren't doing.
> > > 
> > > container_of.h is just as silly.
> > > 
> > > kernel.h might need _some_ cleanup (like panic and tainted stuff) which
> > > is rarely used but ARRAY_SIZE()?
> > 
> > Are you suggesting to slow down compilation with inclusion of tons of unneeded
> > stuff in the zillions of drivers?
> > 
> > Or you are talking that we need to abandon most of the headers and combine
> > everything into kernel.h? I think this is what is silly.
> 
> It hard to escape kernel.h so you will be including it anyway.

It's very important to not include it in the headers.

And this split helps to it a lot. We have container_of() or array_size() used
in macros and/or inliners that are usually appears in the headers. And if you
know what dependency hell means, the kernel.h brings to it a huge mess.

So, try to be constructive, okay?

> Unless you delete, say, kstrtox.h from kernel.h, it is pointless busywork.

-- 
With Best Regards,
Andy Shevchenko


