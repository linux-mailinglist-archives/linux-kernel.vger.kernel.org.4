Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DAC70F77C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 15:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235036AbjEXNUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 09:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjEXNUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 09:20:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7281AA;
        Wed, 24 May 2023 06:20:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99E691595;
        Wed, 24 May 2023 06:21:03 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F0F5F3F840;
        Wed, 24 May 2023 06:20:15 -0700 (PDT)
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
Subject: [PATCH 2/4] perf cs-etm: Use previous thread for branch sample source IP
Date:   Wed, 24 May 2023 14:19:56 +0100
Message-Id: <20230524131958.2139331-3-james.clark@arm.com>
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

Branch samples currently use the IP of the previous packet as the from
IP, and the IP of the current packet as the to IP. But it incorrectly
uses the current thread. In some cases like a jump into a different
exception level this will attribute to the incorrect process.

Fix it by tracking the previous thread in the same way the previous
packet is tracked.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/cs-etm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index ebffc9052561..a997fe79d458 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -86,6 +86,7 @@ struct cs_etm_traceid_queue {
 	size_t last_branch_pos;
 	union perf_event *event_buf;
 	struct thread *thread;
+	struct thread *prev_thread;
 	struct branch_stack *last_branch;
 	struct branch_stack *last_branch_rb;
 	struct cs_etm_packet *prev_packet;
@@ -480,6 +481,7 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
 	tidq->trace_chan_id = trace_chan_id;
 	tidq->thread = machine__findnew_thread(&etm->session->machines.host, -1,
 					       queue->tid);
+	tidq->prev_thread = machine__idle_thread(&etm->session->machines.host);
 
 	tidq->packet = zalloc(sizeof(struct cs_etm_packet));
 	if (!tidq->packet)
@@ -616,6 +618,8 @@ static void cs_etm__packet_swap(struct cs_etm_auxtrace *etm,
 		tmp = tidq->packet;
 		tidq->packet = tidq->prev_packet;
 		tidq->prev_packet = tmp;
+		thread__put(tidq->prev_thread);
+		tidq->prev_thread = thread__get(tidq->thread);
 	}
 }
 
@@ -791,6 +795,7 @@ static void cs_etm__free_traceid_queues(struct cs_etm_queue *etmq)
 		/* Free this traceid_queue from the array */
 		tidq = etmq->traceid_queues[idx];
 		thread__zput(tidq->thread);
+		thread__zput(tidq->prev_thread);
 		zfree(&tidq->event_buf);
 		zfree(&tidq->last_branch);
 		zfree(&tidq->last_branch_rb);
@@ -1450,8 +1455,8 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
 	sample.time = cs_etm__resolve_sample_time(etmq, tidq);
 
 	sample.ip = ip;
-	sample.pid = tidq->thread->pid_;
-	sample.tid = tidq->thread->tid;
+	sample.pid = tidq->prev_thread->pid_;
+	sample.tid = tidq->prev_thread->tid;
 	sample.addr = cs_etm__first_executed_instr(tidq->packet);
 	sample.id = etmq->etm->branches_id;
 	sample.stream_id = etmq->etm->branches_id;
-- 
2.34.1

