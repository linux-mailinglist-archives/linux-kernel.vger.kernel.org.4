Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1B16DF908
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjDLOxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjDLOxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:53:13 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD543A90
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 07:53:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id o19-20020a254113000000b00b8ed021361bso12702719yba.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 07:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681311184;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CwA0wdGrULC2XXBzkQfVWleO9hyls9jS7CAlyZ8lvMo=;
        b=BGJ19UUT/KQmXwBdHwvfufxanTrfOtkalEb3y2N+im3F2wdY+eRyJvh/ocOo8nqvpt
         uIcfLl18+AYnrHG4kmP2Uz8d6wIAZ9dx8yRd9Umw2JeCcoKxqj5pmjixgiZHtkC2BrgW
         oSHxZTZMW29EHRY01yVSztq5fRm8X1vjMchRqarRQjuPc/GNpryrcg5n7M2vJzY9DhIQ
         +w2LOGFSsfRD4VqKwBlOEX8NzX+CuE3pYgcQxQOePaJ2fG446CSGdzQ2QUOhRZ6jjgRB
         5pEb2j+e+90dkmujhtCU8zi9mrzviRnvG+dSdZyM1nUjKupT6dPf7tEIjh3t5Qb4NvIu
         s4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681311184;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CwA0wdGrULC2XXBzkQfVWleO9hyls9jS7CAlyZ8lvMo=;
        b=6ShHYmWmOJZfT+H4I2mueY5npBG84DwEMMUvefgPk6fRKnzXkxzWAMMOTE/a1wk9zw
         h9DO+EZDK+vbT8G8SeBHgCeuX31PeV/w7Y95NLOsYl6yvV3rz3Dot/jAw2u/VUqnfL2a
         Hzg1W+sZjNEiHpOxwMX+pW2xiVZ+faX3w0ZUsPt7okAJ3YbALvMh/JTSUQXloXGt3wd1
         R2ANpDdSRKghIWM12nC7ym0CcHBtMvtk+uAMQBl3KLi0mRMeixErkrxn27aHZ+iBF0l2
         nzHEe8zp5u4GFyvuWXL/n+9YBwgdKriVAZC/yIfNtzN6qmdmYN5UVykcdQDKeU6eD8Qr
         AWEA==
X-Gm-Message-State: AAQBX9cEMFDdi7VnBgIXWhu+T9tOQZmg/Tp4ZYmNX3Yk84n1gAiKdtf7
        5iGOWrs8ztItf/eSb/cj8hnudUPYh8I=
X-Google-Smtp-Source: AKy350Y9H8x8fkMOv72KbbGnFPvZ5mHfzvPfBgJCLqdyjWcNAGuZGxLlLfr/LwfWgzBFvM7gkBOLd4qRA1E=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:901c:7904:40a1:1b6c])
 (user=glider job=sendgmr) by 2002:a25:c905:0:b0:b77:81f:42dc with SMTP id
 z5-20020a25c905000000b00b77081f42dcmr12063363ybf.1.1681311184657; Wed, 12 Apr
 2023 07:53:04 -0700 (PDT)
Date:   Wed, 12 Apr 2023 16:52:59 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230412145300.3651840-1-glider@google.com>
Subject: [PATCH 1/2] mm: kmsan: handle alloc failures in kmsan_vmap_pages_range_noflush()
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     urezki@gmail.com, hch@infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, elver@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        Dipanjan Das <mail.dipanjan.das@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by Dipanjan Das, when KMSAN is used together with kernel
fault injection (or, generally, even without the latter), calls to
kcalloc() or __vmap_pages_range_noflush() may fail, leaving the
metadata mappings for the virtual mapping in an inconsistent state.
When these metadata mappings are accessed later, the kernel crashes.

To address the problem, we return a non-zero error code from
kmsan_vmap_pages_range_noflush() in the case of any allocation/mapping
failure inside it, and make vmap_pages_range_noflush() return an error
if KMSAN fails to allocate the metadata.

This patch also removes KMSAN_WARN_ON() from vmap_pages_range_noflush(),
as these allocation failures are not fatal anymore.

Reported-by: Dipanjan Das <mail.dipanjan.das@gmail.com>
Link: https://lore.kernel.org/linux-mm/CANX2M5ZRrRA64k0hOif02TjmY9kbbO2aCBPyq79es34RXZ=cAw@mail.gmail.com/
Fixes: b073d7f8aee4 ("mm: kmsan: maintain KMSAN metadata for page operations")
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 include/linux/kmsan.h | 19 ++++++++++---------
 mm/kmsan/shadow.c     | 27 ++++++++++++++++++---------
 mm/vmalloc.c          |  6 +++++-
 3 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
