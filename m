Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC006C53F7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjCVSoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjCVSnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:43:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422D6298DD
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:43:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3DAA62281
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 18:43:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8E7C433D2;
        Wed, 22 Mar 2023 18:43:36 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pf3Qt-000pam-1j;
        Wed, 22 Mar 2023 14:43:35 -0400
Message-ID: <20230322184335.352033343@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 22 Mar 2023 14:42:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [for-next][PATCH 09/11] ring_buffer: Change some static functions to bool
References: <20230322184239.594953818@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uros Bizjak <ubizjak@gmail.com>

The return values of some functions are of boolean type. Change the
type of these function to bool and adjust their return values. Also
change type of some internal varibles to bool.

No functional change intended.

Link: https://lkml.kernel.org/r/20230305155532.5549-3-ubizjak@gmail.com

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 47 +++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index b45915dd67b9..93f854433d89 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -163,7 +163,7 @@ enum {
 #define extended_time(event) \
 	(event->type_len >= RINGBUF_TYPE_TIME_EXTEND)
 
-static inline int rb_null_event(struct ring_buffer_event *event)
+static inline bool rb_null_event(struct ring_buffer_event *event)
 {
 	return event->type_len == RINGBUF_TYPE_PADDING && !event->time_delta;
 }
@@ -363,11 +363,9 @@ static void free_buffer_page(struct buffer_page *bpage)
 /*
  * We need to fit the time_stamp delta into 27 bits.
  */
-static inline int test_time_stamp(u64 delta)
+static inline bool test_time_stamp(u64 delta)
 {
-	if (delta & TS_DELTA_TEST)
-		return 1;
-	return 0;
+	return !!(delta & TS_DELTA_TEST);
 }
 
 #define BUF_PAGE_SIZE (PAGE_SIZE - BUF_PAGE_HDR_SIZE)
@@ -696,7 +694,7 @@ rb_time_read_cmpxchg(local_t *l, unsigned long expect, unsigned long set)
 	return ret == expect;
 }
 
-static int rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
+static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
 {
 	unsigned long cnt, top, bottom, msb;
 	unsigned long cnt2, top2, bottom2, msb2;
@@ -1486,7 +1484,7 @@ rb_set_head_page(struct ring_buffer_per_cpu *cpu_buffer)
 	return NULL;
 }
 
-static int rb_head_page_replace(struct buffer_page *old,
+static bool rb_head_page_replace(struct buffer_page *old,
 				struct buffer_page *new)
 {
 	unsigned long *ptr = (unsigned long *)&old->list.prev->next;
@@ -1913,7 +1911,7 @@ static inline unsigned long rb_page_write(struct buffer_page *bpage)
 	return local_read(&bpage->write) & RB_WRITE_MASK;
 }
 
-static int
+static bool
 rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 {
 	struct list_head *tail_page, *to_remove, *next_page;
@@ -2026,12 +2024,13 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 	return nr_removed == 0;
 }
 
-static int
+static bool
 rb_insert_pages(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	struct list_head *pages = &cpu_buffer->new_pages;
-	int retries, success;
 	unsigned long flags;
+	bool success;
+	int retries;
 
 	/* Can be called at early boot up, where interrupts must not been enabled */
 	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
@@ -2050,7 +2049,7 @@ rb_insert_pages(struct ring_buffer_per_cpu *cpu_buffer)
 	 * spinning.
 	 */
 	retries = 10;
-	success = 0;
+	success = false;
 	while (retries--) {
 		struct list_head *head_page, *prev_page, *r;
 		struct list_head *last_page, *first_page;
@@ -2079,7 +2078,7 @@ rb_insert_pages(struct ring_buffer_per_cpu *cpu_buffer)
 			 * pointer to point to end of list
 			 */
 			head_page->prev = last_page;
-			success = 1;
+			success = true;
 			break;
 		}
 	}
@@ -2107,7 +2106,7 @@ rb_insert_pages(struct ring_buffer_per_cpu *cpu_buffer)
 
 static void rb_update_pages(struct ring_buffer_per_cpu *cpu_buffer)
 {
-	int success;
+	bool success;
 
 	if (cpu_buffer->nr_pages_to_update > 0)
 		success = rb_insert_pages(cpu_buffer);
@@ -2990,7 +2989,7 @@ static u64 rb_time_delta(struct ring_buffer_event *event)
 	}
 }
 
-static inline int
+static inline bool
 rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
 		  struct ring_buffer_event *event)
 {
@@ -3011,7 +3010,7 @@ rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
 	delta = rb_time_delta(event);
 
 	if (!rb_time_read(&cpu_buffer->write_stamp, &write_stamp))
-		return 0;
+		return false;
 
 	/* Make sure the write stamp is read before testing the location */
 	barrier();
@@ -3024,7 +3023,7 @@ rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
 		/* Something came in, can't discard */
 		if (!rb_time_cmpxchg(&cpu_buffer->write_stamp,
 				       write_stamp, write_stamp - delta))
-			return 0;
+			return false;
 
 		/*
 		 * It's possible that the event time delta is zero
@@ -3057,12 +3056,12 @@ rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
 		if (index == old_index) {
 			/* update counters */
 			local_sub(event_length, &cpu_buffer->entries_bytes);
-			return 1;
+			return true;
 		}
 	}
 
 	/* could not discard */
-	return 0;
+	return false;
 }
 
 static void rb_start_commit(struct ring_buffer_per_cpu *cpu_buffer)
@@ -3277,7 +3276,7 @@ rb_wakeups(struct trace_buffer *buffer, struct ring_buffer_per_cpu *cpu_buffer)
  * Note: The TRANSITION bit only handles a single transition between context.
  */
 
-static __always_inline int
+static __always_inline bool
 trace_recursive_lock(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	unsigned int val = cpu_buffer->current_context;
@@ -3294,14 +3293,14 @@ trace_recursive_lock(struct ring_buffer_per_cpu *cpu_buffer)
 		bit = RB_CTX_TRANSITION;
 		if (val & (1 << (bit + cpu_buffer->nest))) {
 			do_ring_buffer_record_recursion();
-			return 1;
+			return true;
 		}
 	}
 
 	val |= (1 << (bit + cpu_buffer->nest));
 	cpu_buffer->current_context = val;
 
-	return 0;
+	return false;
 }
 
 static __always_inline void
@@ -4530,7 +4529,7 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 	unsigned long overwrite;
 	unsigned long flags;
 	int nr_loops = 0;
-	int ret;
+	bool ret;
 
 	local_irq_save(flags);
 	arch_spin_lock(&cpu_buffer->lock);
@@ -5405,8 +5404,8 @@ bool ring_buffer_empty(struct trace_buffer *buffer)
 	struct ring_buffer_per_cpu *cpu_buffer;
 	unsigned long flags;
 	bool dolock;
+	bool ret;
 	int cpu;
-	int ret;
 
 	/* yes this is racy, but if you don't like the race, lock the buffer */
 	for_each_buffer_cpu(buffer, cpu) {
@@ -5435,7 +5434,7 @@ bool ring_buffer_empty_cpu(struct trace_buffer *buffer, int cpu)
 	struct ring_buffer_per_cpu *cpu_buffer;
 	unsigned long flags;
 	bool dolock;
-	int ret;
+	bool ret;
 
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return true;
-- 
2.39.1
