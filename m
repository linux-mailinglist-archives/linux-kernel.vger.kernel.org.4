Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D13264AB23
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 00:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbiLLXI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 18:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiLLXIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 18:08:25 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DEF389C;
        Mon, 12 Dec 2022 15:08:24 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 62so9244888pgb.13;
        Mon, 12 Dec 2022 15:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=BixYrt5jBeO5bMXrldU6lVICXxrT+iOah0QeXup/R6o=;
        b=T36ktEhXs/gqYRRMf3MNb3cHeHp/KrXHpooTcgVq7pfaUm+FUZEyqBOF06LBDZonOY
         eG9NwOkL3Njyw7C3kREHLjdWI1CMjykmC9973vJSFR5MOwZDo7SOSXEEM9RqlWOaIews
         bCRHV6VTfpoquO1LOSMqFF+yHGvHs7vbqEK6ZHheqRTBtNkYjxKKNhVhiGv6MJj43r1o
         oupmlSQmLxrYS2hwFx1WfFg4qsYhB522rZgFJRuCJhX41gE4upJRr47DpksoIjlNGGvz
         VqQlxxPk0Cr3zV0kk0xUpsKEkLyoEK6JsGEYCTP5NmARxFfT9TnnOKhfiUL4XBemawYN
         87+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BixYrt5jBeO5bMXrldU6lVICXxrT+iOah0QeXup/R6o=;
        b=7TnrTrTG99oRuF65bgGRzzCjEHiUFJRnYubd5Gff1qVZuJlb/THpdTP5gqsHpieDL2
         nMHAVFdB8OOz6r3BkbPTlEFWtZ4tBAeqfqlpzLEvtQeuVPM1lZV0skfj9V8rSVTehox9
         pkcycySnAwPrranREMltXR3MQDc+zC+db46NQT1aEPhEuewJve1eT+fw+j8qwoKNmYmx
         EEnm++IWZEi7YnHMNXA9zMzvljw6IyRjwPs0k5pfB8HkLs+kC2FErxO7C6lFAfi3oyF8
         PsRLo9QVFAf9/Sz19KDNl4oU418PVqW3JuAmknPI7J0VSO4t4I5CTqCtHQBnNGKQ80Q7
         gWng==
X-Gm-Message-State: ANoB5pkcXgUUxf2wHB0z/TG0eTEJAmCI2OcChRsm3GRRH4nzUBNMicOy
        H/aABV6r7xnFKKAcxr7NYnY=
X-Google-Smtp-Source: AA0mqf7YkFbwkTfZO8URj12Zm9HNrcevDbm/Au7uAYkksZcTtH7uPMY7DoCNcjYsx2nzDE+8+U4AbQ==
X-Received: by 2002:a05:6a00:e14:b0:573:d183:4218 with SMTP id bq20-20020a056a000e1400b00573d1834218mr18794633pfb.10.1670886504196;
        Mon, 12 Dec 2022 15:08:24 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:9742:b5d1:7b27:ce4c])
        by smtp.gmail.com with ESMTPSA id f67-20020a625146000000b0056be1581126sm6529114pfb.143.2022.12.12.15.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 15:08:23 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kevin Nomura <nomurak@google.com>
Subject: [PATCH] perf stat: Do not delay the workload with --delay
Date:   Mon, 12 Dec 2022 15:08:20 -0800
Message-Id: <20221212230820.901382-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The -D/--delay option is to delay the measure after the program starts.
But the current code goes to sleep before starting the program so the
program is delayed too.  This is not the intention, let's fix it.

Before:

  $ time sudo ./perf stat -a -e cycles -D 3000 sleep 4
  Events disabled
  Events enabled

   Performance counter stats for 'system wide':

       4,326,949,337      cycles

         4.007494118 seconds time elapsed

  real	0m7.474s
  user	0m0.356s
  sys	0m0.120s

It ran the workload for 4 seconds and gave the 3 second delay.  So it
should skip the first 3 second and measure the last 1 second only.  But
as you can see, it delays 3 seconds and ran the workload after that for
4 seconds.  So the total time (real) was 7 seconds.

After:

  $ time sudo ./perf stat -a -e cycles -D 3000 sleep 4
  Events disabled
  Events enabled

   Performance counter stats for 'system wide':

       1,063,551,013      cycles

         1.002769510 seconds time elapsed

  real	0m4.484s
  user	0m0.385s
  sys	0m0.086s

The bug was introduced when it changed enablement of system-wide events
with a command line workload.  But it should've considered the initial
delay case.  The code was reworked since then (in bb8bc52e7578) so I'm
afraid it won't be applied cleanly.

Fixes: d0a0a511493d ("perf stat: Fix forked applications enablement of counters")
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Reported-by: Kevin Nomura <nomurak@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d040fbcdcc5a..b39bf785a16e 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -540,26 +540,14 @@ static int enable_counters(void)
 			return err;
 	}
 
-	if (stat_config.initial_delay < 0) {
-		pr_info(EVLIST_DISABLED_MSG);
-		return 0;
-	}
-
-	if (stat_config.initial_delay > 0) {
-		pr_info(EVLIST_DISABLED_MSG);
-		usleep(stat_config.initial_delay * USEC_PER_MSEC);
-	}
-
 	/*
 	 * We need to enable counters only if:
 	 * - we don't have tracee (attaching to task or cpu)
 	 * - we have initial delay configured
 	 */
-	if (!target__none(&target) || stat_config.initial_delay) {
+	if (!target__none(&target)) {
 		if (!all_counters_use_bpf)
 			evlist__enable(evsel_list);
-		if (stat_config.initial_delay > 0)
-			pr_info(EVLIST_ENABLED_MSG);
 	}
 	return 0;
 }
@@ -930,14 +918,27 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			return err;
 	}
 
-	err = enable_counters();
-	if (err)
-		return -1;
+	if (stat_config.initial_delay) {
+		pr_info(EVLIST_DISABLED_MSG);
+	} else {
+		err = enable_counters();
+		if (err)
+			return -1;
+	}
 
 	/* Exec the command, if any */
 	if (forks)
 		evlist__start_workload(evsel_list);
 
+	if (stat_config.initial_delay > 0) {
+		usleep(stat_config.initial_delay * USEC_PER_MSEC);
+		err = enable_counters();
+		if (err)
+			return -1;
+
+		pr_info(EVLIST_ENABLED_MSG);
+	}
+
 	t0 = rdclock();
 	clock_gettime(CLOCK_MONOTONIC, &ref_time);
 
-- 
2.39.0.rc1.256.g54fd8350bd-goog

