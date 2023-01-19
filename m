Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C71673DDC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 16:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjASPrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 10:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjASPq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 10:46:58 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13D9480898;
        Thu, 19 Jan 2023 07:46:22 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 589601BB0;
        Thu, 19 Jan 2023 07:47:03 -0800 (PST)
Received: from e126815.warwick.arm.com (e126815.arm.com [10.32.32.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B039D3F445;
        Thu, 19 Jan 2023 07:46:18 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, tanmay@marvell.com,
        leo.yan@linaro.org, mike.leach@linaro.org
Cc:     sgoutham@marvell.com, gcherian@marvell.com, lcherian@marvell.com,
        bbhushan2@marvell.com, German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
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
Subject: [PATCH v4 7/8] perf cs_etm: Set the time field in the synthetic samples
Date:   Thu, 19 Jan 2023 15:43:06 +0000
Message-Id: <20230119154308.3815108-8-james.clark@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230119154308.3815108-1-james.clark@arm.com>
References: <20230119154308.3815108-1-james.clark@arm.com>
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
otherwise warn the user that the samples will not include accurate
time data.

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

Now that times are converted to nanoseconds, also try to estimate the
timestamps more accurately be dividing by some fixed value for
instructions per ns. This prevents long ranges from being estimated
too far in the past than would be realistic.

Signed-off-by: German Gomez <german.gomez@arm.com>
Signed-off-by: James Clark <james.clark@arm.com>
---
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 47 +++++++++--
 tools/perf/util/cs-etm.c                      | 83 ++++++++++++++++++-
 tools/perf/util/cs-etm.h                      |  3 +-
 3 files changed, 120 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 31fa3b45134a..440fe844ed17 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -30,6 +30,15 @@
 #endif
 #endif
 
+/*
+ * Assume a maximum of 0.1ns elapsed per instruction. This would be the
+ * case with a theoretical 10GHz core executing 1 instruction per cycle.
+ * Used to estimate the sample time for synthesized instructions because
+ * Coresight only emits a timestamp for a range of instructions rather
+ * than per instruction.
+ */
+const u32 INSTR_PER_NS = 10;
+
 struct cs_etm_decoder {
 	void *data;
 	void (*packet_printer)(const char *msg);
@@ -112,6 +121,20 @@ int cs_etm_decoder__get_packet(struct cs_etm_packet_queue *packet_queue,
 	return 1;
 }
 
+/*
+ * Calculate the number of nanoseconds elapsed.
+ *
+ * instr_count is updated in place with the remainder of the instructions
+ * which didn't make up a whole nanosecond.
+ */
+static u32 cs_etm_decoder__dec_instr_count_to_ns(u32 *instr_count)
+{
+	const u32 instr_copy = *instr_count;
+
+	*instr_count %= INSTR_PER_NS;
+	return instr_copy / INSTR_PER_NS;
+}
+
 static int cs_etm_decoder__gen_etmv3_config(struct cs_etm_trace_params *params,
 					    ocsd_etmv3_cfg *config)
 {
@@ -267,8 +290,8 @@ cs_etm_decoder__do_soft_timestamp(struct cs_etm_queue *etmq,
 	packet_queue->cs_timestamp = packet_queue->next_cs_timestamp;
 
 	/* Estimate the timestamp for the next range packet */
-	packet_queue->next_cs_timestamp += packet_queue->instr_count;
-	packet_queue->instr_count = 0;
+	packet_queue->next_cs_timestamp +=
+		cs_etm_decoder__dec_instr_count_to_ns(&packet_queue->instr_count);
 
 	/* Tell the front end which traceid_queue needs attention */
 	cs_etm__etmq_set_traceid_queue_timestamp(etmq, trace_chan_id);
@@ -283,24 +306,31 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
 				  const ocsd_trc_index_t indx)
 {
 	struct cs_etm_packet_queue *packet_queue;
+	u64 converted_timestamp;
 
 	/* First get the packet queue for this traceID */
 	packet_queue = cs_etm__etmq_get_packet_queue(etmq, trace_chan_id);
 	if (!packet_queue)
 		return OCSD_RESP_FATAL_SYS_ERR;
 
+	/*
+	 * Coresight timestamps are raw timer values which need to be scaled to ns. Assume
+	 * 0 is a bad value so don't try to convert it.
+	 */
+	converted_timestamp = elem->timestamp ?
+				cs_etm__convert_sample_time(etmq, elem->timestamp) : 0;
+
 	/*
 	 * We've seen a timestamp packet before - simply record the new value.
 	 * Function do_soft_timestamp() will report the value to the front end,
 	 * hence asking the decoder to keep decoding rather than stopping.
 	 */
 	if (packet_queue->cs_timestamp) {
-		packet_queue->next_cs_timestamp = elem->timestamp;
+		packet_queue->next_cs_timestamp = converted_timestamp;
 		return OCSD_RESP_CONT;
 	}
 
-
-	if (!elem->timestamp) {
+	if (!converted_timestamp) {
 		/*
 		 * Zero timestamps can be seen due to misconfiguration or hardware bugs.
 		 * Warn once, and don't try to subtract instr_count as it would result in an
@@ -312,7 +342,7 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
 					". Decoding may be improved by prepending 'Z' to your current --itrace arguments.\n",
 					indx);
 
-	} else if (packet_queue->instr_count > elem->timestamp) {
+	} else if (packet_queue->instr_count / INSTR_PER_NS > converted_timestamp) {
 		/*
 		 * Sanity check that the elem->timestamp - packet_queue->instr_count would not
 		 * result in an underflow. Warn and clamp at 0 if it would.
@@ -327,9 +357,10 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
 		 * which instructions started by subtracting the number of instructions
 		 * executed to the timestamp.
 		 */
-		packet_queue->cs_timestamp = elem->timestamp - packet_queue->instr_count;
+		packet_queue->cs_timestamp = converted_timestamp -
+						(packet_queue->instr_count / INSTR_PER_NS);
 	}
-	packet_queue->next_cs_timestamp = elem->timestamp;
+	packet_queue->next_cs_timestamp = converted_timestamp;
 	packet_queue->instr_count = 0;
 
 	/* Tell the front end which traceid_queue needs attention */
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 879576d5f899..f65bac5ddbdb 100644
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
@@ -1161,6 +1164,30 @@ static void cs_etm__copy_insn(struct cs_etm_queue *etmq,
 			   sample->insn_len, (void *)sample->insn);
 }
 
+u64 cs_etm__convert_sample_time(struct cs_etm_queue *etmq, u64 cs_timestamp)
+{
+	struct cs_etm_auxtrace *etm = etmq->etm;
+
+	if (etm->has_virtual_ts)
+		return tsc_to_perf_time(cs_timestamp, &etm->tc);
+	else
+		return cs_timestamp;
+}
+
+static inline u64 cs_etm__resolve_sample_time(struct cs_etm_queue *etmq,
+					       struct cs_etm_traceid_queue *tidq)
+{
+	struct cs_etm_auxtrace *etm = etmq->etm;
+	struct cs_etm_packet_queue *packet_queue = &tidq->packet_queue;
+
+	if (etm->timeless_decoding)
+		return 0;
+	else if (etm->has_virtual_ts)
+		return packet_queue->cs_timestamp;
+	else
+		return etm->latest_kernel_timestamp;
+}
+
 static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 					    struct cs_etm_traceid_queue *tidq,
 					    u64 addr, u64 period)
@@ -1174,8 +1201,9 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 	event->sample.header.misc = cs_etm__cpu_mode(etmq, addr);
 	event->sample.header.size = sizeof(struct perf_event_header);
 
-	if (!etm->timeless_decoding)
-		sample.time = etm->latest_kernel_timestamp;
+	/* Set time field based on etm auxtrace config. */
+	sample.time = cs_etm__resolve_sample_time(etmq, tidq);
+
 	sample.ip = addr;
 	sample.pid = tidq->pid;
 	sample.tid = tidq->tid;
@@ -1232,8 +1260,9 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
 	event->sample.header.misc = cs_etm__cpu_mode(etmq, ip);
 	event->sample.header.size = sizeof(struct perf_event_header);
 
-	if (!etm->timeless_decoding)
-		sample.time = etm->latest_kernel_timestamp;
+	/* Set time field based on etm auxtrace config. */
+	sample.time = cs_etm__resolve_sample_time(etmq, tidq);
+
 	sample.ip = ip;
 	sample.pid = tidq->pid;
 	sample.tid = tidq->tid;
@@ -2746,12 +2775,42 @@ static int cs_etm__queue_aux_records(struct perf_session *session)
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
@@ -2886,6 +2945,13 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	etm->auxtrace_type = auxtrace_info->type;
 	etm->timeless_decoding = cs_etm__is_timeless_decoding(etm);
 
+	/* Use virtual timestamps if all ETMs report ts_source = 1 */
+	etm->has_virtual_ts = cs_etm__has_virtual_ts(metadata, num_cpu);
+
+	if (!etm->has_virtual_ts)
+		ui__warning("Virtual timestamps are not enabled, or not supported by the traced system.\n"
+			    "The time field of the samples will not be set accurately.\n\n");
+
 	etm->auxtrace.process_event = cs_etm__process_event;
 	etm->auxtrace.process_auxtrace_event = cs_etm__process_auxtrace_event;
 	etm->auxtrace.flush_events = cs_etm__flush_events;
@@ -2915,6 +2981,15 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
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
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index ad790930bcbc..98a4f7113d2f 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -192,7 +192,7 @@ struct cs_etm_packet_queue {
 	u32 head;
 	u32 tail;
 	u32 instr_count;
-	u64 cs_timestamp;
+	u64 cs_timestamp; /* Timestamp from trace data, converted to ns if possible */
 	u64 next_cs_timestamp;
 	struct cs_etm_packet packet_buffer[CS_ETM_PACKET_MAX_BUFFER];
 };
@@ -231,6 +231,7 @@ struct cs_etm_packet_queue
 *cs_etm__etmq_get_packet_queue(struct cs_etm_queue *etmq, u8 trace_chan_id);
 int cs_etm__process_auxtrace_info_full(union perf_event *event __maybe_unused,
 				       struct perf_session *session __maybe_unused);
+u64 cs_etm__convert_sample_time(struct cs_etm_queue *etmq, u64 cs_timestamp);
 #else
 static inline int
 cs_etm__process_auxtrace_info_full(union perf_event *event __maybe_unused,
-- 
2.25.1

