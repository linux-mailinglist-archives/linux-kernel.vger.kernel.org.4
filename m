Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9EE06886E0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 19:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbjBBSlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 13:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbjBBSlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 13:41:39 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD675454F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 10:40:58 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id pv1-20020a17090b3c8100b0022c1ab71110so3267494pjb.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 10:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eq0ulXMOCofqygUrvWm3TIivHTQgIXHPYH8AiMJK0m4=;
        b=bDN/F5+92U9ElOjd1SYVToTojhMiCQYGQISkGNS8PM1648rxpmyQ3QKgjpbuD7I6NN
         qgetR+X51HYf/Go5JRnPXrz/iM74aLFsI8+br9BFEftVOgmDNsLHwaB1qw0+VMzC20A8
         HcuOaUGFY1AxKT4gJhCOEpLXLd0wWSBkjJzCwQ7RCoA7mJidt+kpy9/MlXB3fc8bK+yj
         cfMq7T27ZekbeZSzpoVUUL5feMw7KQLg5NJp/9e/ehTgzTMM1ygK+zTnWoYtRJZ0SUbF
         Iyjst+/jW7a/xd+sXjMmitt5XKMM75YACl+e0+JckvsO187i7FaslLnv8YG5Y1nNWjvu
         Ndtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eq0ulXMOCofqygUrvWm3TIivHTQgIXHPYH8AiMJK0m4=;
        b=IKaKcwy0WAlNB+49TvKctWle3o5XOynXojA+jux+49DdmgYDfVaVhJKUT62rgK9zt4
         SV6ShfsCFFkPZW314i8TVOquwxy2XbFjuRfVCFxXF6BeRwOt+kK+RMlWqibY4kiTQhu5
         PY9xYNkkS6udjbqG5SrGt1fi632amtdpIEYCNpcMoykG92Z1km1A8eCBEOev5MPioe2E
         4WrbGKT+Gmc4N8pBeYaZLbWx5JCvrZP2DixZiSWTojFe5Z46dB3+YA2Ka2sMX6P7tJ5T
         aZHXIjs8+haImowf/PqmdHrKFa4iU93a3mFXHTzrIojgUXldj+A98NUMkUZ+jAIyxg/d
         f/iw==
X-Gm-Message-State: AO0yUKUbDxJozBzHOy/o43b3oWYk1ufgGOGBmJA6oanL/Y25idyXjlAQ
        3B92nns+iAH8RcACF43TyNlwZwtQNNazwmON8q0VxVa+Mh7BubJPBNuGRbxe9aQE5S1OPfJLKgR
        ihQYMBNZ6ubqmRcq4ylqk85ixhRxrG+qe+oQqn0pJpyN/ieHLnn+GWpg268gS2cGqpFVv/t8=
X-Google-Smtp-Source: AK7set/0YEW8im9qYiikDlyp4cuSXMahQOw9o82iZ/sT06lXQeZm+uxoXQpRb9CiyBeI6aNrNQUdmu7G8zqO
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a63:475f:0:b0:4da:d745:98da with SMTP id
 w31-20020a63475f000000b004dad74598damr1241724pgk.46.1675363222206; Thu, 02
 Feb 2023 10:40:22 -0800 (PST)
Date:   Thu,  2 Feb 2023 18:40:18 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230202184018.2576687-1-jstultz@google.com>
Subject: [RESEND][PATCH v3] trace: Add trace points for tasklet entry/exit
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Lingutla Chandrasekhar <clingutla@codeaurora.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, kernel-team@android.com,
        "J . Avila" <elavila@google.com>, John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
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
2.39.1.519.gcb327c4b5f-goog

