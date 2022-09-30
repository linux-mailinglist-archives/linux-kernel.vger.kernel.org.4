Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AB45F10CB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 19:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbiI3R2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 13:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbiI3R1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 13:27:43 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F69811FD24;
        Fri, 30 Sep 2022 10:27:36 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id b21so4542387plz.7;
        Fri, 30 Sep 2022 10:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=sYSCzo/dCEHy9uom4/Q42uUwbH0+TjIpRi+wDvZ9v+M=;
        b=A6oyjBK3ujGB4Vjkw0+7c6QXkkKsYwASuReGkcRIxnx/bukbBl6OVSZ1GFOvYJmR/q
         11jx0FFxDlO1eKDdaBkWlfJDDDJM8yey0o9WnBGyuhOo/+C6Uar/pA+2q4mEMt0Y/CQi
         VFp8M3YCYVPGq4ie4F5aGLUNUB/enFDBqdZL9vG/5fyvHdgurCZucNvNxb+gUiHV4Nzf
         w7zN/N7DOXY+OAfIc7huXnZ5v8sAXuMKdLF+NVQKJftjpsbinPJgRlhuJj6LgP0u/KNf
         irAtY9/i2rX7WJ/q/SEYsbm/7ibFRkv+epEYKLDaTiYrmtKTaV7i1keCSRlKfhq7msjm
         ZlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=sYSCzo/dCEHy9uom4/Q42uUwbH0+TjIpRi+wDvZ9v+M=;
        b=PQ4hBSs7xjUD98o0iqm7XAczG1M6HVFx/GZmAFyWlPv0kamX4UflAFDkSRFtNoOscX
         WXdgsrbKNXZIHnnmKUVdSbe9Chm7aoSD6UZnHgyuoLIEIYDfosAQ39uTsQ1PStqDIoej
         2ewiizFwCyk9tfCj0VFW4IyMylZmr8UmUmuHXTj92nhfwnqWtgLP8rOalBu3KKwD8E4e
         mi35UvYbwyuC62rqVKTgqqxWqOfSmn/KlON4kL81DGixxSwSyYOZb58F0RVud32dZzfG
         SC4JKaQndzmdbLp4+xd3y/a4F7mVM3T/jXoh47E21tD0HLVKbknMD+Ooe6lCimeQhWMX
         VZ2Q==
X-Gm-Message-State: ACrzQf0v21HR8zm0pdqEiyEMGTsZeQHr+CtaCXN4zGJunnYMJ/x+GD2q
        p9yRxEudzN3Sr78/kfqujIk=
X-Google-Smtp-Source: AMsMyM6RUSc/dZNQniCXQYK/8cTEtNmC4JENUAgxWQEUj1kF8z0vILQ5f5f4iHdQ1ZsvVPyTPjlTkA==
X-Received: by 2002:a17:90b:1c07:b0:202:ff6e:6015 with SMTP id oc7-20020a17090b1c0700b00202ff6e6015mr10994970pjb.210.1664558855318;
        Fri, 30 Sep 2022 10:27:35 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:4075:4245:762c:e746])
        by smtp.gmail.com with ESMTPSA id e10-20020a170902b78a00b00168dadc7354sm2154762pls.78.2022.09.30.10.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 10:27:34 -0700 (PDT)
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
Date:   Fri, 30 Sep 2022 10:27:14 -0700
Message-Id: <20220930172714.711616-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20220930172714.711616-1-namhyung@kernel.org>
References: <20220930172714.711616-1-namhyung@kernel.org>
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

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
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
2.38.0.rc1.362.ged0d419d3c-goog

