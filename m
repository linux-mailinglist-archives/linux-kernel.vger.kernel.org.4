Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDBD6E4DA9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 17:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjDQPuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 11:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjDQPti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 11:49:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2094EF1;
        Mon, 17 Apr 2023 08:49:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A7F2627A9;
        Mon, 17 Apr 2023 15:49:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B58C433EF;
        Mon, 17 Apr 2023 15:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681746552;
        bh=bysd5IIwjuAO5DVbyKkP3vq1Dzslza6Brvsl5Bx0PiY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AXfabgYn7VYJ3lC6sDxGBEH5kk2GtBVJgHl3jmB7e02U1nroOZst3dYz8idbTFqkL
         Kl/sI7SQebiL1OX8thzlho6i5vSI5F8jG1f6rNxlhcXTrcAC3viEMYyl9fropxPi8J
         AZfTfsWTIDbtvGlFucWz6IOC/W+5pLMfeAAkw/oiTsGggYTVl89qZrOoEDcsKQwlLX
         yv9UkL8lsj9UYgw3YYD/U/VmkF6a7BlNxuX5B/Ff4GkGIl+s7XPxgLTURtaBamtcVT
         ns4EKUoCBVHHlmSmZQw+HjCkAg9mTQwoOttp00adAQYIGmgUjucJsjCQqYGO1MnNnt
         DefUXMbw09V6w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 62287403B5; Mon, 17 Apr 2023 12:49:09 -0300 (-03)
Date:   Mon, 17 Apr 2023 12:49:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hao Luo <haoluo@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v7 2/5] perf cpumap: Add reference count checking
Message-ID: <ZD1qdYjG+DL6KOfP@kernel.org>
References: <20230407230405.2931830-1-irogers@google.com>
 <20230407230405.2931830-3-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407230405.2931830-3-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Apr 07, 2023 at 04:04:02PM -0700, Ian Rogers escreveu:
