Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065336CCE42
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 01:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjC1Xww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 19:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjC1Xw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 19:52:29 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75CD52D47;
        Tue, 28 Mar 2023 16:52:27 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id B3F3F20FDABC;
        Tue, 28 Mar 2023 16:52:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B3F3F20FDABC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1680047547;
        bh=4Tw0x0REBVNQbPmE7YKz+0Y5T7GJmSyJL4LF57PSOTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PPhU+Txa9J+OmhxNlaZoPcjDXyHyCZ9FDOVMk0XDLbiw91/+Kmr6E4Tc4EEOXPHUa
         IcstD4kqI+CXd8qyR0WvK8eMzo7/EXyThPHVnUdVf303yaWS6G642Hl1YX9s0/abnb
         87OFyFAmbkhmRT3lzBdDWQusizzo2/or3m8RXSbw=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, dcook@linux.microsoft.com,
        alanau@linux.microsoft.com, brauner@kernel.org,
        akpm@linux-foundation.org, ebiederm@xmission.com,
        keescook@chromium.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH v10 06/12] tracing/user_events: Update self-tests to write ABI
Date:   Tue, 28 Mar 2023 16:52:13 -0700
Message-Id: <20230328235219.203-7-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230328235219.203-1-beaub@linux.microsoft.com>
References: <20230328235219.203-1-beaub@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ABI has been changed to remote writes, update existing test cases to use
this new ABI to ensure existing functionality continues to work.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 .../testing/selftests/user_events/dyn_test.c  |   2 +-
 .../selftests/user_events/ftrace_test.c       | 162 ++++++++++--------
 .../testing/selftests/user_events/perf_test.c |  39 ++---
 3 files changed, 105 insertions(+), 98 deletions(-)

diff --git a/tools/testing/selftests/user_events/dyn_test.c b/tools/testing/selftests/user_events/dyn_test.c
index d6265d14cd51..8879a7b04c6a 100644
--- a/tools/testing/selftests/user_events/dyn_test.c
+++ b/tools/testing/selftests/user_events/dyn_test.c
@@ -16,7 +16,7 @@
 
 #include "../kselftest_harness.h"
 
-const char *dyn_file = "/sys/kernel/debug/tracing/dynamic_events";
+const char *dyn_file = "/sys/kernel/tracing/dynamic_events";
 const char *clear = "!u:__test_event";
 
 static int Append(const char *value)
diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
index 404a2713dcae..aceafacfb126 100644
--- a/tools/testing/selftests/user_events/ftrace_test.c
+++ b/tools/testing/selftests/user_events/ftrace_test.c
@@ -12,20 +12,16 @@
 #include <fcntl.h>
 #include <sys/ioctl.h>
 #include <sys/stat.h>
+#include <sys/uio.h>
 #include <unistd.h>
 
 #include "../kselftest_harness.h"
 
-const char *data_file = "/sys/kernel/debug/tracing/user_events_data";
-const char *status_file = "/sys/kernel/debug/tracing/user_events_status";
-const char *enable_file = "/sys/kernel/debug/tracing/events/user_events/__test_event/enable";
-const char *trace_file = "/sys/kernel/debug/tracing/trace";
-const char *fmt_file = "/sys/kernel/debug/tracing/events/user_events/__test_event/format";
-
-static inline int status_check(char *status_page, int status_bit)
-{
-	return status_page[status_bit >> 3] & (1 << (status_bit & 7));
-}
+const char *data_file = "/sys/kernel/tracing/user_events_data";
+const char *status_file = "/sys/kernel/tracing/user_events_status";
+const char *enable_file = "/sys/kernel/tracing/events/user_events/__test_event/enable";
+const char *trace_file = "/sys/kernel/tracing/trace";
+const char *fmt_file = "/sys/kernel/tracing/events/user_events/__test_event/format";
 
 static int trace_bytes(void)
 {
@@ -106,13 +102,23 @@ static int get_print_fmt(char *buffer, int len)
 	return -1;
 }
 
-static int clear(void)
+static int clear(int *check)
 {
+	struct user_unreg unreg = {0};
+
+	unreg.size = sizeof(unreg);
+	unreg.disable_bit = 31;
+	unreg.disable_addr = (__u64)check;
+
 	int fd = open(data_file, O_RDWR);
 
 	if (fd == -1)
 		return -1;
 
+	if (ioctl(fd, DIAG_IOCSUNREG, &unreg) == -1)
+		if (errno != ENOENT)
+			return -1;
+
 	if (ioctl(fd, DIAG_IOCSDEL, "__test_event") == -1)
 		if (errno != ENOENT)
 			return -1;
@@ -122,7 +128,7 @@ static int clear(void)
 	return 0;
 }
 
