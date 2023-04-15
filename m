Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF376E2FB2
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 10:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjDOIUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 04:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjDOIUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 04:20:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4785583;
        Sat, 15 Apr 2023 01:20:35 -0700 (PDT)
Date:   Sat, 15 Apr 2023 08:20:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681546833;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GnzE4raEONRJxVjFOSpczBdz0wF9vVGe9QBOs99a6Io=;
        b=jGtfoOqTGT8E5Do9fHd1GvUZxwj1vrZSvpdg8xhhvfk1ZkNHuvdDBL7jSUFpmYASiIEXyf
        IySLiUeTf2Rzfx+rXAss+HAwasbhs756hQk3V3qQ1JKN9BVQvFgBmpjEm/OAdypMWk4f/s
        7bW8JnUBOF3OELRNJd9bdDT7uBTut4Dnfccmupdjbpk6V2N+luFxw9MsK8qC4d702M32Hu
        qdPQFlGFxkpkixwN3zosinErKAL71TcI6Jd1OFI2m+uQ8qs4GG//PSuwDhNfILfHDl4VkQ
        c7iK7mJE+dccbk+FAzcPwq6MbGZxDE5MWqssF32bqu3YoetRkBQ3G1EleXbUIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681546833;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GnzE4raEONRJxVjFOSpczBdz0wF9vVGe9QBOs99a6Io=;
        b=HNTu8wINmM5oDWBgRvFBNfmytR/i8xjyrsXdgYfQfZk/i/IN7rWORDJN+mAMlpD8ydk2Kw
        j96aB9AjkV/NVRBA==
From:   "tip-bot2 for Lingutla Chandrasekhar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] softirq: Add trace points for tasklet entry/exit
Cc:     Lingutla Chandrasekhar <clingutla@codeaurora.org>,
        "J. Avila" <elavila@google.com>, John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20230407230526.1685443-1-jstultz@google.com>
References: <20230407230526.1685443-1-jstultz@google.com>
MIME-Version: 1.0
Message-ID: <168154683281.404.4623946113472484183.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     f4bf3ca2e5cba655824b6e0893a98dfb33ed24e5
Gitweb:        https://git.kernel.org/tip/f4bf3ca2e5cba655824b6e0893a98dfb33ed24e5
Author:        Lingutla Chandrasekhar <clingutla@codeaurora.org>
AuthorDate:    Fri, 07 Apr 2023 23:05:26 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 15 Apr 2023 10:17:16 +02:00

softirq: Add trace points for tasklet entry/exit

Tasklets are supposed to finish their work quickly and should not block the
current running process, but it is not guaranteed that they do so.

Currently softirq_entry/exit can be used to analyse the total tasklets
execution time, but that's not helpful to track individual tasklets
execution time. That makes it hard to identify tasklet functions, which
take more time than expected.

Add tasklet_entry/exit trace point support to track individual tasklet
execution.

Trivial usage example:
   # echo 1 > /sys/kernel/debug/tracing/events/irq/tasklet_entry/enable
   # echo 1 > /sys/kernel/debug/tracing/events/irq/tasklet_exit/enable
   # cat /sys/kernel/debug/tracing/trace
 # tracer: nop
 #
 # entries-in-buffer/entries-written: 4/4   #P:4
 #
 #                                _-----=> irqs-off/BH-disabled
 #                               / _----=> need-resched
 #                              | / _---=> hardirq/softirq
 #                              || / _--=> preempt-depth
 #                              ||| / _-=> migrate-disable
 #                              |||| /     delay
 #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
 #              | |         |   |||||     |         |
           <idle>-0       [003] ..s1.   314.011428: tasklet_entry: tasklet=0xffffa01ef8db2740 function=tcp_tasklet_func
           <idle>-0       [003] ..s1.   314.011432: tasklet_exit: tasklet=0xffffa01ef8db2740 function=tcp_tasklet_func
           <idle>-0       [003] ..s1.   314.017369: tasklet_entry: tasklet=0xffffa01ef8db2740 function=tcp_tasklet_func
           <idle>-0       [003] ..s1.   314.017371: tasklet_exit: tasklet=0xffffa01ef8db2740 function=tcp_tasklet_func

Signed-off-by: Lingutla Chandrasekhar <clingutla@codeaurora.org>
Signed-off-by: J. Avila <elavila@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Link: https://lore.kernel.org/r/20230407230526.1685443-1-jstultz@google.com

[elavila: Port to android-mainline]
[jstultz: Rebased to upstream, cut unused trace points, added
 comments for the tracepoints, reworded commit]
---
 include/trace/events/irq.h | 47 +++++++++++++++++++++++++++++++++++++-
 kernel/softirq.c           |  9 +++++--
 2 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/irq.h b/include/trace/events/irq.h
index eeceafa..a07b460 100644
--- a/include/trace/events/irq.h
+++ b/include/trace/events/irq.h
@@ -160,6 +160,53 @@ DEFINE_EVENT(softirq, softirq_raise,
 	TP_ARGS(vec_nr)
 );
 
+DECLARE_EVENT_CLASS(tasklet,
+
+	TP_PROTO(struct tasklet_struct *t, void *func),
+
+	TP_ARGS(t, func),
+
+	TP_STRUCT__entry(
+		__field(	void *,	tasklet)
+		__field(	void *,	func)
+	),
+
+	TP_fast_assign(
+		__entry->tasklet = t;
+		__entry->func = func;
+	),
+
+	TP_printk("tasklet=%ps function=%ps", __entry->tasklet, __entry->func)
+);
+
+/**
+ * tasklet_entry - called immediately before the tasklet is run
+ * @t: tasklet pointer
+ * @func: tasklet callback or function being run
+ *
+ * Used to find individual tasklet execution time
+ */
+DEFINE_EVENT(tasklet, tasklet_entry,
+
+	TP_PROTO(struct tasklet_struct *t, void *func),
+
+	TP_ARGS(t, func)
+);
+
+/**
+ * tasklet_exit - called immediately after the tasklet is run
+ * @t: tasklet pointer
+ * @func: tasklet callback or function being run
+ *
+ * Used to find individual tasklet execution time
+ */
+DEFINE_EVENT(tasklet, tasklet_exit,
+
+	TP_PROTO(struct tasklet_struct *t, void *func),
+
+	TP_ARGS(t, func)
+);
+
 #endif /*  _TRACE_IRQ_H */
 
 /* This part must be outside protection */
diff --git a/kernel/softirq.c b/kernel/softirq.c
index c8a6913..1b72551 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -793,10 +793,15 @@ static void tasklet_action_common(struct softirq_action *a,
 		if (tasklet_trylock(t)) {
 			if (!atomic_read(&t->count)) {
 				if (tasklet_clear_sched(t)) {
-					if (t->use_callback)
+					if (t->use_callback) {
+						trace_tasklet_entry(t, t->callback);
 						t->callback(t);
-					else
+						trace_tasklet_exit(t, t->callback);
+					} else {
+						trace_tasklet_entry(t, t->func);
 						t->func(t->data);
+						trace_tasklet_exit(t, t->func);
+					}
 				}
 				tasklet_unlock(t);
 				continue;
