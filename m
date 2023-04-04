Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDBD6D69F2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbjDDRMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235324AbjDDRMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:12:20 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEA71BC9
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:12:17 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-544781e30easo325922647b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680628337;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TZONwuqfItcGVp6ITohrbP5GvIwso+WspPhpgQVUWFg=;
        b=hGnBviT8jNwzZr4NfOBj7PHa0sn0XO2aFf67JWoM2f9iSELdLDd1a9Qi412uoao3+v
         pkOkH6UvJb4sHHLvTpRzA565deyReJJPC/Na746oGChl0dT2NuqJd85y48gIxmZSb7Im
         VBKDRY5qN1yxI5mpj7qr4u+NLKSzoYZ8EvkQu40biR4y0cRTWx6w+vNZ44gqyx60HFwq
         VKlJ66H0ObODoU+MAMSq7zEsm+ETaXenG/CIfu3eormgIJrNjz6jo5/LfE5lUNCxxo1t
         8txSv+D8KxtV2v/WY2S223b2TtRNvEoJZvimEDGFC2DhzqDA8kYbWqNgbmu9yUVK/Csn
         sysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628337;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TZONwuqfItcGVp6ITohrbP5GvIwso+WspPhpgQVUWFg=;
        b=ynt2UTJNpayu9UsCPEHCJbzd9aHY5jxqyW7hfZxI70vikqOLcXgMWEm9LgO5ZujxiE
         L1APmtVSgQv21UgcwWH80Mnnj/xanXz753HjgISom/VrfBLX0hmU4ZPhDVNezbGYKuXL
         df+3HAVgX11HvNL5rHlxH45JzN4FhQhQHfVQE5L6Gl6ihr/svGYtxPZBzJWfvVTU+O6k
         zRXBODVIU4OjBVJyD7IZJ1Bt/MA5fZ63x1NbzHAH8AMYsgHxLcLiNRL9iZ5L3L8jIYk4
         Rl7DLP84MK6nWe1GRIt7U+7oQqIfmO2y/P0xK+RMTuHdC8+M5rRD3JM3tpdaQ204opra
         SHGA==
X-Gm-Message-State: AAQBX9dPiJsMkSvljOqGixCEaykHngfbNlPqBFHunx3iNmAkc5loshgy
        DyWXAFU6xK9jJjIFhzcfFk4C57fFZ+j6
X-Google-Smtp-Source: AKy350YR13RjzF9oXsel9DCut3UHkS8UYtfrSXqifFrFSAqyeKLVe6/4DMQ/XFVHaOJxItrFv8Jjw26rR7V/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a051:e074:d6f:dc29])
 (user=irogers job=sendgmr) by 2002:a25:d8d1:0:b0:b82:410e:daab with SMTP id
 p200-20020a25d8d1000000b00b82410edaabmr2357660ybg.8.1680628336683; Tue, 04
 Apr 2023 10:12:16 -0700 (PDT)
Date:   Tue,  4 Apr 2023 10:11:46 -0700
In-Reply-To: <20230404171146.2018616-1-irogers@google.com>
Message-Id: <20230404171146.2018616-3-irogers@google.com>
Mime-Version: 1.0
References: <20230404171146.2018616-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v1 3/3] perf test: Write Json output to a file
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
        Claire Jensen <cjense@google.com>,
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
index 2c4212c641ed..ecb015ac7c85 100755
--- a/tools/perf/tests/shell/stat+json_output.sh
+++ b/tools/perf/tests/shell/stat+json_output.sh
@@ -23,6 +23,20 @@ then
 	fi
 fi
 
+stat_output=$(mktemp /tmp/__perf_test.stat_output.XXXXX.json)
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
2.40.0.348.gf938b09366-goog

