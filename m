Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA785BA063
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 19:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiIOR3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 13:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiIOR3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 13:29:07 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8937C98CB9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 10:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663262946; x=1694798946;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b+eGOyzBNzmsIjgmd3FH7KDt5YKAIkB20CJEC/+9RbQ=;
  b=NJmiC7cDqJzotfQKdz7p2/46qbnDr1WKVC/E2/pGw4I0ILMNN6aQAq2w
   BYVgvHHXHbd9U5/6245lFwOAKDiMLb//VDs/7uNY3QCkhxiVsHzz1QYro
   E1PYWplwBxJX20uQJ3y0ESDcVp6HLPWLU7rEMlgdvBxNaAbHnO4KGTZ/p
   Mg2Q3U5Tadltf/i5POfIR+ufvidWi8aIgV/gzBmE4NvI+IuwGrANxT6UD
   fCpBTBF+0wj6gRbl+x65AlxvZEFRM8Ud3TAQRdiPvT+x3IuKYR4Lc6JEB
   DFqM0K9atRMHfeQ1CXgv+G0vBV1Qdsn77jlgjBaHnwYKm0gNryV/i/P29
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10471"; a="325049926"
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="325049926"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 10:29:06 -0700
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="679624817"
Received: from gnogale1-mobl2.amr.corp.intel.com (HELO box.shutemov.name) ([10.251.209.66])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2022 10:29:00 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 6559810466F; Thu, 15 Sep 2022 20:28:58 +0300 (+03)
Date:   Thu, 15 Sep 2022 20:28:58 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Jacob Pan <jacob.jun.pan@intel.com>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Ashok Raj <ashok_raj@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCHv8 00/11] Linear Address Masking enabling
Message-ID: <20220915172858.pl62a5w3m5binxrk@box.shutemov.name>
References: <YxDvpLb77lwb8zaT@araj-dh-work>
 <20220904003952.fheisiloilxh3mpo@box.shutemov.name>
 <20220912224930.ukakmmwumchyacqc@box.shutemov.name>
 <20220914144518.46rhhyh7zmxieozs@box.shutemov.name>
 <YyHvF2K7ELVSTGvB@araj-MOBL2.amr.corp.intel.com>
 <20220914151818.uupzpyd333qnnmlt@box.shutemov.name>
 <YyHz7H0uyqG58b3E@araj-MOBL2.amr.corp.intel.com>
 <20220914154532.mmxfsr7eadgnxt3s@box.shutemov.name>
 <20220914165116.24f82d74@jacob-builder>
 <20220915090135.fpeokbokkdljv7rw@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915090135.fpeokbokkdljv7rw@box.shutemov.name>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 12:01:35PM +0300, Kirill A. Shutemov wrote:
> On Wed, Sep 14, 2022 at 04:51:16PM -0700, Jacob Pan wrote:
> > Hi Kirill,
> > 
> > On Wed, 14 Sep 2022 18:45:32 +0300, "Kirill A. Shutemov"
> > <kirill.shutemov@linux.intel.com> wrote:
> > 
> > > On Wed, Sep 14, 2022 at 08:31:56AM -0700, Ashok Raj wrote:
> > > > On Wed, Sep 14, 2022 at 06:18:18PM +0300, Kirill A. Shutemov wrote:  
> > > > > > > > > 
> > > > > > > > > The patch below implements something like this. It is PoC,
> > > > > > > > > build-tested only.
> > > > > > > > > 
> > > > > > > > > To be honest, I hate it. It is clearly a layering violation.
> > > > > > > > > It feels dirty. But I don't see any better way as we tie
> > > > > > > > > orthogonal features together.
> > > > > > > > > 
> > > > > > > > > Also I have no idea how to make forced PASID allocation if
> > > > > > > > > LAM enabled. What the API has to look like?  
> > > > > > > > 
> > > > > > > > Jacob, Ashok, any comment on this part?
> > > > > > > > 
> > > > > > > > I expect in many cases LAM will be enabled very early (like
> > > > > > > > before malloc is functinal) in process start and it makes PASID
> > > > > > > > allocation always fail.
> > > > > > > > 
> > > > > > > > Any way out?  
> > > > > > > 
> > > > > > > We need closure on this to proceed. Any clue?  
> > > > > > 
> > > > > > Failing PASID allocation seems like the right thing to do here. If
> > > > > > the application is explicitly allocating PASID's it can opt-out
> > > > > > using the similar mechanism you have for LAM enabling. So user takes
> > > > > > responsibility for sanitizing pointers. 
> > > > > > 
> > > > > > If some library is using an accelerator without application
> > > > > > knowledge, that would use the failure as a mechanism to use an
> > > > > > alternate path if one exists.
> > > > > > 
> > > > > > I don't know if both LAM and SVM need a separate forced opt-in (or i
> > > > > > don't have an opinion rather). Is this what you were asking? 
> > > > > > 
> > > > > > + Joerg, JasonG in case they have an opinion.  
> > > > > 
> > > > > My point is that the patch provides a way to override LAM vs. PASID
> > > > > mutual exclusion, but only if PASID allocated first. If we enabled
> > > > > LAM before PASID is allcoated there's no way to forcefully allocate
> > > > > PASID, bypassing LAM check. I think there should be one, no?  
> > > > 
> > > > Yes, we should have one for force enabling SVM too if the application
> > > > asks for forgiveness.   
> > > 
> > > What is the right API here?
> > > 
> > It seems very difficult to implement a UAPI for the applications to
> > override  at a runtime.  Currently, SVM bind  is under the control of
> > individual drivers. It could be at the time of open or some ioctl.
> > 
> > Perhaps,  this can be a platform policy via some commandline option. e.g.
> > intel_iommu=sva_lam_coexist.
> 
> I think it has to be per-process, not a system-wide handle.
> 
> Maybe a separate arch_prctl() to allow to enable LAM/SVM coexisting?
> It would cover both sides of the API, relaxing check for both.

