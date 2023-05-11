Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BEF6FF826
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 19:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238845AbjEKRKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 13:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjEKRKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 13:10:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7B066A4B;
        Thu, 11 May 2023 10:10:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04FE4113E;
        Thu, 11 May 2023 10:10:52 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.35.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1679A3F67D;
        Thu, 11 May 2023 10:10:05 -0700 (PDT)
Date:   Thu, 11 May 2023 18:10:00 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, akiyks@gmail.com,
        linux-doc@vger.kernel.org, kernel-team@meta.com,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH locking/atomic 18/19] locking/atomic: Refrain from
 generating duplicate fallback kernel-doc
Message-ID: <ZF0haDfyL3At3Ijw@FVFF77S0Q05N.cambridge.arm.com>
References: <19135936-06d7-4705-8bc8-bb31c2a478ca@paulmck-laptop>
 <20230510181717.2200934-18-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510181717.2200934-18-paulmck@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul

On Wed, May 10, 2023 at 11:17:16AM -0700, Paul E. McKenney wrote:
> The gen-atomics.sh script currently generates 42 duplicate definitions:
> 
> 	arch_atomic64_add_negative
> 	arch_atomic64_add_negative_acquire
> 	arch_atomic64_add_negative_release

	[...]

> These duplicates are presumably to handle different architectures
> generating hand-coded definitions for different subsets of the atomic
> operations.

Yup, for each FULL/ACQUIRE/RELEASE/RELAXED variant of each op, we allow the
archtiecture to choose between:

* Providing the ordering variant directly
* Providing the FULL ordering variant only
* Providing the RELAXED ordering variant only
* Providing an equivalent op that we can build from

> However, generating duplicate kernel-doc headers is undesirable.

Understood -- I hadn't understood that duplication was a problem when this was
originally written.

The way this is currently done is largely an artifact of our ifdeffery (and the
kerneldoc for fallbacks living inthe fallback templates), and I think we can
fix both of those.

> Therefore, generate only the first kernel-doc definition in a group
> of duplicates.  A comment indicates the name of the function and the
> fallback script that generated it.

I'm not keen on this approach, especially with the chkdup.sh script -- it feels
like we're working around an underlying structural issue.

I think that we can restructure the ifdeffery so that each ordering variant
gets its own ifdeffery, and then we could place the kerneldoc immediately above
that, e.g.

	/**
	 * arch_atomic_inc_return_release()
	 *
	 * [ full kerneldoc block here ]
	 */
	#if defined(arch_atomic_inc_return_release)
	/* defined in arch code */
	#elif defined(arch_atomic_inc_return_relaxed)
	[ define in terms of arch_atomic_inc_return_relaxed ]
	#elif defined(arch_atomic_inc_return)
	[ define in terms of arch_atomic_inc_return ]
	#else
	[ define in terms of arch_atomic_fetch_inc_release ]
	#endif

... with similar for the mandatory ops that each arch must provide, e.g.

	/**
	 * arch_atomic_or()
	 *
	 * [ full kerneldoc block here ]
	 */
	/* arch_atomic_or() is mandatory -- architectures must define it! */

I had a go at that restructuring today, and while local build testing indicates
I haven't got it quite right, I think it's possible:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=atomics/fallback-rework

Does that sound ok to you?

Thanks,
Mark.

