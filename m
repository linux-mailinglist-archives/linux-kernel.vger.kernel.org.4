Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09146986F6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 22:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjBOVGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 16:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjBOVFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 16:05:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420B0460A3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 13:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676494982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VoCRwH2jPhFQ3VoxDFQSv+suzueBHZpDa+/5djWt/Do=;
        b=AkZ7sm6eiK9eB8owpNS69nqBO2lMzgKJGcu6uP9bDZxoji5wpmov1mUdrgxFw/R+gfM4nn
        BQTkD/Jr6+5gotPvuIeCsZdUxRtX3xbP6tGHYkUiGJpKyVqCNnjH7yyqiz+2gmEKBooT7G
        z6LIpX1T44WhleLAh/alwo7EjQZyJD8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-14-I503mgLUOaqXYqjUtnbSKw-1; Wed, 15 Feb 2023 16:03:01 -0500
X-MC-Unique: I503mgLUOaqXYqjUtnbSKw-1
Received: by mail-qt1-f199.google.com with SMTP id g9-20020ac80709000000b003ba266c0c2bso40250qth.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 13:03:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VoCRwH2jPhFQ3VoxDFQSv+suzueBHZpDa+/5djWt/Do=;
        b=TkOTiiGFVdcxDuynbFTLE9AmZmrnvuoIFba7pfF0GcNfimF+o8EWh8LNnwlyQD3qOb
         Z2Sv2P5/ZHx5TOdGTjN45rUBEIgr6caQbb7llPaaSIxL42uwN7eNv3Buf6wAml4MpPVi
         nb8D1w5Bpn9vpVz7i7kaW1+ZzIaeMdAUKZtnFX6K3T6bKdi9GKRj2rtm9q4jy2H/mARK
         cdbFqwKsQQn/OGEPsw/6hc1t4YYXG1sCF6HdhSk/yev5TzCGqo4OEEn43hcqqoFWH3UV
         A5qRF680MUyJbeU9Wtdf47fsbYQ/VhXCyMelEhAXsL8MrvwIbjslvqm7oEBM0z30p2eZ
         1ZRw==
X-Gm-Message-State: AO0yUKVNiFPj+48Rv5yVJhShMOdfqezaVsYukT+vEzpPmEznwbCTfegs
        ++Rg3NAbziLyoH/W+dPuOm+S1d8OyYR/CO8/WeKxaegJBVFqOA6Lnz6XoAdW5jX+9wkQvUXs/pD
        Uvlg3qFeuG3sD9mbaLlmXjvmxE8YinUYDSoDQ/LOw4Lw6M3710TryDkUHWO/n6pjMAy6Vt0JZSQ
        lxTnA=
X-Received: by 2002:a05:622a:178e:b0:3b9:fc92:a6 with SMTP id s14-20020a05622a178e00b003b9fc9200a6mr6754222qtk.6.1676494979530;
        Wed, 15 Feb 2023 13:02:59 -0800 (PST)
X-Google-Smtp-Source: AK7set8LEWy0V2AVOG8G/L8ZZN16QPyV4430+929RA9g++45whVVJX7tqyrAfVy6BqldhxXYMQcHNw==
X-Received: by 2002:a05:622a:178e:b0:3b9:fc92:a6 with SMTP id s14-20020a05622a178e00b003b9fc9200a6mr6754155qtk.6.1676494979030;
        Wed, 15 Feb 2023 13:02:59 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id e25-20020ac845d9000000b003b86b99690fsm13505460qto.62.2023.02.15.13.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 13:02:58 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>, peterx@redhat.com,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: [PATCH] mm/uffd: UFFD_FEATURE_WP_ZEROPAGE
Date:   Wed, 15 Feb 2023 16:02:57 -0500
Message-Id: <20230215210257.224243-1-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a new feature that controls how uffd-wp handles zero pages (aka,
empty ptes), majorly for anonymous pages only.

Note, here we used "zeropage" as a replacement of "empty pte" just to avoid
introducing the pte idea into uapi, since "zero page" is more well known to
an user app developer.

File memories handles none ptes consistently by allowing wr-protecting of
none ptes because of the unawareness of page cache being exist or not.  For
anonymous it was not as persistent because we used to assume that we don't
need protections on none ptes or known zero pages.

But it's actually not true.

