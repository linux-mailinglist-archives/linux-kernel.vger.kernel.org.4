Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606D45ED9CD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbiI1KHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbiI1KGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:06:43 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB4376465
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 03:06:41 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id nb11so26046595ejc.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 03:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=reAAZ1Fg31aMt0fosaFa3oLFeytHbOA9bmQ9dv1ASJM=;
        b=anMJtLd7baGV7pqxR2ivslFu/p+34G1sbWS/ma62GmAJVHES1xfvvwSUibofPaXLQ7
         tr3roUiw25Hvt/1hPem5DGeUfDoWxUb0pTGY1jlhxTo1k+PahM8a9D2ednqwqrFyW1ff
         A7fEd64ATCyS5Bt+uSXOgxEsJQYJjqrJe9rsVERDM3y5GQIedyJrKEciTJ6h+iW32LcT
         5g15NaM4sU4ccfBEgEnRzjWZaJ811YH55oJKdo14faFp/yxja6yKtsfG2ZKDzmu1LPxo
         mQNEQhlG58PS7xrJoSfJG2GSBJo0SirHXQxbsEBDPfPfb87DlzjVimWokgI0O2FJ8FTI
         kMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=reAAZ1Fg31aMt0fosaFa3oLFeytHbOA9bmQ9dv1ASJM=;
        b=Ek8m1yHeA+gVDcrUB5DVcj6QD8eSI6pLFxikm8igzJcxprHcedFzOBxNlQbQsHT/qE
         ditJnt9lqgN+Iens9fOEuuNBo7H92fEFgtD8QAFWupDkFGiEdQFC6JVpsV6r00lJWVm/
         +e0K9dgJrghzWMBdZlZRNE6vTQmTyljJpR2E/fgUrViLhX0L5cdJf3c61CKli4FYxWMX
         WMG3skeN9PmY2syUdpChmIn1PWx/t8UuhR/nmQ6fxgdLwctgXgqnopuyV6GKUcVFOIEN
         66M+mLhMxs/b6jE9P9U1fkGMrHNhJ8L4qerJYYPbm8MjhOD+n88LSk/AEooW7gmCTj10
         A/8Q==
X-Gm-Message-State: ACrzQf0QZknKSjQ0OZgcrlVDu9se+gDSkKTawaN7y/E8S4b2t+oUI366
        m/CeV+rciinS93GYwL1Xfnkc8g==
X-Google-Smtp-Source: AMsMyM6qXjesMdMMa/oU4flTPFJ+011FIxmnGkwoTdqgP1N+bM9GccBbiwQ6cE6SL4pCJEVVwj2Dpw==
X-Received: by 2002:a17:907:7245:b0:782:331b:60f4 with SMTP id ds5-20020a170907724500b00782331b60f4mr27443656ejc.594.1664359599590;
        Wed, 28 Sep 2022 03:06:39 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:dbbc:9ea2:a5f7:571e])
        by smtp.gmail.com with ESMTPSA id q1-20020a50cc81000000b00457618d3409sm3055135edi.68.2022.09.28.03.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 03:06:38 -0700 (PDT)
Date:   Wed, 28 Sep 2022 12:06:33 +0200
From:   Marco Elver <elver@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] perf: Fix missing SIGTRAPs due to pending_disable abuse
Message-ID: <YzQcqe9p9C5ZbjZ1@elver.google.com>
References: <20220927121322.1236730-1-elver@google.com>
 <YzM/BUsBnX18NoOG@hirez.programming.kicks-ass.net>
 <YzNu5bgASbuVi0S3@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzNu5bgASbuVi0S3@elver.google.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 11:45PM +0200, Marco Elver wrote:
> On Tue, Sep 27, 2022 at 08:20PM +0200, Peter Zijlstra wrote:
> > On Tue, Sep 27, 2022 at 02:13:22PM +0200, Marco Elver wrote:
> > > Due to the implementation of how SIGTRAP are delivered if
> > > perf_event_attr::sigtrap is set, we've noticed 3 issues:
> > > 
> > > 	1. Missing SIGTRAP due to a race with event_sched_out() (more
> > > 	   details below).
> > > 
> > > 	2. Hardware PMU events being disabled due to returning 1 from
> > > 	   perf_event_overflow(). The only way to re-enable the event is
> > > 	   for user space to first "properly" disable the event and then
> > > 	   re-enable it.
> > > 
> > > 	3. The inability to automatically disable an event after a
> > > 	   specified number of overflows via PERF_EVENT_IOC_REFRESH.
> > > 
> > > The worst of the 3 issues is problem (1), which occurs when a
> > > pending_disable is "consumed" by a racing event_sched_out(), observed as
> > > follows:
> > > 
> > > 		CPU0			| 	CPU1
> > > 	--------------------------------+---------------------------
> > > 	__perf_event_overflow()		|
> > > 	 perf_event_disable_inatomic()	|
> > > 	  pending_disable = CPU0	| ...
> > > 	  				| _perf_event_enable()
> > > 					|  event_function_call()
> > > 					|   task_function_call()
> > > 					|    /* sends IPI to CPU0 */
> > > 	<IPI>				| ...
> > > 	 __perf_event_enable()		+---------------------------
> > > 	  ctx_resched()
> > > 	   task_ctx_sched_out()
> > > 	    ctx_sched_out()
> > > 	     group_sched_out()
> > > 	      event_sched_out()
> > > 	       pending_disable = -1
> > > 	</IPI>
> > > 	<IRQ-work>
> > > 	 perf_pending_event()
> > > 	  perf_pending_event_disable()
> > > 	   /* Fails to send SIGTRAP because no pending_disable! */
> > > 	</IRQ-work>
> > > 
> > > In the above case, not only is that particular SIGTRAP missed, but also
> > > all future SIGTRAPs because 'event_limit' is not reset back to 1.
> > > 
> > > To fix, rework pending delivery of SIGTRAP via IRQ-work by introduction
> > > of a separate 'pending_sigtrap', no longer using 'event_limit' and
> > > 'pending_disable' for its delivery.
> > > 
> > > During testing, this also revealed several more possible races between
> > > reschedules and pending IRQ work; see code comments for details.
> > 
> > Perhaps use task_work_add() for this case? That runs on the
> > return-to-user path, so then it doesn't matter how many reschedules
> > happen in between.
> 
> Hmm, I tried the below (on top of this patch), but then all the tests
> fail (including tools/testing/selftests/perf_events/sigtrap_threads.c)
> because of lots of missing SIGTRAP. (The missing SIGTRAP happen with or
> without the kernel/entry/ change.)
> 
> So something is wrong with task_work, and the irq_work solution thus far
> is more robust (ran many hours of tests and fuzzing without failure).

