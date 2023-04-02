Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65846D39E6
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 20:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjDBSsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 14:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjDBSs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 14:48:29 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9BB2A6A59
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 11:48:25 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 332ImDTk012489;
        Sun, 2 Apr 2023 20:48:13 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux@weissschuh.net, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 3/4] tools/nolibc: implement fd-based FILE streams
Date:   Sun,  2 Apr 2023 20:48:05 +0200
Message-Id: <20230402184806.12440-4-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20230402184806.12440-1-w@1wt.eu>
References: <20230402184806.12440-1-w@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Weißschuh <linux@weissschuh.net>

This enables the usage of the stream APIs with arbitrary filedescriptors.

It will be used by a future testcase.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/stdio.h | 95 ++++++++++++++++++++++++++----------
 1 file changed, 68 insertions(+), 27 deletions(-)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index 96ac8afc5aee..4add736c07aa 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -21,17 +21,75 @@
 #define EOF (-1)
 #endif
 
-/* just define FILE as a non-empty type */
+/* just define FILE as a non-empty type. The value of the pointer gives
+ * the FD: FILE=~fd for fd>=0 or NULL for fd<0. This way positive FILE
+ * are immediately identified as abnormal entries (i.e. possible copies
+ * of valid pointers to something else).
+ */
 typedef struct FILE {
 	char dummy[1];
 } FILE;
 
-/* We define the 3 common stdio files as constant invalid pointers that
- * are easily recognized.
- */
-static __attribute__((unused)) FILE* const stdin  = (FILE*)-3;
-static __attribute__((unused)) FILE* const stdout = (FILE*)-2;
-static __attribute__((unused)) FILE* const stderr = (FILE*)-1;
+static __attribute__((unused)) FILE* const stdin  = (FILE*)(intptr_t)~STDIN_FILENO;
+static __attribute__((unused)) FILE* const stdout = (FILE*)(intptr_t)~STDOUT_FILENO;
+static __attribute__((unused)) FILE* const stderr = (FILE*)(intptr_t)~STDERR_FILENO;
+
+/* provides a FILE* equivalent of fd. The mode is ignored. */
+static __attribute__((unused))
+FILE *fdopen(int fd, const char *mode __attribute__((unused)))
+{
+	if (fd < 0) {
+		SET_ERRNO(EBADF);
+		return NULL;
+	}
+	return (FILE*)(intptr_t)~fd;
+}
+
+/* provides the fd of stream. */
+static __attribute__((unused))
+int fileno(FILE *stream)
+{
+	intptr_t i = (intptr_t)stream;
+
+	if (i >= 0) {
+		SET_ERRNO(EBADF);
+		return -1;
+	}
+	return ~i;
+}
+
+/* flush a stream. */
+static __attribute__((unused))
+int fflush(FILE *stream)
+{
+	intptr_t i = (intptr_t)stream;
+
+	/* NULL is valid here. */
+	if (i > 0) {
+		SET_ERRNO(EBADF);
+		return -1;
+	}
+
+	/* Don't do anything, nolibc does not support buffering. */
+	return 0;
+}
+
+/* flush a stream. */
+static __attribute__((unused))
+int fclose(FILE *stream)
+{
+	intptr_t i = (intptr_t)stream;
+
+	if (i >= 0) {
+		SET_ERRNO(EBADF);
+		return -1;
+	}
+
+	if (close(~i))
+		return EOF;
+
+	return 0;
+}
 
 /* getc(), fgetc(), getchar() */
 
@@ -41,14 +99,8 @@ static __attribute__((unused))
 int fgetc(FILE* stream)
 {
 	unsigned char ch;
-	int fd;
 
-	if (stream < stdin || stream > stderr)
-		return EOF;
-
-	fd = 3 + (long)stream;
-
-	if (read(fd, &ch, 1) <= 0)
+	if (read(fileno(stream), &ch, 1) <= 0)
 		return EOF;
 	return ch;
 }
@@ -68,14 +120,8 @@ static __attribute__((unused))
 int fputc(int c, FILE* stream)
 {
 	unsigned char ch = c;
-	int fd;
-
-	if (stream < stdin || stream > stderr)
-		return EOF;
-
-	fd = 3 + (long)stream;
 
-	if (write(fd, &ch, 1) <= 0)
+	if (write(fileno(stream), &ch, 1) <= 0)
 		return EOF;
 	return ch;
 }
@@ -96,12 +142,7 @@ static __attribute__((unused))
 int _fwrite(const void *buf, size_t size, FILE *stream)
 {
 	ssize_t ret;
-	int fd;
-
-	if (stream < stdin || stream > stderr)
-		return EOF;
-
-	fd = 3 + (long)stream;
+	int fd = fileno(stream);
 
 	while (size) {
 		ret = write(fd, buf, size);
-- 
2.17.5

