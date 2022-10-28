Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0247610B43
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 09:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiJ1H1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 03:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJ1H1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 03:27:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9DD1B1555
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:27:17 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MzDdK1CM2zHvRC;
        Fri, 28 Oct 2022 15:27:01 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 28 Oct 2022 15:27:15 +0800
From:   Yuanzheng Song <songyuanzheng@huawei.com>
To:     <sj@kernel.org>, <akpm@linux-foundation.org>
CC:     <damon@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH STABLE 5.15] mm/memory: add non-anonymous page check in the copy_present_page()
Date:   Fri, 28 Oct 2022 07:52:44 +0000
Message-ID: <20221028075244.3112566-1-songyuanzheng@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vma->anon_vma of the child process may be NULL because
the entire vma does not contain anonymous pages. In this
case, a BUG will occur when the copy_present_page() passes
a copy of a non-anonymous page of that vma to the
page_add_new_anon_rmap() to set up new anonymous rmap.

------------[ cut here ]------------
kernel BUG at mm/rmap.c:1052!
Internal error: Oops - BUG: 0 [#1] SMP
Modules linked in:
CPU: 4 PID: 4652 Comm: test Not tainted 5.15.75 #1
Hardware name: linux,dummy-virt (DT)
pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __page_set_anon_rmap+0xc0/0xe8
lr : __page_set_anon_rmap+0xc0/0xe8
sp : ffff80000e773860
x29: ffff80000e773860 x28: fffffc13cf006ec0 x27: ffff04f3ccd68000
x26: ffff04f3c5c33248 x25: 0000000010100073 x24: ffff04f3c53c0a80
x23: 0000000020000000 x22: 0000000000000001 x21: 0000000020000000
x20: fffffc13cf006ec0 x19: 0000000000000000 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000000000 x9 : ffffdddc5581377c
x8 : 0000000000000000 x7 : 0000000000000011 x6 : ffff2717a8433000
x5 : ffff80000e773810 x4 : ffffdddc55400000 x3 : 0000000000000000
x2 : ffffdddc56b20000 x1 : ffff04f3c9a48040 x0 : 0000000000000000
Call trace:
 __page_set_anon_rmap+0xc0/0xe8
 page_add_new_anon_rmap+0x13c/0x200
 copy_pte_range+0x6b8/0x1018
 copy_page_range+0x3a8/0x5e0
 dup_mmap+0x3a0/0x6e8
 dup_mm+0x78/0x140
 copy_process+0x1528/0x1b08
 kernel_clone+0xac/0x610
 __do_sys_clone+0x78/0xb0
 __arm64_sys_clone+0x30/0x40
 invoke_syscall+0x68/0x170
 el0_svc_common.constprop.0+0x80/0x250
 do_el0_svc+0x48/0xb8
 el0_svc+0x48/0x1a8
 el0t_64_sync_handler+0xb0/0xb8
 el0t_64_sync+0x1a0/0x1a4
Code: 97f899f4 f9400273 17ffffeb 97f899f1 (d4210000)
---[ end trace dc65e5edd0f362fa ]---
Kernel panic - not syncing: Oops - BUG: Fatal exception
SMP: stopping secondary CPUs
Kernel Offset: 0x5ddc4d400000 from 0xffff800008000000
PHYS_OFFSET: 0xfffffb0c80000000
CPU features: 0x44000cf1,00000806
Memory Limit: none
---[ end Kernel panic - not syncing: Oops - BUG: Fatal exception ]---

This problem has been fixed by the commit <fb3d824d1a46>
("mm/rmap: split page_dup_rmap() into page_dup_file_rmap()
and page_try_dup_anon_rmap()"), but still exists in the
linux-5.15.y branch.

This patch is not applicable to this version because
of the large version differences. Therefore, fix it by
adding non-anonymous page check in the copy_present_page().

Cc: stable@vger.kernel.org
Fixes: 70e806e4e645 ("mm: Do early cow for pinned pages during fork() for ptes")
Signed-off-by: Yuanzheng Song <songyuanzheng@huawei.com>
---
 mm/memory.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index a4d0f744a458..5f98778cfff2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -903,6 +903,17 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 	if (likely(!page_needs_cow_for_dma(src_vma, page)))
 		return 1;
 
+	/*
+	 * The vma->anon_vma of the child process may be NULL
+	 * because the entire vma does not contain anonymous pages.
+	 * A BUG will occur when the copy_present_page() passes
+	 * a copy of a non-anonymous page of that vma to the
+	 * page_add_new_anon_rmap() to set up new anonymous rmap.
+	 * Return 1 if the page is not an anonymous page.
+	 */
+	if (!PageAnon(page))
+		return 1;
+
 	new_page = *prealloc;
 	if (!new_page)
 		return -EAGAIN;
-- 
2.25.1

