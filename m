Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4954A6D69F0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjDDRME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjDDRMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:12:02 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E3794
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:12:01 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-544781e30easo325914377b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680628320;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GOgT1sPETj0q8HMl3FDDjzVshKnjlllm3myIaWYsAM8=;
        b=BYBxqbK2pUllPRrLNmM5XjfLeYeLPgW9BpbWzuu/eplCiVAJTvhoifRPPnINbdOBXM
         Bv0dQ0LKJep9TBIEjwA+CRf2ut3voBdXAsH4shFzn/MzH3yYH9e7/dAPIT/N97sAdwLM
         3Hp4ln4eViOtBxKwuKRME+2OS2auQy1vlG9Im6bBgrCv12DwEUW+hzYuMZySqf3Vg2vG
         BQy35vV0su10XaBfNSVWyqaRLEFXujrxqcSdBls47E7shPzwX0T+VwRL41+Y49EcOre6
         dtYd4WiFMxTyPmmw9PupmLtJqcRQXpS+7kxgvFhiMVDUndVsn7Psmute16dqIbenB1lP
         zBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628320;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GOgT1sPETj0q8HMl3FDDjzVshKnjlllm3myIaWYsAM8=;
        b=pDmaEQtAD6n7ndjSLlDcwwMSyLkD2RJ0RWOnNUFInjgD6/U9E3ZsTIwqBeq/uQhZxJ
         ExptX9Bxi1DjKgsfUZjwIxuBQUU9SD+xWbD2d8+LXJsktn5UtZzErTjn95D0kwYnAAVP
         j0XVEEriwtuSJNfgWykBgmRn/+SbGJiTLIsYncF7CwdTz7bpyQHch/qJwm9rr3aV+9og
         rg3TwgZkamm0mmGg+5xlGOoo11kyBIuR8lrL4bPtzecWlnvSjgrrlI0oAVvRiD+lLqZx
         iGbQUQjSaCTzPcDUKJks4u13pwuGmWcCM7yUlBVAMNrd6nMKM+/pM2DwgjGLlIVJQ3xf
         GHpw==
X-Gm-Message-State: AAQBX9eBPqJE9nEUYF60bzt+Sb1GBLLhH3/xHKwhw0BsN7dfzo0/1EYy
        1u11PgR1/nAcHnrPK3NAwxQCIsBBriWE
X-Google-Smtp-Source: AKy350aHB55zg30TbIzYb6EGEfJlq5BclAuDczTKHnBOT8GBOsqGlnfxujWMcePnaQu6BAgTrHIPniAeG1fp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a051:e074:d6f:dc29])
 (user=irogers job=sendgmr) by 2002:a25:d406:0:b0:b7d:4c96:de0 with SMTP id
 m6-20020a25d406000000b00b7d4c960de0mr2002396ybf.5.1680628320495; Tue, 04 Apr
 2023 10:12:00 -0700 (PDT)
Date:   Tue,  4 Apr 2023 10:11:44 -0700
Message-Id: <20230404171146.2018616-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v1 1/3] perf test: Write CSV output to a file
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

Write the CSV output to a file, then sanity check this output. This
avoids problems with debug/warning/error output corrupting the file
format.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat+csv_output.sh | 58 ++++++++++++++++-------
 1 file changed, 42 insertions(+), 16 deletions(-)

diff --git a/tools/perf/tests/shell/stat+csv_output.sh b/tools/perf/tests/shell/stat+csv_output.sh
index 324fc9e6edd7..929c83977fa9 100755
--- a/tools/perf/tests/shell/stat+csv_output.sh
+++ b/tools/perf/tests/shell/stat+csv_output.sh
@@ -9,6 +9,20 @@ set -e
 skip_test=0
 csv_sep=@
 
+stat_output=$(mktemp /tmp/__perf_test.stat_output.XXXXX.csv)
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
 function commachecker()
 {
 	local -i cnt=0
@@ -30,9 +44,11 @@ function commachecker()
 
 	while read line
 	do
-		# Check for lines beginning with Failed
-		x=${line:0:6}
-		[ "$x" = "Failed" ] && continue
+		# Ignore initial "started on" comment.
+		x=${line:0:1}
+		[ "$x" = "#" ] && continue
+		# Ignore initial blank line.
+		[ "$line" = "" ] && continue
 
 		# Count the number of commas
 		x=$(echo $line | tr -d -c $csv_sep)
@@ -42,7 +58,7 @@ function commachecker()
 			echo "wrong number of fields. expected $exp in $line" 1>&2
 			exit 1;
 		}
