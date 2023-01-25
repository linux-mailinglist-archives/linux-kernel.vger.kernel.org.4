Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DAE67A901
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 03:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbjAYCvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 21:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbjAYCvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 21:51:37 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C264030288;
        Tue, 24 Jan 2023 18:51:36 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id p12so8287174ilq.10;
        Tue, 24 Jan 2023 18:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24Kolj4JV2M8McXm4v+n0gLJPa8chzLkxYYS/Gp9uYA=;
        b=qiUQa29oCQ/fE3FNK/vPFR4Z9FNDSdmIwperpGyCa38eq/VZa0Rr2IVYj57pZu4EVN
         lsN9agJDKwhyZV597ptufaH5qNhPlXhqF4jOnU6VC6kwq+9O1S56QZ+fYU4Dsc59YzKg
         3iKJxDWS0pRvU0uEHnsYIEmmnVjAHJ0uSRLTsSCgZ7ZZP3EkQfS05a1wPn+s05/MCRYM
         gMoR03qYJcUZ1mhC8Pvgd28CyBfHdy9hgU34MUFiK5OdcdTZ3TUvlzWv7IKUrkWGe50f
         edh0ANw9sZB9KB+TvgXw1/2xrAm90umcF8ir/H50A9a2z/xzMJHBhJI1fmDookyNUtlG
         6eHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24Kolj4JV2M8McXm4v+n0gLJPa8chzLkxYYS/Gp9uYA=;
        b=GPcNilnM026IkZJAWVZxreDB5fpTfk4DsbHQ3w3U6AikpaiesiwSK0GsXyWN4BzCXV
         GrBsNWUdyqZdFG65yOYez1korbusHXdp/FLt3gW25nH0Wr2sXZIHqrX5TlW4YRMIMZNf
         a6ZC0omVctMQsSr8nDMkpsHuU9+C+cewTrSVXICvlOcoa0v2+y0UeZT4Jafv+4uvL5aZ
         oioLXsl+qPGWcKZ7OK0UHc3ZX7q3XD561bXIg5h7HrfQdJOfoHGbrrNEIVEejC8EBAXN
         x3Fc/1fTeRVC3Er7CkVx18yvPK0NXKNZdb3DQOSH2h34I2aVO7owOrwMGXL4WuZCWuPa
         4k8g==
X-Gm-Message-State: AFqh2kqtExfvrmrsmEVf6yLHU7tqZ9wXSh0ktaFa+eJGgCEBs667OTcp
        kZCvOVBqfCL047YLsm7HPDAkUcljFgli
X-Google-Smtp-Source: AMrXdXvp3tVSPZgAOl73+DM9I8Te+hxp1Ua7hWEL/hSVSDluM2WJaMz5V1od/doJf+p0gHrDnI8qug==
X-Received: by 2002:a05:6e02:1562:b0:30f:3736:25ab with SMTP id k2-20020a056e02156200b0030f373625abmr20523982ilu.28.1674615096348;
        Tue, 24 Jan 2023 18:51:36 -0800 (PST)
Received: from fedora.mshome.net ([104.184.156.161])
        by smtp.gmail.com with ESMTPSA id v5-20020a023845000000b0038a13e116a1sm1265722jae.61.2023.01.24.18.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 18:51:35 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, oleg@redhat.com, avagin@gmail.com,
        peterz@infradead.org, luto@kernel.org, krisman@collabora.com,
        tglx@linutronix.de, corbet@lwn.net, shuah@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v6 1/2] ptrace,syscall_user_dispatch: Implement Syscall User Dispatch Suspension
Date:   Tue, 24 Jan 2023 21:51:25 -0500
Message-Id: <20230125025126.787431-2-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230125025126.787431-1-gregory.price@memverge.com>
References: <20230125025126.787431-1-gregory.price@memverge.com>
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

Adds PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH to ptrace options, and
modify Syscall User Dispatch to suspend interception when enabled.

