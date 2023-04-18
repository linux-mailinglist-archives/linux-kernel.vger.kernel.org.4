Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DE86E57CC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 05:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjDRDTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 23:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjDRDS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 23:18:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7026E6;
        Mon, 17 Apr 2023 20:18:50 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [7.221.188.120])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Q0pxq3z4hzsR8C;
        Tue, 18 Apr 2023 11:17:19 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 18 Apr 2023 11:18:47 +0800
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
Subject: [PATCH v5 3/3] perf: script: add new output field 'dsoff' to print dso offset
Date:   Tue, 18 Apr 2023 11:18:25 +0800
Message-ID: <20230418031825.1262579-4-changbin.du@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230418031825.1262579-1-changbin.du@huawei.com>
References: <20230418031825.1262579-1-changbin.du@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a new 'dsoff' field to print dso offset for resolved symbols,
and the offset is appended to dso name.

Default output:
$ perf script
       ls 2695501 3011030.487017:     500000 cycles:      152cc73ef4b5 get_common_indices.constprop.0+0x155 (/usr/lib/x86_64-linux-gnu/ld-2.31.so)
       ls 2695501 3011030.487018:     500000 cycles:  ffffffff99045b3e [unknown] ([unknown])
       ls 2695501 3011030.487018:     500000 cycles:  ffffffff9968e107 [unknown] ([unknown])
       ls 2695501 3011030.487018:     500000 cycles:  ffffffffc1f54afb [unknown] ([unknown])
       ls 2695501 3011030.487018:     500000 cycles:  ffffffff9968382f [unknown] ([unknown])
       ls 2695501 3011030.487019:     500000 cycles:  ffffffff99e00094 [unknown] ([unknown])
       ls 2695501 3011030.487019:     500000 cycles:      152cc718a8d0 __errno_location@plt+0x0 (/usr/lib/x86_64-linux-gnu/libselinux.so.1)

