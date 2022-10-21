Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8BC6074B7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 12:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiJUKMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 06:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJUKMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 06:12:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F212E7AB06
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 03:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666347155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uL1RRyPgPkJis952ZjK0SFPNdUV1Kk+hsw2E/TYMifs=;
        b=ia0n/9LmLL+E7X5Fxzf++n8B2xy0+m31zQQDbijcvPkjmhpAyM8b4IBLEHRWR9J0bJ4iGu
        +omV9NWudGSrEm1e06xzmalRAtjJRki5m/8z+/aIQeDqa2P3xW7+TBp5uHo/ToYjifITXV
        faYl8YAXct/3h5Nw4YlNdEQe0KgoiQM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638--bIND0qnMVShTdrbuDHPqA-1; Fri, 21 Oct 2022 06:12:31 -0400
X-MC-Unique: -bIND0qnMVShTdrbuDHPqA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D72186EB31;
        Fri, 21 Oct 2022 10:12:26 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.193.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6896D40D299B;
        Fri, 21 Oct 2022 10:12:07 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 3/9] mm: remove VM_FAULT_WRITE
Date:   Fri, 21 Oct 2022 12:11:35 +0200
Message-Id: <20221021101141.84170-4-david@redhat.com>
In-Reply-To: <20221021101141.84170-1-david@redhat.com>
References: <20221021101141.84170-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All users -- GUP and KSM -- are gone, let's just remove it.

Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm_types.h | 3 ---
 mm/huge_memory.c         | 2 +-
 mm/memory.c              | 9 ++++-----
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 500e536796ca..6bc3baced3e3 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -847,7 +847,6 @@ typedef __bitwise unsigned int vm_fault_t;
  * @VM_FAULT_OOM:		Out Of Memory
  * @VM_FAULT_SIGBUS:		Bad access
  * @VM_FAULT_MAJOR:		Page read from storage
- * @VM_FAULT_WRITE:		Special case for get_user_pages
  * @VM_FAULT_HWPOISON:		Hit poisoned small page
  * @VM_FAULT_HWPOISON_LARGE:	Hit poisoned large page. Index encoded
  *				in upper bits
@@ -868,7 +867,6 @@ enum vm_fault_reason {
 	VM_FAULT_OOM            = (__force vm_fault_t)0x000001,
 	VM_FAULT_SIGBUS         = (__force vm_fault_t)0x000002,
 	VM_FAULT_MAJOR          = (__force vm_fault_t)0x000004,
-	VM_FAULT_WRITE          = (__force vm_fault_t)0x000008,
 	VM_FAULT_HWPOISON       = (__force vm_fault_t)0x000010,
 	VM_FAULT_HWPOISON_LARGE = (__force vm_fault_t)0x000020,
 	VM_FAULT_SIGSEGV        = (__force vm_fault_t)0x000040,
@@ -894,7 +892,6 @@ enum vm_fault_reason {
 	{ VM_FAULT_OOM,                 "OOM" },	\
 	{ VM_FAULT_SIGBUS,              "SIGBUS" },	\
 	{ VM_FAULT_MAJOR,               "MAJOR" },	\
-	{ VM_FAULT_WRITE,               "WRITE" },	\
 	{ VM_FAULT_HWPOISON,            "HWPOISON" },	\
 	{ VM_FAULT_HWPOISON_LARGE,      "HWPOISON_LARGE" },	\
 	{ VM_FAULT_SIGSEGV,             "SIGSEGV" },	\
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1cc4a5f4791e..be13fe55b798 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1379,7 +1379,7 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
 		if (pmdp_set_access_flags(vma, haddr, vmf->pmd, entry, 1))
 			update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
 		spin_unlock(vmf->ptl);
-		return VM_FAULT_WRITE;
+		return 0;
 	}
 
 unlock_fallback:
diff --git a/mm/memory.c b/mm/memory.c
index f88c351aecd4..8e72f703ed99 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3242,7 +3242,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 	}
 
 	delayacct_wpcopy_end();
-	return (page_copied && !unshare) ? VM_FAULT_WRITE : 0;
+	return 0;
 oom_free_new:
 	put_page(new_page);
 oom:
@@ -3306,14 +3306,14 @@ static vm_fault_t wp_pfn_shared(struct vm_fault *vmf)
 		return finish_mkwrite_fault(vmf);
 	}
 	wp_page_reuse(vmf);
-	return VM_FAULT_WRITE;
+	return 0;
 }
 
 static vm_fault_t wp_page_shared(struct vm_fault *vmf)
 	__releases(vmf->ptl)
 {
 	struct vm_area_struct *vma = vmf->vma;
-	vm_fault_t ret = VM_FAULT_WRITE;
+	vm_fault_t ret = 0;
 
 	get_page(vmf->page);
 
@@ -3464,7 +3464,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
 			return 0;
 		}
 		wp_page_reuse(vmf);
-		return VM_FAULT_WRITE;
+		return 0;
 	} else if (unshare) {
 		/* No anonymous page -> nothing to do. */
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
@@ -3983,7 +3983,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		if (vmf->flags & FAULT_FLAG_WRITE) {
 			pte = maybe_mkwrite(pte_mkdirty(pte), vma);
 			vmf->flags &= ~FAULT_FLAG_WRITE;
-			ret |= VM_FAULT_WRITE;
 		}
 		rmap_flags |= RMAP_EXCLUSIVE;
 	}
-- 
2.37.3

