Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9124F6A75B3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 21:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjCAU7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 15:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjCAU67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 15:58:59 -0500
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AB3521D8;
        Wed,  1 Mar 2023 12:58:57 -0800 (PST)
Received: by mail-oo1-xc43.google.com with SMTP id p8-20020a4a3c48000000b0052527a9d5f0so2326526oof.1;
        Wed, 01 Mar 2023 12:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677704336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPF5EyQxtwmVIBBsMsBw6MBdmljqzOk6IpS0dWxTsQE=;
        b=UFaBFkZdJl3MlZF8Rp9CvpxWxWoUksQCckAz3ImzlufLPBGa98Vcs1lla5DVb5euSS
         ZnVw7rsrPPEncy1f+1Lxe6hphYUDoZT9r3iwUDw+bzuYIJvs0d2Miu7HN+HkpXVFmgpM
         y5Gj+Ivah4MMrHMn5ZjU4sshJ4EIwF2JB0UybzokonKGteWXrN0L766X0bqdvMQCt59G
         rMFW4sykAicqUlydoLaIglZZuSGMIbu13LBxocFyeFE/QDW42PdR7fPqlIf/KSvvH7px
         JyAajnIgKuQQQFVvU4GH3FIJeXIX5qnb01e2OdONantR0mDZDVi3J4qMDt4EscgtU4AJ
         +c/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677704336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SPF5EyQxtwmVIBBsMsBw6MBdmljqzOk6IpS0dWxTsQE=;
        b=IdIlmXAZqz2z9/TMiTv3/xIy9QpGSWvQJ4PQnU8Nru0clhtDd5R1NkNMz7da/wUPs+
         YQGC6nNpjVCwKjKSf8OdvGO/UDPm5nRLdzjsDd+NL514xbjLoXtIhWMMF+VhvpZ4dfSf
         PVwnY/AZ0zFxj33mliLIcM/u/lEoSm2oVlBA6OV6vbSxsz/KUJvLnxdupcdwBQJGrL6c
         n702Otf16WtalAHnDwmyDhv1QoeYGU8ijMs9LvIn3bgO3Xhxlh7O45CYBc/Q+l0fFyGR
         Y8GxuiFnqFbZIcyb5vJlunkAPa7o8lDmId/HCOkau/8DuyiJBld/OFtrbnXOAHHmywXe
         DVXw==
X-Gm-Message-State: AO0yUKUT0yl3dVMul9tHCw2z4Qh73Gg7Uyt6FMJ5XzqAkb9iJ/pxZIf4
        +cRCg7BPDJE8nRxQI+OiDtRrzt7U2rYC
X-Google-Smtp-Source: AK7set9xSAiQjezMMnQ6Rv/+IXkuMuFTZz5ZfIyQcQHe+CoZBLMDW6AkpSXiEhn0U4Twk0gyOQ9X2Q==
X-Received: by 2002:a4a:e54c:0:b0:525:d9c:b1bb with SMTP id s12-20020a4ae54c000000b005250d9cb1bbmr3091583oot.2.1677704336375;
        Wed, 01 Mar 2023 12:58:56 -0800 (PST)
Received: from fedora.mshome.net ([104.184.156.161])
        by smtp.gmail.com with ESMTPSA id bt55-20020a05683039f700b0068abc8e786fsm5273899otb.10.2023.03.01.12.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 12:58:55 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, oleg@redhat.com, avagin@gmail.com,
        peterz@infradead.org, luto@kernel.org, krisman@collabora.com,
        tglx@linutronix.de, corbet@lwn.net, shuah@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v13 2/3] ptrace,syscall_user_dispatch: checkpoint/restore support for SUD
Date:   Wed,  1 Mar 2023 15:58:42 -0500
Message-Id: <20230301205843.2164-3-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230301205843.2164-1-gregory.price@memverge.com>
References: <20230301205843.2164-1-gregory.price@memverge.com>
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
 .../admin-guide/syscall-user-dispatch.rst     |  4 ++
 include/linux/syscall_user_dispatch.h         | 18 ++++++++
 include/uapi/linux/ptrace.h                   | 29 +++++++++++++
 kernel/entry/syscall_user_dispatch.c          | 42 +++++++++++++++++++
 kernel/ptrace.c                               |  9 ++++
 5 files changed, 102 insertions(+)

diff --git a/Documentation/admin-guide/syscall-user-dispatch.rst b/Documentation/admin-guide/syscall-user-dispatch.rst
index 60314953c728..f7648c08297e 100644
--- a/Documentation/admin-guide/syscall-user-dispatch.rst
+++ b/Documentation/admin-guide/syscall-user-dispatch.rst
@@ -73,6 +73,10 @@ thread-wide, without the need to invoke the kernel directly.  selector
 can be set to SYSCALL_DISPATCH_FILTER_ALLOW or SYSCALL_DISPATCH_FILTER_BLOCK.
 Any other value should terminate the program with a SIGSYS.
 
+Additionally, a task's syscall user dispatch configuration can be peeked
+and poked via the PTRACE_(GET|SET)_SYSCALL_USER_DISPATCH_CONFIG ptrace
+requests. This is useful for checkpoint/restart software.
+
 Security Notes
 --------------
 
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
index 195ae64a8c87..1e77b02344c3 100644
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
+	__u64 selector;
+	__u64 offset;
+	__u64 len;
+};
+
 /*
  * These values are stored in task->ptrace_message
  * by ptrace_stop to describe the current syscall-stop.
diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
index 22396b234854..5191d2eac168 100644
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
@@ -113,3 +114,44 @@ int set_syscall_user_dispatch(unsigned long mode, unsigned long offset,
 {
 	return task_set_syscall_user_dispatch(current, mode, offset, len, selector);
 }
+
+int syscall_user_dispatch_get_config(struct task_struct *task, unsigned long size,
+				     void __user *data)
+{
+	struct syscall_user_dispatch *sd = &task->syscall_dispatch;
+	struct ptrace_sud_config cfg;
+
+	if (size != sizeof(cfg))
+		return -EINVAL;
+
+	if (test_task_syscall_work(task, SYSCALL_USER_DISPATCH))
+		cfg.mode = PR_SYS_DISPATCH_ON;
+	else
+		cfg.mode = PR_SYS_DISPATCH_OFF;
+
+	cfg.offset = sd->offset;
+	cfg.len = sd->len;
+	cfg.selector = (__u64)(uintptr_t)sd->selector;
+
+	if (copy_to_user(data, &cfg, sizeof(cfg)))
+		return -EFAULT;
+
+	return 0;
+}
+
+int syscall_user_dispatch_set_config(struct task_struct *task, unsigned long size,
+				     void __user *data)
+{
+	int rc;
+	struct ptrace_sud_config cfg;
+
+	if (size != sizeof(cfg))
+		return -EINVAL;
+
+	if (copy_from_user(&cfg, data, sizeof(cfg)))
+		return -EFAULT;
+
+	rc = task_set_syscall_user_dispatch(task, cfg.mode, cfg.offset, cfg.len,
+					    (char __user *)(uintptr_t)cfg.selector);
+	return rc;
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
-- 
2.39.1