This is modeled after the SUSPEND_SECCOMP feature, which suspends
SECCOMP interposition.  Without doing this, software like CRIU will
inject system calls into a process and be intercepted by Syscall
User Dispatch, either causing a crash (due to blocked signals) or
the delivery of those signals to a ptracer (not the intended behavior).

Since Syscall User Dispatch is not a privileged feature, a check
for permissions is not required, however attempting to set this
option when CONFIG_CHECKPOINT_RESTORE it not supported should be
disallowed, as its intended use is checkpoint/resume.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
---
 include/linux/ptrace.h               | 2 ++
 include/uapi/linux/ptrace.h          | 6 +++++-
 kernel/entry/syscall_user_dispatch.c | 5 +++++
 kernel/ptrace.c                      | 4 ++++
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index eaaef3ffec22..461ae5c99d57 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -45,6 +45,8 @@ extern int ptrace_access_vm(struct task_struct *tsk, unsigned long addr,
 
 #define PT_EXITKILL		(PTRACE_O_EXITKILL << PT_OPT_FLAG_SHIFT)
 #define PT_SUSPEND_SECCOMP	(PTRACE_O_SUSPEND_SECCOMP << PT_OPT_FLAG_SHIFT)
+#define PT_SUSPEND_SYSCALL_USER_DISPATCH \
+	(PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH << PT_OPT_FLAG_SHIFT)
 
 extern long arch_ptrace(struct task_struct *child, long request,
 			unsigned long addr, unsigned long data);
diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
index 195ae64a8c87..ba9e3f19a22c 100644
--- a/include/uapi/linux/ptrace.h
+++ b/include/uapi/linux/ptrace.h
@@ -146,9 +146,13 @@ struct ptrace_rseq_configuration {
 /* eventless options */
 #define PTRACE_O_EXITKILL		(1 << 20)
 #define PTRACE_O_SUSPEND_SECCOMP	(1 << 21)
+#define PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH	(1 << 22)
 
 #define PTRACE_O_MASK		(\
-	0x000000ff | PTRACE_O_EXITKILL | PTRACE_O_SUSPEND_SECCOMP)
+	0x000000ff | \
+	PTRACE_O_EXITKILL | \
+	PTRACE_O_SUSPEND_SECCOMP | \
+	PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH)
 
 #include <asm/ptrace.h>
 
diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
index 0b6379adff6b..b5ec75164805 100644
--- a/kernel/entry/syscall_user_dispatch.c
+++ b/kernel/entry/syscall_user_dispatch.c
@@ -8,6 +8,7 @@
 #include <linux/uaccess.h>
 #include <linux/signal.h>
 #include <linux/elf.h>
+#include <linux/ptrace.h>
 
 #include <linux/sched/signal.h>
 #include <linux/sched/task_stack.h>
@@ -36,6 +37,10 @@ bool syscall_user_dispatch(struct pt_regs *regs)
 	struct syscall_user_dispatch *sd = &current->syscall_dispatch;
 	char state;
 
+	if (IS_ENABLED(CONFIG_CHECKPOINT_RESTORE) &&
+	    unlikely(current->ptrace & PT_SUSPEND_SYSCALL_USER_DISPATCH))
+		return false;
+
 	if (likely(instruction_pointer(regs) - sd->offset < sd->len))
 		return false;
 
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 54482193e1ed..a348b68d07a2 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -370,6 +370,10 @@ static int check_ptrace_options(unsigned long data)
 	if (data & ~(unsigned long)PTRACE_O_MASK)
 		return -EINVAL;
 
+	if (unlikely(data & PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH) &&
+	    (!IS_ENABLED(CONFIG_CHECKPOINT_RESTORE)))
+			return -EINVAL;
+
 	if (unlikely(data & PTRACE_O_SUSPEND_SECCOMP)) {
 		if (!IS_ENABLED(CONFIG_CHECKPOINT_RESTORE) ||
 		    !IS_ENABLED(CONFIG_SECCOMP))
-- 
2.39.0

