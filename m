Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5FB72D864
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 06:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239099AbjFMEVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 00:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbjFMEVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 00:21:38 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496E710DC;
        Mon, 12 Jun 2023 21:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686630097; x=1718166097;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=FPTg/Kh6Bpx/mtnSi0xLQfXNHVVz6z4CysuQe9QkeN4=;
  b=jY0wpup8aNnyc/CKvnYznW4W5RtdAmMn4Wu2cxgS3PpedtNNpbxUV8UW
   82aZ32WtwlwZ5jOCixt4YfhEszb2epwcFhk7F+qyNed1T9tLRAStZvWyL
   nnuRwQB4ccbFBe95oqbQo7a/ks0ZKPDowHsHtV6Ze2klBenAfYO1oeoDV
   9QduMMpmrJGjVOvjaf/lOzPAVRJfXPyphM9Myq1cHvqITCGgwocceUlIa
   gq+pkdSefIr4EXvx5O8lr/ZIV5CPvyjwEcszTCWM64c3OJTNeWNmyOtrt
   aeohUcbF7tR9VadVUvT1rQHwx3Dj53Is4leYfF9dIDhow5NjnBDrOVebt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="358222031"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="358222031"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 21:21:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="661854926"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="661854926"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga003.jf.intel.com with ESMTP; 12 Jun 2023 21:21:34 -0700
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
Subject: [PATCH v4 01/24] sched/task_struct: Introduce IPC classes of tasks
Date:   Mon, 12 Jun 2023 21:23:59 -0700
Message-Id: <20230613042422.5344-2-ricardo.neri-calderon@linux.intel.com>
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

On hybrid processors, the architecture differences between the types of
CPUs result in different instructions-per-cycle (IPC) rates for each type
of CPU. IPCs may vary further by the type of instructions being executed.
Instructions can be grouped into classes of similar IPCs.

Tasks can be classified into groups based on the type of instructions they
execute.

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
 * Changed the type of task_struct::ipcc to unsigned short. A subsequent
   patch uses bit fields to use 9 bits, along with other auxiliary
   members.

Changes since v1:
 * Renamed task_struct::class as task_struct::ipcc. (Joel)
 * Use task_struct::ipcc = 0 for unclassified tasks. (PeterZ)
 * Renamed CONFIG_SCHED_TASK_CLASSES as CONFIG_IPC_CLASSES. (PeterZ, Joel)
---
 include/linux/sched.h | 10 ++++++++++
 init/Kconfig          | 12 ++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1292d38d66cc..9fdee040f450 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -129,6 +129,8 @@ struct user_event_mm;
 					 __TASK_TRACED | EXIT_DEAD | EXIT_ZOMBIE | \
 					 TASK_PARKED)
 
+#define IPC_CLASS_UNCLASSIFIED		0
+
 #define task_is_running(task)		(READ_ONCE((task)->__state) == TASK_RUNNING)
 
 #define task_is_traced(task)		((READ_ONCE(task->jobctl) & JOBCTL_TRACED) != 0)
@@ -1534,6 +1536,14 @@ struct task_struct {
 	struct user_event_mm		*user_event_mm;
 #endif
 
+#ifdef CONFIG_IPC_CLASSES
+	/*
+	 * A hardware-defined classification of task that reflects but is
+	 * not identical to the number of instructions per cycle.
+	 */
+	unsigned short			ipcc;
+#endif
+
 	/*
 	 * New fields for task_struct should be added above here, so that
 	 * they are included in the randomized portion of task_struct.
diff --git a/init/Kconfig b/init/Kconfig
index 32c24950c4ce..ea3371ccb530 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -839,6 +839,18 @@ config UCLAMP_BUCKETS_COUNT
 
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

