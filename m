Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D14A6350A7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 07:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236105AbiKWGpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 01:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235805AbiKWGpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 01:45:15 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF33F72C6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 22:45:13 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9905B1F88C;
        Wed, 23 Nov 2022 06:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669185912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ERGdKE61fVRNY0a6dOvhZEh4X8YafC9pFxMZrIBrLNI=;
        b=OU8vM80GCIzYkrqJveAbNhKEOuRrjXzRQNbmrV3uIdWjGnjqe5Ia12nx0sPRw9HGbcfK63
        xLs62YHbWi/dzAZyUcRBrLvreob17wfA7+TfxxlKSoDI5hxEMMym1wrtvUYpUHjHQYTXf5
        WY7CHY59E4VtWRxGkPK5CsUTsrAJEWY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4428413A37;
        Wed, 23 Nov 2022 06:45:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id w1E1D3jBfWMEQQAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 23 Nov 2022 06:45:12 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sander Eikelenboom <linux@eikelenboom.it>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v2] mm: introduce arch_has_hw_nonleaf_pmd_young()
Date:   Wed, 23 Nov 2022 07:45:10 +0100
Message-Id: <20221123064510.16225-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running as a Xen PV guests commit eed9a328aa1a ("mm: x86: add
CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG") can cause a protection violation
in pmdp_test_and_clear_young():

 BUG: unable to handle page fault for address: ffff8880083374d0
 #PF: supervisor write access in kernel mode
 #PF: error_code(0x0003) - permissions violation
 PGD 3026067 P4D 3026067 PUD 3027067 PMD 7fee5067 PTE 8010000008337065
 Oops: 0003 [#1] PREEMPT SMP NOPTI
 CPU: 7 PID: 158 Comm: kswapd0 Not tainted 6.1.0-rc5-20221118-doflr+ #1
 RIP: e030:pmdp_test_and_clear_young+0x25/0x40

This happens because the Xen hypervisor can't emulate direct writes to
page table entries other than PTEs.

This can easily be fixed by introducing arch_has_hw_nonleaf_pmd_young()
similar to arch_has_hw_pte_young() and test that instead of
CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG.

Fixes: eed9a328aa1a ("mm: x86: add CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG")
Reported-by: Sander Eikelenboom <linux@eikelenboom.it>
Signed-off-by: Juergen Gross <jgross@suse.com>
Acked-by: Yu Zhao <yuzhao@google.com>
Tested-by: Sander Eikelenboom <linux@eikelenboom.it>
---
V2:
- correct function name in commit message to match patch
---
 arch/x86/include/asm/pgtable.h |  8 ++++++++
 include/linux/pgtable.h        | 11 +++++++++++
 mm/vmscan.c                    | 10 +++++-----
 3 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 5059799bebe3..c567a6ed17ce 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1438,6 +1438,14 @@ static inline bool arch_has_hw_pte_young(void)
 	return true;
 }
 
+#ifdef CONFIG_XEN_PV
+#define arch_has_hw_nonleaf_pmd_young arch_has_hw_nonleaf_pmd_young
+static inline bool arch_has_hw_nonleaf_pmd_young(void)
+{
+	return !cpu_feature_enabled(X86_FEATURE_XENPV);
+}
+#endif
+
 #ifdef CONFIG_PAGE_TABLE_CHECK
 static inline bool pte_user_accessible_page(pte_t pte)
 {
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index a108b60a6962..58fc7e2d9575 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -260,6 +260,17 @@ static inline int pmdp_clear_flush_young(struct vm_area_struct *vma,
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 #endif
 
+#ifndef arch_has_hw_nonleaf_pmd_young
+/*
+ * Return whether the accessed bit in non-leaf PMD entries is supported on the
+ * local CPU.
+ */
+static inline bool arch_has_hw_nonleaf_pmd_young(void)
+{
+	return IS_ENABLED(CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG);
+}
+#endif
+
 #ifndef arch_has_hw_pte_young
 /*
  * Return whether the accessed bit is supported on the local CPU.
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 04d8b88e5216..a04ac3b18326 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3975,7 +3975,7 @@ static void walk_pmd_range_locked(pud_t *pud, unsigned long next, struct vm_area
 			goto next;
 
 		if (!pmd_trans_huge(pmd[i])) {
-			if (IS_ENABLED(CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG) &&
+			if (arch_has_hw_nonleaf_pmd_young() &&
 			    get_cap(LRU_GEN_NONLEAF_YOUNG))
 				pmdp_test_and_clear_young(vma, addr, pmd + i);
 			goto next;
@@ -4073,14 +4073,14 @@ static void walk_pmd_range(pud_t *pud, unsigned long start, unsigned long end,
 #endif
 		walk->mm_stats[MM_NONLEAF_TOTAL]++;
 
-#ifdef CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG
-		if (get_cap(LRU_GEN_NONLEAF_YOUNG)) {
+		if (arch_has_hw_nonleaf_pmd_young() &&
+		    get_cap(LRU_GEN_NONLEAF_YOUNG)) {
 			if (!pmd_young(val))
 				continue;
 
 			walk_pmd_range_locked(pud, addr, vma, args, bitmap, &pos);
 		}
-#endif
+
 		if (!walk->force_scan && !test_bloom_filter(walk->lruvec, walk->max_seq, pmd + i))
 			continue;
 
@@ -5354,7 +5354,7 @@ static ssize_t show_enabled(struct kobject *kobj, struct kobj_attribute *attr, c
 	if (arch_has_hw_pte_young() && get_cap(LRU_GEN_MM_WALK))
 		caps |= BIT(LRU_GEN_MM_WALK);
 
-	if (IS_ENABLED(CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG) && get_cap(LRU_GEN_NONLEAF_YOUNG))
+	if (arch_has_hw_nonleaf_pmd_young() && get_cap(LRU_GEN_NONLEAF_YOUNG))
 		caps |= BIT(LRU_GEN_NONLEAF_YOUNG);
 
 	return snprintf(buf, PAGE_SIZE, "0x%04x\n", caps);
-- 
2.35.3

