Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA156C51C6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjCVREZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjCVRDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:03:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD397EF4;
        Wed, 22 Mar 2023 10:03:24 -0700 (PDT)
Date:   Wed, 22 Mar 2023 17:03:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679504584;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=oMpc9GjKiKzOfugOngBxJGxql9QSACRvf4WRe2BBm6A=;
        b=TS6XD55S8eqCToqI2HYTyXG+RtH1536/AxgS+wdhM1sxa63H5PzKrqyZWNXXo0bd3hVUoT
        KwaDBs9rhznGr1IiQ04/7zEHDjmLBK/l4Sl+JXOPHpnP9g6rv1+H6l6SDUBPkPZ4TOgVnA
        yMFrSDR9K6m5rwyC9IeqZJVofLrzVRcasQDNjvdfXDpTjzUpTDaj97UyFVsQ7gDgmRCqLg
        8b2ayxMMNgJGtDHoWQiffgCzbMJLGbb/J4C6gf0iL0mhKokVfhZrmGPMuNNw3c8ObCU85/
        zwfQ+FETIFthrW3tM62CkaSmXh8dPa5gdzbGmNr3LAN+Y/ndbcPJDm+LnWnN/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679504584;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=oMpc9GjKiKzOfugOngBxJGxql9QSACRvf4WRe2BBm6A=;
        b=vyTai8vbjRdm3AWvO0Tw3/AgtspWxK0LNutUUvlBV59ryVhov0StvaFNmnwY0fHl21ABdK
        VAYtGVow+jDsJNDg==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] selftests/x86/lam: Add test cases for LAM vs thread creation
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167950458385.5837.2205725754203915953.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     dfd7a1569e25996575a24725b64f73162155bcd6
Gitweb:        https://git.kernel.org/tip/dfd7a1569e25996575a24725b64f73162155bcd6
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Sun, 12 Mar 2023 14:26:12 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 16 Mar 2023 13:08:41 -07:00

selftests/x86/lam: Add test cases for LAM vs thread creation

LAM enabling is only allowed when the process has single thread.
LAM mode is inherited into child thread.

Trying to enable LAM after spawning a thread has to fail.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20230312112612.31869-18-kirill.shutemov%40linux.intel.com
---
 tools/testing/selftests/x86/lam.c | 92 ++++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+)

diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index a8c9182..eb0e469 100644
--- a/tools/testing/selftests/x86/lam.c
+++ b/tools/testing/selftests/x86/lam.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -12,6 +13,7 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <inttypes.h>
+#include <sched.h>
 
 #include <sys/uio.h>
 #include <linux/io_uring.h>
@@ -50,6 +52,8 @@
 
 #define PAGE_SIZE               (4 << 10)
 
+#define STACK_SIZE		65536
+
 #define barrier() ({						\
 		   __asm__ __volatile__("" : : : "memory");	\
 })
@@ -731,6 +735,75 @@ static int handle_inheritance(struct testcases *test)
 	return 0;
 }
 
+static int thread_fn_get_lam(void *arg)
+{
+	return get_lam();
+}
+
+static int thread_fn_set_lam(void *arg)
+{
+	struct testcases *test = arg;
+
+	return set_lam(test->lam);
+}
+
+static int handle_thread(struct testcases *test)
+{
+	char stack[STACK_SIZE];
+	int ret, child_ret;
+	int lam = 0;
+	pid_t pid;
+
+	/* Set LAM mode in parent process */
+	if (!test->later) {
+		lam = test->lam;
+		if (set_lam(lam) != 0)
+			return 1;
+	}
+
+	pid = clone(thread_fn_get_lam, stack + STACK_SIZE,
+		    SIGCHLD | CLONE_FILES | CLONE_FS | CLONE_VM, NULL);
+	if (pid < 0) {
+		perror("Clone failed.");
+		return 1;
+	}
+
+	waitpid(pid, &child_ret, 0);
+	ret = WEXITSTATUS(child_ret);
+
+	if (lam != ret)
+		return 1;
+
+	if (test->later) {
+		if (set_lam(test->lam) != 0)
+			return 1;
+	}
+
+	return 0;
+}
+
+static int handle_thread_enable(struct testcases *test)
+{
+	char stack[STACK_SIZE];
+	int ret, child_ret;
+	int lam = test->lam;
+	pid_t pid;
+
+	pid = clone(thread_fn_set_lam, stack + STACK_SIZE,
+		    SIGCHLD | CLONE_FILES | CLONE_FS | CLONE_VM, test);
+	if (pid < 0) {
+		perror("Clone failed.");
+		return 1;
+	}
+
+	waitpid(pid, &child_ret, 0);
+	ret = WEXITSTATUS(child_ret);
+
+	if (lam != ret)
+		return 1;
+
+	return 0;
+}
 static void run_test(struct testcases *test, int count)
 {
 	int i, ret = 0;
@@ -849,6 +922,25 @@ static struct testcases inheritance_cases[] = {
 	{
 		.expected = 0,
 		.lam = LAM_U57_BITS,
+		.test_func = handle_thread,
+		.msg = "THREAD: LAM_U57, child thread should get LAM mode same as parent\n",
+	},
+	{
+		.expected = 1,
+		.lam = LAM_U57_BITS,
+		.test_func = handle_thread_enable,
+		.msg = "THREAD: [NEGATIVE] Enable LAM in child.\n",
+	},
+	{
+		.expected = 1,
+		.later = 1,
+		.lam = LAM_U57_BITS,
+		.test_func = handle_thread,
+		.msg = "THREAD: [NEGATIVE] Enable LAM in parent after thread created.\n",
+	},
+	{
+		.expected = 0,
+		.lam = LAM_U57_BITS,
 		.test_func = handle_execve,
 		.msg = "EXECVE: LAM_U57, child process should get disabled LAM mode\n",
 	},
