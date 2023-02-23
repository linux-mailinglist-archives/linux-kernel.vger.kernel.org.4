Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D2E6A0340
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 08:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjBWHSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 02:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbjBWHSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 02:18:37 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FE828209
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 23:18:32 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536bf649e70so109451257b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 23:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iXAeDlZXVCzOH1LqKDfRFH+Nnlw0nQyHAuUwu11nvRY=;
        b=gme+dLCjCjeQrS7dw8VS93maFpyrhu5Zmp25GduivSACrzqAvIAAq6r72zo6X3cbTH
         1SpV6w4bVEz+pKjwSz/1FHSFMvQUU/q8XDkvCk8R1r3iyMzs3FvmyA2pQtamrBcOi3HW
         UDx2iYfwq6sImcWTSGhYkFdceh1kVm2MuxgnEx9dbNmSP7+yeWuj3HbiL94DxnX5IleC
         6LgsVa6GxavccDMnVFb4WCs/hTml6Z1PeFyqNH3/C366KTqF3/+op7S+7AUyyB9nrmJU
         U6ZVH9dl05NJ5HhMBvEV7pwphPtakpca6vS8aF1iFlgwMZ5JSigJqSg0LO49MZ44DVhb
         Tt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iXAeDlZXVCzOH1LqKDfRFH+Nnlw0nQyHAuUwu11nvRY=;
        b=QD66xaCqIGTWH2kV1uNzWEDu8JkWSXreOt8fmnpnCGdT9mrITtfK8+jvV6x+8IBWdT
         sUKAdGPs8YWX13D2X7KvgywDodahI9iI/sdUKMLoQdWWACxSgEY/eicOEWmi/q1KzKRW
         TgW763LiqkLgva9DsruV9LVHbeX/CrjID1Gx9zMPOZxOuwO7F/L1XT5CHy6/F//2TJPQ
         q9P1gRofA3WPWxXZ23VVXea9thGDIX0gCGBQqXvDfWjx/LmtCejJLu6tnVSWXxtbD197
         grR4nzObPa7751d8XmkDsfinDRz9FP+ktEoY4qfMsWnb+XLr8OwO2PDM8QFeXGdb+s2B
         0M9g==
X-Gm-Message-State: AO0yUKUM/dVyuo+KuJ3zJahADFh3/hzNg1WtdlBMOOhxFatHJD807WgN
        hucLpQ0ektuf/hIuzJITsjgJS/1x8fDp
X-Google-Smtp-Source: AK7set/Wkw8fj89oBF//D3/fhbjw6lAN4fu5/NHTRzd5x1LMXBtFZ22kkHGRjzYle+Rqh3E7YUEzYF4jcKj0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:9002:67cd:9e6b:7083])
 (user=irogers job=sendgmr) by 2002:a81:4320:0:b0:52e:c77d:3739 with SMTP id
 q32-20020a814320000000b0052ec77d3739mr1651534ywa.9.1677136711579; Wed, 22 Feb
 2023 23:18:31 -0800 (PST)
Date:   Wed, 22 Feb 2023 23:18:17 -0800
Message-Id: <20230223071818.329671-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 1/2] perf tests stat+csv_output: Switch CSV separator to @
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Claire Jensen <cjense@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commas may appear in events like:
cpu/INT_MISC.RECOVERY_CYCLES,cmask=1,edge/
which causes the commachecker to see more fields than expected. Use @
as the CSV separator to avoid this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat+csv_output.sh | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/tools/perf/tests/shell/stat+csv_output.sh b/tools/perf/tests/shell/stat+csv_output.sh
index b7f050aa6210..324fc9e6edd7 100755
--- a/tools/perf/tests/shell/stat+csv_output.sh
+++ b/tools/perf/tests/shell/stat+csv_output.sh
@@ -7,6 +7,7 @@
 set -e
 
 skip_test=0
