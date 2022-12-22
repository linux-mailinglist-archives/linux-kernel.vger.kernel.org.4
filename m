Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872B16544D8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 17:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiLVQIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 11:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiLVQHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 11:07:55 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6196D31DF6;
        Thu, 22 Dec 2022 08:07:47 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34D512F4;
        Thu, 22 Dec 2022 08:08:28 -0800 (PST)
Received: from e126815.warwick.arm.com (e126815.arm.com [10.32.32.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1CEDA3FAFB;
        Thu, 22 Dec 2022 08:07:44 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, tanmay@marvell.com
Cc:     sgoutham@marvell.com, gcherian@marvell.com, lcherian@marvell.com,
        bbhushan2@marvell.com, German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] perf cs_etm: Set the time field in the synthetic samples
Date:   Thu, 22 Dec 2022 16:03:27 +0000
Message-Id: <20221222160328.3639989-8-james.clark@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221222160328.3639989-1-james.clark@arm.com>
References: <20221222160328.3639989-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: German Gomez <german.gomez@arm.com>

If virtual timestamps are detected, set sample time field accordingly,
otherwise warn the user that the samples will not include the time data.

 | Test notes (FEAT_TRF platform)
 |
 | $ ./perf record -e cs_etm//u -a -- sleep 4
 | $ ./perf script --fields +time
 | 	    perf   422 [000]   163.375100:          1 branches:uH:                 0 [unknown] ([unknown])
 | 	    perf   422 [000]   163.375100:          1 branches:uH:      ffffb8009544 ioctl+0x14 (/lib/aarch64-linux-gnu/libc-2.27.so)
 | 	    perf   422 [000]   163.375100:          1 branches:uH:      aaaaab6bebf4 perf_evsel__run_ioctl+0x90 (/home/german/linux/tools/perf/perf)
 | [...]
 | 	    perf   422 [000]   167.393100:          1 branches:uH:      aaaaab6bda00 __xyarray__entry+0x74 (/home/german/linux/tools/perf/perf)
 | 	    perf   422 [000]   167.393099:          1 branches:uH:      aaaaab6bda0c __xyarray__entry+0x80 (/home/german/linux/tools/perf/perf)
 | 	    perf   422 [000]   167.393099:          1 branches:uH:      ffffb8009538 ioctl+0x8 (/lib/aarch64-linux-gnu/libc-2.27.so)
 |
 | The time from the first sample to the last sample is 4 seconds

Signed-off-by: German Gomez <german.gomez@arm.com>
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm.c | 74 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 70 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 879576d5f899..57a381eaaa6a 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -35,6 +35,7 @@
 #include "tool.h"
 #include "thread.h"
 #include "thread-stack.h"
+#include "tsc.h"
 #include <tools/libc_compat.h>
 #include "util/synthetic-events.h"
 
@@ -46,10 +47,12 @@ struct cs_etm_auxtrace {
 	struct perf_session *session;
 	struct machine *machine;
 	struct thread *unknown_thread;
+	struct perf_tsc_conversion tc;
 
 	u8 timeless_decoding;
 	u8 snapshot_mode;
 	u8 data_queued;
+	u8 has_virtual_ts; /* Virtual/Kernel timestamps in the trace. */
 
 	int num_cpu;
 	u64 latest_kernel_timestamp;
@@ -1161,6 +1164,22 @@ static void cs_etm__copy_insn(struct cs_etm_queue *etmq,
 			   sample->insn_len, (void *)sample->insn);
 }
 
+static inline void cs_etm__resolve_sample_time(struct cs_etm_queue *etmq,
+					       struct cs_etm_traceid_queue *tidq,
+					       u64 *time)
+{
+	struct cs_etm_auxtrace *etm = etmq->etm;
+	struct cs_etm_packet_queue *packet_queue = &tidq->packet_queue;
+
+	if (etm->timeless_decoding)
+		*time = 0;
+	else if (etm->has_virtual_ts)
+		*time = tsc_to_perf_time(packet_queue->cs_timestamp, &etm->tc);
+	else
+		*time = etm->latest_kernel_timestamp;
+
+}
+
 static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 					    struct cs_etm_traceid_queue *tidq,
 					    u64 addr, u64 period)
