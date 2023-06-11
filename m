Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286F772B09F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 09:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbjFKH2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 03:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbjFKH17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 03:27:59 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4F2B2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 00:27:58 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56d1d3726a2so1957897b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 00:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686468477; x=1689060477;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XsobhHP4TT4FYszQpT6KcQr5X8Uh2ycHvLaNzS1NXUU=;
        b=ANaywSsA2O3GF7p/PPSYqlzdyw8+wxOaFWdm2bpj3jgUwXpuWbSKvG7smNO9gyj8Z0
         dB2v+dJO4MfCfxqX7GrY9J48NJDlVbxwtA1KkcZChJW5XNv0oPqpoh1aDyEGLgk48wJv
         AxqLUUkyJHCWbkbWDvRuX9ZcPqPGWepL7iTR9OqCA5RQQUZCGhMrBpI5nCKsbm5B2J4P
         GCcZhWSXgeXLPyOmp6yC8Pv3dKYmhYNiX/thKCQK8PeYj6bzTw4c8GDLmTIh/c2mLmSV
         qL+KaY9pBAAgzEjWAsUR+5/C+g8uRMDG+nKexoLgpBAz7KGNNpvsOXVNYl3iJmSDet+u
         6LkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686468477; x=1689060477;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XsobhHP4TT4FYszQpT6KcQr5X8Uh2ycHvLaNzS1NXUU=;
        b=GyElwuu0rrh9sGyFOqCaW4NjDqihx3AX+QiaE5y0a301uhIo/c1xP2lZp7M2nxzm9q
         wMusaO2Xxppzmn9+FygROyz3w+CJ/+vYmouUaMUrL16hDj9wc8tpnXa8MnlUvj1pt+6C
         LTzTdqH1yOHfnmiXABBrPHpjKC6EINnddPwmhTIbASHAalv9+uSnhUNVr9/LvpOWWYAA
         mnBq1/x2NbLD+smpEg9/DPed3O7d7YAIVnQit1PUHcSpl2beGsiFglDSYN4zk1Aa4fhe
         YnpDCdF5+SHwPt8eYqE4UACQLSFhF5aJwMqoFum4Y3JY6lN/QQFFLHJoYqurIFxyyyZR
         jmzg==
X-Gm-Message-State: AC+VfDx0WD2behsvV0xELxmfadC3znTFlSWOOdl2ZC4TXwknc9uLv3k5
        qP5qIaZQdYFuQHpv4CYbfcHuQ5NaKLa1
X-Google-Smtp-Source: ACHHUZ622mEHWQffL3YUe9F73Cz/TO68VKtkkBi51cr3pk0ZuRf/TiE0ktL9yPKxIrvV76/GBSgnCdMhrSau
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:737b:2b94:75b5:9fb7])
 (user=irogers job=sendgmr) by 2002:a05:6902:1085:b0:ba8:337a:d8a3 with SMTP
 id v5-20020a056902108500b00ba8337ad8a3mr3327852ybu.11.1686468477622; Sun, 11
 Jun 2023 00:27:57 -0700 (PDT)
Date:   Sun, 11 Jun 2023 00:27:50 -0700
In-Reply-To: <20230611072751.637227-1-irogers@google.com>
Message-Id: <20230611072751.637227-2-irogers@google.com>
Mime-Version: 1.0
References: <20230611072751.637227-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 2/2] perf annotation: Switch lock from a mutex to a sharded_mutex
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
        Yuan Can <yuancan@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Andres Freund <andres@anarazel.de>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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

Remove the "struct mutex lock" variable from annotation that is
allocated per symbol. This removes in the region of 40 bytes per
symbol allocation. Use a sharded mutex where the number of shards is
set to the number of CPUs. Assuming good hashing of the annotation
(done based on the pointer), this means in order to contend there
needs to be more threads than CPUs, which is not currently true in any
perf command. Were contention an issue it is straightforward to
increase the number of shards in the mutex.

On my Debian/glibc based machine, this reduces the size of struct
annotation from 136 bytes to 96 bytes, or nearly 30%.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-top.c          | 14 +++----
 tools/perf/ui/browsers/annotate.c | 10 ++---
 tools/perf/util/annotate.c        | 66 ++++++++++++++++++++++++++-----
 tools/perf/util/annotate.h        | 11 ++++--
 4 files changed, 77 insertions(+), 24 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index c363c04e16df..1baa2acb3ced 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -137,10 +137,10 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 	}
 
 	notes = symbol__annotation(sym);
