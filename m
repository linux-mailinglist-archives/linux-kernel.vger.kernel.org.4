Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE82761ECA8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 09:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbiKGILV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 03:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiKGILT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 03:11:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D4913F5A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 00:11:18 -0800 (PST)
Date:   Mon, 7 Nov 2022 09:11:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667808676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i8TWACLbeYPnb6i/itaQfQovVtDzXJg8yp8PNvc/44Q=;
        b=zmxysgUqLH6g5w/1nWOrfc/ALVKleShJAX8HIRN9lFfn1IKvjXnsff41mJ8hsN0dAVWPWr
        E0j8+fkfLKLIjkpXKm2KjPguDeBLe4Fn7m6eXHvlGx0WGGcIRyjIvJ7eGyI/quBTWOfWgI
        LEQMk8VWtufQD9f6mSQ2nI7rRMaOzhgnCRp1XnbpteQvsNL1y33FqZlKaZiwcp8HLuMHCd
        9Lu+19va6fiaZWoUYW0CIsOru99oCT8V0czJUg5snTYsax7rdjEkA73ELnFf9u9YcwI79j
        fMaejeHz6u5aSnkjslPSKHYgvKoBwTdYIwtX5YKl2d+Al6O4Q7H2Em4UYoYDIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667808676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i8TWACLbeYPnb6i/itaQfQovVtDzXJg8yp8PNvc/44Q=;
        b=FAEwpyxGhgJXoSIYFfrcaUo2qmiBe43afbJgDwk/Q9PvG5/3cAq2Zc+3yrriFSMy5OkL91
        X0I1zwywyWtKFUCg==
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Stephen Boyd <sboyd@kernel.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v4 05/16] add_timer_on(): Make sure callers have TIMER_PINNED
 flag
In-Reply-To: <20221104164342.GA1440400@lothringen>
Message-ID: <f72b4d5d-493d-916-5d19-2bf87e8c41e1@linutronix.de>
References: <20221104145737.71236-1-anna-maria@linutronix.de> <20221104145737.71236-6-anna-maria@linutronix.de> <20221104164342.GA1440400@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2022, Frederic Weisbecker wrote:

> On Fri, Nov 04, 2022 at 03:57:26PM +0100, Anna-Maria Behnsen wrote:
> > The implementation of the hierachical timer pull model will change the
> > timer bases per CPU. Timers, that have to expire on a specific CPU, require
> > the TIMER_PINNED flag. Otherwise they will be queued on the dedicated CPU
> > but in global timer base and those timers could also expire on other
> > CPUs. Timers with TIMER_DEFERRABLE flag end up in a separate base anyway
> > and are executed on the local CPU only.
> > 
> > Therefore add the missing TIMER_PINNED flag for those callers who use
> > add_timer_on() without the flag. No functional change.
> 
> You're fixing the current callers but what about the future ones?
> 
> add_timer_on() should always guarantee that a timer runs on the
> right destination, which is not the case after your patchset if the
> timer hasn't been set to TIMER_PINNED.
> 
> Therefore I think we should either have:
> 
> * add_timer_on() enforce TIMER_PINNED (doesn't work because if the timer is
>   later called with mod_timer(), we should expect it to run anywhere)
> 
> or
> 
> * add_timer_on() warns if !TIMER_PINNED

This is already part of the last patch of the queue where also the
crystalball logic is removed. But the patch where I added the WARN_ONCE()
might be the wrong patch, it should be better part of the next patch where
the new timer bases are introduced.

> or
> 
> * have an internal flag TIMER_LOCAL, that is turned on when
>   add_timer_on() is called or add_timer()/mod_timer() is called
>   on a TIMER_PINNED. Otherwise it is turned off.
> 
> The last solution should work with existing API and you don't need to
> chase the current and future users of add_timer_on().

With the last approach it doesn't matter how the timer is setup. Everything
is done by timer code implicitly. When a future caller uses add_timer_on()
and wants to modfiy this "implicitly pinned timer", he will call
mod_timer() and the timer is no longer pinned (if it do not end up in the
same bucket it was before). For a user this does not seems to be very
obvious, or am I wrong?

But if the caller sets up the timer correctly we do not need this extra
timer flag. With the WARN_ONCE() in place, callers need to do the timer
setup properly and it is more clear to the caller what should be done.

BTW, the hunk in this patch for the workqueue is also not a final fix in my
opinion. I'm preparing a cleanup queue (it's part of the deferrable cleanup
queue), where I want to set the timer flags properly when
initializing/defining the workers. I should have added a comment here...

Thanks,

	Anna-Maria

