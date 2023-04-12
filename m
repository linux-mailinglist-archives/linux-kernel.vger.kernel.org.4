Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5496DF90B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjDLOxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjDLOxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:53:15 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA5B1994
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 07:53:10 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-5048993067dso9188786a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 07:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681311189;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GLtuEgzLkzzznhMQcB+RHI4zD53wmkIOG/wGgFhyqPw=;
        b=utjKfmygHn4kBdNPDo9Nu5744uCmHko/uzMzJes3gOweiYJk0TBjzaO2UChJ0JcFcJ
         lqin+1bee46zFqjL/hHX655dUQ2HRBBGkxuvYqqolwDWtcEg90ktwgp9D+O9oNn4ArOs
         EdSBg/WiVVR+gasXULzcLqxJc6U6K9DV/3j5Xq8xRQ1xRDb+DR/c2DSDFmp2olDBsYYd
         fSpGc3RDZVj/w4XGCSNFz5h1UfN7ktZUTSgAD+N8VJlJKA4ECg6MKy6b7XnsGoLwQ7mj
         aomTPIJ9aWSWMQ58tOu4ug/5EdiuE9yMeni+sxFDoZ6ywmtR3iYNqlt4mJEeZXBemZOV
         16Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681311189;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GLtuEgzLkzzznhMQcB+RHI4zD53wmkIOG/wGgFhyqPw=;
        b=LertPRej0ySvjA2chjleNSMYUPCttro+GyAUmPGhSHTSHKrbc3um9zn/+9PPX8nL9y
         r9odt/k2ye2W9b7VDohtsD8hOj463HHBgBtkwOYu8HV6mJIqsKbtqUozllVGHo0VjI5o
         +x/ZJo8ndSILQz17VmZwTxKwfMBu8mCqtIO1c+5Xv+FJ/+coOK8gFSdGqNbDfPosRE8n
         ODqS3rfjYy2HuAglemYjiCHac4Gqc9vhJ09lIalQLdX5zU5Pg1nOs/+ErCmikQF4bwSy
         DKj/XeHTIcDsAq/cCon/ueDOn+FfJfAVuuV1gbmAl62BlVSIW5ZMw1o2y/KgyUQykowr
         t1TQ==
X-Gm-Message-State: AAQBX9dmwX8U2PkVSmorh4wiUUsT0XMGtPcPCEqDEXuZZzhJG16ksbnw
        GQuQzZ26RYswib1Pmf64ddwW4+t4Ka4=
X-Google-Smtp-Source: AKy350YtDxSb5Y0wl3Wqq51FjjIPmOzR3iiHinDz/kAPj7foWIm39W0DOvvC3nfps4wExlaQUWfESeTbnQY=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:901c:7904:40a1:1b6c])
 (user=glider job=sendgmr) by 2002:a05:6402:550b:b0:4fb:e069:77ac with SMTP id
 fi11-20020a056402550b00b004fbe06977acmr2006910edb.0.1681311189113; Wed, 12
 Apr 2023 07:53:09 -0700 (PDT)
Date:   Wed, 12 Apr 2023 16:53:00 +0200
In-Reply-To: <20230412145300.3651840-1-glider@google.com>
Mime-Version: 1.0
References: <20230412145300.3651840-1-glider@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230412145300.3651840-2-glider@google.com>
Subject: [PATCH 2/2] mm: kmsan: handle alloc failures in kmsan_ioremap_page_range()
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
metadata mappings and return an error code, so that the failure can be
propagated to ioremap_page_range().

Reported-by: Dipanjan Das <mail.dipanjan.das@gmail.com>
Link: https://lore.kernel.org/linux-mm/CANX2M5ZRrRA64k0hOif02TjmY9kbbO2aCBPyq79es34RXZ=cAw@mail.gmail.com/
Fixes: b073d7f8aee4 ("mm: kmsan: maintain KMSAN metadata for page operations")
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 include/linux/kmsan.h | 18 +++++++--------
 mm/kmsan/hooks.c      | 53 +++++++++++++++++++++++++++++++++++++------
 mm/vmalloc.c          |  4 ++--
 3 files changed, 57 insertions(+), 18 deletions(-)

diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
index a0769d4aad1c8..fa5a4705ea379 100644
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
@@ -295,11 +296,10 @@ static inline void kmsan_vunmap_range_noflush(unsigned long start,
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
 }
 
diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
index 3807502766a3e..02c17b7cb6ddd 100644
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
+		if (mapped) {
+			err = mapped;
+			goto ret;
+		}
+		shadow = NULL;
 		__vmap_pages_range_noflush(
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

