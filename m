Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A126C238F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjCTVXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjCTVX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:23:28 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB31AD06
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:23:12 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5419fb7d6c7so133750327b3.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679347390;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HTn2hjAh9Nouc/rloylNMSTmI2V2EkvcDVrDtj6Buak=;
        b=ED4uu1cgrIA7/03LoG5QjbNozmLYwWmKk28oUbN/R7ZuqxeNQO1yCL08meB7mt5y/i
         2oysP80gCiauwPCKEIMwJdHihdsS/NFaInK7q880rjAqkPBJoQHqnEZr562MJGQuIfP+
         /QyEx6DFATCfUibw0/KV5P5LMKiFWkL5DdXFrbWiNiUcvIBobcaDQOgPrABTrKOOz2PH
         25CJhOvu0OYxDbZ+GA5d0NHtVaPJENTBKFME7g4Gh40j1FyKMyq17ylnFZUXlq1Z/wXJ
         rGDBiHNc6od9mxmSlhBQnK2w8NY6ERnbAMBPDIbOmq0kV5q+LJb6ILKM+bt/cXSmrwFx
         YUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679347390;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HTn2hjAh9Nouc/rloylNMSTmI2V2EkvcDVrDtj6Buak=;
        b=SLeHyZr4Bo+y05d9VmL1CA2TrkEK02+D+DFJVRRMWVHKWqy+O4hrASRKlHt4o9PaMG
         8lxbmiQMx4Tyhs0/jY1I4tVZ+m9C2PJ1InlZnr0kO69E8Xz1jZ2wRfqMJM0TyyYWA+Mc
         +dR4QQgno7VQviYPMvY7hBGFraaV1j+/fYbB7a6F8FZloL5C99cWiU+o9Qbco0U4EsXm
         GrZ5kjaMy0yveElDlSZQ8rZlZuUcV/sZqjXJfszozw5uw9DF6t8FPqLCYWuG/h76guQU
         cbg9ZxXh6mbVdT8ZP4HISv0J+lRKoL+ir7c2ZrpONQJ1IMggQsy/ZN9/4HP3bLSbHuCa
         MZzQ==
X-Gm-Message-State: AAQBX9fwdDkdruerO2LcfVAKQk5893vzasG4DaF9fR8hcO0KXZTJoQ8m
        Q7nCfIoNKX68WBX8Dl75QaBH7nJQNhzp
X-Google-Smtp-Source: AKy350a1BNEp7EjVeycZAHWABjXgUIRfgqyJiYf32UghqDdonZ8WFKIxrZ4GEUp1TwFz9RYbQ4THIqaczZcV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a30f:d1e2:fcd8:aa4d])
 (user=irogers job=sendgmr) by 2002:a25:9289:0:b0:a5f:0:bf12 with SMTP id
 y9-20020a259289000000b00a5f0000bf12mr389640ybl.13.1679347390628; Mon, 20 Mar
 2023 14:23:10 -0700 (PDT)
Date:   Mon, 20 Mar 2023 14:22:32 -0700
In-Reply-To: <20230320212248.1175731-1-irogers@google.com>
Message-Id: <20230320212248.1175731-2-irogers@google.com>
Mime-Version: 1.0
References: <20230320212248.1175731-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v5 01/17] perf map: Move map list node into symbol
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using a perf map as a list node is only done in symbol. Move the
list_node struct into symbol as a single pointer to the map. This
makes reference count behavior more obvious and easy to check.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/map.h    |  5 +--
 tools/perf/util/symbol.c | 93 ++++++++++++++++++++++++++--------------
 2 files changed, 63 insertions(+), 35 deletions(-)

diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 3dcfe06db6b3..2879cae05ee0 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -16,10 +16,7 @@ struct maps;
 struct machine;
 
 struct map {
-	union {
-		struct rb_node	rb_node;
-		struct list_head node;
-	};
+	struct rb_node		rb_node;
 	u64			start;
 	u64			end;
 	bool			erange_warned:1;
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index a458aa8b87bb..65e0c3d126f1 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -48,6 +48,11 @@ static bool symbol__is_idle(const char *name);
 int vmlinux_path__nr_entries;
 char **vmlinux_path;
 
+struct map_list_node {
+	struct list_head node;
+	struct map *map;
+};
+
 struct symbol_conf symbol_conf = {
 	.nanosecs		= false,
 	.use_modules		= true,
@@ -85,6 +90,11 @@ static enum dso_binary_type binary_type_symtab[] = {
 
 #define DSO_BINARY_TYPE__SYMTAB_CNT ARRAY_SIZE(binary_type_symtab)
 
+static struct map_list_node *map_list_node__new(void)
+{
+	return malloc(sizeof(struct map_list_node));
+}
+
 static bool symbol_type__filter(char symbol_type)
 {
 	symbol_type = toupper(symbol_type);
@@ -1219,16 +1229,21 @@ struct kcore_mapfn_data {
 static int kcore_mapfn(u64 start, u64 len, u64 pgoff, void *data)
 {
 	struct kcore_mapfn_data *md = data;
-	struct map *map;
+	struct map_list_node *list_node = map_list_node__new();
 
-	map = map__new2(start, md->dso);
-	if (map == NULL)
+	if (!list_node)
 		return -ENOMEM;
 
-	map->end = map->start + len;
-	map->pgoff = pgoff;
+	list_node->map = map__new2(start, md->dso);
+	if (!list_node->map) {
+		free(list_node);
+		return -ENOMEM;
+	}
+
+	list_node->map->end = list_node->map->start + len;
+	list_node->map->pgoff = pgoff;
 
-	list_add(&map->node, &md->maps);
+	list_add(&list_node->node, &md->maps);
 
 	return 0;
 }
@@ -1264,12 +1279,18 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
 				 * |new.............| -> |new..|       |new..|
 				 *       |old....|    ->       |old....|
 				 */
-				struct map *m = map__clone(new_map);
+				struct map_list_node *m = map_list_node__new();
 
 				if (!m)
 					return -ENOMEM;
 
-				m->end = old_map->start;
+				m->map = map__clone(new_map);
+				if (!m->map) {
+					free(m);
+					return -ENOMEM;
+				}
+
+				m->map->end = old_map->start;
 				list_add_tail(&m->node, &merged);
 				new_map->pgoff += old_map->end - new_map->start;
 				new_map->start = old_map->end;
@@ -1299,10 +1320,13 @@ int maps__merge_in(struct maps *kmaps, struct map *new_map)
 	}
 
 	while (!list_empty(&merged)) {
-		old_map = list_entry(merged.next, struct map, node);
-		list_del_init(&old_map->node);
-		maps__insert(kmaps, old_map);
-		map__put(old_map);
+		struct map_list_node *old_node;
+
+		old_node = list_entry(merged.next, struct map_list_node, node);
+		list_del_init(&old_node->node);
+		maps__insert(kmaps, old_node->map);
+		map__put(old_node->map);
+		free(old_node);
 	}
 
 	if (new_map) {
@@ -1317,7 +1341,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 {
 	struct maps *kmaps = map__kmaps(map);
 	struct kcore_mapfn_data md;
-	struct map *old_map, *new_map, *replacement_map = NULL, *next;
+	struct map *old_map, *replacement_map = NULL, *next;
 	struct machine *machine;
 	bool is_64_bit;
 	int err, fd;
@@ -1378,11 +1402,12 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 	/* Find the kernel map using the '_stext' symbol */
 	if (!kallsyms__get_function_start(kallsyms_filename, "_stext", &stext)) {
 		u64 replacement_size = 0;
+		struct map_list_node *new_node;
 
-		list_for_each_entry(new_map, &md.maps, node) {
-			u64 new_size = new_map->end - new_map->start;
+		list_for_each_entry(new_node, &md.maps, node) {
+			u64 new_size = new_node->map->end - new_node->map->start;
 
-			if (!(stext >= new_map->start && stext < new_map->end))
+			if (!(stext >= new_node->map->start && stext < new_node->map->end))
 				continue;
 
 			/*
@@ -1392,40 +1417,43 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 			 * falls within more than one in the list.
 			 */
 			if (!replacement_map || new_size < replacement_size) {
-				replacement_map = new_map;
+				replacement_map = new_node->map;
 				replacement_size = new_size;
 			}
 		}
 	}
 
 	if (!replacement_map)
-		replacement_map = list_entry(md.maps.next, struct map, node);
+		replacement_map = list_entry(md.maps.next, struct map_list_node, node)->map;
 
 	/* Add new maps */
 	while (!list_empty(&md.maps)) {
-		new_map = list_entry(md.maps.next, struct map, node);
-		list_del_init(&new_map->node);
-		if (new_map == replacement_map) {
-			map->start	= new_map->start;
-			map->end	= new_map->end;
-			map->pgoff	= new_map->pgoff;
-			map->map_ip	= new_map->map_ip;
-			map->unmap_ip	= new_map->unmap_ip;
+		struct map_list_node *new_node;
+
+		new_node = list_entry(md.maps.next, struct map_list_node, node);
+		list_del_init(&new_node->node);
+		if (new_node->map == replacement_map) {
+			map->start	= new_node->map->start;
+			map->end	= new_node->map->end;
+			map->pgoff	= new_node->map->pgoff;
+			map->map_ip	= new_node->map->map_ip;
+			map->unmap_ip	= new_node->map->unmap_ip;
 			/* Ensure maps are correctly ordered */
 			map__get(map);
 			maps__remove(kmaps, map);
 			maps__insert(kmaps, map);
 			map__put(map);
-			map__put(new_map);
+			map__put(new_node->map);
 		} else {
 			/*
 			 * Merge kcore map into existing maps,
 			 * and ensure that current maps (eBPF)
 			 * stay intact.
 			 */
-			if (maps__merge_in(kmaps, new_map))
+			if (maps__merge_in(kmaps, new_node->map))
 				goto out_err;
 		}
+		free(new_node);
 	}
 
 	if (machine__is(machine, "x86_64")) {
@@ -1462,9 +1490,12 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 
 out_err:
 	while (!list_empty(&md.maps)) {
-		map = list_entry(md.maps.next, struct map, node);
-		list_del_init(&map->node);
-		map__put(map);
+		struct map_list_node *list_node;
+
+		list_node = list_entry(md.maps.next, struct map_list_node, node);
+		list_del_init(&list_node->node);
+		map__put(list_node->map);
+		free(list_node);
 	}
 	close(fd);
 	return -EINVAL;
-- 
2.40.0.rc1.284.g88254d51c5-goog

