Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94BE623080
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 17:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiKIQwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 11:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiKIQwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 11:52:12 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247AB1B78D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 08:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668012730; x=1699548730;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P8gMvL5O01u2pAUkWY9sWozOyXZzWwP0vO43zDps+Zk=;
  b=F/Dd995lCnvgY14qan+EPxooUHPFiTIsYPWTv6sR1B0Z3WJ7yPbaWw26
   nWO0k/aRgwo9vkQ7OZfeJrEbg6nYUa+VyA8iGQx5Scig7tmpmmlNYwmuc
   wFc0lKuJogOiu6v9BrHEcs3zMnFbeZpNtdYvZj6gbutnkTA7Y4DTKP1ZR
   th1JF2Ie+GeCK76zRmD5i9NJR6fvi1O5SKdUtu74A5Ar1abU2Y9pvkviV
   1/RsgiQv9nGPy5OrDNo0OpWrU7XPQxeFrJ9lvnZabxo0c78bI1aQK4/jl
   PtsCB3S5tG0rwo26LTx6IsSCmuAwCKvwG2IvhswFyapmwdGaw6UkDF6+/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="294405269"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="294405269"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 08:52:08 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="700426425"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="700426425"
Received: from dschramm-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.219.85])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 08:52:03 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 77EE610946F; Wed,  9 Nov 2022 19:52:00 +0300 (+03)
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
Subject: [PATCHv12 03/16] mm: Pass down mm_struct to untagged_addr()
Date:   Wed,  9 Nov 2022 19:51:27 +0300
Message-Id: <20221109165140.9137-4-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221109165140.9137-1-kirill.shutemov@linux.intel.com>
References: <20221109165140.9137-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Linear Address Masking (LAM) brings per-mm untagging rules. Pass
down mm_struct to the untagging helper. It will help to apply untagging
policy correctly.

In most cases, current->mm is the one to use, but there are some
exceptions, such as get_user_page_remote().

Move dummy implementation of untagged_addr() from <linux/mm.h> to
<linux/uaccess.h>. <asm/uaccess.h> can override the implementation.
Moving the dummy header outside <linux/mm.h> helps to avoid header hell
if you need to defer mm_struct within the helper.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Tested-by: Alexander Potapenko <glider@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm64/include/asm/memory.h                  |  4 ++--
 arch/arm64/include/asm/signal.h                  |  2 +-
 arch/arm64/include/asm/uaccess.h                 |  2 +-
 arch/arm64/kernel/hw_breakpoint.c                |  2 +-
 arch/arm64/kernel/traps.c                        |  4 ++--
 arch/arm64/mm/fault.c                            | 10 +++++-----
 arch/sparc/include/asm/pgtable_64.h              |  2 +-
 arch/sparc/include/asm/uaccess_64.h              |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c          |  2 +-
 drivers/gpu/drm/radeon/radeon_gem.c              |  2 +-
 drivers/infiniband/hw/mlx4/mr.c                  |  2 +-
 drivers/media/common/videobuf2/frame_vector.c    |  2 +-
 drivers/media/v4l2-core/videobuf-dma-contig.c    |  2 +-
 drivers/staging/media/atomisp/pci/hmm/hmm_bo.c   |  2 +-
 drivers/tee/tee_shm.c                            |  2 +-
 drivers/vfio/vfio_iommu_type1.c                  |  2 +-
 fs/proc/task_mmu.c                               |  2 +-
 include/linux/mm.h                               | 11 -----------
 include/linux/uaccess.h                          | 15 +++++++++++++++
 lib/strncpy_from_user.c                          |  2 +-
 lib/strnlen_user.c                               |  2 +-
 mm/gup.c                                         |  6 +++---
 mm/madvise.c                                     |  2 +-
 mm/mempolicy.c                                   |  6 +++---
 mm/migrate.c                                     |  2 +-
 mm/mincore.c                                     |  2 +-
 mm/mlock.c                                       |  4 ++--
 mm/mmap.c                                        |  2 +-
 mm/mprotect.c                                    |  2 +-
 mm/mremap.c                                      |  2 +-
 mm/msync.c                                       |  2 +-
 virt/kvm/kvm_main.c                              |  2 +-
 33 files changed, 58 insertions(+), 52 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 9dd08cd339c3..5b24ef93c6b9 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -227,8 +227,8 @@ static inline unsigned long kaslr_offset(void)
 #define __untagged_addr(addr)	\
 	((__force __typeof__(addr))sign_extend64((__force u64)(addr), 55))
 
