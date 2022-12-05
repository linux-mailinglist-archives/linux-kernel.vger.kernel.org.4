Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE2B643644
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbiLEVAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbiLEVA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:00:26 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DAB725E92;
        Mon,  5 Dec 2022 13:00:25 -0800 (PST)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.50.127])
        by linux.microsoft.com (Postfix) with ESMTPSA id 47A6620B83F0;
        Mon,  5 Dec 2022 13:00:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 47A6620B83F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1670274025;
        bh=aWHxZ0Rug7dYGjaDIv7NPEAr23iSo6VpFSdzAk+Y29c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LGENb5yQV0gnJWjlbBNY65hjR9H8xV4kgRhiZinbVbYTrVwaaktNKqCrXoUGhrf2i
         9JAXUwVonzeMPVXbIlvF/xVN30pLj+sNifk7Z7pd8J4wmjq8DT4GcbhljLgQhDp10A
         1dCexfWij1QP6XTBcAT213PV+RUs9ZX0IRIdqIFo=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, dcook@linux.microsoft.com,
        alanau@linux.microsoft.com, brauner@kernel.org,
        akpm@linux-foundation.org
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 07/11] tracing/user_events: Add ABI self-test
Date:   Mon,  5 Dec 2022 13:00:13 -0800
Message-Id: <20221205210017.23440-8-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221205210017.23440-1-beaub@linux.microsoft.com>
References: <20221205210017.23440-1-beaub@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ABI specific self-test to ensure enablements work in various
scenarios such as fork, VM_CLONE, and basic event enable/disable.
Ensure ABI contracts/limits are also being upheld, such as bit limits
and data size limits.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 tools/testing/selftests/user_events/Makefile  |   2 +-
 .../testing/selftests/user_events/abi_test.c  | 228 ++++++++++++++++++
 2 files changed, 229 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/user_events/abi_test.c

diff --git a/tools/testing/selftests/user_events/Makefile b/tools/testing/selftests/user_events/Makefile
index c765d8635d9a..d5f64ef93197 100644
--- a/tools/testing/selftests/user_events/Makefile
+++ b/tools/testing/selftests/user_events/Makefile
@@ -2,7 +2,7 @@
 CFLAGS += -Wl,-no-as-needed -Wall -I../../../../usr/include
 LDLIBS += -lrt -lpthread -lm
 
-TEST_GEN_PROGS = ftrace_test dyn_test perf_test
+TEST_GEN_PROGS = ftrace_test dyn_test perf_test abi_test
 
 TEST_FILES := settings
 
