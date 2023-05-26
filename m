Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816F4712C8E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243298AbjEZSfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243257AbjEZSew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:34:52 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E831210D8
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:34:38 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-564f6099813so21292227b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685126078; x=1687718078;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bcu52ZFroNNUdqyZRIxQffX6dxZ/uHK2VwVobLtSsPQ=;
        b=5o/Nx7rLPrNfsjQlkkwWwKM8wDGHmv5Dybvj9q2PYboM4W3EidbHkxN5I0Oo/rs7S0
         khUL+qXGYgFBPOGZw1ae+0f82yoyabEVbgKZ/qilDA7Ug1LN0wdETQjZq8sReEFkF5Mv
         slV7gSy5Zol+0tUuJlF3l4ebDn3ItoOkCofhzx67roW6klSVhkf7ihzbKKPLxMglfgnw
         Y1av5YxUp3V8cTSuTyoO1q5tubptBAPkPxO7k0DDTlK9EAXklj+sSHCCQustodKl/2mk
         N9qqMsUWaAmTRHrbC6zYr+ToTwBFtjy4OdY4Rt/VgF4zqdacRrr/XbD85TIDdPiEtydd
         UZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685126078; x=1687718078;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bcu52ZFroNNUdqyZRIxQffX6dxZ/uHK2VwVobLtSsPQ=;
        b=IZDb0d6CUv9+HX7zZYijfqrq9ViZatweNOk6/ZKx3L5uamq4q7/0osphHj0nkcIMdZ
         /CW2GQD3IlFItZYWPtixdHurkmvyV/pZ6e6mUE+/XY0kiFbRPCTSrSALE21O4Ilte79q
         UFFIbQ2mRM2qnEOvrXHVJcfOHAaVMxh0SCgAQzQpHwbQ+q/jmHM9YjC8c7fjmVi7Aw3C
         3ENDUbiJc/bYL6n3uZvzh6PmH21j6VvUVWjagR4/QDMMMoeennuAoUoQJoJAII/9syDK
         Vinx6P7OzqYEipIjdHMbKopAKcXJk+yxvTaS/t9i42SS4jHhfzCHEPIcgUzg468rqJJs
         oG8A==
X-Gm-Message-State: AC+VfDyw/UyDcWzhCOI/sMwyZTVHgDP2fWaLUuF0+EOI4NWy2GdrN/pM
        06u0KJwg4imLdbKqA+jhD2gAoj34nbDv
X-Google-Smtp-Source: ACHHUZ40dfijm94RJq2Q31obwmB+WB5iBglw4oyCn9Mp3VcGTYG7tjYdBlampUIaFb0Y5I554ax/Hm8uUwv9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a81:4309:0:b0:561:987e:d22 with SMTP id
 q9-20020a814309000000b00561987e0d22mr1566047ywa.1.1685126077827; Fri, 26 May
 2023 11:34:37 -0700 (PDT)
Date:   Fri, 26 May 2023 11:33:57 -0700
In-Reply-To: <20230526183401.2326121-1-irogers@google.com>
Message-Id: <20230526183401.2326121-13-irogers@google.com>
Mime-Version: 1.0
References: <20230526183401.2326121-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v2 12/16] perf path: Make mkpath thread safe
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
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Ross Zwisler <zwisler@chromium.org>,
        Leo Yan <leo.yan@linaro.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
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

Avoid 4 static arrays for paths, pass in a char[] buffer to use. Makes
mkpath thread safe for the small number of users. Also removes 16,384
bytes from .bss.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-config.c |  4 +++-
 tools/perf/builtin-help.c   |  4 +++-
 tools/perf/util/cache.h     |  2 +-
 tools/perf/util/config.c    |  3 ++-
 tools/perf/util/path.c      | 35 +++++------------------------------
 5 files changed, 14 insertions(+), 34 deletions(-)

diff --git a/tools/perf/builtin-config.c b/tools/perf/builtin-config.c
index 2603015f98be..2e8363778935 100644
--- a/tools/perf/builtin-config.c
+++ b/tools/perf/builtin-config.c
@@ -12,6 +12,7 @@
 #include "util/debug.h"
 #include "util/config.h"
 #include <linux/string.h>
+#include <limits.h>
 #include <stdio.h>
 #include <stdlib.h>
 
