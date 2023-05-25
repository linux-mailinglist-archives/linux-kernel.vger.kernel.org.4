Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F360C710614
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 09:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239100AbjEYHNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 03:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239272AbjEYHMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 03:12:44 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2DBE5E
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:12:26 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba88ec544ddso643665276.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684998746; x=1687590746;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t2aELLGlNNj7hku9z1aRjQTB9lcqOk+GXPWkETSohOQ=;
        b=iKmBY0tqG9A4f90Oxzgc6K2d5FDijlR6/v662mMbKBcPRqpnrnSjeNQ7uLHcQRIBTo
         NVLKZoJchJNoH9E6Pj5fxuSPMsL3/V9+/OUlQeD/Ep+sGnWNQzPTpXKUp0WrFYdCkxJ4
         Shs33MQyKnjbVs4/mxGIPse3SMm7jwWL8NKa3zwnotMaCxDgcId6Gu9t9SXMvsz7zo9z
         8h85Bnl2M1psoVN2MJ/F+qD6BXzNjZp8WqAf6+CmyRDpeF+es9AeOBhKkTpiHFChXWXD
         Yzpb4QzvQzM+4Ze+jMf7XL6rm7M9fXrCyTok06hU5CT/sbzN/6IPRt6E3JMhJG3ySKvE
         R6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684998746; x=1687590746;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t2aELLGlNNj7hku9z1aRjQTB9lcqOk+GXPWkETSohOQ=;
        b=OD4vLJqKa24mTcb6xLUwGTGXR8xMuqMJUXEImB17+5/1kXTf4T4knWMeCsmIeSiwAs
         y0hM5Z0UutvkNluMalhvVGMGxRhI2r2Il8xFgBX80+rFHUrDr1dTfSJPp0PpHi2kuyb+
         U9/iETlNJX/vLmC9EsQMaADUWeWighNZKzMeygmelxbetAWvYnmxXM6to0tLOvN02Tr8
         A7xK+bUdXmqmi5SGMA4n9Ker2ml0pYQlpgwe52mC+ySINcqMRq0o9/HK1aZD194hEJe5
         8UO1Yz+ANvll+l/QR1TMP2JOsONyGAdfdXKg/kko+bJSgqkKZtDtP1Usrc/BnG8zGbLa
         VWWQ==
X-Gm-Message-State: AC+VfDy0aXCl9jfIJUkqq+Ti2kWVcWPUD0bXWMdovT+hqjhFYdeYP66s
        8wfhMVcqK+9A+t3NYnlUFARfox+uNVxm
X-Google-Smtp-Source: ACHHUZ7BinpmXpwKmORyqVBwqgT6XCjUR6ZaZ1Am4QsjEhiXgq8OGs7h5oRO7Y6iB2GePDNw0Tt/Fa69P3UZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a25:ada1:0:b0:ba8:736a:5bec with SMTP id
 z33-20020a25ada1000000b00ba8736a5becmr1676397ybi.6.1684998745826; Thu, 25 May
 2023 00:12:25 -0700 (PDT)
Date:   Thu, 25 May 2023 00:11:29 -0700
In-Reply-To: <20230525071133.2066610-1-irogers@google.com>
Message-Id: <20230525071133.2066610-13-irogers@google.com>
Mime-Version: 1.0
References: <20230525071133.2066610-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v1 12/16] perf path: Make mkpath thread safe
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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
2.40.1.698.g37aff9b760-goog

