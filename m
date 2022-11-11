Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F616264A1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 23:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbiKKWbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 17:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbiKKWbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 17:31:16 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4025E4E407
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 14:31:15 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id u7so4173419qvn.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 14:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g5QtNrTk+w8/73Vy3fSGZT5rE522rZx+3vx3VVx77Pw=;
        b=4/1sXfbrZ8FjHb/XCuRiNI4Tkmqrjfe61YsZMRjH5IMEIR4XPXrqrQZCljGun93XkI
         wAbpPWhO3iXyIaOywwixREQ2Ti9wf+MQe7VAxc9u3efD85AxuylWd57xuYo/xgwHB91K
         elvPRmZIbBPJe11kpiyk/OwWAjCBBkwEH3wG+1r3W2izHmOwcIFhf++GejjBSRyBpiMu
         FW0nmDuKbvv4+aEzSZtAR3ueo7qW7dcroe7ha6EzeRBT6KKN5yWlpGv8o+pORPLE3wKo
         y/MtESZ/Yo5LKl+kN4hu3s+1QgKFXAR4nPTwUxXuIw9yTX7J/4jDH60Ehzha1bcbQ0nX
         ngSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g5QtNrTk+w8/73Vy3fSGZT5rE522rZx+3vx3VVx77Pw=;
        b=A0oAJ0XJwjukKke+KPErgq2eVVasldrRFu2NzaIvJK1X7MnwDrLRynECbmeseeicL8
         dZzRw5CovUvkoE/JAgMt1jaHjRnGMpgr/7TuuW/lUTU/eJlDtRmg7pcgeCk2U0HOa6Tx
         MiYtfHesRUPnonWrdWtHKGa2t9YTUG2BZB9PCtHSTYLoWhurlo9HbBGLXVf3UixFTwg0
         EvF0I8d5fvOSVoCYzP9Lwz7ka/k+Blrmpw0jEZddI5gciAMbkPSFA+iHdSN0nu4UYvAC
         YeXJ8MIz1cQSLa+oEbs6ACZkXW8CC6lYXUBXjVOD7ZaNpGjn+cZlmeHx38yidT4zjw4Y
         HvbA==
X-Gm-Message-State: ANoB5pk+lKYmxK/dHhWIqx7BRqlKRQutU2PrOBsXqvQtvIPwAOP14gkJ
        Zl/GU+788NbUCa5RA7ERWISDAzN4hprXRA==
X-Google-Smtp-Source: AA0mqf5NktUO7qEAJTx0O1rFTkLU5Jp2OahXZ/Qb67noQ5Q83wTWsjjhUvzSyoFNotCpUIHl4SS/pA==
X-Received: by 2002:a05:6214:883:b0:4b9:6eb4:ba10 with SMTP id cz3-20020a056214088300b004b96eb4ba10mr3938072qvb.75.1668205874321;
        Fri, 11 Nov 2022 14:31:14 -0800 (PST)
Received: from abrestic-xps.ba.rivosinc.com (pool-72-80-155-134.nycmny.fios.verizon.net. [72.80.155.134])
        by smtp.gmail.com with ESMTPSA id c18-20020ac85192000000b0039c7b9522ecsm1907290qtn.35.2022.11.11.14.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 14:31:13 -0800 (PST)
From:   Andrew Bresticker <abrestic@rivosinc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atishp@rivosinc.com>, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Bresticker <abrestic@rivosinc.com>
Subject: [PATCH] RISC-V: Fix unannoted hardirqs-on in return to userspace slow-path
Date:   Fri, 11 Nov 2022 17:31:08 -0500
Message-Id: <20221111223108.1976562-1-abrestic@rivosinc.com>
X-Mailer: git-send-email 2.25.1
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

The return to userspace path in entry.S may enable interrupts without the
corresponding lockdep annotation, producing a splat[0] when DEBUG_LOCKDEP
is enabled. Simply calling __trace_hardirqs_on() here gets a bit messy
due to the use of RA to point back to ret_from_exception, so just move
the whole slow-path loop into C. It's more readable and it lets us use
local_irq_{enable,disable}(), avoiding the need for manual annotations
altogether.

