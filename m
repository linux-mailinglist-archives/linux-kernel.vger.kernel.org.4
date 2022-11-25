Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECDB638D68
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 16:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiKYPUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 10:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiKYPUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 10:20:45 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BB72036D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 07:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669389644; x=1700925644;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ie9Cipr13cWq7X2y/HN0MNBOBwDL9NwTsg4HclRvEvs=;
  b=YGmep14RtjbGl1bn30J3k+cc1mPV5MxlIodQnzQbgFy5g9vQJTXApFIj
   yhX5EYXLk/0HcgjAO8K/cAfZfkH58lIuPDOlIBkZ1IuyWAamm/yGFYBoN
   ZaXoPDxBjOCVy881qyvTo7V6wmjUGK3uABaxmZa6D1vXCYllnMxJk4ceA
   9nqKjW0u9LRWo6JcTW/VrfiyaqIu6+b5AzjNWlSJLQBpvDq58A0UPOwA3
   BZPHD31IGa2unrpEfxHLfWiMxo2c/C0LMvL1VZAZpXWZhhER5xncehESz
   1Z11s54deoIGPssmRjD1a88+kj8EXOirGLKR2XfZz5jyhYnq6Z4NGxCxo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="314534809"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="314534809"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2022 07:20:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="593243240"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="593243240"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 25 Nov 2022 07:20:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oyaVF-00HHSM-0J;
        Fri, 25 Nov 2022 17:20:33 +0200
Date:   Fri, 25 Nov 2022 17:20:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        'Joe Perches' <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/1] Slightly relax the type checking done by min() and
 max().
Message-ID: <Y4DdQIMiFGk7YYcJ@smile.fi.intel.com>
References: <cfc6c0f0fd4c4724890be8a8397c2cbe@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfc6c0f0fd4c4724890be8a8397c2cbe@AcuMS.aculab.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
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

I don't buy this. What's exactly wrong with this code?

-- 
With Best Regards,
Andy Shevchenko


