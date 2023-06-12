Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB0972C2EB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbjFLLgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbjFLLgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:36:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C615D8C02;
        Mon, 12 Jun 2023 04:14:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FE6E1FB;
        Mon, 12 Jun 2023 04:15:03 -0700 (PDT)
Received: from e127643.broadband (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D5F593F587;
        Mon, 12 Jun 2023 04:14:14 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org
Cc:     James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
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
Subject: [PATCH v3 2/5] perf cs-etm: Use previous thread for branch sample source IP
Date:   Mon, 12 Jun 2023 12:13:59 +0100
Message-Id: <20230612111403.100613-3-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230612111403.100613-1-james.clark@arm.com>
References: <20230612111403.100613-1-james.clark@arm.com>
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

Branch samples currently use the IP of the previous packet as the from
IP, and the IP of the current packet as the to IP. But it incorrectly
uses the current thread. In some cases like a jump into a different
exception level this will attribute to the incorrect process.

Fix it by tracking the previous thread in the same way the previous
packet is tracked.

Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index ebffc9052561..5b909bca294e 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -86,6 +86,7 @@ struct cs_etm_traceid_queue {
 	size_t last_branch_pos;
 	union perf_event *event_buf;
 	struct thread *thread;
+	struct thread *prev_packet_thread;
 	struct branch_stack *last_branch;
 	struct branch_stack *last_branch_rb;
 	struct cs_etm_packet *prev_packet;
@@ -480,6 +481,7 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
 	tidq->trace_chan_id = trace_chan_id;
 	tidq->thread = machine__findnew_thread(&etm->session->machines.host, -1,
 					       queue->tid);
+	tidq->prev_packet_thread = machine__idle_thread(&etm->session->machines.host);
 
 	tidq->packet = zalloc(sizeof(struct cs_etm_packet));
 	if (!tidq->packet)
@@ -612,10 +614,20 @@ static void cs_etm__packet_swap(struct cs_etm_auxtrace *etm,
 		/*
 		 * Swap PACKET with PREV_PACKET: PACKET becomes PREV_PACKET for
 		 * the next incoming packet.
+		 *
+		 * Threads and exception levels are also tracked for both the
+		 * previous and current packets. This is because the previous
+		 * packet is used for the 'from' IP for branch samples, so the
+		 * thread at that time must also be assigned to that sample.
+		 * Across discontinuity packets the thread can change, so by
+		 * tracking the thread for the previous packet the branch sample
+		 * will have the correct info.
 		 */
 		tmp = tidq->packet;
 		tidq->packet = tidq->prev_packet;
 		tidq->prev_packet = tmp;
+		thread__put(tidq->prev_packet_thread);
+		tidq->prev_packet_thread = thread__get(tidq->thread);
 	}
 }
 
@@ -791,6 +803,7 @@ static void cs_etm__free_traceid_queues(struct cs_etm_queue *etmq)
 		/* Free this traceid_queue from the array */
 		tidq = etmq->traceid_queues[idx];
 		thread__zput(tidq->thread);
+		thread__zput(tidq->prev_packet_thread);
 		zfree(&tidq->event_buf);
 		zfree(&tidq->last_branch);
 		zfree(&tidq->last_branch_rb);
@@ -1450,8 +1463,8 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
 	sample.time = cs_etm__resolve_sample_time(etmq, tidq);
 
 	sample.ip = ip;
-	sample.pid = tidq->thread->pid_;
-	sample.tid = tidq->thread->tid;
+	sample.pid = tidq->prev_packet_thread->pid_;
+	sample.tid = tidq->prev_packet_thread->tid;
 	sample.addr = cs_etm__first_executed_instr(tidq->packet);
 	sample.id = etmq->etm->branches_id;
 	sample.stream_id = etmq->etm->branches_id;
-- 
2.34.1

