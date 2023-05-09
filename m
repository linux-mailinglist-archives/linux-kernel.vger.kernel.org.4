Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FFA6FC421
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 12:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235323AbjEIKm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 06:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235299AbjEIKmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 06:42:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108A3106CF
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 03:42:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68AB364595
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 10:42:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388D1C4339C;
        Tue,  9 May 2023 10:42:14 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>, chenhuacai@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH RFC] kthread: Unify kernel_thread() and user_mode_thread()
Date:   Tue,  9 May 2023 18:41:27 +0800
Message-Id: <20230509104127.1997562-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 343f4c49f2438d8 ("kthread: Don't allocate kthread_struct for init
and umh") introduces a new function user_mode_thread() for init and umh.
But the name is a bit confusing because init and umh are indeed kernel
threads at creation time, the real difference is "they will become user
processes". So let's unify the kernel_thread() and user_mode_thread() to
kernel_thread() again, and add a new 'user' parameter for init and umh.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 include/linux/sched/task.h |  3 +--
 init/main.c                |  4 ++--
 kernel/fork.c              | 20 ++------------------
 kernel/kthread.c           |  2 +-
 kernel/umh.c               |  6 +++---
 5 files changed, 9 insertions(+), 26 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 537cbf9a2ade..1fc09768257c 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -98,8 +98,7 @@ struct task_struct *copy_process(struct pid *pid, int trace, int node,
 struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node);
 struct task_struct *fork_idle(int);
 extern pid_t kernel_thread(int (*fn)(void *), void *arg, const char *name,
-			    unsigned long flags);
-extern pid_t user_mode_thread(int (*fn)(void *), void *arg, unsigned long flags);
+			    unsigned long flags, int user);
 extern long kernel_wait4(pid_t, int __user *, int, struct rusage *);
 int kernel_wait(pid_t pid, int *stat);
 
diff --git a/init/main.c b/init/main.c
index af50044deed5..487d93da5eea 100644
--- a/init/main.c
+++ b/init/main.c
@@ -697,7 +697,7 @@ noinline void __ref __noreturn rest_init(void)
 	 * the init task will end up wanting to create kthreads, which, if
 	 * we schedule it before we create kthreadd, will OOPS.
 	 */
-	pid = user_mode_thread(kernel_init, NULL, CLONE_FS);
+	pid = kernel_thread(kernel_init, NULL, NULL, CLONE_FS, 1);
 	/*
 	 * Pin init on the boot CPU. Task migration is not properly working
 	 * until sched_init_smp() has been run. It will set the allowed
@@ -710,7 +710,7 @@ noinline void __ref __noreturn rest_init(void)
 	rcu_read_unlock();
 
 	numa_default_policy();
-	pid = kernel_thread(kthreadd, NULL, NULL, CLONE_FS | CLONE_FILES);
+	pid = kernel_thread(kthreadd, NULL, NULL, CLONE_FS | CLONE_FILES, 0);
 	rcu_read_lock();
 	kthreadd_task = find_task_by_pid_ns(pid, &init_pid_ns);
 	rcu_read_unlock();
diff --git a/kernel/fork.c b/kernel/fork.c
index ed4e01daccaa..eeaf50944a0b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2965,7 +2965,7 @@ pid_t kernel_clone(struct kernel_clone_args *args)
  * Create a kernel thread.
  */
 pid_t kernel_thread(int (*fn)(void *), void *arg, const char *name,
-		    unsigned long flags)
+		    unsigned long flags, int user)
 {
 	struct kernel_clone_args args = {
 		.flags		= ((lower_32_bits(flags) | CLONE_VM |
@@ -2974,23 +2974,7 @@ pid_t kernel_thread(int (*fn)(void *), void *arg, const char *name,
 		.fn		= fn,
 		.fn_arg		= arg,
 		.name		= name,
-		.kthread	= 1,
-	};
-
-	return kernel_clone(&args);
-}
-
-/*
- * Create a user mode thread.
- */
-pid_t user_mode_thread(int (*fn)(void *), void *arg, unsigned long flags)
-{
-	struct kernel_clone_args args = {
-		.flags		= ((lower_32_bits(flags) | CLONE_VM |
-				    CLONE_UNTRACED) & ~CSIGNAL),
-		.exit_signal	= (lower_32_bits(flags) & CSIGNAL),
-		.fn		= fn,
-		.fn_arg		= arg,
+		.kthread	= !user,
 	};
 
 	return kernel_clone(&args);
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 490792b1066e..f4ac241c8d94 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -400,7 +400,7 @@ static void create_kthread(struct kthread_create_info *create)
 #endif
 	/* We want our own signal handler (we take no signals by default). */
 	pid = kernel_thread(kthread, create, create->full_name,
-			    CLONE_FS | CLONE_FILES | SIGCHLD);
+			    CLONE_FS | CLONE_FILES | SIGCHLD, 0);
 	if (pid < 0) {
 		/* Release the structure when caller killed by a fatal signal. */
 		struct completion *done = xchg(&create->done, NULL);
diff --git a/kernel/umh.c b/kernel/umh.c
index 60aa9e764a38..ec4ec12094b5 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -130,7 +130,7 @@ static void call_usermodehelper_exec_sync(struct subprocess_info *sub_info)
 
 	/* If SIGCLD is ignored do_wait won't populate the status. */
 	kernel_sigaction(SIGCHLD, SIG_DFL);
-	pid = user_mode_thread(call_usermodehelper_exec_async, sub_info, SIGCHLD);
+	pid = kernel_thread(call_usermodehelper_exec_async, sub_info, NULL, SIGCHLD, 1);
 	if (pid < 0)
 		sub_info->retval = pid;
 	else
@@ -169,8 +169,8 @@ static void call_usermodehelper_exec_work(struct work_struct *work)
 		 * want to pollute current->children, and we need a parent
 		 * that always ignores SIGCHLD to ensure auto-reaping.
 		 */
-		pid = user_mode_thread(call_usermodehelper_exec_async, sub_info,
-				       CLONE_PARENT | SIGCHLD);
+		pid = kernel_thread(call_usermodehelper_exec_async, sub_info,
+				       NULL, CLONE_PARENT | SIGCHLD, 1);
 		if (pid < 0) {
 			sub_info->retval = pid;
 			umh_complete(sub_info);
-- 
2.39.1

