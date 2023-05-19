Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE23E70A03E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 22:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjESUAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 16:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjESUAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 16:00:02 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828D090
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 12:59:57 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-24e147c206eso2217982a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 12:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684526397; x=1687118397;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sM2EB7NCw7NfgMqqrzYyWFdwz4M2eE9WrGZWFFwFv3Q=;
        b=Uy5gh7plFqIDxIaXvzbz2FWW891KSI0x5cnbCcT/IZcbVc8WG45G06UoARW5CGRcI0
         y6iRd0JZ3hiCts4BW656JSFRQKrR2FVXqJ1bESFVH/3r7xlAZINmrzF8iSJM7VAg7Tfi
         ySi16326cL5FZhktxjPU8z4DP6Wg1SAbsZ8oOCO95rPBzo85rT6A0NtpCmMPJ2VQ0JjB
         a5Dn/yZemKY7xJnPBPPV1Tt6X9H37slBF1/b+0XU9g8if5i3BJc3fGB35LBrxGDnYh5z
         yYG0Y8KS2YgCBq+IMFza1bfT+wvKZ162qCmPMXLt/xKNlmXBZeYVhG+aS9ownhy5uQVP
         Oupg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684526397; x=1687118397;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sM2EB7NCw7NfgMqqrzYyWFdwz4M2eE9WrGZWFFwFv3Q=;
        b=DOL8qT85qAFNomzuQ79tNxgXIbvWmFuAZQ2yAeEoMktJHXWANXNyujkE5KPCxsTuys
         6TDDY1O7GDiEpMQpRpViaRXYkXCNarTDZahSGaF2UFKh5zao8lVFR9qSX2cA8hxpdHG+
         XZoV+K8GfcIUxn4qEf8QzZfseOLZN+CFDHpDK7Aj7QRiNLIT0CZHAZqrKqNkU5T4HrMd
         2KAWTes1Y62IHxqEorWjQHRkcvR1wQUEsQ5IGOl95L7jLI0xsM+wYSOxoxZFvWE/5kWf
         q8BfpZLVn7vCFWklnGz4tChEmw0LFkVqet96ATKOGgcExtOW1CcrDSJ8+KOx61u2l6yU
         2CMQ==
X-Gm-Message-State: AC+VfDwDP17g+x+1mDOi3Oi6HKxyZnpJN3+eyp5A8U5dWJ1ndsUN5YuQ
        cxAoyyRIJiHn6jSqWTEF8MldyKCsthSHbQ==
X-Google-Smtp-Source: ACHHUZ7uw4oIzy93fUnVuA0JSxHld2rgcS476PgaXURhqaQWJFCE0i/oqjMOOOLuIkDZmoI4FcNNtNMVyO1D4w==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:90b:905:b0:253:3b5f:7a16 with SMTP id
 bo5-20020a17090b090500b002533b5f7a16mr844623pjb.1.1684526397005; Fri, 19 May
 2023 12:59:57 -0700 (PDT)
