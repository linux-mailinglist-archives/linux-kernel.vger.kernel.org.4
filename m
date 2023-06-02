Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB04572078C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 18:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbjFBQ3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 12:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235860AbjFBQ3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 12:29:05 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56B3B4;
        Fri,  2 Jun 2023 09:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685723343; x=1717259343;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HFHz9wlwFAEo7xyFHTfBnBYu2q+2T/i5wXGP+p9OpCA=;
  b=Ds8cdRRtjcnIyKCknq+ZIeiggcbVPqLw5Mc/zsn9bF16lGUK4rjo+qal
   7+nmRbGNkGykNHWLxNiSr2mCEvFkBBTJVoN6MOdq1Z1HloBFq5s7MSyrR
   sTwaFcopSLrRebLfdUSWmBWGIT8xjONUwioCCNjF2obfXAoqhjudgmQ2G
   aVAwyJUrRCdbhD5r+uSUKoInyD7JaZ9Ze+ghYlhmeWTAhUq7fhRlvpYxj
   H3iXjlwAevbvantpyUqN+p0Olkyjq0zuU8Ab/b1vNyyQNmTqk+pwxISib
   FFJICX2YqkqnROOMLa1WcBTLDwi1vMPX4feBeWBU34bwW/s5KFEqE22Wq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="336273024"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="336273024"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 09:29:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="852215941"
X-IronPort-AV: E=Sophos;i="6.00,213,1681196400"; 
   d="scan'208";a="852215941"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 02 Jun 2023 09:29:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q57e8-000hrn-2S;
        Fri, 02 Jun 2023 19:29:00 +0300
Date:   Fri, 2 Jun 2023 19:29:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/1] gpiolib: Do not unexport GPIO on freeing
Message-ID: <ZHoYzFPNrwwNpm93@smile.fi.intel.com>
References: <20230602162258.63853-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602162258.63853-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 07:22:58PM +0300, Andy Shevchenko wrote:
> Since the legacy exporting is gone with 2f804aca4832 ("gpiolib:
> Kill unused GPIOF_EXPORT and Co") there is no need to unexport
> GPIO on freeing. Remove that call.
> 
> Note, the other users of this functionality do that explicitly,
> except one SH boardfile which doesn't free GPIO anyways, so it
> is safe to drop the call.

Note, that this might be squashed with the above mentioned commit, because
I haven't checked current users I didn't do the removal in that patch.

But this will probably needs rebase which is not good thing process wise.
So, just my 2 cents in case.

-- 
With Best Regards,
Andy Shevchenko


