Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92D770F77B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 15:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbjEXNUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 09:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjEXNUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 09:20:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 630539B;
        Wed, 24 May 2023 06:20:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 327D4113E;
        Wed, 24 May 2023 06:21:00 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 886593F840;
        Wed, 24 May 2023 06:20:12 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, denik@chromium.org
Cc:     James Clark <james.clark@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] perf cs-etm: Only track threads instead of PID and TIDs
Date:   Wed, 24 May 2023 14:19:55 +0100
Message-Id: <20230524131958.2139331-2-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230524131958.2139331-1-james.clark@arm.com>
References: <20230524131958.2139331-1-james.clark@arm.com>
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

PIDs and TIDs are already contained within the thread struct, so to
avoid inconsistencies drop the extra members on the etm queue and only
use the thread struct.

At the same time stop using the 'unknown' thread. In a later commit
we will be making samples from multiple machines so it will be better
to use the idle thread of each machine rather than overlapping unknown
threads. Using the idle thread is also better because kernel addresses
with a previously unknown thread will now be assigned to a real kernel
thread.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm.c | 124 ++++++++++++---------------------------
 1 file changed, 38 insertions(+), 86 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 91299cc56bf7..ebffc9052561 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -46,8 +46,6 @@ struct cs_etm_auxtrace {
 	struct auxtrace_heap heap;
 	struct itrace_synth_opts synth_opts;
 	struct perf_session *session;
-	struct machine *machine;
-	struct thread *unknown_thread;
 	struct perf_tsc_conversion tc;
 
 	/*
@@ -84,7 +82,6 @@ struct cs_etm_auxtrace {
 
 struct cs_etm_traceid_queue {
 	u8 trace_chan_id;
-	pid_t pid, tid;
 	u64 period_instructions;
 	size_t last_branch_pos;
 	union perf_event *event_buf;
@@ -480,9 +477,9 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
 	cs_etm__clear_packet_queue(&tidq->packet_queue);
 
 	queue = &etmq->etm->queues.queue_array[etmq->queue_nr];
-	tidq->tid = queue->tid;
-	tidq->pid = -1;
 	tidq->trace_chan_id = trace_chan_id;
+	tidq->thread = machine__findnew_thread(&etm->session->machines.host, -1,
+					       queue->tid);
 
 	tidq->packet = zalloc(sizeof(struct cs_etm_packet));
 	if (!tidq->packet)
@@ -863,7 +860,6 @@ static void cs_etm__free(struct perf_session *session)
 	for (i = 0; i < aux->num_cpu; i++)
 		zfree(&aux->metadata[i]);
 
-	thread__zput(aux->unknown_thread);
 	zfree(&aux->metadata);
 	zfree(&aux);
 }
@@ -882,7 +878,7 @@ static u8 cs_etm__cpu_mode(struct cs_etm_queue *etmq, u64 address)
 {
 	struct machine *machine;
 
-	machine = etmq->etm->machine;
+	machine = &etmq->etm->session->machines.host;
 
 	if (address >= machine__kernel_start(machine)) {
 		if (machine__is_host(machine))
@@ -905,8 +901,6 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
 	u8  cpumode;
 	u64 offset;
 	int len;
-	struct thread *thread;
-	struct machine *machine;
 	struct addr_location al;
 	struct dso *dso;
 	struct cs_etm_traceid_queue *tidq;
@@ -914,20 +908,12 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
 	if (!etmq)
 		return 0;
 
-	machine = etmq->etm->machine;
 	cpumode = cs_etm__cpu_mode(etmq, address);
 	tidq = cs_etm__etmq_get_traceid_queue(etmq, trace_chan_id);
 	if (!tidq)
 		return 0;
 
-	thread = tidq->thread;
-	if (!thread) {
-		if (cpumode != PERF_RECORD_MISC_KERNEL)
-			return 0;
-		thread = etmq->etm->unknown_thread;
-	}
-
-	if (!thread__find_map(thread, cpumode, address, &al))
+	if (!thread__find_map(tidq->thread, cpumode, address, &al))
 		return 0;
 
 	dso = map__dso(al.map);
@@ -942,7 +928,8 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
 
 	map__load(al.map);
 
-	len = dso__data_read_offset(dso, machine, offset, buffer, size);
+	len = dso__data_read_offset(dso, maps__machine(tidq->thread->maps),
+				    offset, buffer, size);
 
 	if (len <= 0) {
 		ui__warning_once("CS ETM Trace: Missing DSO. Use 'perf archive' or debuginfod to export data from the traced system.\n"
@@ -1303,39 +1290,31 @@ cs_etm__get_trace(struct cs_etm_queue *etmq)
 	return etmq->buf_len;
 }
 
-static void cs_etm__set_pid_tid_cpu(struct cs_etm_auxtrace *etm,
-				    struct cs_etm_traceid_queue *tidq)
+static void cs_etm__set_thread(struct cs_etm_auxtrace *etm,
+			       struct cs_etm_traceid_queue *tidq, pid_t tid)
 {
-	if ((!tidq->thread) && (tidq->tid != -1))
-		tidq->thread = machine__find_thread(etm->machine, -1,
-						    tidq->tid);
+	struct machine *machine = &etm->session->machines.host;
+
+	if (tid != -1) {
+		thread__zput(tidq->thread);
+		tidq->thread = machine__find_thread(machine, -1, tid);
+	}
 
-	if (tidq->thread)
-		tidq->pid = tidq->thread->pid_;
+	/* Couldn't find a known thread */
+	if (!tidq->thread)
+		tidq->thread = machine__idle_thread(machine);
 }
 
 int cs_etm__etmq_set_tid(struct cs_etm_queue *etmq,
 			 pid_t tid, u8 trace_chan_id)
 {
-	int cpu, err = -EINVAL;
-	struct cs_etm_auxtrace *etm = etmq->etm;
 	struct cs_etm_traceid_queue *tidq;
 
 	tidq = cs_etm__etmq_get_traceid_queue(etmq, trace_chan_id);
 	if (!tidq)
-		return err;
-
-	if (cs_etm__get_cpu(trace_chan_id, &cpu) < 0)
-		return err;
-
-	err = machine__set_current_tid(etm->machine, cpu, tid, tid);
-	if (err)
-		return err;
-
-	tidq->tid = tid;
-	thread__zput(tidq->thread);
+		return -EINVAL;
 
-	cs_etm__set_pid_tid_cpu(etm, tidq);
+	cs_etm__set_thread(etmq->etm, tidq, tid);
 	return 0;
 }
 
