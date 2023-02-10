Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC2B691917
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 08:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjBJHZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 02:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbjBJHZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 02:25:17 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EB674302;
        Thu,  9 Feb 2023 23:25:15 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id s89-20020a17090a2f6200b0023125ebb4b1so4698655pjd.3;
        Thu, 09 Feb 2023 23:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nyo5FBFMhxUs0FFeXxjh9eO+Nqz3VUgDmDHgRRExFCA=;
        b=p9m6W08ExoXrqbjTQRFF5tI+KHHnLpR1M2SANdDbVBHwhiy9VSuiLBsNxA+jSfT7h3
         ltNsEj7ChuI5DyLmJF/urs/z9GQKI1YthF7j37ERy100W8KoIi1Jt+X+ywVqRljyWJDm
         Ss68HgM4zc8hFu9OldN6M5G1NqCl8Gq9vejh9lLwGTH988fpzIV+wWUWCFjwY+hgqOYc
         ymw1l1piT0OOD9uxQTO1rzRlYijeRI+y7Ld+RrbrZGuYx7C7yKAD2JwmWSMSzWE2uhEJ
         Wi+frgFj+xfSTSQqkuPccudSdLdWcxi6DXh3w214XC1ATZLmA1WNswjEvgnzmts9+A6z
         G0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nyo5FBFMhxUs0FFeXxjh9eO+Nqz3VUgDmDHgRRExFCA=;
        b=EGls2aU9AgxaQcW7E85dlLZPPLXQUuJos0U0rmlj3Z1GswJZKfRqOC5s4q3+wtnypm
         GMH9pi95HZVxklJP9RZTMxWmf4NDuUOxFeDai2PsmHbNXslMw6kE0XNxIm6egjQ3/llB
         4HXeChYe/JhpSM1S1cuRJlX/X5e/bEUcdCgFVCFQG0qCNNHm9Ux9Wsg/94Qx7XynfleI
         lkUHse5wYYYZsLG1iMp8TMWT8o/C6vQLmnbrK4oIA6JC+liQPKBGVB3VH1NeNxrE6aqt
         8OKVJQA0vdX4asLzAUwpFxAeY2y3qu6LkYcv762FVLYgDwifH8mT7TnhKQAdKCmb/g4f
         CJ3A==
X-Gm-Message-State: AO0yUKVWC4O1nysGjCJ9rrMJA3iAOTHTSkaJXRzwEaU1Rvyb1vd/855C
        JK3KzmjKgFyJ6mA7doDPm3dTmNHGCM5w
X-Google-Smtp-Source: AK7set+KNx9v7X5r4gyAZyA/iZPr6e4uZQ6lQTJMP6sa1YLHii9aud+FxWMRzY1kqyzvhVUDG2qr6A==
X-Received: by 2002:a17:902:d506:b0:199:4ff5:6e73 with SMTP id b6-20020a170902d50600b001994ff56e73mr5249798plg.3.1676013915019;
        Thu, 09 Feb 2023 23:25:15 -0800 (PST)
Received: from fedora.mshome.net ([172.56.184.138])
        by smtp.gmail.com with ESMTPSA id k22-20020a170902761600b00196217f1219sm2705658pll.70.2023.02.09.23.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 23:25:14 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, oleg@redhat.com, avagin@gmail.com,
        peterz@infradead.org, luto@kernel.org, krisman@collabora.com,
        tglx@linutronix.de, corbet@lwn.net, shuah@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v9 1/1] ptrace,syscall_user_dispatch: checkpoint/restore support for SUD
Date:   Fri, 10 Feb 2023 02:25:03 -0500
Message-Id: <20230210072503.1808-2-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230210072503.1808-1-gregory.price@memverge.com>
References: <20230210072503.1808-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement ptrace getter/setter interface for syscall user dispatch.

These prctl settings are presently write-only, making it impossible to
implement transparent checkpoint/restore via software like CRIU.

