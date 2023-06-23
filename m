Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC21673AF6F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 06:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjFWEbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 00:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjFWEbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 00:31:14 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C6E2129
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 21:31:12 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bf34588085bso382730276.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 21:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687494672; x=1690086672;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cu9nI31LEpqxG6RFF3bTH+0H9TeY5MTdZFgwWUSRFwU=;
        b=HDdKa5vorjtsTOrpdZyZbORmZaBWBLRNFyZz+mquVo87kCprIyIN8sJdGBbNPkAExV
         lZsOFohZIZYXcx+EOi3cnPYVBgXSwuRwX+NN2SyjBHY+dZhlbeFPbvDTcrUYvX4iDgND
         B/3N4GkPcRdJSTv8PAv+Ayi/kJFAETG/ktcG0BK1ipSkvvzQwQdd9b4hO+HNvdy4HHj0
         QLMcbKt6YfIiTauaZuaOdy+BOR0vdfzOvUEXZzzZahsNRBWHTIK9DqfXmbpg8xvTmNEC
         ggmowdUOKFgOlKsPkUOx4gckl6EE1Qrlwe5LqX69IpEeV9d2LTWQE8ayD2XjjG87s6cJ
         dCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687494672; x=1690086672;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cu9nI31LEpqxG6RFF3bTH+0H9TeY5MTdZFgwWUSRFwU=;
        b=eB70em7hr52/lZR8aISPZ/IRTxxVCipb3JKqcmUC7V2Art3NnOsXoM9nz5KTNvhDwP
         yZSb3REx+mwK8mCZqboErcXHDtiAW0O9ivu5oSBf4w/T1tpsZ/KZAJMp+057vAiWGCTv
         /PdlLv17O91w/jVA2zS3HxgtzNFo/Y3WnqBSApb/F5+NSUHuxkJxSDGDWSieRLbTOUQX
         j118zYW0NAnsJkSpLI2KBybfrdILSeJGLkoips3QD404vwRlvzyRjrsOKyIYxtKT/tYA
         +ZO1bOgrHEw0dIv+ghg6xwlbJCoQEIrbW3q/bkG2Bpb2OqQ0zP26xBMsyTZ+xu2YnE4j
         cFZg==
X-Gm-Message-State: AC+VfDyeCzrK+gZynNkrmqc61HjNfmAW37PlOajWFOY96y6yFbRRBauf
        gvbMKpP5EH4SNHlRf0sEyllyMk2Xcx0q
X-Google-Smtp-Source: ACHHUZ6Y8LjAHTkZi3zCabhg5Vde/FZX17mb7veqsintqlySiJ99zT4N14uiAb3OID4t2IMOa5kNVv3SNJgR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6559:8968:cdfe:35b6])
 (user=irogers job=sendgmr) by 2002:a25:ab28:0:b0:bc5:2869:d735 with SMTP id
 u37-20020a25ab28000000b00bc52869d735mr8255983ybi.13.1687494671922; Thu, 22
 Jun 2023 21:31:11 -0700 (PDT)
Date:   Thu, 22 Jun 2023 21:31:07 -0700
Message-Id: <20230623043107.4077510-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2] perf unwind: Fix map reference counts
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
        Ivan Babrou <ivan@cloudflare.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The result of thread__find_map is the map in the passed in
addr_location. Calling addr_location__exit puts that map and so copies
need to do a map__get. Add in the corresponding map__puts.

Signed-off-by: Ian Rogers <irogers@google.com>

v2. Add missing map__put when dso is missing.
---
 tools/perf/util/unwind-libunwind-local.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 36bf5100bad2..ebfde537b99b 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -419,7 +419,8 @@ static struct map *find_map(unw_word_t ip, struct unwind_info *ui)
 	struct map *ret;
 
 	addr_location__init(&al);
-	ret = thread__find_map(ui->thread, PERF_RECORD_MISC_USER, ip, &al);
+	thread__find_map(ui->thread, PERF_RECORD_MISC_USER, ip, &al);
+	ret = map__get(al.map);
 	addr_location__exit(&al);
 	return ret;
 }
@@ -440,8 +441,10 @@ find_proc_info(unw_addr_space_t as, unw_word_t ip, unw_proc_info_t *pi,
 		return -EINVAL;
 
 	dso = map__dso(map);
-	if (!dso)
+	if (!dso) {
+		map__put(map);
 		return -EINVAL;
+	}
 
 	pr_debug("unwind: find_proc_info dso %s\n", dso->name);
 
@@ -476,11 +479,11 @@ find_proc_info(unw_addr_space_t as, unw_word_t ip, unw_proc_info_t *pi,
 
 		memset(&di, 0, sizeof(di));
 		if (dwarf_find_debug_frame(0, &di, ip, base, symfile, start, map__end(map)))
-			return dwarf_search_unwind_table(as, ip, &di, pi,
-							 need_unwind_info, arg);
+			ret = dwarf_search_unwind_table(as, ip, &di, pi,
+							need_unwind_info, arg);
 	}
 #endif
-
+	map__put(map);
 	return ret;
 }
 
@@ -534,12 +537,14 @@ static int access_dso_mem(struct unwind_info *ui, unw_word_t addr,
 
 	dso = map__dso(map);
 
-	if (!dso)
+	if (!dso) {
+		map__put(map);
 		return -1;
+	}
 
 	size = dso__data_read_addr(dso, map, ui->machine,
 				   addr, (u8 *) data, sizeof(*data));
-
+	map__put(map);
 	return !(size == sizeof(*data));
 }
 
-- 
2.41.0.162.gfafddb0af9-goog

