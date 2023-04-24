Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FA66ECF92
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjDXNth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbjDXNtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:49:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21A02A246;
        Mon, 24 Apr 2023 06:48:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C211EFEC;
        Mon, 24 Apr 2023 06:49:21 -0700 (PDT)
Received: from e127643.arm.com (unknown [10.57.58.229])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6BFCB3F64C;
        Mon, 24 Apr 2023 06:48:34 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, coresight@lists.linaro.org,
        shy828301@gmail.com
Cc:     denik@google.com, James Clark <james.clark@arm.com>,
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
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] perf: cs-etm: Add separate decode paths for timeless and per-thread modes
Date:   Mon, 24 Apr 2023 14:47:47 +0100
Message-Id: <20230424134748.228137-8-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230424134748.228137-1-james.clark@arm.com>
References: <20230424134748.228137-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Timeless and per-thread are orthogonal concepts that are currently
treated as if they are the same (per-thread == timeless). This breaks
when you modify the command line or itrace options to something that the
current logic doesn't expect.

For example:

  # Force timeless with Z
  --itrace=Zi10i

  # Or inconsistent record options
  -e cs_etm/timestamp=1/ --per-thread

Adding Z for decoding in per-cpu mode is particularly bad because in
per-thread mode trace channel IDs are discarded and all assumed to be 0,
which would mix trace from different CPUs in per-cpu mode.

Although the results might not be perfect in all scenarios, if the user
requests no timestamps, it should still be possible to decode in either
mode. Especially if the relative times of samples in different processes
aren't interesting, quite a bit of space can be saved by turning off
timestamps in per-cpu mode.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/tests/shell/test_arm_coresight.sh |  24 +++
 tools/perf/util/cs-etm.c                     | 162 ++++++++++++++-----
 2 files changed, 148 insertions(+), 38 deletions(-)

diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
index 565ce525c40b..482009e17bda 100755
--- a/tools/perf/tests/shell/test_arm_coresight.sh
+++ b/tools/perf/tests/shell/test_arm_coresight.sh
@@ -150,6 +150,8 @@ arm_cs_etm_system_wide_test() {
 	echo "Recording trace with system wide mode"
 	perf record -o ${perfdata} -e cs_etm// -a -- ls > /dev/null 2>&1
 
+	# System-wide mode should include perf samples so test for that
+	# instead of ls
 	perf_script_branch_samples perf &&
 	perf_report_branch_samples perf &&
 	perf_report_instruction_samples perf
@@ -182,7 +184,29 @@ arm_cs_etm_snapshot_test() {
 	arm_cs_report "CoreSight snapshot testing" $err
 }
 
+arm_cs_etm_basic_test() {
+	echo "Recording trace with '$*'"
+	perf record -o ${perfdata} "$@" -- ls > /dev/null 2>&1
+
+	perf_script_branch_samples ls &&
+	perf_report_branch_samples ls &&
+	perf_report_instruction_samples ls
+
+	err=$?
+	arm_cs_report "CoreSight basic testing with '$*'" $err
+}
+
 arm_cs_etm_traverse_path_test
 arm_cs_etm_system_wide_test
 arm_cs_etm_snapshot_test
+
+# Test all combinations of per-thread, system-wide and normal mode with
+# and without timestamps
+arm_cs_etm_basic_test -e cs_etm/timestamp=0/ --per-thread
+arm_cs_etm_basic_test -e cs_etm/timestamp=1/ --per-thread
+arm_cs_etm_basic_test -e cs_etm/timestamp=0/ -a
+arm_cs_etm_basic_test -e cs_etm/timestamp=1/ -a
+arm_cs_etm_basic_test -e cs_etm/timestamp=0/
+arm_cs_etm_basic_test -e cs_etm/timestamp=1/
+
 exit $glb_err
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index e048949bf655..456994564d6e 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -50,7 +50,22 @@ struct cs_etm_auxtrace {
 	struct thread *unknown_thread;
 	struct perf_tsc_conversion tc;
 
+	/*
+	 * Timeless has no timestamps in the trace so overlapping mmap lookups
+	 * are less accurate but produces smaller trace data. We use context IDs
+	 * in the trace instead of matching timestamps with fork records so
+	 * they're not really needed in the general case. Overlapping mmaps
+	 * happen in cases like between a fork and an exec.
+	 */
 	bool timeless_decoding;
+
+	/*
+	 * Per-thread ignores the trace channel ID and instead assumes that
+	 * everything in a buffer comes from the same process regardless of
+	 * which CPU it ran on. It also implies no context IDs so the TID is
+	 * taken from the auxtrace buffer.
+	 */
+	bool per_thread_decoding;
 	bool snapshot_mode;
 	bool data_queued;
 	bool has_virtual_ts; /* Virtual/Kernel timestamps in the trace. */
@@ -98,7 +113,7 @@ struct cs_etm_queue {
 /* RB tree for quick conversion between traceID and metadata pointers */
 static struct intlist *traceid_list;
 
-static int cs_etm__process_queues(struct cs_etm_auxtrace *etm);
+static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm);
 static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
 					   pid_t tid);
 static int cs_etm__get_data_block(struct cs_etm_queue *etmq);
@@ -492,7 +507,7 @@ static struct cs_etm_traceid_queue
 	struct cs_etm_traceid_queue *tidq, **traceid_queues;
 	struct cs_etm_auxtrace *etm = etmq->etm;
 
-	if (etm->timeless_decoding)
+	if (etm->per_thread_decoding)
 		trace_chan_id = CS_ETM_PER_THREAD_TRACEID;
 
 	traceid_queues_list = etmq->traceid_queues_list;
@@ -731,10 +746,15 @@ static int cs_etm__flush_events(struct perf_session *session,
 	if (!tool->ordered_events)
 		return -EINVAL;
 
-	if (etm->timeless_decoding)
+	if (etm->timeless_decoding) {
+		/*
+		 * Pass tid = -1 to process all queues. But likely they will have
+		 * already been processed on PERF_RECORD_EXIT anyway.
+		 */
 		return cs_etm__process_timeless_queues(etm, -1);
+	}
 
-	return cs_etm__process_queues(etm);
+	return cs_etm__process_timestamped_queues(etm);
 }
 
 static void cs_etm__free_traceid_queues(struct cs_etm_queue *etmq)
@@ -1066,7 +1086,7 @@ static int cs_etm__queue_first_cs_timestamp(struct cs_etm_auxtrace *etm,
 	 * chronological order.
 	 *
 	 * Note that packets decoded above are still in the traceID's packet
-	 * queue and will be processed in cs_etm__process_queues().
+	 * queue and will be processed in cs_etm__process_timestamped_queues().
 	 */
 	cs_queue_nr = TO_CS_QUEUE_NR(queue_nr, trace_chan_id);
 	ret = auxtrace_heap__add(&etm->heap, cs_queue_nr, cs_timestamp);
@@ -1347,9 +1367,7 @@ static inline u64 cs_etm__resolve_sample_time(struct cs_etm_queue *etmq,
 	struct cs_etm_auxtrace *etm = etmq->etm;
 	struct cs_etm_packet_queue *packet_queue = &tidq->packet_queue;
 
-	if (etm->timeless_decoding)
-		return 0;
-	else if (etm->has_virtual_ts)
+	if (!etm->timeless_decoding && etm->has_virtual_ts)
 		return packet_queue->cs_timestamp;
 	else
 		return etm->latest_kernel_timestamp;
@@ -2329,7 +2347,7 @@ static void cs_etm__clear_all_traceid_queues(struct cs_etm_queue *etmq)
 	}
 }
 
-static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
+static int cs_etm__run_per_thread_timeless_decoder(struct cs_etm_queue *etmq)
 {
 	int err = 0;
 	struct cs_etm_traceid_queue *tidq;
@@ -2367,6 +2385,51 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 	return err;
 }
 
+static int cs_etm__run_per_cpu_timeless_decoder(struct cs_etm_queue *etmq)
+{
+	int idx, err = 0;
+	struct cs_etm_traceid_queue *tidq;
+	struct int_node *inode;
+
+	/* Go through each buffer in the queue and decode them one by one */
+	while (1) {
+		err = cs_etm__get_data_block(etmq);
+		if (err <= 0)
+			return err;
+
+		/* Run trace decoder until buffer consumed or end of trace */
+		do {
+			err = cs_etm__decode_data_block(etmq);
+			if (err)
+				return err;
+
+			/*
+			 * cs_etm__run_per_thread_timeless_decoder() runs on a
+			 * single traceID queue because each TID has a separate
+			 * buffer. But here in per-cpu mode we need to iterate
+			 * over each channel instead.
+			 */
+			intlist__for_each_entry(inode,
+						etmq->traceid_queues_list) {
+				idx = (int)(intptr_t)inode->priv;
+				tidq = etmq->traceid_queues[idx];
+				cs_etm__process_traceid_queue(etmq, tidq);
+			}
+		} while (etmq->buf_len);
+
+		intlist__for_each_entry(inode, etmq->traceid_queues_list) {
+			idx = (int)(intptr_t)inode->priv;
+			tidq = etmq->traceid_queues[idx];
+			/* Flush any remaining branch stack entries */
+			err = cs_etm__end_block(etmq, tidq);
+			if (err)
+				return err;
+		}
+	}
+
+	return err;
+}
+
 static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
 					   pid_t tid)
 {
@@ -2381,22 +2444,30 @@ static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
 		if (!etmq)
 			continue;
 
-		tidq = cs_etm__etmq_get_traceid_queue(etmq,
-						CS_ETM_PER_THREAD_TRACEID);
+		/*
+		 * Per-cpu mode has contextIDs in the trace and the decoder
+		 * calls cs_etm__set_pid_tid_cpu() automatically so no need
+		 * to do this here
+		 */
+		if (etm->per_thread_decoding) {
+			tidq = cs_etm__etmq_get_traceid_queue(
+				etmq, CS_ETM_PER_THREAD_TRACEID);
 
-		if (!tidq)
-			continue;
+			if (!tidq)
+				continue;
 
-		if ((tid == -1) || (tidq->tid == tid)) {
-			cs_etm__set_pid_tid_cpu(etm, tidq);
-			cs_etm__run_decoder(etmq);
-		}
+			if ((tid == -1) || (tidq->tid == tid)) {
+				cs_etm__set_pid_tid_cpu(etm, tidq);
+				cs_etm__run_per_thread_timeless_decoder(etmq);
+			}
+		} else
+			cs_etm__run_per_cpu_timeless_decoder(etmq);
 	}
 
 	return 0;
 }
 
