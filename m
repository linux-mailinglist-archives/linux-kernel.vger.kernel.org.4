Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA10660D31
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 10:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjAGJS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 04:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbjAGJSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 04:18:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C8885CA1;
        Sat,  7 Jan 2023 01:18:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 890F4B81E27;
        Sat,  7 Jan 2023 09:18:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBDF0C433EF;
        Sat,  7 Jan 2023 09:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673083116;
        bh=3blh9oSLoNamYh9NWhbTPvhef5a0zDqGldGZ48E9Mzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aYFrVZsSxtozAFBliQDD+/luTh0CNzwFpi7rWPds/UZKlSWGjyYgOvdKxJhDSQ+np
         gJM4hFTHTQEF8rKIc7gkHohVr+/7cisXwIeURF3GCQHRHB0igW58rslk9dz4Xr/HOE
         x7Nm8wYipQLXGRATGpDsBoqBe4OPy2PwwXgxk6LvNeC158W2le0NVcoTBs21inxxgc
         yGZZOwEJEXiXiyJo2wXUDrZEOBh9jEe763vpel6hjZ3AT2xumHeNdnGNF9GFk0VLxn
         FDWv/ESfxPMgZ7lHMR3XEuE1yJxcQOAxLyx1+C4d6Bfn0WOoKfX0xeeir0x1S9lUvV
         erLPkTGrfvgGQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        llvm@lists.linux.dev
Subject: [PATCH v2 3/7] fixdep: parse Makefile more correctly to handle comments etc.
Date:   Sat,  7 Jan 2023 18:18:16 +0900
Message-Id: <20230107091820.3382134-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230107091820.3382134-1-masahiroy@kernel.org>
References: <20230107091820.3382134-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixdep parses dependency files (*.d) emitted by the compiler.

*.d files are Makefiles describing the dependencies of the main source
file.

fixdep understands minimal Makefile syntax. It works well enough for
GCC and Clang, but not for rustc.

This commit improves the parser a little more for better processing
comments, escape sequences, etc.

My main motivation is to drop comments. rustc may output comments
(e.g. env-dep). Currentyly, rustc build rules invoke sed to remove
comments, but it is more efficient to do it in fixdep.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Acked-by: Miguel Ojeda <ojeda@kernel.org>
Tested-by: Miguel Ojeda <ojeda@kernel.org>
---

Changes in v2:
  - Rename searching_colon -> is_target
  - More comments

 scripts/basic/fixdep.c | 173 ++++++++++++++++++++++++++++-------------
 1 file changed, 119 insertions(+), 54 deletions(-)

diff --git a/scripts/basic/fixdep.c b/scripts/basic/fixdep.c
index 37782a632494..f5a51770eb74 100644
--- a/scripts/basic/fixdep.c
+++ b/scripts/basic/fixdep.c
@@ -94,6 +94,7 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <string.h>
+#include <stdbool.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <ctype.h>
@@ -251,75 +252,139 @@ static int is_ignored_file(const char *s, int len)
  * assignments are parsed not only by make, but also by the rather simple
  * parser in scripts/mod/sumversion.c.
  */
