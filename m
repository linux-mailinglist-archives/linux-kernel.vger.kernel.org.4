Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217A26C51D3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjCVRFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbjCVREd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:04:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E2A4608F;
        Wed, 22 Mar 2023 10:03:51 -0700 (PDT)
Date:   Wed, 22 Mar 2023 17:03:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679504587;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=etTSmXrHU8UUxgpLu3aX2UgX8Rd8wKMSZtrj1BlNtjk=;
        b=AnBE/dxdjfvn5Ipt7/lLx1wNxiI8aQ3I2hJMx1gMpPpsOC8CnbcF/TRZnn1hpjmXSexZhh
        g6unvEUyiP/DTaE3yltQfFzBN5EcYhMyHxprG903swPfJQAWiAs+j1pcRwANzF1qA6Cic0
        IFRE4ll/5Dz52z2H9UPPEXWFerdNKzQ2Oola/XU8ceLVQa5Pq/sKRGmiyv7T+VEKP3rHwF
        EKYaYuojLAg1DeuY+VmOc69JaCxZ1tNqFNwKOqJEBKpj/JYg8ll866XdAJrTlIBR6Z8MZ+
        3ddHxJtNb+er8yGtlwyChpJDqas/TXGNXMkhzTAcIdGa8OvMbcd7XSv6i3gC7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679504587;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=etTSmXrHU8UUxgpLu3aX2UgX8Rd8wKMSZtrj1BlNtjk=;
        b=ODmQMVd9Jfb4x1+0pIddx4r0EvinxRajnTH77wdeDtoOaZb6RhC7mMFf/RvI7YIRbBag5P
        dkjMggJ62IwbCyAQ==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] mm: Expose untagging mask in /proc/$PID/status
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexander Potapenko <glider@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167950458685.5837.10434749489202545544.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     f7d304343b9d2456ffba23b99d2345408251ea45
Gitweb:        https://git.kernel.org/tip/f7d304343b9d2456ffba23b99d2345408251ea45
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Sun, 12 Mar 2023 14:26:04 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 16 Mar 2023 13:08:40 -07:00

mm: Expose untagging mask in /proc/$PID/status

Add a line in /proc/$PID/status to report untag_mask. It can be
used to find out LAM status of the process from the outside. It is
useful for debuggers.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Alexander Potapenko <glider@google.com>
Link: https://lore.kernel.org/all/20230312112612.31869-10-kirill.shutemov%40linux.intel.com
---
 arch/arm64/include/asm/mmu_context.h    | 6 ++++++
 arch/sparc/include/asm/mmu_context_64.h | 6 ++++++
 arch/x86/include/asm/mmu_context.h      | 6 ++++++
 fs/proc/array.c                         | 7 +++++++
 include/linux/mmu_context.h             | 7 +++++++
 5 files changed, 32 insertions(+)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 72dbd64..5691169 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -288,6 +288,12 @@ void post_ttbr_update_workaround(void);
 unsigned long arm64_mm_context_get(struct mm_struct *mm);
 void arm64_mm_context_put(struct mm_struct *mm);
 
+#define mm_untag_mask mm_untag_mask
+static inline unsigned long mm_untag_mask(struct mm_struct *mm)
+{
+	return -1UL >> 8;
+}
+
 #include <asm-generic/mmu_context.h>
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/sparc/include/asm/mmu_context_64.h b/arch/sparc/include/asm/mmu_context_64.h
index 7a8380c..799e797 100644
--- a/arch/sparc/include/asm/mmu_context_64.h
+++ b/arch/sparc/include/asm/mmu_context_64.h
@@ -185,6 +185,12 @@ static inline void finish_arch_post_lock_switch(void)
 	}
 }
 
+#define mm_untag_mask mm_untag_mask
+static inline unsigned long mm_untag_mask(struct mm_struct *mm)
+{
+       return -1UL >> adi_nbits();
+}
+
 #include <asm-generic/mmu_context.h>
 
 #endif /* !(__ASSEMBLY__) */
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index eb1387a..06eaaf7 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -104,6 +104,12 @@ static inline void dup_lam(struct mm_struct *oldmm, struct mm_struct *mm)
 	mm->context.untag_mask = oldmm->context.untag_mask;
 }
 
+#define mm_untag_mask mm_untag_mask
+static inline unsigned long mm_untag_mask(struct mm_struct *mm)
+{
+	return mm->context.untag_mask;
+}
+
 static inline void mm_reset_untag_mask(struct mm_struct *mm)
 {
 	mm->context.untag_mask = -1UL;
diff --git a/fs/proc/array.c b/fs/proc/array.c
index 9b0315d..6daea62 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -91,6 +91,7 @@
 #include <linux/user_namespace.h>
 #include <linux/fs_struct.h>
 #include <linux/kthread.h>
+#include <linux/mmu_context.h>
 
 #include <asm/processor.h>
 #include "internal.h"
@@ -423,6 +424,11 @@ static inline void task_thp_status(struct seq_file *m, struct mm_struct *mm)
 	seq_printf(m, "THP_enabled:\t%d\n", thp_enabled);
 }
 
+static inline void task_untag_mask(struct seq_file *m, struct mm_struct *mm)
+{
+	seq_printf(m, "untag_mask:\t%#lx\n", mm_untag_mask(mm));
+}
+
 int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
 			struct pid *pid, struct task_struct *task)
 {
@@ -438,6 +444,7 @@ int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
 		task_mem(m, mm);
 		task_core_dumping(m, task);
 		task_thp_status(m, mm);
+		task_untag_mask(m, mm);
 		mmput(mm);
 	}
 	task_sig(m, task);
diff --git a/include/linux/mmu_context.h b/include/linux/mmu_context.h
index b9b970f..14b9c1f 100644
--- a/include/linux/mmu_context.h
+++ b/include/linux/mmu_context.h
@@ -28,4 +28,11 @@ static inline void leave_mm(int cpu) { }
 # define task_cpu_possible(cpu, p)	cpumask_test_cpu((cpu), task_cpu_possible_mask(p))
 #endif
 
+#ifndef mm_untag_mask
+static inline unsigned long mm_untag_mask(struct mm_struct *mm)
+{
+	return -1UL;
+}
+#endif
+
 #endif