> Enabled when REFCNT_CHECKING is defined. The change adds a memory
> allocated pointer that is interposed between the reference counted
> cpu map at a get and freed by a put. The pointer replaces the original
> perf_cpu_map struct, so use of the perf_cpu_map via APIs remains
> unchanged. Any use of the cpu map without the API requires two versions,
> handled via the RC_CHK_ACCESS macro.
> 
> This change is intended to catch:
>  - use after put: using a cpumap after you have put it will cause a
>    segv.
>  - unbalanced puts: two puts for a get will result in a double free
>    that can be captured and reported by tools like address sanitizer,
>    including with the associated stack traces of allocation and frees.
>  - missing puts: if a put is missing then the get turns into a memory
>    leak that can be reported by leak sanitizer, including the stack
>    trace at the point the get occurs.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/perf/Makefile                  |  2 +-
>  tools/lib/perf/cpumap.c                  | 94 +++++++++++++-----------
>  tools/lib/perf/include/internal/cpumap.h |  4 +-
>  tools/perf/tests/cpumap.c                |  4 +-
>  tools/perf/util/cpumap.c                 | 40 +++++-----
>  tools/perf/util/pmu.c                    |  8 +-
>  6 files changed, 81 insertions(+), 71 deletions(-)
> 
> diff --git a/tools/lib/perf/Makefile b/tools/lib/perf/Makefile
> index d8cad124e4c5..3a9b2140aa04 100644
> --- a/tools/lib/perf/Makefile
> +++ b/tools/lib/perf/Makefile
> @@ -188,7 +188,7 @@ install_lib: libs
>  		cp -fpR $(LIBPERF_ALL) $(DESTDIR)$(libdir_SQ)
>  
>  HDRS := bpf_perf.h core.h cpumap.h threadmap.h evlist.h evsel.h event.h mmap.h
> -INTERNAL_HDRS := cpumap.h evlist.h evsel.h lib.h mmap.h threadmap.h xyarray.h
> +INTERNAL_HDRS := cpumap.h evlist.h evsel.h lib.h mmap.h rc_check.h threadmap.h xyarray.h
>  
>  INSTALL_HDRS_PFX := $(DESTDIR)$(prefix)/include/perf
>  INSTALL_HDRS := $(addprefix $(INSTALL_HDRS_PFX)/, $(HDRS))
> diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
> index 6cd0be7c1bb4..56eed1ac80d9 100644
> --- a/tools/lib/perf/cpumap.c
> +++ b/tools/lib/perf/cpumap.c
> @@ -10,16 +10,16 @@
>  #include <ctype.h>
>  #include <limits.h>
>  
> -static struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus)
> +struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus)
>  {
> -	struct perf_cpu_map *cpus = malloc(sizeof(*cpus) + sizeof(struct perf_cpu) * nr_cpus);
> -
> -	if (cpus != NULL) {
> +	struct perf_cpu_map *result;
> +	RC_STRUCT(perf_cpu_map) *cpus =
> +		malloc(sizeof(*cpus) + sizeof(struct perf_cpu) * nr_cpus);
> +	if (ADD_RC_CHK(result, cpus)) {
>  		cpus->nr = nr_cpus;
>  		refcount_set(&cpus->refcnt, 1);
> -
>  	}
> -	return cpus;
> +	return result;
>  }
>  
>  struct perf_cpu_map *perf_cpu_map__dummy_new(void)
> @@ -27,7 +27,7 @@ struct perf_cpu_map *perf_cpu_map__dummy_new(void)
>  	struct perf_cpu_map *cpus = perf_cpu_map__alloc(1);
>  
>  	if (cpus)
> -		cpus->map[0].cpu = -1;
> +		RC_CHK_ACCESS(cpus)->map[0].cpu = -1;

One more:

From 93bbe2e90194f70df537e0ea4836277c316b3050 Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Mon, 17 Apr 2023 12:47:49 -0300
Subject: [PATCH 1/1] libperf: Add perf_cpu_map__refcnt() interanl accessor to
 use in the maps test

To remove one more direct access to 'struct perf_cpu_map' so that we can
intercept accesses to its instantiations and refcount check it to catch
use after free, etc.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc: Dmitriy Vyukov <dvyukov@google.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Riccardo Mancini <rickyman7@gmail.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/perf/cpumap.c                  | 6 +++---
 tools/lib/perf/include/internal/cpumap.h | 4 ++++
 tools/perf/tests/cpumap.c                | 4 ++--
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index 6bbcbb83eb14cc45..27c3e73c6db29b57 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -40,7 +40,7 @@ struct perf_cpu_map *perf_cpu_map__dummy_new(void)
 static void cpu_map__delete(struct perf_cpu_map *map)
 {
 	if (map) {
-		WARN_ONCE(refcount_read(&map->refcnt) != 0,
+		WARN_ONCE(refcount_read(perf_cpu_map__refcnt(map)) != 0,
 			  "cpu_map refcnt unbalanced\n");
 		free(map);
 	}
@@ -49,13 +49,13 @@ static void cpu_map__delete(struct perf_cpu_map *map)
 struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map)
 {
 	if (map)
-		refcount_inc(&map->refcnt);
+		refcount_inc(perf_cpu_map__refcnt(map));
 	return map;
 }
 
 void perf_cpu_map__put(struct perf_cpu_map *map)
 {
-	if (map && refcount_dec_and_test(&map->refcnt))
+	if (map && refcount_dec_and_test(perf_cpu_map__refcnt(map)))
 		cpu_map__delete(map);
 }
 
diff --git a/tools/lib/perf/include/internal/cpumap.h b/tools/lib/perf/include/internal/cpumap.h
index b82fd6607a00e3dc..1e840dd53a11adc6 100644
--- a/tools/lib/perf/include/internal/cpumap.h
+++ b/tools/lib/perf/include/internal/cpumap.h
@@ -30,4 +30,8 @@ bool perf_cpu_map__is_subset(const struct perf_cpu_map *a, const struct perf_cpu
 
 void perf_cpu_map__set_nr(struct perf_cpu_map *map, int nr_cpus);
 
+static inline refcount_t *perf_cpu_map__refcnt(struct perf_cpu_map *map)
+{
+	return &map->refcnt;
+}
 #endif /* __LIBPERF_INTERNAL_CPUMAP_H */
diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
index 3150fc1fed6f503b..b1a924314e095b0d 100644
--- a/tools/perf/tests/cpumap.c
+++ b/tools/perf/tests/cpumap.c
@@ -68,7 +68,7 @@ static int process_event_cpus(struct perf_tool *tool __maybe_unused,
 	TEST_ASSERT_VAL("wrong nr",  perf_cpu_map__nr(map) == 2);
 	TEST_ASSERT_VAL("wrong cpu", perf_cpu_map__cpu(map, 0).cpu == 1);
 	TEST_ASSERT_VAL("wrong cpu", perf_cpu_map__cpu(map, 1).cpu == 256);
-	TEST_ASSERT_VAL("wrong refcnt", refcount_read(&map->refcnt) == 1);
+	TEST_ASSERT_VAL("wrong refcnt", refcount_read(perf_cpu_map__refcnt(map)) == 1);
 	perf_cpu_map__put(map);
 	return 0;
 }
@@ -94,7 +94,7 @@ static int process_event_range_cpus(struct perf_tool *tool __maybe_unused,
 	TEST_ASSERT_VAL("wrong nr",  perf_cpu_map__nr(map) == 256);
 	TEST_ASSERT_VAL("wrong cpu", perf_cpu_map__cpu(map, 0).cpu == 1);
 	TEST_ASSERT_VAL("wrong cpu", perf_cpu_map__max(map).cpu == 256);
-	TEST_ASSERT_VAL("wrong refcnt", refcount_read(&map->refcnt) == 1);
+	TEST_ASSERT_VAL("wrong refcnt", refcount_read(perf_cpu_map__refcnt(map)) == 1);
 	perf_cpu_map__put(map);
 	return 0;
 }
-- 
2.39.2

