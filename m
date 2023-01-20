Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A925867584B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjATPRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjATPRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:17:12 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E322D42;
        Fri, 20 Jan 2023 07:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674227831; x=1705763831;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1DKDhX2aS6+ehqAJu8VWeSS88MeJAdJ3MEj7/2+SAv8=;
  b=AVaDPTvRPOy1ayGkk7BSj2Sq3cb0hwiur1VYgxUwarM6FeDsB5rm/3me
   LgYb/QK/rxhZeh2eMwpV6tfOFAEB6TI8LEkFDVyy/sA56KJnxV8XC6Nir
   JUiskelsilSlkL0dStU9KCgUqNvkXzaZkdjn9QOSpIA+LIY4Iv4PUZ13B
   eeBE+YEL6/pYDQxaQbzM+F2GnCPiIkrntwRZ1LCtBPiB3YyFzfGhkcLt9
   lkKKbXgBm4O95BB3LDAsMwSOnKFCvzWrshDmjsa6ky9pN8pcy9VUYHccd
   WJHVJYK1foBG1ei19nf4aRWCMhPsGDl22kf57GhSJpet6LtywtQrN07JW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="387961875"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="387961875"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 07:17:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="723977921"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="723977921"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 20 Jan 2023 07:17:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pIt8b-00CHXa-2f;
        Fri, 20 Jan 2023 17:17:05 +0200
Date:   Fri, 20 Jan 2023 17:17:05 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Luca Ellero <l.ellero@asem.it>
Cc:     dmitry.torokhov@gmail.com, daniel@zonque.org,
        m.felsch@pengutronix.de, u.kleine-koenig@pengutronix.de,
        mkl@pengutronix.de, miquel.raynal@bootlin.com, imre.deak@nokia.com,
        luca.ellero@brickedbrain.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Input: ads7846 - always set last command to PWRDOWN
Message-ID: <Y8qwceKl6G1jh014@smile.fi.intel.com>
References: <20230120124544.5993-1-l.ellero@asem.it>
 <20230120124544.5993-3-l.ellero@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120124544.5993-3-l.ellero@asem.it>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 01:45:43PM +0100, Luca Ellero wrote:
> Controllers that report pressure (e.g. ADS7846) use 5 commands and the
> correct sequence is READ_X, READ_Y, READ_Z1, READ_Z2, PWRDOWN.
> 
> Controllers that don't report pressure (e.g. ADS7845/ADS7843) use only 3
> commands and the correct sequence should be READ_X, READ_Y, PWRDOWN. But
> the sequence sent was incorrect: READ_X, READ_Y, READ_Z1.
> 
> Fix this by setting the third (and last) command to PWRDOWN.

Provide a Fixes: tag?

> Signed-off-by: Luca Ellero <l.ellero@asem.it>

-- 
With Best Regards,
Andy Shevchenko


