Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D1B6D6E8F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 23:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236259AbjDDVBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 17:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235526AbjDDVBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 17:01:23 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7552D59CD
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 14:01:09 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id w5-20020a253005000000b00aedd4305ff2so33527363ybw.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 14:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680642068;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wj0zFnOGjLX2H2pqmjaN/TPZtFXQJuNwPwp/XDMzHTQ=;
        b=hiCSSAyFc3Fefg1mJbZzl8j/FKOnlkPpEXx19zp0ly1BZRc/R9T9iunS1w2QWke9uR
         QegPENGF+aNbgBtFN5ccAzQM/H0SdPUksuLqsb4DXGeJH2NO4BffynfHt5I7WGX53yxM
         hhpFZYh+qirjfk5ZMbSMkqb6Xq8esuRteAXydbB0K20KolVT/d2OmlATTGe5JYHHdn/4
         54kTcBj5o8fmek12N512sLdcRv4VAuhqwLbkkWCOxlczXiAiaqLjCJ3OCAM+/5Jd/AmL
         kQjdOuHqtVhq7/jRQ+1174d9KAvTWHbakVY49PeYYr0bXEatiy6a9mL2CN0N+PyIR4D/
         ZOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680642068;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wj0zFnOGjLX2H2pqmjaN/TPZtFXQJuNwPwp/XDMzHTQ=;
        b=Nw2GV6+8OLcZCMGxkvcZzYNsLcTN/n9t5gCj/+CfZbLH+yZ7Lf+LTQYxG+EqaN/wly
         D+NDAvUMF6Q7mz6JTfCu4WgbGikAsGZKzSUyXsvs/tz0oFgLE5JiPNdfMCLd2RSjHDhU
         btSHBkU2ZWN1I5TGTMCQQK6E98pykfER/+R1zGQakcFteO0dk48M0T3wZUwEtkEVjfQg
         sYQUL6ljzC+ftBl4KMAlR4l7GpJxDar9rSwj2uY8JjznU02TjFbbgh7h56Ky/Z7IVG7R
         YFsCMPIi3OToHqV5UluOuyebFhbYpKFo0CT42q+cWtSOEfCXyeQnMyXSxA2R4TZYNTio
         o9AA==
X-Gm-Message-State: AAQBX9dHGC9vgyW9qw7Y+8qvR/NHAFzTIxRrDtzGQj4woR9tRK7xgqeB
        DFSwlQVBPMCKrFBxq0OC9MVJc6pEJhNM
X-Google-Smtp-Source: AKy350ZcdHcdBTuvh0rSINk4xC5JyX/qIlqlYqW7u1+yruF7GiLKgVxMIlN1SDDSU7PcYPl1n2916BVQDBnD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a051:e074:d6f:dc29])
 (user=irogers job=sendgmr) by 2002:a25:74d7:0:b0:b6d:1483:bc0f with SMTP id
 p206-20020a2574d7000000b00b6d1483bc0fmr2366307ybc.9.1680642068274; Tue, 04
 Apr 2023 14:01:08 -0700 (PDT)
Date:   Tue,  4 Apr 2023 13:59:48 -0700
In-Reply-To: <20230404205954.2245628-1-irogers@google.com>
Message-Id: <20230404205954.2245628-7-irogers@google.com>
Mime-Version: 1.0
References: <20230404205954.2245628-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v6 06/12] perf maps: Modify maps_by_name to hold a reference
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
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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
index 0eee27e24c33..5afed53ea0b4 100644
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
index 7282119c2990..91ebf93e0c20 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2053,10 +2053,23 @@ int dso__load(struct dso *dso, struct map *map)
 
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
@@ -2088,7 +2101,7 @@ static int map__groups__sort_by_name_from_rbtree(struct maps *maps)
 	maps->nr_maps_allocated = maps__nr_maps(maps);
 
 	maps__for_each_entry(maps, rb_node)
-		maps_by_name[i++] = rb_node->map;
+		maps_by_name[i++] = map__get(rb_node->map);
 
 	__maps__sort_by_name(maps);
 
-- 
2.40.0.348.gf938b09366-goog

