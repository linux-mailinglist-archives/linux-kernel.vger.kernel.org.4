Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C5A6D82D2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238692AbjDEQDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237503AbjDEQD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:03:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8435BB7
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 09:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680710565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9SgMl0U05ydcYM0cFwFg6RkUkX/SVGBlhLdBNLErgqU=;
        b=ZUwcpALrnDcDVCL8viQrg/fVO0rMBki+Oj33nXSdDe5weVBGE78xPM9FrXcMASbqmtlJlW
        vx90AVrjZ/ba/kQzyNwGziHn7XQdg291n5MbeL9ua6hdDdLov+KZi3yAiqisoo5ULODwgr
        KFCRPCxw1AmPjOR6mNCYotdcRbMjieA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-167-QqiIz_h_NguASfvv2dusNA-1; Wed, 05 Apr 2023 12:02:40 -0400
X-MC-Unique: QqiIz_h_NguASfvv2dusNA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 27BE238221CD;
        Wed,  5 Apr 2023 16:02:40 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.195.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD0DF492C14;
        Wed,  5 Apr 2023 16:02:38 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 1/2] mm/userfaultfd: fix uffd-wp handling for THP migration entries
Date:   Wed,  5 Apr 2023 18:02:35 +0200
Message-Id: <20230405160236.587705-2-david@redhat.com>
In-Reply-To: <20230405160236.587705-1-david@redhat.com>
References: <20230405160236.587705-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like what we fixed for hugetlb in commit 44f86392bdd1 ("mm/hugetlb:
fix uffd-wp handling for migration entries in hugetlb_change_protection()")
similarly applies to THP.

Setting/clearing uffd-wp on THP migration entries is not implemented
properly. Further, while removing migration PMDs considers the uffd-wp
bit, inserting migration PMDs does not consider the uffd-wp bit.

We have to set/clear independently of the migration entry type in
change_huge_pmd() and properly copy the uffd-wp bit in
set_pmd_migration_entry().

Verified using a simple reproducer that triggers migration of a THP, that
the set_pmd_migration_entry() no longer loses the uffd-wp bit.

Fixes: f45ec5ff16a7 ("userfaultfd: wp: support swap and page migration")
Reviewed-by: Peter Xu <peterx@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 032fb0ef9cd1..e3706a2b34b2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1838,10 +1838,10 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	if (is_swap_pmd(*pmd)) {
 		swp_entry_t entry = pmd_to_swp_entry(*pmd);
 		struct page *page = pfn_swap_entry_to_page(entry);
+		pmd_t newpmd;
 
 		VM_BUG_ON(!is_pmd_migration_entry(*pmd));
 		if (is_writable_migration_entry(entry)) {
-			pmd_t newpmd;
 			/*
 			 * A protection check is difficult so
 			 * just be safe and disable write
@@ -1855,8 +1855,16 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 				newpmd = pmd_swp_mksoft_dirty(newpmd);
 			if (pmd_swp_uffd_wp(*pmd))
 				newpmd = pmd_swp_mkuffd_wp(newpmd);
-			set_pmd_at(mm, addr, pmd, newpmd);
+		} else {
+			newpmd = *pmd;
 		}
+
+		if (uffd_wp)
+			newpmd = pmd_swp_mkuffd_wp(newpmd);
+		else if (uffd_wp_resolve)
+			newpmd = pmd_swp_clear_uffd_wp(newpmd);
+		if (!pmd_same(*pmd, newpmd))
+			set_pmd_at(mm, addr, pmd, newpmd);
 		goto unlock;
 	}
 #endif
@@ -3251,6 +3259,8 @@ int set_pmd_migration_entry(struct page_vma_mapped_walk *pvmw,
 	pmdswp = swp_entry_to_pmd(entry);
 	if (pmd_soft_dirty(pmdval))
 		pmdswp = pmd_swp_mksoft_dirty(pmdswp);
+	if (pmd_uffd_wp(pmdval))
+		pmdswp = pmd_swp_mkuffd_wp(pmdswp);
 	set_pmd_at(mm, address, pvmw->pmd, pmdswp);
 	page_remove_rmap(page, vma, true);
 	put_page(page);
-- 
2.39.2