-#define untagged_addr(addr)	({					\
-	u64 __addr = (__force u64)(addr);					\
+#define untagged_addr(mm, addr)	({					\
+	u64 __addr = (__force u64)(addr);				\
 	__addr &= __untagged_addr(__addr);				\
 	(__force __typeof__(addr))__addr;				\
 })
diff --git a/arch/arm64/include/asm/signal.h b/arch/arm64/include/asm/signal.h
index ef449f5f4ba8..0899c355c398 100644
--- a/arch/arm64/include/asm/signal.h
+++ b/arch/arm64/include/asm/signal.h
@@ -18,7 +18,7 @@ static inline void __user *arch_untagged_si_addr(void __user *addr,
 	if (sig == SIGTRAP && si_code == TRAP_BRKPT)
 		return addr;
 
-	return untagged_addr(addr);
+	return untagged_addr(current->mm, addr);
 }
 #define arch_untagged_si_addr arch_untagged_si_addr
 
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 5c7b2f9d5913..122d894a4136 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -44,7 +44,7 @@ static inline int access_ok(const void __user *addr, unsigned long size)
 	 */
 	if (IS_ENABLED(CONFIG_ARM64_TAGGED_ADDR_ABI) &&
 	    (current->flags & PF_KTHREAD || test_thread_flag(TIF_TAGGED_ADDR)))
