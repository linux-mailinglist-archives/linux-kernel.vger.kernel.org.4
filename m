Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DC6638F4D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 18:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiKYRsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 12:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiKYRsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 12:48:07 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7721CB20
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 09:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669398486; x=1700934486;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lFnwMy7tH/1jjCK7gvvHwna2ISaJXAsxVKp7FJgg9HE=;
  b=c0R2r2sebmCM/xA+Dx4hREGczhaQSSn3WFhDxow6ilGHsjuo/MpoByny
   ep7OMRMu9H3azh8pTOjSc8+e7a79SXx4/Cy5KeF/rfAU7EszGcmVQJgC3
   hPahVcHXmUcFKyvRwCFeCBK3PHjt5CpzoSc3ZfrTX3NeP9TUTbiZUVggm
   HzzaU+j+GjtP8PJWx2f1c7eMnMtnx3BN32VgZpmYeGAwU7DRA8AAeXa3/
   IcFSXpo9xgUBoXN2IHJ8dfxMCBFkd0pwI3c6qVHkqCj7AZGh+dHEiHnKf
   wFB7mmwjWmIiN1lNQWXUyzJKEJgozYztYCXQRnsz3Bz0Jb2ABgH6i6WSz
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="315677130"
X-IronPort-AV: E=Sophos;i="5.96,194,1665471600"; 
   d="scan'208";a="315677130"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 09:48:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="971631144"
X-IronPort-AV: E=Sophos;i="5.96,194,1665471600"; 
   d="scan'208";a="971631144"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 25 Nov 2022 09:48:03 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oycnx-00HKzG-1l;
        Fri, 25 Nov 2022 19:48:01 +0200
Date:   Fri, 25 Nov 2022 19:48:01 +0200
From:   'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        'Joe Perches' <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/1] Slightly relax the type checking done by min() and
 max().
Message-ID: <Y4D/0dqOODs4ZHQM@smile.fi.intel.com>
References: <cfc6c0f0fd4c4724890be8a8397c2cbe@AcuMS.aculab.com>
 <Y4DdQIMiFGk7YYcJ@smile.fi.intel.com>
 <7e594ad64e444d448c747688b8f28249@AcuMS.aculab.com>
 <Y4DmFfj6G6+niZ+t@smile.fi.intel.com>
 <0b38ced96519407e95962aef2771bbc6@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b38ced96519407e95962aef2771bbc6@AcuMS.aculab.com>
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

On Fri, Nov 25, 2022 at 04:14:58PM +0000, David Laight wrote:
> From: 'Andy Shevchenko'
> > Sent: 25 November 2022 15:58
> > On Fri, Nov 25, 2022 at 03:27:07PM +0000, David Laight wrote:

...

> > Any better example, please?
> 
> How about:

Better, indeed.

> data_size = min_t(u16, buf_size, len);
> 
> https://elixir.bootlin.com/linux/v6.1-rc6/source/kernel/printk/printk_ringbuffer.c#L1738
> 
> Now, maybe, you could claim that buf_size > 64k never happens.
> But the correct cast here is u32 to match buf_size.
> len (being u16) will be promoted to int before the compare.
> 
> Just search the kernel for "min_t(u8," or "min_t(u16," while some might
> be ok, I really wouldn't want to verify each case.
> 
> If you look hard enough there are also some:
> 	u32_var = min_t(u32, u32_val, u64_val);
> where the intent is to limit values that might be invalid for u32.

Wouldn't be better to actually issue a warning if the desired type is shorter
than one of the min_t() arguments?

Then you go through all cases and fix them accordingly.

Blindly relaxing the rules is not an option in my opinion.

-- 
With Best Regards,
Andy Shevchenko


