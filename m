Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F746D4ED1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 19:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjDCRUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 13:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbjDCRUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:20:43 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F95113
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 10:20:41 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id h8-20020a654688000000b0050fa9ced8e3so8624147pgr.18
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 10:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680542441;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vx2EyZDMjlrb24p+eE6gF383dd6AN/BW3JHvFyB6a7M=;
        b=tdC69fVTXHytRukvvYKb1yfECkl50VkcLqMKdSEOj0E/YOjzox6qloC0ctcwe6mOpT
         VWoiyEMml1zo42mGmvWLjgxaXBrFM4yD9ZcidQUO+AzqxrENFRN/1G3dkckWRX1fR1qe
         DN28rP8gQRfeiRY0g+8/vlAHKINLYeT1Prj7DWWpSl7duX9i5eV+R62x20jwedk7qDG2
         QbQbMe2P6xY8XI77FEe+EAYpCAVl0ZlnQnf7DXe1Tdlpg3+xg/EAWuBzVtKTGC2NNR0N
         Fy9gtmbwzfCDMyE5xwmm9oDf6qCAey1xIdRrNYnsGMqmUD3rb5eJrbtPZib/vvETo2th
         W39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680542441;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vx2EyZDMjlrb24p+eE6gF383dd6AN/BW3JHvFyB6a7M=;
        b=na6GW52Ky3XzAh1Yg7zPGGe/Bi7gO42nlzXQ0NDTl0XVbuXN1fcaF2V2JwhNnQJk1L
         9ER2HnXeoGuekkPcWAEMS9u2fFSSKmT3eni876JREB9FcpbhyySUgtcI9qql/xjRKzrr
         R0WLnQlDG/YEOnBKjo/Ax9+EbpDJJzsqujMJ0JlhuvWKUKmRO5biwAE/UbyRuKtazXiD
         Ria0mGmjDxjQc/5/7CoTFAz6BpglbRZaPZW+SVLxQwqne1BGfh/S74pikPTcJ1H5SQCp
         LlLj9FPXwoJiHAwHewqtRf3/aiPsYwgoVsqY/2kpKN3Hmpti8psu3ZEOnNhNZvLae9iJ
         JdaA==
X-Gm-Message-State: AAQBX9eSutQrsAsn5IGjVXlrBYWoZxcNZS5R8+4ZbLLGlbgsePjcnn2v
        a7VC/y0pv1YdMV5B9z32uPgm5LIR7JYh
X-Google-Smtp-Source: AKy350aS27RBMmT0lgRBP5b00cEYuDyFtR8unUb+blHuPGKBr5whFKcmWPyOfMF5jmU3rSq4Y6dTfNjBvb/i
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:9dc:a977:817d:341])
 (user=irogers job=sendgmr) by 2002:a17:903:2615:b0:1a0:561c:7276 with SMTP id
 jd21-20020a170903261500b001a0561c7276mr12856737plb.1.1680542441383; Mon, 03
 Apr 2023 10:20:41 -0700 (PDT)
Date:   Mon,  3 Apr 2023 10:20:31 -0700
Message-Id: <20230403172031.1759781-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v1] perf pmu: Make parser reentrant
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
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        German Gomez <german.gomez@arm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

By default bison uses global state for compatibility with yacc. Make
the parser reentrant so that it may be used in asynchronous and
multithreaded situations.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 17 ++++++++++++-----
 tools/perf/util/pmu.h |  2 +-
 tools/perf/util/pmu.l | 17 ++++++++++++-----
 tools/perf/util/pmu.y |  5 ++++-
 4 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index e3aae731bd6f..8ef2532428a4 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -24,6 +24,8 @@
 #include "evsel.h"
 #include "pmu.h"
 #include "pmus.h"
+#include "pmu-bison.h"
+#include "pmu-flex.h"
 #include "parse-events.h"
 #include "print-events.h"
 #include "header.h"
@@ -57,9 +59,6 @@ struct perf_pmu_format {
 	struct list_head list;
 };
 
