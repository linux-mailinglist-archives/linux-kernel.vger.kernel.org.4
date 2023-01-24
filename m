Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDAE67A6FF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 00:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbjAXXmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 18:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbjAXXmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 18:42:07 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5443CEC47
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 15:42:06 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id cw8-20020a056a00450800b0058a3508303eso7435398pfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 15:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lah5T4LA+ROCG4YZ0vVyyEKK2I5gjhcF16gSjf24Noo=;
        b=IGyqT2rl17rRqTPfLdyuUnvDyatbJTaprQUp50FrNxlkElHUAQ3qVdFWKUPsOzYUq5
         4oPRURkXY/vQbChgZRoNYC8JgWMMFE/cPIjWFH1Iu7QKftN2wi1N2eXwDMlnAoy96MRK
         IMIRFkXPABMKN822NiWifYufm479ZeVAp5IOyaT8iWyx/orysTDv8u2x/3nKhXclU5iU
         PHwNu3sw7RdpX6FGLP1jV6vQIG3GGrHNAr8AP8+lLUEy6GuSLMWSuQqxDrA/r6J+tjzz
         XB17TJG2qpEGN0Mj8OJY9uQfolU97Xcl8htO7xLvY0Z/ITZNT+HsXwaAC8hgFl2Ctm3H
         ssrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lah5T4LA+ROCG4YZ0vVyyEKK2I5gjhcF16gSjf24Noo=;
        b=sz7jGsXpKIkUP0e4qjTJWCGwcEAYUBmVftDWCb0/JBV4iz0+Be6s2jSPTiKSVqS4iz
         B1u55zkXCTzAJgZqL7AgdmyUfu3OLojFUOxduDCs9U6hvuk5g+hHOryB9n1DbbgvpHT8
         4bFg9mZ0EXqC+lrJyacNVXdWNLb48bzOZ/Z9+OqlhVPL0K12KAbujhFz5+P9GOQr2Csr
         z5eO1snDFa0GFYvPWZ9QTTFmeSoGt1llghWmKByK6QfLVFmZ6plUj5NorbpINKnza8Bh
         AH+1IUo7zvh6zAniflh7GGUxWhNMCKjYsKIXShGY2UMdUE29ilmJGvS1PsBP5iimqHVf
         NIGw==
X-Gm-Message-State: AFqh2koj7Qj0AJ4cmXGw3y8jgKsqYxXcDq+ga5PIvEU9OJ3aFKqcKv+F
        BhBPDHDQmHSYxUBlt8LF7AtzWceFvqE=
X-Google-Smtp-Source: AMrXdXv9K4v9hzMSYuAKQ/zJZat1GlLN6b7eEIcHe6NOl6EmnzFsD2eqMF7f6uqGqPXCBT/0V1UbUPII0C4=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:11:cf1b:2f7f:3ca1:6488])
 (user=avagin job=sendgmr) by 2002:a05:6a00:2490:b0:575:c993:d318 with SMTP id
 c16-20020a056a00249000b00575c993d318mr3017697pfv.78.1674603725657; Tue, 24
 Jan 2023 15:42:05 -0800 (PST)
Date:   Tue, 24 Jan 2023 15:41:52 -0800
In-Reply-To: <20230124234156.211569-1-avagin@google.com>
Mime-Version: 1.0
References: <20230124234156.211569-1-avagin@google.com>
X-Mailer: git-send-email 2.39.1.405.gd4c25cc71f-goog
Message-ID: <20230124234156.211569-3-avagin@google.com>
Subject: [PATCH 2/6] sched: add WF_CURRENT_CPU and externise ttwu
From:   Andrei Vagin <avagin@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Christian Brauner <brauner@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>, Andrei Vagin <avagin@gmail.com>,
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
Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 kernel/sched/core.c  |  3 +--
 kernel/sched/fair.c  |  4 ++++
 kernel/sched/sched.h | 13 ++++++++-----
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bb1ee6d7bdde..028c2840baa6 100644
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
2.39.1.405.gd4c25cc71f-goog

