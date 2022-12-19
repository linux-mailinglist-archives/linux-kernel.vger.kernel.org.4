Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9500E65100D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 17:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbiLSQOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 11:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbiLSQOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 11:14:10 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF6E4A440;
        Mon, 19 Dec 2022 08:14:03 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85D70FEC;
        Mon, 19 Dec 2022 08:14:44 -0800 (PST)
Received: from e126815.warwick.arm.com (e126815.arm.com [10.32.32.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5C9433F703;
        Mon, 19 Dec 2022 08:14:01 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org
Cc:     robh@kernel.org, German Gomez <german.gomez@arm.com>,
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
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/4] perf report: Add 'simd' sort field
Date:   Mon, 19 Dec 2022 16:12:58 +0000
Message-Id: <20221219161259.3097213-5-james.clark@arm.com>
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
index 4fa509b15948..ff524d83a4a7 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -115,6 +115,7 @@ OPTIONS
 	- p_stage_cyc: On powerpc, this presents the number of cycles spent in a
 	  pipeline stage. And currently supported only on powerpc.
 	- addr: (Full) virtual address of the sampled instruction
+	- simd: Flags describing a SIMD operation. "e" for empty Arm SVE predicate. "p" for partial Arm SVE predicate
 
 	By default, comm, dso and symbol keys are used.
 	(i.e. --sort comm,dso,symbol)
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 17a05e943b44..e2390114c495 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -742,6 +742,7 @@ __hists__add_entry(struct hists *hists,
 		.weight = sample->weight,
 		.ins_lat = sample->ins_lat,
 		.p_stage_cyc = sample->p_stage_cyc,
+		.simd_flags = sample->simd_flags,
 	}, *he = hists__findnew_entry(hists, &entry, al, sample_self);
 
 	if (!hists->has_callchains && he && he->callchain_size != 0)
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index ebd8a8f783ee..e6ecb4453053 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -80,6 +80,7 @@ enum hist_column {
 	HISTC_ADDR_FROM,
 	HISTC_ADDR_TO,
 	HISTC_ADDR,
+	HISTC_SIMD,
 	HISTC_NR_COLS, /* Last entry */
 };
 
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 0ecc2cb13792..5c8bfea2ce34 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -131,6 +131,52 @@ struct sort_entry sort_thread = {
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
@@ -2042,6 +2088,7 @@ static struct sort_dimension common_sort_dimensions[] = {
 	DIM(SORT_LOCAL_PIPELINE_STAGE_CYC, "local_p_stage_cyc", sort_local_p_stage_cyc),
 	DIM(SORT_GLOBAL_PIPELINE_STAGE_CYC, "p_stage_cyc", sort_global_p_stage_cyc),
 	DIM(SORT_ADDR, "addr", sort_addr),
+	DIM(SORT_SIMD, "simd", sort_simd)
 };
 
 #undef DIM
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 04ff8b61a2a7..8e69a2a53dc1 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -110,6 +110,7 @@ struct hist_entry {
 	u64			p_stage_cyc;
 	u8			cpumode;
 	u8			depth;
+	struct simd_flags	simd_flags;
 
 	/* We are added by hists__add_dummy_entry. */
 	bool			dummy;
@@ -237,6 +238,7 @@ enum sort_type {
 	SORT_LOCAL_PIPELINE_STAGE_CYC,
 	SORT_GLOBAL_PIPELINE_STAGE_CYC,
 	SORT_ADDR,
+	SORT_SIMD,
 
 	/* branch stack specific sort keys */
 	__SORT_BRANCH_STACK,
-- 
2.25.1