-int perf_pmu_parse(struct list_head *list, char *name);
-extern FILE *perf_pmu_in;
-
 static bool hybrid_scanned;
 
 /*
@@ -79,6 +78,7 @@ int perf_pmu__format_parse(char *dir, struct list_head *head)
 	while (!ret && (evt_ent = readdir(format_dir))) {
 		char path[PATH_MAX];
 		char *name = evt_ent->d_name;
+		void *scanner;
 		FILE *file;
 
 		if (!strcmp(name, ".") || !strcmp(name, ".."))
@@ -91,8 +91,15 @@ int perf_pmu__format_parse(char *dir, struct list_head *head)
 		if (!file)
 			break;
 
-		perf_pmu_in = file;
-		ret = perf_pmu_parse(head, name);
+		ret = perf_pmu_lex_init(&scanner);
+		if (ret) {
+			fclose(file);
+			break;
+		}
+
+		perf_pmu_set_in(file, scanner);
+		ret = perf_pmu_parse(head, name, scanner);
+		perf_pmu_lex_destroy(scanner);
 		fclose(file);
 	}
 
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 24cf69ab32cd..52c37081c880 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -206,7 +206,7 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct list_head *head_terms,
 			  struct perf_pmu_info *info);
 struct list_head *perf_pmu__alias(struct perf_pmu *pmu,
 				  struct list_head *head_terms);
-void perf_pmu_error(struct list_head *list, char *name, char const *msg);
+void perf_pmu_error(struct list_head *list, char *name, void *scanner, char const *msg);
 
 int perf_pmu__new_format(struct list_head *list, char *name,
 			 int config, unsigned long *bits);
diff --git a/tools/perf/util/pmu.l b/tools/perf/util/pmu.l
index 58b4926cfaca..67b247be693b 100644
--- a/tools/perf/util/pmu.l
+++ b/tools/perf/util/pmu.l
@@ -1,4 +1,6 @@
 %option prefix="perf_pmu_"
+%option reentrant
+%option bison-bridge
 
 %{
 #include <stdlib.h>
@@ -6,16 +8,21 @@
 #include "pmu.h"
 #include "pmu-bison.h"
 
-static int value(int base)
+char *perf_pmu_get_text(yyscan_t yyscanner);
+YYSTYPE *perf_pmu_get_lval(yyscan_t yyscanner);
+
+static int value(yyscan_t scanner, int base)
 {
+	YYSTYPE *yylval = perf_pmu_get_lval(scanner);
+	char *text = perf_pmu_get_text(scanner);
 	long num;
 
 	errno = 0;
-	num = strtoul(perf_pmu_text, NULL, base);
+	num = strtoul(text, NULL, base);
 	if (errno)
 		return PP_ERROR;
 
-	perf_pmu_lval.num = num;
+	yylval->num = num;
 	return PP_VALUE;
 }
 
@@ -25,7 +32,7 @@ num_dec         [0-9]+
 
 %%
 
-{num_dec}	{ return value(10); }
+{num_dec}	{ return value(yyscanner, 10); }
 config		{ return PP_CONFIG; }
 -		{ return '-'; }
 :		{ return ':'; }
@@ -35,7 +42,7 @@ config		{ return PP_CONFIG; }
 
 %%
 
-int perf_pmu_wrap(void)
+int perf_pmu_wrap(void *scanner __maybe_unused)
 {
 	return 1;
 }
diff --git a/tools/perf/util/pmu.y b/tools/perf/util/pmu.y
index e675d79a0274..dff4e892ac4d 100644
--- a/tools/perf/util/pmu.y
+++ b/tools/perf/util/pmu.y
@@ -1,6 +1,8 @@
-
+%define api.pure full
 %parse-param {struct list_head *format}
 %parse-param {char *name}
+%parse-param {void *scanner}
+%lex-param {void* scanner}
 
 %{
 
@@ -78,6 +80,7 @@ PP_VALUE
 
 void perf_pmu_error(struct list_head *list __maybe_unused,
 		    char *name __maybe_unused,
+		    void *scanner __maybe_unused,
 		    char const *msg __maybe_unused)
 {
 }
-- 
2.40.0.348.gf938b09366-goog

