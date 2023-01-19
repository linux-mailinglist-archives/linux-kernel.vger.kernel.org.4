Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EEC673DE3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 16:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjASPsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 10:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjASPrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 10:47:55 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB1887670;
        Thu, 19 Jan 2023 07:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674143232; x=1705679232;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WDq3PaWr838vW+P+WF80t5tJts1I6f8G8mSMYofwq0U=;
  b=fql269gJKuvCV83T1iGlOYh+r4lEBH4gFD8TggWaQqK9UmEUvYPr8mFc
   TUw4JIyYrLtH23rHPT4LQnxwTeSS4h0nPBXXt95hvALBaMTA2zCD7ieSg
   geK15+nQtoxwrZyLz4p5ZM6ZNy3/y+zel1cw1WEs1dkNoNAPB6FyTMdJv
   41gI44WYLJgSl55/G4W3d2tihWkWm7/P+Rbq4dHIsTM6plCaaE6glNmGQ
   hhU2gUuidibjOigXRyod2F6Wwogderw7fQntHQMFfph9ZC/kUX9x3Gsb7
   8icybQGTtPvnNiBCFIJtkkoalA7BZI4+7AJHAiGzl1HA1aMbA2kr+OBpz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="326599993"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="326599993"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 07:47:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="692461970"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="692461970"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 19 Jan 2023 07:47:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pIX7z-00Bjgz-24;
        Thu, 19 Jan 2023 17:46:59 +0200
Date:   Thu, 19 Jan 2023 17:46:59 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v4 1/4] device property: Get rid of
 __PROPERTY_ENTRY_ARRAY_EL*SIZE*()
Message-ID: <Y8ll89pF8MJhI1WA@smile.fi.intel.com>
References: <20221122133600.49897-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0gewC7z5XY+r8=2bkOAO2y8q7VVbrazj0z+4xGRR2Bkew@mail.gmail.com>
 <Y8lkhedIFY8UOPf+@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8lkhedIFY8UOPf+@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 04:40:53PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Nov 23, 2022 at 07:55:44PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Nov 22, 2022 at 2:35 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > First of all, _ELEMENT_SIZE() repeats existing sizeof_field() macro.
> > > Second, usage of _ARRAY_ELSIZE_LEN() adds unnecessary indirection
> > > to the data layout. It's more understandable when the data structure
> > > is placed explicitly. That said, get rid of those macros by replacing
> > > them with the existing helper and explicit data structure layout.
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > 
> > The series in which this patch is included does not apply cleanly for me.
> > 
> > I guess it depends on the earlier material already in Greg's tree, so
> > I'm leaving it to Greg.
> 
> Andy, did I miss this?

Nope, thanks!
40eb28dc17f8 ("device property: Get rid of __PROPERTY_ENTRY_ARRAY_EL*SIZE*()")

-- 
With Best Regards,
Andy Shevchenko