[0]:
  ------------[ cut here ]------------
  DEBUG_LOCKS_WARN_ON(!lockdep_hardirqs_enabled())
  WARNING: CPU: 2 PID: 1 at kernel/locking/lockdep.c:5512 check_flags+0x10a/0x1e0
  Modules linked in:
  CPU: 2 PID: 1 Comm: init Not tainted 6.1.0-rc4-00160-gb56b6e2b4f31 #53
  Hardware name: riscv-virtio,qemu (DT)
  epc : check_flags+0x10a/0x1e0
  ra : check_flags+0x10a/0x1e0
  <snip>
   status: 0000000200000100 badaddr: 0000000000000000 cause: 0000000000000003
  [<ffffffff808edb90>] lock_is_held_type+0x78/0x14e
  [<ffffffff8003dae2>] __might_resched+0x26/0x22c
  [<ffffffff8003dd24>] __might_sleep+0x3c/0x66
  [<ffffffff80022c60>] get_signal+0x9e/0xa70
  [<ffffffff800054a2>] do_notify_resume+0x6e/0x422
  [<ffffffff80003c68>] ret_from_exception+0x0/0x10
  irq event stamp: 44512
  hardirqs last  enabled at (44511): [<ffffffff808f901c>] _raw_spin_unlock_irqrestore+0x54/0x62
  hardirqs last disabled at (44512): [<ffffffff80008200>] __trace_hardirqs_off+0xc/0x14
  softirqs last  enabled at (44472): [<ffffffff808f9fbe>] __do_softirq+0x3de/0x51e
  softirqs last disabled at (44467): [<ffffffff80017760>] irq_exit+0xd6/0x104
  ---[ end trace 0000000000000000 ]---
  possible reason: unannotated irqs-on.

Signed-off-by: Andrew Bresticker <abrestic@rivosinc.com>
---
This should also theoretically be fixed by the conversion to generic entry,
but it's not clear how far away that series is from landing.
---
 arch/riscv/kernel/entry.S  | 18 +++++-------------
 arch/riscv/kernel/signal.c | 34 +++++++++++++++++++++-------------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index b9eda3fcbd6d..58dfa8595e19 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -263,12 +263,11 @@ ret_from_exception:
 #endif
 	bnez s0, resume_kernel
 
-resume_userspace:
 	/* Interrupts must be disabled here so flags are checked atomically */
 	REG_L s0, TASK_TI_FLAGS(tp) /* current_thread_info->flags */
 	andi s1, s0, _TIF_WORK_MASK
-	bnez s1, work_pending
-
+	bnez s1, resume_userspace_slow
+resume_userspace:
 #ifdef CONFIG_CONTEXT_TRACKING_USER
 	call user_enter_callable
 #endif
@@ -368,19 +367,12 @@ resume_kernel:
 	j restore_all
 #endif
 
-work_pending:
+resume_userspace_slow:
 	/* Enter slow path for supplementary processing */
-	la ra, ret_from_exception
-	andi s1, s0, _TIF_NEED_RESCHED
-	bnez s1, work_resched
-work_notifysig:
-	/* Handle pending signals and notify-resume requests */
-	csrs CSR_STATUS, SR_IE /* Enable interrupts for do_notify_resume() */
 	move a0, sp /* pt_regs */
 	move a1, s0 /* current_thread_info->flags */
-	tail do_notify_resume
-work_resched:
-	tail schedule
+	call do_work_pending
+	j resume_userspace
 
 /* Slow paths for ptrace. */
 handle_syscall_trace_enter:
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index 5c591123c440..bfb2afa4135f 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -313,19 +313,27 @@ static void do_signal(struct pt_regs *regs)
 }
 
 /*
- * notification of userspace execution resumption
- * - triggered by the _TIF_WORK_MASK flags
+ * Handle any pending work on the resume-to-userspace path, as indicated by
+ * _TIF_WORK_MASK. Entered from assembly with IRQs off.
  */
-asmlinkage __visible void do_notify_resume(struct pt_regs *regs,
-					   unsigned long thread_info_flags)
+asmlinkage __visible void do_work_pending(struct pt_regs *regs,
+					  unsigned long thread_info_flags)
 {
-	if (thread_info_flags & _TIF_UPROBE)
-		uprobe_notify_resume(regs);
-
-	/* Handle pending signal delivery */
-	if (thread_info_flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
-		do_signal(regs);
-
-	if (thread_info_flags & _TIF_NOTIFY_RESUME)
-		resume_user_mode_work(regs);
+	do {
+		if (thread_info_flags & _TIF_NEED_RESCHED) {
+			schedule();
+		} else {
+			local_irq_enable();
+			if (thread_info_flags & _TIF_UPROBE)
+				uprobe_notify_resume(regs);
+			/* Handle pending signal delivery */
+			if (thread_info_flags & (_TIF_SIGPENDING |
+						 _TIF_NOTIFY_SIGNAL))
+				do_signal(regs);
+			if (thread_info_flags & _TIF_NOTIFY_RESUME)
+				resume_user_mode_work(regs);
+		}
+		local_irq_disable();
+		thread_info_flags = read_thread_flags();
+	} while (thread_info_flags & _TIF_WORK_MASK);
 }
-- 
2.25.1