@@ -1412,8 +1391,8 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 	sample.time = cs_etm__resolve_sample_time(etmq, tidq);
 
 	sample.ip = addr;
-	sample.pid = tidq->pid;
-	sample.tid = tidq->tid;
+	sample.pid = tidq->thread->pid_;
+	sample.tid = tidq->thread->tid;
 	sample.id = etmq->etm->instructions_id;
 	sample.stream_id = etmq->etm->instructions_id;
 	sample.period = period;
@@ -1471,8 +1450,8 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
 	sample.time = cs_etm__resolve_sample_time(etmq, tidq);
 
 	sample.ip = ip;
-	sample.pid = tidq->pid;
-	sample.tid = tidq->tid;
+	sample.pid = tidq->thread->pid_;
+	sample.tid = tidq->thread->tid;
 	sample.addr = cs_etm__first_executed_instr(tidq->packet);
 	sample.id = etmq->etm->branches_id;
 	sample.stream_id = etmq->etm->branches_id;
@@ -2466,11 +2445,6 @@ static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
 		if (!etmq)
 			continue;
 
-		/*
-		 * Per-cpu mode has contextIDs in the trace and the decoder
-		 * calls cs_etm__set_pid_tid_cpu() automatically so no need
-		 * to do this here
-		 */
 		if (etm->per_thread_decoding) {
 			tidq = cs_etm__etmq_get_traceid_queue(
 				etmq, CS_ETM_PER_THREAD_TRACEID);
@@ -2478,10 +2452,8 @@ static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
 			if (!tidq)
 				continue;
 
-			if ((tid == -1) || (tidq->tid == tid)) {
-				cs_etm__set_pid_tid_cpu(etm, tidq);
+			if (tid == -1 || tidq->thread->tid == tid)
 				cs_etm__run_per_thread_timeless_decoder(etmq);
-			}
 		} else
 			cs_etm__run_per_cpu_timeless_decoder(etmq);
 	}
