Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3497A637E04
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiKXRGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiKXRG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:06:27 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFCB5C0DF
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 09:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669309586; x=1700845586;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qockOsAMoDOBx6eKZclTWGMF3laYhg4U+GQm6e2dPFU=;
  b=dFI0aTe/68kJiFIsBvPrziBnfRW2q9PpQYzzgc2zBqdYxpQK8X6SVh9N
   eG9ON4T3MMO9DQy+C1FDl7RZbeoEpqQ0NdozgSSHOfqv/URvi2TzySlaQ
   FHa+JiOb2XMkINf1tB9np38ZYI0/flTaAC5mdsGEv7wRyhPSFPu07+14Z
   AWM9fExE+yt1SzkCm396J7SoHW+DlCVEqlexqvPAKV2J8FVtNjby5tt4c
   Qmfeg3SCAg3PEW8JyzpS/0eyNBewufY4YJ8wUkhiPsLNcejKY/xvfjFoO
   40kARP3W7EeH+ziZCIfNrtxQWCUwWE1D4hEmU8q2ay/tGV6DXpF9KRoM0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="315487889"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="315487889"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 09:06:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="767133180"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="767133180"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 24 Nov 2022 09:06:23 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oyFg5-00Gr1A-2e;
        Thu, 24 Nov 2022 19:06:21 +0200
Date:   Thu, 24 Nov 2022 19:06:21 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        hpa@zytor.com
Subject: Re: [PATCH v3] x86/rtc: Remove __init for runtime functions
Message-ID: <Y3+kjSupFGY4jMiX@smile.fi.intel.com>
References: <af226986-c6ba-5192-4544-b878fd3140c8@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af226986-c6ba-5192-4544-b878fd3140c8@nokia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 05:57:30PM +0100, Matija Glavinic Pecotic wrote:
> set_rtc_noop, get_rtc_noop are used runtime, therefore need init removed.
> Crash was observed on x86 platform where cmos rtc is unused and disabled
> via device tree. Function was triggered from ntp: sync_hw_clock, although
> CONFIG_RTC_SYSTOHC=n, however sync_cmos_clock doesn't honour that.
> 
>   Workqueue: events_power_efficient sync_hw_clock
>   RIP: 0010:set_rtc_noop
>   Call Trace:
>    update_persistent_clock64
>    sync_hw_clock
> 
> Fix by dropping __init and making set/get_rtc_noop available runtime.
> 
> Fixes: c311ed6183f4 ("x86/init: Allow DT configured systems to disable RTC at boot time")
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Side note: seems you sent this not using `git send-email ...`
(I see my @intel.com rather than @linux.intel.com in the Cc list).

But at least the Cc list looks closer to what MAINTAINERS says.

And you forgot to make it clear that a) it's a resend, by altering
--subject-prefix, and b) mentioning this in the changelog.

-- 
With Best Regards,
Andy Shevchenko


