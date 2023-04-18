Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2906E68AC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 17:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbjDRPvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 11:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbjDRPvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:51:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB38118E9;
        Tue, 18 Apr 2023 08:50:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B7EF6360F;
        Tue, 18 Apr 2023 15:50:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43ABC433AE;
        Tue, 18 Apr 2023 15:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681833033;
        bh=S69g9Z1MTJwNHfumzm0YaNAnXZOMiQ8bygW8JHop/vc=;
        h=Date:From:To:Cc:Subject:From;
        b=uSTyC+gmtxGh+fJwCK4bkTEAH+4XO+Kke/2eL76Y6sY87eX6Va0e7N3bHpufefVjv
         l7XZg5ON9e153ym9vREAzJd8rMdnUKOZryvQOabzRzL1XHw9BP1AKMbcj7l2U+xaD1
         35mnL3/XUUO6UVc5jXYhhkuPK8F3iqITTmfMu/REMhodPa4z3mKkAQGT9kLFNFgs/m
         OQLW38eEHNQWpYmauDSDoijrZMs1W8JwGa08Ehtq6F4UqgOxcyG+mKV0faejkXd7I/
         6AiuanIyMtb1+Exy9tjxostDzSqsleekF5dOkZt0xiicJ/rGGFVwhEbqi3pTnSFYTv
         W7VoJ/+4nLcoQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0A84F403B5; Tue, 18 Apr 2023 12:50:29 -0300 (-03)
Date:   Tue, 18 Apr 2023 12:50:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>, James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] perf tools: Fix use before NULL check introduced by
 map__dso() introduction
Message-ID: <ZD68RYCVT8hqPuxr@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

James Clark noticed that the recent 63df0e4bc368adbd ("perf map: Add
accessor for dso") patch accessed map->dso before the 'map' variable was
NULL checked, which is a change in logic that leads to segmentation
faults, so comb thru that patch to fix similar cases.

Fixes: 63df0e4bc368adbd ("perf map: Add accessor for dso")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Will Deacon <will@kernel.org>
To: James Clark <james.clark@arm.com>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c    | 7 +++----
 tools/perf/ui/browsers/hists.c | 4 ++--
 tools/perf/util/sort.c         | 2 +-
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 8fba247b798ca307..006f522d0e7f6a18 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1075,8 +1075,7 @@ static int grab_bb(u8 *buffer, u64 start, u64 end,
 		return 0;
 	}
 
-	dso = map__dso(al.map);
-	if (!thread__find_map(thread, *cpumode, start, &al) || !dso) {
+	if (!thread__find_map(thread, *cpumode, start, &al) || (dso = map__dso(al.map)) == NULL) {
 		pr_debug("\tcannot resolve %" PRIx64 "-%" PRIx64 "\n", start, end);
 		return 0;
 	}
@@ -1106,9 +1105,9 @@ static int map__fprintf_srccode(struct map *map, u64 addr, FILE *fp, struct srcc
 	unsigned line;
 	int len;
 	char *srccode;
-	struct dso *dso = map__dso(map);
+	struct dso *dso;
 
-	if (!map || !dso)
+	if (!map || (dso = map__dso(map)) == NULL)
 		return 0;
 	srcfile = get_srcline_split(dso,
 				    map__rip_2objdump(map, addr),
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index ab70e5f5fad236e5..69c81759a64f938f 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2499,9 +2499,9 @@ add_annotate_opt(struct hist_browser *browser __maybe_unused,
 		 struct map_symbol *ms,
 		 u64 addr)
 {
-	struct dso *dso = map__dso(ms->map);
+	struct dso *dso;
 
-	if (!ms->map || !dso || dso->annotate_warned)
+	if (!ms->map || (dso = map__dso(ms->map)) == NULL || dso->annotate_warned)
 		return 0;
 
 	if (!ms->sym)
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index f2ffaf90648e469e..31b1cd0935e277ba 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -1568,7 +1568,7 @@ static int hist_entry__dcacheline_snprintf(struct hist_entry *he, char *bf,
 
 	if (he->mem_info) {
 		struct map *map = he->mem_info->daddr.ms.map;
-		struct dso *dso = map__dso(map);
+		struct dso *dso = map ? map__dso(map) : NULL;
 
 		addr = cl_address(he->mem_info->daddr.al_addr, chk_double_cl);
 		ms = &he->mem_info->daddr.ms;
-- 
2.39.2