Display 'dsoff' field:
$ perf script -F +dsoff
       ls 2695501 3011030.487017:     500000 cycles:      152cc73ef4b5 get_common_indices.constprop.0+0x155 (/usr/lib/x86_64-linux-gnu/ld-2.31.so+0x1c4b5)
       ls 2695501 3011030.487018:     500000 cycles:  ffffffff99045b3e [unknown] ([unknown])
       ls 2695501 3011030.487018:     500000 cycles:  ffffffff9968e107 [unknown] ([unknown])
       ls 2695501 3011030.487018:     500000 cycles:  ffffffffc1f54afb [unknown] ([unknown])
       ls 2695501 3011030.487018:     500000 cycles:  ffffffff9968382f [unknown] ([unknown])
       ls 2695501 3011030.487019:     500000 cycles:  ffffffff99e00094 [unknown] ([unknown])
       ls 2695501 3011030.487019:     500000 cycles:      152cc718a8d0 __errno_location@plt+0x0 (/usr/lib/x86_64-linux-gnu/libselinux.so.1+0x68d0)
       ls 2695501 3011030.487019:     500000 cycles:  ffffffff992a6db0 [unknown] ([unknown])

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/Documentation/perf-script.txt |  2 +-
 tools/perf/builtin-script.c              | 60 ++++++++++--------------
 tools/perf/util/evsel_fprintf.c          | 16 +++----
 tools/perf/util/evsel_fprintf.h          |  1 +
 4 files changed, 32 insertions(+), 47 deletions(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 777a0d8ba7d1..ff9a52e44688 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -130,7 +130,7 @@ OPTIONS
 -F::
 --fields::
         Comma separated list of fields to print. Options are:
-        comm, tid, pid, time, cpu, event, trace, ip, sym, dso, addr, symoff,
+        comm, tid, pid, time, cpu, event, trace, ip, sym, dso, dsoff, addr, symoff,
         srcline, period, iregs, uregs, brstack, brstacksym, flags, bpf-output,
         brstackinsn, brstackinsnlen, brstackoff, callindent, insn, insnlen, synth,
         phys_addr, metric, misc, srccode, ipc, data_page_size, code_page_size, ins_lat,
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 8fba247b798c..e7cb8d904eb5 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -133,6 +133,7 @@ enum perf_output_field {
 	PERF_OUTPUT_VCPU            = 1ULL << 38,
 	PERF_OUTPUT_CGROUP          = 1ULL << 39,
 	PERF_OUTPUT_RETIRE_LAT      = 1ULL << 40,
+	PERF_OUTPUT_DSOFF           = 1ULL << 41,
 };
 
 struct perf_script {
@@ -174,6 +175,7 @@ struct output_option {
 	{.str = "ip",    .field = PERF_OUTPUT_IP},
 	{.str = "sym",   .field = PERF_OUTPUT_SYM},
 	{.str = "dso",   .field = PERF_OUTPUT_DSO},
+	{.str = "dsoff", .field = PERF_OUTPUT_DSOFF},
 	{.str = "addr",  .field = PERF_OUTPUT_ADDR},
 	{.str = "symoff", .field = PERF_OUTPUT_SYMOFFSET},
 	{.str = "srcline", .field = PERF_OUTPUT_SRCLINE},
@@ -574,6 +576,9 @@ static void set_print_ip_opts(struct perf_event_attr *attr)
 	if (PRINT_FIELD(DSO))
 		output[type].print_ip_opts |= EVSEL__PRINT_DSO;
 
+	if (PRINT_FIELD(DSOFF))
+		output[type].print_ip_opts |= EVSEL__PRINT_DSOFF;
+
 	if (PRINT_FIELD(SYMOFFSET))
 		output[type].print_ip_opts |= EVSEL__PRINT_SYMOFFSET;
 
@@ -627,6 +632,10 @@ static int perf_session__check_output_opt(struct perf_session *session)
 		if (evsel == NULL)
 			continue;
 
+		/* 'dsoff' implys 'dso' field */
+		if (output[j].fields & PERF_OUTPUT_DSOFF)
+			output[j].fields |= PERF_OUTPUT_DSO;
+
 		set_print_ip_opts(&evsel->core.attr);
 		tod |= output[j].fields & PERF_OUTPUT_TOD;
 	}
@@ -929,18 +938,12 @@ static int perf_sample__fprintf_brstack(struct perf_sample *sample,
 		}
 
 		printed += fprintf(fp, " 0x%"PRIx64, from);
-		if (PRINT_FIELD(DSO)) {
-			printed += fprintf(fp, "(");
-			printed += map__fprintf_dsoname(alf.map, fp);
-			printed += fprintf(fp, ")");
-		}
+		if (PRINT_FIELD(DSO))
+			printed += map__fprintf_dsoname_dsoff(alf.map, PRINT_FIELD(DSOFF), alf.addr, fp);
 
 		printed += fprintf(fp, "/0x%"PRIx64, to);
-		if (PRINT_FIELD(DSO)) {
-			printed += fprintf(fp, "(");
-			printed += map__fprintf_dsoname(alt.map, fp);
-			printed += fprintf(fp, ")");
-		}
+		if (PRINT_FIELD(DSO))
+			printed += map__fprintf_dsoname_dsoff(alt.map, PRINT_FIELD(DSOFF), alt.addr, fp);
 
 		printed += print_bstack_flags(fp, entries + i);
 	}
@@ -972,18 +975,12 @@ static int perf_sample__fprintf_brstacksym(struct perf_sample *sample,
 		thread__find_symbol_fb(thread, sample->cpumode, to, &alt);
 
 		printed += symbol__fprintf_symname_offs(alf.sym, &alf, fp);
-		if (PRINT_FIELD(DSO)) {
-			printed += fprintf(fp, "(");
-			printed += map__fprintf_dsoname(alf.map, fp);
-			printed += fprintf(fp, ")");
-		}
+		if (PRINT_FIELD(DSO))
+			printed += map__fprintf_dsoname_dsoff(alf.map, PRINT_FIELD(DSOFF), alf.addr, fp);
 		printed += fprintf(fp, "%c", '/');
 		printed += symbol__fprintf_symname_offs(alt.sym, &alt, fp);
-		if (PRINT_FIELD(DSO)) {
-			printed += fprintf(fp, "(");
-			printed += map__fprintf_dsoname(alt.map, fp);
-			printed += fprintf(fp, ")");
-		}
+		if (PRINT_FIELD(DSO))
+			printed += map__fprintf_dsoname_dsoff(alt.map, PRINT_FIELD(DSOFF), alt.addr, fp);
 		printed += print_bstack_flags(fp, entries + i);
 	}
 
@@ -1019,17 +1016,11 @@ static int perf_sample__fprintf_brstackoff(struct perf_sample *sample,
 			to = map__dso_map_ip(alt.map, to);
 
 		printed += fprintf(fp, " 0x%"PRIx64, from);
-		if (PRINT_FIELD(DSO)) {
-			printed += fprintf(fp, "(");
-			printed += map__fprintf_dsoname(alf.map, fp);
-			printed += fprintf(fp, ")");
-		}
+		if (PRINT_FIELD(DSO))
+			printed += map__fprintf_dsoname_dsoff(alf.map, PRINT_FIELD(DSOFF), alf.addr, fp);
 		printed += fprintf(fp, "/0x%"PRIx64, to);
-		if (PRINT_FIELD(DSO)) {
-			printed += fprintf(fp, "(");
-			printed += map__fprintf_dsoname(alt.map, fp);
-			printed += fprintf(fp, ")");
-		}
+		if (PRINT_FIELD(DSO))
+			printed += map__fprintf_dsoname_dsoff(alt.map, PRINT_FIELD(DSOFF), alt.addr, fp);
 		printed += print_bstack_flags(fp, entries + i);
 	}
 
@@ -1394,11 +1385,8 @@ static int perf_sample__fprintf_addr(struct perf_sample *sample,
 			printed += symbol__fprintf_symname(al.sym, fp);
 	}
 
-	if (PRINT_FIELD(DSO)) {
-		printed += fprintf(fp, " (");
-		printed += map__fprintf_dsoname(al.map, fp);
-		printed += fprintf(fp, ")");
-	}
+	if (PRINT_FIELD(DSO))
+		printed += map__fprintf_dsoname_dsoff(al.map, PRINT_FIELD(DSOFF), al.addr, fp);
 out:
 	return printed;
 }
