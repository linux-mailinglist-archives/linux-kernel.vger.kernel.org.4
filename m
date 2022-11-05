Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7A361DE3A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 22:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiKEVFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 17:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKEVFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 17:05:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F591114F;
        Sat,  5 Nov 2022 14:05:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FA8460B9B;
        Sat,  5 Nov 2022 21:05:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632FDC433D7;
        Sat,  5 Nov 2022 21:05:14 +0000 (UTC)
Date:   Sat, 5 Nov 2022 17:05:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Li Huafei <lihuafei1@huawei.com>, Li Qiang <liq3ea@163.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Rafael Mendonca <rafaelmendsr@gmail.com>,
        Shang XiaoJing <shangxiaojing@huawei.com>
Subject: [GIT PULL] tracing: Fixes for 6.1-rc3
Message-ID: <20221105170512.39ee3ce9@rorschach.local.home>
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


Linus,

[ Taking a break from the timer code and back to my day job ]

Tracing fixes for 6.1-rc3:

- Fixed NULL pointer dereference in the ring buffer wait-waiters code for
  machines that have less CPUs than what nr_cpu_ids returns. The buffer
  array is of size nr_cpu_ids, but only the online CPUs get initialized.

- Fixed use after free call in ftrace_shutdown.

- Fix accounting of if a kprobe is enabled

- Fix NULL pointer dereference on error path of fprobe rethook_alloc().

- Fix unregistering of fprobe_kprobe_handler

- Fix memory leak in kprobe test module


Please pull the latest trace-v6.1-rc3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.1-rc3

Tag SHA1: 0723ad8e5cb2545738776246daee13d0526ab73a
Head SHA1: 66f0919c953ef7b55e5ab94389a013da2ce80a2c


Li Huafei (1):
      ftrace: Fix use-after-free for dynamic ftrace_ops

Li Qiang (1):
      kprobe: reverse kp->flags when arm_kprobe failed

Masami Hiramatsu (Google) (1):
      tracing/fprobe: Fix to check whether fprobe is registered correctly

Rafael Mendonca (1):
      fprobe: Check rethook_alloc() return in rethook initialization

Shang XiaoJing (1):
      tracing: kprobe: Fix memory leak in test_gen_kprobe/kretprobe_cmd()

Steven Rostedt (Google) (1):
      ring-buffer: Check for NULL cpu_buffer in ring_buffer_wake_waiters()

----
 kernel/kprobes.c                     |  5 ++++-
 kernel/trace/fprobe.c                |  5 ++++-
 kernel/trace/ftrace.c                | 16 +++-------------
 kernel/trace/kprobe_event_gen_test.c | 18 +++++++-----------
 kernel/trace/ring_buffer.c           | 11 +++++++++++
 5 files changed, 29 insertions(+), 26 deletions(-)
---------------------------
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 3220b0a2fb4a..cd9f5a66a690 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2429,8 +2429,11 @@ int enable_kprobe(struct kprobe *kp)
 	if (!kprobes_all_disarmed && kprobe_disabled(p)) {
 		p->flags &= ~KPROBE_FLAG_DISABLED;
 		ret = arm_kprobe(p);
-		if (ret)
+		if (ret) {
 			p->flags |= KPROBE_FLAG_DISABLED;
+			if (p != kp)
+				kp->flags |= KPROBE_FLAG_DISABLED;
+		}
 	}
 out:
 	mutex_unlock(&kprobe_mutex);
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index aac63ca9c3d1..e8143e368074 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -141,6 +141,8 @@ static int fprobe_init_rethook(struct fprobe *fp, int num)
 		return -E2BIG;
 
 	fp->rethook = rethook_alloc((void *)fp, fprobe_exit_handler);
