Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701B16C1847
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbjCTPXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbjCTPWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:22:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47AEC16884;
        Mon, 20 Mar 2023 08:16:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2881C1063;
        Mon, 20 Mar 2023 08:16:12 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C26A63F71E;
        Mon, 20 Mar 2023 08:15:25 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, Anshuman.Khandual@arm.com
Cc:     German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
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
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/4] perf arm-spe: Add SVE flags to the SPE samples
Date:   Mon, 20 Mar 2023 15:15:07 +0000
Message-Id: <20230320151509.1137462-4-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230320151509.1137462-1-james.clark@arm.com>
References: <20230320151509.1137462-1-james.clark@arm.com>
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

Add flags from the Scalable Vector Extension (SVE) to the SPE samples
which are available from Armv8.3 (FEAT_SPEv1p1).

These will be displayed in a new SIMD sort field in a later commit.

Signed-off-by: German Gomez <german.gomez@arm.com>
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/util/arm-spe.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index bfae4731a47a..7b36ba6b4079 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -273,6 +273,25 @@ static int arm_spe_set_tid(struct arm_spe_queue *speq, pid_t tid)
 	return 0;
 }
 
+static struct simd_flags arm_spe__synth_simd_flags(const struct arm_spe_record *record)
+{
+	struct simd_flags simd_flags = {};
+
+	if ((record->op & ARM_SPE_OP_LDST) && (record->op & ARM_SPE_OP_SVE_LDST))
+		simd_flags.arch |= SIMD_OP_FLAGS_ARCH_SVE;
+
+	if ((record->op & ARM_SPE_OP_OTHER) && (record->op & ARM_SPE_OP_SVE_OTHER))
+		simd_flags.arch |= SIMD_OP_FLAGS_ARCH_SVE;
+
+	if (record->type & ARM_SPE_SVE_PARTIAL_PRED)
+		simd_flags.pred |= SIMD_OP_FLAGS_PRED_PARTIAL;
+
+	if (record->type & ARM_SPE_SVE_EMPTY_PRED)
+		simd_flags.pred |= SIMD_OP_FLAGS_PRED_EMPTY;
+
+	return simd_flags;
+}
+
 static void arm_spe_prep_sample(struct arm_spe *spe,
 				struct arm_spe_queue *speq,
 				union perf_event *event,
@@ -289,6 +308,7 @@ static void arm_spe_prep_sample(struct arm_spe *spe,
 	sample->tid = speq->tid;
 	sample->period = 1;
 	sample->cpu = speq->cpu;
+	sample->simd_flags = arm_spe__synth_simd_flags(record);
 
 	event->sample.header.type = PERF_RECORD_SAMPLE;
 	event->sample.header.misc = sample->cpumode;
-- 
2.34.1

