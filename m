Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76B2731A24
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344438AbjFONgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344171AbjFONfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:35:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B492729
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:35:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB8E86399E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 13:34:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684D8C433CA;
        Thu, 15 Jun 2023 13:34:18 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1q9n7B-000Ts1-1Z;
        Thu, 15 Jun 2023 09:34:17 -0400
Message-ID: <20230615133417.304604444@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Jun 2023 09:05:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-linus][PATCH 13/15] selftests/user_events: Ensure auto cleanup works as expected
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

User events now auto cleanup upon the last reference put. Update
ftrace_test to ensure this works as expected. Ensure EBUSY delays
while event is being deleted do not cause transient failures by
waiting and re-attempting.

Link: https://lkml.kernel.org/r/20230614163336.5797-5-beaub@linux.microsoft.com

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
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
2.39.2
