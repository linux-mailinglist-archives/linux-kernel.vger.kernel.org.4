Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFB5716CF8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 21:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbjE3TAO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 30 May 2023 15:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjE3TAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 15:00:10 -0400
Received: from mail-b.sr.ht (mail-b.sr.ht [173.195.146.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC227106
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 12:00:02 -0700 (PDT)
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
        by mail-b.sr.ht (Postfix) with ESMTPSA id B8D4811F074;
        Tue, 30 May 2023 18:50:50 +0000 (UTC)
From:   ~akihirosuda <akihirosuda@git.sr.ht>
Date:   Tue, 30 May 2023 20:34:33 +0900
Subject: [PATCH linux 3/3] userns: add sysctl "kernel.userns_group_range"
Message-ID: <168547265011.24337.4306067683997517082-3@git.sr.ht>
X-Mailer: git.sr.ht
Reply-to: ~akihirosuda <suda.kyoto@gmail.com>
In-Reply-To: <168547265011.24337.4306067683997517082-0@git.sr.ht>
To:     linux-kernel@vger.kernel.org, containers@lists.linux.dev,
        serge@hallyn.com, brauner@kernel.org, paul@paul-moore.com,
        ebiederm@xmission.com
Cc:     suda.kyoto@gmail.com, akihiro.suda.cz@hco.ntt.co.jp
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=1.7 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        FREEMAIL_FORGED_REPLYTO,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>

This sysctl limits groups who can create a new userns without CAP_SYS_ADMIN
in the current userns, so as to mitigate potential kernel vulnerabilities
around userns.

The sysctl value format is same as "net.ipv4.ping_group_range".

To disable creating new unprivileged userns, set the sysctl value to "1 0"
in the initial userns.

To allow everyone to create new userns, set the sysctl value to
"0 4294967294". This is the default value.

This sysctl replaces "kernel.unprivileged_userns_clone" that is found in
Ubuntu [1] and Debian GNU/Linux.

Link: https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/jammy/commit?id=3422764 [1]

Signed-off-by: Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
---
 include/linux/user_namespace.h |  5 +++++
 kernel/fork.c                  | 24 ++++++++++++++++++++++++
 kernel/sysctl.c                | 30 ++++++++++++++++++++++++++++++
 kernel/user.c                  |  9 +++++++++
 4 files changed, 68 insertions(+)

diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 45f09bec02c4..b8b5a982f818 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -11,6 +11,10 @@
 #include <linux/sysctl.h>
 #include <linux/err.h>
 
+#ifdef CONFIG_SYSCTL
+#include <linux/group_range.h>
+#endif
+
 #define UID_GID_MAP_MAX_BASE_EXTENTS 5
 #define UID_GID_MAP_MAX_EXTENTS 340
 
@@ -98,6 +102,7 @@ struct user_namespace {
 #ifdef CONFIG_SYSCTL
 	struct ctl_table_set	set;
 	struct ctl_table_header *sysctls;
+	struct group_range group_range;
 #endif
 	struct ucounts		*ucounts;
 	long ucount_max[UCOUNT_COUNTS];
diff --git a/kernel/fork.c b/kernel/fork.c
index ed4e01daccaa..1e8debdf0896 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -111,6 +111,10 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/task.h>
 
+#ifdef CONFIG_USER_NS
+#include <linux/group_range.h>
+#endif
+
 /*
  * Minimum number of threads to boot the kernel
  */
@@ -2235,6 +2239,16 @@ static void rv_task_fork(struct task_struct *p)
 #define rv_task_fork(p) do {} while (0)
 #endif
 
+#ifdef CONFIG_USER_NS
+static bool userns_clone_is_allowed(void)
+{
+	if (capable(CAP_SYS_ADMIN))
+		return true;
+
+	return check_current_group_range(&current_user_ns()->group_range);
+}
+#endif
+
 /*
  * This creates a new process as a copy of the old one,
  * but does not actually start it yet.
@@ -2266,6 +2280,11 @@ __latent_entropy struct task_struct *copy_process(
 	if ((clone_flags & (CLONE_NEWUSER|CLONE_FS)) == (CLONE_NEWUSER|CLONE_FS))
 		return ERR_PTR(-EINVAL);
 
+#ifdef CONFIG_USER_NS
+	if ((clone_flags & CLONE_NEWUSER) && !userns_clone_is_allowed())
+		return ERR_PTR(-EPERM);
+#endif
+
 	/*
 	 * Thread groups must share signals as well, and detached threads
 	 * can only be started up within the thread group.
@@ -3340,6 +3359,11 @@ static int check_unshare_flags(unsigned long unshare_flags)
 			return -EINVAL;
 	}
 
+#ifdef CONFIG_USER_NS
+	if ((unshare_flags & CLONE_NEWUSER) && !userns_clone_is_allowed())
+		return -EPERM;
+#endif
+
 	return 0;
 }
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index bfe53e835524..ace7bf0fe9fc 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -80,6 +80,9 @@
 #ifdef CONFIG_RT_MUTEXES
 #include <linux/rtmutex.h>
 #endif
+#ifdef CONFIG_USER_NS
+#include <linux/group_range.h>
+#endif
 
 /* shared constants to be used in various sysctls */
 const int sysctl_vals[] = { 0, 1, 2, 3, 4, 100, 200, 1000, 3000, INT_MAX, 65535, -1 };
@@ -1615,6 +1618,24 @@ int proc_do_static_key(struct ctl_table *table, int write,
 	return ret;
 }
 
+#ifdef CONFIG_USER_NS
+static struct group_range *userns_group_range_func(struct ctl_table *table)
+{
+	struct user_namespace *user_ns =
+		container_of(table->data, struct user_namespace, group_range.range);
+
+	return &user_ns->group_range;
+}
+
+/* Validate changes from /proc interface. */
+static int userns_group_range(struct ctl_table *table, int write,
+	void *buffer, size_t *lenp, loff_t *ppos)
+{
+	return sysctl_group_range(userns_group_range_func, table,
+		write, buffer, lenp, ppos);
+}
+#endif
+
 static struct ctl_table kern_table[] = {
 	{
 		.procname	= "panic",
@@ -1623,6 +1644,15 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
+#ifdef CONFIG_USER_NS
+	{
+		.procname	= "userns_group_range",
+		.data = &init_user_ns.group_range.range,
+		.maxlen		= sizeof(init_user_ns.group_range.range),
+		.mode		= 0644,
+		.proc_handler	= userns_group_range,
+	},
+#endif
 #ifdef CONFIG_PROC_SYSCTL
 	{
 		.procname	= "tainted",
diff --git a/kernel/user.c b/kernel/user.c
index d667debeafd6..4704c93f62f9 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -20,6 +20,10 @@
 #include <linux/user_namespace.h>
 #include <linux/proc_ns.h>
 
+#ifdef CONFIG_SYSCTL
+#include <linux/group_range.h>
+#endif
+
 /*
  * userns count is 1 for root user, 1 for init_uts_ns,
  * and 1 for... ?
@@ -67,6 +71,11 @@ struct user_namespace init_user_ns = {
 	.keyring_name_list = LIST_HEAD_INIT(init_user_ns.keyring_name_list),
 	.keyring_sem = __RWSEM_INITIALIZER(init_user_ns.keyring_sem),
 #endif
+#ifdef CONFIG_SYSCTL
+	.group_range = {
+		.range = {0, ((gid_t)~0U) - 1},
+	},
+#endif
 };
 EXPORT_SYMBOL_GPL(init_user_ns);
 
-- 
2.38.4
