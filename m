Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47494620E38
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbiKHLIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 06:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234082AbiKHLHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:07:25 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DD649B5D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 03:07:19 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id j15so20392212wrq.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 03:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NtmLIc1OG3i/6ArDTQ6YikGOAgIUmTbWIngQk/LQ8zg=;
        b=FdnA4+dyfxlKZErCxB93J843nLgDAUPWfFVew6lXVD+CR4nd4CLnhAF4t+e/dwLDyh
         63R6kwIrfAxxYCxx93XStVzEyR+7ie/FgES+k658xqfSNGLT/AodcpDO/59lViyEVtu3
         svrHWlMoO67jPNI8pGkzc6BtJsy9aNtdC7d8A2iA3NvDE7yXe2RxgrABbq2OLZOnXx/H
         VCG5ekoJbd3bc8g72JD2xSopN0H5mV10pZI4Ay41DBoT4ZgH158ZBVjOf6k+WiiIVdrH
         lqTL73dZKw2AOFW4Gt2AcVzksADX7pvWiDCjaB46+Dfe6lFww2TdEm5rnbQK0FSaa4Rs
         WULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NtmLIc1OG3i/6ArDTQ6YikGOAgIUmTbWIngQk/LQ8zg=;
        b=LLulOTeG1Dxvnogs5Y4waBcCG0uMSRD7YnU/fPiDOno2gEoxqZq6qRc6Jap63geohp
         eFMoZ5qObzHblk2ha3NfZwp5ybs7nK5ARFMgmWJSxBVnJshjDt93M9drPf8vTbkWUP7r
         YsB+z7jdIvjRpvKSVe8ayBenE75ZpH5GNO9bf5T2yRchGd4xztLE54fAy5LTRddd4+A5
         JqIAJnwgV2hnLkDmLyVYJ2w/yBgxFkTXxrsn5qIslB7yfHXg3+VdrBm4c446KUoOqKMs
         ScOY97W/2wvTHIKSw4cgsJSJvavfIQM78i9WmSkMm6njW88veNIbWrYkOVZsFaSb87RA
         awVw==
X-Gm-Message-State: ACrzQf12tFSzlvwQ/CP2JRuLT+rV6oUE7aMezaDm5KceO1Il5tv9BV7b
        6rPAtPAN8CxvX+zCW62nY4zz2muRh251tVpB
X-Google-Smtp-Source: AMsMyM5g0HQG+Dbr4uadKaKhyC1+2LrMU+pIVd2lZPHLb3RplWc5KT+Eu+JKsF6RjuLsz9oleEm+HA==
X-Received: by 2002:adf:e491:0:b0:236:5270:7f5e with SMTP id i17-20020adfe491000000b0023652707f5emr34501020wrm.600.1667905638248;
        Tue, 08 Nov 2022 03:07:18 -0800 (PST)
Received: from PC-PEDRO-ARCH.lan ([2001:8a0:7280:5801:9441:3dce:686c:bfc7])
        by smtp.gmail.com with ESMTPSA id o13-20020adfeacd000000b002366a624bd4sm9915748wrn.28.2022.11.08.03.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 03:07:17 -0800 (PST)
From:   Pedro Falcato <pedro.falcato@gmail.com>
To:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     dalias@libc.org, ebiederm@xmission.com, pedro.falcato@gmail.com,
        sam@gentoo.org, viro@zeniv.linux.org.uk
Subject: [PATCH v3] fs/binfmt_elf: Fix memsz > filesz handling
Date:   Tue,  8 Nov 2022 11:07:15 +0000
Message-Id: <20221108110715.227062-1-pedro.falcato@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The old code for ELF interpreter loading could only handle
1 memsz > filesz segment. This is incorrect, as evidenced
by the elf program loading code, which could handle multiple
such segments.

Fix memsz > filesz handling for elf interpreters and refactor
interpreter/program BSS clearing into a common
codepath; also handle the case where a segment after a bss
could overwrite a bss clear.

This bug was uncovered on builds of ppc64le musl libc with
llvm lld 15.0.0, since ppc64 does not allocate file space
for its .plt.

Cc: Rich Felker <dalias@libc.org>
Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
---
v3:
	- Minor commit message edit (make the whole commit msg imperative)
v2:
	- Fixed possible problems mapping segments on top of a cleared bss
		See https://github.com/heatd/elf-bug-questionmark for a repro and patch
		comments for fix details.
	  Further refactoring brk clearing.