-static int check_print_fmt(const char *event, const char *expected)
+static int check_print_fmt(const char *event, const char *expected, int *check)
 {
 	struct user_reg reg = {0};
 	char print_fmt[256];
@@ -130,7 +136,7 @@ static int check_print_fmt(const char *event, const char *expected)
 	int fd;
 
 	/* Ensure cleared */
-	ret = clear();
+	ret = clear(check);
 
 	if (ret != 0)
 		return ret;
@@ -142,14 +148,19 @@ static int check_print_fmt(const char *event, const char *expected)
 
 	reg.size = sizeof(reg);
 	reg.name_args = (__u64)event;
+	reg.enable_bit = 31;
+	reg.enable_addr = (__u64)check;
+	reg.enable_size = sizeof(*check);
 
 	/* Register should work */
 	ret = ioctl(fd, DIAG_IOCSREG, &reg);
 
 	close(fd);
 
-	if (ret != 0)
+	if (ret != 0) {
+		printf("Reg failed in fmt\n");
 		return ret;
+	}
 
 	/* Ensure correct print_fmt */
 	ret = get_print_fmt(print_fmt, sizeof(print_fmt));
@@ -164,6 +175,7 @@ FIXTURE(user) {
 	int status_fd;
 	int data_fd;
 	int enable_fd;
+	int check;
 };
 
 FIXTURE_SETUP(user) {
@@ -185,59 +197,56 @@ FIXTURE_TEARDOWN(user) {
 		close(self->enable_fd);
 	}
 
-	ASSERT_EQ(0, clear());
+	if (clear(&self->check) != 0)
+		printf("WARNING: Clear didn't work!\n");
 }
 
 TEST_F(user, register_events) {
 	struct user_reg reg = {0};
-	int page_size = sysconf(_SC_PAGESIZE);
-	char *status_page;
+	struct user_unreg unreg = {0};
 
 	reg.size = sizeof(reg);
 	reg.name_args = (__u64)"__test_event u32 field1; u32 field2";
+	reg.enable_bit = 31;
+	reg.enable_addr = (__u64)&self->check;
+	reg.enable_size = sizeof(self->check);
 
-	status_page = mmap(NULL, page_size, PROT_READ, MAP_SHARED,
-			   self->status_fd, 0);
+	unreg.size = sizeof(unreg);
+	unreg.disable_bit = 31;
+	unreg.disable_addr = (__u64)&self->check;
 
 	/* Register should work */
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
 	ASSERT_EQ(0, reg.write_index);
-	ASSERT_NE(0, reg.status_bit);
 
 	/* Multiple registers should result in same index */
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
 	ASSERT_EQ(0, reg.write_index);
-	ASSERT_NE(0, reg.status_bit);
 
 	/* Ensure disabled */
 	self->enable_fd = open(enable_file, O_RDWR);
 	ASSERT_NE(-1, self->enable_fd);
 	ASSERT_NE(-1, write(self->enable_fd, "0", sizeof("0")))
 
-	/* MMAP should work and be zero'd */
-	ASSERT_NE(MAP_FAILED, status_page);
-	ASSERT_NE(NULL, status_page);
-	ASSERT_EQ(0, status_check(status_page, reg.status_bit));
-
 	/* Enable event and ensure bits updated in status */
 	ASSERT_NE(-1, write(self->enable_fd, "1", sizeof("1")))
-	ASSERT_NE(0, status_check(status_page, reg.status_bit));
+	ASSERT_EQ(1 << reg.enable_bit, self->check);
 
 	/* Disable event and ensure bits updated in status */
 	ASSERT_NE(-1, write(self->enable_fd, "0", sizeof("0")))
-	ASSERT_EQ(0, status_check(status_page, reg.status_bit));
+	ASSERT_EQ(0, self->check);
 
 	/* File still open should return -EBUSY for delete */
 	ASSERT_EQ(-1, ioctl(self->data_fd, DIAG_IOCSDEL, "__test_event"));
 	ASSERT_EQ(EBUSY, errno);
 
-	/* Delete should work only after close */
+	/* Unregister */
+	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSUNREG, &unreg));
+
+	/* Delete should work only after close and unregister */
 	close(self->data_fd);
 	self->data_fd = open(data_file, O_RDWR);
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSDEL, "__test_event"));
-
-	/* Unmap should work */
-	ASSERT_EQ(0, munmap(status_page, page_size));
 }
 
 TEST_F(user, write_events) {
@@ -245,11 +254,12 @@ TEST_F(user, write_events) {
 	struct iovec io[3];
 	__u32 field1, field2;
 	int before = 0, after = 0;
-	int page_size = sysconf(_SC_PAGESIZE);
-	char *status_page;
 
 	reg.size = sizeof(reg);
 	reg.name_args = (__u64)"__test_event u32 field1; u32 field2";
+	reg.enable_bit = 31;
+	reg.enable_addr = (__u64)&self->check;
+	reg.enable_size = sizeof(self->check);
 
 	field1 = 1;
 	field2 = 2;
@@ -261,18 +271,10 @@ TEST_F(user, write_events) {
 	io[2].iov_base = &field2;
 	io[2].iov_len = sizeof(field2);
 
-	status_page = mmap(NULL, page_size, PROT_READ, MAP_SHARED,
-			   self->status_fd, 0);
-
 	/* Register should work */
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
 	ASSERT_EQ(0, reg.write_index);
-	ASSERT_NE(0, reg.status_bit);
-
-	/* MMAP should work and be zero'd */
-	ASSERT_NE(MAP_FAILED, status_page);
-	ASSERT_NE(NULL, status_page);
-	ASSERT_EQ(0, status_check(status_page, reg.status_bit));
+	ASSERT_EQ(0, self->check);
 
 	/* Write should fail on invalid slot with ENOENT */
 	io[0].iov_base = &field2;
@@ -287,7 +289,7 @@ TEST_F(user, write_events) {
 	ASSERT_NE(-1, write(self->enable_fd, "1", sizeof("1")))
 
 	/* Event should now be enabled */
-	ASSERT_NE(0, status_check(status_page, reg.status_bit));
+	ASSERT_NE(1 << reg.enable_bit, self->check);
 
 	/* Write should make it out to ftrace buffers */
 	before = trace_bytes();
@@ -304,6 +306,9 @@ TEST_F(user, write_fault) {
 
 	reg.size = sizeof(reg);
 	reg.name_args = (__u64)"__test_event u64 anon";
+	reg.enable_bit = 31;
+	reg.enable_addr = (__u64)&self->check;
+	reg.enable_size = sizeof(self->check);
 
 	anon = mmap(NULL, l, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 	ASSERT_NE(MAP_FAILED, anon);
@@ -316,7 +321,6 @@ TEST_F(user, write_fault) {
 	/* Register should work */
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
 	ASSERT_EQ(0, reg.write_index);
-	ASSERT_NE(0, reg.status_bit);
 
 	/* Write should work normally */
 	ASSERT_NE(-1, writev(self->data_fd, (const struct iovec *)io, 2));
@@ -333,24 +337,17 @@ TEST_F(user, write_validator) {
 	int loc, bytes;
 	char data[8];
 	int before = 0, after = 0;
-	int page_size = sysconf(_SC_PAGESIZE);
-	char *status_page;
-
-	status_page = mmap(NULL, page_size, PROT_READ, MAP_SHARED,
-			   self->status_fd, 0);
 
 	reg.size = sizeof(reg);
 	reg.name_args = (__u64)"__test_event __rel_loc char[] data";
+	reg.enable_bit = 31;
+	reg.enable_addr = (__u64)&self->check;
+	reg.enable_size = sizeof(self->check);
 
 	/* Register should work */
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
 	ASSERT_EQ(0, reg.write_index);
-	ASSERT_NE(0, reg.status_bit);
-
-	/* MMAP should work and be zero'd */
-	ASSERT_NE(MAP_FAILED, status_page);
-	ASSERT_NE(NULL, status_page);
-	ASSERT_EQ(0, status_check(status_page, reg.status_bit));
+	ASSERT_EQ(0, self->check);
 
 	io[0].iov_base = &reg.write_index;
 	io[0].iov_len = sizeof(reg.write_index);
@@ -369,7 +366,7 @@ TEST_F(user, write_validator) {
 	ASSERT_NE(-1, write(self->enable_fd, "1", sizeof("1")))
 
 	/* Event should now be enabled */
-	ASSERT_NE(0, status_check(status_page, reg.status_bit));
+	ASSERT_EQ(1 << reg.enable_bit, self->check);
 
 	/* Full in-bounds write should work */
 	before = trace_bytes();
@@ -409,71 +406,88 @@ TEST_F(user, print_fmt) {
 	int ret;
 
 	ret = check_print_fmt("__test_event __rel_loc char[] data",
-			      "print fmt: \"data=%s\", __get_rel_str(data)");
+			      "print fmt: \"data=%s\", __get_rel_str(data)",
+			      &self->check);
 	ASSERT_EQ(0, ret);
 
 	ret = check_print_fmt("__test_event __data_loc char[] data",
-			      "print fmt: \"data=%s\", __get_str(data)");
+			      "print fmt: \"data=%s\", __get_str(data)",
+			      &self->check);
 	ASSERT_EQ(0, ret);
 
 	ret = check_print_fmt("__test_event s64 data",
-			      "print fmt: \"data=%lld\", REC->data");
+			      "print fmt: \"data=%lld\", REC->data",
+			      &self->check);
 	ASSERT_EQ(0, ret);
 
 	ret = check_print_fmt("__test_event u64 data",
-			      "print fmt: \"data=%llu\", REC->data");
+			      "print fmt: \"data=%llu\", REC->data",
+			      &self->check);
 	ASSERT_EQ(0, ret);
 
 	ret = check_print_fmt("__test_event s32 data",
-			      "print fmt: \"data=%d\", REC->data");
+			      "print fmt: \"data=%d\", REC->data",
+			      &self->check);
 	ASSERT_EQ(0, ret);
 
 	ret = check_print_fmt("__test_event u32 data",
-			      "print fmt: \"data=%u\", REC->data");
+			      "print fmt: \"data=%u\", REC->data",
+			      &self->check);
 	ASSERT_EQ(0, ret);
 
 	ret = check_print_fmt("__test_event int data",
-			      "print fmt: \"data=%d\", REC->data");
+			      "print fmt: \"data=%d\", REC->data",
+			      &self->check);
 	ASSERT_EQ(0, ret);
 
 	ret = check_print_fmt("__test_event unsigned int data",
-			      "print fmt: \"data=%u\", REC->data");
+			      "print fmt: \"data=%u\", REC->data",
+			      &self->check);
 	ASSERT_EQ(0, ret);
 
 	ret = check_print_fmt("__test_event s16 data",
-			      "print fmt: \"data=%d\", REC->data");
+			      "print fmt: \"data=%d\", REC->data",
+			      &self->check);
 	ASSERT_EQ(0, ret);
 
 	ret = check_print_fmt("__test_event u16 data",
-			      "print fmt: \"data=%u\", REC->data");
+			      "print fmt: \"data=%u\", REC->data",
+			      &self->check);
 	ASSERT_EQ(0, ret);
 
 	ret = check_print_fmt("__test_event short data",
-			      "print fmt: \"data=%d\", REC->data");
+			      "print fmt: \"data=%d\", REC->data",
+			      &self->check);
 	ASSERT_EQ(0, ret);
 
 	ret = check_print_fmt("__test_event unsigned short data",
-			      "print fmt: \"data=%u\", REC->data");
+			      "print fmt: \"data=%u\", REC->data",
+			      &self->check);
 	ASSERT_EQ(0, ret);
 
 	ret = check_print_fmt("__test_event s8 data",
-			      "print fmt: \"data=%d\", REC->data");
+			      "print fmt: \"data=%d\", REC->data",
+			      &self->check);
 	ASSERT_EQ(0, ret);
 
 	ret = check_print_fmt("__test_event u8 data",
-			      "print fmt: \"data=%u\", REC->data");
+			      "print fmt: \"data=%u\", REC->data",
+			      &self->check);
 	ASSERT_EQ(0, ret);
 
 	ret = check_print_fmt("__test_event char data",
-			      "print fmt: \"data=%d\", REC->data");
+			      "print fmt: \"data=%d\", REC->data",
+			      &self->check);
 	ASSERT_EQ(0, ret);
 
 	ret = check_print_fmt("__test_event unsigned char data",
-			      "print fmt: \"data=%u\", REC->data");
+			      "print fmt: \"data=%u\", REC->data",
+			      &self->check);
 	ASSERT_EQ(0, ret);
 
 	ret = check_print_fmt("__test_event char[4] data",
-			      "print fmt: \"data=%s\", REC->data");
+			      "print fmt: \"data=%s\", REC->data",
+			      &self->check);
 	ASSERT_EQ(0, ret);
 }
 
