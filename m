Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1231769777C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 08:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbjBOHjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 02:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbjBOHjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 02:39:39 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA8B30EB3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 23:39:38 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id ja21so11860975plb.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 23:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kgpwtrMIVhsk6XLRiPwQgdlO2IlMEQ8NQ+3sczObvmQ=;
        b=wlLueEwjUolZQYMfI7cIONFtinAjY8Xi1MheBNMKlbeGElNvtl3SDlEXvvRUr3TWNZ
         z257Cn1RIpGFxGJh9guowB9Q/5llhJeeMt/ZdO9Lc//3Tlcltdd3qR1dTf8AxCf3uAl5
         a04w1X+5DWgIQkD1nJC6yCPfegwVf5ocJjcMQ/kGUqXOtpOZ1cy0BOGAt80gfp7gOLHf
         DuSfs0WsQz+7QK1tbU1bsBdtxYsz3CFrc1fjhy+Y/6CqlBWnz+4izbU1JIor++uh7Ked
         LgqgbNtZXtREg9xUP6bY+pZxroiPp0CMn0Q6e8LFZt3ZmDWJVn0RlYLEEO6Rdnha78Qn
         xugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kgpwtrMIVhsk6XLRiPwQgdlO2IlMEQ8NQ+3sczObvmQ=;
        b=rgve9dcO1w62oJdL6CqqCU2+Cy6qVKpn02ihJSnXws31uUYZ9LPJflyEdGNpFuC44W
         7jicJvm0uxEEdE/j7t7OjiGEvLCgjfTf1JE/mi4aSGvMg7Tu4EIVHK0GfdAcllh3teCm
         YEWCtga6g3FImMAD5Hdn6gzhFmfrMgtnUFl8GDYW7InlFa9uo5fUBPRU6T+E+zdkA+6V
         +V4bgGljpxfYkHWghsahEuWU5NUIv5nuaSFOE5Y6YKoGXcUJk+dwC5AWtZTgiNvQFQn4
         ypw3/FFuu7VyIgG1cB1rHrHXfvYPzLZmhLqpsr+5H9RRNbxeAAs0XVrKWQUWT+8Y444X
         MEUA==
X-Gm-Message-State: AO0yUKV0LX555ChiwZfvb2HUCJ7tT0DqUn9BEWPXsiFNCve35zKMcSOu
        7PBa7c9NyPRWhSCOyHXi3iDRBw==
X-Google-Smtp-Source: AK7set81dFRxBCPjtdhW0HiHQUkwHGG0SOzl4lGugwrQt758srgSU2dTvnM0lRQv0p0O08abJv2DcA==
X-Received: by 2002:a17:903:27ce:b0:194:5c63:364c with SMTP id km14-20020a17090327ce00b001945c63364cmr1148929plb.62.1676446778169;
        Tue, 14 Feb 2023 23:39:38 -0800 (PST)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id x3-20020a1709027c0300b0019934030f46sm11443267pll.132.2023.02.14.23.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 23:39:37 -0800 (PST)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH v2] sched/core: Adapt WARN_DOUBLE_CLOCK machinery for core-sched
Date:   Wed, 15 Feb 2023 15:39:27 +0800
Message-Id: <20230215073927.97802-1-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
a core wide rq->lock, so at this point we can safely clear RQCF_UPDATED of
rq->clock_update_flags of all CPUs on this core to avoid the
WARN_DOUBLE_CLOCK warning.

We cannot clear rq->clock_update_flags of other cpus on the same core in
rq_pin_lock(). Because in some functions, we will temporarily give up
core wide rq->lock, and then use raw_spin_rq_lock() to obtain core wide
rq->lock, such as newidle_balance() and _double_lock_balance().

Steps to reproduce:
1. Enable CONFIG_SCHED_DEBUG and CONFIG_SCHED_CORE when compiling
   the kernel
2. echo 1 > /sys/kernel/debug/clear_warn_once
   echo "WARN_DOUBLE_CLOCK" > /sys/kernel/debug/sched/features
3. Run the linux/tools/testing/selftests/sched/cs_prctl_test test

Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
---
 - Adapt WARN_DOUBLE_CLOCK machinery for core-sched instead of clearing
   WARN_DOUBLE_CLOCK warning one by one.
 - Modify commit information
 [v1] https://lore.kernel.org/all/20221206070550.31763-1-jiahao.os@bytedance.com

 kernel/sched/core.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e838feb6adc5..16a33e5adb77 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -427,11 +427,27 @@ void sched_core_put(void)
 		schedule_work(&_work);
 }
 
+static inline void sched_core_rq_clock_clear_update(struct rq *rq)
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
+static inline void sched_core_rq_clock_clear_update(struct rq *rq) { }
 
 #endif /* CONFIG_SCHED_CORE */
 
@@ -546,6 +562,7 @@ void raw_spin_rq_lock_nested(struct rq *rq, int subclass)
 		if (likely(lock == __rq_lockp(rq))) {
 			/* preempt_count *MUST* be > 1 */
 			preempt_enable_no_resched();
+			sched_core_rq_clock_clear_update(rq);
 			return;
 		}
 		raw_spin_unlock(lock);
-- 
2.37.0 (Apple Git-136)

