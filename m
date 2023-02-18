Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2968569B6DA
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 01:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjBRAbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 19:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjBRAan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:30:43 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FED6D264
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:41 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 75-20020a250b4e000000b0090f2c84a6a4so1998119ybl.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 16:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ep+t2caOQSahkPTOUAWt22QPS6ka0wL1iktlvruOFtk=;
        b=eXxtIitdVZvzFBf04daw9PPgRtXdmihKwPkQjcig6vMYYMtp+LOPKmFy/GNPGDZBuZ
         hUMbzRNTCrNmLeDYHlIEgRctvtpQ9FpU/o7UPh1ZIp/HRvg6DXU0nPANTJe2xRrjJGwp
         WbMuaqtCTStJZiCZ1A+9pK76quqdRz7D7vwYcnbCxzAH8ZqKG92mdTDkW+Ff5KgL16Oc
         bfQ+hpZtyfxk3DBK5nZlhD8pUxO/J77oxCvJiRMYzZvWPl+L1gHyATsIUcMQzvI17Xkm
         FGAjE5aD9xBtLlj157PrQ56C2U6XXydzea3z40X2BAfKNbG/jjnHVSZCkfPzbPOV1U8m
         sBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ep+t2caOQSahkPTOUAWt22QPS6ka0wL1iktlvruOFtk=;
        b=igxrMWXMAxA7kza0kCO3chs5gaHN3oSNNdh2nuAunXS+8wAL7oOwQ+rhkrjWxVoTf8
         EVX0yoJ3V8+kMcjBVjBMszCM2yzc+bs1xWkRaGX7uRoHrIDMX4kB09h8UKm1vRyAVItd
         WDX2AYVDMNrG7jYGSfAlxK445m0lyfCRCSr2qpy/hEfvkpEEBgsmgDNgeWicOaEYSrH0
         G2Xp4e0LhCffszc+NoX+wNQ3vvP7TZwCfP1tEp14wSzygiEWe3KzEygI3e/3ViDgZ9fP
         sR67ROMJSk3v8XzSYGxFdUVK6e/PRwRl9ZWnsklfRLl//Td+OJJxnmTJ1NptelZmS1Tn
         /2mQ==
X-Gm-Message-State: AO0yUKXwvMCaOPUT9aIEKkf93kLZyazWuikaxQMfNujn+4XYscJrtJf5
        bXqtdllh5G05ocgpPnCvo62Q5qWAfQXTF5PC
X-Google-Smtp-Source: AK7set+tBwsrzsGfYGkr6mqGYtCrd2pD30kKOdycyIYEofwc08SH08MLRIHONTv2mYLxvGH/o6jI+3RKVfH+ffxg
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a5b:d4b:0:b0:8da:6dc5:ca06 with SMTP id
 f11-20020a5b0d4b000000b008da6dc5ca06mr215488ybr.7.1676680162408; Fri, 17 Feb
 2023 16:29:22 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:28:11 +0000
In-Reply-To: <20230218002819.1486479-1-jthoughton@google.com>
Mime-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230218002819.1486479-39-jthoughton@google.com>
Subject: [PATCH v2 38/46] mm: smaps: add stats for HugeTLB mapping size
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
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
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
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

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 2f293b5dabc0..1ced7300f8cd 100644
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
+#endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
 	u64 pss;
 	u64 pss_anon;
 	u64 pss_file;
@@ -731,6 +740,33 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 }
 
 #ifdef CONFIG_HUGETLB_PAGE
+
+#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
+static void smaps_hugetlb_hgm_account(struct mem_size_stats *mss,
+		struct hugetlb_pte *hpte)
+{
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
+}
+#endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
+
 static int smaps_hugetlb_range(struct hugetlb_pte *hpte,
 				unsigned long addr,
 				struct mm_walk *walk)
@@ -764,6 +800,9 @@ static int smaps_hugetlb_range(struct hugetlb_pte *hpte,
 			mss->shared_hugetlb += sz;
 		else
 			mss->private_hugetlb += sz;
+#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
+		smaps_hugetlb_hgm_account(mss, hpte);
+#endif
 	}
 	return 0;
 }
@@ -833,38 +872,47 @@ static void smap_gather_stats(struct vm_area_struct *vma,
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
@@ -880,18 +928,18 @@ static int show_smap(struct seq_file *m, void *v)
 
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
2.39.2.637.g21b0678d19-goog

