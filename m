Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C1E6D8FBC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 08:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235656AbjDFGwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 02:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235613AbjDFGwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 02:52:41 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3849033
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 23:52:39 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54c01480e3cso27387207b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 23:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680763959;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9nm1xQP5/CZTYWyFSei8uHNISktYFNWv+Clu34MqVSI=;
        b=aF4o0ID3B8PG82DEAzeXoAcnPn1WF9QIuD7OyY1P2NqOM2Dh9v/NE2dz82JzAm2DFr
         Ap+MaCgzmrtRHJC4qKdqBZOE7jD/tQgasQ+zXPaV10HdXO0rC1ui/jhA60SQn4KeIF8W
         v9UvAumeG4rSnAFaOSQMWLRbjyo5rVJJlPsjfT+xjiC96sTvuTHbAV7dxgFVETkoymhP
         eDrXMV4iDw+pge6SOnzc9N6hH5oYOHgRhfohIsya/rrRRvUB7isrvmSrIiT0WutCRyTZ
         2HWVNLEloX00o86nLmQpgXk2Fx5MXyQ8IW9Uig/Q2aEtdJC1yZaPIPq5eu2xQH666dzM
         g61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680763959;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9nm1xQP5/CZTYWyFSei8uHNISktYFNWv+Clu34MqVSI=;
        b=WDo7BHJ2i6dKgzHrV0yrAaOSH/DRyvDr3s5bYxu/igEYmadS2qSCCe9bvlOBWxcSYm
         j18qwYTDy+xgjp1gXNY8apI5TtmoaR1UflG51NLSkpZpLB2sSCXtUrCPoCBTQHPDIqxx
         oTpbo1ZblPHhNs1GzH0jCnPvw2r/qj8cuRybgKq7vtztp+ECTl8VnqTxJM8JwwS1b/nK
         ti/Hs+IC8NzRp45Df/yqsUdiPXWfewaAfjkmzSIx5RwxxZV9osBS9i2EKX0Yj6gIf94d
         3nRPDDTbFway3l2tdW2sf/Mpll0+xUYxZF1Qg3KnfEhEVv3QQ4pRtkHK2QjO/BjHfe+v
         gEyw==
X-Gm-Message-State: AAQBX9cCZVpFXMyAxRazynPvLJH40It5JKy+EK5RxsfII2Uxsv9CSjWt
        HpdE3MEkx7mnv/5+46NR7HvKeUiI+wrX
X-Google-Smtp-Source: AKy350bQ4nVxm9pm1EMUTqmjPalcWhGurSYQoufT2eKUEZbCulj7gZYb3C05jpRER3BtDbL4Fhf0v9y+EwUo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:713a:ed0b:3d14:a4da])
 (user=irogers job=sendgmr) by 2002:a25:cb03:0:b0:b8b:fd23:5028 with SMTP id
 b3-20020a25cb03000000b00b8bfd235028mr179977ybg.3.1680763959081; Wed, 05 Apr
 2023 23:52:39 -0700 (PDT)
Date:   Wed,  5 Apr 2023 23:52:23 -0700
Message-Id: <20230406065224.2553640-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v3 1/2] perf pmu: Make parser reentrant
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
 tools/perf/util/pmu.c | 26 ++++++++++++++++++++------
 tools/perf/util/pmu.h |  2 +-
 tools/perf/util/pmu.l | 17 ++++++++++++-----
 tools/perf/util/pmu.y |  5 ++++-
 4 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 78a407b42ad1..96ef317bac41 100644
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
 
 static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name);
@@ -81,6 +80,8 @@ int perf_pmu__format_parse(int dirfd, struct list_head *head)
 	while (!ret && (evt_ent = readdir(format_dir))) {
 		char *name = evt_ent->d_name;
 		int fd;
+		void *scanner;
+		FILE *file;
 
 		if (!strcmp(name, ".") || !strcmp(name, ".."))
 			continue;
@@ -91,9 +92,22 @@ int perf_pmu__format_parse(int dirfd, struct list_head *head)
 		if (fd < 0)
 			break;
 
-		perf_pmu_in = fdopen(fd, "r");
-		ret = perf_pmu_parse(head, name);
-		fclose(perf_pmu_in);
+		file = fdopen(fd, "r");
+		if (!file) {
+			close(fd);
+			break;
+		}
+
+		ret = perf_pmu_lex_init(&scanner);
+		if (ret) {
+			fclose(file);
+			break;
+		}
+
+		perf_pmu_set_in(file, scanner);
+		ret = perf_pmu_parse(head, name, scanner);
+		perf_pmu_lex_destroy(scanner);
+		fclose(file);
 	}
 
 	closedir(format_dir);
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 32c3a75bca0e..d53618c65c92 100644
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

