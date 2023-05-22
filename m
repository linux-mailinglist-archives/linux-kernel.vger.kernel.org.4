Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1017A70C198
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 16:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbjEVO5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 10:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbjEVO5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 10:57:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15FD1C4;
        Mon, 22 May 2023 07:57:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C62181480;
        Mon, 22 May 2023 07:57:58 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.22.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 942F33F6C4;
        Mon, 22 May 2023 07:57:10 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        rafael@kernel.org, linux-pm@vger.kernel.org
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, delyank@fb.com, lukasz.luba@arm.com,
        qyousef@google.com, qyousef@layalina.io
Subject: [RESEND][PATCH v2 1/3] sched/tp: Add new tracepoint to track uclamp set from user-space
Date:   Mon, 22 May 2023 15:57:00 +0100
Message-Id: <20230522145702.2419654-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230522145702.2419654-1-lukasz.luba@arm.com>
References: <20230522145702.2419654-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 944c3ae39861..7b9b800ebb6c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -114,6 +114,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_se_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
+EXPORT_TRACEPOINT_SYMBOL_GPL(uclamp_update_tsk_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 
@@ -1956,12 +1957,16 @@ static void __setscheduler_uclamp(struct task_struct *p,
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
2.25.1

