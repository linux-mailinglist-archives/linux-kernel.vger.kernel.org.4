Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7B05B308F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiIIHpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbiIIHpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:45:12 -0400
Received: from out199-15.us.a.mail.aliyun.com (out199-15.us.a.mail.aliyun.com [47.90.199.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A5F132068
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 00:41:46 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VP8T26d_1662709098;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VP8T26d_1662709098)
          by smtp.aliyun-inc.com;
          Fri, 09 Sep 2022 15:38:19 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH V1] mm: remove update_mmu_cache() when page is zero page
Date:   Fri,  9 Sep 2022 15:38:15 +0800
Message-Id: <20220909073815.90046-1-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The zero page is never written to, so it will never has any dirty cache
lines, and therefore there no need to be flushed.

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 mm/huge_memory.c | 1 -
 mm/memory.c      | 5 ++++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 8a7c1b344abe..679eb425e54f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -821,7 +821,6 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 			} else {
 				set_huge_zero_page(pgtable, vma->vm_mm, vma,
 						   haddr, vmf->pmd, zero_page);
-				update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
 				spin_unlock(vmf->ptl);
 			}
 		} else {
diff --git a/mm/memory.c b/mm/memory.c
index 4ba73f5aa8bb..3650e7cae26f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4034,6 +4034,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	struct page *page;
 	vm_fault_t ret = 0;
 	pte_t entry;
+	bool is_zero_page = false;

 	/* File mapping without ->vm_ops ? */
 	if (vma->vm_flags & VM_SHARED)
@@ -4075,6 +4076,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 			pte_unmap_unlock(vmf->pte, vmf->ptl);
 			return handle_userfault(vmf, VM_UFFD_MISSING);
 		}
+		is_zero_page = true;
 		goto setpte;
 	}

@@ -4126,7 +4128,8 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);

 	/* No need to invalidate - it was non-present before */
-	update_mmu_cache(vma, vmf->address, vmf->pte);
+	if (!is_zero_page)
+		update_mmu_cache(vma, vmf->address, vmf->pte);
 unlock:
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 	return ret;
--
2.31.0
