Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99876CF388
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjC2Tqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjC2Tp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:45:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCA94219
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:45:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5890361E2B
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 19:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D557C433D2;
        Wed, 29 Mar 2023 19:45:53 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1phbk0-002Rng-29;
        Wed, 29 Mar 2023 15:45:52 -0400
Message-ID: <20230329194552.474991854@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 29 Mar 2023 15:45:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-next][PATCH 17/25] tracing/user_events: Update self-tests to write ABI
References: <20230329194516.146147554@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Beau Belgrave <beaub@linux.microsoft.com>

ABI has been changed to remote writes, update existing test cases to use
this new ABI to ensure existing functionality continues to work.

Link: https://lkml.kernel.org/r/20230328235219.203-7-beaub@linux.microsoft.com

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../selftests/user_events/ftrace_test.c       | 152 ++++++++++--------
 .../testing/selftests/user_events/perf_test.c |  33 ++--
 2 files changed, 96 insertions(+), 89 deletions(-)

diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
index a0b2c96eb252..aceafacfb126 100644
--- a/tools/testing/selftests/user_events/ftrace_test.c
+++ b/tools/testing/selftests/user_events/ftrace_test.c
@@ -12,6 +12,7 @@
 #include <fcntl.h>
 #include <sys/ioctl.h>
 #include <sys/stat.h>
+#include <sys/uio.h>
 #include <unistd.h>
 
 #include "../kselftest_harness.h"
@@ -22,11 +23,6 @@ const char *enable_file = "/sys/kernel/tracing/events/user_events/__test_event/e
 const char *trace_file = "/sys/kernel/tracing/trace";
 const char *fmt_file = "/sys/kernel/tracing/events/user_events/__test_event/format";
 
-static inline int status_check(char *status_page, int status_bit)
-{
-	return status_page[status_bit >> 3] & (1 << (status_bit & 7));
-}
-
 static int trace_bytes(void)
 {
 	int fd = open(trace_file, O_RDONLY);
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
index 31505642aa9b..a070258d4449 100644
--- a/tools/testing/selftests/user_events/perf_test.c
+++ b/tools/testing/selftests/user_events/perf_test.c
@@ -19,7 +19,6 @@
 #include "../kselftest_harness.h"
 
 const char *data_file = "/sys/kernel/tracing/user_events_data";
-const char *status_file = "/sys/kernel/tracing/user_events_status";
 const char *id_file = "/sys/kernel/tracing/events/user_events/__test_event/id";
 const char *fmt_file = "/sys/kernel/tracing/events/user_events/__test_event/format";
 
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
2.39.1
