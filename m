Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EE265357F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 18:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbiLURpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 12:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbiLURpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 12:45:01 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41D42611D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 09:44:57 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id z26so24569264lfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 09:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7FIqKDrnuYPUOY6BxbRSJvB6UTorb2a6qA8yexJXh/E=;
        b=NiK7RWvlQXZ8dOj9iWHcMGSJodA9Hf/lFIjKQhzPDf9DMqkZp3h/c7gX7m3+ZbMX8l
         Qu9OkrtUYSt2BBdq4z+DK+4WSjl9QXihlcK7TAJGoA/bbnWdBjeq3gUpJ3MN4AE+JAwB
         PfjfHzbwQrwOsGqWmGPNQVKRx8nKi27gm0nREMD5tLmP3BBBeY+eTyvaQtZU1zKEGzZi
         EvkSokhXUyJXOfu0CMLNP95tHVyzD3nLXWuVMiEM5Dv2NU33FQFYR9ulL1YdY5T4vCsK
         Mx4TNltMVYa31SP37rNDz0K22gPGkfeeRMYOAA2p2SCp00PNtBakk9NFtcTs8bLZDRfk
         HJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7FIqKDrnuYPUOY6BxbRSJvB6UTorb2a6qA8yexJXh/E=;
        b=QY51mQ+cquW/CLyswhzKAG/RLpMOCkDQR1lp6Mv32PDNMe8imQgTAUOw8NWLScccwi
         V+o8LhjLFY4/75wzGdDVcIcSmOO6vUQGNF5TVUZo/4GHNMYIabSuErEvZ/mT+kXeTOxW
         j3fgRXz/Lxt0Yw76VgAbGb3Tw9mYKzPbFYcRHrxUN29+oVBtdSdR3wIIF8LlYBSlf1Zs
         Q2JVFicqEwVjN/xJh0jh8ilev+JdXuwxMtQTDzwILrV8sFbmG1RqLVAH52JnryUYmtc4
         tUnAxRgM0cSbgndRYhVlSW08hjNPh8o1kVdN2pVJG/bsgx30UflgasjgRDg7hft1+2Zs
         OOKQ==
X-Gm-Message-State: AFqh2korvf16g5ug02X0xchuxbUQ8MIVMnKxNurE++GeUqDwJct/sqLj
        PvAAZK7eIw2il41EhRw7F0g=
X-Google-Smtp-Source: AMrXdXsoLv+kqFCeuTy3EBv+oDdqKzEisHULSKtyfyTs0KE5oVC8/Uqy3qIDA0xiJyW9MFSgGMkIYw==
X-Received: by 2002:ac2:5edc:0:b0:4b5:869e:b5ec with SMTP id d28-20020ac25edc000000b004b5869eb5ecmr1843243lfq.61.1671644696112;
        Wed, 21 Dec 2022 09:44:56 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id r18-20020ac252b2000000b004a91d1b3070sm1904915lfm.308.2022.12.21.09.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 09:44:55 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v2 1/3] mm: vmalloc: Avoid of calling __find_vmap_area() twise in __vunmap()
Date:   Wed, 21 Dec 2022 18:44:52 +0100
Message-Id: <20221221174454.1085130-1-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently __vunmap() path calls __find_vmap_area() two times. One on
entry to check that area exists, second time inside remove_vm_area()
function that also performs a new search of VA.

In order to improvie it from a performance point of view we split
remove_vm_area() into two new parts:
  - find_unlink_vmap_area() that does a search and unlink from tree;
  - __remove_vm_area() that does a removing but without searching.

In this case there is no any functional change for remove_vm_area()
whereas vm_remove_mappings(), where a second search happens, switches
to the __remove_vm_area() variant where already detached VA is passed
as a parameter, so there is no need to find it again.

Performance wise, i use test_vmalloc.sh with 32 threads doing alloc
free on a 64-CPUs-x86_64-box:

perf without this patch:
-   31.41%     0.50%  vmalloc_test/10  [kernel.vmlinux]    [k] __vunmap
   - 30.92% __vunmap
      - 17.67% _raw_spin_lock
           native_queued_spin_lock_slowpath
      - 12.33% remove_vm_area
         - 11.79% free_vmap_area_noflush
            - 11.18% _raw_spin_lock
                 native_queued_spin_lock_slowpath
        0.76% free_unref_page

perf with this patch:
-   11.35%     0.13%  vmalloc_test/14  [kernel.vmlinux]    [k] __vunmap
   - 11.23% __vunmap
      - 8.28% find_unlink_vmap_area
         - 7.95% _raw_spin_lock
              7.44% native_queued_spin_lock_slowpath
      - 1.93% free_vmap_area_noflush
         - 0.56% _raw_spin_lock
              0.53% native_queued_spin_lock_slowpath
        0.60% __vunmap_range_noflush

__vunmap() consumes around ~20% less CPU cycles on this test.

