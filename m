Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70560620BD1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 10:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbiKHJMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 04:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbiKHJMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 04:12:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8461A047
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 01:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+L/9dtMbqdIQkXmyQjmXU+Bv7A5Ip/ZUV5v9AJeWvdA=; b=i6J4QiqFKt2S5y/erZgdrIbf+b
        7C8W67leFhjWW3MYu6Ph/rgnCOdiIKRlmGAfyi+4HhgBl1G0hEmeODoeBXFpbCBzr7k7ThyyVM/JK
        taVN4724jugudKyyhWhAG0PU7vB1WveBl2xnvH7D0r2h0ewLXJX1K85sBALGP3DeCFaSgsEFDfHeF
        KH28FZ7xlK/pKoR6jKnYrD6MgX4ZcZBkwwOeNQEOGJ0XZFMF/h2zJ37m/Lqe1G2ccMU7f+QtbefAw
        L1cKRbrxTJJECJeLz+cwEtNtCY4PKimYqOm7F27UYkEUrAMUIo0KaxO8z0TicRx7XABF00GQ88MVi
        bRqq6bEw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1osKeI-00A8g3-8b; Tue, 08 Nov 2022 09:12:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7E56C300110;
        Tue,  8 Nov 2022 10:11:49 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5A2532B87854E; Tue,  8 Nov 2022 10:11:49 +0100 (CET)
Date:   Tue, 8 Nov 2022 10:11:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: Minor optimize ttwu_runnable()
Message-ID: <Y2odVSwrCSI2LW2m@hirez.programming.kicks-ass.net>
References: <20221102102343.57845-1-zhouchengming@bytedance.com>
 <xhsmhr0yivazl.mognet@vschneid.remote.csb>
 <7b8bd69a-39cb-a1f0-6ccd-7b0810ef0db7@bytedance.com>
 <xhsmhwn86ncrs.mognet@vschneid.remote.csb>
 <346228d3-8b80-4e9b-0157-662429b11a05@bytedance.com>
 <xhsmhtu3an4jl.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhtu3an4jl.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 03:54:38PM +0000, Valentin Schneider wrote:

> So that's the part for the p->sched_class->task_woken() callback, which
> only affects RT and DL (and only does something when !p->on_cpu). I *think*
> it's fine to remove it from ttwu_runnable() as any push/pull should have
> happened when other tasks were enqueued on the same CPU - with that said,
> it wouldn't hurt to double check this :-)
> 
> 
> As for the check_preempt_curr(), since per the above p can be preempted,
> you could have scenarios right now with CFS tasks where
> ttwu_runnable()->check_preempt_curr() causes NEED_RESCHED to be set.
> 
> e.g. p0 does
> 
>   set_current_state(TASK_UNINTERRUPTIBLE)
> 
> but then gets interrupted by the tick, a p1 gets selected to run instead
> because of check_preempt_tick(), and then runs long enough to have
> check_preempt_curr() decide to let p0 preempt p1.
> 
> That does require specific timing (lower tick frequency should make this
> more likely) and probably task niceness distribution too, but isn't
> impossible.
> 
> Maybe try reading p->on_cpu, and only do the quick task state update if
> it's still the current task, otherwise do the preemption checks?

I'm confused...

So all relevant parties take rq->lock:

 - __schedule()
 - scheduler_tick()
 - ttwu_runnable()

So if ttwu_runnable() sees on_rq and switches state back to RUNNING then
neither check_preempt_curr() nor task_woken() make any sense.

Specifically:

 - you can't very well preempt yourself (which is what
   check_preempt_curr() is trying to determine -- if the woken task
   should preempt the running task, they're both the same in this case);

 - the task did not actually wake up, because it was still on the
   runqueue to begin with. This path prevents a sleep, rather than
   issues a wakeup.

So yes, I think the patch as proposed is ok.

