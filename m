Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE0A607C87
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 18:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbiJUQkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 12:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiJUQjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:39:08 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEF82892EC
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:53 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-367dc159c2fso33850737b3.19
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 09:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l0T+gx8ZiJIGzUiHsY9RRIxEbYNQB6e8ZQhqkah5o0o=;
        b=hcmOSRNpRjq1NSM7DS6HOkNcODOyUhsGlgn2j//u74i5fPh2pgjEybQjits1Mwk5lZ
         lKPtFsy9JwRZ/QpCoIUrz+BOUQpmPn+x03wKvOaw4dkIE0YqoVSiYMWvcQlk22duLcOv
         Ih4SJ+4n2QJdtBkeEPXivg1YLJg/nUSmvxiKAqqtuM0iOZOwSeuYV7oa76jrjZexxv2d
         g2n70JA8Q7a6iYcl4XXTqj8YTsteJE6rxVLegrKhAN80Er0f8yLjwpslDHiqVDzr/NBy
         kxGlC87klGgk8zgpyI9hmrUjjd9CbOO8P2QhjI2W0lQZebZNHlUuk/9YNIni/j2WIMky
         1A6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l0T+gx8ZiJIGzUiHsY9RRIxEbYNQB6e8ZQhqkah5o0o=;
        b=GNWCZCcJNr+I3WzFPBtrqKMrn0XqxMbnh1cWkmQaTkl1ol0CYuI9xc5+9sLVndWJVq
         WsIZZW7P+0XNJko8mP0TwSUtZ2Ew1OfWAhmZmWh7WpjEYISoocUOEydZLIWiFL9bpW5w
         LcYcpsZhxoGS1fSIDoUF7HjjFrZ7ruzGePyo+wOQRnvBPBgWTTfmYnIGAFS3tFC7wRtz
         UfOyk94EWk3ejF4N7CwPPmOG6ONSau728aZrkz+JH50M3196hOUdUYA9humduQKdEGHe
         HUUq/N2K4oOJf9OB3ad0efC83PHkTVzIFLLrmURhG59OMv6h2wijHIhff7eWQClWNtEb
         CVOg==
X-Gm-Message-State: ACrzQf1+L6S1007Bt3iW9WatFfTMWHBt1liCozudrGEdliuMzV09B9/2
        YgyzUODhor5wEMeSidteg+8j/VMV+va+rO2g
X-Google-Smtp-Source: AMsMyM4JAXwy24rXZvtJd9kUyV3ZJKwuo8Rj2q9Eu3xMQ2hWwGLVEU/aYB0TsW+nYhoV4WdGOlqlbvyyVDobsOLq
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a81:5789:0:b0:35d:f12:4c0e with SMTP id
 l131-20020a815789000000b0035d0f124c0emr17814525ywb.26.1666370272899; Fri, 21
 Oct 2022 09:37:52 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:36:55 +0000
In-Reply-To: <20221021163703.3218176-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021163703.3218176-40-jthoughton@google.com>
Subject: [RFC PATCH v2 39/47] mm: smaps: add stats for HugeTLB mapping size
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
index be78cdb7677e..16288d6dbf1d 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -405,6 +405,15 @@ struct mem_size_stats {
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
@@ -720,6 +729,35 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
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
@@ -753,6 +791,8 @@ static int smaps_hugetlb_range(struct hugetlb_pte *hpte,
 			mss->shared_hugetlb += hugetlb_pte_size(hpte);
 		else
 			mss->private_hugetlb += hugetlb_pte_size(hpte);
+
+		smaps_hugetlb_hgm_account(mss, hpte);
 	}
 	return 0;
 }
@@ -822,38 +862,47 @@ static void smap_gather_stats(struct vm_area_struct *vma,
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
@@ -869,18 +918,18 @@ static int show_smap(struct seq_file *m, void *v)
 
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
2.38.0.135.g90850a2211-goog