Date:   Fri, 19 May 2023 19:59:49 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Message-ID: <20230519195950.1775656-1-cmllamas@google.com>
Subject: [PATCH] binder: fix UAF of alloc->vma in race with munmap()
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Jann Horn <jannh@google.com>, stable@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ cmllamas: clean forward port from commit 015ac18be7de ("binder: fix
  UAF of alloc->vma in race with munmap()") in 5.10 stable. It is needed
  in mainline after the revert of commit a43cfc87caaf ("android: binder:
  stop saving a pointer to the VMA") as pointed out by Liam. The commit
  log and tags have been tweaked to reflect this. ]

In commit 720c24192404 ("ANDROID: binder: change down_write to
down_read") binder assumed the mmap read lock is sufficient to protect
alloc->vma inside binder_update_page_range(). This used to be accurate
until commit dd2283f2605e ("mm: mmap: zap pages with read mmap_sem in
munmap"), which now downgrades the mmap_lock after detaching the vma
from the rbtree in munmap(). Then it proceeds to teardown and free the
vma with only the read lock held.

This means that accesses to alloc->vma in binder_update_page_range() now
will race with vm_area_free() in munmap() and can cause a UAF as shown
in the following KASAN trace:

  ==================================================================
  BUG: KASAN: use-after-free in vm_insert_page+0x7c/0x1f0
  Read of size 8 at addr ffff16204ad00600 by task server/558

  CPU: 3 PID: 558 Comm: server Not tainted 5.10.150-00001-gdc8dcf942daa #1
  Hardware name: linux,dummy-virt (DT)
  Call trace:
   dump_backtrace+0x0/0x2a0
   show_stack+0x18/0x2c
   dump_stack+0xf8/0x164
   print_address_description.constprop.0+0x9c/0x538
   kasan_report+0x120/0x200
   __asan_load8+0xa0/0xc4
   vm_insert_page+0x7c/0x1f0
   binder_update_page_range+0x278/0x50c
   binder_alloc_new_buf+0x3f0/0xba0
   binder_transaction+0x64c/0x3040
   binder_thread_write+0x924/0x2020
   binder_ioctl+0x1610/0x2e5c
   __arm64_sys_ioctl+0xd4/0x120
   el0_svc_common.constprop.0+0xac/0x270
   do_el0_svc+0x38/0xa0
   el0_svc+0x1c/0x2c
   el0_sync_handler+0xe8/0x114
   el0_sync+0x180/0x1c0

  Allocated by task 559:
   kasan_save_stack+0x38/0x6c
   __kasan_kmalloc.constprop.0+0xe4/0xf0
   kasan_slab_alloc+0x18/0x2c
   kmem_cache_alloc+0x1b0/0x2d0
   vm_area_alloc+0x28/0x94
   mmap_region+0x378/0x920
   do_mmap+0x3f0/0x600
   vm_mmap_pgoff+0x150/0x17c
   ksys_mmap_pgoff+0x284/0x2dc
   __arm64_sys_mmap+0x84/0xa4
   el0_svc_common.constprop.0+0xac/0x270
   do_el0_svc+0x38/0xa0
   el0_svc+0x1c/0x2c
   el0_sync_handler+0xe8/0x114
   el0_sync+0x180/0x1c0

  Freed by task 560:
   kasan_save_stack+0x38/0x6c
   kasan_set_track+0x28/0x40
   kasan_set_free_info+0x24/0x4c
   __kasan_slab_free+0x100/0x164
   kasan_slab_free+0x14/0x20
   kmem_cache_free+0xc4/0x34c
   vm_area_free+0x1c/0x2c
   remove_vma+0x7c/0x94
   __do_munmap+0x358/0x710
   __vm_munmap+0xbc/0x130
   __arm64_sys_munmap+0x4c/0x64
   el0_svc_common.constprop.0+0xac/0x270
   do_el0_svc+0x38/0xa0
   el0_svc+0x1c/0x2c
   el0_sync_handler+0xe8/0x114
   el0_sync+0x180/0x1c0

  [...]
  ==================================================================

To prevent the race above, revert back to taking the mmap write lock
inside binder_update_page_range(). One might expect an increase of mmap
lock contention. However, binder already serializes these calls via top
level alloc->mutex. Also, there was no performance impact shown when
running the binder benchmark tests.

Fixes: c0fd2101781e ("Revert "android: binder: stop saving a pointer to the VMA"")
Fixes: dd2283f2605e ("mm: mmap: zap pages with read mmap_sem in munmap")
Reported-by: Jann Horn <jannh@google.com>
Closes: https://lore.kernel.org/all/20230518144052.xkj6vmddccq4v66b@revolver
Cc: <stable@vger.kernel.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
Acked-by: Todd Kjos <tkjos@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/android/binder_alloc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index e7c9d466f8e8..662a2a2e2e84 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -212,7 +212,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 		mm = alloc->mm;
 
 	if (mm) {
-		mmap_read_lock(mm);
+		mmap_write_lock(mm);
 		vma = alloc->vma;
 	}
 
@@ -270,7 +270,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 		trace_binder_alloc_page_end(alloc, index);
 	}
 	if (mm) {
-		mmap_read_unlock(mm);
+		mmap_write_unlock(mm);
 		mmput(mm);
 	}
 	return 0;
@@ -303,7 +303,7 @@ static int binder_update_page_range(struct binder_alloc *alloc, int allocate,
 	}
 err_no_vma:
 	if (mm) {
-		mmap_read_unlock(mm);
+		mmap_write_unlock(mm);
 		mmput(mm);
 	}
 	return vma ? -ENOMEM : -ESRCH;
-- 
2.40.1.698.g37aff9b760-goog

