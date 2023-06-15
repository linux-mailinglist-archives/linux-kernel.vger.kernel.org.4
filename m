Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADA2731A20
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344403AbjFONgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344734AbjFONfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:35:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B44A3AB8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:34:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8DCF639D3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 13:34:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D82C43391;
        Thu, 15 Jun 2023 13:34:17 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1q9n7A-000Tpl-2A;
        Thu, 15 Jun 2023 09:34:16 -0400
Message-ID: <20230615133416.491731786@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Jun 2023 09:05:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-linus][PATCH 09/15] tracing/user_events: Remove user_ns walk for groups
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

During discussions it was suggested that user_ns is not a good place to
try to attach a tracing namespace. The current code has stubs to enable
that work that are very likely to change and incur a performance cost.

Remove the user_ns walk when creating a group and determining the system
name to use, since it's unlikely user_ns will be used in the future.

Link: https://lore.kernel.org/all/20230601-urenkel-holzofen-cd9403b9cadd@brauner/
Link: https://lore.kernel.org/linux-trace-kernel/20230601224928.301-1-beaub@linux.microsoft.com

Suggested-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_user.c | 42 ++++----------------------------
 1 file changed, 5 insertions(+), 37 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 49914b6cb651..cf6d4c02c363 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -182,21 +182,11 @@ static void user_event_group_destroy(struct user_event_group *group)
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
@@ -207,34 +197,12 @@ static char *user_event_group_system_name(struct user_namespace *user_ns)
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
 
@@ -243,7 +211,7 @@ static struct user_event_group
 	if (!group)
 		return NULL;
 
-	group->system_name = user_event_group_system_name(user_ns);
+	group->system_name = user_event_group_system_name();
 
 	if (!group->system_name)
 		goto error;
@@ -2603,7 +2571,7 @@ static int __init trace_events_user_init(void)
 	if (!fault_cache)
 		return -ENOMEM;
 
-	init_group = user_event_group_create(&init_user_ns);
+	init_group = user_event_group_create();
 
 	if (!init_group) {
 		kmem_cache_destroy(fault_cache);
-- 
2.39.2
