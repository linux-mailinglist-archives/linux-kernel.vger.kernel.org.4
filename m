Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A033F5B327A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiIII5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiIII44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:56:56 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F851377BB;
        Fri,  9 Sep 2022 01:55:32 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MP8qM4NjPz14QR7;
        Fri,  9 Sep 2022 16:51:27 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemi500013.china.huawei.com (7.221.188.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 16:55:17 +0800
From:   Changbin Du <changbin.du@huawei.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        Hui Wang <hw.huiwang@huawei.com>, <changbin.du@gmail.com>,
        Changbin Du <changbin.du@huawei.com>
Subject: [PATCH 3/3] perf: script: Deprecate the '--xed' option
Date:   Fri, 9 Sep 2022 16:48:21 +0800
Message-ID: <20220909084821.7894-4-changbin.du@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220909084821.7894-1-changbin.du@huawei.com>
References: <20220909084821.7894-1-changbin.du@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.110.54.157]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now perf can show assembly instructions with libcapstone for both x86 and
Arm. So the old '--xed' option should not be used.

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/Documentation/build-xed.txt     | 19 -------------------
 tools/perf/Documentation/perf-intel-pt.txt | 17 +++++------------
 tools/perf/Documentation/perf-script.txt   |  5 ++---
 tools/perf/Documentation/tips.txt          |  2 +-
 tools/perf/builtin-script.c                |  7 ++-----
 tools/perf/ui/browsers/res_sample.c        |  2 +-
 tools/perf/ui/browsers/scripts.c           |  4 ++--
 7 files changed, 13 insertions(+), 43 deletions(-)
 delete mode 100644 tools/perf/Documentation/build-xed.txt

diff --git a/tools/perf/Documentation/build-xed.txt b/tools/perf/Documentation/build-xed.txt
deleted file mode 100644
index 6222c1e7231f..000000000000
--- a/tools/perf/Documentation/build-xed.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-
-For --xed the xed tool is needed. Here is how to install it:
-
-  $ git clone https://github.com/intelxed/mbuild.git mbuild
-  $ git clone https://github.com/intelxed/xed
-  $ cd xed
-  $ ./mfile.py --share
-  $ ./mfile.py examples
-  $ sudo ./mfile.py --prefix=/usr/local install
-  $ sudo ldconfig
-  $ sudo cp obj/examples/xed /usr/local/bin
-
-Basic xed testing:
-
-  $ xed | head -3
-  ERROR: required argument(s) were missing
-  Copyright (C) 2017, Intel Corporation. All rights reserved.
-  XED version: [v10.0-328-g7d62c8c49b7b]
-  $
diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index 3dc3f0ccbd51..2a598927f36c 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -115,9 +115,8 @@ toggle respectively.
 
 perf script also supports higher level ways to dump instruction traces:
 
-	perf script --insn-trace --xed
+	perf script --insn-trace
 
-Dump all instructions. This requires installing the xed tool (see XED below)
 Dumping all instructions in a long trace can be fairly slow. It is usually better
 to start with higher level decoding, like
 
@@ -130,12 +129,12 @@ or
 and then select a time range of interest. The time range can then be examined
 in detail with
 
-	perf script --time starttime,stoptime --insn-trace --xed
+	perf script --time starttime,stoptime --insn-trace
 
 While examining the trace it's also useful to filter on specific CPUs using
 the -C option
 
-	perf script --time starttime,stoptime --insn-trace --xed -C 1
+	perf script --time starttime,stoptime --insn-trace -C 1
 
 Dump all instructions in time range on CPU 1.
 
@@ -1212,12 +1211,6 @@ To display PEBS events from the Intel PT trace, use the itrace 'o' option e.g.
 
 	perf script --itrace=oe
 
-XED
----
-
-include::build-xed.txt[]
-
-
 Tracing Virtual Machines (kernel only)
 --------------------------------------
 
@@ -1275,7 +1268,7 @@ Without timestamps, --per-thread must be specified to distinguish threads.
 
 perf script can be used to provide an instruction trace
 
- $ perf script --guestkallsyms $KALLSYMS --insn-trace --xed -F+ipc | grep -C10 vmresume | head -21
+ $ perf script --guestkallsyms $KALLSYMS --insn-trace -F+ipc | grep -C10 vmresume | head -21
        CPU 0/KVM  1440  ffffffff82133cdd __vmx_vcpu_run+0x3d ([kernel.kallsyms])                movq  0x48(%rax), %r9
        CPU 0/KVM  1440  ffffffff82133ce1 __vmx_vcpu_run+0x41 ([kernel.kallsyms])                movq  0x50(%rax), %r10
        CPU 0/KVM  1440  ffffffff82133ce5 __vmx_vcpu_run+0x45 ([kernel.kallsyms])                movq  0x58(%rax), %r11
@@ -1376,7 +1369,7 @@ There were none.
 
 'perf script' can be used to provide an instruction trace showing timestamps
 
