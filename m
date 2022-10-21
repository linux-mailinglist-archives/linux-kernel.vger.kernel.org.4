Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71B8607C66
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiJUQh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiJUQh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:37:29 -0400
Received: from mail-ua1-x94a.google.com (mail-ua1-x94a.google.com [IPv6:2607:f8b0:4864:20::94a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED6227B564
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:25 -0700 (PDT)
Received: by mail-ua1-x94a.google.com with SMTP id h11-20020ab0470b000000b003bf1da44886so2348887uac.17
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2b1VLSKb1qIoBhHv68uc7sEp7uA+Ju1UfoLt8HAduUY=;
        b=fFKq9A+3A5TkI1IGkVnB2YWBf8fVHVGy1IiVCq2xH2D+ukznX6/SfUTTA86X+pjDnq
         mbkAvkkQZk6J12PGLDzV/KGi2b7kOMU02Aktw1M0kEN5f6ZdQppBNHzpLJZ/2+Tr/2/g
         ncbFQte81ZEqmhzmntgBziWdoyhRcdyDj0o5k51Fk87D8MZ5FdHzTMkbyahm7686yY3i
         DZOqrcFZGBRSPmwIMgUobG/r3zXICtn1+y5idZYO2hGxg2n7PJaREU84U/umC4o0E0Ow
         /Kbl96xQv1BiA7GCRPg/XqDMmTLQZjscb0wPrtARpfKTcFdOZGNtTdI8o1uc4cbj1uEg
         69aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2b1VLSKb1qIoBhHv68uc7sEp7uA+Ju1UfoLt8HAduUY=;
        b=dZLaVedVZ65npY9+RIkby/0YIv1neWgkH3rdavJ16jIuwGRuR2nsjOPPvHuQo2suEw
         OZUIbouwdSSR+DHbCEOumya9kGRgCPjOHT1TN2L0+MUMjCiaDfZ5gN/uFVc+cmqCUWu5
         XQq1NPLkgztXYvNt3vGFJLnme5Qk8U4C7JLsP1uBegrpRuUpQ28nO43FEq42WsZRY5ab
         lw1enGh4lZy7Tw9F1zko4k+DZ7MqdL43Jcge7Jot6a7jhXvRFiTjaSPZ5Qs9lb+D8EuG
         0aKZ5dV1K37jt655ehSL3MZQwIJARx8YSpmWodtY/5gtrzpVpY2fLKGwCpYo856HfVGC
         5/bA==
X-Gm-Message-State: ACrzQf3b8CdCQyxV2yrGUJzPodUqkIhIWoC9aHvee0fvpO0m0NtfI9LT
        +Yp/nqfcRehuxzcyn4r1AXXQhIYp/Qvsm77+
X-Google-Smtp-Source: AMsMyM4U494lNIuvyXBYQh14d1SDt3UAjeXmdAvTI/QhS8Lp1qSrtxq6ioU81FqwlquHVCLPB+1LIMea9tgSCnQ7
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:ab0:6847:0:b0:3f0:c29b:e14a with SMTP
 id a7-20020ab06847000000b003f0c29be14amr9896783uas.33.1666370244124; Fri, 21
 Oct 2022 09:37:24 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:36:24 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-9-jthoughton@google.com>
Subject: [RFC PATCH v2 08/47] hugetlb: add HGM enablement functions
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
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

Currently it is possible for all shared VMAs to use HGM, but it must be
enabled first. This is because with HGM, we lose PMD sharing, and page
table walks require additional synchronization (we need to take the VMA
lock).

Signed-off-by: James Houghton <jthoughton@google.com>
---
 include/linux/hugetlb.h | 22 +++++++++++++
 mm/hugetlb.c            | 69 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 534958499ac4..6e0c36b08a0c 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -123,6 +123,9 @@ struct hugetlb_vma_lock {
 
 struct hugetlb_shared_vma_data {
 	struct hugetlb_vma_lock vma_lock;
+#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
+	bool hgm_enabled;
+#endif
 };
 
 extern struct resv_map *resv_map_alloc(void);
@@ -1179,6 +1182,25 @@ static inline void hugetlb_unregister_node(struct node *node)
 }
 #endif	/* CONFIG_HUGETLB_PAGE */
 
+#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
+bool hugetlb_hgm_enabled(struct vm_area_struct *vma);
+bool hugetlb_hgm_eligible(struct vm_area_struct *vma);
+int enable_hugetlb_hgm(struct vm_area_struct *vma);
+#else
+static inline bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
+{
+	return false;
+}
+static inline bool hugetlb_hgm_eligible(struct vm_area_struct *vma)
+{
+	return false;
+}
+static inline int enable_hugetlb_hgm(struct vm_area_struct *vma)
+{
+	return -EINVAL;
+}
+#endif
+
 static inline spinlock_t *huge_pte_lock(struct hstate *h,
 					struct mm_struct *mm, pte_t *pte)
 {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5ae8bc8c928e..a18143add956 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6840,6 +6840,10 @@ static bool pmd_sharing_possible(struct vm_area_struct *vma)
 #ifdef CONFIG_USERFAULTFD
 	if (uffd_disable_huge_pmd_share(vma))
 		return false;
+#endif
+#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
+	if (hugetlb_hgm_enabled(vma))
+		return false;
 #endif
 	/*
 	 * Only shared VMAs can share PMDs.
@@ -7033,6 +7037,9 @@ static int hugetlb_vma_data_alloc(struct vm_area_struct *vma)
 	kref_init(&data->vma_lock.refs);
 	init_rwsem(&data->vma_lock.rw_sema);
 	data->vma_lock.vma = vma;
+#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
+	data->hgm_enabled = false;
+#endif
 	vma->vm_private_data = data;
 	return 0;
 }
@@ -7290,6 +7297,68 @@ __weak unsigned long hugetlb_mask_last_page(struct hstate *h)
 
 #endif /* CONFIG_ARCH_WANT_GENERAL_HUGETLB */
 
+#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
+bool hugetlb_hgm_eligible(struct vm_area_struct *vma)
+{
+	/*
+	 * All shared VMAs may have HGM.
+	 *
+	 * HGM requires using the VMA lock, which only exists for shared VMAs.
+	 * To make HGM work for private VMAs, we would need to use another
+	 * scheme to prevent collapsing/splitting from invalidating other
+	 * threads' page table walks.
+	 */
+	return vma && (vma->vm_flags & VM_MAYSHARE);
+}
+bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
+{
+	struct hugetlb_shared_vma_data *data = vma->vm_private_data;
+
+	if (!vma || !(vma->vm_flags & VM_MAYSHARE))
+		return false;
+
+	return data && data->hgm_enabled;
+}
+
+/*
+ * Enable high-granularity mapping (HGM) for this VMA. Once enabled, HGM
+ * cannot be turned off.
+ *
+ * PMDs cannot be shared in HGM VMAs.
+ */
+int enable_hugetlb_hgm(struct vm_area_struct *vma)
+{
+	int ret;
+	struct hugetlb_shared_vma_data *data;
+
+	if (!hugetlb_hgm_eligible(vma))
+		return -EINVAL;
+
+	if (hugetlb_hgm_enabled(vma))
+		return 0;
+
+	/*
+	 * We must hold the mmap lock for writing so that callers can rely on
+	 * hugetlb_hgm_enabled returning a consistent result while holding
+	 * the mmap lock for reading.
+	 */
+	mmap_assert_write_locked(vma->vm_mm);
+
+	/* HugeTLB HGM requires the VMA lock to synchronize collapsing. */
+	ret = hugetlb_vma_data_alloc(vma);
+	if (ret)
+		return ret;
+
+	data = vma->vm_private_data;
+	BUG_ON(!data);
+	data->hgm_enabled = true;
+
+	/* We don't support PMD sharing with HGM. */
+	hugetlb_unshare_all_pmds(vma);
+	return 0;
+}
+#endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
+
 /*
  * These functions are overwritable if your architecture needs its own
  * behavior.
-- 
2.38.0.135.g90850a2211-goog

