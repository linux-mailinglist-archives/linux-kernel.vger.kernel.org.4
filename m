Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E2D74AA9B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 07:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbjGGFeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 01:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjGGFeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 01:34:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A5D991FEB;
        Thu,  6 Jul 2023 22:33:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F865D75;
        Thu,  6 Jul 2023 22:34:41 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.48.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C10AE3F740;
        Thu,  6 Jul 2023 22:33:55 -0700 (PDT)
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
Subject: [RFC 3/4] arm64/mm: Add pte_preserve_hw_dirty()
Date:   Fri,  7 Jul 2023 11:03:30 +0530
Message-Id: <20230707053331.510041-4-anshuman.khandual@arm.com>
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

Preserving the HW dirty state via SW PTE dirty bit, should be made explicit
ensuring greater clarity and readability. This adds pte_preserve_hw_dirty()
helper for that effect. No functional change is intended.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index dd20b752ed48..5344e71a58b2 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -237,7 +237,7 @@ static inline pte_t pte_mkdirty(pte_t pte)
 	return pte;
 }
 
-static inline pte_t pte_wrprotect(pte_t pte)
+static inline pte_t pte_preserve_hw_dirty(pte_t pte)
 {
 	/*
 	 * If hardware-dirty (PTE_WRITE/DBM bit set and PTE_RDONLY
@@ -246,6 +246,12 @@ static inline pte_t pte_wrprotect(pte_t pte)
 	if (pte_hw_dirty(pte))
 		pte = pte_sw_mkdirty(pte);
 
+	return pte;
+}
+
+static inline pte_t pte_wrprotect(pte_t pte)
+{
+	pte = pte_preserve_hw_dirty(pte);
 	pte = clear_pte_bit(pte, __pgprot(PTE_WRITE));
 	pte = set_pte_bit(pte, __pgprot(PTE_RDONLY));
 	return pte;
@@ -853,9 +859,7 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 	const pteval_t mask = PTE_USER | PTE_PXN | PTE_UXN | PTE_RDONLY |
 			      PTE_PROT_NONE | PTE_VALID | PTE_WRITE | PTE_GP |
 			      PTE_ATTRINDX_MASK;
-	/* preserve the hardware dirty information */
-	if (pte_hw_dirty(pte))
-		pte = pte_sw_mkdirty(pte);
+	pte = pte_preserve_hw_dirty(pte);
 	pte_val(pte) = (pte_val(pte) & ~mask) | (pgprot_val(newprot) & mask);
 	return pte;
 }
-- 
2.30.2

