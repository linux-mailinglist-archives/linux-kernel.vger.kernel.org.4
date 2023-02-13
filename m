Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C551693CDE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 04:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjBMDWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 22:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBMDWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 22:22:08 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B51A262;
        Sun, 12 Feb 2023 19:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676258526; x=1707794526;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sbUryGN2GlhD5JhBXbYxOcllmwJOGL46QI8dL79t/vY=;
  b=iEbA9WF3mcH0LSR7B8Egz5DosTZGK4MpQQhBW7bGV+x3tIyeyGcZZOPp
   EbV7IrmoMojzPkx7pMXowcNn6PyDiY1gSsfhlqXBuUlSJQSI/Vgfy/HXW
   MvC9m0QQ2XuQqJCTNMFptCgIEhVex95fw6m4RO1UWqRBx1civ3H5B2gsb
   WcuodL3cuqlqkUPlo1wSpc9Rf/tXmzoi9el7x4tp8wskLAdymZcQ9nirU
   tfEVRWcrETW41dJ6Swft855iFMjh5nEfcV6AvfGIpQ8s8xevhmBGTTADm
   G5vq0we70wLFAowJfVfMmufIzR0OA7fRFA+O6uayjWwl9xrNVwbjRCP+v
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="311158675"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="311158675"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 19:22:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="732336201"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="732336201"
Received: from feng-clx.sh.intel.com ([10.238.200.228])
  by fmsmga008.fm.intel.com with ESMTP; 12 Feb 2023 19:22:01 -0800
From:   Feng Tang <feng.tang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Joe Mario <jmario@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Feng Tang <feng.tang@intel.com>
Subject: [PATCH] perf c2c: Add report option to show false sharing in adjacent cachelines
Date:   Mon, 13 Feb 2023 11:17:33 +0800
Message-Id: <20230213031733.236485-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many platforms have feature of adjacent cachelines prefetch, when it
is enabled, for data in RAM of 2 cachelines (2N and 2N+1) granularity,
if one is fetched to cache, the other one could likely be fetched too,
which sort of extends the cacheline size to double, thus the false
sharing could happens in adjacent cachelines.

0Day has captured performance changed related with this [1], and some
commercial software explicitly makes its hot global variables 128 bytes
aligned (2 cache lines) to avoid this kind of extended false sharing.

So add an option "-a" or "--double-cl" for c2c report to show false
sharing in double cache line granularity, which acts just like the
cacheline size is doubled. There is no change to c2c record. The
hardware HITM events are still per cacheline. The option just changes
the granularity of how events are grouped and displayed.

