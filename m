Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2439664B33C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 11:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbiLMK1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 05:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbiLMK1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 05:27:23 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170FC1CFC8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 02:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670927237; x=1702463237;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xo4cPD17Q8E85pIFLX7I4jQUoYar/XftlntIfv8FRww=;
  b=XGs2d3VGzQB8JT+/PQ3wIQXU3fSL+MNl1ObEneAL9oZfDBf7UJoY/aQq
   cmRr1QSxtXjtvD8/4X8341LCemNbIv6o9oD+XOhJ9cTbfanIYI6E2Sa0D
   1jSgpPO7e416iDfG+Lk2dHv0HPh+X0cPqXR+wergJWwkMpsMq5NjD3o51
   UFBF2pgYbSB36ruC+okshvhAjAaB3Fl0JQOgKnWT+QeK+MPO9J9+L19p6
   83amnt3XdvMCe0al1zsELZQQJKUYq9sHYNfetVujn1zlOWDLhhE5lyYwL
   uI97ZCuCf0En6a5A/g72btaM9Jm+AFr9KbESxzwzYw/fiSLstGV8fjV1a
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="404354275"
X-IronPort-AV: E=Sophos;i="5.96,241,1665471600"; 
   d="scan'208";a="404354275"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 02:27:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="598782174"
X-IronPort-AV: E=Sophos;i="5.96,241,1665471600"; 
   d="scan'208";a="598782174"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 13 Dec 2022 02:27:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p52VA-009ALu-2B;
        Tue, 13 Dec 2022 12:27:08 +0200
Date:   Tue, 13 Dec 2022 12:27:08 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Intel-gfx] [PATCH 1/5] linux/minmax.h: add non-atomic version
 of xchg
Message-ID: <Y5hTfB+oc1/tWdWQ@smile.fi.intel.com>
References: <20221209154843.4162814-1-andrzej.hajda@intel.com>
 <Y5OE3AX7DS/DfClX@smile.fi.intel.com>
 <398d55d0-3256-238e-132a-195baaf7f4a6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <398d55d0-3256-238e-132a-195baaf7f4a6@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 11:09:12AM +0100, Andrzej Hajda wrote:
> On 09.12.2022 19:56, Andy Shevchenko wrote:
> > On Fri, Dec 09, 2022 at 04:48:39PM +0100, Andrzej Hajda wrote:

...

> > > I hope there will be place for such tiny helper in kernel.
> > > Quick cocci analyze shows there is probably few thousands places
> > > where it could be used, of course I do not intend to do it :).
> > > 
> > > I was not sure where to put this macro, I hope near swap definition
> > > is the most suitable place.
> > 
> > Ah, swap() in this context is not the same. minmax.h hosts it because
> > it's often related to the swap function in the sort-type algorithms.

> >> Moreover sorry if to/cc is not correct - get_maintainers.pl was
> > > more confused than me, to who address this patch.

...

> > >   include/linux/minmax.h | 14 ++++++++++++++
> > 
> > Does it really suit this header? I would expect something else.
> > Maybe include/linux/non-atomic/xchg.h, dunno.
> 
> non-atomic seems quite strange for me, I would assume everything not in
> atomic is non-atomic, unless explicitly specified.
> 
> > 
> > Btw, have you looked if Ingo's gigantic series have done anything to cmpxchg.h
> > and related headers? Maybe some ideas can be taken from there?
> 
> Grepping it didn't give any clue.
> 
> Looking at 'near' languages just to get an idea (they name the function
> differently):
> 
> C++ [1]: exchange and swap are in utility header
> Rust[2]: replace and swap are in std::mem module
> 
> This is some argument to put them together.

Again, I left the above part on top of this message, the swap() in Linux kernel
is not related to __xchg() or similar. That said, minmax.h is not a good place
for the latter.

> [1]: https://en.cppreference.com/w/cpp/header/utility
> [2]: https://doc.rust-lang.org/std/mem/index.html

-- 
With Best Regards,
Andy Shevchenko


