Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEB4664E11
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 22:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjAJVbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 16:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbjAJVbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 16:31:02 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36C36534B
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:30:21 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id r5-20020a17090a1bc500b00227067dde1eso3614448pjr.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 13:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=er80A9Er8wBpxR2BIE0p2D2/xkiobfzzZD4tbBwSUuc=;
        b=k7kio1FL9Eg0JJeN23HIDqJzpDd/aXo24nWXA8QtE26rzS8NIcltXZhsRIlZMJ/v4y
         FFL90KgnLTpkw1lLYymV6ADXdp5aTBQFGoW/wwuZWYtoaI0yAtVlEWUoLZyRcnsjdNBi
         JT3BNX2YSuH9BnOBoE/oeMVzlB/ShvfW9zWuGCfcHHZJGFMQ+IHSYZwpZbmHCUMzb27R
         ej317WRq8YkKUX6P8M+rM3r5REU7oFpoNuUkoGCut433ssPdvnJ8ILCQi9Ks2QR+GZWj
         yYdrXk1tL6llthn89LX846SNzgDrI4Z2ToHsY9Vr3IhA/1ymq2oE6tNHQhaHGzgxsXQ2
         M2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=er80A9Er8wBpxR2BIE0p2D2/xkiobfzzZD4tbBwSUuc=;
        b=TTaZS+K84JXkm1xMvI2M+1JC4EBVlVuoXE6L1xjBU0GaSoRiBi1G+xGXO9AvLIQGgZ
         I8qABCMIf1PkAP0u0QFm0WNqdPmDeEzIzE9ApS9RJ82capkb+7Kf+UUOPmOuJweD6HKD
         4rTaOwTMI8qNd+3QOT8WWJrx6g/c+ec2H4gnn73A7dI3g/ocU3AHLkfORNHtBa/lH7ka
         FwDKwZvjqBFnIUDGeykI46S+ug9jdw5LxdHoFRmM5AmFzsaXMMUAvpN72ziv669CSMYK
         7bpquvM6YpfNv6Ug8OUcx3qJhg9PyygK6ddyQlR5cotd84t6Pnvwso7XxjAH3a/7C4Ay
         br5g==
X-Gm-Message-State: AFqh2koKtqts7scJmxzwNMfoXWTYmm7qizf8lDDNWFcSr91JQcoLJi8S
        HXxTHEDLDBfwlajjXF0U3BeH6IMVh6Y=
X-Google-Smtp-Source: AMrXdXtj0wrADAOgf+zF9QujslNiLfEm/Juh4EPsEFD/mE7R9rd6zhbudUg4fgg8yDp8PqaGX8+6nFDBnOY=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:11:6203:13b5:2d85:b75c])
 (user=avagin job=sendgmr) by 2002:a62:3683:0:b0:578:47f4:e0ec with SMTP id
 d125-20020a623683000000b0057847f4e0ecmr5429470pfa.60.1673386221162; Tue, 10
 Jan 2023 13:30:21 -0800 (PST)
Date:   Tue, 10 Jan 2023 13:30:07 -0800
In-Reply-To: <20230110213010.2683185-1-avagin@google.com>
Mime-Version: 1.0
References: <20230110213010.2683185-1-avagin@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230110213010.2683185-3-avagin@google.com>
Subject: [PATCH 2/5] sched: add WF_CURRENT_CPU and externise ttwu
From:   Andrei Vagin <avagin@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>
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

From: Peter Oskolkov <posk@google.com>

Add WF_CURRENT_CPU wake flag that advices the scheduler to
move the wakee to the current CPU. This is useful for fast on-CPU
context switching use cases.

In addition, make ttwu external rather than static so that
the flag could be passed to it from outside of sched/core.c.

Signed-off-by: Peter Oskolkov <posk@google.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 kernel/sched/core.c  |  3 +--
 kernel/sched/fair.c  |  4 ++++
 kernel/sched/sched.h | 13 ++++++++-----
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 25b582b6ee5f..6478e819eb99 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4063,8 +4063,7 @@ bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
  * Return: %true if @p->state changes (an actual wakeup was done),
  *	   %false otherwise.
  */
-static int
-try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
+int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 {
 	unsigned long flags;
 	int cpu, success = 0;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c36aa54ae071..d6f76bead3c5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7380,6 +7380,10 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 	if (wake_flags & WF_TTWU) {
 		record_wakee(p);
 
+		if ((wake_flags & WF_CURRENT_CPU) &&
+		    cpumask_test_cpu(cpu, p->cpus_ptr))
+			return cpu;
+
 		if (sched_energy_enabled()) {
 			new_cpu = find_energy_efficient_cpu(p, prev_cpu);
 			if (new_cpu >= 0)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 771f8ddb7053..34b4c54b2a2a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2088,12 +2088,13 @@ static inline int task_on_rq_migrating(struct task_struct *p)
 }
 
 /* Wake flags. The first three directly map to some SD flag value */
-#define WF_EXEC     0x02 /* Wakeup after exec; maps to SD_BALANCE_EXEC */
-#define WF_FORK     0x04 /* Wakeup after fork; maps to SD_BALANCE_FORK */
-#define WF_TTWU     0x08 /* Wakeup;            maps to SD_BALANCE_WAKE */
+#define WF_EXEC         0x02 /* Wakeup after exec; maps to SD_BALANCE_EXEC */
+#define WF_FORK         0x04 /* Wakeup after fork; maps to SD_BALANCE_FORK */
+#define WF_TTWU         0x08 /* Wakeup;            maps to SD_BALANCE_WAKE */
 
-#define WF_SYNC     0x10 /* Waker goes to sleep after wakeup */
-#define WF_MIGRATED 0x20 /* Internal use, task got migrated */
+#define WF_SYNC         0x10 /* Waker goes to sleep after wakeup */
+#define WF_MIGRATED     0x20 /* Internal use, task got migrated */
+#define WF_CURRENT_CPU  0x40 /* Prefer to move the wakee to the current CPU. */
 
 #ifdef CONFIG_SMP
 static_assert(WF_EXEC == SD_BALANCE_EXEC);
@@ -3245,6 +3246,8 @@ static inline bool is_per_cpu_kthread(struct task_struct *p)
 extern void swake_up_all_locked(struct swait_queue_head *q);
 extern void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
 
+extern int try_to_wake_up(struct task_struct *tsk, unsigned int state, int wake_flags);
+
 #ifdef CONFIG_PREEMPT_DYNAMIC
 extern int preempt_dynamic_mode;
 extern int sched_dynamic_mode(const char *str);
-- 
2.39.0.314.g84b9a713c41-goog

