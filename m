Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E957F606253
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 15:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiJTN5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 09:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiJTN5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 09:57:30 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B7219C067
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 06:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666274247; x=1697810247;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6d05uh/PRRPPMALZrbJAbzB3x4DqqbHlYLonr+PPN3o=;
  b=WvPjntZsr+EvFklW/QACwgQN/sqDQn/yZIbzPg3vtMzWAdo0l6HOZM+S
   MBOqY7YCAArVioO7W1XUwuAQl8fcVXsmWGZXhVUYsoNAC6WkSQGMeVg4U
   DQr+U5QLHNkoOFfOpdnxNyzxf/fEMYgsAznut5pY2y63fsLxtnNAd5hj8
   97fvd9Gm31PHrrVTU6VZR5zBhZVHpnxEioXOHea+370SaZ3x/p12NTeHx
   kuvnqcwS5cdHDgyUVdvPmZcpo37WgX2adH0f3PyXd24JBIiqToZlaHbyv
   vzgFCuanFh6ex3BCitWerz38xZ6bf0uOFQqg8A9e0DzxZbEE38Bih3gdE
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="294106798"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="294106798"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 06:57:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="804894448"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; 
   d="scan'208";a="804894448"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 20 Oct 2022 06:57:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1olW30-00AZfH-1s;
        Thu, 20 Oct 2022 16:57:22 +0300
Date:   Thu, 20 Oct 2022 16:57:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jane Chu <jane.chu@oracle.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        John Haxby <john.haxby@oracle.com>
Subject: Re: [PATCH] vsprintf: protect kernel from panic due to non-canonical
 pointer dereference
Message-ID: <Y1FTwpngS5EPgSX4@smile.fi.intel.com>
References: <20221017191611.2577466-1-jane.chu@oracle.com>
 <Y02sENwhtpsx5yhP@smile.fi.intel.com>
 <5d987403-a7bf-8996-d639-c99edeaabcdf@oracle.com>
 <Y06f4EwisLTU0rEz@alley>
 <799e5390-2ff5-02b7-2df7-61198d5451e2@oracle.com>
 <Y08Hn6on37fgc57F@smile.fi.intel.com>
 <f77145e0-2bc9-a558-7f55-22100fa4b5ed@oracle.com>
 <Y08RVzvniYr8ycKV@smile.fi.intel.com>
 <Y1D8RfpkyLa4FU7r@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1D8RfpkyLa4FU7r@alley>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 09:44:05AM +0200, Petr Mladek wrote:
> On Tue 2022-10-18 23:49:27, Andy Shevchenko wrote:
> > On Tue, Oct 18, 2022 at 08:30:01PM +0000, Jane Chu wrote:

...

> > Obviously, to see the crash. And let kernel _to crash_. Isn't it what we need
> > to see a bug as early as possible?
> 
> I do not agree here. Kernel tries to survive many situations when
> thighs does not work as expected. It prints a warning so that
> users/developers are aware of the problem and could fix it.

How the user will know what the root cause and how to fix it? The crash
report will give all needed information, the "(eXXXXXX)" will hide it all,
which I consider inappropriate approach.

I.o.w. consider "(eXXXXXX)" vs. something like "your stuff crashed kernel
because of misaligned / etc pointer which has value of 0xXXXXXXXX and other
registers have these values" and so on, so on...

> In our case, the crash happened when reading a sysfs file.
> IMHO, it is much better to show (-EINVAL) than crash. The bug
> when accessing devX_attrY[] does not affect the stability of
> the system at all.

When I got "eXXXXX" from cat /sys/... I think "OK, something went wrong,
I shouldn't really take it seriously". And completely different feelings
when you got a crash, right?

> And the broken string might be passed in a very rare case,
> e.g. in an error path. So that it might be hard to catch
> when testing.

-- 
With Best Regards,
Andy Shevchenko


