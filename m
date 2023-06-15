Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F00D730D59
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 04:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237652AbjFOCvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 22:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjFOCvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 22:51:17 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA46E3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 19:51:16 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bd7f0e5df8eso1555744276.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 19:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686797475; x=1689389475;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gVuSMQJnyJqCPMn5wsYe5ruCFs+oyn3bf7+bzMc2VbA=;
        b=t2ELNQ3GM7CTdlb9230ffQCHUNkSOyG6FHs6z2PtiQ+8pdVl1Y1TrKhOxbvQZshNZf
         LtAOSjoNVtIHtBfpCm4ZguKPFjf7guyQxPtgAX9giEABWtSPmlT4bru+bc3gtLmgLWbR
         qlRtYKTjjhESmK0fi9jiFBW/duQknAYD01Xo6+EAcFimMWyWZrM3+Olkd2HJWKEbaeoZ
         n1VqyJjhOiewyHytbzJWCdHbnHVOltdzrM1uddprBM7pDH4lhgv68kurNc9eC/LQhGLl
         k7wiSBmQGVfoQ3bQkJ1rZe6iVTDIX808nOcJuxtp6yXAGB2zBvnAioVtpWsnuGg7hw7T
         GdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686797475; x=1689389475;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gVuSMQJnyJqCPMn5wsYe5ruCFs+oyn3bf7+bzMc2VbA=;
        b=KY0yzoHHQbMxnvdEZX85syQi/NGySdtW0RNxrnuIlwVoyqG4amrjsY/WFgRwfHbGiP
         sVHfNqZdlVWIBpjsq/olc+7JTE85a3KgDRylnIPTjj0c/QDNc3/YqBamShCkgZCDalGy
         qQCWrzkDJj4WBK1h1WjZFj8L2bmjA/qqsfpowYmHYAGu5lS3SduPVd2lTt7Zc4F83zqM
         9Nmk9vfido63wyFEy4MOyPJ0v6yD2EG1coQVo62HlYw7QZi3DndpMFZfvPCjfbDx6qwB
         18G+tr1zWc5f4Xt5nLvVSE6xC5LgYDT8PvpK4MJDNKkqPUBiP2He2he0eR2krQOELApx
         NaBA==
X-Gm-Message-State: AC+VfDxUouz70ytk+Se9TNAhTTdXrMQNa5KbizZbUhUiIRG0yTWQzKb5
        1jXJ3vc/ctre+h1PQuhJNEYHX4TNYmX3
X-Google-Smtp-Source: ACHHUZ7AvmRKIAMspzKtWYz8IrakoMh8S7Qs/SZ2WaA8e/Ns75rUCQVbSCgQvZCym0Ej7MoGX76mbAUvfkhi
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:768d:713f:8ce8:1d35])
 (user=irogers job=sendgmr) by 2002:a25:20a:0:b0:bc6:3354:e65e with SMTP id
 10-20020a25020a000000b00bc63354e65emr579424ybc.7.1686797475352; Wed, 14 Jun
 2023 19:51:15 -0700 (PDT)
Date:   Wed, 14 Jun 2023 19:50:41 -0700
Message-Id: <20230615025041.1982072-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1] perf srcline: Fix handling of inline functions
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
        Tom Rix <trix@redhat.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
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

We write an address then a ',' to addr2line. With inline data we
generally get back (// are my comments):
0x1234    // address
foo       // function name
foo.c:123 // filename:line
bar       // function name
bar.c:123 // filename:line
0x000000000000000 // sentinel address created by ','
??        // unknown function name
??:0      // unknown filename:line

The code was assuming the inline data also had the address, which is
incorrect. This means the first inline function name (bar above) needs
to be checked to see if it is the sentinel, otherwise to be treated as
a function name. The regression was caused by the addition of
addresses as the kernel is reporting a symbol at address 0 (used by
GNU binutils when it interprets ',').

Fixes: 8dc26b6f718a ("perf srcline: Make sentinel reading for binutils addr2line more robust")
Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/srcline.c | 136 ++++++++++++++++++++++----------------
 1 file changed, 80 insertions(+), 56 deletions(-)

diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index c013bcbdfd42..034b496df297 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -389,7 +389,7 @@ static int filename_split(char *filename, unsigned int *line_nr)
 		*line_nr = strtoul(sep, NULL, 0);
 		return 1;
 	}
-
+	pr_debug("addr2line missing ':' in filename split\n");
 	return 0;
 }
 
