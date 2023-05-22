Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7911C70C19D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 16:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbjEVO5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 10:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234090AbjEVO52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 10:57:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FD9D18D;
        Mon, 22 May 2023 07:57:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0055D150C;
        Mon, 22 May 2023 07:58:06 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.22.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9E0E73F6C4;
        Mon, 22 May 2023 07:57:17 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        rafael@kernel.org, linux-pm@vger.kernel.org
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, delyank@fb.com, lukasz.luba@arm.com,
        qyousef@google.com, qyousef@layalina.io,
        kernel test robot <lkp@intel.com>
Subject: [RESEND][PATCH v2 3/3] schedutil: trace: Add tracing to capture filter out requests
Date:   Mon, 22 May 2023 15:57:02 +0100
Message-Id: <20230522145702.2419654-4-lukasz.luba@arm.com>
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

Some of the frequency update requests coming form the task scheduler
might be filter out. It can happen when the previous request was served
not that long ago (in a period smaller than provided by the cpufreq driver
as minimum for frequency update). In such case, we want to know if some of
the frequency updates cannot make through.
Export the new tracepoint as well. That would allow to handle it by a
toolkit for trace analyzes.

Reported-by: kernel test robot <lkp@intel.com> # solved tricky build
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/trace/events/sched.h     |  4 ++++
 kernel/sched/cpufreq_schedutil.c | 10 ++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index dbfb30809f15..e34b7cd5de73 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -739,6 +739,10 @@ DECLARE_TRACE(uclamp_update_tsk_tp,
 	TP_PROTO(struct task_struct *tsk, int uclamp_id,  unsigned int value),
 	TP_ARGS(tsk, uclamp_id, value));
 
+DECLARE_TRACE(schedutil_update_filtered_tp,
+	TP_PROTO(int cpu),
+	TP_ARGS(cpu));
+
 #endif /* _TRACE_SCHED_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index f462496e5c07..4f9daf258a65 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -6,6 +6,8 @@
  * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
  */
 
+EXPORT_TRACEPOINT_SYMBOL_GPL(schedutil_update_filtered_tp);
+
 #define IOWAIT_BOOST_MIN	(SCHED_CAPACITY_SCALE / 8)
 
 struct sugov_tunables {
@@ -318,8 +320,10 @@ static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
 
 	ignore_dl_rate_limit(sg_cpu);
 
-	if (!sugov_should_update_freq(sg_cpu->sg_policy, time))
+	if (!sugov_should_update_freq(sg_cpu->sg_policy, time)) {
+		trace_schedutil_update_filtered_tp(sg_cpu->cpu);
 		return false;
+	}
 
 	sugov_get_util(sg_cpu);
 	sugov_iowait_apply(sg_cpu, time, max_cap);
@@ -446,8 +450,10 @@ sugov_update_shared(struct update_util_data *hook, u64 time, unsigned int flags)
 
 	ignore_dl_rate_limit(sg_cpu);
 
-	if (!sugov_should_update_freq(sg_policy, time))
+	if (!sugov_should_update_freq(sg_policy, time)) {
+		trace_schedutil_update_filtered_tp(sg_cpu->cpu);
 		goto unlock;
+	}
 
 	next_f = sugov_next_freq_shared(sg_cpu, time);
 
-- 
2.25.1

