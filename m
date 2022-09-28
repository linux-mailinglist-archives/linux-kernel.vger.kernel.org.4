Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE535EE34B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 19:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234598AbiI1Rii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 13:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233787AbiI1Ria (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:38:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E49CF3916
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:38:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DFD961F64
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 17:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4378DC433D6;
        Wed, 28 Sep 2022 17:38:27 +0000 (UTC)
Date:   Wed, 28 Sep 2022 13:39:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2] ring-buffer: Add ring_buffer_wake_waiters()
Message-ID: <20220928133938.28dc2c27@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

On closing of a file that represents a ring buffer or flushing the file,
there may be waiters on the ring buffer that needs to be woken up and exit
the ring_buffer_wait() function.

Add ring_buffer_wake_waiters() to wake up the waiters on the ring buffer
and allow them to exit the wait loop.

Cc: stable@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Fixes: 15693458c4bc0 ("tracing/ring-buffer: Move poll wake ups into ring buffer code")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lkml.kernel.org/r/20220927231824.700269106@goodmis.org
  - Wake up all waiters on the individual CPU queues on ALL cpus wakeups.

 include/linux/ring_buffer.h |  2 +-
 kernel/trace/ring_buffer.c  | 39 +++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index dac53fd3afea..2504df9a0453 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -101,7 +101,7 @@ __ring_buffer_alloc(unsigned long size, unsigned flags, struct lock_class_key *k
 int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full);
 __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
 			  struct file *filp, poll_table *poll_table);
-
+void ring_buffer_wake_waiters(struct trace_buffer *buffer, int cpu);
 
 #define RING_BUFFER_ALL_CPUS -1
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 5a7d818ca3ea..3046deacf7b3 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -413,6 +413,7 @@ struct rb_irq_work {
 	struct irq_work			work;
 	wait_queue_head_t		waiters;
 	wait_queue_head_t		full_waiters;
+	long				wait_index;
 	bool				waiters_pending;
 	bool				full_waiters_pending;
 	bool				wakeup_full;
@@ -924,6 +925,37 @@ static void rb_wake_up_waiters(struct irq_work *work)
 	}
 }
 
+/**
+ * ring_buffer_wake_waiters - wake up any waiters on this ring buffer
+ * @buffer: The ring buffer to wake waiters on
+ *
+ * In the case of a file that represents a ring buffer is closing,
+ * it is prudent to wake up any waiters that are on this.
+ */
+void ring_buffer_wake_waiters(struct trace_buffer *buffer, int cpu)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+	struct rb_irq_work *rbwork;
+
+	if (cpu == RING_BUFFER_ALL_CPUS) {
+
+		/* Wake up individual ones too. One level recursion */
+		for_each_buffer_cpu(buffer, cpu)
+			ring_buffer_wake_waiters(buffer, cpu);
+
+		rbwork = &buffer->irq_work;
+	} else {
+		cpu_buffer = buffer->buffers[cpu];
+		rbwork = &cpu_buffer->irq_work;
+	}
+
+	rbwork->wait_index++;
+	/* make sure the waiters see the new index */
+	smp_wmb();
+
+	rb_wake_up_waiters(&rbwork->work);
+}
+
 /**
  * ring_buffer_wait - wait for input to the ring buffer
  * @buffer: buffer to wait on
@@ -939,6 +971,7 @@ int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full)
 	struct ring_buffer_per_cpu *cpu_buffer;
 	DEFINE_WAIT(wait);
 	struct rb_irq_work *work;
+	long wait_index;
 	int ret = 0;
 
 	/*
@@ -957,6 +990,7 @@ int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full)
 		work = &cpu_buffer->irq_work;
 	}
 
+	wait_index = READ_ONCE(work->wait_index);
 
 	while (true) {
 		if (full)
@@ -1021,6 +1055,11 @@ int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full)
 		}
 
 		schedule();
+
+		/* Make sure to see the new wait index */
+		smp_rmb();
+		if (wait_index != work->wait_index)
+			break;
 	}
 
 	if (full)
-- 
2.35.1

