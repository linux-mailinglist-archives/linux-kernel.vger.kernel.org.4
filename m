Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248787233BA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 01:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjFEXjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 19:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233476AbjFEXjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 19:39:08 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18446FA;
        Mon,  5 Jun 2023 16:39:07 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id 813C320BD03E;
        Mon,  5 Jun 2023 16:39:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 813C320BD03E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1686008346;
        bh=6monnkZ7pd/D0U2iHah9YGHOLagyAkBtH4KggkTtfXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pxo1Cre6//tGTFPdK28EPlQOfgLJVCOxiDcaqusq+3YmrxrW5yEAgkKXjBACTpv74
         6iFdeXciOhamP5Uy5XjwZu/TYY7kCn+6ehlBQmYIPZC7d8QQiLpre2bfP5CL1uvzkP
         +9tZSbQhLJ3BB2yIHH8mdP7AUYsFqeGfJRGavvCw=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        ast@kernel.org, dcook@linux.microsoft.com
Subject: [PATCH v2 4/5] tracing/user_events: Add self-test for persist flag
Date:   Mon,  5 Jun 2023 16:38:59 -0700
Message-Id: <20230605233900.2838-5-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230605233900.2838-1-beaub@linux.microsoft.com>
References: <20230605233900.2838-1-beaub@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new flag for persisting user_events upon the last reference exists
now. We must ensure this flag works correctly in the common cases.

Update abi self test to ensure when this flag is used the user_event
goes away at the appropriate time. Ensure last fd, enabler, and
trace_event_call refs paths correctly delete the event for non-persist
events.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 .../testing/selftests/user_events/abi_test.c  | 144 +++++++++++++++++-
 .../selftests/user_events/ftrace_test.c       |   1 +
 2 files changed, 137 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/user_events/abi_test.c b/tools/testing/selftests/user_events/abi_test.c
index 5125c42efe65..55aaec21fd8e 100644
--- a/tools/testing/selftests/user_events/abi_test.c
+++ b/tools/testing/selftests/user_events/abi_test.c
@@ -22,10 +22,61 @@
 
 const char *data_file = "/sys/kernel/tracing/user_events_data";
 const char *enable_file = "/sys/kernel/tracing/events/user_events/__abi_event/enable";
+const char *temp_enable_file = "/sys/kernel/tracing/events/user_events/__abi_temp_event/enable";
 
-static int change_event(bool enable)
+static bool __exists(int grace_ms, const char *path)
 {
-	int fd = open(enable_file, O_RDWR);
+	int fd;
+
+	usleep(grace_ms * 1000);
+
+	fd = open(path, O_RDONLY);
+
+	if (fd == -1)
+		return false;
+
+	close(fd);
+
+	return true;
+}
+
+static bool temp_exists(int grace_ms)
+{
+	return __exists(grace_ms, temp_enable_file);
+}
+
+static bool exists(int grace_ms)
+{
+	return __exists(grace_ms, enable_file);
+}
+
+static int __clear(const char *name)
+{
+	int fd = open(data_file, O_RDWR);
+	int ret = 0;
+
+	if (ioctl(fd, DIAG_IOCSDEL, name) == -1)
+		if (errno != ENOENT)
+			ret = -1;
+
+	close(fd);
+
+	return ret;
+}
+
+static int clear_temp(void)
+{
+	return __clear("__abi_temp_event");
+}
+
+static int clear(void)
+{
+	return __clear("__abi_event");
+}
+
+static int __change_event(const char *path, bool enable)
+{
+	int fd = open(path, O_RDWR);
 	int ret;
 
 	if (fd < 0)
@@ -46,22 +97,48 @@ static int change_event(bool enable)
 	return ret;
 }
 
-static int reg_enable(long *enable, int size, int bit)
+static int change_temp_event(bool enable)
+{
+	return __change_event(temp_enable_file, enable);
+}
+
+static int change_event(bool enable)
+{
+	return __change_event(enable_file, enable);
+}
+
+static int __reg_enable(int *fd, const char *name, long *enable, int size,
+			int bit, int flags)
 {
 	struct user_reg reg = {0};
-	int fd = open(data_file, O_RDWR);
-	int ret;
 
-	if (fd < 0)
+	*fd = open(data_file, O_RDWR);
+
+	if (*fd < 0)
 		return -1;
 
 	reg.size = sizeof(reg);
-	reg.name_args = (__u64)"__abi_event";
+	reg.name_args = (__u64)name;
 	reg.enable_bit = bit;
 	reg.enable_addr = (__u64)enable;
 	reg.enable_size = size;
+	reg.flags = flags;
+
+	return ioctl(*fd, DIAG_IOCSREG, &reg);
+}
 
