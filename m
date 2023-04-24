Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61B36ED426
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbjDXSNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbjDXSN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:13:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAE34C35
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:13:26 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682360005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=e+wmQI2U4t0cN/nKLjKEoED1oMCxB/T69gTECdRBsgU=;
        b=OahCyx2QGvRF05hOsfd3oWePsfLx90rhFlMiJ3rWiI/cOwXh8gFSTXn5c3AY4ppiCq4dOP
        S7y80amCNih0w+KKn3QFnbJkLV2XnkTm+5hjJ3IJGsWjpYR+zTZxpva1CFRNQM9kCj3/r4
        4gyYPUAOilkqlIwQbQftcgXBzQ+ZHzKnkf6qkgExFym7J0LL5OoQCiOSgE6s/gIaPIX9CN
        PX1zalz/Cs7zxiV3n1C1S3Ap+wLlY0FmNVi7HKeCf4ZbV5lcBJHb07CTZfxYX+SZ8PB76a
        gVVmEzIyXKv2qGA1pIK9tBKav7BvXrODj5aYRmLKH/Qo6EbEiZzUihLOifv3og==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682360005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=e+wmQI2U4t0cN/nKLjKEoED1oMCxB/T69gTECdRBsgU=;
        b=TEY72/gLiQPMFJW5gibCeZ4YsA+ezyIPQXJYzAd+lJHndiBOTfhyACLwnD1akohnbqbcHc
        WiJm0yF37k9TlSCA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] core/entry for 6.4-rc1
References: <168235968801.840202.17752066425816055574.tglx@xen13>
Message-ID: <168235968948.840202.12520465196184040624.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 24 Apr 2023 20:13:24 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core/entry branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-entry-2023-=
04-24

up to:  8c8fa605f7b8: selftest, ptrace: Add selftest for syscall user dispatc=
h config api


Update for entry and ptrace:

  Provide a ptrace set/get interface for syscall user dispatch. The main
  purpose is to enable checkpoint/restore (CRIU) to handle processes which
  utilize syscall user dispatch correctly.


Thanks,

	tglx

------------------>
Gregory Price (4):
      syscall_user_dispatch: Split up set_syscall_user_dispatch()
      syscall_user_dispatch: Untag selector address before access_ok()
      ptrace: Provide set/get interface for syscall user dispatch
      selftest, ptrace: Add selftest for syscall user dispatch config api


 .../admin-guide/syscall-user-dispatch.rst          |  4 ++
 include/linux/syscall_user_dispatch.h              | 18 ++++++
 include/uapi/linux/ptrace.h                        | 30 +++++++++
 kernel/entry/syscall_user_dispatch.c               | 74 +++++++++++++++++++-=
--
 kernel/ptrace.c                                    |  9 +++
 tools/testing/selftests/ptrace/.gitignore          |  1 +
 tools/testing/selftests/ptrace/Makefile            |  2 +-
 tools/testing/selftests/ptrace/get_set_sud.c       | 72 +++++++++++++++++++++
 8 files changed, 200 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/ptrace/get_set_sud.c

diff --git a/Documentation/admin-guide/syscall-user-dispatch.rst b/Documentat=
ion/admin-guide/syscall-user-dispatch.rst
index 60314953c728..e3cfffef5a63 100644
--- a/Documentation/admin-guide/syscall-user-dispatch.rst
+++ b/Documentation/admin-guide/syscall-user-dispatch.rst
@@ -73,6 +73,10 @@ thread-wide, without the need to invoke the kernel directl=
y.  selector
 can be set to SYSCALL_DISPATCH_FILTER_ALLOW or SYSCALL_DISPATCH_FILTER_BLOCK.
 Any other value should terminate the program with a SIGSYS.
=20
+Additionally, a tasks syscall user dispatch configuration can be peeked
+and poked via the PTRACE_(GET|SET)_SYSCALL_USER_DISPATCH_CONFIG ptrace
+requests. This is useful for checkpoint/restart software.
+
 Security Notes
 --------------
