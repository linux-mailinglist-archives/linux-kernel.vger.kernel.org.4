Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3746DCC41
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 22:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjDJUo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 16:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjDJUoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 16:44:11 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4037F10FC
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 13:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681159450; x=1712695450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=inpVng/Bcp3nfLuM1fQwcQiyrkOpWUtdNri8ppIn/8A=;
  b=k7gJ/e5srCfvm1JNWBCFM5yQkULBx35Xl7kiyBFVE92YJZUgzRycoC8E
   ZfAXR4qarFKANuEQmVpeYKIXXAi5IYW/7tNhcNdERyEWMko1WWVySo5QG
   B44AFzU6pH98NtF3LMWckgkwy9lFIp68wHshEAnI054ab5ki39VUN1CN5
   IKBfcoIC/EbfkTTfz0oKKRpvLtnnAIWuL3NJqTZbmOTp/8i075PnBfwQi
   nguka0Jvaa7KEzyT3IpocRCgE3lcAH0Wfli1l5Ycal0e+wst2do1Lokdr
   bVx/deH1Tpd4UGJF/ng8Uw4n9+76ObgptQsxKlfB05AhKvbLEPQg5Ga1g
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="408588946"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="408588946"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 13:44:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="638569726"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="638569726"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga003.jf.intel.com with ESMTP; 10 Apr 2023 13:44:06 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 5/6] perf tools: Add branch event knob
Date:   Mon, 10 Apr 2023 13:43:51 -0700
Message-Id: <20230410204352.1098067-5-kan.liang@linux.intel.com>
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

Add a new branch filter for the branch event option. If the legacy
kernel doesn't support the branch sample type, switching off the branch
event filter.

The new branch event information should be dumped with other branch
information via perf report -D.

Extend the struct branch_flags and evsel__bitfield_swap_branch_flags()
to support the new field.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/Documentation/perf-record.txt  |  1 +
 tools/perf/util/branch.h                  |  3 ++-
 tools/perf/util/evsel.c                   | 18 ++++++++++++++----
 tools/perf/util/evsel.h                   |  1 +
 tools/perf/util/parse-branch-options.c    |  1 +
 tools/perf/util/perf_event_attr_fprintf.c |  1 +
 tools/perf/util/session.c                 |  3 ++-
 7 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index ff815c2f67e8..d09443a01d91 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -402,6 +402,7 @@ following filters are defined:
 		     4th-Gen Xeon+ server), the save branch type is unconditionally enabled
 		     when the taken branch stack sampling is enabled.
 	- priv: save privilege state during sampling in case binary is not available later
+	- event: save occurrences of the event since the last branch entry.
 
 +
 The option requires at least one branch type among any, any_call, any_ret, ind_call, cond.
