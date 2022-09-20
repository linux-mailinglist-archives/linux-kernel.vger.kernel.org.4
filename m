Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756985BE51A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 14:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiITMAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 08:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiITMAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:00:08 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89C43C142
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 05:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663675200; x=1695211200;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6attfvJn2TlCroEf1Q0w21onYCW/hVVtQgXXXvv2Utc=;
  b=eEMJ8YvkoyY0/sQSHKuFYAOYY6YSjezpKqDy+ZpBnUTT6xg6NvEPGcXL
   9y1fPyNW+JjcAtyenVT0GmG1ut/J9i6gh2yP43YNwTSEBuilTzYhUYNdb
   hJ6Cu0SN8UxDxSOdCBPqR2vGTMTAX9JfVZYE49aV+4UrBG13XkEXpfVys
   Nzh2LpnVboCjUQJ4Se+Q0iWdX/scohqIMBn4xu9MAFee7xFCXuWlaV2FV
   H0Ie49k8a7Gqot5ZzlvP6wpoh86RNF6Ny8iem9eQehvi7kIR9nnYkSKMQ
   JA8q+piXV/096JEmhDUz+d0bDoZA4J4zkHaTczbGNl+FLqIAgUiMJRyKo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="299663285"
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="299663285"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 05:00:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,330,1654585200"; 
   d="scan'208";a="618885283"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 20 Sep 2022 04:59:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oabur-004yhD-2z;
        Tue, 20 Sep 2022 14:59:53 +0300
Date:   Tue, 20 Sep 2022 14:59:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Laight <David.Laight@aculab.com>,
        Dennis Zhou <dennis@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Valentin Schneider <vschneid@redhat.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v4 3/4] lib/find_bit: optimize find_next_bit() functions
Message-ID: <YymrOVsQW4YtoHve@smile.fi.intel.com>
References: <20220915020730.852234-1-yury.norov@gmail.com>
 <20220915020730.852234-4-yury.norov@gmail.com>
 <YyhykvFCOskPAp59@smile.fi.intel.com>
 <CAHk-=whELT9vVs+K1KqkySz+6LL21t7TqQXM_VWmrgGXancUHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whELT9vVs+K1KqkySz+6LL21t7TqQXM_VWmrgGXancUHQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 08:23:00AM -0700, Linus Torvalds wrote:
> On Mon, Sep 19, 2022 at 6:46 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > > +#define FIND_NEXT_BIT(FETCH, MUNGE, size, start)                             \
> > > +({                                                                           \
> [..]
> > > +out:                                                                         \
> >
> > I dunno if GCC expression limits the scope of goto labels
> 
> No. Labels are function-global by default. If you need block-scope for
> them, you need to declare them explicitly in tha block before use with
> "__label__".
> 
> > but on the safe side you can add a prefix to it, so it becomes:
> >
> > FIND_NEXT_BIT_out:
> 
> That doesn't really help, since if you were to use the macro twice,
> you'd still get a name clash.
> 
> That said, I'm not convinced any of this matters, since these macros
> aren't supposed to be used anywhere else, and in fact, they aren't
> even in any header file that would allow anybody else to use them.
> 
> So I think all the normal "make macros safe" rules are simply
> irrelevant for these cases - despite the readable name, these macros
> are local special cases for code generation and avoiding duplication,
> not generic "use this macro to find a bit".
> 
> So it's one thing if a macro is in a header file to be used by random
> code. It's a different thing entirely if it's a specialized local
> macro for a local issue, that nobody else is ever going to even see.
> 
> So I don't think it would be wrong to use __label__ to block-scope it,
> or to use a longer name, but I also don't think it's really required.
> 
> It's not exactly super-common, but we have various cases of macros
> that generate full (or partial) function bodies in various places,
> where the macro does various things that should *never* be done in a
> "regular" macro that gets used by normal code.
> 
> You can see one class of this with something like
> 
>    git grep '^static.*##.*(.*\\$' -- '*.c'
> 
> but to *really* go blind, see the "SYSCALL_DEFINE*()" macros in
> <linux/syscalls.h>.
> 
> Those will mess with your mind, and go "whoever wrote those macros
> needs to be institutionalized". They do some impressive things,
> including creating local functions _and_ starting a new function
> definition where the actual code then isn't part of the macro, but
> actually just continues where the macro was used.
> 
> Which is all very natural and actually looks quite nice and readable
> in the places that use it, with users looking like
> 
>   SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
>   {
>         int fd;
>         struct pid *p;
>    ...
> 
> which is all pretty legible. But there's no question that that macro
> violates every single "normal" macro rule.
> 
> The FIND_NEXT_BIT() macro in comparison is pretty tame.

Thanks for elaboration. It makes a lot of sense and something TIL material
to me.

-- 
With Best Regards,
Andy Shevchenko


