Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D13622951
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiKIK4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiKIK4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:56:00 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F2529CB8;
        Wed,  9 Nov 2022 02:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667991276; x=1699527276;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kZDUrGxLZXD8ZS03E/DY8j/TP1l3/jEAXlKHEYjBUD8=;
  b=NZOhVjsvKITQbu1GuC4+LuuWB+b1AK/FeoxM1QTVN5Cx89U3HNl7PIaE
   UV3w6NF3f726ICqheZVsuBh2WnmNLT7+/aaJwFpI4KoOWrc3xEWQtZSjQ
   uuCr1Qhju/F/Ld/FdlXBlf9XbbwaWpf3t1T5FLxnDuGtgOxq4lrxE3OJC
   qzY6qXzN3tovqMLro2hEk9Q7vJPp0ulN5QOigk70pwMOTTOC3+ubKeGob
   kxJ4HIzoq2td7lHM0iUG29G5UQa3r1Wk4xCl+TU72i3hzIl9a/MJeC44A
   VYCq4VUr+2X/X8Ejvks91o1Mj87tPng89JFndzGZzJ0YCHBqNPrwu7AtN
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="309658674"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="309658674"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 02:54:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="811591459"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="811591459"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 09 Nov 2022 02:54:32 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1osij0-009huC-0s;
        Wed, 09 Nov 2022 12:54:30 +0200
Date:   Wed, 9 Nov 2022 12:54:30 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     chengwei <larry.lai@yunjingtech.com>, lee@kernel.org, pavel@ucw.cz,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
        noah.hung@yunjingtech.com, Javier Arteaga <javier@emutex.com>,
        Nicola Lunghi <nicola.lunghi@emutex.com>
Subject: Re: [PATCH V3 2/3] pinctrl: Add support pin control for UP board
 CPLD/FPGA
Message-ID: <Y2uG5jrYeadqMNav@smile.fi.intel.com>
References: <20221109090957.13167-1-larry.lai@yunjingtech.com>
 <20221109090957.13167-3-larry.lai@yunjingtech.com>
 <CACRpkdZQ7FCtLPEioWXn+MXQhnpuu-EY+CjhEeKqBe=Bvq777g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdZQ7FCtLPEioWXn+MXQhnpuu-EY+CjhEeKqBe=Bvq777g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 10:27:59AM +0100, Linus Walleij wrote:
> On Wed, Nov 9, 2022 at 10:11 AM chengwei <larry.lai@yunjingtech.com> wrote:

...

> > +config PINCTRL_UPBOARD
> > +       tristate "UP board FPGA pin controller"
> > +       depends on ACPI
> > +       depends on MFD_UPBOARD_FPGA
> > +       depends on X86
> 
> This is Andy territory as it is x86 and ACPI but...

It seems they forgot paying the respect to the reviewers by Cc'ing them.

...

> So this looks like it should be uncommented and used or deleted?
> It just looks unfinished, and this patch is not an RFC.

I'm wondering why it has v3 and not RFC in the Subject. So, no need to spend
time right now in reviewing this.

-- 
With Best Regards,
Andy Shevchenko


