Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02FC638DF8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 16:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiKYP60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 10:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiKYP6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 10:58:19 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C1D4AF0B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 07:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669391897; x=1700927897;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y9bTL14X4whNb/Mndo70gBsRMAZq0yxwpnPLUHzKUYM=;
  b=G6XqI9b5WNIZferzvlYxRQVsUnIGXiIGqgHKC74kBNCjZDs8kc9Z50q7
   bakFxgz8/87Ki+udDoODcZCKb6AJxsnr6JPl0+BQ2fMUNpALa9qb+A45j
   w908VHCsIte/f72UeMQbUk5NC0Cx6R9/ELLYBTk2VzzGa53hYzL7jz9AM
   OP52xMuxyxo9w47DmBtPWJSRDVJxVDU1QvAjuyOnnQ5jGUn80eMC1RwY9
   Dqmma1olCMFUDhEoHij8HxVrWNsCE1d5EYOc6rCHYYhfbiQZHc8TMV+Rn
   71Fqm/e8AFbN+GoSEFAet6gOIqCbLT355WZqpuPFH70k59yLUCq63aI6H
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="376648768"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="376648768"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 07:58:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="731474894"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="731474894"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Nov 2022 07:58:15 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oyb5h-00HIMQ-1g;
        Fri, 25 Nov 2022 17:58:13 +0200
Date:   Fri, 25 Nov 2022 17:58:13 +0200
From:   'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        'Joe Perches' <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/1] Slightly relax the type checking done by min() and
 max().
Message-ID: <Y4DmFfj6G6+niZ+t@smile.fi.intel.com>
References: <cfc6c0f0fd4c4724890be8a8397c2cbe@AcuMS.aculab.com>
 <Y4DdQIMiFGk7YYcJ@smile.fi.intel.com>
 <7e594ad64e444d448c747688b8f28249@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e594ad64e444d448c747688b8f28249@AcuMS.aculab.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 03:27:07PM +0000, David Laight wrote:
> From: Andy Shevchenko
> > Sent: 25 November 2022 15:21
> > On Fri, Nov 25, 2022 at 03:00:40PM +0000, David Laight wrote:
> > > The min() and max() defines include a type check to avoid the unexpected
> > >   behaviour when a negative value is compared against and unsigned value.
> > > However a lot of code hits this check and uses min_t() to avoid the error.
> > > Many of these are just plain wrong.
> > >
> > > Those casting to u8 or u16 are particularly suspect, eg:
> > > drivers/usb/misc/usb251xb.c:528:
> > > 		hub->max_current_sp = min_t(u8, property_u32 / 2000, 50);
> > 
> > I don't buy this. What's exactly wrong with this code?
> 
> Consider what happens if propery_u32 is 512000.
> The returned value is 0 not 50.

I considered that and there are two things to consider on your side:
1) it's coming from device property;
2) device property is validated using YAML schema.

On top of that, the wrong property is on the user. We have a lot of stuff that
user may put wrongly, but it's user's choice.

Any better example, please?

-- 
With Best Regards,
Andy Shevchenko


