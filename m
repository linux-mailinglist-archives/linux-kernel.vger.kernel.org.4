Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF806526D9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 20:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbiLTTPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 14:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbiLTTPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 14:15:31 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531C31D0FC;
        Tue, 20 Dec 2022 11:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671563728; x=1703099728;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2COOT5zaAK5+RIgGHKkO1Q1ITT88R4AqRmnRRum82sU=;
  b=QJyc1IbQUVxAUdXbNFjoDSz4tad0JdnXL/cJ1sRDWxgaFp2tIMPXJQdU
   CVKREdAt0JpOy6oS2/6R0nqiYjeIu1mxpbILB0X8KHKXdSX+j/cfTH5Iy
   WzffNAm4O0rs/0BM3XHsPlyrQAnYSToNoDIcNY7x2oOvTsqJy4PjV55rT
   aDH4C4HG0r9mZ7rKxoZC3GDY/MCN6I8WJNL56yz87VefFtgd4AVsAev1J
   G4kEcd/pnWTjZDv3KsilUTIHarhjVXdBBV9SyiusLwDR22jr4FeSG0I8H
   EzXg3AxXWrO/KjxuuGxb9y7mxXaDBDmMcPmQyMgpYpRE6nQgE6LQHfctq
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="318391690"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="318391690"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 11:15:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="896582153"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="896582153"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 20 Dec 2022 11:15:26 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p7i5F-00D99z-00;
        Tue, 20 Dec 2022 21:15:25 +0200
Date:   Tue, 20 Dec 2022 21:15:24 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] gpiolib: of: stop exporting of_gpio_named_count()
Message-ID: <Y6IJzE9eWKl6MdvV@smile.fi.intel.com>
References: <20221219192016.1396950-1-dmitry.torokhov@gmail.com>
 <20221219192016.1396950-2-dmitry.torokhov@gmail.com>
 <Y6G9sOYhThlE3dGu@smile.fi.intel.com>
 <Y6H+kFR+vilCh8HH@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6H+kFR+vilCh8HH@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 10:27:28AM -0800, Dmitry Torokhov wrote:
> On Tue, Dec 20, 2022 at 03:50:40PM +0200, Andy Shevchenko wrote:
> > On Mon, Dec 19, 2022 at 11:20:13AM -0800, Dmitry Torokhov wrote:
> > > The only user of this function is gpiolib-of.c so move it there.
> > 
> > It's one liner used a single file, can we kill it completely?
> 
> It is being called from a couple of places there and documents how
> exactly we are counting GPIOs, so I would prefer to leave this helper as
> is.

Fair enough. However I think that even so it may be killed in the future.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


