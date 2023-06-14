Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767027304FF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbjFNQeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbjFNQdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:33:43 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 136791A3;
        Wed, 14 Jun 2023 09:33:42 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id 381B820FEB21;
        Wed, 14 Jun 2023 09:33:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 381B820FEB21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1686760421;
        bh=Sj676SYDjXthxSr+gv3kzOZIwdLqaCDmhWjZjJgPAy4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D6G2xO/uq3RAw+D2Tv0g7GL9SXLACiGzQNcSZNVpW/FW3vm2IU/ZS6nYdsTXSHtFT
         V48COHuHeS6unZKLe9rKoMnBewPmv7AXEueoL6wDt/UuviFRjaRZfPLF+JTF0Jnh4M
         0ZMfEyI3Qvzi1V9uultYUaVYD+KmLhRg1OBndTZk=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        ast@kernel.org, dcook@linux.microsoft.com
Subject: [PATCH v3 4/6] selftests/user_events: Ensure auto cleanup works as expected
Date:   Wed, 14 Jun 2023 09:33:34 -0700
Message-Id: <20230614163336.5797-5-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230614163336.5797-1-beaub@linux.microsoft.com>
References: <20230614163336.5797-1-beaub@linux.microsoft.com>
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

User events now auto cleanup upon the last reference put. Update
ftrace_test to ensure this works as expected. Ensure EBUSY delays
while event is being deleted do not cause transient failures by
waiting and re-attempting.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 .../selftests/user_events/ftrace_test.c       | 49 ++++++++++++++-----
 1 file changed, 38 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
index abfb49558a26..eb6904d89f14 100644
--- a/tools/testing/selftests/user_events/ftrace_test.c
+++ b/tools/testing/selftests/user_events/ftrace_test.c
@@ -102,30 +102,56 @@ static int get_print_fmt(char *buffer, int len)
 	return -1;
 }
 
+static bool wait_for_delete(void)
+{
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
 static int clear(int *check)
 {
 	struct user_unreg unreg = {0};
+	int fd;
 
 	unreg.size = sizeof(unreg);
 	unreg.disable_bit = 31;
 	unreg.disable_addr = (__u64)check;
 
-	int fd = open(data_file, O_RDWR);
+	fd = open(data_file, O_RDWR);
 
 	if (fd == -1)
 		return -1;
 
 	if (ioctl(fd, DIAG_IOCSUNREG, &unreg) == -1)
 		if (errno != ENOENT)
-			return -1;
-
-	if (ioctl(fd, DIAG_IOCSDEL, "__test_event") == -1)
-		if (errno != ENOENT)
-			return -1;
+			goto fail;
+
+	if (ioctl(fd, DIAG_IOCSDEL, "__test_event") == -1) {
+		if (errno == EBUSY) {
+			if (!wait_for_delete())
+				goto fail;
+		} else if (errno != ENOENT)
+			goto fail;
+	}
 
 	close(fd);
 
 	return 0;
+fail:
+	close(fd);
+
+	return -1;
 }
 
 static int check_print_fmt(const char *event, const char *expected, int *check)
@@ -155,9 +181,8 @@ static int check_print_fmt(const char *event, const char *expected, int *check)
 	/* Register should work */
 	ret = ioctl(fd, DIAG_IOCSREG, &reg);
 
-	close(fd);
-
 	if (ret != 0) {
+		close(fd);
 		printf("Reg failed in fmt\n");
 		return ret;
 	}
@@ -165,6 +190,8 @@ static int check_print_fmt(const char *event, const char *expected, int *check)
 	/* Ensure correct print_fmt */
 	ret = get_print_fmt(print_fmt, sizeof(print_fmt));
 
+	close(fd);
+
 	if (ret != 0)
 		return ret;
 
@@ -256,10 +283,10 @@ TEST_F(user, register_events) {
 	unreg.disable_bit = 30;
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSUNREG, &unreg));
 
-	/* Delete should work only after close and unregister */
+	/* Delete should have been auto-done after close and unregister */
 	close(self->data_fd);
-	self->data_fd = open(data_file, O_RDWR);
-	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSDEL, "__test_event"));
+
+	ASSERT_EQ(true, wait_for_delete());
 }
 
 TEST_F(user, write_events) {
-- 
2.25.1

