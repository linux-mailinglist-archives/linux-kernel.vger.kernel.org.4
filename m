Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CDE6385EC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 10:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiKYJNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 04:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiKYJNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:13:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA3663AA
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 01:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uAfGoK08v60ApQLBAJVzswYfYs4HD0yYTDh0683H4fc=; b=PGk/pprKsrCCePWlyccHY69C04
        jO9m8NtmaTvplw+0ZsANv/OQcz91L0dEnul+FGZNbweMou5G7USM2ZCzjEb650fBk6L3YrqFqwL0/
        CQLRzzIy/qZUZbb459WYgVio7LkS92OxHAlrbJbAhCmmi40yXrfCN0rq8LaNDDjj3VEPAB8uudKK5
        otYDHw/EPnE6/8J1jONx95PNXJ2WPdWJCLVDOc65mnfnH6qxmWfxBzukDGNTtGdn7f9WU7cz+yBGN
        02TbkePMQYWGpruF8x9XKW6zNBx9XpPgrkNoJ4yS7TJQ9M5x3rfmT3eeCsEFv1IInHPeHHEEcEUqC
        v3SvPEfA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oyUlV-009SZI-4Y; Fri, 25 Nov 2022 09:12:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2BAF6300282;
        Fri, 25 Nov 2022 10:12:49 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ED5E2205E4E96; Fri, 25 Nov 2022 10:12:48 +0100 (CET)
Date:   Fri, 25 Nov 2022 10:12:48 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Christian Brauner <brauner@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        anna-maria@linutronix.de
Subject: Re: [PATCH v3] sched: async unthrottling for cfs bandwidth
Message-ID: <Y4CHEOEbBqAm70oQ@hirez.programming.kicks-ass.net>
References: <20221117005418.3499691-1-joshdon@google.com>
 <Y3d+1a9AEnWaxFwq@hirez.programming.kicks-ass.net>
 <CABk29NtSmXVCvkdpymeam7AYmXhZy2JLYLPFTdKpk5g6AN1-zg@mail.gmail.com>
 <094299a3-f039-04c1-d749-2bea0bc14246@linux.dev>
 <Y3tn5wz6TjsqfGTA@hirez.programming.kicks-ass.net>
 <CABk29Nuyp=Ba=qiJAospx-SR2ZQM9GrKW0pDUeJ3sfgNB4uLFg@mail.gmail.com>
 <Y3ymBOfRikUci/PD@hirez.programming.kicks-ass.net>
 <Y4CDZXZJpPB0J1BV@hirez.programming.kicks-ass.net>
 <Y4CD615rYurnV6h7@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4CD615rYurnV6h7@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 09:59:23AM +0100, Peter Zijlstra wrote:
> On Fri, Nov 25, 2022 at 09:57:09AM +0100, Peter Zijlstra wrote:
> > On Tue, Nov 22, 2022 at 11:35:48AM +0100, Peter Zijlstra wrote:
> > > On Mon, Nov 21, 2022 at 11:37:14AM -0800, Josh Don wrote:
> > > > Yep, this tradeoff feels "best", but there are some edge cases where
> > > > this could potentially disrupt fairness. For example, if we have
> > > > non-trivial W, a lot of cpus to iterate through for dispatching remote
> > > > unthrottle, and quota is small. Doesn't help that the timer is pinned
> > > > so that this will continually hit the same cpu.
> > > 
> > > We could -- if we wanted to -- manually rotate the timer around the
> > > relevant CPUs. Doing that sanely would require a bit of hrtimer surgery
> > > though I'm afraid.
> > 
> > Here; something like so should enable us to cycle the bandwidth timer.
> > Just need to figure out a way to find another CPU or something.
> 
> Some more preparation...

And then I think something like so.. That migrates the timer to the CPU
of the first throttled entry -- possibly not the best heuristic, but its
the simplest.

NOTE: none of this has seen a compiler up close.

---
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5595,13 +5595,21 @@ static bool distribute_cfs_runtime(struc
  */
 static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun, unsigned long flags)
 {
-	int throttled;
+	struct cfs_rq *first_cfs_rq;
+	int throttled = 0;
+	int cpu;
 
 	/* no need to continue the timer with no bandwidth constraint */
 	if (cfs_b->quota == RUNTIME_INF)
 		goto out_deactivate;
 
-	throttled = !list_empty(&cfs_b->throttled_cfs_rq);
+	first_cfs_rq = list_first_entry_or_null(&cfs_b->throttled_cfs_rq,
+						struct cfs_rq, throttled_list);
+	if (first_cfs_rq) {
+		throttled = 1;
+		cpu = cpu_of(rq_of(first_cfs_rq));
+	}
+
 	cfs_b->nr_periods += overrun;
 
 	/* Refill extra burst quota even if cfs_b->idle */
@@ -5641,7 +5649,7 @@ static int do_sched_cfs_period_timer(str
 	 */
 	cfs_b->idle = 0;
 
-	return HRTIMER_RESTART;
+	return HRTIMER_RESTART_MIGRATE + cpu;
 
 out_deactivate:
 	return HRTIMER_NORESTART;
