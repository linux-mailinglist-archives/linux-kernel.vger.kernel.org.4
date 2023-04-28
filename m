Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89466F14B3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 11:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345978AbjD1J4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 05:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345838AbjD1Jzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 05:55:44 -0400
Received: from out187-18.us.a.mail.aliyun.com (out187-18.us.a.mail.aliyun.com [47.90.187.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3095BBC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 02:55:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047213;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---.STFoGcy_1682675612;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.STFoGcy_1682675612)
          by smtp.aliyun-inc.com;
          Fri, 28 Apr 2023 17:53:33 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Thomas Garnier" <thgarnie@chromium.org>,
        "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Hou Wenlong" <houwenlong.hwl@antgroup.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Juergen Gross" <jgross@suse.com>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>,
        "Mike Rapoport" <rppt@kernel.org>,
        "Josh Poimboeuf" <jpoimboe@kernel.org>,
        "Pasha Tatashin" <pasha.tatashin@soleen.com>
Subject: [PATCH RFC 32/43] x86/boot/64: Use data relocation to get absloute address when PIE is enabled
Date:   Fri, 28 Apr 2023 17:51:12 +0800
Message-Id: <bcdf9c31498fbd143848c15639d0c4fa46d804d6.1682673543.git.houwenlong.hwl@antgroup.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
References: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When PIE is enabled, all symbol references are RIP-relative, so there is
no need to fixup global symbol references when in low address.  However,
in order to acquire absloute virtual address of symbol, introduce a
macro to use data relocation to get it.

Suggested-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: Thomas Garnier <thgarnie@chromium.org>
Cc: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/head64.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 49f7629b17f7..ef7ad96f2154 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -86,10 +86,22 @@ static struct desc_ptr startup_gdt_descr = {
 
 #define __head	__section(".head.text")
 
+#ifdef CONFIG_X86_PIE
+#define SYM_ABS_VAL(sym)	\
+	({ static unsigned long __initdata __##sym = (unsigned long)sym; __##sym; })
+
+static void __head *fixup_pointer(void *ptr, unsigned long physaddr)
+{
+	return ptr;
+}
+#else
+#define SYM_ABS_VAL(sym) ((unsigned long)sym)
+
 static void __head *fixup_pointer(void *ptr, unsigned long physaddr)
 {
 	return ptr - (void *)_text + (void *)physaddr;
 }
+#endif /* CONFIG_X86_PIE */
 
 static unsigned long __head *fixup_long(void *ptr, unsigned long physaddr)
 {
@@ -142,8 +154,8 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
 	 * attribute.
 	 */
 	if (sme_get_me_mask()) {
-		vaddr = (unsigned long)__start_bss_decrypted;
-		vaddr_end = (unsigned long)__end_bss_decrypted;
+		vaddr = SYM_ABS_VAL(__start_bss_decrypted);
+		vaddr_end = SYM_ABS_VAL(__end_bss_decrypted);
 
 		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
 			/*
@@ -189,6 +201,8 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	bool la57;
 	int i;
 	unsigned int *next_pgt_ptr;
+	unsigned long text_base = SYM_ABS_VAL(_text);
+	unsigned long end_base = SYM_ABS_VAL(_end);
 
 	la57 = check_la57_support(physaddr);
 
@@ -200,7 +214,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	 * Compute the delta between the address I am compiled to run at
 	 * and the address I am actually running at.
 	 */
-	load_delta = physaddr - (unsigned long)(_text - __START_KERNEL_map);
+	load_delta = physaddr - (text_base - __START_KERNEL_map);
 
 	/* Is the address not 2M aligned? */
 	if (load_delta & ~PMD_MASK)
@@ -214,9 +228,9 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	pgd = fixup_pointer(&early_top_pgt, physaddr);
 	p = pgd + pgd_index(__START_KERNEL_map);
 	if (la57)
-		*p = (unsigned long)level4_kernel_pgt;
+		*p = SYM_ABS_VAL(level4_kernel_pgt);
 	else
-		*p = (unsigned long)level3_kernel_pgt;
+		*p = SYM_ABS_VAL(level3_kernel_pgt);
 	*p += _PAGE_TABLE_NOENC - __START_KERNEL_map + load_delta;
 
 	if (la57) {
@@ -273,7 +287,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	pmd_entry += sme_get_me_mask();
 	pmd_entry +=  physaddr;
 
-	for (i = 0; i < DIV_ROUND_UP(_end - _text, PMD_SIZE); i++) {
+	for (i = 0; i < DIV_ROUND_UP(end_base - text_base, PMD_SIZE); i++) {
 		int idx = i + (physaddr >> PMD_SHIFT);
 
 		pmd[idx % PTRS_PER_PMD] = pmd_entry + i * PMD_SIZE;
@@ -298,11 +312,11 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	pmd = fixup_pointer(level2_kernel_pgt, physaddr);
 
 	/* invalidate pages before the kernel image */
-	for (i = 0; i < pmd_index((unsigned long)_text); i++)
+	for (i = 0; i < pmd_index(text_base); i++)
 		pmd[i] &= ~_PAGE_PRESENT;
 
 	/* fixup pages that are part of the kernel image */
-	for (; i <= pmd_index((unsigned long)_end); i++)
+	for (; i <= pmd_index(end_base); i++)
 		if (pmd[i] & _PAGE_PRESENT)
 			pmd[i] += load_delta;
 
-- 
2.31.1

