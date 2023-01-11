Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536F5665C6D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbjAKNZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbjAKNYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:24:01 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639832632
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 05:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673443440; x=1704979440;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C8PPsmcjUUuQBbdSz1HmIC78H3wDV2qhKG6GO472d7A=;
  b=YhiyPcOO1f+HFK31XrdkWIHvcw7JnzbmEaC2H587bxjlycIvwtlqqtez
   RivWcW3gKeFDLRjau6+ABxSF8RYtjVpAs/95OiuC8DJ+v4SZ+aDmfsVQT
   6P4ow838gKcVtyJ/g4362QGSkea16MoEKMAb3QJL0+RnV8JXJOKLSCTGI
   ly+Qm1YJFs4KtYGGBsGhi41LJq/FEfOaXxsot5opseBEYe/4ZfD5zHCYM
   +rHYXj74q6HFVjuQvX4kpMSe4P5K+tHhS+ckdKgEQ3GphKMc0CeoAtmJK
   eZfpeJjt76oBJLHdvmzJ/55/rOF8u8lLUn/juKPafHDJoYtlHRLupHjzM
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="324646093"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="324646093"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 05:23:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="720725481"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="720725481"
Received: from bachaue1-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.37.250])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 05:23:49 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 73247109CE1; Wed, 11 Jan 2023 15:37:41 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv14 11/17] x86/mm/iommu/sva: Make LAM and SVA mutually exclusive
Date:   Wed, 11 Jan 2023 15:37:30 +0300
Message-Id: <20230111123736.20025-12-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20230111123736.20025-1-kirill.shutemov@linux.intel.com>
References: <20230111123736.20025-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOMMU and SVA-capable devices know nothing about LAM and only expect
canonical addresses. An attempt to pass down tagged pointer will lead
to address translation failure.

By default do not allow to enable both LAM and use SVA in the same
process.

The new ARCH_FORCE_TAGGED_SVA arch_prctl() overrides the limitation.
By using the arch_prctl() userspace takes responsibility to never pass
tagged address to the device.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 arch/x86/include/asm/mmu.h         | 2 ++
 arch/x86/include/asm/mmu_context.h | 6 ++++++
 arch/x86/include/uapi/asm/prctl.h  | 1 +
 arch/x86/kernel/process_64.c       | 7 +++++++
 drivers/iommu/iommu-sva.c          | 4 ++++
 include/linux/mmu_context.h        | 7 +++++++
 6 files changed, 27 insertions(+)

diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index e80762e998ce..0da5c227f490 100644
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
index 4b77c96da07f..6ffc42dfd59d 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -114,6 +114,12 @@ static inline void mm_reset_untag_mask(struct mm_struct *mm)
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
index a31e27b95b19..eb290d89cb32 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -23,5 +23,6 @@
 #define ARCH_GET_UNTAG_MASK		0x4001
 #define ARCH_ENABLE_TAGGED_ADDR		0x4002
 #define ARCH_GET_MAX_TAG_BITS		0x4003
+#define ARCH_FORCE_TAGGED_SVA		0x4004
 
 #endif /* _ASM_X86_PRCTL_H */
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 1b41c60ebf6e..0831d2be190f 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -759,6 +759,10 @@ static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
 	if (current->mm != mm)
 		return -EINVAL;
 
+	if (mm_valid_pasid(mm) &&
+	    !test_bit(MM_CONTEXT_FORCE_TAGGED_SVA, &mm->context.flags))
+		return -EINTR;
+
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
 
@@ -882,6 +886,9 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
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
index 4ee2929f0d7a..dd76a1a09cf7 100644
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
index 14b9c1fa05c4..f2b7a3f04099 100644
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
-- 
2.38.2

