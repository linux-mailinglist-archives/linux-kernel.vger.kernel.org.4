Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FCE731A2A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344089AbjFONhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344389AbjFONgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:36:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0092D76
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:35:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BF6D63C87
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 13:34:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8888AC43391;
        Thu, 15 Jun 2023 13:34:18 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1q9n7B-000Tsb-2D;
        Thu, 15 Jun 2023 09:34:17 -0400
Message-ID: <20230615133417.503900831@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Jun 2023 09:05:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-linus][PATCH 14/15] selftests/user_events: Adapt dyn_test to non-persist events
References: <20230615130531.200384328@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Beau Belgrave <beaub@linux.microsoft.com>

Now that user_events does not honor persist events the dynamic_events
file cannot be easily used to test parsing and matching cases.

Update dyn_test to use the direct ABI file instead of dynamic_events so
that we still have testing coverage until persist events and
dynamic_events file integration has been decided.

Link: https://lkml.kernel.org/r/20230614163336.5797-6-beaub@linux.microsoft.com

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../testing/selftests/user_events/dyn_test.c  | 177 ++++++++++++++----
 1 file changed, 136 insertions(+), 41 deletions(-)

diff --git a/tools/testing/selftests/user_events/dyn_test.c b/tools/testing/selftests/user_events/dyn_test.c
index 8879a7b04c6a..d6979a48478f 100644
--- a/tools/testing/selftests/user_events/dyn_test.c
+++ b/tools/testing/selftests/user_events/dyn_test.c
@@ -16,42 +16,140 @@
 
 #include "../kselftest_harness.h"
 
-const char *dyn_file = "/sys/kernel/tracing/dynamic_events";
-const char *clear = "!u:__test_event";
+const char *abi_file = "/sys/kernel/tracing/user_events_data";
+const char *enable_file = "/sys/kernel/tracing/events/user_events/__test_event/enable";
 
-static int Append(const char *value)
+static bool wait_for_delete(void)
 {
-	int fd = open(dyn_file, O_RDWR | O_APPEND);
-	int ret = write(fd, value, strlen(value));
+	int i;
+
+	for (i = 0; i < 1000; ++i) {
+		int fd = open(enable_file, O_RDONLY);
+
+		if (fd == -1)
+			return true;
+
+		close(fd);
+		usleep(1000);
+	}
+
+	return false;
+}
+
+static int reg_event(int fd, int *check, int bit, const char *value)
+{
+	struct user_reg reg = {0};
+
+	reg.size = sizeof(reg);
+	reg.name_args = (__u64)value;
+	reg.enable_bit = bit;
+	reg.enable_addr = (__u64)check;
+	reg.enable_size = sizeof(*check);
+
+	if (ioctl(fd, DIAG_IOCSREG, &reg) == -1)
+		return -1;
+
+	return 0;
+}
+
+static int unreg_event(int fd, int *check, int bit)
+{
+	struct user_unreg unreg = {0};
+
+	unreg.size = sizeof(unreg);
+	unreg.disable_bit = bit;
+	unreg.disable_addr = (__u64)check;
+
+	return ioctl(fd, DIAG_IOCSUNREG, &unreg);
+}
+
+static int parse(int *check, const char *value)
+{
+	int fd = open(abi_file, O_RDWR);
+	int ret;
+
+	if (fd == -1)
+		return -1;
+
+	/* Until we have persist flags via dynamic events, use the base name */
+	if (value[0] != 'u' || value[1] != ':') {
+		close(fd);
+		return -1;
+	}
+
+	ret = reg_event(fd, check, 31, value + 2);
+
+	if (ret != -1) {
+		if (unreg_event(fd, check, 31) == -1)
+			printf("WARN: Couldn't unreg event\n");
+	}
 
 	close(fd);
+
 	return ret;
 }
 
