Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C16652F46
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 11:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbiLUKVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 05:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiLUKVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 05:21:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07073120B2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 02:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671618022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rZMl35g9o3N5e4d8Ph65UmYi5ZElld+YK7ZJYgVoFlI=;
        b=O50+w2cMlYFnZd4JZt1ueAFl/X6fnyRGxOuPknNeu7hcsq+/hcfKPM5Lqz9XHE/jFttc7s
        pnDwVanIGBz8Iz/19Tvmp5oBuYNR3yyu7BHgPRnhMqjp9ewx1I3LmVRFv77sOXJaGULItu
        iC7SUgGFNnMJ22qyhmk0vaLI816NRwU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-25-hSYzwpRUPaGU4jKGJ7rZpw-1; Wed, 21 Dec 2022 05:20:17 -0500
X-MC-Unique: hSYzwpRUPaGU4jKGJ7rZpw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C9F0802D19;
        Wed, 21 Dec 2022 10:20:16 +0000 (UTC)
Received: from lithium.redhat.com (unknown [10.39.193.218])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CBE311400E44;
        Wed, 21 Dec 2022 10:20:14 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     ebiederm@xmission.com, brauner@kernel.org, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, alexl@redhat.com, peterz@infradead.org,
        gscrivan@redhat.com
Subject: [PATCH RFC 1/2] exec: add PR_HIDE_SELF_EXE prctl
Date:   Wed, 21 Dec 2022 11:19:12 +0100
Message-Id: <20221221101913.484203-1-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new prctl called PR_HIDE_SELF_EXE which allows
processes to hide their own /proc/*/exe file. When this prctl is
used, every access to /proc/*/exe for the calling process will
fail with ENOENT.

This is useful for preventing issues like CVE-2019-5736, where an
attacker can gain host root access by overwriting the binary
in OCI runtimes through file-descriptor mishandling in containers.

The current fix for CVE-2019-5736 is to create a read-only copy or
a bind-mount of the current executable, and then re-exec the current
process.  With the new prctl, the read-only copy or bind-mount copy is
not needed anymore.

Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
---
 fs/exec.c                        | 1 +
 fs/proc/base.c                   | 8 +++++---
 include/linux/sched.h            | 5 +++++
 include/uapi/linux/prctl.h       | 3 +++
 kernel/sys.c                     | 9 +++++++++
 tools/include/uapi/linux/prctl.h | 3 +++
 6 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index ab913243a367..5a5dd964c3a3 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1855,6 +1855,7 @@ static int bprm_execve(struct linux_binprm *bprm,
 	/* execve succeeded */
 	current->fs->in_exec = 0;
 	current->in_execve = 0;
+	task_clear_hide_self_exe(current);
 	rseq_execve(current);
 	acct_update_integrals(current);
 	task_numa_free(current, false);
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 9e479d7d202b..959968e2da0d 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1723,19 +1723,21 @@ static int proc_exe_link(struct dentry *dentry, struct path *exe_path)
 {
 	struct task_struct *task;
 	struct file *exe_file;
+	long hide_self_exe;
 
 	task = get_proc_task(d_inode(dentry));
 	if (!task)
 		return -ENOENT;
 	exe_file = get_task_exe_file(task);
+	hide_self_exe = task_hide_self_exe(task);
 	put_task_struct(task);
-	if (exe_file) {
+	if (exe_file && !hide_self_exe) {
 		*exe_path = exe_file->f_path;
 		path_get(&exe_file->f_path);
 		fput(exe_file);
 		return 0;
-	} else
-		return -ENOENT;
+	}
+	return -ENOENT;
 }
 
 static const char *proc_pid_get_link(struct dentry *dentry,
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 853d08f7562b..8db32d5fc285 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1790,6 +1790,7 @@ static __always_inline bool is_percpu_thread(void)
 #define PFA_SPEC_IB_DISABLE		5	/* Indirect branch speculation restricted */
 #define PFA_SPEC_IB_FORCE_DISABLE	6	/* Indirect branch speculation permanently restricted */
 #define PFA_SPEC_SSB_NOEXEC		7	/* Speculative Store Bypass clear on execve() */
+#define PFA_HIDE_SELF_EXE		8	/* Hide /proc/self/exe for the process */
 
 #define TASK_PFA_TEST(name, func)					\
 	static inline bool task_##func(struct task_struct *p)		\
@@ -1832,6 +1833,10 @@ TASK_PFA_CLEAR(SPEC_IB_DISABLE, spec_ib_disable)
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
index a5e06dcbba13..f12f3df12468 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -284,4 +284,7 @@ struct prctl_mm_map {
 #define PR_SET_VMA		0x53564d41
 # define PR_SET_VMA_ANON_NAME		0
 
+#define PR_SET_HIDE_SELF_EXE		65
+#define PR_GET_HIDE_SELF_EXE		66
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index 5fd54bf0e886..e992f1b72973 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2626,6 +2626,15 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
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
index a5e06dcbba13..f12f3df12468 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -284,4 +284,7 @@ struct prctl_mm_map {
 #define PR_SET_VMA		0x53564d41
 # define PR_SET_VMA_ANON_NAME		0
 
+#define PR_SET_HIDE_SELF_EXE		65
+#define PR_GET_HIDE_SELF_EXE		66
+
 #endif /* _LINUX_PRCTL_H */
-- 
2.38.1

