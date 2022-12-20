Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E0A65262D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 19:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbiLTS1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 13:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbiLTS1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 13:27:10 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60152DC6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 10:27:08 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id j4so19964153lfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 10:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=al6BhI4srzCs1FPe4+yTumkcC9D7WK89QS4j43wccGo=;
        b=He4LSkfftmKDRS5QkA1CHeTe2kxMW4ulbRyZLHgaRHwJpmli8nEsB8nhk0unOX8AwH
         2cyOvpiA9souQmUDOKwNyAeak6kcvuR/lyUn39+tCY53FnYkaHZqhCIXdQaMiTOtca+y
         y82yKp0un3QQE6s0pQz74OZ4WrUzX59kDfmGepGdtvtoBcoO1DXIoM+Zkby+Arbpki+W
         griVbhtqtjHd7tcrmPadRLvswFVF/CL3Mny5BP9ATQkcge/SUzjPE+W4cMxTJpT0N9p0
         lWJ1L2iB23C70e1sngYS7nMjW5RHx2Wv1rqcS5Jzsnj5kZfAJMPMtSUhXt0RGUYMxBWh
         HyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=al6BhI4srzCs1FPe4+yTumkcC9D7WK89QS4j43wccGo=;
        b=VqG0mhapiTP61um6MX67ctuIotMVT9EI4V5EZkV2oxjW9PNLV0mK4hiwDNVIeYvG6Z
         mGWTCLumD0YdL0DXYVGIP//wnRJBLH8WBcY/dn63JA3JNrp/Q/KlZmTYENp5BcViH4Jl
         MNkcA3HGt8FHQsGV6nUkBwh4xm67XeylSmLCA8+t71eCNWCHhq8l+Td1JIBnbdiYjSBi
         1DEWwclwrB0PHjhmeQIipe0/5LCmEJV4koLL0QYKjCyLZWLj0lnt+McAVzZ871ZFweb6
         9Ga/xopS5geoa9DjVFuksAyOeDMNJZ8gD7OZewnfyquWIxZmVgC7B9iUcxJXvi2b/jhm
         SEdA==
X-Gm-Message-State: ANoB5pmlVrlD0kcvznAseiQw2a9ifufmU/irTCXFjIsBXZ7J/Ds7bCjZ
        23mYfDzRsaU9gsRUxsrvAz0=
X-Google-Smtp-Source: AA0mqf5bsLcJzPxHFQJ+drM/vi0aDKZw6r3yWC0LCOZJr+LNEMBjAetLFsvy96VuxR+YKa3lFTUudg==
X-Received: by 2002:a05:6512:3a8b:b0:4b5:6d8d:b4cd with SMTP id q11-20020a0565123a8b00b004b56d8db4cdmr16237780lfu.54.1671560827012;
        Tue, 20 Dec 2022 10:27:07 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id v17-20020a056512349100b004bc1dd05351sm1538176lfr.206.2022.12.20.10.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 10:27:06 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 1/2] mm: vmalloc: Avoid a double lookup of freed VA in a tree
Date:   Tue, 20 Dec 2022 19:27:03 +0100
Message-Id: <20221220182704.181657-1-urezki@gmail.com>
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

When a VA is freed over a main path, for example by invoking
the vfree() function, a tree is accessed two times what is odd:

vfree():
  __vunmap()
    __find_vmap_area()
  vm_remove_mappings()
    remove_vm_area()
      __find_vmap_area()

__find_vmap_area() are called two times. Fix it by introducing
a find_unlink_vmap_area() helper that finds and un-links a VA
from a tree.

Performance test results on a single CPU:

- fix_size_alloc_test       loops: 1000000 avg: 476847   usec
- full_fit_alloc_test       loops: 1000000 avg: 806746   usec
- long_busy_list_alloc_test loops: 1000000 avg: 13552093 usec
- random_size_alloc_test    loops: 1000000 avg: 7441322  usec
- fix_align_alloc_test      loops: 1000000 avg: 1411132  usec
All test took worker0=87650866284 cycles

- fix_size_alloc_test       loops: 1000000 avg: 490713   usec
- full_fit_alloc_test       loops: 1000000 avg: 579162   usec
- long_busy_list_alloc_test loops: 1000000 avg: 10485448 usec
- random_size_alloc_test    loops: 1000000 avg: 5824449  usec
- fix_align_alloc_test      loops: 1000000 avg: 984735   usec
All test took worker0=67952362802 cycles

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 9e30f0b39203..0fc38c36e0df 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1825,9 +1825,14 @@ static void free_vmap_area_noflush(struct vmap_area *va)
 	unsigned long va_start = va->va_start;
 	unsigned long nr_lazy;
 
-	spin_lock(&vmap_area_lock);
-	unlink_va(va, &vmap_area_root);
-	spin_unlock(&vmap_area_lock);
+	/*
+	 * A free_vmap_block() is left. It is NOT a main free path.
+	 */
+	if (!list_empty(&va->list)) {
+		spin_lock(&vmap_area_lock);
+		unlink_va(va, &vmap_area_root);
+		spin_unlock(&vmap_area_lock);
+	}
 
 	nr_lazy = atomic_long_add_return((va->va_end - va->va_start) >>
 				PAGE_SHIFT, &vmap_lazy_nr);
@@ -1871,6 +1876,19 @@ struct vmap_area *find_vmap_area(unsigned long addr)
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
@@ -2236,7 +2254,7 @@ void vm_unmap_ram(const void *mem, unsigned int count)
 		return;
 	}
 
-	va = find_vmap_area(addr);
+	va = find_unlink_vmap_area(addr);
 	BUG_ON(!va);
 	debug_check_no_locks_freed((void *)va->va_start,
 				    (va->va_end - va->va_start));
@@ -2607,21 +2625,16 @@ struct vm_struct *remove_vm_area(const void *addr)
 
 	might_sleep();
 
-	spin_lock(&vmap_area_lock);
-	va = __find_vmap_area((unsigned long)addr, &vmap_area_root);
-	if (va && va->vm) {
+	va = find_unlink_vmap_area((unsigned long) addr);
+	if (va) {
 		struct vm_struct *vm = va->vm;
 
-		va->vm = NULL;
-		spin_unlock(&vmap_area_lock);
-
 		kasan_free_module_shadow(vm);
 		free_unmap_vmap_area(va);
 
 		return vm;
 	}
 
-	spin_unlock(&vmap_area_lock);
 	return NULL;
 }
 
@@ -2690,6 +2703,7 @@ static void vm_remove_mappings(struct vm_struct *area, int deallocate_pages)
 static void __vunmap(const void *addr, int deallocate_pages)
 {
 	struct vm_struct *area;
+	struct vmap_area *va;
 
 	if (!addr)
 		return;
@@ -2698,7 +2712,9 @@ static void __vunmap(const void *addr, int deallocate_pages)
 			addr))
 		return;
 
-	area = find_vm_area(addr);
+	va = find_unlink_vmap_area((unsigned long)addr);
+	area = va->vm;
+
 	if (unlikely(!area)) {
 		WARN(1, KERN_ERR "Trying to vfree() nonexistent vm area (%p)\n",
 				addr);
-- 
2.30.2

