Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7155744924
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 15:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjGANLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 09:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjGANLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 09:11:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E34F4212;
        Sat,  1 Jul 2023 06:10:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B84860B73;
        Sat,  1 Jul 2023 13:10:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73A1C433C7;
        Sat,  1 Jul 2023 13:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688217055;
        bh=EE0qeq3gUBVaw6Ne1rNDy8G92kaLPTLE9n9XiE3xbfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PvyoQJDLM5lHq+9oOOBIhGaeYScNzU/QTLSCIRpH/lAjK1rDD9ATHtoHPf5aDftGD
         S4VI/Jt64TKeQFUsHlUk3QnuDwwwwFPANZPn+gkGN+d0d8KR2T695860zrqmBboO/w
         IlnBzThrBB2MJLD9UYt45eba3A+v7/GX+Tk2fCI8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.3.11
Date:   Sat,  1 Jul 2023 15:10:46 +0200
Message-ID: <2023070146-endearing-bounding-d21a@gregkh>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023070145-pureness-conjure-c024@gregkh>
References: <2023070145-pureness-conjure-c024@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 47253ac6c85c..34349623a76a 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 3
-SUBLEVEL = 10
+SUBLEVEL = 11
 EXTRAVERSION =
 NAME = Hurr durr I'ma ninja sloth
 
diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 780d4673c3ca..a40a61583b33 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -29,6 +29,7 @@ config ALPHA
 	select GENERIC_SMP_IDLE_THREAD
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_MOD_ARCH_SPECIFIC
+	select LOCK_MM_AND_FIND_VMA
 	select MODULES_USE_ELF_RELA
 	select ODD_RT_SIGACTION
 	select OLD_SIGSUSPEND
diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
index 7b01ae4f3bc6..8c9850437e67 100644
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -119,20 +119,12 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
 		flags |= FAULT_FLAG_USER;
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 retry:
-	mmap_read_lock(mm);
-	vma = find_vma(mm, address);
+	vma = lock_mm_and_find_vma(mm, address, regs);
 	if (!vma)
-		goto bad_area;
-	if (vma->vm_start <= address)
-		goto good_area;
-	if (!(vma->vm_flags & VM_GROWSDOWN))
-		goto bad_area;
-	if (expand_stack(vma, address))
-		goto bad_area;
+		goto bad_area_nosemaphore;
 
 	/* Ok, we have a good vm_area for this memory access, so
 	   we can handle it.  */