v1: https://lore.kernel.org/all/20221106021657.1145519-1-pedro.falcato@gmail.com/ 

 fs/binfmt_elf.c | 277 ++++++++++++++++++++++++++++--------------------
 1 file changed, 164 insertions(+), 113 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 6a11025e585..78ff6dcb198 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -109,37 +109,20 @@ static struct linux_binfmt elf_format = {
 
 #define BAD_ADDR(x) (unlikely((unsigned long)(x) >= TASK_SIZE))
 
-static int set_brk(unsigned long start, unsigned long end, int prot)
-{
-	start = ELF_PAGEALIGN(start);
-	end = ELF_PAGEALIGN(end);
-	if (end > start) {
-		/*
-		 * Map the last of the bss segment.
-		 * If the header is requesting these pages to be
-		 * executable, honour that (ppc32 needs this).
-		 */
-		int error = vm_brk_flags(start, end - start,
-				prot & PROT_EXEC ? VM_EXEC : 0);
-		if (error)
-			return error;
-	}
-	current->mm->start_brk = current->mm->brk = end;
-	return 0;
-}
-
 /* We need to explicitly zero any fractional pages
    after the data section (i.e. bss).  This would
    contain the junk from the file that should not
    be in memory
  */
-static int padzero(unsigned long elf_bss)
+static int padzero(unsigned long elf_bss, unsigned long len)
 {
 	unsigned long nbyte;
 
 	nbyte = ELF_PAGEOFFSET(elf_bss);
 	if (nbyte) {
 		nbyte = ELF_MIN_ALIGN - nbyte;
+		if (nbyte > len)
+			nbyte = len;
 		if (clear_user((void __user *) elf_bss, nbyte))
 			return -EFAULT;
 	}
@@ -584,6 +567,138 @@ static inline int make_prot(u32 p_flags, struct arch_elf_state *arch_state,
 	return arch_elf_adjust_prot(prot, arch_state, has_interp, is_interp);
 }
 
+static int map_bss_anon(unsigned long start, unsigned long end, int prot)
+{
+	start = ELF_PAGEALIGN(start);
+	end = ELF_PAGEALIGN(end);
+
+	return (end > start ? vm_brk_flags(start, end - start,
+		prot & PROT_EXEC ? VM_EXEC : 0) : 0);
+}
+
+static void set_brk(unsigned long end)
+{
+	current->mm->start_brk = current->mm->brk = ELF_PAGEALIGN(end);
+}
+
+static int handle_bss_clearing(struct elf_phdr *elf_phdata,
+			       struct elfhdr *elf_ex, unsigned long load_bias,
+			       int is_interp)
+{
+	int i;
+	struct elf_phdr *elf_ppnt;
+	int retval = 0;
+	/*
+	 * Do explicit bss clearing after loading everything.
+	 * Why? Because we may get odd phdr layouts like:
+	 * PHDR [0x1000, 0x1200] p_filesz 0 p_memsz 0x200 [.bss]
+	 * PHDR [0x1200, 0x1300] p_filesz 0x100 p_memsz 0x200 [.data]
+	 *
+	 * If we mindlessly clear and map, we'll get loading bugs where we map
+	 * anon bss and do our explicit clearing, then map [.data], which
+	 * elf_map ends up mapping over our .bss, which effectively undoes the
+	 * clear!
+	 */
+	for (i = 0, elf_ppnt = elf_phdata;
+	     i < elf_ex->e_phnum; i++, elf_ppnt++) {
+
+		unsigned long addr;
+		unsigned int n;
+		unsigned long end;
+		struct elf_phdr *next = NULL;
+		int j;
+
+		if (elf_ppnt->p_type != PT_LOAD)
+			continue;
+
+		if (elf_ppnt->p_memsz <= elf_ppnt->p_filesz)
+			continue;
+
+		addr = elf_ppnt->p_vaddr + load_bias + elf_ppnt->p_filesz;
+		n = ELF_PAGEOFFSET(addr);
+		end = elf_ppnt->p_vaddr + load_bias + elf_ppnt->p_memsz;
+
+		/*
+		 * Find the next PT_LOAD in the list, if it exists.
+		 */
+		for (j = i + 1; j < elf_ex->e_phnum; j++) {
+			struct elf_phdr *phdr = elf_ppnt + j - i;
+
+			if (phdr->p_type == PT_LOAD) {
+				next = phdr;
+				break;
+			}
+		}
+
+
+		/*
+		 * Check if we need to zero the starting bss page, explicitly.
+		 */
+		if (n != 0) {
+			unsigned long bss_len =
+				elf_ppnt->p_memsz - elf_ppnt->p_filesz;
+			unsigned long len;
+
+			if (next)
+				len = bss_len;
+			else
+				len = ELF_MIN_ALIGN;
+
+			/*
+			 * Note: padzero will zero either
+			 * [addr, end of addr_page] or [addr, addr + len],
+			 * whatever comes first. The old bss behavior zeroed
+			 * the whole last page *only* if it was the last bss
+			 * segment, else it would only zero bss_len bytes.
+			 * It turns out ld-linux relies on this to not crash,
+			 * so we follow the old behavior.
+			 */
+			retval = padzero(addr, len);
+
+			if (retval < 0)
+				return retval;
+		}
+
+		/*
+		 * brk is defined with regards to the main program, not the
+		 * interpreter.
+		 */
+		if (!is_interp)
+			set_brk(end);
+
+		n = ELF_PAGEOFFSET(end);
+
+		/*
+		 *
+		 * The tail logic is a bit more complex. We need to re-clear
+		 * the tail if something was mapped over that last page.
+		 * How do we do it?
+		 * We check if the next phdr maps this page.
+		 * If so, we know there was a mmap MAP_FIXED over it, so
+		 * re-clear it.
+		 *
+		 * This tail logic is skippable if we're the last phdr, as
+		 * nothing can map an address >= our p_vaddr, since ELF phdr
+		 * PT_LOAD segments are required to be sorted in an increasing
+		 * order.
+		 */
+		if (n == 0 || !next)
+			continue;
+
+		end = ELF_PAGESTART(end);
+
+		if (end == ELF_PAGESTART(next->p_vaddr + load_bias)) {
+			/*
+			 * Re-clear the last n bytes
+			 */
+			if (clear_user((void __user *) end, n))
+				return -EFAULT;
+		}
+	}
+
+	return 0;
+}
+
 /* This is much more generalized than the library routine read function,
    so we keep this separate.  Technically the library read function
    is only provided so that we can read a.out libraries that have
@@ -597,8 +712,6 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 	struct elf_phdr *eppnt;
 	unsigned long load_addr = 0;
 	int load_addr_set = 0;
-	unsigned long last_bss = 0, elf_bss = 0;
-	int bss_prot = 0;
 	unsigned long error = ~0UL;
 	unsigned long total_size;
 	int i;
@@ -662,49 +775,25 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 				goto out;
 			}
 
-			/*
-			 * Find the end of the file mapping for this phdr, and
-			 * keep track of the largest address we see for this.
-			 */
-			k = load_addr + eppnt->p_vaddr + eppnt->p_filesz;
-			if (k > elf_bss)
-				elf_bss = k;
+			if (eppnt->p_memsz > eppnt->p_filesz) {
+				/*
+				 * Handle BSS zeroing and mapping
+				 */
+				unsigned long start = load_addr + vaddr + eppnt->p_filesz;
+				unsigned long end = load_addr + vaddr + eppnt->p_memsz;
 
-			/*
-			 * Do the same thing for the memory mapping - between
-			 * elf_bss and last_bss is the bss section.
-			 */
-			k = load_addr + eppnt->p_vaddr + eppnt->p_memsz;
-			if (k > last_bss) {
-				last_bss = k;
-				bss_prot = elf_prot;
+				error = map_bss_anon(start, end, elf_prot);
+
+				if (error < 0)
+					goto out;
 			}
 		}
 	}
 
-	/*
-	 * Now fill out the bss section: first pad the last page from
-	 * the file up to the page boundary, and zero it from elf_bss
-	 * up to the end of the page.
-	 */
-	if (padzero(elf_bss)) {
-		error = -EFAULT;
+	error = handle_bss_clearing(interp_elf_phdata, interp_elf_ex,
+				load_addr, 1);
+	if (error < 0)
 		goto out;
-	}
-	/*
-	 * Next, align both the file and mem bss up to the page size,
-	 * since this is where elf_bss was just zeroed up to, and where
-	 * last_bss will end after the vm_brk_flags() below.
-	 */
-	elf_bss = ELF_PAGEALIGN(elf_bss);
-	last_bss = ELF_PAGEALIGN(last_bss);
-	/* Finally, if there is still more bss to allocate, do it. */
-	if (last_bss > elf_bss) {
-		error = vm_brk_flags(elf_bss, last_bss - elf_bss,
-				bss_prot & PROT_EXEC ? VM_EXEC : 0);
-		if (error)
-			goto out;
-	}
 
 	error = load_addr;
 out:
@@ -829,8 +918,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	unsigned long error;
 	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
 	struct elf_phdr *elf_property_phdata = NULL;
-	unsigned long elf_bss, elf_brk;
-	int bss_prot = 0;
 	int retval, i;
 	unsigned long elf_entry;
 	unsigned long e_entry;
@@ -1020,9 +1107,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 				 executable_stack);
 	if (retval < 0)
 		goto out_free_dentry;
