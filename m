Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486C768739B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 04:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjBBDEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 22:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjBBDEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 22:04:41 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D165FFA
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 19:04:40 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id h4-20020a17090aa88400b0022c8dfc9db4so364054pjq.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 19:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QH2jJ0lYMHyWgETUubfbRs+kKTgqzQ/t/S1vJNh165w=;
        b=rtMV7RhRmvPg8Ucd6Z/onimnlE9lf06PbCwPfNV/GB8xMtJNDystCRo0DaxhIgmIUb
         nLjjcHpdKF63ac6JkmxtKZjVRVN9v4Gx+sNYnl7HmBq+h/5XsYcP5ihqGsSnKW/xUAwb
         73lPnZ7/LqTvLJXCDPF2MfnbWcirqk6QT8cp2Ho/5bzpw+cOx4ZstUEuk3XKB2MU78zV
         0xFJc0vMyEcgAky7/8WRFvqyTl8Mtwyzp7jvpHEiKlbUvjn8hpMoq92XNqITMU6f43cu
         qyRuKxqroLeFReijOSuysEkFbUFi3MaklNT6r9E0fNBx+vMsWMmrzW6fHFftdqBVz6hT
         Kanw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QH2jJ0lYMHyWgETUubfbRs+kKTgqzQ/t/S1vJNh165w=;
        b=1WQa3GKLrMr0Q8U1DiWSlZaVy8Kju0vvl4I2xku1wZPILbhpyxjj8f1xrfNuzQMTl5
         Ok5KpaClcEI3v6v9GEEDaU/PJe3bmMYaFb32zHtlAyAYb5K1sOLb7Th+m/bJk1PvQgja
         XRzIwsfbGAcCWPE+n0y407aPaKzzTETC2dBfYRgLcMlDqGfm1EGYT4myl3bSXtdxXgRo
         1wjCYTubqbj2mdd/Z4IiA/XTc47YkI3n2tTKF3vGL5fwwp4/H8fBvkWkJTyuB7TOuXl2
         47aNBiMcytkBunztSXTzdZF4hgk7JQ0qzlmV2O69IbXvvQqI8LaC8YLFm2r+u3sW+weg
         eBfQ==
X-Gm-Message-State: AO0yUKWxZBLjI5gedWy3NKEetJ886NfoAOHaOXtacOvorPmdQYGjQnhZ
        Ydd9/QB66eyrO8vsdhB6IGO/Eet8Pa4=
X-Google-Smtp-Source: AK7set/zcd+uxDP2ZStcQYb/rlrwbfrj/lIWF1EUkpLvGPyfkfhueGFv9F1csahB+2Xw4IEX46f0F1A+7MU=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:11:eee0:dc42:a911:8b59])
 (user=avagin job=sendgmr) by 2002:a05:6a00:17a7:b0:590:762f:58bc with SMTP id
 s39-20020a056a0017a700b00590762f58bcmr1077020pfg.50.1675307079604; Wed, 01
 Feb 2023 19:04:39 -0800 (PST)
Date:   Wed,  1 Feb 2023 19:04:25 -0800
In-Reply-To: <20230202030429.3304875-1-avagin@google.com>
Mime-Version: 1.0
References: <20230202030429.3304875-1-avagin@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230202030429.3304875-3-avagin@google.com>
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
index e838feb6adc5..25e902b40a18 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4112,8 +4112,7 @@ bool ttwu_state_match(struct task_struct *p, unsigned int state, int *success)
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
index 0f8736991427..698828bd8d72 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7377,6 +7377,10 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
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
2.39.1.456.gfc5497dd1b-goog

