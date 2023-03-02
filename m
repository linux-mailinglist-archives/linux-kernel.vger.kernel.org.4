Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689146A79B4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 03:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjCBCyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 21:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjCBCyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 21:54:12 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B68AA474D8
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 18:54:10 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99FCB1FB;
        Wed,  1 Mar 2023 18:54:53 -0800 (PST)
Received: from a077893.blr.arm.com (unknown [10.162.41.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C7E9A3F99C;
        Wed,  1 Mar 2023 18:54:07 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     david@redhat.com, mike.kravetz@oracle.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] mm/migrate: Drop pte_mkhuge() in remove_migration_pte()
Date:   Thu,  2 Mar 2023 08:23:49 +0530
Message-Id: <20230302025349.358341-1-anshuman.khandual@arm.com>
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

Since the following commit, arch_make_huge_pte() should be used directly in
generic memory subsystem as a platform provided page table helper, instead
of pte_mkhuge(). This just drops pte_mkhuge() from remove_migration_pte(),
which has now become redundant.

'commit 16785bd77431 ("mm: merge pte_mkhuge() call into arch_make_huge_pte()")'

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Reported-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Link: https://lore.kernel.org/all/1ea45095-0926-a56a-a273-816709e9075e@csgroup.eu/
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on latest mainline.

 mm/migrate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 37865f85df6d..d3964c414010 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -249,7 +249,6 @@ static bool remove_migration_pte(struct folio *folio,
 		if (folio_test_hugetlb(folio)) {
 			unsigned int shift = huge_page_shift(hstate_vma(vma));
 
-			pte = pte_mkhuge(pte);
 			pte = arch_make_huge_pte(pte, shift, vma->vm_flags);
 			if (folio_test_anon(folio))
 				hugepage_add_anon_rmap(new, vma, pvmw.address,
-- 
2.30.2

