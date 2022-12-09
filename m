Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0B5647D3C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 06:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiLIF3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 00:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiLIF3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 00:29:42 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8597125E;
        Thu,  8 Dec 2022 21:29:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 19EA6CE27D3;
        Fri,  9 Dec 2022 05:29:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA67C433D2;
        Fri,  9 Dec 2022 05:29:35 +0000 (UTC)
Date:   Fri, 9 Dec 2022 00:29:32 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ross Zwisler <zwisler@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        paulmck@kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v2] tracing: Add trace_trigger kernel command line
 option
Message-ID: <20221209002932.2e9e89e2@gandalf.local.home>
In-Reply-To: <Y5J/CajlNh1gexvo@google.com>
References: <20221020210056.0d8d0a5b@gandalf.local.home>
        <CAGRrVHw2ABuBtb+6BtES0WPNpbtu3p6vfZ-pADjtYYxm9kWZ4g@mail.gmail.com>
        <20221208183945.1de18843@gandalf.local.home>
        <Y5J/CajlNh1gexvo@google.com>
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

On Thu, 8 Dec 2022 17:19:21 -0700
Ross Zwisler <zwisler@google.com> wrote:

> I think that this is because the code to allocate the snapshot buffer uses
> workqueues (ring_buffer_resize() calls schedule_work_on() then
> wait_for_completion()), but at this point during the init process the
> workqueues are up enough that we can enqueue entries, but they are not yet
> doing work.

Thanks for the report.
> 
> start_kernel() {
> ...
> 
>   /*
>    * Allow workqueue creation and work item queueing/cancelling
>    * early.  Work item execution depends on kthreads and starts after
>    * workqueue_init().
>    */
>   workqueue_init_early();
>   ...
> 
>   /* Trace events are available after this */
>   trace_init();  // here is where we try and allocate the snapshot
> 
>   ...
> 
>   arch_call_rest_init();
>     rest_init()
>       kernel_init()
>         kernel_init_freeable()
>           workqueue_init()
> }
> 
> I'm guessing the best we can do here is just disallow snapshot triggers via
> the command line option, so that others don't cut themselves on this sharp
> corner?  Other ideas?

After debugging it, it's because that code path expects to be called with
interrupts enabled, but this early in boot up, interrupts haven't been
enabled yet and should not be.

> [    0.178253]  </#DF>
> [    0.178253]  <TASK>
> [    0.178254]  ? _raw_spin_unlock_irq+0x11/0x40

raw_spin_lock_irq() enables interrupts regardless.


> [    0.178256]  ? wait_for_completion+0x7e/0x160
> [    0.178258]  ? ring_buffer_resize+0x320/0x450
> [    0.178262]  ? resize_buffer_duplicate_size+0x38/0xe0
> [    0.178264]  ? tracing_alloc_snapshot_instance+0x23/0x40
> [    0.178266]  ? register_snapshot_trigger+0x16/0x40
> [    0.178269]  ? event_trigger_parse+0x113/0x160
> [    0.178272]  ? trigger_process_regex+0xb8/0x100
> [    0.178274]  ? __trace_early_add_events+0xb8/0x140
> [    0.178275]  ? trace_event_init+0xcc/0x2dd
> [    0.178278]  ? start_kernel+0x4a9/0x713
> [    0.178281]  ? secondary_startup_64_no_verify+0xce/0xdb

This appears to fix it.

-- Steve

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 843818ee4814..ef4da331ff61 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2062,8 +2062,10 @@ rb_insert_pages(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	struct list_head *pages = &cpu_buffer->new_pages;
 	int retries, success;
+	unsigned long flags;
 
-	raw_spin_lock_irq(&cpu_buffer->reader_lock);
+	/* Can be called at early boot up, where interrupts have not been enabled */
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
@@ -2171,6 +2173,7 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
 	unsigned long nr_pages;
+	unsigned long flags;
 	int cpu, err;
 
 	/*
@@ -2248,8 +2251,19 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 				rb_update_pages(cpu_buffer);
 				cpu_buffer->nr_pages_to_update = 0;
 			} else {
-				schedule_work_on(cpu,
-						&cpu_buffer->update_pages_work);
+				/*
+				 * Run directly if possible.
+				 * Save flags as this can be called at early boot up.
+				 */
+				local_irq_save(flags);
+				if (cpu != smp_processor_id()) {
+					local_irq_restore(flags);
+					schedule_work_on(cpu,
+							 &cpu_buffer->update_pages_work);
+				} else {
+					update_pages_handler(&cpu_buffer->update_pages_work);
+					local_irq_restore(flags);
+				}
 			}
 		}
 
@@ -2298,9 +2312,20 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 		if (!cpu_online(cpu_id))
 			rb_update_pages(cpu_buffer);
 		else {
-			schedule_work_on(cpu_id,
-					 &cpu_buffer->update_pages_work);
-			wait_for_completion(&cpu_buffer->update_done);
+			/*
+			 * Run directly if possible.
+			 * Save flags as this can be called at early boot up.
+			 */
+			local_irq_save(flags);
+			if (cpu_id == smp_processor_id()) {
+				update_pages_handler(&cpu_buffer->update_pages_work);
+				local_irq_restore(flags);
+			} else {
+				local_irq_restore(flags);
+				schedule_work_on(cpu_id,
+						 &cpu_buffer->update_pages_work);
+				wait_for_completion(&cpu_buffer->update_done);
+			}
 		}
 
 		cpu_buffer->nr_pages_to_update = 0;
