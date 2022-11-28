Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E189763A686
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 11:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiK1K7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 05:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiK1K7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 05:59:33 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99A312AEC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 02:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669633172; x=1701169172;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4Z1bM9Tmjz6Bvo0a/hUeA6G3B1Xmf4XawJ+D22qwJPk=;
  b=hdLnH1NmjSc2uPjPNgw1NBVe0MwQPeOjjCeMUjCYNLHAMV6Aa9NuSF1s
   KhuJ+if/DD7o5KU0fTlts09KIqSOr5olu6U/hIIUYBb8XGGcn+AVYbL+E
   bUHthIFRCGArpMm+mnhp2bv+Q750jvSd+DkR//cwA/GXDM6UbYkJUvOgr
   kShVsQ+6KmeHEmDIS87lmUWP5JLxZ2GqofW1BcA9wa+3LECVCh4Nm4OxS
   viWsUapdzPgh4jRXbGZ7c4ibY5paa2Pd0TWr7wxyJ8kIo4YMFUD5EZhyZ
   DFdINnNdS3ilgZnXm7uEJ0fOvGYkjDPNjF1Z678hxYLtGKZuVlpPInO7T
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="302382990"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="302382990"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 02:59:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="645451609"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="645451609"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 28 Nov 2022 02:59:30 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ozbrE-0015fW-2c;
        Mon, 28 Nov 2022 12:59:28 +0200
Date:   Mon, 28 Nov 2022 12:59:28 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jianglei Nie <niejianglei2021@163.com>
Cc:     ojeda@kernel.org, geert+renesas@glider.be,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] auxdisplay: hd44780: Fix potential memory leak in
 hd44780_remove()
Message-ID: <Y4SUkGYK5Y6Uo3Bv@smile.fi.intel.com>
References: <20221128084421.8626-1-niejianglei2021@163.com>
 <Y4SRUwKFGJfwNZ2U@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4SRUwKFGJfwNZ2U@smile.fi.intel.com>
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

On Mon, Nov 28, 2022 at 12:45:39PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 28, 2022 at 04:44:21PM +0800, Jianglei Nie wrote:

...

> Fixes: 718e05ed92ec ("auxdisplay: Introduce hd44780_common.[ch]")
> 
> What you found has nothing to do with the issue. Issue has been introduced
> later on.

Side note (mostly for Miguel): That series by Lars was indeed problematic.
And I see now that he didn't get the parameter to the charlcd_alloc(). Now
we have problem that your patch solves and dangling parameter in the struct
charlcd_priv. So, I will restore charlcd_alloc() before his series (after
this patch has been applied, because of the backport needs) for a new
kernel development cycle.

-- 
With Best Regards,
Andy Shevchenko


