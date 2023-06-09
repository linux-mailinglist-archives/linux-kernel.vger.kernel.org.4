Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419D872A6E4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 01:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjFIXyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 19:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjFIXya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 19:54:30 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87D135B0
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 16:54:28 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bb397723627so2798914276.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 16:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686354868; x=1688946868;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cZRa8J45tSEoIBwwMfP3oeiIjnBxryB3tiHQ4mYVspA=;
        b=A0YP3D1MDS6ipDOhIWcopNNcD1QYcBlz/2xVJXWlJnEcbGaUxeiAs8tAUYkIngCOa8
         MQo2PIbwQsXAFY1yuFQGkjf3bvgbdqa3mrQBK2i0yIO5RLeYwe/tpXG6AkOgOrci1IM6
         ee3XPIDjmnxTfAdqa01/cUYTAwXqQaBt3LihZqFiSQfj+Jb56vCWeBQ0D7e3X0KHZvuN
         yynmKcETGjwSFfENJ2wUnkXz3Ho9B6qnkXADkQCciNzXPJ2rCD22RrDxLcS5y4lyZldw
         C5JPSBAZ0ooPspDHdyJ11GeQVbOA4ixy1f+h1W52hL6Td8d6Y+NofNCoJTEmAYSVrDGh
         4PwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686354868; x=1688946868;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cZRa8J45tSEoIBwwMfP3oeiIjnBxryB3tiHQ4mYVspA=;
        b=FXZwumC8j2AbujeCu7vNAEcVvo+3j4hD/M4azzb3F4MLMT7pIqIWleC0IsGw+jjkad
         YO6Rb1oIEo1mEk6hZ5uLDVRJpEQk8h8mEeHDE2iLObiyDbbRyENxVNGtPzOQXQoKA8Cl
         LUpvmvrOneq/Pa/5NKYr1Na5LkYOLh86lJCcU2sN0g7G3N7jDbnZPFCjziY0BoTfejNf
         l9NEjbsedxkIfRtg/nNRNw1+l9pyB1WP6dhsxSgSERWYBdeffu2zQcnyyrI8oeeUmEeA
         iIhneLwBk83bhzD2XD3SP4Y0buLStknDPuVYp/DzeO6RkbADUTCz3lZHwSmu4HnkHVxo
         SVGA==
X-Gm-Message-State: AC+VfDzaM7Bw4KdMMTILhcRtmq2pS0+RkiCWUX3d02uX7Zl0VRvremQq
        V6OffsFf6NtDoEFV8HPf9EXMXRRBqXue
X-Google-Smtp-Source: ACHHUZ5r3Yz2yKKHzyS3K5w8FkkkyUAesFC0U/xNjOAbG5oeaKw2Nxnz2IOd1Bgz+HxxkgCovA9JoZEHUQJh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:55f2:1922:c44b:472d])
 (user=irogers job=sendgmr) by 2002:a05:6902:1085:b0:ba8:cbd2:61b3 with SMTP
 id v5-20020a056902108500b00ba8cbd261b3mr731327ybu.5.1686354868009; Fri, 09
 Jun 2023 16:54:28 -0700 (PDT)
Date:   Fri,  9 Jun 2023 16:54:18 -0700
Message-Id: <20230609235419.204624-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 1/2] perf srcline: Make addr2line configuration failure
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
index b8e596528d7e..fc85cdd6c8f9 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -441,7 +441,7 @@ enum a2l_style {
 	LLVM,
 };
 
-static enum a2l_style addr2line_configure(struct child_process *a2l)
+static enum a2l_style addr2line_configure(struct child_process *a2l, const char *dso_name)
 {
 	static bool cached;
 	static enum a2l_style style;
@@ -450,6 +450,7 @@ static enum a2l_style addr2line_configure(struct child_process *a2l)
 		char buf[128];
 		struct io io;
 		int ch;
+		int lines;
 
 		if (write(a2l->in, ",\n", 2) != 2)
 			return BROKEN;
@@ -459,19 +460,29 @@ static enum a2l_style addr2line_configure(struct child_process *a2l)
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
+				char *output;
+				size_t output_len;
+
+				io__getline(&io, &output, &output_len);
+				pr_warning("%s %s: addr2line configuration failed\n",
+					   __func__, dso_name);
+				pr_warning("\t%c%s\n", ch, output);
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
@@ -591,12 +602,9 @@ static int addr2line(const char *dso_name, u64 addr,
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

