Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3357638F6A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 18:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiKYR4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 12:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiKYR4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 12:56:14 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDD0240A5;
        Fri, 25 Nov 2022 09:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669398974; x=1700934974;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dGozxIeI3Hdihd+DZCG3wMJNJscHR7IQT+pzisHO0dw=;
  b=PEHplHBWj5K4xgAKzId5N2yIhtdX/eWA7YUZGjuB8oCTOVaJnTeMHiHK
   z5zVXqmh4itKCT0A/yxyMLvPre8z1ffqdgAnX1gg9mxqIHpopCclhiSVh
   J7fF60z3fWkRmyWHJZcB8YRoyHq2UsSqs+aSEfTjlFDr6UowvrqqsAKlL
   731hxfCVb8+ezrD5/Nd+mV7WHVv+2onAHhvM62kNHHv4HdobxOP3Y4V68
   Y8Su0/X3GRKqhM4N2xR+j3bQc0RJHFjy1Epi3XKa7RUSzRImAxyjF0O4A
   zvoi5/g5jq8DBNHSctL2pMf9mX5/fvQWLHbbuiREQELg2A+P87ZMyGbvk
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="297876025"
X-IronPort-AV: E=Sophos;i="5.96,194,1665471600"; 
   d="scan'208";a="297876025"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 09:56:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="817198720"
X-IronPort-AV: E=Sophos;i="5.96,194,1665471600"; 
   d="scan'208";a="817198720"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 25 Nov 2022 09:56:11 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oycvq-00HLBW-0p;
        Fri, 25 Nov 2022 19:56:10 +0200
Date:   Fri, 25 Nov 2022 19:56:09 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpiolib: cdev: fix NULL-pointer dereferences
Message-ID: <Y4EBubusGqo4IroP@smile.fi.intel.com>
References: <20221125153257.528826-1-brgl@bgdev.pl>
 <Y4DsTxPH1tv5eEwf@sol>
 <CAMRc=Me83-_oiGEmwy4BUrzLEMT6ZsoMwWYsb6iXwg19yHMHdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Me83-_oiGEmwy4BUrzLEMT6ZsoMwWYsb6iXwg19yHMHdQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 05:48:02PM +0100, Bartosz Golaszewski wrote:
> On Fri, Nov 25, 2022 at 5:24 PM Kent Gibson <warthog618@gmail.com> wrote:

...

> Then at the subsystem level, the GPIO device struct would need a lock
> that would be taken by every user-space operation AND the code
> unregistering the device so that we don't do what you described (i.e.
> if there's a thread doing a read(), then let's wait until it returns
> before we drop the device).

It's called a reference counting, basically you need to get device and then
put when it makes sense.

> This wouldn't fix the case in which the same situation happened in a
> kernel driver but crashing the kernel from within is a much lesser
> offense than allowing user-space to crash it.

-- 
With Best Regards,
Andy Shevchenko


