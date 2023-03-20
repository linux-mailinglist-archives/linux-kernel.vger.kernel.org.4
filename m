Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5306C6C239D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjCTVZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjCTVYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:24:53 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1F030B2C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:24:25 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536cb268ab8so136132507b3.17
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679347462;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NZSTAlatdezUNZqdamSKfW9oqDBHQoWsbo0yb5484mE=;
        b=JdAu8PMKQEi4bieLV725buzM41qbgUkaxsS5tUEVI8F5HKNIJcy0rLUBV+ZmRVoUBt
         UExOK4KAE9PN+GRurJjXLPifQzi1MVHyxV9t0z4uW5B71GFsNcFeyBeShweFigA0O7aF
         sXiBIYr6XVhIGAvudgRtIidhoFiGcBZMKkLkJu/0LF7t1oF5Sp0n0E8YOePHLDFqt8LJ
         JezGb7uWBYwCC1+HIKIL92W9eRpd8Z4cS3BuS+3U2oGEnzuytuL88xPMdwf+kqhn/at9
         W+fX+owKMVkc3R4bMl402Gw6mVbY9ZVzZHS7VH6WgsPyixsg1JPaSp7wqLitPMttLRTS
         sjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679347462;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NZSTAlatdezUNZqdamSKfW9oqDBHQoWsbo0yb5484mE=;
        b=13c00q5HrbQwU4Bwfw6B7GH0w2yj+k6EpnDMrG1xsxILAz4upJJ4dOa7djykfLZst9
         lVCMx5+8GsPkYLJwiN5Chbt5A5xMgLZhwQ4+sCUoGYR9RhOx8gMhqdKeSMxCLEB/puT3
         TQwb+ry/jN2nWsqzakk+oMylhYb2h6hLTYwln/VBi1ZHuhmpXhUJRDuOQrdHiTSRLzfd
         o/KSivMqg43hRc92YJuLUZXd5Lq/ATLNSt4zoFnD4sGg/CYGRtz8KxRWzi87k41R88uF
         xMz+f09nfp4Qi6mDLGfYWygjW7NJVsZi+NeQC5XKK6na6xei5HVC3avfD5d905Icc1B3
         xRDw==
X-Gm-Message-State: AO0yUKX1hwsnQZSteWJhOtYXCrIl27W2XZ3uLLoZFFbhpFMTHAPPRW3M
        3aSkVsTmLf4N7QHM2gKrqgfujIuYtgQK
X-Google-Smtp-Source: AK7set80BpnTMxIuVFH04AHkuXSJzpUb15eiPscxY003I+puT5meiAZ0JWqBTIcpCPbxVUsKKLWyB0KsIJSA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a30f:d1e2:fcd8:aa4d])
 (user=irogers job=sendgmr) by 2002:a05:6902:1002:b0:a27:3ecc:ffe7 with SMTP
 id w2-20020a056902100200b00a273eccffe7mr6243320ybt.3.1679347462405; Mon, 20
 Mar 2023 14:24:22 -0700 (PDT)
Date:   Mon, 20 Mar 2023 14:22:42 -0700
In-Reply-To: <20230320212248.1175731-1-irogers@google.com>
Message-Id: <20230320212248.1175731-12-irogers@google.com>
Mime-Version: 1.0
References: <20230320212248.1175731-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v5 11/17] perf maps: Modify maps_by_name to hold a reference
 to a map
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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
        Dmitry Vyukov <dvyukov@google.com>, Hao Luo <haoluo@google.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make it clearer about the ownership of a reference count split the
by-name case from the regular start-address sorted tree. Put the
reference count when maps_by_name is freed, which requires moving a
decrement to nr_maps in maps__remove. Add two missing map puts in
maps__fixup_overlappings in the event maps__insert fails.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/maps.c   | 30 ++++++++++++++++--------------
 tools/perf/util/symbol.c | 21 +++++++++++++++++----
 2 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index ffd4a4a64026..74e3133f5007 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -26,6 +26,9 @@ static void __maps__free_maps_by_name(struct maps *maps)
 	/*
 	 * Free everything to try to do it from the rbtree in the next search
 	 */
+	for (unsigned int i = 0; i < maps__nr_maps(maps); i++)
+		map__put(maps__maps_by_name(maps)[i]);
+
 	zfree(&maps->maps_by_name);
 	maps->nr_maps_allocated = 0;
 }
@@ -42,7 +45,7 @@ static int __maps__insert(struct maps *maps, struct map *map)
 		return -ENOMEM;
 
 	RB_CLEAR_NODE(&new_rb_node->rb_node);
