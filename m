Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3EE272DC3B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239048AbjFMIVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240763AbjFMIVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:21:10 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E85410D4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:20:44 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b038064d97so30272125ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 01:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686644443; x=1689236443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NdXaw5dg9b8aDwiY+1vzb/StC7BleYDvDIrkoD6JVyU=;
        b=MwkwZQfZhXuFpRyxfGK+yeua8xcpXoyMLDreZ9ju9u4T4rKv9hAAAGJ9CM0/uozmT9
         hejd5YQc39tI88ViqQaOMkmyQZh2trhkk6+sB35OQrVp8AmBNpUKzusQV/LEidc4diNv
         tIhW57975r3oigYlMcK2P6ANTbyTzQxkyg8yvE2HsPTp9aR9qpdcZunuA+NMW6VQLFFj
         DFSD6jbfdzNWQGJ+zZzq0M6oaXsGepHQ9KQcy5/s/QYo/+OsCPvPN1MAobKgtMcM6/3C
         TnglD35JjWL1zoJQWEAZuRZhLQ1XSrV13q6qBtICqUjHOfXioIFDMUaq4k/P5KefQd/B
         6+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686644443; x=1689236443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NdXaw5dg9b8aDwiY+1vzb/StC7BleYDvDIrkoD6JVyU=;
        b=LwFa6NI7XbGh3wddC6UUHKsNZnwkaUOtSxhNuFN17QJhAdbGkTE5ynBDa0S8jrNnkJ
         VtPnrhZvKKk2ro53sIh2VFB76Eo8T7qo2RulcYhdSdVYJ3o9Jch9rFGlqXu5ITgHh7G+
         aW3XWEC6JODaWnSehI8Enh91rOMN26Xc/h/YsMpsMn96OHvU0Al12aC8LPF0ZM4JgIvu
         YN3MI7eIT5W4+PvDx4f85narNclI7suVq4OPf3C4VnKviTh48LQLMehVzELr4OCkwKm+
         BMT5w6KwyrCU5Ie6cl6rI38oXbBc6cCOWObpAPw54jS61RxfjeN0T9y46TcYZYwVcuaj
         cc9A==
X-Gm-Message-State: AC+VfDw1ifdbvqhmxANJ3AtD/EkjC4KcRxopMJrUY0r3/wMWG+mfOaCL
        YF7+OQA33lJLhKzbNvjE0Vq9Rw==
X-Google-Smtp-Source: ACHHUZ6jh1nPw6RXaAJQ5CYCdoB/yebKE51Je9nfgqU4wp2Nsj4Qfe6zgARXc/p8RBgiSsYrI2o7OA==
X-Received: by 2002:a17:902:c205:b0:1b0:ec0:7cff with SMTP id 5-20020a170902c20500b001b00ec07cffmr8660630pll.10.1686644443668;
        Tue, 13 Jun 2023 01:20:43 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902c1c500b001b027221393sm9567834plc.43.2023.06.13.01.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 01:20:43 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH v5 3/4] sched/core: Avoid multiple calling update_rq_clock() in __cfsb_csd_unthrottle()
Date:   Tue, 13 Jun 2023 16:20:11 +0800
Message-Id: <20230613082012.49615-4-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230613082012.49615-1-jiahao.os@bytedance.com>
References: <20230613082012.49615-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 8ad075c2eb1f ("sched: Async unthrottling for cfs
bandwidth"), we may update the rq clock multiple times in the loop of
__cfsb_csd_unthrottle(). At that time the following warning will be
triggered.
------------[ cut here ]------------
rq->clock_update_flags & RQCF_UPDATED
WARNING: CPU: 54 PID: 0 at kernel/sched/core.c:741
update_rq_clock+0xaf/0x180
Call Trace:
 <TASK>
 unthrottle_cfs_rq+0x4b/0x300
 __cfsb_csd_unthrottle+0xe0/0x100
 __flush_smp_call_function_queue+0xaf/0x1d0
 flush_smp_call_function_queue+0x49/0x90
 do_idle+0x17c/0x270
 cpu_startup_entry+0x19/0x20
 start_secondary+0xfa/0x120
 secondary_startup_64_no_verify+0xce/0xdb

Before the loop starts, we update the rq clock once and call
rq_clock_start_loop_update() to prevent updating the rq clock
multiple times. And call rq_clock_stop_loop_update() After
the loop to clear rq->clock_update_flags.

Fixes: 8ad075c2eb1f ("sched: Async unthrottling for cfs bandwidth")

Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c  |  9 +++++++++
 kernel/sched/sched.h | 21 +++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 373ff5f55884..af9604f4b135 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5576,6 +5576,14 @@ static void __cfsb_csd_unthrottle(void *arg)
 
 	rq_lock(rq, &rf);
 
+	/*
+	 * Iterating over the list can trigger several call to
+	 * update_rq_clock() in unthrottle_cfs_rq().
+	 * Do it once and skip the potential next ones.
+	 */
+	update_rq_clock(rq);
+	rq_clock_start_loop_update(rq);
+
 	/*
 	 * Since we hold rq lock we're safe from concurrent manipulation of
 	 * the CSD list. However, this RCU critical section annotates the
@@ -5595,6 +5603,7 @@ static void __cfsb_csd_unthrottle(void *arg)
 
 	rcu_read_unlock();
 
+	rq_clock_stop_loop_update(rq);
 	rq_unlock(rq, &rf);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ec7b3e0a2b20..50446e401b9f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1546,6 +1546,27 @@ static inline void rq_clock_cancel_skipupdate(struct rq *rq)
 	rq->clock_update_flags &= ~RQCF_REQ_SKIP;
 }
 
+/*
+ * During cpu offlining and rq wide unthrottling, we can trigger
+ * an update_rq_clock() for several cfs and rt runqueues (Typically
+ * when using list_for_each_entry_*)
+ * rq_clock_start_loop_update() can be called after updating the clock
+ * once and before iterating over the list to prevent multiple update.
+ * After the iterative traversal, we need to call rq_clock_stop_loop_update()
+ * to clear RQCF_ACT_SKIP of rq->clock_update_flags.
+ */
+static inline void rq_clock_start_loop_update(struct rq *rq)
+{
+	lockdep_assert_rq_held(rq);
+	rq->clock_update_flags |= RQCF_ACT_SKIP;
+}
+
+static inline void rq_clock_stop_loop_update(struct rq *rq)
+{
+	lockdep_assert_rq_held(rq);
+	rq->clock_update_flags &= ~RQCF_ACT_SKIP;
+}
+
 struct rq_flags {
 	unsigned long flags;
 	struct pin_cookie cookie;
-- 
2.20.1