'on_dispatch' field is not exposed because it is a kernel-internal
only field that cannot be 'true' when returning to userland.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 .../admin-guide/syscall-user-dispatch.rst     |  5 +-
 include/linux/syscall_user_dispatch.h         | 18 +++++
 include/uapi/linux/ptrace.h                   | 29 +++++++
 kernel/entry/syscall_user_dispatch.c          | 63 +++++++++++++--
 kernel/ptrace.c                               |  9 +++
 tools/testing/selftests/ptrace/.gitignore     |  1 +
 tools/testing/selftests/ptrace/Makefile       |  2 +-
 tools/testing/selftests/ptrace/get_set_sud.c  | 80 +++++++++++++++++++
 8 files changed, 197 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/ptrace/get_set_sud.c

diff --git a/Documentation/admin-guide/syscall-user-dispatch.rst b/Documentation/admin-guide/syscall-user-dispatch.rst
index 60314953c728..a23ae21a1d5b 100644
--- a/Documentation/admin-guide/syscall-user-dispatch.rst
+++ b/Documentation/admin-guide/syscall-user-dispatch.rst
@@ -43,7 +43,10 @@ doesn't rely on any of the syscall ABI to make the filtering.  It uses
 only the syscall dispatcher address and the userspace key.
 
 As the ABI of these intercepted syscalls is unknown to Linux, these
-syscalls are not instrumentable via ptrace or the syscall tracepoints.
+syscalls are not instrumentable via ptrace or the syscall tracepoints,
+however an interfaces to suspend, checkpoint, and restore syscall user
+dispatch configuration has been added to ptrace to assist userland
+checkpoint/restart software.
 
 Interface
 ---------
diff --git a/include/linux/syscall_user_dispatch.h b/include/linux/syscall_user_dispatch.h
index a0ae443fb7df..641ca8880995 100644
--- a/include/linux/syscall_user_dispatch.h
+++ b/include/linux/syscall_user_dispatch.h
@@ -22,6 +22,12 @@ int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
 #define clear_syscall_work_syscall_user_dispatch(tsk) \
 	clear_task_syscall_work(tsk, SYSCALL_USER_DISPATCH)
 
+int syscall_user_dispatch_get_config(struct task_struct *task, unsigned long size,
+				     void __user *data);
+
+int syscall_user_dispatch_set_config(struct task_struct *task, unsigned long size,
+				     void __user *data);
+
 #else
 struct syscall_user_dispatch {};
 
@@ -35,6 +41,18 @@ static inline void clear_syscall_work_syscall_user_dispatch(struct task_struct *
 {
 }
 
+static inline int syscall_user_dispatch_get_config(struct task_struct *task,
+						   unsigned long size, void __user *data)
+{
+	return -EINVAL;
+}
+
+static inline int syscall_user_dispatch_set_config(struct task_struct *task,
+						   unsigned long size, void __user *data)
+{
+	return -EINVAL;
+}
+
 #endif /* CONFIG_GENERIC_ENTRY */
 
 #endif /* _SYSCALL_USER_DISPATCH_H */
diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
index 195ae64a8c87..e79739e86a68 100644
--- a/include/uapi/linux/ptrace.h
+++ b/include/uapi/linux/ptrace.h
@@ -112,6 +112,35 @@ struct ptrace_rseq_configuration {
 	__u32 pad;
 };
 
+#define PTRACE_SET_SYSCALL_USER_DISPATCH_CONFIG 0x4210
+#define PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG 0x4211
+
+/*
+ * struct ptrace_sud_config - Per-task configuration for SUD
+ * @mode:	One of PR_SYS_DISPATCH_ON or PR_SYS_DISPATCH_OFF
+ * @selector:	Tracee's user virtual address of SUD selector
+ * @offset:	SUD exclusion area (virtual address)
+ * @len:	Length of SUD exclusion area
+ *
+ * Used to get/set the syscall user dispatch configuration for tracee.
+ * process.  Selector is optional (may be NULL), and if invalid will produce
+ * a SIGSEGV in the tracee upon first access.
+ *
+ * If mode is PR_SYS_DISPATCH_ON, syscall dispatch will be enabled. If
+ * PR_SYS_DISPATCH_OFF, syscall dispatch will be disabled and all other
+ * parameters must be 0.  The value in *selector (if not null), also determines
+ * whether syscall dispatch will occur.
+ *
+ * The SUD Exclusion area described by offset/len is the virtual address space
+ * from which syscalls will not produce a user dispatch.
+ */
+struct ptrace_sud_config {
+	__u64 mode;
+	__s8 *selector;
+	__u64 offset;
+	__u64 len;
+};
+
 /*
  * These values are stored in task->ptrace_message
  * by ptrace_stop to describe the current syscall-stop.
diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
index 0b6379adff6b..7fffcf1a53cb 100644
--- a/kernel/entry/syscall_user_dispatch.c
+++ b/kernel/entry/syscall_user_dispatch.c
@@ -4,6 +4,7 @@
  */
 #include <linux/sched.h>
 #include <linux/prctl.h>
+#include <linux/ptrace.h>
 #include <linux/syscall_user_dispatch.h>
 #include <linux/uaccess.h>
 #include <linux/signal.h>
@@ -68,8 +69,9 @@ bool syscall_user_dispatch(struct pt_regs *regs)
 	return true;
 }
 
