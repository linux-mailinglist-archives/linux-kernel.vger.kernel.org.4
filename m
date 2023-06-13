Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9941272D881
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 06:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239415AbjFMEX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 00:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239599AbjFMEXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 00:23:03 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE74F10E3;
        Mon, 12 Jun 2023 21:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686630117; x=1718166117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=j+E1XdJn/u7s3/DMQyQTEanAvog6+RNqIczdbl+b8aQ=;
  b=J+1pZGctWkvLormUlInL4dgSQaYhGF30WYolG3/x+lC3LhMwbB6uWn20
   YdGEC+532sTVZLo8PmVqvhIlbOol5oKC6pNm8ZH53dxWovgtude0FIcSV
   t0Q3q6Y8ZlD8OV2lZzsz9GSISd9KS5sNazMEnyvdHs74nxM89aohlKpHm
   YrAYY2k4pstPVPBY3teMzeGtf0qctteTelOBzFJEuBmiFoSUFgbee2jBp
   gbsEirYyBLy+BPGNLkFu9v1tkl5pRJrQn5EtDZgvfiaFkH7w5SLahScLO
   8PbOOJx5EUPYhk1B62NGXQHfMzglZyO/RFreAW2W+RWK/WT5pRUkK1NrP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="358222210"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="358222210"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 21:21:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="661854977"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="661854977"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga003.jf.intel.com with ESMTP; 12 Jun 2023 21:21:53 -0700
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
Subject: [PATCH v4 15/24] thermal: intel: hfi: Report the IPC class score of a CPU
Date:   Mon, 12 Jun 2023 21:24:13 -0700
Message-Id: <20230613042422.5344-16-ricardo.neri-calderon@linux.intel.com>
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

Implement the arch_get_ipcc_score() interface of the scheduler. Use the
performance capabilities of the extended Hardware Feedback Interface table
as the IPC score.

Use the cached per-CPU IPCC scores. A seqcount provides lockless access and
the required memory ordering to avoid stale data.

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
 * Ordered memory loads using a seqcount.
 * Removed local variable hfi_class from intel_hfi_get_ipcc_score().
   (Rafael).

Changes since v2:
 * None

Changes since v1:
 * Adjusted the returned HFI class (which starts at 0) to match the
   scheduler IPCC class (which starts at 1). (PeterZ)
 * Used the new interface names.
---
 arch/x86/include/asm/topology.h   |  4 ++++
 drivers/thermal/intel/intel_hfi.c | 40 +++++++++++++++++++++++++++++--
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 7d2ed7f7bb8c..8dd328cdb5cf 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -237,13 +237,17 @@ void init_freq_invariance_cppc(void);
 
 #ifdef CONFIG_INTEL_HFI_THERMAL
 int intel_hfi_read_classid(u8 *classid);
+unsigned long intel_hfi_get_ipcc_score(unsigned short ipcc, int cpu);
 #else
 static inline int intel_hfi_read_classid(u8 *classid) { return -ENODEV; }
+static inline unsigned long
+intel_hfi_get_ipcc_score(unsigned short ipcc, int cpu) { return -ENODEV; }
 #endif
 
 #ifdef CONFIG_IPC_CLASSES
 void intel_update_ipcc(struct task_struct *curr);
 #define arch_update_ipcc intel_update_ipcc
+#define arch_get_ipcc_score intel_hfi_get_ipcc_score
 #endif
 
 #endif /* _ASM_X86_TOPOLOGY_H */
diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index d822ed0bb5c1..fec2c01fda1b 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -199,6 +199,42 @@ static int alloc_hfi_ipcc_scores(void)
 	return hfi_ipcc_scores ? 0 : -ENOMEM;
 }
 
+unsigned long intel_hfi_get_ipcc_score(unsigned short ipcc, int cpu)
+{
+	int *scores, score;
+	unsigned long seq;
+
+	scores = per_cpu_ptr(hfi_ipcc_scores, cpu);
+	if (!scores)
+		return -ENODEV;
+
+	if (cpu < 0 || cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	if (ipcc == IPC_CLASS_UNCLASSIFIED)
+		return -EINVAL;
+
+	/*
+	 * Scheduler IPC classes start at 1. HFI classes start at 0.
+	 * See note intel_hfi_update_ipcc().
+	 */
+	if (ipcc >= hfi_features.nr_classes + 1)
+		return -EINVAL;
+
+	/*
+	 * The seqcount implies load-acquire semantics to order loads with
+	 * lockless stores of the write side in set_hfi_ipcc_score(). It
+	 * also implies a compiler barrier.
+	 */
+	do {
+		seq = read_seqcount_begin(&hfi_ipcc_seqcount);
+		/* @ipcc is never 0. */
+		score = scores[ipcc - 1];
+	} while (read_seqcount_retry(&hfi_ipcc_seqcount, seq));
+
+	return score;
+}
+
 static void set_hfi_ipcc_scores(struct hfi_instance *hfi_instance)
 {
 	int cpu;
@@ -213,8 +249,8 @@ static void set_hfi_ipcc_scores(struct hfi_instance *hfi_instance)
 	raw_spin_lock_irq(&hfi_instance->table_lock);
 	/*
 	 * The seqcount implies store-release semantics to order stores with
-	 * lockless loads from the seqcount read side. It also implies a
-	 * compiler barrier.
+	 * lockless loads from the seqcount read side in
+	 * intel_hfi_get_ipcc_score(). It also implies a compiler barrier.
 	 */
 	write_seqcount_begin(&hfi_ipcc_seqcount);
 	for_each_cpu(cpu, hfi_instance->cpus) {
-- 
2.25.1

