Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246F36C1CAB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbjCTQuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjCTQsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:48:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B261123118;
        Mon, 20 Mar 2023 09:41:44 -0700 (PDT)
Date:   Mon, 20 Mar 2023 16:39:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679330369;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=E8uckkRhYtGhjYgD1zxfWIMgKATVGBDK2ETEdaGxUl8=;
        b=iom8daLrTSr6bGyT733yF1WW3ZkKl6gpr7ipm8IMfanapBxhZF6E3TykcPlGjZ8ba1VFmt
        k5zdAhbjTTJbEE4J5k4P/RUOQZgGNuYtRyrfbMCp3cBWyBRvbzVdKpWR9GB7tp+bnbiWH9
        ZDFGwhiuub77hfatWVwVkszVcSHkSEZmNagwLeq91yOPpiyV8gsaB5BOrvVWNE62eroDEx
        e7HjIysSrZhZGK9Ux3Q7KFGhXTHXyjZ1/dO1C8o1vr64hgTaly+fXE6d50TgRVAcaH6w01
        TQ/BE36iR7sNrErzP4rfUgKKgJ7VEqpj4yOj8eljBkgQSoWlqNz/kZ4z++iRuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679330369;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=E8uckkRhYtGhjYgD1zxfWIMgKATVGBDK2ETEdaGxUl8=;
        b=QUN+yvHDSYewW3b4Z75nIXZQm1lvvTmz+4ZKUzfyHyF6n9QSNvptqA/MuVBb6+YzhGIK8s
        s5yRM5imlv9yc7Dw==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] mm: Introduce pte_mkwrite_kernel()
Cc:     David Hildenbrand <david@redhat.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Deepak Gupta <debug@rivosinc.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167933036855.5837.3392895917684573434.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     2cdecd5f4a15cb5896ea2ca5a8f9408ceb3653db
Gitweb:        https://git.kernel.org/tip/2cdecd5f4a15cb5896ea2ca5a8f9408ceb3653db
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Sat, 18 Mar 2023 17:15:06 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 20 Mar 2023 09:01:09 -07:00

mm: Introduce pte_mkwrite_kernel()

The x86 Control-flow Enforcement Technology (CET) feature includes a new
type of memory called shadow stack. This shadow stack memory has some
unusual properties, which requires some core mm changes to function
properly.

One of these changes is to allow for pte_mkwrite() to create different
types of writable memory (the existing conventionally writable type and
also the new shadow stack type). Future patches will convert pte_mkwrite()
to take a VMA in order to facilitate this, however there are places in the
kernel where pte_mkwrite() is called outside of the context of a VMA.
These are for kernel memory. So create a new variant called
pte_mkwrite_kernel() and switch the kernel users over to it. Have
pte_mkwrite() and pte_mkwrite_kernel() be the same for now. Future patches
will introduce changes to make pte_mkwrite() take a VMA.

Only do this for architectures that need it because they call pte_mkwrite()
in arch code without an associated VMA. Since it will only currently be
used in arch code, so do not include it in arch_pgtable_helpers.rst.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Deepak Gupta <debug@rivosinc.com>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/lkml/0e29a2d0-08d8-bcd6-ff26-4bea0e4037b0@redhat.com/
Link: https://lore.kernel.org/all/20230319001535.23210-12-rick.p.edgecombe%40intel.com
---
 arch/arm64/include/asm/pgtable.h | 7 ++++++-
 arch/arm64/mm/trans_pgd.c        | 4 ++--
 arch/s390/include/asm/pgtable.h  | 7 ++++++-
 arch/s390/mm/pageattr.c          | 2 +-
 arch/x86/include/asm/pgtable.h   | 7 ++++++-
 arch/x86/xen/mmu_pv.c            | 2 +-
 6 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index b6ba466..cccf888 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -180,13 +180,18 @@ static inline pmd_t set_pmd_bit(pmd_t pmd, pgprot_t prot)
 	return pmd;
 }
 
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_kernel(pte_t pte)
 {
 	pte = set_pte_bit(pte, __pgprot(PTE_WRITE));
 	pte = clear_pte_bit(pte, __pgprot(PTE_RDONLY));
 	return pte;
 }
 