-int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
-			      unsigned long len, char __user *selector)
+static int task_set_syscall_user_dispatch(struct task_struct *task, unsigned long mode,
+		                          unsigned long offset, unsigned long len,
+		                          char __user *selector)
 {
 	switch (mode) {
 	case PR_SYS_DISPATCH_OFF:
@@ -94,15 +96,60 @@ int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
 		return -EINVAL;
 	}
 
-	current->syscall_dispatch.selector = selector;
-	current->syscall_dispatch.offset = offset;
-	current->syscall_dispatch.len = len;
-	current->syscall_dispatch.on_dispatch = false;
+	task->syscall_dispatch.selector = selector;
+	task->syscall_dispatch.offset = offset;
+	task->syscall_dispatch.len = len;
+	task->syscall_dispatch.on_dispatch = false;
 
 	if (mode == PR_SYS_DISPATCH_ON)
-		set_syscall_work(SYSCALL_USER_DISPATCH);
+		set_task_syscall_work(task, SYSCALL_USER_DISPATCH);
 	else
-		clear_syscall_work(SYSCALL_USER_DISPATCH);
+		clear_task_syscall_work(task, SYSCALL_USER_DISPATCH);
 
 	return 0;
 }
+
+int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
+		              unsigned long len, char __user *selector)
+{
+	return task_set_syscall_user_dispatch(current, mode, offset, len, selector);
+}
+
+int syscall_user_dispatch_get_config(struct task_struct *task, unsigned long size,
+		                     void __user *data)
+{
+	struct syscall_user_dispatch *sd = &task->syscall_dispatch;
+	struct ptrace_sud_config config;
+
+	if (size != sizeof(struct ptrace_sud_config))
+		return -EINVAL;
+
+	if (test_task_syscall_work(task, SYSCALL_USER_DISPATCH))
+		config.mode = PR_SYS_DISPATCH_ON;
+	else
+		config.mode = PR_SYS_DISPATCH_OFF;
+
+	config.offset = sd->offset;
+	config.len = sd->len;
+	config.selector = sd->selector;
+
+	if (copy_to_user(data, &config, sizeof(config)))
+		return -EFAULT;
+
+	return 0;
+}
+
+int syscall_user_dispatch_set_config(struct task_struct *task, unsigned long size,
+		                     void __user *data)
+{
+	struct ptrace_sud_config config;
+
+	if (size != sizeof(struct ptrace_sud_config))
+		return -EINVAL;
+
+	if (copy_from_user(&config, data, sizeof(config)))
+		return -EFAULT;
+
+	return task_set_syscall_user_dispatch(task, config.mode, config.offset,
+	                                      config.len, config.selector);
+}
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 54482193e1ed..d99376532b56 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -32,6 +32,7 @@
 #include <linux/compat.h>
 #include <linux/sched/signal.h>
 #include <linux/minmax.h>
+#include <linux/syscall_user_dispatch.h>
 
 #include <asm/syscall.h>	/* for syscall_get_* */
 
