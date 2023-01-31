Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A852E6831B5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbjAaPj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbjAaPjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:39:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F4B125A0;
        Tue, 31 Jan 2023 07:39:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C00061584;
        Tue, 31 Jan 2023 15:39:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3EDC433EF;
        Tue, 31 Jan 2023 15:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675179548;
        bh=Qk1Z8jvFaCkQ+X8X7f5hjELbAOMKL3oSAPP4+h9Aq7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tw2+FXLLCq6ldE48EI2yvVjfvzHMgEL+NlNDQfdBbRFTnA6vR829al4ZcMubFuwON
         pLJ2GKb98uO0lT2Un8xBe3vX8MVMndhlu9Zi/2CBiAGlcKibBgxEm4cUFwOqw3AgU5
         fyIygCYGbsWGfiI16yM5EViQK63Sqv9kKH5adhEGgmrg1Vh+7QEWV9JvS66Yq9e/iT
         y2Z/mkavEoiarvx8LFZZ45IHZWEnjCM26xlUiBbGndDSLdLepYV2Cdq/ENYyKMTKOt
         ZyhkBU7wzv4sH5Ghziq1ZVthmVavtDWsG/jrWFh8+nKfbHrzx2iXqhD4UbmxEcWpnp
         NxT8nUHHPxHtQ==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-trace-devel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Documentation/rtla: Add timerlat-top auto-analysis options
Date:   Tue, 31 Jan 2023 16:38:55 +0100
Message-Id: <a3f5fb49432a55c3323b18725fc6e702f16ccc79.1675179318.git.bristot@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1675179318.git.bristot@kernel.org>
References: <cover.1675179318.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the new options to the man page, as well as updating the
example to include the new output.

Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 .../tools/rtla/common_timerlat_aa.rst         |   7 +
 .../tools/rtla/rtla-timerlat-top.rst          | 164 ++++++++----------
 2 files changed, 80 insertions(+), 91 deletions(-)
 create mode 100644 Documentation/tools/rtla/common_timerlat_aa.rst

diff --git a/Documentation/tools/rtla/common_timerlat_aa.rst b/Documentation/tools/rtla/common_timerlat_aa.rst
new file mode 100644
index 000000000000..077029e6b289
--- /dev/null
+++ b/Documentation/tools/rtla/common_timerlat_aa.rst
@@ -0,0 +1,7 @@
+**--dump-tasks**
+
+        prints the task running on all CPUs if stop conditions are met (depends on !--no-aa)
+
+**--no-aa**
+
+        disable auto-analysis, reducing rtla timerlat cpu usage
diff --git a/Documentation/tools/rtla/rtla-timerlat-top.rst b/Documentation/tools/rtla/rtla-timerlat-top.rst
index 7c4e4b109493..73799c1150ad 100644
--- a/Documentation/tools/rtla/rtla-timerlat-top.rst
+++ b/Documentation/tools/rtla/rtla-timerlat-top.rst
@@ -30,102 +30,84 @@ OPTIONS
 
 .. include:: common_options.rst
 
+.. include:: common_timerlat_aa.rst
+
 EXAMPLE
 =======
 
-In the example below, the *timerlat* tracer is set to capture the stack trace at
-the IRQ handler, printing it to the buffer if the *Thread* timer latency is
-higher than *30 us*. It is also set to stop the session if a *Thread* timer
-latency higher than *30 us* is hit. Finally, it is set to save the trace
-buffer if the stop condition is hit::
+In the example below, the timerlat tracer is dispatched in cpus *1-23* in the
+automatic trace mode, instructing the tracer to stop if a *40 us* latency or
+higher is found::
 
-  [root@alien ~]# rtla timerlat top -s 30 -T 30 -t
-                   Timer Latency
-    0 00:00:59   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)
+  # timerlat -a 40 -c 1-23 -q
+                                     Timer Latency
+    0 00:00:12   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)
   CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max
