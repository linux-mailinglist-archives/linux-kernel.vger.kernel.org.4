Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB15640880
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 15:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbiLBOdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 09:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbiLBOdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 09:33:12 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D446637C;
        Fri,  2 Dec 2022 06:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669991591; x=1701527591;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/6k6mNVmtzB/jl/p5N0Wi6v2aL60rnZtwGnJuRkORpM=;
  b=m3HphLeUYR0TDa0tPexFXL7fTQIMlB2d0qZJh2NtqqGFjxcjav6mRGYz
   0RcIYSwBJwD/0ceNpif10LMCR9wpae3zDcVwD5MWsK96gXqSPWGa4Hswp
   HLJIttK79jaN8Ab5aiGTVqYr0e21N9IorB3OWqBrN7hu2Jxt2wLXsiPl9
   BaVgbtpBLM/RbdoheQ+iQWelkZFhGtKoFTRKIOLYm+6uZRJ5ywxmJhWYu
   9U1Ns1xYnhQmjvchz6ymyJ2TeAFQrOXGj9BM8qRhk8LJglEP2OhRRYuYy
   lS4yTVKo7BQxYZC8/ZQmjxdS8JDOY5A4b9kHnLaDl/dgDHY0LnW/RDWYn
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="317109989"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="317109989"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 06:33:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="890164985"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="890164985"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 02 Dec 2022 06:33:08 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p176B-003Vr6-0q;
        Fri, 02 Dec 2022 16:33:07 +0200
Date:   Fri, 2 Dec 2022 16:33:06 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Nick Hainke <vincent@systemli.org>
Cc:     linux-next@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: fix compiling when CONFIG_GPIO_CDEV_V1 is not
 defined
Message-ID: <Y4oMolxWW7H15ayK@smile.fi.intel.com>
References: <20221202140454.273333-1-vincent@systemli.org>
 <Y4oMCYksMaQ6KYwU@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4oMCYksMaQ6KYwU@smile.fi.intel.com>
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

On Fri, Dec 02, 2022 at 04:30:33PM +0200, Andy Shevchenko wrote:
> On Fri, Dec 02, 2022 at 03:04:54PM +0100, Nick Hainke wrote:

...


> > drivers/gpio/gpiolib-cdev.c:1468:16: error: implicit declaration of
> >  function 'call_ioctl_locked' [-Werror=implicit-function-declaration]

> > drivers/gpio/gpiolib-cdev.c:1503:16: error: implicit declaration of
> >  function 'call_poll_locked'; did you mean 'wake_up_all_locked'?
> >  [-Werror=implicit-function-declaration]

> > drivers/gpio/gpiolib-cdev.c:1566:16: error: implicit declaration of
> >  function 'call_read_locked'; did you mean 'xa_head_locked'?
> >  [-Werror=implicit-function-declaration]

> Above is a bit too noisy for the commit message. It can be trimmed 3x times.

To be precise leave only the above and make them as is (i.e. unwrapped even
if they are so long), because it's a citation from the compiler.

-- 
With Best Regards,
Andy Shevchenko


