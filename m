Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CD5670EE4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 01:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjARAm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 19:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjARAlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 19:41:31 -0500
Received: from mail-io1-xd49.google.com (mail-io1-xd49.google.com [IPv6:2607:f8b0:4864:20::d49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2C63CE18
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:18:48 -0800 (PST)
Received: by mail-io1-xd49.google.com with SMTP id b21-20020a5d8d95000000b006fa39fbb94eso20260742ioj.17
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CTCu27j3NsgPeq6sMC4ftRhidA8hrlAj8BNmRhunsTg=;
        b=KmtgBZ0ns5KBrFINUJN1UyCkT0OkztNePcFoXQ/KcNMIWVI4/Md6wgIu7rD9n2Z9W7
         OHP52GbTDEUvON3Ld0n87PN+YeYWmganlqHvab14UiI2dOJRoBrxCTfp/qt8Xhwz53OB
         mPEpoJUArFb1uvBq5NwobsbT+aICrf6M2jI1VnONWmew09b3yBrXI5tYV14dkq1e3YUD
         0EHv/w9MXarhkO+fJBlUWX4vvx6dkSXDUwGOj0NKr7HEFADLxh0DrE/USqzuEbBO+WOd
         QBw+bLV+MykCDnCfOAw7H7t3evyBdMLMvH1I1gxmNRV/8Dny+rXsipWoINWSU52z73y8
         GcWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CTCu27j3NsgPeq6sMC4ftRhidA8hrlAj8BNmRhunsTg=;
        b=VAFbNQ3q6T/SBRKMw17E3WZa23g8n6og0zqdzKKeczaYHBhiVYiKmpwp88hhy4IRtB
         QUPpc273ingzBDzp1974k3BZE2bfCCkYLMBOj2Lz6dlE6asy2ojHPuVRdket6INCvCoF
         UADQWiPRUtRXVCsNUOO8stFUZqnIaj5wk8mllUKPA+pRj6a3DTKH7u7pbcqf60pX9aad
         PRl/sJgisD/OW4H2euprCSYHkcm6GO1Pk6d4l9Jri8YU9t1mQJW953NeQlGvpkZHhyux
         rReTdZbg/tKSxHfWBBFgAWaLChMT7TBYDZgBoYUngHQQCFFE6P095pI1Y4igqKLmnjaB
         p2fg==
X-Gm-Message-State: AFqh2kr56fqXMALbFPOsTUl5U5u1YiBiYba/UQLQI/epk/rkQtzebM+b
        b8Zuv4gRuPJIZoVCBnxIql3O+aKjD2lgZQ==
X-Google-Smtp-Source: AMrXdXuxcjNNoKg2rw1D3GgeuKMfxw+4OUiAhpy9aCzXSpOxc3V+thh4Ty8+l3G41CLAAnqXADnDMl74AePdDg==
X-Received: from talumbau.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:90d])
 (user=talumbau job=sendgmr) by 2002:a02:b795:0:b0:39e:9c44:3fe6 with SMTP id
 f21-20020a02b795000000b0039e9c443fe6mr578418jam.297.1674001128137; Tue, 17
 Jan 2023 16:18:48 -0800 (PST)
Date:   Wed, 18 Jan 2023 00:18:26 +0000
In-Reply-To: <20230118001827.1040870-1-talumbau@google.com>
Mime-Version: 1.0
References: <20230118001827.1040870-1-talumbau@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230118001827.1040870-7-talumbau@google.com>
Subject: [PATCH mm-unstable v1 6/7] mm: multi-gen LRU: improve walk_pmd_range()
From:   "T.J. Alumbaugh" <talumbau@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-mm@google.com, "T.J. Alumbaugh" <talumbau@google.com>
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

Improve readability of walk_pmd_range() and walk_pmd_range_locked().