One use case was VM live snapshot, where if without wr-protecting empty
ptes the snapshot can contain random rubbish in the holes of the anonymous
memory, which can cause misbehave of the guest when the guest assumes the
pages should (and were) all zeros.

QEMU worked it around by pre-populate the section with reads to fill in
zero page entries before starting the whole snapshot process [1].

Recently there's another need that raised on using userfaultfd wr-protect
for detecting dirty pages (to replace soft-dirty) [2].  In that case if
without being able to wr-protect zero pages by default, the dirty info can
get lost as long as a zero page is written, even after the tracking was
started.

In general, we want to be able to wr-protect empty ptes too even for
anonymous.

This patch implements UFFD_FEATURE_WP_ZEROPAGE so that it'll make uffd-wp
handling on zeropage being consistent no matter what the memory type is
underneath.  It doesn't have any impact on file memories so far because we
already have pte markers taking care of that.  So it only affects
anonymous.

One way to implement this is to also install pte markers for anonymous
memories.  However here we can actually do better (than i.e. shmem) because
we know there's no page that is backing the pte, so the better solution is
to directly install a zeropage read-only pte, so that if there'll be a
upcoming read it'll not trigger a fault at all.  It will also reduce the
changeset to implement this feature too.

To install zeropages, we'll also need to populate the pgtables just like
file memories during ioctl(UFFDIO_WRITEPROTECT), where zeropage needs to be
installed.  Rename uffd_wp_protect_file() to pgtable_populate_needed()
because it's not only about file memory, not anymore.  Add yet another
pgtable_split_needed() because for anonymous we don't need to split a thp
for wr-protections (e.g., when it's only read during the whole process).

[1] https://lore.kernel.org/all/20210401092226.102804-4-andrey.gruzdev@virtuozzo.com/
[1] https://lore.kernel.org/all/Y+v2HJ8+3i%2FKzDBu@x1n/

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c                         |  8 +++
 include/linux/userfaultfd_k.h            |  6 +++
 include/uapi/linux/userfaultfd.h         | 10 +++-
 mm/mprotect.c                            | 68 ++++++++++++++++++++----
 tools/testing/selftests/mm/userfaultfd.c | 13 ++++-
 5 files changed, 93 insertions(+), 12 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 44d1ee429eb0..0117e409cc07 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -108,6 +108,13 @@ static bool userfaultfd_is_initialized(struct userfaultfd_ctx *ctx)
 	return ctx->features & UFFD_FEATURE_INITIALIZED;
 }
 
+bool userfaultfd_wp_zeropage(struct vm_area_struct *vma)
+{
+	struct userfaultfd_ctx *ctx = vma->vm_userfaultfd_ctx.ctx;
+
+	return ctx && (ctx->features & UFFD_FEATURE_WP_ZEROPAGE);
+}
+
 static void userfaultfd_set_vm_flags(struct vm_area_struct *vma,
 				     vm_flags_t flags)
 {
@@ -1968,6 +1975,7 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 #endif
 #ifndef CONFIG_HAVE_ARCH_USERFAULTFD_WP
 	uffdio_api.features &= ~UFFD_FEATURE_PAGEFAULT_FLAG_WP;
+	uffdio_api.features &= ~UFFD_FEATURE_WP_ZEROPAGE;
 #endif
 #ifndef CONFIG_PTE_MARKER_UFFD_WP
 	uffdio_api.features &= ~UFFD_FEATURE_WP_HUGETLBFS_SHMEM;
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 3767f18114ef..f539a9a45189 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -179,6 +179,7 @@ extern int userfaultfd_unmap_prep(struct mm_struct *mm, unsigned long start,
 				  unsigned long end, struct list_head *uf);
 extern void userfaultfd_unmap_complete(struct mm_struct *mm,
 				       struct list_head *uf);
+extern bool userfaultfd_wp_zeropage(struct vm_area_struct *vma);
 
 #else /* CONFIG_USERFAULTFD */
 
@@ -274,6 +275,11 @@ static inline bool uffd_disable_fault_around(struct vm_area_struct *vma)
 	return false;
 }
 