-static void parse_dep_file(char *m, const char *target)
+static void parse_dep_file(char *p, const char *target)
 {
-	char *p;
-	int is_last, is_target;
-	int saw_any_target = 0;
-	int is_first_dep = 0;
-	void *buf;
-
-	while (1) {
-		/* Skip any "white space" */
-		while (*m == ' ' || *m == '\\' || *m == '\n')
-			m++;
-
-		if (!*m)
+	bool saw_any_target = false;
+	bool is_target = true;
+	bool is_source = false;
+	bool need_parse;
+	char *q, saved_c;
+
+	while (*p) {
+		/* handle some special characters first. */
+		switch (*p) {
+		case '#':
+			/*
+			 * skip comments.
+			 * rustc may emit comments to dep-info.
+			 */
+			p++;
+			while (*p != '\0' && *p != '\n') {
+				/*
+				 * escaped newlines continue the comment across
+				 * multiple lines.
+				 */
+				if (*p == '\\')
+					p++;
+				p++;
+			}
+			continue;
+		case ' ':
+		case '\t':
+			/* skip whitespaces */
+			p++;
+			continue;
+		case '\\':
+			/*
+			 * backslash/newline combinations continue the
+			 * statement. Skip it just like a whitespace.
+			 */
+			if (*(p + 1) == '\n') {
+				p += 2;
+				continue;
+			}
 			break;
-
-		/* Find next "white space" */
-		p = m;
-		while (*p && *p != ' ' && *p != '\\' && *p != '\n')
+		case '\n':
+			/*
+			 * Makefiles use a line-based syntax, where the newline
+			 * is the end of a statement. After seeing a newline,
+			 * we expect the next token is a target.
+			 */
 			p++;
-		is_last = (*p == '\0');
-		/* Is the token we found a target name? */
-		is_target = (*(p-1) == ':');
-		/* Don't write any target names into the dependency file */
-		if (is_target) {
-			/* The /next/ file is the first dependency */
-			is_first_dep = 1;
-		} else if (!is_ignored_file(m, p - m)) {
-			*p = '\0';
-
+			is_target = true;
+			continue;
+		case ':':
 			/*
-			 * Do not list the source file as dependency, so that
-			 * kbuild is not confused if a .c file is rewritten
-			 * into .S or vice versa. Storing it in source_* is
-			 * needed for modpost to compute srcversions.
+			 * assume the first dependency after a colon as the
+			 * source file.
 			 */
-			if (is_first_dep) {
+			p++;
+			is_target = false;
+			is_source = true;
+			continue;
+		}
+
+		/* find the end of the token */
+		q = p;
+		while (*q != ' ' && *q != '\t' && *q != '\n' && *q != '#' && *q != ':') {
+			if (*q == '\\') {
 				/*
-				 * If processing the concatenation of multiple
-				 * dependency files, only process the first
-				 * target name, which will be the original
-				 * source name, and ignore any other target
-				 * names, which will be intermediate temporary
-				 * files.
+				 * backslash/newline combinations work like as
+				 * a whitespace, so this is the end of token.
 				 */
-				if (!saw_any_target) {
-					saw_any_target = 1;
-					printf("source_%s := %s\n\n",
-					       target, m);
-					printf("deps_%s := \\\n", target);
+				if (*(q + 1) == '\n')
+					break;
+
+				/* escaped special characters */
+				if (*(q + 1) == '#' || *(q + 1) == ':') {
+					memmove(p + 1, p, q - p);
+					p++;
 				}
-				is_first_dep = 0;
-			} else {
-				printf("  %s \\\n", m);
+
+				q++;
 			}
 
-			buf = read_file(m);
-			parse_config_file(buf);
-			free(buf);
+			if (*q == '\0')
+				break;
+			q++;
 		}
 
-		if (is_last)
-			break;
+		/* Just discard the target */
+		if (is_target) {
+			p = q;
+			continue;
+		}
+
+		saved_c = *q;
+		*q = '\0';
+		need_parse = false;
 
 		/*
-		 * Start searching for next token immediately after the first
-		 * "whitespace" character that follows this token.
+		 * Do not list the source file as dependency, so that kbuild is
+		 * not confused if a .c file is rewritten into .S or vice versa.
+		 * Storing it in source_* is needed for modpost to compute
+		 * srcversions.
 		 */
-		m = p + 1;
+		if (is_source) {
+			/*
+			 * The DT build rule concatenates multiple dep files.
+			 * When processing them, only process the first source
+			 * name, which will be the original one, and ignore any
+			 * other source names, which will be intermediate
+			 * temporary files.
+			 */
+			if (!saw_any_target) {
+				saw_any_target = true;
+				printf("source_%s := %s\n\n", target, p);
+				printf("deps_%s := \\\n", target);
+				need_parse = true;
+			}
+		} else if (!is_ignored_file(p, q - p)) {
+			printf("  %s \\\n", p);
+			need_parse = true;
+		}
+
+		if (need_parse) {
+			void *buf;
+
+			buf = read_file(p);
+			parse_config_file(buf);
+			free(buf);
+		}
+
+		is_source = false;
+		*q = saved_c;
+		p = q;
 	}
 
 	if (!saw_any_target) {
-- 
2.34.1