Maybe something like the patch below. Build tested only.

I really struggle with naming here. Any suggestions on what XXX has to be
replaced with? I don't think it has to be limited to LAM as some other
tagging implementation may come later.

diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 2fdb390040b5..0a38b52b7b5e 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -12,6 +12,8 @@
 #define MM_CONTEXT_UPROBE_IA32	BIT(0)
 /* vsyscall page is accessible on this MM */
 #define MM_CONTEXT_HAS_VSYSCALL	BIT(1)
+/* Allow LAM and SVM coexisting */
+#define MM_CONTEXT_XXX		BIT(2)
 
 /*
  * x86 has arch-specific MMU state beyond what lives in mm_struct.
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 3736f41948e9..d4a0994e5bc7 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -113,6 +113,8 @@ static inline void mm_reset_untag_mask(struct mm_struct *mm)
 	mm->context.untag_mask = -1UL;
 }
 
+#define arch_can_alloc_pasid(mm)	\
+	(!mm_lam_cr3_mask(mm) || (mm->context.flags & MM_CONTEXT_XXX))
 #else
 
 static inline unsigned long mm_lam_cr3_mask(struct mm_struct *mm)
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index a31e27b95b19..3b77d51c7e6c 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -23,5 +23,6 @@
 #define ARCH_GET_UNTAG_MASK		0x4001
 #define ARCH_ENABLE_TAGGED_ADDR		0x4002
 #define ARCH_GET_MAX_TAG_BITS		0x4003
+#define ARCH_XXX			0x4004
 
 #endif /* _ASM_X86_PRCTL_H */
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 9aa85e74e59e..111843c9dd40 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -793,6 +793,11 @@ static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
 		goto out;
 	}
 
+	if (pasid_valid(mm->pasid) && !(mm->context.flags & MM_CONTEXT_XXX)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
 	if (!nr_bits) {
 		ret = -EINVAL;
 		goto out;
@@ -911,6 +916,12 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 				(unsigned long __user *)arg2);
 	case ARCH_ENABLE_TAGGED_ADDR:
 		return prctl_enable_tagged_addr(task->mm, arg2);
+	case ARCH_XXX:
+		if (mmap_write_lock_killable(task->mm))
+			return -EINTR;
+		task->mm->context.flags |= MM_CONTEXT_XXX;
+		mmap_write_unlock(task->mm);
+		return 0;
 	case ARCH_GET_MAX_TAG_BITS: {
 		int nr_bits;
 
diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
index 106506143896..ed76cdfa3e6b 100644
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
 
@@ -31,7 +33,17 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
 	    min == 0 || max < min)
 		return -EINVAL;
 
+	/* Serialize against address tagging enabling */
+	if (mmap_write_lock_killable(mm))
+		return -EINTR;
+
+	if (!arch_can_alloc_pasid(mm)) {
+		mmap_write_unlock(mm);
+		return -EBUSY;
+	}
+
 	mutex_lock(&iommu_sva_lock);
+
 	/* Is a PASID already associated with this mm? */
 	if (pasid_valid(mm->pasid)) {
 		if (mm->pasid < min || mm->pasid >= max)
@@ -46,6 +58,7 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
 		mm_pasid_set(mm, pasid);
 out:
 	mutex_unlock(&iommu_sva_lock);
+	mmap_write_unlock(mm);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_sva_alloc_pasid);
diff --git a/include/linux/mmu_context.h b/include/linux/mmu_context.h
index b9b970f7ab45..1649b080d844 100644
--- a/include/linux/mmu_context.h
+++ b/include/linux/mmu_context.h
@@ -28,4 +28,8 @@ static inline void leave_mm(int cpu) { }
 # define task_cpu_possible(cpu, p)	cpumask_test_cpu((cpu), task_cpu_possible_mask(p))
 #endif
 
+#ifndef arch_can_alloc_pasid
+#define arch_can_alloc_pasid(mm)	true
+#endif
+
 #endif
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
