Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3FB6DB917
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 07:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjDHFpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 01:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjDHFpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 01:45:41 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03030E04A
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 22:45:37 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54c01480e3cso84721497b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 22:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680932736;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GDcV3jJAEkDWKL53VhxAD/1zHUw0qGpFJOT1XTjqbho=;
        b=TuxH/c6dK3cKaVf4R/DMtEzVdMjdMc+MHphlLwfoa/h6eeyccMX7DPnW8PO5Ydu2r+
         VPjqhVqdPFSre1ZjYor/uEOpPZUvnOdqeUNl9vtMFUa72OrJ8/pegm3z9v1a8jWiKCqj
         PnuBxFek1q27W9ofEIHTknHe83Nv9u8nREejjrVU1/USIQGajVQlhw4YIYC/hW3JIfhs
         1f8GHYbk3N8N0W2InEK4tACxgMTHCFRJZ8nEQbF99ytWPyzdFizwcVQw0BpTlUKc8+/R
         YNtBmCgfkpHiYmR+IKfgYW+O8aSqv6lbABR2/j1gqbVwcx9C9kd09qr4URaucYeSse9V
         /5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680932736;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GDcV3jJAEkDWKL53VhxAD/1zHUw0qGpFJOT1XTjqbho=;
        b=I6C8CVbRJTA73q+xzbMFEuHdEWsseE0YrJy82f9zlwlGTq84tzBgCo2dNtxjokUuC5
         7AnB+UO1DAxaRslNknnf+u9SX/8b3iT4A9MrxNinu9CwcnLtXZOqZh/fF1g4KxlW81+1
         4d5sLfjlfXPSVQlDNFROQ/vR4yLrLrEGeYv1G98jkPUJmGFptCh1JjbBWXr6eyRfTN9A
         JWYs9FYLT+Jae4fCPAbylMUjjG8VPv7mjaPoIRG5CNpB9std8j4yZZfwIw3loYj/tjJ5
         IhZc90pUzsHQUf7A4f/VKcWvXDBwR6/gcqJSx+3njkCpEv/s7b2c/SBuo/0d2gqDVNH0
         aGXw==
X-Gm-Message-State: AAQBX9fmenqs/TJykbS6OzQyNH+QJfESmY/Aj7lI6nog/TRC2WCdlZsB
        tF/H/t/ZTDYBj6IWZadG/v99Do/gRlsB
X-Google-Smtp-Source: AKy350bPlEzEvMR7Lx/aXHf6yrIoEnl/tBSl7gD7KG9Cf8E9zTU0p33sq0AtgXsTzxqSU+xfMborpStdqQMV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b240:9cdf:7861:b23e])
 (user=irogers job=sendgmr) by 2002:a81:ae51:0:b0:54c:1ab:6aaf with SMTP id
 g17-20020a81ae51000000b0054c01ab6aafmr2188740ywk.5.1680932736234; Fri, 07 Apr
 2023 22:45:36 -0700 (PDT)
Date:   Fri,  7 Apr 2023 22:44:56 -0700
In-Reply-To: <20230408054456.3001367-1-irogers@google.com>
Message-Id: <20230408054456.3001367-4-irogers@google.com>
Mime-Version: 1.0
References: <20230408054456.3001367-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v2 3/3] perf test: Write Json output to a file
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Write the Json output to a file, then sanity check this output. This
avoids problems with debug/warning/error output corrupting the file
format.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../tests/shell/lib/perf_json_output_lint.py  |  3 +-
 tools/perf/tests/shell/stat+json_output.sh    | 48 ++++++++++++++-----
 2 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/perf/tests/shell/lib/perf_json_output_lint.py
index 97598d14e532..61f3059ca54b 100644
--- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
+++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
@@ -17,9 +17,10 @@ ap.add_argument('--per-thread', action='store_true')
 ap.add_argument('--per-die', action='store_true')
 ap.add_argument('--per-node', action='store_true')
 ap.add_argument('--per-socket', action='store_true')
+ap.add_argument('--file', type=argparse.FileType('r'), default=sys.stdin)
 args = ap.parse_args()
 
-Lines = sys.stdin.readlines()
+Lines = args.file.readlines()
 
 def isfloat(num):
   try:
diff --git a/tools/perf/tests/shell/stat+json_output.sh b/tools/perf/tests/shell/stat+json_output.sh
index 2c4212c641ed..f3e4967cc72e 100755
--- a/tools/perf/tests/shell/stat+json_output.sh
+++ b/tools/perf/tests/shell/stat+json_output.sh
@@ -23,6 +23,20 @@ then
 	fi
 fi
 