diff --git a/tools/testing/selftests/user_events/perf_test.c b/tools/testing/selftests/user_events/perf_test.c
index 8b4c7879d5a7..a070258d4449 100644
--- a/tools/testing/selftests/user_events/perf_test.c
+++ b/tools/testing/selftests/user_events/perf_test.c
@@ -18,10 +18,9 @@
 
 #include "../kselftest_harness.h"
 
-const char *data_file = "/sys/kernel/debug/tracing/user_events_data";
-const char *status_file = "/sys/kernel/debug/tracing/user_events_status";
-const char *id_file = "/sys/kernel/debug/tracing/events/user_events/__test_event/id";
-const char *fmt_file = "/sys/kernel/debug/tracing/events/user_events/__test_event/format";
+const char *data_file = "/sys/kernel/tracing/user_events_data";
+const char *id_file = "/sys/kernel/tracing/events/user_events/__test_event/id";
+const char *fmt_file = "/sys/kernel/tracing/events/user_events/__test_event/format";
 
 struct event {
 	__u32 index;
@@ -35,11 +34,6 @@ static long perf_event_open(struct perf_event_attr *pe, pid_t pid,
 	return syscall(__NR_perf_event_open, pe, pid, cpu, group_fd, flags);
 }
 
-static inline int status_check(char *status_page, int status_bit)
-{
-	return status_page[status_bit >> 3] & (1 << (status_bit & 7));
-}
-
 static int get_id(void)
 {
 	FILE *fp = fopen(id_file, "r");
@@ -88,45 +82,38 @@ static int get_offset(void)
 }
 
 FIXTURE(user) {
-	int status_fd;
 	int data_fd;
+	int check;
 };
 
 FIXTURE_SETUP(user) {
-	self->status_fd = open(status_file, O_RDONLY);
-	ASSERT_NE(-1, self->status_fd);
-
 	self->data_fd = open(data_file, O_RDWR);
 	ASSERT_NE(-1, self->data_fd);
 }
 
 FIXTURE_TEARDOWN(user) {
-	close(self->status_fd);
 	close(self->data_fd);
 }
 
 TEST_F(user, perf_write) {
 	struct perf_event_attr pe = {0};
 	struct user_reg reg = {0};
-	int page_size = sysconf(_SC_PAGESIZE);
-	char *status_page;
 	struct event event;
 	struct perf_event_mmap_page *perf_page;
+	int page_size = sysconf(_SC_PAGESIZE);
 	int id, fd, offset;
 	__u32 *val;
 
 	reg.size = sizeof(reg);
 	reg.name_args = (__u64)"__test_event u32 field1; u32 field2";
-
-	status_page = mmap(NULL, page_size, PROT_READ, MAP_SHARED,
-			   self->status_fd, 0);
-	ASSERT_NE(MAP_FAILED, status_page);
+	reg.enable_bit = 31;
+	reg.enable_addr = (__u64)&self->check;
+	reg.enable_size = sizeof(self->check);
 
 	/* Register should work */
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
 	ASSERT_EQ(0, reg.write_index);
-	ASSERT_NE(0, reg.status_bit);
-	ASSERT_EQ(0, status_check(status_page, reg.status_bit));
+	ASSERT_EQ(0, self->check);
 
 	/* Id should be there */
 	id = get_id();
@@ -149,7 +136,7 @@ TEST_F(user, perf_write) {
 	ASSERT_NE(MAP_FAILED, perf_page);
 
 	/* Status should be updated */
-	ASSERT_NE(0, status_check(status_page, reg.status_bit));
+	ASSERT_EQ(1 << reg.enable_bit, self->check);
 
 	event.index = reg.write_index;
 	event.field1 = 0xc001;
@@ -165,6 +152,12 @@ TEST_F(user, perf_write) {
 	/* Ensure correct */
 	ASSERT_EQ(event.field1, *val++);
 	ASSERT_EQ(event.field2, *val++);
+
+	munmap(perf_page, page_size * 2);
+	close(fd);
+
+	/* Status should be updated */
+	ASSERT_EQ(0, self->check);
 }
 
 int main(int argc, char **argv)
-- 
2.25.1