=20
diff --git a/include/linux/syscall_user_dispatch.h b/include/linux/syscall_us=
er_dispatch.h
index a0ae443fb7df..641ca8880995 100644
--- a/include/linux/syscall_user_dispatch.h
+++ b/include/linux/syscall_user_dispatch.h
@@ -22,6 +22,12 @@ int set_syscall_user_dispatch(unsigned long mode, unsigned=
 long offset,
 #define clear_syscall_work_syscall_user_dispatch(tsk) \
 	clear_task_syscall_work(tsk, SYSCALL_USER_DISPATCH)
=20
+int syscall_user_dispatch_get_config(struct task_struct *task, unsigned long=
 size,
+				     void __user *data);
+
+int syscall_user_dispatch_set_config(struct task_struct *task, unsigned long=
 size,
+				     void __user *data);
+
 #else
 struct syscall_user_dispatch {};
=20
@@ -35,6 +41,18 @@ static inline void clear_syscall_work_syscall_user_dispatc=
h(struct task_struct *
 {
 }
=20
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
=20
 #endif /* _SYSCALL_USER_DISPATCH_H */
diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
index 195ae64a8c87..72c038fc71d0 100644
--- a/include/uapi/linux/ptrace.h
+++ b/include/uapi/linux/ptrace.h
@@ -112,6 +112,36 @@ struct ptrace_rseq_configuration {
 	__u32 pad;
 };
=20
+#define PTRACE_SET_SYSCALL_USER_DISPATCH_CONFIG 0x4210
+#define PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG 0x4211
+
+/*
+ * struct ptrace_sud_config - Per-task configuration for Syscall User Dispat=
ch
+ * @mode:	One of PR_SYS_DISPATCH_ON or PR_SYS_DISPATCH_OFF
+ * @selector:	Tracees user virtual address of SUD selector
+ * @offset:	SUD exclusion area (virtual address)
+ * @len:	Length of SUD exclusion area
+ *
+ * Used to get/set the syscall user dispatch configuration for a tracee.
+ * Selector is optional (may be NULL), and if invalid will produce
+ * a SIGSEGV in the tracee upon first access.
+ *
+ * If mode is PR_SYS_DISPATCH_ON, syscall dispatch will be enabled. If
+ * PR_SYS_DISPATCH_OFF, syscall dispatch will be disabled and all other
+ * parameters must be 0.  The value in *selector (if not null), also determi=
nes
+ * whether syscall dispatch will occur.
+ *
+ * The Syscall User Dispatch Exclusion area described by offset/len is the
+ * virtual address space from which syscalls will not produce a user
+ * dispatch.
+ */
+struct ptrace_sud_config {
+	__u64 mode;
+	__u64 selector;
+	__u64 offset;
+	__u64 len;
+};
+
 /*
  * These values are stored in task->ptrace_message
  * by ptrace_stop to describe the current syscall-stop.
diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user=
_dispatch.c
index 0b6379adff6b..5340c5aa89e7 100644
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
=20
-int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
-			      unsigned long len, char __user *selector)
+static int task_set_syscall_user_dispatch(struct task_struct *task, unsigned=
 long mode,
+					  unsigned long offset, unsigned long len,
+					  char __user *selector)
 {
 	switch (mode) {
 	case PR_SYS_DISPATCH_OFF:
@@ -86,7 +88,16 @@ int set_syscall_user_dispatch(unsigned long mode, unsigned=
 long offset,
 		if (offset && offset + len <=3D offset)
 			return -EINVAL;
=20
-		if (selector && !access_ok(selector, sizeof(*selector)))
+		/*
+		 * access_ok() will clear memory tags for tagged addresses
+		 * if current has memory tagging enabled.
+
+		 * To enable a tracer to set a tracees selector the
+		 * selector address must be untagged for access_ok(),
+		 * otherwise an untagged tracer will always fail to set a
+		 * tagged tracees selector.
+		 */
+		if (selector && !access_ok(untagged_addr(selector), sizeof(*selector)))
 			return -EFAULT;
=20
 		break;
@@ -94,15 +105,60 @@ int set_syscall_user_dispatch(unsigned long mode, unsign=
ed long offset,
 		return -EINVAL;
 	}
=20
-	current->syscall_dispatch.selector =3D selector;
-	current->syscall_dispatch.offset =3D offset;
-	current->syscall_dispatch.len =3D len;
-	current->syscall_dispatch.on_dispatch =3D false;
+	task->syscall_dispatch.selector =3D selector;
+	task->syscall_dispatch.offset =3D offset;
+	task->syscall_dispatch.len =3D len;
+	task->syscall_dispatch.on_dispatch =3D false;
=20
 	if (mode =3D=3D PR_SYS_DISPATCH_ON)
-		set_syscall_work(SYSCALL_USER_DISPATCH);
+		set_task_syscall_work(task, SYSCALL_USER_DISPATCH);
+	else
+		clear_task_syscall_work(task, SYSCALL_USER_DISPATCH);
+
+	return 0;
+}
+
+int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
+			      unsigned long len, char __user *selector)
+{
+	return task_set_syscall_user_dispatch(current, mode, offset, len, selector);
+}
+
+int syscall_user_dispatch_get_config(struct task_struct *task, unsigned long=
 size,
+				     void __user *data)
+{
+	struct syscall_user_dispatch *sd =3D &task->syscall_dispatch;
+	struct ptrace_sud_config cfg;
+
+	if (size !=3D sizeof(cfg))
+		return -EINVAL;
+
+	if (test_task_syscall_work(task, SYSCALL_USER_DISPATCH))
+		cfg.mode =3D PR_SYS_DISPATCH_ON;
 	else
-		clear_syscall_work(SYSCALL_USER_DISPATCH);
+		cfg.mode =3D PR_SYS_DISPATCH_OFF;
+
+	cfg.offset =3D sd->offset;
+	cfg.len =3D sd->len;
+	cfg.selector =3D (__u64)(uintptr_t)sd->selector;
+
+	if (copy_to_user(data, &cfg, sizeof(cfg)))
+		return -EFAULT;
=20
 	return 0;
 }
