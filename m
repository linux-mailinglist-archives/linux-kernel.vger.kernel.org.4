Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FF870BBD7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjEVLbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjEVLbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:31:12 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F29102
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684755059; x=1716291059;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pDJxX0xEINN52I76eruquUlqRmcdL87f6osPOtH4oY0=;
  b=nC4RtKELTVRjBE0mV7ekWchr1Nl8wAHQqVRWTkLt9Vyb5F9evbE2IXaT
   ooe3BCxNVgJZd0DFFx/gh7snnMHJkMNBkxTGnPJvB9iufpw0iqpGdCVhT
   rApZOi9yQux4eWFG/Zspd7O2SUex6Rmm73Bk1pkxkWWGPhwe2YifYRg5o
   GvN8hQXM40+ACMEK2eKq+dzllUk/x2SaLH/2EAtB1Wkk1OkzJozAg+VSP
   Lrg5jJR7v9Mv30q7ZzmE5eJtw/Ba8t4Dzk/8/kMM8LVsnhVCMM8FKhXys
   bYV30fIGMR9nUHCEb6q5p0QP1QxIYGypD081ycKZk4kJPVNWeY8x4KJof
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="416356739"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="416356739"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 04:30:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="703468252"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="703468252"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga002.jf.intel.com with ESMTP; 22 May 2023 04:30:58 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH V2 2/6] perf: Add branch stack extension
Date:   Mon, 22 May 2023 04:30:36 -0700
Message-Id: <20230522113040.2329924-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230522113040.2329924-1-kan.liang@linux.intel.com>
References: <20230522113040.2329924-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Currently, the extra information of a branch entry is stored in a u64
space. With more and more information added, the space is running out.
For example, the information of occurrences of events will be added for
each branch.

Add an extension space to record the new information for each branch
entry. The space is appended after the struct perf_branch_stack.

Add a bit in struct perf_branch_entry to indicate whether the extra
information is included.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Sandipan Das <sandipan.das@amd.com>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---

New patch
- Introduce a generic extension space which can be used to
  store the LBR event information for Intel. It can also be used by
  other ARCHs for the other purpose.
- Add a new bit in struct perf_branch_entry to indicate whether the
  extra information is included.

 arch/powerpc/perf/core-book3s.c |  2 +-
 arch/x86/events/amd/core.c      |  2 +-
 arch/x86/events/intel/core.c    |  2 +-
 arch/x86/events/intel/ds.c      |  4 ++--
 include/linux/perf_event.h      | 18 +++++++++++++++++-
 include/uapi/linux/perf_event.h |  4 +++-
 kernel/events/core.c            |  5 +++++
 7 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 8c1f7def596e..3c14596bbfaf 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -2313,7 +2313,7 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 			struct cpu_hw_events *cpuhw;
 			cpuhw = this_cpu_ptr(&cpu_hw_events);
 			power_pmu_bhrb_read(event, cpuhw);
-			perf_sample_save_brstack(&data, event, &cpuhw->bhrb_stack);
+			perf_sample_save_brstack(&data, event, &cpuhw->bhrb_stack, NULL);
 		}
 
 		if (event->attr.sample_type & PERF_SAMPLE_DATA_SRC &&
diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index bccea57dee81..facee84aeecb 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -930,7 +930,7 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 			continue;
 
 		if (has_branch_stack(event))
-			perf_sample_save_brstack(&data, event, &cpuc->lbr_stack);
+			perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
 
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index ba2a971e6b8a..21566f66bfd8 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3048,7 +3048,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		perf_sample_data_init(&data, 0, event->hw.last_period);
 
 		if (has_branch_stack(event))
-			perf_sample_save_brstack(&data, event, &cpuc->lbr_stack);
+			perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
 
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 608e220e46aa..3f16e95e99dd 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1747,7 +1747,7 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 		setup_pebs_time(event, data, pebs->tsc);
 
 	if (has_branch_stack(event))
-		perf_sample_save_brstack(data, event, &cpuc->lbr_stack);
+		perf_sample_save_brstack(data, event, &cpuc->lbr_stack, NULL);
 }
 
 static void adaptive_pebs_save_regs(struct pt_regs *regs,
@@ -1904,7 +1904,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 
 		if (has_branch_stack(event)) {
 			intel_pmu_store_pebs_lbrs(lbr);
-			perf_sample_save_brstack(data, event, &cpuc->lbr_stack);
+			perf_sample_save_brstack(data, event, &cpuc->lbr_stack, NULL);
 		}
 	}
 
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d5628a7b5eaa..e2e04dc39199 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -126,6 +126,16 @@ struct perf_branch_stack {
 	struct perf_branch_entry	entries[];
 };
 
