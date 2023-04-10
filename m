Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7BB6DCC3F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 22:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjDJUoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 16:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjDJUoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 16:44:11 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67621BC
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 13:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681159449; x=1712695449;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kcLJhD28Bc2+ALOajmNmlBWEQ7assJNKIKUzATapj3k=;
  b=UdIE7jtYCVYUFfcXZTzZ7nEHJQ91kWuKc8pYSdYL9SxycWLS2MWpls03
   DuT/oC62dGTwp4H8s+M6yQ/yZ3f3u2GhNW5yvL7HV/PJchrJK/keJ1j7W
   6F3MNr2Eidd/mEmqyHAv5uGz53dxNPkBYPviyvgG9ko6INZtwN5shGaJg
   Hd1GIqBRl/h0/0py7H300dNL6sYuSOMYdD0LtYPdTbN9zCQKkwDr80QtN
   w+w5//OXYsbdFuxAR0wNfwSaJZkvgx0ERQHiyFLN4Z9HJ/tEe/ohTr2JK
   0R4XmJQmC5/TLjxAGq1jfLy6s+4ezYxCizVNQkTMZQfj/2ywh4GGCJfc8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="408588952"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="408588952"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 13:44:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="638569729"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="638569729"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga003.jf.intel.com with ESMTP; 10 Apr 2023 13:44:06 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 6/6] perf tools: Support PERF_SAMPLE_BRANCH_EVENT_IDS
Date:   Mon, 10 Apr 2023 13:43:52 -0700
Message-Id: <20230410204352.1098067-6-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230410204352.1098067-1-kan.liang@linux.intel.com>
References: <20230410204352.1098067-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Support new sample type PERF_SAMPLE_BRANCH_EVENT_IDS.

It's used with the branch event feature together. If the legacy kernel
doesn't support either of them, switching off them together.

The sampling event may not be the event logged by a branch. Apply the
PERF_SAMPLE_BRANCH_EVENT_IDS for all events if the branch events logging
feature is detected.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/branch.h                  |  5 +++++
 tools/perf/util/evsel.c                   | 22 ++++++++++++++++++++--
 tools/perf/util/perf_event_attr_fprintf.c |  2 +-
 tools/perf/util/record.c                  | 13 +++++++++++++
 tools/perf/util/sample.h                  |  1 +
 tools/perf/util/session.c                 | 17 +++++++++++++++++
 tools/perf/util/synthetic-events.c        | 12 ++++++++++++
 7 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/branch.h b/tools/perf/util/branch.h
index 5feb79ccd698..761b686e7730 100644
--- a/tools/perf/util/branch.h
+++ b/tools/perf/util/branch.h
@@ -51,6 +51,11 @@ struct branch_stack {
 	struct branch_entry	entries[];
 };
 
+struct branch_event_ids {
+	u64			nr;
+	u64			ids[];
+};
+
 /*
  * The hw_idx is only available when PERF_SAMPLE_BRANCH_HW_INDEX is applied.
  * Otherwise, the output format of a sample with branch stack is
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1888552f41f9..91bd989c8491 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1850,8 +1850,10 @@ static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 static void evsel__disable_missing_features(struct evsel *evsel)
 {
-	if (perf_missing_features.branch_event)
+	if (perf_missing_features.branch_event) {
 		evsel->core.attr.branch_sample_type &= ~PERF_SAMPLE_BRANCH_EVENT;
+		evsel__reset_sample_bit(evsel, BRANCH_EVENT_IDS);
+	}
 	if (perf_missing_features.read_lost)
 		evsel->core.attr.read_format &= ~PERF_FORMAT_LOST;
 	if (perf_missing_features.weight_struct) {
@@ -1906,7 +1908,8 @@ bool evsel__detect_missing_features(struct evsel *evsel)
 	 * perf_event_attr interface.
 	 */
 	if (!perf_missing_features.branch_event &&
-	    (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_EVENT)) {
+	    ((evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_EVENT) ||
+	     (evsel->core.attr.sample_type & PERF_SAMPLE_BRANCH_EVENT_IDS))) {
 		perf_missing_features.branch_event = true;
 		pr_debug2("switching off branch event support\n");
 		return true;
@@ -2710,6 +2713,21 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		array = (void *)array + sz;
 	}
 
+	if (type & PERF_SAMPLE_BRANCH_EVENT_IDS) {
+		const u64 max_branch_nr = UINT64_MAX / sizeof(u64);
+
+		OVERFLOW_CHECK_u64(array);
+		data->branch_event_ids = (struct branch_event_ids *)array++;
+
+		if (data->branch_event_ids->nr > max_branch_nr)
+			return -EFAULT;
+
+		sz = data->branch_event_ids->nr * sizeof(u64);
+
+		OVERFLOW_CHECK(array, sz, max_size);
+		array = (void *)array + sz;
+	}
+
 	return 0;
 }
 
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 96f0aafc962d..5eadcdaba12e 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -36,7 +36,7 @@ static void __p_sample_type(char *buf, size_t size, u64 value)
 		bit_name(IDENTIFIER), bit_name(REGS_INTR), bit_name(DATA_SRC),
 		bit_name(WEIGHT), bit_name(PHYS_ADDR), bit_name(AUX),
 		bit_name(CGROUP), bit_name(DATA_PAGE_SIZE), bit_name(CODE_PAGE_SIZE),
