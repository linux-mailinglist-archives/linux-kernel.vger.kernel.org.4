Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E906A4F60
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 00:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjB0XBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 18:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjB0XBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 18:01:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6285024115
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 15:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677538853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=b8Q5SfsuqcK6by/RpALUvFMU8eJCg1/R5NwlrFe5JHo=;
        b=DUpKnt5QPBH6KFTKtfGcsI3sjYHAUCMQ9cilR8iRsVncI7UjrWmxQjONBUVpngLx7WhsyP
        DJLSRsKU9WbtJd4DzAQtxG1xlgpDTjk1biWCjanG4BykrZNsFxBkMEC06kE0KuErWuT3as
        1WCNsIg3scjYudQ9aZjg4uqItjQrzSc=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-615-gRauBmTyMf6fP4L4GZ1acQ-1; Mon, 27 Feb 2023 18:00:52 -0500
X-MC-Unique: gRauBmTyMf6fP4L4GZ1acQ-1
Received: by mail-il1-f200.google.com with SMTP id k10-20020a92b70a000000b00316fed8644fso4730406ili.21
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 15:00:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677538848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b8Q5SfsuqcK6by/RpALUvFMU8eJCg1/R5NwlrFe5JHo=;
        b=8M/YC9/JAcZHK24T2NWafYp4G4W4euKqjZvs7wr2oSnb0Rc29DJ8z29uxm5kNwBAk0
         v0LgzPmbYF39QqLXswuYxiJ6EJhJWTDBQkDXcdbo9EjuVxXv/FMFjxMcYH5l0hCiGMZ3
         m3WBNFL9L6329ApCiHVi47VKJ+tYZ87u06pbgIZ5eIj5hblSuj+optib+nTp7CxxqrfU
         AXSAk/hDYFLJ+jx9Wq+fGVmk4lFR6rd6SQgqmKOM5XCsfttAcnRh5jyeMlpGAlYTyayR
         CdbHbLjSqo8cY7jDku9hvoIe3oNn8qgaAnUC8h211sWR+v6m5zzcoAuaV0sgMo3+O3NB
         VomA==
X-Gm-Message-State: AO0yUKX3A+ChJxIIi5ZDaaRZcSUPtOVOHYojBcuDkdC1D0lKuj6gTmTf
        Za5q5C8yaSKQeXxmb5H3RmOpmKWQjnsZfwBUGLqkOjqQ0cK8RvgYYYn45OB7xg52ChlYKHmMhAo
        8EiKU8sDdiQmqQHDvy2NRWdxiO6RbObfMVn9oFBbpmI/XLigtkyGUa4cxe7lBUPr/k5gZIvztFH
        /IUk8=
X-Received: by 2002:a92:d606:0:b0:316:e2ee:3a15 with SMTP id w6-20020a92d606000000b00316e2ee3a15mr619410ilm.1.1677538847958;
        Mon, 27 Feb 2023 15:00:47 -0800 (PST)
X-Google-Smtp-Source: AK7set94WStccZkAfCfyMkCMg35YrK8DnTeKehKO7Xa9LSoo1+YWFIJhZ+gGaE/GxX0xm8/0aTcE6Q==
X-Received: by 2002:a92:d606:0:b0:316:e2ee:3a15 with SMTP id w6-20020a92d606000000b00316e2ee3a15mr619381ilm.1.1677538847243;
        Mon, 27 Feb 2023 15:00:47 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id n12-20020a02a90c000000b003c449a192cdsm2392844jam.73.2023.02.27.15.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 15:00:46 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v2] mm/uffd: UFFD_FEATURE_WP_UNPOPULATED
Date:   Mon, 27 Feb 2023 18:00:44 -0500
Message-Id: <20230227230044.1596744-1-peterx@redhat.com>
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

This is a new feature that controls how uffd-wp handles none ptes.  When
it's set, the kernel will handle anonymous memory the same way as file
memory, by allowing the user to wr-protect unpopulated ptes.

