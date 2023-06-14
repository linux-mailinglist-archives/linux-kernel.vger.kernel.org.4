Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A3C7304FD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbjFNQdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbjFNQdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:33:42 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08F5A1FF5;
        Wed, 14 Jun 2023 09:33:41 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id 71BF520FEA4C;
        Wed, 14 Jun 2023 09:33:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 71BF520FEA4C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1686760420;
        bh=SfIyYj95J/RW8ouG7qSlLS6zRHlnKNgkIAoGUxHrtq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CFuMkI5HspE/dncp81UDflGaqfC6Yd6t1yqDUXXkWNoLWh28AB8vUFVyjZZlQCQJx
         CeNRR58VcwAVO/W4jNartIUzOysuoTAI8p1H8zQ1/wJwHM7+hV/yWXmCPbijiuvDKI
         ldj8vQC1A+XxUR7/BjmxUXtwv1K/Gsk8eZ9WctiE=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        ast@kernel.org, dcook@linux.microsoft.com
Subject: [PATCH v3 1/6] tracing/user_events: Store register flags on events
Date:   Wed, 14 Jun 2023 09:33:31 -0700
Message-Id: <20230614163336.5797-2-beaub@linux.microsoft.com>
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

Currently we don't have any available flags for user processes to use to
indicate options for user_events. We will soon have a flag to indicate
the event should or should not auto-delete once it's not being used by
anyone.

Add a reg_flags field to user_events and parameters to existing
functions to allow for this in future patches.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
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
2.25.1

