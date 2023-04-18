Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAF26E5C69
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 10:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjDRIro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 04:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjDRIrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 04:47:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1EE3A9B;
        Tue, 18 Apr 2023 01:47:39 -0700 (PDT)
Date:   Tue, 18 Apr 2023 08:47:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681807658;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DW9A8g3/oAk3v/A00iyN2Xu69bbeEhnxtHkQPD6d1TY=;
        b=tIQfulbk5OvsQv11RPOjwQulcrjB3sr+BdVS62F38qTA2MJtxy1L2GTwiFcPm50l7YIn+C
        7iAUY4/12LNcntzY8/6FyUQZ8zKNHtod1jDjPk3OSiNKw1k/RYURalQpqCSPIcuDaOXEcI
        zjtBCO5csr5QB38jMbOC9QDToE0wyV0OCPpMMjA340YkATC43JVgLoS7vVScsJrsorrLAi
        N5uxHYg8FYqfGhWFQTeDeqfu3VsmMKiCzuemCv+2xer/5m675rXv+YbvjFPSDmhPbWuZka
        iIlqLp/zUaM1Pfv08Rrgob//Z8anJy3g7q0Bj4rh6T8dZVXP4/6iw1sx9KcKkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681807658;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DW9A8g3/oAk3v/A00iyN2Xu69bbeEhnxtHkQPD6d1TY=;
        b=tIpsSkBlrvZkwjHVaiciq5x3LniBoOZ2yAi2qws5uvG9gkQNFRow+Of7fDavTSyVNs1sYu
        OiVuJ3z+SUZkBQDw==
From:   "tip-bot2 for Gregory Price" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] selftest, ptrace: Add selftest for syscall user
 dispatch config api
Cc:     Gregory Price <gregory.price@memverge.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230407171834.3558-5-gregory.price@memverge.com>
References: <20230407171834.3558-5-gregory.price@memverge.com>
MIME-Version: 1.0
Message-ID: <168180765788.404.7470709952569487395.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     8c8fa605f7b8b6df3e6fb280a74cff8d7374a7b7
Gitweb:        https://git.kernel.org/tip/8c8fa605f7b8b6df3e6fb280a74cff8d7374a7b7
Author:        Gregory Price <gourry.memverge@gmail.com>
AuthorDate:    Fri, 07 Apr 2023 13:18:34 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 16 Apr 2023 14:23:08 +02:00

selftest, ptrace: Add selftest for syscall user dispatch config api

Validate that the following new ptrace requests work as expected

 * PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG
   returns the contents of task->syscall_dispatch

 * PTRACE_SET_SYSCALL_USER_DISPATCH_CONFIG
   sets the contents of task->syscall_dispatch

Signed-off-by: Gregory Price <gregory.price@memverge.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230407171834.3558-5-gregory.price@memverge.com

---
 tools/testing/selftests/ptrace/.gitignore    |  1 +-
 tools/testing/selftests/ptrace/Makefile      |  2 +-
 tools/testing/selftests/ptrace/get_set_sud.c | 72 +++++++++++++++++++-
 3 files changed, 74 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/ptrace/get_set_sud.c

diff --git a/tools/testing/selftests/ptrace/.gitignore b/tools/testing/selftests/ptrace/.gitignore
index 792318a..b7dde15 100644
--- a/tools/testing/selftests/ptrace/.gitignore
+++ b/tools/testing/selftests/ptrace/.gitignore
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 get_syscall_info
+get_set_sud
 peeksiginfo
 vmaccess
diff --git a/tools/testing/selftests/ptrace/Makefile b/tools/testing/selftests/ptrace/Makefile
index 96ffa94..1c63174 100644
--- a/tools/testing/selftests/ptrace/Makefile
+++ b/tools/testing/selftests/ptrace/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -std=c99 -pthread -Wall $(KHDR_INCLUDES)
 
-TEST_GEN_PROGS := get_syscall_info peeksiginfo vmaccess
+TEST_GEN_PROGS := get_syscall_info peeksiginfo vmaccess get_set_sud
 
 include ../lib.mk
diff --git a/tools/testing/selftests/ptrace/get_set_sud.c b/tools/testing/selftests/ptrace/get_set_sud.c
new file mode 100644
index 0000000..5297b10
--- /dev/null
+++ b/tools/testing/selftests/ptrace/get_set_sud.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include "../kselftest_harness.h"
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+#include <sys/wait.h>
+#include <sys/syscall.h>
+#include <sys/prctl.h>
+
+#include "linux/ptrace.h"
+
+static int sys_ptrace(int request, pid_t pid, void *addr, void *data)
+{
+	return syscall(SYS_ptrace, request, pid, addr, data);
+}
+
+TEST(get_set_sud)
+{
+	struct ptrace_sud_config config;
+	pid_t child;
+	int ret = 0;
+	int status;
+
+	child = fork();
+	ASSERT_GE(child, 0);
+	if (child == 0) {
+		ASSERT_EQ(0, sys_ptrace(PTRACE_TRACEME, 0, 0, 0)) {
+			TH_LOG("PTRACE_TRACEME: %m");
+		}
+		kill(getpid(), SIGSTOP);
+		_exit(1);
+	}
+
+	waitpid(child, &status, 0);
+
+	memset(&config, 0xff, sizeof(config));
+	config.mode = PR_SYS_DISPATCH_ON;
+
+	ret = sys_ptrace(PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG, child,
+			 (void *)sizeof(config), &config);
+
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(config.mode, PR_SYS_DISPATCH_OFF);
+	ASSERT_EQ(config.selector, 0);
+	ASSERT_EQ(config.offset, 0);
+	ASSERT_EQ(config.len, 0);
+
+	config.mode = PR_SYS_DISPATCH_ON;
+	config.selector = 0;
+	config.offset = 0x400000;
+	config.len = 0x1000;
+
+	ret = sys_ptrace(PTRACE_SET_SYSCALL_USER_DISPATCH_CONFIG, child,
+			 (void *)sizeof(config), &config);
+
+	ASSERT_EQ(ret, 0);
+
+	memset(&config, 1, sizeof(config));
+	ret = sys_ptrace(PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG, child,
+			 (void *)sizeof(config), &config);
+
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(config.mode, PR_SYS_DISPATCH_ON);
+	ASSERT_EQ(config.selector, 0);
+	ASSERT_EQ(config.offset, 0x400000);
+	ASSERT_EQ(config.len, 0x1000);
+
+	kill(child, SIGKILL);
+}
+
+TEST_HARNESS_MAIN
