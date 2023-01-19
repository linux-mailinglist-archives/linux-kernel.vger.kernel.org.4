Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56405674B5D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjATExU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjATExB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:53:01 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0609619A;
        Thu, 19 Jan 2023 20:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674189894; x=1705725894;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BfEES7hM/KFkzDhKaqvx+cc8oD5zFjJ0h/F4pzIFBEU=;
  b=DXbNGXHzaa+uUuacONlWZoaTNbJ+s3f8oL2fvYs3T7Y/iz6raRSIgP4/
   g7lh0Q+LhgNc6tuY1DUqbtQVThIn5d5tG0G0FTH9kaTkC/uMDgTZVdQJW
   lJ2WdGFAa+9OXZOfsgPomb3oHd49I9cy7zYFKsJBQDYqOiZXkNZHBjwlu
   j2h53Dw99g0d62mIm+xLU32ANRy0X7qldGsTxcsXTx6Lz2bGILPZ59g44
   zF1YO8MaZaKg16l3H+BAwTmrg/wsb3qqWTtvF2lX2yxeU+BvUMQQhfQ4R
   t4SNy96IUwQvDCcCpXegtP1kQ8wZu590XSsXeXsTKfm8/uYfJ9jT7np/q
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="387695425"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="387695425"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 08:13:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="610115645"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="610115645"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 19 Jan 2023 08:13:08 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pIXXG-00BkPa-0Q;
        Thu, 19 Jan 2023 18:13:06 +0200
Date:   Thu, 19 Jan 2023 18:13:05 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, kernel test robot <lkp@intel.com>
Subject: Re: [resent, PATCH v2 1/1] leds: is31fl319x: Wrap mutex_destroy()
 for devm_add_action_or_rest()
Message-ID: <Y8lsEc2cFR3mMS0N@smile.fi.intel.com>
References: <20230103131553.34124-1-andriy.shevchenko@linux.intel.com>
 <Y8lqRjeM9I/rRrvv@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8lqRjeM9I/rRrvv@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 04:05:26PM +0000, Lee Jones wrote:
> On Tue, 03 Jan 2023, Andy Shevchenko wrote:

...

> > v2 resent: resent as v2
> > v2: added tag (Vincent), Cc'ed to Lee
> > 
> >  drivers/leds/leds-is31fl319x.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> Not sure what the differences were, but looks like I already applied v1.

Codewise there is none. Thank you!

-- 
With Best Regards,
Andy Shevchenko


