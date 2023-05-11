Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE276FFB4C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 22:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239374AbjEKU3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 16:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239160AbjEKU3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 16:29:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13EC6E90;
        Thu, 11 May 2023 13:29:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3571B65160;
        Thu, 11 May 2023 20:29:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D385C433D2;
        Thu, 11 May 2023 20:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683836944;
        bh=tTH7rKHrO5TIvduxYxjfHjNjYXZc1hEYflMKrrUL640=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=X8h2AOfJuljQNpl0ZblXP97y2wFv4xnVU+D9s9+lU3ZqXA4FN9+JeWdNGaFk6tRMP
         pO6teecBZ+CJWvKQ96IzJucHL43WZVGAbfS+mhcrDmQmU9xZCefvV2hbFkjwKB1VPT
         XYawbcFO6k39fRsfZ1pQcbu8frcKvlhK54vePVoDkPgepmz/YXLvYQocqmNrA33kIO
         KxWnpLI8t4fQWRmTfcAha9PezZQLAWoe2Tx7FxAj2VVQhxDnZvVU9IXksbsL/7Iq0d
         jrtbaYCUE/dJmUO2MvhQ+ZHazveKP5fTAmhA8Bh49OWRCzspk12KrI1vpOH69BP75C
         AahyxQ83PZmwA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 297ECCE0FED; Thu, 11 May 2023 13:29:04 -0700 (PDT)
Date:   Thu, 11 May 2023 13:29:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, akiyks@gmail.com,
        linux-doc@vger.kernel.org, kernel-team@meta.com,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH locking/atomic 18/19] locking/atomic: Refrain from
 generating duplicate fallback kernel-doc
Message-ID: <fc518edb-410b-4ea3-b628-26ef7d61000d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <19135936-06d7-4705-8bc8-bb31c2a478ca@paulmck-laptop>
 <20230510181717.2200934-18-paulmck@kernel.org>
 <20230511201837.GD2296992@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511201837.GD2296992@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 10:18:37PM +0200, Peter Zijlstra wrote:
> On Wed, May 10, 2023 at 11:17:16AM -0700, Paul E. McKenney wrote:
> > The gen-atomics.sh script currently generates 42 duplicate definitions:
> > 
> > 	arch_atomic64_add_negative
> > 	arch_atomic64_add_negative_acquire
> > 	arch_atomic64_add_negative_release
> > 	arch_atomic64_dec_return
> > 	arch_atomic64_dec_return_acquire
> > 	arch_atomic64_dec_return_release
> > 	arch_atomic64_fetch_andnot
> > 	arch_atomic64_fetch_andnot_acquire
> > 	arch_atomic64_fetch_andnot_release
> > 	arch_atomic64_fetch_dec
> > 	arch_atomic64_fetch_dec_acquire
> > 	arch_atomic64_fetch_dec_release
> > 	arch_atomic64_fetch_inc
> > 	arch_atomic64_fetch_inc_acquire
> > 	arch_atomic64_fetch_inc_release
> > 	arch_atomic64_inc_return
> > 	arch_atomic64_inc_return_acquire
> > 	arch_atomic64_inc_return_release
> > 	arch_atomic64_try_cmpxchg
> > 	arch_atomic64_try_cmpxchg_acquire
> > 	arch_atomic64_try_cmpxchg_release
> > 	arch_atomic_add_negative
> > 	arch_atomic_add_negative_acquire
> > 	arch_atomic_add_negative_release
> > 	arch_atomic_dec_return
> > 	arch_atomic_dec_return_acquire
> > 	arch_atomic_dec_return_release
> > 	arch_atomic_fetch_andnot
> > 	arch_atomic_fetch_andnot_acquire
> > 	arch_atomic_fetch_andnot_release
> > 	arch_atomic_fetch_dec
> > 	arch_atomic_fetch_dec_acquire
> > 	arch_atomic_fetch_dec_release
> > 	arch_atomic_fetch_inc
> > 	arch_atomic_fetch_inc_acquire
> > 	arch_atomic_fetch_inc_release
> > 	arch_atomic_inc_return
> > 	arch_atomic_inc_return_acquire
> > 	arch_atomic_inc_return_release
> > 	arch_atomic_try_cmpxchg
> > 	arch_atomic_try_cmpxchg_acquire
> > 	arch_atomic_try_cmpxchg_release
> > 
> > These duplicates are presumably to handle different architectures
> > generating hand-coded definitions for different subsets of the atomic
> > operations.  However, generating duplicate kernel-doc headers is
> > undesirable.
> > 
> > Therefore, generate only the first kernel-doc definition in a group
> > of duplicates.  A comment indicates the name of the function and the
> > fallback script that generated it.
> 
> So my canonical solution to fixing kernel-doc related problems is this
> trivial regex:
> 
> 	s/\/\*\*/\/\*/
> 
> works every time.

Can't say that I am a fan of that approach.

> And is *much* simpler than this:
> 
> >  scripts/atomic/chkdup.sh                     |  27 ++
> >  scripts/atomic/fallbacks/acquire             |   3 +
> >  scripts/atomic/fallbacks/add_negative        |   5 +
> >  scripts/atomic/fallbacks/add_unless          |   5 +
> >  scripts/atomic/fallbacks/andnot              |   5 +
> >  scripts/atomic/fallbacks/dec                 |   5 +
> >  scripts/atomic/fallbacks/dec_and_test        |   5 +
> >  scripts/atomic/fallbacks/dec_if_positive     |   5 +
> >  scripts/atomic/fallbacks/dec_unless_positive |   5 +
> >  scripts/atomic/fallbacks/fence               |   3 +
> >  scripts/atomic/fallbacks/fetch_add_unless    |   5 +
> >  scripts/atomic/fallbacks/inc                 |   5 +
> >  scripts/atomic/fallbacks/inc_and_test        |   5 +
> >  scripts/atomic/fallbacks/inc_not_zero        |   5 +
> >  scripts/atomic/fallbacks/inc_unless_negative |   5 +
> >  scripts/atomic/fallbacks/read_acquire        |   5 +
> >  scripts/atomic/fallbacks/release             |   3 +
> >  scripts/atomic/fallbacks/set_release         |   5 +
> >  scripts/atomic/fallbacks/sub_and_test        |   5 +
> >  scripts/atomic/fallbacks/try_cmpxchg         |   5 +
> >  scripts/atomic/gen-atomics.sh                |   4 +

This is not a huge addition, now is it?

							Thanx, Paul
