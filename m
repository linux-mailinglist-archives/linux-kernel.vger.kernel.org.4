Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DADD6CF387
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjC2Tqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjC2Tp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:45:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15A8139
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:45:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B223961E26
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 19:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED5FC4339C;
        Wed, 29 Mar 2023 19:45:54 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1phbk1-002RqW-2D;
        Wed, 29 Mar 2023 15:45:53 -0400
Message-ID: <20230329194553.504328919@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 29 Mar 2023 15:45:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-next][PATCH 22/25] tracing/user_events: Limit global user_event count
References: <20230329194516.146147554@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.0 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Beau Belgrave <beaub@linux.microsoft.com>

Operators want to be able to ensure enough tracepoints exist on the
system for kernel components as well as for user components. Since there
are only up to 64K events, by default allow up to half to be used by
user events.

Add a kernel sysctl parameter (kernel.user_events_max) to set a global
limit that is honored among all groups on the system. This ensures hard
limits can be setup to prevent user processes from consuming all event
IDs on the system.

Link: https://lkml.kernel.org/r/20230328235219.203-12-beaub@linux.microsoft.com

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_user.c | 47 ++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 3a01c2df4a90..9b43a02e1597 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -20,6 +20,7 @@
 #include <linux/types.h>
 #include <linux/uaccess.h>
 #include <linux/highmem.h>
+#include <linux/init.h>
 #include <linux/user_events.h>
 #include "trace.h"
 #include "trace_dynevent.h"
@@ -61,6 +62,12 @@ struct user_event_group {
 /* Group for init_user_ns mapping, top-most group */
 static struct user_event_group *init_group;
 
+/* Max allowed events for the whole system */
+static unsigned int max_user_events = 32768;
+
+/* Current number of events on the whole system */
+static unsigned int current_user_events;
+
 /*
  * Stores per-event properties, as users register events
  * within a file a user_event might be created if it does not
@@ -1241,6 +1248,8 @@ static int destroy_user_event(struct user_event *user)
 {
 	int ret = 0;
 
+	lockdep_assert_held(&event_mutex);
+
 	/* Must destroy fields before call removal */
 	user_event_destroy_fields(user);
 
@@ -1257,6 +1266,11 @@ static int destroy_user_event(struct user_event *user)
 	kfree(EVENT_NAME(user));
 	kfree(user);
 
+	if (current_user_events > 0)
+		current_user_events--;
+	else
+		pr_alert("BUG: Bad current_user_events\n");
+
 	return ret;
 }
 
@@ -1744,6 +1758,11 @@ static int user_event_parse(struct user_event_group *group, char *name,
 
 	mutex_lock(&event_mutex);
 
+	if (current_user_events >= max_user_events) {
+		ret = -EMFILE;
+		goto put_user_lock;
+	}
+
 	ret = user_event_trace_register(user);
 
 	if (ret)
@@ -1755,6 +1774,7 @@ static int user_event_parse(struct user_event_group *group, char *name,
 	dyn_event_init(&user->devent, &user_event_dops);
 	dyn_event_add(&user->devent, &user->call);
 	hash_add(group->register_table, &user->node, key);
+	current_user_events++;
 
 	mutex_unlock(&event_mutex);
 
@@ -2390,6 +2410,31 @@ static int create_user_tracefs(void)
 	return -ENODEV;
 }
 
+static int set_max_user_events_sysctl(struct ctl_table *table, int write,
+				      void *buffer, size_t *lenp, loff_t *ppos)
+{
+	int ret;
+
+	mutex_lock(&event_mutex);
+
+	ret = proc_douintvec(table, write, buffer, lenp, ppos);
+
+	mutex_unlock(&event_mutex);
+
+	return ret;
+}
+
+static struct ctl_table user_event_sysctls[] = {
+	{
+		.procname	= "user_events_max",
+		.data		= &max_user_events,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= set_max_user_events_sysctl,
+	},
+	{}
+};
+
 static int __init trace_events_user_init(void)
 {
 	int ret;
@@ -2419,6 +2464,8 @@ static int __init trace_events_user_init(void)
 	if (dyn_event_register(&user_event_dops))
 		pr_warn("user_events could not register with dyn_events\n");
 
+	register_sysctl_init("kernel", user_event_sysctls);
+
 	return 0;
 }
 
-- 
2.39.1
