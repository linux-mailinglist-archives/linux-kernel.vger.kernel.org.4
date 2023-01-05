Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840F065E8EE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjAEKXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbjAEKVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:21:48 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D1A32EAF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:19:49 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id n203-20020a2572d4000000b0078f09db9888so19455633ybc.18
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YROC31bBHQbBSjmgrEGHhxpa+rSAT6KfqkSaFQ7ab5I=;
        b=U/UY/aBZuBuGO1zBf6hoefUgK67MuUBly/rpc07hnF9u48daPB1OjsNzzcpRAPF19C
         LuSN2mUnYGUk8rvXyHGEuQtX3iEeJRkKhDrbwW5MY6Wf7TTfUt5oqHr8PuK0ICT4V7Ir
         G9IYlCVaymyzPUk4ZLkY6wnrdelHelK76kz4YyGJlubRd29SUQWrCXQl5QBNjdcKzI6B
         +QXWbVZqKiQuB/zZgtBcVlNNhSjJRbffRJg2gp1NzRPUYzXyFHl30sL1lhuUu2N/BaSC
         x0saMyGSHg8E20qCo+1AtcjQOlOpoSyK4amkpF0avMjdnvn1hlCJtd1I/c5LFWD6iihU
         /N9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YROC31bBHQbBSjmgrEGHhxpa+rSAT6KfqkSaFQ7ab5I=;
        b=E4fshb58xX1Dh+gTCJvKw8zabKuQlqXq2WXYndrMswerVehLJDCDYtZ/FmYXTcQXUd
         aBfwgQxXSBXVstOFgZ7PHq/DlyldaZJYCfpcmZT9JZBjwZw5f1sNzqzy1onGYOp5PA7f
         PiYjjnhLUjaihuHdD8yoBEvL+Qv02AQmZLOySPS6M9/UQkAXPKR6CpbkxvUJQ0SU0+uW
         H/usRuX/oJxjDiAVNGH/FF/RFYwBxkHo0M2PrQNjvMb4kfZfoDffBiJsF3qyggL/9j9m
         wjjFlRm09UAvCH/nBjOSy9XxJSZUBjLxUF0zqGWlj+5BozTv07Ttto0VjeRle5jRwgiu
         fywg==
X-Gm-Message-State: AFqh2kqeaKsbn6XvRDfjc6KBQlLaQwbQTadPuVgkDHmprmsb3IGo0oxo
        z77eQ1eilzOax8y69L+ow2r6ANU7UrWd5aZ+
X-Google-Smtp-Source: AMrXdXva/62F1LiNjUZP+w4O7dOJeE1Zyly2AVsZ+dGfpJE6FQgboB0b+h+nC+ToRQ8c3xNeHsE+NI6Dzh0EkPbj
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a0d:e5c3:0:b0:4ba:4d9d:ca0f with SMTP
 id o186-20020a0de5c3000000b004ba4d9dca0fmr472468ywe.250.1672913989605; Thu,
 05 Jan 2023 02:19:49 -0800 (PST)
Date:   Thu,  5 Jan 2023 10:18:36 +0000
In-Reply-To: <20230105101844.1893104-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230105101844.1893104-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230105101844.1893104-39-jthoughton@google.com>
Subject: [PATCH 38/46] mm: smaps: add stats for HugeTLB mapping size
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

When the kernel is compiled with HUGETLB_HIGH_GRANULARITY_MAPPING,
smaps may provide HugetlbPudMapped, HugetlbPmdMapped, and
HugetlbPteMapped. Levels that are folded will not be outputted.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 fs/proc/task_mmu.c | 101 +++++++++++++++++++++++++++++++++------------
 1 file changed, 75 insertions(+), 26 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index c353cab11eee..af31c4d314d2 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -412,6 +412,15 @@ struct mem_size_stats {
 	unsigned long swap;
 	unsigned long shared_hugetlb;
 	unsigned long private_hugetlb;
+#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
+#ifndef __PAGETABLE_PUD_FOLDED
+	unsigned long hugetlb_pud_mapped;
+#endif
+#ifndef __PAGETABLE_PMD_FOLDED
+	unsigned long hugetlb_pmd_mapped;
+#endif
+	unsigned long hugetlb_pte_mapped;
+#endif
 	u64 pss;
 	u64 pss_anon;
 	u64 pss_file;
@@ -731,6 +740,35 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 }
 
 #ifdef CONFIG_HUGETLB_PAGE
