Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B556E812A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 20:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjDSSWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 14:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjDSSWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 14:22:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7B983F6;
        Wed, 19 Apr 2023 11:21:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 180566417A;
        Wed, 19 Apr 2023 18:21:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79A1C433D2;
        Wed, 19 Apr 2023 18:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681928509;
        bh=uXSdIo80daIsIj3rcz4D58UVn7dC1eLHNlCvy7csydk=;
        h=From:To:Cc:Subject:Date:From;
        b=QGhMALOjpQjkIlfYbhy254oioZ4ITd59f35AIwY11yMJcj6rQCI0fpuAk9F8ZGaWU
         +RcJYqF191I/sPZswjuCx0cf2IEBkzZMiHPI4sv87LO82N6gEcPoEZwaqEvQo4SQMn
         oWZ5zsieRgZakR2lwsGtG2/Q31lNKYNpnrYilRM5JdHDXaC0MQYWM8jvs5blATZv7R
         zvvVqISjTcF7yntQidLVON4Yg6RCaSgv62LUaXS/Xd/JqB+tl72WnLcy+BL+EZqLVA
         XwrKRLmRudmwujTCKFtMdONQKJxd41+bnYpBSKmjLQaJxMhbPo7JUWcXL0zjRGhsZO
         30asrtav1XADw==
From:   broonie@kernel.org
To:     David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@alien8.de>,
        Mike Rapoport <rppt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Build failure after merge of the tip tree
Date:   Wed, 19 Apr 2023 19:21:36 +0100
Message-Id: <20230419182136.112974-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

After merging the rcu tree, today's linux-next build (arm64 defconfig)
failed like this:

/tmp/next/build/mm/migrate.c: In function 'remove_migration_pte':
/tmp/next/build/mm/migrate.c:222:31: error: too few arguments to function 'pte_mkwrite'
  222 |                         pte = pte_mkwrite(pte);
      |                               ^~~~~~~~~~~
In file included from /tmp/next/build/include/linux/pgtable.h:6,
                 from /tmp/next/build/include/linux/mm.h:29,
                 from /tmp/next/build/include/linux/migrate.h:5,
                 from /tmp/next/build/mm/migrate.c:16:
/tmp/next/build/arch/arm64/include/asm/pgtable.h:190:21: note: declared here
  190 | static inline pte_t pte_mkwrite(pte_t pte, struct vm_area_struct *vma)
      |                     ^~~~~~~~~~~

Caused by commit

  717f95b494ac36 ("mm: don't check VMA write permissions if the PTE/PMD indicates write permissions")

from the mm tree interacting with

  74fd30bd28e4c7 ("mm: Make pte_mkwrite() take a VMA")

from the tip tree.  I've applied the fixup below

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1cc86d0a669e8..c3cc20c1b26cb 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2235,7 +2235,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		} else {
 			entry = mk_pte(page + i, READ_ONCE(vma->vm_page_prot));
 			if (write)
-				entry = pte_mkwrite(entry);
+				entry = pte_mkwrite(entry, vma);
 			if (anon_exclusive)
 				SetPageAnonExclusive(page + i);
 			if (!young)
@@ -3272,7 +3272,7 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 	if (pmd_swp_soft_dirty(*pvmw->pmd))
 		pmde = pmd_mksoft_dirty(pmde);
 	if (is_writable_migration_entry(entry))
-		pmde = pmd_mkwrite(pmde);
+		pmde = pmd_mkwrite(pmde, vma);
 	if (pmd_swp_uffd_wp(*pvmw->pmd))
 		pmde = pmd_mkuffd_wp(pmde);
 	if (!is_migration_entry_young(entry))
diff --git a/mm/migrate.c b/mm/migrate.c
index 01cac26a31279..8b46b722f1a44 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -219,7 +219,7 @@ static bool remove_migration_pte(struct folio *folio,
 		if (folio_test_dirty(folio) && is_migration_entry_dirty(entry))
 			pte = pte_mkdirty(pte);
 		if (is_writable_migration_entry(entry))
-			pte = pte_mkwrite(pte);
+			pte = pte_mkwrite(pte, vma);
 		else if (pte_swp_uffd_wp(*pvmw.pte))
 			pte = pte_mkuffd_wp(pte);
 
-- 
2.30.2