-#define CLEAR() \
+static int check_match(int *check, const char *first, const char *second, bool *match)
+{
+	int fd = open(abi_file, O_RDWR);
+	int ret = -1;
+
+	if (fd == -1)
+		return -1;
+
+	if (reg_event(fd, check, 31, first) == -1)
+		goto cleanup;
+
+	if (reg_event(fd, check, 30, second) == -1) {
+		if (errno == EADDRINUSE) {
+			/* Name is in use, with different fields */
+			*match = false;
+			ret = 0;
+		}
+
+		goto cleanup;
+	}
+
+	*match = true;
+	ret = 0;
+cleanup:
+	unreg_event(fd, check, 31);
+	unreg_event(fd, check, 30);
+
+	close(fd);
+
+	wait_for_delete();
+
+	return ret;
+}
+
+#define TEST_MATCH(x, y) \
 do { \
-	int ret = Append(clear); \
-	if (ret == -1) \
-		ASSERT_EQ(ENOENT, errno); \
+	bool match; \
+	ASSERT_NE(-1, check_match(&self->check, x, y, &match)); \
+	ASSERT_EQ(true, match); \
 } while (0)
 
-#define TEST_PARSE(x) \
+#define TEST_NMATCH(x, y) \
 do { \
-	ASSERT_NE(-1, Append(x)); \
-	CLEAR(); \
+	bool match; \
+	ASSERT_NE(-1, check_match(&self->check, x, y, &match)); \
+	ASSERT_EQ(false, match); \
 } while (0)
 
-#define TEST_NPARSE(x) ASSERT_EQ(-1, Append(x))
+#define TEST_PARSE(x) ASSERT_NE(-1, parse(&self->check, x))
+
+#define TEST_NPARSE(x) ASSERT_EQ(-1, parse(&self->check, x))
 
 FIXTURE(user) {
+	int check;
 };
 
 FIXTURE_SETUP(user) {
-	CLEAR();
 }
 
 FIXTURE_TEARDOWN(user) {
-	CLEAR();
+	wait_for_delete();
 }
 
 TEST_F(user, basic_types) {
@@ -95,33 +193,30 @@ TEST_F(user, size_types) {
 	TEST_NPARSE("u:__test_event char a 20");
 }
 
-TEST_F(user, flags) {
-	/* Should work */
-	TEST_PARSE("u:__test_event:BPF_ITER u32 a");
-	/* Forward compat */
-	TEST_PARSE("u:__test_event:BPF_ITER,FLAG_FUTURE u32 a");
-}
-
 TEST_F(user, matching) {
-	/* Register */
-	ASSERT_NE(-1, Append("u:__test_event struct custom a 20"));
-	/* Should not match */
-	TEST_NPARSE("!u:__test_event struct custom b");
-	/* Should match */
-	TEST_PARSE("!u:__test_event struct custom a");
-	/* Multi field reg */
-	ASSERT_NE(-1, Append("u:__test_event u32 a; u32 b"));
-	/* Non matching cases */
-	TEST_NPARSE("!u:__test_event u32 a");
-	TEST_NPARSE("!u:__test_event u32 b");
-	TEST_NPARSE("!u:__test_event u32 a; u32 ");
-	TEST_NPARSE("!u:__test_event u32 a; u32 a");
-	/* Matching case */
-	TEST_PARSE("!u:__test_event u32 a; u32 b");
-	/* Register */
-	ASSERT_NE(-1, Append("u:__test_event u32 a; u32 b"));
-	/* Ensure trailing semi-colon case */
-	TEST_PARSE("!u:__test_event u32 a; u32 b;");
+	/* Single name matches */
+	TEST_MATCH("__test_event u32 a",
+		   "__test_event u32 a");
+
+	/* Multiple names match */
+	TEST_MATCH("__test_event u32 a; u32 b",
+		   "__test_event u32 a; u32 b");
+
+	/* Multiple names match with dangling ; */
+	TEST_MATCH("__test_event u32 a; u32 b",
+		   "__test_event u32 a; u32 b;");
+
+	/* Single name doesn't match */
+	TEST_NMATCH("__test_event u32 a",
+		    "__test_event u32 b");
+
+	/* Multiple names don't match */
+	TEST_NMATCH("__test_event u32 a; u32 b",
+		    "__test_event u32 b; u32 a");
+
+	/* Types don't match */
+	TEST_NMATCH("__test_event u64 a; u64 b",
+		    "__test_event u32 a; u32 b");
 }
 
 int main(int argc, char **argv)
-- 
2.39.2
