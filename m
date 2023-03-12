Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AF16B656D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 12:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjCLL1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 07:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjCLL1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 07:27:21 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0F531E05
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 04:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678620419; x=1710156419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pXZFCCXe+PDES5Btd5MhuDoEZZ+VyMVykxFB/NLFXd8=;
  b=DX0oH4A4hgc/FPe/UEPIUie3vgKKxGXpzjDpQjZOBiaxp8jgCVIiQh+8
   2jVIH+LWlj55pQs9ZOkAX5laH1oRTZJs6SUrfaimZPEcqFbawD+Svxofo
   t+KvYOXC8MvJDm/fCph3atb8+CJxhU9z4wp11q4nd+k+iPAi2CRHpMc9w
   NZucrD9ZXs56vapSlqDdsL9gI5shFMOLYySB3XTtjTJEFvG0OtR7r1g8a
   CgwCmoALIKBbcC3z7Pdd4lOC4ruREcWW0FMVg2qcj7duXbRxiPxiUUeZj
   7SQmiy1UXGtxGrGBR1FjrOFZ3p5jLB1e6c4lE0AN/lh5DJuV7HADqbwbi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="399577563"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="399577563"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2023 04:26:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="671580733"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="671580733"
Received: from nmoazzen-mobl1.amr.corp.intel.com (HELO box.shutemov.name) ([10.251.219.215])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2023 04:26:30 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id C3FDC10D7B9; Sun, 12 Mar 2023 14:26:19 +0300 (+03)
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
Subject: [PATCHv16 11/17] x86/mm/iommu/sva: Make LAM and SVA mutually exclusive
Date:   Sun, 12 Mar 2023 14:26:06 +0300
Message-Id: <20230312112612.31869-12-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230312112612.31869-1-kirill.shutemov@linux.intel.com>
References: <20230312112612.31869-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
index 06eaaf75d572..4c396e9a384f 100644
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
index 88aae519c8f8..eda826a956df 100644
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
2.39.2