My second idea about introducing something like irq_work_raw_sync().
Maybe it's not that crazy if it is actually safe. I expect this case
where we need the irq_work_raw_sync() to be very very rare.

------ >8 ------

diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index 8cd11a223260..490adecbb4be 100644
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -59,6 +59,7 @@ bool irq_work_queue_on(struct irq_work *work, int cpu);
 
 void irq_work_tick(void);
 void irq_work_sync(struct irq_work *work);
+bool irq_work_raw_sync(struct irq_work *work);
 
 #ifdef CONFIG_IRQ_WORK
 #include <asm/irq_work.h>
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index dff3430844a2..c119fa7b70d6 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -743,7 +743,6 @@ struct perf_event {
 	int				pending_sigtrap;
 	unsigned long			pending_addr;	/* SIGTRAP */
 	struct irq_work			pending;
-	struct irq_work			pending_resched;
 
 	atomic_t			event_limit;
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 007a87c1599c..6ba02a1b5c5d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2532,7 +2532,8 @@ event_sched_in(struct perf_event *event,
 		 * The task and event might have been moved to another CPU:
 		 * queue another IRQ work. See perf_pending_event_sigtrap().
 		 */
-		WARN_ON_ONCE(!irq_work_queue(&event->pending_resched));
+		irq_work_raw_sync(&event->pending); /* Syncs if pending on other CPU. */
+		irq_work_queue(&event->pending);
 	}
 
 out:
@@ -4946,7 +4947,6 @@ static void perf_addr_filters_splice(struct perf_event *event,
 static void _free_event(struct perf_event *event)
 {
 	irq_work_sync(&event->pending);
-	irq_work_sync(&event->pending_resched);
 
 	unaccount_event(event);
 
@@ -6545,26 +6545,6 @@ static void perf_pending_event(struct irq_work *entry)
 		perf_swevent_put_recursion_context(rctx);
 }
 
-/*
- * If handling of a pending action must occur before returning to user space,
- * and it is possible to reschedule an event (to another CPU) with pending
- * actions, where the moved-from CPU may not yet have run event->pending (and
- * irq_work_queue() would fail on reuse), we'll use a separate IRQ work that
- * runs perf_pending_event_resched().
- */
-static void perf_pending_event_resched(struct irq_work *entry)
-{
-	struct perf_event *event = container_of(entry, struct perf_event, pending_resched);
-	int rctx;
-
-	rctx = perf_swevent_get_recursion_context();
-
-	perf_pending_event_sigtrap(event);
-
-	if (rctx >= 0)
-		perf_swevent_put_recursion_context(rctx);
-}
-
 #ifdef CONFIG_GUEST_PERF_EVENTS
 struct perf_guest_info_callbacks __rcu *perf_guest_cbs;
 
@@ -11599,7 +11579,6 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	init_waitqueue_head(&event->waitq);
 	event->pending_disable = -1;
 	init_irq_work(&event->pending, perf_pending_event);
-	init_irq_work(&event->pending_resched, perf_pending_event_resched);
 
 	mutex_init(&event->mmap_mutex);
 	raw_spin_lock_init(&event->addr_filters.lock);
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 7afa40fe5cc4..2d21be0c0f3e 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -290,6 +290,40 @@ void irq_work_sync(struct irq_work *work)
 }
 EXPORT_SYMBOL_GPL(irq_work_sync);
 
+/*
+ * Synchronize against the irq_work @work, ensuring the entry is not currently
+ * in use after returning true. If it returns false, it was not possible to
+ * synchronize against the irq_work. Requires that interrupts are already
+ * disabled (prefer irq_work_sync() in all other cases).
+ */
+bool irq_work_raw_sync(struct irq_work *work)
+{
+	struct irq_work *entry;
+	struct llist_head *list;
+
+	lockdep_assert_irqs_disabled();
+
+	if (!irq_work_is_busy(work))
+		return true;
+
+	list = this_cpu_ptr(&raised_list);
+	llist_for_each_entry(entry, list->first, node.llist) {
+		if (entry == work)
+			return false;
+	}
+	list = this_cpu_ptr(&lazy_list);
+	llist_for_each_entry(entry, list->first, node.llist) {
+		if (entry == work)
+			return false;
+	}
+
+	while (irq_work_is_busy(work))
+		cpu_relax();
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(irq_work_raw_sync);
+
 static void run_irq_workd(unsigned int cpu)
 {
 	irq_work_run_list(this_cpu_ptr(&lazy_list));
