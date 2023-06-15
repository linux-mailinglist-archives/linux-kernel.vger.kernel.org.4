Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A58731A1B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344236AbjFONfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344485AbjFONfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:35:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D2430DE
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:34:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E038E63759
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 13:34:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D1BC433CB;
        Thu, 15 Jun 2023 13:34:16 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1q9n79-000Tlr-0p;
        Thu, 15 Jun 2023 09:34:15 -0400
Message-ID: <20230615133415.070156632@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Jun 2023 09:05:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        sunliming <sunliming@kylinos.cn>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-linus][PATCH 02/15] tracing/user_events: Prevent same name but different args event
References: <20230615130531.200384328@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: sunliming <sunliming@kylinos.cn>

User processes register name_args for events. If the same name but different
args event are registered. The trace outputs of second event are printed
as the first event. This is incorrect.

Return EADDRINUSE back to the user process if the same name but different args
event has being registered.

Link: https://lore.kernel.org/linux-trace-kernel/20230529032100.286534-1-sunliming@kylinos.cn

Signed-off-by: sunliming <sunliming@kylinos.cn>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_user.c              | 36 +++++++++++++++----
 .../selftests/user_events/ftrace_test.c       |  6 ++++
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index dbb14705d0d3..37a38496a6be 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1786,6 +1786,8 @@ static int user_event_parse(struct user_event_group *group, char *name,
 	int ret;
 	u32 key;
 	struct user_event *user;
+	int argc = 0;
+	char **argv;
 
 	/* Prevent dyn_event from racing */
 	mutex_lock(&event_mutex);
@@ -1793,13 +1795,35 @@ static int user_event_parse(struct user_event_group *group, char *name,
 	mutex_unlock(&event_mutex);
 
 	if (user) {
-		*newuser = user;
-		/*
-		 * Name is allocated by caller, free it since it already exists.
-		 * Caller only worries about failure cases for freeing.
-		 */
-		kfree(name);
+		if (args) {
+			argv = argv_split(GFP_KERNEL, args, &argc);
+			if (!argv) {
+				ret = -ENOMEM;
+				goto error;
+			}
+
+			ret = user_fields_match(user, argc, (const char **)argv);
+			argv_free(argv);
+
+		} else
+			ret = list_empty(&user->fields);
+
+		if (ret) {
+			*newuser = user;
+			/*
+			 * Name is allocated by caller, free it since it already exists.
+			 * Caller only worries about failure cases for freeing.
+			 */
+			kfree(name);
+		} else {
+			ret = -EADDRINUSE;
+			goto error;
+		}
+
 		return 0;
+error:
+		refcount_dec(&user->refcnt);
+		return ret;
 	}
 
 	user = kzalloc(sizeof(*user), GFP_KERNEL_ACCOUNT);
diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
index 7c99cef94a65..6e8c4b47281c 100644
--- a/tools/testing/selftests/user_events/ftrace_test.c
+++ b/tools/testing/selftests/user_events/ftrace_test.c
@@ -228,6 +228,12 @@ TEST_F(user, register_events) {
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
 	ASSERT_EQ(0, reg.write_index);
 
+	/* Multiple registers to same name but different args should fail */
+	reg.enable_bit = 29;
+	reg.name_args = (__u64)"__test_event u32 field1;";
+	ASSERT_EQ(-1, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
+	ASSERT_EQ(EADDRINUSE, errno);
+
 	/* Ensure disabled */
 	self->enable_fd = open(enable_file, O_RDWR);
 	ASSERT_NE(-1, self->enable_fd);
-- 
2.39.2
