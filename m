Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2256D6DF646
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjDLM6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjDLM6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:58:00 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109E2FC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 05:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681304262; x=1712840262;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3KZXaAgeQIkWxhc2/zF12AM1Dfx5Ji584vsX4NKGv8o=;
  b=Pb3Yd0FaU0VQG4BCUPwFePfN/XQdW5EymAiCBkC9/++qKne5m3toc+Dv
   PeAfoE0nVi5GHsJzcOgxxRR1I5keRDSb0LOQ/qQ/HAJ9HzMiciGle1wsL
   NDpbOUUl75+VeL30h1Ut5c9lCxFCMQIuuIbdXtyq+lE5QQZ3fMx+G41PS
   m9P8SJ5WORD23IWXMS+7DBIBWIXBD1YIR60cSmCBjpVSlTqWnwImZ/gPL
   19xvHBQZOl6Q+0RsIKGyi1OQUY8jpfXr2VdYKzceAmIZzTUQeQBJ5Hy+U
   FodXfVMulXnbTyJFIUcq07Fi4+kZE9wPFclQGSQaDgLPpPVBabUA06Yrp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="343889215"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="343889215"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 05:56:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="935102836"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="935102836"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 12 Apr 2023 05:56:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pma1k-00FwQB-13;
        Wed, 12 Apr 2023 15:56:44 +0300
Date:   Wed, 12 Apr 2023 15:56:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v1 1/1] kernel.h: Split out COUNT_ARGS() and CONCATENATE()
Message-ID: <ZDaqi1jE0Fkg5BSp@smile.fi.intel.com>
References: <20230411102454.85898-1-andriy.shevchenko@linux.intel.com>
 <20230411152119.c9bb83a8566e37f6d8dbc590@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411152119.c9bb83a8566e37f6d8dbc590@linux-foundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 03:21:19PM -0700, Andrew Morton wrote:
> On Tue, 11 Apr 2023 13:24:54 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > kernel.h is being used as a dump for all kinds of stuff for a long time.
> > The COUNT_ARGS() and CONCATENATE() macros may be used in some places
> > without need of the full kernel.h dependency train with it.
> > 
> > Here is the attempt on cleaning it up by splitting out these macros().
> > 
> > --- a/include/linux/kernel.h
> > +++ b/include/linux/kernel.h
> > @@ -13,6 +13,7 @@
> >  
> >  #include <linux/stdarg.h>
> >  #include <linux/align.h>
> > +#include <linux/args.h>
> 
> A more energetic patch would have included args.h into each file which
> calls COUNT_ARGS() and CONCATENATE(), and not included args.h into
> kernel.h.  And that appears to be very easy - only bpf uses these things?
> 
> In fact these macros are so weird and ugly I'd be inclined to move them
> into some bpf header so we don't have to see them again.  No
> args.h, which might avoid encouraging others to use them.

We have more users than one and a couple of users that reimplement this macro
under different names.

-- 
With Best Regards,
Andy Shevchenko


