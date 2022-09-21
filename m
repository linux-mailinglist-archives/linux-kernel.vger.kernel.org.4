Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D865BF1FD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 02:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbiIUAbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 20:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiIUAb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 20:31:27 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91FA6E89D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 17:31:23 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id j11-20020a056a00234b00b005415b511595so2570157pfj.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 17:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=qGRWDcFaYPLFs5iWMNHMwoViduFR4vpceIvIvEWEb0c=;
        b=G/i8U4vsIWYH1IV3aQaZ8DdVienjwPw+dGLNUpALgd9qJL9wRtqvDlpY2jR2q0Gp47
         dQF6hd8ktTKq8bkBWYsSbPpTjkq8PxlniHwl8mxkV5bFucQ5ldvyyW/ZQXO1jluuWYEM
         ENub1isdMitvr5tLh+nytU+E9lfIQ08H/nN0anELye/l5GyImtPxh7jBvhs/jxakPeuZ
         EPfabH75hZf5j5pKqpoTFqIq5OlhjZ+0QUVk+K26FKvYxpeD7rXW1ENEs1Oqpy0e6yOf
         KLYEWMEXYDPEksnzj67jt9o3rXGFpecCkK5Orv0JoRJ+ks/e9BBzWvl2vBMrJb+DfJxk
         s4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=qGRWDcFaYPLFs5iWMNHMwoViduFR4vpceIvIvEWEb0c=;
        b=RRzU3Sblj6OCVHm+2Zc/tCU4LGG1/G0boxmf3XuHgTpuiUIAJoAVYiuQqDVuzXNxHR
         4TatTLcrgZrXaLp+Gvb9/1mil++D3ltIXIy+B89i723h0cYP2soCd8/4hWceG8O2TXkb
         D0ew4Hp8sSD7mnToudy6iqX3VGXs8yS3n7+9CmJUT8bL4frUz/tG1G55Fl1rsgak1p5m
         4pXJmPnR98qO/omOgXxnONaf0E9jTlU2TrRa/rvR2CAouPSl6CD/mSgPRGq/M09fXEnM
         grCWhvdkA36MjWxmBvddgPeiQYiRLyzwRmScYxTpYtnnL7+2jCddlYWQ/m7S5cexBrWx
         vpOA==
X-Gm-Message-State: ACrzQf3FQfsnrzFUN977f4pY266zfqGgGn8hCLcHhQhdYF5mDckQbcOA
        1xWhsmGj1xpbK/d+kpeohs2EmgYmPjk=
X-Google-Smtp-Source: AMsMyM6b+/mMnOuAYp2ZKCTY6zX8DuHGYF9oOBrlhFMVXmv5SjeuOTGX+grjgWST4otL4YpXIj2/zMiW6LM=
X-Received: from avagin.kir.corp.google.com ([2620:15c:29:204:2436:675:9889:e5ed])
 (user=avagin job=sendgmr) by 2002:aa7:90d4:0:b0:544:9a9c:f563 with SMTP id
 k20-20020aa790d4000000b005449a9cf563mr27182997pfk.70.1663720283342; Tue, 20
 Sep 2022 17:31:23 -0700 (PDT)
Date:   Tue, 20 Sep 2022 17:31:19 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
Message-ID: <20220921003120.209637-1-avagin@google.com>
Subject: [PATCH 1/2] fs/exec: switch timens when a task gets a new mm
From:   Andrei Vagin <avagin@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Alexey Izbyshev <izbyshev@ispras.ru>,
        Christian Brauner <brauner@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Florian Weimer <fweimer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

Changing a time namespace requires remapping a vvar page, so we don't want
to allow doing that if any other tasks can use the same mm.

Currently, we install a time namespace when a task is created with a new
vm. exec() is another case when a task gets a new mm and so it can switch
a time namespace safely, but it isn't handled now.

