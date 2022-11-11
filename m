Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E5D626407
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 22:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbiKKV6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 16:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233851AbiKKV62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 16:58:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D1E6361;
        Fri, 11 Nov 2022 13:58:26 -0800 (PST)
Date:   Fri, 11 Nov 2022 21:58:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668203905;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=rbW3lY0W9aR/yZEgIzEBTVlhI4pM6oglzRqDO7zLZRM=;
        b=BcgGqnqEF/TJ53MAr0VHevEGVmS8wohx8hMMMdnCJDkjaIK+/mngkern1lXAHvufEiFmO4
        KUgnkDv3rH5K+UUZlPVHnycxo6KjF1gPCqXXnOdLrbY0GquS+psl7bR8nGwtmqMlS42Uzw
        sypbzC3lGamwglGCfuIWulbV+Q9HKmJUyU7wEw2XVNFILImLisP1LMti9whlDq4uU9J9Iz
        96kh2oDB9GPm5sillmaJ7apMowJ8VsjrcjJjbDKTI4v91RBK9jgoxEhhmBGu03mI6NJA5T
        rvLq4ihy6ddKvFumuq6MhTNmwdsvP9qWN2Kwf6eZ+X4y58CLEqA1RgalHV3hIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668203905;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=rbW3lY0W9aR/yZEgIzEBTVlhI4pM6oglzRqDO7zLZRM=;
        b=MWz8dhzTLI0+KvLLbwVWUssTviAaAs2gwU1MDRpLR8xYViRzuyZg5elNNTwOCaH7bOMsRP
        ydIS8ZY4JDW6lOAg==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/iommu/sva: Make LAM and SVA mutually exclusive
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166820390410.4906.14639543924188548491.tip-bot2@tip-bot2>
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

Commit-ID:     53e220bbaa51f72a0d6c77dc3014ab9757baa8b5
Gitweb:        https://git.kernel.org/tip/53e220bbaa51f72a0d6c77dc3014ab9757baa8b5
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Wed, 09 Nov 2022 19:51:35 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 11 Nov 2022 13:29:55 -08:00

x86/mm/iommu/sva: Make LAM and SVA mutually exclusive

IOMMU and SVA-capable devices know nothing about LAM and only expect
canonical addresses. An attempt to pass down tagged pointer will lead
to address translation failure.

By default do not allow to enable both LAM and use SVA in the same
process.

The new ARCH_FORCE_TAGGED_SVA arch_prctl() overrides the limitation.
By using the arch_prctl() userspace takes responsibility to never pass
tagged address to the device.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Link: https://lore.kernel.org/all/20221109165140.9137-12-kirill.shutemov%40linux.intel.com
---
 arch/x86/include/asm/mmu.h         |  6 ++++--
 arch/x86/include/asm/mmu_context.h |  6 ++++++
 arch/x86/include/uapi/asm/prctl.h  |  1 +
 arch/x86/kernel/process_64.c       | 12 ++++++++++++
 drivers/iommu/iommu-sva-lib.c      | 12 ++++++++++++
 include/linux/mmu_context.h        |  7 +++++++
 6 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 2fdb390..1215b0a 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -9,9 +9,11 @@
 #include <linux/bits.h>
 
 /* Uprobes on this MM assume 32-bit code */
-#define MM_CONTEXT_UPROBE_IA32	BIT(0)
+#define MM_CONTEXT_UPROBE_IA32		BIT(0)
 /* vsyscall page is accessible on this MM */
-#define MM_CONTEXT_HAS_VSYSCALL	BIT(1)
+#define MM_CONTEXT_HAS_VSYSCALL		BIT(1)
+/* Allow LAM and SVA coexisting */
+#define MM_CONTEXT_FORCE_TAGGED_SVA	BIT(2)
 
 /*
  * x86 has arch-specific MMU state beyond what lives in mm_struct.
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 91fdbb4..32483ab 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -114,6 +114,12 @@ static inline void mm_reset_untag_mask(struct mm_struct *mm)
 	mm->context.untag_mask = -1UL;
 }
 
+#define arch_pgtable_dma_compat arch_pgtable_dma_compat
+static inline bool arch_pgtable_dma_compat(struct mm_struct *mm)
+{
+	return !mm_lam_cr3_mask(mm) ||
+		(mm->context.flags & MM_CONTEXT_FORCE_TAGGED_SVA);
+}
 #else
 
 static inline unsigned long mm_lam_cr3_mask(struct mm_struct *mm)
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index a31e27b..eb290d8 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -23,5 +23,6 @@
 #define ARCH_GET_UNTAG_MASK		0x4001
 #define ARCH_ENABLE_TAGGED_ADDR		0x4002
 #define ARCH_GET_MAX_TAG_BITS		0x4003
+#define ARCH_FORCE_TAGGED_SVA		0x4004
 
 #endif /* _ASM_X86_PRCTL_H */
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 457f79b..b06de18 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -789,6 +789,12 @@ static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
 		goto out;
 	}
 
+	if (mm_valid_pasid(mm) &&
+	    !(mm->context.flags & MM_CONTEXT_FORCE_TAGGED_SVA)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
 	if (!nr_bits) {
 		ret = -EINVAL;
 		goto out;
@@ -899,6 +905,12 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 				(unsigned long __user *)arg2);
 	case ARCH_ENABLE_TAGGED_ADDR:
 		return prctl_enable_tagged_addr(task->mm, arg2);
+	case ARCH_FORCE_TAGGED_SVA:
+		if (mmap_write_lock_killable(task->mm))
+			return -EINTR;
+		task->mm->context.flags |= MM_CONTEXT_FORCE_TAGGED_SVA;
+		mmap_write_unlock(task->mm);
+		return 0;
 	case ARCH_GET_MAX_TAG_BITS:
 		if (!cpu_feature_enabled(X86_FEATURE_LAM))
 			return put_user(0, (unsigned long __user *)arg2);
diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
index 27be6b8..8934c32 100644
--- a/drivers/iommu/iommu-sva-lib.c
+++ b/drivers/iommu/iommu-sva-lib.c
@@ -2,6 +2,8 @@
 /*
  * Helpers for IOMMU drivers implementing SVA
  */
+#include <linux/mm.h>
+#include <linux/mmu_context.h>
 #include <linux/mutex.h>
 #include <linux/sched/mm.h>
 
@@ -31,6 +33,15 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
 	    min == 0 || max < min)
 		return -EINVAL;
 
+	/* Serialize against address tagging enabling */
+	if (mmap_write_lock_killable(mm))
+		return -EINTR;
+
+	if (!arch_pgtable_dma_compat(mm)) {
+		mmap_write_unlock(mm);
+		return -EBUSY;
+	}
+
 	mutex_lock(&iommu_sva_lock);
 	/* Is a PASID already associated with this mm? */
 	if (mm_valid_pasid(mm)) {
@@ -46,6 +57,7 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
 		mm_pasid_set(mm, pasid);
 out:
 	mutex_unlock(&iommu_sva_lock);
+	mmap_write_unlock(mm);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_sva_alloc_pasid);
diff --git a/include/linux/mmu_context.h b/include/linux/mmu_context.h
index 14b9c1f..f2b7a3f 100644
--- a/include/linux/mmu_context.h
+++ b/include/linux/mmu_context.h
@@ -35,4 +35,11 @@ static inline unsigned long mm_untag_mask(struct mm_struct *mm)
 }
 #endif
 
+#ifndef arch_pgtable_dma_compat
+static inline bool arch_pgtable_dma_compat(struct mm_struct *mm)
+{
+	return true;
+}
+#endif
+
 #endif