diff --git a/tools/perf/util/branch.h b/tools/perf/util/branch.h
index e41bfffe2217..5feb79ccd698 100644
--- a/tools/perf/util/branch.h
+++ b/tools/perf/util/branch.h
@@ -25,7 +25,8 @@ struct branch_flags {
 			u64 spec:2;
 			u64 new_type:4;
 			u64 priv:3;
-			u64 reserved:31;
+			u64 events:8;
+			u64 reserved:23;
 		};
 	};
 };
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 51e8ce6edddc..1888552f41f9 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1850,6 +1850,8 @@ static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 static void evsel__disable_missing_features(struct evsel *evsel)
 {
+	if (perf_missing_features.branch_event)
+		evsel->core.attr.branch_sample_type &= ~PERF_SAMPLE_BRANCH_EVENT;
 	if (perf_missing_features.read_lost)
 		evsel->core.attr.read_format &= ~PERF_FORMAT_LOST;
 	if (perf_missing_features.weight_struct) {
@@ -1903,7 +1905,12 @@ bool evsel__detect_missing_features(struct evsel *evsel)
 	 * Must probe features in the order they were added to the
 	 * perf_event_attr interface.
 	 */
-	if (!perf_missing_features.read_lost &&
+	if (!perf_missing_features.branch_event &&
+	    (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_EVENT)) {
+		perf_missing_features.branch_event = true;
+		pr_debug2("switching off branch event support\n");
+		return true;
+	} else if (!perf_missing_features.read_lost &&
 	    (evsel->core.attr.read_format & PERF_FORMAT_LOST)) {
 		perf_missing_features.read_lost = true;
 		pr_debug2("switching off PERF_FORMAT_LOST support\n");
@@ -2320,7 +2327,8 @@ u64 evsel__bitfield_swap_branch_flags(u64 value)
 	 * 		spec:2		//branch speculation info
 	 * 		new_type:4	//additional branch type
 	 * 		priv:3		//privilege level
-	 * 		reserved:31
+	 *		events:8	//occurrences of events
+	 *		reserved:23
 	 * 	}
 	 * }
 	 *
@@ -2339,7 +2347,8 @@ u64 evsel__bitfield_swap_branch_flags(u64 value)
 		new_val |= bitfield_swap(value, 24, 2);
 		new_val |= bitfield_swap(value, 26, 4);
 		new_val |= bitfield_swap(value, 30, 3);
-		new_val |= bitfield_swap(value, 33, 31);
+		new_val |= bitfield_swap(value, 33, 8);
+		new_val |= bitfield_swap(value, 41, 23);
 	} else {
 		new_val = bitfield_swap(value, 63, 1);
 		new_val |= bitfield_swap(value, 62, 1);
@@ -2350,7 +2359,8 @@ u64 evsel__bitfield_swap_branch_flags(u64 value)
 		new_val |= bitfield_swap(value, 38, 2);
 		new_val |= bitfield_swap(value, 34, 4);
 		new_val |= bitfield_swap(value, 31, 3);
-		new_val |= bitfield_swap(value, 0, 31);
+		new_val |= bitfield_swap(value, 23, 8);
+		new_val |= bitfield_swap(value, 0, 23);
 	}
 
 	return new_val;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 24cb807ef6ce..05a61d36ee10 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -187,6 +187,7 @@ struct perf_missing_features {
 	bool code_page_size;
 	bool weight_struct;
 	bool read_lost;
+	bool branch_event;
 };
 
 extern struct perf_missing_features perf_missing_features;
diff --git a/tools/perf/util/parse-branch-options.c b/tools/perf/util/parse-branch-options.c
index fd67d204d720..c9fcefed5f9d 100644
--- a/tools/perf/util/parse-branch-options.c
+++ b/tools/perf/util/parse-branch-options.c
@@ -36,6 +36,7 @@ static const struct branch_mode branch_modes[] = {
 	BRANCH_OPT("stack", PERF_SAMPLE_BRANCH_CALL_STACK),
 	BRANCH_OPT("hw_index", PERF_SAMPLE_BRANCH_HW_INDEX),
 	BRANCH_OPT("priv", PERF_SAMPLE_BRANCH_PRIV_SAVE),
+	BRANCH_OPT("event", PERF_SAMPLE_BRANCH_EVENT),
 	BRANCH_END
 };
 
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 7e5e7b30510d..96f0aafc962d 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -53,6 +53,7 @@ static void __p_branch_sample_type(char *buf, size_t size, u64 value)
 		bit_name(COND), bit_name(CALL_STACK), bit_name(IND_JUMP),
 		bit_name(CALL), bit_name(NO_FLAGS), bit_name(NO_CYCLES),
 		bit_name(TYPE_SAVE), bit_name(HW_INDEX), bit_name(PRIV_SAVE),
+		bit_name(EVENT),
 		{ .name = NULL, }
 	};
 #undef bit_name
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 749d5b5c135b..ce6d9349ec42 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1180,13 +1180,14 @@ static void branch_stack__printf(struct perf_sample *sample, bool callstack)
 		struct branch_entry *e = &entries[i];
 
 		if (!callstack) {
-			printf("..... %2"PRIu64": %016" PRIx64 " -> %016" PRIx64 " %hu cycles %s%s%s%s %x %s %s\n",
+			printf("..... %2"PRIu64": %016" PRIx64 " -> %016" PRIx64 " %hu cycles %s%s%s%s %x %x %s %s\n",
 				i, e->from, e->to,
 				(unsigned short)e->flags.cycles,
 				e->flags.mispred ? "M" : " ",
 				e->flags.predicted ? "P" : " ",
 				e->flags.abort ? "A" : " ",
 				e->flags.in_tx ? "T" : " ",
+				e->flags.events,
 				(unsigned)e->flags.reserved,
 				get_branch_type(e),
 				e->flags.spec ? branch_spec_desc(e->flags.spec) : "");
-- 
2.35.1

