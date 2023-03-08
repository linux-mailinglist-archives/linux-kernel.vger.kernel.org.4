Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAECC6AFFB9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 08:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjCHHc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 02:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjCHHcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 02:32:19 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DF2A336C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 23:32:14 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id d185-20020a25e6c2000000b008fa1d22bd55so17083990ybh.21
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 23:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678260734;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1HJMLloX8l3VEo0+22HUaFfPeUdekf+/4qykWWC+d8Q=;
        b=sV1RKOnV7SF9Z0hXW96OjKAFskv9QxYAq2DIgZs6X3jgNThSZn8PERZBPg+ExcAz8q
         L+yd8AyQO80kF1xo0A5IYqIKP+g037KRTtaDB0s0ruMuH8v/qos7aw9bx8KvIhxL+QdZ
         nbI3yF7wgTcPM6xv17msJrDyGBFNO/0cm5d3tj0H7gH+XqK/a/fLx4qnF3NtThvqlevo
         vF84/hm97EKEGvrDziTCNG5cNrIm0gZHhMjxUyXWZuVHZO2MZ8V9XVcbWhj9kj78mjJl
         qTLc8o1g+gKHaL5FlMjaaGPY8tqvJmhKhA0uYKy5ylyGYJZBd0LqA4JdzqXDGC/TunWj
         7uyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678260734;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1HJMLloX8l3VEo0+22HUaFfPeUdekf+/4qykWWC+d8Q=;
        b=nqw5L0UnT+QQDxEErPU8piGziO0+YvlpBKyw6oT5NGWfnvQ+Bji2PdQN//w6iZqGl9
         1STFli6une0VU+//6LqBj54QYEUiWvCAlbwJT3iTBzyKNfh53PWJ7+pg1ddLN54SCvNx
         vrZWuiN6pu8bjba4LQl3+UbEbTR00uwv+mcVnLGeE3gTRKW7gH/PGlKvqApVFOP2i6OD
         eMIABJLpQRc1imuYzUsMitWpqbQx5QWrtBOePsUNGT8FunbROTeTBaBkiTnJEnfGngoE
         COvYFYQPzRBQgl/9EjdtRcf2mTpla8oMQWvtb5LUWMPWF5aSfOu8Xjdy6b/n9IHbzl95
         eewg==
X-Gm-Message-State: AO0yUKW9qbsQn/6DZXPa48OpBFzMxEkfRhiE5RCYqf2dPhZkrBinNA5n
        8Kf1dNS5iYdXE+qGidoeVRSZLsnFC4g=
X-Google-Smtp-Source: AK7set9ioPK6MoaQWwmMvAEI8zCmlOuHUBwUXXK8WXboKLBqaMGLdSnUaq9+l4rgvMN20bhtpnMM0D5mYlQ=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:11:b53:99a6:b4fe:b30b])
 (user=avagin job=sendgmr) by 2002:a05:6902:151:b0:afa:d8b5:8e82 with SMTP id
 p17-20020a056902015100b00afad8b58e82mr8271697ybh.6.1678260734085; Tue, 07 Mar
 2023 23:32:14 -0800 (PST)
Date:   Tue,  7 Mar 2023 23:31:57 -0800
In-Reply-To: <20230308073201.3102738-1-avagin@google.com>
Mime-Version: 1.0
References: <20230308073201.3102738-1-avagin@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230308073201.3102738-3-avagin@google.com>
Subject: [PATCH 2/6] sched: add WF_CURRENT_CPU and externise ttwu
From:   Andrei Vagin <avagin@google.com>
To:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>, avagin@gmail.com,
        Andrei Vagin <avagin@google.com>,
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
context switching use cases.

In addition, make ttwu external rather than static so that
the flag could be passed to it from outside of sched/core.c.

Signed-off-by: Peter Oskolkov <posk@google.com>
Signed-off-by: Andrei Vagin <avagin@google.com>
---
 kernel/sched/core.c  |  3 +--
 kernel/sched/fair.c  |  4 ++++
 kernel/sched/sched.h | 13 ++++++++-----
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index af017e038b48..386a0c40d341 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4123,8 +4123,7 @@ bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
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
index 7a1b1f855b96..4c67652aa302 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7569,6 +7569,10 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
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
index 3e8df6d31c1e..f8420e9ed290 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2093,12 +2093,13 @@ static inline int task_on_rq_migrating(struct task_struct *p)
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
@@ -3232,6 +3233,8 @@ static inline bool is_per_cpu_kthread(struct task_struct *p)
 extern void swake_up_all_locked(struct swait_queue_head *q);
 extern void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
 
+extern int try_to_wake_up(struct task_struct *tsk, unsigned int state, int wake_flags);
+
 #ifdef CONFIG_PREEMPT_DYNAMIC
 extern int preempt_dynamic_mode;
 extern int sched_dynamic_mode(const char *str);
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