Signed-off-by: T.J. Alumbaugh <talumbau@google.com>
---
 mm/vmscan.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index c2e6ad53447b..ff3b4aa3c31f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3999,8 +3999,8 @@ static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
 }
 
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG)
-static void walk_pmd_range_locked(pud_t *pud, unsigned long next, struct vm_area_struct *vma,
-				  struct mm_walk *args, unsigned long *bitmap, unsigned long *start)
+static void walk_pmd_range_locked(pud_t *pud, unsigned long addr, struct vm_area_struct *vma,
+				  struct mm_walk *args, unsigned long *bitmap, unsigned long *first)
 {
 	int i;
 	pmd_t *pmd;
@@ -4013,18 +4013,19 @@ static void walk_pmd_range_locked(pud_t *pud, unsigned long next, struct vm_area
 	VM_WARN_ON_ONCE(pud_leaf(*pud));
 
 	/* try to batch at most 1+MIN_LRU_BATCH+1 entries */
-	if (*start == -1) {
-		*start = next;
+	if (*first == -1) {
+		*first = addr;
+		bitmap_zero(bitmap, MIN_LRU_BATCH);
 		return;
 	}
 
-	i = next == -1 ? 0 : pmd_index(next) - pmd_index(*start);
+	i = addr == -1 ? 0 : pmd_index(addr) - pmd_index(*first);
 	if (i && i <= MIN_LRU_BATCH) {
 		__set_bit(i - 1, bitmap);
 		return;
 	}
 
-	pmd = pmd_offset(pud, *start);
+	pmd = pmd_offset(pud, *first);
 
 	ptl = pmd_lockptr(args->mm, pmd);
 	if (!spin_trylock(ptl))
@@ -4035,15 +4036,16 @@ static void walk_pmd_range_locked(pud_t *pud, unsigned long next, struct vm_area
 	do {
 		unsigned long pfn;
 		struct folio *folio;
-		unsigned long addr = i ? (*start & PMD_MASK) + i * PMD_SIZE : *start;
+
+		/* don't round down the first address */
+		addr = i ? (*first & PMD_MASK) + i * PMD_SIZE : *first;
 
 		pfn = get_pmd_pfn(pmd[i], vma, addr);
 		if (pfn == -1)
 			goto next;
 
 		if (!pmd_trans_huge(pmd[i])) {
-			if (arch_has_hw_nonleaf_pmd_young() &&
-			    get_cap(LRU_GEN_NONLEAF_YOUNG))
+			if (arch_has_hw_nonleaf_pmd_young() && get_cap(LRU_GEN_NONLEAF_YOUNG))
 				pmdp_test_and_clear_young(vma, addr, pmd + i);
 			goto next;
 		}
@@ -4072,12 +4074,11 @@ static void walk_pmd_range_locked(pud_t *pud, unsigned long next, struct vm_area
 	arch_leave_lazy_mmu_mode();
 	spin_unlock(ptl);
 done:
-	*start = -1;
-	bitmap_zero(bitmap, MIN_LRU_BATCH);
+	*first = -1;
 }
 #else
-static void walk_pmd_range_locked(pud_t *pud, unsigned long next, struct vm_area_struct *vma,
-				  struct mm_walk *args, unsigned long *bitmap, unsigned long *start)
+static void walk_pmd_range_locked(pud_t *pud, unsigned long addr, struct vm_area_struct *vma,
+				  struct mm_walk *args, unsigned long *bitmap, unsigned long *first)
 {
 }
 #endif
@@ -4090,9 +4091,9 @@ static void walk_pmd_range(pud_t *pud, unsigned long start, unsigned long end,
 	unsigned long next;
 	unsigned long addr;
 	struct vm_area_struct *vma;
-	unsigned long pos = -1;
+	unsigned long bitmap[BITS_TO_LONGS(MIN_LRU_BATCH)];
+	unsigned long first = -1;
 	struct lru_gen_mm_walk *walk = args->private;
-	unsigned long bitmap[BITS_TO_LONGS(MIN_LRU_BATCH)] = {};
 
 	VM_WARN_ON_ONCE(pud_leaf(*pud));
 
@@ -4131,18 +4132,17 @@ static void walk_pmd_range(pud_t *pud, unsigned long start, unsigned long end,
 			if (pfn < pgdat->node_start_pfn || pfn >= pgdat_end_pfn(pgdat))
 				continue;
 
-			walk_pmd_range_locked(pud, addr, vma, args, bitmap, &pos);
+			walk_pmd_range_locked(pud, addr, vma, args, bitmap, &first);
 			continue;
 		}
 #endif
 		walk->mm_stats[MM_NONLEAF_TOTAL]++;
 
-		if (arch_has_hw_nonleaf_pmd_young() &&
-		    get_cap(LRU_GEN_NONLEAF_YOUNG)) {
+		if (arch_has_hw_nonleaf_pmd_young() && get_cap(LRU_GEN_NONLEAF_YOUNG)) {
 			if (!pmd_young(val))
 				continue;
 
-			walk_pmd_range_locked(pud, addr, vma, args, bitmap, &pos);
+			walk_pmd_range_locked(pud, addr, vma, args, bitmap, &first);
 		}
 
 		if (!walk->force_scan && !test_bloom_filter(walk->lruvec, walk->max_seq, pmd + i))
@@ -4159,7 +4159,7 @@ static void walk_pmd_range(pud_t *pud, unsigned long start, unsigned long end,
 		update_bloom_filter(walk->lruvec, walk->max_seq + 1, pmd + i);
 	}
 
-	walk_pmd_range_locked(pud, -1, vma, args, bitmap, &pos);
+	walk_pmd_range_locked(pud, -1, vma, args, bitmap, &first);
 
 	if (i < PTRS_PER_PMD && get_next_vma(PUD_MASK, PMD_SIZE, args, &start, &end))
 		goto restart;
-- 
2.39.0.314.g84b9a713c41-goog

