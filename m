Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F5F6FFAE1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 21:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239384AbjEKTxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 15:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238502AbjEKTxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 15:53:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE4394;
        Thu, 11 May 2023 12:53:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26FFA650B6;
        Thu, 11 May 2023 19:53:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880ADC433EF;
        Thu, 11 May 2023 19:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683834826;
        bh=BkdI8mWSj5IwdlV5+hQdSi0IpqFWZ3SrwIq6fXS+Fy8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=P2vrz0TfX4QXI3f4duhILMdIacMdnhCvuvLdC8xwtokC3qY+CqbSVFmByYSGizz5H
         ka6q9s7YXjAtQQMxDrkkZDaMgtk0MgwdX6kSt8JQpVV2vBusodesLdN/zrlNHkUaNE
         Py5qJ6Pb0m2JpFGAS1/0QtzB+nD+OlXS0rhiLiFEayLK5DkGrGzumu4YnGiHuMiBCX
         RHGjW5hF1DgCKPZR4DFbAI0IM6/6PAST+7aDXRh5DzMiRJcz31uj83EzaVPQizBIJM
         Zv+ac/ih46A29Ui5JgPuCgRp4V6qJl34uVdQPy9Hd89eILgccGP6WYHOkabe0vR6e5
         tWqG8bNz69z1Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2351DCE0FED; Thu, 11 May 2023 12:53:46 -0700 (PDT)
Date:   Thu, 11 May 2023 12:53:46 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, akiyks@gmail.com, linux-doc@vger.kernel.org,
        kernel-team@meta.com, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH locking/atomic 18/19] locking/atomic: Refrain from
 generating duplicate fallback kernel-doc
Message-ID: <c619d689-e7b5-4136-9bd3-8f41954f43cd@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <19135936-06d7-4705-8bc8-bb31c2a478ca@paulmck-laptop>
 <20230510181717.2200934-18-paulmck@kernel.org>
 <ZF0haDfyL3At3Ijw@FVFF77S0Q05N.cambridge.arm.com>
 <20230511193856.GA2296992@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511193856.GA2296992@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
> 
> I'm not at all keen to complicate the scripts for something daft like
> kernel-doc. The last thing we need is documentation style weenies making
> an unholy mess of things.

Do you have an alternative suggestion for generating the kernel-doc?
The current lack of it is problematic.

							Thanx, Paul