+/*
+ * The extension space is appended after the struct perf_branch_stack.
+ * It is used to store the extra data of each branch, e.g.,
+ * the occurrences of events since the last branch entry for Intel LBR.
+ */
+struct perf_branch_stack_ext {
+	__u64				nr;
+	__u64				data[];
+};
+
 struct task_struct;
 
 /*
@@ -1161,6 +1171,7 @@ struct perf_sample_data {
 	struct perf_callchain_entry	*callchain;
 	struct perf_raw_record		*raw;
 	struct perf_branch_stack	*br_stack;
+	struct perf_branch_stack_ext	*br_stack_ext;
 	union perf_sample_weight	weight;
 	union  perf_mem_data_src	data_src;
 	u64				txn;
@@ -1237,7 +1248,8 @@ static inline void perf_sample_save_raw_data(struct perf_sample_data *data,
 
 static inline void perf_sample_save_brstack(struct perf_sample_data *data,
 					    struct perf_event *event,
-					    struct perf_branch_stack *brs)
+					    struct perf_branch_stack *brs,
+					    struct perf_branch_stack_ext *brs_ext)
 {
 	int size = sizeof(u64); /* nr */
 
@@ -1245,7 +1257,11 @@ static inline void perf_sample_save_brstack(struct perf_sample_data *data,
 		size += sizeof(u64);
 	size += brs->nr * sizeof(struct perf_branch_entry);
 
+	if (brs_ext)
+		size += (1 + brs_ext->nr) * sizeof(u64);
+
 	data->br_stack = brs;
+	data->br_stack_ext = brs_ext;
 	data->dyn_size += size;
 	data->sample_flags |= PERF_SAMPLE_BRANCH_STACK;
 }
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 37675437b768..1b3b90965b6b 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1410,6 +1410,7 @@ union perf_mem_data_src {
  *    cycles: cycles from last branch (or 0 if not supported)
  *      type: branch type
  *      spec: branch speculation info (or 0 if not supported)
+ *       ext: has extension space for extra info (or 0 if not supported)
  */
 struct perf_branch_entry {
 	__u64	from;
@@ -1423,7 +1424,8 @@ struct perf_branch_entry {
 		spec:2,     /* branch speculation info */
 		new_type:4, /* additional branch type */
 		priv:3,     /* privilege level */
-		reserved:31;
+		ext:1,      /* has extension */
+		reserved:30;
 };
 
 union perf_sample_weight {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 435815d3be3f..dfd6703139a1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7324,6 +7324,11 @@ void perf_output_sample(struct perf_output_handle *handle,
 			if (branch_sample_hw_index(event))
 				perf_output_put(handle, data->br_stack->hw_idx);
 			perf_output_copy(handle, data->br_stack->entries, size);
+			if (data->br_stack_ext) {
+				size = data->br_stack_ext->nr * sizeof(u64);
+				perf_output_put(handle, data->br_stack_ext->nr);
+				perf_output_copy(handle, data->br_stack_ext->data, size);
+			}
 		} else {
 			/*
 			 * we always store at least the value of nr
-- 
2.35.1

