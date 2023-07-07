Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A5F74AA99
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 07:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjGGFd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 01:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjGGFdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 01:33:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6DFB01BF4;
        Thu,  6 Jul 2023 22:33:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 025DAD75;
        Thu,  6 Jul 2023 22:34:36 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.48.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9B77D3F740;
        Thu,  6 Jul 2023 22:33:49 -0700 (PDT)
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
Subject: [RFC 2/4] arm64/mm: Call pte_sw_mkdirty() while preserving the HW dirty state
Date:   Fri,  7 Jul 2023 11:03:29 +0530
Message-Id: <20230707053331.510041-3-anshuman.khandual@arm.com>
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

pte_mkdirty() creates dirty states both in SW and HW bits which is really
not required either in pte_wrprotect() or pte_modify() for preserving the
HW dirty state. Instead pte_sw_mkdirty() is sufficient.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index fb03be697819..dd20b752ed48 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -244,7 +244,7 @@ static inline pte_t pte_wrprotect(pte_t pte)
 	 * clear), set the PTE_DIRTY bit.
 	 */
 	if (pte_hw_dirty(pte))
-		pte = pte_mkdirty(pte);
+		pte = pte_sw_mkdirty(pte);
 
 	pte = clear_pte_bit(pte, __pgprot(PTE_WRITE));
 	pte = set_pte_bit(pte, __pgprot(PTE_RDONLY));
@@ -855,7 +855,7 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 			      PTE_ATTRINDX_MASK;
 	/* preserve the hardware dirty information */
 	if (pte_hw_dirty(pte))
-		pte = pte_mkdirty(pte);
+		pte = pte_sw_mkdirty(pte);
 	pte_val(pte) = (pte_val(pte) & ~mask) | (pgprot_val(newprot) & mask);
 	return pte;
 }
-- 
2.30.2

