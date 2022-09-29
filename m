Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5587D5F0115
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 00:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiI2W4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 18:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiI2Wz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 18:55:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44ED3F192B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 15:55:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16238621C1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 22:55:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB87C433B5;
        Thu, 29 Sep 2022 22:55:26 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oe2SO-000crd-18;
        Thu, 29 Sep 2022 18:56:40 -0400
Message-ID: <20220929225639.943545555@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 29 Sep 2022 18:55:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-next][PATCH 12/15] tracing/user_events: Ensure user provided strings are safely
 formatted
References: <20220929225542.784716766@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Beau Belgrave <beaub@linux.microsoft.com>

User processes can provide bad strings that may cause issues or leak
kernel details back out. Don't trust the content of these strings
when formatting strings for matching.

This also moves to a consistent dynamic length string creation model.

Link: https://lkml.kernel.org/r/20220728233309.1896-4-beaub@linux.microsoft.com
Link: https://lore.kernel.org/all/2059213643.196683.1648499088753.JavaMail.zimbra@efficios.com/

Reported-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_user.c | 91 +++++++++++++++++++++-----------
 1 file changed, 59 insertions(+), 32 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 15edbf6b1e2e..f9bb7d37d76f 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -45,7 +45,6 @@
 #define MAX_EVENT_DESC 512
 #define EVENT_NAME(user_event) ((user_event)->tracepoint.name)
 #define MAX_FIELD_ARRAY_SIZE 1024
-#define MAX_FIELD_ARG_NAME 256
 
 static char *register_page_data;
 
@@ -483,6 +482,48 @@ static bool user_field_is_dyn_string(const char *type, const char **str_func)
 }
 
 #define LEN_OR_ZERO (len ? len - pos : 0)
+static int user_dyn_field_set_string(int argc, const char **argv, int *iout,
+				     char *buf, int len, bool *colon)
+{
+	int pos = 0, i = *iout;
+
+	*colon = false;
+
+	for (; i < argc; ++i) {
+		if (i != *iout)
+			pos += snprintf(buf + pos, LEN_OR_ZERO, " ");
+
+		pos += snprintf(buf + pos, LEN_OR_ZERO, "%s", argv[i]);
+
+		if (strchr(argv[i], ';')) {
+			++i;
+			*colon = true;
+			break;
+		}
+	}
+
+	/* Actual set, advance i */
+	if (len != 0)
+		*iout = i;
+
+	return pos + 1;
+}
+
+static int user_field_set_string(struct ftrace_event_field *field,
+				 char *buf, int len, bool colon)
+{
+	int pos = 0;
+
+	pos += snprintf(buf + pos, LEN_OR_ZERO, "%s", field->type);
+	pos += snprintf(buf + pos, LEN_OR_ZERO, " ");
+	pos += snprintf(buf + pos, LEN_OR_ZERO, "%s", field->name);
+
+	if (colon)
+		pos += snprintf(buf + pos, LEN_OR_ZERO, ";");
+
+	return pos + 1;
+}
+
 static int user_event_set_print_fmt(struct user_event *user, char *buf, int len)
 {
 	struct ftrace_event_field *field, *next;
@@ -926,49 +967,35 @@ static int user_event_free(struct dyn_event *ev)
 static bool user_field_match(struct ftrace_event_field *field, int argc,
 			     const char **argv, int *iout)
 {
-	char *field_name, *arg_name;
-	int len, pos, i = *iout;
+	char *field_name = NULL, *dyn_field_name = NULL;
 	bool colon = false, match = false;
+	int dyn_len, len;
 
-	if (i >= argc)
+	if (*iout >= argc)
 		return false;
 
-	len = MAX_FIELD_ARG_NAME;
-	field_name = kmalloc(len, GFP_KERNEL);
-	arg_name = kmalloc(len, GFP_KERNEL);
+	dyn_len = user_dyn_field_set_string(argc, argv, iout, dyn_field_name,
+					    0, &colon);
 
-	if (!arg_name || !field_name)
-		goto out;
-
-	pos = 0;
-
-	for (; i < argc; ++i) {
-		if (i != *iout)
-			pos += snprintf(arg_name + pos, len - pos, " ");
+	len = user_field_set_string(field, field_name, 0, colon);
 
-		pos += snprintf(arg_name + pos, len - pos, argv[i]);
-
-		if (strchr(argv[i], ';')) {
-			++i;
-			colon = true;
-			break;
-		}
-	}
+	if (dyn_len != len)
+		return false;
 
-	pos = 0;
+	dyn_field_name = kmalloc(dyn_len, GFP_KERNEL);
+	field_name = kmalloc(len, GFP_KERNEL);
 
-	pos += snprintf(field_name + pos, len - pos, field->type);
-	pos += snprintf(field_name + pos, len - pos, " ");
-	pos += snprintf(field_name + pos, len - pos, field->name);
+	if (!dyn_field_name || !field_name)
+		goto out;
 
-	if (colon)
-		pos += snprintf(field_name + pos, len - pos, ";");
+	user_dyn_field_set_string(argc, argv, iout, dyn_field_name,
+				  dyn_len, &colon);
 
-	*iout = i;
+	user_field_set_string(field, field_name, len, colon);
 
-	match = strcmp(arg_name, field_name) == 0;
+	match = strcmp(dyn_field_name, field_name) == 0;
 out:
-	kfree(arg_name);
+	kfree(dyn_field_name);
 	kfree(field_name);
 
 	return match;
-- 
2.35.1
