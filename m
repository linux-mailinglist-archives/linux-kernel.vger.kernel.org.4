Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D43695369
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 22:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjBMVwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 16:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjBMVwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 16:52:54 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA326185
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 13:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dAIoj3yLDoCA6OEqzK/oW7tr31FDz8nemZmjFZA+QIA=; b=c7hV1slied1adFVdEAkB+sNmqT
        Q09QA17SU1k1h6kO3Gj01tJvXWnm2ujvFo93Kx6E3VJtKrh0A2kB+J8kuiSpfMIoJQTTQME+63Avn
        qJGHWMTWdOnB95vORxFhxc5tIE7M3G9OMCapW8DdapZ9TRnqmKIXkzFozUVR5gFNn4Zk58dHrqrdj
        qwyfDcGPH943apg8fAG1ecFFLQM2YM2baPfPQZDz5tkYu5yXjzMZc4Pjey6DjExk+9WcZXwFYSXuT
        4fzIBjZJTIVSKUfW2mqLgk8HdMug7b00PhcT0OmbapitM7cYld0fcIDupqLquqpp2d+PXUHzXadnA
        TJuFtuDw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pRgjm-009TBt-09;
        Mon, 13 Feb 2023 21:51:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0912430030F;
        Mon, 13 Feb 2023 22:52:30 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DFDC520D18CCA; Mon, 13 Feb 2023 22:52:29 +0100 (CET)
Date:   Mon, 13 Feb 2023 22:52:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, john.p.donnelly@oracle.com,
        Hillf Danton <hdanton@sina.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Ting11 Wang =?utf-8?B?546L5am3?= <wangting11@xiaomi.com>
Subject: Re: [PATCH v7 4/4] locking/rwsem: Enable direct rwsem lock handoff
Message-ID: <Y+qxHXwXSsIZnVtH@hirez.programming.kicks-ass.net>
References: <20230126003628.365092-1-longman@redhat.com>
 <20230126003628.365092-5-longman@redhat.com>
 <Y+otv+QGyMpHAFO1@hirez.programming.kicks-ass.net>
 <19c54f55-3b27-6777-e42c-8d7b25b6f2b5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19c54f55-3b27-6777-e42c-8d7b25b6f2b5@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 12:14:59PM -0500, Waiman Long wrote:

> > I am once again confused...
> > 
> > *WHY* are you changing the writer wake-up path? The comments added here
> > don't clarify anything.
> > 
> > If we set handoff, we terminate/disallow the spinning/stealing. The
> > direct consequence is that the slowpath/wait-list becomes the only way
> > forward.
> Yes, that is true.
> > 
> > Since we don't take wait_lock on up, we fundamentally have a race
> > condition. But *WHY* do you insist on handling that in rwsem_wake()?
> > Delaying all that until rwsem_try_write_lock()? Doing so would render
> > pretty much all of the above pointless, no?
> 
> There is an advantage in doing the handover earlier, if possible. A reader
> that comes in between can spoils the takeover of the rwsem in

How ?!? since all the stealing and spinning is out, the wait-list reigns
supreme. A new reader will queue.

Are you worried about the spurious elevation of ->count due to that
uncondition increment on down_read() ? This is always going to be the
case.

> rwsem_try_write_lock() and cause it to sleep again. Since we will have to
> take the wait lock anyway in rwsem_wake(), there isn't much additional cost
> to do some additional check.

There is a complexity cost -- and so far I've not seen a single line of
justification for the added complexity.

> Note that the kernel test robot had detected a 19.3% improvement of
> will-it-scale.per_thread_ops [1] due to this commit. That indicates this
> commit is good to have. I am planning to update the commit log to include
> that information as well as additional reasoning as discussed here.

Seen that; but who's saying a simpler implementation will not also have
those gains. And if not, then we have a clear separation into
functionality and optimization and justifications for it.

But now, we have neither. I'm not saying the patch is wrong -- I'm
saying it is needlessly complicated without justification.

All this stuff is hard enough -- we should really try to keep is as
simple as possible, having two distinct ways to wake up a writer is not
'as simple as possible'.

> > After all, rwsem_mark_wake() already wakes the writer if it is first,
> > no? Why invent yet another special way to wake up the writer.
> As I said before, waking up the writer does not mean it can always get the
> rwsem on the first rwsem_try_write_lock(). Doing early handoff in
> rwsem_wake() can remove that ambiguity.

But what if it is rwsem_down_read_slowpath() that drops ->count to 0 and
does rwsem_mark_wake() and misses your fancy new path?

That is, I'm thinking there's an argument to be had that rwsem_wake() is
fundamentally the wrong place to do anything.

OTOH, you are right in that rwsem_mark_wake() is in a special position;
it *KNOWS* the reader count has hit 0 and can ignore future spurious
increments because by knowing it was 0 it knows they *WILL* fail and
queue (provided WAITERS||HANDOFF) -- but I've not seen you
articulate this point.

(note how rwsem_cond_wake_waiter() relies on exactly this to select
WAKE_ANY)

You are also right in that having these different means of waking
readers and writers is 'confusing'.

But you failed to take things to their natural conclusion -- change the
way we do writer wakeups, all writer wakeups.

So change rwsem_mark_wake()'s writer wakeup and
rwsem_down_write_slowpath() to always so that waiter->task thing that
the readers already do.

It means putting all the logic for waking writers into
rwsem_mark_wake(), but then we can make full use of this 'we hit zero
future readers are temporary noise'. Althought I suspect you might need
to pass count into it, so we can observe the flags at the time 0 was
observed.

Is all that making sense? -- it has been a long day :-)

> > Also; and I asked this last time around; why do we care about the
> > handoff to writer *at*all* ? It is the readers that set HANDOFF.
> 
> HANDOFF can happen for both readers and writers. Handoff to writer is
> actually more important than to readers.

Hmm, clearly I missed something. This is rwsem_try_write_lock() setting
it, right?
