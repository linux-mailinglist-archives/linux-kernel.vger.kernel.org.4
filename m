Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3F5708458
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjEROzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbjEROza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:55:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC91B12E
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:55:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 593BE64FE7
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 14:55:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A0BC433A1;
        Thu, 18 May 2023 14:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684421723;
        bh=gpgpcEtunmdu9Bwe6EgvPNpLf5lDxIDNN1gL/ShrEz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=exJk6fUVzzcyLzaPPr1taRHEZh0enXf1X54640PYulffd2Un8/j2KA8Feo1md9LgI
         1CuSNHS5L0wTj1uTNGuX87n0GgdB2jVRR7ETNCPskPSGWU9mbpgOJ9b0ytdnugd46U
         tZtjuDYRpME60oJpLRivbDIFJ2HG7TC/yBd2j9V5tgkrboOQBHHIq8CoNwqfh8kJIG
         XAVFNmTb+BL/8DZSqHamFBEkbEcGYfJjCvzV84YQ/OGRE1AvzrOB0XKK9189rI3WhY
         s9eO+V5bXAN6IReEILoVlzcxi2nay734ud7jeinMmh7s/tzSgMTENPUaXXefackw0M
         X/mx0OoI4Vp0w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 21BAECE1431; Thu, 18 May 2023 07:55:23 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 07/15] tools/nolibc: add testcases for vfprintf
Date:   Thu, 18 May 2023 07:55:13 -0700
Message-Id: <20230518145521.3806117-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <4817a4dc-69e6-4937-84d5-f2f630ff646c@paulmck-laptop>
References: <4817a4dc-69e6-4937-84d5-f2f630ff646c@paulmck-laptop>
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

vfprintf() is complex and so far did not have proper tests.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
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
2.40.1

