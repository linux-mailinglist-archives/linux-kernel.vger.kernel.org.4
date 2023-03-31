Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB996D1459
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 02:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjCaAtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 20:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjCaAtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 20:49:43 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B742611E8C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 17:49:31 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-544781e30easo202380017b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 17:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680223771;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7oxd+W11NuknN5NF+IipV44WcyCkZNF/Dx6bcDvAiT8=;
        b=KsdyLKvSEFbnoBYCu2r2O888p0VE6efe0Pok+IhIFZthAU349DLJX2KPXHXB/YmZ7v
         mqWXRt6Cui7RbnAl+H+RBTwTdjrkrkoOdWmkqGI60wgpg/VK4A0DjJkm1PxmV5wmsOx1
         /TeYIQRcpu8HeSdv+xV9cGuDj+CPMoM2H8xJezT2JtwjmZHXevlnRAxN2onqgLnXMkeA
         EJDZ/Nl86FZA8YtiYDFWL2Jm/bKeDJQwcYdL68R3O+T3zup/3G56JVWmzwmNq/aDsw+n
         uwF5zl6K2NJEFZLTHkC4NMlAfkl8xzX0aeG22x4iUU1azRjNX2TV5k4/fX69Dedt2TWV
         xFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680223771;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7oxd+W11NuknN5NF+IipV44WcyCkZNF/Dx6bcDvAiT8=;
        b=xlltQcVVNsE8U3tHsWSDCXhZReXyhn1GowxnbT81rQBydLLMbjylWbOmJMO3lb1uVW
         pFOrEzVfNLShLZqcCyEkjGgPihkb6mA1gtYcfb6aqqZyMobxrT6lDJmKMPR4YMLWqCAk
         3pnjWMq8vqJPN8EXzN6hf16CbWAoSIvaos6YIZziNuSuGQQWNglzeB/DmuDC6wSU5wC0
         epG6DHV/W1XHyFKp4P4NE/iRYuAIkGSMzCYnTVQtInCCpOX2kPT+byrt3+Dwo0hBzXVS
         AGB0tv+/tIYrDZaw0xju/L1bw+3qqb2BzczwXs6xzB0Lf5TAU+Sq2ve2v4EZe1aYTOLc
         nd3Q==
X-Gm-Message-State: AAQBX9feaByQrDpgmbASKfCauWULR3b0mgTT3z0vRiQuPMHaGwYldcRK
        ez7C1iBXOgFe1DNV7EeijUv/Xa2lPvU3
X-Google-Smtp-Source: AKy350bDVwr8m1Oc+vefnZXhKJxJxJ5yTGusejTrFkjb+CBfOpCsR2pfVEtuUYmLYwF0e9gCesDEytfcOd9V
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:11ea:eb75:e48c:2c04])
 (user=irogers job=sendgmr) by 2002:a05:6902:18cd:b0:b78:45fd:5f01 with SMTP
 id ck13-20020a05690218cd00b00b7845fd5f01mr15780898ybb.7.1680223770977; Thu,
 30 Mar 2023 17:49:30 -0700 (PDT)
Date:   Thu, 30 Mar 2023 17:48:43 -0700
In-Reply-To: <20230331004844.1592789-1-irogers@google.com>
Message-Id: <20230331004844.1592789-4-irogers@google.com>
Mime-Version: 1.0
References: <20230331004844.1592789-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v1 3/4] perf srcline: Support for llvm-addr2line
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
 tools/perf/util/srcline.c | 65 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 2da86e57215d..423ddf3967b0 100644
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
 
 	if (io__getline(&line, &line_len, io) < 0 || !line_len)
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
 	if (io__getline(&line, &line_len, io) < 0 || !line_len)
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
@@ -538,6 +589,12 @@ static int addr2line(const char *dso_name, u64 addr,
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
@@ -557,7 +614,8 @@ static int addr2line(const char *dso_name, u64 addr,
 	}
 	io__init(&io, a2l->out, buf, sizeof(buf));
 
-	switch (read_addr2line_record(&io, &record_function, &record_filename, &record_line_nr)) {
+	switch (read_addr2line_record(&io, a2l_style,
+				      &record_function, &record_filename, &record_line_nr)) {
 	case -1:
 		if (!symbol_conf.disable_add2line_warn)
 			pr_warning("%s %s: could not read first record\n", __func__, dso_name);
@@ -567,7 +625,7 @@ static int addr2line(const char *dso_name, u64 addr,
 		 * The first record was invalid, so return failure, but first read another
 		 * record, since we asked a junk question and have to clear the answer out.
 		 */
-		switch (read_addr2line_record(&io, NULL, NULL, NULL)) {
+		switch (read_addr2line_record(&io, a2l_style, NULL, NULL, NULL)) {
 		case -1:
 			if (!symbol_conf.disable_add2line_warn)
 				pr_warning("%s %s: could not read delimiter record\n",
@@ -606,6 +664,7 @@ static int addr2line(const char *dso_name, u64 addr,
 
 	/* We have to read the records even if we don't care about the inline info. */
 	while ((record_status = read_addr2line_record(&io,
+						      a2l_style,
 						      &record_function,
 						      &record_filename,
 						      &record_line_nr)) == 1) {
-- 
2.40.0.348.gf938b09366-goog

