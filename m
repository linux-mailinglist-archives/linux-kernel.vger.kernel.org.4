Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31B4745E89
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 16:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjGCOdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 10:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGCOdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 10:33:13 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E06D94
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 07:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M6biFba36/dvwdpy7paAJx9BloGDg1HvyAfRKozbIbM=; b=lNsGz6yBP0gwxsmfObKEVVhhNV
        1itYd21MtlUDQUM0Xs+5MXfVVcckVgOkepzn6ZZJjwDRYM79jUT0Ot9azSjGKXm81eJ5WYBwNzEIw
        hOGTvN4h601JsE2IgpAuKtn/f+OJ6WukgMyT1gMRwqSr0168zgLxMq+ZSy12lIUoE5yXp+yUxVEyR
        Lwl7809TsvCpC02LhahATgU2QEvtQ9uD8rar+7pOSGO4yP0nVDbC2Ne3jNEb55xzGKNz5ti84h6wr
        JrYjQG+r4fQJmZE7pVXUfWJkftjst/bwKH2/e26ePELImJfLqRnUwKUg2M2omcFWfbg1beuSSY4gV
        0AbvGYEA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qGKbr-00A6Mw-0n;
        Mon, 03 Jul 2023 14:32:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 073EC3001E7;
        Mon,  3 Jul 2023 16:32:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BA4D520292D0E; Mon,  3 Jul 2023 16:32:57 +0200 (CEST)
Date:   Mon, 3 Jul 2023 16:32:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ben Segall <bsegall@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v4] Sched/fair: Block nohz tick_stop when cfs bandwidth
 in use
Message-ID: <20230703143257.GY83892@hirez.programming.kicks-ass.net>
References: <20230630135714.1018434-1-pauld@redhat.com>
 <20230630150641.GH2533791@hirez.programming.kicks-ass.net>
 <20230630152824.GC43299@lorien.usersys.redhat.com>
 <20230630160534.GA2534344@hirez.programming.kicks-ass.net>
 <20230630162910.GD43299@lorien.usersys.redhat.com>
 <20230703121009.GH4253@hirez.programming.kicks-ass.net>
 <20230703141056.GA67396@lorien.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703141056.GA67396@lorien.usersys.redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 10:10:56AM -0400, Phil Auld wrote:
> On Mon, Jul 03, 2023 at 02:10:09PM +0200 Peter Zijlstra wrote:
> > On Fri, Jun 30, 2023 at 12:29:10PM -0400, Phil Auld wrote:
> > 
> > > I think you are agreeing that I need the pick next code but need to remove
> > > the hierarchy walks, right?
> > 
> > Yeah, the dequeue case makes we have to care about pick, not sure we
> > then also need to care about sched_update_tick_dependency() though.
> > There is indeed a window where these two will 'race', but afaict it is
> > benign.
> > 
> 
> Hm, that's confusing.
> 
> As I see it it's the enqueue case (0->1 mostly) where we need the check
> in pick.  At that point in enqueue we only have a handle on ->curr which
> is the idle thread.

Well, the 0->1 case is trivial, we'll run the task that's enqueued, and
as such everything can DTRT and be simple.

> For the dequeue case (2->1) we need the check in the
> sched_update_tick_dependency() path because if the 1 is the task on the
> cpu (and is staying there) then we'd otherwise clear the bit when we
> shouldn't (since we aren't going to go back through pick).

The 2->1 case OTOH is tricky, because then we'll end up running a task
we've not recently seen. sub_nr_running() will hit the ==1 case and
clear TICK_DEP_BIT_SCHED.

But then pick will come and set it again, no harm done, right?

.oO Ah!, You're worried about the case where a task is already running,
a second task comes in, (1->2) and then quickly leaves again (2->1)
without passing through schedule(). And you don't want to disable the
tick if that running task needs it.

Mooo :-(

> I'm thinking that I'll try to set the bit in pick since we only care about
> it when it's the task on the cpu.  That, I think, will simplify the
> code needed to update the bit when the quota is changed (to or from
> RUNTIME_INF).
> 
> Setting the bit in enqueue/dequeue means updating it on all the queued
> task if it changes. Although I may clear it in dequeue just to not leave
> it around stale.

Hmm, no you have to set on enqueue (1->2), otherwise the running task
doesn't get preempted when it runs out of slice.

And I don't suppose you want to delay clearing to the first tick after,
because NOHZ_FULL doesn't want spurious ticks :/

What a mess.

Please document all these stupid cases in a comment, otherwise we'll go
bananas trying to make sense of the code later on.
