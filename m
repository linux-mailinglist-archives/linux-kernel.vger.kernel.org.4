Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA39E72D83C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 05:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238920AbjFMDsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 23:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238436AbjFMDs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 23:48:27 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131B71A5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:48:26 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b3e2394342so4759235ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686628105; x=1689220105;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fh2/X2DcjKAgDqPnWnfxRkgvpF2RX/19bu1FUWmY1oo=;
        b=ktMCYKQ23y92/hFOFI1dvQheIMyTrdBS0U8C++VW/iCieaMrRtxM5Ct/36PbJLIphs
         JGI4VsBQPdkq1yi7u84/wAmZb8hJo/JVnk5MNi3+Y48rG/RAzAnqZFwfAn5xwvPp+1vT
         HArBuorD5V/4Q+LfGAqFRDB9C1UakZUEgx/PhiZLGJKQepkoRcgtv4wz1612gAVabnFE
         GuaY0U3+QBfi8/1cKSXR4zrTsH/xtkCalsMUEEO7CSBZ6/PgK4x8i2fpJfUcrye0hFWs
         GkhmujpGKlzEetDXKC5I6NFamIH2KXyEbicxcKSeaBWVuUrBphkRbyVA1gAEYzigkM7Y
         Wq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686628105; x=1689220105;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fh2/X2DcjKAgDqPnWnfxRkgvpF2RX/19bu1FUWmY1oo=;
        b=Dr4YSmJuymJ+vHB3Xp9AInB9ng3hyokDbE24VrqYZVCT40hgk7mBdoxJCZUVj6uTYx
         BDFK1DW0wwVVTd89JcAEhlfdv1OqgxPwIxfPaeii/ehUGPdMwx9oJxVSJ2E3J7h4D2RK
         g8x/kJ/Tg6ekUqENV8enpBQShspNVgE8BMTH/SkHkOrekHmSvj520AxD8iCEY+sBywhL
         GRfCNqTHzFTdUbwopYsNbE5yllKUhH+M1o1Jmq5dsZLHmG1HUZ9RAIHJUl4yS7RRXTGI
         zFRzQ/lXEHGDp8RSZ92ivgfRo+KZDzjubE2qeQro+Gka/VLCgdKMRkH/IKXwc6nfZMrj
         s0ig==
X-Gm-Message-State: AC+VfDyw6scB8q9HQ24DroeGvD4tz5xFxawwiuF404WMznrcBnjFvkw4
        kbREGVxPonWHN4XX8WTetigAn48BbTAE
X-Google-Smtp-Source: ACHHUZ6sciJjzxG2hplUQW0FOprYaYkTntl16jRWZeKa85E/pH8Sl+A0VM6bQ4Kbr8NlTIaWDuF06RNycYll
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a704:56d6:f79d:33e7])
 (user=irogers job=sendgmr) by 2002:a17:902:e5d1:b0:1ac:3f51:fa64 with SMTP id
 u17-20020a170902e5d100b001ac3f51fa64mr1598921plf.13.1686628105441; Mon, 12
 Jun 2023 20:48:25 -0700 (PDT)
Date:   Mon, 12 Jun 2023 20:48:17 -0700
In-Reply-To: <20230613034817.1356114-1-irogers@google.com>
Message-Id: <20230613034817.1356114-3-irogers@google.com>
Mime-Version: 1.0
References: <20230613034817.1356114-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 2/2] perf srcline: Make sentinel reading for binutils
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
index d477332586b2..b27b4b3c391b 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -408,7 +408,7 @@ static struct child_process *addr2line_subprocess_init(const char *addr2line_pat
 	const char *argv[] = {
 		addr2line_path ?: "addr2line",
 		"-e", binary_path,
-		"-i", "-f", NULL
+		"-a", "-i", "-f", NULL
 	};
 	struct child_process *a2l = zalloc(sizeof(*a2l));
 	int start_command_status = 0;
@@ -463,10 +463,10 @@ static enum a2l_style addr2line_configure(struct child_process *a2l, const char
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
 				char *output = NULL;
@@ -518,20 +518,64 @@ static int read_addr2line_record(struct io *io,
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
+			else if (line[i] != '\n')
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
 
@@ -635,8 +679,9 @@ static int addr2line(const char *dso_name, u64 addr,
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

