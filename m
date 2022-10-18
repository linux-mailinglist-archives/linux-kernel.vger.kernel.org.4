Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70410602BA7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 14:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiJRMXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 08:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiJRMXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 08:23:50 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85F9175BC;
        Tue, 18 Oct 2022 05:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666095827; x=1697631827;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1Bqc3BUNVg21trt++6fEDZWARJxHdRb9XbV3KjHO0Mo=;
  b=kvbI1oe0G+NadwBoV/oNi4DQlIOjHX3fm4mY9aQnQQuykF5SPMNF5M/U
   jPF5QHknEhZRR5qt9MTxjSiamFkQxb/g1C8wSIVGayBeC2HWH9hQgIZgT
   gsuAG5d5iHfv9AhEy+SBoPehznoa33YMcAKd4grZ/raLB3rHmjlu8CVF+
   J+742/zNbfRo9Tr80sXNnBMrPqScxS4i1CLVlid23eMOh9ejU5lGJorMb
   N1CB8+2nm+JcY6oe5a3Ogi5GiGDtUuQtC9RNpaW+c+8ewkNy0B6Ofe9HJ
   fvuzsAvKzdrYF+qvKlqY4pu2+fyohWpyAdPOTQxVRBkGJlEerUFQnAnRo
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="307172601"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="307172601"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 05:23:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="659765811"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="659765811"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 18 Oct 2022 05:23:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1okldG-009Lxb-2g;
        Tue, 18 Oct 2022 15:23:42 +0300
Date:   Tue, 18 Oct 2022 15:23:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 6/6] spi: pxa2xx: Switch from PM ifdeffery to pm_ptr()
Message-ID: <Y06azpyRsqISBYoj@smile.fi.intel.com>
References: <20221017171243.57078-1-andriy.shevchenko@linux.intel.com>
 <20221017171243.57078-6-andriy.shevchenko@linux.intel.com>
 <20221018101452.0000001c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018101452.0000001c@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 10:14:52AM +0100, Jonathan Cameron wrote:
> On Mon, 17 Oct 2022 20:12:43 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Cleaning up the driver to use pm_ptr() macro instead of ifdeffery
> > that makes it simpler and allows the compiler to remove those functions
> > if built without CONFIG_PM and CONFIG_PM_SLEEP support.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> FWIW I like these - so drive by review.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> I think you could change the handling of !pm_runtime_suspended()
> to use pm_runtime_force_suspend() and equivalent for resume path.
> I haven't checked that closely though - just looks like a typical
> usecase for those functions that are hardened against some of
> the corner cases that can occur in interactions between different
> forms of pm.

Thanks for an advice. Wouldn't it be matter of a separate change?

-- 
With Best Regards,
Andy Shevchenko


