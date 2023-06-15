Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFFE731A28
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344420AbjFONhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344374AbjFONgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:36:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E534358E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:35:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE6B863B6C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 13:34:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD5DC433C8;
        Thu, 15 Jun 2023 13:34:17 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1q9n7A-000TqK-2p;
        Thu, 15 Jun 2023 09:34:16 -0400
Message-ID: <20230615133416.688476874@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Jun 2023 09:05:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-linus][PATCH 10/15] tracing/user_events: Store register flags on events
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

From: Beau Belgrave <beaub@linux.microsoft.com>

Currently we don't have any available flags for user processes to use to
indicate options for user_events. We will soon have a flag to indicate
the event should or should not auto-delete once it's not being used by
anyone.

Add a reg_flags field to user_events and parameters to existing
functions to allow for this in future patches.

Link: https://lkml.kernel.org/r/20230614163336.5797-2-beaub@linux.microsoft.com

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_user.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index cf6d4c02c363..629823e21447 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -87,6 +87,7 @@ struct user_event {
 	struct list_head		validators;
 	refcount_t			refcnt;
 	int				min_size;
+	int				reg_flags;
 	char				status;
 };
 
@@ -165,7 +166,7 @@ typedef void (*user_event_func_t) (struct user_event *user, struct iov_iter *i,
 
 static int user_event_parse(struct user_event_group *group, char *name,
 			    char *args, char *flags,
-			    struct user_event **newuser);
+			    struct user_event **newuser, int reg_flags);
 
 static struct user_event_mm *user_event_mm_get(struct user_event_mm *mm);
 static struct user_event_mm *user_event_mm_get_all(struct user_event *user);
@@ -810,7 +811,8 @@ static struct list_head *user_event_get_fields(struct trace_event_call *call)
  * Upon success user_event has its ref count increased by 1.
  */
 static int user_event_parse_cmd(struct user_event_group *group,
-				char *raw_command, struct user_event **newuser)
+				char *raw_command, struct user_event **newuser,
+				int reg_flags)
 {
 	char *name = raw_command;
 	char *args = strpbrk(name, " ");
@@ -824,7 +826,7 @@ static int user_event_parse_cmd(struct user_event_group *group,
 	if (flags)
 		*flags++ = '\0';
 
-	return user_event_parse(group, name, args, flags, newuser);
+	return user_event_parse(group, name, args, flags, newuser, reg_flags);
 }
 
 static int user_field_array_size(const char *type)
@@ -1588,7 +1590,7 @@ static int user_event_create(const char *raw_command)
 
 	mutex_lock(&group->reg_mutex);
 
-	ret = user_event_parse_cmd(group, name, &user);
+	ret = user_event_parse_cmd(group, name, &user, 0);
 
 	if (!ret)
 		refcount_dec(&user->refcnt);
@@ -1751,7 +1753,7 @@ static int user_event_trace_register(struct user_event *user)
  */
 static int user_event_parse(struct user_event_group *group, char *name,
 			    char *args, char *flags,
-			    struct user_event **newuser)
+			    struct user_event **newuser, int reg_flags)
 {
 	int ret;
 	u32 key;
@@ -1846,6 +1848,8 @@ static int user_event_parse(struct user_event_group *group, char *name,
 	if (ret)
 		goto put_user_lock;
 
+	user->reg_flags = reg_flags;
+
 	/* Ensure we track self ref and caller ref (2) */
 	refcount_set(&user->refcnt, 2);
 
@@ -2144,7 +2148,7 @@ static long user_events_ioctl_reg(struct user_event_file_info *info,
 		return ret;
 	}
 
-	ret = user_event_parse_cmd(info->group, name, &user);
+	ret = user_event_parse_cmd(info->group, name, &user, reg.flags);
 
 	if (ret) {
 		kfree(name);
-- 
2.39.2
