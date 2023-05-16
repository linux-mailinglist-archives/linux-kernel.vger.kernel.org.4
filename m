Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D1C70545F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjEPQwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjEPQwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:52:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A018A524D;
        Tue, 16 May 2023 09:52:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 178621FB;
        Tue, 16 May 2023 09:52:58 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.59.123])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D32E53F7BD;
        Tue, 16 May 2023 09:52:11 -0700 (PDT)
Date:   Tue, 16 May 2023 17:52:03 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Akira Yokosawa <akiyks@gmail.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-doc@vger.kernel.org, kernel-team@meta.com,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH locking/atomic 18/19] locking/atomic: Refrain from
 generating duplicate fallback kernel-doc
Message-ID: <ZGO0s1FDGn/pzCPg@FVFF77S0Q05N>
References: <20230510181717.2200934-18-paulmck@kernel.org>
 <ZF0haDfyL3At3Ijw@FVFF77S0Q05N.cambridge.arm.com>
 <2a8b310c-3145-462b-a4c4-a130939da862@paulmck-laptop>
 <ZF48uBYKczItubrU@FVFF77S0Q05N>
 <b5498819-c2d4-414d-ba01-5373e749dc52@paulmck-laptop>
 <ZF5xXuPsrZEgAEEE@FVFF77S0Q05N>
 <e767dcc6-ea63-4ed8-9a15-9e5bb133fafc@paulmck-laptop>
 <b3956719-d478-4dc6-95fd-ec0744acc662@paulmck-laptop>
 <23195f15-7024-6fde-84f2-4cdd45c9abfc@gmail.com>
 <551c7820-1748-433b-8c42-daf777e202df@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <551c7820-1748-433b-8c42-daf777e202df@paulmck-laptop>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Sat, May 13, 2023 at 06:14:36PM -0700, Paul E. McKenney wrote:
> On Sun, May 14, 2023 at 08:58:00AM +0900, Akira Yokosawa wrote:
> > Running "./scripts/kernel-doc -none include/linux/atomic/atomic-arch-fallback.h"
> > on the tag emits a lot of warnings.
> > 
> > Looks like there are kernel-doc comments who don't have a corresponding
> > function signature next to them.
> > 
> >     /**
> >      * function_name() - Brief description of function.
> >      * @arg1: Describe the first argument.
> >      * @arg2: Describe the second argument.
> >      *        One can provide multiple line descriptions
> >      *        for arguments.
> >      *
> >      * A longer description, with more discussion of the function function_name()
> >      * that might be useful to those using or modifying it. Begins with an
> >      * empty comment line, and may include additional embedded empty
> >      * comment lines.
> >      */
> >     int function_name(int arg1, int arg2)  <---
> > 
> > Note that the kernel-doc script ignores #ifdef -- #else.
> 
> Me, I was thinking in terms of making this diagnostic ignore
> include/linux/atomic/atomic-arch-fallback.h.  ;-)
> 
> The actual definitions are off in architecture-specific files, and
> the kernel-doc headers could be left there.  But there are benefits to
> automatically generating all of them.
> 
> Another approach might be to put a "it is OK for the definition to
> be elsewhere" comment following those kernel-doc headers.
> 
> Any other ways to make this work?

I've spent the last day or so playing with this, and I think we can do this by
relegating the arch_atomic*() functions to an implementation detail (and not
documenting those with kerneldoc), and having a raw_atomic*() layer where we
flesh out the API, where each can have a mandatory function definition as
below:

/**
 * raw_atomic_fetch_inc_release() - does a thing atomically
 *
 * TODO: fill this in
 *
 * This is a version of atomic_fetch_inc_release() which is safe to use in
 * noinstr code. Unless instrumentation needs to be avoided,
 * atomic_fetch_inc_release() should be used in preference.
 */
static __always_inline int
raw_atomic_fetch_inc_release(atomic_t *v)
{
#if defined(arch_atomic_fetch_inc_release)
        return arch_atomic_fetch_inc_release(v)
#elif defined(arch_atomic_fetch_inc_relaxed)
        __atomic_release_fence();
        return arch_atomic_fetch_inc_relaxed(v);
#elif defined(arch_atomic_fetch_inc)
        return arch_atomic_fetch_inc(v)
#else   
        return raw_atomic_fetch_add_release(1, v);
#endif
}

... and likewise we can add comments for the regular instrumented atomics.

I've pushed out the WIP patches to my atomics/fallback-rework branch; if you're
happy to give me another day or two I can get a bit further.

> For me, the option of making this
> diagnostic ignore include/linux/atomic/atomic-arch-fallback.h has
> considerable attraction.

It's certainly appealing...

Thanks,
Mark.
