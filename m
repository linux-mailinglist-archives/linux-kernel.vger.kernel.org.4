Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8638B70BBB4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbjEVLZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjEVLYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:24:31 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D25E7B
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:21:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba2b9ecfadaso11578270276.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684754474; x=1687346474;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kdK6cg22OO4qOyQXs9xKaUltuTOUFz6FCWZwVxCh2Hw=;
        b=qWkhlrfibgnL4RhQHj7B1l6RBrzRaJLlA4S+q3+9iSaHf1FoZjrbjIeox0pMD4akA6
         baQ7YGto4El4LBM0QVJP4cql3S/UP2QCxjMxcH7zZ5WU2ZmYY0a2LN1Q9hftLvUgx6xY
         uXUXdOY22m4wBBpuN+E+S8/WR8wVUIBuOpCWW0NW5nnfixtNx9Op2M4J0Eea727f7z1S
         sf3g9TCIQtAIo4Vtb/9RoX4qfTdUkuWDMiPRz3BajpDxdF5yZCBeE2pRNa/l/Mg0f+eq
         /DBmBGIyvEk0YXmD4u8BuGDulx27iox/80TqcG8JU2bBdNBSanhjgzZa8EFs7/ImsyhS
         /GFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684754474; x=1687346474;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kdK6cg22OO4qOyQXs9xKaUltuTOUFz6FCWZwVxCh2Hw=;
        b=BIX6zw6jkcb84Ng5Dcdeh/bV0y6kX/xQVpANRGTVnrC1NfbDbyp3pRnlY5D4knzGy1
         zlIhMIQTFujYUDeQKk6kUcwvnSF6O6RdhkGdieWRNPzyxme++l7VeW7yrX4qIGGh3kNZ
         lrnKQO/glQz3sBxTunHwaew9ZQKliWO8R2QftUwUdkKQyilFjS92iJPCLT6bVrkRAfgU
         Lb+hOEiQjIrD27Lk/nlK8zThEEEVoH3TgCdD4PGxlafQmi/LbJ7FXCp4KO9h8AHOzm2y
         HYtIpobCw6P7ENwqbHdW9SDaweAt0YiQICmXbPvF5VVi0S3Z81eXkJzXmwr/XircPKhp
         Bhsw==
X-Gm-Message-State: AC+VfDy38xZdrQ3wZ8bCl6AYTucds4XpNhX23inIqHbgS6kEMcZU7qlj
        0ytpBXbZJK8X719KL/kZ0IQ1lxkX8Au83g==
X-Google-Smtp-Source: ACHHUZ446Fd/FV7ov35m5UQMLmkLqc0ZI7PlRhDVjQ/W3/nS3VNBnb0IdrQrR6Vu/5xKg9r94Z/zbNEve8+TSg==
X-Received: from talumbau.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:90d])
 (user=talumbau job=sendgmr) by 2002:a05:6902:56b:b0:ba8:91c2:268a with SMTP
 id a11-20020a056902056b00b00ba891c2268amr6184995ybt.0.1684754474384; Mon, 22
 May 2023 04:21:14 -0700 (PDT)
Date:   Mon, 22 May 2023 11:20:57 +0000
In-Reply-To: <20230522112058.2965866-1-talumbau@google.com>
Mime-Version: 1.0
References: <20230522112058.2965866-1-talumbau@google.com>
Message-ID: <20230522112058.2965866-3-talumbau@google.com>
Subject: [PATCH mm-unstable 3/4] mm: multi-gen LRU: add helpers in page table walks
From:   "T.J. Alumbaugh" <talumbau@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yuanchu Xie <yuanchu@google.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-mm@google.com, "T.J. Alumbaugh" <talumbau@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helpers to page table walking code:
 - Clarifies intent via name "should_walk_mmu" and "should_clear_pmd_young"
 - Avoids repeating same logic in two places

Signed-off-by: T.J. Alumbaugh <talumbau@google.com>
---
 mm/vmscan.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index e088db138f5f..ad0f589d32e6 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3234,6 +3234,16 @@ DEFINE_STATIC_KEY_ARRAY_FALSE(lru_gen_caps, NR_LRU_GEN_CAPS);
 #define get_cap(cap)	static_branch_unlikely(&lru_gen_caps[cap])
 #endif
 
+static bool should_walk_mmu(void)
+{
+	return arch_has_hw_pte_young() && get_cap(LRU_GEN_MM_WALK);
+}
+
+static bool should_clear_pmd_young(void)
+{
+	return arch_has_hw_nonleaf_pmd_young() && get_cap(LRU_GEN_NONLEAF_YOUNG);
+}
+
 /******************************************************************************
  *                          shorthand helpers
  ******************************************************************************/
@@ -4098,7 +4108,7 @@ static void walk_pmd_range_locked(pud_t *pud, unsigned long addr, struct vm_area
 			goto next;
 
 		if (!pmd_trans_huge(pmd[i])) {
-			if (arch_has_hw_nonleaf_pmd_young() && get_cap(LRU_GEN_NONLEAF_YOUNG))
+			if (should_clear_pmd_young())
 				pmdp_test_and_clear_young(vma, addr, pmd + i);
 			goto next;
 		}
@@ -4191,7 +4201,7 @@ static void walk_pmd_range(pud_t *pud, unsigned long start, unsigned long end,
 #endif
 		walk->mm_stats[MM_NONLEAF_TOTAL]++;
 
-		if (arch_has_hw_nonleaf_pmd_young() && get_cap(LRU_GEN_NONLEAF_YOUNG)) {
+		if (should_clear_pmd_young()) {
 			if (!pmd_young(val))
 				continue;
 
@@ -4493,7 +4503,7 @@ static bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long max_seq,
 	 * handful of PTEs. Spreading the work out over a period of time usually
 	 * is less efficient, but it avoids bursty page faults.
 	 */
-	if (!arch_has_hw_pte_young() || !get_cap(LRU_GEN_MM_WALK)) {
+	if (!should_walk_mmu()) {
 		success = iterate_mm_list_nowalk(lruvec, max_seq);
 		goto done;
 	}
@@ -5730,10 +5740,10 @@ static ssize_t enabled_show(struct kobject *kobj, struct kobj_attribute *attr, c
 	if (get_cap(LRU_GEN_CORE))
 		caps |= BIT(LRU_GEN_CORE);
 
-	if (arch_has_hw_pte_young() && get_cap(LRU_GEN_MM_WALK))
+	if (should_walk_mmu())
 		caps |= BIT(LRU_GEN_MM_WALK);
 
-	if (arch_has_hw_nonleaf_pmd_young() && get_cap(LRU_GEN_NONLEAF_YOUNG))
+	if (should_clear_pmd_young())
 		caps |= BIT(LRU_GEN_NONLEAF_YOUNG);
 
 	return sysfs_emit(buf, "0x%04x\n", caps);
-- 
2.40.1.698.g37aff9b760-goog

