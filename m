Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FBF70FA31
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 17:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235837AbjEXPdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 11:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236227AbjEXPdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 11:33:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE8E1A4
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:33:09 -0700 (PDT)
Date:   Wed, 24 May 2023 17:33:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684942387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lYvue+5+U8g6PY27mjpGf7EoNllwg1l1SmANn8QWJuY=;
        b=BI4rURRFeibXSU3UNx24Gz/qJJrzJgVG1mtpRAVM5CQAXpmBkeuhSad9rCtSMgtpsudzRl
        Us9d7XylJ7xSEMoXOlkiV1uFWTUkTXfnoUQQd7SjKdobsrCZPY39+sP7ht+SQP7WB+fzAT
        cANyYXi4ziYYzDBRaFpgzNvVNTssh74/nAmoAW/N4jzm0spI0uHVPszwKwwrVTuRQs7dEx
        Fecpvu6OQHKsoSyRI/vC437j3IqgX+AP3FifyVm5AvES7v4OT2WfoK5UIa9QSsU74Mhjj2
        sakogeIkwQ0lw8oXajCgkeQ3x3e+EHXMtC73+PvhxMRAELwCFH/EfNp+4aMN5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684942387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lYvue+5+U8g6PY27mjpGf7EoNllwg1l1SmANn8QWJuY=;
        b=AXHl8eTPVVr3sXNv0cwNx5Q8u1j7CltAnQwZPkwr2CKwGTHCKMkbHjgS66wIs8hR6vmkII
        EspxYwax3VbEbEBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hillf Danton <hdanton@sina.com>, linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4] signal: Let tasks cache one sigqueue struct.
Message-ID: <20230524153305.60aTQ2sC@linutronix.de>
References: <20230406194004.KP1K6FwO@linutronix.de>
 <20230407000306.940-1-hdanton@sina.com>
 <ZC+Tt2WqyFmNEm/w@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZC+Tt2WqyFmNEm/w@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-07 04:53:27 [+0100], Matthew Wilcox wrote:
> On Fri, Apr 07, 2023 at 08:03:06AM +0800, Hillf Danton wrote:
> > On Thu, 6 Apr 2023 22:47:21 +0200 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > The sigqueue caching originated in the PREEMPT_RT tree. A few of the
> > > applications, that were ported to Linux, were ported from OS-9. Sending
> > > notifications from one task to another via a signal was a common
> > > communication model there and so the applications are heavy signal
> > > users. Removing the allocation reduces the critical path, avoids locks
> > > and so lowers the maximal latency of the task while sending a signal.
> 
> It might lower the _average_ latency, but it certainly doesn't lower
> the _maximum_ latency, because you have to assume worst case scenario
> for maximum latency.  Which is that there's no sigqueue cached, so you
> have to go into the slab allocator.  And again, worst case scenario is
> that you have to go into the page allocator from there, and further that
> you have to run reclaim, and ...

Yes. The idea is in general not to send more signals in parallel than
the available number cached slots.

> What I find odd about the numbers that you quote:
> 
> > The numbers of system boot followed by an allmod kernel build:
> > Out of 333216 allocations, 194876 (~58%) were served from the cache.
> > From all free invocations, 4212 were in a path were caching is not done
> > and 329002 sigqueue were cached.
> 
> ... is that there's no absolute numbers.  Does it save 1% of the cost
> of sending a signal?  10%?  What does perf say about the cost saved
> by no longer going into slab?  Because the fast path in slab is very
> fast.  It might even be quicker than your fast path for multithreaded
> applications which have threads running on different NUMA nodes.

I asked for updated numbers and the improvement is not as big as
initially reported. There might have been a change in the configuration
for the testing an so the improvement is not as big as initially assumed.
I'm sorry, but I didn't get any numbers to back anything up. I'm
dropping the effort here, thanks for the review :)

Sebastian
