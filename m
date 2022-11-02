Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35488615F44
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiKBJO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiKBJNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:13:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF3B286F8;
        Wed,  2 Nov 2022 02:12:45 -0700 (PDT)
Date:   Wed, 02 Nov 2022 09:12:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667380364;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ESfO0u5bKjAsNcCeuEXFUdb/g8igRH9nlk5zjoK4QQI=;
        b=DFxrgvtyLvg3q9CQ9kXr5MFcqLjaLjBN+4SZtnaQ1BEIxZCruLnSjdZW7IBWd+LTj/ZujA
        1QsEfh08dOEXWo2I/8y6XY555fPnYWAkt+jPtkl83NpwemJYHSRkSIIM8kOrJ5DNTiUFRn
        vmv/OsRQ3l+TDsieJLydembC7Je5ex3n4WOnu8qX86Vew+Rx0Vhr/ulnppFpwWy47glkRh
        lBNVfPGlJotxwS6bO1DsdyCQDtH+MpJrgKpiOdWZ/B85gchz9bodUPE0jR6/52N3YGoMJR
        m5obrIg9ZWyTcEYDdQ1MIVp+U2k4yDQqUobMKannZta32QIk+o3W/80zoqFYuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667380364;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ESfO0u5bKjAsNcCeuEXFUdb/g8igRH9nlk5zjoK4QQI=;
        b=vGbHE4lk6XjxPFvwLyqR8tHpUjg2USQCYrXoCGKddwa8dtCx4o2ZwR9Y8EJjH8lGSDDJJK
        xj4+kWN9friEkNBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] mm: Fix pmd_read_atomic()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166738036297.7716.1671235806175659018.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     a93f1747e1417f00d25a22ade495c222643d975e
Gitweb:        https://git.kernel.org/tip/a93f1747e1417f00d25a22ade495c222643d975e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 26 Nov 2020 17:16:22 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Nov 2022 13:44:01 +01:00

mm: Fix pmd_read_atomic()

AFAICT there's no reason to do anything different than what we do for
PTEs. Make it so (also affects SH).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20221022114424.711181252%40infradead.org
---
 arch/x86/include/asm/pgtable-3level.h | 56 +--------------------------
 include/linux/pgtable.h               | 47 +++++++++++++++++-----
 2 files changed, 37 insertions(+), 66 deletions(-)

diff --git a/arch/x86/include/asm/pgtable-3level.h b/arch/x86/include/asm/pgtable-3level.h
index 28556d2..94f50b0 100644
--- a/arch/x86/include/asm/pgtable-3level.h
+++ b/arch/x86/include/asm/pgtable-3level.h
@@ -34,62 +34,6 @@ static inline void native_set_pte(pte_t *ptep, pte_t pte)
 	ptep->pte_low = pte.pte_low;
 }
 