-static int cs_etm__process_queues(struct cs_etm_auxtrace *etm)
+static int cs_etm__process_timestamped_queues(struct cs_etm_auxtrace *etm)
 {
 	int ret = 0;
 	unsigned int cs_queue_nr, queue_nr, i;
@@ -2573,7 +2644,6 @@ static int cs_etm__process_event(struct perf_session *session,
 				 struct perf_sample *sample,
 				 struct perf_tool *tool)
 {
-	u64 sample_kernel_timestamp;
 	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
 						   struct cs_etm_auxtrace,
 						   auxtrace);
@@ -2586,33 +2656,39 @@ static int cs_etm__process_event(struct perf_session *session,
 		return -EINVAL;
 	}
 
-	if (sample->time && (sample->time != (u64) -1))
-		sample_kernel_timestamp = sample->time;
-	else
-		sample_kernel_timestamp = 0;
-
-	/*
-	 * Don't wait for cs_etm__flush_events() in per-thread/timeless mode to start the decode. We
-	 * need the tid of the PERF_RECORD_EXIT event to assign to the synthesised samples because
-	 * ETM_OPT_CTXTID is not enabled.
-	 */
-	if (etm->timeless_decoding &&
-	    event->header.type == PERF_RECORD_EXIT)
-		return cs_etm__process_timeless_queues(etm,
-						       event->fork.tid);
+	switch (event->header.type) {
+	case PERF_RECORD_EXIT:
+		/*
+		 * Don't need to wait for cs_etm__flush_events() in per-thread mode to
+		 * start the decode because we know there will be no more trace from
+		 * this thread. All this does is emit samples earlier than waiting for
+		 * the flush in other modes, but with timestamps it makes sense to wait
+		 * for flush so that events from different threads are interleaved
+		 * properly.
+		 */
+		if (etm->per_thread_decoding && etm->timeless_decoding)
+			return cs_etm__process_timeless_queues(etm,
+							       event->fork.tid);
+		break;
 
-	if (event->header.type == PERF_RECORD_ITRACE_START)
+	case PERF_RECORD_ITRACE_START:
 		return cs_etm__process_itrace_start(etm, event);
-	else if (event->header.type == PERF_RECORD_SWITCH_CPU_WIDE)
+
+	case PERF_RECORD_SWITCH_CPU_WIDE:
 		return cs_etm__process_switch_cpu_wide(etm, event);
 
-	if (!etm->timeless_decoding && event->header.type == PERF_RECORD_AUX) {
+	case PERF_RECORD_AUX:
 		/*
 		 * Record the latest kernel timestamp available in the header
 		 * for samples so that synthesised samples occur from this point
 		 * onwards.
 		 */
-		etm->latest_kernel_timestamp = sample_kernel_timestamp;
+		if (sample->time && (sample->time != (u64)-1))
+			etm->latest_kernel_timestamp = sample->time;
+		break;
+
+	default:
+		break;
 	}
 
 	return 0;
@@ -2821,10 +2897,20 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
 	 * Return 'not found' if mismatch.
 	 */
 	if (auxtrace_event->cpu == (__u32) -1) {
+		etm->per_thread_decoding = true;
 		if (auxtrace_event->tid != sample->tid)
 			return 1;
-	} else if (auxtrace_event->cpu != sample->cpu)
+	} else if (auxtrace_event->cpu != sample->cpu) {
+		if (etm->per_thread_decoding) {
+			/*
+			 * Found a per-cpu buffer after a per-thread one was
+			 * already found
+			 */
+			pr_err("CS ETM: Inconsistent per-thread/per-cpu mode.\n");
+			return -EINVAL;
+		}
 		return 1;
+	}
 
 	if (aux_event->flags & PERF_AUX_FLAG_OVERWRITE) {
 		/*
-- 
2.34.1

