Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957F165DF33
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 22:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240285AbjADVnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 16:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239618AbjADVmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 16:42:43 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E77FF1DF24;
        Wed,  4 Jan 2023 13:42:39 -0800 (PST)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8C2FD20B478C;
        Wed,  4 Jan 2023 13:42:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8C2FD20B478C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1672868559;
        bh=dXIuKwK6fkoWlzFZyIr5COYwBNSniKo2OrGUJXosDSM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jh+D4ERgi2AYQIbTy9m8l8pP4zDC60p3Co5WMYWKymYJ7F3x6xA0uoAPvo77lO17w
         gfvZOMEEE4H4NbsnhqkgMzX96tJ4bMBcw8hIbvkVX7Pi4b+AcvTMr++PDqXVap9LVp
         Eajx9zkcGatKILNuB1c6rOj8ZQ/8hQ6glTZLpouE=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, dcook@linux.microsoft.com,
        alanau@linux.microsoft.com, brauner@kernel.org,
        akpm@linux-foundation.org
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 11/11] tracing/user_events: Limit global user_event count
Date:   Wed,  4 Jan 2023 13:42:30 -0800
Message-Id: <20230104214230.26349-12-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230104214230.26349-1-beaub@linux.microsoft.com>
References: <20230104214230.26349-1-beaub@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Operators want to be able to ensure enough tracepoints exist on the
system for kernel components as well as for user components. Since there
are only up to 64K events, by default allow up to half to be used by
user events.

Add a boot parameter (user_events_max=%d) and a kernel sysctl parameter
(kernel.user_events_max) to set a global limit that is honored among all
groups on the system. This ensures hard limits can be setup to prevent
user processes from consuming all event IDs on the system.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 kernel/trace/trace_events_user.c | 59 ++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index a32694b9dfb6..3699a5ee432d 100644
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
 
@@ -2382,6 +2402,43 @@ static int create_user_tracefs(void)
 	return -ENODEV;
 }
 
+static int __init set_max_user_events(char *str)
+{
+	if (!str)
+		return 0;
+
+	if (kstrtouint(str, 0, &max_user_events))
+		return 0;
+
+	return 1;
+}
+__setup("user_events_max=", set_max_user_events);
+
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
@@ -2411,6 +2468,8 @@ static int __init trace_events_user_init(void)
 	if (dyn_event_register(&user_event_dops))
 		pr_warn("user_events could not register with dyn_events\n");
 
+	register_sysctl_init("kernel", user_event_sysctls);
+
 	return 0;
 }
 
-- 
2.25.1

