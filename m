Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9BC7339AB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346002AbjFPTUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346077AbjFPTRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:17:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C533C22;
        Fri, 16 Jun 2023 12:17:09 -0700 (PDT)
Date:   Fri, 16 Jun 2023 19:17:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686943027;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=M0FKMtRaAb/6L/OT2t7Srr0MVg7mcTR1I9VcP5NaKAA=;
        b=POx5Z1veLv3wrJ4YH5Qj9T/9kF5iOSC0h1in14QVyYCwwFeKM/ATaJI51GDl1axofYTmVp
        KGxe31LLkU+hR/5+dhy2Sto4gkmRPmuhMXOTX8GqiDiAdG7o/lDnHnpud5DJ7V1i1S4LRt
        iG5MsdMc3XAWw7x+oR2AJzg+wEFEFQK81fv/Foa2yJ80S3c5SkdsfDcjYKYUXLcAEIp+ES
        WWXbd/B0fgb55g/+maGy0mg2ockGYrw+3Ey2GBbwb+NyQdCv/30ZbzqxcOB5De7B9YI4EB
        uTO92HTemsN+TqcfgzJrQIB3wGw/fQiUIXcwdozhBlaORJdl647sof/kFAcgTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686943027;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=M0FKMtRaAb/6L/OT2t7Srr0MVg7mcTR1I9VcP5NaKAA=;
        b=VlS8+WgwhtiP3rkZqjR3n/qJveWgltvvyOfbEe6pqkAWL7hcnraGEsHxjcWLAyVzYGcmik
        36H5YNs7w/s7qDAA==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] mm: Move pte/pmd_mkwrite() callers with no VMA to _novma()
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168694302711.404.15740203946719027823.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     88e48257290d03a14f007cd31d05a0208c7dcfce
Gitweb:        https://git.kernel.org/tip/88e48257290d03a14f007cd31d05a0208c7dcfce
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Mon, 12 Jun 2023 17:10:28 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 15 Jun 2023 16:29:01 -07:00

mm: Move pte/pmd_mkwrite() callers with no VMA to _novma()

The x86 Shadow stack feature includes a new type of memory called shadow
stack. This shadow stack memory has some unusual properties, which requires
some core mm changes to function properly.

One of these unusual properties is that shadow stack memory is writable,
but only in limited ways. These limits are applied via a specific PTE
bit combination. Nevertheless, the memory is writable, and core mm code
will need to apply the writable permissions in the typical paths that
call pte_mkwrite(). Future patches will make pte_mkwrite() take a VMA, so
that the x86 implementation of it can know whether to create regular
writable or shadow stack mappings.

But there are a couple of challenges to this. Modifying the signatures of
each arch pte_mkwrite() implementation would be error prone because some
are generated with macros and would need to be re-implemented. Also, some
pte_mkwrite() callers operate on kernel memory without a VMA.

So this can be done in a three step process. First pte_mkwrite() can be
renamed to pte_mkwrite_novma() in each arch, with a generic pte_mkwrite()
added that just calls pte_mkwrite_novma(). Next callers without a VMA can
be moved to pte_mkwrite_novma(). And lastly, pte_mkwrite() and all callers
can be changed to take/pass a VMA.

Earlier work did the first step, so next move the callers that don't have
a VMA to pte_mkwrite_novma(). Also do the same for pmd_mkwrite().  This
will be ok for the shadow stack feature, as these callers are on kernel
memory which will not need to be made shadow stack, and the other
architectures only currently support one type of memory in pte_mkwrite()

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/all/20230613001108.3040476-3-rick.p.edgecombe%40intel.com
---
 arch/arm64/mm/trans_pgd.c | 4 ++--
 arch/s390/mm/pageattr.c   | 4 ++--
 arch/x86/xen/mmu_pv.c     | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
index 4ea2eef..a01493f 100644
--- a/arch/arm64/mm/trans_pgd.c
+++ b/arch/arm64/mm/trans_pgd.c
@@ -40,7 +40,7 @@ static void _copy_pte(pte_t *dst_ptep, pte_t *src_ptep, unsigned long addr)
 		 * read only (code, rodata). Clear the RDONLY bit from
 		 * the temporary mappings we use during restore.
 		 */
-		set_pte(dst_ptep, pte_mkwrite(pte));
+		set_pte(dst_ptep, pte_mkwrite_novma(pte));
 	} else if (debug_pagealloc_enabled() && !pte_none(pte)) {
 		/*
 		 * debug_pagealloc will removed the PTE_VALID bit if
@@ -53,7 +53,7 @@ static void _copy_pte(pte_t *dst_ptep, pte_t *src_ptep, unsigned long addr)
 		 */
 		BUG_ON(!pfn_valid(pte_pfn(pte)));
 
-		set_pte(dst_ptep, pte_mkpresent(pte_mkwrite(pte)));
+		set_pte(dst_ptep, pte_mkpresent(pte_mkwrite_novma(pte)));
 	}
 }
 
diff --git a/arch/s390/mm/pageattr.c b/arch/s390/mm/pageattr.c
index 5ba3bd8..6931d48 100644
--- a/arch/s390/mm/pageattr.c
+++ b/arch/s390/mm/pageattr.c
@@ -97,7 +97,7 @@ static int walk_pte_level(pmd_t *pmdp, unsigned long addr, unsigned long end,
 		if (flags & SET_MEMORY_RO)
 			new = pte_wrprotect(new);
 		else if (flags & SET_MEMORY_RW)
-			new = pte_mkwrite(pte_mkdirty(new));
+			new = pte_mkwrite_novma(pte_mkdirty(new));
 		if (flags & SET_MEMORY_NX)
 			new = set_pte_bit(new, __pgprot(_PAGE_NOEXEC));
 		else if (flags & SET_MEMORY_X)
@@ -155,7 +155,7 @@ static void modify_pmd_page(pmd_t *pmdp, unsigned long addr,
 	if (flags & SET_MEMORY_RO)
 		new = pmd_wrprotect(new);
 	else if (flags & SET_MEMORY_RW)
-		new = pmd_mkwrite(pmd_mkdirty(new));
+		new = pmd_mkwrite_novma(pmd_mkdirty(new));
 	if (flags & SET_MEMORY_NX)
 		new = set_pmd_bit(new, __pgprot(_SEGMENT_ENTRY_NOEXEC));
 	else if (flags & SET_MEMORY_X)
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index b3b8d28..63fced0 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -150,7 +150,7 @@ void make_lowmem_page_readwrite(void *vaddr)
 	if (pte == NULL)
 		return;		/* vaddr missing */
 
-	ptev = pte_mkwrite(*pte);
+	ptev = pte_mkwrite_novma(*pte);
 
 	if (HYPERVISOR_update_va_mapping(address, ptev, 0))
 		BUG();
