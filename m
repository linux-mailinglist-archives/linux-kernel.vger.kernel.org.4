Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7C072A6E5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 01:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbjFIXyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 19:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjFIXyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 19:54:32 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D843835B1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 16:54:30 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba87bd29e9dso3232552276.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 16:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686354870; x=1688946870;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oNyUS02eW/yXFIAlgFDfwEmFoe9Pd7uSEDgKLORvHjM=;
        b=V11apG9LHOwhutH46QHmQ0gFKrfNaC6p1CizyVW65E2n8EhG+rIvmW285qgxYWdy68
         Am892SzAOwS/ktZ92R2Inm+9rHnmpjZH5EtYHOE9rLiXEl33z6EZLwsx3lkKfCfkYfNa
         dnpiTxRdkt2Aha2k3I1IdY+WUUBb6EnCjBrF+YbO1s2z1W1d4daY7/xMLd+PqX6c2ZN7
         1l4pasEPgSopAcpHBehgcFW+gl/CqZK9N+iAoO9Xm2e0ZieeV+dpSeNsvOeXcKMNRuf4
         /fEJf+7N7JW8da5CtMIl/WIre12zkDa/wtXnudrUI7oozutQxWyOqfMhHfJ4n0RSogMw
         bEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686354870; x=1688946870;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oNyUS02eW/yXFIAlgFDfwEmFoe9Pd7uSEDgKLORvHjM=;
        b=Rvv0JZh43e03lm9TBreyyfKYcdiEBirxaSCQszUpr3jMfmPfQagJgYe9j02UqvdvPJ
         0rrV9TWZdqRB8iZGk19fNMg/pXtFtVHC2fNCW2e3qSE9Fu7hC/DX95uv1+PInt7XeqdK
         KAKVzld/9tYggJvnwp3co1EftbsqN6Zc/onbSVgUrzyvxqPq93lrHO/9C610aFiAuI6l
         xOsJHbb7Ihi97Wv6XAVT6eUPFt0j79NmKZP2bl7v0SZ3AFfF21OEbB10kypXW2k+Oxqd
         7uUNqyCbpbku0KaaMJ36lq+Y7XL5VHXkCnYg7JKBNyCFNOVUAPNg8Y9N4adYbfXBGWeQ
         KLGw==
X-Gm-Message-State: AC+VfDzAE/w/dRHvDPRRh0w7VC6JJThNC1y2A0eEqn4uBO8qqvfGnb/T
        Ok8FBN7FGFELYPDqjzUWDY2Tm75/978v
X-Google-Smtp-Source: ACHHUZ4PMyCkdCSyENQFYB0qETjtjOg/fcbawc434c4hu5aAPdXX7kCJC4yurstliqdU7VqpZ+H7i4hZQlWz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:55f2:1922:c44b:472d])
 (user=irogers job=sendgmr) by 2002:a25:da09:0:b0:bbe:8486:5895 with SMTP id
 n9-20020a25da09000000b00bbe84865895mr1408283ybf.1.1686354870144; Fri, 09 Jun
 2023 16:54:30 -0700 (PDT)
Date:   Fri,  9 Jun 2023 16:54:19 -0700
In-Reply-To: <20230609235419.204624-1-irogers@google.com>
Message-Id: <20230609235419.204624-2-irogers@google.com>
Mime-Version: 1.0
References: <20230609235419.204624-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 2/2] perf srcline: Make sentinel reading for binutils
 addr2line more robust
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

The addr2line process is sent an address then multiple function,
filename:line "records" are read. To detect the end of output a ',' is
sent and for llvm-addr2line a ',' is then read back showing the end of
addrline's output. For binutils addr2line the ',' translates to
address 0 and we expect the bogus filename marker "??:0" (see
filename_split) to be sent from addr2line. For some kernels address 0
may have a mapping and so a seemingly valid inline output is given and
breaking the sentinel discovery:

