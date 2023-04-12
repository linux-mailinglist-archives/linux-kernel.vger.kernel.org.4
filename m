Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3E66DFA90
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjDLPuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjDLPuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:50:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53E559F0;
        Wed, 12 Apr 2023 08:50:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FC9E63583;
        Wed, 12 Apr 2023 15:50:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CDBC433D2;
        Wed, 12 Apr 2023 15:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681314608;
        bh=py3z9HpgKFsgkK9Fic8o4YVTIgR1hDxGNyaU/pbt2JI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vNRd7hdMc13Bgl7TeBLNA48Df/uWyCYgfPg5viZELVHwugJcquo2tgx9145J/rs2W
         /SSxGdV6Iykvm44ZpdC2sktgczRGEd+Jgm5v/zkNKqRcEpIv6WsAjf0n9+FWmNuL3D
         Nvd7bzr8kQQ1vNF3Lo+TXjwP1VnCn4pWQjd/mHMtSQe/qqhDH9GDxsEVTei/QJqZhl
         Xa2vazN0P6ewrIjITHHldUsLcIVoYQ7+fHDZD1pwls9H0iS/NxJMz1hDshh+HR2l0u
         MwfUiF/kWBlM9ldSuVmr0GagEmhkmaUQoSSMdaPjkJrdU4zrp9TJ0legQthIuVoRfQ
         W1jxRySoyjAag==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 94F7F40080; Wed, 12 Apr 2023 12:50:05 -0300 (-03)
Date:   Wed, 12 Apr 2023 12:50:05 -0300
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
Message-ID: <ZDbTLbjtJ8mVET8N@kernel.org>
References: <20230407230405.2931830-1-irogers@google.com>
 <20230407230405.2931830-3-irogers@google.com>
 <ZDWkmmj/UvuiXSWX@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDWkmmj/UvuiXSWX@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
 
> These are missing convertions that should be in a separate patch, no?
> 
> > @@ -239,7 +236,7 @@ struct cpu_aggr_map *cpu_aggr_map__new(const struct perf_cpu_map *cpus,
> >  {
> >       int idx;
> >       struct perf_cpu cpu;
> > -     struct cpu_aggr_map *c = cpu_aggr_map__empty_new(cpus->nr);
> > +     struct cpu_aggr_map *c = cpu_aggr_map__empty_new(perf_cpu_map__nr(cpus));
> >
> >       if (!c)
> >               return NULL;

Extracted this from your larger patch:

From f8a23fce48400168be0cc078a0b0bd0e7d4a889f Mon Sep 17 00:00:00 2001
From: Ian Rogers <irogers@google.com>
Date: Wed, 12 Apr 2023 12:45:45 -0300
Subject: [PATCH 1/1] perf cpumap: Use perf_cpu_map__nr(cpus) to access
 cpus->nr

So that we can have a single point where to refcount check 'struct perf_cpu_map'
instances for use after free, etc.

Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc: Dmitriy Vyukov <dvyukov@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Riccardo Mancini <rickyman7@gmail.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cpumap.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 5e564974fba4ffab..c8484b75413ef709 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -239,7 +239,7 @@ struct cpu_aggr_map *cpu_aggr_map__new(const struct perf_cpu_map *cpus,
 {
 	int idx;
 	struct perf_cpu cpu;
-	struct cpu_aggr_map *c = cpu_aggr_map__empty_new(cpus->nr);
+	struct cpu_aggr_map *c = cpu_aggr_map__empty_new(perf_cpu_map__nr(cpus));
 
 	if (!c)
 		return NULL;
@@ -263,7 +263,7 @@ struct cpu_aggr_map *cpu_aggr_map__new(const struct perf_cpu_map *cpus,
 		}
 	}
 	/* Trim. */
-	if (c->nr != cpus->nr) {
+	if (c->nr != perf_cpu_map__nr(cpus)) {
 		struct cpu_aggr_map *trimmed_c =
 			realloc(c,
 				sizeof(struct cpu_aggr_map) + sizeof(struct aggr_cpu_id) * c->nr);
@@ -582,9 +582,9 @@ size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size)
 
 #define COMMA first ? "" : ","
 
-	for (i = 0; i < map->nr + 1; i++) {
+	for (i = 0; i < perf_cpu_map__nr(map) + 1; i++) {
 		struct perf_cpu cpu = { .cpu = INT_MAX };
-		bool last = i == map->nr;
+		bool last = i == perf_cpu_map__nr(map);
 
 		if (!last)
 			cpu = map->map[i];
@@ -633,7 +633,7 @@ size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size_t size)
 	int i, cpu;
 	char *ptr = buf;
 	unsigned char *bitmap;
-	struct perf_cpu last_cpu = perf_cpu_map__cpu(map, map->nr - 1);
+	struct perf_cpu last_cpu = perf_cpu_map__cpu(map, perf_cpu_map__nr(map) - 1);
 
 	if (buf == NULL)
 		return 0;
@@ -644,7 +644,7 @@ size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size_t size)
 		return 0;
 	}
 
-	for (i = 0; i < map->nr; i++) {
+	for (i = 0; i < perf_cpu_map__nr(map); i++) {
 		cpu = perf_cpu_map__cpu(map, i).cpu;
 		bitmap[cpu / 8] |= 1 << (cpu % 8);
 	}
-- 
2.39.2

