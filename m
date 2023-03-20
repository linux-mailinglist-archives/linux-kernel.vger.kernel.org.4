Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A6F6C1D4E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjCTRHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbjCTRHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:07:04 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F6A3928D;
        Mon, 20 Mar 2023 10:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679331726; x=1710867726;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yiv2o1xgkJKIW97HgBc4IdaI8YCn/dj8kY/wB9X9Iqw=;
  b=Wzx5++aH7Sfu/31SGEBmAZY/7z9aMh2EUuOj5178xMF88s+57JYom0kS
   YMNlB5DiowT0WP4DOHOMbeycLdUIBQaVdJiJ+lM7hMPYtXMP9+eCbkCPk
   9Fx64VCHKt9j6cWK4F3PR6lN5O+TRRcbVepF/TJ5h41IMCP74xBYb4MqP
   UtTmvD1HbRxPOAdPid1UBn/HEv7qh5qU/SXzkufykDqr5h167ICnpIw3y
   pmroXHWMUNbM0fJMYhg54M8MFrxII2ry++XrErXDK/QkYPfcBuG7G08Z9
   g69hz5gie+dH2vmJL6rCX2Y/VLDI5RXccMBUxZzOHYNJ31iebcAOUzbZc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="319116923"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="319116923"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 09:54:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="770264230"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="770264230"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Mar 2023 09:54:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1peIm0-006Lus-16;
        Mon, 20 Mar 2023 18:54:16 +0200
Date:   Mon, 20 Mar 2023 18:54:16 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-iio@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] counter: 104-quad-8: Utilize helper functions to
 handle PR, FLAG and PSC
Message-ID: <ZBiPuHvF78sM1vq+@smile.fi.intel.com>
References: <cover.1679149542.git.william.gray@linaro.org>
 <71496f9295e68388ce07f3051bf5882177be83c5.1679149543.git.william.gray@linaro.org>
 <ZBhRb+v/8+vSwjz6@smile.fi.intel.com>
 <ZBh8O5oOL0TB9wzT@fedora>
 <ZBh9cUwvV+hi5We8@smile.fi.intel.com>
 <ZBiBgI5mVHAg/59Y@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBiBgI5mVHAg/59Y@fedora>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 11:53:36AM -0400, William Breathitt Gray wrote:
> On Mon, Mar 20, 2023 at 05:36:17PM +0200, Andy Shevchenko wrote:

...

> After reading through the implementation for these functions I realized
> they are actually doing something different than what's happening here.
> The 104-QUAD-8 device exposes the 24-bit register by consecutive 8-bit
> I/O operations on the same address; however, the iomap_copy and regmap
> bulk functions operate on different addresses.

Ah, than we have ioreadXX_rep()/iowriteXX_rep() for that.

> I'm not sure if there really is a way to make the 104-QUAD-8 operation
> more generic for other drivers because it configures the current byte
> pointer through a separate register from the data register (all of this
> feel rather device specific), so I suspect keeping this function local
> to 104-quad-8 is best for now.

-- 
With Best Regards,
Andy Shevchenko


