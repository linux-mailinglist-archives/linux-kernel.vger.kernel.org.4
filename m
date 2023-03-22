Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5382A6C51D8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjCVRFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjCVREe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:04:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80046544D;
        Wed, 22 Mar 2023 10:03:51 -0700 (PDT)
Date:   Wed, 22 Mar 2023 17:03:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679504586;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Bjollm9Vuq3vRe3xsjqMWjhW+nQF8Korpyye6JjVNTU=;
        b=u7ZJEFeIBAEq48ULDJdfHOOSgjJ6Ux16VAGp4wDVeEljJTc9J1Rr23G7AdgJnzVJilwBAP
        ep46bU4Oow6EuhKD3x3b8XYzg83FcllxY3bKjm4Cski3dyDP9GukrQYveci379QYIIm3UW
        oY+SB+SYrNdtac2VS1QTyMBO7iTa2bCrj8hlddFMu3K3wxLYen1ToJM/0Dp8hZkPGxLdPk
        qd+WzUochLW6pGNGz9VBJo69Vh3o5mj4rTDZp4hITZ6D2PKB+OKhFSKTFWaYsoMonOTeKZ
        jIx0bZAKfkin1ruhGmWzLtC3OHVXYeaE0YebWTuFdkvuDu3DwiqkLbdnYJJSuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679504586;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Bjollm9Vuq3vRe3xsjqMWjhW+nQF8Korpyye6JjVNTU=;
        b=f7qfq4/Ju3jzu/O7utjFO9/wzWfiIyXDDh6aGxlxkRsYdNY5gzGvkz6LLxKPHzzRXET9az
        lB67tCNmAmQ0KtAQ==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/iommu/sva: Make LAM and SVA mutually exclusive
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167950458621.5837.11497227830572339720.tip-bot2@tip-bot2>
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

Commit-ID:     23e5d9ec2bab53c4e5fbac675304e699726c1ac5
Gitweb:        https://git.kernel.org/tip/23e5d9ec2bab53c4e5fbac675304e699726c1ac5
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Sun, 12 Mar 2023 14:26:06 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 16 Mar 2023 13:08:40 -07:00

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
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20230312112612.31869-12-kirill.shutemov%40linux.intel.com
---
 arch/x86/include/asm/mmu.h         | 2 ++
 arch/x86/include/asm/mmu_context.h | 6 ++++++
 arch/x86/include/uapi/asm/prctl.h  | 1 +
 arch/x86/kernel/process_64.c       | 7 +++++++
 drivers/iommu/iommu-sva.c          | 4 ++++
 include/linux/mmu_context.h        | 7 +++++++
 6 files changed, 27 insertions(+)

diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index e80762e..0da5c22 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -14,6 +14,8 @@
 #define MM_CONTEXT_HAS_VSYSCALL		1
 /* Do not allow changing LAM mode */
 #define MM_CONTEXT_LOCK_LAM		2
+/* Allow LAM and SVA coexisting */
+#define MM_CONTEXT_FORCE_TAGGED_SVA	3
 
 /*
  * x86 has arch-specific MMU state beyond what lives in mm_struct.
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 06eaaf7..4c396e9 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -115,6 +115,12 @@ static inline void mm_reset_untag_mask(struct mm_struct *mm)
 	mm->context.untag_mask = -1UL;
 }
 
+#define arch_pgtable_dma_compat arch_pgtable_dma_compat
+static inline bool arch_pgtable_dma_compat(struct mm_struct *mm)
+{
+	return !mm_lam_cr3_mask(mm) ||
+		test_bit(MM_CONTEXT_FORCE_TAGGED_SVA, &mm->context.flags);
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
index 186f34a..b46924c 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -756,6 +756,10 @@ static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
 	if (current->mm != mm)
 		return -EINVAL;
 
+	if (mm_valid_pasid(mm) &&
+	    !test_bit(MM_CONTEXT_FORCE_TAGGED_SVA, &mm->context.flags))
+		return -EINTR;
+
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
 
@@ -878,6 +882,9 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 				(unsigned long __user *)arg2);
 	case ARCH_ENABLE_TAGGED_ADDR:
 		return prctl_enable_tagged_addr(task->mm, arg2);
+	case ARCH_FORCE_TAGGED_SVA:
+		set_bit(MM_CONTEXT_FORCE_TAGGED_SVA, &task->mm->context.flags);
+		return 0;
 	case ARCH_GET_MAX_TAG_BITS:
 		if (!cpu_feature_enabled(X86_FEATURE_LAM))
 			return put_user(0, (unsigned long __user *)arg2);
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 4ee2929..dd76a1a 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -2,6 +2,7 @@
 /*
  * Helpers for IOMMU drivers implementing SVA
  */
+#include <linux/mmu_context.h>
 #include <linux/mutex.h>
 #include <linux/sched/mm.h>
 #include <linux/iommu.h>
@@ -32,6 +33,9 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
 	    min == 0 || max < min)
 		return -EINVAL;
 
+	if (!arch_pgtable_dma_compat(mm))
+		return -EBUSY;
+
 	mutex_lock(&iommu_sva_lock);
 	/* Is a PASID already associated with this mm? */
 	if (mm_valid_pasid(mm)) {
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
