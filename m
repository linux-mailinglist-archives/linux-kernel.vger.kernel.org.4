Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FAB617BD4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 12:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiKCLo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 07:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiKCLox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 07:44:53 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCE4DB3;
        Thu,  3 Nov 2022 04:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667475893; x=1699011893;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i1ewGVqgpLa0I9aDl7AaVHshZOxjkLCv6NBjBF5OKM8=;
  b=BLVVYaU+tVDW4ykWwDwW+qgLQPeMWKKTlczK5Sb95TPg6hKT1yEneY+0
   7kLuhU5XsCs2R0HYQuT32ChGymBi2u/yB4hjXe/K9mFpCQ97o6amXEiv3
   1kMWPy2KTdQrtaLlQKa/kKnKOrXRwWUCTuhO7VldseMvrtNeT6HlkzGTk
   47W9KonZELT6L8E903AllrvLlJekSBGTwxjYRnjjcUc5iuBHhF0YyqgM3
   qPz2ecBqM4DKrNi7pfKepX/SvJba26aJ5YUvzT/Wd0L1FYme/AGMj7Kw0
   fuPSQpJ7EOb/DM7i8kmGhG3YIdVKX8zumVgWYFoTlIwvKJc672PiOMy1v
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="310775048"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="310775048"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 04:44:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="740158650"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="740158650"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 03 Nov 2022 04:44:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oqYeH-006gqi-3C;
        Thu, 03 Nov 2022 13:44:41 +0200
Date:   Thu, 3 Nov 2022 13:44:41 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/2] pinctrl: intel: Use temporary variable for struct
 device
Message-ID: <Y2OpqUKHf7ksL660@smile.fi.intel.com>
References: <20221102152915.22995-1-andriy.shevchenko@linux.intel.com>
 <Y2NtQgRwkUlU5bMw@black.fi.intel.com>
 <CAHp75Vd520HKL8_JQrDr7JBEVf1rDzJC=T=mceZvovq8AwrUVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vd520HKL8_JQrDr7JBEVf1rDzJC=T=mceZvovq8AwrUVg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 12:54:23PM +0200, Andy Shevchenko wrote:
> On Thu, Nov 3, 2022 at 9:26 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > On Wed, Nov 02, 2022 at 05:29:14PM +0200, Andy Shevchenko wrote:

...

> > Anyway, no feelings about this so feel free to add,
> >
> > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> >
> > for both patches.
> 
> Thank you!

Pushed to my review and testing queue, thank you!

-- 
With Best Regards,
Andy Shevchenko