-	done
+	done < "${stat_output}"
 	return 0
 }
 
@@ -55,7 +71,8 @@ function ParanoidAndNotRoot()
 check_no_args()
 {
 	echo -n "Checking CSV output: no args "
-	perf stat -x$csv_sep true 2>&1 | commachecker --no-args
+	perf stat -x$csv_sep -o "${stat_output}" true
+        commachecker --no-args
 	echo "[Success]"
 }
 
@@ -67,27 +84,29 @@ check_system_wide()
 		echo "[Skip] paranoid and not root"
 		return
 	fi
-	perf stat -x$csv_sep -a true 2>&1 | commachecker --system-wide
+	perf stat -x$csv_sep -a -o "${stat_output}" true
+        commachecker --system-wide
 	echo "[Success]"
 }
 
 check_system_wide_no_aggr()
 {
-	echo -n "Checking CSV output: system wide "
+	echo -n "Checking CSV output: system wide no aggregation "
 	if ParanoidAndNotRoot 0
 	then
 		echo "[Skip] paranoid and not root"
 		return
 	fi
-	echo -n "Checking CSV output: system wide no aggregation "
-	perf stat -x$csv_sep -A -a --no-merge true 2>&1 | commachecker --system-wide-no-aggr
+	perf stat -x$csv_sep -A -a --no-merge -o "${stat_output}" true
+        commachecker --system-wide-no-aggr
 	echo "[Success]"
 }
 
 check_interval()
 {
 	echo -n "Checking CSV output: interval "
-	perf stat -x$csv_sep -I 1000 true 2>&1 | commachecker --interval
+	perf stat -x$csv_sep -I 1000 -o "${stat_output}" true
+        commachecker --interval
 	echo "[Success]"
 }
 
@@ -95,7 +114,8 @@ check_interval()
 check_event()
 {
 	echo -n "Checking CSV output: event "
-	perf stat -x$csv_sep -e cpu-clock true 2>&1 | commachecker --event
+	perf stat -x$csv_sep -e cpu-clock -o "${stat_output}" true
+        commachecker --event
 	echo "[Success]"
 }
 
@@ -107,7 +127,8 @@ check_per_core()
 		echo "[Skip] paranoid and not root"
 		return
 	fi
-	perf stat -x$csv_sep --per-core -a true 2>&1 | commachecker --per-core
+	perf stat -x$csv_sep --per-core -a -o "${stat_output}" true
+        commachecker --per-core
 	echo "[Success]"
 }
 
@@ -119,7 +140,8 @@ check_per_thread()
 		echo "[Skip] paranoid and not root"
 		return
 	fi
-	perf stat -x$csv_sep --per-thread -a true 2>&1 | commachecker --per-thread
+	perf stat -x$csv_sep --per-thread -a -o "${stat_output}" true
+        commachecker --per-thread
 	echo "[Success]"
 }
 
@@ -131,7 +153,8 @@ check_per_die()
 		echo "[Skip] paranoid and not root"
 		return
 	fi
-	perf stat -x$csv_sep --per-die -a true 2>&1 | commachecker --per-die
+	perf stat -x$csv_sep --per-die -a -o "${stat_output}" true
+        commachecker --per-die
 	echo "[Success]"
 }
 
@@ -143,7 +166,8 @@ check_per_node()
 		echo "[Skip] paranoid and not root"
 		return
 	fi
-	perf stat -x$csv_sep --per-node -a true 2>&1 | commachecker --per-node
+	perf stat -x$csv_sep --per-node -a -o "${stat_output}" true
+        commachecker --per-node
 	echo "[Success]"
 }
 
@@ -155,7 +179,8 @@ check_per_socket()
 		echo "[Skip] paranoid and not root"
 		return
 	fi
-	perf stat -x$csv_sep --per-socket -a true 2>&1 | commachecker --per-socket
+	perf stat -x$csv_sep --per-socket -a -o "${stat_output}" true
+        commachecker --per-socket
 	echo "[Success]"
 }
 
@@ -202,4 +227,5 @@ then
 else
 	echo "[Skip] Skipping tests for system_wide_no_aggr, per_core, per_die and per_socket since socket id exposed via topology is invalid"
 fi
+cleanup
 exit 0
-- 
2.40.0.348.gf938b09366-goog

