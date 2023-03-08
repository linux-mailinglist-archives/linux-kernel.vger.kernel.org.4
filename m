Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A7D6B033B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjCHJmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjCHJmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:42:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA09B7185
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 01:41:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B119B81C0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 09:41:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E84C433D2;
        Wed,  8 Mar 2023 09:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678268500;
        bh=FOZyjqFesuEnEwpUW1WYq+F0fxn2qMQwF+XDs3hZBQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=leVKbWeo/7qOftIstG5B9Wgf9MRXnwDGvaQUihQL6sWuanLYUQozOUwMx4mEYxlep
         SK+6GKBux58RzySSLw+ASPQ2LI0d6QdcBWHG4l2uuE9FqQyRWANesgRaYuCvprRtL2
         994aEBWZuA/D8wD0+MLrSqO/8JSauc/E8A48GBC4UFCF0Mteg/IOFl9IH+v5CGnkmX
         78RxsHHsDeqbtilOWnIuJihopZEwO+M4DIWXi6/YmWDg7iUB7fVn9xfYNiaJ5WWZ4p
         tvTaCpCyYZdmV2vKLa1pPMyu6s3qL5dgi4J4Ywy5j0orqUR0qA92pNM5IFhFjn/keq
         6l9vE6tUdD9qw==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Song Liu <song@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: [RFC PATCH 5/5] EXPERIMENTAL: mm/secretmem: use __GFP_UNMAPPED
Date:   Wed,  8 Mar 2023 11:41:06 +0200
Message-Id: <20230308094106.227365-6-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230308094106.227365-1-rppt@kernel.org>
References: <20230308094106.227365-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 mm/secretmem.c | 26 +-------------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/mm/secretmem.c b/mm/secretmem.c
index 0b502625cd30..f66dfd16a0c3 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -53,7 +53,6 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	pgoff_t offset = vmf->pgoff;
 	gfp_t gfp = vmf->gfp_mask;
-	unsigned long addr;
 	struct page *page;
 	vm_fault_t ret;
 	int err;
@@ -66,38 +65,22 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
 retry:
 	page = find_lock_page(mapping, offset);
 	if (!page) {
-		page = alloc_page(gfp | __GFP_ZERO);
+		page = alloc_page(gfp | __GFP_ZERO | __GFP_UNMAPPED);
 		if (!page) {
 			ret = VM_FAULT_OOM;
 			goto out;
 		}
 
-		err = set_direct_map_invalid_noflush(page);
-		if (err) {
-			put_page(page);
-			ret = vmf_error(err);
-			goto out;
-		}
-
 		__SetPageUptodate(page);
 		err = add_to_page_cache_lru(page, mapping, offset, gfp);
 		if (unlikely(err)) {
 			put_page(page);
-			/*
-			 * If a split of large page was required, it
-			 * already happened when we marked the page invalid
-			 * which guarantees that this call won't fail
-			 */
-			set_direct_map_default_noflush(page);
 			if (err == -EEXIST)
 				goto retry;
 
 			ret = vmf_error(err);
 			goto out;
 		}
-
-		addr = (unsigned long)page_address(page);
-		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
 	}
 
 	vmf->page = page;
@@ -150,15 +133,8 @@ static int secretmem_migrate_folio(struct address_space *mapping,
 	return -EBUSY;
 }
 
-static void secretmem_free_folio(struct folio *folio)
-{
-	set_direct_map_default_noflush(&folio->page);
-	folio_zero_segment(folio, 0, folio_size(folio));
-}
-
 const struct address_space_operations secretmem_aops = {
 	.dirty_folio	= noop_dirty_folio,
-	.free_folio	= secretmem_free_folio,
 	.migrate_folio	= secretmem_migrate_folio,
 };
 
-- 
2.35.1

