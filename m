Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC336D1CCE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbjCaJn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjCaJny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:43:54 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F000849EF;
        Fri, 31 Mar 2023 02:43:25 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PnwLW6lPWzKq6D;
        Fri, 31 Mar 2023 17:42:27 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 17:42:58 +0800
From:   Changbin Du <changbin.du@huawei.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hui Wang <hw.huiwang@huawei.com>,
        Changbin Du <changbin.du@huawei.com>
Subject: [PATCH] perf: script: add new output field 'dsoip'
Date:   Fri, 31 Mar 2023 16:44:18 +0800
Message-ID: <20230331084418.3910903-1-changbin.du@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal of this change is to achieve consistent output for address. Before
this, the raw ip is printed for non-callchain and binary offset for
callchain. Mostly what we expect is the raw ip.

This patch does two changes:
  - Always print raw ip for symbols.
  - Add a new 'dsoip' field if we really need the binary offset, and the
    offset is appended to dso name.

Default output now:
$ perf script
       perf-exec 171459 5380927.621499:          1 cycles:  ffffffff8c66e1b8 [unknown] ([unknown])
       perf-exec 171459 5380927.621524:          1 cycles:  ffffffff8c66e1b8 [unknown] ([unknown])
       perf-exec 171459 5380927.621527:          2 cycles:  ffffffff8c66e1b8 [unknown] ([unknown])
       perf-exec 171459 5380927.621530:         17 cycles:  ffffffff8c66e1b8 [unknown] ([unknown])
       perf-exec 171459 5380927.621533:        194 cycles:  ffffffff8c66e1bf [unknown] ([unknown])
       perf-exec 171459 5380927.621536:       2153 cycles:  ffffffff8c6375fe [unknown] ([unknown])
       perf-exec 171459 5380927.621540:      23135 cycles:  ffffffff8d001ac4 [unknown] ([unknown])
       perf-exec 171459 5380927.621555:     224703 cycles:  ffffffff8c7a5153 [unknown] ([unknown])
              ls 171459 5380927.621686:     587397 cycles:  ffffffff8c7c43de [unknown] ([unknown])
              ls 171459 5380927.622016:     653693 cycles:      7fe1e47278c7 _dl_map_object_deps+0x307 (/lib/x86_64-linux-gnu/ld-2.27.so)
              ls 171459 5380927.622382:     633896 cycles:      7fe1e41bd0d0 __wmemchr_ifunc+0x0 (/lib/x86_64-linux-gnu/libc-2.27.so)
              ls 171459 5380927.622737:     608856 cycles:      7fe1e4194594 _int_malloc+0x264 (/lib/x86_64-linux-gnu/libc-2.27.so)
              ls 171459 5380927.623078:     586376 cycles:      55ff5293d27c [unknown] (/bin/ls)
              ls 171459 5380927.623405:     566812 cycles:      55ff5293b202 [unknown] (/bin/ls)
              ls 171459 5380927.623723:     549960 cycles:  ffffffff8c82b138 [unknown] ([unknown])

Display 'dsoip' field:
$ perf script -F +dsoip
       perf-exec 171459 5380927.621499:          1 cycles:  ffffffff8c66e1b8 [unknown] ([unknown]+0x0)
       perf-exec 171459 5380927.621524:          1 cycles:  ffffffff8c66e1b8 [unknown] ([unknown]+0x0)
       perf-exec 171459 5380927.621527:          2 cycles:  ffffffff8c66e1b8 [unknown] ([unknown]+0x0)
       perf-exec 171459 5380927.621530:         17 cycles:  ffffffff8c66e1b8 [unknown] ([unknown]+0x0)
       perf-exec 171459 5380927.621533:        194 cycles:  ffffffff8c66e1bf [unknown] ([unknown]+0x0)
       perf-exec 171459 5380927.621536:       2153 cycles:  ffffffff8c6375fe [unknown] ([unknown]+0x0)
       perf-exec 171459 5380927.621540:      23135 cycles:  ffffffff8d001ac4 [unknown] ([unknown]+0x0)
       perf-exec 171459 5380927.621555:     224703 cycles:  ffffffff8c7a5153 [unknown] ([unknown]+0x0)
              ls 171459 5380927.621686:     587397 cycles:  ffffffff8c7c43de [unknown] ([unknown]+0x0)
              ls 171459 5380927.622016:     653693 cycles:      7fe1e47278c7 _dl_map_object_deps+0x307 (/lib/x86_64-linux-gnu/ld-2.27.so+0xe8c7)
              ls 171459 5380927.622382:     633896 cycles:      7fe1e41bd0d0 __wmemchr_ifunc+0x0 (/lib/x86_64-linux-gnu/libc-2.27.so+0xbd0d0)
              ls 171459 5380927.622737:     608856 cycles:      7fe1e4194594 _int_malloc+0x264 (/lib/x86_64-linux-gnu/libc-2.27.so+0x94594)
              ls 171459 5380927.623078:     586376 cycles:      55ff5293d27c [unknown] (/bin/ls+0x1227c)
              ls 171459 5380927.623405:     566812 cycles:      55ff5293b202 [unknown] (/bin/ls+0x10202)
              ls 171459 5380927.623723:     549960 cycles:  ffffffff8c82b138 [unknown] ([unknown]+0x0)

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/Documentation/perf-script.txt |  2 +-
 tools/perf/builtin-script.c              |  5 +++++
 tools/perf/util/evsel_fprintf.c          | 26 ++++++++++++------------
 tools/perf/util/evsel_fprintf.h          | 13 ++++++------
 4 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 777a0d8ba7d1..ef392785f776 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -130,7 +130,7 @@ OPTIONS
 -F::
 --fields::
         Comma separated list of fields to print. Options are:
-        comm, tid, pid, time, cpu, event, trace, ip, sym, dso, addr, symoff,
+        comm, tid, pid, time, cpu, event, trace, ip, sym, dso, dsoip, addr, symoff,
         srcline, period, iregs, uregs, brstack, brstacksym, flags, bpf-output,
         brstackinsn, brstackinsnlen, brstackoff, callindent, insn, insnlen, synth,
         phys_addr, metric, misc, srccode, ipc, data_page_size, code_page_size, ins_lat,
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index a792214d1af8..a181decf7922 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -133,6 +133,7 @@ enum perf_output_field {
 	PERF_OUTPUT_VCPU            = 1ULL << 38,
 	PERF_OUTPUT_CGROUP          = 1ULL << 39,
 	PERF_OUTPUT_RETIRE_LAT      = 1ULL << 40,
+	PERF_OUTPUT_DSOIP           = 1ULL << 41,
 };
 
 struct perf_script {
@@ -174,6 +175,7 @@ struct output_option {
 	{.str = "ip",    .field = PERF_OUTPUT_IP},
 	{.str = "sym",   .field = PERF_OUTPUT_SYM},
 	{.str = "dso",   .field = PERF_OUTPUT_DSO},
+	{.str = "dsoip", .field = PERF_OUTPUT_DSOIP},
 	{.str = "addr",  .field = PERF_OUTPUT_ADDR},
 	{.str = "symoff", .field = PERF_OUTPUT_SYMOFFSET},
 	{.str = "srcline", .field = PERF_OUTPUT_SRCLINE},
@@ -574,6 +576,9 @@ static void set_print_ip_opts(struct perf_event_attr *attr)
 	if (PRINT_FIELD(DSO))
 		output[type].print_ip_opts |= EVSEL__PRINT_DSO;
 
+	if (PRINT_FIELD(DSOIP))
+		output[type].print_ip_opts |= EVSEL__PRINT_DSOIP;
+
 	if (PRINT_FIELD(SYMOFFSET))
 		output[type].print_ip_opts |= EVSEL__PRINT_SYMOFFSET;
 
diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index bd22c4932d10..fd1791fab051 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -116,6 +116,7 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 	int print_ip = print_opts & EVSEL__PRINT_IP;
 	int print_sym = print_opts & EVSEL__PRINT_SYM;
 	int print_dso = print_opts & EVSEL__PRINT_DSO;
+	int print_dsoip = print_opts & EVSEL__PRINT_DSOIP;
 	int print_symoffset = print_opts & EVSEL__PRINT_SYMOFFSET;
 	int print_oneline = print_opts & EVSEL__PRINT_ONELINE;
 	int print_srcline = print_opts & EVSEL__PRINT_SRCLINE;
@@ -133,7 +134,7 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 		while (1) {
 			struct symbol *sym;
 			struct map *map;
-			u64 addr = 0;
+			u64 dso_ip = 0;
 
 			node = callchain_cursor_current(cursor);
 			if (!node)
@@ -141,6 +142,8 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 
 			sym = node->ms.sym;
 			map = node->ms.map;
+			if (map)
+				dso_ip = map->map_ip(map, node->ip);
 
 			if (sym && sym->ignore && print_skip_ignored)
 				goto next;
@@ -150,20 +153,12 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 			if (print_arrow && !first)
 				printed += fprintf(fp, " <-");
 
-			if (map)
-				addr = map->map_ip(map, node->ip);
-
-			if (print_ip) {
-				/* Show binary offset for userspace addr */
-				if (map && !map->dso->kernel)
-					printed += fprintf(fp, "%c%16" PRIx64, s, addr);
-				else
-					printed += fprintf(fp, "%c%16" PRIx64, s, node->ip);
-			}
+			if (print_ip)
+				printed += fprintf(fp, "%c%16" PRIx64, s, node->ip);
 
 			if (print_sym) {
 				printed += fprintf(fp, " ");
-				node_al.addr = addr;
+				node_al.addr = dso_ip;
 				node_al.map  = map;
 
 				if (print_symoffset) {
@@ -179,11 +174,13 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 			if (print_dso && (!sym || !sym->inlined)) {
 				printed += fprintf(fp, " (");
 				printed += map__fprintf_dsoname(map, fp);
+				if (print_dsoip)
+					printed += fprintf(fp, "+0x%lx", (map && map->dso) ? dso_ip : 0);
 				printed += fprintf(fp, ")");
 			}
 
 			if (print_srcline)
-				printed += map__fprintf_srcline(map, addr, "\n  ", fp);
+				printed += map__fprintf_srcline(map, dso_ip, "\n  ", fp);
 
 			if (sym && sym->inlined)
 				printed += fprintf(fp, " (inlined)");
@@ -214,6 +211,7 @@ int sample__fprintf_sym(struct perf_sample *sample, struct addr_location *al,
 	int print_ip = print_opts & EVSEL__PRINT_IP;
 	int print_sym = print_opts & EVSEL__PRINT_SYM;
 	int print_dso = print_opts & EVSEL__PRINT_DSO;
+	int print_dsoip = print_opts & EVSEL__PRINT_DSOIP;
 	int print_symoffset = print_opts & EVSEL__PRINT_SYMOFFSET;
 	int print_srcline = print_opts & EVSEL__PRINT_SRCLINE;
 	int print_unknown_as_addr = print_opts & EVSEL__PRINT_UNKNOWN_AS_ADDR;
@@ -242,6 +240,8 @@ int sample__fprintf_sym(struct perf_sample *sample, struct addr_location *al,
 		if (print_dso) {
 			printed += fprintf(fp, " (");
 			printed += map__fprintf_dsoname(al->map, fp);
+			if (print_dsoip)
+				printed += fprintf(fp, "+0x%lx", (al->map && al->map->dso) ? al->addr : 0);
 			printed += fprintf(fp, ")");
 		}
 
diff --git a/tools/perf/util/evsel_fprintf.h b/tools/perf/util/evsel_fprintf.h
index 3093d096c29f..3f282c5840da 100644
--- a/tools/perf/util/evsel_fprintf.h
+++ b/tools/perf/util/evsel_fprintf.h
@@ -20,12 +20,13 @@ int evsel__fprintf(struct evsel *evsel, struct perf_attr_details *details, FILE
 #define EVSEL__PRINT_IP			(1<<0)
 #define EVSEL__PRINT_SYM		(1<<1)
 #define EVSEL__PRINT_DSO		(1<<2)
-#define EVSEL__PRINT_SYMOFFSET		(1<<3)
-#define EVSEL__PRINT_ONELINE		(1<<4)
-#define EVSEL__PRINT_SRCLINE		(1<<5)
-#define EVSEL__PRINT_UNKNOWN_AS_ADDR	(1<<6)
-#define EVSEL__PRINT_CALLCHAIN_ARROW	(1<<7)
-#define EVSEL__PRINT_SKIP_IGNORED	(1<<8)
+#define EVSEL__PRINT_DSOIP		(1<<3)
+#define EVSEL__PRINT_SYMOFFSET		(1<<4)
+#define EVSEL__PRINT_ONELINE		(1<<5)
+#define EVSEL__PRINT_SRCLINE		(1<<6)
+#define EVSEL__PRINT_UNKNOWN_AS_ADDR	(1<<7)
+#define EVSEL__PRINT_CALLCHAIN_ARROW	(1<<8)
+#define EVSEL__PRINT_SKIP_IGNORED	(1<<9)
 
 struct addr_location;
 struct perf_event_attr;
-- 
2.25.1