-	
-	elf_bss = 0;
-	elf_brk = 0;
 
 	start_code = ~0UL;
 	end_code = 0;
@@ -1041,33 +1125,6 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		if (elf_ppnt->p_type != PT_LOAD)
 			continue;
 
-		if (unlikely (elf_brk > elf_bss)) {
-			unsigned long nbyte;
-	            
-			/* There was a PT_LOAD segment with p_memsz > p_filesz
-			   before this one. Map anonymous pages, if needed,
-			   and clear the area.  */
-			retval = set_brk(elf_bss + load_bias,
-					 elf_brk + load_bias,
-					 bss_prot);
-			if (retval)
-				goto out_free_dentry;
-			nbyte = ELF_PAGEOFFSET(elf_bss);
-			if (nbyte) {
-				nbyte = ELF_MIN_ALIGN - nbyte;
-				if (nbyte > elf_brk - elf_bss)
-					nbyte = elf_brk - elf_bss;
-				if (clear_user((void __user *)elf_bss +
-							load_bias, nbyte)) {
-					/*
-					 * This bss-zeroing can fail if the ELF
-					 * file specifies odd protections. So
-					 * we don't check the return value
-					 */
-				}
-			}
-		}
-
 		elf_prot = make_prot(elf_ppnt->p_flags, &arch_state,
 				     !!interpreter, false);
 
