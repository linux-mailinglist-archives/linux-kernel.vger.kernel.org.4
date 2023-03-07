Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936856AFAAC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 00:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjCGXq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 18:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCGXqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 18:46:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304B395469;
        Tue,  7 Mar 2023 15:46:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1FB9B81B22;
        Tue,  7 Mar 2023 23:46:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFAAC433EF;
        Tue,  7 Mar 2023 23:46:48 +0000 (UTC)
Date:   Tue, 7 Mar 2023 18:46:45 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Ross Zwisler <zwisler@google.com>
Subject: [PATCH] tracing, hardirq: Do not test lockdep on irq trace points
 when disabled
Message-ID: <20230307184645.521db5c9@gandalf.local.home>
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

When CONFIG_LOCKDEP is enabled, the trace points have:

	static inline void trace_##name(proto)				\
	{								\
		if (static_key_false(&__tracepoint_##name.key))		\
			__DO_TRACE(name,				\
				TP_ARGS(args),				\
				TP_CONDITION(cond), 0);			\
		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
			rcu_read_lock_sched_notrace();			\
			rcu_dereference_sched(__tracepoint_##name.funcs);\
			rcu_read_unlock_sched_notrace();		\
		}							\
	}								\

Where it will test lockdep for trace points even when they are not
enabled, to make sure they do not cause RCU issues, and lockdep will
trigger even when the trace points are not enabled.

The trace_<tracepoint>_rcuidle() skipped this check as it was called when
RCU was not watching. With the lastest changes with noinstr, this is
becoming less of an issue.

The trace points that cover enabling and disabling irqs use to have the
_rcuidle() variant. This was removed as noinstr made it no longer needed.

My tests started failing with this on 32 bit when LOCKDEP was enabled,
with a soft lockup:

Testing tracer function_graph:
 watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [swapper/0:1]
 Modules linked in:
 irq event stamp: 15379006
 hardirqs last  enabled at (15379005): [<ca0cbd6d>] __text_poke+0x3d5/0x4dc
 hardirqs last disabled at (15379006): [<cad13fac>] sysvec_apic_timer_interrupt+0xc/0x40
 softirqs last  enabled at (15349578): [<ca1011b8>] return_to_handler+0x0/0x18
 softirqs last disabled at (15349457): [<ca0c6f09>] call_on_stack+0x45/0x4c
 CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.2.0-test-06742-g307e14c03906-dirty #934
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
 EIP: __text_poke+0x3d9/0x4dc
 Code: 16 cb 6a 00 6a 0c e8 2e 17 04 00 5a 59 81 7d dc 50 b7 0c ca 0f 84 97 00 00 00 8b 45 c0 85 c0 74 06 e8 bf 0d 1a 00 fb 8b 45 ec <e8> de 51 c5 00 89 f0 e8 1f ff 2a 00 64 a1 00 4b 4f cb 83 a8 ac 0e
 EAX: c1016758 EBX: 00000001 ECX: 00000040 EDX: cb13b63e
 ESI: fffbb060 EDI: ca8fd0e9 EBP: c123de0c ESP: c123dd9c
 DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00000202
 CR0: 80050033 CR2: ff9ff000 CR3: 0b504000 CR4: 00150ef0
 Call Trace:
  ? text_poke_memset+0x14/0x14
  ? trace_graph_entry_watchdog+0x1f/0x6c
  ? function_graph_enter+0xe8/0x13c
  ? arch_unregister_cpu+0x24/0x24
  ? ftrace_graph_caller+0x1c/0x1c
  text_poke_bp_batch+0x18d/0x30c
  ? __traceiter_regmap_async_io_complete+0x1/0x34
  ? __mptcp_init_sock+0xc4/0x150
  ? regmap_update_bits_base+0x68/0x68
  ? ftrace_graph_caller+0x1c/0x1c
  text_poke_queue+0x5a/0x84
  ftrace_replace_code+0x103/0x174
  ftrace_modify_all_code+0x10c/0x198
  arch_ftrace_update_code+0x8/0xc
  ftrace_startup+0xac/0x14c
  register_ftrace_graph+0x376/0x3b0
  trace_selftest_startup_function_graph+0x72/0x248
  run_tracer_selftest+0x89/0x230
  register_tracer+0xc7/0x25c
  ? init_graph_tracefs+0x2c/0x2c
  init_graph_trace+0x48/0x74
  do_one_initcall+0x5e/0x300
  kernel_init_freeable+0x22c/0x460
  ? rest_init+0x168/0x168
  kernel_init+0x17/0x1b8
  ret_from_fork+0x1c/0x28

I found that the lockdep checks did slow down the functions slightly, just
enough to trigger the soft lockup detector when enabling function graph
tracing.

By adding:

  if (!IS_ENABLED(CONFIG_LOCKDEP) || trace_##point##_enabled())

around the call to the trace point, it would make it act more like the
rcuidle() trace point, and would not cause the soft lockup detection.

Note, without this change, the normal system is slowed down much more with
LOCKDEP enabled than it was before. This brings it back to the normal slow
performance of LOCKDEP.

Fixes: 9aedeaed6fc6 ("tracing, hardirq: No moar _rcuidle() tracing")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_preemptirq.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
index f992444a0b1f..4765e1a6c7f4 100644
--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -26,9 +26,17 @@ static DEFINE_PER_CPU(int, tracing_irq_cpu);
  *
  * On older architectures, use the rcuidle tracing methods (which
  * aren't NMI-safe - so exclude NMI contexts):
+ *
+ * Note, when LOCKDEP is enabled, the default checks for the trace point
+ * can cause a noticeable slowdown even when the trace point is not
+ * enabled. By only calling the trace point when the trace point is
+ * enabled, will keep the lockdep checks from being always triggered
+ * and slowing down the system.
  */
 #ifdef CONFIG_ARCH_WANTS_NO_INSTR
-#define trace(point)	trace_##point
+#define trace(point)							\
+	if (!IS_ENABLED(CONFIG_LOCKDEP) || trace_##point##_enabled())	\
+		trace_##point
 #else
 #define trace(point)	if (!in_nmi()) trace_##point##_rcuidle
 #endif
-- 
2.39.1

