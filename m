Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A9F717F01
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 13:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbjEaLv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 07:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235311AbjEaLvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 07:51:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603B810B
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 04:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685533834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=25yV48GzrN5JRrbcRZVzMDMeJIhkLtz0P43vLbvVHR0=;
        b=AyHnH6TzWO6Mrkl78DDF+rL4gHLC8kDnQub3GANaGtUwAtkuTq9xsvWJI7ukuKFq+cV0EX
        Jq7sc3MqcP3kKdZU+gE9JuODFxMFcqaIEzXIRGAGDdmRzs6wWC8ofhGtWHljt4o4HU4rp8
        EjeE+REL+I4BufAe24iAO1CZCYVD3uY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-cgkqOGKTMNS5dIdK6VMiuQ-1; Wed, 31 May 2023 07:50:33 -0400
X-MC-Unique: cgkqOGKTMNS5dIdK6VMiuQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D812E3C0CEF7;
        Wed, 31 May 2023 11:50:32 +0000 (UTC)
Received: from samus.usersys.redhat.com (unknown [10.43.17.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 475D840CFD45;
        Wed, 31 May 2023 11:50:31 +0000 (UTC)
From:   Artem Savkov <asavkov@redhat.com>
To:     linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, Artem Savkov <asavkov@redhat.com>
Subject: [PATCH 2/2] perf tools: allow running annotation browser from c2c-report
Date:   Wed, 31 May 2023 13:50:14 +0200
Message-Id: <20230531115014.161454-3-asavkov@redhat.com>
In-Reply-To: <20230531115014.161454-1-asavkov@redhat.com>
References: <20230531115014.161454-1-asavkov@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a shortcut to run annotation browser for selected symbol from
c2c report TUI.

Signed-off-by: Artem Savkov <asavkov@redhat.com>
---
 tools/perf/builtin-c2c.c | 76 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 71 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 05dfd98af170b..96e66289c2576 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -19,11 +19,13 @@
 #include <linux/zalloc.h>
 #include <asm/bug.h>
 #include <sys/param.h>
+#include <sys/ttydefaults.h>
 #include "debug.h"
 #include "builtin.h"
 #include <perf/cpumap.h>
 #include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
+#include "map.h"
 #include "map_symbol.h"
 #include "mem-events.h"
 #include "session.h"
@@ -43,6 +45,8 @@
 #include "ui/progress.h"
 #include "pmus.h"
 #include "string2.h"
+#include "util/annotate.h"
+#include "util/dso.h"
 #include "util/util.h"
 
 struct c2c_hists {
@@ -79,6 +83,7 @@ struct c2c_hist_entry {
 	 * because of its callchain dynamic entry
 	 */
 	struct hist_entry	he;
+	struct evsel		*evsel;
 };
 
 static char const *coalesce_default = "iaddr";
@@ -111,6 +116,8 @@ struct perf_c2c {
 	char			*cl_sort;
 	char			*cl_resort;
 	char			*cl_output;
+
+	struct annotation_options annotation_opts;
 };
 
 enum {
@@ -326,7 +333,12 @@ static int process_sample_event(struct perf_tool *tool __maybe_unused,
 	c2c_he__set_cpu(c2c_he, sample);
 	c2c_he__set_node(c2c_he, sample);
 
+	c2c_he->evsel = evsel;
+
 	hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
+	if (use_browser == 1 && al.map != NULL && al.sym != NULL) {
+		hist_entry__inc_addr_samples(he, sample, c2c_he->evsel, al.addr);
+	}
 	ret = hist_entry__append_callchain(he, sample);
 
 	if (!ret) {
@@ -363,7 +375,12 @@ static int process_sample_event(struct perf_tool *tool __maybe_unused,
 		c2c_he__set_cpu(c2c_he, sample);
 		c2c_he__set_node(c2c_he, sample);
 
+		c2c_he->evsel = evsel;
+
 		hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
+		if (use_browser == 1 && al.map != NULL && al.sym != NULL) {
+			hist_entry__inc_addr_samples(he, sample, c2c_he->evsel, al.addr);
+		}
 		ret = hist_entry__append_callchain(he, sample);
 	}
 
@@ -2618,9 +2635,12 @@ static int perf_c2c__browse_cacheline(struct hist_entry *he)
 	struct c2c_hists *c2c_hists;
 	struct c2c_cacheline_browser *cl_browser;
 	struct hist_browser *browser;
+	struct map_symbol ms = { NULL, NULL, NULL };
+	int err = 0;
 	int key = -1;
 	static const char help[] =
 	" ENTER         Toggle callchains (if present) \n"
+	" a             Annotate current symbol\n"
 	" n             Toggle Node details info \n"
 	" s             Toggle full length of symbol and source line columns \n"
 	" q             Return back to cacheline list \n";
@@ -2650,6 +2670,44 @@ static int perf_c2c__browse_cacheline(struct hist_entry *he)
 		key = hist_browser__run(browser, "? - help", true, 0);
 
 		switch (key) {
+		case 'a':
+			if (!browser->selection ||
+			    !browser->selection->map ||
+			    !browser->selection->map->dso ||
+			    browser->selection->map->dso->annotate_warned) {
+				continue;
+			}
+
+			ms.map = browser->selection->map;
+
+			if (!browser->selection->sym) {
+				if (!browser->he_selection)
+					continue;
+
+				ms.sym = symbol__new_unresolved(browser->he_selection->ip,
+								browser->selection->map);
+
+				if (!ms.sym)
+					continue;
+			} else {
+				if (symbol__annotation(browser->selection->sym)->src == NULL) {
+					ui_browser__warning(&browser->b, 0,
+						"No samples for the \"%s\" symbol.\n\n",
+						browser->selection->sym->name);
+					continue;
+				}
+				ms.sym = browser->selection->sym;
+			}
+
+			err = map_symbol__tui_annotate(&ms, c2c_he->evsel, browser->hbt, &c2c.annotation_opts);
+
+			ui_browser__update_nr_entries(&browser->b, browser->hists->nr_entries);
+			if ((err == 'q' || err == CTRL('c')) && browser->he_selection->branch_info)
+					continue;
+			if (err)
+				ui_browser__handle_resize(&browser->b);
+
+			continue;
 		case 's':
 			c2c.symbol_full = !c2c.symbol_full;
 			break;
@@ -3045,6 +3103,10 @@ static int perf_c2c__report(int argc, const char **argv)
 	int err = 0;
 	const char *output_str, *sort_str = NULL;
 
+	annotation_options__init(&c2c.annotation_opts);
+
+	hists__init();
+
 	argc = parse_options(argc, argv, options, report_c2c_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 	if (argc)
@@ -3118,6 +3180,14 @@ static int perf_c2c__report(int argc, const char **argv)
 	if (err)
 		goto out_mem2node;
 
+	if (c2c.use_stdio) {
+		use_browser = 0;
+	} else {
+		use_browser = 1;
+		symbol__annotation_init();
+		annotation_config__init(&c2c.annotation_opts);
+	}
+
 	if (symbol__init(&session->header.env) < 0)
 		goto out_mem2node;
 
@@ -3127,11 +3197,6 @@ static int perf_c2c__report(int argc, const char **argv)
 		goto out_mem2node;
 	}
 
-	if (c2c.use_stdio)
-		use_browser = 0;
-	else
-		use_browser = 1;
-
 	setup_browser(false);
 
 	err = perf_session__process_events(session);
@@ -3202,6 +3267,7 @@ static int perf_c2c__report(int argc, const char **argv)
 out_session:
 	perf_session__delete(session);
 out:
+	annotation_options__init(&c2c.annotation_opts);
 	return err;
 }
 
-- 
2.40.1

