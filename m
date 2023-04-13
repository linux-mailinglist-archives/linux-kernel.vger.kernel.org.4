Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C21D6E0E36
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 15:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjDMNMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 09:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjDMNMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 09:12:47 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467E89ECC
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 06:12:28 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54f8e31155bso53091537b3.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 06:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681391547; x=1683983547;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=akxBw8gEREuaBtxzA9qIYFhL4FrjZkaJp5ikMOEw/lQ=;
        b=eFVXlBPlk8KkE4XTi3JZp57snk+KevAS/0AAEO8KUQKSbtlezEhHzl7gM28PRSANsQ
         xFi584iPfUhEI0ZAWBsfzgePMg6oXen48McBe5VCcz3DplJ9+JeZD8wEHuwXfb7eY+aA
         THak+NvZaFjvTd+yrsI8BUdRjts/e+TlenEWbeB/fSl1rVQuPhafFd1hHa62VJ5VBcge
         QATR+oYNfLbD6vAsZk5H8AvFSiI2ZPTTeghUDlHrPmD8jGdiFgPB+XAQN5P+oGv4bkuy
         TaaeUlNPKKBSXPBJH748wRB30XE0ZCS7+rSKmlOZquvzOsUXj2WzRZH+HEGv0+px1Ego
         21RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681391547; x=1683983547;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=akxBw8gEREuaBtxzA9qIYFhL4FrjZkaJp5ikMOEw/lQ=;
        b=iJrhHwiZV5eFXWxSRVSSGoWb4kbLl4cAglEFG1KAEVFYALRaruxvHOGBCPZo+13PIB
         FxQv70Z1H7mMjWzoIuAzBn8DzyqYQchumUoQrvmkzg6fptoL0BFSxDk9Y5WEskmbJ4NZ
         lZpxB+ypbuRehjEqsepOYzsdADpv0cJWzlFaw+be8mSSvGItAb9VX5H79zmSUBV+Wx2f
         R9FOuQskrTy1znTSFkvD0HkQAfBsJV3ChxgJ3/+ZhcF7/exAlIn0n32QKowe6AtqBWnb
         PD3TIKUIuf3LRVEQWxRv31ZTiPCxnEAbkyiip+/+zwiWPFBVS1WoXnGDeduwKimvwInz
         XO6g==
X-Gm-Message-State: AAQBX9fzFhwly2CFsZOHqua92mYtMUHij9lUYtxY54vvLUDWy/R74GH5
        k6nCnC8InK643vXhufvolRfTEZ4EFMA=
X-Google-Smtp-Source: AKy350YiiGBZ9G/MU1vaW002Sqg0JV5Azs5DqEu339HBwPrg/oAX3rcUTYgYybyELrzyBffUmUNxtdYNiGA=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:eb2b:4d7d:1d7f:9316])
 (user=glider job=sendgmr) by 2002:a81:4319:0:b0:545:62cb:3bcf with SMTP id
 q25-20020a814319000000b0054562cb3bcfmr1362388ywa.2.1681391547580; Thu, 13 Apr
 2023 06:12:27 -0700 (PDT)
Date:   Thu, 13 Apr 2023 15:12:20 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230413131223.4135168-1-glider@google.com>
Subject: [PATCH v2 1/4] mm: kmsan: handle alloc failures in kmsan_vmap_pages_range_noflush()
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
v2:
 -- return 0 from the inline version of kmsan_vmap_pages_range_noflush()
    (spotted by kernel test robot <lkp@intel.com>)
---
 include/linux/kmsan.h | 20 +++++++++++---------
 mm/kmsan/shadow.c     | 27 ++++++++++++++++++---------
 mm/vmalloc.c          |  6 +++++-
 3 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
index e38ae3c346184..c7ff3aefc5a13 100644
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
@@ -281,12 +282,13 @@ static inline void kmsan_kfree_large(const void *ptr)
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
+	return 0;
 }
 
 static inline void kmsan_vunmap_range_noflush(unsigned long start,
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

