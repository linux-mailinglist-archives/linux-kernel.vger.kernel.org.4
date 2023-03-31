Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D536D1458
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 02:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjCaAtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 20:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjCaAte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 20:49:34 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD6C1207F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 17:49:23 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id w5-20020a253005000000b00aedd4305ff2so20601714ybw.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 17:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680223763;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r8kDVr0L3/jz3PKx2/Xe0c5OesyXlwiHmE5YPaDrqp0=;
        b=hFAdw/K0Go/isitryy0LSHmnD7fhXsz6n3po1ZSyOfHRKVuSNM5iVw+qzblpNVH8yK
         GgL6o5uLCXZvmcAFyfPz3JBPLTw0eMlCG2qqY1m16DWdaGNHzawprr4+y2ey38eunBer
         RL5zjRvWS2cNNW8HGaPz4aVYxSRoClBE6FRl0BXcQZ6bQQmJrKRAEELHWmuaGm+r99Dy
         mlrfvTFbxAT9IJd6Wko+gkL9o+7NJIog04d/2w34avGJjqU8AfK8gbPBzjtGPWeq+wx2
         7eR5TUc4VXzVqAQbUrJB6KWkbYIdmonFVIBRBweNMozheXLLgY4LqL79KPDAs9JmK1Pb
         QeGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680223763;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r8kDVr0L3/jz3PKx2/Xe0c5OesyXlwiHmE5YPaDrqp0=;
        b=iJmDGssFS+tV50z1QPYHtGK4hMw6/MTHSWR7oRzb7N7kEJVdTB5G+0NTvboXydLZzp
         K45RcqN1x2hOZjwgfu1E2Rf6RDAedZj9H7O3MwYCfQU+pO/xL21m9+/uhi0sCjVtpUWX
         Ch0Q3Wh0v+ySGdRA39oMLzedSqpA2mcKksE6Oe22pfgA7Zz7zmjBUep2GSNXgESccMyb
         R35xBUspazPSxDEvXBhl0phq4uDbSoctzSMlZAyNW7X8oXnF/QmmhsKyAN8Wxlnn7ajD
         h3gHwcU3zoLk4HsgOAY5+zX0wqo79b156sLDKb+ikyZsQ7+O6+Nb8KnGi2FMbtv159Co
         QfSg==
X-Gm-Message-State: AAQBX9c0bTkBkNaLfsmheHVfTH9yLX2RXQnQiMpB7lToGdcbaGGJ4Tvx
        YDUrIummutSsuHRt/fBRppjJKvRNUKPF
X-Google-Smtp-Source: AKy350aJkuyRGOFqyRqlaNJdTuRJxkuDhuBr5i7y2eTM0OAROBvmVidnwWbq21tgIgl3OOw+ykZgzlmpCkHY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:11ea:eb75:e48c:2c04])
 (user=irogers job=sendgmr) by 2002:a05:6902:168d:b0:b6d:1483:bc18 with SMTP
 id bx13-20020a056902168d00b00b6d1483bc18mr16244213ybb.7.1680223762986; Thu,
 30 Mar 2023 17:49:22 -0700 (PDT)
Date:   Thu, 30 Mar 2023 17:48:42 -0700
In-Reply-To: <20230331004844.1592789-1-irogers@google.com>
Message-Id: <20230331004844.1592789-3-irogers@google.com>
Mime-Version: 1.0
References: <20230331004844.1592789-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v1 2/4] perf srcline: Simplify addr2line subprocess
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
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, llvm@lists.linux.dev
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

Don't wrap stdin and stdout of subprocess with streams, use the api/io
library for buffering.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/srcline.c | 103 ++++++++++++++------------------------
 1 file changed, 38 insertions(+), 65 deletions(-)

diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index f0a96a834e4b..2da86e57215d 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -10,6 +10,8 @@
 #include <linux/string.h>
 #include <linux/zalloc.h>
 
+#include <api/io.h>
+
 #include "util/dso.h"
 #include "util/debug.h"
 #include "util/callchain.h"
