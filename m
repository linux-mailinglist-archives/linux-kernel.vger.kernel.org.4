Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E3172D83B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 05:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238802AbjFMDsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 23:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237433AbjFMDsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 23:48:24 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71841A7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:48:23 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56ce36fca90so52024207b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686628103; x=1689220103;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TFZEItTTBrSMUTBa58hKToUNkL4hMjjE5NbhujtdO6I=;
        b=sugIE8oskjJ0EeMybjZLw2QY8Hop8AEO4OtW23PCZWE3F2bKKMHhNiXsuJibFMMwGY
         o9JgVx3RwVyXpJif3Mj0k++i5lcshtCZnCpjD/0lbvoSGBi706rw/3HTUpwfpFDvvt6l
         R6JaGfUsg2ChbI9Lc4oNoQv9vp5k7VhrG92rk80H8sY6fT26z8Ca/LkSYbkAvWc+QHUc
         BND3MS/YPcPWMpbzXKIwqGGX3fonvC56Y6UQmkLh82amrlb3pdC3yS4MZuJZs68mxOWk
         Cv0L66ytK2vloI75LBX8XZkCUE0i8sfwHJkGWso6uGWxJuyaKFCWKdf09TQYNwDpwhPA
         Cn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686628103; x=1689220103;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TFZEItTTBrSMUTBa58hKToUNkL4hMjjE5NbhujtdO6I=;
        b=fij7qE+Y/v3+Ug+ouMdwOM0Rtns7YKw3gaPRY/jo0l6dYqq1KoCL12Iz5vQBuUGyqO
         TIHP+TsuPRwE2jFT88bdqeJFIb9U4TR585aqOE/K/N21D5+OptU/p2P5uQ58DHI1mPWO
         LNap+9pQ6gg/SpQWWOvwkp2OX3omqub3IXnm1qxxv9zOagjrwmYuaJdQkqdCvab1qEf2
         C/Rydea5T7QiGoPTiBAiIGeApPMY2lN5myjyYsTa+LkwVG8LDhhRi2rZ3EDf2S/b70lP
         jMaMhFQ+qFh9s8Sk/aovrJbJS7MpX+slxnr7vjGDZfeQKZVfkbhFImiiAE6ytbc4YLPy
         hHfw==
X-Gm-Message-State: AC+VfDyVdGB6hfSUspXPTmFTiF6+2jNrAyZNL8zb6BMHESiHzTL/gt81
        7dnaG7jkcqATCOt6TJHkiWi1Dq/5t6Yr
X-Google-Smtp-Source: ACHHUZ79nD4tHJp4BftcjKhgpKXuJELFAbzCZiWZNM9q+2bGeEAnsJjQvM5m0L1KgjOvrfxsRqfOhuz5toHp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a704:56d6:f79d:33e7])
 (user=irogers job=sendgmr) by 2002:a25:361f:0:b0:bc8:c749:eede with SMTP id
 d31-20020a25361f000000b00bc8c749eedemr299027yba.7.1686628102944; Mon, 12 Jun
 2023 20:48:22 -0700 (PDT)
Date:   Mon, 12 Jun 2023 20:48:16 -0700
In-Reply-To: <20230613034817.1356114-1-irogers@google.com>
Message-Id: <20230613034817.1356114-2-irogers@google.com>
Mime-Version: 1.0
References: <20230613034817.1356114-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 1/2] perf srcline: Make addr2line configuration failure
 more verbose
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
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Changbin Du <changbin.du@huawei.com>
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

To aid debugging why it fails. Also, combine the loops for reading a
line for the llvm/binutils cases.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/srcline.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index aec596a0b0bb..d477332586b2 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -443,7 +443,7 @@ enum a2l_style {
 	LLVM,
 };
 
-static enum a2l_style addr2line_configure(struct child_process *a2l)
+static enum a2l_style addr2line_configure(struct child_process *a2l, const char *dso_name)
 {
 	static bool cached;
 	static enum a2l_style style;
@@ -452,6 +452,7 @@ static enum a2l_style addr2line_configure(struct child_process *a2l)
 		char buf[128];
 		struct io io;
 		int ch;
+		int lines;
 
 		if (write(a2l->in, ",\n", 2) != 2)
 			return BROKEN;
@@ -461,19 +462,29 @@ static enum a2l_style addr2line_configure(struct child_process *a2l)
 		if (ch == ',') {
 			style = LLVM;
 			cached = true;
+			lines = 1;
 		} else if (ch == '?') {
 			style = GNU_BINUTILS;
 			cached = true;
+			lines = 2;
 		} else {
-			style = BROKEN;
+			if (!symbol_conf.disable_add2line_warn) {
+				char *output = NULL;
+				size_t output_len;
+
+				io__getline(&io, &output, &output_len);
+				pr_warning("%s %s: addr2line configuration failed\n",
+					   __func__, dso_name);
+				pr_warning("\t%c%s", ch, output);
+			}
+			return BROKEN;
 		}
-		do {
+		while (lines) {
 			ch = io__get_char(&io);
-		} while (ch > 0 && ch != '\n');
-		if (style == GNU_BINUTILS) {
-			do {
-				ch = io__get_char(&io);
-			} while (ch > 0 && ch != '\n');
+			if (ch <= 0)
+				break;
+			if (ch == '\n')
+				lines--;
 		}
 		/* Ignore SIGPIPE in the event addr2line exits. */
 		signal(SIGPIPE, SIG_IGN);
@@ -593,12 +604,9 @@ static int addr2line(const char *dso_name, u64 addr,
 			pr_warning("%s %s: addr2line_subprocess_init failed\n", __func__, dso_name);
 		goto out;
 	}
-	a2l_style = addr2line_configure(a2l);
-	if (a2l_style == BROKEN) {
-		if (!symbol_conf.disable_add2line_warn)
-			pr_warning("%s: addr2line configuration failed\n", __func__);
+	a2l_style = addr2line_configure(a2l, dso_name);
+	if (a2l_style == BROKEN)
 		goto out;
-	}
 
 	/*
 	 * Send our request and then *deliberately* send something that can't be interpreted as
-- 
2.41.0.162.gfafddb0af9-goog

