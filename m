Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670AF615F32
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbiKBJNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbiKBJMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:12:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3194A286E6;
        Wed,  2 Nov 2022 02:12:38 -0700 (PDT)
Date:   Wed, 02 Nov 2022 09:12:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667380356;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=UTRMnIUFtASuDW2MFV2J+C2GgauHuL37XW04cvm+iPE=;
        b=GdURiOSsDodf8IQ2tlac0ECKytGBm8Fzd63tAXDS+h3d2IG0ehYDliEHPIUwLQjc9q0RW4
        8JoMfaxaFREovoCH/TiPsMKbM7rWNRZ5ABzEDxSD2BNI64FKzdRzJdSNfRrg/Lclo/7ovD
        ITDSuk7yW4HMyOH4HXr7i6TqIs4zh6EckTGFkPqPyDcfM7lkYnuw0ZLs7My/2kjdbg5DJy
        pw/mrUmjlyEdQnNxYteaMXk0jPV2jcC9SS2fS1Kpel/adbyM72N2hgjYfznClIrBep5xM6
        iQ16AlaKg7l/REzhZ7C2yeKrVVvc4XjPAOZqnE6+7UtvfK8hPaiXQylATgX6ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667380356;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=UTRMnIUFtASuDW2MFV2J+C2GgauHuL37XW04cvm+iPE=;
        b=CE2rFq1cliwpXk+ULBGF1jJKoSFBLSq8wce/l3i2Gnq+GjdIPaiEqWAuG7mdF+UIbShGni
        GmiJV77Rnp+vVQCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86_64: Remove pointless set_64bit() usage
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166738035515.7716.8696362559569893592.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     0475a2d10fc7ced3268cd0f0551390b5858f90cd
Gitweb:        https://git.kernel.org/tip/0475a2d10fc7ced3268cd0f0551390b5858f90cd
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 21 Oct 2022 14:11:38 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Nov 2022 13:44:04 +01:00

x86_64: Remove pointless set_64bit() usage

The use of set_64bit() in X86_64 only code is pretty pointless, seeing
how it's a direct assignment. Remove all this nonsense.

Additionally, since x86_64 unconditionally has HAVE_CMPXCHG_DOUBLE,
there is no point in even having that fallback.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20221022114425.168036718%40infradead.org
---
 arch/um/include/asm/pgtable-3level.h |  8 --------
 arch/x86/include/asm/cmpxchg_64.h    |  5 -----
 drivers/iommu/intel/irq_remapping.c  | 10 ++--------
 3 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/arch/um/include/asm/pgtable-3level.h b/arch/um/include/asm/pgtable-3level.h
index cb896e6..8a5032e 100644
--- a/arch/um/include/asm/pgtable-3level.h
+++ b/arch/um/include/asm/pgtable-3level.h
@@ -58,11 +58,7 @@
 #define pud_populate(mm, pud, pmd) \
 	set_pud(pud, __pud(_PAGE_TABLE + __pa(pmd)))
 
-#ifdef CONFIG_64BIT
-#define set_pud(pudptr, pudval) set_64bit((u64 *) (pudptr), pud_val(pudval))
-#else
 #define set_pud(pudptr, pudval) (*(pudptr) = (pudval))
-#endif
 
 static inline int pgd_newpage(pgd_t pgd)
 {
@@ -71,11 +67,7 @@ static inline int pgd_newpage(pgd_t pgd)
 
 static inline void pgd_mkuptodate(pgd_t pgd) { pgd_val(pgd) &= ~_PAGE_NEWPAGE; }
 
-#ifdef CONFIG_64BIT
-#define set_pmd(pmdptr, pmdval) set_64bit((u64 *) (pmdptr), pmd_val(pmdval))
-#else
 #define set_pmd(pmdptr, pmdval) (*(pmdptr) = (pmdval))
-#endif
 
 static inline void pud_clear (pud_t *pud)
 {
diff --git a/arch/x86/include/asm/cmpxchg_64.h b/arch/x86/include/asm/cmpxchg_64.h
index 250187a..0d3beb2 100644
--- a/arch/x86/include/asm/cmpxchg_64.h
+++ b/arch/x86/include/asm/cmpxchg_64.h
@@ -2,11 +2,6 @@
 #ifndef _ASM_X86_CMPXCHG_64_H
 #define _ASM_X86_CMPXCHG_64_H
 
-static inline void set_64bit(volatile u64 *ptr, u64 val)
-{
-	*ptr = val;
-}
-
 #define arch_cmpxchg64(ptr, o, n)					\
 ({									\
 	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 5962bb5..4216caf 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -173,7 +173,6 @@ static int modify_irte(struct irq_2_iommu *irq_iommu,
 	index = irq_iommu->irte_index + irq_iommu->sub_handle;
 	irte = &iommu->ir_table->base[index];
 
-#if defined(CONFIG_HAVE_CMPXCHG_DOUBLE)
 	if ((irte->pst == 1) || (irte_modified->pst == 1)) {
 		bool ret;
 
@@ -187,11 +186,6 @@ static int modify_irte(struct irq_2_iommu *irq_iommu,
 		 * same as the old value.
 		 */
 		WARN_ON(!ret);
-	} else
-#endif
-	{
-		set_64bit(&irte->low, irte_modified->low);
-		set_64bit(&irte->high, irte_modified->high);
 	}
 	__iommu_flush_cache(iommu, irte, sizeof(*irte));
 
@@ -249,8 +243,8 @@ static int clear_entries(struct irq_2_iommu *irq_iommu)
 	end = start + (1 << irq_iommu->irte_mask);
 
 	for (entry = start; entry < end; entry++) {
-		set_64bit(&entry->low, 0);
-		set_64bit(&entry->high, 0);
+		WRITE_ONCE(entry->low, 0);
+		WRITE_ONCE(entry->high, 0);
 	}
 	bitmap_release_region(iommu->ir_table->bitmap, index,
 			      irq_iommu->irte_mask);
