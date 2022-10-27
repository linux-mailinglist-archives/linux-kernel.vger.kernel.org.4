Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307A360EDA7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 03:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbiJ0Bzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 21:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbiJ0Bz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 21:55:28 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428497F0B9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 18:55:27 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MyTJw0lVNzHvMP;
        Thu, 27 Oct 2022 09:55:12 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 27 Oct
 2022 09:55:24 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <akpm@linux-foundation.org>, <Liam.Howlett@Oracle.com>,
        <willy@infradead.org>, <catalin.marinas@arm.com>
CC:     <lizetao@huawei.com>, <mike.kravetz@oracle.com>,
        <cmllamas@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Li Zetao <lizetao1@huawei.com>
Subject: [PATCH] mm/mmap: Fix memory leak in mmap_region()
Date:   Thu, 27 Oct 2022 10:58:37 +0800
Message-ID: <20221027025837.136492-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

Fix it by calling fput(vma->vm_file) when arch_validate_flags() or
mas_preallocate() returns an error. And for the beauty of the code,
put fput() under mapping_unmap_writable().

Fixes: d4af56c5c7c6 ("mm: start tracking VMAs with maple tree")
Fixes: c462ac288f2c ("mm: Introduce arch_validate_flags()")
Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 mm/mmap.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index e270057ed04e..8530195b3ec5 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2674,6 +2674,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		error = -EINVAL;
 		if (file)
 			goto close_and_free_vma;
+		else if (vm_flags & VM_SHARED)
+			goto put_vma_file;
 		else
 			goto free_vma;
 	}
@@ -2682,6 +2684,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		error = -ENOMEM;
 		if (file)
 			goto close_and_free_vma;
+		else if (vm_flags & VM_SHARED)
+			goto put_vma_file;
 		else
 			goto free_vma;
 	}
@@ -2746,13 +2750,13 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	if (vma->vm_ops && vma->vm_ops->close)
 		vma->vm_ops->close(vma);
 unmap_and_free_vma:
-	fput(vma->vm_file);
-	vma->vm_file = NULL;
-
 	/* Undo any partial mapping done by a device driver. */
 	unmap_region(mm, mas.tree, vma, prev, next, vma->vm_start, vma->vm_end);
 	if (vm_flags & VM_SHARED)
 		mapping_unmap_writable(file->f_mapping);
+put_vma_file:
+	fput(vma->vm_file);
+	vma->vm_file = NULL;
 free_vma:
 	vm_area_free(vma);
 unacct_error:
-- 
2.31.1

