Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D8265DF2A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 22:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240056AbjADVmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 16:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235464AbjADVmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 16:42:37 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A4301D0CF;
        Wed,  4 Jan 2023 13:42:36 -0800 (PST)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id EAEFA20B928C;
        Wed,  4 Jan 2023 13:42:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EAEFA20B928C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1672868556;
        bh=S8OIOLUkRs5CBqJ2LYBXQxLSyKFNFEQS/E/TUK8EqMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FruesEPFVXK7+2KidcBlAr3CQvhrafePeX5tQr5O/IYKxDkHQT5WMyJOUt54dwLNs
         DkUj7Oyuv90I8J0qUsSLTopDLq7OW3xwxUt/YwEz6mF6nMyo8+7ViMvDRJjI6cyRUu
         Y2hrR+qCZXQb+Jl0H2bJcyAA+yRiI5d/44lRxWD8=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, dcook@linux.microsoft.com,
        alanau@linux.microsoft.com, brauner@kernel.org,
        akpm@linux-foundation.org
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 02/11] tracing/user_events: Track fork/exec/exit for mm lifetime
Date:   Wed,  4 Jan 2023 13:42:21 -0800
Message-Id: <20230104214230.26349-3-beaub@linux.microsoft.com>
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

During tracefs discussions it was decided instead of requiring a mapping
within a user-process to track the lifetime of memory descriptors we
should hook the appropriate calls. Do this by adding the minimal stubs
required for task fork, exec, and exit. Currently this is just a NOP.
Future patches will implement these calls fully.

Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 fs/exec.c                   |  2 ++
 include/linux/sched.h       |  5 +++++
 include/linux/user_events.h | 18 ++++++++++++++++++
 kernel/exit.c               |  2 ++
 kernel/fork.c               |  2 ++
 5 files changed, 29 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index ab913243a367..d1c83e0dbae5 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -65,6 +65,7 @@
 #include <linux/syscall_user_dispatch.h>
 #include <linux/coredump.h>
 #include <linux/time_namespace.h>
+#include <linux/user_events.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -1856,6 +1857,7 @@ static int bprm_execve(struct linux_binprm *bprm,
 	current->fs->in_exec = 0;
 	current->in_execve = 0;
 	rseq_execve(current);
+	user_events_execve(current);
 	acct_update_integrals(current);
 	task_numa_free(current, false);
 	return retval;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 853d08f7562b..a8e683b4291c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -69,6 +69,7 @@ struct sighand_struct;
 struct signal_struct;
 struct task_delay_info;
 struct task_group;
+struct user_event_mm;
 
 /*
  * Task state bitmask. NOTE! These bits are also
@@ -1522,6 +1523,10 @@ struct task_struct {
 	union rv_task_monitor		rv[RV_PER_TASK_MONITORS];
 #endif
 
+#ifdef CONFIG_USER_EVENTS
+	struct user_event_mm		*user_event_mm;
+#endif
+
 	/*
 	 * New fields for task_struct should be added above here, so that
 	 * they are included in the randomized portion of task_struct.
diff --git a/include/linux/user_events.h b/include/linux/user_events.h
index 13689589d36e..3d747c45d2fa 100644
--- a/include/linux/user_events.h
+++ b/include/linux/user_events.h
@@ -11,4 +11,22 @@
 
 #include <uapi/linux/user_events.h>
 
+#ifdef CONFIG_USER_EVENTS
+struct user_event_mm {
+};
+#endif
+
+static inline void user_events_fork(struct task_struct *t,
+				    unsigned long clone_flags)
+{
+}
+
+static inline void user_events_execve(struct task_struct *t)
+{
+}
+
+static inline void user_events_exit(struct task_struct *t)
+{
+}
+
 #endif /* _LINUX_USER_EVENTS_H */
diff --git a/kernel/exit.c b/kernel/exit.c
index 15dc2ec80c46..e2aaaa81b281 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -68,6 +68,7 @@
 #include <linux/kprobes.h>
 #include <linux/rethook.h>
 #include <linux/sysfs.h>
+#include <linux/user_events.h>
 
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
@@ -816,6 +817,7 @@ void __noreturn do_exit(long code)
 
 	coredump_task_exit(tsk);
 	ptrace_event(PTRACE_EVENT_EXIT, code);
+	user_events_exit(tsk);
 
 	validate_creds_for_do_exit(tsk);
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 9f7fe3541897..180f6d86fbad 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -97,6 +97,7 @@
 #include <linux/io_uring.h>
 #include <linux/bpf.h>
 #include <linux/stackprotector.h>
+#include <linux/user_events.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -2502,6 +2503,7 @@ static __latent_entropy struct task_struct *copy_process(
 
 	trace_task_newtask(p, clone_flags);
 	uprobe_copy_process(p, clone_flags);
+	user_events_fork(p, clone_flags);
 
 	copy_oom_score_adj(clone_flags, p);
 
-- 
2.25.1

