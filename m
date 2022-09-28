Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E2D5EDE5D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbiI1OBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiI1OBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:01:43 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7218A4D240;
        Wed, 28 Sep 2022 07:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664373702; x=1695909702;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hpkQCvDQ+Bp2dIyGqfUgYRvKhQSfa6bsWYPsfUPAih0=;
  b=SzSOymOXn1TR8DUjOWXS85C2qjyUfaTCCYC/pVNNtJuVcgNYqjFduFp0
   TA9pENfocM4xGoxxk/DRHWdGlVlu5RC+WMHxt8RXVomx7PBpe/2La7Fev
   bLSvaoK0cn3D/nfEAoBi8+y1gPRiDBX6sbzycjZNDSWTEERK4mBJ/eqoc
   qZOnR8E0yrOHXY7GZkku6tyXb8pCe6xAZGe+2UTT+ub7TJc5pY+2CARTw
   7aS6pBiU4//0W6p24SZqcN4vr2o5ZLB6ZMggfqfhGs23ASveKpycpx3IG
   DNu3EuWw4vPQ9Khl6bIeb1IXB3z9MrZ/AwqBZogJu7EswGaQzINR/y1eq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="302519619"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="302519619"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 07:01:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="764298336"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="764298336"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 28 Sep 2022 07:01:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1odXd3-008xR7-1K;
        Wed, 28 Sep 2022 17:01:37 +0300
Date:   Wed, 28 Sep 2022 17:01:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 1/4] pwm: sysfs: Switch to DEFINE_SIMPLE_DEV_PM_OPS()
 and pm_sleep_ptr()
Message-ID: <YzRTwSzQ9EAb+DT0@smile.fi.intel.com>
References: <20220826170716.6886-1-andriy.shevchenko@linux.intel.com>
 <YzQ+sYdl2HR/4fNi@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzQ+sYdl2HR/4fNi@orome>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 02:31:45PM +0200, Thierry Reding wrote:
> On Fri, Aug 26, 2022 at 08:07:13PM +0300, Andy Shevchenko wrote:
> > Using these newer macros allows the compiler to remove the unused
> > structure and functions when !CONFIG_PM_SLEEP + removes the need to
> > mark pm functions __maybe_unused.

> Applied, thanks.

Thanks and thank you for the review. It would be nice if you can check PWM LPSS
series [1] as well and another PWM related patch [2] I sent.

[1]: https://lore.kernel.org/linux-pwm/20220927162421.11052-1-andriy.shevchenko@linux.intel.com/
[2]: https://lore.kernel.org/linux-pwm/20220927172258.62418-1-andriy.shevchenko@linux.intel.com/

-- 
With Best Regards,
Andy Shevchenko