@@ -1259,6 +1260,14 @@ int ptrace_request(struct task_struct *child, long request,
 		break;
 #endif
 
+	case PTRACE_SET_SYSCALL_USER_DISPATCH_CONFIG:
+		ret = syscall_user_dispatch_set_config(child, addr, datavp);
+		break;
+
+	case PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG:
+		ret = syscall_user_dispatch_get_config(child, addr, datavp);
+		break;
+
 	default:
 		break;
 	}
diff --git a/tools/testing/selftests/ptrace/.gitignore b/tools/testing/selftests/ptrace/.gitignore
index 792318aaa30c..b7dde152e75a 100644
--- a/tools/testing/selftests/ptrace/.gitignore
+++ b/tools/testing/selftests/ptrace/.gitignore
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 get_syscall_info
+get_set_sud
 peeksiginfo
 vmaccess
diff --git a/tools/testing/selftests/ptrace/Makefile b/tools/testing/selftests/ptrace/Makefile
index 2f1f532c39db..33a36b73bcb9 100644
--- a/tools/testing/selftests/ptrace/Makefile
+++ b/tools/testing/selftests/ptrace/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -std=c99 -pthread -iquote../../../../include/uapi -Wall
 
-TEST_GEN_PROGS := get_syscall_info peeksiginfo vmaccess
+TEST_GEN_PROGS := get_syscall_info peeksiginfo vmaccess get_set_sud
 
 include ../lib.mk
diff --git a/tools/testing/selftests/ptrace/get_set_sud.c b/tools/testing/selftests/ptrace/get_set_sud.c
new file mode 100644
index 000000000000..b22ab35cbca7
--- /dev/null
+++ b/tools/testing/selftests/ptrace/get_set_sud.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include "../kselftest_harness.h"
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+#include <sys/wait.h>
+#include <sys/syscall.h>
+#include <sys/prctl.h>
+
+#include "linux/ptrace.h"
+
+static int sys_ptrace(int request, pid_t pid, void *addr, void *data)
+{
+	return syscall(SYS_ptrace, request, pid, addr, data);
+}
+
+TEST(get_set_sud)
+{
+	struct ptrace_sud_config config;
+	pid_t child;
+	int ret = 0;
+	int status;
+
+	child = fork();
+	ASSERT_GE(child, 0);
+	if (child == 0) {
+		ASSERT_EQ(0, sys_ptrace(PTRACE_TRACEME, 0, 0, 0)) {
+			TH_LOG("PTRACE_TRACEME: %m");
+		}
+		kill(getpid(), SIGSTOP);
+		sleep(2);
+		_exit(1);
+	}
+
+	waitpid(child, &status, 0);
+
+	config.mode = PR_SYS_DISPATCH_ON;
+	config.selector = (void*)0xDEADBEEF;
+	config.offset = 0x12345678;
+	config.len = 0x87654321;
+
+	ret = sys_ptrace(PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG, child,
+			 (void*)sizeof(config), &config);
+	if (ret < 0) {
+		ASSERT_EQ(errno, EIO);
+		goto leave;
+	}
+
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(config.mode, PR_SYS_DISPATCH_OFF);
+	ASSERT_EQ(config.selector, (void*)NULL);
+	ASSERT_EQ(config.offset, 0);
+	ASSERT_EQ(config.len, 0);
+
+	config.mode = PR_SYS_DISPATCH_ON;
+	config.selector = (void*)NULL;
+	config.offset = 0x400000;
+	config.len = 0x1000;
+
+	ret = sys_ptrace(PTRACE_SET_SYSCALL_USER_DISPATCH_CONFIG, child,
+			 (void*)sizeof(config), &config);
+
+	ASSERT_EQ(ret, 0);
+
+	memset(&config, 1, sizeof(config));
+	ret = sys_ptrace(PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG, child,
+			 (void*)sizeof(config), &config);
+
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(config.mode, PR_SYS_DISPATCH_ON);
+	ASSERT_EQ(config.selector, (void*)NULL);
+	ASSERT_EQ(config.offset, 0x400000);
+	ASSERT_EQ(config.len, 0x1000);
+
+leave:
+	kill(child, SIGKILL);
+}
+
+TEST_HARNESS_MAIN
-- 
2.39.1