In the c2c report below (will-it-scale's pagefault2 case on old kernel):

  ----------------------------------------------------------------------
     26       31        2        0        0        0  0xffff888103ec6000
  ----------------------------------------------------------------------
   35.48%   50.00%    0.00%    0.00%    0.00%   0x10     0       1  0xffffffff8133148b      1153        66       971     3748        74  [k] get_mem_cgroup_from_mm
    6.45%    0.00%    0.00%    0.00%    0.00%   0x10     0       1  0xffffffff813396e4       570         0      1531      879        75  [k] mem_cgroup_charge
   25.81%   50.00%    0.00%    0.00%    0.00%   0x54     0       1  0xffffffff81331472       949        70       593     3359        74  [k] get_mem_cgroup_from_mm
   19.35%    0.00%    0.00%    0.00%    0.00%   0x54     0       1  0xffffffff81339686      1352         0      1073     1022        74  [k] mem_cgroup_charge
    9.68%    0.00%    0.00%    0.00%    0.00%   0x54     0       1  0xffffffff813396d6      1401         0       863      768        74  [k] mem_cgroup_charge
    3.23%    0.00%    0.00%    0.00%    0.00%   0x54     0       1  0xffffffff81333106       618         0       804       11         9  [k] uncharge_batch

The offset 0x10 and 0x54 used to displayed in 2 groups, and now they
are listed together to give users a hint.

[1]. https://lore.kernel.org/lkml/20201102091543.GM31092@shao2-debian/

Signed-off-by: Feng Tang <feng.tang@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/Documentation/perf-c2c.txt |  6 ++++++
 tools/perf/builtin-c2c.c              | 22 +++++++++++++---------
 tools/perf/util/cacheline.h           | 25 ++++++++++++++++++++-----
 tools/perf/util/sort.c                | 13 ++++++++++---
 tools/perf/util/sort.h                |  1 +
 5 files changed, 50 insertions(+), 17 deletions(-)

diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index 5c5eb2def83e..a8e1e40d270e 100644
--- a/tools/perf/Documentation/perf-c2c.txt
+++ b/tools/perf/Documentation/perf-c2c.txt
@@ -126,6 +126,12 @@ REPORT OPTIONS
 	The known limitations include exception handing such as
 	setjmp/longjmp will have calls/returns not match.
 
+-a::
+--double-cl::
+	Group HITM events in double cacheline granularity. Some architecture
+	has Adjacent Cacheline Prefetch feature, which behaves like the
+	cachline size is doubled.
+
 C2C RECORD
 ----------
 The perf c2c record command setup options related to HITM cacheline analysis
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 52d94c7dd836..7d495db7e5a2 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -524,7 +524,7 @@ static int dcacheline_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 	char buf[20];
 
 	if (he->mem_info)
-		addr = cl_address(he->mem_info->daddr.addr);
+		addr = cl_address(he->mem_info->daddr.addr, chk_double_cl);
 
 	return scnprintf(hpp->buf, hpp->size, "%*s", width, HEX_STR(buf, addr));
 }
@@ -562,7 +562,7 @@ static int offset_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 	char buf[20];
 
 	if (he->mem_info)
-		addr = cl_offset(he->mem_info->daddr.al_addr);
+		addr = cl_offset(he->mem_info->daddr.al_addr, chk_double_cl);
 
 	return scnprintf(hpp->buf, hpp->size, "%*s", width, HEX_STR(buf, addr));
 }
@@ -574,9 +574,10 @@ offset_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 	uint64_t l = 0, r = 0;
 
 	if (left->mem_info)
-		l = cl_offset(left->mem_info->daddr.addr);
+		l = cl_offset(left->mem_info->daddr.addr, chk_double_cl);
+
 	if (right->mem_info)
-		r = cl_offset(right->mem_info->daddr.addr);
+		r = cl_offset(right->mem_info->daddr.addr, chk_double_cl);
 
 	return (int64_t)(r - l);
 }
@@ -2590,7 +2591,7 @@ perf_c2c_cacheline_browser__title(struct hist_browser *browser,
 	he = cl_browser->he;
 
 	if (he->mem_info)
-		addr = cl_address(he->mem_info->daddr.addr);
+		addr = cl_address(he->mem_info->daddr.addr, chk_double_cl);
 
 	scnprintf(bf, size, "Cacheline 0x%lx", addr);
 	return 0;
@@ -2788,15 +2789,16 @@ static int ui_quirks(void)
 	if (!c2c.use_stdio) {
 		dim_offset.width  = 5;
 		dim_offset.header = header_offset_tui;
-		nodestr = "CL";
+		nodestr = chk_double_cl ? "Double-CL" : "CL";
 	}
 
 	dim_percent_costly_snoop.header = percent_costly_snoop_header[c2c.display];
 
 	/* Fix the zero line for dcacheline column. */
-	buf = fill_line("Cacheline", dim_dcacheline.width +
-				     dim_dcacheline_node.width +
-				     dim_dcacheline_count.width + 4);
+	buf = fill_line(chk_double_cl ? "Double-Cacheline" : "Cacheline",
+				dim_dcacheline.width +
+				dim_dcacheline_node.width +
+				dim_dcacheline_count.width + 4);
 	if (!buf)
 		return -ENOMEM;
 
@@ -3037,6 +3039,8 @@ static int perf_c2c__report(int argc, const char **argv)
 	OPT_BOOLEAN('f', "force", &symbol_conf.force, "don't complain, do it"),
 	OPT_BOOLEAN(0, "stitch-lbr", &c2c.stitch_lbr,
 		    "Enable LBR callgraph stitching approach"),
+	OPT_BOOLEAN('a', "double-cl", &chk_double_cl,
+		    "Check adjacent cachline false sharing"),
 	OPT_PARENT(c2c_options),
 	OPT_END()
 	};
