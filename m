Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93326B8FB6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjCNKXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCNKWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:22:30 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548089BA73;
        Tue, 14 Mar 2023 03:22:02 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 794554076B3D;
        Tue, 14 Mar 2023 10:14:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 794554076B3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1678788841;
        bh=cYTZ/gmVk3OpdumhLwrj4VTAssL6GMlQFuk7LngrsRk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NELyDBpvQwFHy68bV8QD1zrh4bGl7AhMizmoQ4t78vurCJjaVdPKe69IQdGCaR+3k
         UnR6hH0HLWvrbM01dGZ7RZDk73b0ygR+VzqzdNOpnBldldEVnD2hMO2ZwW6/GW+3LQ
         +hrXCP8D/8tyKVF5+nfuTGAKP2MBmUNNL24N9XjE=
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Evgeniy Baskov <baskov@ispras.ru>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        joeyli <jlee@suse.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v5 05/27] x86/boot: Support 4KB pages for identity mapping
Date:   Tue, 14 Mar 2023 13:13:32 +0300
Message-Id: <7ab57fb851bb0afa3724edf556a1cf24037babbc.1678785672.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1678785672.git.baskov@ispras.ru>
References: <cover.1678785672.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current identity mapping code only supports 2M and 1G pages.
4KB pages are desirable for better memory protection granularity
in compressed kernel code.

Change identity mapping code to support 4KB pages and
memory remapping with different attributes.

Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>

Warnings caused by the previous version were
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202303081758.wjUcKEAW-lkp@intel.com/
---
 arch/x86/include/asm/init.h |   8 +-
 arch/x86/mm/ident_map.c     | 185 +++++++++++++++++++++++++++++-------
 2 files changed, 160 insertions(+), 33 deletions(-)

diff --git a/arch/x86/include/asm/init.h b/arch/x86/include/asm/init.h
index 5f1d3c421f68..d4e790435bac 100644
--- a/arch/x86/include/asm/init.h
+++ b/arch/x86/include/asm/init.h
@@ -8,10 +8,16 @@ struct x86_mapping_info {
 	unsigned long page_flag;	 /* page flag for PMD or PUD entry */
 	unsigned long offset;		 /* ident mapping offset */
 	bool direct_gbpages;		 /* PUD level 1GB page support */
+	bool allow_4kpages;		 /* Allow more granular mappings with 4K pages */
 	unsigned long kernpg_flag;	 /* kernel pagetable flag override */
 };
 
 int kernel_ident_mapping_init(struct x86_mapping_info *info, pgd_t *pgd_page,
-				unsigned long pstart, unsigned long pend);
+			      unsigned long pstart, unsigned long pend);
+pte_t *ident_split_large_pmd(struct x86_mapping_info *info,
+			     pmd_t *pmdp, unsigned long page_addr);
+pmd_t *ident_split_large_pud(struct x86_mapping_info *info,
+			     pud_t *pudp, unsigned long page_addr);
+
 
 #endif /* _ASM_X86_INIT_H */
diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
index 968d7005f4a7..662e794a325d 100644
--- a/arch/x86/mm/ident_map.c
+++ b/arch/x86/mm/ident_map.c
@@ -4,24 +4,127 @@
  * included by both the compressed kernel and the regular kernel.
  */
 