-	mutex_lock(&notes->lock);
+	annotation__lock(notes);
 
 	if (!symbol__hists(sym, top->evlist->core.nr_entries)) {
-		mutex_unlock(&notes->lock);
+		annotation__unlock(notes);
 		pr_err("Not enough memory for annotating '%s' symbol!\n",
 		       sym->name);
 		sleep(1);
@@ -156,7 +156,7 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 		pr_err("Couldn't annotate %s: %s\n", sym->name, msg);
 	}
 
-	mutex_unlock(&notes->lock);
+	annotation__unlock(notes);
 	return err;
 }
 
@@ -211,12 +211,12 @@ static void perf_top__record_precise_ip(struct perf_top *top,
 
 	notes = symbol__annotation(sym);
 
-	if (!mutex_trylock(&notes->lock))
+	if (!annotation__trylock(notes))
 		return;
 
 	err = hist_entry__inc_addr_samples(he, sample, evsel, ip);
 
-	mutex_unlock(&notes->lock);
+	annotation__unlock(notes);
 
 	if (unlikely(err)) {
 		/*
@@ -253,7 +253,7 @@ static void perf_top__show_details(struct perf_top *top)
 	symbol = he->ms.sym;
 	notes = symbol__annotation(symbol);
 
-	mutex_lock(&notes->lock);
+	annotation__lock(notes);
 
 	symbol__calc_percent(symbol, evsel);
 
@@ -274,7 +274,7 @@ static void perf_top__show_details(struct perf_top *top)
 	if (more != 0)
 		printf("%d lines not displayed, maybe increase display entries [e]\n", more);
 out_unlock:
-	mutex_unlock(&notes->lock);
+	annotation__unlock(notes);
 }
 
 static void perf_top__resort_hists(struct perf_top *t)
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 70bad42b807b..ccdb2cd11fbf 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -314,7 +314,7 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 
 	browser->entries = RB_ROOT;
 
-	mutex_lock(&notes->lock);
+	annotation__lock(notes);
 
 	symbol__calc_percent(sym, evsel);
 
@@ -343,7 +343,7 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 		}
 		disasm_rb_tree__insert(browser, &pos->al);
 	}
-	mutex_unlock(&notes->lock);
+	annotation__unlock(notes);
 
 	browser->curr_hot = rb_last(&browser->entries);
 }
@@ -470,10 +470,10 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
 	}
 
 	notes = symbol__annotation(dl->ops.target.sym);
-	mutex_lock(&notes->lock);
+	annotation__lock(notes);
 
 	if (!symbol__hists(dl->ops.target.sym, evsel->evlist->core.nr_entries)) {
-		mutex_unlock(&notes->lock);
+		annotation__unlock(notes);
 		ui__warning("Not enough memory for annotating '%s' symbol!\n",
 			    dl->ops.target.sym->name);
 		return true;
@@ -482,7 +482,7 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
 	target_ms.maps = ms->maps;
 	target_ms.map = ms->map;
 	target_ms.sym = dl->ops.target.sym;
-	mutex_unlock(&notes->lock);
+	annotation__unlock(notes);
 	symbol__tui_annotate(&target_ms, evsel, hbt, browser->opts);
 	sym_title(ms->sym, ms->map, title, sizeof(title), browser->opts->percent_type);
 	ui_browser__show_title(&browser->b, title);
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index bde890cfa620..310dde7b3419 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -32,6 +32,7 @@
 #include "block-range.h"
 #include "string2.h"
 #include "util/event.h"
+#include "util/sharded_mutex.h"
 #include "arch/common.h"
 #include "namespaces.h"
 #include <regex.h>
@@ -856,7 +857,7 @@ void symbol__annotate_zero_histograms(struct symbol *sym)
 {
 	struct annotation *notes = symbol__annotation(sym);
 
-	mutex_lock(&notes->lock);
+	annotation__lock(notes);
 	if (notes->src != NULL) {
 		memset(notes->src->histograms, 0,
 		       notes->src->nr_histograms * notes->src->sizeof_sym_hist);
@@ -864,7 +865,7 @@ void symbol__annotate_zero_histograms(struct symbol *sym)
 			memset(notes->src->cycles_hist, 0,
 				symbol__size(sym) * sizeof(struct cyc_hist));
 	}
-	mutex_unlock(&notes->lock);
+	annotation__unlock(notes);
 }
 
 static int __symbol__account_cycles(struct cyc_hist *ch,
@@ -1121,7 +1122,7 @@ void annotation__compute_ipc(struct annotation *notes, size_t size)
 	notes->hit_insn = 0;
 	notes->cover_insn = 0;
 
-	mutex_lock(&notes->lock);
+	annotation__lock(notes);
 	for (offset = size - 1; offset >= 0; --offset) {
 		struct cyc_hist *ch;
 
@@ -1140,7 +1141,7 @@ void annotation__compute_ipc(struct annotation *notes, size_t size)
 			notes->have_cycles = true;
 		}
 	}
-	mutex_unlock(&notes->lock);
+	annotation__unlock(notes);
 }
 
 int addr_map_symbol__inc_samples(struct addr_map_symbol *ams, struct perf_sample *sample,
@@ -1291,17 +1292,64 @@ int disasm_line__scnprintf(struct disasm_line *dl, char *bf, size_t size, bool r
 	return ins__scnprintf(&dl->ins, bf, size, &dl->ops, max_ins_name);
 }
 
-void annotation__init(struct annotation *notes)
+void annotation__exit(struct annotation *notes)
 {
-	mutex_init(&notes->lock);
+	annotated_source__delete(notes->src);
 }
 
-void annotation__exit(struct annotation *notes)
+static struct sharded_mutex *sharded_mutex;
+
+static void annotation__init_sharded_mutex(void)
 {
-	annotated_source__delete(notes->src);
-	mutex_destroy(&notes->lock);
+	/* As many mutexes as there are CPUs. */
+	sharded_mutex = sharded_mutex__new(cpu__max_present_cpu().cpu);
+}
+
+static size_t annotation__hash(const struct annotation *notes)
+{
+	return ((size_t)notes) >> 4;
 }
 
+static struct mutex *annotation__get_mutex(const struct annotation *notes)
+{
+	static pthread_once_t once = PTHREAD_ONCE_INIT;
+
+	pthread_once(&once, annotation__init_sharded_mutex);
+	if (!sharded_mutex)
+		return NULL;
+
+	return sharded_mutex__get_mutex(sharded_mutex, annotation__hash(notes));
+}
+
+void annotation__lock(struct annotation *notes)
+	NO_THREAD_SAFETY_ANALYSIS
+{
+	struct mutex *mutex = annotation__get_mutex(notes);
+
+	if (mutex)
+		mutex_lock(mutex);
+}
+
+void annotation__unlock(struct annotation *notes)
+	NO_THREAD_SAFETY_ANALYSIS
+{
+	struct mutex *mutex = annotation__get_mutex(notes);
+
+	if (mutex)
+		mutex_unlock(mutex);
+}
+
+bool annotation__trylock(struct annotation *notes)
+{
+	struct mutex *mutex = annotation__get_mutex(notes);
+
+	if (!mutex)
+		return false;
+
+	return mutex_trylock(mutex);
+}
+
+
 static void annotation_line__add(struct annotation_line *al, struct list_head *head)
 {
 	list_add_tail(&al->node, head);
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 1c6335b8333a..962780559176 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -271,8 +271,7 @@ struct annotated_source {
 	struct sym_hist	   *histograms;
 };
 
-struct annotation {
-	struct mutex lock;
+struct LOCKABLE annotation {
 	u64			max_coverage;
 	u64			start;
 	u64			hit_cycles;
@@ -298,9 +297,15 @@ struct annotation {
 	struct annotated_source *src;
 };
 
-void annotation__init(struct annotation *notes);
+static inline void annotation__init(struct annotation *notes __maybe_unused)
+{
+}
 void annotation__exit(struct annotation *notes);
 
+void annotation__lock(struct annotation *notes) EXCLUSIVE_LOCK_FUNCTION(*notes);
+void annotation__unlock(struct annotation *notes) UNLOCK_FUNCTION(*notes);
+bool annotation__trylock(struct annotation *notes) EXCLUSIVE_TRYLOCK_FUNCTION(true, *notes);
+
 static inline int annotation__cycles_width(struct annotation *notes)
 {
 	if (notes->have_cycles && notes->options->show_minmax_cycle)
-- 
2.41.0.162.gfafddb0af9-goog

