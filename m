Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC335E8EB2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 18:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiIXQ6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 12:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233939AbiIXQ5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 12:57:48 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397428FD5E;
        Sat, 24 Sep 2022 09:57:46 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id t190so2950608pgd.9;
        Sat, 24 Sep 2022 09:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=pBF4ZzTbmSSf3D3u0dSQ0dRvqjp81c7kDio+V9o09V4=;
        b=GPgSOwj8gg3MLAl25L5V+/YfmaBwz8OIMSUembZ/4dgveavNrGxKC8CHwSRVz8z9jH
         dZtN7BfH0Hqu9ND3293o6ayYTR5VBSaez28su8AirlqYs4Wjpwd6J6KKAJJ9+A0iN9AK
         bSuNkMiGifrYpq/DPApbgdQKBo4lAutonHjagmSEKLi10Bey3OUC3tLkWUVbeamDq4CC
         XyBNkG4eI5AhnQ9cqVHIeGJIJ54mvD2U498PcvOAFwepefgEcYHM/cCnJrjL3/SJ/R3a
         s6+Dcq/HQrTYToG3Vy36gA924LA8PYmtiWrdN1yM4vnzMX9Vwnn1mj5DhAzh6v9ncjOg
         k9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=pBF4ZzTbmSSf3D3u0dSQ0dRvqjp81c7kDio+V9o09V4=;
        b=iOUTCJuujfHrSSBw7j1KHuQlDfI4kaGxSalNNPmd9XoiAxM8Gm3o4I4cT1mG29FP1C
         sUyr0YtAB7D6oSOyMwjBuToCcqG+D6uVCqfvQsg6KJiFEidoiVSVn+1N97O/OYkpjXVY
         BGVMsAMKNCLos5Q6Ro/zFHKdipXn7GveRGpWI0zpeXCp/fb1v/cDVvKGehdw2WeQ+6f3
         h+VTzg5Fgb3ebIkKYy48byMKqmQk8NtcFldsNZEemjsd2x5p+eGqc3i7QXe8ikYkpzV8
         T9Hkv0Q35Q9lS00peZWdvtEHU+0AhU3xb1Hw4UWbL8t/6RMBxUCHqJakhJLFx3tNziK7
         /+8A==
X-Gm-Message-State: ACrzQf1BRd/oKsnZ14I0ip8Vxn7vQ8Mjg+3xDfoTB0/ZLN56ef/VkaDM
        J4IUNb1e2iVAmhD8EFR7H0E=
X-Google-Smtp-Source: AMsMyM53GVkc2Cy683BypENlfHcF58Gw5tykq4EfpnnWckONGuemFtLPWnEhUZIh6oM6QnrgxUyu7w==
X-Received: by 2002:a63:4243:0:b0:439:2031:be87 with SMTP id p64-20020a634243000000b004392031be87mr12801448pga.592.1664038666190;
        Sat, 24 Sep 2022 09:57:46 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:20c0:42d3:7ef1:1f3])
        by smtp.gmail.com with ESMTPSA id m12-20020a170902f20c00b00176675adbe1sm7960082plc.208.2022.09.24.09.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 09:57:45 -0700 (PDT)
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
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 5/5] perf tools: Remove special handling of system-wide evsel
Date:   Sat, 24 Sep 2022 09:57:37 -0700
Message-Id: <20220924165737.956428-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
In-Reply-To: <20220924165737.956428-1-namhyung@kernel.org>
References: <20220924165737.956428-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For system-wide evsels, the thread map should be dummy - i.e. it has a
single entry of -1.  But the code guarantees such a thread map, so no
need to handle it specially.

No functional change intended.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/lib/perf/evsel.c      |  3 ---
 tools/perf/builtin-script.c |  3 ---
 tools/perf/util/evsel.c     | 12 ++----------
 tools/perf/util/stat.c      |  3 ---
 4 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index 8ce5bbd09666..8b51b008a81f 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -515,9 +515,6 @@ int perf_evsel__alloc_id(struct perf_evsel *evsel, int ncpus, int nthreads)
 	if (ncpus == 0 || nthreads == 0)
 		return 0;
 
-	if (evsel->system_wide)
-		nthreads = 1;
-
 	evsel->sample_id = xyarray__new(ncpus, nthreads, sizeof(struct perf_sample_id));
 	if (evsel->sample_id == NULL)
 		return -ENOMEM;
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 886f53cfa257..7fa467ed91dc 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2243,9 +2243,6 @@ static void __process_stat(struct evsel *counter, u64 tstamp)
 	struct perf_cpu cpu;
 	static int header_printed;
 
-	if (counter->core.system_wide)
-		nthreads = 1;
-
 	if (!header_printed) {
 		printf("%3s %8s %15s %15s %15s %15s %s\n",
 		       "CPU", "THREAD", "VAL", "ENA", "RUN", "TIME", "EVENT");
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 5776bfa70f11..e319bb17d10d 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1813,7 +1813,7 @@ static struct perf_thread_map *empty_thread_map;
 static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
 		struct perf_thread_map *threads)
 {
-	int nthreads;
+	int nthreads = perf_thread_map__nr(threads);
 
 	if ((perf_missing_features.write_backward && evsel->core.attr.write_backward) ||
 	    (perf_missing_features.aux_output     && evsel->core.attr.aux_output))
@@ -1839,11 +1839,6 @@ static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
 		threads = empty_thread_map;
 	}
 
-	if (evsel->core.system_wide)
-		nthreads = 1;
-	else
-		nthreads = threads->nr;
-
 	if (evsel->core.fd == NULL &&
 	    perf_evsel__alloc_fd(&evsel->core, perf_cpu_map__nr(cpus), nthreads) < 0)
 		return -ENOMEM;
@@ -2061,10 +2056,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	if (threads == NULL)
 		threads = empty_thread_map;
 
-	if (evsel->core.system_wide)
-		nthreads = 1;
-	else
-		nthreads = threads->nr;
+	nthreads = perf_thread_map__nr(threads);
 
 	if (evsel->cgrp)
 		pid = evsel->cgrp->fd;
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index ce5e9e372fc4..cef943377ad7 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -420,9 +420,6 @@ static int process_counter_maps(struct perf_stat_config *config,
 	int ncpus = evsel__nr_cpus(counter);
 	int idx, thread;
 
-	if (counter->core.system_wide)
-		nthreads = 1;
-
 	for (thread = 0; thread < nthreads; thread++) {
 		for (idx = 0; idx < ncpus; idx++) {
 			if (process_counter_values(config, counter, idx, thread,
-- 
2.37.3.998.g577e59143f-goog

