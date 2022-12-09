Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779976484C0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiLIPM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiLIPL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:11:58 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4146084B5E;
        Fri,  9 Dec 2022 07:11:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8C3D0CE28AF;
        Fri,  9 Dec 2022 15:11:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9C8C433F1;
        Fri,  9 Dec 2022 15:11:52 +0000 (UTC)
Date:   Fri, 9 Dec 2022 10:11:51 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ross Zwisler <zwisler@google.com>
Subject: [PATCH] ring-buffer: Handle resize in early boot up
Message-ID: <20221209101151.1fec1167@gandalf.local.home>
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

From: Steven Rostedt <rostedt@goodmis.org>

With the new command line option that allows trace event triggers to be
added at boot, the "snapshot" trigger will allocate the snapshot buffer
very early, when interrupts can not be enabled. Allocating the ring buffer
is not the problem, but it also resizes it, which is, as the resize code
does synchronization that can not be preformed at early boot.

To handle this, first change the raw_spin_lock_irq() in rb_insert_pages()
to raw_spin_lock_irqsave(), such that the unlocking of that spin lock will
not enable interrupts.

Next, where it calls schedule_work_on(), disable migration and check if
the CPU to update is the current CPU, and if so, perform the work
directly, otherwise re-enable migration and call the schedule_work_on() to
the CPU that is being updated. The rb_insert_pages() just needs to be run
on the CPU that it is updating, and does not need preemption nor
interrupts disabled when calling it.

Link: https://lore.kernel.org/lkml/Y5J%2FCajlNh1gexvo@google.com/

Fixes: a01fdc897fa5 ("tracing: Add trace_trigger kernel command line option")
Reported-by: Ross Zwisler <zwisler@google.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 843818ee4814..c366a0a9ddba 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2062,8 +2062,10 @@ rb_insert_pages(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	struct list_head *pages = &cpu_buffer->new_pages;
 	int retries, success;
+	unsigned long flags;
 
-	raw_spin_lock_irq(&cpu_buffer->reader_lock);
+	/* Can be called at early boot up, where interrupts must not been enabled */
+	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 	/*
 	 * We are holding the reader lock, so the reader page won't be swapped
 	 * in the ring buffer. Now we are racing with the writer trying to
@@ -2120,7 +2122,7 @@ rb_insert_pages(struct ring_buffer_per_cpu *cpu_buffer)
 	 * tracing
 	 */
 	RB_WARN_ON(cpu_buffer, !success);
-	raw_spin_unlock_irq(&cpu_buffer->reader_lock);
+	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 
 	/* free pages if they weren't inserted */
 	if (!success) {
@@ -2248,8 +2250,16 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 				rb_update_pages(cpu_buffer);
 				cpu_buffer->nr_pages_to_update = 0;
 			} else {
-				schedule_work_on(cpu,
-						&cpu_buffer->update_pages_work);
+				/* Run directly if possible. */
+				migrate_disable();
+				if (cpu != smp_processor_id()) {
+					migrate_enable();
+					schedule_work_on(cpu,
+							 &cpu_buffer->update_pages_work);
+				} else {
+					update_pages_handler(&cpu_buffer->update_pages_work);
+					migrate_enable();
+				}
 			}
 		}
 
@@ -2298,9 +2308,17 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 		if (!cpu_online(cpu_id))
 			rb_update_pages(cpu_buffer);
 		else {
-			schedule_work_on(cpu_id,
-					 &cpu_buffer->update_pages_work);
-			wait_for_completion(&cpu_buffer->update_done);
+			/* Run directly if possible. */
+			migrate_disable();
+			if (cpu_id == smp_processor_id()) {
+				rb_update_pages(cpu_buffer);
+				migrate_enable();
+			} else {
+				migrate_enable();
+				schedule_work_on(cpu_id,
+						 &cpu_buffer->update_pages_work);
+				wait_for_completion(&cpu_buffer->update_done);
+			}
 		}
 
 		cpu_buffer->nr_pages_to_update = 0;
-- 
2.35.1

