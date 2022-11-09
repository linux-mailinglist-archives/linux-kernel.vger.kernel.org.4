Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0076E622A94
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiKILaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiKILax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:30:53 -0500
Received: from outbound-smtp20.blacknight.com (outbound-smtp20.blacknight.com [46.22.139.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDC011C17
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:30:48 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp20.blacknight.com (Postfix) with ESMTPS id 8AB9C1C3A47
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 11:30:46 +0000 (GMT)
Received: (qmail 14175 invoked from network); 9 Nov 2022 11:30:46 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 9 Nov 2022 11:30:46 -0000
Date:   Wed, 9 Nov 2022 11:30:44 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>, Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-RT <linux-rt-users@vger.kernel.org>
Subject: [RFC PATCH] x86: Drop fpregs lock before inheriting FPU permissions
 during clone
Message-ID: <20221109113044.7ncdw6263o3msycl@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith reported the following off-list against an old fork of
preempt-rt but the same issue likely also applies to current preempt-rt

   BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
   in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1, name: systemd
   preempt_count: 1, expected: 0
   RCU nest depth: 0, expected: 0
   Preemption disabled at:
   fpu_clone+0xfa/0x480
   CPU: 6 PID: 1 Comm: systemd Tainted: G            E       (unreleased)
   Call Trace:
    <TASK>
    dump_stack_lvl+0x45/0x5b
    ? fpu_clone+0xfa/0x480
    __might_resched+0x165/0x200
    rt_spin_lock+0x2d/0x70
    fpu_clone+0x32a/0x480
    ? copy_thread+0xef/0x270
    ? copy_process+0xd2c/0x1c00
    ? shmem_alloc_inode+0x16/0x30
    ? kmem_cache_alloc+0x120/0x2a0
    ? kernel_clone+0x9b/0x460
    ? __do_sys_clone+0x72/0xa0
    ? do_syscall_64+0x58/0x80
    ? __x64_sys_rt_sigprocmask+0x93/0xd0
    ? syscall_exit_to_user_mode+0x18/0x40
    ? do_syscall_64+0x67/0x80
    ? syscall_exit_to_user_mode+0x18/0x40
    ? do_syscall_64+0x67/0x80
    ? syscall_exit_to_user_mode+0x18/0x40
    ? do_syscall_64+0x67/0x80
    ? exc_page_fault+0x6a/0x190
    ? entry_SYSCALL_64_after_hwframe+0x61/0xcb
    </TASK>

  The splat comes from fpu_inherit_perms() being called under fpregs_lock(),
  and us reaching the spin_lock_irq() therein due to fpu_state_size_dynamic()
  returning true despite static key __fpu_state_size_dynamic having never
  been enabled.

Mike's assessment looks correct. fpregs_lock on PREEMPT_RT disables
preemption only so the spin_lock_irq() in fpu_inherit_perms is unsafe
and converting siglock to raw spinlock would be an unwelcome change.
This problem exists since commit 9e798e9aa14c ("x86/fpu: Prepare fpu_clone()
for dynamically enabled features"). While the bug triggering is probably a
mistake for the affected machine and due to a bug that is not in mainline,
spin_lock_irq within a preempt_disable section on PREEMPT_RT is problematic.

In this specific context, it may not be necessary to hold fpregs_lock at
all. The lock is necessary when editing the FPU registers or a tasks fpstate
but in this case, the only write of any FP state in fpu_inherit_perms is
for the new child which is not running yet so it cannot context switch or
be borrowed by a kernel thread yet. Hence, fpregs_lock is not protecting
anything in the new child until clone() completes. The siglock still needs
to be acquired by fpu_inherit_perms as the read of the parents permissions
has to be serialised.

This is not tested as I did not access to a machine with Intel's
eXtended Feature Disable (XFD) feature that enables the relevant path
in fpu_inherit_perms and the bug is against a non-mainline kernel.

Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 arch/x86/kernel/fpu/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 3b28c5b25e12..d00db56a8868 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -605,9 +605,9 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags, bool minimal)
 	if (test_thread_flag(TIF_NEED_FPU_LOAD))
 		fpregs_restore_userregs();
 	save_fpregs_to_fpstate(dst_fpu);
+	fpregs_unlock();
 	if (!(clone_flags & CLONE_THREAD))
 		fpu_inherit_perms(dst_fpu);
-	fpregs_unlock();
 
 	/*
 	 * Children never inherit PASID state.
