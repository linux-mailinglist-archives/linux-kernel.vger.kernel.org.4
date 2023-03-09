Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04B96B30EB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 23:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjCIWiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 17:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjCIWiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 17:38:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29053FB249
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 14:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678401438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ysgFWfyZC6/5ktdPobreCAXolrb4DyJ34SU0oA25JVU=;
        b=RWYYDtSOFdAnOwEcKeN8zl+aRRU6J6S5r3SmDlcaFZ9sqXbmFC9M28Y4T2BQ59y0sA5cF2
        WtDCVf7730txi0Qe+VQ540yjsYYys/t4Qb0H1/9WHUkpM6vxUgykGI3CFKm3It2FEJjDYg
        EjwE6UuNp5DH1zxAyzkR72dy8TGNcJQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-eYjZGnvdNM6dOBeuap_I1g-1; Thu, 09 Mar 2023 17:37:17 -0500
X-MC-Unique: eYjZGnvdNM6dOBeuap_I1g-1
Received: by mail-qk1-f199.google.com with SMTP id 19-20020a370c13000000b007428253bb55so2031191qkm.23
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 14:37:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678401436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ysgFWfyZC6/5ktdPobreCAXolrb4DyJ34SU0oA25JVU=;
        b=TN0bBVk/7rtUvls/huLVyc1h0ZoFBmX0mgv2zJXr6REJEegEMoLECNim2T/Zq6Fc/+
         NlCXy6iz7hgFKzvnbjCYEQAcHp5P+EeBLDRaQDwiEYiUpEGtcYxAT6D/Se0KaWAMk9n3
         aqlOUBC2yI3HfTxVwU1hTe9Ci4+G8+/jlGpGfsCmQYYD18c6AqrlpzdGMvjguNcGtXj6
         CQ1DqMqVVFEI2Cb5Bw/Hr6rn37xv1RpJGc0UEiCeS61Lz108rWJu3XAITJv765gpFWOT
         sAHxfTGx3vhB64byu8XvW0TQ3lpUNytapQnPaU0Exezlcf/se/VwyFhiBUpl4ZEyww4H
         Xosw==
X-Gm-Message-State: AO0yUKX7yQwIePJLw46nC5sXK9o8PSy91PVAZu7Vbyi0FviXfHkTf90c
        UbKDwlkZk+0O6OTZjBpVeYH0Ie0NPnJBGCsf6M5pngUSe70yI37QRWsxJDY9cBMp7O2HJlsE+EE
        /F8+c3djgi1HChjnDaQ5g6zz5
X-Received: by 2002:ac8:5906:0:b0:3bf:daa8:cacc with SMTP id 6-20020ac85906000000b003bfdaa8caccmr1663753qty.3.1678401436170;
        Thu, 09 Mar 2023 14:37:16 -0800 (PST)
X-Google-Smtp-Source: AK7set+wO2kA6nqYFUeDU7Z02nij0VDKvtwfZVmJOJ+w6vZGgiE35KpmnIuI+ipqEUlvP2ZmpRWjUg==
X-Received: by 2002:ac8:5906:0:b0:3bf:daa8:cacc with SMTP id 6-20020ac85906000000b003bfdaa8caccmr1663715qty.3.1678401435734;
        Thu, 09 Mar 2023 14:37:15 -0800 (PST)
Received: from x1n.redhat.com (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id c26-20020ac84e1a000000b003b8484fdfccsm172215qtw.42.2023.03.09.14.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 14:37:14 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v4 1/2] mm/uffd: UFFD_FEATURE_WP_UNPOPULATED
Date:   Thu,  9 Mar 2023 17:37:10 -0500
Message-Id: <20230309223711.823547-2-peterx@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230309223711.823547-1-peterx@redhat.com>
References: <20230309223711.823547-1-peterx@redhat.com>
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

With WP_UNPOPUATED, application like QEMU can avoid pre-read faults all the
memory before wr-protect during taking a live snapshot.  Quotting from
Muhammad's test result here [3] based on a simple program [4]:

  (1) With huge page disabled
  echo madvise > /sys/kernel/mm/transparent_hugepage/enabled
  ./uffd_wp_perf
  Test DEFAULT: 4
  Test PRE-READ: 1111453 (pre-fault 1101011)
  Test MADVISE: 278276 (pre-fault 266378)
  Test WP-UNPOPULATE: 11712

  (2) With Huge page enabled
  echo always > /sys/kernel/mm/transparent_hugepage/enabled
  ./uffd_wp_perf
  Test DEFAULT: 4
  Test PRE-READ: 22521 (pre-fault 22348)
  Test MADVISE: 4909 (pre-fault 4743)
  Test WP-UNPOPULATE: 14448