@@ -2611,10 +2583,12 @@ static int cs_etm__process_itrace_start(struct cs_etm_auxtrace *etm,
 		return 0;
 
 	/*
-	 * Add the tid/pid to the log so that we can get a match when
-	 * we get a contextID from the decoder.
+	 * Add the tid/pid to the log so that we can get a match when we get a
+	 * contextID from the decoder. Only track for the host: only kernel
+	 * trace is supported for guests which wouldn't need pids so this should
+	 * be fine.
 	 */
-	th = machine__findnew_thread(etm->machine,
+	th = machine__findnew_thread(&etm->session->machines.host,
 				     event->itrace_start.pid,
 				     event->itrace_start.tid);
 	if (!th)
@@ -2647,10 +2621,12 @@ static int cs_etm__process_switch_cpu_wide(struct cs_etm_auxtrace *etm,
 		return 0;
 
 	/*
-	 * Add the tid/pid to the log so that we can get a match when
-	 * we get a contextID from the decoder.
+	 * Add the tid/pid to the log so that we can get a match when we get a
+	 * contextID from the decoder. Only track for the host: only kernel
+	 * trace is supported for guests which wouldn't need pids so this should
+	 * be fine.
 	 */
-	th = machine__findnew_thread(etm->machine,
+	th = machine__findnew_thread(&etm->session->machines.host,
 				     event->context_switch.next_prev_pid,
 				     event->context_switch.next_prev_tid);
 	if (!th)
@@ -3259,7 +3235,6 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	}
 
 	etm->session = session;
-	etm->machine = &session->machines.host;
 
 	etm->num_cpu = num_cpu;
 	etm->pmu_type = (unsigned int) ((ptr[CS_PMU_TYPE_CPUS] >> 32) & 0xffffffff);
@@ -3286,27 +3261,6 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	if (err)
 		return err;
 
-	etm->unknown_thread = thread__new(999999999, 999999999);
-	if (!etm->unknown_thread) {
-		err = -ENOMEM;
-		goto err_free_queues;
-	}
-
-	/*
-	 * Initialize list node so that at thread__zput() we can avoid
-	 * segmentation fault at list_del_init().
-	 */
-	INIT_LIST_HEAD(&etm->unknown_thread->node);
-
-	err = thread__set_comm(etm->unknown_thread, "unknown", 0);
-	if (err)
-		goto err_delete_thread;
-
-	if (thread__init_maps(etm->unknown_thread, etm->machine)) {
-		err = -ENOMEM;
-		goto err_delete_thread;
-	}
-
 	etm->tc.time_shift = tc->time_shift;
 	etm->tc.time_mult = tc->time_mult;
 	etm->tc.time_zero = tc->time_zero;
@@ -3318,7 +3272,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 	}
 	err = cs_etm__synth_events(etm, session);
 	if (err)
-		goto err_delete_thread;
+		goto err_free_queues;
 
 	/*
 	 * Map Trace ID values to CPU metadata.
@@ -3348,7 +3302,7 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 					session->header.data_size,
 					cs_etm__process_aux_hw_id_cb, &aux_hw_id_found);
 	if (err)
-		goto err_delete_thread;
+		goto err_free_queues;
 
 	/* if HW ID found then clear any unused metadata ID values */
 	if (aux_hw_id_found)
@@ -3358,17 +3312,15 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 		err = cs_etm__map_trace_ids_metadata(num_cpu, metadata);
 
 	if (err)
-		goto err_delete_thread;
+		goto err_free_queues;
 
 	err = cs_etm__queue_aux_records(session);
 	if (err)
-		goto err_delete_thread;
+		goto err_free_queues;
 
 	etm->data_queued = etm->queues.populated;
 	return 0;
 
-err_delete_thread:
-	thread__zput(etm->unknown_thread);
 err_free_queues:
 	auxtrace_queues__free(&etm->queues);
 	session->auxtrace = NULL;
-- 
2.34.1

