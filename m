Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034C073B03A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 07:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjFWFpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 01:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbjFWFpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 01:45:33 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52DE1BD6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 22:45:30 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bc9483b506fso421590276.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 22:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687499130; x=1690091130;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3jas64HUjV3HJVDpG17XD7Hv9DQQ04m+xOZqxowPnBU=;
        b=r8whqJkm2R1MKMzPQBrgIQCKEaP0WpOaAdnkeqUKSg/X4I7zrDJTqjOmxTm9Xnpe1D
         lpPmQ0ca/vk6yU+UBHiwr3mbdXptWsJVqUb5ElS7dTXLmNmKS/57yKg08rQrQXfQu2S+
         y9GMBHxRI5YOfl3nf9sEGKqeyeUuxyEiHGYjQD+mDDpnP7McoHx04KLpV8HT5EvMoFsU
         EQiLNM3yBRz02WW6mOYJJ9YbOLENwDY+uMXmov5tU/mmRkiWwbHsnB6cyixIJQRpXXIm
         4e2zW79wy+ftgUFKCSpT1hpknMYOY0VRezni747C37DB4RiVo+hPPaMpJxaN5x5akvZo
         d2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687499130; x=1690091130;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3jas64HUjV3HJVDpG17XD7Hv9DQQ04m+xOZqxowPnBU=;
        b=iK2mmHIHd9qMi3Rviu+n55TcNPAoSPmS/UALugNE2FzsebX7f/oQk/TX2qAiQFViVS
         KYaaDTnqcRx1loljfn/Z5JC3mQh/xg5bjAPZOLXAxP+Po3A7qI7/0I5e+hCVPDYZMRL1
         0m7Ov6asFhV1oIefqpXgrHPxoANBAtG2QSKwo0MdkEF318/QxAvVJecwb4i6aXQ92VsX
         i9ljsHRS7d+KjOt1YKhFOoX4CdCWDbzHSlQwX/Ak/3SZbS29Fxuq8tlpC+pXE6ldJf+p
         lqiPqUDMSe63AELoYxe63OsQC1LOULRstspbl8JYeHhn22B9sudKlDGsMhdGvYVHeC9P
         BNFg==
X-Gm-Message-State: AC+VfDwxbhUdwsaBNxDYa0Imrkltp9qqdgrBTPKUUASs2YgOkcQPFDMg
        oeYPtF3cNInlXO59Fbyn/lYWJ/H2VjKX
X-Google-Smtp-Source: ACHHUZ7PxKGpDh+cAgtWjhbs5+R0xSk07CNx1+Z6p+gtOaUPvG98LV21Brim5zMD8FRl3CH4m8+elo5LKP/M
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6559:8968:cdfe:35b6])
 (user=irogers job=sendgmr) by 2002:a05:6902:1363:b0:bea:918f:2ef6 with SMTP
 id bt3-20020a056902136300b00bea918f2ef6mr2933550ybb.0.1687499130012; Thu, 22
 Jun 2023 22:45:30 -0700 (PDT)
Date:   Thu, 22 Jun 2023 22:45:19 -0700
In-Reply-To: <20230623054520.4118442-1-irogers@google.com>
Message-Id: <20230623054520.4118442-3-irogers@google.com>
Mime-Version: 1.0
References: <20230623054520.4118442-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v3 2/3] perf symbol: Remove symbol_name_rb_node
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jason Wang <wangborong@cdjrlc.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most perf commands want to sort symbols by name and this is done via
an invasive rbtree that on 64-bit systems costs 24 bytes. Sorting the
symbols in a DSO by name is optional and not done by default, however,
if sorting is requested the 24 bytes is allocated for every
symbol.

This change removes the rbtree and uses a sorted array of symbol
pointers instead (costing 8 bytes per symbol). As the array is created
on demand then there are further memory savings. The complexity of
sorting the array and using the rbtree are the same.

To support going to the next symbol, the index of the current symbol
needs to be passed around as a pair with the current symbol. This
requires some API changes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.c            |   7 +-
 tools/perf/util/dso.h            |   3 +-
 tools/perf/util/map.c            |  11 ++-
 tools/perf/util/map.h            |  12 +--
 tools/perf/util/probe-event.c    |  15 ++--
 tools/perf/util/symbol.c         | 127 ++++++++++++++++---------------
 tools/perf/util/symbol.h         |  12 +--
 tools/perf/util/symbol_fprintf.c |  10 +--
 8 files changed, 101 insertions(+), 96 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 046fbfcfdaab..bdfead36b83a 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1320,7 +1320,9 @@ struct dso *dso__new_id(const char *name, struct dso_id *id)
 			dso->id = *id;
 		dso__set_long_name_id(dso, dso->name, id, false);
 		dso__set_short_name(dso, dso->name, false);