> Reported-by: Akira Yokosawa <akiyks@gmail.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---
>  include/linux/atomic/atomic-arch-fallback.h  | 386 +++----------------
>  scripts/atomic/chkdup.sh                     |  27 ++
>  scripts/atomic/fallbacks/acquire             |   3 +
>  scripts/atomic/fallbacks/add_negative        |   5 +
>  scripts/atomic/fallbacks/add_unless          |   5 +
>  scripts/atomic/fallbacks/andnot              |   5 +
>  scripts/atomic/fallbacks/dec                 |   5 +
>  scripts/atomic/fallbacks/dec_and_test        |   5 +
>  scripts/atomic/fallbacks/dec_if_positive     |   5 +
>  scripts/atomic/fallbacks/dec_unless_positive |   5 +
>  scripts/atomic/fallbacks/fence               |   3 +
>  scripts/atomic/fallbacks/fetch_add_unless    |   5 +
>  scripts/atomic/fallbacks/inc                 |   5 +
>  scripts/atomic/fallbacks/inc_and_test        |   5 +
>  scripts/atomic/fallbacks/inc_not_zero        |   5 +
>  scripts/atomic/fallbacks/inc_unless_negative |   5 +
>  scripts/atomic/fallbacks/read_acquire        |   5 +
>  scripts/atomic/fallbacks/release             |   3 +
>  scripts/atomic/fallbacks/set_release         |   5 +
>  scripts/atomic/fallbacks/sub_and_test        |   5 +
>  scripts/atomic/fallbacks/try_cmpxchg         |   5 +
>  scripts/atomic/gen-atomics.sh                |   4 +
>  22 files changed, 163 insertions(+), 343 deletions(-)
>  create mode 100644 scripts/atomic/chkdup.sh
> 
> diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
> index 41aa94f0aacd..2d56726f8662 100644
> --- a/include/linux/atomic/atomic-arch-fallback.h
> +++ b/include/linux/atomic/atomic-arch-fallback.h
> @@ -639,13 +639,7 @@ arch_atomic_inc_return_relaxed(atomic_t *v)
>  #else /* arch_atomic_inc_return_relaxed */
>  
>  #ifndef arch_atomic_inc_return_acquire
> -/**
> - * arch_atomic_inc_return_acquire - Atomic inc with acquire ordering
> - * @v: pointer of type atomic_t
> - *
> - * Atomically increment @v using acquire ordering.
> - * Return new value.
> - */
> +// Fallback acquire omitting duplicate arch_atomic_inc_return_acquire() kernel-doc header.
>  static __always_inline int
>  arch_atomic_inc_return_acquire(atomic_t *v)
>  {
> @@ -657,13 +651,7 @@ arch_atomic_inc_return_acquire(atomic_t *v)
>  #endif
>  
>  #ifndef arch_atomic_inc_return_release
> -/**
> - * arch_atomic_inc_return_release - Atomic inc with release ordering
> - * @v: pointer of type atomic_t
> - *
> - * Atomically increment @v using release ordering.
> - * Return new value.
> - */
> +// Fallback release omitting duplicate arch_atomic_inc_return_release() kernel-doc header.
>  static __always_inline int
>  arch_atomic_inc_return_release(atomic_t *v)
>  {
> @@ -674,13 +662,7 @@ arch_atomic_inc_return_release(atomic_t *v)
>  #endif
>  
>  #ifndef arch_atomic_inc_return
> -/**
> - * arch_atomic_inc_return - Atomic inc with full ordering
> - * @v: pointer of type atomic_t
> - *
> - * Atomically increment @v using full ordering.
> - * Return new value.
> - */
> +// Fallback fence omitting duplicate arch_atomic_inc_return() kernel-doc header.
>  static __always_inline int
>  arch_atomic_inc_return(atomic_t *v)
>  {
> @@ -769,13 +751,7 @@ arch_atomic_fetch_inc_relaxed(atomic_t *v)
>  #else /* arch_atomic_fetch_inc_relaxed */
>  
>  #ifndef arch_atomic_fetch_inc_acquire
> -/**
> - * arch_atomic_fetch_inc_acquire - Atomic inc with acquire ordering
> - * @v: pointer of type atomic_t
> - *
> - * Atomically increment @v using acquire ordering.
> - * Return old value.
> - */
> +// Fallback acquire omitting duplicate arch_atomic_fetch_inc_acquire() kernel-doc header.
>  static __always_inline int
>  arch_atomic_fetch_inc_acquire(atomic_t *v)
>  {
> @@ -787,13 +763,7 @@ arch_atomic_fetch_inc_acquire(atomic_t *v)
>  #endif
>  
>  #ifndef arch_atomic_fetch_inc_release
> -/**
> - * arch_atomic_fetch_inc_release - Atomic inc with release ordering
> - * @v: pointer of type atomic_t
> - *
> - * Atomically increment @v using release ordering.
> - * Return old value.
> - */
> +// Fallback release omitting duplicate arch_atomic_fetch_inc_release() kernel-doc header.
>  static __always_inline int
>  arch_atomic_fetch_inc_release(atomic_t *v)
>  {
> @@ -804,13 +774,7 @@ arch_atomic_fetch_inc_release(atomic_t *v)
>  #endif
>  
>  #ifndef arch_atomic_fetch_inc
> -/**
> - * arch_atomic_fetch_inc - Atomic inc with full ordering
> - * @v: pointer of type atomic_t
> - *
> - * Atomically increment @v using full ordering.
> - * Return old value.
> - */
> +// Fallback fence omitting duplicate arch_atomic_fetch_inc() kernel-doc header.
>  static __always_inline int
>  arch_atomic_fetch_inc(atomic_t *v)
>  {
> @@ -915,13 +879,7 @@ arch_atomic_dec_return_relaxed(atomic_t *v)
>  #else /* arch_atomic_dec_return_relaxed */
>  
>  #ifndef arch_atomic_dec_return_acquire
> -/**
> - * arch_atomic_dec_return_acquire - Atomic dec with acquire ordering
> - * @v: pointer of type atomic_t
> - *
> - * Atomically decrement @v using acquire ordering.
> - * Return new value.
> - */
> +// Fallback acquire omitting duplicate arch_atomic_dec_return_acquire() kernel-doc header.
>  static __always_inline int
>  arch_atomic_dec_return_acquire(atomic_t *v)
>  {
> @@ -933,13 +891,7 @@ arch_atomic_dec_return_acquire(atomic_t *v)
>  #endif
>  
>  #ifndef arch_atomic_dec_return_release
> -/**
> - * arch_atomic_dec_return_release - Atomic dec with release ordering
> - * @v: pointer of type atomic_t
> - *
> - * Atomically decrement @v using release ordering.
> - * Return new value.
> - */
> +// Fallback release omitting duplicate arch_atomic_dec_return_release() kernel-doc header.
>  static __always_inline int
>  arch_atomic_dec_return_release(atomic_t *v)
>  {
> @@ -950,13 +902,7 @@ arch_atomic_dec_return_release(atomic_t *v)
>  #endif
>  
>  #ifndef arch_atomic_dec_return
> -/**
> - * arch_atomic_dec_return - Atomic dec with full ordering
> - * @v: pointer of type atomic_t
> - *
> - * Atomically decrement @v using full ordering.
> - * Return new value.
> - */
> +// Fallback fence omitting duplicate arch_atomic_dec_return() kernel-doc header.
>  static __always_inline int
>  arch_atomic_dec_return(atomic_t *v)
>  {
> @@ -1045,13 +991,7 @@ arch_atomic_fetch_dec_relaxed(atomic_t *v)
>  #else /* arch_atomic_fetch_dec_relaxed */
>  
>  #ifndef arch_atomic_fetch_dec_acquire
> -/**
> - * arch_atomic_fetch_dec_acquire - Atomic dec with acquire ordering
> - * @v: pointer of type atomic_t
> - *
> - * Atomically decrement @v using acquire ordering.
> - * Return old value.
> - */
> +// Fallback acquire omitting duplicate arch_atomic_fetch_dec_acquire() kernel-doc header.
>  static __always_inline int
>  arch_atomic_fetch_dec_acquire(atomic_t *v)
>  {
> @@ -1063,13 +1003,7 @@ arch_atomic_fetch_dec_acquire(atomic_t *v)
>  #endif
>  
>  #ifndef arch_atomic_fetch_dec_release
> -/**
> - * arch_atomic_fetch_dec_release - Atomic dec with release ordering
> - * @v: pointer of type atomic_t
> - *
> - * Atomically decrement @v using release ordering.
> - * Return old value.
> - */
> +// Fallback release omitting duplicate arch_atomic_fetch_dec_release() kernel-doc header.
>  static __always_inline int
>  arch_atomic_fetch_dec_release(atomic_t *v)
>  {
> @@ -1080,13 +1014,7 @@ arch_atomic_fetch_dec_release(atomic_t *v)
>  #endif
>  
>  #ifndef arch_atomic_fetch_dec
> -/**
> - * arch_atomic_fetch_dec - Atomic dec with full ordering
> - * @v: pointer of type atomic_t
> - *
> - * Atomically decrement @v using full ordering.
> - * Return old value.
> - */
> +// Fallback fence omitting duplicate arch_atomic_fetch_dec() kernel-doc header.
>  static __always_inline int
>  arch_atomic_fetch_dec(atomic_t *v)
>  {
> @@ -1262,14 +1190,7 @@ arch_atomic_fetch_andnot_relaxed(int i, atomic_t *v)
>  #else /* arch_atomic_fetch_andnot_relaxed */
>  
>  #ifndef arch_atomic_fetch_andnot_acquire
> -/**
> - * arch_atomic_fetch_andnot_acquire - Atomic andnot with acquire ordering
> - * @i: value to complement then AND
> - * @v: pointer of type atomic_t
> - *
> - * Atomically complement then AND @i with @v using acquire ordering.
> - * Return old value.
> - */
> +// Fallback acquire omitting duplicate arch_atomic_fetch_andnot_acquire() kernel-doc header.
>  static __always_inline int
>  arch_atomic_fetch_andnot_acquire(int i, atomic_t *v)
>  {
> @@ -1281,14 +1202,7 @@ arch_atomic_fetch_andnot_acquire(int i, atomic_t *v)
>  #endif
>  
>  #ifndef arch_atomic_fetch_andnot_release
> -/**
> - * arch_atomic_fetch_andnot_release - Atomic andnot with release ordering
> - * @i: value to complement then AND
> - * @v: pointer of type atomic_t
> - *
> - * Atomically complement then AND @i with @v using release ordering.
> - * Return old value.
> - */
> +// Fallback release omitting duplicate arch_atomic_fetch_andnot_release() kernel-doc header.
>  static __always_inline int
>  arch_atomic_fetch_andnot_release(int i, atomic_t *v)
>  {
> @@ -1299,14 +1213,7 @@ arch_atomic_fetch_andnot_release(int i, atomic_t *v)
>  #endif
>  
>  #ifndef arch_atomic_fetch_andnot
> -/**
> - * arch_atomic_fetch_andnot - Atomic andnot with full ordering
> - * @i: value to complement then AND
> - * @v: pointer of type atomic_t
> - *
> - * Atomically complement then AND @i with @v using full ordering.
> - * Return old value.
> - */
> +// Fallback fence omitting duplicate arch_atomic_fetch_andnot() kernel-doc header.
>  static __always_inline int
>  arch_atomic_fetch_andnot(int i, atomic_t *v)
>  {
> @@ -1699,18 +1606,7 @@ arch_atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
>  #else /* arch_atomic_try_cmpxchg_relaxed */
>  
>  #ifndef arch_atomic_try_cmpxchg_acquire
> -/**
> - * arch_atomic_try_cmpxchg_acquire - Atomic try_cmpxchg with acquire ordering
> - * @v: pointer of type atomic_t
> - * @old: desired old value to match
> - * @new: new value to put in
> - *
> - * Atomically compares @new to *@v, and if equal,
> - * stores @new to *@v, providing acquire ordering.
> - * Returns @true if the cmpxchg operation succeeded,
> - * and false otherwise.  Either way, stores the old
> - * value of *@v to *@old.
> - */
> +// Fallback acquire omitting duplicate arch_atomic_try_cmpxchg_acquire() kernel-doc header.
>  static __always_inline bool
>  arch_atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
>  {
> @@ -1722,18 +1618,7 @@ arch_atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
>  #endif
>  
>  #ifndef arch_atomic_try_cmpxchg_release
> -/**
> - * arch_atomic_try_cmpxchg_release - Atomic try_cmpxchg with release ordering
> - * @v: pointer of type atomic_t
> - * @old: desired old value to match
> - * @new: new value to put in
> - *
> - * Atomically compares @new to *@v, and if equal,
> - * stores @new to *@v, providing release ordering.
> - * Returns @true if the cmpxchg operation succeeded,
> - * and false otherwise.  Either way, stores the old
> - * value of *@v to *@old.
> - */
> +// Fallback release omitting duplicate arch_atomic_try_cmpxchg_release() kernel-doc header.
>  static __always_inline bool
>  arch_atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
>  {
> @@ -1744,18 +1629,7 @@ arch_atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
>  #endif
>  
>  #ifndef arch_atomic_try_cmpxchg
> -/**
> - * arch_atomic_try_cmpxchg - Atomic try_cmpxchg with full ordering
> - * @v: pointer of type atomic_t
> - * @old: desired old value to match
> - * @new: new value to put in
> - *
> - * Atomically compares @new to *@v, and if equal,
> - * stores @new to *@v, providing full ordering.
> - * Returns @true if the cmpxchg operation succeeded,
> - * and false otherwise.  Either way, stores the old
> - * value of *@v to *@old.
> - */
> +// Fallback fence omitting duplicate arch_atomic_try_cmpxchg() kernel-doc header.
>  static __always_inline bool
>  arch_atomic_try_cmpxchg(atomic_t *v, int *old, int new)
>  {
> @@ -1900,15 +1774,7 @@ arch_atomic_add_negative_relaxed(int i, atomic_t *v)
>  #else /* arch_atomic_add_negative_relaxed */
>  
>  #ifndef arch_atomic_add_negative_acquire
> -/**
> - * arch_atomic_add_negative_acquire - Atomic add_negative with acquire ordering
> - * @i: value to add
> - * @v: pointer of type atomic_t
> - *
> - * Atomically add @i with @v using acquire ordering.
> - * Return @true if the result is negative, or @false when
> - * the result is greater than or equal to zero.
> - */
> +// Fallback acquire omitting duplicate arch_atomic_add_negative_acquire() kernel-doc header.
>  static __always_inline bool
>  arch_atomic_add_negative_acquire(int i, atomic_t *v)
>  {
> @@ -1920,15 +1786,7 @@ arch_atomic_add_negative_acquire(int i, atomic_t *v)
>  #endif
>  
>  #ifndef arch_atomic_add_negative_release
> -/**
> - * arch_atomic_add_negative_release - Atomic add_negative with release ordering
> - * @i: value to add
> - * @v: pointer of type atomic_t
> - *
> - * Atomically add @i with @v using release ordering.
> - * Return @true if the result is negative, or @false when
> - * the result is greater than or equal to zero.
> - */
> +// Fallback release omitting duplicate arch_atomic_add_negative_release() kernel-doc header.
>  static __always_inline bool
>  arch_atomic_add_negative_release(int i, atomic_t *v)
>  {
> @@ -1939,15 +1797,7 @@ arch_atomic_add_negative_release(int i, atomic_t *v)
>  #endif
>  
>  #ifndef arch_atomic_add_negative
> -/**
> - * arch_atomic_add_negative - Atomic add_negative with full ordering
> - * @i: value to add
> - * @v: pointer of type atomic_t
> - *
> - * Atomically add @i with @v using full ordering.
> - * Return @true if the result is negative, or @false when
> - * the result is greater than or equal to zero.
> - */
> +// Fallback fence omitting duplicate arch_atomic_add_negative() kernel-doc header.
>  static __always_inline bool
>  arch_atomic_add_negative(int i, atomic_t *v)
>  {
> @@ -2500,13 +2350,7 @@ arch_atomic64_inc_return_relaxed(atomic64_t *v)
>  #else /* arch_atomic64_inc_return_relaxed */
>  
>  #ifndef arch_atomic64_inc_return_acquire
> -/**
> - * arch_atomic64_inc_return_acquire - Atomic inc with acquire ordering
> - * @v: pointer of type atomic64_t
> - *
> - * Atomically increment @v using acquire ordering.
> - * Return new value.
> - */
> +// Fallback acquire omitting duplicate arch_atomic64_inc_return_acquire() kernel-doc header.
>  static __always_inline s64
>  arch_atomic64_inc_return_acquire(atomic64_t *v)
>  {
> @@ -2518,13 +2362,7 @@ arch_atomic64_inc_return_acquire(atomic64_t *v)
>  #endif
>  
>  #ifndef arch_atomic64_inc_return_release
> -/**
> - * arch_atomic64_inc_return_release - Atomic inc with release ordering
> - * @v: pointer of type atomic64_t
> - *
> - * Atomically increment @v using release ordering.
> - * Return new value.
> - */
> +// Fallback release omitting duplicate arch_atomic64_inc_return_release() kernel-doc header.
>  static __always_inline s64
>  arch_atomic64_inc_return_release(atomic64_t *v)
>  {
> @@ -2535,13 +2373,7 @@ arch_atomic64_inc_return_release(atomic64_t *v)
>  #endif
>  
>  #ifndef arch_atomic64_inc_return
> -/**
> - * arch_atomic64_inc_return - Atomic inc with full ordering
> - * @v: pointer of type atomic64_t
> - *
> - * Atomically increment @v using full ordering.
> - * Return new value.
> - */
> +// Fallback fence omitting duplicate arch_atomic64_inc_return() kernel-doc header.
>  static __always_inline s64
>  arch_atomic64_inc_return(atomic64_t *v)
>  {
> @@ -2630,13 +2462,7 @@ arch_atomic64_fetch_inc_relaxed(atomic64_t *v)
>  #else /* arch_atomic64_fetch_inc_relaxed */
>  
>  #ifndef arch_atomic64_fetch_inc_acquire
> -/**
> - * arch_atomic64_fetch_inc_acquire - Atomic inc with acquire ordering
> - * @v: pointer of type atomic64_t
> - *
> - * Atomically increment @v using acquire ordering.
> - * Return old value.
> - */
> +// Fallback acquire omitting duplicate arch_atomic64_fetch_inc_acquire() kernel-doc header.
>  static __always_inline s64
>  arch_atomic64_fetch_inc_acquire(atomic64_t *v)
>  {
> @@ -2648,13 +2474,7 @@ arch_atomic64_fetch_inc_acquire(atomic64_t *v)
>  #endif
>  
>  #ifndef arch_atomic64_fetch_inc_release
> -/**
> - * arch_atomic64_fetch_inc_release - Atomic inc with release ordering
> - * @v: pointer of type atomic64_t
> - *
> - * Atomically increment @v using release ordering.
> - * Return old value.
> - */
> +// Fallback release omitting duplicate arch_atomic64_fetch_inc_release() kernel-doc header.
>  static __always_inline s64
>  arch_atomic64_fetch_inc_release(atomic64_t *v)
>  {
> @@ -2665,13 +2485,7 @@ arch_atomic64_fetch_inc_release(atomic64_t *v)
>  #endif
>  
>  #ifndef arch_atomic64_fetch_inc
> -/**
> - * arch_atomic64_fetch_inc - Atomic inc with full ordering
> - * @v: pointer of type atomic64_t
> - *
> - * Atomically increment @v using full ordering.
> - * Return old value.
> - */
> +// Fallback fence omitting duplicate arch_atomic64_fetch_inc() kernel-doc header.
>  static __always_inline s64
>  arch_atomic64_fetch_inc(atomic64_t *v)
>  {
> @@ -2776,13 +2590,7 @@ arch_atomic64_dec_return_relaxed(atomic64_t *v)
>  #else /* arch_atomic64_dec_return_relaxed */
>  
>  #ifndef arch_atomic64_dec_return_acquire
> -/**
> - * arch_atomic64_dec_return_acquire - Atomic dec with acquire ordering
> - * @v: pointer of type atomic64_t
> - *
> - * Atomically decrement @v using acquire ordering.
> - * Return new value.
> - */
> +// Fallback acquire omitting duplicate arch_atomic64_dec_return_acquire() kernel-doc header.
>  static __always_inline s64
>  arch_atomic64_dec_return_acquire(atomic64_t *v)
>  {
> @@ -2794,13 +2602,7 @@ arch_atomic64_dec_return_acquire(atomic64_t *v)
>  #endif
>  
>  #ifndef arch_atomic64_dec_return_release
> -/**
> - * arch_atomic64_dec_return_release - Atomic dec with release ordering
> - * @v: pointer of type atomic64_t
> - *
> - * Atomically decrement @v using release ordering.
> - * Return new value.
> - */
> +// Fallback release omitting duplicate arch_atomic64_dec_return_release() kernel-doc header.
>  static __always_inline s64
>  arch_atomic64_dec_return_release(atomic64_t *v)
>  {
> @@ -2811,13 +2613,7 @@ arch_atomic64_dec_return_release(atomic64_t *v)
>  #endif
>  
>  #ifndef arch_atomic64_dec_return
> -/**
> - * arch_atomic64_dec_return - Atomic dec with full ordering
> - * @v: pointer of type atomic64_t
> - *
> - * Atomically decrement @v using full ordering.
> - * Return new value.
> - */
> +// Fallback fence omitting duplicate arch_atomic64_dec_return() kernel-doc header.
>  static __always_inline s64
>  arch_atomic64_dec_return(atomic64_t *v)
>  {
> @@ -2906,13 +2702,7 @@ arch_atomic64_fetch_dec_relaxed(atomic64_t *v)
>  #else /* arch_atomic64_fetch_dec_relaxed */
>  
>  #ifndef arch_atomic64_fetch_dec_acquire
> -/**
> - * arch_atomic64_fetch_dec_acquire - Atomic dec with acquire ordering
> - * @v: pointer of type atomic64_t
> - *
> - * Atomically decrement @v using acquire ordering.
> - * Return old value.
> - */
> +// Fallback acquire omitting duplicate arch_atomic64_fetch_dec_acquire() kernel-doc header.
>  static __always_inline s64
>  arch_atomic64_fetch_dec_acquire(atomic64_t *v)
>  {
> @@ -2924,13 +2714,7 @@ arch_atomic64_fetch_dec_acquire(atomic64_t *v)
>  #endif
>  
>  #ifndef arch_atomic64_fetch_dec_release
> -/**
> - * arch_atomic64_fetch_dec_release - Atomic dec with release ordering
> - * @v: pointer of type atomic64_t
> - *
> - * Atomically decrement @v using release ordering.
> - * Return old value.
> - */
> +// Fallback release omitting duplicate arch_atomic64_fetch_dec_release() kernel-doc header.
>  static __always_inline s64
>  arch_atomic64_fetch_dec_release(atomic64_t *v)
>  {
> @@ -2941,13 +2725,7 @@ arch_atomic64_fetch_dec_release(atomic64_t *v)
>  #endif
>  
>  #ifndef arch_atomic64_fetch_dec
> -/**
> - * arch_atomic64_fetch_dec - Atomic dec with full ordering
> - * @v: pointer of type atomic64_t
> - *
> - * Atomically decrement @v using full ordering.
> - * Return old value.
> - */
> +// Fallback fence omitting duplicate arch_atomic64_fetch_dec() kernel-doc header.
>  static __always_inline s64
>  arch_atomic64_fetch_dec(atomic64_t *v)
>  {
> @@ -3123,14 +2901,7 @@ arch_atomic64_fetch_andnot_relaxed(s64 i, atomic64_t *v)
>  #else /* arch_atomic64_fetch_andnot_relaxed */
>  
>  #ifndef arch_atomic64_fetch_andnot_acquire
> -/**
> - * arch_atomic64_fetch_andnot_acquire - Atomic andnot with acquire ordering
> - * @i: value to complement then AND
> - * @v: pointer of type atomic64_t
> - *
> - * Atomically complement then AND @i with @v using acquire ordering.
> - * Return old value.
> - */
> +// Fallback acquire omitting duplicate arch_atomic64_fetch_andnot_acquire() kernel-doc header.
>  static __always_inline s64
>  arch_atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
>  {
> @@ -3142,14 +2913,7 @@ arch_atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
>  #endif
>  
>  #ifndef arch_atomic64_fetch_andnot_release
> -/**
> - * arch_atomic64_fetch_andnot_release - Atomic andnot with release ordering
> - * @i: value to complement then AND
> - * @v: pointer of type atomic64_t
> - *
> - * Atomically complement then AND @i with @v using release ordering.
> - * Return old value.
> - */
> +// Fallback release omitting duplicate arch_atomic64_fetch_andnot_release() kernel-doc header.
>  static __always_inline s64
>  arch_atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
>  {
> @@ -3160,14 +2924,7 @@ arch_atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
>  #endif
>  
>  #ifndef arch_atomic64_fetch_andnot
> -/**
> - * arch_atomic64_fetch_andnot - Atomic andnot with full ordering
> - * @i: value to complement then AND
> - * @v: pointer of type atomic64_t
> - *
> - * Atomically complement then AND @i with @v using full ordering.
> - * Return old value.
> - */
> +// Fallback fence omitting duplicate arch_atomic64_fetch_andnot() kernel-doc header.
>  static __always_inline s64
>  arch_atomic64_fetch_andnot(s64 i, atomic64_t *v)
>  {
> @@ -3560,18 +3317,7 @@ arch_atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
>  #else /* arch_atomic64_try_cmpxchg_relaxed */
>  
>  #ifndef arch_atomic64_try_cmpxchg_acquire
> -/**
> - * arch_atomic64_try_cmpxchg_acquire - Atomic try_cmpxchg with acquire ordering
> - * @v: pointer of type atomic64_t
> - * @old: desired old value to match
> - * @new: new value to put in
> - *
> - * Atomically compares @new to *@v, and if equal,
> - * stores @new to *@v, providing acquire ordering.
> - * Returns @true if the cmpxchg operation succeeded,
> - * and false otherwise.  Either way, stores the old
> - * value of *@v to *@old.
> - */
> +// Fallback acquire omitting duplicate arch_atomic64_try_cmpxchg_acquire() kernel-doc header.
>  static __always_inline bool
>  arch_atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
>  {
> @@ -3583,18 +3329,7 @@ arch_atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
>  #endif
>  
>  #ifndef arch_atomic64_try_cmpxchg_release
> -/**
> - * arch_atomic64_try_cmpxchg_release - Atomic try_cmpxchg with release ordering
> - * @v: pointer of type atomic64_t
> - * @old: desired old value to match
> - * @new: new value to put in
> - *
> - * Atomically compares @new to *@v, and if equal,
> - * stores @new to *@v, providing release ordering.
> - * Returns @true if the cmpxchg operation succeeded,
> - * and false otherwise.  Either way, stores the old
> - * value of *@v to *@old.
> - */
> +// Fallback release omitting duplicate arch_atomic64_try_cmpxchg_release() kernel-doc header.
>  static __always_inline bool
>  arch_atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
>  {
> @@ -3605,18 +3340,7 @@ arch_atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
>  #endif
>  
>  #ifndef arch_atomic64_try_cmpxchg
> -/**
> - * arch_atomic64_try_cmpxchg - Atomic try_cmpxchg with full ordering
> - * @v: pointer of type atomic64_t
> - * @old: desired old value to match
> - * @new: new value to put in
> - *
> - * Atomically compares @new to *@v, and if equal,
> - * stores @new to *@v, providing full ordering.
> - * Returns @true if the cmpxchg operation succeeded,
> - * and false otherwise.  Either way, stores the old
> - * value of *@v to *@old.
> - */
> +// Fallback fence omitting duplicate arch_atomic64_try_cmpxchg() kernel-doc header.
>  static __always_inline bool
>  arch_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
>  {
> @@ -3761,15 +3485,7 @@ arch_atomic64_add_negative_relaxed(s64 i, atomic64_t *v)
>  #else /* arch_atomic64_add_negative_relaxed */
>  
>  #ifndef arch_atomic64_add_negative_acquire
> -/**
> - * arch_atomic64_add_negative_acquire - Atomic add_negative with acquire ordering
> - * @i: value to add
> - * @v: pointer of type atomic64_t
> - *
> - * Atomically add @i with @v using acquire ordering.
> - * Return @true if the result is negative, or @false when
> - * the result is greater than or equal to zero.
> - */
> +// Fallback acquire omitting duplicate arch_atomic64_add_negative_acquire() kernel-doc header.
>  static __always_inline bool
>  arch_atomic64_add_negative_acquire(s64 i, atomic64_t *v)
>  {
> @@ -3781,15 +3497,7 @@ arch_atomic64_add_negative_acquire(s64 i, atomic64_t *v)
>  #endif
>  
>  #ifndef arch_atomic64_add_negative_release
> -/**
> - * arch_atomic64_add_negative_release - Atomic add_negative with release ordering
> - * @i: value to add
> - * @v: pointer of type atomic64_t
> - *
> - * Atomically add @i with @v using release ordering.
> - * Return @true if the result is negative, or @false when
> - * the result is greater than or equal to zero.
> - */
> +// Fallback release omitting duplicate arch_atomic64_add_negative_release() kernel-doc header.
>  static __always_inline bool
>  arch_atomic64_add_negative_release(s64 i, atomic64_t *v)
>  {
> @@ -3800,15 +3508,7 @@ arch_atomic64_add_negative_release(s64 i, atomic64_t *v)
>  #endif
>  
>  #ifndef arch_atomic64_add_negative
> -/**
> - * arch_atomic64_add_negative - Atomic add_negative with full ordering
> - * @i: value to add
> - * @v: pointer of type atomic64_t
> - *
> - * Atomically add @i with @v using full ordering.
> - * Return @true if the result is negative, or @false when
> - * the result is greater than or equal to zero.
> - */
> +// Fallback fence omitting duplicate arch_atomic64_add_negative() kernel-doc header.
>  static __always_inline bool
>  arch_atomic64_add_negative(s64 i, atomic64_t *v)
>  {
> @@ -3958,4 +3658,4 @@ arch_atomic64_dec_if_positive(atomic64_t *v)
>  #endif
>  
>  #endif /* _LINUX_ATOMIC_FALLBACK_H */
> -// 7c2c97cd48cf9c672efc44b9fed5a37b8970dde4
> +// 9bf9febc5288ed9539d1b3cfbbc6e36743b74c3b
> diff --git a/scripts/atomic/chkdup.sh b/scripts/atomic/chkdup.sh
> new file mode 100644
> index 000000000000..04bb4f5c5c34
> --- /dev/null
> +++ b/scripts/atomic/chkdup.sh
> @@ -0,0 +1,27 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Check to see if the specified atomic is already in use.  This is
> +# done by keeping filenames in the temporary directory specified by the
> +# environment variable T.
> +#
> +# Usage:
> +#	chkdup.sh name fallback
> +#
> +# The "name" argument is the name of the function to be generated, and
> +# the "fallback" argument is the name of the fallback script that is
> +# doing the generation.
> +#
> +# If the function is a duplicate, output a comment saying so and
> +# exit with non-zero (error) status.  Otherwise exit successfully
> +#
> +# If the function is a duplicate, output a comment saying so and
> +# exit with non-zero (error) status.  Otherwise exit successfully.
> +
> +if test -f ${T}/${1}
> +then
> +	echo // Fallback ${2} omitting duplicate "${1}()" kernel-doc header.
> +	exit 1
> +fi
> +touch ${T}/${1}
> +exit 0
> diff --git a/scripts/atomic/fallbacks/acquire b/scripts/atomic/fallbacks/acquire
> index 08fc6c30a9ef..a349935ac7fe 100755
> --- a/scripts/atomic/fallbacks/acquire
> +++ b/scripts/atomic/fallbacks/acquire
> @@ -1,5 +1,8 @@
> +if /bin/sh ${ATOMICDIR}/chkdup.sh arch_${atomic}_${pfx}${name}${sfx}_acquire acquire
> +then
>  acqrel=acquire
>  . ${ATOMICDIR}/acqrel.sh
> +fi
>  cat << EOF
>  static __always_inline ${ret}
>  arch_${atomic}_${pfx}${name}${sfx}_acquire(${params})
> diff --git a/scripts/atomic/fallbacks/add_negative b/scripts/atomic/fallbacks/add_negative
> index c032e8bec6e2..b105fdfe8fd1 100755
> --- a/scripts/atomic/fallbacks/add_negative
> +++ b/scripts/atomic/fallbacks/add_negative
> @@ -1,3 +1,5 @@
> +if /bin/sh ${ATOMICDIR}/chkdup.sh arch_${atomic}_add_negative${order} add_negative
> +then
>  cat <<EOF
>  /**
>   * arch_${atomic}_add_negative${order} - Add and test if negative
> @@ -7,6 +9,9 @@ cat <<EOF
>   * Atomically adds @i to @v and returns @true if the result is negative,
>   * or @false when the result is greater than or equal to zero.
>   */
> +EOF
> +fi
> +cat <<EOF
>  static __always_inline bool
>  arch_${atomic}_add_negative${order}(${int} i, ${atomic}_t *v)
>  {
> diff --git a/scripts/atomic/fallbacks/add_unless b/scripts/atomic/fallbacks/add_unless
> index 650fee935aed..d72d382e3757 100755
> --- a/scripts/atomic/fallbacks/add_unless
> +++ b/scripts/atomic/fallbacks/add_unless
> @@ -1,3 +1,5 @@
> +if /bin/sh ${ATOMICDIR}/chkdup.sh arch_${atomic}_add_unless add_unless
> +then
>  cat << EOF
>  /**
>   * arch_${atomic}_add_unless - add unless the number is already a given value
> @@ -8,6 +10,9 @@ cat << EOF
>   * Atomically adds @a to @v, if @v was not already @u.
>   * Returns @true if the addition was done.
>   */
> +EOF
> +fi
> +cat << EOF
>  static __always_inline bool
>  arch_${atomic}_add_unless(${atomic}_t *v, ${int} a, ${int} u)
>  {
> diff --git a/scripts/atomic/fallbacks/andnot b/scripts/atomic/fallbacks/andnot
> index 9fbc0ce75a7c..57b2a187374a 100755
> --- a/scripts/atomic/fallbacks/andnot
> +++ b/scripts/atomic/fallbacks/andnot
> @@ -1,3 +1,5 @@
> +if /bin/sh ${ATOMICDIR}/chkdup.sh arch_${atomic}_${pfx}andnot${sfx}${order} andnot
> +then
>  cat <<EOF
>  /**
>   * arch_${atomic}_${pfx}andnot${sfx}${order} - Atomic and-not
> @@ -7,6 +9,9 @@ cat <<EOF
>   * Atomically and-not @i with @v using ${docbook_order} ordering.
>   * returning ${docbook_oldnew} value.
>   */
> +EOF
> +fi
> +cat <<EOF
>  static __always_inline ${ret}
>  arch_${atomic}_${pfx}andnot${sfx}${order}(${int} i, ${atomic}_t *v)
>  {
> diff --git a/scripts/atomic/fallbacks/dec b/scripts/atomic/fallbacks/dec
> index e99c8edd36a3..e44d3eb96d2b 100755
> --- a/scripts/atomic/fallbacks/dec
> +++ b/scripts/atomic/fallbacks/dec
> @@ -1,3 +1,5 @@
> +if /bin/sh ${ATOMICDIR}/chkdup.sh arch_${atomic}_${pfx}dec${sfx}${order} dec
> +then
>  cat <<EOF
>  /**
>   * arch_${atomic}_${pfx}dec${sfx}${order} - Atomic decrement
> @@ -6,6 +8,9 @@ cat <<EOF
>   * Atomically decrement @v with ${docbook_order} ordering,
>   * returning ${docbook_oldnew} value.
>   */
> +EOF
> +fi
> +cat <<EOF
>  static __always_inline ${ret}
>  arch_${atomic}_${pfx}dec${sfx}${order}(${atomic}_t *v)
>  {
> diff --git a/scripts/atomic/fallbacks/dec_and_test b/scripts/atomic/fallbacks/dec_and_test
> index 3720896b1afc..94f5a6d4827c 100755
> --- a/scripts/atomic/fallbacks/dec_and_test
> +++ b/scripts/atomic/fallbacks/dec_and_test
> @@ -1,3 +1,5 @@
> +if /bin/sh ${ATOMICDIR}/chkdup.sh arch_${atomic}_dec_and_test dec_and_test
> +then
>  cat <<EOF
>  /**
>   * arch_${atomic}_dec_and_test - decrement and test
> @@ -7,6 +9,9 @@ cat <<EOF
>   * returns @true if the result is 0, or @false for all other
>   * cases.
>   */
> +EOF
> +fi
> +cat <<EOF
>  static __always_inline bool
>  arch_${atomic}_dec_and_test(${atomic}_t *v)
>  {
> diff --git a/scripts/atomic/fallbacks/dec_if_positive b/scripts/atomic/fallbacks/dec_if_positive
> index dedbdbc1487d..e27eb71dd1b2 100755
> --- a/scripts/atomic/fallbacks/dec_if_positive
> +++ b/scripts/atomic/fallbacks/dec_if_positive
> @@ -1,3 +1,5 @@
> +if /bin/sh ${ATOMICDIR}/chkdup.sh arch_${atomic}_dec_if_positive dec_if_positive
> +then
>  cat <<EOF
>  /**
>   * arch_${atomic}_dec_if_positive - Atomic decrement if old value is positive
> @@ -9,6 +11,9 @@ cat <<EOF
>   * there @v will not be decremented, but -4 will be returned.  As a result,
>   * if the return value is non-negative, then the value was in fact decremented.
>   */
> +EOF
> +fi
> +cat <<EOF
>  static __always_inline ${ret}
>  arch_${atomic}_dec_if_positive(${atomic}_t *v)
>  {
> diff --git a/scripts/atomic/fallbacks/dec_unless_positive b/scripts/atomic/fallbacks/dec_unless_positive
> index c3d01d201c63..ee00fffc5f11 100755
> --- a/scripts/atomic/fallbacks/dec_unless_positive
> +++ b/scripts/atomic/fallbacks/dec_unless_positive
> @@ -1,3 +1,5 @@
> +if /bin/sh ${ATOMICDIR}/chkdup.sh arch_${atomic}_dec_unless_positive dec_unless_positive
> +then
>  cat <<EOF
>  /**
>   * arch_${atomic}_dec_unless_positive - Atomic decrement if old value is non-positive
> @@ -7,6 +9,9 @@ cat <<EOF
>   * than or equal to zero.  Return @true if the decrement happened and
>   * @false otherwise.
>   */
> +EOF
> +fi
> +cat <<EOF
>  static __always_inline bool
>  arch_${atomic}_dec_unless_positive(${atomic}_t *v)
>  {
> diff --git a/scripts/atomic/fallbacks/fence b/scripts/atomic/fallbacks/fence
> index 975855dfba25..f4901343cd2b 100755
> --- a/scripts/atomic/fallbacks/fence
> +++ b/scripts/atomic/fallbacks/fence
> @@ -1,5 +1,8 @@
> +if /bin/sh ${ATOMICDIR}/chkdup.sh arch_${atomic}_${pfx}${name}${sfx} fence
> +then
>  acqrel=full
>  . ${ATOMICDIR}/acqrel.sh
> +fi
>  cat <<EOF
>  static __always_inline ${ret}
>  arch_${atomic}_${pfx}${name}${sfx}(${params})
> diff --git a/scripts/atomic/fallbacks/fetch_add_unless b/scripts/atomic/fallbacks/fetch_add_unless
> index a1692df0d514..ec583d340785 100755
> --- a/scripts/atomic/fallbacks/fetch_add_unless
> +++ b/scripts/atomic/fallbacks/fetch_add_unless
> @@ -1,3 +1,5 @@
> +if /bin/sh ${ATOMICDIR}/chkdup.sh arch_${atomic}_fetch_add_unless fetch_add_unless
> +then
>  cat << EOF
>  /**
>   * arch_${atomic}_fetch_add_unless - add unless the number is already a given value
> @@ -8,6 +10,9 @@ cat << EOF
>   * Atomically adds @a to @v, so long as @v was not already @u.
>   * Returns original value of @v.
>   */
> +EOF
> +fi
> +cat << EOF
>  static __always_inline ${int}
>  arch_${atomic}_fetch_add_unless(${atomic}_t *v, ${int} a, ${int} u)
>  {
> diff --git a/scripts/atomic/fallbacks/inc b/scripts/atomic/fallbacks/inc
> index 3f2c0730cd0c..bb1d5ea6846c 100755
> --- a/scripts/atomic/fallbacks/inc
> +++ b/scripts/atomic/fallbacks/inc
> @@ -1,3 +1,5 @@
> +if /bin/sh ${ATOMICDIR}/chkdup.sh arch_${atomic}_${pfx}inc${sfx}${order} inc
> +then
>  cat <<EOF
>  /**
>   * arch_${atomic}_${pfx}inc${sfx}${order} - Atomic increment
> @@ -6,6 +8,9 @@ cat <<EOF
>   * Atomically increment @v with ${docbook_order} ordering,
>   * returning ${docbook_oldnew} value.
>   */
> +EOF
> +fi
> +cat <<EOF
>  static __always_inline ${ret}
>  arch_${atomic}_${pfx}inc${sfx}${order}(${atomic}_t *v)
>  {
> diff --git a/scripts/atomic/fallbacks/inc_and_test b/scripts/atomic/fallbacks/inc_and_test
> index cc3ac1dde508..dd74f6a5ca4a 100755
> --- a/scripts/atomic/fallbacks/inc_and_test
> +++ b/scripts/atomic/fallbacks/inc_and_test
> @@ -1,3 +1,5 @@
> +if /bin/sh ${ATOMICDIR}/chkdup.sh arch_${atomic}_inc_and_test inc_and_test
> +then
>  cat <<EOF
>  /**
>   * arch_${atomic}_inc_and_test - increment and test
> @@ -7,6 +9,9 @@ cat <<EOF
>   * and returns @true if the result is zero, or @false for all
>   * other cases.
>   */
> +EOF
> +fi
> +cat <<EOF
>  static __always_inline bool
>  arch_${atomic}_inc_and_test(${atomic}_t *v)
>  {
> diff --git a/scripts/atomic/fallbacks/inc_not_zero b/scripts/atomic/fallbacks/inc_not_zero
> index 891fa3c057f6..38e2c13dab62 100755
> --- a/scripts/atomic/fallbacks/inc_not_zero
> +++ b/scripts/atomic/fallbacks/inc_not_zero
> @@ -1,3 +1,5 @@
> +if /bin/sh ${ATOMICDIR}/chkdup.sh arch_${atomic}_inc_not_zero inc_not_zero
> +then
>  cat <<EOF
>  /**
>   * arch_${atomic}_inc_not_zero - increment unless the number is zero
> @@ -6,6 +8,9 @@ cat <<EOF
>   * Atomically increments @v by 1, if @v is non-zero.
>   * Returns @true if the increment was done.
>   */
> +EOF
> +fi
> +cat <<EOF
>  static __always_inline bool
>  arch_${atomic}_inc_not_zero(${atomic}_t *v)
>  {
> diff --git a/scripts/atomic/fallbacks/inc_unless_negative b/scripts/atomic/fallbacks/inc_unless_negative
> index 98830b0dcdb1..2dc853c4e5b9 100755
> --- a/scripts/atomic/fallbacks/inc_unless_negative
> +++ b/scripts/atomic/fallbacks/inc_unless_negative
> @@ -1,3 +1,5 @@
> +if /bin/sh ${ATOMICDIR}/chkdup.sh arch_${atomic}_inc_unless_negative inc_unless_negative
> +then
>  cat <<EOF
>  /**
>   * arch_${atomic}_inc_unless_negative - Atomic increment if old value is non-negative
> @@ -7,6 +9,9 @@ cat <<EOF
>   * than or equal to zero.  Return @true if the increment happened and
>   * @false otherwise.
>   */
> +EOF
> +fi
> +cat <<EOF
>  static __always_inline bool
>  arch_${atomic}_inc_unless_negative(${atomic}_t *v)
>  {
> diff --git a/scripts/atomic/fallbacks/read_acquire b/scripts/atomic/fallbacks/read_acquire
> index 779f40c07018..680cd43080cb 100755
> --- a/scripts/atomic/fallbacks/read_acquire
> +++ b/scripts/atomic/fallbacks/read_acquire
> @@ -1,3 +1,5 @@
> +if /bin/sh ${ATOMICDIR}/chkdup.sh arch_${atomic}_read_acquire read_acquire
> +then
>  cat <<EOF
>  /**
>   * arch_${atomic}_read_acquire - Atomic load acquire
> @@ -6,6 +8,9 @@ cat <<EOF
>   * Atomically load from *@v with acquire ordering, returning the value
>   * loaded.
>   */
> +EOF
> +fi
> +cat <<EOF
>  static __always_inline ${ret}
>  arch_${atomic}_read_acquire(const ${atomic}_t *v)
>  {
> diff --git a/scripts/atomic/fallbacks/release b/scripts/atomic/fallbacks/release
> index bce3a1cbd497..a1604df66ece 100755
> --- a/scripts/atomic/fallbacks/release
> +++ b/scripts/atomic/fallbacks/release
> @@ -1,5 +1,8 @@
> +if /bin/sh ${ATOMICDIR}/chkdup.sh arch_${atomic}_${pfx}${name}${sfx}_release release
> +then
>  acqrel=release
>  . ${ATOMICDIR}/acqrel.sh
> +fi
>  cat <<EOF
>  static __always_inline ${ret}
>  arch_${atomic}_${pfx}${name}${sfx}_release(${params})
> diff --git a/scripts/atomic/fallbacks/set_release b/scripts/atomic/fallbacks/set_release
> index 46effb6203e5..2a65d3b29f4b 100755
> --- a/scripts/atomic/fallbacks/set_release
> +++ b/scripts/atomic/fallbacks/set_release
> @@ -1,3 +1,5 @@
> +if /bin/sh ${ATOMICDIR}/chkdup.sh arch_${atomic}_set_release set_release
> +then
>  cat <<EOF
>  /**
>   * arch_${atomic}_set_release - Atomic store release
> @@ -6,6 +8,9 @@ cat <<EOF
>   *
>   * Atomically store @i into *@v with release ordering.
>   */
> +EOF
> +fi
> +cat <<EOF
>  static __always_inline void
>  arch_${atomic}_set_release(${atomic}_t *v, ${int} i)
>  {
> diff --git a/scripts/atomic/fallbacks/sub_and_test b/scripts/atomic/fallbacks/sub_and_test
> index 204282e260ea..0397b0e92192 100755
> --- a/scripts/atomic/fallbacks/sub_and_test
> +++ b/scripts/atomic/fallbacks/sub_and_test
> @@ -1,3 +1,5 @@
> +if /bin/sh ${ATOMICDIR}/chkdup.sh arch_${atomic}_sub_and_test sub_and_test
> +then
>  cat <<EOF
>  /**
>   * arch_${atomic}_sub_and_test - subtract value from variable and test result
> @@ -8,6 +10,9 @@ cat <<EOF
>   * @true if the result is zero, or @false for all
>   * other cases.
>   */
> +EOF
> +fi
> +cat <<EOF
>  static __always_inline bool
>  arch_${atomic}_sub_and_test(${int} i, ${atomic}_t *v)
>  {
> diff --git a/scripts/atomic/fallbacks/try_cmpxchg b/scripts/atomic/fallbacks/try_cmpxchg
> index baf7412f9bf4..e08c5962dd83 100755
> --- a/scripts/atomic/fallbacks/try_cmpxchg
> +++ b/scripts/atomic/fallbacks/try_cmpxchg
> @@ -1,3 +1,5 @@
> +if /bin/sh ${ATOMICDIR}/chkdup.sh arch_${atomic}_try_cmpxchg${order} try_cmpxchg
> +then
>  cat <<EOF
>  /**
>   * arch_${atomic}_try_cmpxchg${order} - Atomic cmpxchg with bool return value
> @@ -9,6 +11,9 @@ cat <<EOF
>   * providing ${docbook_order} ordering.
>   * Returns @true if the cmpxchg operation succeeded, and false otherwise.
>   */
> +EOF
> +fi
> +cat <<EOF
>  static __always_inline bool
>  arch_${atomic}_try_cmpxchg${order}(${atomic}_t *v, ${int} *old, ${int} new)
>  {
> diff --git a/scripts/atomic/gen-atomics.sh b/scripts/atomic/gen-atomics.sh
> index 5b98a8307693..69bf3754df5a 100755
> --- a/scripts/atomic/gen-atomics.sh
> +++ b/scripts/atomic/gen-atomics.sh
> @@ -3,6 +3,10 @@
>  #
>  # Generate atomic headers
>  
> +T="`mktemp -d ${TMPDIR-/tmp}/gen-atomics.sh.XXXXXX`"
> +trap 'rm -rf $T' 0
> +export T
> +
>  ATOMICDIR=$(dirname $0)
>  ATOMICTBL=${ATOMICDIR}/atomics.tbl
>  LINUXDIR=${ATOMICDIR}/../..
> -- 
> 2.40.1
> 