There'll be a great perf boost for no-thp case, while for thp enabled with
extreme case of all-thp-zero WP_UNPOPULATED can be slower than MADVISE, but
that's low possibility in reality, also the overhead was not reduced but
postponed until a follow up write on any huge zero thp, so potentially it
is faster by making the follow up writes slower.

[1] https://lore.kernel.org/all/20210401092226.102804-4-andrey.gruzdev@virtuozzo.com/
[2] https://lore.kernel.org/all/Y+v2HJ8+3i%2FKzDBu@x1n/
[3] https://lore.kernel.org/all/d0eb0a13-16dc-1ac1-653a-78b7273781e3@collabora.com/
[4] https://github.com/xzpeter/clibs/blob/master/uffd-test/uffd-wp-perf.c

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 Documentation/admin-guide/mm/userfaultfd.rst | 17 ++++++
 fs/userfaultfd.c                             | 16 ++++++
 include/linux/mm_inline.h                    |  6 +++
 include/linux/userfaultfd_k.h                | 23 ++++++++
 include/uapi/linux/userfaultfd.h             | 10 +++-
 mm/memory.c                                  | 56 +++++++++++++++-----
 mm/mprotect.c                                | 51 ++++++++++++++----
 7 files changed, 154 insertions(+), 25 deletions(-)

diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
index 7dc823b56ca4..c86b56c95ea6 100644
--- a/Documentation/admin-guide/mm/userfaultfd.rst
+++ b/Documentation/admin-guide/mm/userfaultfd.rst
@@ -219,6 +219,23 @@ former will have ``UFFD_PAGEFAULT_FLAG_WP`` set, the latter
 you still need to supply a page when ``UFFDIO_REGISTER_MODE_MISSING`` was
 used.
 
+Userfaultfd write-protect mode currently behave differently on none ptes
+(when e.g. page is missing) over different types of memories.
+
+For anonymous memory, ``ioctl(UFFDIO_WRITEPROTECT)`` will ignore none ptes
+(e.g. when pages are missing and not populated).  For file-backed memories
+like shmem and hugetlbfs, none ptes will be write protected just like a
+present pte.  In other words, there will be a userfaultfd write fault
+message generated when writting to a missing page on file typed memories,
+as long as the page range was write-protected before.  Such a message will
+not be generated on anonymous memories by default.
+
+If the application wants to be able to write protect none ptes on anonymous
+memory, one can pre-populate the memory with e.g. MADV_POPULATE_READ.  On
+newer kernels, one can also detect the feature UFFD_FEATURE_WP_UNPOPULATED
+and set the feature bit in advance to make sure none ptes will also be
+write protected even upon anonymous memory.
+
 QEMU/KVM
 ========
 
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 44d1ee429eb0..881e9c82b9d1 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -108,6 +108,21 @@ static bool userfaultfd_is_initialized(struct userfaultfd_ctx *ctx)
 	return ctx->features & UFFD_FEATURE_INITIALIZED;
 }
 
+/*
+ * Whether WP_UNPOPULATED is enabled on the uffd context.  It is only
+ * meaningful when userfaultfd_wp()==true on the vma and when it's
+ * anonymous.
+ */
+bool userfaultfd_wp_unpopulated(struct vm_area_struct *vma)
+{
+	struct userfaultfd_ctx *ctx = vma->vm_userfaultfd_ctx.ctx;
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
@@ -1971,6 +1986,7 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
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
index 3767f18114ef..0cf8880219da 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -179,6 +179,7 @@ extern int userfaultfd_unmap_prep(struct mm_struct *mm, unsigned long start,
 				  unsigned long end, struct list_head *uf);
 extern void userfaultfd_unmap_complete(struct mm_struct *mm,
 				       struct list_head *uf);
+extern bool userfaultfd_wp_unpopulated(struct vm_area_struct *vma);
 
 #else /* CONFIG_USERFAULTFD */
 
@@ -274,8 +275,30 @@ static inline bool uffd_disable_fault_around(struct vm_area_struct *vma)
 	return false;
 }
 
+static inline bool userfaultfd_wp_unpopulated(struct vm_area_struct *vma)
+{
+	return false;
+}
+
 #endif /* CONFIG_USERFAULTFD */
 
