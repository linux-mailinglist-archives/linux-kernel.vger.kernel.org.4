Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0368E60C124
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiJYBie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiJYBhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:37:54 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270DE9E0F2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 18:16:35 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MxDV40xqfzJn9K;
        Tue, 25 Oct 2022 09:13:48 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 09:16:33 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 09:16:32 +0800
From:   Wupeng Ma <mawupeng1@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <songmuchun@bytedance.com>
CC:     <mhocko@suse.com>, <osalvador@suse.de>, <catalin.marinas@arm.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <mawupeng1@huawei.com>
Subject: [PATCH -next 1/1] mm: hugetlb_vmemmap: Fix WARN_ON in vmemmap_remap_pte
Date:   Tue, 25 Oct 2022 09:42:15 +0800
Message-ID: <20221025014215.3466904-1-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ma Wupeng <mawupeng1@huawei.com>

Commit f41f2ed43ca5 ("mm: hugetlb: free the vmemmap pages associated with
each HugeTLB page") add vmemmap_remap_pte to remap the tail pages as
read-only to catch illegal write operation to the tail page.

However this will lead to WARN_ON in arm64 in __check_racy_pte_update()
since this may lead to dirty state cleaned. This check is introduced by
commit 2f4b829c625e ("arm64: Add support for hardware updates of the
access and dirty pte bits") and the initial check is as follow:

  BUG_ON(pte_write(*ptep) && !pte_dirty(pte));

Since we do need to mark this pte as read-only to catch illegal write
operation to the tail pages, use set_pte  to replace set_pte_at to bypass
this check.

The following shell command can be used to reproduce this WARN_ON in
6.1.0-rc1:

  echo 1 > /proc/sys/vm/hugetlb_optimize_vmemmap
  cat /proc/sys/vm/hugetlb_optimize_vmemmap

  echo 1024 > /proc/sys/vm/nr_overcommit_hugepages
  mkdir -p /root/hugetlb
  mount none /root/hugetlb -t hugetlbfs
  fallocate -l 2g /root/hugetlb/xx &

Here is the detail WARN_ON log:

------------[ cut here ]------------
__check_racy_pte_update: racy dirty state clearing: 0x0068000416899f03 -> 0x0060000416898f83
WARNING: CPU: 3 PID: 394 at arch/arm64/include/asm/pgtable.h:318 vmemmap_remap_pte+0x118/0x120
Modules linked in:
CPU: 3 PID: 394 Comm: fallocate Not tainted 6.1.0-rc1 #224
Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
Call trace:
 vmemmap_remap_pte+0x118/0x120
 vmemmap_remap_range+0x30c/0x560
 hugetlb_vmemmap_optimize+0x158/0x408
 __prep_new_huge_page+0x24/0x150
 prep_new_huge_page+0x30/0x60
 alloc_fresh_huge_page+0x1c4/0x1e0
 alloc_surplus_huge_page+0xa0/0x168
 alloc_huge_page+0x264/0x5b8
 hugetlbfs_fallocate+0x294/0x680
 vfs_fallocate+0x12c/0x568
 ksys_fallocate+0x50/0xa0
 __arm64_sys_fallocate+0x28/0x38
 invoke_syscall+0x4c/0x110
 el0_svc_common.constprop.0+0x68/0x128
 do_el0_svc+0x34/0xd0
 el0_svc+0x48/0xb8
 el0t_64_sync_handler+0xb8/0xc0
 el0t_64_sync+0x18c/0x190
---[ end trace 0000000000000000 ]---

Fixes: f41f2ed43ca5 ("mm: hugetlb: free the vmemmap pages associated with each HugeTLB page")
Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
---
 mm/hugetlb_vmemmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index ba2a2596fb4e..cb056265c31e 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -249,7 +249,7 @@ static void vmemmap_remap_pte(pte_t *pte, unsigned long addr,
 	struct page *page = pte_page(*pte);
 
 	list_add_tail(&page->lru, walk->vmemmap_pages);
-	set_pte_at(&init_mm, addr, pte, entry);
+	set_pte(pte, entry);
 }
 
 /*
-- 
2.25.1