@@ -1174,8 +1193,9 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 	event->sample.header.misc = cs_etm__cpu_mode(etmq, addr);
 	event->sample.header.size = sizeof(struct perf_event_header);
 
-	if (!etm->timeless_decoding)
-		sample.time = etm->latest_kernel_timestamp;
+	/* Set time field based con etm auxtrace config. */
+	cs_etm__resolve_sample_time(etmq, tidq, &sample.time);
+
 	sample.ip = addr;
 	sample.pid = tidq->pid;
 	sample.tid = tidq->tid;
@@ -1232,8 +1252,9 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
 	event->sample.header.misc = cs_etm__cpu_mode(etmq, ip);
 	event->sample.header.size = sizeof(struct perf_event_header);
 
-	if (!etm->timeless_decoding)
-		sample.time = etm->latest_kernel_timestamp;
+	/* Set time field based con etm auxtrace config. */
+	cs_etm__resolve_sample_time(etmq, tidq, &sample.time);
+
 	sample.ip = ip;
 	sample.pid = tidq->pid;
 	sample.tid = tidq->tid;
@@ -2746,12 +2767,42 @@ static int cs_etm__queue_aux_records(struct perf_session *session)
 	return 0;
 }
 
+#define HAS_PARAM(j, type, param) (metadata[(j)][CS_ETM_NR_TRC_PARAMS] <= \
+				  (CS_##type##_##param - CS_ETM_COMMON_BLK_MAX_V1))
+
+/*
+ * Loop through the ETMs and complain if we find at least one where ts_source != 1 (virtual
+ * timestamps).
+ */
+static bool cs_etm__has_virtual_ts(u64 **metadata, int num_cpu)
+{
+	int j;
+
+	for (j = 0; j < num_cpu; j++) {
+		switch (metadata[j][CS_ETM_MAGIC]) {
+		case __perf_cs_etmv4_magic:
+			if (HAS_PARAM(j, ETMV4, TS_SOURCE) || metadata[j][CS_ETMV4_TS_SOURCE] != 1)
+				return false;
+			break;
+		case __perf_cs_ete_magic:
+			if (HAS_PARAM(j, ETE, TS_SOURCE) || metadata[j][CS_ETE_TS_SOURCE] != 1)
+				return false;
+			break;
+		default:
+			/* Unknown / unsupported magic number. */
+			return false;
+		}
+	}
+	return true;
+}
+
 int cs_etm__process_auxtrace_info_full(union perf_event *event,
 				       struct perf_session *session)
 {
 	struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
 	struct cs_etm_auxtrace *etm = NULL;
 	struct int_node *inode;
+	struct perf_record_time_conv *tc = &session->time_conv;
 	int event_header_size = sizeof(struct perf_event_header);
 	int total_size = auxtrace_info->header.size;
 	int priv_size = 0;
@@ -2886,6 +2937,12 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	etm->auxtrace_type = auxtrace_info->type;
 	etm->timeless_decoding = cs_etm__is_timeless_decoding(etm);
 
+	/* Use virtual timestamps if all ETMs report ts_source = 1 */
+	etm->has_virtual_ts = cs_etm__has_virtual_ts(metadata, num_cpu);
+
+	if (!etm->has_virtual_ts)
+		ui__warning("Virtual timestamps are not enabled, or not supported by the traced system.\n\nThe time field of the samples will not be set.\n\n");
+
 	etm->auxtrace.process_event = cs_etm__process_event;
 	etm->auxtrace.process_auxtrace_event = cs_etm__process_auxtrace_event;
 	etm->auxtrace.flush_events = cs_etm__flush_events;
@@ -2915,6 +2972,15 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 		goto err_delete_thread;
 	}
 
+	etm->tc.time_shift = tc->time_shift;
+	etm->tc.time_mult = tc->time_mult;
+	etm->tc.time_zero = tc->time_zero;
+	if (event_contains(*tc, time_cycles)) {
+		etm->tc.time_cycles = tc->time_cycles;
+		etm->tc.time_mask = tc->time_mask;
+		etm->tc.cap_user_time_zero = tc->cap_user_time_zero;
+		etm->tc.cap_user_time_short = tc->cap_user_time_short;
+	}
 	err = cs_etm__synth_events(etm, session);
 	if (err)
 		goto err_delete_thread;
-- 
2.25.1

