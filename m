Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DD665C6C8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbjACSyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjACSyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:54:14 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57251F7B
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 10:54:13 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id p12-20020a170902e74c00b0019254f41f6aso21749672plf.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 10:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=88y0UfhMzpIzcF+i0aeHj+160apjA13IPkO6jcFxsno=;
        b=pb4wfNxDUm8ufcVaIopM/P/7BA4nwETAThO5+GdYRFGByDsGP2OY1BG1OREWfUvfJP
         ioSBhW2guArKhAJWhPcMJp1n6UbR+F5/XlFdkvJMa0peVKimtw6aXNhEBCu0hvfCOLsf
         dJRI+jyoxciIuI85qNw3pZ0IGC6lbMwoCbT7LWuRVK83EEjofpiYL8p3qthyVMdllOpz
         5wsvVXuK4J1Veze/4qYvKbIhTa1rBrAzpvuGbigsSElTN4KApnqobUTt5XVBwD6xnvHK
         F/8ueXFQuJA2KpAh4/rl6IEo7os7yCh85IY9WzWYsOOqQF+PG3xyp/BjkgZJbuUv3DiL
         sQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=88y0UfhMzpIzcF+i0aeHj+160apjA13IPkO6jcFxsno=;
        b=fWjL/PbA5aLqF5Zn/yjNnzDC4x4GEtt8bUqx3sD4/xCaNqy1A0qovsmxQ+T6HX3ueW
         tgA2zPTz4Ck81Gywg/tQwBCFaApdl/TeFCAPaAgCr3WGthxKSqKAYOR4Bxu+pbAEs36M
         NekBUXX+YPQrWVFCPOORJuchYCUXzLSqB8bxZM9KEFYaQ4ksYmc2oz6CdPPimeWWsUWD
         eEB/P1zxS2V0G8CJXuHZv3jtKH+ei4IQo5kgQV/81LKD/cfFoWwxTFLmKnja7F+ZEQDx
         yueL6DYJnOZcgbKYmCqebdLIyhpoPoZR36OzRwBZm/aMcyqnr7hH/bqN8dwYIDb2o20C
         pqmQ==
X-Gm-Message-State: AFqh2krwq7Qpa8fw3DRoHSIOKjp63KC8H8K9nUgQa5vQsa4XbBcCq6se
        HY1JBxRIazyKcTGa+HVbsSsAn/yda58WBRl67Qhah+HYG4/3teL5FDTx3k3itSzT3jTKTPvd+Wt
        /yYfhWiVh7tPyM2365LXakjp0b1pG2kB/KN54IMQW0UZuuelzHv6bZ9oEgu0pZZKDxBSXnhg=
X-Google-Smtp-Source: AMrXdXupyFMOn124Go6QjcG8VYKG9jlja4Raft5SzbiZayFhIVJ7PZy4jplEJnnlLS5d5cMsdujIvGhPE1A2
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:902:e993:b0:192:b9ae:6def with SMTP id
 f19-20020a170902e99300b00192b9ae6defmr704540plb.83.1672772052716; Tue, 03 Jan
 2023 10:54:12 -0800 (PST)
Date:   Tue,  3 Jan 2023 18:54:08 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230103185408.2874345-1-jstultz@google.com>
Subject: [PATCH] trace: Add trace points for tasklet entry/exit
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Lingutla Chandrasekhar <clingutla@codeaurora.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Connor O'Brien" <connoro@google.com>, kernel-team@android.com,
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

This patch has been carried in the Android tree for awhile
so I wanted to submit it for review upstream. Feedback would
be appreciated!

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Connor O'Brien <connoro@google.com>
Cc: kernel-team@android.com
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Lingutla Chandrasekhar <clingutla@codeaurora.org>
[elavila: Port to android-mainline]
Signed-off-by: J. Avila <elavila@google.com>
[jstultz: Rebased to upstream, cut unused trace points, added
 comments for the tracepoints, reworded commit]
Signed-off-by: John Stultz <jstultz@google.com>
---
 include/trace/events/irq.h | 43 ++++++++++++++++++++++++++++++++++++++
 kernel/softirq.c           |  9 ++++++--
 2 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/irq.h b/include/trace/events/irq.h
index eeceafaaea4c..da85851d4ec1 100644
--- a/include/trace/events/irq.h
+++ b/include/trace/events/irq.h
@@ -160,6 +160,49 @@ DEFINE_EVENT(softirq, softirq_raise,
 	TP_ARGS(vec_nr)
 );
 
+DECLARE_EVENT_CLASS(tasklet,
+
+	TP_PROTO(void *func),
+
+	TP_ARGS(func),
+
+	TP_STRUCT__entry(
+		__field(	void *,	func)
+	),
+
+	TP_fast_assign(
+		__entry->func = func;
+	),
+
+	TP_printk("function=%ps", __entry->func)
+);
+
+/**
+ * tasklet_entry - called immediately before the tasklet is run
+ * @func:  tasklet callback or function being run
+ *
+ * Used to find individual tasklet execution time
+ */
+DEFINE_EVENT(tasklet, tasklet_entry,
+
+	TP_PROTO(void *func),
+
+	TP_ARGS(func)
+);
+
+/**
+ * tasklet_exit - called immediately after the tasklet is run
+ * @func:  tasklet callback or function being run
+ *
+ * Used to find individual tasklet execution time
+ */
+DEFINE_EVENT(tasklet, tasklet_exit,
+
+	TP_PROTO(void *func),
+
+	TP_ARGS(func)
+);
+
 #endif /*  _TRACE_IRQ_H */
 
 /* This part must be outside protection */
diff --git a/kernel/softirq.c b/kernel/softirq.c
index c8a6913c067d..dbd322524171 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -793,10 +793,15 @@ static void tasklet_action_common(struct softirq_action *a,
 		if (tasklet_trylock(t)) {
 			if (!atomic_read(&t->count)) {
 				if (tasklet_clear_sched(t)) {
-					if (t->use_callback)
+					if (t->use_callback) {
+						trace_tasklet_entry(t->callback);
 						t->callback(t);
-					else
+						trace_tasklet_exit(t->callback);
+					} else {
+						trace_tasklet_entry(t->func);
 						t->func(t->data);
+						trace_tasklet_exit(t->func);
+					}
 				}
 				tasklet_unlock(t);
 				continue;
-- 
2.39.0.314.g84b9a713c41-goog

