Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C367A6E0E38
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 15:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjDMNMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 09:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjDMNMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 09:12:48 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94913A26F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 06:12:32 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id m7-20020a05600c3b0700b003ee112e6df1so4774989wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 06:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681391551; x=1683983551;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=akRe6e4LluVT6nSisjA8EFH4R71lf+zwEBXmk0EhBro=;
        b=UWMmjgu4IOSqX5O5xqqvwkH7RA1XeATrgudE5npO4wFN2DVyqyLAVKX22J9okhAt/f
         WotKPxEQVCFGgD5uRAwrTZUlIEZ/IsbLrld0fd3ZNx6+fnGYgn6BFkHWg+tR5TuM3i/2
         /QxA1eaUKLWaI7yosX5HLTbRHZPPs9eytyhZr7c+VI11gRjnyGympvKbf2DjnClcTAeZ
         jMHfSvmsDhUshFLa9aTwnqaCvBr5xvm37uTdVsG/JwEBAxP/7+CABtpGpFdswDI8yGf6
         rlZFmxJpt+if/yKAmeqXtLu4so+aQiQ3pC2KmSbses/Xm3lEXWcn2I/t7g7IAXvH2OlP
         1pwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681391551; x=1683983551;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=akRe6e4LluVT6nSisjA8EFH4R71lf+zwEBXmk0EhBro=;
        b=B3NdbFw02s4L3i5TT9byQml3r1lkLntpemGUL5DGE/pyVGdb4KY9hqNghDMIY5zf+6
         cnf+JXu8TK3VyqxY+tbBUIqiJzzuC5oNJ87T8ptciqdIqJR9c0vm3lCjLwIKwKGZCkbl
         o5WXtFs8V8w1BngwPs/bhVPqK/bLdFQthUUZeeraB0QI81A+xrVBRf41d/6HgSQn6FFT
         IJvPmeegaIDGTErVPuZpy1ZKGTg6eUQ7qQxFXRMgoiboYDDlwVfIkSUoDtbTd40wTGna
         3ZdVBSy80RBGXXjDD+CLkSupcwIzTI+Zixo6PUWdSd3rqN0/qYaye7XdjTm4xf/l1K/U
         MeJA==
X-Gm-Message-State: AAQBX9fxbjjIvy6pE77yukuF8t8mS0NixzlsqzrvabcvUZiv6pHuWia4
        TjsWpbFyRYdcZ+h6UJ3bmEk8T+J60y8=
X-Google-Smtp-Source: AKy350aXlH+JEH6G36TukQUXMTmo+3/5cJ7SYgjh19063ZjyiBg+1zGqVChNDLCI/LK5ak77r2MOdwY/dZk=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:eb2b:4d7d:1d7f:9316])
 (user=glider job=sendgmr) by 2002:a5d:4a42:0:b0:2f2:7854:f419 with SMTP id
 v2-20020a5d4a42000000b002f27854f419mr325850wrs.13.1681391551064; Thu, 13 Apr
 2023 06:12:31 -0700 (PDT)
Date:   Thu, 13 Apr 2023 15:12:21 +0200
In-Reply-To: <20230413131223.4135168-1-glider@google.com>
Mime-Version: 1.0
References: <20230413131223.4135168-1-glider@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230413131223.4135168-2-glider@google.com>
Subject: [PATCH v2 2/4] mm: kmsan: handle alloc failures in kmsan_ioremap_page_range()
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

Similarly to kmsan_vmap_pages_range_noflush(),
kmsan_ioremap_page_range() must also properly handle allocation/mapping
failures. In the case of such, it must clean up the already created
metadata mappings and return an error code, so that the error can be
propagated to ioremap_page_range(). Without doing so, KMSAN may silently
fail to bring the metadata for the page range into a consistent state,
which will result in user-visible crashes when trying to access them.

Reported-by: Dipanjan Das <mail.dipanjan.das@gmail.com>
Link: https://lore.kernel.org/linux-mm/CANX2M5ZRrRA64k0hOif02TjmY9kbbO2aCBPyq79es34RXZ=cAw@mail.gmail.com/
Fixes: b073d7f8aee4 ("mm: kmsan: maintain KMSAN metadata for page operations")
Signed-off-by: Alexander Potapenko <glider@google.com>

---
v2:
 -- updated patch description as requested by Andrew Morton
 -- check the return value of __vmap_pages_range_noflush(), as suggested by Dipanjan Das
 -- return 0 from the inline version of kmsan_ioremap_page_range()
    (spotted by kernel test robot <lkp@intel.com>)
---
 include/linux/kmsan.h | 19 ++++++++-------
 mm/kmsan/hooks.c      | 55 ++++++++++++++++++++++++++++++++++++-------
 mm/vmalloc.c          |  4 ++--
 3 files changed, 59 insertions(+), 19 deletions(-)

diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
index c7ff3aefc5a13..30b17647ce3c7 100644
--- a/include/linux/kmsan.h
+++ b/include/linux/kmsan.h
@@ -160,11 +160,12 @@ void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end);
  * @page_shift:	page_shift argument passed to vmap_range_noflush().
  *
  * KMSAN creates new metadata pages for the physical pages mapped into the
