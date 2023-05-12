Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F4670093C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 15:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241185AbjELNap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 09:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241241AbjELNan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 09:30:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F5173C00;
        Fri, 12 May 2023 06:30:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D60CC14;
        Fri, 12 May 2023 06:31:26 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.58.179])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BA283F67D;
        Fri, 12 May 2023 06:30:40 -0700 (PDT)
Date:   Fri, 12 May 2023 14:30:37 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org, akiyks@gmail.com,
        linux-doc@vger.kernel.org, kernel-team@meta.com,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH locking/atomic 18/19] locking/atomic: Refrain from
 generating duplicate fallback kernel-doc
Message-ID: <ZF4/fV83euZoCZkp@FVFF77S0Q05N>
References: <19135936-06d7-4705-8bc8-bb31c2a478ca@paulmck-laptop>
 <20230510181717.2200934-18-paulmck@kernel.org>
 <ZF0haDfyL3At3Ijw@FVFF77S0Q05N.cambridge.arm.com>
 <20230511193856.GA2296992@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511193856.GA2296992@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 09:38:56PM +0200, Peter Zijlstra wrote:
> On Thu, May 11, 2023 at 06:10:00PM +0100, Mark Rutland wrote:
> > Hi Paul
> > 
> > On Wed, May 10, 2023 at 11:17:16AM -0700, Paul E. McKenney wrote:
> > > The gen-atomics.sh script currently generates 42 duplicate definitions:
> > > 
> > > 	arch_atomic64_add_negative
> > > 	arch_atomic64_add_negative_acquire
> > > 	arch_atomic64_add_negative_release
> > 
> > 	[...]
> > 
> > > These duplicates are presumably to handle different architectures
> > > generating hand-coded definitions for different subsets of the atomic
> > > operations.
> > 
> > Yup, for each FULL/ACQUIRE/RELEASE/RELAXED variant of each op, we allow the
> > archtiecture to choose between:
> > 
> > * Providing the ordering variant directly
> > * Providing the FULL ordering variant only
> > * Providing the RELAXED ordering variant only
> > * Providing an equivalent op that we can build from
> > 
> > > However, generating duplicate kernel-doc headers is undesirable.
> > 
> > Understood -- I hadn't understood that duplication was a problem when this was
> > originally written.
> > 
> > The way this is currently done is largely an artifact of our ifdeffery (and the
> > kerneldoc for fallbacks living inthe fallback templates), and I think we can
> > fix both of those.
> > 
> > > Therefore, generate only the first kernel-doc definition in a group
> > > of duplicates.  A comment indicates the name of the function and the
> > > fallback script that generated it.
> > 
> > I'm not keen on this approach, especially with the chkdup.sh script -- it feels
> > like we're working around an underlying structural issue.
> > 
> > I think that we can restructure the ifdeffery so that each ordering variant
> > gets its own ifdeffery, and then we could place the kerneldoc immediately above
> > that, e.g.
> > 
> > 	/**
> > 	 * arch_atomic_inc_return_release()
> > 	 *
> > 	 * [ full kerneldoc block here ]
> > 	 */
> > 	#if defined(arch_atomic_inc_return_release)
> > 	/* defined in arch code */
> > 	#elif defined(arch_atomic_inc_return_relaxed)
> > 	[ define in terms of arch_atomic_inc_return_relaxed ]
> > 	#elif defined(arch_atomic_inc_return)
> > 	[ define in terms of arch_atomic_inc_return ]
> > 	#else
> > 	[ define in terms of arch_atomic_fetch_inc_release ]
> > 	#endif
> > 
> > ... with similar for the mandatory ops that each arch must provide, e.g.
> > 
> > 	/**
> > 	 * arch_atomic_or()
> > 	 *
> > 	 * [ full kerneldoc block here ]
> > 	 */
> > 	/* arch_atomic_or() is mandatory -- architectures must define it! */
> > 
> > I had a go at that restructuring today, and while local build testing indicates
> > I haven't got it quite right, I think it's possible:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=atomics/fallback-rework
> > 
> > Does that sound ok to you?
> 
> If the end result is simpler scripts, sure.

FWIW, regardless of the comments, I'd like to make this restructuring as it
makes it easier to add some more fallback cases, and I find the generated
ifdeffery a bit easier to follow when it's a chain of of-elif-elif-else-end
rather than a few nested cases.

> I'm not at all keen to complicate the scripts for something daft like
> kernel-doc. The last thing we need is documentation style weenies making
> an unholy mess of things.

Sure. I agree we don't want to bend over backwards for it at the cost of
maintainability, but I think it can be made pretty simple and self-contained,
and hopefully we can prove that with a v2 or v3. ;)

If nothing else, handling this centrally means that we'll have *one* set of
comments for this rather than a tonne of randomly managed copies in arch
code, which seems like a win...

Thanks,
Mark.
