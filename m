Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB26B625470
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 08:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbiKKHcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 02:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbiKKHcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 02:32:09 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516405B599
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 23:32:08 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id t3-20020a170902e84300b00186ab03043dso3074765plg.20
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 23:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qJqakF/cb4xngAKJ2V4R5RqLyy98cuBZSEz0fOEyQyE=;
        b=G2Otzz01US+DOi6goCyzMK7tP68iJqbqsKD5nc/uQuFqxTtqVKJqSgQnm9mEnXTj7A
         XoWso2YI94PIpLITBT9FSPb7Q74RMOrusytAAdR+aO8LX1GmZ6mYwDZiqsRhQ7Gi22Gy
         B4TSTt6s+/btq3k9nCUUCDSK/tsrMIqRMaK/xGs4a7Tc57IIACF/EEif4lFW0zWJwyvv
         jISfhJ6dcJswhGTKkku3MgbV2KwiAoLenii5IzwONSooP51bmg3OQoTDSrO2Glx58DpZ
         kVtLTDlCbeb7/XZyHXeyM0sYovlLwbCtpZm+dhiwVJILaPSnxtJSVqx1bKhGibKw1cl3
         KONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qJqakF/cb4xngAKJ2V4R5RqLyy98cuBZSEz0fOEyQyE=;
        b=uzEMSmk4fsUmerW3K3s/cWpPJC/2al3MdfAEc9NM7NOMAZGpoqYxMp0PhrMS/rJ1Z3
         9FE9o+prgP61OlYjVEF3nB9fiWxrvJPTU4iS2dO7K+POwPZ3fsQ0xJwWF+83amR7+Grh
         T6xQfnbs69xrrEzDk6cPkQq78ytiXptHUZyezHMqZ1WNvg1GWPb9f1WQpd3pgbRI5crL
         RNoQcpg4ddh0dER6AYPCe4azQE5wqV1Wys/koA0EVTg53wu+ZTlgi0j10CwnH1WY8Sl1
         TjoC+VG744BuvVH0+QLBZo1XnP/J0NfPQMfb7WbAyPsoG8cQJ1CknLQDs+t8WLTfIKRD
         7FVQ==
X-Gm-Message-State: ANoB5plnBlA8MJNRExlr971iZ+KSIAduNBGNv1NRIFG0vS2paOfOtA1a
        LKN7jNXRWCeaoC1sLA96MfKdVkrVYXE=
X-Google-Smtp-Source: AA0mqf56NlSTNAmS1SSIjJydNdN8gscB0Ne+rGIBCmPLknLmZzp8IJYFcFvjgBP9VWg3RlNDi3GFqrG8qP0=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:11:8cf3:f53:2863:82a3])
 (user=avagin job=sendgmr) by 2002:a17:902:9349:b0:17e:802b:fd6e with SMTP id
 g9-20020a170902934900b0017e802bfd6emr1101537plp.116.1668151927844; Thu, 10
 Nov 2022 23:32:07 -0800 (PST)
Date:   Thu, 10 Nov 2022 23:31:51 -0800
In-Reply-To: <20221111073154.784261-1-avagin@google.com>
Mime-Version: 1.0
References: <20221111073154.784261-1-avagin@google.com>
X-Mailer: git-send-email 2.38.1.493.g58b659f92b-goog
Message-ID: <20221111073154.784261-3-avagin@google.com>
Subject: [PATCH 2/5] sched: add WF_CURRENT_CPU and externise ttwu
From:   Andrei Vagin <avagin@google.com>
To:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
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
context switching use cases such as UMCG.

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
index cb2aa2b54c7a..4b591e7773fd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4039,8 +4039,7 @@ bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
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
index e4a0b8bd941c..4ebe7222664c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7204,6 +7204,10 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
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
index a4a20046e586..4c275f41773c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2077,12 +2077,13 @@ static inline int task_on_rq_migrating(struct task_struct *p)
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
@@ -3167,6 +3168,8 @@ static inline bool is_per_cpu_kthread(struct task_struct *p)
 extern void swake_up_all_locked(struct swait_queue_head *q);
 extern void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
 
+extern int try_to_wake_up(struct task_struct *tsk, unsigned int state, int wake_flags);
+
 #ifdef CONFIG_PREEMPT_DYNAMIC
 extern int preempt_dynamic_mode;
 extern int sched_dynamic_mode(const char *str);
-- 
2.38.1.493.g58b659f92b-goog

