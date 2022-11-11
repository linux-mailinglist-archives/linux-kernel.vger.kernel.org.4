Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CC2626409
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 22:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbiKKV6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 16:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbiKKV6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 16:58:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE91CC761;
        Fri, 11 Nov 2022 13:58:28 -0800 (PST)
Date:   Fri, 11 Nov 2022 21:58:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668203907;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=wJ4VmNv5odo4IUQ0hbkPconHUXSlDNr+RScHZTFV53U=;
        b=M0wGgN6uuieIbR6A43/NR4RxcfSpKDM05g3ABWPXkhr92g94OgzyqJ2GD6Eyl6I7AZYvD8
        g8vlfpx6XdC71x3ofuiIHcIZHadfIVuDeMLYWUDzP6F9Ckph/IzcfT8Z443iLA3jXUImwy
        H4TUkXNY4zTs6x98PjkE5UKNgMunNxGOvDWo+bwmqU4Q4NTdjCPtYIwFtzJOPF9ROWyhzA
        dKw8+ZnxRQ8SJgSkhpsxmz3tB8mfPpOFqq2HAPmzbGiH1LpLRdt9hogLHJibSQ2dwWfbdj
        fAknxGcpb3ak5lrrtgfIHHlB9ilO0kUNOPiqxCnTS0WKYmd3uIvloplf81OLrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668203907;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=wJ4VmNv5odo4IUQ0hbkPconHUXSlDNr+RScHZTFV53U=;
        b=84xiXbS3b+ylPabFFChdU59JYtKKb41L/BQuuddpKE5sIQv26G+e5PXbNLW2S/rdaX20U4
        p9J4YHymC2+7XTAw==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] mm: Expose untagging mask in /proc/$PID/status
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166820390635.4906.10104879631223162906.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     57d3d258198cd13ba8ef7e3f97a6d6825d2f8868
Gitweb:        https://git.kernel.org/tip/57d3d258198cd13ba8ef7e3f97a6d6825d2f8868
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Wed, 09 Nov 2022 19:51:33 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 11 Nov 2022 13:29:37 -08:00

mm: Expose untagging mask in /proc/$PID/status

Add a line in /proc/$PID/status to report untag_mask. It can be
used to find out LAM status of the process from the outside. It is
useful for debuggers.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/all/20221109165140.9137-10-kirill.shutemov%40linux.intel.com
---
 arch/arm64/include/asm/mmu_context.h    | 6 ++++++
 arch/sparc/include/asm/mmu_context_64.h | 6 ++++++
 arch/x86/include/asm/mmu_context.h      | 6 ++++++
 fs/proc/array.c                         | 6 ++++++
 include/linux/mmu_context.h             | 7 +++++++
 5 files changed, 31 insertions(+)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index d3f8b5d..81ac12d 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -278,6 +278,12 @@ void post_ttbr_update_workaround(void);
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
index 92cf8f5..91fdbb4 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -103,6 +103,12 @@ static inline void dup_lam(struct mm_struct *oldmm, struct mm_struct *mm)
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
index 49283b8..d2a94ea 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -428,6 +428,11 @@ static inline void task_thp_status(struct seq_file *m, struct mm_struct *mm)
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
@@ -443,6 +448,7 @@ int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
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