+static inline bool userfaultfd_wp_zeropage(struct vm_area_struct *vma)
+{
+	return false;
+}
+
 #endif /* CONFIG_USERFAULTFD */
 
 static inline bool pte_marker_entry_uffd_wp(swp_entry_t entry)
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index 005e5e306266..ba5da3a521b3 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -38,7 +38,8 @@
 			   UFFD_FEATURE_MINOR_HUGETLBFS |	\
 			   UFFD_FEATURE_MINOR_SHMEM |		\
 			   UFFD_FEATURE_EXACT_ADDRESS |		\
-			   UFFD_FEATURE_WP_HUGETLBFS_SHMEM)
+			   UFFD_FEATURE_WP_HUGETLBFS_SHMEM |	\
+			   UFFD_FEATURE_WP_ZEROPAGE)
 #define UFFD_API_IOCTLS				\
 	((__u64)1 << _UFFDIO_REGISTER |		\
 	 (__u64)1 << _UFFDIO_UNREGISTER |	\
@@ -203,6 +204,12 @@ struct uffdio_api {
 	 *
 	 * UFFD_FEATURE_WP_HUGETLBFS_SHMEM indicates that userfaultfd
 	 * write-protection mode is supported on both shmem and hugetlbfs.
+	 *
+	 * UFFD_FEATURE_WP_ZEROPAGE indicates that userfaultfd
+	 * write-protection mode will always apply to zero pages (aka,
+	 * empty ptes).  This will be the default behavior for shmem &
+	 * hugetlbfs, so this flag only affects anonymous memory behavior
+	 * when userfault write-protection mode is registered.
 	 */
 #define UFFD_FEATURE_PAGEFAULT_FLAG_WP		(1<<0)
 #define UFFD_FEATURE_EVENT_FORK			(1<<1)
@@ -217,6 +224,7 @@ struct uffdio_api {
 #define UFFD_FEATURE_MINOR_SHMEM		(1<<10)
 #define UFFD_FEATURE_EXACT_ADDRESS		(1<<11)
 #define UFFD_FEATURE_WP_HUGETLBFS_SHMEM		(1<<12)
+#define UFFD_FEATURE_WP_ZEROPAGE		(1<<13)
 	__u64 features;
 
 	__u64 ioctls;
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 1d4843c97c2a..c157d0830807 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -276,7 +276,15 @@ static long change_pte_range(struct mmu_gather *tlb,
 		} else {
 			/* It must be an none page, or what else?.. */
 			WARN_ON_ONCE(!pte_none(oldpte));
-			if (unlikely(uffd_wp && !vma_is_anonymous(vma))) {
+
+			/*
+			 * Nobody plays with any none ptes besides
+			 * userfaultfd when applying the protections.
+			 */
+			if (likely(!uffd_wp))
+				continue;
+
+			if (!vma_is_anonymous(vma)) {
 				/*
 				 * For file-backed mem, we need to be able to
 				 * wr-protect a none pte, because even if the
@@ -286,6 +294,17 @@ static long change_pte_range(struct mmu_gather *tlb,
 				set_pte_at(vma->vm_mm, addr, pte,
 					   make_pte_marker(PTE_MARKER_UFFD_WP));
 				pages++;
+			} else if (userfaultfd_wp_zeropage(vma)) {
+				/*
+				 * Anonymous memory, wr-protecting it with
+				 * WP_ZEROPAGE, injecting zero pages to
+				 * persist uffd-wp bit.
+				 */
+				pte_t entry = pte_mkspecial(pfn_pte(my_zero_pfn(addr),
+								    vma->vm_page_prot));
+				entry = pte_mkuffd_wp(entry);
+				set_pte_at(vma->vm_mm, addr, pte, entry);
+				pages++;
 			}
 		}
 	} while (pte++, addr += PAGE_SIZE, addr != end);
@@ -320,23 +339,52 @@ static inline int pmd_none_or_clear_bad_unless_trans_huge(pmd_t *pmd)
 	return 0;
 }
 
-/* Return true if we're uffd wr-protecting file-backed memory, or false */
+/*
+ * Return true if we want to split huge thps in change protection
+ * procedure, false otherwise.
+ */
 static inline bool
-uffd_wp_protect_file(struct vm_area_struct *vma, unsigned long cp_flags)
+pgtable_split_needed(struct vm_area_struct *vma, unsigned long cp_flags)
 {
+	/*
+	 * pte markers only resides in pte level, if we need pte markers,
+	 * we need to split.
+	 */
 	return (cp_flags & MM_CP_UFFD_WP) && !vma_is_anonymous(vma);
 }
 
 /*
- * If wr-protecting the range for file-backed, populate pgtable for the case
- * when pgtable is empty but page cache exists.  When {pte|pmd|...}_alloc()
- * failed we treat it the same way as pgtable allocation failures during
- * page faults by kicking OOM and returning error.
+ * Return true if we want to populate pgtables in change protection
+ * procedure, false otherwise
+ */
+static inline bool
+pgtable_populate_needed(struct vm_area_struct *vma, unsigned long cp_flags)
+{
+	/* If not within ioctl(UFFDIO_WRITEPROTECT), then don't bother */
+	if (!(cp_flags & MM_CP_UFFD_WP))
+		return false;
+
+	/* Either if this is file-based, we need it for pte markers */
+	if (!vma_is_anonymous(vma))
+		return true;
+
+	/*
+	 * Or anonymous, we only need this if WP_ZEROPAGE enabled (to
+	 * install zero pages).
+	 */
+	return userfaultfd_wp_zeropage(vma);
+}
+
+/*
+ * Populate the pgtable underneath for whatever reason if requested.
+ * When {pte|pmd|...}_alloc() failed we treat it the same way as pgtable
+ * allocation failures during page faults by kicking OOM and returning
+ * error.
  */
 #define  change_pmd_prepare(vma, pmd, cp_flags)				\
 	({								\
 		long err = 0;						\
-		if (unlikely(uffd_wp_protect_file(vma, cp_flags))) {	\
+		if (unlikely(pgtable_populate_needed(vma, cp_flags))) {	\
 			if (pte_alloc(vma->vm_mm, pmd))			\
 				err = -ENOMEM;				\
 		}							\
@@ -351,7 +399,7 @@ uffd_wp_protect_file(struct vm_area_struct *vma, unsigned long cp_flags)
 #define  change_prepare(vma, high, low, addr, cp_flags)			\
 	  ({								\
 		long err = 0;						\
-		if (unlikely(uffd_wp_protect_file(vma, cp_flags))) {	\
+		if (unlikely(pgtable_populate_needed(vma, cp_flags))) {	\
 			low##_t *p = low##_alloc(vma->vm_mm, high, addr); \
 			if (p == NULL)					\
 				err = -ENOMEM;				\
@@ -404,7 +452,7 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 
 		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)) {
 			if ((next - addr != HPAGE_PMD_SIZE) ||
-			    uffd_wp_protect_file(vma, cp_flags)) {
+			    pgtable_split_needed(vma, cp_flags)) {
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
 				/*
 				 * For file-backed, the pmd could have been
diff --git a/tools/testing/selftests/mm/userfaultfd.c b/tools/testing/selftests/mm/userfaultfd.c
index 7f22844ed704..c600ea4ee9b9 100644
--- a/tools/testing/selftests/mm/userfaultfd.c
+++ b/tools/testing/selftests/mm/userfaultfd.c
@@ -1462,7 +1462,7 @@ static void userfaultfd_pagemap_test(unsigned int test_pgsize)
 	/* Flush so it doesn't flush twice in parent/child later */
 	fflush(stdout);
 
-	uffd_test_ctx_init(0);
+	uffd_test_ctx_init(UFFD_FEATURE_WP_ZEROPAGE);
 
 	if (test_pgsize > page_size) {
 		/* This is a thp test */
@@ -1482,6 +1482,17 @@ static void userfaultfd_pagemap_test(unsigned int test_pgsize)
 
 	pagemap_fd = pagemap_open();
 
+	if (test_pgsize == page_size) {
+		/* Test WP_ZEROPAGE first */
+		wp_range(uffd, (uint64_t)area_dst, test_pgsize, true);
+		value = pagemap_read_vaddr(pagemap_fd, area_dst);
+		pagemap_check_wp(value, true);
+
+		wp_range(uffd, (uint64_t)area_dst, page_size, false);
+		value = pagemap_read_vaddr(pagemap_fd, area_dst);
+		pagemap_check_wp(value, false);
+	}
+
 	/* Touch the page */
 	*area_dst = 1;
 	wp_range(uffd, (uint64_t)area_dst, test_pgsize, true);
-- 
2.39.1

