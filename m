Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B99602BCF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 14:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiJRMcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 08:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJRMcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 08:32:03 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4868D27CD8;
        Tue, 18 Oct 2022 05:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666096323; x=1697632323;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=679yrLLfz5kJkADoDvJtXHkNCdTyNEeZjUBrx5uh7Gg=;
  b=X7IKGcoJjIBaQCxoOEvI/OEg3aMXzvhnTNAVyT0i+kXGdXUzjH63BOmk
   0Qpv5qnLwOE+cxhDWnSxouKQO58uMAm7UEoaBq6Hhj9ar23VIb10YqOCf
   MPCQ52B8DVqwk3as6DHiPQVgy+1gfljdslxS987k3yIXys8QCYuV45j8o
   2KypPNE3G4VwmkrGaWjx05lTZyIMDb75Gd+gRmaf1XUgwbC8aYs7AyX9B
   RhCyXjM9M7EixQRkh3nxyINGj54CrwR7dcikk7TLAT7wXnrI0tGcVs3GG
   npt8IXryVS5tiUdX6Qoxk0LFQYbx/L4cLNumQwfuZGTUjOcsOKEJyPov6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="289384271"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="289384271"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 05:32:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="733605367"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="733605367"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 18 Oct 2022 05:32:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1okllG-009M9O-2Q;
        Tue, 18 Oct 2022 15:31:58 +0300
Date:   Tue, 18 Oct 2022 15:31:58 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 00/10] gpiolib: more quirks to handle legacy names
Message-ID: <Y06cvrpcHn0jwZxU@smile.fi.intel.com>
References: <20221011-gpiolib-quirks-v3-0-eae9cc2ed0a1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011-gpiolib-quirks-v3-0-eae9cc2ed0a1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 10:41:01PM -0700, Dmitry Torokhov wrote:
> In preparation to converting several drivers to gpiod API, and to keep
> existing DTS working, this series adds additional quirks to locate
> gpio lines with legacy names.
> 
> Additionally the quirk handling has been reworked (once again) to pull
> all simple renames (ones that do not involve change of indices or other
> complex manipulations) into a single quirk with a table containing
> transformations. This should make adding new quirks easier.
> When using legacy names gpiolib will emit a message to nudge users to
> update DTSes (when possible).
> 
> Note that the last patch requires the following change from the OF tree:
> 
>         88269151be67 ("of: base: make of_device_compatible_match() accept const device node")
> 
> The change is also available in mainline - it has been merged in 6.1
> merge window.

I was wondering if we can use the approach that ACPI chose for itself,
i.e.  the separate data that can be filled by the corresponding driver
and then GPIO OF common code may use it. In that case each driver knows
the exact list of compatible strings and associated quirks.

-- 
With Best Regards,
Andy Shevchenko


