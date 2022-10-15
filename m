Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6775FF935
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 10:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiJOIvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 04:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiJOIvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 04:51:42 -0400
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DF65464E;
        Sat, 15 Oct 2022 01:51:39 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 9CB44C01F; Sat, 15 Oct 2022 10:51:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1665823898; bh=fPtKzKbWRupedizWDLTiPtPdKS0iGBNll/UA6bu7PnE=;
        h=From:To:Cc:Subject:Date:From;
        b=jLAHJ8eyaxbT41DMkMenvsQhq0m5JonyrOVu+2xp3ZjqCrEF8CsFabjwpSVWmKfvJ
         D6Da3CsDmLsjrln/M7h654VBkv4sh2WNte96AlVsz80NsXp6pKWTamnTicGXXKu65y
         oRWQVEix5wJ0N8jhBMBVSBIrCB72/gXfUV/3Rfayu3ARDRw0NvhUEcEUwIowgzTsQl
         Rso3WlTLPyvKJEKsiTwQryhDlzcv8TGRwMxKQhsQZqVnd7uSA+tZcJPbBHFB08YI1Y
         S9vBKxtp20ZukvJ5k8rT1HXMWKeDYOcP7gQ+PRBT1mdFgAexbc1ZNcNlGPIzUd699E
         TE5EXG8k8oVGA==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 71009C009;
        Sat, 15 Oct 2022 10:51:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1665823896; bh=fPtKzKbWRupedizWDLTiPtPdKS0iGBNll/UA6bu7PnE=;
        h=From:To:Cc:Subject:Date:From;
        b=siOWoZQO2YqbCXK0rvmThv/LcePzUU1/gCRJdvHh9ounEvcSBPrS525uTb9e5zjiO
         x6pqZFPpt5f9jPXuBox7WUBtGyydHpc7UYoHYZlJNPzy58bT0oqHM+sPcfGjMstT9N
         oVW5RFcAiN8lkgs304NWNz3Sq7bdDW6vMIVIvNudKyv9BPrG1aNnC9R1QB4Y+bCTLZ
         /M5Q05XlNUwVdgnnmvKOGtMdaTu+EtVVNJDCdtPNj567FI/sf7G86K9/lupUbSEYfH
         RzZtzgSVQPPaNQb0pZZtJsnM/hFRixLgJNp5ashXilqCRw/FRiCFuPBKZLoAYdwWbQ
         C9fu2+UjKLLeA==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 1331e84e;
        Sat, 15 Oct 2022 08:51:29 +0000 (UTC)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 1/3] perf parse-events: pass parse_state to add_tracepoint
Date:   Sat, 15 Oct 2022 17:48:10 +0900
Message-Id: <20221015084810.2114158-1-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a noop refactoring: instead of passing the index argument to
various add tracepoint functions pass the event parse state directly.

Next commit will add an extra parameter to parse_state that will be
used.

Link: https://lore.kernel.org/all/YsGduWiTvkM2/tHv@krava/
Co-authored-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
This is the first half of the diff Jiri sent in the mail linked above,
in preparation to add a 9p probe test that would only work if 9p module
is loaded without this.

Jiri, not sure if that is the split you had in mind? but it sort of made
sense to me, so I went with that.
Please ask if you were thinking of something else.

I also didn't change anything else here (except for a minor rebase
conflict for patch 2), so happy to demote myself and put you as main
author or anything you want; I don't care for commit count.


 tools/perf/util/parse-events.c | 31 ++++++++++++++++++-------------
 tools/perf/util/parse-events.h |  3 ++-
 tools/perf/util/parse-events.y |  2 +-
 3 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 437389dacf48..aa06be9583a2 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -472,12 +472,13 @@ static void tracepoint_error(struct parse_events_error *e, int err,
 	parse_events_error__handle(e, 0, strdup(str), strdup(help));
 }
 
