Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01186C3252
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 14:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjCUNIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 09:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjCUNIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 09:08:52 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E5A1C302;
        Tue, 21 Mar 2023 06:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679404129; x=1710940129;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dDawhMbCoPJQU9jRIClAgTZfAFVmoWyY2z2wwL5eHyA=;
  b=GqzCeu03/ZTIEKERFU2O70yddSriKNL1iUZclaSN3M43q6e+znjqYjnN
   59ObRbmE1bm9l6+67a2u9xfUY3Sk4/9XoPeEZyIV+dWVpeYopmJX5jmcQ
   XrHKI5IPq7oaI8mgUet+S5bbovD7a7S6Bvr7bGghEsxdDWIJtXaJGVvag
   8q+UK+A7QiuXZRWbQL7h9q8rrOAuaoGQOxfd+yDMs9fjhi2A9VeVPaV1j
   FIJ2+OQbBJQ+9yzvIWM1fleCSdnbfoneb6for3f/UD9pDiO4fApI4bgxx
   OBtwoKQ1IRuc7TLyElNiC6XQ6De909DsXPPLtNWo16h3kldZKEfqdlgqn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="425209709"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="425209709"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 06:08:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="750552792"
X-IronPort-AV: E=Sophos;i="5.98,279,1673942400"; 
   d="scan'208";a="750552792"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 21 Mar 2023 06:08:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pebjJ-006ijj-1j;
        Tue, 21 Mar 2023 15:08:45 +0200
Date:   Tue, 21 Mar 2023 15:08:45 +0200
From:   "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
To:     "Winiarska, Iwona" <iwona.winiarska@intel.com>
Cc:     "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "fercerpav@gmail.com" <fercerpav@gmail.com>
Subject: Re: [PATCH] hwmon: (peci/cputemp) Fix miscalculated DTS for SKX
Message-ID: <ZBmsXYV6jkLiFmJz@smile.fi.intel.com>
References: <20230321090410.866766-1-iwona.winiarska@intel.com>
 <f2fe16cf-3838-df89-958f-c39d1bae81a1@molgen.mpg.de>
 <df6ab72faf9f1484f7f850ad7386f76b60e5bf02.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df6ab72faf9f1484f7f850ad7386f76b60e5bf02.camel@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 10:29:22AM +0000, Winiarska, Iwona wrote:
> On Tue, 2023-03-21 at 10:41 +0100, Paul Menzel wrote:
> > Am 21.03.23 um 10:04 schrieb Iwona Winiarska:

...

> > This is not aligned. Why not only use one space before the equal sign?
> 
> Yeah - same alignment problem is present in cpu_hsx and cpu_icx though, so I
> just followed along for skx to not stand out visually.
> So while I agree that alignment is broken here, I think it might be better to
> separate out the potential cleanup from the fix.

I agree with Iwona. If community wants a cleanup, it can be created in
a separate patch. For the fixes it's better to reduce the unrelated churn.

-- 
With Best Regards,
Andy Shevchenko


