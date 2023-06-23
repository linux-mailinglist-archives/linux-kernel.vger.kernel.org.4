Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F234973C49F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 01:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjFWXC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 19:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjFWXCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 19:02:40 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5B830DD;
        Fri, 23 Jun 2023 16:02:05 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6b5e9468720so1085437a34.2;
        Fri, 23 Jun 2023 16:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687561304; x=1690153304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJlQfVETWQjncSmnQ4teodumw1H80k/YD0fsmkk1X6E=;
        b=Y1ATiaF2gvAaE1mYG0n9k+Pj4L6GBfnLHmjFJ936HWKgku1p2W0IdiiQaWdzEGjE4m
         7isD1EDIkPB/i5lwcoQc1pXe68Uw2dGXGOQLFQVVZzdD7d8H4ZoJUmFEMBCsMNrL+06y
         LpRAyhAtTkrDCwTN/fK1rj2XCJmY6i3DACejfDBCw4VAwoAyWJciD75MS91jVK2aw2+j
         hm8uaaHvW6JitORm0/IEL9jGWk6rFEgpDxaSCZ3YLcXFdixqpw+Sx/91L4abdWWuoYlJ
         sPNIZ9WpXTMH3lPnG8MOZyVYW1x+z5VgZXCl/8u5rJsJbFr3psm0H9L0DXPDLH07UDJi
         Sv9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687561304; x=1690153304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DJlQfVETWQjncSmnQ4teodumw1H80k/YD0fsmkk1X6E=;
        b=eWND79h54+Fs3N6Q1UnJtw8H0kmHPno9PjKfii7aAZLM2rGmrbQ4yaMod1EOLolHvm
         Zzrn6zrrPAKJTyPcPTYsT0+1VRFOMFC7LZ51sATfYoySihUCXAtNlb84AHnrpAoGhd3X
         5C8c8hUWTBbA0O818y2CBUXRKDiqZ87nSGMJfzqVuC1I15uRfd2cgyd4m+qYTItNZ9AJ
         8q8gZdmiKKSQ39zt34rXZbfeCgeQZMErMMI6kCrKLlqyfMLr2LoGzmkqWl4nFZiPftPw
         WpAycwP8O/r8YcNXC91YnLncPh2HjzaHZBCbdglKaNI67dSymrWRMrOaez+aey1pHltu
         sLag==
X-Gm-Message-State: AC+VfDyAgoTEGPtdUtjfcXRXI0MlHtKPoJCtchOr5l6cfz+jsWiBsc0N
        0ouVU8ieEufW7UY4qhhDWiE=
X-Google-Smtp-Source: ACHHUZ4FjtpHMwgF1+dBxAFtkmpRvdOZw3PjQFO+2OEqtE2xDJOhbga18qViGa1ot9CIT+AvBI0YlA==
X-Received: by 2002:a05:6808:13c6:b0:39a:b1e4:ef28 with SMTP id d6-20020a05680813c600b0039ab1e4ef28mr29542837oiw.47.1687561303637;
        Fri, 23 Jun 2023 16:01:43 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2a3:200:24b9:8f4e:fcc6:150a])
        by smtp.gmail.com with ESMTPSA id x11-20020aa793ab000000b00659af3079d3sm70723pff.16.2023.06.23.16.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 16:01:43 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/2] perf test: Skip metrics w/o event name in stat STD output linter
Date:   Fri, 23 Jun 2023 16:01:39 -0700
Message-ID: <20230623230139.985594-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230623230139.985594-1-namhyung@kernel.org>
References: <20230623230139.985594-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This test checks if the output of perf stat to match event names and
metrics.  So it wants the output lines to have both event name and
metric.  Otherwise it should skip the line.

On AMD machines, the instruction event has two metrics and they are printed
in separate lines.  It makes the line without event name like below:

  # perf stat -a sleep 1

   Performance counter stats for 'system wide':

           64,383.34 msec cpu-clock                  #   64.048 CPUs utilized
              14,526      context-switches           #  225.617 /sec
                 112      cpu-migrations             #    1.740 /sec
                 190      page-faults                #    2.951 /sec
         807,558,652      cycles                     #    0.013 GHz                         (83.30%)
          69,809,799      stalled-cycles-frontend    #    8.64% frontend cycles idle        (83.30%)
         196,983,266      stalled-cycles-backend     #   24.39% backend cycles idle         (83.30%)
         424,876,008      instructions               #    0.53  insn per cycle
 (here) --->                                  #    0.46  stalled cycles per insn     (83.30%)
          97,788,321      branches                   #    1.519 M/sec                       (83.34%)
           4,147,377      branch-misses              #    4.24% of all branches             (83.46%)

         1.005241409 seconds time elapsed

