Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C226DFD1C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 19:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjDLR4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 13:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjDLR42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 13:56:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6717840F4;
        Wed, 12 Apr 2023 10:56:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00F80634AD;
        Wed, 12 Apr 2023 17:56:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E36C433EF;
        Wed, 12 Apr 2023 17:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681322186;
        bh=SFPNZ57jgJwdanHftsNasuwe20prsMMXX1x5mPFxK8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mbQXm8E8gmSfb+WziLPWHWtU5vHmm9ryTSwe9KEllaXjP5kcpNN0TCFDCNkRhiz/t
         raVW/UA3nONz6GyX11z35knLETDH0knkito/Uph7fGiVzoaGJmoHMj3eajNBQ6CbLi
         r5zKYMJFMa6MY9zyxnC7BkTxlj9gjPINV/ke7dNP2skwFxfr+zNLKx1TzWqGztZc56
         qBEYfc9uTDkRTSi0V9/+KbQCZUp1+TmXzZ3pNSbzodBV4fyUHVYo5sYhyXXWRQCiog
         gGlNG4Q0mtQa4tMWqThWr7/2uZMXrH4a+2JfFu6yLPZU+C+okFyk0AD3NP5EM1MDzA
         OYZlhv/GJ1Hfw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B714940080; Wed, 12 Apr 2023 14:56:23 -0300 (-03)
Date:   Wed, 12 Apr 2023 14:56:23 -0300
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
Message-ID: <ZDbwx8dbIdQNEtMF@kernel.org>
References: <20230407230405.2931830-1-irogers@google.com>
 <20230407230405.2931830-3-irogers@google.com>
 <ZDWkmmj/UvuiXSWX@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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
> I think this should be further split into self contained patches as it
> does:
> These should be in a separate patchset using a new perf_cpu_map__set_nr() macro:
> 
> > +     RC_CHK_ACCESS(unmatched_cpus)->nr = unmatched_nr;
> > +     RC_CHK_ACCESS(matched_cpus)->nr = matched_nr;

One more, next one will be this:

⬢[acme@toolbox perf-tools-next]$ git diff
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 561e2616861f8bd9..760c848c9fa27728 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2020,8 +2020,8 @@ int perf_pmu__cpus_match(struct perf_pmu *pmu, struct perf_cpu_map *cpus,
                        matched_cpus->map[matched_nr++] = cpu;
        }

-       unmatched_cpus->nr = unmatched_nr;
-       matched_cpus->nr = matched_nr;
+       perf_cpu_map__set_nr(unmatched_cpus, unmatched_nr);
+       perf_cpu_map__set_nr(matched_cpus, matched_nr);
        *mcpus_ptr = matched_cpus;
        *ucpus_ptr = unmatched_cpus;
        return 0;
⬢[acme@toolbox perf-tools-next]$

From b277851417e0149aff5e6986e1ad6e2d8054e4a6 Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Wed, 12 Apr 2023 14:53:35 -0300
Subject: [PATCH 1/1] libperf: Add a perf_cpu_map__set_nr() available as an
 internal function for tools/perf to use

We'll need to reference count check 'struct perf_cpu_map', so wrap
accesses to its internal state to allow intercepting accesses to its
instances.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc: Dmitriy Vyukov <dvyukov@google.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Riccardo Mancini <rickyman7@gmail.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>
Link: https://lore.kernel.org/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/perf/cpumap.c                  | 5 +++++
 tools/lib/perf/include/internal/cpumap.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index 0833423c243b9b49..6bbcbb83eb14cc45 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -10,6 +10,11 @@
 #include <ctype.h>
 #include <limits.h>
 
+void perf_cpu_map__set_nr(struct perf_cpu_map *map, int nr_cpus)
+{
+	map->nr = nr_cpus;
+}
+
 struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus)
 {
 	struct perf_cpu_map *cpus = malloc(sizeof(*cpus) + sizeof(struct perf_cpu) * nr_cpus);
diff --git a/tools/lib/perf/include/internal/cpumap.h b/tools/lib/perf/include/internal/cpumap.h
index f5bffb1f86748ca2..b82fd6607a00e3dc 100644
--- a/tools/lib/perf/include/internal/cpumap.h
+++ b/tools/lib/perf/include/internal/cpumap.h
@@ -28,4 +28,6 @@ struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus);
 int perf_cpu_map__idx(const struct perf_cpu_map *cpus, struct perf_cpu cpu);
 bool perf_cpu_map__is_subset(const struct perf_cpu_map *a, const struct perf_cpu_map *b);
 
+void perf_cpu_map__set_nr(struct perf_cpu_map *map, int nr_cpus);
+
 #endif /* __LIBPERF_INTERNAL_CPUMAP_H */
-- 
2.39.2