- good_area:
 	si_code = SEGV_ACCERR;
 	if (cause < 0) {
 		if (!(vma->vm_flags & VM_EXEC))
@@ -192,6 +184,7 @@ do_page_fault(unsigned long address, unsigned long mmcsr,
  bad_area:
 	mmap_read_unlock(mm);
 
+ bad_area_nosemaphore:
 	if (user_mode(regs))
 		goto do_sigsegv;
 
diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index d9a13ccf89a3..cb1074f74c3f 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -41,6 +41,7 @@ config ARC
 	select HAVE_PERF_EVENTS
 	select HAVE_SYSCALL_TRACEPOINTS
 	select IRQ_DOMAIN
+	select LOCK_MM_AND_FIND_VMA
 	select MODULES_USE_ELF_RELA
 	select OF
 	select OF_EARLY_FLATTREE
diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index 5ca59a482632..f59e722d147f 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -113,15 +113,9 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 retry:
-	mmap_read_lock(mm);
-
-	vma = find_vma(mm, address);
+	vma = lock_mm_and_find_vma(mm, address, regs);
 	if (!vma)
-		goto bad_area;
-	if (unlikely(address < vma->vm_start)) {
-		if (!(vma->vm_flags & VM_GROWSDOWN) || expand_stack(vma, address))
-			goto bad_area;
-	}
+		goto bad_area_nosemaphore;
 
 	/*
 	 * vm_area is good, now check permissions for this memory access
@@ -161,6 +155,7 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 bad_area:
 	mmap_read_unlock(mm);
 
+bad_area_nosemaphore:
 	/*
 	 * Major/minor page fault accounting
 	 * (in case of retry we only land here once)
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e24a9820e12f..a04bb151a902 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -125,6 +125,7 @@ config ARM
 	select HAVE_UID16
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN
 	select IRQ_FORCED_THREADING
+	select LOCK_MM_AND_FIND_VMA
 	select MODULES_USE_ELF_REL
 	select NEED_DMA_MAP_STATE
 	select OF_EARLY_FLATTREE if OF
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 2418f1efabd8..0860eeba8bd3 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -232,37 +232,11 @@ static inline bool is_permission_fault(unsigned int fsr)
 	return false;
 }
 
-static vm_fault_t __kprobes
-__do_page_fault(struct mm_struct *mm, unsigned long addr, unsigned int flags,
-		unsigned long vma_flags, struct pt_regs *regs)
-{
-	struct vm_area_struct *vma = find_vma(mm, addr);
-	if (unlikely(!vma))
-		return VM_FAULT_BADMAP;
-
-	if (unlikely(vma->vm_start > addr)) {
-		if (!(vma->vm_flags & VM_GROWSDOWN))
-			return VM_FAULT_BADMAP;
-		if (addr < FIRST_USER_ADDRESS)
-			return VM_FAULT_BADMAP;
-		if (expand_stack(vma, addr))
-			return VM_FAULT_BADMAP;
-	}
-
-	/*
-	 * ok, we have a good vm_area for this memory access, check the
-	 * permissions on the VMA allow for the fault which occurred.
-	 */
-	if (!(vma->vm_flags & vma_flags))
-		return VM_FAULT_BADACCESS;
-
-	return handle_mm_fault(vma, addr & PAGE_MASK, flags, regs);
-}
-
 static int __kprobes
 do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 {
 	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
 	int sig, code;
 	vm_fault_t fault;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
@@ -301,31 +275,21 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
 
-	/*
-	 * As per x86, we may deadlock here.  However, since the kernel only
-	 * validly references user space from well defined areas of the code,
-	 * we can bug out early if this is from code which shouldn't.
-	 */
-	if (!mmap_read_trylock(mm)) {
-		if (!user_mode(regs) && !search_exception_tables(regs->ARM_pc))
-			goto no_context;
 retry:
-		mmap_read_lock(mm);
-	} else {
-		/*
-		 * The above down_read_trylock() might have succeeded in
-		 * which case, we'll have missed the might_sleep() from
-		 * down_read()
-		 */
-		might_sleep();
-#ifdef CONFIG_DEBUG_VM
-		if (!user_mode(regs) &&
-		    !search_exception_tables(regs->ARM_pc))
-			goto no_context;
-#endif
+	vma = lock_mm_and_find_vma(mm, addr, regs);
+	if (unlikely(!vma)) {
+		fault = VM_FAULT_BADMAP;
+		goto bad_area;
 	}
 
-	fault = __do_page_fault(mm, addr, flags, vm_flags, regs);
+	/*
+	 * ok, we have a good vm_area for this memory access, check the
+	 * permissions on the VMA allow for the fault which occurred.
+	 */
+	if (!(vma->vm_flags & vm_flags))
+		fault = VM_FAULT_BADACCESS;
+	else
+		fault = handle_mm_fault(vma, addr & PAGE_MASK, flags, regs);
 
 	/* If we need to retry but a fatal signal is pending, handle the
 	 * signal first. We do not need to release the mmap_lock because
@@ -356,6 +320,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	if (likely(!(fault & (VM_FAULT_ERROR | VM_FAULT_BADMAP | VM_FAULT_BADACCESS))))
 		return 0;
 
+bad_area:
 	/*
 	 * If we are in kernel mode at this point, we
 	 * have no context to handle this fault with.
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1023e896d46b..15e097206e1a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -219,6 +219,7 @@ config ARM64
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
 	select KASAN_VMALLOC if KASAN
+	select LOCK_MM_AND_FIND_VMA
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE
 	select NEED_SG_DMA_LENGTH
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index d1136259b7b8..473575a75f55 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -483,27 +483,14 @@ static void do_bad_area(unsigned long far, unsigned long esr,
 #define VM_FAULT_BADMAP		((__force vm_fault_t)0x010000)
 #define VM_FAULT_BADACCESS	((__force vm_fault_t)0x020000)
 
-static vm_fault_t __do_page_fault(struct mm_struct *mm, unsigned long addr,
+static vm_fault_t __do_page_fault(struct mm_struct *mm,
+				  struct vm_area_struct *vma, unsigned long addr,
 				  unsigned int mm_flags, unsigned long vm_flags,
 				  struct pt_regs *regs)
 {
-	struct vm_area_struct *vma = find_vma(mm, addr);
-
-	if (unlikely(!vma))
-		return VM_FAULT_BADMAP;
-
 	/*
 	 * Ok, we have a good vm_area for this memory access, so we can handle
 	 * it.
-	 */
-	if (unlikely(vma->vm_start > addr)) {
-		if (!(vma->vm_flags & VM_GROWSDOWN))
-			return VM_FAULT_BADMAP;
-		if (expand_stack(vma, addr))
-			return VM_FAULT_BADMAP;
-	}
-
-	/*
 	 * Check that the permissions on the VMA allow for the fault which
 	 * occurred.
 	 */
@@ -535,6 +522,7 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 	unsigned long vm_flags;
 	unsigned int mm_flags = FAULT_FLAG_DEFAULT;
 	unsigned long addr = untagged_addr(far);
+	struct vm_area_struct *vma;
 
 	if (kprobe_page_fault(regs, esr))
 		return 0;
@@ -585,31 +573,14 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
 
-	/*
-	 * As per x86, we may deadlock here. However, since the kernel only
-	 * validly references user space from well defined areas of the code,
-	 * we can bug out early if this is from code which shouldn't.
-	 */
-	if (!mmap_read_trylock(mm)) {
-		if (!user_mode(regs) && !search_exception_tables(regs->pc))
-			goto no_context;
 retry:
-		mmap_read_lock(mm);
-	} else {
-		/*
-		 * The above mmap_read_trylock() might have succeeded in which
-		 * case, we'll have missed the might_sleep() from down_read().
-		 */
-		might_sleep();
-#ifdef CONFIG_DEBUG_VM
-		if (!user_mode(regs) && !search_exception_tables(regs->pc)) {
-			mmap_read_unlock(mm);
-			goto no_context;
-		}
-#endif
+	vma = lock_mm_and_find_vma(mm, addr, regs);
+	if (unlikely(!vma)) {
+		fault = VM_FAULT_BADMAP;
+		goto done;
 	}
 
-	fault = __do_page_fault(mm, addr, mm_flags, vm_flags, regs);
+	fault = __do_page_fault(mm, vma, addr, mm_flags, vm_flags, regs);
 
 	/* Quick path to respond to signals */
 	if (fault_signal_pending(fault, regs)) {
@@ -628,6 +599,7 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 	}
 	mmap_read_unlock(mm);
 
+done:
 	/*
 	 * Handle the "normal" (no error) case first.
 	 */
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index dba02da6fa34..225df1674b33 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -96,6 +96,7 @@ config CSKY
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
+	select LOCK_MM_AND_FIND_VMA
 	select MAY_HAVE_SPARSE_IRQ
 	select MODULES_USE_ELF_RELA if MODULES
 	select OF
diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
index e15f736cca4b..a885518ce1dd 100644
--- a/arch/csky/mm/fault.c
+++ b/arch/csky/mm/fault.c
@@ -97,13 +97,12 @@ static inline void mm_fault_error(struct pt_regs *regs, unsigned long addr, vm_f
 	BUG();
 }
 
-static inline void bad_area(struct pt_regs *regs, struct mm_struct *mm, int code, unsigned long addr)
+static inline void bad_area_nosemaphore(struct pt_regs *regs, struct mm_struct *mm, int code, unsigned long addr)
 {
 	/*
 	 * Something tried to access memory that isn't in our memory map.
 	 * Fix it, but check if it's kernel or user first.
 	 */
-	mmap_read_unlock(mm);
 	/* User mode accesses just cause a SIGSEGV */
 	if (user_mode(regs)) {
 		do_trap(regs, SIGSEGV, code, addr);
@@ -238,20 +237,9 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	if (is_write(regs))
 		flags |= FAULT_FLAG_WRITE;
 retry:
-	mmap_read_lock(mm);
-	vma = find_vma(mm, addr);
+	vma = lock_mm_and_find_vma(mm, addr, regs);
 	if (unlikely(!vma)) {
-		bad_area(regs, mm, code, addr);
-		return;
-	}
-	if (likely(vma->vm_start <= addr))
-		goto good_area;
-	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN))) {
-		bad_area(regs, mm, code, addr);
-		return;
-	}
-	if (unlikely(expand_stack(vma, addr))) {
-		bad_area(regs, mm, code, addr);
+		bad_area_nosemaphore(regs, mm, code, addr);
 		return;
 	}
 
@@ -259,11 +247,11 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	 * Ok, we have a good vm_area for this memory access, so
 	 * we can handle it.
 	 */
-good_area:
 	code = SEGV_ACCERR;
 
 	if (unlikely(access_error(regs, vma))) {
-		bad_area(regs, mm, code, addr);
+		mmap_read_unlock(mm);
+		bad_area_nosemaphore(regs, mm, code, addr);
 		return;
 	}
 
diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 54eadf265178..6726f4941015 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -28,6 +28,7 @@ config HEXAGON
 	select GENERIC_SMP_IDLE_THREAD
 	select STACKTRACE_SUPPORT
 	select GENERIC_CLOCKEVENTS_BROADCAST
+	select LOCK_MM_AND_FIND_VMA
 	select MODULES_USE_ELF_RELA
 	select GENERIC_CPU_DEVICES
 	select ARCH_WANT_LD_ORPHAN_WARN
diff --git a/arch/hexagon/mm/vm_fault.c b/arch/hexagon/mm/vm_fault.c
index 4b578d02fd01..7295ea3f8cc8 100644
--- a/arch/hexagon/mm/vm_fault.c
+++ b/arch/hexagon/mm/vm_fault.c
@@ -57,21 +57,10 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 retry:
-	mmap_read_lock(mm);
-	vma = find_vma(mm, address);
-	if (!vma)
-		goto bad_area;
+	vma = lock_mm_and_find_vma(mm, address, regs);
+	if (unlikely(!vma))
+		goto bad_area_nosemaphore;
 
-	if (vma->vm_start <= address)
-		goto good_area;
-
-	if (!(vma->vm_flags & VM_GROWSDOWN))
-		goto bad_area;
-
-	if (expand_stack(vma, address))
-		goto bad_area;
-
-good_area:
 	/* Address space is OK.  Now check access rights. */
 	si_code = SEGV_ACCERR;
 
@@ -143,6 +132,7 @@ void do_page_fault(unsigned long address, long cause, struct pt_regs *regs)
 bad_area:
 	mmap_read_unlock(mm);
 
+bad_area_nosemaphore:
 	if (user_mode(regs)) {
 		force_sig_fault(SIGSEGV, si_code, (void __user *)address);
 		return;
diff --git a/arch/ia64/mm/fault.c b/arch/ia64/mm/fault.c
index 85c4d9ac8686..5458b52b4009 100644
--- a/arch/ia64/mm/fault.c
+++ b/arch/ia64/mm/fault.c
@@ -110,10 +110,12 @@ ia64_do_page_fault (unsigned long address, unsigned long isr, struct pt_regs *re
          * register backing store that needs to expand upwards, in
          * this case vma will be null, but prev_vma will ne non-null
          */
-        if (( !vma && prev_vma ) || (address < vma->vm_start) )
-		goto check_expansion;
+        if (( !vma && prev_vma ) || (address < vma->vm_start) ) {
+		vma = expand_stack(mm, address);
+		if (!vma)
+			goto bad_area_nosemaphore;
+	}
 
-  good_area:
 	code = SEGV_ACCERR;
 
 	/* OK, we've got a good vm_area for this memory area.  Check the access permissions: */
@@ -177,35 +179,9 @@ ia64_do_page_fault (unsigned long address, unsigned long isr, struct pt_regs *re
 	mmap_read_unlock(mm);
 	return;
 
-  check_expansion:
-	if (!(prev_vma && (prev_vma->vm_flags & VM_GROWSUP) && (address == prev_vma->vm_end))) {
-		if (!vma)
-			goto bad_area;
-		if (!(vma->vm_flags & VM_GROWSDOWN))
-			goto bad_area;
-		if (REGION_NUMBER(address) != REGION_NUMBER(vma->vm_start)
-		    || REGION_OFFSET(address) >= RGN_MAP_LIMIT)
-			goto bad_area;
-		if (expand_stack(vma, address))
-			goto bad_area;
-	} else {
-		vma = prev_vma;
-		if (REGION_NUMBER(address) != REGION_NUMBER(vma->vm_start)
-		    || REGION_OFFSET(address) >= RGN_MAP_LIMIT)
-			goto bad_area;
-		/*
-		 * Since the register backing store is accessed sequentially,
-		 * we disallow growing it by more than a page at a time.
-		 */
-		if (address > vma->vm_end + PAGE_SIZE - sizeof(long))
-			goto bad_area;
-		if (expand_upwards(vma, address))
-			goto bad_area;
-	}
-	goto good_area;
-
   bad_area:
 	mmap_read_unlock(mm);
+  bad_area_nosemaphore:
 	if ((isr & IA64_ISR_SP)
 	    || ((isr & IA64_ISR_NA) && (isr & IA64_ISR_CODE_MASK) == IA64_ISR_CODE_LFETCH))
 	{
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 3e5d6acbf240..085d87d7e91d 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -125,6 +125,7 @@ config LOONGARCH
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN if !SMP
 	select IRQ_FORCED_THREADING
 	select IRQ_LOONGARCH_CPU
+	select LOCK_MM_AND_FIND_VMA
 	select MMU_GATHER_MERGE_VMAS if MMU
 	select MODULES_USE_ELF_RELA if MODULES
 	select NEED_PER_CPU_EMBED_FIRST_CHUNK
diff --git a/arch/loongarch/mm/fault.c b/arch/loongarch/mm/fault.c
index 449087bd589d..da5b6d518cdb 100644
--- a/arch/loongarch/mm/fault.c
+++ b/arch/loongarch/mm/fault.c
@@ -169,22 +169,18 @@ static void __kprobes __do_page_fault(struct pt_regs *regs,
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 retry:
-	mmap_read_lock(mm);
-	vma = find_vma(mm, address);
-	if (!vma)
-		goto bad_area;
-	if (vma->vm_start <= address)
-		goto good_area;
-	if (!(vma->vm_flags & VM_GROWSDOWN))
-		goto bad_area;
-	if (!expand_stack(vma, address))
-		goto good_area;
+	vma = lock_mm_and_find_vma(mm, address, regs);
+	if (unlikely(!vma))
+		goto bad_area_nosemaphore;
+	goto good_area;
+
 /*
  * Something tried to access memory that isn't in our memory map..
  * Fix it, but check if it's kernel or user first..
  */
 bad_area:
 	mmap_read_unlock(mm);
+bad_area_nosemaphore:
 	do_sigsegv(regs, write, address, si_code);
 	return;
 
diff --git a/arch/m68k/mm/fault.c b/arch/m68k/mm/fault.c
index 228128e45c67..c290c5c0cfb9 100644
--- a/arch/m68k/mm/fault.c
+++ b/arch/m68k/mm/fault.c
@@ -105,8 +105,9 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 		if (address + 256 < rdusp())
 			goto map_err;
 	}
-	if (expand_stack(vma, address))
-		goto map_err;
+	vma = expand_stack(mm, address);
+	if (!vma)
+		goto map_err_nosemaphore;
 
 /*
  * Ok, we have a good vm_area for this memory access, so
@@ -196,10 +197,12 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 	goto send_sig;
 
 map_err:
+	mmap_read_unlock(mm);
+map_err_nosemaphore:
 	current->thread.signo = SIGSEGV;
 	current->thread.code = SEGV_MAPERR;
 	current->thread.faddr = address;
-	goto send_sig;
+	return send_fault_sig(regs);
 
 acc_err:
 	current->thread.signo = SIGSEGV;
diff --git a/arch/microblaze/mm/fault.c b/arch/microblaze/mm/fault.c
index 687714db6f4d..d3c3c33b73a6 100644
--- a/arch/microblaze/mm/fault.c
+++ b/arch/microblaze/mm/fault.c
@@ -192,8 +192,9 @@ void do_page_fault(struct pt_regs *regs, unsigned long address,
 			&& (kernel_mode(regs) || !store_updates_sp(regs)))
 				goto bad_area;
 	}
-	if (expand_stack(vma, address))
-		goto bad_area;
+	vma = expand_stack(mm, address);
+	if (!vma)
+		goto bad_area_nosemaphore;
 
 good_area:
 	code = SEGV_ACCERR;
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 5b3f1f1dfd16..2cc139f10c1d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -94,6 +94,7 @@ config MIPS
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN if 64BIT || !SMP
 	select IRQ_FORCED_THREADING
 	select ISA if EISA
+	select LOCK_MM_AND_FIND_VMA
 	select MODULES_USE_ELF_REL if MODULES
 	select MODULES_USE_ELF_RELA if MODULES && 64BIT
 	select PERF_USE_VMALLOC
diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index a27045f5a556..d7878208bd3f 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -99,21 +99,13 @@ static void __do_page_fault(struct pt_regs *regs, unsigned long write,
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 retry:
-	mmap_read_lock(mm);
-	vma = find_vma(mm, address);
+	vma = lock_mm_and_find_vma(mm, address, regs);
 	if (!vma)
-		goto bad_area;
-	if (vma->vm_start <= address)
-		goto good_area;
-	if (!(vma->vm_flags & VM_GROWSDOWN))
-		goto bad_area;
-	if (expand_stack(vma, address))
-		goto bad_area;
+		goto bad_area_nosemaphore;
 /*
  * Ok, we have a good vm_area for this memory access, so
  * we can handle it..
  */
-good_area:
 	si_code = SEGV_ACCERR;
 
 	if (write) {
diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index a582f72104f3..1fb78865a459 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -16,6 +16,7 @@ config NIOS2
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_KGDB
 	select IRQ_DOMAIN
+	select LOCK_MM_AND_FIND_VMA
 	select MODULES_USE_ELF_RELA
 	select OF
 	select OF_EARLY_FLATTREE
diff --git a/arch/nios2/mm/fault.c b/arch/nios2/mm/fault.c
index ca64eccea551..e3fa9c15181d 100644
--- a/arch/nios2/mm/fault.c
+++ b/arch/nios2/mm/fault.c
@@ -86,27 +86,14 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long cause,
 
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 
-	if (!mmap_read_trylock(mm)) {
-		if (!user_mode(regs) && !search_exception_tables(regs->ea))
-			goto bad_area_nosemaphore;
 retry:
-		mmap_read_lock(mm);
-	}
-
-	vma = find_vma(mm, address);
+	vma = lock_mm_and_find_vma(mm, address, regs);
 	if (!vma)
-		goto bad_area;
-	if (vma->vm_start <= address)
-		goto good_area;
-	if (!(vma->vm_flags & VM_GROWSDOWN))
-		goto bad_area;
-	if (expand_stack(vma, address))
-		goto bad_area;
+		goto bad_area_nosemaphore;
 /*
  * Ok, we have a good vm_area for this memory access, so
  * we can handle it..
  */
-good_area:
 	code = SEGV_ACCERR;
 
 	switch (cause) {
diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c
index 6734fee3134f..a9dcd4381d1a 100644
--- a/arch/openrisc/mm/fault.c
+++ b/arch/openrisc/mm/fault.c
@@ -127,8 +127,9 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 		if (address + PAGE_SIZE < regs->sp)
 			goto bad_area;
 	}
-	if (expand_stack(vma, address))
-		goto bad_area;
+	vma = expand_stack(mm, address);
+	if (!vma)
+		goto bad_area_nosemaphore;
 
 	/*
 	 * Ok, we have a good vm_area for this memory access, so
diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
index 6941fdbf2517..a4c7c7630f48 100644
--- a/arch/parisc/mm/fault.c
+++ b/arch/parisc/mm/fault.c
@@ -288,15 +288,19 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
 retry:
 	mmap_read_lock(mm);
 	vma = find_vma_prev(mm, address, &prev_vma);
-	if (!vma || address < vma->vm_start)
-		goto check_expansion;
+	if (!vma || address < vma->vm_start) {
+		if (!prev_vma || !(prev_vma->vm_flags & VM_GROWSUP))
+			goto bad_area;
+		vma = expand_stack(mm, address);
+		if (!vma)
+			goto bad_area_nosemaphore;
+	}
+
 /*
  * Ok, we have a good vm_area for this memory access. We still need to
  * check the access permissions.
  */
 
-good_area:
-
 	if ((vma->vm_flags & acc_type) != acc_type)
 		goto bad_area;
 
@@ -347,17 +351,13 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
 	mmap_read_unlock(mm);
 	return;
 
-check_expansion:
-	vma = prev_vma;
-	if (vma && (expand_stack(vma, address) == 0))
-		goto good_area;
-
 /*
  * Something tried to access memory that isn't in our memory map..
  */
 bad_area:
 	mmap_read_unlock(mm);
 
+bad_area_nosemaphore:
 	if (user_mode(regs)) {
 		int signo, si_code;
 
@@ -449,7 +449,7 @@ handle_nadtlb_fault(struct pt_regs *regs)
 {
 	unsigned long insn = regs->iir;
 	int breg, treg, xreg, val = 0;
-	struct vm_area_struct *vma, *prev_vma;
+	struct vm_area_struct *vma;
 	struct task_struct *tsk;
 	struct mm_struct *mm;
 	unsigned long address;
@@ -485,7 +485,7 @@ handle_nadtlb_fault(struct pt_regs *regs)
 				/* Search for VMA */
 				address = regs->ior;
 				mmap_read_lock(mm);
-				vma = find_vma_prev(mm, address, &prev_vma);
+				vma = vma_lookup(mm, address);
 				mmap_read_unlock(mm);
 
 				/*
@@ -494,7 +494,6 @@ handle_nadtlb_fault(struct pt_regs *regs)
 				 */
 				acc_type = (insn & 0x40) ? VM_WRITE : VM_READ;
 				if (vma
-				    && address >= vma->vm_start
 				    && (vma->vm_flags & acc_type) == acc_type)
 					val = 1;
 			}
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a6c4407d3ec8..4ab9b44e6c1c 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -263,6 +263,7 @@ config PPC
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
 	select KASAN_VMALLOC			if KASAN && MODULES
+	select LOCK_MM_AND_FIND_VMA
 	select MMU_GATHER_PAGE_SIZE
 	select MMU_GATHER_RCU_TABLE_FREE
 	select MMU_GATHER_MERGE_VMAS
diff --git a/arch/powerpc/mm/copro_fault.c b/arch/powerpc/mm/copro_fault.c
index 7c507fb48182..f49fd873df8d 100644
--- a/arch/powerpc/mm/copro_fault.c
+++ b/arch/powerpc/mm/copro_fault.c
@@ -33,19 +33,11 @@ int copro_handle_mm_fault(struct mm_struct *mm, unsigned long ea,
 	if (mm->pgd == NULL)
 		return -EFAULT;
 
-	mmap_read_lock(mm);
-	ret = -EFAULT;
-	vma = find_vma(mm, ea);
+	vma = lock_mm_and_find_vma(mm, ea, NULL);
 	if (!vma)
-		goto out_unlock;
-
-	if (ea < vma->vm_start) {
-		if (!(vma->vm_flags & VM_GROWSDOWN))
-			goto out_unlock;
-		if (expand_stack(vma, ea))
-			goto out_unlock;
-	}
+		return -EFAULT;
 
+	ret = -EFAULT;
 	is_write = dsisr & DSISR_ISSTORE;
 	if (is_write) {
 		if (!(vma->vm_flags & VM_WRITE))
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index af46aa88422b..644e4ec6ce99 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -84,11 +84,6 @@ static int __bad_area(struct pt_regs *regs, unsigned long address, int si_code)
 	return __bad_area_nosemaphore(regs, address, si_code);
 }
 
-static noinline int bad_area(struct pt_regs *regs, unsigned long address)
-{
-	return __bad_area(regs, address, SEGV_MAPERR);
-}
-
 static noinline int bad_access_pkey(struct pt_regs *regs, unsigned long address,
 				    struct vm_area_struct *vma)
 {
@@ -481,40 +476,12 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * we will deadlock attempting to validate the fault against the
 	 * address space.  Luckily the kernel only validly references user
 	 * space from well defined areas of code, which are listed in the
-	 * exceptions table.
-	 *
-	 * As the vast majority of faults will be valid we will only perform
-	 * the source reference check when there is a possibility of a deadlock.
-	 * Attempt to lock the address space, if we cannot we then validate the
-	 * source.  If this is invalid we can skip the address space check,
-	 * thus avoiding the deadlock.
+	 * exceptions table. lock_mm_and_find_vma() handles that logic.
 	 */
-	if (unlikely(!mmap_read_trylock(mm))) {
-		if (!is_user && !search_exception_tables(regs->nip))
-			return bad_area_nosemaphore(regs, address);
-
 retry:
-		mmap_read_lock(mm);
-	} else {
-		/*
-		 * The above down_read_trylock() might have succeeded in
-		 * which case we'll have missed the might_sleep() from
-		 * down_read():
-		 */
-		might_sleep();
-	}
-
-	vma = find_vma(mm, address);
+	vma = lock_mm_and_find_vma(mm, address, regs);
 	if (unlikely(!vma))
-		return bad_area(regs, address);
-
-	if (unlikely(vma->vm_start > address)) {
-		if (unlikely(!(vma->vm_flags & VM_GROWSDOWN)))
-			return bad_area(regs, address);
-
-		if (unlikely(expand_stack(vma, address)))
-			return bad_area(regs, address);
-	}
+		return bad_area_nosemaphore(regs, address);
 
 	if (unlikely(access_pkey_error(is_write, is_exec,
 				       (error_code & DSISR_KEYFAULT), vma)))
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index b462ed7d41fe..73671af406dc 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -119,6 +119,7 @@ config RISCV
 	select HAVE_SYSCALL_TRACEPOINTS
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
+	select LOCK_MM_AND_FIND_VMA
 	select MODULES_USE_ELF_RELA if MODULES
 	select MODULE_SECTIONS if MODULES
 	select OF
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index d5f3e501dffb..89226458eab8 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -83,13 +83,13 @@ static inline void mm_fault_error(struct pt_regs *regs, unsigned long addr, vm_f
 	BUG();
 }
 
-static inline void bad_area(struct pt_regs *regs, struct mm_struct *mm, int code, unsigned long addr)
+static inline void
+bad_area_nosemaphore(struct pt_regs *regs, int code, unsigned long addr)
 {
 	/*
 	 * Something tried to access memory that isn't in our memory map.
 	 * Fix it, but check if it's kernel or user first.
 	 */
-	mmap_read_unlock(mm);
 	/* User mode accesses just cause a SIGSEGV */
 	if (user_mode(regs)) {
 		do_trap(regs, SIGSEGV, code, addr);
@@ -99,6 +99,15 @@ static inline void bad_area(struct pt_regs *regs, struct mm_struct *mm, int code
 	no_context(regs, addr);
 }
 
+static inline void
+bad_area(struct pt_regs *regs, struct mm_struct *mm, int code,
+	 unsigned long addr)
+{
+	mmap_read_unlock(mm);
+
+	bad_area_nosemaphore(regs, code, addr);
+}
+
 static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long addr)
 {
 	pgd_t *pgd, *pgd_k;
@@ -286,23 +295,10 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	else if (cause == EXC_INST_PAGE_FAULT)
 		flags |= FAULT_FLAG_INSTRUCTION;
 retry:
-	mmap_read_lock(mm);
-	vma = find_vma(mm, addr);
+	vma = lock_mm_and_find_vma(mm, addr, regs);
 	if (unlikely(!vma)) {
 		tsk->thread.bad_cause = cause;
-		bad_area(regs, mm, code, addr);
-		return;
-	}
-	if (likely(vma->vm_start <= addr))
-		goto good_area;
-	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN))) {
-		tsk->thread.bad_cause = cause;
-		bad_area(regs, mm, code, addr);
-		return;
-	}
-	if (unlikely(expand_stack(vma, addr))) {
-		tsk->thread.bad_cause = cause;
-		bad_area(regs, mm, code, addr);
+		bad_area_nosemaphore(regs, code, addr);
 		return;
 	}
 
@@ -310,7 +306,6 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	 * Ok, we have a good vm_area for this memory access, so
 	 * we can handle it.
 	 */
-good_area:
 	code = SEGV_ACCERR;
 
 	if (unlikely(access_error(cause, vma))) {
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index a2632fd97d00..94e3970c4839 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -433,8 +433,9 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 	if (unlikely(vma->vm_start > address)) {
 		if (!(vma->vm_flags & VM_GROWSDOWN))
 			goto out_up;
-		if (expand_stack(vma, address))
-			goto out_up;
+		vma = expand_stack(mm, address);
+		if (!vma)
+			goto out;
 	}
 
 	/*
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 0665ac0add0b..101a0d094a66 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -56,6 +56,7 @@ config SUPERH
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select IRQ_FORCED_THREADING
+	select LOCK_MM_AND_FIND_VMA
 	select MODULES_USE_ELF_RELA
 	select NEED_SG_DMA_LENGTH
 	select NO_DMA if !MMU && !DMA_COHERENT
diff --git a/arch/sh/mm/fault.c b/arch/sh/mm/fault.c
index acd2f5e50bfc..06e6b4952924 100644
--- a/arch/sh/mm/fault.c
+++ b/arch/sh/mm/fault.c
@@ -439,21 +439,9 @@ asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
 	}
 
 retry:
-	mmap_read_lock(mm);
-
-	vma = find_vma(mm, address);
+	vma = lock_mm_and_find_vma(mm, address, regs);
 	if (unlikely(!vma)) {
-		bad_area(regs, error_code, address);
-		return;
-	}
-	if (likely(vma->vm_start <= address))
-		goto good_area;
-	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN))) {
-		bad_area(regs, error_code, address);
-		return;
-	}
-	if (unlikely(expand_stack(vma, address))) {
-		bad_area(regs, error_code, address);
+		bad_area_nosemaphore(regs, error_code, address);
 		return;
 	}
 
@@ -461,7 +449,6 @@ asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
 	 * Ok, we have a good vm_area for this memory access, so
 	 * we can handle it..
 	 */
-good_area:
 	if (unlikely(access_error(error_code, vma))) {
 		bad_area_access_error(regs, error_code, address);
 		return;
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 84437a4c6545..dbb1760cbe8c 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -56,6 +56,7 @@ config SPARC32
 	select DMA_DIRECT_REMAP
 	select GENERIC_ATOMIC64
 	select HAVE_UID16
+	select LOCK_MM_AND_FIND_VMA
 	select OLD_SIGACTION
 	select ZONE_DMA
 
diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index 179295b14664..86a831ebd8c8 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -143,28 +143,19 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
 	if (pagefault_disabled() || !mm)
 		goto no_context;
 
+	if (!from_user && address >= PAGE_OFFSET)
+		goto no_context;
+
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 
 retry:
-	mmap_read_lock(mm);
-
-	if (!from_user && address >= PAGE_OFFSET)
-		goto bad_area;
-
-	vma = find_vma(mm, address);
+	vma = lock_mm_and_find_vma(mm, address, regs);
 	if (!vma)
-		goto bad_area;
-	if (vma->vm_start <= address)
-		goto good_area;
-	if (!(vma->vm_flags & VM_GROWSDOWN))
-		goto bad_area;
-	if (expand_stack(vma, address))
-		goto bad_area;
+		goto bad_area_nosemaphore;
 	/*
 	 * Ok, we have a good vm_area for this memory access, so
 	 * we can handle it..
 	 */
-good_area:
 	code = SEGV_ACCERR;
 	if (write) {
 		if (!(vma->vm_flags & VM_WRITE))
@@ -321,17 +312,9 @@ static void force_user_fault(unsigned long address, int write)
 
 	code = SEGV_MAPERR;
 
-	mmap_read_lock(mm);
-	vma = find_vma(mm, address);
+	vma = lock_mm_and_find_vma(mm, address, NULL);
 	if (!vma)
-		goto bad_area;
-	if (vma->vm_start <= address)
-		goto good_area;
-	if (!(vma->vm_flags & VM_GROWSDOWN))
-		goto bad_area;
-	if (expand_stack(vma, address))
-		goto bad_area;
-good_area:
+		goto bad_area_nosemaphore;
 	code = SEGV_ACCERR;
 	if (write) {
 		if (!(vma->vm_flags & VM_WRITE))
@@ -350,6 +333,7 @@ static void force_user_fault(unsigned long address, int write)
 	return;
 bad_area:
 	mmap_read_unlock(mm);
+bad_area_nosemaphore:
 	__do_fault_siginfo(code, SIGSEGV, tsk->thread.kregs, address);
 	return;
 
diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
index d91305de694c..69ff07bc6c07 100644
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -383,8 +383,9 @@ asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
 				goto bad_area;
 		}
 	}
-	if (expand_stack(vma, address))
-		goto bad_area;
+	vma = expand_stack(mm, address);
+	if (!vma)
+		goto bad_area_nosemaphore;
 	/*
 	 * Ok, we have a good vm_area for this memory access, so
 	 * we can handle it..
@@ -487,8 +488,9 @@ asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
 	 * Fix it, but check if it's kernel or user first..
 	 */
 bad_area:
-	insn = get_fault_insn(regs, insn);
 	mmap_read_unlock(mm);
+bad_area_nosemaphore:
+	insn = get_fault_insn(regs, insn);
 
 handle_kernel_fault:
 	do_kernel_fault(regs, si_code, fault_code, insn, address);
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index d3ce21c4ca32..6d8ae86ae978 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -47,14 +47,15 @@ int handle_page_fault(unsigned long address, unsigned long ip,
 	vma = find_vma(mm, address);
 	if (!vma)
 		goto out;
-	else if (vma->vm_start <= address)
+	if (vma->vm_start <= address)
 		goto good_area;
-	else if (!(vma->vm_flags & VM_GROWSDOWN))
+	if (!(vma->vm_flags & VM_GROWSDOWN))
 		goto out;
-	else if (is_user && !ARCH_IS_STACKGROW(address))
-		goto out;
-	else if (expand_stack(vma, address))
+	if (is_user && !ARCH_IS_STACKGROW(address))
 		goto out;
+	vma = expand_stack(mm, address);
+	if (!vma)
+		goto out_nosemaphore;
 
 good_area:
 	*code_out = SEGV_ACCERR;
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a825bf031f49..8e6db5262614 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -274,6 +274,7 @@ config X86
 	select HAVE_GENERIC_VDSO
 	select HOTPLUG_SMT			if SMP
 	select IRQ_FORCED_THREADING
+	select LOCK_MM_AND_FIND_VMA
 	select NEED_PER_CPU_EMBED_FIRST_CHUNK
 	select NEED_PER_CPU_PAGE_FIRST_CHUNK
 	select NEED_SG_DMA_LENGTH
diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 78796b98a544..9ba3c3dec6f3 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -98,4 +98,6 @@ extern u64 x86_read_arch_cap_msr(void);
 int intel_find_matching_signature(void *mc, unsigned int csig, int cpf);
 int intel_microcode_sanity_check(void *mc, bool print_err, int hdr_type);
 
+extern struct cpumask cpus_stop_mask;
+
 #endif /* _ASM_X86_CPU_H */
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index b4dbb20dab1a..4e8e64541395 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -131,6 +131,8 @@ void wbinvd_on_cpu(int cpu);
 int wbinvd_on_all_cpus(void);
 void cond_wakeup_cpu0(void);
 
+void smp_kick_mwait_play_dead(void);
+
 void native_smp_send_reschedule(int cpu);
 void native_send_call_func_ipi(const struct cpumask *mask);
 void native_send_call_func_single_ipi(int cpu);
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 9eb457b10341..cedecba55163 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -705,7 +705,7 @@ static enum ucode_state apply_microcode_amd(int cpu)
 	rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
 
 	/* need to apply patch? */
-	if (rev >= mc_amd->hdr.patch_id) {
+	if (rev > mc_amd->hdr.patch_id) {
 		ret = UCODE_OK;
 		goto out;
 	}
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index b650cde3f64d..2fed8aafb521 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -752,15 +752,26 @@ bool xen_set_default_idle(void)
 }
 #endif
 
+struct cpumask cpus_stop_mask;
+
 void __noreturn stop_this_cpu(void *dummy)
 {
+	struct cpuinfo_x86 *c = this_cpu_ptr(&cpu_info);
+	unsigned int cpu = smp_processor_id();
+
 	local_irq_disable();
+
 	/*
-	 * Remove this CPU:
+	 * Remove this CPU from the online mask and disable it
+	 * unconditionally. This might be redundant in case that the reboot
+	 * vector was handled late and stop_other_cpus() sent an NMI.
+	 *
+	 * According to SDM and APM NMIs can be accepted even after soft
+	 * disabling the local APIC.
 	 */
-	set_cpu_online(smp_processor_id(), false);
+	set_cpu_online(cpu, false);
 	disable_local_APIC();
-	mcheck_cpu_clear(this_cpu_ptr(&cpu_info));
+	mcheck_cpu_clear(c);
 
 	/*
 	 * Use wbinvd on processors that support SME. This provides support
@@ -774,8 +785,17 @@ void __noreturn stop_this_cpu(void *dummy)
 	 * Test the CPUID bit directly because the machine might've cleared
 	 * X86_FEATURE_SME due to cmdline options.
 	 */
-	if (cpuid_eax(0x8000001f) & BIT(0))
+	if (c->extended_cpuid_level >= 0x8000001f && (cpuid_eax(0x8000001f) & BIT(0)))
 		native_wbinvd();
+
+	/*
+	 * This brings a cache line back and dirties it, but
+	 * native_stop_other_cpus() will overwrite cpus_stop_mask after it
+	 * observed that all CPUs reported stop. This write will invalidate
+	 * the related cache line on this CPU.
+	 */
+	cpumask_clear_cpu(cpu, &cpus_stop_mask);
+
 	for (;;) {
 		/*
 		 * Use native_halt() so that memory contents don't change
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 375b33ecafa2..174d6232b87f 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -21,12 +21,14 @@
 #include <linux/interrupt.h>
 #include <linux/cpu.h>
 #include <linux/gfp.h>
+#include <linux/kexec.h>
 
 #include <asm/mtrr.h>
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
 #include <asm/proto.h>
 #include <asm/apic.h>
+#include <asm/cpu.h>
 #include <asm/idtentry.h>
 #include <asm/nmi.h>
 #include <asm/mce.h>
@@ -146,34 +148,47 @@ static int register_stop_handler(void)
 
 static void native_stop_other_cpus(int wait)
 {
-	unsigned long flags;
-	unsigned long timeout;
+	unsigned int cpu = smp_processor_id();
+	unsigned long flags, timeout;
 
 	if (reboot_force)
 		return;
 
-	/*
-	 * Use an own vector here because smp_call_function
-	 * does lots of things not suitable in a panic situation.
-	 */
+	/* Only proceed if this is the first CPU to reach this code */
+	if (atomic_cmpxchg(&stopping_cpu, -1, cpu) != -1)
+		return;
+
+	/* For kexec, ensure that offline CPUs are out of MWAIT and in HLT */
+	if (kexec_in_progress)
+		smp_kick_mwait_play_dead();
 
 	/*
-	 * We start by using the REBOOT_VECTOR irq.
-	 * The irq is treated as a sync point to allow critical
-	 * regions of code on other cpus to release their spin locks
-	 * and re-enable irqs.  Jumping straight to an NMI might
-	 * accidentally cause deadlocks with further shutdown/panic
-	 * code.  By syncing, we give the cpus up to one second to
-	 * finish their work before we force them off with the NMI.
+	 * 1) Send an IPI on the reboot vector to all other CPUs.
+	 *
+	 *    The other CPUs should react on it after leaving critical
+	 *    sections and re-enabling interrupts. They might still hold
+	 *    locks, but there is nothing which can be done about that.
+	 *
+	 * 2) Wait for all other CPUs to report that they reached the
+	 *    HLT loop in stop_this_cpu()
+	 *
+	 * 3) If #2 timed out send an NMI to the CPUs which did not
+	 *    yet report
+	 *
+	 * 4) Wait for all other CPUs to report that they reached the
+	 *    HLT loop in stop_this_cpu()
+	 *
+	 * #3 can obviously race against a CPU reaching the HLT loop late.
+	 * That CPU will have reported already and the "have all CPUs
+	 * reached HLT" condition will be true despite the fact that the
+	 * other CPU is still handling the NMI. Again, there is no
+	 * protection against that as "disabled" APICs still respond to
+	 * NMIs.
 	 */
-	if (num_online_cpus() > 1) {
-		/* did someone beat us here? */
-		if (atomic_cmpxchg(&stopping_cpu, -1, safe_smp_processor_id()) != -1)
-			return;
-
-		/* sync above data before sending IRQ */
-		wmb();
+	cpumask_copy(&cpus_stop_mask, cpu_online_mask);
+	cpumask_clear_cpu(cpu, &cpus_stop_mask);
 
+	if (!cpumask_empty(&cpus_stop_mask)) {
 		apic_send_IPI_allbutself(REBOOT_VECTOR);
 
 		/*
@@ -183,24 +198,22 @@ static void native_stop_other_cpus(int wait)
 		 * CPUs reach shutdown state.
 		 */
 		timeout = USEC_PER_SEC;
-		while (num_online_cpus() > 1 && timeout--)
+		while (!cpumask_empty(&cpus_stop_mask) && timeout--)
 			udelay(1);
 	}
 
 	/* if the REBOOT_VECTOR didn't work, try with the NMI */
-	if (num_online_cpus() > 1) {
+	if (!cpumask_empty(&cpus_stop_mask)) {
 		/*
 		 * If NMI IPI is enabled, try to register the stop handler
 		 * and send the IPI. In any case try to wait for the other
 		 * CPUs to stop.
 		 */
 		if (!smp_no_nmi_ipi && !register_stop_handler()) {
-			/* Sync above data before sending IRQ */
-			wmb();
-
 			pr_emerg("Shutting down cpus with NMI\n");
 
-			apic_send_IPI_allbutself(NMI_VECTOR);
+			for_each_cpu(cpu, &cpus_stop_mask)
+				apic->send_IPI(cpu, NMI_VECTOR);
 		}
 		/*
 		 * Don't wait longer than 10 ms if the caller didn't
@@ -208,7 +221,7 @@ static void native_stop_other_cpus(int wait)
 		 * one or more CPUs do not reach shutdown state.
 		 */
 		timeout = USEC_PER_MSEC * 10;
-		while (num_online_cpus() > 1 && (wait || timeout--))
+		while (!cpumask_empty(&cpus_stop_mask) && (wait || timeout--))
 			udelay(1);
 	}
 
@@ -216,6 +229,12 @@ static void native_stop_other_cpus(int wait)
 	disable_local_APIC();
 	mcheck_cpu_clear(this_cpu_ptr(&cpu_info));
 	local_irq_restore(flags);
+
+	/*
+	 * Ensure that the cpus_stop_mask cache lines are invalidated on
+	 * the other CPUs. See comment vs. SME in stop_this_cpu().
+	 */
+	cpumask_clear(&cpus_stop_mask);
 }
 
 /*
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 9013bb28255a..144c6f2c4230 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -53,6 +53,7 @@
 #include <linux/tboot.h>
 #include <linux/gfp.h>
 #include <linux/cpuidle.h>
+#include <linux/kexec.h>
 #include <linux/numa.h>
 #include <linux/pgtable.h>
 #include <linux/overflow.h>
@@ -101,6 +102,20 @@ EXPORT_PER_CPU_SYMBOL(cpu_die_map);
 DEFINE_PER_CPU_READ_MOSTLY(struct cpuinfo_x86, cpu_info);
 EXPORT_PER_CPU_SYMBOL(cpu_info);
 
+struct mwait_cpu_dead {
+	unsigned int	control;
+	unsigned int	status;
+};
+
+#define CPUDEAD_MWAIT_WAIT	0xDEADBEEF
+#define CPUDEAD_MWAIT_KEXEC_HLT	0x4A17DEAD
+
+/*
+ * Cache line aligned data for mwait_play_dead(). Separate on purpose so
+ * that it's unlikely to be touched by other CPUs.
+ */
+static DEFINE_PER_CPU_ALIGNED(struct mwait_cpu_dead, mwait_cpu_dead);
+
 /* Logical package management. We might want to allocate that dynamically */
 unsigned int __max_logical_packages __read_mostly;
 EXPORT_SYMBOL(__max_logical_packages);
@@ -157,6 +172,10 @@ static void smp_callin(void)
 {
 	int cpuid;
 
+	/* Mop up eventual mwait_play_dead() wreckage */
+	this_cpu_write(mwait_cpu_dead.status, 0);
+	this_cpu_write(mwait_cpu_dead.control, 0);
+
 	/*
 	 * If waken up by an INIT in an 82489DX configuration
 	 * cpu_callout_mask guarantees we don't get here before
@@ -1750,10 +1769,10 @@ EXPORT_SYMBOL_GPL(cond_wakeup_cpu0);
  */
 static inline void mwait_play_dead(void)
 {
+	struct mwait_cpu_dead *md = this_cpu_ptr(&mwait_cpu_dead);
 	unsigned int eax, ebx, ecx, edx;
 	unsigned int highest_cstate = 0;
 	unsigned int highest_subcstate = 0;
-	void *mwait_ptr;
 	int i;
 
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
@@ -1788,12 +1807,9 @@ static inline void mwait_play_dead(void)
 			(highest_subcstate - 1);
 	}
 
-	/*
-	 * This should be a memory location in a cache line which is
-	 * unlikely to be touched by other processors.  The actual
-	 * content is immaterial as it is not actually modified in any way.
-	 */
-	mwait_ptr = &current_thread_info()->flags;
+	/* Set up state for the kexec() hack below */
+	md->status = CPUDEAD_MWAIT_WAIT;
+	md->control = CPUDEAD_MWAIT_WAIT;
 
 	wbinvd();
 
@@ -1806,16 +1822,63 @@ static inline void mwait_play_dead(void)
 		 * case where we return around the loop.
 		 */
 		mb();
-		clflush(mwait_ptr);
+		clflush(md);
 		mb();
-		__monitor(mwait_ptr, 0, 0);
+		__monitor(md, 0, 0);
 		mb();
 		__mwait(eax, 0);
 
+		if (READ_ONCE(md->control) == CPUDEAD_MWAIT_KEXEC_HLT) {
+			/*
+			 * Kexec is about to happen. Don't go back into mwait() as
+			 * the kexec kernel might overwrite text and data including
+			 * page tables and stack. So mwait() would resume when the
+			 * monitor cache line is written to and then the CPU goes
+			 * south due to overwritten text, page tables and stack.
+			 *
+			 * Note: This does _NOT_ protect against a stray MCE, NMI,
+			 * SMI. They will resume execution at the instruction
+			 * following the HLT instruction and run into the problem
+			 * which this is trying to prevent.
+			 */
+			WRITE_ONCE(md->status, CPUDEAD_MWAIT_KEXEC_HLT);
+			while(1)
+				native_halt();
+		}
+
 		cond_wakeup_cpu0();
 	}
 }
 
+/*
+ * Kick all "offline" CPUs out of mwait on kexec(). See comment in
+ * mwait_play_dead().
+ */
+void smp_kick_mwait_play_dead(void)
+{
+	u32 newstate = CPUDEAD_MWAIT_KEXEC_HLT;
+	struct mwait_cpu_dead *md;
+	unsigned int cpu, i;
+
+	for_each_cpu_andnot(cpu, cpu_present_mask, cpu_online_mask) {
+		md = per_cpu_ptr(&mwait_cpu_dead, cpu);
+
+		/* Does it sit in mwait_play_dead() ? */
+		if (READ_ONCE(md->status) != CPUDEAD_MWAIT_WAIT)
+			continue;
+
+		/* Wait up to 5ms */
+		for (i = 0; READ_ONCE(md->status) != newstate && i < 1000; i++) {
+			/* Bring it out of mwait */
+			WRITE_ONCE(md->control, newstate);
+			udelay(5);
+		}
+
+		if (READ_ONCE(md->status) != newstate)
+			pr_err_once("CPU%u is stuck in mwait_play_dead()\n", cpu);
+	}
+}
+
 void hlt_play_dead(void)
 {
 	if (__this_cpu_read(cpu_info.x86) >= 4)
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index a498ae1fbe66..67954abb9fdc 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -879,12 +879,6 @@ __bad_area(struct pt_regs *regs, unsigned long error_code,
 	__bad_area_nosemaphore(regs, error_code, address, pkey, si_code);
 }
 
-static noinline void
-bad_area(struct pt_regs *regs, unsigned long error_code, unsigned long address)
-{
-	__bad_area(regs, error_code, address, 0, SEGV_MAPERR);
-}
-
 static inline bool bad_area_access_from_pkeys(unsigned long error_code,
 		struct vm_area_struct *vma)
 {
@@ -1333,51 +1327,10 @@ void do_user_addr_fault(struct pt_regs *regs,
 	}
 #endif
 
-	/*
-	 * Kernel-mode access to the user address space should only occur
-	 * on well-defined single instructions listed in the exception
-	 * tables.  But, an erroneous kernel fault occurring outside one of
-	 * those areas which also holds mmap_lock might deadlock attempting
-	 * to validate the fault against the address space.
-	 *
-	 * Only do the expensive exception table search when we might be at
-	 * risk of a deadlock.  This happens if we
-	 * 1. Failed to acquire mmap_lock, and
-	 * 2. The access did not originate in userspace.
-	 */
-	if (unlikely(!mmap_read_trylock(mm))) {
-		if (!user_mode(regs) && !search_exception_tables(regs->ip)) {
-			/*
-			 * Fault from code in kernel from
-			 * which we do not expect faults.
-			 */
-			bad_area_nosemaphore(regs, error_code, address);
-			return;
-		}
 retry:
-		mmap_read_lock(mm);
-	} else {
-		/*
-		 * The above down_read_trylock() might have succeeded in
-		 * which case we'll have missed the might_sleep() from
-		 * down_read():
-		 */
-		might_sleep();
-	}
-
-	vma = find_vma(mm, address);
+	vma = lock_mm_and_find_vma(mm, address, regs);
 	if (unlikely(!vma)) {
-		bad_area(regs, error_code, address);
-		return;
-	}
-	if (likely(vma->vm_start <= address))
-		goto good_area;
-	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN))) {
-		bad_area(regs, error_code, address);
-		return;
-	}
-	if (unlikely(expand_stack(vma, address))) {
-		bad_area(regs, error_code, address);
+		bad_area_nosemaphore(regs, error_code, address);
 		return;
 	}
 
@@ -1385,7 +1338,6 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 * Ok, we have a good vm_area for this memory access, so
 	 * we can handle it..
 	 */
-good_area:
 	if (unlikely(access_error(error_code, vma))) {
 		bad_area_access_error(regs, error_code, address, vma);
 		return;
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index bcb0c5d2abc2..6d3c9257aa13 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -49,6 +49,7 @@ config XTENSA
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN
 	select IRQ_DOMAIN
+	select LOCK_MM_AND_FIND_VMA
 	select MODULES_USE_ELF_RELA
 	select PERF_USE_VMALLOC
 	select TRACE_IRQFLAGS_SUPPORT
diff --git a/arch/xtensa/mm/fault.c b/arch/xtensa/mm/fault.c
index faf7cf35a0ee..d1eb8d6c5b82 100644
--- a/arch/xtensa/mm/fault.c
+++ b/arch/xtensa/mm/fault.c
@@ -130,23 +130,14 @@ void do_page_fault(struct pt_regs *regs)
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 
 retry:
-	mmap_read_lock(mm);
-	vma = find_vma(mm, address);
-
+	vma = lock_mm_and_find_vma(mm, address, regs);
 	if (!vma)
-		goto bad_area;
-	if (vma->vm_start <= address)
-		goto good_area;
-	if (!(vma->vm_flags & VM_GROWSDOWN))
-		goto bad_area;
-	if (expand_stack(vma, address))
-		goto bad_area;
+		goto bad_area_nosemaphore;
 
 	/* Ok, we have a good vm_area for this memory access, so
 	 * we can handle it..
 	 */
 
-good_area:
 	code = SEGV_ACCERR;
 
 	if (is_write) {
@@ -205,6 +196,7 @@ void do_page_fault(struct pt_regs *regs)
 	 */
 bad_area:
 	mmap_read_unlock(mm);
+bad_area_nosemaphore:
 	if (user_mode(regs)) {
 		force_sig_fault(SIGSEGV, code, (void *) address);
 		return;
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index a7eb25066c27..48543d29050a 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1272,7 +1272,7 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
 	.online		= amd_pstate_epp_cpu_online,
 	.suspend	= amd_pstate_epp_suspend,
 	.resume		= amd_pstate_epp_resume,
-	.name		= "amd_pstate_epp",
+	.name		= "amd-pstate-epp",
 	.attr		= amd_pstate_epp_attr,
 };
 
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 14bce1fdec9f..3e1c30c653a5 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4364,7 +4364,7 @@ static const struct hid_device_id hidpp_devices[] = {
 	{ /* wireless touchpad T651 */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
 		USB_DEVICE_ID_LOGITECH_T651),
-	  .driver_data = HIDPP_QUIRK_CLASS_WTP },
+	  .driver_data = HIDPP_QUIRK_CLASS_WTP | HIDPP_QUIRK_DELAYED_INIT },
 	{ /* Mouse Logitech Anywhere MX */
 	  LDJ_DEVICE(0x1017), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_1P0 },
 	{ /* Mouse logitech M560 */
diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 197b1e7bf029..b617aada50b0 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -272,7 +272,12 @@ static int hidraw_open(struct inode *inode, struct file *file)
 		goto out;
 	}
 
-	down_read(&minors_rwsem);
+	/*
+	 * Technically not writing to the hidraw_table but a write lock is
+	 * required to protect the device refcount. This is symmetrical to
+	 * hidraw_release().
+	 */
+	down_write(&minors_rwsem);
 	if (!hidraw_table[minor] || !hidraw_table[minor]->exist) {
 		err = -ENODEV;
 		goto out_unlock;
@@ -301,7 +306,7 @@ static int hidraw_open(struct inode *inode, struct file *file)
 	spin_unlock_irqrestore(&hidraw_table[minor]->list_lock, flags);
 	file->private_data = list;
 out_unlock:
-	up_read(&minors_rwsem);
+	up_write(&minors_rwsem);
 out:
 	if (err < 0)
 		kfree(list);
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 9c30dd30537a..15cd0cabee2a 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1309,7 +1309,7 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
 	struct input_dev *pen_input = wacom->pen_input;
 	unsigned char *data = wacom->data;
 	int number_of_valid_frames = 0;
-	int time_interval = 15000000;
+	ktime_t time_interval = 15000000;
 	ktime_t time_packet_received = ktime_get();
 	int i;
 
@@ -1343,7 +1343,7 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
 	if (number_of_valid_frames) {
 		if (wacom->hid_data.time_delayed)
 			time_interval = ktime_get() - wacom->hid_data.time_delayed;
-		time_interval /= number_of_valid_frames;
+		time_interval = div_u64(time_interval, number_of_valid_frames);
 		wacom->hid_data.time_delayed = time_packet_received;
 	}
 
@@ -1354,7 +1354,7 @@ static void wacom_intuos_pro2_bt_pen(struct wacom_wac *wacom)
 		bool range = frame[0] & 0x20;
 		bool invert = frame[0] & 0x10;
 		int frames_number_reversed = number_of_valid_frames - i - 1;
-		int event_timestamp = time_packet_received - frames_number_reversed * time_interval;
+		ktime_t event_timestamp = time_packet_received - frames_number_reversed * time_interval;
 
 		if (!valid)
 			continue;
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 1a40bb8c5810..ee21bb260f22 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -324,7 +324,7 @@ struct hid_data {
 	int ps_connected;
 	bool pad_input_event_flag;
 	unsigned short sequence_number;
-	int time_delayed;
+	ktime_t time_delayed;
 };
 
 struct wacom_remote_data {
diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index 864e4ffb6aa9..261352a23271 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -485,8 +485,8 @@ static void do_fault(struct work_struct *work)
 	flags |= FAULT_FLAG_REMOTE;
 
 	mmap_read_lock(mm);
-	vma = find_extend_vma(mm, address);
-	if (!vma || address < vma->vm_start)
+	vma = vma_lookup(mm, address);
+	if (!vma)
 		/* failed to get a vma in the right range */
 		goto out;
 
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 24bf9b2b58aa..ed5f11eb92e5 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -203,7 +203,7 @@ iommu_sva_handle_iopf(struct iommu_fault *fault, void *data)
 
 	mmap_read_lock(mm);
 
-	vma = find_extend_vma(mm, prm->addr);
+	vma = vma_lookup(mm, prm->addr);
 	if (!vma)
 		/* Unmapped area */
 		goto out_put_mm;
diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/thermal/mediatek/auxadc_thermal.c
index 3372f7c29626..ab730f9552d0 100644
--- a/drivers/thermal/mediatek/auxadc_thermal.c
+++ b/drivers/thermal/mediatek/auxadc_thermal.c
@@ -1142,12 +1142,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	auxadc_base = devm_of_iomap(&pdev->dev, auxadc, 0, NULL);
-	if (IS_ERR(auxadc_base)) {
-		of_node_put(auxadc);
-		return PTR_ERR(auxadc_base);
-	}
-
+	auxadc_base = of_iomap(auxadc, 0);
 	auxadc_phys_base = of_get_phys_base(auxadc);
 
 	of_node_put(auxadc);
@@ -1163,12 +1158,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	apmixed_base = devm_of_iomap(&pdev->dev, apmixedsys, 0, NULL);
-	if (IS_ERR(apmixed_base)) {
-		of_node_put(apmixedsys);
-		return PTR_ERR(apmixed_base);
-	}
-
+	apmixed_base = of_iomap(apmixedsys, 0);
 	apmixed_phys_base = of_get_phys_base(apmixedsys);
 
 	of_node_put(apmixedsys);
diff --git a/drivers/video/fbdev/core/sysimgblt.c b/drivers/video/fbdev/core/sysimgblt.c
index 335e92b813fc..665ef7a0a249 100644
--- a/drivers/video/fbdev/core/sysimgblt.c
+++ b/drivers/video/fbdev/core/sysimgblt.c
@@ -189,7 +189,7 @@ static void fast_imageblit(const struct fb_image *image, struct fb_info *p,
 	u32 fgx = fgcolor, bgx = bgcolor, bpp = p->var.bits_per_pixel;
 	u32 ppw = 32/bpp, spitch = (image->width + 7)/8;
 	u32 bit_mask, eorx, shift;
-	const char *s = image->data, *src;
+	const u8 *s = image->data, *src;
 	u32 *dst;
 	const u32 *tab;
 	size_t tablen;
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 8a884e795f6a..3f6e7e5b7ead 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -320,10 +320,10 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 	 * Grow the stack manually; some architectures have a limit on how
 	 * far ahead a user-space access may be in order to grow the stack.
 	 */
-	if (mmap_read_lock_killable(mm))
+	if (mmap_write_lock_killable(mm))
 		return -EINTR;
-	vma = find_extend_vma(mm, bprm->p);
-	mmap_read_unlock(mm);
+	vma = find_extend_vma_locked(mm, bprm->p);
+	mmap_write_unlock(mm);
 	if (!vma)
 		return -EFAULT;
 
diff --git a/fs/exec.c b/fs/exec.c
index 7c44d0c65b1b..a0188e5c9ee2 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -199,33 +199,39 @@ static struct page *get_arg_page(struct linux_binprm *bprm, unsigned long pos,
 		int write)
 {
 	struct page *page;
+	struct vm_area_struct *vma = bprm->vma;
+	struct mm_struct *mm = bprm->mm;
 	int ret;
-	unsigned int gup_flags = 0;
 
-#ifdef CONFIG_STACK_GROWSUP
-	if (write) {
-		ret = expand_downwards(bprm->vma, pos);
-		if (ret < 0)
+	/*
+	 * Avoid relying on expanding the stack down in GUP (which
+	 * does not work for STACK_GROWSUP anyway), and just do it
+	 * by hand ahead of time.
+	 */
+	if (write && pos < vma->vm_start) {
+		mmap_write_lock(mm);
+		ret = expand_downwards(vma, pos);
+		if (unlikely(ret < 0)) {
+			mmap_write_unlock(mm);
 			return NULL;
-	}
-#endif
-
-	if (write)
-		gup_flags |= FOLL_WRITE;
+		}
+		mmap_write_downgrade(mm);
+	} else
+		mmap_read_lock(mm);
 
 	/*
 	 * We are doing an exec().  'current' is the process
-	 * doing the exec and bprm->mm is the new process's mm.
+	 * doing the exec and 'mm' is the new process's mm.
 	 */
-	mmap_read_lock(bprm->mm);
-	ret = get_user_pages_remote(bprm->mm, pos, 1, gup_flags,
+	ret = get_user_pages_remote(mm, pos, 1,
+			write ? FOLL_WRITE : 0,
 			&page, NULL, NULL);
-	mmap_read_unlock(bprm->mm);
+	mmap_read_unlock(mm);
 	if (ret <= 0)
 		return NULL;
 
 	if (write)
-		acct_arg_size(bprm, vma_pages(bprm->vma));
+		acct_arg_size(bprm, vma_pages(vma));
 
 	return page;
 }
@@ -852,7 +858,7 @@ int setup_arg_pages(struct linux_binprm *bprm,
 	stack_base = vma->vm_end - stack_expand;
 #endif
 	current->mm->start_stack = bprm->p;
-	ret = expand_stack(vma, stack_base);
+	ret = expand_stack_locked(vma, stack_base);
 	if (ret)
 		ret = -EFAULT;
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ced82b9c18e5..53bec6d4297b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2179,6 +2179,9 @@ void pagecache_isize_extended(struct inode *inode, loff_t from, loff_t to);
 void truncate_pagecache_range(struct inode *inode, loff_t offset, loff_t end);
 int generic_error_remove_page(struct address_space *mapping, struct page *page);
 
+struct vm_area_struct *lock_mm_and_find_vma(struct mm_struct *mm,
+		unsigned long address, struct pt_regs *regs);
+
 #ifdef CONFIG_MMU
 extern vm_fault_t handle_mm_fault(struct vm_area_struct *vma,
 				  unsigned long address, unsigned int flags,
@@ -3063,16 +3066,11 @@ extern vm_fault_t filemap_page_mkwrite(struct vm_fault *vmf);
 
 extern unsigned long stack_guard_gap;
 /* Generic expand stack which grows the stack according to GROWS{UP,DOWN} */
-extern int expand_stack(struct vm_area_struct *vma, unsigned long address);
+int expand_stack_locked(struct vm_area_struct *vma, unsigned long address);
+struct vm_area_struct *expand_stack(struct mm_struct * mm, unsigned long addr);
 
 /* CONFIG_STACK_GROWSUP still needs to grow downwards at some places */
-extern int expand_downwards(struct vm_area_struct *vma,
-		unsigned long address);
-#if VM_GROWSUP
-extern int expand_upwards(struct vm_area_struct *vma, unsigned long address);
-#else
-  #define expand_upwards(vma, address) (0)
-#endif
+int expand_downwards(struct vm_area_struct *vma, unsigned long address);
 
 /* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
 extern struct vm_area_struct * find_vma(struct mm_struct * mm, unsigned long addr);
@@ -3167,7 +3165,8 @@ unsigned long change_prot_numa(struct vm_area_struct *vma,
 			unsigned long start, unsigned long end);
 #endif
 
-struct vm_area_struct *find_extend_vma(struct mm_struct *, unsigned long addr);
+struct vm_area_struct *find_extend_vma_locked(struct mm_struct *,
+		unsigned long addr);
 int remap_pfn_range(struct vm_area_struct *, unsigned long addr,
 			unsigned long pfn, unsigned long size, pgprot_t);
 int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index a614129d4339..468d37bf512d 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4287,11 +4287,13 @@ static inline bool mas_wr_slot_store(struct ma_wr_state *wr_mas)
 
 static inline void mas_wr_end_piv(struct ma_wr_state *wr_mas)
 {
-	while ((wr_mas->mas->last > wr_mas->end_piv) &&
-	       (wr_mas->offset_end < wr_mas->node_end))
-		wr_mas->end_piv = wr_mas->pivots[++wr_mas->offset_end];
+	while ((wr_mas->offset_end < wr_mas->node_end) &&
+	       (wr_mas->mas->last > wr_mas->pivots[wr_mas->offset_end]))
+		wr_mas->offset_end++;
 
-	if (wr_mas->mas->last > wr_mas->end_piv)
+	if (wr_mas->offset_end < wr_mas->node_end)
+		wr_mas->end_piv = wr_mas->pivots[wr_mas->offset_end];
+	else
 		wr_mas->end_piv = wr_mas->mas->max;
 }
 
@@ -4448,7 +4450,6 @@ static inline void *mas_wr_store_entry(struct ma_wr_state *wr_mas)
 	}
 
 	/* At this point, we are at the leaf node that needs to be altered. */
-	wr_mas->end_piv = wr_mas->r_max;
 	mas_wr_end_piv(wr_mas);
 
 	if (!wr_mas->entry)
diff --git a/mm/Kconfig b/mm/Kconfig
index 4751031f3f05..ae3003a98d13 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1202,6 +1202,10 @@ config LRU_GEN_STATS
 	  This option has a per-memcg and per-node memory overhead.
 # }
 
+config LOCK_MM_AND_FIND_VMA
+	bool
+	depends on !STACK_GROWSUP
+
 source "mm/damon/Kconfig"
 
 endmenu
diff --git a/mm/gup.c b/mm/gup.c
index eab18ba045db..eb0b96985c3c 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1096,7 +1096,11 @@ static long __get_user_pages(struct mm_struct *mm,
 
 		/* first iteration or cross vma bound */
 		if (!vma || start >= vma->vm_end) {
-			vma = find_extend_vma(mm, start);
+			vma = find_vma(mm, start);
+			if (vma && (start < vma->vm_start)) {
+				WARN_ON_ONCE(vma->vm_flags & VM_GROWSDOWN);
+				vma = NULL;
+			}
 			if (!vma && in_gate_area(mm, start)) {
 				ret = get_gate_page(mm, start & PAGE_MASK,
 						gup_flags, &vma,
@@ -1265,9 +1269,13 @@ int fixup_user_fault(struct mm_struct *mm,
 		fault_flags |= FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
 
 retry:
-	vma = find_extend_vma(mm, address);
-	if (!vma || address < vma->vm_start)
+	vma = find_vma(mm, address);
+	if (!vma)
+		return -EFAULT;
+	if (address < vma->vm_start ) {
+		WARN_ON_ONCE(vma->vm_flags & VM_GROWSDOWN);
 		return -EFAULT;
+	}
 
 	if (!vma_permits_fault(vma, fault_flags))
 		return -EFAULT;
diff --git a/mm/memory.c b/mm/memory.c
index 01a23ad48a04..2c2caae6fb3b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5230,6 +5230,125 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 }
 EXPORT_SYMBOL_GPL(handle_mm_fault);
 
+#ifdef CONFIG_LOCK_MM_AND_FIND_VMA
+#include <linux/extable.h>
+
+static inline bool get_mmap_lock_carefully(struct mm_struct *mm, struct pt_regs *regs)
+{
+	/* Even if this succeeds, make it clear we *might* have slept */
+	if (likely(mmap_read_trylock(mm))) {
+		might_sleep();
+		return true;
+	}
+
+	if (regs && !user_mode(regs)) {
+		unsigned long ip = instruction_pointer(regs);
+		if (!search_exception_tables(ip))
+			return false;
+	}
+
+	return !mmap_read_lock_killable(mm);
+}
+
+static inline bool mmap_upgrade_trylock(struct mm_struct *mm)
+{
+	/*
+	 * We don't have this operation yet.
+	 *
+	 * It should be easy enough to do: it's basically a
+	 *    atomic_long_try_cmpxchg_acquire()
+	 * from RWSEM_READER_BIAS -> RWSEM_WRITER_LOCKED, but
+	 * it also needs the proper lockdep magic etc.
+	 */
+	return false;
+}
+
+static inline bool upgrade_mmap_lock_carefully(struct mm_struct *mm, struct pt_regs *regs)
+{
+	mmap_read_unlock(mm);
+	if (regs && !user_mode(regs)) {
+		unsigned long ip = instruction_pointer(regs);
+		if (!search_exception_tables(ip))
+			return false;
+	}
+	return !mmap_write_lock_killable(mm);
+}
+
+/*
+ * Helper for page fault handling.
+ *
+ * This is kind of equivalend to "mmap_read_lock()" followed
+ * by "find_extend_vma()", except it's a lot more careful about
+ * the locking (and will drop the lock on failure).
+ *
+ * For example, if we have a kernel bug that causes a page
+ * fault, we don't want to just use mmap_read_lock() to get
+ * the mm lock, because that would deadlock if the bug were
+ * to happen while we're holding the mm lock for writing.
+ *
+ * So this checks the exception tables on kernel faults in
+ * order to only do this all for instructions that are actually
+ * expected to fault.
+ *
+ * We can also actually take the mm lock for writing if we
+ * need to extend the vma, which helps the VM layer a lot.
+ */
+struct vm_area_struct *lock_mm_and_find_vma(struct mm_struct *mm,
+			unsigned long addr, struct pt_regs *regs)
+{
+	struct vm_area_struct *vma;
+
+	if (!get_mmap_lock_carefully(mm, regs))
+		return NULL;
+
+	vma = find_vma(mm, addr);
+	if (likely(vma && (vma->vm_start <= addr)))
+		return vma;
+
+	/*
+	 * Well, dang. We might still be successful, but only
+	 * if we can extend a vma to do so.
+	 */
+	if (!vma || !(vma->vm_flags & VM_GROWSDOWN)) {
+		mmap_read_unlock(mm);
+		return NULL;
+	}
+
+	/*
+	 * We can try to upgrade the mmap lock atomically,
+	 * in which case we can continue to use the vma
+	 * we already looked up.
+	 *
+	 * Otherwise we'll have to drop the mmap lock and
+	 * re-take it, and also look up the vma again,
+	 * re-checking it.
+	 */
+	if (!mmap_upgrade_trylock(mm)) {
+		if (!upgrade_mmap_lock_carefully(mm, regs))
+			return NULL;
+
+		vma = find_vma(mm, addr);
+		if (!vma)
+			goto fail;
+		if (vma->vm_start <= addr)
+			goto success;
+		if (!(vma->vm_flags & VM_GROWSDOWN))
+			goto fail;
+	}
+
+	if (expand_stack_locked(vma, addr))
+		goto fail;
+
+success:
+	mmap_write_downgrade(mm);
+	return vma;
+
+fail:
+	mmap_write_unlock(mm);
+	return NULL;
+}
+#endif
+
 #ifndef __PAGETABLE_P4D_FOLDED
 /*
  * Allocate p4d page table.
@@ -5501,6 +5620,14 @@ int __access_remote_vm(struct mm_struct *mm, unsigned long addr, void *buf,
 	if (mmap_read_lock_killable(mm))
 		return 0;
 
+	/* We might need to expand the stack to access it */
+	vma = vma_lookup(mm, addr);
+	if (!vma) {
+		vma = expand_stack(mm, addr);
+		if (!vma)
+			return 0;
+	}
+
 	/* ignore errors, just check how much was successfully transferred */
 	while (len) {
 		int bytes, ret, offset;
diff --git a/mm/mmap.c b/mm/mmap.c
index eefa6f0cda28..c9328a6c7d43 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1898,7 +1898,7 @@ static int acct_stack_growth(struct vm_area_struct *vma,
  * PA-RISC uses this for its stack; IA64 for its Register Backing Store.
  * vma is the last one with address > vma->vm_end.  Have to extend vma.
  */
-int expand_upwards(struct vm_area_struct *vma, unsigned long address)
+static int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	struct vm_area_struct *next;
@@ -1990,6 +1990,7 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
 
 /*
  * vma is the first one with address < vma->vm_start.  Have to extend vma.
+ * mmap_lock held for writing.
  */
 int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 {
@@ -1998,16 +1999,20 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
 	struct vm_area_struct *prev;
 	int error = 0;
 
+	if (!(vma->vm_flags & VM_GROWSDOWN))
+		return -EFAULT;
+
 	address &= PAGE_MASK;
-	if (address < mmap_min_addr)
+	if (address < mmap_min_addr || address < FIRST_USER_ADDRESS)
 		return -EPERM;
 
 	/* Enforce stack_guard_gap */
 	prev = mas_prev(&mas, 0);
 	/* Check that both stack segments have the same anon_vma? */
-	if (prev && !(prev->vm_flags & VM_GROWSDOWN) &&
-			vma_is_accessible(prev)) {
-		if (address - prev->vm_end < stack_guard_gap)
+	if (prev) {
+		if (!(prev->vm_flags & VM_GROWSDOWN) &&
+		    vma_is_accessible(prev) &&
+		    (address - prev->vm_end < stack_guard_gap))
 			return -ENOMEM;
 	}
 
@@ -2087,13 +2092,12 @@ static int __init cmdline_parse_stack_guard_gap(char *p)
 __setup("stack_guard_gap=", cmdline_parse_stack_guard_gap);
 
 #ifdef CONFIG_STACK_GROWSUP
-int expand_stack(struct vm_area_struct *vma, unsigned long address)
+int expand_stack_locked(struct vm_area_struct *vma, unsigned long address)
 {
 	return expand_upwards(vma, address);
 }
 
-struct vm_area_struct *
-find_extend_vma(struct mm_struct *mm, unsigned long addr)
+struct vm_area_struct *find_extend_vma_locked(struct mm_struct *mm, unsigned long addr)
 {
 	struct vm_area_struct *vma, *prev;
 
@@ -2101,20 +2105,23 @@ find_extend_vma(struct mm_struct *mm, unsigned long addr)
 	vma = find_vma_prev(mm, addr, &prev);
 	if (vma && (vma->vm_start <= addr))
 		return vma;
-	if (!prev || expand_stack(prev, addr))
+	if (!prev)
+		return NULL;
+	if (expand_stack_locked(prev, addr))
 		return NULL;
 	if (prev->vm_flags & VM_LOCKED)
 		populate_vma_page_range(prev, addr, prev->vm_end, NULL);
 	return prev;
 }
 #else
-int expand_stack(struct vm_area_struct *vma, unsigned long address)
+int expand_stack_locked(struct vm_area_struct *vma, unsigned long address)
 {
+	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN)))
+		return -EINVAL;
 	return expand_downwards(vma, address);
 }
 
-struct vm_area_struct *
-find_extend_vma(struct mm_struct *mm, unsigned long addr)
+struct vm_area_struct *find_extend_vma_locked(struct mm_struct *mm, unsigned long addr)
 {
 	struct vm_area_struct *vma;
 	unsigned long start;
@@ -2125,10 +2132,8 @@ find_extend_vma(struct mm_struct *mm, unsigned long addr)
 		return NULL;
 	if (vma->vm_start <= addr)
 		return vma;
-	if (!(vma->vm_flags & VM_GROWSDOWN))
-		return NULL;
 	start = vma->vm_start;
-	if (expand_stack(vma, addr))
+	if (expand_stack_locked(vma, addr))
 		return NULL;
 	if (vma->vm_flags & VM_LOCKED)
 		populate_vma_page_range(vma, addr, start, NULL);
@@ -2136,7 +2141,91 @@ find_extend_vma(struct mm_struct *mm, unsigned long addr)
 }
 #endif
 
-EXPORT_SYMBOL_GPL(find_extend_vma);
+/*
+ * IA64 has some horrid mapping rules: it can expand both up and down,
+ * but with various special rules.
+ *
+ * We'll get rid of this architecture eventually, so the ugliness is
+ * temporary.
+ */
+#ifdef CONFIG_IA64
+static inline bool vma_expand_ok(struct vm_area_struct *vma, unsigned long addr)
+{
+	return REGION_NUMBER(addr) == REGION_NUMBER(vma->vm_start) &&
+		REGION_OFFSET(addr) < RGN_MAP_LIMIT;
+}
+
+/*
+ * IA64 stacks grow down, but there's a special register backing store
+ * that can grow up. Only sequentially, though, so the new address must
+ * match vm_end.
+ */
+static inline int vma_expand_up(struct vm_area_struct *vma, unsigned long addr)
+{
+	if (!vma_expand_ok(vma, addr))
+		return -EFAULT;
+	if (vma->vm_end != (addr & PAGE_MASK))
+		return -EFAULT;
+	return expand_upwards(vma, addr);
+}
+
+static inline bool vma_expand_down(struct vm_area_struct *vma, unsigned long addr)
+{
+	if (!vma_expand_ok(vma, addr))
+		return -EFAULT;
+	return expand_downwards(vma, addr);
+}
+
+#elif defined(CONFIG_STACK_GROWSUP)
+
+#define vma_expand_up(vma,addr) expand_upwards(vma, addr)
+#define vma_expand_down(vma, addr) (-EFAULT)
+
+#else
+
+#define vma_expand_up(vma,addr) (-EFAULT)
+#define vma_expand_down(vma, addr) expand_downwards(vma, addr)
+
+#endif
+
+/*
+ * expand_stack(): legacy interface for page faulting. Don't use unless
+ * you have to.
+ *
+ * This is called with the mm locked for reading, drops the lock, takes
+ * the lock for writing, tries to look up a vma again, expands it if
+ * necessary, and downgrades the lock to reading again.
+ *
+ * If no vma is found or it can't be expanded, it returns NULL and has
+ * dropped the lock.
+ */
+struct vm_area_struct *expand_stack(struct mm_struct *mm, unsigned long addr)
+{
+	struct vm_area_struct *vma, *prev;
+
+	mmap_read_unlock(mm);
+	if (mmap_write_lock_killable(mm))
+		return NULL;
+
+	vma = find_vma_prev(mm, addr, &prev);
+	if (vma && vma->vm_start <= addr)
+		goto success;
+
+	if (prev && !vma_expand_up(prev, addr)) {
+		vma = prev;
+		goto success;
+	}
+
+	if (vma && !vma_expand_down(vma, addr))
+		goto success;
+
+	mmap_write_unlock(mm);
+	return NULL;
+
+success:
+	mmap_write_downgrade(mm);
+	return vma;
+}
 
 /*
  * Ok - we have the memory areas we should free on a maple tree so release them,
@@ -2280,19 +2369,6 @@ int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	return __split_vma(vmi, vma, addr, new_below);
 }
 
-static inline int munmap_sidetree(struct vm_area_struct *vma,
-				   struct ma_state *mas_detach)
-{
-	mas_set_range(mas_detach, vma->vm_start, vma->vm_end - 1);
-	if (mas_store_gfp(mas_detach, vma, GFP_KERNEL))
-		return -ENOMEM;
-
-	if (vma->vm_flags & VM_LOCKED)
-		vma->vm_mm->locked_vm -= vma_pages(vma);
-
-	return 0;
-}
-
 /*
  * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
  * @vmi: The vma iterator
@@ -2314,6 +2390,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	struct maple_tree mt_detach;
 	int count = 0;
 	int error = -ENOMEM;
+	unsigned long locked_vm = 0;
 	MA_STATE(mas_detach, &mt_detach, 0, 0);
 	mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
 	mt_set_external_lock(&mt_detach, &mm->mmap_lock);
@@ -2359,9 +2436,12 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 			if (error)
 				goto end_split_failed;
 		}
-		error = munmap_sidetree(next, &mas_detach);
+		mas_set_range(&mas_detach, next->vm_start, next->vm_end - 1);
+		error = mas_store_gfp(&mas_detach, next, GFP_KERNEL);
 		if (error)
-			goto munmap_sidetree_failed;
+			goto munmap_gather_failed;
+		if (next->vm_flags & VM_LOCKED)
+			locked_vm += vma_pages(next);
 
 		count++;
 #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
@@ -2406,11 +2486,13 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		BUG_ON(count != test_count);
 	}
 #endif
-	/* Point of no return */
 	vma_iter_set(vmi, start);
-	if (vma_iter_clear_gfp(vmi, start, end, GFP_KERNEL))
-		return -ENOMEM;
+	error = vma_iter_clear_gfp(vmi, start, end, GFP_KERNEL);
+	if (error)
+		goto clear_tree_failed;
 
+	/* Point of no return */
+	mm->locked_vm -= locked_vm;
 	mm->map_count -= count;
 	/*
 	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
@@ -2440,8 +2522,9 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	validate_mm(mm);
 	return downgrade ? 1 : 0;
 
+clear_tree_failed:
 userfaultfd_error:
-munmap_sidetree_failed:
+munmap_gather_failed:
 end_split_failed:
 	__mt_destroy(&mt_detach);
 start_split_failed:
diff --git a/mm/nommu.c b/mm/nommu.c
index 57ba243c6a37..07a3af6a94ea 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -631,23 +631,31 @@ struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 EXPORT_SYMBOL(find_vma);
 
 /*
- * find a VMA
- * - we don't extend stack VMAs under NOMMU conditions
+ * At least xtensa ends up having protection faults even with no
+ * MMU.. No stack expansion, at least.
  */
-struct vm_area_struct *find_extend_vma(struct mm_struct *mm, unsigned long addr)
+struct vm_area_struct *lock_mm_and_find_vma(struct mm_struct *mm,
+			unsigned long addr, struct pt_regs *regs)
 {
-	return find_vma(mm, addr);
+	mmap_read_lock(mm);
+	return vma_lookup(mm, addr);
 }
 
 /*
  * expand a stack to a given address
  * - not supported under NOMMU conditions
  */
-int expand_stack(struct vm_area_struct *vma, unsigned long address)
+int expand_stack_locked(struct vm_area_struct *vma, unsigned long addr)
 {
 	return -ENOMEM;
 }
 
+struct vm_area_struct *expand_stack(struct mm_struct *mm, unsigned long addr)
+{
+	mmap_read_unlock(mm);
+	return NULL;
+}
+
 /*
  * look up the first VMA exactly that exactly matches addr
  * - should be called with mm->mmap_lock at least held readlocked
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 1af623839bff..b3c2a49b189c 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1079,8 +1079,9 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 		if (err)
 			goto err_event_drop;
 
-		if (sk->sk_err)
-			return -sk->sk_err;
+		err = sock_error(sk);
+		if (err)
+			return err;
 	}
 
 	return size;
