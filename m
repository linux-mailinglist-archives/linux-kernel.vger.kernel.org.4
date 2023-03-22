Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A62C6C4F4C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjCVPUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjCVPUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:20:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA838591E0;
        Wed, 22 Mar 2023 08:20:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 755B4AD7;
        Wed, 22 Mar 2023 08:20:58 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.18.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C8DC73F71E;
        Wed, 22 Mar 2023 08:20:11 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, delyank@fb.com, lukasz.luba@arm.com,
        qyousef@google.com
Subject: [PATCH 1/3] sched/tp: Add new tracepoint to track uclamp set from user-space
Date:   Wed, 22 Mar 2023 15:18:41 +0000
Message-Id: <20230322151843.14390-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230322151843.14390-1-lukasz.luba@arm.com>
References: <20230322151843.14390-1-lukasz.luba@arm.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The user-space can set uclamp value for a given task. It impacts task
placement decisions made by the scheduler. This is very useful information
and helps to understand the system behavior or track improvements in
middleware and applications which start using uclamp mechanisms and report
better performance in tests.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/trace/events/sched.h | 4 ++++
 kernel/sched/core.c          | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index fbb99a61f714..dbfb30809f15 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -735,6 +735,10 @@ DECLARE_TRACE(sched_update_nr_running_tp,
 	TP_PROTO(struct rq *rq, int change),
 	TP_ARGS(rq, change));
 
+DECLARE_TRACE(uclamp_update_tsk_tp,
+	TP_PROTO(struct task_struct *tsk, int uclamp_id,  unsigned int value),
+	TP_ARGS(tsk, uclamp_id, value));
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 488655f2319f..882c92e3ccf0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -110,6 +110,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_se_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(uclamp_update_tsk_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 
@@ -1936,12 +1937,16 @@ static void __setscheduler_uclamp(struct task_struct *p,
 	    attr->sched_util_min != -1) {
 		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
 			      attr->sched_util_min, true);
+		trace_uclamp_update_tsk_tp(p, UCLAMP_MIN,
+					   attr->sched_util_min);
 	}
 
 	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX &&
 	    attr->sched_util_max != -1) {
 		uclamp_se_set(&p->uclamp_req[UCLAMP_MAX],
 			      attr->sched_util_max, true);
+		trace_uclamp_update_tsk_tp(p, UCLAMP_MAX,
+					   attr->sched_util_max);
 	}
 }
 
-- 
2.17.1

