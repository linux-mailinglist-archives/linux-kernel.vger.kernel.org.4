Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2996C8F12
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 16:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjCYPp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 11:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjCYPpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 11:45:49 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8CFEA12589
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 08:45:47 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 32PFjQOW008051;
        Sat, 25 Mar 2023 16:45:26 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux@weissschuh.net, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 6/8] tools/nolibc: tests: add test for -fstack-protector
Date:   Sat, 25 Mar 2023 16:45:14 +0100
Message-Id: <20230325154516.7995-7-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20230325154516.7995-1-w@1wt.eu>
References: <20230325154516.7995-1-w@1wt.eu>
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

Test the previously introduce stack protector functionality in nolibc.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/testing/selftests/nolibc/Makefile      |  3 +
 tools/testing/selftests/nolibc/nolibc-test.c | 62 +++++++++++++++++++-
 2 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 4469dcb0c9d7..e516e53775d4 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -76,6 +76,9 @@ else
 Q=@
 endif
 
+CFLAGS_STACKPROTECTOR = -DNOLIBC_STACKPROTECTOR \
+			$(call cc-option,-mstack-protector-guard=global) \
+			$(call cc-option,-fstack-protector-all)
 CFLAGS_s390 = -m64
 CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables \
 		$(call cc-option,-fno-stack-protector) \
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index fb2d4872fac9..21bacc928bf7 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -667,6 +667,63 @@ int run_stdlib(int min, int max)
 	return ret;
 }
 
+#if defined(__clang__)
+__attribute__((optnone))
+#elif defined(__GNUC__)
+__attribute__((optimize("O0")))
+#endif
+static int smash_stack(void)
+{
+	char buf[100];
+
+	for (size_t i = 0; i < 200; i++)
+		buf[i] = 'P';
+
+	return 1;
+}
+
+static int run_protection(int min, int max)
+{
+	pid_t pid;
+	int llen = 0, status;
+
+	llen += printf("0 -fstackprotector ");
+
+#if !defined(NOLIBC_STACKPROTECTOR)
+	llen += printf("not supported");
+	pad_spc(llen, 64, "[SKIPPED]\n");
+	return 0;
+#endif
+
+	pid = -1;
+	pid = fork();
+
+	switch (pid) {
+	case -1:
+		llen += printf("fork()");
+		pad_spc(llen, 64, "[FAIL]\n");
+		return 1;
+
+	case 0:
+		close(STDOUT_FILENO);
+		close(STDERR_FILENO);
+
+		smash_stack();
+		return 1;
+
+	default:
+		pid = waitpid(pid, &status, 0);
+
+		if (pid == -1 || !WIFSIGNALED(status) || WTERMSIG(status) != SIGABRT) {
+			llen += printf("waitpid()");
+			pad_spc(llen, 64, "[FAIL]\n");
+			return 1;
+		}
+		pad_spc(llen, 64, " [OK]\n");
+		return 0;
+	}
+}
+
 /* prepare what needs to be prepared for pid 1 (stdio, /dev, /proc, etc) */
 int prepare(void)
 {
@@ -719,8 +776,9 @@ int prepare(void)
 /* This is the definition of known test names, with their functions */
 static const struct test test_names[] = {
 	/* add new tests here */
-	{ .name = "syscall",   .func = run_syscall  },
-	{ .name = "stdlib",    .func = run_stdlib   },
+	{ .name = "syscall",    .func = run_syscall    },
+	{ .name = "stdlib",     .func = run_stdlib     },
+	{ .name = "protection", .func = run_protection },
 	{ 0 }
 };
 
-- 
2.17.5

