Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2536272D102
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238179AbjFLUtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237673AbjFLUrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:47:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D52C1BE5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:46:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A99C062F16
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BDEBC43325;
        Mon, 12 Jun 2023 20:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686602717;
        bh=N9vHg92hQf/Gt8IdTsnnfWQj4zqBnDUs4128W6vih/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iBqkFKk36EhtaWtPZU3rgUuxmTtfv97JaYZTgokAM7xcRt/22Jd6rGrNGFPWOBG63
         xO4W8Cww3Yh5hfTupDtDNm0birqBzS4PNmnAtJpZnPST7SAICqEIZPgQO6HIoAp0qG
         H2F2Yt6Ef/HxDEyry02VutbT0YRSKV1RnwldHrd+caLpGfUxGTULdxUZUtbDHZF0WU
         +Z7ltdnbFdZvH7aPjVONZJQVNBWSg1QqWspwR+//JJQSslcD1lklBs/5DpQ0ZNQ4G7
         TjlsYXhWa3n0PN1oLzbza6wdU3Z8zjZVYgai71XbHhyAiUQUfyhAHYpeilM1hrOhSj
         uNLF9+M2qEsCA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 01E0ACE3A7D; Mon, 12 Jun 2023 13:45:16 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 34/53] tools/nolibc: add support for prctl()
Date:   Mon, 12 Jun 2023 13:44:55 -0700
Message-Id: <20230612204514.292087-34-paulmck@kernel.org>
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

It will be used to disable core dumps from the child spawned to validate
the stack protector functionality.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/sys.h                   | 27 ++++++++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index d5792a5de70b..c688b410f9e4 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -22,6 +22,7 @@
 #include <linux/fcntl.h> /* for O_* and AT_* */
 #include <linux/stat.h>  /* for statx() */
 #include <linux/reboot.h> /* for LINUX_REBOOT_* */
+#include <linux/prctl.h>
 
 #include "arch.h"
 #include "errno.h"
@@ -875,6 +876,32 @@ int open(const char *path, int flags, ...)
 }
 
 
+/*
+ * int prctl(int option, unsigned long arg2, unsigned long arg3,
+ *                       unsigned long arg4, unsigned long arg5);
+ */
+
+static __attribute__((unused))
+int sys_prctl(int option, unsigned long arg2, unsigned long arg3,
+		          unsigned long arg4, unsigned long arg5)
+{
+	return my_syscall5(__NR_prctl, option, arg2, arg3, arg4, arg5);
+}
+
+static __attribute__((unused))
+int prctl(int option, unsigned long arg2, unsigned long arg3,
+		      unsigned long arg4, unsigned long arg5)
+{
+	int ret = sys_prctl(option, arg2, arg3, arg4, arg5);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
+
 /*
  * int pivot_root(const char *new, const char *old);
  */
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index b50b5a8bcc90..6db788603a34 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -22,6 +22,7 @@
 #include <sys/ioctl.h>
 #include <sys/mman.h>
 #include <sys/mount.h>
+#include <sys/prctl.h>
 #include <sys/reboot.h>
 #include <sys/stat.h>
 #include <sys/syscall.h>
@@ -580,6 +581,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(poll_null);         EXPECT_SYSZR(1, poll(NULL, 0, 0)); break;
 		CASE_TEST(poll_stdout);       EXPECT_SYSNE(1, ({ struct pollfd fds = { 1, POLLOUT, 0}; poll(&fds, 1, 0); }), -1); break;
 		CASE_TEST(poll_fault);        EXPECT_SYSER(1, poll((void *)1, 1, 0), -1, EFAULT); break;
+		CASE_TEST(prctl);             EXPECT_SYSER(1, prctl(PR_SET_NAME, (unsigned long)NULL, 0, 0, 0), -1, EFAULT); break;
 		CASE_TEST(read_badf);         EXPECT_SYSER(1, read(-1, &tmp, 1), -1, EBADF); break;
 		CASE_TEST(sched_yield);       EXPECT_SYSZR(1, sched_yield()); break;
 		CASE_TEST(select_null);       EXPECT_SYSZR(1, ({ struct timeval tv = { 0 }; select(0, NULL, NULL, NULL, &tv); })); break;
-- 
2.40.1

