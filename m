Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6703F6B3DAB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 12:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjCJL1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 06:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjCJL0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 06:26:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC5AC9A4A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 03:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678447573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QuePB9CGeUn2nwUN/prBkWMxpBRB1OgcU+YzFHJpYE4=;
        b=UUuCreZDsFLiOF0QhuM4DyjtDiotOWVzJzMzMuEWG/MW9vJcvpjpgLBaSP9MZO18c2TAlN
        OUZpIeyEOE6rmgEV8E2AgeJQdhHLArZqbwq1fOf/Ex25xbbONhJkHOjgonSYqvNNaDw9a6
        ip8uA/lgL2jBewlvczK89D03/XweowA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-nepR23YANCmHj3P5bxfTEA-1; Fri, 10 Mar 2023 06:26:10 -0500
X-MC-Unique: nepR23YANCmHj3P5bxfTEA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C02B1C2C4E2;
        Fri, 10 Mar 2023 11:26:09 +0000 (UTC)
Received: from carbon.redhat.com (unknown [10.39.194.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7E64CC15BAD;
        Fri, 10 Mar 2023 11:26:05 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     keescook@chromium.org, bristot@redhat.com, ebiederm@xmission.com,
        brauner@kernel.org, cyphar@cyphar.com, viro@zeniv.linux.org.uk,
        walters@verbum.org, avagin@gmail.com, alexl@redhat.com,
        peterz@infradead.org, bmasney@redhat.com, gscrivan@redhat.com
Subject: [PATCH v4 1/3] exec: add PR_HIDE_SELF_EXE prctl
Date:   Fri, 10 Mar 2023 12:25:52 +0100
Message-Id: <20230310112554.1261731-1-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new prctl called PR_HIDE_SELF_EXE which allows
processes to hide their own /proc/self/exe file. When this prctl is
used, every access to /proc/self/exe for the calling process will
fail with EPERM.

This is useful for preventing issues like CVE-2019-5736, where an
attacker can gain host root access by overwriting the binary
in OCI runtimes through file-descriptor mishandling in containers.

The current fix for CVE-2019-5736 is to create a read-only copy or
a bind-mount of the current executable, and then re-exec the current
process.  With the new prctl, the read-only copy or bind-mount copy is
not needed anymore.

Once prctl(PR_HIDE_SELF_EXE) is set, it will blocks PR_SET_DUMPABLE to
be set again.  It is not done automatically so that PR_SET_DUMPABLE
can be set at a later time if needed, e.g. a container runtime might
want to do that after the user namespace is joined.

It is currently kind of expected that a container uses execve to pass
control to a binary in the container chroot, since the /proc/self/exe
and /proc/self/map_files refer to files that are not part of the
container itself; so if the process can be compromised in any way
(e.g. an interpreter running a script in the container without calling
execve), it could potentially lead to host compromise.  It is
necessary to ensure that the current process cannot be set to dumpable
anymore, since that would allow another process in the container to
get access to its proc files.

A container runtime could use the new prctl in the following way:

- run prctl(PR_HIDE_SELF_EXE) as soon as possible.
- if prctl(PR_HIDE_SELF_EXE) fails then use the more expensive current
  fallbacks mechanism.
- perform all operations that require the process to be dumpable.
- prctl(PR_SET_DUMPABLE, 0), as it is already done today.
- execve the new binary or run directly the interpreter.

Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
---
v3: https://lkml.org/lkml/2023/1/20/434

Differences from v3:

- rebased on top of the latest upstream master.
- now prctl(PR_HIDE_SELF_EXE) blocks access only from the same thread group, it
  won't break CRIU as v3 did.
- extend the prctl to also cover files under /proc/self/map_files.
- once prctl(PR_HIDE_SELF_EXE) is used, it is not possible to unset
  SUID_DUMP_DISABLE anymore.  This is useful for the case where the container
  doesn't use execve to pass the control to a binary in the container chroot, and it
  prevents the process to be set to dumpable again since it would allow a different
  process in the container to get access to its proc files.
- cleaned up the selftest and added more checks.

v2: https://lkml.org/lkml/2023/1/19/849

Differences from v2:

- fixed the test to check PR_SET_HIDE_SELF_EXE after fork

v1: https://lkml.org/lkml/2023/1/4/334

Differences from v1:

- amended more information in the commit message wrt map_files not
  requiring the same protection.
- changed the test to verify PR_HIDE_SELF_EXE cannot be unset after
  a fork.

fs/exec.c                        |  1 +
 fs/proc/base.c                   |  9 +++++++++
 include/linux/sched.h            |  5 +++++
 include/uapi/linux/prctl.h       |  3 +++
 kernel/sys.c                     | 13 +++++++++++++
 tools/include/uapi/linux/prctl.h |  3 +++
 6 files changed, 34 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index 7c44d0c65b1b..d40e019a5ac5 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1858,6 +1858,7 @@ static int bprm_execve(struct linux_binprm *bprm,
 	/* execve succeeded */
 	current->fs->in_exec = 0;
 	current->in_execve = 0;
+	task_clear_hide_self_exe(current);
 	rseq_execve(current);
 	acct_update_integrals(current);
 	task_numa_free(current, false);
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 5e0e0ccd47aa..14102a133655 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1719,16 +1719,25 @@ static const struct file_operations proc_pid_set_comm_operations = {
 	.release	= single_release,
 };
 
+static inline bool is_hide_self_exe_blocked(struct task_struct *task)
+{
+	return task_hide_self_exe(task) && same_thread_group(current, task);
+}
+
 static int proc_exe_link(struct dentry *dentry, struct path *exe_path)
 {
 	struct task_struct *task;
 	struct file *exe_file;
+	bool hide_self_exe;
 
 	task = get_proc_task(d_inode(dentry));
 	if (!task)
 		return -ENOENT;
 	exe_file = get_task_exe_file(task);
+	hide_self_exe = is_hide_self_exe_blocked(task);
 	put_task_struct(task);
+	if (hide_self_exe)
+		return -EPERM;
 	if (exe_file) {
 		*exe_path = exe_file->f_path;
 		path_get(&exe_file->f_path);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 63d242164b1a..fb1faaabe795 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1796,6 +1796,7 @@ static __always_inline bool is_percpu_thread(void)
 #define PFA_SPEC_IB_DISABLE		5	/* Indirect branch speculation restricted */
 #define PFA_SPEC_IB_FORCE_DISABLE	6	/* Indirect branch speculation permanently restricted */
 #define PFA_SPEC_SSB_NOEXEC		7	/* Speculative Store Bypass clear on execve() */
+#define PFA_HIDE_SELF_EXE		8	/* Hide /proc/self/exe for the process */
 
 #define TASK_PFA_TEST(name, func)					\
 	static inline bool task_##func(struct task_struct *p)		\
@@ -1838,6 +1839,10 @@ TASK_PFA_CLEAR(SPEC_IB_DISABLE, spec_ib_disable)
 TASK_PFA_TEST(SPEC_IB_FORCE_DISABLE, spec_ib_force_disable)
 TASK_PFA_SET(SPEC_IB_FORCE_DISABLE, spec_ib_force_disable)
 
+TASK_PFA_TEST(HIDE_SELF_EXE, hide_self_exe)
+TASK_PFA_SET(HIDE_SELF_EXE, hide_self_exe)
+TASK_PFA_CLEAR(HIDE_SELF_EXE, hide_self_exe)
+
 static inline void
 current_restore_flags(unsigned long orig_flags, unsigned long flags)
 {
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 1312a137f7fb..715c601b4fed 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -290,4 +290,7 @@ struct prctl_mm_map {
 #define PR_SET_VMA		0x53564d41
 # define PR_SET_VMA_ANON_NAME		0
 
+#define PR_SET_HIDE_SELF_EXE		67
+#define PR_GET_HIDE_SELF_EXE		68
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index 495cd87d9bf4..6e5aae861ae7 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2408,6 +2408,10 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			error = -EINVAL;
 			break;
 		}
+		if (task_hide_self_exe(me) && arg2 != SUID_DUMP_DISABLE) {
+			error = -EPERM;
+			break;
+		}
 		set_dumpable(me->mm, arg2);
 		break;
 
@@ -2661,6 +2665,15 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case PR_SET_VMA:
 		error = prctl_set_vma(arg2, arg3, arg4, arg5);
 		break;
+	case PR_SET_HIDE_SELF_EXE:
+		if (arg2 != 1 || arg3 || arg4 || arg5)
+			return -EINVAL;
+		task_set_hide_self_exe(current);
+		break;
+	case PR_GET_HIDE_SELF_EXE:
+		if (arg2 || arg3 || arg4 || arg5)
+			return -EINVAL;
+		return task_hide_self_exe(current) ? 1 : 0;
 	default:
 		error = -EINVAL;
 		break;
diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
index a5e06dcbba13..b4c7a6c248a9 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -284,4 +284,7 @@ struct prctl_mm_map {
 #define PR_SET_VMA		0x53564d41
 # define PR_SET_VMA_ANON_NAME		0
 
+#define PR_SET_HIDE_SELF_EXE		67
+#define PR_GET_HIDE_SELF_EXE		68
+
 #endif /* _LINUX_PRCTL_H */
-- 
2.39.2

