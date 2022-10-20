Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E665C606463
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiJTP0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiJTP0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:26:14 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662992A718;
        Thu, 20 Oct 2022 08:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666279552; x=1697815552;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Qn3KLBoa61sLxw61wNYSQCyv7NmnxrLWiipgBVrLdqY=;
  b=PZDB37BbyOch3eWvPUbEmZWVLSDwi75mxbu6IUcukGXEKnUn8k6Ue4dJ
   ZDeI8ScJIj8kvXiORqylwqX7yh6oSUWJC+6oymblDO4RVsFI1hMmeE7lE
   fEIzyhCVig1B5z+Bz3OVP2LU04VKatKK5geo6Ear35Lj93O1oYm8PVeGC
   /vtJFAtwhTrxwD5LQgQHri7neoIAPsYrLnj1RUGYu7phjxUWewiBmo27I
   nvb0oSNMhQGG/1qCosQA+u1IHgjBN4/fS07vqj7+MzEu4JRv2GXZbVyom
   7V33HRqWISy68+K4UDEQd+aijoHxKwnbG63KHp3LWWn8eVPfar047NK0X
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="305479684"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="305479684"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 08:25:25 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="734908509"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="734908509"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.53.25])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 08:25:23 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] perf scripts python: intel-pt-events.py: Add ability interleave output
Date:   Thu, 20 Oct 2022 18:25:09 +0300
Message-Id: <20221020152509.5298-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel PT timestamps are not provided for every branch, let alone every
instruction, so there can be many samples with the same timestamp. With
per-cpu contexts, decoding is done for each CPU in turn, which can make it
difficult to see what is happening on different CPUs at the same time.
Currently the interleaving from perf script --itrace=i0ns is quite coarse
grained. There are often long stretches executing on one CPU and nothing on
another.

Some people are interested in seeing what happened on multiple CPUs before
a crash to debug races etc.

To improve perf script interleaving for parallel execution, the
intel-pt-events.py script has been enhanced to enable interleaving the
output with the same timestamp from different CPUs. It is understood that
interleaving is not perfect or causal.

Add parameter --interleave [<n>] to interleave sample output for the same
timestamp so that no more than n samples for a CPU are displayed in a row.
'n' defaults to 4. Note this only affects the order of output, and only
when the timestamp is the same.

Example:

  $ perf script intel-pt-events.py --insn-trace --interleave 3
  ...
  bash  2267/2267  [004]  9323.692625625  563caa3c86f0  jz 0x563caa3c89c7        run_pending_traps+0x30 (/usr/bin/bash)   IPC: 1.52 (38/25)
  bash  2267/2267  [004]  9323.692625625  563caa3c89c7  movq  0x118(%rsp), %rax  run_pending_traps+0x307 (/usr/bin/bash)
  bash  2267/2267  [004]  9323.692625625  563caa3c89cf  subq  %fs:0x28, %rax     run_pending_traps+0x30f (/usr/bin/bash)
  bash  2270/2270  [007]  9323.692625625  55dc58cabf02  jz 0x55dc58cabf48        unquoted_glob_pattern_p+0x102 (/usr/bin/bash)   IPC: 1.56 (25/16)
  bash  2270/2270  [007]  9323.692625625  55dc58cabf04  cmp $0x5d, %al           unquoted_glob_pattern_p+0x104 (/usr/bin/bash)
  bash  2270/2270  [007]  9323.692625625  55dc58cabf06  jnz 0x55dc58cabf10       unquoted_glob_pattern_p+0x106 (/usr/bin/bash)
  bash  2264/2264  [001]  9323.692625625  7fd556a4376c  jbe 0x7fd556a43ac8       round_and_return+0x3fc (/usr/lib/x86_64-linux-gnu/libc.so.6)   IPC: 4.30 (43/10)
  bash  2264/2264  [001]  9323.692625625  7fd556a43772  and $0x8, %edx           round_and_return+0x402 (/usr/lib/x86_64-linux-gnu/libc.so.6)
  bash  2264/2264  [001]  9323.692625625  7fd556a43775  jnz 0x7fd556a43ac8       round_and_return+0x405 (/usr/lib/x86_64-linux-gnu/libc.so.6)
  bash  2267/2267  [004]  9323.692625625  563caa3c89d8  jnz 0x563caa3c8b11       run_pending_traps+0x318 (/usr/bin/bash)
  bash  2267/2267  [004]  9323.692625625  563caa3c89de  add $0x128, %rsp         run_pending_traps+0x31e (/usr/bin/bash)
  bash  2267/2267  [004]  9323.692625625  563caa3c89e5  popq  %rbx               run_pending_traps+0x325 (/usr/bin/bash)
  ...

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-intel-pt.txt   | 12 +++-
 tools/perf/scripts/python/intel-pt-events.py | 65 +++++++++++++++++++-
 2 files changed, 74 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index 92464a5d7eaf..7b6ccd2fa3bf 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -189,8 +189,16 @@ There is also script intel-pt-events.py which provides an example of how to
 unpack the raw data for power events and PTWRITE. The script also displays
 branches, and supports 2 additional modes selected by option:
 