+
+static void smaps_hugetlb_hgm_account(struct mem_size_stats *mss,
+		struct hugetlb_pte *hpte)
+{
+#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
+	unsigned long size = hugetlb_pte_size(hpte);
+
+	switch (hpte->level) {
+#ifndef __PAGETABLE_PUD_FOLDED
+	case HUGETLB_LEVEL_PUD:
+		mss->hugetlb_pud_mapped += size;
+		break;
+#endif
+#ifndef __PAGETABLE_PMD_FOLDED
+	case HUGETLB_LEVEL_PMD:
+		mss->hugetlb_pmd_mapped += size;
+		break;
+#endif
+	case HUGETLB_LEVEL_PTE:
+		mss->hugetlb_pte_mapped += size;
+		break;
+	default:
+		break;
+	}
+#else
+	return;
+#endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
+}
+
 static int smaps_hugetlb_range(struct hugetlb_pte *hpte,
 				unsigned long addr,
 				struct mm_walk *walk)
@@ -764,6 +802,8 @@ static int smaps_hugetlb_range(struct hugetlb_pte *hpte,
 			mss->shared_hugetlb += hugetlb_pte_size(hpte);
 		else
 			mss->private_hugetlb += hugetlb_pte_size(hpte);
+
+		smaps_hugetlb_hgm_account(mss, hpte);
 	}
 	return 0;
 }
