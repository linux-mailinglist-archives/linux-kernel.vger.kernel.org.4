Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9AB620CE1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 11:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbiKHKIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 05:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233574AbiKHKIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 05:08:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1032BF9
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 02:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3jXWBjHH4m5pXjhj9tcfbgJa8HZbNC9xLMclLMMD3Rc=; b=RynkomRYB81X/K14Gb84hQlhgm
        bdXalhn337To4xkBOFz3EhIzyrlgV/nMLd2CBm0D+pemurahrp614Q6uOl6BfbVSqsfLsiBE8u4r/
        feFPclQ8RoEgejKhawdGtMWv+mLXeOROB6naGSzSflqG9CG4e0A7bs4HM7rHK4kxe575qDXNkTILU
        qh7WIkTpy+wBerjixBkCgxVI1I3amTgV+eoh5ovANidf/+he6S8AVoc65RoruEcmaE7w9ruG3RoDn
        IWICX6YKjbMQEOjRRPGanx4MiCf5UCyMATZu44iinuvZAPFHTpyHE6zEt+BAFwpDa1Hivp9mMU+hq
        De03NYSA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1osLX7-00AAtb-Nn; Tue, 08 Nov 2022 10:08:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 726E730041D;
        Tue,  8 Nov 2022 11:08:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4CBD42B8932BB; Tue,  8 Nov 2022 11:08:35 +0100 (CET)
Date:   Tue, 8 Nov 2022 11:08:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: Minor optimize ttwu_runnable()
Message-ID: <Y2oqo0u2/TPN3ozU@hirez.programming.kicks-ass.net>
References: <20221102102343.57845-1-zhouchengming@bytedance.com>
 <xhsmhr0yivazl.mognet@vschneid.remote.csb>
 <7b8bd69a-39cb-a1f0-6ccd-7b0810ef0db7@bytedance.com>
 <xhsmhwn86ncrs.mognet@vschneid.remote.csb>
 <346228d3-8b80-4e9b-0157-662429b11a05@bytedance.com>
 <xhsmhtu3an4jl.mognet@vschneid.remote.csb>
 <Y2odVSwrCSI2LW2m@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2odVSwrCSI2LW2m@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 10:11:49AM +0100, Peter Zijlstra wrote:
> On Mon, Nov 07, 2022 at 03:54:38PM +0000, Valentin Schneider wrote:
> 
> > So that's the part for the p->sched_class->task_woken() callback, which
> > only affects RT and DL (and only does something when !p->on_cpu). I *think*
> > it's fine to remove it from ttwu_runnable() as any push/pull should have
> > happened when other tasks were enqueued on the same CPU - with that said,
> > it wouldn't hurt to double check this :-)
> > 
> > 
> > As for the check_preempt_curr(), since per the above p can be preempted,
> > you could have scenarios right now with CFS tasks where
> > ttwu_runnable()->check_preempt_curr() causes NEED_RESCHED to be set.
> > 
> > e.g. p0 does
> > 
> >   set_current_state(TASK_UNINTERRUPTIBLE)
> > 
> > but then gets interrupted by the tick, a p1 gets selected to run instead
> > because of check_preempt_tick(), and then runs long enough to have
> > check_preempt_curr() decide to let p0 preempt p1.
> > 
> > That does require specific timing (lower tick frequency should make this
> > more likely) and probably task niceness distribution too, but isn't
> > impossible.
> > 
> > Maybe try reading p->on_cpu, and only do the quick task state update if
> > it's still the current task, otherwise do the preemption checks?
> 
> I'm confused...

I am and Valentin has a point. It could indeed be preempted and in that
case check_preempt_curr() could indeed make it get back on.

In that case his suggestion might make sense; something along the lines
of so I suppose...

(And I think we can still do the reorg I proposed elsewhere, but I've not
yet tried.)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cb2aa2b54c7a..6944d9473295 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3698,9 +3698,16 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
 
 	rq = __task_rq_lock(p, &rf);
 	if (task_on_rq_queued(p)) {
-		/* check_preempt_curr() may use rq clock */
-		update_rq_clock(rq);
-		ttwu_do_wakeup(rq, p, wake_flags, &rf);
+		if (!p->on_cpu) {
+			/*
+			 * When on_rq && !on_cpu the task is preempted, see if
+			 * it should preempt whatever is current there now.
+			 */
+			update_rq_clock(rq);
+			check_preempt_curr(rq, p, wake_flags);
+		}
+		WRITE_ONCE(p->__state, TASK_RUNNING);
+		trace_sched_wakeup(p);
 		ret = 1;
 	}
 	__task_rq_unlock(rq, &rf);
