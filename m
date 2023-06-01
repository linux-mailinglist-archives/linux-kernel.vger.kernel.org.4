Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FC971F63B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 00:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjFAWtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 18:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjFAWtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 18:49:35 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 434BA137;
        Thu,  1 Jun 2023 15:49:34 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7693120FCD27;
        Thu,  1 Jun 2023 15:49:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7693120FCD27
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1685659772;
        bh=Al6Gkocw7whHT52Bc4ElZbslNdqBvx6ntA83ZjEnGCw=;
        h=From:To:Cc:Subject:Date:From;
        b=eBkE6tthDxKoqBO9Fwv67XKmq0g+Sy+bnMV3haP3kpSA4FOId5penjiuwuUqu0fqc
         0yrQbjbQ+UgZSpC/6MYwDHiYcWqMJ1v36hHtX3iMOPoePgNeWl9WAKYtBiCVij64ij
         I90KenDa9WpQitzqgEfNzHCHKiIoNaLGCsvrWMak=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        brauner@kernel.org
Subject: [PATCH] tracing/user_events: Remove user_ns walk for groups
Date:   Thu,  1 Jun 2023 15:49:28 -0700
Message-Id: <20230601224928.301-1-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
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

During discussions it was suggested that user_ns is not a good place to
try to attach a tracing namespace. The current code has stubs to enable
that work that are very likely to change and incur a performance cost.

Remove the user_ns walk when creating a group and determining the system
name to use, since it's unlikely user_ns will be used in the future.

Link: https://lore.kernel.org/all/20230601-urenkel-holzofen-cd9403b9cadd@brauner/

Suggested-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 kernel/trace/trace_events_user.c | 42 ++++----------------------------
 1 file changed, 5 insertions(+), 37 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index b1ecd7677642..55e362484b66 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -180,21 +180,11 @@ static void user_event_group_destroy(struct user_event_group *group)
 	kfree(group);
 }
 
-static char *user_event_group_system_name(struct user_namespace *user_ns)
+static char *user_event_group_system_name(void)
 {
 	char *system_name;
 	int len = sizeof(USER_EVENTS_SYSTEM) + 1;
 
-	if (user_ns != &init_user_ns) {
-		/*
-		 * Unexpected at this point:
-		 * We only currently support init_user_ns.
-		 * When we enable more, this will trigger a failure so log.
-		 */
-		pr_warn("user_events: Namespace other than init_user_ns!\n");
-		return NULL;
-	}
-
 	system_name = kmalloc(len, GFP_KERNEL);
 
 	if (!system_name)
@@ -205,34 +195,12 @@ static char *user_event_group_system_name(struct user_namespace *user_ns)
 	return system_name;
 }
 
-static inline struct user_event_group
-*user_event_group_from_user_ns(struct user_namespace *user_ns)
-{
-	if (user_ns == &init_user_ns)
-		return init_group;
-
-	return NULL;
-}
-
 static struct user_event_group *current_user_event_group(void)
 {
-	struct user_namespace *user_ns = current_user_ns();
-	struct user_event_group *group = NULL;
-
-	while (user_ns) {
-		group = user_event_group_from_user_ns(user_ns);
-
-		if (group)
-			break;
-
-		user_ns = user_ns->parent;
-	}
-
-	return group;
+	return init_group;
 }
 
-static struct user_event_group
-*user_event_group_create(struct user_namespace *user_ns)
+static struct user_event_group *user_event_group_create(void)
 {
 	struct user_event_group *group;
 
@@ -241,7 +209,7 @@ static struct user_event_group
 	if (!group)
 		return NULL;
 
-	group->system_name = user_event_group_system_name(user_ns);
+	group->system_name = user_event_group_system_name();
 
 	if (!group->system_name)
 		goto error;
@@ -2543,7 +2511,7 @@ static int __init trace_events_user_init(void)
 	if (!fault_cache)
 		return -ENOMEM;
 
-	init_group = user_event_group_create(&init_user_ns);
+	init_group = user_event_group_create();
 
 	if (!init_group) {
 		kmem_cache_destroy(fault_cache);

base-commit: 3862f86c1529fa0016de6344eb974877b4cd3838
-- 
2.25.1