-static void ident_pmd_init(struct x86_mapping_info *info, pmd_t *pmd_page,
-			   unsigned long addr, unsigned long end)
+static void ident_pte_init(struct x86_mapping_info *info, pte_t *pte_page,
+			   unsigned long addr, unsigned long end,
+			   unsigned long flags)
 {
-	addr &= PMD_MASK;
-	for (; addr < end; addr += PMD_SIZE) {
+	addr &= PAGE_MASK;
+	for (; addr < end; addr += PAGE_SIZE) {
+		pte_t *pte = pte_page + pte_index(addr);
+
+		set_pte(pte, __pte((addr - info->offset) | flags));
+	}
+}
+
+pte_t *ident_split_large_pmd(struct x86_mapping_info *info,
+			     pmd_t *pmdp, unsigned long page_addr)
+{
+	unsigned long pmd_addr, page_flags;
+	pte_t *pte;
+
+	pte = (pte_t *)info->alloc_pgt_page(info->context);
+	if (!pte)
+		return NULL;
+
+	pmd_addr = page_addr & PMD_MASK;
+
+	/* Not a large page - clear PSE flag */
+	page_flags = pmd_flags(*pmdp) & ~_PSE;
+	ident_pte_init(info, pte, pmd_addr, pmd_addr + PMD_SIZE, page_flags);
+
+	return pte;
+}
+
+static int ident_pmd_init(struct x86_mapping_info *info, pmd_t *pmd_page,
+			  unsigned long addr, unsigned long end,
+			  unsigned long flags)
+{
+	unsigned long next;
+	bool new_table = 0;
+
+	for (; addr < end; addr = next) {
 		pmd_t *pmd = pmd_page + pmd_index(addr);
+		pte_t *pte;
 
-		if (pmd_present(*pmd))
+		next = (addr & PMD_MASK) + PMD_SIZE;
+		if (next > end)
+			next = end;
+
+		/*
+		 * Use 2M pages if 4k pages are not allowed or
+		 * we are not mapping extra, i.e. address and size are aligned.
+		 */
+
+		if (!info->allow_4kpages ||
+		    (!(addr & ~PMD_MASK) && next == addr + PMD_SIZE)) {
+
+			pmd_t pmdval;
+
+			addr &= PMD_MASK;
+			pmdval = __pmd((addr - info->offset) | flags | _PSE);
+			set_pmd(pmd, pmdval);
 			continue;
+		}
+
+		/*
+		 * If currently mapped page is large, we need to split it.
+		 * The case when we don't can remap 2M page to 2M page
+		 * with different flags is already covered above.
+		 *
+		 * If there's nothing mapped to desired address,
+		 * we need to allocate new page table.
+		 */
 
-		set_pmd(pmd, __pmd((addr - info->offset) | info->page_flag));
+		if (pmd_large(*pmd)) {
+			pte = ident_split_large_pmd(info, pmd, addr);
+			new_table = 1;
+		} else if (!pmd_present(*pmd)) {
+			pte = (pte_t *)info->alloc_pgt_page(info->context);
+			new_table = 1;
+		} else {
+			pte = pte_offset_kernel(pmd, 0);
+			new_table = 0;
+		}
+
+		if (!pte)
+			return -ENOMEM;
+
+		ident_pte_init(info, pte, addr, next, flags);
+
+		if (new_table)
+			set_pmd(pmd, __pmd(__pa(pte) | info->kernpg_flag));
 	}
+
+	return 0;
 }
 
+
+pmd_t *ident_split_large_pud(struct x86_mapping_info *info,
+			     pud_t *pudp, unsigned long page_addr)
+{
+	unsigned long pud_addr, page_flags;
+	pmd_t *pmd;
+
+	pmd = (pmd_t *)info->alloc_pgt_page(info->context);
+	if (!pmd)
+		return NULL;
+
+	pud_addr = page_addr & PUD_MASK;
+
+	/* Not a large page - clear PSE flag */
+	page_flags = pud_flags(*pudp) & ~_PSE;
+	ident_pmd_init(info, pmd, pud_addr, pud_addr + PUD_SIZE, page_flags);
+
+	return pmd;
+}
+
+
 static int ident_pud_init(struct x86_mapping_info *info, pud_t *pud_page,
 			  unsigned long addr, unsigned long end)
 {
 	unsigned long next;
+	bool new_table = 0;
+	int result;
 
 	for (; addr < end; addr = next) {
 		pud_t *pud = pud_page + pud_index(addr);
@@ -31,28 +134,39 @@ static int ident_pud_init(struct x86_mapping_info *info, pud_t *pud_page,
 		if (next > end)
 			next = end;
 
+		/* Use 1G pages only if forced, even if they are supported. */
 		if (info->direct_gbpages) {
 			pud_t pudval;
-
-			if (pud_present(*pud))
-				continue;
+			unsigned long flags;
 
 			addr &= PUD_MASK;
-			pudval = __pud((addr - info->offset) | info->page_flag);
+			flags = info->page_flag | _PSE;
+			pudval = __pud((addr - info->offset) | flags);
+
 			set_pud(pud, pudval);
 			continue;
 		}
 
-		if (pud_present(*pud)) {
+		if (pud_large(*pud)) {
+			pmd = ident_split_large_pud(info, pud, addr);
+			new_table = 1;
+		} else if (!pud_present(*pud)) {
+			pmd = (pmd_t *)info->alloc_pgt_page(info->context);
+			new_table = 1;
+		} else {
 			pmd = pmd_offset(pud, 0);
-			ident_pmd_init(info, pmd, addr, next);
-			continue;
+			new_table = 0;
 		}
-		pmd = (pmd_t *)info->alloc_pgt_page(info->context);
+
 		if (!pmd)
 			return -ENOMEM;
-		ident_pmd_init(info, pmd, addr, next);
-		set_pud(pud, __pud(__pa(pmd) | info->kernpg_flag));
+
+		result = ident_pmd_init(info, pmd, addr, next, info->page_flag);
+		if (result)
+			return result;
+
+		if (new_table)
+			set_pud(pud, __pud(__pa(pmd) | info->kernpg_flag));
 	}
 
 	return 0;
@@ -63,6 +177,7 @@ static int ident_p4d_init(struct x86_mapping_info *info, p4d_t *p4d_page,
 {
 	unsigned long next;
 	int result;
+	bool new_table = 0;
 
 	for (; addr < end; addr = next) {
 		p4d_t *p4d = p4d_page + p4d_index(addr);
@@ -72,15 +187,14 @@ static int ident_p4d_init(struct x86_mapping_info *info, p4d_t *p4d_page,
 		if (next > end)
 			next = end;
 
-		if (p4d_present(*p4d)) {
+		if (!p4d_present(*p4d)) {
+			pud = (pud_t *)info->alloc_pgt_page(info->context);
+			new_table = 1;
+		} else {
 			pud = pud_offset(p4d, 0);
-			result = ident_pud_init(info, pud, addr, next);
-			if (result)
-				return result;
-
-			continue;
+			new_table = 0;
 		}
-		pud = (pud_t *)info->alloc_pgt_page(info->context);
+
 		if (!pud)
 			return -ENOMEM;
 
@@ -88,19 +202,22 @@ static int ident_p4d_init(struct x86_mapping_info *info, p4d_t *p4d_page,
 		if (result)
 			return result;
 
-		set_p4d(p4d, __p4d(__pa(pud) | info->kernpg_flag));
+		if (new_table)
+			set_p4d(p4d, __p4d(__pa(pud) | info->kernpg_flag));
 	}
 
 	return 0;
 }
 
-int kernel_ident_mapping_init(struct x86_mapping_info *info, pgd_t *pgd_page,
-			      unsigned long pstart, unsigned long pend)
+int kernel_ident_mapping_init(struct x86_mapping_info *info,
+			      pgd_t *pgd_page, unsigned long pstart,
+			      unsigned long pend)
 {
 	unsigned long addr = pstart + info->offset;
 	unsigned long end = pend + info->offset;
 	unsigned long next;
 	int result;
+	bool new_table;
 
 	/* Set the default pagetable flags if not supplied */
 	if (!info->kernpg_flag)
@@ -117,20 +234,24 @@ int kernel_ident_mapping_init(struct x86_mapping_info *info, pgd_t *pgd_page,
 		if (next > end)
 			next = end;
 
-		if (pgd_present(*pgd)) {
+		if (!pgd_present(*pgd)) {
+			p4d = (p4d_t *)info->alloc_pgt_page(info->context);
+			new_table = 1;
+		} else {
 			p4d = p4d_offset(pgd, 0);
-			result = ident_p4d_init(info, p4d, addr, next);
-			if (result)
-				return result;
-			continue;
+			new_table = 0;
 		}
 
-		p4d = (p4d_t *)info->alloc_pgt_page(info->context);
 		if (!p4d)
 			return -ENOMEM;
+
 		result = ident_p4d_init(info, p4d, addr, next);
 		if (result)
 			return result;
+
+		if (!new_table)
+			continue;
+
 		if (pgtable_l5_enabled()) {
 			set_pgd(pgd, __pgd(__pa(p4d) | info->kernpg_flag));
 		} else {
-- 
2.39.2

