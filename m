Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA0371720C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbjE3XxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjE3XxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:53:15 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6CB16B2;
        Tue, 30 May 2023 16:53:12 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id D449320FC46D;
        Tue, 30 May 2023 16:53:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D449320FC46D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1685490792;
        bh=dz/CtqF8fC3WjlIzINF503ue//H9KjjhIANdrvLeVn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iQORsCvD6vpEbIv0pI6gHu/s66CGSc9VNmHP5zEn17G21gdKW0xyLpMqI8Gj2mSgQ
         Q6ospDsmeMg37r9SfigYKv/2e/O4tyUZFj7ot16O2wQUDQ4fpEGx6evvGncO5etTHI
         3QoRk85Hzl0OAZgdBza/JiNHfAThEReUerZabxBQ=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        ast@kernel.org, dcook@linux.microsoft.com
Subject: [PATCH 1/5] tracing/user_events: Store register flags on events
Date:   Tue, 30 May 2023 16:53:00 -0700
Message-Id: <20230530235304.2726-2-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230530235304.2726-1-beaub@linux.microsoft.com>
References: <20230530235304.2726-1-beaub@linux.microsoft.com>
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
the event should auto-delete once it's not being used by anyone.

Add a reg_flags field to user_events and parameters to existing
functions to allow for this in future patches.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 kernel/trace/trace_events_user.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index b1ecd7677642..34aa0a5d8e2a 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -87,6 +87,7 @@ struct user_event {
 	struct list_head		validators;
 	refcount_t			refcnt;
 	int				min_size;
+	int				reg_flags;
 	char				status;
 };
 
@@ -163,7 +164,7 @@ typedef void (*user_event_func_t) (struct user_event *user, struct iov_iter *i,
 
 static int user_event_parse(struct user_event_group *group, char *name,
 			    char *args, char *flags,
-			    struct user_event **newuser);
+			    struct user_event **newuser, int reg_flags);
 
 static struct user_event_mm *user_event_mm_get(struct user_event_mm *mm);
 static struct user_event_mm *user_event_mm_get_all(struct user_event *user);
@@ -809,7 +810,8 @@ static struct list_head *user_event_get_fields(struct trace_event_call *call)
  * Upon success user_event has its ref count increased by 1.
  */
 static int user_event_parse_cmd(struct user_event_group *group,
-				char *raw_command, struct user_event **newuser)
+				char *raw_command, struct user_event **newuser,
+				int reg_flags)
 {
 	char *name = raw_command;
 	char *args = strpbrk(name, " ");
@@ -823,7 +825,7 @@ static int user_event_parse_cmd(struct user_event_group *group,
 	if (flags)
 		*flags++ = '\0';
 
-	return user_event_parse(group, name, args, flags, newuser);
+	return user_event_parse(group, name, args, flags, newuser, reg_flags);
 }
 
 static int user_field_array_size(const char *type)
@@ -1587,7 +1589,7 @@ static int user_event_create(const char *raw_command)
 
 	mutex_lock(&group->reg_mutex);
 
-	ret = user_event_parse_cmd(group, name, &user);
+	ret = user_event_parse_cmd(group, name, &user, 0);
 
 	if (!ret)
 		refcount_dec(&user->refcnt);
@@ -1748,7 +1750,7 @@ static int user_event_trace_register(struct user_event *user)
  */
 static int user_event_parse(struct user_event_group *group, char *name,
 			    char *args, char *flags,
-			    struct user_event **newuser)
+			    struct user_event **newuser, int reg_flags)
 {
 	int ret;
 	u32 key;
@@ -1819,6 +1821,8 @@ static int user_event_parse(struct user_event_group *group, char *name,
 	if (ret)
 		goto put_user_lock;
 
+	user->reg_flags = reg_flags;
+
 	/* Ensure we track self ref and caller ref (2) */
 	refcount_set(&user->refcnt, 2);
 
@@ -2117,7 +2121,7 @@ static long user_events_ioctl_reg(struct user_event_file_info *info,
 		return ret;
 	}
 
-	ret = user_event_parse_cmd(info->group, name, &user);
+	ret = user_event_parse_cmd(info->group, name, &user, reg.flags);
 
 	if (ret) {
 		kfree(name);
-- 
2.25.1