@@ -465,10 +465,12 @@ static enum a2l_style addr2line_configure(struct child_process *a2l, const char
 			style = LLVM;
 			cached = true;
 			lines = 1;
+			pr_debug("Detected LLVM addr2line style\n");
 		} else if (ch == '0') {
 			style = GNU_BINUTILS;
 			cached = true;
 			lines = 3;
+			pr_debug("Detected binutils addr2line style\n");
 		} else {
 			if (!symbol_conf.disable_add2line_warn) {
 				char *output = NULL;
@@ -479,6 +481,7 @@ static enum a2l_style addr2line_configure(struct child_process *a2l, const char
 					   __func__, dso_name);
 				pr_warning("\t%c%s", ch, output);
 			}
+			pr_debug("Unknown/broken addr2line style\n");
 			return BROKEN;
 		}
 		while (lines) {
@@ -496,6 +499,9 @@ static enum a2l_style addr2line_configure(struct child_process *a2l, const char
 
 static int read_addr2line_record(struct io *io,
 				 enum a2l_style style,
+				 const char *dso_name,
+				 u64 addr,
+				 bool first,
 				 char **function,
 				 char **filename,
 				 unsigned int *line_nr)
@@ -521,56 +527,62 @@ static int read_addr2line_record(struct io *io,
 		*line_nr = 0;
 
 	/*
-	 * Read the first line. Without an error this will be either an address
-	 * like 0x1234 or for llvm-addr2line the sentinal ',' character.
+	 * Read the first line. Without an error this will be:
+	 * - for the first line an address like 0x1234,
+	 * - the binutils sentinel 0x0000000000000000,
+	 * - the llvm-addr2line the sentinel ',' character,
+	 * - the function name line for an inlined function.
 	 */
 	if (io__getline(io, &line, &line_len) < 0 || !line_len)
 		goto error;
 
-	if (style == LLVM) {
-		if (line_len == 2 && line[0] == ',') {
-			zfree(&line);
-			return 0;
-		}
-	} else {
+	pr_debug("%s %s: addr2line read address for sentinel: %s", __func__, dso_name, line);
+	if (style == LLVM && line_len == 2 && line[0] == ',') {
+		/* Found the llvm-addr2line sentinel character. */
+		zfree(&line);
+		return 0;
+	} else if (style == GNU_BINUTILS && (!first || addr != 0)) {
 		int zero_count = 0, non_zero_count = 0;
+		/*
+		 * Check for binutils sentinel ignoring it for the case the
+		 * requested address is 0.
+		 */
 
-		/* The address should always start 0x. */
-		if (line_len < 2 || line[0] != '0' || line[1] != 'x')
-			goto error;
-
-		for (size_t i = 2; i < line_len; i++) {
-			if (line[i] == '0')
-				zero_count++;
-			else if (line[i] != '\n')
-				non_zero_count++;
-		}
-		if (!non_zero_count) {
-			int ch;
-
-			if (!zero_count) {
-				/* Line was erroneous just '0x'. */
-				goto error;
+		/* A given address should always start 0x. */
+		if (line_len >= 2 || line[0] != '0' || line[1] != 'x') {
+			for (size_t i = 2; i < line_len; i++) {
+				if (line[i] == '0')
+					zero_count++;
+				else if (line[i] != '\n')
+					non_zero_count++;
+			}
+			if (!non_zero_count) {
+				int ch;
+
+				if (first && !zero_count) {
+					/* Line was erroneous just '0x'. */
+					goto error;
+				}
+				/*
+				 * Line was 0x0..0, the sentinel for binutils. Remove
+				 * the function and filename lines.
+				 */
+				zfree(&line);
+				do {
+					ch = io__get_char(io);
+				} while (ch > 0 && ch != '\n');
+				do {
+					ch = io__get_char(io);
+				} while (ch > 0 && ch != '\n');
+				return 0;
 			}
-			/*
-			 * Line was 0x0..0, the sentinel for binutils. Remove
-			 * the function and filename lines.
-			 */
-			zfree(&line);
-			do {
-				ch = io__get_char(io);
-			} while (ch > 0 && ch != '\n');
-			do {
-				ch = io__get_char(io);
-			} while (ch > 0 && ch != '\n');
-			return 0;
 		}
 	}
-
-	/* Read the second function name line. */
-	if (io__getline(io, &line, &line_len) < 0 || !line_len)
+	/* Read the second function name line (if inline data then this is the first line). */
+	if (first && (io__getline(io, &line, &line_len) < 0 || !line_len))
 		goto error;
 
+	pr_debug("%s %s: addr2line read line: %s", __func__, dso_name, line);
 	if (function != NULL)
 		*function = strdup(strim(line));
 
@@ -581,6 +593,7 @@ static int read_addr2line_record(struct io *io,
 	if (io__getline(io, &line, &line_len) < 0 || !line_len)
 		goto error;
 
+	pr_debug("%s %s: addr2line filename:number : %s", __func__, dso_name, line);
 	if (filename_split(line, line_nr == NULL ? &dummy_line_nr : line_nr) == 0 &&
 	    style == GNU_BINUTILS) {
 		ret = 0;
@@ -640,8 +653,7 @@ static int addr2line(const char *dso_name, u64 addr,
 		if (!filename__has_section(dso_name, ".debug_line"))
 			goto out;
 
-		dso->a2l = addr2line_subprocess_init(symbol_conf.addr2line_path,
-						     dso_name);
+		dso->a2l = addr2line_subprocess_init(symbol_conf.addr2line_path, dso_name);
 		a2l = dso->a2l;
 	}
 
@@ -655,14 +667,13 @@ static int addr2line(const char *dso_name, u64 addr,
 		goto out;
 
 	/*
-	 * Send our request and then *deliberately* send something that can't be interpreted as
-	 * a valid address to ask addr2line about (namely, ","). This causes addr2line to first
-	 * write out the answer to our request, in an unbounded/unknown number of records, and
-	 * then to write out the lines "??" and "??:0", for GNU binutils, or "," for
-	 * llvm-addr2line, so that we can detect when it has finished giving us anything
-	 * useful. With GNU binutils, we have to be careful about the first record, though,
-	 * because it may be genuinely unknown, in which case we'll get two sets of "??"/"??:0"
-	 * lines.
+	 * Send our request and then *deliberately* send something that can't be
+	 * interpreted as a valid address to ask addr2line about (namely,
+	 * ","). This causes addr2line to first write out the answer to our
+	 * request, in an unbounded/unknown number of records, and then to write
+	 * out the lines "0x0...0", "??" and "??:0", for GNU binutils, or ","
+	 * for llvm-addr2line, so that we can detect when it has finished giving
+	 * us anything useful.
 	 */
 	len = snprintf(buf, sizeof(buf), "%016"PRIx64"\n,\n", addr);
 	written = len > 0 ? write(a2l->in, buf, len) : -1;
@@ -673,7 +684,7 @@ static int addr2line(const char *dso_name, u64 addr,
 	}
 	io__init(&io, a2l->out, buf, sizeof(buf));
 	io.timeout_ms = addr2line_timeout_ms;
-	switch (read_addr2line_record(&io, a2l_style,
+	switch (read_addr2line_record(&io, a2l_style, dso_name, addr, /*first=*/true,
 				      &record_function, &record_filename, &record_line_nr)) {
 	case -1:
 		if (!symbol_conf.disable_add2line_warn)
@@ -683,16 +694,21 @@ static int addr2line(const char *dso_name, u64 addr,
 		/*
 		 * The first record was invalid, so return failure, but first
 		 * read another record, since we sent a sentinel ',' for the
-		 * sake of detected the last inlined function.
+		 * sake of detected the last inlined function. Treat this as the
+		 * first of a record as the ',' generates a new start with GNU
+		 * binutils, also force a non-zero address as we're no longer
+		 * reading that record.
 		 */
-		switch (read_addr2line_record(&io, a2l_style, NULL, NULL, NULL)) {
+		switch (read_addr2line_record(&io, a2l_style, dso_name,
+					      /*addr=*/1, /*first=*/true,
+					      NULL, NULL, NULL)) {
 		case -1:
 			if (!symbol_conf.disable_add2line_warn)
-				pr_warning("%s %s: could not read delimiter record\n",
+				pr_warning("%s %s: could not read sentinel record\n",
 					   __func__, dso_name);
 			break;
 		case 0:
-			/* As expected. */
+			/* The sentinel as expected. */
 			break;
 		default:
 			if (!symbol_conf.disable_add2line_warn)
@@ -702,6 +718,7 @@ static int addr2line(const char *dso_name, u64 addr,
 		}
 		goto out;
 	default:
+		/* First record as expected. */
 		break;
 	}
 
@@ -722,9 +739,16 @@ static int addr2line(const char *dso_name, u64 addr,
 		}
 	}
 
-	/* We have to read the records even if we don't care about the inline info. */
+	/*
+	 * We have to read the records even if we don't care about the inline
+	 * info. This isn't the first record and force the address to non-zero
+	 * as we're reading records beyond the first.
+	 */
 	while ((record_status = read_addr2line_record(&io,
 						      a2l_style,
+						      dso_name,
+						      /*addr=*/1,
+						      /*first=*/false,
 						      &record_function,
 						      &record_filename,
 						      &record_line_nr)) == 1) {
-- 
2.41.0.162.gfafddb0af9-goog

