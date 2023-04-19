Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8306E7EE4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 17:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbjDSPva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 11:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbjDSPvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 11:51:14 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B222A5C7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 08:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1681919416;
        bh=jG8tTXCR9Ya7nvQsevu7MKGN0o0nozXlruFMc2npb60=;
        h=From:To:Cc:Subject:Date:From;
        b=Pq5aqMHUlJGsJNwFBbACVYp9o9kotaGSVMKFvl8XHfLnB9+xGaKX3KSGvwx3rkVxO
         5NNUSIKV/wIWT5rRHj4geZcLyqRz+3pEpQ4g1EnD+pGoXXKKMxua2Y5SrwM0Ha6DMA
         dceLciZLbMEknVEMvi7oMTZaojytidaRNu/xXNcCp3ovqwdCRgary2icIgavb1mhtc
         TXIFimY6O0CSjEAdrHZc4TO35r3yVKEiq4xidUxovkYEG1S+1tfxJthA4ms1RrUPJS
         +3/nckw1LdyC5BV+CdCyT85yLssAPwj3wGsjbuli1IQZ3XpDGmTBU2O9h1C745/g0A
         kD+doFhpKAVvQ==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Q1lc81g12zwF9;
        Wed, 19 Apr 2023 11:50:16 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Aaron Lu <aaron.lu@intel.com>
Subject: [RFC PATCH v9 1/2] sched: Fix: Handle target_cpu offlining in active_load_balance_cpu_stop
Date:   Wed, 19 Apr 2023 11:50:11 -0400
Message-Id: <20230419155012.63901-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle scenario where the target cpu is going offline concurrently with
execution of active_load_balance_cpu_stop, which can cause
__sched_core_flip to flip rq->core_enabled without rq lock held, which
can trigger lockdep_assert_rq_held() warnings.

This scenario possibly has other unwanted effects such as migrating
tasks to offline cpus, which may prevent their execution for a long
time until the cpu is brought back online.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Aaron Lu <aaron.lu@intel.com>
---
 kernel/sched/fair.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5f6587d94c1d..1c837ba41704 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8744,6 +8744,27 @@ static void attach_one_task(struct rq *rq, struct task_struct *p)
 	rq_unlock(rq, &rf);
 }
 
+/*
+ * try_attach_one_task() -- attaches the task returned from detach_one_task() to
+ * its new rq if the rq is online. Returns false if the rq is not online.
+ */
+static bool try_attach_one_task(struct rq *rq, struct task_struct *p)
+{
+	struct rq_flags rf;
+	bool result = true;
+
+	rq_lock(rq, &rf);
+	if (!rq->online) {
+		result = false;
+		goto unlock;
+	}
+	update_rq_clock(rq);
+	attach_task(rq, p);
+unlock:
+	rq_unlock(rq, &rf);
+	return result;
+}
+
 /*
  * attach_tasks() -- attaches all tasks detached by detach_tasks() to their
  * new rq.
@@ -11048,8 +11069,17 @@ static int active_load_balance_cpu_stop(void *data)
 	busiest_rq->active_balance = 0;
 	rq_unlock(busiest_rq, &rf);
 
-	if (p)
-		attach_one_task(target_rq, p);
+	if (p) {
+		if (!try_attach_one_task(target_rq, p)) {
+			/*
+			 * target_rq was offlined concurrently. There is no
+			 * guarantee that the busiest cpu is still online at
+			 * this point. Fallback on using the CPU on which the
+			 * stopper thread is running as target.
+			 */
+			attach_one_task(this_rq(), p);
+		}
+	}
 
 	local_irq_enable();
 
-- 
2.25.1

