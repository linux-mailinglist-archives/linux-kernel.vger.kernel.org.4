Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518AD6054B2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 03:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiJTBLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 21:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiJTBLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 21:11:04 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534801645F9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 18:11:03 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 204so18834965pfx.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 18:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NSOyseBFnL3nwsXsl+tqfsopwFipdmUNqJP3ooKECg=;
        b=E9Oa32keD+q4jeVumDMAg41KTc4XBw8kCovcEgAwRbI6e2hr/jPOoUNhMAsOBk0ioI
         09YwP40DDIeO/2fFJ9e3ENAdOuYPo3Z3ehexjpoNyhntwp8bnjeZQ8rGAYA4Wzc3+ceR
         60FBoamG5nr24SMb/49lFPTSy+riRMpt+A3uA7AiURI3pgGv/6yvL4YUU9K8/fGndHby
         T+1FIiviiFWZVNNE61IjHStUuoh20XoSmZFnX1IITkpV3Eo14RNdMY/FGUrqVMKlSWXq
         BaYrE5XkB+PY0yewZeZmm51CpzIfcMERDTqc52+dhBTk1BAJsaSJBa0GzanRacGbxeYl
         fdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4NSOyseBFnL3nwsXsl+tqfsopwFipdmUNqJP3ooKECg=;
        b=vQZDuPJHojAw8omEz3vdacbuG4xH0LhHrWfiC3f/SvS4GDmKSWM/phhWRdasUe4w02
         J7Wpq1qvt5CEmorJJp7oZpqikg1tiOaGm5frqknR/9RMr8OHbtZnWhDtqDvsIQseJoaw
         b35pl3adG72DS6sImw5LZsrvao86S+gYp0Q00iF7rfDYEkwyn4PPr2Yem/bzbZiTZvBo
         ez0n5v1qcVEwmF+Mt4XRXHlvfESbSmUR7SqzxGSi1n6pfGL7GWEKL57vB9y9RjpG4cVC
         cp1qeda6mWs3IJE6SFGqnnEvpPrZ6UFYw08M/mU2oWriWYHo8+c+Y3hUTNVY+EnrXaR1
         plWg==
X-Gm-Message-State: ACrzQf1Oz9oTY7IegztHyI8YQZkDX6WZLd8n7H/TzEfZEyA6vlFycm21
        HNvxvwJjvom2TmXetid3hST/FOy3Q682gw==
X-Google-Smtp-Source: AMsMyM7LGbdYHU3LBBsneZkJEr/+juWcmiIvZCQiTr4j4HeKksJAm4bnpd1eQtF19wUWwLNpBDz/9g==
X-Received: by 2002:a63:4904:0:b0:439:e6a4:a3b5 with SMTP id w4-20020a634904000000b00439e6a4a3b5mr9269287pga.182.1666228262156;
        Wed, 19 Oct 2022 18:11:02 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id b14-20020a170902650e00b00174fa8cbf31sm11242938plk.303.2022.10.19.18.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 18:11:01 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Christian Brauner <brauner@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 2/5] sched: add WF_CURRENT_CPU and externise ttwu
Date:   Wed, 19 Oct 2022 18:10:45 -0700
Message-Id: <20221020011048.156415-3-avagin@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221020011048.156415-1-avagin@gmail.com>
References: <20221020011048.156415-1-avagin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
index 5800b0623ff3..cffa8f314c9a 100644
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
index 1644242ecd11..ee24141c4942 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2071,12 +2071,13 @@ static inline int task_on_rq_migrating(struct task_struct *p)
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
@@ -3161,6 +3162,8 @@ static inline bool is_per_cpu_kthread(struct task_struct *p)
 extern void swake_up_all_locked(struct swait_queue_head *q);
 extern void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
 
+extern int try_to_wake_up(struct task_struct *tsk, unsigned int state, int wake_flags);
+
 #ifdef CONFIG_PREEMPT_DYNAMIC
 extern int preempt_dynamic_mode;
 extern int sched_dynamic_mode(const char *str);
-- 
2.37.2

