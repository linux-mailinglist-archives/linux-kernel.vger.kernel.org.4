Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4296A79F5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 04:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjCBDSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 22:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCBDSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 22:18:47 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A79035BA;
        Wed,  1 Mar 2023 19:18:46 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36F511FB;
        Wed,  1 Mar 2023 19:19:29 -0800 (PST)
Received: from a077893.blr.arm.com (unknown [10.162.41.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 92D323F99C;
        Wed,  1 Mar 2023 19:18:42 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     david@redhat.com, mike.kravetz@oracle.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] mm/debug_vm_pgtable: Replace pte_mkhuge() with arch_make_huge_pte()
Date:   Thu,  2 Mar 2023 08:48:33 +0530
Message-Id: <20230302031833.360679-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the following commit arch_make_huge_pte() should be used directly in
generic memory subsystem as a platform provided page table helper, instead
of pte_mkhuge(). Change hugetlb_basic_tests() to call arch_make_huge_pte()
directly, and update its relevant documentation entry as required.

'commit 16785bd77431 ("mm: merge pte_mkhuge() call into arch_make_huge_pte()")'

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Reported-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Link: https://lore.kernel.org/all/1ea45095-0926-a56a-a273-816709e9075e@csgroup.eu/
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on latest mainline.

 Documentation/mm/arch_pgtable_helpers.rst | 2 +-
 mm/debug_vm_pgtable.c                     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/mm/arch_pgtable_helpers.rst b/Documentation/mm/arch_pgtable_helpers.rst
index 30d9a09f01f4..af3891f895b0 100644
--- a/Documentation/mm/arch_pgtable_helpers.rst
+++ b/Documentation/mm/arch_pgtable_helpers.rst
@@ -214,7 +214,7 @@ HugeTLB Page Table Helpers
 +---------------------------+--------------------------------------------------+
 | pte_huge                  | Tests a HugeTLB                                  |
 +---------------------------+--------------------------------------------------+
-| pte_mkhuge                | Creates a HugeTLB                                |
+| arch_make_huge_pte        | Creates a HugeTLB                                |
 +---------------------------+--------------------------------------------------+
 | huge_pte_dirty            | Tests a dirty HugeTLB                            |
 +---------------------------+--------------------------------------------------+
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index af59cc7bd307..92bed5bd5879 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -934,7 +934,7 @@ static void __init hugetlb_basic_tests(struct pgtable_debug_args *args)
 #ifdef CONFIG_ARCH_WANT_GENERAL_HUGETLB
 	pte = pfn_pte(args->fixed_pmd_pfn, args->page_prot);
 
-	WARN_ON(!pte_huge(pte_mkhuge(pte)));
+	WARN_ON(!pte_huge(arch_make_huge_pte(pte)));
 #endif /* CONFIG_ARCH_WANT_GENERAL_HUGETLB */
 }
 #else  /* !CONFIG_HUGETLB_PAGE */
-- 
2.30.2

