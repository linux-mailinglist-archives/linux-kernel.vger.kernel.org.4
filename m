Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB266C1845
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbjCTPXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbjCTPWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:22:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47F0A32E7E;
        Mon, 20 Mar 2023 08:16:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CDC3106F;
        Mon, 20 Mar 2023 08:16:15 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 31DCC3F71E;
        Mon, 20 Mar 2023 08:15:29 -0700 (PDT)
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
Subject: [PATCH v2 4/4] perf report: Add 'simd' sort field
Date:   Mon, 20 Mar 2023 15:15:08 +0000
Message-Id: <20230320151509.1137462-5-james.clark@arm.com>
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

Add 'simd' sort field to visualize SIMD ops in perf-report.

Rows are labeled with the SIMD isa, and the type of predicate (if any):

  - [p] partial predicate
  - [e] empty predicate (no elements in the vector being used)

Example with Arm SPE and SVE (Scalable Vector Extension):

  #include <arm_sve.h>

  double src[1025], dst[1025];

  int main(void) {
    svfloat64_t vc = svdup_f64(1);
    for(;;)
      for(int i = 0; i < 1025; i += svcntd())
      {
        svbool_t pg = svwhilelt_b64(i, 1025);
        svfloat64_t vsrc = svld1(pg, &src[i]);
        svfloat64_t vdst = svadd_x(pg, vsrc, vc);
        svst1(pg, &dst[i], vdst);
      }
    return 0;
  }

  ... compiled using "gcc-11 -march=armv8-a+sve -O3"

Profiling on a platform that implements FEAT_SVE and FEAT_SPEv1p1:

  $ perf record -e arm_spe_0// -- ./a.out
  $ perf report --itrace=i1i -s overhead,pid,simd,sym

  Overhead      Pid:Command   Simd     Symbol
  ........  ................  .......  ......................

    53.76%    10758:program            [.] main
    46.14%    10758:program   [.] SVE  [.] main
     0.09%    10758:program   [p] SVE  [.] main

The report shows 0.09% of the sampled SVE operations use partial
predicates due to src and dst arrays not being multiples of the vector
register lengths.

Signed-off-by: German Gomez <german.gomez@arm.com>
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/Documentation/perf-report.txt |  1 +
 tools/perf/util/hist.c                   |  1 +
 tools/perf/util/hist.h                   |  1 +
 tools/perf/util/sort.c                   | 47 ++++++++++++++++++++++++
 tools/perf/util/sort.h                   |  2 +
 5 files changed, 52 insertions(+)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index c242e8da6b1a..cfd502f7e6da 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -117,6 +117,7 @@ OPTIONS
 	- addr: (Full) virtual address of the sampled instruction
 	- retire_lat: On X86, this reports pipeline stall of this instruction compared
 	  to the previous instruction in cycles. And currently supported only on X86
+	- simd: Flags describing a SIMD operation. "e" for empty Arm SVE predicate. "p" for partial Arm SVE predicate
 
 	By default, comm, dso and symbol keys are used.
 	(i.e. --sort comm,dso,symbol)
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 3670136a0074..0c11f50abfec 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -745,6 +745,7 @@ __hists__add_entry(struct hists *hists,
 		.weight = sample->weight,
 		.ins_lat = sample->ins_lat,
 		.p_stage_cyc = sample->p_stage_cyc,
+		.simd_flags = sample->simd_flags,
 	}, *he = hists__findnew_entry(hists, &entry, al, sample_self);
 
 	if (!hists->has_callchains && he && he->callchain_size != 0)
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 86a677954279..afc9f1c7f4dc 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -81,6 +81,7 @@ enum hist_column {
 	HISTC_ADDR_FROM,
 	HISTC_ADDR_TO,
 	HISTC_ADDR,
+	HISTC_SIMD,
 	HISTC_NR_COLS, /* Last entry */
 };
 
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 093a0c8b2e3d..e11e68ecf0a2 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -139,6 +139,52 @@ struct sort_entry sort_thread = {
 	.se_width_idx	= HISTC_THREAD,
 };
 
+/* --sort simd */
+
+static int64_t
+sort__simd_cmp(struct hist_entry *left, struct hist_entry *right)
+{
+	if (left->simd_flags.arch != right->simd_flags.arch)
+		return (int64_t) left->simd_flags.arch - right->simd_flags.arch;
+
+	return (int64_t) left->simd_flags.pred - right->simd_flags.pred;
+}
+
+static const char *hist_entry__get_simd_name(struct simd_flags *simd_flags)
+{
+	u64 arch = simd_flags->arch;
+
+	if (arch & SIMD_OP_FLAGS_ARCH_SVE)
+		return "SVE";
+	else
+		return "n/a";
+}
+
+static int hist_entry__simd_snprintf(struct hist_entry *he, char *bf,
+				     size_t size, unsigned int width __maybe_unused)
+{
+	const char *name;
+
+	if (!he->simd_flags.arch)
+		return repsep_snprintf(bf, size, "");
+
+	name = hist_entry__get_simd_name(&he->simd_flags);
+
+	if (he->simd_flags.pred & SIMD_OP_FLAGS_PRED_EMPTY)
+		return repsep_snprintf(bf, size, "[e] %s", name);
+	else if (he->simd_flags.pred & SIMD_OP_FLAGS_PRED_PARTIAL)
+		return repsep_snprintf(bf, size, "[p] %s", name);
+
+	return repsep_snprintf(bf, size, "[.] %s", name);
+}
+
+struct sort_entry sort_simd = {
+	.se_header	= "Simd   ",
+	.se_cmp		= sort__simd_cmp,
+	.se_snprintf	= hist_entry__simd_snprintf,
+	.se_width_idx	= HISTC_SIMD,
+};
+
 /* --sort comm */
 
 /*
@@ -2142,6 +2188,7 @@ static struct sort_dimension common_sort_dimensions[] = {
 	DIM(SORT_ADDR, "addr", sort_addr),
 	DIM(SORT_LOCAL_RETIRE_LAT, "local_retire_lat", sort_local_p_stage_cyc),
 	DIM(SORT_GLOBAL_RETIRE_LAT, "retire_lat", sort_global_p_stage_cyc),
+	DIM(SORT_SIMD, "simd", sort_simd)
 };
 
 #undef DIM
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 22f437c3476f..ecfb7f1359d5 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -111,6 +111,7 @@ struct hist_entry {
 	u64			p_stage_cyc;
 	u8			cpumode;
 	u8			depth;
+	struct simd_flags	simd_flags;
 
 	/* We are added by hists__add_dummy_entry. */
 	bool			dummy;
@@ -241,6 +242,7 @@ enum sort_type {
 	SORT_ADDR,
 	SORT_LOCAL_RETIRE_LAT,
 	SORT_GLOBAL_RETIRE_LAT,
+	SORT_SIMD,
 
 	/* branch stack specific sort keys */
 	__SORT_BRANCH_STACK,
-- 
2.34.1