One more issue of the current interface is that clone() with CLONE_VM isn't
allowed if the current task has unshared a time namespace
(timens_for_children doesn't match the current timens).

Both these issues make some inconvenience for users. For example, Alexey
and Florian reported that posix_spawn() uses vfork+exec and this pattern
doesn't work with time namespaces due to the both described issues.
LXC needed to workaround the exec() issue by calling setns.

In the commit 133e2d3e81de5 ("fs/exec: allow to unshare a time namespace on
vfork+exec"), we tried to fix these issues with minimal impact on UAPI. But
it adds extra complexity and some undesirable side effects. Eric suggested
fixing the issues properly because here are all the reasons to suppose that
there are no users that depend on the old behavior.

Cc: Alexey Izbyshev <izbyshev@ispras.ru>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Suggested-by: "Eric W. Biederman" <ebiederm@xmission.com>
Origin-author: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 fs/exec.c               |  5 +++++
 include/linux/nsproxy.h |  1 +
 kernel/fork.c           |  9 ---------
 kernel/nsproxy.c        | 23 +++++++++++++++++++++--
 4 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index d046dbb9cbd0..71284188b96d 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -65,6 +65,7 @@
 #include <linux/io_uring.h>
 #include <linux/syscall_user_dispatch.h>
 #include <linux/coredump.h>
+#include <linux/time_namespace.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -1296,6 +1297,10 @@ int begin_new_exec(struct linux_binprm * bprm)
 
 	bprm->mm = NULL;
 
+	retval = exec_task_namespaces();
+	if (retval)
+		goto out_unlock;
+
 #ifdef CONFIG_POSIX_TIMERS
 	spin_lock_irq(&me->sighand->siglock);
 	posix_cpu_timers_exit(me);
diff --git a/include/linux/nsproxy.h b/include/linux/nsproxy.h
index cdb171efc7cb..fee881cded01 100644
--- a/include/linux/nsproxy.h
+++ b/include/linux/nsproxy.h
@@ -94,6 +94,7 @@ static inline struct cred *nsset_cred(struct nsset *set)
 int copy_namespaces(unsigned long flags, struct task_struct *tsk);
 void exit_task_namespaces(struct task_struct *tsk);
 void switch_task_namespaces(struct task_struct *tsk, struct nsproxy *new);
+int exec_task_namespaces(void);
 void free_nsproxy(struct nsproxy *ns);
 int unshare_nsproxy_namespaces(unsigned long, struct nsproxy **,
 	struct cred *, struct fs_struct *);
diff --git a/kernel/fork.c b/kernel/fork.c
index 2b6bd511c6ed..4eb803f75225 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2044,15 +2044,6 @@ static __latent_entropy struct task_struct *copy_process(
 			return ERR_PTR(-EINVAL);
 	}
 
-	/*
-	 * If the new process will be in a different time namespace
-	 * do not allow it to share VM or a thread group with the forking task.
-	 */
-	if (clone_flags & (CLONE_THREAD | CLONE_VM)) {
-		if (nsp->time_ns != nsp->time_ns_for_children)
-			return ERR_PTR(-EINVAL);
-	}
-
 	if (clone_flags & CLONE_PIDFD) {
 		/*
 		 * - CLONE_DETACHED is blocked so that we can potentially
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index eec72ca962e2..a487ff24129b 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -157,7 +157,8 @@ int copy_namespaces(unsigned long flags, struct task_struct *tsk)
 	if (likely(!(flags & (CLONE_NEWNS | CLONE_NEWUTS | CLONE_NEWIPC |
 			      CLONE_NEWPID | CLONE_NEWNET |
 			      CLONE_NEWCGROUP | CLONE_NEWTIME)))) {
-		if (likely(old_ns->time_ns_for_children == old_ns->time_ns)) {
+		if ((flags & CLONE_VM) ||
+		    likely(old_ns->time_ns_for_children == old_ns->time_ns)) {
 			get_nsproxy(old_ns);
 			return 0;
 		}
@@ -179,7 +180,8 @@ int copy_namespaces(unsigned long flags, struct task_struct *tsk)
 	if (IS_ERR(new_ns))
 		return  PTR_ERR(new_ns);
 
-	timens_on_fork(new_ns, tsk);
+	if ((flags & CLONE_VM) == 0)
+		timens_on_fork(new_ns, tsk);
 
 	tsk->nsproxy = new_ns;
 	return 0;
@@ -254,6 +256,23 @@ void exit_task_namespaces(struct task_struct *p)
 	switch_task_namespaces(p, NULL);
 }
 
+int exec_task_namespaces(void)
+{
+	struct task_struct *tsk = current;
+	struct nsproxy *new;
+
+	if (tsk->nsproxy->time_ns_for_children == tsk->nsproxy->time_ns)
+		return 0;
+
+	new = create_new_namespaces(0, tsk, current_user_ns(), tsk->fs);
+	if (IS_ERR(new))
+		return PTR_ERR(new);
+
+	timens_on_fork(new, tsk);
+	switch_task_namespaces(tsk, new);
+	return 0;
+}
+
 static int check_setns_flags(unsigned long flags)
 {
 	if (!flags || (flags & ~(CLONE_NEWNS | CLONE_NEWUTS | CLONE_NEWIPC |
-- 
2.37.3.968.ga6b4b080e4-goog