-#define pmd_read_atomic pmd_read_atomic
-/*
- * pte_offset_map_lock() on 32-bit PAE kernels was reading the pmd_t with
- * a "*pmdp" dereference done by GCC. Problem is, in certain places
- * where pte_offset_map_lock() is called, concurrent page faults are
- * allowed, if the mmap_lock is hold for reading. An example is mincore
- * vs page faults vs MADV_DONTNEED. On the page fault side
- * pmd_populate() rightfully does a set_64bit(), but if we're reading the
- * pmd_t with a "*pmdp" on the mincore side, a SMP race can happen
- * because GCC will not read the 64-bit value of the pmd atomically.
- *
- * To fix this all places running pte_offset_map_lock() while holding the
- * mmap_lock in read mode, shall read the pmdp pointer using this
- * function to know if the pmd is null or not, and in turn to know if
- * they can run pte_offset_map_lock() or pmd_trans_huge() or other pmd
- * operations.
- *
- * Without THP if the mmap_lock is held for reading, the pmd can only
- * transition from null to not null while pmd_read_atomic() runs. So
- * we can always return atomic pmd values with this function.
- *
- * With THP if the mmap_lock is held for reading, the pmd can become
- * trans_huge or none or point to a pte (and in turn become "stable")
- * at any time under pmd_read_atomic(). We could read it truly
- * atomically here with an atomic64_read() for the THP enabled case (and
- * it would be a whole lot simpler), but to avoid using cmpxchg8b we
- * only return an atomic pmdval if the low part of the pmdval is later
- * found to be stable (i.e. pointing to a pte). We are also returning a
- * 'none' (zero) pmdval if the low part of the pmd is zero.
- *
- * In some cases the high and low part of the pmdval returned may not be
- * consistent if THP is enabled (the low part may point to previously
- * mapped hugepage, while the high part may point to a more recently
- * mapped hugepage), but pmd_none_or_trans_huge_or_clear_bad() only
- * needs the low part of the pmd to be read atomically to decide if the
- * pmd is unstable or not, with the only exception when the low part
- * of the pmd is zero, in which case we return a 'none' pmd.
- */
-static inline pmd_t pmd_read_atomic(pmd_t *pmdp)
-{
-	pmdval_t ret;
-	u32 *tmp = (u32 *)pmdp;
-
-	ret = (pmdval_t) (*tmp);
-	if (ret) {
-		/*
-		 * If the low part is null, we must not read the high part
-		 * or we can end up with a partial pmd.
-		 */
-		smp_rmb();
-		ret |= ((pmdval_t)*(tmp + 1)) << 32;
-	}
-
-	return (pmd_t) { .pmd = ret };
-}
-
 static inline void native_set_pte_atomic(pte_t *ptep, pte_t pte)
 {
 	set_64bit((unsigned long long *)(ptep), native_pte_val(pte));
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index c0b2900..765fd4b 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -298,6 +298,13 @@ static inline pte_t ptep_get(pte_t *ptep)
 }
 #endif
 
+#ifndef __HAVE_ARCH_PMDP_GET
+static inline pmd_t pmdp_get(pmd_t *pmdp)
+{
+	return READ_ONCE(*pmdp);
+}
+#endif
+
 #ifdef CONFIG_GUP_GET_PTE_LOW_HIGH
 /*
  * For walking the pagetables without holding any locks.  Some architectures
@@ -340,15 +347,42 @@ static inline pte_t ptep_get_lockless(pte_t *ptep)
 
 	return pte;
 }
-#else /* CONFIG_GUP_GET_PTE_LOW_HIGH */
+#define ptep_get_lockless ptep_get_lockless
+
+#if CONFIG_PGTABLE_LEVELS > 2
+static inline pmd_t pmdp_get_lockless(pmd_t *pmdp)
+{
+	pmd_t pmd;
+
+	do {
+		pmd.pmd_low = pmdp->pmd_low;
+		smp_rmb();
+		pmd.pmd_high = pmdp->pmd_high;
+		smp_rmb();
+	} while (unlikely(pmd.pmd_low != pmdp->pmd_low));
+
+	return pmd;
+}
+#define pmdp_get_lockless pmdp_get_lockless
+#endif /* CONFIG_PGTABLE_LEVELS > 2 */
+#endif /* CONFIG_GUP_GET_PTE_LOW_HIGH */
+
 /*
  * We require that the PTE can be read atomically.
  */
+#ifndef ptep_get_lockless
 static inline pte_t ptep_get_lockless(pte_t *ptep)
 {
 	return ptep_get(ptep);
 }
-#endif /* CONFIG_GUP_GET_PTE_LOW_HIGH */
+#endif
+
+#ifndef pmdp_get_lockless
+static inline pmd_t pmdp_get_lockless(pmd_t *pmdp)
+{
+	return pmdp_get(pmdp);
+}
+#endif
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #ifndef __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR
@@ -1318,17 +1352,10 @@ static inline int pud_trans_unstable(pud_t *pud)
 #endif
 }
 
-#ifndef pmd_read_atomic
 static inline pmd_t pmd_read_atomic(pmd_t *pmdp)
 {
-	/*
-	 * Depend on compiler for an atomic pmd read. NOTE: this is
-	 * only going to work, if the pmdval_t isn't larger than
-	 * an unsigned long.
-	 */
-	return *pmdp;
+	return pmdp_get_lockless(pmdp);
 }
-#endif
 
 #ifndef arch_needs_pgtable_deposit
 #define arch_needs_pgtable_deposit() (false)
