Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342E9731832
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244277AbjFOMKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238157AbjFOMKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:10:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09E8194
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:10:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4817360A05
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 12:10:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97596C433C8;
        Thu, 15 Jun 2023 12:10:33 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>, chenhuacai@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] kthread: Rename user_mode_thread() to kmuser_thread()
Date:   Thu, 15 Jun 2023 20:10:16 +0800
Message-Id: <20230615121016.3731983-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.3
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

init and umh are different from typical kernel threads since the don't
need a "kthread" struct and they will finally become user processes by
calling kernel_execve(), but on the other hand, they are also different
from typical user mode threads (they have no "mm" structs at creation
time, which is traditionally used to distinguish a user thread and a
kernel thread).

In a former patch I treat init and umh as "special kernel threads" and
unify kernel_thread() and user_mode_thread() to kernel_thread() again.
However, the patch has been nacked because init and umh are essentially
"special user threads".

Nevertheless, I still agree with Andrews' comment "But the naming isn't
very good anyway. They should have been usermode_thread/kernel_thread or
user_thread/kernel_thread.".

Since Eric describes init and umh as "user threads run in kernel mode",
in this patch I rename user_mode_thread() as kmuser_thread(), which is
a little better than just user_thread().

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 include/linux/sched/task.h | 2 +-
 init/main.c                | 2 +-
 kernel/fork.c              | 4 ++--
 kernel/umh.c               | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index e0f5ac90a228..c774d604b0a3 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -98,7 +98,7 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node);
 struct task_struct *fork_idle(int);
 extern pid_t kernel_thread(int (*fn)(void *), void *arg, const char *name,
 			    unsigned long flags);
-extern pid_t user_mode_thread(int (*fn)(void *), void *arg, unsigned long flags);
+extern pid_t kmuser_thread(int (*fn)(void *), void *arg, unsigned long flags);
 extern long kernel_wait4(pid_t, int __user *, int, struct rusage *);
 int kernel_wait(pid_t pid, int *stat);
 
diff --git a/init/main.c b/init/main.c
index af50044deed5..362ba90d6f73 100644
--- a/init/main.c
+++ b/init/main.c
@@ -697,7 +697,7 @@ noinline void __ref __noreturn rest_init(void)
 	 * the init task will end up wanting to create kthreads, which, if
 	 * we schedule it before we create kthreadd, will OOPS.
 	 */
-	pid = user_mode_thread(kernel_init, NULL, CLONE_FS);
+	pid = kmuser_thread(kernel_init, NULL, CLONE_FS);
 	/*
 	 * Pin init on the boot CPU. Task migration is not properly working
 	 * until sched_init_smp() has been run. It will set the allowed
diff --git a/kernel/fork.c b/kernel/fork.c
index 41c964104b58..57d5c8c1766e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2978,9 +2978,9 @@ pid_t kernel_thread(int (*fn)(void *), void *arg, const char *name,
 }
 
 /*
- * Create a user mode thread.
+ * Create a kernel mode user thread.
  */
-pid_t user_mode_thread(int (*fn)(void *), void *arg, unsigned long flags)
+pid_t kmuser_thread(int (*fn)(void *), void *arg, unsigned long flags)
 {
 	struct kernel_clone_args args = {
 		.flags		= ((lower_32_bits(flags) | CLONE_VM |
diff --git a/kernel/umh.c b/kernel/umh.c
index 60aa9e764a38..28c0cf0da7be 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -130,7 +130,7 @@ static void call_usermodehelper_exec_sync(struct subprocess_info *sub_info)
 
 	/* If SIGCLD is ignored do_wait won't populate the status. */
 	kernel_sigaction(SIGCHLD, SIG_DFL);
-	pid = user_mode_thread(call_usermodehelper_exec_async, sub_info, SIGCHLD);
+	pid = kmuser_thread(call_usermodehelper_exec_async, sub_info, SIGCHLD);
 	if (pid < 0)
 		sub_info->retval = pid;
 	else
@@ -169,7 +169,7 @@ static void call_usermodehelper_exec_work(struct work_struct *work)
 		 * want to pollute current->children, and we need a parent
 		 * that always ignores SIGCHLD to ensure auto-reaping.
 		 */
-		pid = user_mode_thread(call_usermodehelper_exec_async, sub_info,
+		pid = kmuser_thread(call_usermodehelper_exec_async, sub_info,
 				       CLONE_PARENT | SIGCHLD);
 		if (pid < 0) {
 			sub_info->retval = pid;
-- 
2.39.3

