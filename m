Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CE263A915
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbiK1NNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbiK1NNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:13:33 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5727713D5E;
        Mon, 28 Nov 2022 05:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669641212; x=1701177212;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=bVqpVo1Q9MYSWk8Td5o+e8rn4ip/1+KMBJaJ/M8s+/Y=;
  b=U5vi/ORGokvMveSG0Qai9S11M08uOBRjdSHA8jXTTzLa/lPDNCuT7VvG
   8B9LKyJjj3eCneQEjqVHlJNnyHMu2TGaEC8GGCNV5yTk4KHa++thsMMeb
   l5iCSupGVtJK7hfRJqg6g0EPqyy2ZI60zCZRjn8tZu62mSuhuZeRaBYbm
   fmNEFhICVDfE3Co+d5zeqdzCqk47bwvo8zk1Ff+ryj+1b69WPwhxi79Mk
   34f1KPLeonfpCRCiQwyYtvxX8sENJcSDv2cDCNqvRfPErv12Jn7FFtfA3
   X3ZuadxzzzstMV4a3hPI7mZIy5kQ03No4d1QBqNJ30D/3GNT/XVn9C+eo
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="401117058"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="401117058"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 05:13:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="749381321"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="749381321"
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
Subject: [PATCH v2 01/22] sched/task_struct: Introduce IPC classes of tasks
Date:   Mon, 28 Nov 2022 05:20:39 -0800
Message-Id: <20221128132100.30253-2-ricardo.neri-calderon@linux.intel.com>
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

On hybrid processors, the architecture differences between the types of
CPUs lead to different instructions-per-cycle (IPC) on each type of CPU.
IPCs may differ further by the type of instructions. Instructions can be
grouped into classes of similar IPCs.

Hence, tasks can be classified into groups based on the type of
instructions they execute.

Add a new member task_struct::ipcc to associate a particular task to
an IPC class that depends on the instructions it executes.

The scheduler may use the IPC class of a task and data about the
performance among CPUs of a given IPC class to improve throughput. It
may, for instance, place certain classes of tasks on CPUs of higher
performance.

The methods to determine the classification of a task and its relative
IPC score are specific to each CPU architecture.

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
 * Renamed task_struct::class as task::struct_ipcc. (Joel)
 * Use task_struct::ipcc = 0 for unclassified tasks. (PeterZ)
 * Renamed CONFIG_SCHED_TASK_CLASSES as CONFIG_IPC_CLASSES. (PeterZ, Joel)
---
 include/linux/sched.h | 10 ++++++++++
 init/Kconfig          | 12 ++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 68c07ae0d7ff..47ae3557ba07 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -127,6 +127,8 @@ struct task_group;
 					 __TASK_TRACED | EXIT_DEAD | EXIT_ZOMBIE | \
 					 TASK_PARKED)
 
+#define IPC_CLASS_UNCLASSIFIED		0
+
 #define task_is_running(task)		(READ_ONCE((task)->__state) == TASK_RUNNING)
 
 #define task_is_traced(task)		((READ_ONCE(task->jobctl) & JOBCTL_TRACED) != 0)
@@ -1525,6 +1527,14 @@ struct task_struct {
 	union rv_task_monitor		rv[RV_PER_TASK_MONITORS];
 #endif
 
+#ifdef CONFIG_IPC_CLASSES
+	/*
+	 * A hardware-defined classification of task based on the number
+	 * of instructions per cycle.
+	 */
+	unsigned int			ipcc;
+#endif
+
 	/*
 	 * New fields for task_struct should be added above here, so that
 	 * they are included in the randomized portion of task_struct.
diff --git a/init/Kconfig b/init/Kconfig
index abf65098f1b6..cd17dd4d3718 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -865,6 +865,18 @@ config UCLAMP_BUCKETS_COUNT
 
 	  If in doubt, use the default value.
 
+config IPC_CLASSES
+	bool "IPC classes of tasks"
+	depends on SMP
+	help
+	  If selected, each task is assigned a classification value that
+	  reflects the type of instructions that the task executes. This
+	  classification reflects but is not equal to the number of
+	  instructions retired per cycle.
+
+	  The scheduler uses the classification value to improve the placement
+	  of tasks.
+
 endmenu
 
 #
-- 
2.25.1

