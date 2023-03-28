Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329E06CBBA5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbjC1J7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbjC1J64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:58:56 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D8165A1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:58:55 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso11941804pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1679997535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMHBZhrpM5z4k2ZtEf9hxQYrO1Qyd30oWmty+49rOpw=;
        b=cRycGiJJnkVXyhfrk/dJRNSCMoFpZNGGzl7dazDlUieFTT+oQ+yoOI0svPNXNgtJqi
         ueJI4DHM5wT7gQ5RfXmNTIxsoHKaTtsJl7K7gn59uLOroQOiZT59BCAtb8NqmrT1Mh3k
         Gmp9KRHfZU2HK7LFnjWVQlIsu8uap2Y3Occ0QtUuXKCCiQ/RNy7ku8loyA64bCWAh8nu
         YarRVEK3zgJVrD1NAyG+Rw6Yp31+UQjj/8IL6k6ldDxLShPxNG7chryjPAjYipTl6RtD
         e5Kw7dStq3e/3/leQwjmSZgKAQc77VNntEv25vM1Y9n+FcT/YOolm+LYWL6kjyf2byr7
         cH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679997535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMHBZhrpM5z4k2ZtEf9hxQYrO1Qyd30oWmty+49rOpw=;
        b=U/BQWjgeegBbGv1pBkwvZYCXwfrA+iGrTUU4/CEy4SyXeQdglpPo2csmA0Ssz8wJrU
         22AA96maC2uYo1HXiENJgo3TCmHmuFKtmCJVJm2tQ+wMze5orzGLdZla+Duonh6t0ovI
         5iFb7h5IAFDiv2OikUavB94i3E6nGHdoRJO5lx7xLVbX4Iu19PX+66GheCifNawXrige
         CsBkjWZiyWEDywY7jaGcebP8nLNcgcUZqe2R8LFRLbabkgrhUcbASq6lDURyOcvqpcix
         Z8zAHpkTlZScWWq17bxZJIiNv7Z2GdtSMFK8EuOlfqjSV8KXrOf/6hFs+rQbLOzdUoAI
         JQPw==
X-Gm-Message-State: AO0yUKVku8Nwp+YlRL8CSf2rTXvW0ihkfNHeV7mtij7T+HRAQjUtesat
        L9j8wM7k2jwAUop2EWhsL1p1iMEhsmdZYQ+Xdmk/qg==
X-Google-Smtp-Source: AK7set932jr2dvDlZkZ6I1j9l5nVAPzrKihlTnIBzV515yMv5dukdFImzzt3Wkm14B5fhfxAnCRdyA==
X-Received: by 2002:a05:6a20:6baf:b0:da:1e1:3f46 with SMTP id bu47-20020a056a206baf00b000da01e13f46mr13145721pzb.31.1679997534793;
        Tue, 28 Mar 2023 02:58:54 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id m26-20020aa78a1a000000b005a8a5be96b2sm17207556pfa.104.2023.03.28.02.58.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Mar 2023 02:58:54 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     glider@google.com, elver@google.com, dvyukov@google.com,
        akpm@linux-foundation.org, jannh@google.com, sjpark@amazon.de,
        muchun.song@linux.dev
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 5/6] mm: kfence: change kfence pool page layout
Date:   Tue, 28 Mar 2023 17:58:06 +0800
Message-Id: <20230328095807.7014-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230328095807.7014-1-songmuchun@bytedance.com>
References: <20230328095807.7014-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original kfence pool layout (Given a layout with 2 objects):

 +------------+------------+------------+------------+------------+------------+
 | guard page | guard page |   object   | guard page |   object   | guard page |
 +------------+------------+------------+------------+------------+------------+
                           |                         |                         |
                           +----kfence_metadata[0]---+----kfence_metadata[1]---+

The comment says "the additional page in the beginning gives us an even
number of pages, which simplifies the mapping of address to metadata index".

However, removing the additional page does not complicate any mapping
calculations. So changing it to the new layout to save a page. And remmove
the KFENCE_ERROR_INVALID test since we cannot test this case easily.

The new kfence pool layout (Given a layout with 2 objects):

 +------------+------------+------------+------------+------------+
 | guard page |   object   | guard page |   object   | guard page |
 +------------+------------+------------+------------+------------+
 |                         |                         |
 +----kfence_metadata[0]---+----kfence_metadata[1]---+

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/kfence.h  |  8 ++------
 mm/kfence/core.c        | 40 ++++++++--------------------------------
 mm/kfence/kfence.h      |  2 +-
 mm/kfence/kfence_test.c | 14 --------------
 4 files changed, 11 insertions(+), 53 deletions(-)

diff --git a/include/linux/kfence.h b/include/linux/kfence.h
index 726857a4b680..25b13a892717 100644
--- a/include/linux/kfence.h
+++ b/include/linux/kfence.h
@@ -19,12 +19,8 @@
 
 extern unsigned long kfence_sample_interval;
 
-/*
- * We allocate an even number of pages, as it simplifies calculations to map
- * address to metadata indices; effectively, the very first page serves as an
- * extended guard page, but otherwise has no special purpose.
- */
-#define KFENCE_POOL_SIZE ((CONFIG_KFENCE_NUM_OBJECTS + 1) * 2 * PAGE_SIZE)
+/* The last page serves as an extended guard page. */
+#define KFENCE_POOL_SIZE	((CONFIG_KFENCE_NUM_OBJECTS * 2 + 1) * PAGE_SIZE)
 extern char *__kfence_pool;
 
 DECLARE_STATIC_KEY_FALSE(kfence_allocation_key);
diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 41befcb3b069..f205b860f460 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -240,24 +240,7 @@ static inline void kfence_unprotect(unsigned long addr)
 
 static inline unsigned long metadata_to_pageaddr(const struct kfence_metadata *meta)
 {
-	unsigned long offset = (meta - kfence_metadata + 1) * PAGE_SIZE * 2;
-	unsigned long pageaddr = (unsigned long)&__kfence_pool[offset];
-
-	/* The checks do not affect performance; only called from slow-paths. */
-
-	/* Only call with a pointer into kfence_metadata. */
-	if (KFENCE_WARN_ON(meta < kfence_metadata ||
-			   meta >= kfence_metadata + CONFIG_KFENCE_NUM_OBJECTS))
-		return 0;
-
-	/*
-	 * This metadata object only ever maps to 1 page; verify that the stored
-	 * address is in the expected range.
-	 */
-	if (KFENCE_WARN_ON(ALIGN_DOWN(meta->addr, PAGE_SIZE) != pageaddr))
-		return 0;
-
-	return pageaddr;
+	return ALIGN_DOWN(meta->addr, PAGE_SIZE);
 }
 
 /*
@@ -535,34 +518,27 @@ static void kfence_init_pool(void)
 	unsigned long addr = (unsigned long)__kfence_pool;
 	int i;
 
-	/*
-	 * Protect the first 2 pages. The first page is mostly unnecessary, and
-	 * merely serves as an extended guard page. However, adding one
-	 * additional page in the beginning gives us an even number of pages,
-	 * which simplifies the mapping of address to metadata index.
-	 */
-	for (i = 0; i < 2; i++, addr += PAGE_SIZE)
-		kfence_protect(addr);
-
 	for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++, addr += 2 * PAGE_SIZE) {
 		struct kfence_metadata *meta = &kfence_metadata[i];
-		struct slab *slab = page_slab(virt_to_page(addr));
+		struct slab *slab = page_slab(virt_to_page(addr + PAGE_SIZE));
 
 		/* Initialize metadata. */
 		INIT_LIST_HEAD(&meta->list);
 		raw_spin_lock_init(&meta->lock);
 		meta->state = KFENCE_OBJECT_UNUSED;
-		meta->addr = addr; /* Initialize for validation in metadata_to_pageaddr(). */
+		meta->addr = addr + PAGE_SIZE;
 		list_add_tail(&meta->list, &kfence_freelist);
 
-		/* Protect the right redzone. */
-		kfence_protect(addr + PAGE_SIZE);
+		/* Protect the left redzone. */
+		kfence_protect(addr);
 
 		__folio_set_slab(slab_folio(slab));
 #ifdef CONFIG_MEMCG
 		slab->memcg_data = (unsigned long)&meta->objcg | MEMCG_DATA_OBJCGS;
 #endif
 	}
+
+	kfence_protect(addr);
 }
 
 static bool __init kfence_init_pool_early(void)
@@ -1043,7 +1019,7 @@ bool kfence_handle_page_fault(unsigned long addr, bool is_write, struct pt_regs
 
 	atomic_long_inc(&counters[KFENCE_COUNTER_BUGS]);
 
-	if (page_index % 2) {
+	if (page_index % 2 == 0) {
 		/* This is a redzone, report a buffer overflow. */
 		struct kfence_metadata *meta;
 		int distance = 0;
diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
index 600f2e2431d6..249d420100a7 100644
--- a/mm/kfence/kfence.h
+++ b/mm/kfence/kfence.h
@@ -110,7 +110,7 @@ static inline struct kfence_metadata *addr_to_metadata(unsigned long addr)
 	 * __kfence_pool, in which case we would report an "invalid access"
 	 * error.
 	 */
-	index = (addr - (unsigned long)__kfence_pool) / (PAGE_SIZE * 2) - 1;
+	index = (addr - (unsigned long)__kfence_pool) / (PAGE_SIZE * 2);
 	if (index < 0 || index >= CONFIG_KFENCE_NUM_OBJECTS)
 		return NULL;
 
diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
index b5d66a69200d..d479f9c8afb1 100644
--- a/mm/kfence/kfence_test.c
+++ b/mm/kfence/kfence_test.c
@@ -637,19 +637,6 @@ static void test_gfpzero(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, report_available());
 }
 
-static void test_invalid_access(struct kunit *test)
-{
-	const struct expect_report expect = {
-		.type = KFENCE_ERROR_INVALID,
-		.fn = test_invalid_access,
-		.addr = &__kfence_pool[10],
-		.is_write = false,
-	};
-
-	READ_ONCE(__kfence_pool[10]);
-	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
-}
-
 /* Test SLAB_TYPESAFE_BY_RCU works. */
 static void test_memcache_typesafe_by_rcu(struct kunit *test)
 {
@@ -787,7 +774,6 @@ static struct kunit_case kfence_test_cases[] = {
 	KUNIT_CASE(test_kmalloc_aligned_oob_write),
 	KUNIT_CASE(test_shrink_memcache),
 	KUNIT_CASE(test_memcache_ctor),
-	KUNIT_CASE(test_invalid_access),
 	KUNIT_CASE(test_gfpzero),
 	KUNIT_CASE(test_memcache_typesafe_by_rcu),
 	KUNIT_CASE(test_krealloc),
-- 
2.11.0

