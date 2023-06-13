Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A1372EAF2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 20:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjFMS0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 14:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbjFMS0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 14:26:41 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7571610CC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 11:26:38 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56fffdea2d0so946367b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 11:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686680797; x=1689272797;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WvMVfl1WbDxqaWJUP4jTOe+ztVEZmNwWPMXr+gZbHUE=;
        b=G39YdJ8wOdM1C69yLTN8U8l+iNpDIl3Id0EXeBecT65zG5PZZ2mXqaDwneqDVxK9Wz
         BPAudXpNDQHC7Qbu4ydbg1xt83/Y0vc5zeyQXEfnt1jodtn3sviJu2FfiILRPIUV6KUy
         jlE57YbOGwV6Y82Lj1lpyuGmLmxvRxRt6Vs4JBcaS9f4McaJTqXJMy8g1xcFpHXR8sd8
         d73bkaYS3fbsopqvO98U2Xbq7WfvKTvoOTjjgK2tAKl2aGJcexX432QAHJqnC9+H2DJc
         rXuIftkkWxYxubgqbRraziqH7Z6jkAwZKHHOR6tXWuueo+G6q/E8e56RXk9n4rbp/JQS
         O/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686680797; x=1689272797;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WvMVfl1WbDxqaWJUP4jTOe+ztVEZmNwWPMXr+gZbHUE=;
        b=YZ4p5K7epqdfULSAD34nvaNDIF3jOrhnkgTjGIVaVCWrgNVkgOSxai9DfQ3mK9o68w
         8MhMHnfSaK8g4YVUZ7hGawgnEY3wAQJ6A5mTWE3/G5JQv5KeK6IPbbPOfP8Cey/9Y7K2
         nJJfHIhM1pml1Z5Z/EWR8AqYqXsOrXfwoBABvebdBfn0T5bAdPagxk+gMzyzslx0PKaF
         82sO1dUK+upzEDGzYM3v3qB/AzgnveLN2jb7aTNNTJFOHA8CACTQcGe9un3LOefJglAx
         EY9NWOqk8KBf1Q+AsvAI8oxAD1DGI6UQvGv0W1fNCCN8V1rN45A+pCrrrX5r34QpFaYu
         S4DQ==
X-Gm-Message-State: AC+VfDy/SfZKBXog+mUt1835PyOnIZXQHBg3P7XzUFI+glrjNGOVHU97
        H4u4JEHFd6TRO8b5btPJe7PvOSgo+Eb7
X-Google-Smtp-Source: ACHHUZ5i6ml3ujak5mKh6Gh2Grqy408xn/nvtw8YEQKjViFjGcQWC+CTovKVHYcktruzNX4apdMyjTjctLv+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a704:56d6:f79d:33e7])
 (user=irogers job=sendgmr) by 2002:a05:6902:160b:b0:bcc:bc25:7296 with SMTP
 id bw11-20020a056902160b00b00bccbc257296mr13317ybb.9.1686680797759; Tue, 13
 Jun 2023 11:26:37 -0700 (PDT)
Date:   Tue, 13 Jun 2023 11:26:29 -0700
Message-Id: <20230613182629.1500317-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1] perf parse-events: Avoid string for PE_BP_COLON, PE_BP_SLASH
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
        Rob Herring <robh@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
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

There's no need to read the string ':' or '/' for PE_BP_COLON or
PE_BP_SLASH and doing so causes parse-events.y to leak memory.

The original patch has a committer note about not using these tokens
presumably as yacc spotted they were a memory leak because no
%destructor could be run. Remove the unused token workaround as there
is now no value associated with these tokens.

Fixes: f0617f526cb0 ("perf parse: Allow config terms with breakpoints")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.h | 4 ----
 tools/perf/util/parse-events.l | 4 ++--
 tools/perf/util/parse-events.y | 9 ---------
 3 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 5fdc1f33f57e..b0eb95f93e9c 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -228,10 +228,6 @@ void parse_events_error__handle(struct parse_events_error *err, int idx,
 void parse_events_error__print(struct parse_events_error *err,
 			       const char *event);
 
-static inline void parse_events_unused_value(const void *x __maybe_unused)
-{
-}
-
 #ifdef HAVE_LIBELF_SUPPORT
 /*
  * If the probe point starts with '%',
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 7629af3d5c7c..99335ec586ae 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -315,13 +315,13 @@ r0x{num_raw_hex}	{ return str(yyscanner, PE_RAW); }
 	 * are the same, so trailing context can be used disambiguate the two
 	 * cases.
 	 */
-":"/{modifier_bp}	{ return str(yyscanner, PE_BP_COLON); }
+":"/{modifier_bp}	{ return PE_BP_COLON; }
 	/*
 	 * The slash before memory length can get mixed up with the slash before
 	 * config terms. Fortunately config terms do not start with a numeric
 	 * digit, so trailing context can be used disambiguate the two cases.
 	 */
-"/"/{digit}		{ return str(yyscanner, PE_BP_SLASH); }
+"/"/{digit}		{ return PE_BP_SLASH; }
 "/"/{non_digit}		{ BEGIN(config); return '/'; }
 {num_dec}		{ return value(yyscanner, 10); }
 {num_hex}		{ return value(yyscanner, 16); }
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 0c3d086cc22a..9f28d4b5502f 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -80,8 +80,6 @@ static void free_list_evsel(struct list_head* list_evsel)
 %type <str> PE_LEGACY_CACHE
 %type <str> PE_MODIFIER_EVENT
 %type <str> PE_MODIFIER_BP
-%type <str> PE_BP_COLON
-%type <str> PE_BP_SLASH
 %type <str> PE_EVENT_NAME
 %type <str> PE_KERNEL_PMU_EVENT PE_PMU_EVENT_FAKE
 %type <str> PE_DRV_CFG_TERM
@@ -510,9 +508,6 @@ PE_PREFIX_MEM PE_VALUE PE_BP_SLASH PE_VALUE PE_BP_COLON PE_MODIFIER_BP opt_event
 	struct list_head *list;
 	int err;
 
-	parse_events_unused_value(&$3);
-	parse_events_unused_value(&$5);
-
 	list = alloc_list();
 	ABORT_ON(!list);
 	err = parse_events_add_breakpoint(_parse_state, list,
@@ -531,8 +526,6 @@ PE_PREFIX_MEM PE_VALUE PE_BP_SLASH PE_VALUE opt_event_config
 	struct list_head *list;
 	int err;
 
-	parse_events_unused_value(&$3);
-
 	list = alloc_list();
 	ABORT_ON(!list);
 	err = parse_events_add_breakpoint(_parse_state, list,
@@ -550,8 +543,6 @@ PE_PREFIX_MEM PE_VALUE PE_BP_COLON PE_MODIFIER_BP opt_event_config
 	struct list_head *list;
 	int err;
 
-	parse_events_unused_value(&$3);
-
 	list = alloc_list();
 	ABORT_ON(!list);
 	err = parse_events_add_breakpoint(_parse_state, list,
-- 
2.41.0.162.gfafddb0af9-goog

