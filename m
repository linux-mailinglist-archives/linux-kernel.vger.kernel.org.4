Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8933E727D66
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 13:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235678AbjFHLAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 07:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235485AbjFHLAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:00:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DB5A136;
        Thu,  8 Jun 2023 04:00:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E8851042;
        Thu,  8 Jun 2023 04:00:55 -0700 (PDT)
Received: from e127643.broadband (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0C1FC3F71E;
        Thu,  8 Jun 2023 04:00:06 -0700 (PDT)
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
Subject: [PATCH v2 5/5] perf cs-etm: Add exception level consistency check
Date:   Thu,  8 Jun 2023 11:59:29 +0100
Message-Id: <20230608105930.1389276-6-james.clark@arm.com>
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

Assert that our own tracking of the exception level matches what
OpenCSD provides. OpenCSD doesn't distinguish between EL0 and EL1 in the
memory access callback so the extra tracking was required. But a rough
assert can still be done.

Signed-off-by: James Clark <james.clark@arm.com>
---
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  6 +--
 .../perf/util/cs-etm-decoder/cs-etm-decoder.h |  4 +-
 tools/perf/util/cs-etm.c                      | 41 ++++++++++++++-----
 3 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 44c49acd6bff..e917985bbbe6 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -52,15 +52,15 @@ struct cs_etm_decoder {
 static u32
 cs_etm_decoder__mem_access(const void *context,
 			   const ocsd_vaddr_t address,
-			   const ocsd_mem_space_acc_t mem_space __maybe_unused,
+			   const ocsd_mem_space_acc_t mem_space,
 			   const u8 trace_chan_id,
 			   const u32 req_size,
 			   u8 *buffer)
 {
 	struct cs_etm_decoder *decoder = (struct cs_etm_decoder *) context;
 
-	return decoder->mem_access(decoder->data, trace_chan_id,
-				   address, req_size, buffer);
+	return decoder->mem_access(decoder->data, trace_chan_id, address,
+				   req_size, buffer, mem_space);
 }
 
 int cs_etm_decoder__add_mem_access_cb(struct cs_etm_decoder *decoder,
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 21d403f55d96..272c2efe78ee 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -11,6 +11,7 @@
 #define INCLUDE__CS_ETM_DECODER_H__
 
 #include <linux/types.h>
+#include <opencsd/ocsd_if_types.h>
 #include <stdio.h>
 
 struct cs_etm_decoder;
@@ -19,7 +20,8 @@ struct cs_etm_packet_queue;
 
 struct cs_etm_queue;
 
-typedef u32 (*cs_etm_mem_cb_type)(struct cs_etm_queue *, u8, u64, size_t, u8 *);
+typedef u32 (*cs_etm_mem_cb_type)(struct cs_etm_queue *, u8, u64, size_t, u8 *,
+				  const ocsd_mem_space_acc_t);
 
 struct cs_etmv3_trace_params {
 	u32 reg_ctrl;
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 916e86f003f4..ca01109c3fc4 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -943,7 +943,8 @@ static u8 cs_etm__cpu_mode(struct cs_etm_queue *etmq, u64 address,
 }
 
 static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
-			      u64 address, size_t size, u8 *buffer)
+			      u64 address, size_t size, u8 *buffer,
+			      const ocsd_mem_space_acc_t mem_space)
 {
 	u8  cpumode;
 	u64 offset;
@@ -959,6 +960,24 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
 	if (!tidq)
 		return 0;
 
+	/*
+	 * We've already tracked EL along side the PID in cs_etm__set_thread()
+	 * so double check that it matches what OpenCSD thinks as well. It
+	 * doesn't distinguish between EL0 and EL1 for this mem access callback
+	 * so we had to do the extra tracking. Skip validation if it's any of
+	 * the 'any' values.
+	 */
+	if (!(mem_space == OCSD_MEM_SPACE_ANY ||
+	      mem_space == OCSD_MEM_SPACE_N || mem_space == OCSD_MEM_SPACE_S)) {
+		if (mem_space & OCSD_MEM_SPACE_EL1N) {
+			/* Includes both non secure EL1 and EL0 */
+			assert(tidq->el == ocsd_EL1 || tidq->el == ocsd_EL0);
+		} else if (mem_space & OCSD_MEM_SPACE_EL2)
+			assert(tidq->el == ocsd_EL2);
+		else if (mem_space & OCSD_MEM_SPACE_EL3)
+			assert(tidq->el == ocsd_EL3);
+	}
+
 	cpumode = cs_etm__cpu_mode(etmq, address, tidq->el);
 
 	if (!thread__find_map(tidq->thread, cpumode, address, &al))
@@ -1207,8 +1226,8 @@ static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
 {
 	u8 instrBytes[2];
 
-	cs_etm__mem_access(etmq, trace_chan_id, addr,
-			   ARRAY_SIZE(instrBytes), instrBytes);
+	cs_etm__mem_access(etmq, trace_chan_id, addr, ARRAY_SIZE(instrBytes),
+			   instrBytes, 0);
 	/*
 	 * T32 instruction size is indicated by bits[15:11] of the first
 	 * 16-bit word of the instruction: 0b11101, 0b11110 and 0b11111
@@ -1399,8 +1418,8 @@ static void cs_etm__copy_insn(struct cs_etm_queue *etmq,
 	else
 		sample->insn_len = 4;
 
-	cs_etm__mem_access(etmq, trace_chan_id, sample->ip,
-			   sample->insn_len, (void *)sample->insn);
+	cs_etm__mem_access(etmq, trace_chan_id, sample->ip, sample->insn_len,
+			   (void *)sample->insn, 0);
 }
 
 u64 cs_etm__convert_sample_time(struct cs_etm_queue *etmq, u64 cs_timestamp)
@@ -1952,8 +1971,8 @@ static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq, u8 trace_chan_id,
 		 * so below only read 2 bytes as instruction size for T32.
 		 */
 		addr = end_addr - 2;
-		cs_etm__mem_access(etmq, trace_chan_id, addr,
-				   sizeof(instr16), (u8 *)&instr16);
+		cs_etm__mem_access(etmq, trace_chan_id, addr, sizeof(instr16),
+				   (u8 *)&instr16, 0);
 		if ((instr16 & 0xFF00) == 0xDF00)
 			return true;
 
@@ -1968,8 +1987,8 @@ static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq, u8 trace_chan_id,
 		 * +---------+---------+-------------------------+
 		 */
 		addr = end_addr - 4;
-		cs_etm__mem_access(etmq, trace_chan_id, addr,
-				   sizeof(instr32), (u8 *)&instr32);
+		cs_etm__mem_access(etmq, trace_chan_id, addr, sizeof(instr32),
+				   (u8 *)&instr32, 0);
 		if ((instr32 & 0x0F000000) == 0x0F000000 &&
 		    (instr32 & 0xF0000000) != 0xF0000000)
 			return true;
@@ -1985,8 +2004,8 @@ static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq, u8 trace_chan_id,
 		 * +-----------------------+---------+-----------+
 		 */
 		addr = end_addr - 4;
-		cs_etm__mem_access(etmq, trace_chan_id, addr,
-				   sizeof(instr32), (u8 *)&instr32);
+		cs_etm__mem_access(etmq, trace_chan_id, addr, sizeof(instr32),
+				   (u8 *)&instr32, 0);
 		if ((instr32 & 0xFFE0001F) == 0xd4000001)
 			return true;
 
-- 
2.34.1

