Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E6264BC68
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 19:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236484AbiLMSx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 13:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235679AbiLMSxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 13:53:23 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD131288
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 10:53:22 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id pi14-20020a17090b1e4e00b0021d20da7a51so3018741pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 10:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Xxzr695HHfHVdhrYup9BkYD8QeX0oumaXm3G9QRhTkA=;
        b=dtokfV/wcTioD/c+ucNrusiyFPcwRiWc24+ntZOUSVun25aEjJYPtU9VYp05v5NAEK
         M+4Mlz0wgTRvVcfVdw/5EAxvYdS0b/QhX5k4XcuTlQBBtD/6MnarV5tSWDKY4bPFhiIe
         ttWsUDnHilchcU3a5EZ5D94QuQT1hLb5mrTlso3j4pABC60aPeLnNRN+UnQpZmNkbQrF
         dlP2AmQ2sLRpRPSw6uG4RVHfokJjOc1+cagrMnGR86qu7JOlJNMnFJIO7rEoyM8T7kPJ
         fk7cL6sitrtIl6nKWyg1dexpwwEJ/euqOZJDBPTILg+swA5/XOmn2Tx6JMPPqz73ykC1
         p+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xxzr695HHfHVdhrYup9BkYD8QeX0oumaXm3G9QRhTkA=;
        b=8N6NBskD1dx+M2O7eGCBY6luPjagg8ur5FhQSCya0sPPN0pCN1hIq3Nm7OImgvhCsk
         t7FVV7X6jqiUgo/cjTk5ib4q3vOjBg0TUAlo1O2bb3JzyEjhd3ABZ5VP/6JTLG69UN1B
         NImCfmcBXonhIBOXdWjyVD/OWrr22ec9x8HfQWIgRjIh48xMTFRasuK7bIhpCQmK0K1u
         lJ9g+8Dh71NPsQP08cP9qi80VuPkmIob/a4VWv7KEV2+eahzfSZnS736IVbAzlDQy2Zz
         8cKvXrW3ZTFuzdguJcSyB1Pp/8rUsb1+AVhLIrQc+9Q3TVDiKwvljGWtsREbuqP1Ijd+
         6WPg==
X-Gm-Message-State: ANoB5pnQwOPAKCLqZqHF2LgThTdky3nevGi8qKvQq6Oot+IhhdHyUxyW
        kCnIIr03QySivOU7sn4cyQKpsaHejOZrDoj1B06LMojNAgVsH6iNZ2OvBj0kXoycPRMxLtJIjI5
        1xEWIZbZ1YRKoUeH4m752YQh+u1Q4xvsuG6c79TY/KF/7DXWAGobKbD9Czgp93oUrbHygDHo=
X-Google-Smtp-Source: AA0mqf7iB6vH0hrMhSr3Yd/TMz0wxdFTaJ8SFFzbOfHTrwGPUJnnRNjeev6+7boVGfHBZe80gI0SEXdqMAXh
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:90a:5414:b0:219:4f54:34e6 with SMTP id
 z20-20020a17090a541400b002194f5434e6mr364698pjh.208.1670957602079; Tue, 13
 Dec 2022 10:53:22 -0800 (PST)
Date:   Tue, 13 Dec 2022 18:53:10 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221213185310.1315794-1-jstultz@google.com>
Subject: [RFC][PATCH] trace: Add trace points for tasklet entry/exit
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
2.39.0.rc1.256.g54fd8350bd-goog