+static inline pte_t pte_mkwrite(pte_t pte)
+{
+	return pte_mkwrite_kernel(pte);
+}
+
 static inline pte_t pte_mkclean(pte_t pte)
 {
 	pte = clear_pte_bit(pte, __pgprot(PTE_DIRTY));
diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
index 4ea2eef..5c07e68 100644
--- a/arch/arm64/mm/trans_pgd.c
+++ b/arch/arm64/mm/trans_pgd.c
@@ -40,7 +40,7 @@ static void _copy_pte(pte_t *dst_ptep, pte_t *src_ptep, unsigned long addr)
 		 * read only (code, rodata). Clear the RDONLY bit from
 		 * the temporary mappings we use during restore.
 		 */
-		set_pte(dst_ptep, pte_mkwrite(pte));
+		set_pte(dst_ptep, pte_mkwrite_kernel(pte));
 	} else if (debug_pagealloc_enabled() && !pte_none(pte)) {
 		/*
 		 * debug_pagealloc will removed the PTE_VALID bit if
@@ -53,7 +53,7 @@ static void _copy_pte(pte_t *dst_ptep, pte_t *src_ptep, unsigned long addr)
 		 */
 		BUG_ON(!pfn_valid(pte_pfn(pte)));
 
-		set_pte(dst_ptep, pte_mkpresent(pte_mkwrite(pte)));
+		set_pte(dst_ptep, pte_mkpresent(pte_mkwrite_kernel(pte)));
 	}
 }
 
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 2c70b4d..d4943f2 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1005,7 +1005,7 @@ static inline pte_t pte_wrprotect(pte_t pte)
 	return set_pte_bit(pte, __pgprot(_PAGE_PROTECT));
 }
 
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_kernel(pte_t pte)
 {
 	pte = set_pte_bit(pte, __pgprot(_PAGE_WRITE));
 	if (pte_val(pte) & _PAGE_DIRTY)
@@ -1013,6 +1013,11 @@ static inline pte_t pte_mkwrite(pte_t pte)
 	return pte;
 }
 
+static inline pte_t pte_mkwrite(pte_t pte)
+{
+	return pte_mkwrite_kernel(pte);
+}
+
 static inline pte_t pte_mkclean(pte_t pte)
 {
 	pte = clear_pte_bit(pte, __pgprot(_PAGE_DIRTY));
diff --git a/arch/s390/mm/pageattr.c b/arch/s390/mm/pageattr.c
index 85195c1..4ee5fe5 100644
--- a/arch/s390/mm/pageattr.c
+++ b/arch/s390/mm/pageattr.c
@@ -96,7 +96,7 @@ static int walk_pte_level(pmd_t *pmdp, unsigned long addr, unsigned long end,
 		if (flags & SET_MEMORY_RO)
 			new = pte_wrprotect(new);
 		else if (flags & SET_MEMORY_RW)
-			new = pte_mkwrite(pte_mkdirty(new));
+			new = pte_mkwrite_kernel(pte_mkdirty(new));
 		if (flags & SET_MEMORY_NX)
 			new = set_pte_bit(new, __pgprot(_PAGE_NOEXEC));
 		else if (flags & SET_MEMORY_X)
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 56eea96..3607f25 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -364,11 +364,16 @@ static inline pte_t pte_mkyoung(pte_t pte)
 	return pte_set_flags(pte, _PAGE_ACCESSED);
 }
 
-static inline pte_t pte_mkwrite(pte_t pte)
+static inline pte_t pte_mkwrite_kernel(pte_t pte)
 {
 	return pte_set_flags(pte, _PAGE_RW);
 }
 
+static inline pte_t pte_mkwrite(pte_t pte)
+{
+	return pte_mkwrite_kernel(pte);
+}
+
 static inline pte_t pte_mkhuge(pte_t pte)
 {
 	return pte_set_flags(pte, _PAGE_PSE);
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index ee29fb5..a23f042 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -150,7 +150,7 @@ void make_lowmem_page_readwrite(void *vaddr)
 	if (pte == NULL)
 		return;		/* vaddr missing */
 
-	ptev = pte_mkwrite(*pte);
+	ptev = pte_mkwrite_kernel(*pte);
 
 	if (HYPERVISOR_update_va_mapping(address, ptev, 0))
 		BUG();
