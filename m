Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEF2727D63
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 13:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbjFHLAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 07:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235939AbjFHLAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:00:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA4EA136;
        Thu,  8 Jun 2023 04:00:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 319451042;
        Thu,  8 Jun 2023 04:00:48 -0700 (PDT)
Received: from e127643.broadband (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3966D3F71E;
        Thu,  8 Jun 2023 04:00:00 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org
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
Subject: [PATCH v2 3/5] perf cs-etm: Make PID format accessible from struct cs_etm_auxtrace
Date:   Thu,  8 Jun 2023 11:59:27 +0100
Message-Id: <20230608105930.1389276-4-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230608105930.1389276-1-james.clark@arm.com>
References: <20230608105930.1389276-1-james.clark@arm.com>
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

To avoid every user of PID format having to use their own static
local variable, cache it on initialisation and change the accessor to
take struct cs_etm_auxtrace.

Signed-off-by: James Clark <james.clark@arm.com>
---
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 20 ++-------
 tools/perf/util/cs-etm.c                      | 42 ++++++++++++-------
 tools/perf/util/cs-etm.h                      |  8 +++-
 3 files changed, 37 insertions(+), 33 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 82a27ab90c8b..2af641d26866 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -541,34 +541,22 @@ cs_etm_decoder__set_tid(struct cs_etm_queue *etmq,
 			const uint8_t trace_chan_id)
 {
 	pid_t tid = -1;
-	static u64 pid_fmt;
-	int ret;
-
-	/*
-	 * As all the ETMs run at the same exception level, the system should
-	 * have the same PID format crossing CPUs.  So cache the PID format
-	 * and reuse it for sequential decoding.
-	 */
-	if (!pid_fmt) {
-		ret = cs_etm__get_pid_fmt(trace_chan_id, &pid_fmt);
-		if (ret)
-			return OCSD_RESP_FATAL_SYS_ERR;
-	}
 
 	/*
 	 * Process the PE_CONTEXT packets if we have a valid contextID or VMID.
 	 * If the kernel is running at EL2, the PID is traced in CONTEXTIDR_EL2
 	 * as VMID, Bit ETM_OPT_CTXTID2 is set in this case.
 	 */
-	switch (pid_fmt) {
-	case BIT(ETM_OPT_CTXTID):
+	switch (cs_etm__get_pid_fmt(etmq)) {
+	case CS_ETM_PIDFMT_CTXTID:
 		if (elem->context.ctxt_id_valid)
 			tid = elem->context.context_id;
 		break;
-	case BIT(ETM_OPT_CTXTID2):
+	case CS_ETM_PIDFMT_CTXTID2:
 		if (elem->context.vmid_valid)
 			tid = elem->context.vmid;
 		break;
+	case CS_ETM_PIDFMT_NONE:
 	default:
 		break;
 	}
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index a997fe79d458..e0904f276e89 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -78,6 +78,7 @@ struct cs_etm_auxtrace {
 	u64 instructions_id;
 	u64 **metadata;
 	unsigned int pmu_type;
+	enum cs_etm_pid_fmt pid_fmt;
 };
 
 struct cs_etm_traceid_queue {
@@ -170,44 +171,46 @@ int cs_etm__get_cpu(u8 trace_chan_id, int *cpu)
 }
 
 /*
- * The returned PID format is presented by two bits:
+ * The returned PID format is presented as an enum:
  *
- *   Bit ETM_OPT_CTXTID: CONTEXTIDR or CONTEXTIDR_EL1 is traced;
- *   Bit ETM_OPT_CTXTID2: CONTEXTIDR_EL2 is traced.
+ *   CS_ETM_PIDFMT_CTXTID: CONTEXTIDR or CONTEXTIDR_EL1 is traced.
+ *   CS_ETM_PIDFMT_CTXTID2: CONTEXTIDR_EL2 is traced.
+ *   CS_ETM_PIDFMT_NONE: No context IDs
  *
  * It's possible that the two bits ETM_OPT_CTXTID and ETM_OPT_CTXTID2
  * are enabled at the same time when the session runs on an EL2 kernel.
  * This means the CONTEXTIDR_EL1 and CONTEXTIDR_EL2 both will be
  * recorded in the trace data, the tool will selectively use
  * CONTEXTIDR_EL2 as PID.
+ *
+ * The result is cached in etm->pid_fmt so this function only needs to be called
+ * when processing the aux info.
  */
-int cs_etm__get_pid_fmt(u8 trace_chan_id, u64 *pid_fmt)
+static enum cs_etm_pid_fmt cs_etm__init_pid_fmt(u64 *metadata)
 {
-	struct int_node *inode;
-	u64 *metadata, val;
-
-	inode = intlist__find(traceid_list, trace_chan_id);
-	if (!inode)
-		return -EINVAL;
-
-	metadata = inode->priv;
+	u64 val;
 
 	if (metadata[CS_ETM_MAGIC] == __perf_cs_etmv3_magic) {
 		val = metadata[CS_ETM_ETMCR];
 		/* CONTEXTIDR is traced */
 		if (val & BIT(ETM_OPT_CTXTID))
-			*pid_fmt = BIT(ETM_OPT_CTXTID);
+			return CS_ETM_PIDFMT_CTXTID;
 	} else {
 		val = metadata[CS_ETMV4_TRCCONFIGR];
 		/* CONTEXTIDR_EL2 is traced */
 		if (val & (BIT(ETM4_CFG_BIT_VMID) | BIT(ETM4_CFG_BIT_VMID_OPT)))
-			*pid_fmt = BIT(ETM_OPT_CTXTID2);
+			return CS_ETM_PIDFMT_CTXTID2;
 		/* CONTEXTIDR_EL1 is traced */
 		else if (val & BIT(ETM4_CFG_BIT_CTXTID))
-			*pid_fmt = BIT(ETM_OPT_CTXTID);
+			return CS_ETM_PIDFMT_CTXTID;
 	}
 
-	return 0;
+	return CS_ETM_PIDFMT_NONE;
+}
+
+enum cs_etm_pid_fmt cs_etm__get_pid_fmt(struct cs_etm_queue *etmq)
+{
+	return etmq->etm->pid_fmt;
 }
 
 static int cs_etm__map_trace_id(u8 trace_chan_id, u64 *cpu_metadata)
@@ -3227,6 +3230,13 @@ int cs_etm__process_auxtrace_info_full(union perf_event *event,
 		goto err_free_metadata;
 	}
 
+	/*
+	 * As all the ETMs run at the same exception level, the system should
+	 * have the same PID format crossing CPUs.  So cache the PID format
+	 * and reuse it for sequential decoding.
+	 */
+	etm->pid_fmt = cs_etm__init_pid_fmt(metadata[0]);
+
 	err = auxtrace_queues__init(&etm->queues);
 	if (err)
 		goto err_free_etm;
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index ecca40787ac9..2f47f4ec5b27 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -244,9 +244,15 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 				  struct perf_session *session);
 struct perf_event_attr *cs_etm_get_default_config(struct perf_pmu *pmu);
 
+enum cs_etm_pid_fmt {
+	CS_ETM_PIDFMT_NONE,
+	CS_ETM_PIDFMT_CTXTID,
+	CS_ETM_PIDFMT_CTXTID2
+};
+
 #ifdef HAVE_CSTRACE_SUPPORT
 int cs_etm__get_cpu(u8 trace_chan_id, int *cpu);
-int cs_etm__get_pid_fmt(u8 trace_chan_id, u64 *pid_fmt);
+enum pid_fmt cs_etm__get_pid_fmt(struct cs_etm_queue *etmq);
 int cs_etm__etmq_set_tid(struct cs_etm_queue *etmq,
 			 pid_t tid, u8 trace_chan_id);
 bool cs_etm__etmq_is_timeless(struct cs_etm_queue *etmq);
-- 
2.34.1