-		bit_name(WEIGHT_STRUCT),
+		bit_name(WEIGHT_STRUCT), bit_name(BRANCH_EVENT_IDS),
 		{ .name = NULL, }
 	};
 #undef bit_name
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index 9eb5c6a08999..640ba5243209 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -98,6 +98,7 @@ void evlist__config(struct evlist *evlist, struct record_opts *opts, struct call
 	bool use_sample_identifier = false;
 	bool use_comm_exec;
 	bool sample_id = opts->sample_id;
+	bool has_branch_events = false;
 
 	if (perf_cpu_map__cpu(evlist->core.user_requested_cpus, 0).cpu < 0)
 		opts->no_inherit = true;
@@ -108,6 +109,8 @@ void evlist__config(struct evlist *evlist, struct record_opts *opts, struct call
 		evsel__config(evsel, opts, callchain);
 		if (evsel->tracking && use_comm_exec)
 			evsel->core.attr.comm_exec = 1;
+		if (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_EVENT)
+			has_branch_events = true;
 	}
 
 	/* Configure leader sampling here now that the sample type is known */
@@ -139,6 +142,16 @@ void evlist__config(struct evlist *evlist, struct record_opts *opts, struct call
 			evsel__set_sample_id(evsel, use_sample_identifier);
 	}
 
+	if (has_branch_events) {
+		/*
+		 * The sampling event may not be the event logged by a
+		 * branch. Apply the BRANCH_EVENT_IDS for all events if
+		 * the branch events logging feature is detected.
+		 */
+		evlist__for_each_entry(evlist, evsel)
+			evsel__set_sample_bit(evsel, BRANCH_EVENT_IDS);
+	}
+
 	evlist__set_id_pos(evlist);
 }
 
diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
index 33b08e0ac746..b0979571c8af 100644
--- a/tools/perf/util/sample.h
+++ b/tools/perf/util/sample.h
@@ -101,6 +101,7 @@ struct perf_sample {
 	void *raw_data;
 	struct ip_callchain *callchain;
 	struct branch_stack *branch_stack;
+	struct branch_event_ids *branch_event_ids;
 	struct regs_dump  user_regs;
 	struct regs_dump  intr_regs;
 	struct stack_dump user_stack;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index ce6d9349ec42..cc53a4ddfe6d 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1203,6 +1203,20 @@ static void branch_stack__printf(struct perf_sample *sample, bool callstack)
 	}
 }
 
+static void branch_event_ids__printf(struct branch_event_ids *br_event)
+{
+	u64 i;
+
+	printf("%s: nr:%" PRIu64 "\n", "... branch event IDs", br_event->nr);
+
+	for (i = 0; i < br_event->nr; i++) {
+		if (br_event->ids[i] != -1ULL)
+			printf("..... %2"PRIu64": %016" PRIx64 "\n", i, br_event->ids[i]);
+		else
+			printf("..... %2"PRIu64": N/A\n", i);
+	}
+}
+
 static void regs_dump__printf(u64 mask, u64 *regs, const char *arch)
 {
 	unsigned rid, i = 0;
@@ -1364,6 +1378,9 @@ static void dump_sample(struct evsel *evsel, union perf_event *event,
 	if (evsel__has_br_stack(evsel))
 		branch_stack__printf(sample, evsel__has_branch_callstack(evsel));
 
+	if (sample_type & PERF_SAMPLE_BRANCH_EVENT_IDS)
+		branch_event_ids__printf(sample->branch_event_ids);
+
 	if (sample_type & PERF_SAMPLE_REGS_USER)
 		regs_user__printf(sample, arch);
 
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 9ab9308ee80c..f4c47979e7c1 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1543,6 +1543,11 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 		result += sample->aux_sample.size;
 	}
 
+	if (type & PERF_SAMPLE_BRANCH_EVENT_IDS) {
+		result += sizeof(u64);
+		result += sample->branch_event_ids->nr * sizeof(u64);
+	}
+
 	return result;
 }
 
@@ -1757,6 +1762,13 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
 		array = (void *)array + sz;
 	}
 
+	if (type & PERF_SAMPLE_BRANCH_EVENT_IDS) {
+		sz = sizeof(u64);
+		sz += sample->branch_event_ids->nr * sizeof(u64);
+		memcpy(array, sample->branch_event_ids, sz);
+		array = (void *)array + sz;
+	}
+
 	return 0;
 }
 
-- 
2.35.1