+	if (!fp->rethook)
+		return -ENOMEM;
 	for (i = 0; i < size; i++) {
 		struct fprobe_rethook_node *node;
 
@@ -301,7 +303,8 @@ int unregister_fprobe(struct fprobe *fp)
 {
 	int ret;
 
-	if (!fp || fp->ops.func != fprobe_handler)
+	if (!fp || (fp->ops.saved_func != fprobe_handler &&
+		    fp->ops.saved_func != fprobe_kprobe_handler))
 		return -EINVAL;
 
 	/*
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index fbf2543111c0..7dc023641bf1 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3028,18 +3028,8 @@ int ftrace_shutdown(struct ftrace_ops *ops, int command)
 		command |= FTRACE_UPDATE_TRACE_FUNC;
 	}
 
-	if (!command || !ftrace_enabled) {
-		/*
-		 * If these are dynamic or per_cpu ops, they still
-		 * need their data freed. Since, function tracing is
-		 * not currently active, we can just free them
-		 * without synchronizing all CPUs.
-		 */
-		if (ops->flags & FTRACE_OPS_FL_DYNAMIC)
-			goto free_ops;
-
-		return 0;
-	}
+	if (!command || !ftrace_enabled)
+		goto out;
 
 	/*
 	 * If the ops uses a trampoline, then it needs to be
@@ -3076,6 +3066,7 @@ int ftrace_shutdown(struct ftrace_ops *ops, int command)
 	removed_ops = NULL;
 	ops->flags &= ~FTRACE_OPS_FL_REMOVING;
 
+out:
 	/*
 	 * Dynamic ops may be freed, we must make sure that all
 	 * callers are done before leaving this function.
@@ -3103,7 +3094,6 @@ int ftrace_shutdown(struct ftrace_ops *ops, int command)
 		if (IS_ENABLED(CONFIG_PREEMPTION))
 			synchronize_rcu_tasks();
 
- free_ops:
 		ftrace_trampoline_free(ops);
 	}
 
diff --git a/kernel/trace/kprobe_event_gen_test.c b/kernel/trace/kprobe_event_gen_test.c
index 80e04a1e1977..d81f7c51025c 100644
--- a/kernel/trace/kprobe_event_gen_test.c
+++ b/kernel/trace/kprobe_event_gen_test.c
@@ -100,20 +100,20 @@ static int __init test_gen_kprobe_cmd(void)
 					 KPROBE_GEN_TEST_FUNC,
 					 KPROBE_GEN_TEST_ARG0, KPROBE_GEN_TEST_ARG1);
 	if (ret)
-		goto free;
+		goto out;
 
 	/* Use kprobe_event_add_fields to add the rest of the fields */
 
 	ret = kprobe_event_add_fields(&cmd, KPROBE_GEN_TEST_ARG2, KPROBE_GEN_TEST_ARG3);
 	if (ret)
-		goto free;
+		goto out;
 
 	/*
 	 * This actually creates the event.
 	 */
 	ret = kprobe_event_gen_cmd_end(&cmd);
 	if (ret)
-		goto free;
+		goto out;
 
 	/*
 	 * Now get the gen_kprobe_test event file.  We need to prevent
@@ -136,13 +136,11 @@ static int __init test_gen_kprobe_cmd(void)
 		goto delete;
 	}
  out:
+	kfree(buf);
 	return ret;
  delete:
 	/* We got an error after creating the event, delete it */
 	ret = kprobe_event_delete("gen_kprobe_test");
- free:
-	kfree(buf);
-
 	goto out;
 }
 
@@ -170,14 +168,14 @@ static int __init test_gen_kretprobe_cmd(void)
 					    KPROBE_GEN_TEST_FUNC,
 					    "$retval");
 	if (ret)
-		goto free;
+		goto out;
 
 	/*
 	 * This actually creates the event.
 	 */
 	ret = kretprobe_event_gen_cmd_end(&cmd);
 	if (ret)
-		goto free;
+		goto out;
 
 	/*
 	 * Now get the gen_kretprobe_test event file.  We need to
@@ -201,13 +199,11 @@ static int __init test_gen_kretprobe_cmd(void)
 		goto delete;
 	}
  out:
+	kfree(buf);
 	return ret;
  delete:
 	/* We got an error after creating the event, delete it */
 	ret = kprobe_event_delete("gen_kretprobe_test");
- free:
-	kfree(buf);
-
 	goto out;
 }
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 199759c73519..9712083832f4 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -937,6 +937,9 @@ void ring_buffer_wake_waiters(struct trace_buffer *buffer, int cpu)
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct rb_irq_work *rbwork;
 
+	if (!buffer)
+		return;
+
 	if (cpu == RING_BUFFER_ALL_CPUS) {
 
 		/* Wake up individual ones too. One level recursion */
@@ -945,7 +948,15 @@ void ring_buffer_wake_waiters(struct trace_buffer *buffer, int cpu)
 
 		rbwork = &buffer->irq_work;
 	} else {
+		if (WARN_ON_ONCE(!buffer->buffers))
+			return;
+		if (WARN_ON_ONCE(cpu >= nr_cpu_ids))
+			return;
+
 		cpu_buffer = buffer->buffers[cpu];
+		/* The CPU buffer may not have been initialized yet */
+		if (!cpu_buffer)
+			return;
 		rbwork = &cpu_buffer->irq_work;
 	}
 
