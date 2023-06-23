Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3332273C4A0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 01:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjFWXCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 19:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjFWXCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 19:02:40 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D7930DB;
        Fri, 23 Jun 2023 16:02:04 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1a991886254so1048592fac.2;
        Fri, 23 Jun 2023 16:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687561302; x=1690153302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ur4PISebzJfqwZslWwEXi2dOwIZMAqoVShCyP/LEfOI=;
        b=ADTYNTAxCknYejnqoyrfkvIf+OR88AEZftkZI90qNuwgNY+nzWdaUNfM5FMpTBqJUW
         4L0pO8PnoQ6e4SbU2xRTfquN99lOJuGnHbZshFnSJbjJLCldPYMTuHILNJyQY9yFIUV+
         y9aDP/T3U/RoGh7TmnnRYMkFvDBIq5UMY060n9rehlErXm9YYMZDp4lr0jRC4OnvuH6a
         /hYzUnF8s8di59f1kQ+srHYjKZPhG2gWWm+2b6jW0DygsYjlECyKlaT9jb0qdndKB1gS
         D0iUXRJfjedfiBT+pCuUU5FhcjA0va9Y7ERGrJJGmOh0ubldfxj0GUdPH5zHGsoKjOwr
         5fuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687561302; x=1690153302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ur4PISebzJfqwZslWwEXi2dOwIZMAqoVShCyP/LEfOI=;
        b=Aybn9uoa2m/MdpxDnRg14Csjq789gsMisJdG7jh40nDUpiapvtnqDYRp0kyzc6p+zf
         7h1di+/0dIGiTOpTojCCjEvvJBhvFDc+YQdrzcvmDQ/mgXCH7RoFZEHV5xFLCbJa77w6
         1eSXnQTB8waws+IWa7OjAUx/m0dO77cNkRFSduNeY5/u1oyj6zBKgO8pviuxccBML6eQ
         3tFozGfyEZDYBYfzhF0Y2JBiQrdUgjrpgj4NtU4gdpiWUM3YF4Mr7VPC3zwPIzR+gBCS
         E9WVds93QoU2PR+Bo4PraB9lFF3wH4TenBOgTVA766kVzwulY+7RTE2mg69ACTu0vHG8
         adRQ==
X-Gm-Message-State: AC+VfDxDSQCfFTTwydDnHDxWSqq7mcVN87lRjkIP141gWKn203bqRg8v
        e6FCSPJnxdng2rDnDLNvTRE=
X-Google-Smtp-Source: ACHHUZ4BWq3L6whBrMObUP3weBv1/0RTRnYlhEoBEgnTRYjjP4AS4tMtZNPmt1sF6oGgOvQA8798Aw==
X-Received: by 2002:a05:6808:21a4:b0:3a0:61a1:5ef0 with SMTP id be36-20020a05680821a400b003a061a15ef0mr7331808oib.39.1687561302531;
        Fri, 23 Jun 2023 16:01:42 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2a3:200:24b9:8f4e:fcc6:150a])
        by smtp.gmail.com with ESMTPSA id x11-20020aa793ab000000b00659af3079d3sm70723pff.16.2023.06.23.16.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 16:01:42 -0700 (PDT)
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
Subject: [PATCH 1/2] perf test: Reorder event name checks in stat STD output linter
Date:   Fri, 23 Jun 2023 16:01:38 -0700
Message-ID: <20230623230139.985594-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
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

On AMD machines, the perf stat STD output test failed like below:

  $ sudo ./perf test -v 98
   98: perf stat STD output linter                                     :
  --- start ---
  test child forked, pid 1841901
  Checking STD output: no argswrong event metric.
    expected 'GHz' in 108,121 stalled-cycles-frontend  # 10.88% frontend cycles idle
  test child finished with -1
  ---- end ----
  perf stat STD output linter: FAILED!

This is because there are stalled-cycles-{frontend,backend} events are
used by default.  The current logic checks the event_name array to find
which event it's running.  But 'cycles' event comes before those stalled
cycles event and it matches first.  So it tries to find 'GHz' metric
in the output (which is for the 'cycles') and fails.

Move the stalled-cycles-{frontend,backend} events before 'cycles' so
that it can find the stalled cycles events first.

Also add a space after 'no args' test name for consistency.

Fixes: 99a04a48f225 ("perf test: Add test case for the standard 'perf stat' output")
Cc: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/lib/stat_output.sh | 2 +-
 tools/perf/tests/shell/stat+std_output.sh | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/lib/stat_output.sh b/tools/perf/tests/shell/lib/stat_output.sh
index 363979b1123d..698343f0ecf9 100644
--- a/tools/perf/tests/shell/lib/stat_output.sh
+++ b/tools/perf/tests/shell/lib/stat_output.sh
@@ -9,7 +9,7 @@ function ParanoidAndNotRoot()
 # $1 name $2 extra_opt
 check_no_args()
 {
-        echo -n "Checking $1 output: no args"
+        echo -n "Checking $1 output: no args "
         perf stat $2 true
         commachecker --no-args
         echo "[Success]"
diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
index 98cc3356a04a..1f70aab45184 100755
--- a/tools/perf/tests/shell/stat+std_output.sh
+++ b/tools/perf/tests/shell/stat+std_output.sh
@@ -10,8 +10,8 @@ set -e
 
 stat_output=$(mktemp /tmp/__perf_test.stat_output.std.XXXXX)
 
-event_name=(cpu-clock task-clock context-switches cpu-migrations page-faults cycles instructions branches branch-misses stalled-cycles-frontend stalled-cycles-backend)
-event_metric=("CPUs utilized" "CPUs utilized" "/sec" "/sec" "/sec" "GHz" "insn per cycle" "/sec" "of all branches" "frontend cycles idle" "backend cycles idle")
+event_name=(cpu-clock task-clock context-switches cpu-migrations page-faults stalled-cycles-frontend stalled-cycles-backend cycles instructions branches branch-misses)
+event_metric=("CPUs utilized" "CPUs utilized" "/sec" "/sec" "/sec" "frontend cycles idle" "backend cycles idle" "GHz" "insn per cycle" "/sec" "of all branches")
 
 metricgroup_name=(TopdownL1 TopdownL2)
 
-- 
2.41.0.162.gfafddb0af9-goog

