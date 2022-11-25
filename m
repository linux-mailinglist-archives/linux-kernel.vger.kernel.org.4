Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA67D638D5C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 16:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiKYPR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 10:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiKYPR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 10:17:57 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740EB1F606
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 07:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669389476; x=1700925476;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TA+1Ns2zQjOmdGxjxZll6kdn2tclvA1e9U9LASRu4J4=;
  b=GW+U/ZXI/RxAsU1HQc+xac3Bzjwzdy3XOsxfDwjsxTJVhDiYZMvT4yMe
   69HlzlZaWpO5Dt/XrFv6zYYEiPQRpuknDWM1tdIYP1ccccBiXqnMhxymQ
   yiZrzqUb3bktIUla4QLCAzK8DauoRtd4qM7l66P2gS+iTWHgyTzOh0ANG
   pk7/qLRRA8/FetuAErpj8H9+JwFlxMefRAyyxZ3C7quvralFz0xfo2Lex
   lopK8ot81613YrJao2Z8jMy+EAzNjRcfUnPnLG2QurDM1GhnI7KfvcVYE
   sXPa+G/yCDobpaqey+zxhVF5JP0b9GkA8EK59ihEY9rtRnZrGGFuzUBDi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="313198006"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="313198006"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 07:17:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="817166937"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="817166937"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 25 Nov 2022 07:17:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oyaSc-00HHPP-32;
        Fri, 25 Nov 2022 17:17:50 +0200
Date:   Fri, 25 Nov 2022 17:17:50 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        'Joe Perches' <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/1] Slightly relax the type checking done by min() and
 max().
Message-ID: <Y4Dcnha/JYoRl4HH@smile.fi.intel.com>
References: <cfc6c0f0fd4c4724890be8a8397c2cbe@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfc6c0f0fd4c4724890be8a8397c2cbe@AcuMS.aculab.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 03:00:40PM +0000, David Laight wrote:
> The min() and max() defines include a type check to avoid the unexpected
>   behaviour when a negative value is compared against and unsigned value.
> However a lot of code hits this check and uses min_t() to avoid the error.
> Many of these are just plain wrong.
> 
> Those casting to u8 or u16 are particularly suspect, eg:
> drivers/usb/misc/usb251xb.c:528:
> 		hub->max_current_sp = min_t(u8, property_u32 / 2000, 50);
> 
> This patch does two changes:
> - Replace typeof(x) with typeof((x) + 0) to promote char/short to int.
> - Add an (int) cast to constants between 0 and MAX_INT so the compiler
>   doesn't promote the 'other side' of the comparison to an unsinged type.
>   If this is done the type test is arranged to always succeed.
> 
> The following can also be done (with some lateral thought):
> - Allow all comparisons where both types are signed. 
> - Allow all comparisons where both types are unsigned. 
> - Allow comparisons where the larger type is signed.
> 
> In addition most of the min_t() calls are there to compare a signed type
> (that holds a non-negative value) with an unsigned value.
> The definition:
> #define min_unsigned(x,y) min((x) + 0u + 0ull, (y) + 0u + 0ull)
> will do an unsigned comparision without 'accidentally' masking off
> any non-zero high bits.
> 
> With those extra changes there can be a 'duck shoot' on min_t().

You have an issue with your email setup, i.e. you send two independent messages
(not a chain). It probably shows that either you don't use `git send-email` for
sending patch, or you missed --thread option to it.

-- 
With Best Regards,
Andy Shevchenko