+stat_output=$(mktemp /tmp/__perf_test.stat_output.json.XXXXX)
+
+cleanup() {
+  rm -f "${stat_output}"
+
+  trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+  cleanup
+  exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
 # Return true if perf_event_paranoid is > $1 and not running as root.
 function ParanoidAndNotRoot()
 {
@@ -32,7 +46,8 @@ function ParanoidAndNotRoot()
 check_no_args()
 {
 	echo -n "Checking json output: no args "
-	perf stat -j true 2>&1 | $PYTHON $pythonchecker --no-args
+	perf stat -j -o "${stat_output}" true
+	$PYTHON $pythonchecker --no-args --file "${stat_output}"
 	echo "[Success]"
 }
 
@@ -44,27 +59,29 @@ check_system_wide()
 		echo "[Skip] paranoia and not root"
 		return
 	fi
-	perf stat -j -a true 2>&1 | $PYTHON $pythonchecker --system-wide
+	perf stat -j -a -o "${stat_output}" true
+	$PYTHON $pythonchecker --system-wide --file "${stat_output}"
 	echo "[Success]"
 }
 
 check_system_wide_no_aggr()
 {
-	echo -n "Checking json output: system wide "
+	echo -n "Checking json output: system wide no aggregation "
 	if ParanoidAndNotRoot 0
 	then
 		echo "[Skip] paranoia and not root"
 		return
 	fi
-	echo -n "Checking json output: system wide no aggregation "
-	perf stat -j -A -a --no-merge true 2>&1 | $PYTHON $pythonchecker --system-wide-no-aggr
+	perf stat -j -A -a --no-merge -o "${stat_output}" true
+	$PYTHON $pythonchecker --system-wide-no-aggr --file "${stat_output}"
 	echo "[Success]"
 }
 
 check_interval()
 {
 	echo -n "Checking json output: interval "
-	perf stat -j -I 1000 true 2>&1 | $PYTHON $pythonchecker --interval
+	perf stat -j -I 1000 -o "${stat_output}" true
+	$PYTHON $pythonchecker --interval --file "${stat_output}"
 	echo "[Success]"
 }
 
@@ -72,7 +89,8 @@ check_interval()
 check_event()
 {
 	echo -n "Checking json output: event "
-	perf stat -j -e cpu-clock true 2>&1 | $PYTHON $pythonchecker --event
+	perf stat -j -e cpu-clock -o "${stat_output}" true
+	$PYTHON $pythonchecker --event --file "${stat_output}"
 	echo "[Success]"
 }
 
@@ -84,7 +102,8 @@ check_per_core()
 		echo "[Skip] paranoia and not root"
 		return
 	fi
-	perf stat -j --per-core -a true 2>&1 | $PYTHON $pythonchecker --per-core
+	perf stat -j --per-core -a -o "${stat_output}" true
+	$PYTHON $pythonchecker --per-core --file "${stat_output}"
 	echo "[Success]"
 }
 
@@ -96,7 +115,8 @@ check_per_thread()
 		echo "[Skip] paranoia and not root"
 		return
 	fi
-	perf stat -j --per-thread -a true 2>&1 | $PYTHON $pythonchecker --per-thread
+	perf stat -j --per-thread -a -o "${stat_output}" true
+	$PYTHON $pythonchecker --per-thread --file "${stat_output}"
 	echo "[Success]"
 }
 
@@ -108,7 +128,8 @@ check_per_die()
 		echo "[Skip] paranoia and not root"
 		return
 	fi
-	perf stat -j --per-die -a true 2>&1 | $PYTHON $pythonchecker --per-die
+	perf stat -j --per-die -a -o "${stat_output}" true
+	$PYTHON $pythonchecker --per-die --file "${stat_output}"
 	echo "[Success]"
 }
 
@@ -120,7 +141,8 @@ check_per_node()
 		echo "[Skip] paranoia and not root"
 		return
 	fi
-	perf stat -j --per-node -a true 2>&1 | $PYTHON $pythonchecker --per-node
+	perf stat -j --per-node -a -o "${stat_output}" true
+	$PYTHON $pythonchecker --per-node --file "${stat_output}"
 	echo "[Success]"
 }
 
@@ -132,7 +154,8 @@ check_per_socket()
 		echo "[Skip] paranoia and not root"
 		return
 	fi
-	perf stat -j --per-socket -a true 2>&1 | $PYTHON $pythonchecker --per-socket
+	perf stat -j --per-socket -a -o "${stat_output}" true
+	$PYTHON $pythonchecker --per-socket --file "${stat_output}"
 	echo "[Success]"
 }
 
@@ -179,4 +202,5 @@ then
 else
 	echo "[Skip] Skipping tests for system_wide_no_aggr, per_core, per_die and per_socket since socket id exposed via topology is invalid"
 fi
+cleanup
 exit 0
-- 
2.40.0.577.gac1e443424-goog

