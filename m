Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA9F74AA98
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 07:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjGGFd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 01:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjGGFdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 01:33:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 41925171D;
        Thu,  6 Jul 2023 22:33:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C82591063;
        Thu,  6 Jul 2023 22:34:30 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.48.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ACB703F740;
        Thu,  6 Jul 2023 22:33:44 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [RFC 1/4] arm64/mm: Add SW and HW dirty state helpers
Date:   Fri,  7 Jul 2023 11:03:28 +0530
Message-Id: <20230707053331.510041-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230707053331.510041-1-anshuman.khandual@arm.com>
References: <20230707053331.510041-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This factors out low level SW and HW state changes i.e make and clear into
separate helpers making them explicit improving readability. This also adds
pte_rdonly() helper as well. No functional change is intended.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 52 ++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 0bd18de9fd97..fb03be697819 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -103,6 +103,7 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
 #define pte_young(pte)		(!!(pte_val(pte) & PTE_AF))
 #define pte_special(pte)	(!!(pte_val(pte) & PTE_SPECIAL))
 #define pte_write(pte)		(!!(pte_val(pte) & PTE_WRITE))
+#define pte_rdonly(pte)		(!!(pte_val(pte) & PTE_RDONLY))
 #define pte_user(pte)		(!!(pte_val(pte) & PTE_USER))
 #define pte_user_exec(pte)	(!(pte_val(pte) & PTE_UXN))
 #define pte_cont(pte)		(!!(pte_val(pte) & PTE_CONT))
@@ -120,7 +121,7 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
 	(__boundary - 1 < (end) - 1) ? __boundary : (end);			\
 })
 
-#define pte_hw_dirty(pte)	(pte_write(pte) && !(pte_val(pte) & PTE_RDONLY))
+#define pte_hw_dirty(pte)	(pte_write(pte) && !pte_rdonly(pte))
 #define pte_sw_dirty(pte)	(!!(pte_val(pte) & PTE_DIRTY))
 #define pte_dirty(pte)		(pte_sw_dirty(pte) || pte_hw_dirty(pte))
 
@@ -174,6 +175,39 @@ static inline pmd_t clear_pmd_bit(pmd_t pmd, pgprot_t prot)
 	return pmd;
 }
 
+static inline pte_t pte_hw_mkdirty(pte_t pte)
+{
+	if (pte_write(pte))
+		pte = clear_pte_bit(pte, __pgprot(PTE_RDONLY));
+
+	return pte;
+}
+
+static inline pte_t pte_sw_mkdirty(pte_t pte)
+{
+	return set_pte_bit(pte, __pgprot(PTE_DIRTY));
+}
+
+static inline __always_unused pte_t pte_hw_clr_dirty(pte_t pte)
+{
+	return set_pte_bit(pte, __pgprot(PTE_RDONLY));
+}
+
+static inline pte_t pte_sw_clr_dirty(pte_t pte)
+{
+	pte = clear_pte_bit(pte, __pgprot(PTE_DIRTY));
+
+	/*
+	 * Clearing the software dirty state requires clearing
+	 * the PTE_DIRTY bit along with setting the PTE_RDONLY
+	 * ensuring a page fault on subsequent write access.
+	 *
+	 * NOTE: Setting the PTE_RDONLY (as a coincident) also
+	 * implies clearing the HW dirty state.
+	 */
+	return set_pte_bit(pte, __pgprot(PTE_RDONLY));
+}
+
 static inline pmd_t set_pmd_bit(pmd_t pmd, pgprot_t prot)
 {
 	pmd_val(pmd) |= pgprot_val(prot);
@@ -189,19 +223,17 @@ static inline pte_t pte_mkwrite(pte_t pte)
 
 static inline pte_t pte_mkclean(pte_t pte)
 {
-	pte = clear_pte_bit(pte, __pgprot(PTE_DIRTY));
-	pte = set_pte_bit(pte, __pgprot(PTE_RDONLY));
-
-	return pte;
+	/*
+	 * Subsequent call to pte_hw_clr_dirty() is not required
+	 * because pte_sw_clr_dirty() in turn does that as well.
+	 */
+	return pte_sw_clr_dirty(pte);
 }
 
 static inline pte_t pte_mkdirty(pte_t pte)
 {
-	pte = set_pte_bit(pte, __pgprot(PTE_DIRTY));
-
-	if (pte_write(pte))
-		pte = clear_pte_bit(pte, __pgprot(PTE_RDONLY));
-
+	pte = pte_sw_mkdirty(pte);
+	pte = pte_hw_mkdirty(pte);
 	return pte;
 }
 
-- 
2.30.2

