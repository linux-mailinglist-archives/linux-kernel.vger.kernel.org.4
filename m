Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5795F6D8FAD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 08:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbjDFGo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 02:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235582AbjDFGoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 02:44:54 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B8E9010
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 23:44:26 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id o2so36684419plg.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 23:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680763466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SSjUHXD/LhQIUTlrHWLn8aPqnhEOO0fsMY11nZErJaU=;
        b=Eg7Yqnn4G9oMXexxUoM/skvv1nV3exncgdctUmXMUhrI98ZIk16yls+gARhO8JvqkA
         ZSAmHo05g48CW/7rTVKO792cIZUUUOfO7Q9A4lUU3lvUthG07h357LhZ/eIA0IphcBRz
         OzNxB5ZGNaYHVw4I5IdOSDQ6fVn1c8k9kOJFKuC0EjayXBcFhFBIq3G1oW6hpKgsvJWj
         Sy9SAXr3AoBlO0KeWNgeg09b4E038fLpbQZvOYz5qRewqLb42gDIC2Bw7Y/jcoeBMFyN
         c3XSQhqDl1qOdnfndb6R/k/mH5H+cRTBZ3bx7bLG+uXcbCmOW173w+QOg6/V8BFRW317
         rf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680763466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SSjUHXD/LhQIUTlrHWLn8aPqnhEOO0fsMY11nZErJaU=;
        b=42VEe6ysllf7gX439o5Eej8Y9aU1rK9qCzSuZO8WWmRnEx/TMI/z0tngxYfT9wgRSQ
         kWsnSuXspL4vOkmJcSMF96BNT8dulVz18xFTVCDDPOdCOjMlkmtFjW5OzJjpVT1/CABN
         64/jfuUpVr30/zDbtY/D9sgYOwvyMwToqwNO+nI4jvtGFwI8KwGJ8ktinNi8O5bLnENd
         67PhK2t6RQLiUAWjMfJTI/6X6+ZtfXwpq5MPxYqBXwlYouYIJheSU1lh0cBoT08jH3Yb
         jTegTXoYcaMddIiqHM1WAHCqRFZTW+xB9+pVk6WhkF6necjonWki307bnHLylUXZSz5Q
         fkag==
X-Gm-Message-State: AAQBX9drUUwfKtsnEbxd7ZrwbA9P7kUZdhYwjMrqn8NL1xg08QtJV5M5
        18Sr6YEXBE74NwAX971TltjLiA==
X-Google-Smtp-Source: AKy350ZNSIKVSomOilm8SpcpzLPoBU9cBCbEIa9c2inY+bAqNAYv7vv+BPyMs8GrRvuYUO6lgRT8iw==
X-Received: by 2002:a17:90b:3ec4:b0:237:5a3c:e86c with SMTP id rm4-20020a17090b3ec400b002375a3ce86cmr10170522pjb.24.1680763466351;
        Wed, 05 Apr 2023 23:44:26 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id p13-20020a17090a348d00b002348d711ebbsm496882pjb.16.2023.04.05.23.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 23:44:25 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>,
        Phil Auld <pauld@redhat.com>
Subject: [PATCH v4] sched/core: Adapt WARN_DOUBLE_CLOCK machinery for core-sched
Date:   Thu,  6 Apr 2023 14:44:15 +0800
Message-Id: <20230406064415.17110-1-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When sched_core_enabled(), we sometimes need to call update_rq_clock()
to update the rq clock of sibling CPUs on the same core, before that we
need to clear RQCF_UPDATED of rq->clock_update_flags to avoid the
WARN_DOUBLE_CLOCK warning. Because at this time the rq->clock_update_flags
of sibling CPUs may be RQCF_UPDATED. If sched_core_enabled(), we will get
a core-wide rq->lock, so at this point we can safely clear RQCF_UPDATED of
rq->clock_update_flags of all CPUs on this core to avoid the
WARN_DOUBLE_CLOCK warning.

We sometimes use rq_pin_lock() and raw_spin_rq_lock() separately,
For example newidle_balance() and _double_lock_balance(). We will
temporarily give up core-wide rq->lock, and then use raw_spin_rq_lock()
to reacquire core-wide rq->lock without rq_pin_lock(), so We can not
clear RQCF_UPDATED of rq->clock_update_flags of other cpus on the
same core in rq_pin_lock().

Steps to reproduce:
1. Enable CONFIG_SCHED_DEBUG and CONFIG_SCHED_CORE when compiling
   the kernel
2. echo 1 > /sys/kernel/debug/clear_warn_once
   echo "WARN_DOUBLE_CLOCK" > /sys/kernel/debug/sched/features
3. Run the linux/tools/testing/selftests/sched/cs_prctl_test test

Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
Reviewed-by: Phil Auld <pauld@redhat.com>
---
v3->v4:
 - Replace "core wide" with "core-wide" everywhere.
 - Add "Reviewed-by: Phil Auld <pauld@redhat.com>".
 [v3] https://lore.kernel.org/all/20230330035827.16937-1-jiahao.os@bytedance.com

v2->v3:
 - Modify the function name to sched_core_clear_rqcf_updated,
   and add function comments.
 - Modify commit information.
 [v2] https://lore.kernel.org/all/20230215073927.97802-1-jiahao.os@bytedance.com

v1->v2:
 - Adapt WARN_DOUBLE_CLOCK machinery for core-sched instead of clearing
   WARN_DOUBLE_CLOCK warning one by one.
 - Modify commit information
 [v1] https://lore.kernel.org/all/20221206070550.31763-1-jiahao.os@bytedance.com

 kernel/sched/core.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0d18c3969f90..c6e2c79152ef 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -429,11 +429,32 @@ void sched_core_put(void)
 		schedule_work(&_work);
 }
 
+/*
+ * Now, we have obtained a core-wide rq->lock, then we need to clear
+ * RQCF_UPDATED of rq->clock_update_flags of the sibiling CPU
+ * on this core to avoid the WARN_DOUBLE_CLOCK warning.
+ */
+static inline void sched_core_clear_rqcf_updated(struct rq *rq)
+{
+#ifdef CONFIG_SCHED_DEBUG
+	const struct cpumask *smt_mask;
+	int i;
+
+	if (rq->core_enabled) {
+		smt_mask = cpu_smt_mask(rq->cpu);
+		for_each_cpu(i, smt_mask) {
+			if (rq->cpu != i)
+				cpu_rq(i)->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
+		}
+	}
+#endif
+}
 #else /* !CONFIG_SCHED_CORE */
 
 static inline void sched_core_enqueue(struct rq *rq, struct task_struct *p) { }
 static inline void
 sched_core_dequeue(struct rq *rq, struct task_struct *p, int flags) { }
+static inline void sched_core_clear_rqcf_updated(struct rq *rq) { }
 
 #endif /* CONFIG_SCHED_CORE */
 
@@ -548,6 +569,7 @@ void raw_spin_rq_lock_nested(struct rq *rq, int subclass)
 		if (likely(lock == __rq_lockp(rq))) {
 			/* preempt_count *MUST* be > 1 */
 			preempt_enable_no_resched();
+			sched_core_clear_rqcf_updated(rq);
 			return;
 		}
 		raw_spin_unlock(lock);
-- 
2.37.0

