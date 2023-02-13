Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A70695068
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjBMTIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjBMTIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:08:14 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D571E1F4B1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676315289; x=1707851289;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k5xM53xjvbGCGQ5zJv4ziyGbnCGQidPVN7fJrmFsYRQ=;
  b=Gv/AwFIHrWB4+sz2xTHKInbBzV/TdVGB96JkIrA8a4vhStKe37ij6obV
   hM38cWxF9XloULEZ6Dtu7jzQ2kxbWL7O0dJgRTjQ4EPephIcdWK6xiLTI
   qSDxPEBjPKYBqvQO2Y3/lebIjEycGwlA0uJnEe7ACkNngDmjjcTGcWhof
   ggyhsb1SQj8yW8JP8XtHq4f6rnWQChVdn6YWd8DLHhAXiizR3u2vDz4/X
   YCxaY+En220UTC34iFnVsF9aWfkjd2mRFJ7wWC2Np6/9rcFCJ04PiBVOW
   DvcBsaZlCZAv7FX9e8/U5osZ7xuB4X0c1ZMKQX0HlxhiY8epj86XGhQBh
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="333108787"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="333108787"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 11:08:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="668901963"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="668901963"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga002.jf.intel.com with ESMTP; 13 Feb 2023 11:08:09 -0800
From:   kan.liang@linux.intel.com
To:     tglx@linutronix.de, jstultz@google.com, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     sboyd@kernel.org, eranian@google.com, namhyung@kernel.org,
        ak@linux.intel.com, adrian.hunter@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [RFC PATCH V2 8/9] perf evsel, tsc: Support the monotonic raw clock conversion
Date:   Mon, 13 Feb 2023 11:07:53 -0800
Message-Id: <20230213190754.1836051-9-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230213190754.1836051-1-kan.liang@linux.intel.com>
References: <20230213190754.1836051-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The cap_user_time_mono_raw indicates that the kernel relies on the perf
tool to convert the HW time to the monotonic raw clock.
Add tsc_to_monotonic_raw() to do the conversion.

The conversion information is stored in the session, which cannot be
read in evsel parsing. Add a pointor in the evlist to point to the
conversion information.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/evlist.h  |  1 +
 tools/perf/util/evsel.c   | 17 +++++++++++++++--
 tools/perf/util/evsel.h   |  7 +++++++
 tools/perf/util/session.c |  1 +
 tools/perf/util/tsc.c     | 12 ++++++++++++
 tools/perf/util/tsc.h     |  2 ++
 6 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 01fa9d592c5a..d860dc94009c 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -82,6 +82,7 @@ struct evlist {
 		int	pos;	/* index at evlist core object to check signals */
 	} ctl_fd;
 	struct event_enable_timer *eet;
+	struct perf_record_time_conv *time_conv;
 };
 
 struct evsel_str_handler {
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 999dd1700502..5e27ac2b9f9b 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -50,6 +50,7 @@
 #include "off_cpu.h"
 #include "../perf-sys.h"
 #include "util/parse-branch-options.h"
+#include "tsc.h"
 #include <internal/xyarray.h>
 #include <internal/lib.h>
 #include <internal/threadmap.h>
@@ -2349,6 +2350,18 @@ u64 evsel__bitfield_swap_branch_flags(u64 value)
 	return new_val;
 }
 
+static u64 perf_evsel_parse_time(struct evsel *evsel, u64 time)
+{
+	/*
+	 * The HW time can only be generated by HW events.
+	 */
+	if ((evsel->core.attr.clockid == CLOCK_MONOTONIC_RAW) &&
+	    evsel->evlist->time_conv && evsel__is_hw_event(evsel))
+		return tsc_to_monotonic_raw(evsel->evlist->time_conv, time);
+
+	return time;
+}
+
 int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 			struct perf_sample *data)
 {
@@ -2411,7 +2424,7 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 	}
 
 	if (type & PERF_SAMPLE_TIME) {
-		data->time = *array;
+		data->time = perf_evsel_parse_time(evsel, *array);
 		array++;
 	}
 
@@ -2734,7 +2747,7 @@ int evsel__parse_sample_timestamp(struct evsel *evsel, union perf_event *event,
 		array++;
 
 	if (type & PERF_SAMPLE_TIME)
-		*timestamp = *array;
+		*timestamp = perf_evsel_parse_time(evsel, *array);
 
 	return 0;
 }
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index d572be41b960..d1ef67852bda 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -269,6 +269,13 @@ static inline bool evsel__is_bpf(struct evsel *evsel)
 	return evsel->bpf_counter_ops != NULL;
 }
 
+static inline bool evsel__is_hw_event(struct evsel *evsel)
+{
+	return (evsel->core.attr.type == PERF_TYPE_HARDWARE) ||
+	       (evsel->core.attr.type == PERF_TYPE_HW_CACHE) ||
+	       (evsel->core.attr.type == PERF_TYPE_RAW);
+}
+
 #define EVSEL__MAX_ALIASES 8
 
 extern const char *const evsel__hw_cache[PERF_COUNT_HW_CACHE_MAX][EVSEL__MAX_ALIASES];
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 189149a7012f..d80d0c4e46da 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1725,6 +1725,7 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 		return tool->stat_round(session, event);
 	case PERF_RECORD_TIME_CONV:
 		session->time_conv = event->time_conv;
+		session->evlist->time_conv = &session->time_conv;
 		return tool->time_conv(session, event);
 	case PERF_RECORD_HEADER_FEATURE:
 		return tool->feature(session, event);
diff --git a/tools/perf/util/tsc.c b/tools/perf/util/tsc.c
index 0b59c0f815f9..5264f9d54be4 100644
--- a/tools/perf/util/tsc.c
+++ b/tools/perf/util/tsc.c
@@ -160,3 +160,15 @@ size_t perf_event__fprintf_time_conv(union perf_event *event, FILE *fp)
 
 	return ret;
 }
+
+u64 tsc_to_monotonic_raw(struct perf_record_time_conv *tc, u64 cyc)
+{
+	u64 delta;
+
+	if (!tc->cap_user_time_mono_raw)
+		return cyc;
+
+	delta = (cyc - tc->time_mono_last) * tc->time_mono_mult + tc->time_mono_nsec;
+	delta >>= tc->time_mono_shift;
+	return tc->time_mono_base + delta;
+}
diff --git a/tools/perf/util/tsc.h b/tools/perf/util/tsc.h
index 6bacc450a14d..2611d3de94b1 100644
--- a/tools/perf/util/tsc.h
+++ b/tools/perf/util/tsc.h
@@ -35,4 +35,6 @@ double arch_get_tsc_freq(void);
 
 size_t perf_event__fprintf_time_conv(union perf_event *event, FILE *fp);
 
+u64 tsc_to_monotonic_raw(struct perf_record_time_conv *tc, u64 cyc);
+
 #endif // __PERF_TSC_H
-- 
2.35.1

