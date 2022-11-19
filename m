Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F85630D8D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 09:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbiKSIu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 03:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKSIu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 03:50:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C07B31F82
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 00:50:55 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668847852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X7W84tVgmtzXWiGK1DtDy7dpFwth4iJrGxPevoDqGpw=;
        b=Xx1f4uRy1Ki7vMWW3NWJH4pM3kSMr4FxHTLvMJ5sHj3wnaty076HOrkgf2+PHzvhqQt7zY
        /36ypbmp20ebfx3Y/AaadCtsdM7Ev2HRtF3NT13y7A9W5xTjdueYgRXK7CwBigW3hmRQYx
        0G2EKIgiusw+4cPmG2jjHtUqDM1MO6LwzXpxgRCH+RVKdDspR9nAxRF0mSqpO2+S68iczJ
        odwtw54V1+UXef0lNzlEirDNmPaRKUv8QExFZ8RUjtrGRi3ctq3cbn0RTuI408+sEiL2Xe
        +R8kDns/dVMkgovAZbmRYFig6KC3O+KoEE4Yz7GyfJIdXyq0fF8M/11gjtVgaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668847852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X7W84tVgmtzXWiGK1DtDy7dpFwth4iJrGxPevoDqGpw=;
        b=cqWvKFwb09ATPLFiGF7iHH3p1Wb3mGtd6lzQGEYsGNvJCawcuN8d9mDjdLAFWnhY721AZb
        5JoXprhyllrb4YCw==
To:     Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Martin Liska <mliska@suse.cz>, Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 18/46] entry, lto: Mark raw_irqentry_exit_cond_resched()
 as __visible
In-Reply-To: <8d055277-1f55-fc93-87cb-7a8f0d8d2839@linux.intel.com>
References: <20221114114344.18650-1-jirislaby@kernel.org>
 <20221114114344.18650-19-jirislaby@kernel.org> <87a64qo4th.ffs@tglx>
 <Y3XzkxNVTvdB4a/1@hirez.programming.kicks-ass.net>
 <289e03d2-be50-4249-343a-75dae302b0e5@linux.intel.com>
 <8735ahkq55.ffs@tglx>
 <8d055277-1f55-fc93-87cb-7a8f0d8d2839@linux.intel.com>
Date:   Sat, 19 Nov 2022 09:50:52 +0100
Message-ID: <87v8nbiaz7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18 2022 at 16:50, Andi Kleen wrote:
>> Sure, they can play around with it but that does not require to merge
>> all this nonsensical ballast for a half thought out compiler.
>
> You are referring to __visible?
>
> TBH I don't understand the problem. In general __visible is useful
> documentation, so you know something is used from assembler or other
> strange contexts.  Doing such things explicitly marked instead of
> implicitly hidden and they just happen to work by accident
> seems cleaner to me.

Seems cleaner is really not a technical argument. Visible is completely
useless. Either a symbol is global and therefore reachable from any
point in the final "executable" or it's not. Whether that reference is
in assembly or from a pointer, static key or whatever does not matter at
all. There is no such thing as a 'strange context'.

Nothing works here by accident. A global symbol is a global symbol
whether it's defined or referenced from C or from ASM or from any other
programming language does not matter at all.

> I can also see the __visible markings being useful for other purposes,
> e.g. static analysis tools or dynamic instrumentation like the various
> sanitizers. Everything that is referenced outside the normal code that
> the compiler sees may need some special handling.

All you have is 'may need' and 'I can see'. Where is the actual use case?

>> If they want to do that they can apply the pile of patches as provided
>> and play around.
>
> It's very difficult to maintain out of tree, while in tree it's much 
> simpler.

Sure. Lots of things are simpler to maintain in tree, but that's not an
argument for merging anything.

> I think Linux should support its primary compiler well and not give up 
> due to relatively small obstacles.

It's not an obstacle. It's a fundamental broken model. clang has proven
that it can be done proper, so there is no reason to proliferate the
inferior.

While you might consider gcc to be the primary compiler, that might have
been true a decade ago. A lot of people prefer clang as their primary
compiler simply because its saner and the maintainers behind it are
working with us and not trying to inflict their half baken crap on us to
spare themself the work to do it right.

Thanks,

        tglx