diff --git a/tools/perf/util/cacheline.h b/tools/perf/util/cacheline.h
index dec8c0fb1f4a..630d16731b4f 100644
--- a/tools/perf/util/cacheline.h
+++ b/tools/perf/util/cacheline.h
@@ -6,16 +6,31 @@
 
 int __pure cacheline_size(void);
 
-static inline u64 cl_address(u64 address)
+
+/*
+ * Some architecture has 'Adjacent Cacheline Prefetch' feature,
+ * which performs like the cacheline size being doubled.
+ */
+static inline u64 cl_address(u64 address, bool double_cl)
 {
+	u64 size = cacheline_size();
+
+	if (double_cl)
+		size *= 2;
+
 	/* return the cacheline of the address */
-	return (address & ~(cacheline_size() - 1));
+	return (address & ~(size - 1));
 }
 
-static inline u64 cl_offset(u64 address)
+static inline u64 cl_offset(u64 address, bool double_cl)
 {
-	/* return the cacheline of the address */
-	return (address & (cacheline_size() - 1));
+	u64 size = cacheline_size();
+
+	if (double_cl)
+		size *= 2;
+
+	/* return the offset inside cachline */
+	return (address & (size - 1));
 }
 
 #endif // PERF_CACHELINE_H
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index e188f74698dd..148b28f0a7e2 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -52,6 +52,13 @@ enum sort_mode	sort__mode = SORT_MODE__NORMAL;
 static const char *const dynamic_headers[] = {"local_ins_lat", "ins_lat", "local_p_stage_cyc", "p_stage_cyc"};
 static const char *const arch_specific_sort_keys[] = {"local_p_stage_cyc", "p_stage_cyc"};
 
+/*
+ * Some architecture has Adjacent Cacheline Prefetch feature, which behaves
+ * like the cachline size is doubled. Enable this flag to check things in
+ * double cacheline granularity.
+ */
+bool chk_double_cl;
+
 /*
  * Replaces all occurrences of a char used with the:
  *
@@ -1499,8 +1506,8 @@ sort__dcacheline_cmp(struct hist_entry *left, struct hist_entry *right)
 
 addr:
 	/* al_addr does all the right addr - start + offset calculations */
-	l = cl_address(left->mem_info->daddr.al_addr);
-	r = cl_address(right->mem_info->daddr.al_addr);
+	l = cl_address(left->mem_info->daddr.al_addr, chk_double_cl);
+	r = cl_address(right->mem_info->daddr.al_addr, chk_double_cl);
 
 	if (l > r) return -1;
 	if (l < r) return 1;
@@ -1519,7 +1526,7 @@ static int hist_entry__dcacheline_snprintf(struct hist_entry *he, char *bf,
 	if (he->mem_info) {
 		struct map *map = he->mem_info->daddr.ms.map;
 
-		addr = cl_address(he->mem_info->daddr.al_addr);
+		addr = cl_address(he->mem_info->daddr.al_addr, chk_double_cl);
 		ms = &he->mem_info->daddr.ms;
 
 		/* print [s] for shared data mmaps */
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 921715e6aec4..04f0a6dc7381 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -35,6 +35,7 @@ extern struct sort_entry sort_sym_from;
 extern struct sort_entry sort_sym_to;
 extern struct sort_entry sort_srcline;
 extern const char default_mem_sort_order[];
+extern bool chk_double_cl;
 
 struct res_sample {
 	u64 time;
-- 
2.30.2

