Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39730633D06
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 14:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbiKVNBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 08:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbiKVNAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:00:55 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3D661BAE;
        Tue, 22 Nov 2022 05:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669122054; x=1700658054;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MmhbBkqNMvSGc76GKa0mJ/p1EKwUawSKuKvJH3qKXFA=;
  b=MFfL2EZ901M+nnDfMD15Y7DqyLHvvcrUZVpXyYNZDfCetvkVqbsBs6UL
   QhrEg7mjSYqsif0NODFCMCRppw7SWj9ByZ29oVzGzTymV5N4mHr+L2DbS
   q/UEBZUwlD0VvTZG374Tlpop9wn6Tg+1UwGvSx3ANxx9YKinnk6WqOhMR
   c1JUpEdZuMoFxdrrfUKAizxegtUW+ORm0SahebpdrSsf2VhBPhkcpkQXj
   F77eQ3ZEJadtoTHW9kzJ873GJbsHftlifUuLG9aS0Q3OLkJGk1Rl+DLr6
   GZML5uYJ7c5dqMXD7HQVFJ9wWOmGcSyvigbTbTf1n8A1WlFX/D4fu3kKM
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="315626941"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="315626941"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 05:00:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="747342883"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="747342883"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 22 Nov 2022 05:00:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oxStJ-00Fpwi-3B;
        Tue, 22 Nov 2022 15:00:45 +0200
Date:   Tue, 22 Nov 2022 15:00:45 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v5 0/7] pinctrl: intel: Enable PWM optional feature
Message-ID: <Y3zH/etMuIQ5l+SK@smile.fi.intel.com>
References: <20221117110806.65470-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117110806.65470-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 01:07:59PM +0200, Andy Shevchenko wrote:
> 
> This is a continuation of the previously applied PWM LPSS cleanup series.
> Now, we would like to enable PWM optional feature that may be embedded
> into Intel pin control IPs (starting from Sky Lake platforms).
> 
> I would like to route this via Intel pin control tree with issuing
> an immutable branch for both PINCTRL and PWM subsystems, but I'm
> open for other suggestions.
> 
> Hans, I dared to leave your Rb tags, however the patches are slightly
> differ, because of the Uwe's suggestion on how to handle the missing
> headers. I hope you are okay with that. If not, please comment what
> must be amended then.
> 
> Uwe, the patches 3 and 6 still need your blessing.

Uwe, do you think they are ready to go?

-- 
With Best Regards,
Andy Shevchenko