@@ -1211,41 +1268,35 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 		k = elf_ppnt->p_vaddr + elf_ppnt->p_filesz;
 
-		if (k > elf_bss)
-			elf_bss = k;
+
+		if (elf_ppnt->p_memsz > elf_ppnt->p_filesz) {
+			unsigned long seg_end = elf_ppnt->p_vaddr +
+					 elf_ppnt->p_memsz + load_bias;
+			retval = map_bss_anon(k + load_bias,
+					 seg_end,
+					 elf_prot);
+			if (retval)
+				goto out_free_dentry;
+		}
+
 		if ((elf_ppnt->p_flags & PF_X) && end_code < k)
 			end_code = k;
 		if (end_data < k)
 			end_data = k;
-		k = elf_ppnt->p_vaddr + elf_ppnt->p_memsz;
-		if (k > elf_brk) {
-			bss_prot = elf_prot;
-			elf_brk = k;
-		}
 	}
 
+	retval = handle_bss_clearing(elf_phdata, elf_ex, load_bias, 0);
+
+	if (retval < 0)
+		goto out_free_dentry;
+
 	e_entry = elf_ex->e_entry + load_bias;
 	phdr_addr += load_bias;
-	elf_bss += load_bias;
-	elf_brk += load_bias;
 	start_code += load_bias;
 	end_code += load_bias;
 	start_data += load_bias;
 	end_data += load_bias;
 
-	/* Calling set_brk effectively mmaps the pages that we need
-	 * for the bss and break sections.  We must do this before
-	 * mapping in the interpreter, to make sure it doesn't wind
-	 * up getting placed where the bss needs to go.
-	 */
-	retval = set_brk(elf_bss, elf_brk, bss_prot);
-	if (retval)
-		goto out_free_dentry;
-	if (likely(elf_bss != elf_brk) && unlikely(padzero(elf_bss))) {
-		retval = -EFAULT; /* Nobody gets to see this, but.. */
-		goto out_free_dentry;
-	}
-
 	if (interpreter) {
 		elf_entry = load_elf_interp(interp_elf_ex,
 					    interpreter,
-- 
2.38.1