@@ -366,12 +368,6 @@ void dso__free_a2l(struct dso *dso)
 
 #else /* HAVE_LIBBFD_SUPPORT */
 
-struct a2l_subprocess {
-	struct child_process addr2line;
-	FILE *to_child;
-	FILE *from_child;
-};
-
 static int filename_split(char *filename, unsigned int *line_nr)
 {
 	char *sep;
@@ -393,28 +389,18 @@ static int filename_split(char *filename, unsigned int *line_nr)
 	return 0;
 }
 
-static void addr2line_subprocess_cleanup(struct a2l_subprocess *a2l)
+static void addr2line_subprocess_cleanup(struct child_process *a2l)
 {
-	if (a2l->addr2line.pid != -1) {
-		kill(a2l->addr2line.pid, SIGKILL);
-		finish_command(&a2l->addr2line); /* ignore result, we don't care */
-		a2l->addr2line.pid = -1;
-	}
-
-	if (a2l->to_child != NULL) {
-		fclose(a2l->to_child);
-		a2l->to_child = NULL;
-	}
-
-	if (a2l->from_child != NULL) {
-		fclose(a2l->from_child);
-		a2l->from_child = NULL;
+	if (a2l->pid != -1) {
+		kill(a2l->pid, SIGKILL);
+		finish_command(a2l); /* ignore result, we don't care */
+		a2l->pid = -1;
 	}
 
 	free(a2l);
 }
 
-static struct a2l_subprocess *addr2line_subprocess_init(const char *addr2line_path,
+static struct child_process *addr2line_subprocess_init(const char *addr2line_path,
 							const char *binary_path)
 {
 	const char *argv[] = {
@@ -422,54 +408,34 @@ static struct a2l_subprocess *addr2line_subprocess_init(const char *addr2line_pa
 		"-e", binary_path,
 		"-i", "-f", NULL
 	};
-	struct a2l_subprocess *a2l = zalloc(sizeof(*a2l));
+	struct child_process *a2l = zalloc(sizeof(*a2l));
 	int start_command_status = 0;
 
-	if (a2l == NULL)
-		goto out;
-
-	a2l->to_child = NULL;
-	a2l->from_child = NULL;
+	if (a2l == NULL) {
+		pr_err("Failed to allocate memory for addr2line");
+		return NULL;
+	}
 
-	a2l->addr2line.pid = -1;
-	a2l->addr2line.in = -1;
-	a2l->addr2line.out = -1;
-	a2l->addr2line.no_stderr = 1;
+	a2l->pid = -1;
+	a2l->in = -1;
+	a2l->out = -1;
+	a2l->no_stderr = 1;
 
-	a2l->addr2line.argv = argv;
-	start_command_status = start_command(&a2l->addr2line);
-	a2l->addr2line.argv = NULL; /* it's not used after start_command; avoid dangling pointers */
+	a2l->argv = argv;
+	start_command_status = start_command(a2l);
+	a2l->argv = NULL; /* it's not used after start_command; avoid dangling pointers */
 
 	if (start_command_status != 0) {
 		pr_warning("could not start addr2line (%s) for %s: start_command return code %d\n",
 			addr2line_path, binary_path, start_command_status);
-		goto out;
-	}
-
-	a2l->to_child = fdopen(a2l->addr2line.in, "w");
-	if (a2l->to_child == NULL) {
-		pr_warning("could not open write-stream to addr2line (%s) of %s\n",
-			addr2line_path, binary_path);
-		goto out;
-	}
-
-	a2l->from_child = fdopen(a2l->addr2line.out, "r");
-	if (a2l->from_child == NULL) {
-		pr_warning("could not open read-stream from addr2line (%s) of %s\n",
-			addr2line_path, binary_path);
-		goto out;
+		addr2line_subprocess_cleanup(a2l);
+		return NULL;
 	}
 
 	return a2l;
-
-out:
-	if (a2l)
-		addr2line_subprocess_cleanup(a2l);
-
-	return NULL;
 }
 
-static int read_addr2line_record(struct a2l_subprocess *a2l,
+static int read_addr2line_record(struct io *io,
 				 char **function,
 				 char **filename,
 				 unsigned int *line_nr)
@@ -494,7 +460,7 @@ static int read_addr2line_record(struct a2l_subprocess *a2l,
 	if (line_nr != NULL)
 		*line_nr = 0;
 
-	if (getline(&line, &line_len, a2l->from_child) < 0 || !line_len)
+	if (io__getline(&line, &line_len, io) < 0 || !line_len)
 		goto error;
 	if (function != NULL)
 		*function = strdup(strim(line));
@@ -502,7 +468,7 @@ static int read_addr2line_record(struct a2l_subprocess *a2l,
 	zfree(&line);
 	line_len = 0;
 
-	if (getline(&line, &line_len, a2l->from_child) < 0 || !line_len)
+	if (io__getline(&line, &line_len, io) < 0 || !line_len)
 		goto error;
 
 	if (filename_split(line, line_nr == NULL ? &dummy_line_nr : line_nr) == 0) {
@@ -546,13 +512,17 @@ static int addr2line(const char *dso_name, u64 addr,
 		     struct inline_node *node,
 		     struct symbol *sym __maybe_unused)
 {
-	struct a2l_subprocess *a2l = dso->a2l;
+	struct child_process *a2l = dso->a2l;
 	char *record_function = NULL;
 	char *record_filename = NULL;
 	unsigned int record_line_nr = 0;
 	int record_status = -1;
 	int ret = 0;
 	size_t inline_count = 0;
+	int len;
+	char buf[128];
+	ssize_t written;
+	struct io io;
 
 	if (!a2l) {
 		if (!filename__has_section(dso_name, ".debug_line"))
@@ -578,13 +548,16 @@ static int addr2line(const char *dso_name, u64 addr,
 	 * though, because it may be genuinely unknown, in which case we'll get two sets of
 	 * "??"/"??:0" lines.
 	 */
-	if (fprintf(a2l->to_child, "%016"PRIx64"\n,\n", addr) < 0 || fflush(a2l->to_child) != 0) {
+	len = snprintf(buf, sizeof(buf), "%016"PRIx64"\n,\n", addr);
+	written = len > 0 ? write(a2l->in, buf, len) : -1;
+	if (written != len) {
 		if (!symbol_conf.disable_add2line_warn)
 			pr_warning("%s %s: could not send request\n", __func__, dso_name);
 		goto out;
 	}
+	io__init(&io, a2l->out, buf, sizeof(buf));
 
-	switch (read_addr2line_record(a2l, &record_function, &record_filename, &record_line_nr)) {
+	switch (read_addr2line_record(&io, &record_function, &record_filename, &record_line_nr)) {
 	case -1:
 		if (!symbol_conf.disable_add2line_warn)
 			pr_warning("%s %s: could not read first record\n", __func__, dso_name);
@@ -594,7 +567,7 @@ static int addr2line(const char *dso_name, u64 addr,
 		 * The first record was invalid, so return failure, but first read another
 		 * record, since we asked a junk question and have to clear the answer out.
 		 */
-		switch (read_addr2line_record(a2l, NULL, NULL, NULL)) {
+		switch (read_addr2line_record(&io, NULL, NULL, NULL)) {
 		case -1:
 			if (!symbol_conf.disable_add2line_warn)
 				pr_warning("%s %s: could not read delimiter record\n",
@@ -632,7 +605,7 @@ static int addr2line(const char *dso_name, u64 addr,
 	}
 
 	/* We have to read the records even if we don't care about the inline info. */
-	while ((record_status = read_addr2line_record(a2l,
+	while ((record_status = read_addr2line_record(&io,
 						      &record_function,
 						      &record_filename,
 						      &record_line_nr)) == 1) {
@@ -656,7 +629,7 @@ static int addr2line(const char *dso_name, u64 addr,
 
 void dso__free_a2l(struct dso *dso)
 {
-	struct a2l_subprocess *a2l = dso->a2l;
+	struct child_process *a2l = dso->a2l;
 
 	if (!a2l)
 		return;
-- 
2.40.0.348.gf938b09366-goog

