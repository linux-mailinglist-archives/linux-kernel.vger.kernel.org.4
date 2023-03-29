Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A606CF386
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjC2Tqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjC2Tp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:45:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD024C01
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:45:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7181D61E1D
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 19:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44D8C4339C;
        Wed, 29 Mar 2023 19:45:53 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1phbk0-002RoG-2n;
        Wed, 29 Mar 2023 15:45:52 -0400
Message-ID: <20230329194552.684425169@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 29 Mar 2023 15:45:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-next][PATCH 18/25] tracing/user_events: Add ABI self-test
References: <20230329194516.146147554@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.0 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Beau Belgrave <beaub@linux.microsoft.com>

Add ABI specific self-test to ensure enablements work in various
scenarios such as fork, VM_CLONE, and basic event enable/disable.
Ensure ABI contracts/limits are also being upheld, such as bit limits
and data size limits.

Link: https://lkml.kernel.org/r/20230328235219.203-8-beaub@linux.microsoft.com

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/testing/selftests/user_events/Makefile  |   2 +-
 .../testing/selftests/user_events/abi_test.c  | 226 ++++++++++++++++++
 2 files changed, 227 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/user_events/abi_test.c

diff --git a/tools/testing/selftests/user_events/Makefile b/tools/testing/selftests/user_events/Makefile
index 6b512b86aec3..9e95bd41b0b4 100644
--- a/tools/testing/selftests/user_events/Makefile
+++ b/tools/testing/selftests/user_events/Makefile
@@ -10,7 +10,7 @@ LDLIBS += -lrt -lpthread -lm
 # This test will not compile until user_events.h is added
 # back to uapi.
 
-TEST_GEN_PROGS = ftrace_test dyn_test perf_test
+TEST_GEN_PROGS = ftrace_test dyn_test perf_test abi_test
 
 TEST_FILES := settings
 
diff --git a/tools/testing/selftests/user_events/abi_test.c b/tools/testing/selftests/user_events/abi_test.c
new file mode 100644
index 000000000000..e0323d3777a7
--- /dev/null
+++ b/tools/testing/selftests/user_events/abi_test.c
@@ -0,0 +1,226 @@
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
+		for (i = 0; i < 10; ++i) {
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
+	if (fork() == 0)
+		exit(reg_disable(&self->check, 0));
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
+	for (i = 0; i < 10; ++i) {
+		usleep(100000);
+
+		if (*(long *)check)
+			return 0;
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
2.39.1
