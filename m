Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63C46D0658
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjC3NSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbjC3NSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:18:53 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8052185;
        Thu, 30 Mar 2023 06:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680182332; x=1711718332;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3EksB4AadDf7H69GDgoB9EW6O1V5EwTQwlm8Fpj1ozk=;
  b=hGaCkWXJrdqreGDknqnlomTXGPpH+3+Gli6JH8xm1aSa9o5Ttt/5+wbv
   xkgCZZg6S5hvtTmhAViBB9DyUKmR9ojASIgiElB/pzXPuyjOfgREwCxEH
   cqgo4ffaDyIJcR7D+MmbClNJAdWVyvwvbFvIQRKFFnBYa4JrC5Kep98Mc
   2zf0xaPNZmAi4HwMQHDXJRxM280dpdAxtIRv1KCrm3BS0v8XkKNAFbpxo
   wcYoUsNCOjGr8XOgn2n1gm+jwe/m0bD6r7SuN8RwsJIsl0o3z3Kv6L6EB
   EpLEJwU4mfWzDtLtU/4pz+vcWR7NWwkVGxcEk7truk3ia7qu6HiTQoEp4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="427440763"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="427440763"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 06:18:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="678185543"
X-IronPort-AV: E=Sophos;i="5.98,303,1673942400"; 
   d="scan'208";a="678185543"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.249.32.122])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 06:18:48 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 1/2] perf top: Add --branch-history option
Date:   Thu, 30 Mar 2023 16:18:32 +0300
Message-Id: <20230330131833.12864-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330131833.12864-1-adrian.hunter@intel.com>
References: <20230330131833.12864-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add --branch-history option, to act the same as that option does for
perf report.

Example:

  $ cat tcallf.c
  volatile a = 10000, b = 100000, c;

  __attribute__((noinline)) f2()
  {
          c = a / b;
  }

  __attribute__((noinline)) f1()
  {
          f2();
          f2();
  }
  main()
  {
          while (1)
                  f1();
  }
  $ gcc -w -g -o tcallf tcallf.c
  $ ./tcallf &
  [1] 29409
  $ perf top -e cycles:u  -t $(pidof tcallf) --stdio --no-children --branch-history
     PerfTop:    3819 irqs/sec  kernel: 0.0%  exact:  0.0% lost: 0/0 drop: 0/0 [4000Hz cycles:u],  (target_tid: 29409)
  --------------------------------------------------------------------------------------------------------------------

      49.01%  tcallf.c:5   [.] f2    tcallf
              |
              |--24.91%--f2 tcallf.c:4
              |          |
              |          |--17.14%--f1 tcallf.c:11 (cycles:1)
              |          |          f1 tcallf.c:11
              |          |          f2 tcallf.c:6 (cycles:3)
              |          |          f2 tcallf.c:4
              |          |          f1 tcallf.c:10 (cycles:2)
              |          |          f1 tcallf.c:9
              |          |          main tcallf.c:16 (cycles:1)
              |          |          main tcallf.c:16
              |          |          main tcallf.c:16 (cycles:1)
              |          |          main tcallf.c:16
              |          |          f1 tcallf.c:12 (cycles:1)
              |          |          f1 tcallf.c:12
              |          |          f2 tcallf.c:6 (cycles:3)
              |          |          f2 tcallf.c:4
              |          |          f1 tcallf.c:11 (cycles:1 iter:1 avg_cycles:12)
              |          |          f1 tcallf.c:11
              |          |          f2 tcallf.c:6 (cycles:3 iter:1 avg_cycles:12)
              |          |          f2 tcallf.c:4
              |          |          f1 tcallf.c:10 (cycles:2 iter:1 avg_cycles:12)
              |          |
              |           --7.78%--f1 tcallf.c:10 (cycles:2)
              |                     f1 tcallf.c:9
              |                     main tcallf.c:16 (cycles:1)
              |                     main tcallf.c:16
              |                     main tcallf.c:16 (cycles:1)
              |                     main tcallf.c:16
              |                     f1 tcallf.c:12 (cycles:1)
              |                     f1 tcallf.c:12
              |                     f2 tcallf.c:6 (cycles:3)
              |                     f2 tcallf.c:4
              |                     f1 tcallf.c:11 (cycles:1)
              |                     f1 tcallf.c:11
              |                     f2 tcallf.c:6 (cycles:3)
              |                     f2 tcallf.c:4
              |                     f1 tcallf.c:10 (cycles:2 iter:1 avg_cycles:12)
              |                     f1 tcallf.c:9
              |                     main tcallf.c:16 (cycles:1 iter:1 avg_cycles:12)
              |                     main tcallf.c:16
              |                     main tcallf.c:16 (cycles:1 iter:1 avg_cycles:12)
  ...

  $ pkill tcallf
  [1]+  Terminated              ./tcallf

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-top.txt |  4 ++++
 tools/perf/builtin-top.c              | 17 +++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index 619cc8143ad5..3c202ec080ba 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -254,6 +254,10 @@ Default is to monitor all CPUS.
 	The various filters must be specified as a comma separated list: --branch-filter any_ret,u,k
 	Note that this feature may not be available on all processors.
 
+--branch-history::
+	Add the addresses of sampled taken branches to the callstack.
+	This allows to examine the path the program took to each sample.
+
 --raw-trace::
 	When displaying traceevent output, do not use print fmt or plugins.
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 82c6c065830d..2c985cfea517 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1437,6 +1437,7 @@ int cmd_top(int argc, const char **argv)
 		.max_stack	     = sysctl__max_stack(),
 		.nr_threads_synthesize = UINT_MAX,
 	};
+	bool branch_call_mode = false;
 	struct record_opts *opts = &top.record_opts;
 	struct target *target = &opts->target;
 	const char *disassembler_style = NULL, *objdump_path = NULL, *addr2line_path = NULL;
@@ -1551,6 +1552,8 @@ int cmd_top(int argc, const char **argv)
 	OPT_CALLBACK('j', "branch-filter", &opts->branch_stack,
 		     "branch filter mask", "branch stack filter modes",
 		     parse_branch_stack),
+	OPT_BOOLEAN(0, "branch-history", &branch_call_mode,
+		    "add last branch records to call history"),
 	OPT_BOOLEAN(0, "raw-trace", &symbol_conf.raw_trace,
 		    "Show raw trace event output (do not use print fmt or plugins)"),
 	OPT_BOOLEAN(0, "hierarchy", &symbol_conf.report_hierarchy,
@@ -1677,6 +1680,20 @@ int cmd_top(int argc, const char **argv)
 		goto out_delete_evlist;
 	}
 
+	if (branch_call_mode) {
+		if (!opts->branch_stack)
+			opts->branch_stack = PERF_SAMPLE_BRANCH_ANY;
+		symbol_conf.use_callchain = true;
+		callchain_param.key = CCKEY_ADDRESS;
+		callchain_param.branch_callstack = true;
+		callchain_param.enabled = true;
+		if (callchain_param.record_mode == CALLCHAIN_NONE)
+			callchain_param.record_mode = CALLCHAIN_FP;
+		callchain_register_param(&callchain_param);
+		if (!sort_order)
+			sort_order = "srcline,symbol,dso";
+	}
+
 	if (opts->branch_stack && callchain_param.enabled)
 		symbol_conf.show_branchflag_count = true;
 
-- 
2.34.1