- --insn-trace - instruction trace
- --src-trace - source trace
+ - --insn-trace - instruction trace
+ - --src-trace - source trace
+
+The intel-pt-events.py script also has options:
+
+ - --all-switch-events - display all switch events, not only the last consecutive.
+ - --interleave [<n>] - interleave sample output for the same timestamp so that
+ no more than n samples for a CPU are displayed in a row. 'n' defaults to 4.
+ Note this only affects the order of output, and only when the timestamp is the
+ same.
 
 As mentioned above, it is easy to capture too much data.  One way to limit the
 data captured is to use 'snapshot' mode which is explained further below.
diff --git a/tools/perf/scripts/python/intel-pt-events.py b/tools/perf/scripts/python/intel-pt-events.py
index 6be7fd8fd615..08862a2582f4 100644
--- a/tools/perf/scripts/python/intel-pt-events.py
+++ b/tools/perf/scripts/python/intel-pt-events.py
@@ -13,10 +13,12 @@
 
 from __future__ import print_function
 
+import io
 import os
 import sys
 import struct
 import argparse
+import contextlib
 
 from libxed import LibXED
 from ctypes import create_string_buffer, addressof
@@ -39,6 +41,11 @@ glb_src			= False
 glb_source_file_name	= None
 glb_line_number		= None
 glb_dso			= None
+glb_stash_dict		= {}
+glb_output		= None
+glb_output_pos		= 0
+glb_cpu			= -1
+glb_time		= 0
 
 def get_optional_null(perf_dict, field):
 	if field in perf_dict:
@@ -70,6 +77,7 @@ def trace_begin():
 	ap.add_argument("--insn-trace", action='store_true')
 	ap.add_argument("--src-trace", action='store_true')
 	ap.add_argument("--all-switch-events", action='store_true')
+	ap.add_argument("--interleave", type=int, nargs='?', const=4, default=0)
 	global glb_args
 	global glb_insn
 	global glb_src
@@ -94,11 +102,39 @@ def trace_begin():
 	perf_set_itrace_options(perf_script_context, itrace)
 
 def trace_end():
+	if glb_args.interleave:
+		flush_stashed_output()
 	print("End")
 
 def trace_unhandled(event_name, context, event_fields_dict):
 		print(' '.join(['%s=%s'%(k,str(v))for k,v in sorted(event_fields_dict.items())]))
 
+def stash_output():
+	global glb_stash_dict
+	global glb_output_pos
+	output_str = glb_output.getvalue()[glb_output_pos:]
+	n = len(output_str)
+	if n:
+		glb_output_pos += n
+		if glb_cpu not in glb_stash_dict:
+			glb_stash_dict[glb_cpu] = []
+		glb_stash_dict[glb_cpu].append(output_str)
+
+def flush_stashed_output():
+	global glb_stash_dict
+	while glb_stash_dict:
+		cpus = list(glb_stash_dict.keys())
+		# Output at most glb_args.interleave output strings per cpu
+		for cpu in cpus:
+			items = glb_stash_dict[cpu]
+			countdown = glb_args.interleave
+			while len(items) and countdown:
+				sys.stdout.write(items[0])
+				del items[0]
+				countdown -= 1
+			if not items:
+				del glb_stash_dict[cpu]
+
 def print_ptwrite(raw_buf):
 	data = struct.unpack_from("<IQ", raw_buf)
 	flags = data[0]
@@ -375,15 +411,40 @@ def do_process_event(param_dict):
 		print_common_start(comm, sample, name)
 		print_common_ip(param_dict, sample, symbol, dso)
 
+def interleave_events(param_dict):
+	global glb_cpu
+	global glb_time
+	global glb_output
+	global glb_output_pos
+
+	sample  = param_dict["sample"]
+	glb_cpu = sample["cpu"]
+	ts      = sample["time"]
+
+	if glb_time != ts:
+		glb_time = ts
+		flush_stashed_output()
+
+	glb_output_pos = 0
+	with contextlib.redirect_stdout(io.StringIO()) as glb_output:
+		do_process_event(param_dict)
+
+	stash_output()
+
 def process_event(param_dict):
 	try:
-		do_process_event(param_dict)
+		if glb_args.interleave:
+			interleave_events(param_dict)
+		else:
+			do_process_event(param_dict)
 	except broken_pipe_exception:
 		# Stop python printing broken pipe errors and traceback
 		sys.stdout = open(os.devnull, 'w')
 		sys.exit(1)
 
 def auxtrace_error(typ, code, cpu, pid, tid, ip, ts, msg, cpumode, *x):
+	if glb_args.interleave:
+		flush_stashed_output()
 	if len(x) >= 2 and x[0]:
 		machine_pid = x[0]
 		vcpu = x[1]
@@ -403,6 +464,8 @@ def auxtrace_error(typ, code, cpu, pid, tid, ip, ts, msg, cpumode, *x):
 		sys.exit(1)
 
 def context_switch(ts, cpu, pid, tid, np_pid, np_tid, machine_pid, out, out_preempt, *x):
+	if glb_args.interleave:
+		flush_stashed_output()
 	if out:
 		out_str = "Switch out "
 	else:
-- 
2.34.1