-		dso->symbols = dso->symbol_names = RB_ROOT_CACHED;
+		dso->symbols = RB_ROOT_CACHED;
+		dso->symbol_names = NULL;
+		dso->symbol_names_len = 0;
 		dso->data.cache = RB_ROOT;
 		dso->inlined_nodes = RB_ROOT_CACHED;
 		dso->srclines = RB_ROOT_CACHED;
@@ -1364,7 +1366,8 @@ void dso__delete(struct dso *dso)
 	inlines__tree_delete(&dso->inlined_nodes);
 	srcline__tree_delete(&dso->srclines);
 	symbols__delete(&dso->symbols);
-
+	dso->symbol_names_len = 0;
+	zfree(&dso->symbol_names);
 	if (dso->short_name_allocated) {
 		zfree((char **)&dso->short_name);
 		dso->short_name_allocated = false;
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index b23a157c914d..b41c9782c754 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -150,7 +150,8 @@ struct dso {
 	struct rb_node	 rb_node;	/* rbtree node sorted by long name */
 	struct rb_root	 *root;		/* root of rbtree that rb_node is in */
 	struct rb_root_cached symbols;
-	struct rb_root_cached symbol_names;
+	struct symbol	 **symbol_names;
+	size_t		 symbol_names_len;
 	struct rb_root_cached inlined_nodes;
 	struct rb_root_cached srclines;
 	struct {
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index a45708289cc6..f64b83004421 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -390,7 +390,7 @@ struct symbol *map__find_symbol(struct map *map, u64 addr)
 	return dso__find_symbol(map__dso(map), addr);
 }
 
-struct symbol *map__find_symbol_by_name(struct map *map, const char *name)
+struct symbol *map__find_symbol_by_name_idx(struct map *map, const char *name, size_t *idx)
 {
 	struct dso *dso;
 
@@ -400,7 +400,14 @@ struct symbol *map__find_symbol_by_name(struct map *map, const char *name)
 	dso = map__dso(map);
 	dso__sort_by_name(dso);
 
-	return dso__find_symbol_by_name(dso, name);
+	return dso__find_symbol_by_name(dso, name, idx);
+}
+
+struct symbol *map__find_symbol_by_name(struct map *map, const char *name)
+{
+	size_t idx;
+
+	return map__find_symbol_by_name_idx(map, name, &idx);
 }
 
 struct map *map__clone(struct map *from)
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 66a87b3d9965..1b53d53adc86 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -148,16 +148,17 @@ struct thread;
  * @map: the 'struct map *' in which symbols are iterated
  * @sym_name: the symbol name
  * @pos: the 'struct symbol *' to use as a loop cursor
+ * @idx: the cursor index in the symbol names array
  */
-#define __map__for_each_symbol_by_name(map, sym_name, pos)	\
-	for (pos = map__find_symbol_by_name(map, sym_name);	\
+#define __map__for_each_symbol_by_name(map, sym_name, pos, idx)		\
+	for (pos = map__find_symbol_by_name_idx(map, sym_name, &idx);	\
 	     pos &&						\
 	     !symbol__match_symbol_name(pos->name, sym_name,	\
 					SYMBOL_TAG_INCLUDE__DEFAULT_ONLY); \
-	     pos = symbol__next_by_name(pos))
+	     pos = dso__next_symbol_by_name(map__dso(map), &idx))
 
-#define map__for_each_symbol_by_name(map, sym_name, pos)		\
-	__map__for_each_symbol_by_name(map, sym_name, (pos))
+#define map__for_each_symbol_by_name(map, sym_name, pos, idx)	\
+	__map__for_each_symbol_by_name(map, sym_name, (pos), idx)
 
 void map__init(struct map *map,
 	       u64 start, u64 end, u64 pgoff, struct dso *dso);
@@ -202,6 +203,7 @@ int map__fprintf_srcline(struct map *map, u64 addr, const char *prefix,
 int map__load(struct map *map);
 struct symbol *map__find_symbol(struct map *map, u64 addr);
 struct symbol *map__find_symbol_by_name(struct map *map, const char *name);
+struct symbol *map__find_symbol_by_name_idx(struct map *map, const char *name, size_t *idx);
 void map__fixup_start(struct map *map);
 void map__fixup_end(struct map *map);
 
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 6e2110d605fb..277cb8f84cbc 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -382,6 +382,7 @@ static int find_alternative_probe_point(struct debuginfo *dinfo,
 	struct symbol *sym;
 	u64 address = 0;
 	int ret = -ENOENT;
+	size_t idx;
 
 	/* This can work only for function-name based one */
 	if (!pp->function || pp->file)
@@ -392,7 +393,7 @@ static int find_alternative_probe_point(struct debuginfo *dinfo,
 		return -EINVAL;
 
 	/* Find the address of given function */
-	map__for_each_symbol_by_name(map, pp->function, sym) {
+	map__for_each_symbol_by_name(map, pp->function, sym, idx) {
 		if (uprobes) {
 			address = sym->start;
 			if (sym->type == STT_GNU_IFUNC)
@@ -3738,7 +3739,6 @@ int del_perf_probe_events(struct strfilter *filter)
 int show_available_funcs(const char *target, struct nsinfo *nsi,
 			 struct strfilter *_filter, bool user)
 {
-        struct rb_node *nd;
 	struct map *map;
 	struct dso *dso;
 	int ret;
@@ -3767,17 +3767,16 @@ int show_available_funcs(const char *target, struct nsinfo *nsi,
 		goto end;
 	}
 	dso = map__dso(map);
-	if (!dso__sorted_by_name(dso))
-		dso__sort_by_name(dso);
+	dso__sort_by_name(dso);
 
 	/* Show all (filtered) symbols */
 	setup_pager();
 
-	for (nd = rb_first_cached(&dso->symbol_names); nd; nd = rb_next(nd)) {
-		struct symbol_name_rb_node *pos = rb_entry(nd, struct symbol_name_rb_node, rb_node);
+	for (size_t i = 0; i < dso->symbol_names_len; i++) {
+		struct symbol *pos = dso->symbol_names[i];
 
-		if (strfilter__compare(_filter, pos->sym.name))
-			printf("%s\n", pos->sym.name);
+		if (strfilter__compare(_filter, pos->name))
+			printf("%s\n", pos->name);
 	}
 end:
 	map__put(map);
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index bb02047e1c59..04bf77519179 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -440,38 +440,34 @@ static struct symbol *symbols__next(struct symbol *sym)
 	return NULL;
 }
 
-static void symbols__insert_by_name(struct rb_root_cached *symbols, struct symbol *sym)
+static int symbols__sort_name_cmp(const void *vlhs, const void *vrhs)
 {
-	struct rb_node **p = &symbols->rb_root.rb_node;
-	struct rb_node *parent = NULL;
-	struct symbol_name_rb_node *symn, *s;
-	bool leftmost = true;
+	const struct symbol *lhs = *((const struct symbol **)vlhs);
+	const struct symbol *rhs = *((const struct symbol **)vrhs);
 
-	symn = container_of(sym, struct symbol_name_rb_node, sym);
-
-	while (*p != NULL) {
-		parent = *p;
-		s = rb_entry(parent, struct symbol_name_rb_node, rb_node);
-		if (strcmp(sym->name, s->sym.name) < 0)
-			p = &(*p)->rb_left;
-		else {
-			p = &(*p)->rb_right;
-			leftmost = false;
-		}
-	}
-	rb_link_node(&symn->rb_node, parent, p);
-	rb_insert_color_cached(&symn->rb_node, symbols, leftmost);
+	return strcmp(lhs->name, rhs->name);
 }
 
-static void symbols__sort_by_name(struct rb_root_cached *symbols,
-				  struct rb_root_cached *source)
+static struct symbol **symbols__sort_by_name(struct rb_root_cached *source, size_t *len)
 {
-	struct rb_node *nd;
+	struct symbol **result;
+	size_t i = 0, size = 0;
 
-	for (nd = rb_first_cached(source); nd; nd = rb_next(nd)) {
+	for (struct rb_node *nd = rb_first_cached(source); nd; nd = rb_next(nd))
+		size++;
+
+	result = malloc(sizeof(*result) * size);
+	if (!result)
+		return NULL;
+
+	for (struct rb_node *nd = rb_first_cached(source); nd; nd = rb_next(nd)) {
 		struct symbol *pos = rb_entry(nd, struct symbol, rb_node);
-		symbols__insert_by_name(symbols, pos);
+
+		result[i++] = pos;
 	}
+	qsort(result, size, sizeof(*result), symbols__sort_name_cmp);
+	*len = size;
+	return result;
 }
 
 int symbol__match_symbol_name(const char *name, const char *str,
@@ -491,48 +487,51 @@ int symbol__match_symbol_name(const char *name, const char *str,
 		return arch__compare_symbol_names(name, str);
 }
 
-static struct symbol *symbols__find_by_name(struct rb_root_cached *symbols,
+static struct symbol *symbols__find_by_name(struct symbol *symbols[],
+					    size_t symbols_len,
 					    const char *name,
-					    enum symbol_tag_include includes)
+					    enum symbol_tag_include includes,
+					    size_t *found_idx)
 {
-	struct rb_node *n;
-	struct symbol_name_rb_node *s = NULL;
+	size_t i, lower = 0, upper = symbols_len;
+	struct symbol *s;
 
-	if (symbols == NULL)
+	if (!symbols_len)
 		return NULL;
 
-	n = symbols->rb_root.rb_node;
-
-	while (n) {
+	while (lower < upper) {
 		int cmp;
 
-		s = rb_entry(n, struct symbol_name_rb_node, rb_node);
-		cmp = symbol__match_symbol_name(s->sym.name, name, includes);
+		i = (lower + upper) / 2;
+		s = symbols[i];
+		cmp = symbol__match_symbol_name(s->name, name, includes);
 
 		if (cmp > 0)
-			n = n->rb_left;
+			upper = i;
 		else if (cmp < 0)
-			n = n->rb_right;
-		else
+			lower = i + 1;
+		else {
+			if (found_idx)
+				*found_idx = i;
 			break;
+		}
 	}
-
-	if (n == NULL)
-		return NULL;
-
-	if (includes != SYMBOL_TAG_INCLUDE__DEFAULT_ONLY)
+	if (includes != SYMBOL_TAG_INCLUDE__DEFAULT_ONLY) {
 		/* return first symbol that has same name (if any) */
-		for (n = rb_prev(n); n; n = rb_prev(n)) {
-			struct symbol_name_rb_node *tmp;
+		for (; i > 0; i--) {
+			struct symbol *tmp = symbols[i - 1];
 
-			tmp = rb_entry(n, struct symbol_name_rb_node, rb_node);
-			if (arch__compare_symbol_names(tmp->sym.name, s->sym.name))
+			if (!arch__compare_symbol_names(tmp->name, s->name)) {
+				if (found_idx)
+					*found_idx = i - 1;
+			} else
 				break;
 
 			s = tmp;
 		}
-
-	return &s->sym;
+	}
+	assert(!found_idx || s == symbols[*found_idx]);
+	return s;
 }
 
 void dso__reset_find_symbol_cache(struct dso *dso)
@@ -590,24 +589,25 @@ struct symbol *dso__next_symbol(struct symbol *sym)
 	return symbols__next(sym);
 }
 
-struct symbol *symbol__next_by_name(struct symbol *sym)
+struct symbol *dso__next_symbol_by_name(struct dso *dso, size_t *idx)
 {
-	struct symbol_name_rb_node *s = container_of(sym, struct symbol_name_rb_node, sym);
-	struct rb_node *n = rb_next(&s->rb_node);
+	if (*idx + 1 >= dso->symbol_names_len)
+		return NULL;
 
-	return n ? &rb_entry(n, struct symbol_name_rb_node, rb_node)->sym : NULL;
+	++*idx;
+	return dso->symbol_names[*idx];
 }
 
  /*
   * Returns first symbol that matched with @name.
   */
-struct symbol *dso__find_symbol_by_name(struct dso *dso, const char *name)
+struct symbol *dso__find_symbol_by_name(struct dso *dso, const char *name, size_t *idx)
 {
-	struct symbol *s = symbols__find_by_name(&dso->symbol_names, name,
-						 SYMBOL_TAG_INCLUDE__NONE);
+	struct symbol *s = symbols__find_by_name(dso->symbol_names, dso->symbol_names_len,
+						name, SYMBOL_TAG_INCLUDE__NONE, idx);
 	if (!s)
-		s = symbols__find_by_name(&dso->symbol_names, name,
-					  SYMBOL_TAG_INCLUDE__DEFAULT_ONLY);
+		s = symbols__find_by_name(dso->symbol_names, dso->symbol_names_len,
+					name, SYMBOL_TAG_INCLUDE__DEFAULT_ONLY, idx);
 	return s;
 }
 
@@ -615,8 +615,13 @@ void dso__sort_by_name(struct dso *dso)
 {
 	mutex_lock(&dso->lock);
 	if (!dso__sorted_by_name(dso)) {
-		symbols__sort_by_name(&dso->symbol_names, &dso->symbols);
-		dso__set_sorted_by_name(dso);
+		size_t len;
+
+		dso->symbol_names = symbols__sort_by_name(&dso->symbols, &len);
+		if (dso->symbol_names) {
+			dso->symbol_names_len = len;
+			dso__set_sorted_by_name(dso);
+		}
 	}
 	mutex_unlock(&dso->lock);
 }
@@ -2660,10 +2665,6 @@ int symbol__init(struct perf_env *env)
 
 	symbol__elf_init();
 
-	if (symbol_conf.sort_by_name)
-		symbol_conf.priv_size += (sizeof(struct symbol_name_rb_node) -
-					  sizeof(struct symbol));
-
 	if (symbol_conf.try_vmlinux_path && vmlinux_path__init(env) < 0)
 		return -1;
 
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 5ca8665dd2c1..af87c46b3f89 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -43,8 +43,7 @@ Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
 
 /**
  * A symtab entry. When allocated this may be preceded by an annotation (see
- * symbol__annotation), a browser_index (see symbol__browser_index) and rb_node
- * to sort by name (see struct symbol_name_rb_node).
+ * symbol__annotation) and/or a browser_index (see symbol__browser_index).
  */
 struct symbol {
 	struct rb_node	rb_node;
@@ -95,11 +94,6 @@ static inline size_t symbol__size(const struct symbol *sym)
 struct strlist;
 struct intlist;
 
-struct symbol_name_rb_node {
-	struct rb_node	rb_node;
-	struct symbol	sym;
-};
-
 static inline int __symbol__join_symfs(char *bf, size_t size, const char *path)
 {
 	return path__join(bf, size, symbol_conf.symfs, path);
@@ -136,9 +130,9 @@ void dso__delete_symbol(struct dso *dso,
 
 struct symbol *dso__find_symbol(struct dso *dso, u64 addr);
 struct symbol *dso__find_symbol_nocache(struct dso *dso, u64 addr);
-struct symbol *dso__find_symbol_by_name(struct dso *dso, const char *name);
 
-struct symbol *symbol__next_by_name(struct symbol *sym);
+struct symbol *dso__next_symbol_by_name(struct dso *dso, size_t *idx);
+struct symbol *dso__find_symbol_by_name(struct dso *dso, const char *name, size_t *idx);
 
 struct symbol *dso__first_symbol(struct dso *dso);
 struct symbol *dso__last_symbol(struct dso *dso);
diff --git a/tools/perf/util/symbol_fprintf.c b/tools/perf/util/symbol_fprintf.c
index d9e5ad040b6a..088f4abf230f 100644
--- a/tools/perf/util/symbol_fprintf.c
+++ b/tools/perf/util/symbol_fprintf.c
@@ -63,13 +63,11 @@ size_t dso__fprintf_symbols_by_name(struct dso *dso,
 				    FILE *fp)
 {
 	size_t ret = 0;
-	struct rb_node *nd;
-	struct symbol_name_rb_node *pos;
 
-	for (nd = rb_first_cached(&dso->symbol_names); nd; nd = rb_next(nd)) {
-		pos = rb_entry(nd, struct symbol_name_rb_node, rb_node);
-		ret += fprintf(fp, "%s\n", pos->sym.name);
-	}
+	for (size_t i = 0; i < dso->symbol_names_len; i++) {
+		struct symbol *pos = dso->symbol_names[i];
 
+		ret += fprintf(fp, "%s\n", pos->name);
+	}
 	return ret;
 }
-- 
2.41.0.162.gfafddb0af9-goog

