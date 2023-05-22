Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52AF270BBDC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbjEVLbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbjEVLb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:31:28 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787C5E9
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684755073; x=1716291073;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g4vus3dTWVAmpjb1PDMk1Af4mQaX4L+vKTTrLgQTJhk=;
  b=moRljhg2i7iOZP11zkpwWb4W2/VMeHdTdQoHsZNOQ8HUYd7R7SYJcAKV
   Mm74F4sPxrWAfqi2xmtrnsRrK87cR7X4CuswKC+fhKKxR79Nj0XWj0rEC
   GvhE67bWdUIxriNMLiGjMT0fU7pDud7Ti+ZdhoHg2tUWoNUOzFe1ebm+2
   gkQx1iy0flN2p8fvtsGC7n7NILPZ999AwUdE3tM3Jq7mzc07a3f3rjNwH
   egoH/VJkeOieBGW4AdJoYisDKpy7pYiZtasRhN4r+5qSj7DLmnLA+tb+N
   wjPLYTJ4YCvp8fXa/uI5AMxRpY11A3xrsBE5JMN6aHPwOMbA6vmbDG4LE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="416356783"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="416356783"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 04:31:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="703468279"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="703468279"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga002.jf.intel.com with ESMTP; 22 May 2023 04:31:03 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 6/6] perf tools: Add branch event knob
Date:   Mon, 22 May 2023 04:30:40 -0700
Message-Id: <20230522113040.2329924-6-kan.liang@linux.intel.com>
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

Add a new branch filter, "event", for the branch event option. It is
used to mark the events which should be logged in the branch. If it is
applied with the -j option, all the events should be logged in the
branch. If the legacy kernel doesn't support the new branch sample type,
switching off the branch event filter.

The new extension space of each branch is dumped right after the regular
branch stack information via perf report -D.

Usage examples:

perf record -e "{branch-instructions,branch-misses}:S" -j any,event

Only the first event, branch-instructions, collect the LBR. Both
branch-instructions and branch-misses are marked as logged events.
The occurrences information of them can be found in the branch stack
extension space of each branch.

perf record -e "{cpu/branch-instructions,branch_type=any/,
cpu/branch-misses,branch_type=event/}"

Only the first event, branch-instructions, collect the LBR. Only the
branch-misses event is marked as a logged event.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Notes: Since the new interfaces are still under review and may be
changed later, the perf tool patch only provides minimum support for the
current version. Once the interfaces are finalized, a more complete perf
tool patch can be expected.

Changes since V1:
- Drop the support of the event ID sample type
- Support the new branch stack extension

 tools/perf/Documentation/perf-record.txt  |  4 +++
 tools/perf/util/branch.h                  |  8 ++++-
 tools/perf/util/evsel.c                   | 39 ++++++++++++++++++++---
 tools/perf/util/evsel.h                   |  6 ++++
 tools/perf/util/parse-branch-options.c    |  1 +
 tools/perf/util/perf_event_attr_fprintf.c |  1 +
 tools/perf/util/sample.h                  |  1 +
 tools/perf/util/session.c                 |  8 +++++
 8 files changed, 62 insertions(+), 6 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index ff815c2f67e8..9183d9c414de 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -402,6 +402,10 @@ following filters are defined:
 		     4th-Gen Xeon+ server), the save branch type is unconditionally enabled
 		     when the taken branch stack sampling is enabled.
 	- priv: save privilege state during sampling in case binary is not available later
+	- event: save occurrences of the event since the last branch entry. Currently, the
+		 feature is only supported by a newer CPU, e.g., Intel Sierra Forest and
+		 later platforms. An error out is expected if it's used on the unsupported
+		 kernel or CPUs.
 
 +
 The option requires at least one branch type among any, any_call, any_ret, ind_call, cond.
diff --git a/tools/perf/util/branch.h b/tools/perf/util/branch.h
index e41bfffe2217..f765b05bbe5f 100644
--- a/tools/perf/util/branch.h
+++ b/tools/perf/util/branch.h
@@ -25,7 +25,8 @@ struct branch_flags {
 			u64 spec:2;
 			u64 new_type:4;
 			u64 priv:3;
-			u64 reserved:31;
+			u64 ext:1;
+			u64 reserved:30;
 		};
 	};
 };