File memories handles none ptes consistently by allowing wr-protecting of
none ptes because of the unawareness of page cache being exist or not.  For
anonymous it was not as persistent because we used to assume that we don't
need protections on none ptes or known zero pages.

One use case of such a feature bit was VM live snapshot, where if without
wr-protecting empty ptes the snapshot can contain random rubbish in the
holes of the anonymous memory, which can cause misbehave of the guest when
the guest OS assumes the pages should be all zeros.

QEMU worked it around by pre-populate the section with reads to fill in
zero page entries before starting the whole snapshot process [1].

Recently there's another need raised on using userfaultfd wr-protect for
detecting dirty pages (to replace soft-dirty in some cases) [2].  In that
case if without being able to wr-protect none ptes by default, the dirty
info can get lost, since we cannot treat every none pte to be dirty (the
current design is identify a page dirty based on uffd-wp bit being cleared).

In general, we want to be able to wr-protect empty ptes too even for
anonymous.

This patch implements UFFD_FEATURE_WP_UNPOPULATED so that it'll make
uffd-wp handling on none ptes being consistent no matter what the memory
type is underneath.  It doesn't have any impact on file memories so far
because we already have pte markers taking care of that.  So it only
affects anonymous.

The feature bit is by default off, so the old behavior will be maintained.
Sometimes it may be wanted because the wr-protect of none ptes will contain
overheads not only during UFFDIO_WRITEPROTECT (by applying pte markers to
anonymous), but also on creating the pgtables to store the pte markers. So
there's potentially less chance of using thp on the first fault for a none
pmd or larger than a pmd.

The major implementation part is teaching the whole kernel to understand
pte markers even for anonymously mapped ranges, meanwhile allowing the
UFFDIO_WRITEPROTECT ioctl to apply pte markers for anonymous too when the
new feature bit is set.

Note that even if the patch subject starts with mm/uffd, there're a few
small refactors to major mm path of handling anonymous page faults. But
they should be straightforward.

So far, add a very light smoke test within the userfaultfd kselftest
pagemap unit test to make sure anon pte markers work.

[1] https://lore.kernel.org/all/20210401092226.102804-4-andrey.gruzdev@virtuozzo.com/
[1] https://lore.kernel.org/all/Y+v2HJ8+3i%2FKzDBu@x1n/

Signed-off-by: Peter Xu <peterx@redhat.com>
---
v1->v2:
- Use pte markers rather than populate zero pages when protect [David]
- Rename WP_ZEROPAGE to WP_UNPOPULATED [David]
---
 fs/userfaultfd.c                         | 14 ++++++
 include/linux/mm_inline.h                |  6 +++
 include/linux/userfaultfd_k.h            |  6 +++
 include/uapi/linux/userfaultfd.h         | 10 +++-
 mm/memory.c                              | 54 ++++++++++++++++------
 mm/mprotect.c                            | 59 ++++++++++++++++++++----
 tools/testing/selftests/mm/userfaultfd.c | 22 ++++++++-
 7 files changed, 146 insertions(+), 25 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 44d1ee429eb0..a2499908985a 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -108,6 +108,19 @@ static bool userfaultfd_is_initialized(struct userfaultfd_ctx *ctx)
 	return ctx->features & UFFD_FEATURE_INITIALIZED;
 }
 
