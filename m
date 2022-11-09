Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62B3623089
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 17:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbiKIQxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 11:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbiKIQwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 11:52:36 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8EF24F29
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 08:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668012739; x=1699548739;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C8gw4fXZss1vNc+3KIpIWYRKDR6wBig/C9HJl6yEnno=;
  b=Xde93O8IK/yhSafgu/zmtJGBj+RksPHh21nOtb7gQX+cztUmDfQf83E4
   u7V9f/gyug3KeLxGIqywc/0rl4oFauCcHAgVjAKaZWCcUrBoPf2wrgWCA
   t/vhkDiYSV7BptLujJtp3KEqjbv0mxB6/VB+UH1iD120Qa7DmRGLs/g3D
   xEDoOTvhle1lfauYxMosoZDvnltQx0qo0x9jq4gKA5ZgRUKCsEusxPPth
   1C2MiWwforxJ2RasIlSLGjcYahqlh2UvwF21nMn3qcm+OuFIY7t6ZGM7c
   XdIgNiBS2KXDfBszh94DdXUQKCO2dQO6dfg3gZlW68SxT30fJj2LJ6tf+
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="298553710"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="298553710"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 08:52:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="587827257"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="587827257"
Received: from dschramm-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.219.85])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 08:52:10 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id C9090109477; Wed,  9 Nov 2022 19:52:00 +0300 (+03)
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
        Ashok Raj <ashok.raj@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv12 11/16] x86/mm, iommu/sva: Make LAM and SVA mutually exclusive
Date:   Wed,  9 Nov 2022 19:51:35 +0300
Message-Id: <20221109165140.9137-12-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221109165140.9137-1-kirill.shutemov@linux.intel.com>
References: <20221109165140.9137-1-kirill.shutemov@linux.intel.com>
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
 arch/x86/include/asm/mmu.h         |  6 ++++--
 arch/x86/include/asm/mmu_context.h |  6 ++++++
 arch/x86/include/uapi/asm/prctl.h  |  1 +
 arch/x86/kernel/process_64.c       | 12 ++++++++++++
 drivers/iommu/iommu-sva-lib.c      | 12 ++++++++++++
 include/linux/mmu_context.h        |  7 +++++++
 6 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 2fdb390040b5..1215b0a714c9 100644
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
index 91fdbb47b0ef..32483ab3f763 100644
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
index 457f79be8bc7..b06de18215ce 100644
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
index 27be6b81e0b5..8934c32e923c 100644
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
2.38.0