-	ret = ioctl(fd, DIAG_IOCSREG, &reg);
+static int reg_enable_temp(int *fd, long *enable, int size, int bit)
+{
+	return __reg_enable(fd, "__abi_temp_event", enable, size, bit, 0);
+}
+
+static int reg_enable(long *enable, int size, int bit)
+{
+	int ret;
+	int fd;
+
+	ret = __reg_enable(&fd, "__abi_event", enable, size, bit,
+			   USER_EVENT_REG_PERSIST);
 
 	close(fd);
 
@@ -98,6 +175,8 @@ FIXTURE_SETUP(user) {
 }
 
 FIXTURE_TEARDOWN(user) {
+	clear();
+	clear_temp();
 }
 
 TEST_F(user, enablement) {
@@ -223,6 +302,55 @@ TEST_F(user, clones) {
 	ASSERT_EQ(0, change_event(false));
 }
 
+TEST_F(user, flags) {
+	int grace = 100;
+	int fd;
+
+	/* FLAG: None */
+	/* Removal path 1, close on last fd ref */
+	ASSERT_EQ(0, clear_temp());
+	ASSERT_EQ(0, reg_enable_temp(&fd, &self->check, sizeof(int), 0));
+	ASSERT_EQ(0, reg_disable(&self->check, 0));
+	close(fd);
+	ASSERT_EQ(false, temp_exists(grace));
+
+	/* Removal path 2, close on last enabler */
+	ASSERT_EQ(0, clear_temp());
+	ASSERT_EQ(0, reg_enable_temp(&fd, &self->check, sizeof(int), 0));
+	close(fd);
+	ASSERT_EQ(true, temp_exists(grace));
+	ASSERT_EQ(0, reg_disable(&self->check, 0));
+	ASSERT_EQ(false, temp_exists(grace));
+
+	/* Removal path 3, close on last trace_event ref */
+	ASSERT_EQ(0, clear_temp());
+	ASSERT_EQ(0, reg_enable_temp(&fd, &self->check, sizeof(int), 0));
+	ASSERT_EQ(0, reg_disable(&self->check, 0));
+	ASSERT_EQ(0, change_temp_event(true));
+	close(fd);
+	ASSERT_EQ(true, temp_exists(grace));
+	ASSERT_EQ(0, change_temp_event(false));
+	ASSERT_EQ(false, temp_exists(grace));
+
+	/* FLAG: USER_EVENT_REG_PERSIST */
+	ASSERT_EQ(0, clear());
+	ASSERT_EQ(0, reg_enable(&self->check, sizeof(int), 0));
+	ASSERT_EQ(0, reg_disable(&self->check, 0));
+	ASSERT_EQ(true, exists(grace));
+	ASSERT_EQ(0, clear());
+	ASSERT_EQ(false, exists(grace));
+
+	/* FLAG: Non-ABI */
+	/* Unknown flags should fail with EINVAL */
+	ASSERT_EQ(-1, __reg_enable(&fd, "__abi_invalid_event", &self->check,
+				   sizeof(int), 0, USER_EVENT_REG_MAX));
+	ASSERT_EQ(EINVAL, errno);
+
+	ASSERT_EQ(-1, __reg_enable(&fd, "__abi_invalid_event", &self->check,
+				   sizeof(int), 0, USER_EVENT_REG_MAX + 1));
+	ASSERT_EQ(EINVAL, errno);
+}
+
 int main(int argc, char **argv)
 {
 	return test_harness_run(argc, argv);
diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
index 7c99cef94a65..e5e966d77918 100644
--- a/tools/testing/selftests/user_events/ftrace_test.c
+++ b/tools/testing/selftests/user_events/ftrace_test.c
@@ -210,6 +210,7 @@ TEST_F(user, register_events) {
 	reg.enable_bit = 31;
 	reg.enable_addr = (__u64)&self->check;
 	reg.enable_size = sizeof(self->check);
+	reg.flags = USER_EVENT_REG_PERSIST;
 
 	unreg.size = sizeof(unreg);
 	unreg.disable_bit = 31;
-- 
2.25.1