@@ -833,38 +873,47 @@ static void smap_gather_stats(struct vm_area_struct *vma,
 static void __show_smap(struct seq_file *m, const struct mem_size_stats *mss,
 	bool rollup_mode)
 {
-	SEQ_PUT_DEC("Rss:            ", mss->resident);
-	SEQ_PUT_DEC(" kB\nPss:            ", mss->pss >> PSS_SHIFT);
-	SEQ_PUT_DEC(" kB\nPss_Dirty:      ", mss->pss_dirty >> PSS_SHIFT);
+	SEQ_PUT_DEC("Rss:              ", mss->resident);
+	SEQ_PUT_DEC(" kB\nPss:              ", mss->pss >> PSS_SHIFT);
+	SEQ_PUT_DEC(" kB\nPss_Dirty:        ", mss->pss_dirty >> PSS_SHIFT);
 	if (rollup_mode) {
 		/*
 		 * These are meaningful only for smaps_rollup, otherwise two of
 		 * them are zero, and the other one is the same as Pss.
 		 */
-		SEQ_PUT_DEC(" kB\nPss_Anon:       ",
+		SEQ_PUT_DEC(" kB\nPss_Anon:         ",
 			mss->pss_anon >> PSS_SHIFT);
-		SEQ_PUT_DEC(" kB\nPss_File:       ",
+		SEQ_PUT_DEC(" kB\nPss_File:         ",
 			mss->pss_file >> PSS_SHIFT);
-		SEQ_PUT_DEC(" kB\nPss_Shmem:      ",
+		SEQ_PUT_DEC(" kB\nPss_Shmem:        ",
 			mss->pss_shmem >> PSS_SHIFT);
 	}
-	SEQ_PUT_DEC(" kB\nShared_Clean:   ", mss->shared_clean);
-	SEQ_PUT_DEC(" kB\nShared_Dirty:   ", mss->shared_dirty);
-	SEQ_PUT_DEC(" kB\nPrivate_Clean:  ", mss->private_clean);
-	SEQ_PUT_DEC(" kB\nPrivate_Dirty:  ", mss->private_dirty);
-	SEQ_PUT_DEC(" kB\nReferenced:     ", mss->referenced);
-	SEQ_PUT_DEC(" kB\nAnonymous:      ", mss->anonymous);
-	SEQ_PUT_DEC(" kB\nLazyFree:       ", mss->lazyfree);
-	SEQ_PUT_DEC(" kB\nAnonHugePages:  ", mss->anonymous_thp);
-	SEQ_PUT_DEC(" kB\nShmemPmdMapped: ", mss->shmem_thp);
-	SEQ_PUT_DEC(" kB\nFilePmdMapped:  ", mss->file_thp);
-	SEQ_PUT_DEC(" kB\nShared_Hugetlb: ", mss->shared_hugetlb);
-	seq_put_decimal_ull_width(m, " kB\nPrivate_Hugetlb: ",
+	SEQ_PUT_DEC(" kB\nShared_Clean:     ", mss->shared_clean);
+	SEQ_PUT_DEC(" kB\nShared_Dirty:     ", mss->shared_dirty);
+	SEQ_PUT_DEC(" kB\nPrivate_Clean:    ", mss->private_clean);
+	SEQ_PUT_DEC(" kB\nPrivate_Dirty:    ", mss->private_dirty);
+	SEQ_PUT_DEC(" kB\nReferenced:       ", mss->referenced);
+	SEQ_PUT_DEC(" kB\nAnonymous:        ", mss->anonymous);
+	SEQ_PUT_DEC(" kB\nLazyFree:         ", mss->lazyfree);
+	SEQ_PUT_DEC(" kB\nAnonHugePages:    ", mss->anonymous_thp);
+	SEQ_PUT_DEC(" kB\nShmemPmdMapped:   ", mss->shmem_thp);
+	SEQ_PUT_DEC(" kB\nFilePmdMapped:    ", mss->file_thp);
+	SEQ_PUT_DEC(" kB\nShared_Hugetlb:   ", mss->shared_hugetlb);
+	seq_put_decimal_ull_width(m, " kB\nPrivate_Hugetlb:   ",
 				  mss->private_hugetlb >> 10, 7);
-	SEQ_PUT_DEC(" kB\nSwap:           ", mss->swap);
-	SEQ_PUT_DEC(" kB\nSwapPss:        ",
+#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
+#ifndef __PAGETABLE_PUD_FOLDED
+	SEQ_PUT_DEC(" kB\nHugetlbPudMapped: ", mss->hugetlb_pud_mapped);
+#endif
+#ifndef __PAGETABLE_PMD_FOLDED
+	SEQ_PUT_DEC(" kB\nHugetlbPmdMapped: ", mss->hugetlb_pmd_mapped);
+#endif
+	SEQ_PUT_DEC(" kB\nHugetlbPteMapped: ", mss->hugetlb_pte_mapped);
+#endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
+	SEQ_PUT_DEC(" kB\nSwap:             ", mss->swap);
+	SEQ_PUT_DEC(" kB\nSwapPss:          ",
 					mss->swap_pss >> PSS_SHIFT);
-	SEQ_PUT_DEC(" kB\nLocked:         ",
+	SEQ_PUT_DEC(" kB\nLocked:           ",
 					mss->pss_locked >> PSS_SHIFT);
 	seq_puts(m, " kB\n");
 }
@@ -880,18 +929,18 @@ static int show_smap(struct seq_file *m, void *v)
 
 	show_map_vma(m, vma);
 
-	SEQ_PUT_DEC("Size:           ", vma->vm_end - vma->vm_start);
-	SEQ_PUT_DEC(" kB\nKernelPageSize: ", vma_kernel_pagesize(vma));
-	SEQ_PUT_DEC(" kB\nMMUPageSize:    ", vma_mmu_pagesize(vma));
+	SEQ_PUT_DEC("Size:             ", vma->vm_end - vma->vm_start);
+	SEQ_PUT_DEC(" kB\nKernelPageSize:   ", vma_kernel_pagesize(vma));
+	SEQ_PUT_DEC(" kB\nMMUPageSize:      ", vma_mmu_pagesize(vma));
 	seq_puts(m, " kB\n");
 
 	__show_smap(m, &mss, false);
 
-	seq_printf(m, "THPeligible:    %d\n",
+	seq_printf(m, "THPeligible:      %d\n",
 		   hugepage_vma_check(vma, vma->vm_flags, true, false, true));
 
 	if (arch_pkeys_enabled())
-		seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
+		seq_printf(m, "ProtectionKey:    %8u\n", vma_pkey(vma));
 	show_smap_vma_flags(m, vma);
 
 	return 0;
-- 
2.39.0.314.g84b9a713c41-goog

