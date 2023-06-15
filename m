Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BB9731A21
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238805AbjFONg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344753AbjFONfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:35:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36CD30F8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:34:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B75636371C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 13:34:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32EC1C433C9;
        Thu, 15 Jun 2023 13:34:17 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1q9n7A-000Tob-0r;
        Thu, 15 Jun 2023 09:34:16 -0400
Message-ID: <20230615133416.089967064@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Jun 2023 09:05:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        sunliming <sunliming@kylinos.cn>
Subject: [for-linus][PATCH 07/15] selftests/user_events: Clear the events after perf self-test
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

From: sunliming <sunliming@kylinos.cn>

When the self test is completed, perf self-test left the user events not to
be cleared. Clear the events by unregister and delete the event.

Link: https://lkml.kernel.org/r/20230606062027.1008398-4-sunliming@kylinos.cn

Acked-by: Beau Belgrave <beaub@linux.microsoft.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: sunliming <sunliming@kylinos.cn>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../testing/selftests/user_events/perf_test.c | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/testing/selftests/user_events/perf_test.c b/tools/testing/selftests/user_events/perf_test.c
index a070258d4449..e97f24ab6e2f 100644
--- a/tools/testing/selftests/user_events/perf_test.c
+++ b/tools/testing/selftests/user_events/perf_test.c
@@ -81,6 +81,32 @@ static int get_offset(void)
 	return offset;
 }
 
+static int clear(int *check)
+{
+	struct user_unreg unreg = {0};
+
+	unreg.size = sizeof(unreg);
+	unreg.disable_bit = 31;
+	unreg.disable_addr = (__u64)check;
+
+	int fd = open(data_file, O_RDWR);
+
+	if (fd == -1)
+		return -1;
+
+	if (ioctl(fd, DIAG_IOCSUNREG, &unreg) == -1)
+		if (errno != ENOENT)
+			return -1;
+
+	if (ioctl(fd, DIAG_IOCSDEL, "__test_event") == -1)
+		if (errno != ENOENT)
+			return -1;
+
+	close(fd);
+
+	return 0;
+}
+
 FIXTURE(user) {
 	int data_fd;
 	int check;
@@ -93,6 +119,9 @@ FIXTURE_SETUP(user) {
 
 FIXTURE_TEARDOWN(user) {
 	close(self->data_fd);
+
+	if (clear(&self->check) != 0)
+		printf("WARNING: Clear didn't work!\n");
 }
 
 TEST_F(user, perf_write) {
-- 
2.39.2