```
$ addr2line -e vmlinux -f -i
,
__per_cpu_start
./arch/x86/kernel/cpu/common.c:1850
```

To avoid this problem enable the address dumping for addr2line (the -a
option). If an address of 0x0000000000000000 is read then this is the
sentinel value working around the problem above. The filename_split
still needs to check for "??:0" as bogus non-zero addresses also need
handling.

Reported-by: Changbin Du <changbin.du@huawei.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/srcline.c | 61 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 53 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index fc85cdd6c8f9..c99a001453b4 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -406,7 +406,7 @@ static struct child_process *addr2line_subprocess_init(const char *addr2line_pat
 	const char *argv[] = {
 		addr2line_path ?: "addr2line",
 		"-e", binary_path,
-		"-i", "-f", NULL
+		"-a", "-i", "-f", NULL
 	};
 	struct child_process *a2l = zalloc(sizeof(*a2l));
 	int start_command_status = 0;
@@ -461,10 +461,10 @@ static enum a2l_style addr2line_configure(struct child_process *a2l, const char
 			style = LLVM;
 			cached = true;
 			lines = 1;
-		} else if (ch == '?') {
+		} else if (ch == '0') {
 			style = GNU_BINUTILS;
 			cached = true;
-			lines = 2;
+			lines = 3;
 		} else {
 			if (!symbol_conf.disable_add2line_warn) {
 				char *output;
@@ -516,20 +516,64 @@ static int read_addr2line_record(struct io *io,
 	if (line_nr != NULL)
 		*line_nr = 0;
 
+	/*
+	 * Read the first line. Without an error this will be either an address
+	 * like 0x1234 or for llvm-addr2line the sentinal ',' character.
+	 */
 	if (io__getline(io, &line, &line_len) < 0 || !line_len)
 		goto error;
 
-	if (style == LLVM && line_len == 2 && line[0] == ',') {
-		zfree(&line);
-		return 0;
+	if (style == LLVM) {
+		if (line_len == 2 && line[0] == ',') {
+			zfree(&line);
+			return 0;
+		}
+	} else {
+		int zero_count = 0, non_zero_count = 0;
+
+		/* The address should always start 0x. */
+		if (line_len < 2 || line[0] != '0' || line[1] != 'x')
+			goto error;
+
+		for (size_t i = 2; i < line_len; i++) {
+			if (line[i] == '0')
+				zero_count++;
+			else
+				non_zero_count++;
+		}
+		if (!non_zero_count) {
+			int ch;
+
+			if (!zero_count) {
+				/* Line was erroneous just '0x'. */
+				goto error;
+			}
+			/*
+			 * Line was 0x0..0, the sentinel for binutils. Remove
+			 * the function and filename lines.
+			 */
+			zfree(&line);
+			do {
+				ch = io__get_char(io);
+			} while (ch > 0 && ch != '\n');
+			do {
+				ch = io__get_char(io);
+			} while (ch > 0 && ch != '\n');
+			return 0;
+		}
 	}
 
+	/* Read the second function name line. */
+	if (io__getline(io, &line, &line_len) < 0 || !line_len)
+		goto error;
+
 	if (function != NULL)
 		*function = strdup(strim(line));
 
 	zfree(&line);
 	line_len = 0;
 
+	/* Read the third filename and line number line. */
 	if (io__getline(io, &line, &line_len) < 0 || !line_len)
 		goto error;
 
@@ -633,8 +677,9 @@ static int addr2line(const char *dso_name, u64 addr,
 		goto out;
 	case 0:
 		/*
-		 * The first record was invalid, so return failure, but first read another
-		 * record, since we asked a junk question and have to clear the answer out.
+		 * The first record was invalid, so return failure, but first
+		 * read another record, since we sent a sentinel ',' for the
+		 * sake of detected the last inlined function.
 		 */
 		switch (read_addr2line_record(&io, a2l_style, NULL, NULL, NULL)) {
 		case -1:
-- 
2.41.0.162.gfafddb0af9-goog