-    0 #58634     |        1         0         1        10 |       11         2        10        23
-    1 #58634     |        1         0         1         9 |       12         2         9        23
-    2 #58634     |        0         0         1        11 |       10         2         9        23
-    3 #58634     |        1         0         1        11 |       11         2         9        24
-    4 #58634     |        1         0         1        10 |       11         2         9        26
-    5 #58634     |        1         0         1         8 |       10         2         9        25
-    6 #58634     |       12         0         1        12 |       30         2        10        30 <--- CPU with spike
-    7 #58634     |        1         0         1         9 |       11         2         9        23
-    8 #58633     |        1         0         1         9 |       11         2         9        26
-    9 #58633     |        1         0         1         9 |       10         2         9        26
-   10 #58633     |        1         0         1        13 |       11         2         9        28
-   11 #58633     |        1         0         1        13 |       12         2         9        24
-   12 #58633     |        1         0         1         8 |       10         2         9        23
-   13 #58633     |        1         0         1        10 |       10         2         9        22
-   14 #58633     |        1         0         1        18 |       12         2         9        27
-   15 #58633     |        1         0         1        10 |       11         2         9        28
-   16 #58633     |        0         0         1        11 |        7         2         9        26
-   17 #58633     |        1         0         1        13 |       10         2         9        24
-   18 #58633     |        1         0         1         9 |       13         2         9        22
-   19 #58633     |        1         0         1        10 |       11         2         9        23
-   20 #58633     |        1         0         1        12 |       11         2         9        28
-   21 #58633     |        1         0         1        14 |       11         2         9        24
-   22 #58633     |        1         0         1         8 |       11         2         9        22
-   23 #58633     |        1         0         1        10 |       11         2         9        27
-  timerlat hit stop tracing
-  saving trace to timerlat_trace.txt
-  [root@alien bristot]# tail -60 timerlat_trace.txt
-  [...]
-      timerlat/5-79755   [005] .......   426.271226: #58634 context thread timer_latency     10823 ns
-              sh-109404  [006] dnLh213   426.271247: #58634 context    irq timer_latency     12505 ns
-              sh-109404  [006] dNLh313   426.271258: irq_noise: local_timer:236 start 426.271245463 duration 12553 ns
-              sh-109404  [006] d...313   426.271263: thread_noise:       sh:109404 start 426.271245853 duration 4769 ns
-      timerlat/6-79756   [006] .......   426.271264: #58634 context thread timer_latency     30328 ns
-      timerlat/6-79756   [006] ....1..   426.271265: <stack trace>
-  => timerlat_irq
-  => __hrtimer_run_queues
-  => hrtimer_interrupt
-  => __sysvec_apic_timer_interrupt
-  => sysvec_apic_timer_interrupt
-  => asm_sysvec_apic_timer_interrupt
-  => _raw_spin_unlock_irqrestore			<---- spinlock that disabled interrupt.
-  => try_to_wake_up
-  => autoremove_wake_function
-  => __wake_up_common
-  => __wake_up_common_lock
-  => ep_poll_callback
-  => __wake_up_common
-  => __wake_up_common_lock
-  => fsnotify_add_event
-  => inotify_handle_inode_event
-  => fsnotify
-  => __fsnotify_parent
-  => __fput
-  => task_work_run
-  => exit_to_user_mode_prepare
-  => syscall_exit_to_user_mode
-  => do_syscall_64
-  => entry_SYSCALL_64_after_hwframe
-  => 0x7265000001378c
-  => 0x10000cea7
-  => 0x25a00000204a
-  => 0x12e302d00000000
-  => 0x19b51010901b6
-  => 0x283ce00726500
-  => 0x61ea308872
-  => 0x00000fe3
-            bash-109109  [007] d..h...   426.271265: #58634 context    irq timer_latency      1211 ns
-      timerlat/6-79756   [006] .......   426.271267: timerlat_main: stop tracing hit on cpu 6
-
-In the trace, it is possible the notice that the *IRQ* timer latency was
-already high, accounting *12505 ns*. The IRQ delay was caused by the
-*bash-109109* process that disabled IRQs in the wake-up path
-(*_try_to_wake_up()* function). The duration of the IRQ handler that woke
-up the timerlat thread, informed with the **osnoise:irq_noise** event, was
-also high and added more *12553 ns* to the Thread latency. Finally, the
-**osnoise:thread_noise** added by the currently running thread (including
-the scheduling overhead) added more *4769 ns*. Summing up these values,
-the *Thread* timer latency accounted for *30328 ns*.
-
-The primary reason for this high value is the wake-up path that was hit
-twice during this case: when the *bash-109109* was waking up a thread
-and then when the *timerlat* thread was awakened. This information can
-then be used as the starting point of a more fine-grained analysis.
+    1 #12322     |        0         0         1        15 |       10         3         9        31
+    2 #12322     |        3         0         1        12 |       10         3         9        23
+    3 #12322     |        1         0         1        21 |        8         2         8        34
+    4 #12322     |        1         0         1        17 |       10         2        11        33
+    5 #12322     |        0         0         1        12 |        8         3         8        25
+    6 #12322     |        1         0         1        14 |       16         3        11        35
+    7 #12322     |        0         0         1        14 |        9         2         8        29
+    8 #12322     |        1         0         1        22 |        9         3         9        34
+    9 #12322     |        0         0         1        14 |        8         2         8        24
+   10 #12322     |        1         0         0        12 |        9         3         8        24
+   11 #12322     |        0         0         0        15 |        6         2         7        29
+   12 #12321     |        1         0         0        13 |        5         3         8        23
+   13 #12319     |        0         0         1        14 |        9         3         9        26
+   14 #12321     |        1         0         0        13 |        6         2         8        24
+   15 #12321     |        1         0         1        15 |       12         3        11        27
+   16 #12318     |        0         0         1        13 |        7         3        10        24
+   17 #12319     |        0         0         1        13 |       11         3         9        25
+   18 #12318     |        0         0         0        12 |        8         2         8        20
+   19 #12319     |        0         0         1        18 |       10         2         9        28
+   20 #12317     |        0         0         0        20 |        9         3         8        34
+   21 #12318     |        0         0         0        13 |        8         3         8        28
+   22 #12319     |        0         0         1        11 |        8         3        10        22
+   23 #12320     |       28         0         1        28 |       41         3        11        41
+  rtla timerlat hit stop tracing
+  ## CPU 23 hit stop tracing, analyzing it ##
+  IRQ handler delay:                                        27.49 us (65.52 %)
+  IRQ latency:                                              28.13 us
+  Timerlat IRQ duration:                                     9.59 us (22.85 %)
+  Blocking thread:                                           3.79 us (9.03 %)
+                         objtool:49256                       3.79 us
+    Blocking thread stacktrace
+                -> timerlat_irq
+                -> __hrtimer_run_queues
+                -> hrtimer_interrupt
+                -> __sysvec_apic_timer_interrupt
+                -> sysvec_apic_timer_interrupt
+                -> asm_sysvec_apic_timer_interrupt
+                -> _raw_spin_unlock_irqrestore
+                -> cgroup_rstat_flush_locked
+                -> cgroup_rstat_flush_irqsafe
+                -> mem_cgroup_flush_stats
+                -> mem_cgroup_wb_stats
+                -> balance_dirty_pages
+                -> balance_dirty_pages_ratelimited_flags
+                -> btrfs_buffered_write
+                -> btrfs_do_write_iter
+                -> vfs_write
+                -> __x64_sys_pwrite64
+                -> do_syscall_64
+                -> entry_SYSCALL_64_after_hwframe
+  ------------------------------------------------------------------------
+    Thread latency:                                          41.96 us (100%)
+
+  The system has exit from idle latency!
+    Max timerlat IRQ latency from idle: 17.48 us in cpu 4
+  Saving trace to timerlat_trace.txt
+
+In this case, the major factor was the delay suffered by the *IRQ handler*
+that handles **timerlat** wakeup: *65.52%*. This can be caused by the
+current thread masking interrupts, which can be seen in the blocking
+thread stacktrace: the current thread (*objtool:49256*) disabled interrupts
+via *raw spin lock* operations inside mem cgroup, while doing write
+syscall in a btrfs file system.
+
+The raw trace is saved in the **timerlat_trace.txt** file for further analysis.
 
 Note that **rtla timerlat** was dispatched without changing *timerlat* tracer
 threads' priority. That is generally not needed because these threads hava
-- 
2.38.1