@@ -157,7 +158,8 @@ int cmd_config(int argc, const char **argv)
 {
 	int i, ret = -1;
 	struct perf_config_set *set;
-	char *user_config = mkpath("%s/.perfconfig", getenv("HOME"));
+	char path[PATH_MAX];
+	char *user_config = mkpath(path, sizeof(path), "%s/.perfconfig", getenv("HOME"));
 	const char *config_filename;
 	bool changed = false;
 
diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
index 3e7f52054fac..b2a368ae295a 100644
--- a/tools/perf/builtin-help.c
+++ b/tools/perf/builtin-help.c
@@ -19,6 +19,7 @@
 #include <linux/string.h>
 #include <linux/zalloc.h>
 #include <errno.h>
+#include <limits.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -389,9 +390,10 @@ static int get_html_page_path(char **page_path, const char *page)
 {
 	struct stat st;
 	const char *html_path = system_path(PERF_HTML_PATH);
+	char path[PATH_MAX];
 
 	/* Check that we have a perf documentation directory. */
-	if (stat(mkpath("%s/perf.html", html_path), &st)
+	if (stat(mkpath(path, sizeof(path), "%s/perf.html", html_path), &st)
 	    || !S_ISREG(st.st_mode)) {
 		pr_err("'%s': not a documentation directory.", html_path);
 		return -1;
diff --git a/tools/perf/util/cache.h b/tools/perf/util/cache.h
index 9f2e36ef5072..0b61840d4226 100644
--- a/tools/perf/util/cache.h
+++ b/tools/perf/util/cache.h
@@ -26,6 +26,6 @@ static inline int is_absolute_path(const char *path)
 	return path[0] == '/';
 }
 
-char *mkpath(const char *fmt, ...) __printf(1, 2);
+char *mkpath(char *path_buf, size_t sz, const char *fmt, ...) __printf(3, 4);
 
 #endif /* __PERF_CACHE_H */
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 658170b8dcef..f340dc73db6d 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -543,6 +543,7 @@ static char *home_perfconfig(void)
 	const char *home = NULL;
 	char *config;
 	struct stat st;
+	char path[PATH_MAX];
 
 	home = getenv("HOME");
 
@@ -554,7 +555,7 @@ static char *home_perfconfig(void)
 	if (!home || !*home || !perf_config_global())
 		return NULL;
 
-	config = strdup(mkpath("%s/.perfconfig", home));
+	config = strdup(mkpath(path, sizeof(path), "%s/.perfconfig", home));
 	if (config == NULL) {
 		pr_warning("Not enough memory to process %s/.perfconfig, ignoring it.\n", home);
 		return NULL;
diff --git a/tools/perf/util/path.c b/tools/perf/util/path.c
index ce80b79be103..00adf872bf00 100644
--- a/tools/perf/util/path.c
+++ b/tools/perf/util/path.c
@@ -1,16 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * I'm tired of doing "vsnprintf()" etc just to open a
- * file, so here's a "return static buffer with printf"
- * interface for paths.
- *
- * It's obviously not thread-safe. Sue me. But it's quite
- * useful for doing things like
- *
- *   f = open(mkpath("%s/%s.perf", base, name), O_RDONLY);
- *
- * which is what it's designed for.
- */
 #include "path.h"
 #include "cache.h"
 #include <linux/kernel.h>
@@ -22,18 +10,6 @@
 #include <dirent.h>
 #include <unistd.h>
 
-static char bad_path[] = "/bad-path/";
-/*
- * One hack:
- */
-static char *get_pathname(void)
-{
-	static char pathname_array[4][PATH_MAX];
-	static int idx;
-
-	return pathname_array[3 & ++idx];
-}
-
 static char *cleanup_path(char *path)
 {
 	/* Clean it up */
@@ -45,18 +21,17 @@ static char *cleanup_path(char *path)
 	return path;
 }
 
-char *mkpath(const char *fmt, ...)
+char *mkpath(char *path_buf, size_t sz, const char *fmt, ...)
 {
 	va_list args;
 	unsigned len;
-	char *pathname = get_pathname();
 
 	va_start(args, fmt);
-	len = vsnprintf(pathname, PATH_MAX, fmt, args);
+	len = vsnprintf(path_buf, sz, fmt, args);
 	va_end(args);
-	if (len >= PATH_MAX)
-		return bad_path;
-	return cleanup_path(pathname);
+	if (len >= sz)
+		strncpy(path_buf, "/bad-path/", sz);
+	return cleanup_path(path_buf);
 }
 
 int path__join(char *bf, size_t size, const char *path1, const char *path2)
-- 
2.41.0.rc0.172.g3f132b7071-goog

