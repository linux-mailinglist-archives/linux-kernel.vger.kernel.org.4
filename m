Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2388D5B42DD
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 01:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbiIIXHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 19:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbiIIXGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 19:06:48 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A8F11539C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 16:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662764797; x=1694300797;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=FngWibDxWuNRD0bCoS0y56HBAfprRaj7NTHoZSBGecI=;
  b=MsYuO/2Crkx/lyyPypYPGY6TLcZ425bnOEn0BpCgjZ+aODUMkcN5SX4+
   6P9gzB2PYiQGTykzU9+Etjq16lHL0RZSVIyrM889jHZztt+Vx9Egjs3XX
   E7HsE2nOItc7+EdIfBXNcYNfLoFFOGQegAh3hUmy1JkQnnMh6gAn0DYSB
   oEbU6zgKLH1TWtF+p/c3P3iThp8l8OD1ysZELThHrJgYahBwGTlU4gP8E
   QvolcJhp3y00GLWWlHIOYkK/aStC9uW7UJS0aEZKMX7J5zmNpEPxCGKru
   c84C3HFXtboam4HzptLwOoOSt8X+iOYbcHbxGQLtCsyIoQZ5q4af/TLeL
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="323803588"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="323803588"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 16:06:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="677354971"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 09 Sep 2022 16:06:31 -0700
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
Subject: [RFC PATCH 02/23] sched: Add interfaces for classes of tasks
Date:   Fri,  9 Sep 2022 16:11:44 -0700
Message-Id: <20220909231205.14009-3-ricardo.neri-calderon@linux.intel.com>
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

Add the interfaces that architectures shall implement to convey needed data
to support classes of tasks.

arch_update_task_class() updates the classification of the current task as
given by dedicated hardware resources.

arch_get_task_class_score() provides a performance score for a given class
of task when placed on a specific CPU relative to other CPUs. Higher scores
indicate higher performance.

The number of classes and the score of each class of task is determined
by hardware.

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
 kernel/sched/sched.h    | 64 +++++++++++++++++++++++++++++++++++++++++
 kernel/sched/topology.c |  8 ++++++
 2 files changed, 72 insertions(+)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e26688d387ae..719bdba660e2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2510,6 +2510,70 @@ void arch_scale_freq_tick(void)
 }
 #endif
 
+#ifdef CONFIG_SCHED_TASK_CLASSES
+DECLARE_STATIC_KEY_FALSE(sched_task_classes);
+
+static inline bool sched_task_classes_enabled(void)
+{
+	return static_branch_unlikely(&sched_task_classes);
+}
+
+#ifndef arch_has_task_classes
+/**
+ * arch_has_task_classes() - Check whether hardware supports classes of tasks
+ *
+ * Returns: true of classes of tasks are supported.
+ */
+static __always_inline
+bool arch_has_task_classes(void)
+{
+	return false;
+}
+#endif
+
+#ifndef arch_update_task_class
+/**
+ * arch_update_task_class() - Update the classification of the current task
+ * @curr:		The current task
+ * @smt_siblings_idle:	True if all of the SMT siblings of the CPU of @curr
+ *			are idle.
+ *
+ * Request that the classification of @curr is updated. On certain CPUs, the
+ * classification is only reliable if all of the SMT siblings of the CPU of
+ * @curr are idle.
+ *
+ * Returns: none
+ */
+static __always_inline
+void arch_update_task_class(struct task_struct *curr, bool smt_siblings_idle)
+{
+}
+#endif
+
+#ifndef arch_get_task_class_score
+/**
+ * arch_get_task_class_score() - Get the priority of a class
+ * @class:	A classification value
+ * @cpu:	A CPU number
+ *
+ * Returns the performance score of a class of tasks when running on @cpu.
+ * Error when either @class or @cpu are invalid.
+ */
+static __always_inline
+int arch_get_task_class_score(int class, int cpu)
+{
+	return 1;
+}
+#endif
+#else /* CONFIG_SCHED_TASK_CLASSES */
+
+#define arch_get_task_class_score(class, cpu) (-EINVAL)
+#define arch_update_task_class(curr, smt_siblings_idle)
+
+static inline bool sched_task_classes_enabled(void) { return false; }
+
+#endif /* CONFIG_SCHED_TASK_CLASSES */
+
 #ifndef arch_scale_freq_capacity
 /**
  * arch_scale_freq_capacity - get the frequency scale factor of a given CPU.
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8739c2a5a54e..8d886dbe6318 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -669,6 +669,9 @@ DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
 DEFINE_STATIC_KEY_FALSE(sched_asym_cpucapacity);
+#ifdef CONFIG_SCHED_TASK_CLASSES
+DEFINE_STATIC_KEY_FALSE(sched_task_classes);
+#endif
 
 static void update_top_cache_domain(int cpu)
 {
@@ -2384,6 +2387,11 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	if (has_asym)
 		static_branch_inc_cpuslocked(&sched_asym_cpucapacity);
 
+#ifdef CONFIG_SCHED_TASK_CLASSES
+	if (arch_has_task_classes())
+		static_branch_enable_cpuslocked(&sched_task_classes);
+#endif
+
 	if (rq && sched_debug_verbose) {
 		pr_info("root domain span: %*pbl (max cpu_capacity = %lu)\n",
 			cpumask_pr_args(cpu_map), rq->rd->max_cpu_capacity);
-- 
2.25.1

