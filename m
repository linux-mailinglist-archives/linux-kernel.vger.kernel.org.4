Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB236C096E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 04:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjCTDmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 23:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjCTDl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 23:41:57 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7226231F7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 20:40:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 204-20020a2514d5000000b00a3637aea9e1so11875700ybu.17
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 20:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679283643;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sc0UoT/sOrVoOx3FR0aFOvpKiVJitcdLEI81kwZKe/g=;
        b=UmEP33hr/jPyu0yNNb2qGf4hbSQTq8fi6dIbd1w65AkitadLNWgAFBRVIskw3bUef5
         tFNkH4yIg0GKr/pw4/15xpiZJQRWK5WcFRNxnsPD6wAnYlqn3OVLLeCoruhZK5BI7PpI
         CAgb8lADRB3PIShqAqa7B79AAM9QNvkuQ1Tz32gZo6EWNKQnRiusj/RVG42LM17H64bU
         0Z39e1rhWe3JlBYvgJZl40GeBH4Z820ZTt7XS3nMiuL27ybtNFUGzkPDujBIfssPEKb9
         6fZPy9qmNeQHPylel43XezvOWOAjy6iGTKTLLxaM+9VcQ21jjJ5bi11fBnOmxPWN+HZ4
         v4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679283643;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sc0UoT/sOrVoOx3FR0aFOvpKiVJitcdLEI81kwZKe/g=;
        b=Aet8x4wpDKV4oKtxXecrYGHthIPMC+1CqdZh0zRIkqn4e0lV/ldojaO8i5QH5VGT96
         8x+6WuUD4JaknTK5zm/39Ql8/3u/66qP9AHKCbN8NGymqqBQMwwwrv/UUVqqhRz6Y8zq
         YShrcZUtMIdvfXp8KkSBzdBpg8tjSUsBbpemxKby2bTYG+e0aZRmii332uNEyVdA7DyZ
         hPqS48D6N86K6NTh4bRMF+Qq1ZbVMfevmEHrWNWoYqTZIkG3MMVZu9todFER9D8WxtoR
         qzX+pM3v0eGZYif+V/2cGs0Y32kv7d8tv5mKedWFZI+9dkuCVo+iBzj1O5puEzsi2jw2
         tX4w==
X-Gm-Message-State: AO0yUKX4p4dqsSvG8o1HDC/0bK3iNToLZFkIMXDeE6e2AJhND1gUGA9r
        3h8Esi1KXihn6i8rmpFLpsA5lIjv7ck+
X-Google-Smtp-Source: AK7set8rIGJCJcTTopzK8gDqrWUi43rxBiQxYsPlBLHZMzFHhN/bfigSuXEcRY8MK2r/URicHWHJMXIbvOtn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:1895:9fa0:27f5:cb71])
 (user=irogers job=sendgmr) by 2002:a5b:711:0:b0:a42:1dd7:6fc7 with SMTP id
 g17-20020a5b0711000000b00a421dd76fc7mr4398820ybq.11.1679283642774; Sun, 19
 Mar 2023 20:40:42 -0700 (PDT)
Date:   Sun, 19 Mar 2023 20:38:04 -0700
In-Reply-To: <20230320033810.980165-1-irogers@google.com>
Message-Id: <20230320033810.980165-17-irogers@google.com>
Mime-Version: 1.0
References: <20230320033810.980165-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v4 16/22] perf maps: Modify maps_by_name to hold a reference
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
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@collabora.com>,
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
index 0431c328f4d6..1f4c23052a54 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2049,10 +2049,23 @@ int dso__load(struct dso *dso, struct map *map)
 
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
@@ -2084,7 +2097,7 @@ static int map__groups__sort_by_name_from_rbtree(struct maps *maps)
 	maps->nr_maps_allocated = maps__nr_maps(maps);
 
 	maps__for_each_entry(maps, rb_node)
-		maps_by_name[i++] = rb_node->map;
+		maps_by_name[i++] = map__get(rb_node->map);
 
 	__maps__sort_by_name(maps);
 
-- 
2.40.0.rc1.284.g88254d51c5-goog

