Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EF8634826
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbiKVU2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbiKVU2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:28:15 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B1F1ADB9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 12:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669148894; x=1700684894;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Tu8yb4rTFtiG5/ROXb+qs9Ym1yY05u5ArJRxVYfGmFo=;
  b=YptDn/a3/nVFOVtzeQfSQeV98c6tT1NwvCbizeZq55KsOlAwv4ge4FUe
   8aIQAfVMfwBhZo3q+3Kh+36152bdNfkn2358g6SNsOcKl0wFhO0MzZGS5
   qFrKDTXl5sg4/VMENHGAbzwUkLOT/gYLSP2rI2etx8Swn9cFru1tBsoMC
   zqD6sAD2A7EdQyhKrAdJCGqjzX0DyPQNG1Ak5v700hb6Y7V/RJb0deiGZ
   EZQiAKhcVC9NscnX/CG3ZuQudCv4pcAukhWC3ya5FxmaHKfIWcMVXWdNj
   IU8PDE03v+VaojhDTTG908ULMkBDBPBDmlVPjY+6mo8aF6kMTARamaUYn
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="293616507"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="293616507"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 12:28:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="816228132"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="816228132"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga005.jf.intel.com with ESMTP; 22 Nov 2022 12:28:13 -0800
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
Subject: [PATCH v2 3/7] sched: Teach arch_asym_cpu_priority() the idle state of SMT siblings
Date:   Tue, 22 Nov 2022 12:35:28 -0800
Message-Id: <20221122203532.15013-4-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221122203532.15013-1-ricardo.neri-calderon@linux.intel.com>
References: <20221122203532.15013-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some processors (e.g., Intel processors with ITMT) use asym_packing to
balance load between physical cores with SMT. In such case, a core with all
its SMT siblings idle is more desirable than another with one or more busy
siblings.

Other processors (e.g, Power7 with SMT8) use asym_packing to balance load
among SMT siblings of different priority, regardless of their idle state.

Add a new parameter, check_smt, that architectures can use as needed.

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
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v1:
 * Introduced this patch.
---
 arch/x86/kernel/itmt.c         | 2 +-
 include/linux/sched/topology.h | 2 +-
 kernel/sched/fair.c            | 5 ++++-
 kernel/sched/sched.h           | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/itmt.c b/arch/x86/kernel/itmt.c
index 9ff480e94511..4cb5a5e4fa47 100644
--- a/arch/x86/kernel/itmt.c
+++ b/arch/x86/kernel/itmt.c
@@ -167,7 +167,7 @@ void sched_clear_itmt_support(void)
 	mutex_unlock(&itmt_update_mutex);
 }
 
-int arch_asym_cpu_priority(int cpu)
+int arch_asym_cpu_priority(int cpu, bool check_smt)
 {
 	return per_cpu(sched_core_priority, cpu);
 }
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 816df6cc444e..87b64b9776f6 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -63,7 +63,7 @@ static inline int cpu_numa_flags(void)
 }
 #endif
 
-extern int arch_asym_cpu_priority(int cpu);
+extern int arch_asym_cpu_priority(int cpu, bool check_smt);
 
 struct sched_domain_attr {
 	int relax_domain_level;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d18947a9c03e..0e4251f83807 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -142,8 +142,11 @@ __setup("sched_thermal_decay_shift=", setup_sched_thermal_decay_shift);
 #ifdef CONFIG_SMP
 /*
  * For asym packing, by default the lower numbered CPU has higher priority.
+ *
+ * When doing ASYM_PACKING at the "MC" or higher domains, architectures may
+ * want to check the idle state of the SMT siblngs of @cpu.
  */
-int __weak arch_asym_cpu_priority(int cpu)
+int __weak arch_asym_cpu_priority(int cpu, bool check_smt)
 {
 	return -cpu;
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0fc7c0130755..e5e52c2e82de 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -802,7 +802,8 @@ static inline long se_weight(struct sched_entity *se)
  */
 static inline bool sched_asym_prefer(int a, int b, bool check_smt)
 {
-	return arch_asym_cpu_priority(a) > arch_asym_cpu_priority(b);
+	return arch_asym_cpu_priority(a, check_smt) >
+	       arch_asym_cpu_priority(b, check_smt);
 }
 
 struct perf_domain {
-- 
2.25.1

