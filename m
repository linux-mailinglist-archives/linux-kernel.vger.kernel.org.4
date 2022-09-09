Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0B55B42D4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 01:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbiIIXHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 19:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbiIIXGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 19:06:47 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52060113C64
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 16:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662764796; x=1694300796;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=JZ8MTmn71ayxLAHr9pYStQxp574jTryFFLcla/Pb/M4=;
  b=J7stwfII2tXCpHa9hQktQg7+1RCfCcQVobLOY6d6ytOluYH0ojx8W2de
   QzvmEQ1XeMMzQ8TFtDDv8n2yO+hDzXYNtrYtkAUh3f0Kb6vHvNeGS1qvl
   WSr1cdERKz3tAe2fT6nvIc69F1uTkZzuRnYLXxX2DNMM0NifkRghIlmAn
   gUorjmkHBVU/1ddd14eN+3oDXFjb+ymMQ4pJwpSWxf9EkNbpu+iPb+egE
   jU3sUfJOtxfjSJxQMqvi2MztERRB/pKcLjEZ4hc8Xnv8w/Ni0g/OhLWgk
   koaOX5T3sDffMm3F7ZFUlMsSjqAmmy/5SDEBSA8rezGUShMjesFT3Iq8h
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="323803592"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="323803592"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 16:06:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="677354981"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 09 Sep 2022 16:06:32 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: [RFC PATCH 05/23] sched/core: Move is_core_idle() out of fair.c
Date:   Fri,  9 Sep 2022 16:11:47 -0700
Message-Id: <20220909231205.14009-6-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Information about the idle state of the SMT siblings of a core can
be used to improve the accuracy of the classification of the current task.

Move is_core_idle() to sched.h to make it available to scheduler_tick().

Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim C. Chen <tim.c.chen@intel.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 kernel/sched/fair.c  | 17 -----------------
 kernel/sched/sched.h | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0089b33ea7b8..2f2a6bb5990d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1536,23 +1536,6 @@ struct numa_stats {
 	int idle_cpu;
 };
 
-static inline bool is_core_idle(int cpu)
-{
-#ifdef CONFIG_SCHED_SMT
-	int sibling;
-
-	for_each_cpu(sibling, cpu_smt_mask(cpu)) {
-		if (cpu == sibling)
-			continue;
-
-		if (!idle_cpu(sibling))
-			return false;
-	}
-#endif
-
-	return true;
-}
-
 struct task_numa_env {
 	struct task_struct *p;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 719bdba660e2..2bddedc55ee9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3212,6 +3212,23 @@ static inline bool is_per_cpu_kthread(struct task_struct *p)
 }
 #endif
 
+static inline bool is_core_idle(int cpu)
+{
+#ifdef CONFIG_SCHED_SMT
+	int sibling;
+
+	for_each_cpu(sibling, cpu_smt_mask(cpu)) {
+		if (cpu == sibling)
+			continue;
+
+		if (!idle_cpu(sibling))
+			return false;
+	}
+#endif
+
+	return true;
+}
+
 extern void swake_up_all_locked(struct swait_queue_head *q);
 extern void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wait);
 
-- 
2.25.1