@@ -50,6 +51,11 @@ struct branch_stack {
 	struct branch_entry	entries[];
 };
 
+struct branch_stack_ext {
+	u64			nr;
+	u64			data[];
+};
+
 /*
  * The hw_idx is only available when PERF_SAMPLE_BRANCH_HW_INDEX is applied.
  * Otherwise, the output format of a sample with branch stack is
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 51e8ce6edddc..19cc9272b669 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1850,6 +1850,8 @@ static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 static void evsel__disable_missing_features(struct evsel *evsel)
 {
+	if (perf_missing_features.branch_event)
+		evsel->core.attr.branch_sample_type &= ~PERF_SAMPLE_BRANCH_EVT_CNTRS;
 	if (perf_missing_features.read_lost)
 		evsel->core.attr.read_format &= ~PERF_FORMAT_LOST;
 	if (perf_missing_features.weight_struct) {
@@ -1903,7 +1905,12 @@ bool evsel__detect_missing_features(struct evsel *evsel)
 	 * Must probe features in the order they were added to the
 	 * perf_event_attr interface.
 	 */
-	if (!perf_missing_features.read_lost &&
+	if (!perf_missing_features.branch_event &&
+	    (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_EVT_CNTRS)) {
+		perf_missing_features.branch_event = true;
+		pr_debug2("switching off branch event support\n");
+		return true;
+	} else if (!perf_missing_features.read_lost &&
 	    (evsel->core.attr.read_format & PERF_FORMAT_LOST)) {
 		perf_missing_features.read_lost = true;
 		pr_debug2("switching off PERF_FORMAT_LOST support\n");
@@ -2339,7 +2346,8 @@ u64 evsel__bitfield_swap_branch_flags(u64 value)
 		new_val |= bitfield_swap(value, 24, 2);
 		new_val |= bitfield_swap(value, 26, 4);
 		new_val |= bitfield_swap(value, 30, 3);
-		new_val |= bitfield_swap(value, 33, 31);
+		new_val |= bitfield_swap(value, 33, 1);
+		new_val |= bitfield_swap(value, 34, 30);
 	} else {
 		new_val = bitfield_swap(value, 63, 1);
 		new_val |= bitfield_swap(value, 62, 1);
@@ -2350,7 +2358,8 @@ u64 evsel__bitfield_swap_branch_flags(u64 value)
 		new_val |= bitfield_swap(value, 38, 2);
 		new_val |= bitfield_swap(value, 34, 4);
 		new_val |= bitfield_swap(value, 31, 3);
-		new_val |= bitfield_swap(value, 0, 31);
+		new_val |= bitfield_swap(value, 30, 1);
+		new_val |= bitfield_swap(value, 0, 30);
 	}
 
 	return new_val;
@@ -2550,7 +2559,8 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 	if (type & PERF_SAMPLE_BRANCH_STACK) {
 		const u64 max_branch_nr = UINT64_MAX /
 					  sizeof(struct branch_entry);
-		struct branch_entry *e;
+		struct branch_entry *e, *e0;
+		bool has_ext = false;
 		unsigned int i;
 
 		OVERFLOW_CHECK_u64(array);
@@ -2571,7 +2581,7 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 			 */
 			e = (struct branch_entry *)&data->branch_stack->hw_idx;
 		}
-
+		e0 = e;
 		if (swapped) {
 			/*
 			 * struct branch_flag does not have endian
@@ -2589,6 +2599,25 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 
 		OVERFLOW_CHECK(array, sz, max_size);
 		array = (void *)array + sz;
+
+		for (i = 0, e = e0; i < data->branch_stack->nr; i++, e++) {
+			if (e->flags.ext) {
+				has_ext = true;
+				break;
+			}
+		}
+
+		if (has_ext) {
+			OVERFLOW_CHECK_u64(array);
+
+			data->branch_stack_ext = (struct branch_stack_ext *)array++;
+			if (data->branch_stack_ext->nr > max_branch_nr)
+				return -EFAULT;
+			sz = data->branch_stack_ext->nr * sizeof(u64);
+
+			OVERFLOW_CHECK(array, sz, max_size);
+			array = (void *)array + sz;
+		}
 	}
 
 	if (type & PERF_SAMPLE_REGS_USER) {
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 24cb807ef6ce..aa666e24f8e6 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -187,6 +187,7 @@ struct perf_missing_features {
 	bool code_page_size;
 	bool weight_struct;
 	bool read_lost;
+	bool branch_event;
 };
 
 extern struct perf_missing_features perf_missing_features;
@@ -473,6 +474,11 @@ static inline bool evsel__has_branch_hw_idx(const struct evsel *evsel)
 	return evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_HW_INDEX;
 }
 
+static inline bool evsel__has_branch_evt_cntrs(const struct evsel *evsel)
+{
+	return evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_EVT_CNTRS;
+}
+
 static inline bool evsel__has_callchain(const struct evsel *evsel)
 {
 	/*
diff --git a/tools/perf/util/parse-branch-options.c b/tools/perf/util/parse-branch-options.c
index fd67d204d720..ab5d6dabe659 100644
--- a/tools/perf/util/parse-branch-options.c
+++ b/tools/perf/util/parse-branch-options.c
@@ -36,6 +36,7 @@ static const struct branch_mode branch_modes[] = {
 	BRANCH_OPT("stack", PERF_SAMPLE_BRANCH_CALL_STACK),
 	BRANCH_OPT("hw_index", PERF_SAMPLE_BRANCH_HW_INDEX),
 	BRANCH_OPT("priv", PERF_SAMPLE_BRANCH_PRIV_SAVE),
+	BRANCH_OPT("event", PERF_SAMPLE_BRANCH_EVT_CNTRS),
 	BRANCH_END
 };
 
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 7e5e7b30510d..3133a4f003eb 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -53,6 +53,7 @@ static void __p_branch_sample_type(char *buf, size_t size, u64 value)
 		bit_name(COND), bit_name(CALL_STACK), bit_name(IND_JUMP),
 		bit_name(CALL), bit_name(NO_FLAGS), bit_name(NO_CYCLES),
 		bit_name(TYPE_SAVE), bit_name(HW_INDEX), bit_name(PRIV_SAVE),
+		bit_name(EVT_CNTRS),
 		{ .name = NULL, }
 	};
 #undef bit_name
diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
index 33b08e0ac746..62abae1c9cd3 100644
--- a/tools/perf/util/sample.h
+++ b/tools/perf/util/sample.h
@@ -101,6 +101,7 @@ struct perf_sample {
 	void *raw_data;
 	struct ip_callchain *callchain;
 	struct branch_stack *branch_stack;
+	struct branch_stack_ext *branch_stack_ext;
 	struct regs_dump  user_regs;
 	struct regs_dump  intr_regs;
 	struct stack_dump user_stack;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 749d5b5c135b..a1e303c2eaa8 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1159,6 +1159,7 @@ static void callchain__printf(struct evsel *evsel,
 static void branch_stack__printf(struct perf_sample *sample, bool callstack)
 {
 	struct branch_entry *entries = perf_sample__branch_entries(sample);
+	struct branch_stack_ext *branch_stack_ext = sample->branch_stack_ext;
 	uint64_t i;
 
 	if (!callstack) {
@@ -1200,6 +1201,13 @@ static void branch_stack__printf(struct perf_sample *sample, bool callstack)
 			}
 		}
 	}
+
+	if (branch_stack_ext) {
+		printf("... branch stack ext: nr:%" PRIu64 "\n", sample->branch_stack_ext->nr);
+		for (i = 0; i < branch_stack_ext->nr; i++) {
+			printf("..... %2"PRIu64": %016" PRIx64 "\n", i, branch_stack_ext->data[i]);
+		}
+	}
 }
 
 static void regs_dump__printf(u64 mask, u64 *regs, const char *arch)
-- 
2.35.1