- * virtual memory.
+ * virtual memory. Returns 0 on success, callers must check for non-zero return
+ * value.
  */
-void kmsan_ioremap_page_range(unsigned long addr, unsigned long end,
-			      phys_addr_t phys_addr, pgprot_t prot,
-			      unsigned int page_shift);
+int kmsan_ioremap_page_range(unsigned long addr, unsigned long end,
+			     phys_addr_t phys_addr, pgprot_t prot,
+			     unsigned int page_shift);
 
 /**
  * kmsan_iounmap_page_range() - Notify KMSAN about a iounmap_page_range() call.
@@ -296,12 +297,12 @@ static inline void kmsan_vunmap_range_noflush(unsigned long start,
 {
 }
 
-static inline void kmsan_ioremap_page_range(unsigned long start,
-					    unsigned long end,
-					    phys_addr_t phys_addr,
-					    pgprot_t prot,
-					    unsigned int page_shift)
+static inline int kmsan_ioremap_page_range(unsigned long start,
+					   unsigned long end,
+					   phys_addr_t phys_addr, pgprot_t prot,
+					   unsigned int page_shift)
 {
+	return 0;
 }
 
 static inline void kmsan_iounmap_page_range(unsigned long start,
diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
index 3807502766a3e..ec0da72e65aa0 100644
--- a/mm/kmsan/hooks.c
+++ b/mm/kmsan/hooks.c
@@ -148,35 +148,74 @@ void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end)
  * into the virtual memory. If those physical pages already had shadow/origin,
  * those are ignored.
  */
-void kmsan_ioremap_page_range(unsigned long start, unsigned long end,
-			      phys_addr_t phys_addr, pgprot_t prot,
-			      unsigned int page_shift)
+int kmsan_ioremap_page_range(unsigned long start, unsigned long end,
+			     phys_addr_t phys_addr, pgprot_t prot,
+			     unsigned int page_shift)
 {
 	gfp_t gfp_mask = GFP_KERNEL | __GFP_ZERO;
 	struct page *shadow, *origin;
 	unsigned long off = 0;
-	int nr;
+	int nr, err = 0, clean = 0, mapped;
 
 	if (!kmsan_enabled || kmsan_in_runtime())
-		return;
+		return 0;
 
 	nr = (end - start) / PAGE_SIZE;
 	kmsan_enter_runtime();
-	for (int i = 0; i < nr; i++, off += PAGE_SIZE) {
+	for (int i = 0; i < nr; i++, off += PAGE_SIZE, clean = i) {
 		shadow = alloc_pages(gfp_mask, 1);
 		origin = alloc_pages(gfp_mask, 1);
-		__vmap_pages_range_noflush(
+		if (!shadow || !origin) {
+			err = -ENOMEM;
+			goto ret;
+		}
+		mapped = __vmap_pages_range_noflush(
 			vmalloc_shadow(start + off),
 			vmalloc_shadow(start + off + PAGE_SIZE), prot, &shadow,
 			PAGE_SHIFT);
-		__vmap_pages_range_noflush(
+		if (mapped) {
+			err = mapped;
+			goto ret;
+		}
+		shadow = NULL;
+		mapped = __vmap_pages_range_noflush(
 			vmalloc_origin(start + off),
 			vmalloc_origin(start + off + PAGE_SIZE), prot, &origin,
 			PAGE_SHIFT);
+		if (mapped) {
+			__vunmap_range_noflush(
+				vmalloc_shadow(start + off),
+				vmalloc_shadow(start + off + PAGE_SIZE));
+			err = mapped;
+			goto ret;
+		}
+		origin = NULL;
+	}
+	/* Page mapping loop finished normally, nothing to clean up. */
+	clean = 0;
+
+ret:
+	if (clean > 0) {
+		/*
+		 * Something went wrong. Clean up shadow/origin pages allocated
+		 * on the last loop iteration, then delete mappings created
+		 * during the previous iterations.
+		 */
+		if (shadow)
+			__free_pages(shadow, 1);
+		if (origin)
+			__free_pages(origin, 1);
+		__vunmap_range_noflush(
+			vmalloc_shadow(start),
+			vmalloc_shadow(start + clean * PAGE_SIZE));
+		__vunmap_range_noflush(
+			vmalloc_origin(start),
+			vmalloc_origin(start + clean * PAGE_SIZE));
 	}
 	flush_cache_vmap(vmalloc_shadow(start), vmalloc_shadow(end));
 	flush_cache_vmap(vmalloc_origin(start), vmalloc_origin(end));
 	kmsan_leave_runtime();
+	return err;
 }
 
 void kmsan_iounmap_page_range(unsigned long start, unsigned long end)
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 1355d95cce1ca..31ff782d368b0 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -313,8 +313,8 @@ int ioremap_page_range(unsigned long addr, unsigned long end,
 				 ioremap_max_page_shift);
 	flush_cache_vmap(addr, end);
 	if (!err)
-		kmsan_ioremap_page_range(addr, end, phys_addr, prot,
-					 ioremap_max_page_shift);
+		err = kmsan_ioremap_page_range(addr, end, phys_addr, prot,
+					       ioremap_max_page_shift);
 	return err;
 }
 
-- 
2.40.0.577.gac1e443424-goog

