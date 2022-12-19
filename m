Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A94651009
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 17:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbiLSQOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 11:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiLSQN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 11:13:58 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5761FE0B6;
        Mon, 19 Dec 2022 08:13:57 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D04B1515;
        Mon, 19 Dec 2022 08:14:38 -0800 (PST)
Received: from e126815.warwick.arm.com (e126815.arm.com [10.32.32.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D7BA33F703;
        Mon, 19 Dec 2022 08:13:54 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org
Cc:     robh@kernel.org, German Gomez <german.gomez@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/4] perf arm-spe: Refactor arm-spe to support operation packet type
Date:   Mon, 19 Dec 2022 16:12:56 +0000
Message-Id: <20221219161259.3097213-3-james.clark@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221219161259.3097213-1-james.clark@arm.com>
References: <20221219161259.3097213-1-james.clark@arm.com>
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

Extend the decoder of Arm SPE records to support more fields from the
operation packet type.

Not all fields are being decoded by this commit. Only those needed to
support the use-case SVE load/store/other operations.

Suggested-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: German Gomez <german.gomez@arm.com>
Signed-off-by: James Clark <james.clark@arm.com>
---
 .../util/arm-spe-decoder/arm-spe-decoder.c    | 30 ++++++++++--
 .../util/arm-spe-decoder/arm-spe-decoder.h    | 47 +++++++++++++++----
 tools/perf/util/arm-spe.c                     |  8 ++--
 3 files changed, 67 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index 091987dd3966..709d3f6b58c6 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -186,11 +186,27 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
 			decoder->record.context_id = payload;
 			break;
 		case ARM_SPE_OP_TYPE:
-			if (idx == SPE_OP_PKT_HDR_CLASS_LD_ST_ATOMIC) {
-				if (payload & 0x1)
-					decoder->record.op = ARM_SPE_ST;
+			switch (idx) {
+			case SPE_OP_PKT_HDR_CLASS_LD_ST_ATOMIC:
+				decoder->record.op |= ARM_SPE_OP_LDST;
+				if (payload & SPE_OP_PKT_ST)
+					decoder->record.op |= ARM_SPE_OP_ST;
 				else
-					decoder->record.op = ARM_SPE_LD;
+					decoder->record.op |= ARM_SPE_OP_LD;
+				if (SPE_OP_PKT_IS_LDST_SVE(payload))
+					decoder->record.op |= ARM_SPE_OP_SVE_LDST;
+				break;
+			case SPE_OP_PKT_HDR_CLASS_OTHER:
+				decoder->record.op |= ARM_SPE_OP_OTHER;
+				if (SPE_OP_PKT_IS_OTHER_SVE_OP(payload))
+					decoder->record.op |= ARM_SPE_OP_SVE_OTHER;
+				break;
+			case SPE_OP_PKT_HDR_CLASS_BR_ERET:
+				decoder->record.op |= ARM_SPE_OP_BRANCH_ERET;
+				break;
+			default:
+				pr_err("Get packet error!\n");
+				return -1;
 			}
 			break;
 		case ARM_SPE_EVENTS:
@@ -218,6 +234,12 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
 			if (payload & BIT(EV_MISPRED))
 				decoder->record.type |= ARM_SPE_BRANCH_MISS;
 
+			if (payload & BIT(EV_PARTIAL_PREDICATE))
+				decoder->record.type |= ARM_SPE_SVE_PARTIAL_PRED;
+
+			if (payload & BIT(EV_EMPTY_PREDICATE))
+				decoder->record.type |= ARM_SPE_SVE_EMPTY_PRED;
+
 			break;
 		case ARM_SPE_DATA_SOURCE:
 			decoder->record.source = payload;
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
index 46a61df1145b..1443c28545a9 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -14,19 +14,46 @@
 #include "arm-spe-pkt-decoder.h"
 
 enum arm_spe_sample_type {
-	ARM_SPE_L1D_ACCESS	= 1 << 0,
-	ARM_SPE_L1D_MISS	= 1 << 1,
-	ARM_SPE_LLC_ACCESS	= 1 << 2,
-	ARM_SPE_LLC_MISS	= 1 << 3,
-	ARM_SPE_TLB_ACCESS	= 1 << 4,
-	ARM_SPE_TLB_MISS	= 1 << 5,
-	ARM_SPE_BRANCH_MISS	= 1 << 6,
-	ARM_SPE_REMOTE_ACCESS	= 1 << 7,
+	ARM_SPE_L1D_ACCESS		= 1 << 0,
+	ARM_SPE_L1D_MISS		= 1 << 1,
+	ARM_SPE_LLC_ACCESS		= 1 << 2,
+	ARM_SPE_LLC_MISS		= 1 << 3,
+	ARM_SPE_TLB_ACCESS		= 1 << 4,
+	ARM_SPE_TLB_MISS		= 1 << 5,
+	ARM_SPE_BRANCH_MISS		= 1 << 6,
+	ARM_SPE_REMOTE_ACCESS		= 1 << 7,
+	ARM_SPE_SVE_PARTIAL_PRED	= 1 << 8,
+	ARM_SPE_SVE_EMPTY_PRED		= 1 << 9,
 };
 
 enum arm_spe_op_type {
-	ARM_SPE_LD		= 1 << 0,
-	ARM_SPE_ST		= 1 << 1,
+	/* First level operation type */
+	ARM_SPE_OP_OTHER	= 1 << 0,
+	ARM_SPE_OP_LDST		= 1 << 1,
+	ARM_SPE_OP_BRANCH_ERET	= 1 << 2,
+
+	/* Second level operation type for OTHER */
+	ARM_SPE_OP_SVE_OTHER		= 1 << 16,
+	ARM_SPE_OP_SVE_FP		= 1 << 17,
+	ARM_SPE_OP_SVE_PRED_OTHER	= 1 << 18,
+
+	/* Second level operation type for LDST */
+	ARM_SPE_OP_LD			= 1 << 16,
+	ARM_SPE_OP_ST			= 1 << 17,
+	ARM_SPE_OP_ATOMIC		= 1 << 18,
+	ARM_SPE_OP_EXCL			= 1 << 19,
+	ARM_SPE_OP_AR			= 1 << 20,
+	ARM_SPE_OP_SIMD_FP		= 1 << 21,
+	ARM_SPE_OP_GP_REG		= 1 << 22,
+	ARM_SPE_OP_UNSPEC_REG		= 1 << 23,
+	ARM_SPE_OP_NV_SYSREG		= 1 << 24,
+	ARM_SPE_OP_SVE_LDST		= 1 << 25,
+	ARM_SPE_OP_SVE_PRED_LDST	= 1 << 26,
+	ARM_SPE_OP_SVE_SG		= 1 << 27,
+
+	/* Second level operation type for BRANCH_ERET */
+	ARM_SPE_OP_BR_COND	= 1 << 16,
+	ARM_SPE_OP_BR_INDIRECT	= 1 << 17,
 };
 
 enum arm_spe_neoverse_data_source {
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 906476a839e1..bfae4731a47a 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -411,7 +411,7 @@ static void arm_spe__synth_data_source_neoverse(const struct arm_spe_record *rec
 	 * We have no data on the hit level or data source for stores in the
 	 * Neoverse SPE records.
 	 */
-	if (record->op & ARM_SPE_ST) {
+	if (record->op & ARM_SPE_OP_ST) {
 		data_src->mem_lvl = PERF_MEM_LVL_NA;
 		data_src->mem_lvl_num = PERF_MEM_LVLNUM_NA;
 		data_src->mem_snoop = PERF_MEM_SNOOP_NA;
@@ -497,12 +497,12 @@ static void arm_spe__synth_data_source_generic(const struct arm_spe_record *reco
 
 static u64 arm_spe__synth_data_source(const struct arm_spe_record *record, u64 midr)
 {
-	union perf_mem_data_src	data_src = { 0 };
+	union perf_mem_data_src	data_src = { .mem_op = PERF_MEM_OP_NA };
 	bool is_neoverse = is_midr_in_range_list(midr, neoverse_spe);
 
-	if (record->op == ARM_SPE_LD)
+	if (record->op & ARM_SPE_OP_LD)
 		data_src.mem_op = PERF_MEM_OP_LOAD;
-	else if (record->op == ARM_SPE_ST)
+	else if (record->op & ARM_SPE_OP_ST)
 		data_src.mem_op = PERF_MEM_OP_STORE;
 	else
 		return 0;
-- 
2.25.1

