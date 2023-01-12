Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D95666C41
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237663AbjALISL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239628AbjALIRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:17:53 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB1436319
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 00:17:36 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Nsy6j12wLz16MkP;
        Thu, 12 Jan 2023 16:15:57 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 12 Jan 2023 16:17:32 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <akpm@linux-foundation.org>, <willy@infradead.org>,
        <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next 3/7] mm: memory: convert do_cow_fault to use folios
Date:   Thu, 12 Jan 2023 16:30:02 +0800
Message-ID: <20230112083006.163393-4-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230112083006.163393-1-wangkefeng.wang@huawei.com>
References: <20230112083006.163393-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page functions are converted to corresponding folio functions in
do_cow_fault().

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/memory.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 1cfdb0fd8d79..f29bca499e0d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4507,22 +4507,24 @@ static vm_fault_t do_read_fault(struct vm_fault *vmf)
 static vm_fault_t do_cow_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
+	struct folio *cow_folio, *folio;
 	vm_fault_t ret;
 
 	if (unlikely(anon_vma_prepare(vma)))
 		return VM_FAULT_OOM;
 
-	vmf->cow_page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma, vmf->address);
-	if (!vmf->cow_page)
+	cow_folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vmf->address,
+				    false);
+	if (!cow_folio)
 		return VM_FAULT_OOM;
 
-	if (mem_cgroup_charge(page_folio(vmf->cow_page), vma->vm_mm,
-				GFP_KERNEL)) {
-		put_page(vmf->cow_page);
+	if (mem_cgroup_charge(cow_folio, vma->vm_mm, GFP_KERNEL)) {
+		folio_put(cow_folio);
 		return VM_FAULT_OOM;
 	}
-	cgroup_throttle_swaprate(vmf->cow_page, GFP_KERNEL);
+	folio_throttle_swaprate(cow_folio, GFP_KERNEL);
 
+	vmf->cow_page = &cow_folio->page;
 	ret = __do_fault(vmf);
 	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY)))
 		goto uncharge_out;
@@ -4530,16 +4532,17 @@ static vm_fault_t do_cow_fault(struct vm_fault *vmf)
 		return ret;
 
 	copy_user_highpage(vmf->cow_page, vmf->page, vmf->address, vma);
-	__SetPageUptodate(vmf->cow_page);
+	__folio_mark_uptodate(cow_folio);
 
 	ret |= finish_fault(vmf);
-	unlock_page(vmf->page);
-	put_page(vmf->page);
+	folio = page_folio(vmf->page);
+	folio_unlock(folio);
+	folio_put(folio);
 	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY)))
 		goto uncharge_out;
 	return ret;
 uncharge_out:
-	put_page(vmf->cow_page);
+	folio_put(cow_folio);
 	return ret;
 }
 
-- 
2.35.3