- $ perf script -i perf.data.kvm --guestkallsyms $KALLSYMS --insn-trace --xed -F+ipc | grep -C10 vmresume | head -21
+ $ perf script -i perf.data.kvm --guestkallsyms $KALLSYMS --insn-trace -F+ipc | grep -C10 vmresume | head -21
        CPU 1/KVM 17006 [001] 11500.262865593:  ffffffff82133cdd __vmx_vcpu_run+0x3d ([kernel.kallsyms])                 movq  0x48(%rax), %r9
        CPU 1/KVM 17006 [001] 11500.262865593:  ffffffff82133ce1 __vmx_vcpu_run+0x41 ([kernel.kallsyms])                 movq  0x50(%rax), %r10
        CPU 1/KVM 17006 [001] 11500.262865593:  ffffffff82133ce5 __vmx_vcpu_run+0x45 ([kernel.kallsyms])                 movq  0x58(%rax), %r11
diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 68e37de5fae4..5929f44d24fc 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -439,11 +439,10 @@ include::itrace.txt[]
 	default, disable with --no-inline.
 
 --insn-trace::
-	Show instruction stream for intel_pt traces. Combine with --xed to
-	show disassembly.
+	Show instruction stream for intel_pt traces.
 
 --xed::
-	Run xed disassembler on output. Requires installing the xed disassembler.
+	Run xed disassembler on output. (deprecated)
 
 -S::
 --symbols=symbol[,symbol...]::
diff --git a/tools/perf/Documentation/tips.txt b/tools/perf/Documentation/tips.txt
index 825745a645c1..5e1182514730 100644
--- a/tools/perf/Documentation/tips.txt
+++ b/tools/perf/Documentation/tips.txt
@@ -15,7 +15,7 @@ To see callchains in a more compact form: perf report -g folded
 Show individual samples with: perf script
 Limit to show entries above 5% only: perf report --percent-limit 5
 Profiling branch (mis)predictions with: perf record -b / perf report
-To show assembler sample contexts use perf record -b / perf script -F +brstackinsn --xed
+To show assembler sample contexts use perf record -b / perf script -F +brstackinsn
 Treat branches as callchains: perf report --branch-history
 To count events in every 1000 msec: perf stat -I 1000
 Print event counts in CSV format with: perf stat -x,
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 2c7b4631f1d7..dcc4bab9ff36 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3721,10 +3721,7 @@ static int parse_xed(const struct option *opt __maybe_unused,
 		     const char *str __maybe_unused,
 		     int unset __maybe_unused)
 {
-	if (isatty(1))
-		force_pager("xed -F insn: -A -64 | less");
-	else
-		force_pager("xed -F insn: -A -64");
+	pr_warning("xed option is deprecated\n");
 	return 0;
 }
 
@@ -3857,7 +3854,7 @@ int cmd_script(int argc, const char **argv)
 	OPT_CALLBACK_OPTARG(0, "insn-trace", &itrace_synth_opts, NULL, NULL,
 			"Decode instructions from itrace", parse_insn_trace),
 	OPT_CALLBACK_OPTARG(0, "xed", NULL, NULL, NULL,
-			"Run xed disassembler on output", parse_xed),
+			"Run xed disassembler on output (deprecated)", parse_xed),
 	OPT_CALLBACK_OPTARG(0, "call-trace", &itrace_synth_opts, NULL, NULL,
 			"Decode calls from itrace", parse_call_trace),
 	OPT_CALLBACK_OPTARG(0, "call-ret-trace", &itrace_synth_opts, NULL, NULL,
diff --git a/tools/perf/ui/browsers/res_sample.c b/tools/perf/ui/browsers/res_sample.c
index 7cb2d6678039..382f1fb07a73 100644
--- a/tools/perf/ui/browsers/res_sample.c
+++ b/tools/perf/ui/browsers/res_sample.c
@@ -83,7 +83,7 @@ int res_sample_browse(struct res_sample *res_samples, int num_res,
 		     r->tid ? "--tid " : "",
 		     r->tid ? (sprintf(tidbuf, "%d", r->tid), tidbuf) : "",
 		     extra_format,
-		     rstype == A_ASM ? "-F +insn --xed" :
+		     rstype == A_ASM ? "-F +insn" :
 		     rstype == A_SOURCE ? "-F +srcline,+srccode" : "",
 		     symbol_conf.inline_name ? "--inline" : "",
 		     "--show-lost-events ",
diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
index 47d2c7a8cbe1..056c51a95712 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -37,7 +37,7 @@ void attr_to_script(char *extra_format, struct perf_event_attr *attr)
 	if (attr->read_format & PERF_FORMAT_GROUP)
 		strcat(extra_format, " -F +metric");
 	if (attr->sample_type & PERF_SAMPLE_BRANCH_STACK)
-		strcat(extra_format, " -F +brstackinsn --xed");
+		strcat(extra_format, " -F +brstackinsn");
 	if (attr->sample_type & PERF_SAMPLE_REGS_INTR)
 		strcat(extra_format, " -F +iregs");
 	if (attr->sample_type & PERF_SAMPLE_REGS_USER)
@@ -107,7 +107,7 @@ static int list_scripts(char *script_name, bool *custom,
 	if (evsel)
 		attr_to_script(scriptc.extra_format, &evsel->core.attr);
 	add_script_option("Show individual samples", "", &scriptc);
-	add_script_option("Show individual samples with assembler", "-F +insn --xed",
+	add_script_option("Show individual samples with assembler", "-F +insn",
 			  &scriptc);
 	add_script_option("Show individual samples with source", "-F +srcline,+srccode",
 			  &scriptc);
-- 
2.17.1

