Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A057008FC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 15:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240972AbjELNTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 09:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241044AbjELNTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 09:19:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 414321FCD;
        Fri, 12 May 2023 06:18:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8ED94C14;
        Fri, 12 May 2023 06:19:40 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.58.179])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 764EF3F67D;
        Fri, 12 May 2023 06:18:54 -0700 (PDT)
Date:   Fri, 12 May 2023 14:18:48 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, akiyks@gmail.com,
        linux-doc@vger.kernel.org, kernel-team@meta.com,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH locking/atomic 18/19] locking/atomic: Refrain from
 generating duplicate fallback kernel-doc
Message-ID: <ZF48uBYKczItubrU@FVFF77S0Q05N>
References: <19135936-06d7-4705-8bc8-bb31c2a478ca@paulmck-laptop>
 <20230510181717.2200934-18-paulmck@kernel.org>
 <ZF0haDfyL3At3Ijw@FVFF77S0Q05N.cambridge.arm.com>
 <2a8b310c-3145-462b-a4c4-a130939da862@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a8b310c-3145-462b-a4c4-a130939da862@paulmck-laptop>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 12:12:16PM -0700, Paul E. McKenney wrote:
> On Thu, May 11, 2023 at 06:10:00PM +0100, Mark Rutland wrote:
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
> At first glance, it appears that your "TODO" locations have the same
> information that I was using, so it should not be hard for me to adapt the
> current kernel-doc generation to your new scheme.  (Famous last words!)

Great!

> Plus having the kernel-doc generation all in one place does have some
> serious attractions.

:)

> I will continue maintaining my current stack, but would of course be
> happy to port it on top of your refactoring.  If it turns out that
> the refactoring will take a long time, we can discuss what to do in
> the meantime.  But here is hoping that the refactoring goes smoothly!
> That would be easier all around.  ;-)

FWIW, I think that's working now; every cross-build I've tried works.

I've updated the branch at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=atomics/fallback-rework

Tagged as:

  atomics-fallback-rework-20230512

Thanks,
Mark.
