Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A387A6D50DD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjDCSlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbjDCSlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:41:17 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E3A2103
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 11:41:10 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f66-20020a255145000000b00b714602d43fso29960462ybb.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 11:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680547270;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sfQ3ydjQvMhzFReVFE6Rco19saqYJT8yxFgkuZOml8M=;
        b=Gu9wGljsOntmdKnEQFzbEEJ5s2QA2ynGBRSQkiTtPlLcurHe8D5nMKz98D9i7XuBnc
         r3Sz6X+VA75m02Auo2Tb7nU8ThH887Qgj9ekDqvBArbZJd311nc8zJK9cxoHeDTimYyI
         5Kj+WyMHMCPMTJIoNEG5Uolq5LB1SvlqrNa4j1wpdcB8c33q5tKfuM1psYsZYJDKUrI3
         MXJfYMJ8/oHr9T4IGC5l/F/KdbqW1xN4GwgmkGFy1E0uWUST7UWAd/dktPn/0VFa26Wx
         +/IFcIAcoLylzrHMNok9MdS9sjBHJvyFjQBeSizhogSnQFvOP2N1qtxElngXbkqhhAzb
         wHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680547270;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sfQ3ydjQvMhzFReVFE6Rco19saqYJT8yxFgkuZOml8M=;
        b=hM5KSG/j4uUYx5q9Kid7RHJxjkaLYvgcM3fyXAYoRY/qV/9JwWHEn3+TeazJbTLT5J
         SJ5aUlcdGolRYDakvUiSGnsOurSKspnDcOdmQ0Grtqp6+WloSH49ZV6lloDYeQ22c21L
         UVKi+6AKRJk09NvrEjhZWi9FeeDLEEeQaNNfOd8Jwq1Ckq9x5gxcczusP+DSPvG5LaC7
         o4A7i1Vu64rooPhm/e27qRlQlKOgi4yAHd6DMolwq/O6x4vOtg/605N1KMp+IP05UbBc
         bvSzkrdzbTXqC852rav0gtxc2IaXMjl72+YtK2J/Rkjuj1KBVZYzO6pYYrgLTgxG4fjU
         xwjQ==
X-Gm-Message-State: AAQBX9eaAO5KWFKVLPv/OdGRx74oXmm/4Mz13BQ2pjFigxkzbJ7jjOlO
        SF3sWaJDO5j6tRFfd2NOJzd/L5+3Hsmr
X-Google-Smtp-Source: AKy350Z1ASPKD1sZeo9v/RbnHxaoRVHKJh3KAyrhCIfp3t0FuCVIKe5XpEH/+L8x6G9opfogGkMCdXjVWb//
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:9dc:a977:817d:341])
 (user=irogers job=sendgmr) by 2002:a25:d412:0:b0:b76:3b21:b1dc with SMTP id
 m18-20020a25d412000000b00b763b21b1dcmr78538ybf.0.1680547270082; Mon, 03 Apr
 2023 11:41:10 -0700 (PDT)
Date:   Mon,  3 Apr 2023 11:40:32 -0700
In-Reply-To: <20230403184033.1836023-1-irogers@google.com>
Message-Id: <20230403184033.1836023-4-irogers@google.com>
Mime-Version: 1.0
References: <20230403184033.1836023-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v2 3/4] perf srcline: Support for llvm-addr2line
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

The sentinel value differs for llvm-addr2line. Configure this once and
then detect when reading records.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/srcline.c | 74 +++++++++++++++++++++++++++++++++++----
 1 file changed, 67 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 5339ab4c5e12..f4fcdada821b 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -435,7 +435,50 @@ static struct child_process *addr2line_subprocess_init(const char *addr2line_pat
 	return a2l;
 }
 
+enum a2l_style {
+	BROKEN,
+	GNU_BINUTILS,
+	LLVM,
+};
+
+static enum a2l_style addr2line_configure(struct child_process *a2l)
+{
+	static bool cached;
+	static enum a2l_style style;
+
+	if (!cached) {
+		char buf[128];
+		struct io io;
+		int ch;
+
+		if (write(a2l->in, ",\n", 2) != 2)
+			return BROKEN;
+
+		io__init(&io, a2l->out, buf, sizeof(buf));
+		ch = io__get_char(&io);
+		if (ch == ',') {
+			style = LLVM;
+			cached = true;
+		} else if (ch == '?') {
+			style = GNU_BINUTILS;
+			cached = true;
+		} else {
+			style = BROKEN;
+		}
+		do {
+			ch = io__get_char(&io);
+		} while (ch > 0 && ch != '\n');
+		if (style == GNU_BINUTILS) {
+			do {
+				ch = io__get_char(&io);
+			} while (ch > 0 && ch != '\n');
+		}
+	}
+	return style;
+}
+
 static int read_addr2line_record(struct io *io,
+				 enum a2l_style style,
 				 char **function,
 				 char **filename,
 				 unsigned int *line_nr)