+bool userfaultfd_wp_unpopulated(struct vm_area_struct *vma)
+{
+	struct userfaultfd_ctx *ctx = vma->vm_userfaultfd_ctx.ctx;
+
+	if (!userfaultfd_wp(vma))
+		return false;
+
+	if (!ctx)
+		return false;
+
+	return ctx->features & UFFD_FEATURE_WP_UNPOPULATED;
+}
+
 static void userfaultfd_set_vm_flags(struct vm_area_struct *vma,
 				     vm_flags_t flags)
 {
@@ -1971,6 +1984,7 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 #endif
 #ifndef CONFIG_PTE_MARKER_UFFD_WP
 	uffdio_api.features &= ~UFFD_FEATURE_WP_HUGETLBFS_SHMEM;
+	uffdio_api.features &= ~UFFD_FEATURE_WP_UNPOPULATED;
 #endif
 	uffdio_api.ioctls = UFFD_API_IOCTLS;
 	ret = -EFAULT;
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index de1e622dd366..0e1d239a882c 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -557,6 +557,12 @@ pte_install_uffd_wp_if_needed(struct vm_area_struct *vma, unsigned long addr,
 	/* The current status of the pte should be "cleared" before calling */
 	WARN_ON_ONCE(!pte_none(*pte));
 
+	/*
+	 * NOTE: userfaultfd_wp_unpopulated() doesn't need this whole
+	 * thing, because when zapping either it means it's dropping the
+	 * page, or in TTU where the present pte will be quickly replaced
+	 * with a swap pte.  There's no way of leaking the bit.
+	 */
 	if (vma_is_anonymous(vma) || !userfaultfd_wp(vma))
 		return;
 
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 3767f18114ef..9d43c1e88175 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -179,6 +179,7 @@ extern int userfaultfd_unmap_prep(struct mm_struct *mm, unsigned long start,
 				  unsigned long end, struct list_head *uf);
 extern void userfaultfd_unmap_complete(struct mm_struct *mm,
 				       struct list_head *uf);
+extern bool userfaultfd_wp_unpopulated(struct vm_area_struct *vma);
 
 #else /* CONFIG_USERFAULTFD */
 
@@ -274,6 +275,11 @@ static inline bool uffd_disable_fault_around(struct vm_area_struct *vma)
 	return false;
 }
 
+static inline bool userfaultfd_wp_unpopulated(struct vm_area_struct *vma)
+{
+	return false;
+}
+
 #endif /* CONFIG_USERFAULTFD */
 
 static inline bool pte_marker_entry_uffd_wp(swp_entry_t entry)
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index 005e5e306266..90c958952bfc 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -38,7 +38,8 @@
 			   UFFD_FEATURE_MINOR_HUGETLBFS |	\
 			   UFFD_FEATURE_MINOR_SHMEM |		\
 			   UFFD_FEATURE_EXACT_ADDRESS |		\
-			   UFFD_FEATURE_WP_HUGETLBFS_SHMEM)
+			   UFFD_FEATURE_WP_HUGETLBFS_SHMEM |	\
+			   UFFD_FEATURE_WP_UNPOPULATED)
 #define UFFD_API_IOCTLS				\
 	((__u64)1 << _UFFDIO_REGISTER |		\
 	 (__u64)1 << _UFFDIO_UNREGISTER |	\
@@ -203,6 +204,12 @@ struct uffdio_api {
 	 *
 	 * UFFD_FEATURE_WP_HUGETLBFS_SHMEM indicates that userfaultfd
 	 * write-protection mode is supported on both shmem and hugetlbfs.
+	 *
+	 * UFFD_FEATURE_WP_UNPOPULATED indicates that userfaultfd
+	 * write-protection mode will always apply to unpopulated pages
+	 * (i.e. empty ptes).  This will be the default behavior for shmem
+	 * & hugetlbfs, so this flag only affects anonymous memory behavior
+	 * when userfault write-protection mode is registered.
 	 */
 #define UFFD_FEATURE_PAGEFAULT_FLAG_WP		(1<<0)
 #define UFFD_FEATURE_EVENT_FORK			(1<<1)
@@ -217,6 +224,7 @@ struct uffdio_api {
 #define UFFD_FEATURE_MINOR_SHMEM		(1<<10)
 #define UFFD_FEATURE_EXACT_ADDRESS		(1<<11)
 #define UFFD_FEATURE_WP_HUGETLBFS_SHMEM		(1<<12)
+#define UFFD_FEATURE_WP_UNPOPULATED		(1<<13)
 	__u64 features;
 
 	__u64 ioctls;
diff --git a/mm/memory.c b/mm/memory.c
index bfa3100ec5a3..46934133bd0b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -104,6 +104,20 @@ EXPORT_SYMBOL(mem_map);
 #endif
 
 static vm_fault_t do_fault(struct vm_fault *vmf);
+static vm_fault_t do_anonymous_page(struct vm_fault *vmf);
+static bool vmf_pte_changed(struct vm_fault *vmf);
+
+/*
+ * Return true if the original pte was a uffd-wp pte marker (so the pte was
+ * wr-protected).
+ */
+static bool vmf_orig_pte_uffd_wp(struct vm_fault *vmf)
+{
+	if (!(vmf->flags & FAULT_FLAG_ORIG_PTE_VALID))
+		return false;
+
+	return pte_marker_uffd_wp(vmf->orig_pte);
+}
 
 /*
  * A number of key systems in x86 including ioremap() rely on the assumption
@@ -1346,6 +1360,10 @@ zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
 			      unsigned long addr, pte_t *pte,
 			      struct zap_details *details, pte_t pteval)
 {
+	/* Zap on anonymous always means dropping everything */
+	if (vma_is_anonymous(vma))
+		return;
+
 	if (zap_drop_file_uffd_wp(details))
 		return;
 
@@ -1452,8 +1470,12 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 				continue;
 			rss[mm_counter(page)]--;
 		} else if (pte_marker_entry_uffd_wp(entry)) {
-			/* Only drop the uffd-wp marker if explicitly requested */
-			if (!zap_drop_file_uffd_wp(details))
+			/*
+			 * For anon: always drop the marker; for file: only
+			 * drop the marker if explicitly requested.
+			 */
+			if (!vma_is_anonymous(vma) &&
+			    !zap_drop_file_uffd_wp(details))
 				continue;
 		} else if (is_hwpoison_entry(entry) ||
 			   is_swapin_error_entry(entry)) {
@@ -3620,6 +3642,14 @@ static vm_fault_t pte_marker_clear(struct vm_fault *vmf)
 	return 0;
 }
 
+static vm_fault_t handle_pte_missing(struct vm_fault *vmf)
+{
+	if (vma_is_anonymous(vmf->vma))
+		return do_anonymous_page(vmf);
+	else
+		return do_fault(vmf);
+}
+
 /*
  * This is actually a page-missing access, but with uffd-wp special pte
  * installed.  It means this pte was wr-protected before being unmapped.
@@ -3630,11 +3660,10 @@ static vm_fault_t pte_marker_handle_uffd_wp(struct vm_fault *vmf)
 	 * Just in case there're leftover special ptes even after the region
 	 * got unregistered - we can simply clear them.
 	 */
-	if (unlikely(!userfaultfd_wp(vmf->vma) || vma_is_anonymous(vmf->vma)))
+	if (unlikely(!userfaultfd_wp(vmf->vma)))
 		return pte_marker_clear(vmf);
 
-	/* do_fault() can handle pte markers too like none pte */
-	return do_fault(vmf);
+	return handle_pte_missing(vmf);
 }
 
 static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
@@ -3999,6 +4028,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
  */
 static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 {
+	bool uffd_wp = vmf_orig_pte_uffd_wp(vmf);
 	struct vm_area_struct *vma = vmf->vma;
 	struct folio *folio;
 	vm_fault_t ret = 0;
@@ -4072,7 +4102,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
 			&vmf->ptl);
-	if (!pte_none(*vmf->pte)) {
+	if (vmf_pte_changed(vmf)) {
 		update_mmu_tlb(vma, vmf->address, vmf->pte);
 		goto release;
 	}
@@ -4092,6 +4122,8 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	folio_add_new_anon_rmap(folio, vma, vmf->address);
 	folio_add_lru_vma(folio, vma);
 setpte:
+	if (uffd_wp)
+		entry = pte_mkuffd_wp(entry);
 	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
 
 	/* No need to invalidate - it was non-present before */
@@ -4259,7 +4291,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
 {
 	struct vm_area_struct *vma = vmf->vma;
-	bool uffd_wp = pte_marker_uffd_wp(vmf->orig_pte);
+	bool uffd_wp = vmf_orig_pte_uffd_wp(vmf);
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
 	bool prefault = vmf->address != addr;
 	pte_t entry;
@@ -4903,12 +4935,8 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		}
 	}
 
-	if (!vmf->pte) {
-		if (vma_is_anonymous(vmf->vma))
-			return do_anonymous_page(vmf);
-		else
-			return do_fault(vmf);
-	}
+	if (!vmf->pte)
+		return handle_pte_missing(vmf);
 
 	if (!pte_present(vmf->orig_pte))
 		return do_swap_page(vmf);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 231929f119d9..6a2df93158ee 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -276,7 +276,16 @@ static long change_pte_range(struct mmu_gather *tlb,
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
+			if (!vma_is_anonymous(vma) ||
+			    userfaultfd_wp_unpopulated(vma)) {
 				/*
 				 * For file-backed mem, we need to be able to
 				 * wr-protect a none pte, because even if the
@@ -320,23 +329,53 @@ static inline int pmd_none_or_clear_bad_unless_trans_huge(pmd_t *pmd)
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
+	 * we need to split.  We cannot wr-protect shmem thp because file
+	 * thp is handled differently when split by erasing the pmd so far.
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
+	return userfaultfd_wp_unpopulated(vma);
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
@@ -351,7 +390,7 @@ uffd_wp_protect_file(struct vm_area_struct *vma, unsigned long cp_flags)
 #define  change_prepare(vma, high, low, addr, cp_flags)			\
 	  ({								\
 		long err = 0;						\
-		if (unlikely(uffd_wp_protect_file(vma, cp_flags))) {	\
+		if (unlikely(pgtable_populate_needed(vma, cp_flags))) {	\
 			low##_t *p = low##_alloc(vma->vm_mm, high, addr); \
 			if (p == NULL)					\
 				err = -ENOMEM;				\
@@ -404,7 +443,7 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 
 		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)) {
 			if ((next - addr != HPAGE_PMD_SIZE) ||
-			    uffd_wp_protect_file(vma, cp_flags)) {
+			    pgtable_split_needed(vma, cp_flags)) {
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
 				/*
 				 * For file-backed, the pmd could have been
diff --git a/tools/testing/selftests/mm/userfaultfd.c b/tools/testing/selftests/mm/userfaultfd.c
index 7f22844ed704..122695a63cf1 100644
--- a/tools/testing/selftests/mm/userfaultfd.c
+++ b/tools/testing/selftests/mm/userfaultfd.c
@@ -1462,7 +1462,7 @@ static void userfaultfd_pagemap_test(unsigned int test_pgsize)
 	/* Flush so it doesn't flush twice in parent/child later */
 	fflush(stdout);
 
-	uffd_test_ctx_init(0);
+	uffd_test_ctx_init(UFFD_FEATURE_WP_UNPOPULATED);
 
 	if (test_pgsize > page_size) {
 		/* This is a thp test */
@@ -1482,6 +1482,26 @@ static void userfaultfd_pagemap_test(unsigned int test_pgsize)
 
 	pagemap_fd = pagemap_open();
 
+	/* Smoke test WP_UNPOPULATED first when it's still empty */
+	if (test_pgsize == page_size) {
+		/* Test applying pte marker to anon unpopulated */
+		wp_range(uffd, (uint64_t)area_dst, test_pgsize, true);
+		value = pagemap_read_vaddr(pagemap_fd, area_dst);
+		pagemap_check_wp(value, true);
+
+		/* Test unprotect with anon pte marker */
+		wp_range(uffd, (uint64_t)area_dst, test_pgsize, false);
+		value = pagemap_read_vaddr(pagemap_fd, area_dst);
+		pagemap_check_wp(value, false);
+
+		/* Re-apply, test zap on anon which should drop the marker */
+		wp_range(uffd, (uint64_t)area_dst, test_pgsize, true);
+		if (madvise(area_dst, test_pgsize, MADV_DONTNEED))
+			err("madvise(MADV_DONTNEED) failed");
+		value = pagemap_read_vaddr(pagemap_fd, area_dst);
+		pagemap_check_wp(value, false);
+	}
+
 	/* Touch the page */
 	*area_dst = 1;
 	wp_range(uffd, (uint64_t)area_dst, test_pgsize, true);
-- 
2.39.1

