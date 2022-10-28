Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719F6610AB8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 08:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiJ1Gv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 02:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiJ1GvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 02:51:06 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BF81A1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 23:48:39 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MzCj13RstzpWHq;
        Fri, 28 Oct 2022 14:45:09 +0800 (CST)
Received: from huawei.com (10.67.175.21) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 28 Oct
 2022 14:48:36 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <liam.howlett@oracle.com>
CC:     <akpm@linux-foundation.org>, <catalin.marinas@arm.com>,
        <cmllamas@google.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <lizetao1@huawei.com>,
        <mike.kravetz@oracle.com>, <willy@infradead.org>
Subject: [PATCH v2] mm/mmap: Fix memory leak in mmap_region()
Date:   Fri, 28 Oct 2022 15:37:17 +0800
Message-ID: <20221028073717.1179380-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221027073029.dyo2p2kearlutizq@revolver>
References: <20221027073029.dyo2p2kearlutizq@revolver>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.21]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a memory leak reported by kmemleak:

  unreferenced object 0xffff88817231ce40 (size 224):
    comm "mount.cifs", pid 19308, jiffies 4295917571 (age 405.880s)
    hex dump (first 32 bytes):
      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
      60 c0 b2 00 81 88 ff ff 98 83 01 42 81 88 ff ff  `..........B....
    backtrace:
      [<ffffffff81936171>] __alloc_file+0x21/0x250
      [<ffffffff81937051>] alloc_empty_file+0x41/0xf0
      [<ffffffff81937159>] alloc_file+0x59/0x710
      [<ffffffff81937964>] alloc_file_pseudo+0x154/0x210
      [<ffffffff81741dbf>] __shmem_file_setup+0xff/0x2a0
      [<ffffffff817502cd>] shmem_zero_setup+0x8d/0x160
      [<ffffffff817cc1d5>] mmap_region+0x1075/0x19d0
      [<ffffffff817cd257>] do_mmap+0x727/0x1110
      [<ffffffff817518b2>] vm_mmap_pgoff+0x112/0x1e0
      [<ffffffff83adf955>] do_syscall_64+0x35/0x80
      [<ffffffff83c0006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0

The root cause was traced to an error handing path in mmap_region()
when arch_validate_flags() or mas_preallocate() fails. In the shared
anonymous mapping sence, vma will be setuped and mapped with a new
shared anonymous file via shmem_zero_setup(). So in this case, the
file resource needs to be released.

Fix it by calling fput(vma->vm_file) and unmap_region() when
arch_validate_flags() or mas_preallocate() returns an error in
the shared anonymous mapping sence.

Fixes: d4af56c5c7c6 ("mm: start tracking VMAs with maple tree")
Fixes: c462ac288f2c ("mm: Introduce arch_validate_flags()")
Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
v1 was posted at: https://lore.kernel.org/all/20221027025837.136492-1-lizetao1@huawei.com/
v1 -> v2: Drop the new goto label, and jump to unmap_and_free_vma "if (vma->vm_file)"

 mm/mmap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index e270057ed04e..77846d8cf9d4 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2674,6 +2674,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		error = -EINVAL;
 		if (file)
 			goto close_and_free_vma;
+		else if (vma->vm_file)
+			goto unmap_and_free_vma;
 		else
 			goto free_vma;
 	}
@@ -2682,6 +2684,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		error = -ENOMEM;
 		if (file)
 			goto close_and_free_vma;
+		else if (vma->vm_file)
+			goto unmap_and_free_vma;
 		else
 			goto free_vma;
 	}
@@ -2751,7 +2755,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	/* Undo any partial mapping done by a device driver. */
 	unmap_region(mm, mas.tree, vma, prev, next, vma->vm_start, vma->vm_end);
-	if (vm_flags & VM_SHARED)
+	if (file && (vm_flags & VM_SHARED))
 		mapping_unmap_writable(file->f_mapping);
 free_vma:
 	vm_area_free(vma);
-- 
2.25.1

