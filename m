Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED0F732AB0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242572AbjFPI5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242847AbjFPI52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:57:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6CBC30CD;
        Fri, 16 Jun 2023 01:57:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 092351FB;
        Fri, 16 Jun 2023 01:58:08 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.26.24])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F31733F5A1;
        Fri, 16 Jun 2023 01:57:21 -0700 (PDT)
Date:   Fri, 16 Jun 2023 09:57:16 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, akiyks@gmail.com,
        boqun.feng@gmail.com, corbet@lwn.net, keescook@chromium.org,
        linux@armlinux.org.uk, linux-doc@vger.kernel.org,
        mchehab@kernel.org, peterz@infradead.org, rdunlap@infradead.org,
        sstabellini@kernel.org, will@kernel.org
Subject: Re: [PATCH v2 25/27] locking/atomic: scripts: generate kerneldoc
 comments
Message-ID: <ZIwj7DzwdQUX2L+i@FVFF77S0Q05N>
References: <20230605070124.3741859-1-mark.rutland@arm.com>
 <20230605070124.3741859-26-mark.rutland@arm.com>
 <9fa47b57-df83-48aa-abb5-763f19f9b3e4@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fa47b57-df83-48aa-abb5-763f19f9b3e4@paulmck-laptop>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 07:07:13AM -0700, Paul E. McKenney wrote:
> On Mon, Jun 05, 2023 at 08:01:22AM +0100, Mark Rutland wrote:
> > Currently the atomics are documented in Documentation/atomic_t.txt, and
> > have no kerneldoc comments. There are a sufficient number of gotchas
> > (e.g. semantics, noinstr-safety) that it would be nice to have comments
> > to call these out, and it would be nice to have kerneldoc comments such
> > that these can be collated.
> > 
> > While it's possible to derive the semantics from the code, this can be
> > painful given the amount of indirection we currently have (e.g. fallback
> > paths), and it's easy to be mislead by naming, e.g.
> > 
> > * The unconditional void-returning ops *only* have relaxed variants
> >   without a _relaxed suffix, and can easily be mistaken for being fully
> >   ordered.
> > 
> >   It would be nice to give these a _relaxed() suffix, but this would
> >   result in significant churn throughout the kernel.
> > 
> > * Our naming of conditional and unconditional+test ops is rather
> >   inconsistent, and it can be difficult to derive the name of an
> >   operation, or to identify where an op is conditional or
> >   unconditional+test.
> > 
> >   Some ops are clearly conditional:
> >   - dec_if_positive
> >   - add_unless
> >   - dec_unless_positive
> >   - inc_unless_negative
> > 
> >   Some ops are clearly unconditional+test:
> >   - sub_and_test
> >   - dec_and_test
> >   - inc_and_test
> > 
> >   However, what exactly those test is not obvious. A _test_zero suffix
> >   might be clearer.
> > 
> >   Others could be read ambiguously:
> >   - inc_not_zero	// conditional
> >   - add_negative	// unconditional+test
> > 
> >   It would probably be worth renaming these, e.g. to inc_unless_zero and
> >   add_test_negative.
> > 
> > As a step towards making this more consistent and easier to understand,
> > this patch adds kerneldoc comments for all generated *atomic*_*()
> > functions. These are generated from templates, with some common text
> > shared, making it easy to extend these in future if necessary.
> > 
> > I've tried to make these as consistent and clear as possible, and I've
> > deliberately ensured:
> > 
> > * All ops have their ordering explicitly mentioned in the short and long
> >   description.
> > 
> > * All test ops have "test" in their short description.
> > 
> > * All ops are described as an expression using their usual C operator.
> >   For example:
> > 
> >   andnot: "Atomically updates @v to (@v & ~@i)"
> >   inc:    "Atomically updates @v to (@v + 1)"
> > 
> >   Which may be clearer to non-naative English speakers, and allows all
> >   the operations to be described in the same style.
> > 
> > * All conditional ops have their condition described as an expression
> >   using the usual C operators. For example:
> > 
> >   add_unless: "If (@v != @u), atomically updates @v to (@v + @i)"
> >   cmpxchg:    "If (@v == @old), atomically updates @v to @new"
> > 
> >   Which may be clearer to non-naative English speakers, and allows all
> >   the operations to be described in the same style.
> > 
> > * All bitwise ops (and,andnot,or,xor) explicitly mention that they are
> >   bitwise in their short description, so that they are not mistaken for
> >   performing their logical equivalents.
> > 
> > * The noinstr safety of each op is explicitly described, with a
> >   description of whether or not to use the raw_ form of the op.
> > 
> > There should be no functional change as a result of this patch.
> > 
> > Reported-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Will Deacon <will@kernel.org>
> 
> With the dec_if_positive fix:
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

Thanks! This is already queued in the tip tree's locking/core branch:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=locking/core

... so I was assuming that the dec_if_positive patch would be picked up atop
that.

Regardless, thanks for checking I hadn't missed anything else here! :)

Mark.