index e38ae3c346184..a0769d4aad1c8 100644
--- a/include/linux/kmsan.h
+++ b/include/linux/kmsan.h
@@ -134,11 +134,12 @@ void kmsan_kfree_large(const void *ptr);
  * @page_shift:	page_shift passed to vmap_range_noflush().
  *
  * KMSAN maps shadow and origin pages of @pages into contiguous ranges in
- * vmalloc metadata address range.
+ * vmalloc metadata address range. Returns 0 on success, callers must check
+ * for non-zero return value.
  */
-void kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
-				    pgprot_t prot, struct page **pages,
-				    unsigned int page_shift);
+int kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
+				   pgprot_t prot, struct page **pages,
+				   unsigned int page_shift);
 
 /**
  * kmsan_vunmap_kernel_range_noflush() - Notify KMSAN about a vunmap.
@@ -281,11 +282,11 @@ static inline void kmsan_kfree_large(const void *ptr)
 {
 }
 
-static inline void kmsan_vmap_pages_range_noflush(unsigned long start,
-						  unsigned long end,
-						  pgprot_t prot,
-						  struct page **pages,
-						  unsigned int page_shift)
+static inline int kmsan_vmap_pages_range_noflush(unsigned long start,
+						 unsigned long end,
+						 pgprot_t prot,
+						 struct page **pages,
+						 unsigned int page_shift)
 {
 }
 
diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
index a787c04e9583c..b8bb95eea5e3d 100644
--- a/mm/kmsan/shadow.c
+++ b/mm/kmsan/shadow.c
@@ -216,27 +216,29 @@ void kmsan_free_page(struct page *page, unsigned int order)
 	kmsan_leave_runtime();
 }
 
-void kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
-				    pgprot_t prot, struct page **pages,
-				    unsigned int page_shift)
+int kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
+				   pgprot_t prot, struct page **pages,
+				   unsigned int page_shift)
 {
 	unsigned long shadow_start, origin_start, shadow_end, origin_end;
 	struct page **s_pages, **o_pages;
-	int nr, mapped;
+	int nr, mapped, err = 0;
 
 	if (!kmsan_enabled)
-		return;
+		return 0;
 
 	shadow_start = vmalloc_meta((void *)start, KMSAN_META_SHADOW);
 	shadow_end = vmalloc_meta((void *)end, KMSAN_META_SHADOW);
 	if (!shadow_start)
-		return;
+		return 0;
 
 	nr = (end - start) / PAGE_SIZE;
 	s_pages = kcalloc(nr, sizeof(*s_pages), GFP_KERNEL);
 	o_pages = kcalloc(nr, sizeof(*o_pages), GFP_KERNEL);
-	if (!s_pages || !o_pages)
+	if (!s_pages || !o_pages) {
+		err = -ENOMEM;
 		goto ret;
+	}
 	for (int i = 0; i < nr; i++) {
 		s_pages[i] = shadow_page_for(pages[i]);
 		o_pages[i] = origin_page_for(pages[i]);
@@ -249,10 +251,16 @@ void kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
 	kmsan_enter_runtime();
 	mapped = __vmap_pages_range_noflush(shadow_start, shadow_end, prot,
 					    s_pages, page_shift);
-	KMSAN_WARN_ON(mapped);
+	if (mapped) {
+		err = mapped;
+		goto ret;
+	}
 	mapped = __vmap_pages_range_noflush(origin_start, origin_end, prot,
 					    o_pages, page_shift);
-	KMSAN_WARN_ON(mapped);
+	if (mapped) {
+		err = mapped;
+		goto ret;
+	}
 	kmsan_leave_runtime();
 	flush_tlb_kernel_range(shadow_start, shadow_end);
 	flush_tlb_kernel_range(origin_start, origin_end);
@@ -262,6 +270,7 @@ void kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
 ret:
 	kfree(s_pages);
 	kfree(o_pages);
+	return err;
 }
 
 /* Allocate metadata for pages allocated at boot time. */
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index a50072066221a..1355d95cce1ca 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -605,7 +605,11 @@ int __vmap_pages_range_noflush(unsigned long addr, unsigned long end,
 int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
 		pgprot_t prot, struct page **pages, unsigned int page_shift)
 {
-	kmsan_vmap_pages_range_noflush(addr, end, prot, pages, page_shift);
+	int ret = kmsan_vmap_pages_range_noflush(addr, end, prot, pages,
+						 page_shift);
+
+	if (ret)
+		return ret;
 	return __vmap_pages_range_noflush(addr, end, prot, pages, page_shift);
 }
 
-- 
2.40.0.577.gac1e443424-goog

