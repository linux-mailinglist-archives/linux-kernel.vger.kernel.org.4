Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFC35B42D0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 01:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbiIIXId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 19:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiIIXGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 19:06:49 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F32E115CE3
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 16:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662764806; x=1694300806;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=yuPvdFo7/1bTUT3MpNBmCDYH8QDT7A+ZWsPsgReg8HQ=;
  b=IjizealNH1JjGQ4B0beU1qpNmEMHzEIqSkiv37ss9EVFOSYe+uCLnoiB
   P7Y3gVK8A2vWgGj0gbYvie9anSceKSuEQr/mRe9BDzNUr9mwvCmEUBCp1
   5dJBScgE47W9EI/d/2k5DuKFihpx9oY4qcgX9EF2nuBY+5FBmfm456v6G
   bcpwGpN3ewWfTG3OOehX5IUh4C/M0UUz9iBBOWJH86axxRqHMANVMfB15
   Ik57v1YWX9E+jRSiKdMfXjLzkASVVGkBEuWEw12581ASMiFj/Ndf00BdS
   jti7anu1jsmU4MZmPIrDaCT6LK2MrQ6aJN46S9OFVsMVRDEHdBjXX8aiu
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="296325075"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="296325075"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 16:06:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="677354966"
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
Subject: [RFC PATCH 01/23] sched/task_struct: Introduce classes of tasks
Date:   Fri,  9 Sep 2022 16:11:43 -0700
Message-Id: <20220909231205.14009-2-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On hybrid processors, the architecture differences between the types of
CPUs lead to different instructions-per-cycle (IPC) on each type of CPU.
IPCs may differ further by the type of instructions. Instructions can be
grouped into classes of similar IPCs.

Hence, tasks may be classified into groups depending on the type of
instructions they execute.

Add a new member task_struct::classid to associate a particular task to
a classification that depends on the instructions it executes.

The scheduler may use the classification of a task and information about
the relative performance among CPUs of a particular class of task to
improve throughput. It may, for instance, place certain tasks on CPUs that
have higher performance

The methods to determine the classification of a task and its relative
IPC are specific to each CPU architecture.

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
 include/linux/sched.h | 7 +++++++
 init/Kconfig          | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index e7b2f8a5c711..acc33dbaa47c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -117,6 +117,8 @@ struct task_group;
 					 __TASK_TRACED | EXIT_DEAD | EXIT_ZOMBIE | \
 					 TASK_PARKED)
 
+#define TASK_CLASS_UNCLASSIFIED		-1
+
 #define task_is_running(task)		(READ_ONCE((task)->__state) == TASK_RUNNING)
 
 #define task_is_traced(task)		((READ_ONCE(task->jobctl) & JOBCTL_TRACED) != 0)
@@ -1512,6 +1514,11 @@ struct task_struct {
 	union rv_task_monitor		rv[RV_PER_TASK_MONITORS];
 #endif
 
+#ifdef CONFIG_SCHED_TASK_CLASSES
+	/* Class of task that the scheduler uses for task placement decisions */
+	short				class;
+#endif
+
 	/*
 	 * New fields for task_struct should be added above here, so that
 	 * they are included in the randomized portion of task_struct.
diff --git a/init/Kconfig b/init/Kconfig
index 532362fcfe31..edfa27f8717a 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -854,6 +854,15 @@ config UCLAMP_BUCKETS_COUNT
 
 	  If in doubt, use the default value.
 
+config SCHED_TASK_CLASSES
+	bool "Classes of tasks"
+	depends on SMP
+	help
+	  If selected, each task is assigned a classification value that
+	  reflects the types of instructions that the task executes. The
+	  scheduler uses the classification value to improve the placement of
+	  tasks.
+
 endmenu
 
 #
-- 
2.25.1

