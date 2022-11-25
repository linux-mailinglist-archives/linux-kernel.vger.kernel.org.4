Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25386385B2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 09:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiKYI5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 03:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiKYI5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 03:57:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1146B853
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 00:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZixrIwFvCi94UuY2L1fI9WSFXdjYr0pMmnLYf2WxCL0=; b=RwNVJTgjY7d0XuR6NrMdmnoIJc
        Juz7wjJbCyEJKrsByboyuYTWBsbpBBqfT4v+Z1mbXa6cq4oMod2jH/kZSoZrBQKK8bGPMFa+QXuLG
        tTzTY2XJDXUb69Zmx5i4wDtnx0LC4FaUC5m6EZkpaHY2aL2K7arfzfOCWPTXCQA+CbfoTDi73U1uQ
        2xcDWtYzg5n4msfFdLBpR2CkoH5Kfptj9JcK68RLJsBs9Qg/kFZaO87V3GWDPYuLw/uq/EnV+40/3
        2870wqNPEnSgKsISXSXrXfgzIvtJlGmCyUnhdTq4mMGOOUfaEGoh+2l80/kyfRcEWCLePCTA/ygml
        dJOccVgA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oyUWN-009Rzu-0C; Fri, 25 Nov 2022 08:57:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 653A630034E;
        Fri, 25 Nov 2022 09:57:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 284602B6CB401; Fri, 25 Nov 2022 09:57:09 +0100 (CET)
Date:   Fri, 25 Nov 2022 09:57:09 +0100
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
Message-ID: <Y4CDZXZJpPB0J1BV@hirez.programming.kicks-ass.net>
References: <20221117005418.3499691-1-joshdon@google.com>
 <Y3d+1a9AEnWaxFwq@hirez.programming.kicks-ass.net>
 <CABk29NtSmXVCvkdpymeam7AYmXhZy2JLYLPFTdKpk5g6AN1-zg@mail.gmail.com>
 <094299a3-f039-04c1-d749-2bea0bc14246@linux.dev>
 <Y3tn5wz6TjsqfGTA@hirez.programming.kicks-ass.net>
 <CABk29Nuyp=Ba=qiJAospx-SR2ZQM9GrKW0pDUeJ3sfgNB4uLFg@mail.gmail.com>
 <Y3ymBOfRikUci/PD@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3ymBOfRikUci/PD@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 11:35:48AM +0100, Peter Zijlstra wrote:
> On Mon, Nov 21, 2022 at 11:37:14AM -0800, Josh Don wrote:
> > Yep, this tradeoff feels "best", but there are some edge cases where
> > this could potentially disrupt fairness. For example, if we have
> > non-trivial W, a lot of cpus to iterate through for dispatching remote
> > unthrottle, and quota is small. Doesn't help that the timer is pinned
> > so that this will continually hit the same cpu.
> 
> We could -- if we wanted to -- manually rotate the timer around the
> relevant CPUs. Doing that sanely would require a bit of hrtimer surgery
> though I'm afraid.

Here; something like so should enable us to cycle the bandwidth timer.
Just need to figure out a way to find another CPU or something.

---
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 0ee140176f10..f8bd200d678a 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -63,8 +63,10 @@ enum hrtimer_mode {
  * Return values for the callback function
  */
 enum hrtimer_restart {
-	HRTIMER_NORESTART,	/* Timer is not restarted */
-	HRTIMER_RESTART,	/* Timer must be restarted */
+	HRTIMER_RESTART = -1,		/* Timer must be restarted */
+	HRTIMER_NORESTART = 0,		/* Timer is not restarted */
+	HRTIMER_RESTART_MIGRATE = 1,
+	HRTIMER_RESTART_MIGRATE_MAX = HRTIMER_RESTART_MIGRATE + NR_CPUS,
 };
 
 /*
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 3ae661ab6260..e75033f78a19 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1621,6 +1621,16 @@ bool hrtimer_active(const struct hrtimer *timer)
 }
 EXPORT_SYMBOL_GPL(hrtimer_active);
 
+static void raw_spin_lock_double(raw_spinlock_t *a, raw_spinlock_t *b)
+{
+	if (b < a)
+		swap(a, b);
+
+	raw_spin_lock(a);
+	if (b != a)
+		raw_spin_lock_nested(b, SINGLE_DEPTH_NESTING);
+}
+
 /*
  * The write_seqcount_barrier()s in __run_hrtimer() split the thing into 3
  * distinct sections:
@@ -1644,6 +1654,8 @@ static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base,
 			  struct hrtimer *timer, ktime_t *now,
 			  unsigned long flags) __must_hold(&cpu_base->lock)
 {
+	struct hrtimer_cpu_base *new_cpu_base = cpu_base;
+	struct hrtimer_clock_base *new_base = base;
 	enum hrtimer_restart (*fn)(struct hrtimer *);
 	bool expires_in_hardirq;
 	int restart;
@@ -1686,7 +1698,17 @@ static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base,
 
 	lockdep_hrtimer_exit(expires_in_hardirq);
 	trace_hrtimer_expire_exit(timer);
-	raw_spin_lock_irq(&cpu_base->lock);
+
+	local_irq_disable();
+
+	if (restart >= HRTIMER_RESTART_MIGRATE) {
+		int cpu = restart - HRTIMER_RESTART_MIGRATE;
+		int b = base - cpu_base->clock_base;
+
+		new_cpu_base = &per_cpu(hrtimer_bases, cpu);
+		new_base = new_cpu_base->clock_base[b];
+	}
+	raw_spin_lock_double(&cpu_base->lock, &new_cpu_base->lock);
 
 	/*
 	 * Note: We clear the running state after enqueue_hrtimer and
@@ -1698,8 +1720,16 @@ static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base,
 	 * for us already.
 	 */
 	if (restart != HRTIMER_NORESTART &&
-	    !(timer->state & HRTIMER_STATE_ENQUEUED))
-		enqueue_hrtimer(timer, base, HRTIMER_MODE_ABS);
+	    !(timer->state & HRTIMER_STATE_ENQUEUED)) {
+
+		if (new_cpu_base != cpu_base) {
+			timer->base = new_base;
+			enqueue_hrtimer(timer, new_base, HRTIMER_MODE_ABS);
+			raw_spin_unlock(&new_cpu_base->lock);
+		} else {
+			enqueue_hrtimer(timer, base, HRTIMER_MODE_ABS);
+		}
+	}
 
 	/*
 	 * Separate the ->running assignment from the ->state assignment.
@@ -2231,12 +2261,8 @@ int hrtimers_dead_cpu(unsigned int scpu)
 	local_irq_disable();
 	old_base = &per_cpu(hrtimer_bases, scpu);
 	new_base = this_cpu_ptr(&hrtimer_bases);
-	/*
-	 * The caller is globally serialized and nobody else
-	 * takes two locks at once, deadlock is not possible.
-	 */
-	raw_spin_lock(&new_base->lock);
-	raw_spin_lock_nested(&old_base->lock, SINGLE_DEPTH_NESTING);
+
+	raw_spin_lock_double(&old_base->lock, &new_base->lock);
 
 	for (i = 0; i < HRTIMER_MAX_CLOCK_BASES; i++) {
 		migrate_hrtimer_list(&old_base->clock_base[i],
