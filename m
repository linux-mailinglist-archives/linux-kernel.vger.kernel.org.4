Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9CC65DFA0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 23:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240453AbjADWKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 17:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239618AbjADWKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 17:10:01 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32B813F54;
        Wed,  4 Jan 2023 14:09:59 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id x11so28516108qtv.13;
        Wed, 04 Jan 2023 14:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ssk203t5op2Ko85GQkEOhmk/EZyaEm8HYyhrWRN0IZg=;
        b=D3aRi9CRLCtwJOUnpE5qMguJFni4UHBtZgBlqjqArAC8/kVQoUTOgWfTyTuO72W/w3
         NvTeNSABWi/HZW5D2GN5Mca22eNoQSi8ETNGMK8UFtNZ5C4ZpCKPit9wPXNsAYYnEiF8
         cKddnFN51Pn2/ReaV7AmeEjQvZcftdylpcmbhkCmvPxGLyrOZoG/BIcSO9GL/AR2V2aZ
         34rFESzun8NPuFt092Ljl2jy57kU97EfvHF2imDn2d/TnIO5194fpYwLIZEsOTndStpS
         NN6MgjLqij+QzEpqsjwE5wSNI5nRgFyl82cei0cYvXNjkmD4oIrlDMhXya/s0WRXSj4a
         6DtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ssk203t5op2Ko85GQkEOhmk/EZyaEm8HYyhrWRN0IZg=;
        b=d+lxRU7G7IhPjvKWv9uCoAYug/6N4YxXy0RIb9DCO1pdOD1M522j9rB7HI+2UwF5aA
         oEjYZAiVz4x+Y+wGyajf9lHTBIac/Ja0vy1oP6SqODEmCJ776dC3hIvRLz/n+wedeb9X
         l7l/NrASomSzAEe/NkTB6s0JSr1SqiuLPVEnEqy26XJ439WaW8kdDVUMM5G6bL0j27pb
         aKcVyvGuMqgYOtdIxLSEHtdqYRtXzZeyymt5sI91UmFvFuLdpoPYKsUdQ9JgVQKSYmUM
         v2uvxkTwmVSk91jIbMWWUHGSpP8DoK+JQFvwrD1JK72cywCFG5dVyv9JYsfFNqqzanXq
         LbJQ==
X-Gm-Message-State: AFqh2ko9WHUojzwyCOoNSZniky+WnCQRh52jSH3pI+xUTOEJ9r2gbuda
        eYYkC15DP/LbtYOAtfsK7uc4v8E+rg==
X-Google-Smtp-Source: AMrXdXvki4onsJf/WgFzOaFVj9UoXEWe1ZKkt8ae6FY6z+oKXL7LfxSk1HPydGynekseKygXUc5XqQ==
X-Received: by 2002:ac8:7457:0:b0:3a8:2122:7c28 with SMTP id h23-20020ac87457000000b003a821227c28mr72469064qtr.47.1672870198733;
        Wed, 04 Jan 2023 14:09:58 -0800 (PST)
Received: from fedora.mshome.net (119.sub-174-242-144.myvzw.com. [174.242.144.119])
        by smtp.gmail.com with ESMTPSA id 6-20020ac85646000000b003a6947863e1sm20431531qtt.11.2023.01.04.14.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 14:09:58 -0800 (PST)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-api@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [RFC PATCH v1] syscall_user_dispatch: ptrace SUSPEND feature for checkpoint/restore
Date:   Wed,  4 Jan 2023 17:09:51 -0500
Message-Id: <20230104220951.34435-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.37.3
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

This is modeled after the similar feature for SECCOMP, which suspends
SECCOMP interposition.  Without doing this, software like CRIU will
inject system calls into a process and be intercepted by Syscall
User Dispatch, either causing a crash (due to blocked signals) or
the delivery of those signals to a ptracer (not the intended behavior).

Since Syscall User Dispatch is not a privileged feature, a check
for permissions like SECCOMP does is not required, however attemping
to set this feature should not be possible when
CONFIG_CHECKPOINT_RESTORE it not supported.
---
 include/linux/ptrace.h               | 1 +
 include/uapi/linux/ptrace.h          | 3 ++-
 kernel/entry/syscall_user_dispatch.c | 4 ++++
 kernel/ptrace.c                      | 5 +++++
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index eaaef3ffec22..17ded8ed3795 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -45,6 +45,7 @@ extern int ptrace_access_vm(struct task_struct *tsk, unsigned long addr,
 
 #define PT_EXITKILL		(PTRACE_O_EXITKILL << PT_OPT_FLAG_SHIFT)
 #define PT_SUSPEND_SECCOMP	(PTRACE_O_SUSPEND_SECCOMP << PT_OPT_FLAG_SHIFT)
+#define PT_SUSPEND_SYSCALL_USER_DISPATCH	(PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH << PT_OPT_FLAG_SHIFT)
 
 extern long arch_ptrace(struct task_struct *child, long request,
 			unsigned long addr, unsigned long data);
diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
index 195ae64a8c87..be602a8d554f 100644
--- a/include/uapi/linux/ptrace.h
+++ b/include/uapi/linux/ptrace.h
@@ -146,9 +146,10 @@ struct ptrace_rseq_configuration {
 /* eventless options */
 #define PTRACE_O_EXITKILL		(1 << 20)
 #define PTRACE_O_SUSPEND_SECCOMP	(1 << 21)
+#define PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH	(1 << 22)
 
 #define PTRACE_O_MASK		(\
-	0x000000ff | PTRACE_O_EXITKILL | PTRACE_O_SUSPEND_SECCOMP)
+	0x000000ff | PTRACE_O_EXITKILL | PTRACE_O_SUSPEND_SECCOMP | PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH)
 
 #include <asm/ptrace.h>
 
diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
index 0b6379adff6b..6fad83e34da7 100644
--- a/kernel/entry/syscall_user_dispatch.c
+++ b/kernel/entry/syscall_user_dispatch.c
@@ -36,6 +36,10 @@ bool syscall_user_dispatch(struct pt_regs *regs)
 	struct syscall_user_dispatch *sd = &current->syscall_dispatch;
 	char state;
 
+	if (IS_ENABLED(CONFIG_CHECKPOINT_RESTORE) &&
+			unlikely(current->ptrace & PT_SUSPEND_SYSCALL_USER_DISPATCH))
+		return false;
+
 	if (likely(instruction_pointer(regs) - sd->offset < sd->len))
 		return false;
 
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 54482193e1ed..a6ad815bd4be 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -370,6 +370,11 @@ static int check_ptrace_options(unsigned long data)
 	if (data & ~(unsigned long)PTRACE_O_MASK)
 		return -EINVAL;
 
+	if (unlikely(data & PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH)) {
+		if (!IS_ENABLED(CONFIG_CHECKPOINT_RESTART))
+			return -EINVAL;
+	}
+
 	if (unlikely(data & PTRACE_O_SUSPEND_SECCOMP)) {
 		if (!IS_ENABLED(CONFIG_CHECKPOINT_RESTORE) ||
 		    !IS_ENABLED(CONFIG_SECCOMP))
-- 
2.37.3

