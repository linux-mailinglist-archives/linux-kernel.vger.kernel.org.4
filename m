Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820886C5A54
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 00:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjCVX17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 19:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCVX15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 19:27:57 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E6C2D63
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 16:27:56 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id j15-20020a17090a318f00b0023fe33f8825so2017258pjb.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 16:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679527676;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F8gJn/RqHZd9pZyBGjIkjsEpwHztmYNBKyUX9XcX/sw=;
        b=FxEe+6vQbntvDlAA9NkLZloGQ6PHegmT23ZDI4/wuFQsobb2Hd7xUlVF+lkQgFerOp
         wDdH8g01ny0Q5nZZ+uJJ/TbvDqi4wtbQq7XVj8JmJhG9dOfKC11pGzUGiZAq0nz89N7F
         ThqUFa5qa509TFg/ejvn1G76vsbp7JDh4ZocaKSSvM49oY1EMygMACUnSs05wDlyDo+e
         oiJSRbrm3vjktkOMc5Z/FpU0ZJPCjPkmpE9VQ9jHD1jYfmatfHlTFYZogZkJODh7hOMn
         CobVaXbhwl08hMvBIghDPhHQoi/E/7AlELCnhLQ32ykTfpGEEE6o/0QJQGROetYwQZcF
         50xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679527676;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F8gJn/RqHZd9pZyBGjIkjsEpwHztmYNBKyUX9XcX/sw=;
        b=eqeS8vSQ0plyrlFw1nlWNFOsTBZOnaoSgJqS+kRopW0e/KKt7IiT9iVIOpFsanLtwR
         pxQxTJs4I88eIrMjPD55aZdCjDPDr5ZoFeO95YBMC0XqkYa5QgZ88FLjpYX7tvx/FPu8
         6ydVdDSwJo5K+sHcuXXuFAoixaVZONk0/4GM2WQ/P6zWFX//B3PX/Ed+ROml2ux6HkhC
         WZhigw+DDL6G3A2xUfGY3OwbhNkEw70rVqwpAqJc3cg9QvoLj5PqBzHvQ7sGovY9GWeB
         26GdbidyE01AQqdSw7wsKzKT1+ZtvNBIxSsCT0sxS562dKZamTpMFf4RWr+6jFJ2BiHa
         rAZw==
X-Gm-Message-State: AO0yUKVE5m7eg1c5Usy+/UB6IbZVsa0X8xIKZQJIg3dx3eGrDMXplH4E
        3og9BHg96I9IVnFrcTbntig2RAu+IAMDq4a0X0cGTN5t+irz+IGL2aGwk7EWQYdVRAltzFo+BRX
        ELhOwn9cq4IrCeGOwwfxET1SITGXigUre/3u3EdwFYgoSaB+LixYtbFWTTra7RKpKAcQ5v0E=
X-Google-Smtp-Source: AK7set+7zGlsAeamA5yej9pDQx8hLnsrgYRGJqTaDEPBpeg3Ippo8y+vWYME+sgpRCq9uWCk8WqS0FoyG+Pi
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6a00:2d0c:b0:627:df77:8303 with SMTP
 id fa12-20020a056a002d0c00b00627df778303mr2627788pfb.5.1679527676079; Wed, 22
 Mar 2023 16:27:56 -0700 (PDT)
Date:   Wed, 22 Mar 2023 23:27:53 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230322232753.2789341-1-jstultz@google.com>
Subject: [RESEND x3][PATCH v3] trace: Add trace points for tasklet entry/exit
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Lingutla Chandrasekhar <clingutla@codeaurora.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, kernel-team@android.com,
        "J . Avila" <elavila@google.com>, John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lingutla Chandrasekhar <clingutla@codeaurora.org>

Tasklets are supposed to finish their work quickly and
should not block the current running process, but it is not
guaranteed that. Currently softirq_entry/exit can be used to
know total tasklets execution time, but not helpful to track
individual tasklet's execution time. With that we can't find
any culprit tasklet function, which is taking more time.

Add tasklet_entry/exit trace point support to track
individual tasklet execution.

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

This patch has been carried in the Android tree for awhile
so I wanted to submit it for review upstream. Feedback would
be appreciated!

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: kernel-team@android.com
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Lingutla Chandrasekhar <clingutla@codeaurora.org>
[elavila: Port to android-mainline]
Signed-off-by: J. Avila <elavila@google.com>
[jstultz: Rebased to upstream, cut unused trace points, added
 comments for the tracepoints, reworded commit]
Signed-off-by: John Stultz <jstultz@google.com>
---
v2:
* Added tasklet pointer to the trace event as suggested by Steven
v3:
* Minor tweak to commit to show usage and output example
---
 include/trace/events/irq.h | 47 ++++++++++++++++++++++++++++++++++++++
 kernel/softirq.c           |  9 ++++++--
 2 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/irq.h b/include/trace/events/irq.h
index eeceafaaea4c..a07b4607b663 100644
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
index c8a6913c067d..1b725510dd0f 100644
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
-- 
2.40.0.rc1.284.g88254d51c5-goog