diff --git a/tools/testing/selftests/user_events/abi_test.c b/tools/testing/selftests/user_events/abi_test.c
new file mode 100644
index 000000000000..aab387af2a66
--- /dev/null
+++ b/tools/testing/selftests/user_events/abi_test.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * User Events ABI Test Program
+ *
+ * Copyright (c) 2022 Beau Belgrave <beaub@linux.microsoft.com>
+ */
+
+#define _GNU_SOURCE
+#include <sched.h>
+
+#include <errno.h>
+#include <linux/user_events.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <asm/unistd.h>
+
+#include "../kselftest_harness.h"
+
+const char *data_file = "/sys/kernel/tracing/user_events_data";
+const char *enable_file = "/sys/kernel/tracing/events/user_events/__abi_event/enable";
+
+static int change_event(bool enable)
+{
+	int fd = open(enable_file, O_RDWR);
+	int ret;
+
+	if (fd < 0)
+		return -1;
+
+	if (enable)
+		ret = write(fd, "1", 1);
+	else
+		ret = write(fd, "0", 1);
+
+	close(fd);
+
+	if (ret == 1)
+		ret = 0;
+	else
+		ret = -1;
+
+	return ret;
+}
+
+static int reg_enable(long *enable, int size, int bit)
+{
+	struct user_reg reg = {0};
+	int fd = open(data_file, O_RDWR);
+	int ret;
+
+	if (fd < 0)
+		return -1;
+
+	reg.size = sizeof(reg);
+	reg.name_args = (__u64)"__abi_event";
+	reg.enable_bit = bit;
+	reg.enable_addr = (__u64)enable;
+	reg.enable_size = size;
+
+	ret = ioctl(fd, DIAG_IOCSREG, &reg);
+
+	close(fd);
+
+	return ret;
+}
+
+static int reg_disable(long *enable, int bit)
+{
+	struct user_unreg reg = {0};
+	int fd = open(data_file, O_RDWR);
+	int ret;
+
+	if (fd < 0)
+		return -1;
+
+	reg.size = sizeof(reg);
+	reg.disable_bit = bit;
+	reg.disable_addr = (__u64)enable;
+
+	ret = ioctl(fd, DIAG_IOCSUNREG, &reg);
+
+	close(fd);
+
+	return ret;
+}
+
+FIXTURE(user) {
+	long check;
+};
+
+FIXTURE_SETUP(user) {
+	change_event(false);
+	self->check = 0;
+}
+
+FIXTURE_TEARDOWN(user) {
+}
+
+TEST_F(user, enablement) {
+	/* Changes should be reflected immediately */
+	ASSERT_EQ(0, self->check);
+	ASSERT_EQ(0, reg_enable(&self->check, sizeof(int), 0));
+	ASSERT_EQ(0, change_event(true));
+	ASSERT_EQ(1, self->check);
+	ASSERT_EQ(0, change_event(false));
+	ASSERT_EQ(0, self->check);
+
+	/* Should not change after disable */
+	ASSERT_EQ(0, change_event(true));
+	ASSERT_EQ(1, self->check);
+	ASSERT_EQ(0, reg_disable(&self->check, 0));
+	ASSERT_EQ(0, change_event(false));
+	ASSERT_EQ(1, self->check);
+	self->check = 0;
+}
+
+TEST_F(user, bit_sizes) {
+	/* Allow 0-31 bits for 32-bit */
+	ASSERT_EQ(0, reg_enable(&self->check, sizeof(int), 0));
+	ASSERT_EQ(0, reg_enable(&self->check, sizeof(int), 31));
+	ASSERT_NE(0, reg_enable(&self->check, sizeof(int), 32));
+	ASSERT_EQ(0, reg_disable(&self->check, 0));
+	ASSERT_EQ(0, reg_disable(&self->check, 31));
+
+#if BITS_PER_LONG == 8
+	/* Allow 0-64 bits for 64-bit */
+	ASSERT_EQ(0, reg_enable(&self->check, sizeof(long), 63));
+	ASSERT_NE(0, reg_enable(&self->check, sizeof(long), 64));
+	ASSERT_EQ(0, reg_disable(&self->check, 63));
+#endif
+
+	/* Disallowed sizes (everything beside 4 and 8) */
+	ASSERT_NE(0, reg_enable(&self->check, 1, 0));
+	ASSERT_NE(0, reg_enable(&self->check, 2, 0));
+	ASSERT_NE(0, reg_enable(&self->check, 3, 0));
+	ASSERT_NE(0, reg_enable(&self->check, 5, 0));
+	ASSERT_NE(0, reg_enable(&self->check, 6, 0));
+	ASSERT_NE(0, reg_enable(&self->check, 7, 0));
+	ASSERT_NE(0, reg_enable(&self->check, 9, 0));
+	ASSERT_NE(0, reg_enable(&self->check, 128, 0));
+}
+
+TEST_F(user, forks) {
+	int i;
+
+	/* Ensure COW pages get updated after fork */
+	ASSERT_EQ(0, reg_enable(&self->check, sizeof(int), 0));
+	ASSERT_EQ(0, self->check);
+
+	if (fork() == 0) {
+		/* Force COW */
+		self->check = 0;
+
+		/* Up to 1 sec for enablement */
+		for (i=0; i<10; ++i) {
+			usleep(100000);
+
+			if (self->check)
+				exit(0);
+		}
+
+		exit(1);
+	}
+
+	/* Allow generous time for COW, then enable */
+	usleep(100000);
+	ASSERT_EQ(0, change_event(true));
+
+	ASSERT_NE(-1, wait(&i));
+	ASSERT_EQ(0, WEXITSTATUS(i));
+
+	/* Ensure child doesn't disable parent */
+	if (fork() == 0) {
+		exit(reg_disable(&self->check, 0));
+	}
+
+	ASSERT_NE(-1, wait(&i));
+	ASSERT_EQ(0, WEXITSTATUS(i));
+	ASSERT_EQ(1, self->check);
+	ASSERT_EQ(0, change_event(false));
+	ASSERT_EQ(0, self->check);
+}
+
+/* Waits up to 1 sec for enablement */
+static int clone_check(void *check)
+{
+	int i;
+
+	for (i=0; i<10; ++i) {
+		usleep(100000);
+
+		if (*(long *)check) {
+			return 0;
+		}
+	}
+
+	return 1;
+}	
+
+TEST_F(user, clones) {
+	int i, stack_size = 4096;
+	void *stack = mmap(NULL, stack_size, PROT_READ | PROT_WRITE,
+			   MAP_PRIVATE | MAP_ANONYMOUS | MAP_STACK,
+			   -1, 0);
+
+	ASSERT_NE(MAP_FAILED, stack);
+	ASSERT_EQ(0, reg_enable(&self->check, sizeof(int), 0));
+	ASSERT_EQ(0, self->check);
+
+	/* Shared VM should see enablements */
+	ASSERT_NE(-1, clone(&clone_check, stack + stack_size,
+			    CLONE_VM | SIGCHLD, &self->check));
+
+	ASSERT_EQ(0, change_event(true));
+	ASSERT_NE(-1, wait(&i));
+	ASSERT_EQ(0, WEXITSTATUS(i));
+	munmap(stack, stack_size);
+	ASSERT_EQ(0, change_event(false));
+}
+
+int main(int argc, char **argv)
+{
+	return test_harness_run(argc, argv);
+}
-- 
2.25.1