-		addr = untagged_addr(addr);
+		addr = untagged_addr(current->mm, addr);
 
 	return likely(__access_ok(addr, size));
 }
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index b29a311bb055..d637cee7b771 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -715,7 +715,7 @@ static u64 get_distance_from_watchpoint(unsigned long addr, u64 val,
 	u64 wp_low, wp_high;
 	u32 lens, lene;
 
-	addr = untagged_addr(addr);
+	addr = untagged_addr(current->mm, addr);
 
 	lens = __ffs(ctrl->len);
 	lene = __fls(ctrl->len);
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 23d281ed7621..f40f3885b674 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -477,7 +477,7 @@ void arm64_notify_segfault(unsigned long addr)
 	int code;
 
 	mmap_read_lock(current->mm);
-	if (find_vma(current->mm, untagged_addr(addr)) == NULL)
+	if (find_vma(current->mm, untagged_addr(current->mm, addr)) == NULL)
 		code = SEGV_MAPERR;
 	else
 		code = SEGV_ACCERR;
@@ -551,7 +551,7 @@ static void user_cache_maint_handler(unsigned long esr, struct pt_regs *regs)
 	int ret = 0;
 
 	tagged_address = pt_regs_read_reg(regs, rt);
-	address = untagged_addr(tagged_address);
+	address = untagged_addr(current->mm, tagged_address);
 
 	switch (crm) {
 	case ESR_ELx_SYS64_ISS_CRM_DC_CVAU:	/* DC CVAU, gets promoted */
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 5b391490e045..b8799e9c7e1b 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -454,7 +454,7 @@ static void set_thread_esr(unsigned long address, unsigned long esr)
 static void do_bad_area(unsigned long far, unsigned long esr,
 			struct pt_regs *regs)
 {
-	unsigned long addr = untagged_addr(far);
+	unsigned long addr = untagged_addr(current->mm, far);
 
 	/*
 	 * If we are in kernel mode at this point, we have no context to
@@ -524,7 +524,7 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 	vm_fault_t fault;
 	unsigned long vm_flags;
 	unsigned int mm_flags = FAULT_FLAG_DEFAULT;
-	unsigned long addr = untagged_addr(far);
+	unsigned long addr = untagged_addr(mm, far);
 
 	if (kprobe_page_fault(regs, esr))
 		return 0;
@@ -679,7 +679,7 @@ static int __kprobes do_translation_fault(unsigned long far,
 					  unsigned long esr,
 					  struct pt_regs *regs)
 {
-	unsigned long addr = untagged_addr(far);
+	unsigned long addr = untagged_addr(current->mm, far);
 
 	if (is_ttbr0_addr(addr))
 		return do_page_fault(far, esr, regs);
@@ -726,7 +726,7 @@ static int do_sea(unsigned long far, unsigned long esr, struct pt_regs *regs)
 		 * UNKNOWN for synchronous external aborts. Mask them out now
 		 * so that userspace doesn't see them.
 		 */
-		siaddr  = untagged_addr(far);
+		siaddr  = untagged_addr(current->mm, far);
 	}
 	arm64_notify_die(inf->name, regs, inf->sig, inf->code, siaddr, esr);
 
@@ -816,7 +816,7 @@ static const struct fault_info fault_info[] = {
 void do_mem_abort(unsigned long far, unsigned long esr, struct pt_regs *regs)
 {
 	const struct fault_info *inf = esr_to_fault_info(esr);
-	unsigned long addr = untagged_addr(far);
+	unsigned long addr = untagged_addr(current->mm, far);
 
 	if (!inf->fn(far, esr, regs))
 		return;
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index a779418ceba9..aa996ffe5c8c 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -1052,7 +1052,7 @@ static inline unsigned long __untagged_addr(unsigned long start)
 
 	return start;
 }
-#define untagged_addr(addr) \
+#define untagged_addr(mm, addr) \
 	((__typeof__(addr))(__untagged_addr((unsigned long)(addr))))
 
 static inline bool pte_access_permitted(pte_t pte, bool write)
diff --git a/arch/sparc/include/asm/uaccess_64.h b/arch/sparc/include/asm/uaccess_64.h
index 94266a5c5b04..b825a5dd0210 100644
--- a/arch/sparc/include/asm/uaccess_64.h
+++ b/arch/sparc/include/asm/uaccess_64.h
@@ -8,8 +8,10 @@
 
 #include <linux/compiler.h>
 #include <linux/string.h>
+#include <linux/mm_types.h>
 #include <asm/asi.h>
 #include <asm/spitfire.h>
+#include <asm/pgtable.h>
 
 #include <asm/processor.h>
 #include <asm-generic/access_ok.h>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 84f44f7e4111..36f87d0e03c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1659,7 +1659,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 		if (flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
 			if (!offset || !*offset)
 				return -EINVAL;
-			user_addr = untagged_addr(*offset);
+			user_addr = untagged_addr(current->mm, *offset);
 		} else if (flags & (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
 				    KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
 			bo_type = ttm_bo_type_sg;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 8ef31d687ef3..691dfb3f2c0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -382,7 +382,7 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
 	uint32_t handle;
 	int r;
 
-	args->addr = untagged_addr(args->addr);
+	args->addr = untagged_addr(current->mm, args->addr);
 
 	if (offset_in_page(args->addr | args->size))
 		return -EINVAL;
diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
index 261fcbae88d7..cba2f4b19838 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -371,7 +371,7 @@ int radeon_gem_userptr_ioctl(struct drm_device *dev, void *data,
 	uint32_t handle;
 	int r;
 
-	args->addr = untagged_addr(args->addr);
+	args->addr = untagged_addr(current->mm, args->addr);
 
 	if (offset_in_page(args->addr | args->size))
 		return -EINVAL;
diff --git a/drivers/infiniband/hw/mlx4/mr.c b/drivers/infiniband/hw/mlx4/mr.c
index a40bf58bcdd3..383ac9e40dfa 100644
--- a/drivers/infiniband/hw/mlx4/mr.c
+++ b/drivers/infiniband/hw/mlx4/mr.c
@@ -379,7 +379,7 @@ static struct ib_umem *mlx4_get_umem_mr(struct ib_device *device, u64 start,
 	 * again
 	 */
 	if (!ib_access_writable(access_flags)) {
-		unsigned long untagged_start = untagged_addr(start);
+		unsigned long untagged_start = untagged_addr(current->mm, start);
 		struct vm_area_struct *vma;
 
 		mmap_read_lock(current->mm);
diff --git a/drivers/media/common/videobuf2/frame_vector.c b/drivers/media/common/videobuf2/frame_vector.c
index 542dde9d2609..7e62f7a2555d 100644
--- a/drivers/media/common/videobuf2/frame_vector.c
+++ b/drivers/media/common/videobuf2/frame_vector.c
@@ -47,7 +47,7 @@ int get_vaddr_frames(unsigned long start, unsigned int nr_frames,
 	if (WARN_ON_ONCE(nr_frames > vec->nr_allocated))
 		nr_frames = vec->nr_allocated;
 
-	start = untagged_addr(start);
+	start = untagged_addr(mm, start);
 
 	ret = pin_user_pages_fast(start, nr_frames,
 				  FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM,
diff --git a/drivers/media/v4l2-core/videobuf-dma-contig.c b/drivers/media/v4l2-core/videobuf-dma-contig.c
index 52312ce2ba05..a1444f8afa05 100644
--- a/drivers/media/v4l2-core/videobuf-dma-contig.c
+++ b/drivers/media/v4l2-core/videobuf-dma-contig.c
@@ -157,8 +157,8 @@ static void videobuf_dma_contig_user_put(struct videobuf_dma_contig_memory *mem)
 static int videobuf_dma_contig_user_get(struct videobuf_dma_contig_memory *mem,
 					struct videobuf_buffer *vb)
 {
-	unsigned long untagged_baddr = untagged_addr(vb->baddr);
 	struct mm_struct *mm = current->mm;
+	unsigned long untagged_baddr = untagged_addr(mm, vb->baddr);
 	struct vm_area_struct *vma;
 	unsigned long prev_pfn, this_pfn;
 	unsigned long pages_done, user_address;
diff --git a/drivers/staging/media/atomisp/pci/hmm/hmm_bo.c b/drivers/staging/media/atomisp/pci/hmm/hmm_bo.c
index a5fd6d38d3c4..4a01bc7c62b6 100644
--- a/drivers/staging/media/atomisp/pci/hmm/hmm_bo.c
+++ b/drivers/staging/media/atomisp/pci/hmm/hmm_bo.c
@@ -668,7 +668,7 @@ static int alloc_user_pages(struct hmm_buffer_object *bo,
 {
 	int page_nr;
 
-	userptr = untagged_addr(userptr);
+	userptr = untagged_addr(current->mm, userptr);
 
 	/* Handle frame buffer allocated in user space */
 	mutex_unlock(&bo->mutex);
diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 27295bda3e0b..5c85445f3a65 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -262,7 +262,7 @@ register_shm_helper(struct tee_context *ctx, unsigned long addr,
 	shm->flags = flags;
 	shm->ctx = ctx;
 	shm->id = id;
-	addr = untagged_addr(addr);
+	addr = untagged_addr(current->mm, addr);
 	start = rounddown(addr, PAGE_SIZE);
 	shm->offset = addr - start;
 	shm->size = length;
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 23c24fe98c00..74b6aecea8b0 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -573,7 +573,7 @@ static int vaddr_get_pfns(struct mm_struct *mm, unsigned long vaddr,
 		goto done;
 	}
 
-	vaddr = untagged_addr(vaddr);
+	vaddr = untagged_addr(mm, vaddr);
 
 retry:
 	vma = vma_lookup(mm, vaddr);
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 8a74cdcc9af0..fa3eea895210 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1685,7 +1685,7 @@ static ssize_t pagemap_read(struct file *file, char __user *buf,
 	/* watch out for wraparound */
 	start_vaddr = end_vaddr;
 	if (svpfn <= (ULONG_MAX >> PAGE_SHIFT))
-		start_vaddr = untagged_addr(svpfn << PAGE_SHIFT);
+		start_vaddr = untagged_addr(mm, svpfn << PAGE_SHIFT);
 
 	/* Ensure the address is inside the task */
 	if (start_vaddr > mm->task_size)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8bbcccbc5565..bfac5a166cb8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -95,17 +95,6 @@ extern int mmap_rnd_compat_bits __read_mostly;
 #include <asm/page.h>
 #include <asm/processor.h>
 
-/*
- * Architectures that support memory tagging (assigning tags to memory regions,
- * embedding these tags into addresses that point to these memory regions, and
- * checking that the memory and the pointer tags match on memory accesses)
- * redefine this macro to strip tags from pointers.
- * It's defined as noop for architectures that don't support memory tagging.
- */
-#ifndef untagged_addr
-#define untagged_addr(addr) (addr)
-#endif
-
 #ifndef __pa_symbol
 #define __pa_symbol(x)  __pa(RELOC_HIDE((unsigned long)(x), 0))
 #endif
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index afb18f198843..46680189d761 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -10,6 +10,21 @@
 
 #include <asm/uaccess.h>
 
+/*
+ * Architectures that support memory tagging (assigning tags to memory regions,
+ * embedding these tags into addresses that point to these memory regions, and
+ * checking that the memory and the pointer tags match on memory accesses)
+ * redefine this macro to strip tags from pointers.
+ *
+ * Passing down mm_struct allows to define untagging rules on per-process
+ * basis.
+ *
+ * It's defined as noop for architectures that don't support memory tagging.
+ */
+#ifndef untagged_addr
+#define untagged_addr(mm, addr) (addr)
+#endif
+
 /*
  * Architectures should provide two primitives (raw_copy_{to,from}_user())
  * and get rid of their private instances of copy_{to,from}_user() and
diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
index 6432b8c3e431..6e1e2aa0c994 100644
--- a/lib/strncpy_from_user.c
+++ b/lib/strncpy_from_user.c
@@ -121,7 +121,7 @@ long strncpy_from_user(char *dst, const char __user *src, long count)
 		return 0;
 
 	max_addr = TASK_SIZE_MAX;
-	src_addr = (unsigned long)untagged_addr(src);
+	src_addr = (unsigned long)untagged_addr(current->mm, src);
 	if (likely(src_addr < max_addr)) {
 		unsigned long max = max_addr - src_addr;
 		long retval;
diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
index feeb935a2299..abc096a68f05 100644
--- a/lib/strnlen_user.c
+++ b/lib/strnlen_user.c
@@ -97,7 +97,7 @@ long strnlen_user(const char __user *str, long count)
 		return 0;
 
 	max_addr = TASK_SIZE_MAX;
-	src_addr = (unsigned long)untagged_addr(str);
+	src_addr = (unsigned long)untagged_addr(current->mm, str);
 	if (likely(src_addr < max_addr)) {
 		unsigned long max = max_addr - src_addr;
 		long retval;
diff --git a/mm/gup.c b/mm/gup.c
index ff8b22327e16..cdff87343884 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1168,7 +1168,7 @@ static long __get_user_pages(struct mm_struct *mm,
 	if (!nr_pages)
 		return 0;
 
-	start = untagged_addr(start);
+	start = untagged_addr(mm, start);
 
 	VM_BUG_ON(!!pages != !!(gup_flags & (FOLL_GET | FOLL_PIN)));
 
@@ -1342,7 +1342,7 @@ int fixup_user_fault(struct mm_struct *mm,
 	struct vm_area_struct *vma;
 	vm_fault_t ret;
 
-	address = untagged_addr(address);
+	address = untagged_addr(mm, address);
 
 	if (unlocked)
 		fault_flags |= FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
@@ -3027,7 +3027,7 @@ static int internal_get_user_pages_fast(unsigned long start,
 	if (!(gup_flags & FOLL_FAST_ONLY))
 		might_lock_read(&current->mm->mmap_lock);
 
-	start = untagged_addr(start) & PAGE_MASK;
+	start = untagged_addr(current->mm, start) & PAGE_MASK;
 	len = nr_pages << PAGE_SHIFT;
 	if (check_add_overflow(start, len, &end))
 		return 0;
diff --git a/mm/madvise.c b/mm/madvise.c
index c7105ec6d08c..0a6cb52cd2da 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1392,7 +1392,7 @@ int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int beh
 	size_t len;
 	struct blk_plug plug;
 
-	start = untagged_addr(start);
+	start = untagged_addr(mm, start);
 
 	if (!madvise_behavior_valid(behavior))
 		return -EINVAL;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 61aa9aedb728..98cf4a22149a 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1472,7 +1472,7 @@ static long kernel_mbind(unsigned long start, unsigned long len,
 	int lmode = mode;
 	int err;
 
-	start = untagged_addr(start);
+	start = untagged_addr(current->mm, start);
 	err = sanitize_mpol_flags(&lmode, &mode_flags);
 	if (err)
 		return err;
@@ -1496,7 +1496,7 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned long, start, unsigned long, le
 	int err = -ENOENT;
 	VMA_ITERATOR(vmi, mm, start);
 
-	start = untagged_addr(start);
+	start = untagged_addr(mm, start);
 	if (start & ~PAGE_MASK)
 		return -EINVAL;
 	/*
@@ -1697,7 +1697,7 @@ static int kernel_get_mempolicy(int __user *policy,
 	if (nmask != NULL && maxnode < nr_node_ids)
 		return -EINVAL;
 
-	addr = untagged_addr(addr);
+	addr = untagged_addr(current->mm, addr);
 
 	err = do_get_mempolicy(&pval, &nodes, addr, flags);
 
diff --git a/mm/migrate.c b/mm/migrate.c
index dff333593a8a..57eb588bc019 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1802,7 +1802,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 			goto out_flush;
 		if (get_user(node, nodes + i))
 			goto out_flush;
-		addr = (unsigned long)untagged_addr(p);
+		addr = (unsigned long)untagged_addr(mm, p);
 
 		err = -ENODEV;
 		if (node < 0 || node >= MAX_NUMNODES)
diff --git a/mm/mincore.c b/mm/mincore.c
index fa200c14185f..72c55bd9d184 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -236,7 +236,7 @@ SYSCALL_DEFINE3(mincore, unsigned long, start, size_t, len,
 	unsigned long pages;
 	unsigned char *tmp;
 
-	start = untagged_addr(start);
+	start = untagged_addr(current->mm, start);
 
 	/* Check the start address: needs to be page-aligned.. */
 	if (start & ~PAGE_MASK)
diff --git a/mm/mlock.c b/mm/mlock.c
index 7032f6dd0ce1..d969703c08ff 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -570,7 +570,7 @@ static __must_check int do_mlock(unsigned long start, size_t len, vm_flags_t fla
 	unsigned long lock_limit;
 	int error = -ENOMEM;
 
-	start = untagged_addr(start);
+	start = untagged_addr(current->mm, start);
 
 	if (!can_do_mlock())
 		return -EPERM;
@@ -633,7 +633,7 @@ SYSCALL_DEFINE2(munlock, unsigned long, start, size_t, len)
 {
 	int ret;
 
-	start = untagged_addr(start);
+	start = untagged_addr(current->mm, start);
 
 	len = PAGE_ALIGN(len + (offset_in_page(start)));
 	start &= PAGE_MASK;
diff --git a/mm/mmap.c b/mm/mmap.c
index 2def55555e05..a15def6cff4e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2796,7 +2796,7 @@ EXPORT_SYMBOL(vm_munmap);
 
 SYSCALL_DEFINE2(munmap, unsigned long, addr, size_t, len)
 {
-	addr = untagged_addr(addr);
+	addr = untagged_addr(current->mm, addr);
 	return __vm_munmap(addr, len, true);
 }
 
diff --git a/mm/mprotect.c b/mm/mprotect.c
index f006bafe338f..de7351631e21 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -680,7 +680,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 	struct mmu_gather tlb;
 	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
 
-	start = untagged_addr(start);
+	start = untagged_addr(current->mm, start);
 
 	prot &= ~(PROT_GROWSDOWN|PROT_GROWSUP);
 	if (grows == (PROT_GROWSDOWN|PROT_GROWSUP)) /* can't be both */
diff --git a/mm/mremap.c b/mm/mremap.c
index e465ffe279bb..81c857281a52 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -909,7 +909,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 	 *
 	 * See Documentation/arm64/tagged-address-abi.rst for more information.
 	 */
-	addr = untagged_addr(addr);
+	addr = untagged_addr(mm, addr);
 
 	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE | MREMAP_DONTUNMAP))
 		return ret;
diff --git a/mm/msync.c b/mm/msync.c
index ac4c9bfea2e7..f941e9bb610f 100644
--- a/mm/msync.c
+++ b/mm/msync.c
@@ -37,7 +37,7 @@ SYSCALL_DEFINE3(msync, unsigned long, start, size_t, len, int, flags)
 	int unmapped_error = 0;
 	int error = -EINVAL;
 
-	start = untagged_addr(start);
+	start = untagged_addr(mm, start);
 
 	if (flags & ~(MS_ASYNC | MS_INVALIDATE | MS_SYNC))
 		goto out;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 1376a47fedee..d2139906ff91 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1945,7 +1945,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
 		return -EINVAL;
 	/* We can read the guest memory with __xxx_user() later on. */
 	if ((mem->userspace_addr & (PAGE_SIZE - 1)) ||
-	    (mem->userspace_addr != untagged_addr(mem->userspace_addr)) ||
+	    (mem->userspace_addr != untagged_addr(kvm->mm, mem->userspace_addr)) ||
 	     !access_ok((void __user *)(unsigned long)mem->userspace_addr,
 			mem->memory_size))
 		return -EINVAL;
-- 
2.38.0

