Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5354872D0ED
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237631AbjFLUrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236810AbjFLUq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:46:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8D2212D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:46:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A5D862BE6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E8EC4339E;
        Mon, 12 Jun 2023 20:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686602716;
        bh=fkkJpit5a3ZlIC5i/D5UeQi47Yy3csUMhtA5gdos6Dc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PmeopVKP2WJ1NEq6kcgJClk7k0JMV+ne7n8eOyk24uxhoBlYQ6lwWJyLOvbrsm/91
         cnNp9KRqzC7cWHAldCR8BbCGoFTukelLxJ8Em6+4Z8pshSIbpXYAYaXW6anrqAuPo/
         GbDgEF7AvgY0ufDwZ+UEhqf3ks2Qo9Ws8yNnb+VL2Sc6EndEHEuywqDCGfeUJdMBpc
         6B32RYs+Qe+8rp5cQCUHzlcRzzQVlvAG2qxC9q2/f/HHGfg+tETPFqyeBKhe9f2vvL
         EA+osJnQcCeSSUdqEXgXVCnFPH5/fjIJRdLo3kRs0zGKJLcnu94qklxGvJ4zSyntcT
         jUTR6N2nvuCrg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B65BECE3A3B; Mon, 12 Jun 2023 13:45:15 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 06/53] tools/nolibc: implement fd-based FILE streams
Date:   Mon, 12 Jun 2023 13:44:27 -0700
Message-Id: <20230612204514.292087-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
References: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/stdio.h | 95 ++++++++++++++++++++++++++----------
 1 file changed, 68 insertions(+), 27 deletions(-)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index 6cbbb52836a0..0eef91daf289 100644
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
2.40.1

