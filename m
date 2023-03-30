Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BD66CF9DE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 05:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjC3D7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 23:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjC3D7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 23:59:05 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E9110A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 20:58:38 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso18298271pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 20:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680148718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IsCNrdmOSaMn5Q4rPaxg2eUpKX5ES9QoZK9D01T3Q20=;
        b=AmvSNXfmNmLN2MxsvYHwgDc8AGXjweIoxZpGack1naBbC2IJHL9M6r0ymuI3qRKX8B
         GgexxL3G9DIlO9JTJHISezOF5zfvvfxmotMaBjgkcxsPV5iZPgpN5m4M8oIwzpGc2Gua
         qz40JP95nnDUUDwDCh1usgNUyNmoLQzurIV7ir7QPXPX7iOUz0YlBuk6MwhKF3Xn0vAq
         RG15OCD3gslV7JXjMEFm4ZqDvFPNcuriGCYpDGS49a1I+/6X8hErslJ0CtooVjPqz9s9
         ndkd+MXvu/gGOFYDuyG2iU+LIROvi2dBeZ5Y/SeEpHDRxqOkMhPz2Q87tSSm/y5S0bAQ
         HfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680148718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IsCNrdmOSaMn5Q4rPaxg2eUpKX5ES9QoZK9D01T3Q20=;
        b=MYuv2qDiX84wwDc8QNxgUIwJWdJwUFbxyCmmlbyLH6xFG9YRYv3ZKzJzi0umBxd8UN
         CJ9dGNgWY0yMhdvj2Z73CMiKlqXRjhbf1I+rylWZmahj/s46/GLLKZlbYEgrH6e/RSfU
         K/BTOs1gTxpfO4ltfGMRCRe7JBrkyuIuh1UOoG2Ds2SojA3ls7EMs5u3hRbmfjT+0UGE
         7VjGjr3hmIfHerrIiiL7pHDpVeCL1Rk3Ol9OD8wfl5FVEipMmpK7WIHRJbJp9XGrgGxD
         j/ezrJMm6HwOIVCc3HlwtnWWGqEfIvrbZyjIgJVDIWEJ78sEOvh5ZQ/km30HPRke/A1k
         c5nQ==
X-Gm-Message-State: AAQBX9cptWizcrLgbL7tM1cL/TGUID1BWI1E9h6atTXyaAJf937ABBFP
        J6NlSWNt4AXDw/v9Jegzu8BPwg==
X-Google-Smtp-Source: AKy350Z+bIWSawbGWf/TmeHkJ3fYkdOyynP+SIU3zU0iqzsBYZYKRTen0TqTOzu3ur3zoT6PEUxcQA==
X-Received: by 2002:a17:903:2441:b0:1a2:7462:d674 with SMTP id l1-20020a170903244100b001a27462d674mr4000820pls.24.1680148718234;
        Wed, 29 Mar 2023 20:58:38 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id x90-20020a17090a38e300b002348d711ebbsm551040pjb.16.2023.03.29.20.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 20:58:37 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH v3] sched/core: Adapt WARN_DOUBLE_CLOCK machinery for core-sched
Date:   Thu, 30 Mar 2023 11:58:27 +0800
Message-Id: <20230330035827.16937-1-jiahao.os@bytedance.com>
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
a core wide rq->lock, so at this point we can safely clear RQCF_UPDATED of
rq->clock_update_flags of all CPUs on this core to avoid the
WARN_DOUBLE_CLOCK warning.

We sometimes use rq_pin_lock() and raw_spin_rq_lock() separately,
For example newidle_balance() and _double_lock_balance(). We will
temporarily give up core wide rq->lock, and then use raw_spin_rq_lock()
to reacquire core wide rq->lock without rq_pin_lock(), so We can not
clear RQCF_UPDATED of rq->clock_update_flags of other cpus on the
same core in rq_pin_lock().

Steps to reproduce:
1. Enable CONFIG_SCHED_DEBUG and CONFIG_SCHED_CORE when compiling
   the kernel
2. echo 1 > /sys/kernel/debug/clear_warn_once
   echo "WARN_DOUBLE_CLOCK" > /sys/kernel/debug/sched/features
3. Run the linux/tools/testing/selftests/sched/cs_prctl_test test

Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
---
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
index 0d18c3969f90..5e06da2f07cb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -429,11 +429,32 @@ void sched_core_put(void)
 		schedule_work(&_work);
 }
 
+/*
+ * Now, we have obtained a core wide rq->lock, then we need to clear
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