-static int add_tracepoint(struct list_head *list, int *idx,
+static int add_tracepoint(struct parse_events_state *parse_state,
+			  struct list_head *list,
 			  const char *sys_name, const char *evt_name,
 			  struct parse_events_error *err,
 			  struct list_head *head_config)
 {
-	struct evsel *evsel = evsel__newtp_idx(sys_name, evt_name, (*idx)++);
+	struct evsel *evsel = evsel__newtp_idx(sys_name, evt_name, parse_state->idx++);
 
 	if (IS_ERR(evsel)) {
 		tracepoint_error(err, PTR_ERR(evsel), sys_name, evt_name);
@@ -496,7 +497,8 @@ static int add_tracepoint(struct list_head *list, int *idx,
 	return 0;
 }
 
-static int add_tracepoint_multi_event(struct list_head *list, int *idx,
+static int add_tracepoint_multi_event(struct parse_events_state *parse_state,
+				      struct list_head *list,
 				      const char *sys_name, const char *evt_name,
 				      struct parse_events_error *err,
 				      struct list_head *head_config)
@@ -530,7 +532,7 @@ static int add_tracepoint_multi_event(struct list_head *list, int *idx,
 
 		found++;
 
-		ret = add_tracepoint(list, idx, sys_name, evt_ent->d_name,
+		ret = add_tracepoint(parse_state, list, sys_name, evt_ent->d_name,
 				     err, head_config);
 	}
 
@@ -544,19 +546,21 @@ static int add_tracepoint_multi_event(struct list_head *list, int *idx,
 	return ret;
 }
 
-static int add_tracepoint_event(struct list_head *list, int *idx,
+static int add_tracepoint_event(struct parse_events_state *parse_state,
+				struct list_head *list,
 				const char *sys_name, const char *evt_name,
 				struct parse_events_error *err,
 				struct list_head *head_config)
 {
 	return strpbrk(evt_name, "*?") ?
-	       add_tracepoint_multi_event(list, idx, sys_name, evt_name,
+	       add_tracepoint_multi_event(parse_state, list, sys_name, evt_name,
 					  err, head_config) :
-	       add_tracepoint(list, idx, sys_name, evt_name,
+	       add_tracepoint(parse_state, list, sys_name, evt_name,
 			      err, head_config);
 }
 
-static int add_tracepoint_multi_sys(struct list_head *list, int *idx,
+static int add_tracepoint_multi_sys(struct parse_events_state *parse_state,
+				    struct list_head *list,
 				    const char *sys_name, const char *evt_name,
 				    struct parse_events_error *err,
 				    struct list_head *head_config)
@@ -582,7 +586,7 @@ static int add_tracepoint_multi_sys(struct list_head *list, int *idx,
 		if (!strglobmatch(events_ent->d_name, sys_name))
 			continue;
 
-		ret = add_tracepoint_event(list, idx, events_ent->d_name,
+		ret = add_tracepoint_event(parse_state, list, events_ent->d_name,
 					   evt_name, err, head_config);
 	}
 
@@ -619,7 +623,7 @@ static int add_bpf_event(const char *group, const char *event, int fd, struct bp
 	pr_debug("add bpf event %s:%s and attach bpf program %d\n",
 		 group, event, fd);
 
-	err = parse_events_add_tracepoint(&new_evsels, &parse_state->idx, group,
+	err = parse_events_add_tracepoint(parse_state, &new_evsels, group,
 					  event, parse_state->error,
 					  param->head_config);
 	if (err) {
@@ -1316,7 +1320,8 @@ static int get_config_chgs(struct perf_pmu *pmu, struct list_head *head_config,
 	return 0;
 }
 
-int parse_events_add_tracepoint(struct list_head *list, int *idx,
+int parse_events_add_tracepoint(struct parse_events_state *parse_state,
+				struct list_head *list,
 				const char *sys, const char *event,
 				struct parse_events_error *err,
 				struct list_head *head_config)
@@ -1330,10 +1335,10 @@ int parse_events_add_tracepoint(struct list_head *list, int *idx,
 	}
 
 	if (strpbrk(sys, "*?"))
-		return add_tracepoint_multi_sys(list, idx, sys, event,
+		return add_tracepoint_multi_sys(parse_state, list, sys, event,
 						err, head_config);
 	else
-		return add_tracepoint_event(list, idx, sys, event,
+		return add_tracepoint_event(parse_state, list, sys, event,
 					    err, head_config);
 }
 
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 07df7bb7b042..c6606638d8cf 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -152,7 +152,8 @@ void parse_events__clear_array(struct parse_events_array *a);
 int parse_events__modifier_event(struct list_head *list, char *str, bool add);
 int parse_events__modifier_group(struct list_head *list, char *event_mod);
 int parse_events_name(struct list_head *list, const char *name);
-int parse_events_add_tracepoint(struct list_head *list, int *idx,
+int parse_events_add_tracepoint(struct parse_events_state *parse_state,
+				struct list_head *list,
 				const char *sys, const char *event,
 				struct parse_events_error *error,
 				struct list_head *head_config);
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index be8c51770051..83ccbf433482 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -625,7 +625,7 @@ tracepoint_name opt_event_config
 	if (error)
 		error->idx = @1.first_column;
 
-	err = parse_events_add_tracepoint(list, &parse_state->idx, $1.sys, $1.event,
+	err = parse_events_add_tracepoint(parse_state, list, $1.sys, $1.event,
 					error, $2);
 
 	parse_events_terms__delete($2);
-- 
2.37.3

