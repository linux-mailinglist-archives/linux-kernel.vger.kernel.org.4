Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FB16DFCDC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 19:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjDLRpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 13:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjDLRpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 13:45:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE0E5BA0;
        Wed, 12 Apr 2023 10:45:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D76216364D;
        Wed, 12 Apr 2023 17:45:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AD7C433EF;
        Wed, 12 Apr 2023 17:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681321505;
        bh=C2Okaxi8HAPm3p9Co7NK51xvlY6z88fd67UrEVYXqdk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rtL+TXMwzgXBXsDgu16n+fEQrfpKn/7dh/fCcRCEdcNn13GP+T/B6oXQSj2I1aVGH
         /QUVqOkB64VdrOB3j7yPF+XCMeuDwN3k6/NTgEil9dU4CO4+a6MwGu/vDAqZUj0AuK
         Ug65B2D8Wu811tM5xnXn1Jr2gIrlxHKnn0nlDiWQqhOrxciWA7IU3Qy2+VDoWy8yIy
         kUYzcE3ID5BW68gRWLppdHvtgMgDVifOMHuxwTpAnSmTNcj06UH99cYL02yGIl4ncN
         ixM93NLQ7bouAiToG3fAvq2EJYpH8BP2yRf6LTF3mYFpIwfnMnCkDw5b6nX9RhtbQu
         udvr9JpWNIbdQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CC32140080; Wed, 12 Apr 2023 14:45:01 -0300 (-03)
Date:   Wed, 12 Apr 2023 14:45:01 -0300
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
Message-ID: <ZDbuHbUbhVKdMz9Y@kernel.org>
References: <20230407230405.2931830-1-irogers@google.com>
 <20230407230405.2931830-3-irogers@google.com>
 <ZDWkmmj/UvuiXSWX@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDWkmmj/UvuiXSWX@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 11, 2023 at 03:19:06PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Apr 07, 2023 at 04:04:02PM -0700, Ian Rogers escreveu:
> > This change is intended to catch:
> >  - use after put: using a cpumap after you have put it will cause a
> >    segv.
> >  - unbalanced puts: two puts for a get will result in a double free
> >    that can be captured and reported by tools like address sanitizer,
> >    including with the associated stack traces of allocation and frees.
> >  - missing puts: if a put is missing then the get turns into a memory
> >    leak that can be reported by leak sanitizer, including the stack
> >    trace at the point the get occurs.
 
> I think this should be further split into self contained patches as it
> does:
> 
> 2. Exports perf_cpu_map__alloc() from libperf for use in tools/perf
> 
> And its usage should be on a separate patch:
> 
> > -     struct perf_cpu_map *cpus = malloc(sizeof(*cpus) + sizeof(int) * nr);
> > +     struct perf_cpu_map *cpus = perf_cpu_map__alloc(nr);

From 1f94479edb4decdcec3e902528abb47f0ccd5d16 Mon Sep 17 00:00:00 2001
From: Ian Rogers <irogers@google.com>
Date: Wed, 12 Apr 2023 12:54:44 -0300
Subject: [PATCH 1/1] libperf: Make perf_cpu_map__alloc() available as an
 internal function for tools/perf to use

We had the open coded equivalent in perf_cpu_map__empty_new(), so reuse
what is in libperf.

Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc: Dmitriy Vyukov <dvyukov@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Riccardo Mancini <rickyman7@gmail.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>
Link: https://lore.kernel.org/lkml/20230407230405.2931830-3-irogers@google.com
[ Split from a larger patch ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/perf/cpumap.c                  | 2 +-
 tools/lib/perf/include/internal/cpumap.h | 1 +
 tools/perf/util/cpumap.c                 | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index 6cd0be7c1bb438e5..0833423c243b9b49 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -10,7 +10,7 @@
 #include <ctype.h>
 #include <limits.h>
 
-static struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus)
+struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus)
 {
 	struct perf_cpu_map *cpus = malloc(sizeof(*cpus) + sizeof(struct perf_cpu) * nr_cpus);
 
diff --git a/tools/lib/perf/include/internal/cpumap.h b/tools/lib/perf/include/internal/cpumap.h
index 35dd29642296e660..f5bffb1f86748ca2 100644
--- a/tools/lib/perf/include/internal/cpumap.h
+++ b/tools/lib/perf/include/internal/cpumap.h
@@ -24,6 +24,7 @@ struct perf_cpu_map {
 #define MAX_NR_CPUS	2048
 #endif
 
+struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus);
 int perf_cpu_map__idx(const struct perf_cpu_map *cpus, struct perf_cpu cpu);
 bool perf_cpu_map__is_subset(const struct perf_cpu_map *a, const struct perf_cpu_map *b);
 
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index c8484b75413ef709..072831f0cad46065 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -160,7 +160,7 @@ size_t cpu_map__fprintf(struct perf_cpu_map *map, FILE *fp)
 
 struct perf_cpu_map *perf_cpu_map__empty_new(int nr)
 {
-	struct perf_cpu_map *cpus = malloc(sizeof(*cpus) + sizeof(int) * nr);
+	struct perf_cpu_map *cpus = perf_cpu_map__alloc(nr);
 
 	if (cpus != NULL) {
 		int i;
-- 
2.39.2

