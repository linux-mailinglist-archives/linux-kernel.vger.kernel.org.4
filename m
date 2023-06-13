Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADFA72D865
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 06:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239152AbjFMEVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 00:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239046AbjFMEVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 00:21:39 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632B510DA;
        Mon, 12 Jun 2023 21:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686630098; x=1718166098;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=f70oxXzoYQGDme9oRHr+6EBjtL+JoDXEljhGKTzB1PQ=;
  b=Inp6q5rZdf0BFS+6rBMTb2BCUnj/nbrH5uiwTyGR8kS9/ZmGb9E6wJav
   O8FZ9foj9UBc++WUQbvZL785/hyl2FPNd+ZIGgsTgLJVz6VddmukMrA7H
   jwShHf6j4KCSQ7ijB1UEHweH7O9cRBciGQzO1L3NP419iaTjNZLURVB3D
   x1k840CNUJGx4YtGA2ZsdHSOY0O39Gosd87RoMR++rzWoJMQt4BhsQSfr
   x6mwSAChNDTREi3lfwfGsmShANr/leM4K9W+e2BBOO1mM3muFwuqK230x
   /d8BOf0/CRHLisGRHjg1FwT4Uitzeuw23NRC5eUntU+SVanhVr438Yd9k
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="358222044"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="358222044"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 21:21:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="661854932"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="661854932"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga003.jf.intel.com with ESMTP; 12 Jun 2023 21:21:36 -0700
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
        Valentin Schneider <vschneid@redhat.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Zhao Liu <zhao1.liu@intel.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Tim C . Chen" <tim.c.chen@intel.com>,
        Zhao Liu <zhao1.liu@linux.intel.com>
Subject: [PATCH v4 02/24] sched: Add interfaces for IPC classes
Date:   Mon, 12 Jun 2023 21:24:00 -0700
Message-Id: <20230613042422.5344-3-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230613042422.5344-1-ricardo.neri-calderon@linux.intel.com>
References: <20230613042422.5344-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the interfaces that architectures shall implement to convey the data
to support IPC classes.

arch_update_ipcc() updates the IPC classification of the current task as
given by hardware.

arch_get_ipcc_score() provides a performance score for a given IPC class
when placed on a specific CPU. Higher scores indicate higher performance.

When a driver or equivalent enablement code has configured the necessary
hardware to support IPC classes, it should call sched_enable_ipc_classes()
to notify the scheduler that it can start using IPC classes data.

The number of classes and the score of each class of task are determined
by hardware.

Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Perry Yuan <Perry.Yuan@amd.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim C. Chen <tim.c.chen@intel.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: x86@kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v3:
 * None

Changes since v2:
 * Clarified the properties of the IPC score: abstract, and linear. It can
   normalized when needed. (Ionela)
 * Selected a better default IPC score. (Ionela)
 * Removed arch_has_ipc_classes(). It is not suitable for hardware that is
   not ready to support IPC classes after boot. (Lukasz)
 * Added a new sched_enable_ipc_classes() interface that drivers or
   enablement code can call when ready to support IPC classes. (Lukasz)

Changes since v1:
 * Shortened the names of the IPCC interfaces (PeterZ):
   sched_task_classes_enabled >> sched_ipcc_enabled
   arch_has_task_classes >> arch_has_ipc_classes
   arch_update_task_class >> arch_update_ipcc
   arch_get_task_class_score >> arch_get_ipcc_score
 * Removed smt_siblings_idle argument from arch_update_ipcc(). (PeterZ)
---
 include/linux/sched/topology.h |  6 ++++
 kernel/sched/sched.h           | 66 ++++++++++++++++++++++++++++++++++
 kernel/sched/topology.c        |  9 +++++
 3 files changed, 81 insertions(+)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 816df6cc444e..5b084d3c9ad1 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -280,4 +280,10 @@ static inline int task_node(const struct task_struct *p)
 	return cpu_to_node(task_cpu(p));
 }
 
+#ifdef CONFIG_IPC_CLASSES
+extern void sched_enable_ipc_classes(void);
+#else
+static inline void sched_enable_ipc_classes(void) { }
+#endif
+
 #endif /* _LINUX_SCHED_TOPOLOGY_H */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 556496c77dc2..03fb53e9f340 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2544,6 +2544,72 @@ void arch_scale_freq_tick(void)
 }
 #endif
 
+#ifdef CONFIG_IPC_CLASSES
+DECLARE_STATIC_KEY_FALSE(sched_ipcc);
+
+static inline bool sched_ipcc_enabled(void)
+{
+	return static_branch_unlikely(&sched_ipcc);
+}
+
+#ifndef arch_update_ipcc
+/**
+ * arch_update_ipcc() - Update the IPC class of the current task
+ * @curr:		The current task
+ *
+ * Request that the IPC classification of @curr is updated.
+ *
+ * Returns: none
+ */
+static __always_inline
+void arch_update_ipcc(struct task_struct *curr)
+{
+}
+#endif
+
+#ifndef arch_get_ipcc_score
+
+#define SCHED_IPCC_SCORE_SCALE (1L << SCHED_FIXEDPOINT_SHIFT)
+/**
+ * arch_get_ipcc_score() - Get the IPC score of a class of task
+ * @ipcc:	The IPC class
+ * @cpu:	A CPU number
+ *
+ * The IPC performance scores reflects (but it is not identical to) the number
+ * of instructions retired per cycle for a given IPC class. It is a linear and
+ * abstract metric. Higher scores reflect better performance.
+ *
+ * The IPC score can be normalized with respect to the class, i, with the
+ * highest IPC score on the CPU, c, with highest performance:
+ *
+ *            IPC(i, c)
+ *  ------------------------------------ * SCHED_IPCC_SCORE_SCALE
+ *     max(IPC(i, c) : (i, c))
+ *
+ * Scheduling schemes that want to use the IPC score along with other
+ * normalized metrics for scheduling (e.g., CPU capacity) may need to normalize
+ * it.
+ *
+ * Other scheduling schemes (e.g., asym_packing) do not need normalization.
+ *
+ * Returns the performance score of an IPC class, @ipcc, when running on @cpu.
+ * Error when either @ipcc or @cpu are invalid.
+ */
+static __always_inline
+unsigned long arch_get_ipcc_score(unsigned short ipcc, int cpu)
+{
+	return SCHED_IPCC_SCORE_SCALE;
+}
+#endif
+#else /* CONFIG_IPC_CLASSES */
+
+#define arch_get_ipcc_score(ipcc, cpu) (-EINVAL)
+#define arch_update_ipcc(curr)
+
+static inline bool sched_ipcc_enabled(void) { return false; }
+
+#endif /* CONFIG_IPC_CLASSES */
+
 #ifndef arch_scale_freq_capacity
 /**
  * arch_scale_freq_capacity - get the frequency scale factor of a given CPU.
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index ca4472281c28..c3a633a4b474 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -672,6 +672,15 @@ DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
 DEFINE_STATIC_KEY_FALSE(sched_asym_cpucapacity);
 
+#ifdef CONFIG_IPC_CLASSES
+DEFINE_STATIC_KEY_FALSE(sched_ipcc);
+
+void sched_enable_ipc_classes(void)
+{
+	static_branch_enable_cpuslocked(&sched_ipcc);
+}
+#endif
+
 static void update_top_cache_domain(int cpu)
 {
 	struct sched_domain_shared *sds = NULL;
-- 
2.25.1

