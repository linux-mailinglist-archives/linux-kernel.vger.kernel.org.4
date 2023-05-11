Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514026FFA65
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 21:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239312AbjEKTjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 15:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239297AbjEKTjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 15:39:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABCC93E0;
        Thu, 11 May 2023 12:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rNxGOtNv4nwNd9WYZv3/bysAISXcHMOu6EkMVwfV4QY=; b=mogy6unPJLnDFVL21r/dgIV1Bn
        WndJfUd6W24Hs/5ij8ycNArN2Be+jaeowgL7m3H5RT5QChmKqG1vPN2LgvfvpP7sEKeGZOGARKvi+
        PDC+TvguLSnz6VltR9fHnxE4BVCnL309yLbas5BJhQuXZPQGZwCU5CY/r7i+2FnrVdFslfzy8Dq1c
        p5XBcj+KJ5LdwOktvKMooXAzju0mj5tCE1YlDTuu7iPj1uvmkhAIoXXLIUpA8je6WPQk+eIoczLxs
        t+4IDgYLpxEMmjsIZEy4437LeFba93miE7HxZJlp8dEhnmK7M3g3VSgB+C4vjhtBu4iQoFEVFRp/1
        0BibqKlQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pxC7u-00HVjo-Al; Thu, 11 May 2023 19:38:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C7B35300451;
        Thu, 11 May 2023 21:38:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A433B2C7C5BFE; Thu, 11 May 2023 21:38:56 +0200 (CEST)
Date:   Thu, 11 May 2023 21:38:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org, akiyks@gmail.com,
        linux-doc@vger.kernel.org, kernel-team@meta.com,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH locking/atomic 18/19] locking/atomic: Refrain from
 generating duplicate fallback kernel-doc
Message-ID: <20230511193856.GA2296992@hirez.programming.kicks-ass.net>
References: <19135936-06d7-4705-8bc8-bb31c2a478ca@paulmck-laptop>
 <20230510181717.2200934-18-paulmck@kernel.org>
 <ZF0haDfyL3At3Ijw@FVFF77S0Q05N.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZF0haDfyL3At3Ijw@FVFF77S0Q05N.cambridge.arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 06:10:00PM +0100, Mark Rutland wrote:
> Hi Paul
> 
> On Wed, May 10, 2023 at 11:17:16AM -0700, Paul E. McKenney wrote:
> > The gen-atomics.sh script currently generates 42 duplicate definitions:
> > 
> > 	arch_atomic64_add_negative
> > 	arch_atomic64_add_negative_acquire
> > 	arch_atomic64_add_negative_release
> 
> 	[...]
> 
> > These duplicates are presumably to handle different architectures
> > generating hand-coded definitions for different subsets of the atomic
> > operations.
> 
> Yup, for each FULL/ACQUIRE/RELEASE/RELAXED variant of each op, we allow the
> archtiecture to choose between:
> 
> * Providing the ordering variant directly
> * Providing the FULL ordering variant only
> * Providing the RELAXED ordering variant only
> * Providing an equivalent op that we can build from
> 
> > However, generating duplicate kernel-doc headers is undesirable.
> 
> Understood -- I hadn't understood that duplication was a problem when this was
> originally written.
> 
> The way this is currently done is largely an artifact of our ifdeffery (and the
> kerneldoc for fallbacks living inthe fallback templates), and I think we can
> fix both of those.
> 
> > Therefore, generate only the first kernel-doc definition in a group
> > of duplicates.  A comment indicates the name of the function and the
> > fallback script that generated it.
> 
> I'm not keen on this approach, especially with the chkdup.sh script -- it feels
> like we're working around an underlying structural issue.
> 
> I think that we can restructure the ifdeffery so that each ordering variant
> gets its own ifdeffery, and then we could place the kerneldoc immediately above
> that, e.g.
> 
> 	/**
> 	 * arch_atomic_inc_return_release()
> 	 *
> 	 * [ full kerneldoc block here ]
> 	 */
> 	#if defined(arch_atomic_inc_return_release)
> 	/* defined in arch code */
> 	#elif defined(arch_atomic_inc_return_relaxed)
> 	[ define in terms of arch_atomic_inc_return_relaxed ]
> 	#elif defined(arch_atomic_inc_return)
> 	[ define in terms of arch_atomic_inc_return ]
> 	#else
> 	[ define in terms of arch_atomic_fetch_inc_release ]
> 	#endif
> 
> ... with similar for the mandatory ops that each arch must provide, e.g.
> 
> 	/**
> 	 * arch_atomic_or()
> 	 *
> 	 * [ full kerneldoc block here ]
> 	 */
> 	/* arch_atomic_or() is mandatory -- architectures must define it! */
> 
> I had a go at that restructuring today, and while local build testing indicates
> I haven't got it quite right, I think it's possible:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=atomics/fallback-rework
> 
> Does that sound ok to you?

If the end result is simpler scripts, sure.

I'm not at all keen to complicate the scripts for something daft like
kernel-doc. The last thing we need is documentation style weenies making
an unholy mess of things.
