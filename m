Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDEC5BEC41
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 19:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiITRrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 13:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiITRr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 13:47:28 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A846E65574;
        Tue, 20 Sep 2022 10:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663696044; x=1695232044;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7paNFYGOegGwNWKM0I1JzPA7eZal509/HcIVxSQt/mw=;
  b=kq53lbS6k5JYB9TufUMtKicZITTrvtW9tKWRirdbtEqGWkh4GHTQBaxx
   +lJ3PtbLozG/GWxz7VPZXJ5+Vj7doNNmKHFwlqnnH8Cs/bs+r0CEmzNAn
   pntGORpDNVw04rOhD08XvzR0UtU7azo6UqFylmVQ8OQiIUwjOcprqkvst
   czyDlqGAKON5Gdzf6KJYzDmlGi+ESrWVkJAAstQDy5MYdyhto0Uw0MdAt
   WKYWabFrqm9obrumzJiFR9hWU6D9UpANPIc+kUQCZwnB/VS5wG61+2jO8
   2eFazTEL0x4kj26bfYD7nj+cLXrrR4fs64NfnbdnGBq2//sTuX/0SU1kO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="363728542"
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="363728542"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 10:47:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="649687156"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 20 Sep 2022 10:47:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oahL7-0059eA-11;
        Tue, 20 Sep 2022 20:47:21 +0300
Date:   Tue, 20 Sep 2022 20:47:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: cdev: add fdinfo output for line request file
 descriptors
Message-ID: <Yyn8qABbRDGYAnnv@smile.fi.intel.com>
References: <20220920135435.15593-1-brgl@bgdev.pl>
 <Yyn2HEBPPWlJ3E0W@smile.fi.intel.com>
 <Yyn4eUKCOSxcLKdi@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yyn4eUKCOSxcLKdi@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 08:29:29PM +0300, Andy Shevchenko wrote:
> On Tue, Sep 20, 2022 at 08:19:25PM +0300, Andy Shevchenko wrote:
> > On Tue, Sep 20, 2022 at 03:54:35PM +0200, Bartosz Golaszewski wrote:

...

> > Also don't forget that sizes over PAGE_SIZE in sysfs sometimes problematic and
> > racy.(the commit 888be6067b97 ("ACPI: sysfs: Fix a buffer overrun problem with
> > description_show()") for the reference).
> 
> This is not the commit I wanted to point to... But suddenly can't find easily
> the one I remembered happened in the kernel.

Found the one:
00ee22c28915 ("PM / wakeup: Use seq_open() to show wakeup stats")

-- 
With Best Regards,
Andy Shevchenko