Reported-by: Roman Gushchin <roman.gushchin@linux.dev>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 66 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 24 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 9e30f0b39203..28030d2441f1 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1825,9 +1825,11 @@ static void free_vmap_area_noflush(struct vmap_area *va)
 	unsigned long va_start = va->va_start;
 	unsigned long nr_lazy;
 
-	spin_lock(&vmap_area_lock);
-	unlink_va(va, &vmap_area_root);
-	spin_unlock(&vmap_area_lock);
+	if (!list_empty(&va->list)) {
+		spin_lock(&vmap_area_lock);
+		unlink_va(va, &vmap_area_root);
+		spin_unlock(&vmap_area_lock);
+	}
 
 	nr_lazy = atomic_long_add_return((va->va_end - va->va_start) >>
 				PAGE_SHIFT, &vmap_lazy_nr);
@@ -1871,6 +1873,19 @@ struct vmap_area *find_vmap_area(unsigned long addr)
 	return va;
 }
 
+static struct vmap_area *find_unlink_vmap_area(unsigned long addr)
+{
+	struct vmap_area *va;
+
+	spin_lock(&vmap_area_lock);
+	va = __find_vmap_area(addr, &vmap_area_root);
+	if (va)
+		unlink_va(va, &vmap_area_root);
+	spin_unlock(&vmap_area_lock);
+
+	return va;
+}
+
 /*** Per cpu kva allocator ***/
 
 /*
@@ -2591,6 +2606,20 @@ struct vm_struct *find_vm_area(const void *addr)
 	return va->vm;
 }
 
+static struct vm_struct *__remove_vm_area(struct vmap_area *va)
+{
+	struct vm_struct *vm;
+
+	if (!va || !va->vm)
+		return NULL;
+
+	vm = va->vm;
+	kasan_free_module_shadow(vm);
+	free_unmap_vmap_area(va);
+
+	return vm;
+}
+
 /**
  * remove_vm_area - find and remove a continuous kernel virtual area
  * @addr:	    base address
@@ -2607,22 +2636,8 @@ struct vm_struct *remove_vm_area(const void *addr)
 
 	might_sleep();
 
-	spin_lock(&vmap_area_lock);
-	va = __find_vmap_area((unsigned long)addr, &vmap_area_root);
-	if (va && va->vm) {
-		struct vm_struct *vm = va->vm;
-
-		va->vm = NULL;
-		spin_unlock(&vmap_area_lock);
-
-		kasan_free_module_shadow(vm);
-		free_unmap_vmap_area(va);
-
-		return vm;
-	}
-
-	spin_unlock(&vmap_area_lock);
-	return NULL;
+	va = find_unlink_vmap_area((unsigned long) addr);
+	return __remove_vm_area(va);
 }
 
 static inline void set_area_direct_map(const struct vm_struct *area,
@@ -2637,15 +2652,16 @@ static inline void set_area_direct_map(const struct vm_struct *area,
 }
 
 /* Handle removing and resetting vm mappings related to the vm_struct. */
-static void vm_remove_mappings(struct vm_struct *area, int deallocate_pages)
+static void vm_remove_mappings(struct vmap_area *va, int deallocate_pages)
 {
+	struct vm_struct *area = va->vm;
 	unsigned long start = ULONG_MAX, end = 0;
 	unsigned int page_order = vm_area_page_order(area);
 	int flush_reset = area->flags & VM_FLUSH_RESET_PERMS;
 	int flush_dmap = 0;
 	int i;
 
-	remove_vm_area(area->addr);
+	__remove_vm_area(va);
 
 	/* If this is not VM_FLUSH_RESET_PERMS memory, no need for the below. */
 	if (!flush_reset)
@@ -2690,6 +2706,7 @@ static void vm_remove_mappings(struct vm_struct *area, int deallocate_pages)
 static void __vunmap(const void *addr, int deallocate_pages)
 {
 	struct vm_struct *area;
+	struct vmap_area *va;
 
 	if (!addr)
 		return;
@@ -2698,19 +2715,20 @@ static void __vunmap(const void *addr, int deallocate_pages)
 			addr))
 		return;
 
-	area = find_vm_area(addr);
-	if (unlikely(!area)) {
+	va = find_unlink_vmap_area((unsigned long)addr);
+	if (unlikely(!va)) {
 		WARN(1, KERN_ERR "Trying to vfree() nonexistent vm area (%p)\n",
 				addr);
 		return;
 	}
 
+	area = va->vm;
 	debug_check_no_locks_freed(area->addr, get_vm_area_size(area));
 	debug_check_no_obj_freed(area->addr, get_vm_area_size(area));
 
 	kasan_poison_vmalloc(area->addr, get_vm_area_size(area));
 
-	vm_remove_mappings(area, deallocate_pages);
+	vm_remove_mappings(va, deallocate_pages);
 
 	if (deallocate_pages) {
 		int i;
-- 
2.30.2

