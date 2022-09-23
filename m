Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890455E7DF4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbiIWPLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbiIWPLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:11:03 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276C4132D5B
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 08:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663945861; x=1695481861;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vd0xsX3fKUl3hM0m74uKnSRNDfGQc4zIVA6EdBvgBgQ=;
  b=QfZ/ST6CUw/675RhnkS2UX8eYkl618MBPW0BauLrk/rr99eZmB0wAU8P
   oahL9RFe2fi5lSd2hJBqin5dsTwiE5cIwhxzg5WJJqayREziBUaBkTFDv
   K8YruhTEgQP9tosKiJDaLQJBL2O1oHgIeI8n6ysB7O/ty0Aw2Fc0lzLPb
   lEpWrJnLsh/CVU7uQmpxqHOisMsplE+NQGZa15sLQjvrABAmRy2x3QN4h
   0HfmjYfQWdvqsJRpjl1BM0FztlZFqm/JV6Eg+KcXnW6ksnN0LX1gVeRTr
   7fxKBwvpsT5YZez9FI1MoCtw1A7y9JyrC1UaJHYVz2y7y53EUwk5K3KjQ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="362424535"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="362424535"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 08:11:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="571403496"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 23 Sep 2022 08:10:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1obkKO-006Vwk-1X;
        Fri, 23 Sep 2022 18:10:56 +0300
Date:   Fri, 23 Sep 2022 18:10:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] minmax: clamp more efficiently by avoiding extra
 comparison
Message-ID: <Yy3MgMhYDFYnLAV/@smile.fi.intel.com>
References: <20220923100621.3888015-1-Jason@zx2c4.com>
 <Yy2MDWCHTW0M3Z6i@smile.fi.intel.com>
 <CAHmME9osJiKg8-o-OdfCPS6t_fZ=zgGKZdy0CgybaK2NDv8XLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9osJiKg8-o-OdfCPS6t_fZ=zgGKZdy0CgybaK2NDv8XLA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 12:40:47PM +0200, Jason A. Donenfeld wrote:
> On Fri, Sep 23, 2022 at 12:36 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Fri, Sep 23, 2022 at 12:06:21PM +0200, Jason A. Donenfeld wrote:
> > > Currently the clamp algorithm does:
> > >
> > >       if (val > hi)
> > >               val = hi;
> > >       if (val < lo)
> > >               val = lo;
> > >
> > > But since hi > lo by definition, this can be made more efficient with:
> >
> > It's strongly speaking, but we have to proof that, right?
> > So, while I haven't checked the code, this change should also
> > include (does it?) the corresponding compile-time checks (for
> > constant arguments) in similar way how it's done for GENMASK().
> >
> > Otherwise I have no objections.
> 
> I think most cases are with compile time constants, but some cases are
> with variables. What should we do in that case? Checking variables at
> runtime incurs the same cost as the old code. I guess we could do this
> fast thing for constants and the slower old thing for non-constants?
> Or not do either, keep this commit as is, and just accept that if you
> pass bogus bounds to clamp, you're going to end up with something
> weird, which is already the case now so not a big deal?

I'm talking only for the cases where we _can_ check. For variables it's
probably tricky to do at compile time if possible at all.

-- 
With Best Regards,
Andy Shevchenko


