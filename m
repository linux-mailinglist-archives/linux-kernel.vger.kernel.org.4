Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C617225A1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 14:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbjFEM0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 08:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbjFEM0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 08:26:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A389E6;
        Mon,  5 Jun 2023 05:26:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA0E062343;
        Mon,  5 Jun 2023 12:26:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB104C433EF;
        Mon,  5 Jun 2023 12:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685967971;
        bh=96gl5J71hpxGYTZSluEX9KNvDN+//VJ4LSUDHkq6+E0=;
        h=From:To:Cc:Subject:Date:From;
        b=XnlHVXRTZphIw2VPrOzxCfSjEVVroDblhxmXrC28Qt8f6+KRN8HATipKW6BkjQ4iO
         kKhJ0CXLaHMTxi2PSGjg+ujshBV31ZWelUZoDd8IX9wgX3rgfzihMX66wzJ9vZmsOf
         9Kuzzxf0AMfKHlM4JEr0ZlTbyO64pVx6SUAvXcJ8eDYt6tVt3tnJfWTyxh2TiRmjyQ
         alHwGuNJ2G6fIKv+J67y4onlL17FkuPbFLjvG5upnin4VkQgabXDPU8qN1IFKasDJA
         bKvrtwXEdKzKZhWpMKCBWtV1QrCIjimzJvrxws4vqeI5L0rQAjScDxuU9qjYdaa++7
         zFNPkoDeZxdhA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] scripts/kallsyms: remove KSYM_NAME_LEN_BUFFER
Date:   Mon,  5 Jun 2023 21:26:04 +0900
Message-Id: <20230605122604.1826856-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You do not need to decide the buffer size statically.

Use getline() to grow the line buffer as needed.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kallsyms.c | 61 ++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 29 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 0d2db41177b2..fc9709839b19 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -19,6 +19,7 @@
  *
  */
 
+#include <errno.h>
 #include <getopt.h>
 #include <stdbool.h>
 #include <stdio.h>
@@ -29,24 +30,8 @@
 
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
 
-#define _stringify_1(x)	#x
-#define _stringify(x)	_stringify_1(x)
-
 #define KSYM_NAME_LEN		512
 
-/*
- * A substantially bigger size than the current maximum.
- *
- * It cannot be defined as an expression because it gets stringified
- * for the fscanf() format string. Therefore, a _Static_assert() is
- * used instead to maintain the relationship with KSYM_NAME_LEN.
- */
-#define KSYM_NAME_LEN_BUFFER	2048
-_Static_assert(
-	KSYM_NAME_LEN_BUFFER == KSYM_NAME_LEN * 4,
-	"Please keep KSYM_NAME_LEN_BUFFER in sync with KSYM_NAME_LEN"
-);
-
 struct sym_entry {
 	unsigned long long addr;
 	unsigned int len;
@@ -136,24 +121,40 @@ static void check_symbol_range(const char *sym, unsigned long long addr,
 	}
 }
 
-static struct sym_entry *read_symbol(FILE *in)
+static struct sym_entry *read_symbol(FILE *in, char **buf, size_t *buf_len)
 {
-	char name[KSYM_NAME_LEN_BUFFER+1], type;
+	char *name, type, *p;
 	unsigned long long addr;
-	unsigned int len;
+	size_t len;
+	ssize_t readlen;
 	struct sym_entry *sym;
-	int rc;
 
-	rc = fscanf(in, "%llx %c %" _stringify(KSYM_NAME_LEN_BUFFER) "s\n", &addr, &type, name);
-	if (rc != 3) {
-		if (rc != EOF && fgets(name, ARRAY_SIZE(name), in) == NULL)
-			fprintf(stderr, "Read error or end of file.\n");
+	readlen = getline(buf, buf_len, in);
+	if (readlen < 0) {
+		if (errno) {
+			perror("read_symbol");
+			exit(EXIT_FAILURE);
+		}
 		return NULL;
 	}
-	if (strlen(name) >= KSYM_NAME_LEN) {
+
+	if ((*buf)[readlen - 1] == '\n')
+		(*buf)[readlen - 1] = 0;
+
+	addr = strtoull(*buf, &p, 16);
+
+	if (*buf == p || *p++ != ' ' || !isascii((type = *p++)) || *p++ != ' ') {
+		fprintf(stderr, "line format error\n");
+		exit(EXIT_FAILURE);
+	}
+
+	name = p;
+	len = strlen(name);
+
+	if (len >= KSYM_NAME_LEN) {
 		fprintf(stderr, "Symbol %s too long for kallsyms (%zu >= %d).\n"
 				"Please increase KSYM_NAME_LEN both in kernel and kallsyms.c\n",
-			name, strlen(name), KSYM_NAME_LEN);
+			name, len, KSYM_NAME_LEN);
 		return NULL;
 	}
 
@@ -169,8 +170,7 @@ static struct sym_entry *read_symbol(FILE *in)
 
 	/* include the type field in the symbol name, so that it gets
 	 * compressed together */
-
-	len = strlen(name) + 1;
+	len++;
 
 	sym = malloc(sizeof(*sym) + len + 1);
 	if (!sym) {
@@ -257,6 +257,8 @@ static void read_map(const char *in)
 {
 	FILE *fp;
 	struct sym_entry *sym;
+	char *buf = NULL;
+	size_t buflen = 0;
 
 	fp = fopen(in, "r");
 	if (!fp) {
@@ -265,7 +267,7 @@ static void read_map(const char *in)
 	}
 
 	while (!feof(fp)) {
-		sym = read_symbol(fp);
+		sym = read_symbol(fp, &buf, &buflen);
 		if (!sym)
 			continue;
 
@@ -284,6 +286,7 @@ static void read_map(const char *in)
 		table[table_cnt++] = sym;
 	}
 
+	free(buf);
 	fclose(fp);
 }
 
-- 
2.39.2

