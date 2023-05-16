Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1350570562E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 20:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjEPSmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 14:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjEPSma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 14:42:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290997EDA;
        Tue, 16 May 2023 11:42:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D91D63DCB;
        Tue, 16 May 2023 18:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBFBC433EF;
        Tue, 16 May 2023 18:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684262548;
        bh=ocRl6YcheJFZTePbv3N2oTCU0SpLREIkqBXPg6L/Erk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ndK1xJgusTHFqtzPdamixfsF3HltCMxcsDOnor2USLnWLZV3D+fwtkO4CQ9vgnDv8
         LXAhsYPUn5wteOmfgYtfyqnkb4gMIaII2iRjCxiznk0KmB/fuxUsHzMd1bx4nm+hPO
         W5beKMcrtJgRyAMV9q+ASmnheDDIEfTFhLRifrJ/aPxObpmW8eb2Sp6NoPUvfoqlj1
         XT3g8M/q1xj+zREaBfeE3h3P7p5DJaFH1YtPGqkXPy9SwtsQzZ6v0hn0ingi9xFkSv
         bddARkKOq8VMcio0ikfWDp+v5tKs0Igdy+vKOhHlHoZxP5vmx2GFKnb5BUKrQcFhYV
         8FG4Km4d+HC/A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7AEEACE105A; Tue, 16 May 2023 11:42:27 -0700 (PDT)
Date:   Tue, 16 May 2023 11:42:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Akira Yokosawa <akiyks@gmail.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-doc@vger.kernel.org, kernel-team@meta.com,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH locking/atomic 18/19] locking/atomic: Refrain from
 generating duplicate fallback kernel-doc
Message-ID: <9035e2e1-7091-4b8a-94d9-7508c9b5cd7e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ZF0haDfyL3At3Ijw@FVFF77S0Q05N.cambridge.arm.com>
 <2a8b310c-3145-462b-a4c4-a130939da862@paulmck-laptop>
 <ZF48uBYKczItubrU@FVFF77S0Q05N>
 <b5498819-c2d4-414d-ba01-5373e749dc52@paulmck-laptop>
 <ZF5xXuPsrZEgAEEE@FVFF77S0Q05N>
 <e767dcc6-ea63-4ed8-9a15-9e5bb133fafc@paulmck-laptop>
 <b3956719-d478-4dc6-95fd-ec0744acc662@paulmck-laptop>
 <23195f15-7024-6fde-84f2-4cdd45c9abfc@gmail.com>
 <551c7820-1748-433b-8c42-daf777e202df@paulmck-laptop>
 <ZGO0s1FDGn/pzCPg@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGO0s1FDGn/pzCPg@FVFF77S0Q05N>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 05:52:03PM +0100, Mark Rutland wrote:
> Hi Paul,
> 
> On Sat, May 13, 2023 at 06:14:36PM -0700, Paul E. McKenney wrote:
> > On Sun, May 14, 2023 at 08:58:00AM +0900, Akira Yokosawa wrote:
> > > Running "./scripts/kernel-doc -none include/linux/atomic/atomic-arch-fallback.h"
> > > on the tag emits a lot of warnings.
> > > 
> > > Looks like there are kernel-doc comments who don't have a corresponding
> > > function signature next to them.
> > > 
> > >     /**
> > >      * function_name() - Brief description of function.
> > >      * @arg1: Describe the first argument.
> > >      * @arg2: Describe the second argument.
> > >      *        One can provide multiple line descriptions
> > >      *        for arguments.
> > >      *
> > >      * A longer description, with more discussion of the function function_name()
> > >      * that might be useful to those using or modifying it. Begins with an
> > >      * empty comment line, and may include additional embedded empty
> > >      * comment lines.
> > >      */
> > >     int function_name(int arg1, int arg2)  <---
> > > 
> > > Note that the kernel-doc script ignores #ifdef -- #else.
> > 
> > Me, I was thinking in terms of making this diagnostic ignore
> > include/linux/atomic/atomic-arch-fallback.h.  ;-)
> > 
> > The actual definitions are off in architecture-specific files, and
> > the kernel-doc headers could be left there.  But there are benefits to
> > automatically generating all of them.
> > 
> > Another approach might be to put a "it is OK for the definition to
> > be elsewhere" comment following those kernel-doc headers.
> > 
> > Any other ways to make this work?
> 
> I've spent the last day or so playing with this, and I think we can do this by
> relegating the arch_atomic*() functions to an implementation detail (and not
> documenting those with kerneldoc), and having a raw_atomic*() layer where we
> flesh out the API, where each can have a mandatory function definition as
> below:
> 
> /**
>  * raw_atomic_fetch_inc_release() - does a thing atomically
>  *
>  * TODO: fill this in
>  *
>  * This is a version of atomic_fetch_inc_release() which is safe to use in
>  * noinstr code. Unless instrumentation needs to be avoided,
>  * atomic_fetch_inc_release() should be used in preference.
>  */
> static __always_inline int
> raw_atomic_fetch_inc_release(atomic_t *v)
> {
> #if defined(arch_atomic_fetch_inc_release)
>         return arch_atomic_fetch_inc_release(v)
> #elif defined(arch_atomic_fetch_inc_relaxed)
>         __atomic_release_fence();
>         return arch_atomic_fetch_inc_relaxed(v);
> #elif defined(arch_atomic_fetch_inc)
>         return arch_atomic_fetch_inc(v)
> #else   
>         return raw_atomic_fetch_add_release(1, v);
> #endif
> }
> 
> ... and likewise we can add comments for the regular instrumented atomics.

I do like that approach!  It should be easy to adapt the kernel-doc
scripting to this.

> I've pushed out the WIP patches to my atomics/fallback-rework branch; if you're
> happy to give me another day or two I can get a bit further.

An RCU issue currently has me by the ankle, so I am quite happy to give
you a day or two.  ;-)

Just FYI, I will be in the air this coming Friday, your time.

> > For me, the option of making this
> > diagnostic ignore include/linux/atomic/atomic-arch-fallback.h has
> > considerable attraction.
> 
> It's certainly appealing...

But I do like your approach of simply always having the function prototype
available.  ;-)

							Thanx, Paul
