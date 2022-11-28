Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DB163A920
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbiK1NN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiK1NNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:13:36 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22F71CB36;
        Mon, 28 Nov 2022 05:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669641214; x=1701177214;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=PygCb/lFlxpA6HfJbBXFOfXsvHEBrsUtKwJwsV3g7Oo=;
  b=MB5KWN8Hs73tFgcXJ1rUQbxcugySDvxKDxIqy2ada6vR8zTy5Ce63b0s
   WvuhiLAgTbZYjYeSIu3yji1SNy2hVhWrUY7txId5iRlkKu520H7PEJ44b
   HuM1Ry7dltAUyRt+RmyqhcviLeTFMZkDq8Rr81v8/DLANjSyrrw2lKzmX
   gvqoowsX56aTuzSc3e/LdbOCpZJiC+YrwPMg38U9KBnmBBxfzSsnb5D12
   XJB4EbUEOHYZ6cZxiD8s8nIOyKHanDeddF4yPGYLv3guBQWtaRS3gToPM
   yreGGCV/0xpbRcXIhcx1K6ENWrkkLjlv9r2yts7xF/vDc4synfkRJ4zFh
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="401117061"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="401117061"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 05:13:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="749381327"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="749381327"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga002.fm.intel.com with ESMTP; 28 Nov 2022 05:13:31 -0800
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
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: [PATCH v2 02/22] sched: Add interfaces for IPC classes
Date:   Mon, 28 Nov 2022 05:20:40 -0800
Message-Id: <20221128132100.30253-3-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221128132100.30253-1-ricardo.neri-calderon@linux.intel.com>
References: <20221128132100.30253-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

The number of classes and the score of each class of task are determined
by hardware.

Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim C. Chen <tim.c.chen@intel.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: x86@kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v1:
 * Shortened the names of the IPCC interfaces (PeterZ):
   sched_task_classes_enabled >> sched_ipcc_enabled
   arch_has_task_classes >> arch_has_ipc_classes
   arch_update_task_class >> arch_update_ipcc
   arch_get_task_class_score >> arch_get_ipcc_score
 * Removed smt_siblings_idle argument from arch_update_ipcc(). (PeterZ)
---
 kernel/sched/sched.h    | 60 +++++++++++++++++++++++++++++++++++++++++
 kernel/sched/topology.c |  8 ++++++
 2 files changed, 68 insertions(+)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b1d338a740e5..75e22baa2622 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2531,6 +2531,66 @@ void arch_scale_freq_tick(void)
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
+#ifndef arch_has_ipc_classes
+/**
+ * arch_has_ipc_classes() - Check whether hardware supports IPC classes of tasks
+ *
+ * Returns: true of IPC classes of tasks are supported.
+ */
+static __always_inline
+bool arch_has_ipc_classes(void)
+{
+	return false;
+}
+#endif
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
+/**
+ * arch_get_ipcc_score() - Get the IPC score of a class of task
+ * @ipcc:	The IPC class
+ * @cpu:	A CPU number
+ *
+ * Returns the performance score of an IPC class when running on @cpu.
+ * Error when either @class or @cpu are invalid.
+ */
+static __always_inline
+int arch_get_ipcc_score(unsigned short ipcc, int cpu)
+{
+	return 1;
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
index 8154ef590b9f..eb1654b64df7 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -669,6 +669,9 @@ DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
 DEFINE_STATIC_KEY_FALSE(sched_asym_cpucapacity);
+#ifdef CONFIG_IPC_CLASSES
+DEFINE_STATIC_KEY_FALSE(sched_ipcc);
+#endif
 
 static void update_top_cache_domain(int cpu)
 {
@@ -2388,6 +2391,11 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	if (has_asym)
 		static_branch_inc_cpuslocked(&sched_asym_cpucapacity);
 
+#ifdef CONFIG_IPC_CLASSES
+	if (arch_has_ipc_classes())
+		static_branch_enable_cpuslocked(&sched_ipcc);
+#endif
+
 	if (rq && sched_debug_verbose) {
 		pr_info("root domain span: %*pbl (max cpu_capacity = %lu)\n",
 			cpumask_pr_args(cpu_map), rq->rd->max_cpu_capacity);
-- 
2.25.1