@@ -3877,7 +3865,7 @@ int cmd_script(int argc, const char **argv)
 		     "comma separated output fields prepend with 'type:'. "
 		     "+field to add and -field to remove."
 		     "Valid types: hw,sw,trace,raw,synth. "
-		     "Fields: comm,tid,pid,time,cpu,event,trace,ip,sym,dso,"
+		     "Fields: comm,tid,pid,time,cpu,event,trace,ip,sym,dso,dsoff"
 		     "addr,symoff,srcline,period,iregs,uregs,brstack,"
 		     "brstacksym,flags,data_src,weight,bpf-output,brstackinsn,"
 		     "brstackinsnlen,brstackoff,callindent,insn,insnlen,synth,"
diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index cc80ec554c0a..79e42d66f55b 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -116,6 +116,7 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 	int print_ip = print_opts & EVSEL__PRINT_IP;
 	int print_sym = print_opts & EVSEL__PRINT_SYM;
 	int print_dso = print_opts & EVSEL__PRINT_DSO;
+	int print_dsoff = print_opts & EVSEL__PRINT_DSOFF;
 	int print_symoffset = print_opts & EVSEL__PRINT_SYMOFFSET;
 	int print_oneline = print_opts & EVSEL__PRINT_ONELINE;
 	int print_srcline = print_opts & EVSEL__PRINT_SRCLINE;
@@ -171,11 +172,8 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 				}
 			}
 
-			if (print_dso && (!sym || !sym->inlined)) {
-				printed += fprintf(fp, " (");
-				printed += map__fprintf_dsoname(map, fp);
-				printed += fprintf(fp, ")");
-			}
+			if (print_dso && (!sym || !sym->inlined))
+				printed += map__fprintf_dsoname_dsoff(map, print_dsoff, addr, fp);
 
 			if (print_srcline)
 				printed += map__fprintf_srcline(map, addr, "\n  ", fp);
@@ -209,6 +207,7 @@ int sample__fprintf_sym(struct perf_sample *sample, struct addr_location *al,
 	int print_ip = print_opts & EVSEL__PRINT_IP;
 	int print_sym = print_opts & EVSEL__PRINT_SYM;
 	int print_dso = print_opts & EVSEL__PRINT_DSO;
+	int print_dsoff = print_opts & EVSEL__PRINT_DSOFF;
 	int print_symoffset = print_opts & EVSEL__PRINT_SYMOFFSET;
 	int print_srcline = print_opts & EVSEL__PRINT_SRCLINE;
 	int print_unknown_as_addr = print_opts & EVSEL__PRINT_UNKNOWN_AS_ADDR;
@@ -234,11 +233,8 @@ int sample__fprintf_sym(struct perf_sample *sample, struct addr_location *al,
 			}
 		}
 
-		if (print_dso) {
-			printed += fprintf(fp, " (");
-			printed += map__fprintf_dsoname(al->map, fp);
-			printed += fprintf(fp, ")");
-		}
+		if (print_dso)
+			printed += map__fprintf_dsoname_dsoff(al->map, print_dsoff, al->addr, fp);
 
 		if (print_srcline)
 			printed += map__fprintf_srcline(al->map, al->addr, "\n  ", fp);
diff --git a/tools/perf/util/evsel_fprintf.h b/tools/perf/util/evsel_fprintf.h
index 3093d096c29f..c8a9fac2f2dd 100644
--- a/tools/perf/util/evsel_fprintf.h
+++ b/tools/perf/util/evsel_fprintf.h
@@ -26,6 +26,7 @@ int evsel__fprintf(struct evsel *evsel, struct perf_attr_details *details, FILE
 #define EVSEL__PRINT_UNKNOWN_AS_ADDR	(1<<6)
 #define EVSEL__PRINT_CALLCHAIN_ARROW	(1<<7)
 #define EVSEL__PRINT_SKIP_IGNORED	(1<<8)
+#define EVSEL__PRINT_DSOFF		(1<<9)
 
 struct addr_location;
 struct perf_event_attr;
-- 
2.25.1