+static inline bool userfaultfd_wp_use_markers(struct vm_area_struct *vma)
+{
+	/* Only wr-protect mode uses pte markers */
+	if (!userfaultfd_wp(vma))
+		return false;
+
+	/* File-based uffd-wp always need markers */
+	if (!vma_is_anonymous(vma))
+		return true;
+
+	/*
+	 * Anonymous uffd-wp only needs the markers if WP_UNPOPULATED
+	 * enabled (to apply markers on zero pages).
+	 */
+	return userfaultfd_wp_unpopulated(vma);
+}
+
 static inline bool pte_marker_entry_uffd_wp(swp_entry_t entry)
 {
 #ifdef CONFIG_PTE_MARKER_UFFD_WP
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
index 0adf23ea5416..8d73d3056348 100644
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
@@ -1350,6 +1364,10 @@ zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
 			      unsigned long addr, pte_t *pte,
 			      struct zap_details *details, pte_t pteval)
 {
+	/* Zap on anonymous always means dropping everything */
+	if (vma_is_anonymous(vma))
+		return;
+
 	if (zap_drop_file_uffd_wp(details))
 		return;
 
@@ -1456,8 +1474,12 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
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
@@ -3624,6 +3646,14 @@ static vm_fault_t pte_marker_clear(struct vm_fault *vmf)
 	return 0;
 }
 
+static vm_fault_t do_pte_missing(struct vm_fault *vmf)
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
@@ -3634,11 +3664,10 @@ static vm_fault_t pte_marker_handle_uffd_wp(struct vm_fault *vmf)
 	 * Just in case there're leftover special ptes even after the region
 	 * got unregistered - we can simply clear them.
 	 */
-	if (unlikely(!userfaultfd_wp(vmf->vma) || vma_is_anonymous(vmf->vma)))
+	if (unlikely(!userfaultfd_wp(vmf->vma)))
 		return pte_marker_clear(vmf);
 
-	/* do_fault() can handle pte markers too like none pte */
-	return do_fault(vmf);
+	return do_pte_missing(vmf);
 }
 
 static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
@@ -4008,6 +4037,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
  */
 static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 {
+	bool uffd_wp = vmf_orig_pte_uffd_wp(vmf);
 	struct vm_area_struct *vma = vmf->vma;
 	struct folio *folio;
 	vm_fault_t ret = 0;
@@ -4041,7 +4071,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 						vma->vm_page_prot));
 		vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
 				vmf->address, &vmf->ptl);
-		if (!pte_none(*vmf->pte)) {
+		if (vmf_pte_changed(vmf)) {
 			update_mmu_tlb(vma, vmf->address, vmf->pte);
 			goto unlock;
 		}
@@ -4081,7 +4111,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
 			&vmf->ptl);
-	if (!pte_none(*vmf->pte)) {
+	if (vmf_pte_changed(vmf)) {
 		update_mmu_tlb(vma, vmf->address, vmf->pte);
 		goto release;
 	}
@@ -4101,6 +4131,8 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	folio_add_new_anon_rmap(folio, vma, vmf->address);
 	folio_add_lru_vma(folio, vma);
 setpte:
+	if (uffd_wp)
+		entry = pte_mkuffd_wp(entry);
 	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
 
 	/* No need to invalidate - it was non-present before */
@@ -4268,7 +4300,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
 {
 	struct vm_area_struct *vma = vmf->vma;
-	bool uffd_wp = pte_marker_uffd_wp(vmf->orig_pte);
+	bool uffd_wp = vmf_orig_pte_uffd_wp(vmf);
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
 	bool prefault = vmf->address != addr;
 	pte_t entry;
@@ -4915,12 +4947,8 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		}
 	}
 
-	if (!vmf->pte) {
-		if (vma_is_anonymous(vmf->vma))
-			return do_anonymous_page(vmf);
-		else
-			return do_fault(vmf);
-	}
+	if (!vmf->pte)
+		return do_pte_missing(vmf);
 
 	if (!pte_present(vmf->orig_pte))
 		return do_swap_page(vmf);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 231929f119d9..455f7051098f 100644
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
+			if (userfaultfd_wp_use_markers(vma)) {
 				/*
 				 * For file-backed mem, we need to be able to
 				 * wr-protect a none pte, because even if the
@@ -320,23 +328,46 @@ static inline int pmd_none_or_clear_bad_unless_trans_huge(pmd_t *pmd)
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
+	/* Populate if the userfaultfd mode requires pte markers */
+	return userfaultfd_wp_use_markers(vma);
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
@@ -351,7 +382,7 @@ uffd_wp_protect_file(struct vm_area_struct *vma, unsigned long cp_flags)
 #define  change_prepare(vma, high, low, addr, cp_flags)			\
 	  ({								\
 		long err = 0;						\
-		if (unlikely(uffd_wp_protect_file(vma, cp_flags))) {	\
+		if (unlikely(pgtable_populate_needed(vma, cp_flags))) {	\
 			low##_t *p = low##_alloc(vma->vm_mm, high, addr); \
 			if (p == NULL)					\
 				err = -ENOMEM;				\
@@ -404,7 +435,7 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 
 		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)) {
 			if ((next - addr != HPAGE_PMD_SIZE) ||
-			    uffd_wp_protect_file(vma, cp_flags)) {
+			    pgtable_split_needed(vma, cp_flags)) {
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
 				/*
 				 * For file-backed, the pmd could have been
-- 
2.39.1