@@ -462,6 +505,12 @@ static int read_addr2line_record(struct io *io,
 
 	if (io__getline(io, &line, &line_len) < 0 || !line_len)
 		goto error;
+
+	if (style == LLVM && line_len == 2 && line[0] == ',') {
+		zfree(&line);
+		return 0;
+	}
+
 	if (function != NULL)
 		*function = strdup(strim(line));
 
@@ -471,7 +520,8 @@ static int read_addr2line_record(struct io *io,
 	if (io__getline(io, &line, &line_len) < 0 || !line_len)
 		goto error;
 
-	if (filename_split(line, line_nr == NULL ? &dummy_line_nr : line_nr) == 0) {
+	if (filename_split(line, line_nr == NULL ? &dummy_line_nr : line_nr) == 0 &&
+	    style == GNU_BINUTILS) {
 		ret = 0;
 		goto error;
 	}
@@ -523,6 +573,7 @@ static int addr2line(const char *dso_name, u64 addr,
 	char buf[128];
 	ssize_t written;
 	struct io io;
+	enum a2l_style a2l_style;
 
 	if (!a2l) {
 		if (!filename__has_section(dso_name, ".debug_line"))
@@ -538,15 +589,22 @@ static int addr2line(const char *dso_name, u64 addr,
 			pr_warning("%s %s: addr2line_subprocess_init failed\n", __func__, dso_name);
 		goto out;
 	}
+	a2l_style = addr2line_configure(a2l);
+	if (a2l_style == BROKEN) {
+		if (!symbol_conf.disable_add2line_warn)
+			pr_warning("%s: addr2line configuration failed\n", __func__);
+		goto out;
+	}
 
 	/*
 	 * Send our request and then *deliberately* send something that can't be interpreted as
 	 * a valid address to ask addr2line about (namely, ","). This causes addr2line to first
 	 * write out the answer to our request, in an unbounded/unknown number of records, and
-	 * then to write out the lines "??" and "??:0", so that we can detect when it has
-	 * finished giving us anything useful. We have to be careful about the first record,
-	 * though, because it may be genuinely unknown, in which case we'll get two sets of
-	 * "??"/"??:0" lines.
+	 * then to write out the lines "??" and "??:0", for GNU binutils, or "," for
+	 * llvm-addr2line, so that we can detect when it has finished giving us anything
+	 * useful. With GNU binutils, we have to be careful about the first record, though,
+	 * because it may be genuinely unknown, in which case we'll get two sets of "??"/"??:0"
+	 * lines.
 	 */
 	len = snprintf(buf, sizeof(buf), "%016"PRIx64"\n,\n", addr);
 	written = len > 0 ? write(a2l->in, buf, len) : -1;
@@ -557,7 +615,8 @@ static int addr2line(const char *dso_name, u64 addr,
 	}
 	io__init(&io, a2l->out, buf, sizeof(buf));
 
-	switch (read_addr2line_record(&io, &record_function, &record_filename, &record_line_nr)) {
+	switch (read_addr2line_record(&io, a2l_style,
+				      &record_function, &record_filename, &record_line_nr)) {
 	case -1:
 		if (!symbol_conf.disable_add2line_warn)
 			pr_warning("%s %s: could not read first record\n", __func__, dso_name);
@@ -567,7 +626,7 @@ static int addr2line(const char *dso_name, u64 addr,
 		 * The first record was invalid, so return failure, but first read another
 		 * record, since we asked a junk question and have to clear the answer out.
 		 */
-		switch (read_addr2line_record(&io, NULL, NULL, NULL)) {
+		switch (read_addr2line_record(&io, a2l_style, NULL, NULL, NULL)) {
 		case -1:
 			if (!symbol_conf.disable_add2line_warn)
 				pr_warning("%s %s: could not read delimiter record\n",
@@ -606,6 +665,7 @@ static int addr2line(const char *dso_name, u64 addr,
 
 	/* We have to read the records even if we don't care about the inline info. */
 	while ((record_status = read_addr2line_record(&io,
+						      a2l_style,
 						      &record_function,
 						      &record_filename,
 						      &record_line_nr)) == 1) {
-- 
2.40.0.348.gf938b09366-goog

