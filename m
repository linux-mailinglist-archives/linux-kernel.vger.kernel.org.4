Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B566D39E7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 20:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjDBSsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 14:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjDBSsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 14:48:42 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8FAB9018
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 11:48:32 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 332ImDKm012490;
        Sun, 2 Apr 2023 20:48:13 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux@weissschuh.net, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 4/4] tools/nolibc: add testcases for vfprintf
Date:   Sun,  2 Apr 2023 20:48:06 +0200
Message-Id: <20230402184806.12440-5-w@1wt.eu>
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

vfprintf() is complex and so far did not have proper tests.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 86 ++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 1bafbd8da6af..888da60eb5ba 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -20,6 +20,7 @@
 #include <linux/reboot.h>
 #include <sys/io.h>
 #include <sys/ioctl.h>
+#include <sys/mman.h>
 #include <sys/mount.h>
 #include <sys/reboot.h>
 #include <sys/stat.h>
@@ -669,6 +670,90 @@ int run_stdlib(int min, int max)
 	return ret;
 }
 
+#define EXPECT_VFPRINTF(c, expected, fmt, ...)				\
+	ret += expect_vfprintf(llen, c, expected, fmt, ##__VA_ARGS__)
+
+static int expect_vfprintf(int llen, size_t c, const char *expected, const char *fmt, ...)
+{
+	int ret, fd, w, r;
+	char buf[100];
+	FILE *memfile;
+	va_list args;
+
+	fd = memfd_create("vfprintf", 0);
+	if (fd == -1) {
+		pad_spc(llen, 64, "[FAIL]\n");
+		return 1;
+	}
+
+	memfile = fdopen(fd, "w+");
+	if (!memfile) {
+		pad_spc(llen, 64, "[FAIL]\n");
+		return 1;
+	}
+
+	va_start(args, fmt);
+	w = vfprintf(memfile, fmt, args);
+	va_end(args);
+
+	if (w != c) {
+		llen += printf(" written(%d) != %d", w, (int) c);
+		pad_spc(llen, 64, "[FAIL]\n");
+		return 1;
+	}
+
+	fflush(memfile);
+	lseek(fd, 0, SEEK_SET);
+
+	r = read(fd, buf, sizeof(buf) - 1);
+	buf[r] = '\0';
+
+	fclose(memfile);
+
+	if (r != w) {
+		llen += printf(" written(%d) != read(%d)", w, r);
+		pad_spc(llen, 64, "[FAIL]\n");
+		return 1;
+	}
+
+	llen += printf(" \"%s\" = \"%s\"", expected, buf);
+	ret = strncmp(expected, buf, c);
+
+	pad_spc(llen, 64, ret ? "[FAIL]\n" : " [OK]\n");
+	return ret;
+}
+
+static int run_vfprintf(int min, int max)
+{
+	int test;
+	int tmp;
+	int ret = 0;
+	void *p1, *p2;
+
+	for (test = min; test >= 0 && test <= max; test++) {
+		int llen = 0; // line length
+
+		/* avoid leaving empty lines below, this will insert holes into
+		 * test numbers.
+		 */
+		switch (test + __LINE__ + 1) {
+		CASE_TEST(empty);        EXPECT_VFPRINTF(0, "", ""); break;
+		CASE_TEST(simple);       EXPECT_VFPRINTF(3, "foo", "foo"); break;
+		CASE_TEST(string);       EXPECT_VFPRINTF(3, "foo", "%s", "foo"); break;
+		CASE_TEST(number);       EXPECT_VFPRINTF(4, "1234", "%d", 1234); break;
+		CASE_TEST(negnumber);    EXPECT_VFPRINTF(5, "-1234", "%d", -1234); break;
+		CASE_TEST(unsigned);     EXPECT_VFPRINTF(5, "12345", "%u", 12345); break;
+		CASE_TEST(char);         EXPECT_VFPRINTF(1, "c", "%c", 'c'); break;
+		CASE_TEST(hex);          EXPECT_VFPRINTF(1, "f", "%x", 0xf); break;
+		CASE_TEST(pointer);      EXPECT_VFPRINTF(3, "0x1", "%p", (void *) 0x1); break;
+		case __LINE__:
+			return ret; /* must be last */
+		/* note: do not set any defaults so as to permit holes above */
+		}
+	}
+	return ret;
+}
+
 static int smash_stack(void)
 {
 	char buf[100];
@@ -777,6 +862,7 @@ static const struct test test_names[] = {
 	/* add new tests here */
 	{ .name = "syscall",    .func = run_syscall    },
 	{ .name = "stdlib",     .func = run_stdlib     },
+	{ .name = "vfprintf",   .func = run_vfprintf   },
 	{ .name = "protection", .func = run_protection },
 	{ 0 }
 };
-- 
2.17.5

