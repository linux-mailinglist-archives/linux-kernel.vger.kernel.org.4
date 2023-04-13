Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBD06E0E3B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 15:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjDMNM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 09:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjDMNMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 09:12:50 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D501EA5EC
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 06:12:35 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-504c8399f19so1289773a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 06:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681391554; x=1683983554;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BH4qKloTg3p5myDfS9qJ+XOa2IgLWTGcxSlYlXSqJNo=;
        b=D1+Gxpsma/kKehsYuehV5AlXbCxc9+6yPgVnS4mtrcrcUcfPbXHC2IVd4NdgcWvxKa
         sFORPx9k38EwNTdIx61YKgywtcophMGlm0SneHUBf4hypraueUI/TCDxI29jaZxY1vIy
         ltbilESRPv7Q0LzZkEMlnMV0LuOIkteNE9tSmGodmB8jIC9XLr/RqiX83LjxWJDm0fVC
         EzV7E9dIAd5BiJZP+J1mqdK7NdGn/rWTij/eOFuQ+J2dgfLFHk6TbzlAIkaBXBH7NQT0
         efLIkeRRi5i07YY6nTPb/kS2kA4Hs5mxoljJv1OfBU3BsRfbtn2Ns7T6FwUjRXC1Rn46
         5MNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681391554; x=1683983554;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BH4qKloTg3p5myDfS9qJ+XOa2IgLWTGcxSlYlXSqJNo=;
        b=Z+PI8+aF1sKXSmsAeX7NmFkD9Oe6C33iI25BGmbk0MK0XNrPiQdhErN2mBvZrZe38M
         rUMwRxB5Cc9r5K+Xu/NO+rEASEwEHfG2CAUIZjEjZTHtm6dntmi33mvAmX6sBF7/xYmt
         z5o6lRkvNB8sDKpC0j74RVy4q9CI17Iv126+p0q9MOgOVlFwK5OkrZq3hJDgIonMctHT
         peQR/cXZLm20g1nlxloKbsw8ZQNRhM5/FN08ErpsCgu38aC0MqXtGHgYFu8vkyzBXyuo
         n11yAfN0FOVln3RX2O4h7wO9bt/QPahcm9+4uRpi+9m7O3iw1kDMWvd2UsHgy2eumsP2
         +Sjg==
X-Gm-Message-State: AAQBX9eq9KsYNjc9uTFkYvO/gbe0fgKkBdqW0V5QcLA4lM1DxAPn7WHc
        /nx7SU3EzPgje2F901Zff8S/qQDDU6U=
X-Google-Smtp-Source: AKy350YjqcoIpDQnhokGemab6QINRaBafWRCSTgHRnGh9LmJmojNFRKF3kptG318ucQsrxRVaIe1NJVIppQ=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:eb2b:4d7d:1d7f:9316])
 (user=glider job=sendgmr) by 2002:a50:9ee7:0:b0:505:842:37b0 with SMTP id
 a94-20020a509ee7000000b00505084237b0mr1236251edf.3.1681391554378; Thu, 13 Apr
 2023 06:12:34 -0700 (PDT)
Date:   Thu, 13 Apr 2023 15:12:22 +0200
In-Reply-To: <20230413131223.4135168-1-glider@google.com>
Mime-Version: 1.0
References: <20230413131223.4135168-1-glider@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230413131223.4135168-3-glider@google.com>
Subject: [PATCH v2 3/4] mm: kmsan: apply __must_check to non-void functions
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     urezki@gmail.com, hch@infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, elver@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com
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

Non-void KMSAN hooks may return error codes that indicate that KMSAN
failed to reflect the changed memory state in the metadata (e.g. it
could not create the necessary memory mappings). In such cases the
callers should handle the errors to prevent the tool from using the
inconsistent metadata in the future.

We mark non-void hooks with __must_check so that error handling is not
skipped.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
 include/linux/kmsan.h | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
index 30b17647ce3c7..e0c23a32cdf01 100644
--- a/include/linux/kmsan.h
+++ b/include/linux/kmsan.h
@@ -54,7 +54,8 @@ void __init kmsan_init_runtime(void);
  * Freed pages are either returned to buddy allocator or held back to be used
  * as metadata pages.
  */
-bool __init kmsan_memblock_free_pages(struct page *page, unsigned int order);
+bool __init __must_check kmsan_memblock_free_pages(struct page *page,
+						   unsigned int order);
 
 /**
  * kmsan_alloc_page() - Notify KMSAN about an alloc_pages() call.
@@ -137,9 +138,11 @@ void kmsan_kfree_large(const void *ptr);
  * vmalloc metadata address range. Returns 0 on success, callers must check
  * for non-zero return value.
  */
-int kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
-				   pgprot_t prot, struct page **pages,
-				   unsigned int page_shift);
+int __must_check kmsan_vmap_pages_range_noflush(unsigned long start,
+						unsigned long end,
+						pgprot_t prot,
+						struct page **pages,
+						unsigned int page_shift);
 
 /**
  * kmsan_vunmap_kernel_range_noflush() - Notify KMSAN about a vunmap.
@@ -163,9 +166,9 @@ void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end);
  * virtual memory. Returns 0 on success, callers must check for non-zero return
  * value.
  */
-int kmsan_ioremap_page_range(unsigned long addr, unsigned long end,
-			     phys_addr_t phys_addr, pgprot_t prot,
-			     unsigned int page_shift);
+int __must_check kmsan_ioremap_page_range(unsigned long addr, unsigned long end,
+					  phys_addr_t phys_addr, pgprot_t prot,
+					  unsigned int page_shift);
 
 /**
  * kmsan_iounmap_page_range() - Notify KMSAN about a iounmap_page_range() call.
@@ -237,8 +240,8 @@ static inline void kmsan_init_runtime(void)
 {
 }
 
-static inline bool kmsan_memblock_free_pages(struct page *page,
-					     unsigned int order)
+static inline bool __must_check kmsan_memblock_free_pages(struct page *page,
+							  unsigned int order)
 {
 	return true;
 }
@@ -251,10 +254,9 @@ static inline void kmsan_task_exit(struct task_struct *task)
 {
 }
 
-static inline int kmsan_alloc_page(struct page *page, unsigned int order,
-				   gfp_t flags)
+static inline void kmsan_alloc_page(struct page *page, unsigned int order,
+				    gfp_t flags)
 {
-	return 0;
 }
 
 static inline void kmsan_free_page(struct page *page, unsigned int order)
@@ -283,11 +285,9 @@ static inline void kmsan_kfree_large(const void *ptr)
 {
 }
 
-static inline int kmsan_vmap_pages_range_noflush(unsigned long start,
-						 unsigned long end,
-						 pgprot_t prot,
-						 struct page **pages,
-						 unsigned int page_shift)
+static inline int __must_check kmsan_vmap_pages_range_noflush(
+	unsigned long start, unsigned long end, pgprot_t prot,
+	struct page **pages, unsigned int page_shift)
 {
 	return 0;
 }
@@ -297,10 +297,11 @@ static inline void kmsan_vunmap_range_noflush(unsigned long start,
 {
 }
 
-static inline int kmsan_ioremap_page_range(unsigned long start,
-					   unsigned long end,
-					   phys_addr_t phys_addr, pgprot_t prot,
-					   unsigned int page_shift)
+static inline int __must_check kmsan_ioremap_page_range(unsigned long start,
+							unsigned long end,
+							phys_addr_t phys_addr,
+							pgprot_t prot,
+							unsigned int page_shift)
 {
 	return 0;
 }
-- 
2.40.0.577.gac1e443424-goog

