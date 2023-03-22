Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672DF6C4F4E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjCVPUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjCVPU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:20:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9743B5BDBC;
        Wed, 22 Mar 2023 08:20:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F1FD1650;
        Wed, 22 Mar 2023 08:21:04 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.18.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B2F0A3F71E;
        Wed, 22 Mar 2023 08:20:17 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, delyank@fb.com, lukasz.luba@arm.com,
        qyousef@google.com
Subject: [PATCH 3/3] schedutil: trace: Add tracing to capture filter out requests
Date:   Wed, 22 Mar 2023 15:18:43 +0000
Message-Id: <20230322151843.14390-4-lukasz.luba@arm.com>
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

Some of the frequency update requests coming form the task scheduler
might be filter out. It can happen when the previous request was served
not that long ago (in a period smaller than provided by the cpufreq driver
as minimum for frequency update). In such case, we want to know if some of
the frequency updates cannot make through.
Export the new tracepoint as well. That would allow to handle it by a
toolkit for trace analyzes.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/trace/events/schedutil.h | 17 +++++++++++++++++
 kernel/sched/cpufreq_schedutil.c | 14 ++++++++++++--
 2 files changed, 29 insertions(+), 2 deletions(-)
 create mode 100644 include/trace/events/schedutil.h

diff --git a/include/trace/events/schedutil.h b/include/trace/events/schedutil.h
new file mode 100644
index 000000000000..7f25122f7257
--- /dev/null
+++ b/include/trace/events/schedutil.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM schedutil
+
+#if !defined(_TRACE_SCHEDUTIL_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_SCHEDUTIL_H
+
+#include <linux/tracepoint.h>
+
+DECLARE_TRACE(schedutil_update_filtered_tp,
+	TP_PROTO(int cpu),
+	TP_ARGS(cpu));
+
+#endif /* _TRACE_SCHEDUTIL_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index f462496e5c07..45c18559f3a8 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -6,6 +6,12 @@
  * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
  */
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/schedutil.h>
+#undef CREATE_TRACE_POINTS
+
+EXPORT_TRACEPOINT_SYMBOL_GPL(schedutil_update_filtered_tp);
+
 #define IOWAIT_BOOST_MIN	(SCHED_CAPACITY_SCALE / 8)
 
 struct sugov_tunables {
@@ -318,8 +324,10 @@ static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
 
 	ignore_dl_rate_limit(sg_cpu);
 
-	if (!sugov_should_update_freq(sg_cpu->sg_policy, time))
+	if (!sugov_should_update_freq(sg_cpu->sg_policy, time)) {
+		trace_schedutil_update_filtered_tp(sg_cpu->cpu);
 		return false;
+	}
 
 	sugov_get_util(sg_cpu);
 	sugov_iowait_apply(sg_cpu, time, max_cap);
@@ -446,8 +454,10 @@ sugov_update_shared(struct update_util_data *hook, u64 time, unsigned int flags)
 
 	ignore_dl_rate_limit(sg_cpu);
 
-	if (!sugov_should_update_freq(sg_policy, time))
+	if (!sugov_should_update_freq(sg_policy, time)) {
+		trace_schedutil_update_filtered_tp(sg_cpu->cpu);
 		goto unlock;
+	}
 
 	next_f = sugov_next_freq_shared(sg_cpu, time);
 
-- 
2.17.1