+
+int syscall_user_dispatch_set_config(struct task_struct *task, unsigned long=
 size,
+				     void __user *data)
+{
+	struct ptrace_sud_config cfg;
+
+	if (size !=3D sizeof(cfg))
+		return -EINVAL;
+
+	if (copy_from_user(&cfg, data, sizeof(cfg)))
+		return -EFAULT;
+
+	return task_set_syscall_user_dispatch(task, cfg.mode, cfg.offset, cfg.len,
+					      (char __user *)(uintptr_t)cfg.selector);
+}
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 0786450074c1..443057bee87c 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -32,6 +32,7 @@
 #include <linux/compat.h>
 #include <linux/sched/signal.h>
 #include <linux/minmax.h>
+#include <linux/syscall_user_dispatch.h>
=20
 #include <asm/syscall.h>	/* for syscall_get_* */
=20
@@ -1259,6 +1260,14 @@ int ptrace_request(struct task_struct *child, long req=
uest,
 		break;
 #endif
=20
+	case PTRACE_SET_SYSCALL_USER_DISPATCH_CONFIG:
+		ret =3D syscall_user_dispatch_set_config(child, addr, datavp);
+		break;
+
+	case PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG:
+		ret =3D syscall_user_dispatch_get_config(child, addr, datavp);
+		break;
+
 	default:
 		break;
 	}
diff --git a/tools/testing/selftests/ptrace/.gitignore b/tools/testing/selfte=
sts/ptrace/.gitignore
index 792318aaa30c..b7dde152e75a 100644
--- a/tools/testing/selftests/ptrace/.gitignore
+++ b/tools/testing/selftests/ptrace/.gitignore
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 get_syscall_info
+get_set_sud
 peeksiginfo
 vmaccess
diff --git a/tools/testing/selftests/ptrace/Makefile b/tools/testing/selftest=
s/ptrace/Makefile
index 96ffa94afb91..1c631740a730 100644
--- a/tools/testing/selftests/ptrace/Makefile
+++ b/tools/testing/selftests/ptrace/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS +=3D -std=3Dc99 -pthread -Wall $(KHDR_INCLUDES)
=20
-TEST_GEN_PROGS :=3D get_syscall_info peeksiginfo vmaccess
+TEST_GEN_PROGS :=3D get_syscall_info peeksiginfo vmaccess get_set_sud
=20
 include ../lib.mk
diff --git a/tools/testing/selftests/ptrace/get_set_sud.c b/tools/testing/sel=
ftests/ptrace/get_set_sud.c
new file mode 100644
index 000000000000..5297b10d25c3
--- /dev/null
+++ b/tools/testing/selftests/ptrace/get_set_sud.c
@@ -0,0 +1,72 @@
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
+	int ret =3D 0;
+	int status;
+
+	child =3D fork();
+	ASSERT_GE(child, 0);
+	if (child =3D=3D 0) {
+		ASSERT_EQ(0, sys_ptrace(PTRACE_TRACEME, 0, 0, 0)) {
+			TH_LOG("PTRACE_TRACEME: %m");
+		}
+		kill(getpid(), SIGSTOP);
+		_exit(1);
+	}
+
+	waitpid(child, &status, 0);
+
+	memset(&config, 0xff, sizeof(config));
+	config.mode =3D PR_SYS_DISPATCH_ON;
+
+	ret =3D sys_ptrace(PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG, child,
+			 (void *)sizeof(config), &config);
+
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(config.mode, PR_SYS_DISPATCH_OFF);
+	ASSERT_EQ(config.selector, 0);
+	ASSERT_EQ(config.offset, 0);
+	ASSERT_EQ(config.len, 0);
+
+	config.mode =3D PR_SYS_DISPATCH_ON;
+	config.selector =3D 0;
+	config.offset =3D 0x400000;
+	config.len =3D 0x1000;
+
+	ret =3D sys_ptrace(PTRACE_SET_SYSCALL_USER_DISPATCH_CONFIG, child,
+			 (void *)sizeof(config), &config);
+
+	ASSERT_EQ(ret, 0);
+
+	memset(&config, 1, sizeof(config));
+	ret =3D sys_ptrace(PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG, child,
+			 (void *)sizeof(config), &config);
+
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(config.mode, PR_SYS_DISPATCH_ON);
+	ASSERT_EQ(config.selector, 0);
+	ASSERT_EQ(config.offset, 0x400000);
+	ASSERT_EQ(config.len, 0x1000);
+
+	kill(child, SIGKILL);
+}
+
+TEST_HARNESS_MAIN