Also modern Intel machines have TopDown metrics which also don't have
event names.

  # perf stat -a sleep 1

   Performance counter stats for 'system wide':

            8,015.39 msec cpu-clock                        #    7.996 CPUs utilized
               5,823      context-switches                 #  726.477 /sec
                 189      cpu-migrations                   #   23.580 /sec
                 139      page-faults                      #   17.342 /sec
         435,139,308      cycles                           #    0.054 GHz
         193,891,345      instructions                     #    0.45  insn per cycle
          42,773,028      branches                         #    5.336 M/sec
           2,298,113      branch-misses                    #    5.37% of all branches
                          TopdownL1                 #     25.5 %  tma_backend_bound
              /-->                                  #      7.9 %  tma_bad_speculation
    (here) --+                                      #     55.7 %  tma_frontend_bound
              \-->                                  #     10.9 %  tma_retiring

         1.002395924 seconds time elapsed

There is a check to skip TopdownL1 and TopdownL2 specifically but it
does not cover every affected lines.

So there is another check to skip the line if it has nothing on the left
side of # sign.  Well.. it seems ok but that's not enough too.

When aggregation mode (like --per-socket or --per-thread) is used, it
adds some prefix (e.g. CPU socket, task name and PID) in the output
line.  So the test code ignores them to normalize result.

A problem can happen for per-thread mode when task name contains one or
more spaces.  It'd only ignore the first part of the task name, and it
thinks there's something more in the line so it would not skip.

  # perf stat -a --perf-thread sleep 1
  ...
            perf-21276                  #     70.2 %  tma_backend_bound
            perf-21276                  #      3.9 %  tma_bad_speculation
            perf-21276                  #     10.5 %  tma_frontend_bound
            perf-21276                  #     15.3 %  tma_retiring
	    ^^^^^^^^^^
	    (ignored)

         my task-21328                  #     70.2 %  tma_backend_bound
         my task-21328                  #      3.9 %  tma_bad_speculation
         my task-21328                  #     10.5 %  tma_frontend_bound
         my task-21328                  #     15.3 %  tma_retiring
	 ^^
     (ignored)

So I think it should look at the metric names instead.  Add skip_metric
to hold the list of names to skip.  It would contain 'stalled cycles per
insn' and metrics started by 'tma_'.

Fixes: 99a04a48f225 ("perf test: Add test case for the standard 'perf stat' output")
Cc: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/stat+std_output.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
index 1f70aab45184..f972b31fa0c2 100755
--- a/tools/perf/tests/shell/stat+std_output.sh
+++ b/tools/perf/tests/shell/stat+std_output.sh
@@ -12,8 +12,7 @@ stat_output=$(mktemp /tmp/__perf_test.stat_output.std.XXXXX)
 
 event_name=(cpu-clock task-clock context-switches cpu-migrations page-faults stalled-cycles-frontend stalled-cycles-backend cycles instructions branches branch-misses)
 event_metric=("CPUs utilized" "CPUs utilized" "/sec" "/sec" "/sec" "frontend cycles idle" "backend cycles idle" "GHz" "insn per cycle" "/sec" "of all branches")
-
-metricgroup_name=(TopdownL1 TopdownL2)
+skip_metric=("stalled cycles per insn" "tma_")
 
 cleanup() {
   rm -f "${stat_output}"
@@ -58,13 +57,14 @@ function commachecker()
 
 		main_body=$(echo $line | cut -d' ' -f$prefix-)
 		x=${main_body%#*}
-		# Check default metricgroup
-		y=$(echo $x | tr -d ' ')
-		[ "$y" = "" ] && continue
-		for i in "${!metricgroup_name[@]}"; do
-			[[ "$y" == *"${metricgroup_name[$i]}"* ]] && break
+		[ "$x" = "" ] && continue
+
+		# Skip metrics without event name
+		y=${main_body#*#}
+		for i in "${!skip_metric[@]}"; do
+			[[ "$y" == *"${skip_metric[$i]}"* ]] && break
 		done
-		[[ "$y" == *"${metricgroup_name[$i]}"* ]] && continue
+		[[ "$y" == *"${skip_metric[$i]}"* ]] && continue
 
 		# Check default event
 		for i in "${!event_name[@]}"; do
-- 
2.41.0.162.gfafddb0af9-goog