-	new_rb_node->map = map;
+	new_rb_node->map = map__get(map);
 
 	while (*p != NULL) {
 		parent = *p;
@@ -55,7 +58,6 @@ static int __maps__insert(struct maps *maps, struct map *map)
 
 	rb_link_node(&new_rb_node->rb_node, parent, p);
 	rb_insert_color(&new_rb_node->rb_node, maps__entries(maps));
-	map__get(map);
 	return 0;
 }
 
@@ -100,7 +102,7 @@ int maps__insert(struct maps *maps, struct map *map)
 			maps->maps_by_name = maps_by_name;
 			maps->nr_maps_allocated = nr_allocate;
 		}
-		maps__maps_by_name(maps)[maps__nr_maps(maps) - 1] = map;
+		maps__maps_by_name(maps)[maps__nr_maps(maps) - 1] = map__get(map);
 		__maps__sort_by_name(maps);
 	}
  out:
@@ -126,9 +128,9 @@ void maps__remove(struct maps *maps, struct map *map)
 	rb_node = maps__find_node(maps, map);
 	assert(rb_node->map == map);
 	__maps__remove(maps, rb_node);
-	--maps->nr_maps;
 	if (maps__maps_by_name(maps))
 		__maps__free_maps_by_name(maps);
+	--maps->nr_maps;
 	up_write(maps__lock(maps));
 }
 
@@ -136,6 +138,9 @@ static void __maps__purge(struct maps *maps)
 {
 	struct map_rb_node *pos, *next;
 
+	if (maps__maps_by_name(maps))
+		__maps__free_maps_by_name(maps);
+
 	maps__for_each_entry_safe(maps, pos, next) {
 		rb_erase_init(&pos->rb_node,  maps__entries(maps));
 		map__put(pos->map);
@@ -293,7 +298,7 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 	}
 
 	next = first;
-	while (next) {
+	while (next && !err) {
 		struct map_rb_node *pos = rb_entry(next, struct map_rb_node, rb_node);
 		next = rb_next(&pos->rb_node);
 
@@ -331,8 +336,10 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 
 			before->end = map__start(map);
 			err = __maps__insert(maps, before);
-			if (err)
+			if (err) {
+				map__put(before);
 				goto put_map;
+			}
 
 			if (verbose >= 2 && !use_browser)
 				map__fprintf(before, fp);
@@ -352,22 +359,17 @@ int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 			assert(map__map_ip(pos->map, map__end(map)) ==
 				map__map_ip(after, map__end(map)));
 			err = __maps__insert(maps, after);
-			if (err)
+			if (err) {
+				map__put(after);
 				goto put_map;
-
+			}
 			if (verbose >= 2 && !use_browser)
 				map__fprintf(after, fp);
 			map__put(after);
 		}
 put_map:
 		map__put(pos->map);
-
-		if (err)
-			goto out;
 	}
-
-	err = 0;
-out:
 	up_write(maps__lock(maps));
 	return err;
 }
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index ec7a312e7cc1..7904bfff7d0e 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2052,10 +2052,23 @@ int dso__load(struct dso *dso, struct map *map)
 
 static int map__strcmp(const void *a, const void *b)
 {
-	const struct dso *dso_a = map__dso(*(const struct map **)a);
-	const struct dso *dso_b = map__dso(*(const struct map **)b);
+	const struct map *map_a = *(const struct map **)a;
+	const struct map *map_b = *(const struct map **)b;
+	const struct dso *dso_a = map__dso(map_a);
+	const struct dso *dso_b = map__dso(map_b);
+	int ret = strcmp(dso_a->short_name, dso_b->short_name);
 
-	return strcmp(dso_a->short_name, dso_b->short_name);
+	if (ret == 0 && map_a != map_b) {
+		/*
+		 * Ensure distinct but name equal maps have an order in part to
+		 * aid reference counting.
+		 */
+		ret = (int)map__start(map_a) - (int)map__start(map_b);
+		if (ret == 0)
+			ret = (int)((intptr_t)map_a - (intptr_t)map_b);
+	}
+
+	return ret;
 }
 
 static int map__strcmp_name(const void *name, const void *b)
@@ -2087,7 +2100,7 @@ static int map__groups__sort_by_name_from_rbtree(struct maps *maps)
 	maps->nr_maps_allocated = maps__nr_maps(maps);
 
 	maps__for_each_entry(maps, rb_node)
-		maps_by_name[i++] = rb_node->map;
+		maps_by_name[i++] = map__get(rb_node->map);
 
 	__maps__sort_by_name(maps);
 
-- 
2.40.0.rc1.284.g88254d51c5-goog