+csv_sep=@
 
 function commachecker()
 {
@@ -34,7 +35,7 @@ function commachecker()
 		[ "$x" = "Failed" ] && continue
 
 		# Count the number of commas
-		x=$(echo $line | tr -d -c ',')
+		x=$(echo $line | tr -d -c $csv_sep)
 		cnt="${#x}"
 		# echo $line $cnt
 		[[ ! "$cnt" =~ $exp ]] && {
@@ -54,7 +55,7 @@ function ParanoidAndNotRoot()
 check_no_args()
 {
 	echo -n "Checking CSV output: no args "
-	perf stat -x, true 2>&1 | commachecker --no-args
+	perf stat -x$csv_sep true 2>&1 | commachecker --no-args
 	echo "[Success]"
 }
 
@@ -66,7 +67,7 @@ check_system_wide()
 		echo "[Skip] paranoid and not root"
 		return
 	fi
-	perf stat -x, -a true 2>&1 | commachecker --system-wide
+	perf stat -x$csv_sep -a true 2>&1 | commachecker --system-wide
 	echo "[Success]"
 }
 
@@ -79,14 +80,14 @@ check_system_wide_no_aggr()
 		return
 	fi
 	echo -n "Checking CSV output: system wide no aggregation "
-	perf stat -x, -A -a --no-merge true 2>&1 | commachecker --system-wide-no-aggr
+	perf stat -x$csv_sep -A -a --no-merge true 2>&1 | commachecker --system-wide-no-aggr
 	echo "[Success]"
 }
 
 check_interval()
 {
 	echo -n "Checking CSV output: interval "
-	perf stat -x, -I 1000 true 2>&1 | commachecker --interval
+	perf stat -x$csv_sep -I 1000 true 2>&1 | commachecker --interval
 	echo "[Success]"
 }
 
@@ -94,7 +95,7 @@ check_interval()
 check_event()
 {
 	echo -n "Checking CSV output: event "
-	perf stat -x, -e cpu-clock true 2>&1 | commachecker --event
+	perf stat -x$csv_sep -e cpu-clock true 2>&1 | commachecker --event
 	echo "[Success]"
 }
 
@@ -106,7 +107,7 @@ check_per_core()
 		echo "[Skip] paranoid and not root"
 		return
 	fi
-	perf stat -x, --per-core -a true 2>&1 | commachecker --per-core
+	perf stat -x$csv_sep --per-core -a true 2>&1 | commachecker --per-core
 	echo "[Success]"
 }
 
@@ -118,7 +119,7 @@ check_per_thread()
 		echo "[Skip] paranoid and not root"
 		return
 	fi
-	perf stat -x, --per-thread -a true 2>&1 | commachecker --per-thread
+	perf stat -x$csv_sep --per-thread -a true 2>&1 | commachecker --per-thread
 	echo "[Success]"
 }
 
@@ -130,7 +131,7 @@ check_per_die()
 		echo "[Skip] paranoid and not root"
 		return
 	fi
-	perf stat -x, --per-die -a true 2>&1 | commachecker --per-die
+	perf stat -x$csv_sep --per-die -a true 2>&1 | commachecker --per-die
 	echo "[Success]"
 }
 
@@ -142,7 +143,7 @@ check_per_node()
 		echo "[Skip] paranoid and not root"
 		return
 	fi
-	perf stat -x, --per-node -a true 2>&1 | commachecker --per-node
+	perf stat -x$csv_sep --per-node -a true 2>&1 | commachecker --per-node
 	echo "[Success]"
 }
 
@@ -154,7 +155,7 @@ check_per_socket()
 		echo "[Skip] paranoid and not root"
 		return
 	fi
-	perf stat -x, --per-socket -a true 2>&1 | commachecker --per-socket
+	perf stat -x$csv_sep --per-socket -a true 2>&1 | commachecker --per-socket
 	echo "[Success]"
 }
 
-- 
2.39.2.637.g21b0678d19-goog

