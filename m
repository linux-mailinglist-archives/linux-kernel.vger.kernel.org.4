Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E944693D9F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 05:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjBMEz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 23:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjBMEy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 23:54:57 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43C011EB7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 20:54:31 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id z14-20020a17090abd8e00b00233bb9d6bdcso5816763pjr.4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 20:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NyKgXXAf6eIxCQNqJDUpc+Bj2CrwyhmFgAHD2REeyJQ=;
        b=EXvhS/VncGgKvwJ3Q0vZAYHmSdbk7Ij5M1B09iI7kQPmHIhtYw0rjfb6raSugnp38T
         RmNzvD40b33QG81EShtF2MT2OnlPOZTgPjpHaiOK24MRNbT55VmbG0wr5uOlczteExqe
         7RyzXdUw1jdcb3u3wJdELeWUM43o7pNbFJcVOiNL1mEjeC1ZstyzXdFxHLminnErv+6t
         5Gh0QI8ML2GvM2ZfYK5uGt1BPhOYeh2whz4oZIvrTreSdNvkkyj2I+Y//kj6Jiov3w3K
         Jk+yFBa6l72SXXXD2fakph5Hh2wqGj5Gb42T4I9/9BIeNQHqONbq+9UgRdavksLsUOeW
         yE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NyKgXXAf6eIxCQNqJDUpc+Bj2CrwyhmFgAHD2REeyJQ=;
        b=u5RBVk+O3uEP46srEjbex8CjqmM7jPWqKJ3cffkv/Rpl5i7yOVwunUdyRh1kCea9M0
         EOVeIpv+0+9VittvdnPKmpsFS8bXl3MsceH9M66MTmB9mM22PpM1jqyy1Q2LjXJEl5pS
         Yirg8hgmcnDsQD2+G/YV01ZnctfOV+AWbnbqeh86ucU/jV/l33dJ3GeLwyFVBdpANKlI
         RnUwmQIwlkNHohnV8G2pXKNAQjGAQf9ROWaOfVAD3+CnAMbXC0zIRi9vRa2UdQ6TtQ61
         R/KObbuRNYMHSmfgVQvqLm1ZLcPAVczUlqKJ65jpzdtLUpsQfRt8bUgeolXdIjqWLPn5
         seYg==
X-Gm-Message-State: AO0yUKU7PXCUQdVzl5x0qFIbbFqJ1J5R0yhpJlYTHB6lVfjAB8kmYmxR
        m67/tEsdRV5CgWJ0S3dk0S3/1xUQqh9u8vII
X-Google-Smtp-Source: AK7set+NkvkqLLx1ODFEJuYixtO6pgsq1Kd5F2Cn+dnuIzgerTzZYBASHAeY5bJ7M/OE6P4BYW1Gjw==
X-Received: by 2002:a17:903:1c2:b0:199:1d6f:3cab with SMTP id e2-20020a17090301c200b001991d6f3cabmr28540571plh.21.1676264064208;
        Sun, 12 Feb 2023 20:54:24 -0800 (PST)
Received: from debug.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902784500b00189e7cb8b89sm7078303pln.127.2023.02.12.20.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 20:54:23 -0800 (PST)
From:   Deepak Gupta <debug@rivosinc.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v1 RFC Zisslpcfi 15/20] sslp prctl: arch-agnostic prctl for shadow stack and landing pad instr
Date:   Sun, 12 Feb 2023 20:53:44 -0800
Message-Id: <20230213045351.3945824-16-debug@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230213045351.3945824-1-debug@rivosinc.com>
References: <20230213045351.3945824-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Three architectures (x86, aarch64, riscv) have announced support for
shadow stack and enforcing requirement of landing pad instructions on
indirect call/jmp. This patch adds arch-agnostic prtcl support to enable
/disable/get/set status of shadow stack and forward control (landing pad)
flow cfi statuses.

New prctls are
      - PR_GET_SHADOW_STACK_STATUS, PR_SET_SHADOW_STACK_STATUS
      - PR_GET_INDIRECT_BR_LP_STATUS, PR_SET_INDIRECT_BR_LP_STATUS

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 include/uapi/linux/prctl.h | 26 +++++++++++++++++++++++++
 kernel/sys.c               | 40 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index a5e06dcbba13..0f401cb2d6d1 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -284,4 +284,30 @@ struct prctl_mm_map {
 #define PR_SET_VMA		0x53564d41
 # define PR_SET_VMA_ANON_NAME		0
 
+/*
+ * get shadow stack status for current thread. Assumes shadow stack is min 4 byte aligned.
+ * Note shadow stack can be 8 byte aligned on 64bit.
+ * Lower 2 bits can give status of locked and enabled/disabled.
+ * size and address range can be obtained via /proc/maps. get_shadow_stack_status will
+ * return base of shadow stack.
+ */
+#define PR_GET_SHADOW_STACK_STATUS      65
+/*
+ * set shadow stack status for current thread (including enabling, disabling or locking)
+ * note that it will only set the status and setup of the shadow stack. Allocating shadow
+ * stack should be done separately using mmap.
+ */
+#define PR_SET_SHADOW_STACK_STATUS      66
+# define PR_SHADOW_STACK_LOCK           (1UL << 0)
+# define PR_SHADOW_STACK_ENABLE         (1UL << 1)
+
+/* get status of requirement of a landing pad instruction for current thread */
+#define PR_GET_INDIRECT_BR_LP_STATUS    67
+/*
+ * set status of requirement of a landing pad instruction for current thread
+ * (including enabling, disabling or locking)
+ */
+#define PR_SET_INDIRECT_BR_LP_STATUS    68
+# define PR_INDIRECT_BR_LP_LOCK         (1UL << 0)
+# define PR_INDIRECT_BR_LP_ENABLE       (1UL << 1)
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index 88b31f096fb2..da8c65d474df 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2284,6 +2284,26 @@ int __weak arch_prctl_spec_ctrl_set(struct task_struct *t, unsigned long which,
 	return -EINVAL;
 }
 
+int __weak arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *status)
+{
+	return -EINVAL;
+}
+
+int __weak arch_set_shadow_stack_status(struct task_struct *t, unsigned long __user *status)
+{
+	return -EINVAL;
+}
+
+int __weak arch_get_indir_br_lp_status(struct task_struct *t, unsigned long __user *status)
+{
+	return -EINVAL;
+}
+
+int __weak arch_set_indir_br_lp_status(struct task_struct *t, unsigned long __user *status)
+{
+	return -EINVAL;
+}
+
 #define PR_IO_FLUSHER (PF_MEMALLOC_NOIO | PF_LOCAL_THROTTLE)
 
 #ifdef CONFIG_ANON_VMA_NAME
@@ -2628,6 +2648,26 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case PR_SET_VMA:
 		error = prctl_set_vma(arg2, arg3, arg4, arg5);
 		break;
+	case PR_GET_SHADOW_STACK_STATUS:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = arch_get_shadow_stack_status(me, (unsigned long __user *) arg2);
+		break;
+	case PR_SET_SHADOW_STACK_STATUS:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = arch_set_shadow_stack_status(me, (unsigned long __user *) arg2);
+		break;
+	case PR_GET_INDIRECT_BR_LP_STATUS:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = arch_get_indir_br_lp_status(me, (unsigned long __user *) arg2);
+		break;
+	case PR_SET_INDIRECT_BR_LP_STATUS:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = arch_set_indir_br_lp_status(me, (unsigned long __user *) arg2);
+		break;
 	default:
 		error = -EINVAL;
 		break;
-- 
2.25.1

