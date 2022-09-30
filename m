Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69875F0DF3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 16:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbiI3Os5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 10:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbiI3OsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 10:48:22 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFA212C1D2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 07:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664549297; x=1696085297;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jASNJsRsaf5vJ4ndsb5wfnYQQP9W4VNqpMHgh8BGioo=;
  b=Fe5cv0sV0QSB9+9qhiNV8AAfoTHtPutcXvpcBOuC9zEcOL6sSsgW33iJ
   uUHXMvftM1Fz1YoThrtrg/cEqdXsCk8SUQJZwBD34bRNenY3nSEEIaTY+
   haZh0zj3UWwLu2u9hyIAT6xdr0+J29wy0mV6GL9SqQnlinuHMVAwwFY7v
   3yWXsvbVJyvoMURI3tZAaVE8dpIVN6uJM1EOnXaWgI4BFAeTiSo6Os/mz
   fvo3WJ84cY4fLeYebZMOsRt7zZlJoqi5YzZmFKNeiwVyM8W8Kwu9bLFAn
   k8kJBl4lY4zSrFzAvrBIPfH2sdKfzr9vdeCJy5sA+UDbsES4hrcNcrT6M
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="282570785"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="282570785"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 07:48:16 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="653563766"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="653563766"
Received: from herrerop-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.38.128])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 07:48:11 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 88F34104D64; Fri, 30 Sep 2022 17:48:02 +0300 (+03)
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
Subject: [PATCHv9 10/14] x86/mm, iommu/sva: Make LAM and SVM mutually exclusive
Date:   Fri, 30 Sep 2022 17:47:54 +0300
Message-Id: <20220930144758.30232-11-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220930144758.30232-1-kirill.shutemov@linux.intel.com>
References: <20220930144758.30232-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOMMU and SVM-capable devices know nothing about LAM and only expect
canonical addresses. Attempt to pass down tagged pointer will lead to
address translation failure.

By default do not allow to enable both LAM and use SVM in the same
process.

The new ARCH_FORCE_TAGGED_SVM arch_prctl() overrides the limitation.
By using the arch_prctl() userspace takes responsibility to never pass
tagged address to the device.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/mmu.h         |  6 ++++--
 arch/x86/include/asm/mmu_context.h |  2 ++
 arch/x86/include/uapi/asm/prctl.h  |  1 +
 arch/x86/kernel/process_64.c       | 13 +++++++++++++
 drivers/iommu/iommu-sva-lib.c      | 12 ++++++++++++
 include/linux/mmu_context.h        |  4 ++++
 6 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 2fdb390040b5..cce9b32b0d6d 100644
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
+/* Allow LAM and SVM coexisting */
+#define MM_CONTEXT_FORCE_TAGGED_SVM	BIT(2)
 
 /*
  * x86 has arch-specific MMU state beyond what lives in mm_struct.
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index b0e9ea23758b..6b9ac2c60cec 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -113,6 +113,8 @@ static inline void mm_reset_untag_mask(struct mm_struct *mm)
 	mm->context.untag_mask = -1UL;
 }
 
+#define arch_pgtable_dma_compat(mm)	\
+	(!mm_lam_cr3_mask(mm) || (mm->context.flags & MM_CONTEXT_FORCE_TAGGED_SVM))
 #else
 
 static inline unsigned long mm_lam_cr3_mask(struct mm_struct *mm)
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index a31e27b95b19..7bd22defb558 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -23,5 +23,6 @@
 #define ARCH_GET_UNTAG_MASK		0x4001
 #define ARCH_ENABLE_TAGGED_ADDR		0x4002
 #define ARCH_GET_MAX_TAG_BITS		0x4003
+#define ARCH_FORCE_TAGGED_SVM		0x4004
 
 #endif /* _ASM_X86_PRCTL_H */
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 1730c2fcc7ab..d7ec5c7f49a7 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -782,6 +782,13 @@ static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
 		goto out;
 	}
 
+#ifdef CONFIG_IOMMU_SVA
+	if (pasid_valid(mm->pasid) &&
+	    !(mm->context.flags & MM_CONTEXT_FORCE_TAGGED_SVM)) {
+		ret = -EBUSY;
+		goto out;
+	}
+#endif
 	if (!nr_bits) {
 		ret = -EINVAL;
 		goto out;
@@ -892,6 +899,12 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 				(unsigned long __user *)arg2);
 	case ARCH_ENABLE_TAGGED_ADDR:
 		return prctl_enable_tagged_addr(task->mm, arg2);
+	case ARCH_FORCE_TAGGED_SVM:
+		if (mmap_write_lock_killable(task->mm))
+			return -EINTR;
+		task->mm->context.flags |= MM_CONTEXT_FORCE_TAGGED_SVM;
+		mmap_write_unlock(task->mm);
+		return 0;
 	case ARCH_GET_MAX_TAG_BITS:
 		if (!cpu_feature_enabled(X86_FEATURE_LAM))
 			return put_user(0, (unsigned long __user *)arg2);
diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
index 106506143896..593ae2472e2c 100644
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
 	if (pasid_valid(mm->pasid)) {
@@ -46,6 +57,7 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
 		mm_pasid_set(mm, pasid);
 out:
 	mutex_unlock(&iommu_sva_lock);
+	mmap_write_unlock(mm);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_sva_alloc_pasid);
diff --git a/include/linux/mmu_context.h b/include/linux/mmu_context.h
index b9b970f7ab45..115e2b518079 100644
--- a/include/linux/mmu_context.h
+++ b/include/linux/mmu_context.h
@@ -28,4 +28,8 @@ static inline void leave_mm(int cpu) { }
 # define task_cpu_possible(cpu, p)	cpumask_test_cpu((cpu), task_cpu_possible_mask(p))
 #endif
 
+#ifndef arch_pgtable_dma_compat
+#define arch_pgtable_dma_compat(mm)	true
+#endif
+
 #endif
-- 
2.35.1

