Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FF8615F46
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbiKBJOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiKBJNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:13:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4C128E31;
        Wed,  2 Nov 2022 02:12:47 -0700 (PDT)
Date:   Wed, 02 Nov 2022 09:12:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667380366;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/hOgdQEqHCc4kXSqZe5ZrwcVNawTBjvm+c+P7ud1s2Q=;
        b=1ckZz3/9tAdL/SLYmxBwfK1f81QtJno0voeIR4WF/H1LT+tBbcLuZAOQzU/IloR5dp+sEb
        PbweuQ0uiqSaeKOozKtWtn0/4+B39TBScbSIzzh9zcuU32ZocuKCsDwsLyWhEatH9eq4a/
        CgIggUKC5C0UU0SipYqE7cYFtYq4OxJT7YRaGrvmIB/C7VBv87mbzLfyjgGkASFmXXoorm
        3rc7ZpTIGipS2tkbHScd0vHIGeC2YYfaS4j/3/qU6tMezcPhSwIIcYoys508mZqPzunugM
        GltnCtmL9WcseoH1VdyQePOx6Pn9TRJBV1QP1+MLXSwDuxpdFQ9j2dGJj8vYJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667380366;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/hOgdQEqHCc4kXSqZe5ZrwcVNawTBjvm+c+P7ud1s2Q=;
        b=/xuwCnD2eMSxWRW8ZVFKmPjCYtGuYcPTCgv2q2lQC8qOYzU1bEBRzQLcQjU7PGtBa2nJPC
        mf0c0GPn759kYMDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/pae: Make pmd_t similar to pte_t
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166738036528.7716.4800701229121974327.tip-bot2@tip-bot2>
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

Commit-ID:     f8c40885e40fd8f5d96c58f4dfca7072fe09a37b
Gitweb:        https://git.kernel.org/tip/f8c40885e40fd8f5d96c58f4dfca7072fe09a37b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 26 Nov 2020 17:02:29 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Nov 2022 13:44:00 +01:00

x86/mm/pae: Make pmd_t similar to pte_t

Instead of mucking about with at least 2 different ways of fudging
it, do the same thing we do for pte_t.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20221022114424.580310787%40infradead.org
---
 arch/x86/include/asm/pgtable-3level.h       | 42 ++++++--------------
 arch/x86/include/asm/pgtable-3level_types.h |  7 +++-
 arch/x86/include/asm/pgtable_64_types.h     |  1 +-
 arch/x86/include/asm/pgtable_types.h        |  4 +--
 4 files changed, 23 insertions(+), 31 deletions(-)

diff --git a/arch/x86/include/asm/pgtable-3level.h b/arch/x86/include/asm/pgtable-3level.h
index 28421a8..28556d2 100644
--- a/arch/x86/include/asm/pgtable-3level.h
+++ b/arch/x86/include/asm/pgtable-3level.h
@@ -87,7 +87,7 @@ static inline pmd_t pmd_read_atomic(pmd_t *pmdp)
 		ret |= ((pmdval_t)*(tmp + 1)) << 32;
 	}
 
-	return (pmd_t) { ret };
+	return (pmd_t) { .pmd = ret };
 }
 
 static inline void native_set_pte_atomic(pte_t *ptep, pte_t pte)
@@ -121,12 +121,11 @@ static inline void native_pte_clear(struct mm_struct *mm, unsigned long addr,
 	ptep->pte_high = 0;
 }
 
-static inline void native_pmd_clear(pmd_t *pmd)
+static inline void native_pmd_clear(pmd_t *pmdp)
 {
-	u32 *tmp = (u32 *)pmd;
-	*tmp = 0;
+	pmdp->pmd_low = 0;
 	smp_wmb();
-	*(tmp + 1) = 0;
+	pmdp->pmd_high = 0;
 }
 
 static inline void native_pud_clear(pud_t *pudp)
@@ -162,25 +161,17 @@ static inline pte_t native_ptep_get_and_clear(pte_t *ptep)
 #define native_ptep_get_and_clear(xp) native_local_ptep_get_and_clear(xp)
 #endif
 
-union split_pmd {
-	struct {
-		u32 pmd_low;
-		u32 pmd_high;
-	};
-	pmd_t pmd;
-};
-
 #ifdef CONFIG_SMP
 static inline pmd_t native_pmdp_get_and_clear(pmd_t *pmdp)
 {
-	union split_pmd res, *orig = (union split_pmd *)pmdp;
+	pmd_t res;
 
 	/* xchg acts as a barrier before setting of the high bits */
-	res.pmd_low = xchg(&orig->pmd_low, 0);
-	res.pmd_high = orig->pmd_high;
-	orig->pmd_high = 0;
+	res.pmd_low = xchg(&pmdp->pmd_low, 0);
+	res.pmd_high = READ_ONCE(pmdp->pmd_high);
+	WRITE_ONCE(pmdp->pmd_high, 0);
 
-	return res.pmd;
+	return res;
 }
 #else
 #define native_pmdp_get_and_clear(xp) native_local_pmdp_get_and_clear(xp)
@@ -199,17 +190,12 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 	 * anybody.
 	 */
 	if (!(pmd_val(pmd) & _PAGE_PRESENT)) {
-		union split_pmd old, new, *ptr;
-
-		ptr = (union split_pmd *)pmdp;
-
-		new.pmd = pmd;
-
 		/* xchg acts as a barrier before setting of the high bits */
-		old.pmd_low = xchg(&ptr->pmd_low, new.pmd_low);
-		old.pmd_high = ptr->pmd_high;
-		ptr->pmd_high = new.pmd_high;
-		return old.pmd;
+		old.pmd_low = xchg(&pmdp->pmd_low, pmd.pmd_low);
+		old.pmd_high = READ_ONCE(pmdp->pmd_high);
+		WRITE_ONCE(pmdp->pmd_high, pmd.pmd_high);
+
+		return old;
 	}
 
 	do {
diff --git a/arch/x86/include/asm/pgtable-3level_types.h b/arch/x86/include/asm/pgtable-3level_types.h
index 56baf43..8091134 100644
--- a/arch/x86/include/asm/pgtable-3level_types.h
+++ b/arch/x86/include/asm/pgtable-3level_types.h
@@ -18,6 +18,13 @@ typedef union {
 	};
 	pteval_t pte;
 } pte_t;
+
+typedef union {
+	struct {
+		unsigned long pmd_low, pmd_high;
+	};
+	pmdval_t pmd;
+} pmd_t;
 #endif	/* !__ASSEMBLY__ */
 
 #define SHARED_KERNEL_PMD	(!static_cpu_has(X86_FEATURE_PTI))
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 04f3606..38bf837 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -19,6 +19,7 @@ typedef unsigned long	pgdval_t;
 typedef unsigned long	pgprotval_t;
 
 typedef struct { pteval_t pte; } pte_t;
+typedef struct { pmdval_t pmd; } pmd_t;
 
 #ifdef CONFIG_X86_5LEVEL
 extern unsigned int __pgtable_l5_enabled;
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index aa174fe..447d4be 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -361,11 +361,9 @@ static inline pudval_t native_pud_val(pud_t pud)
 #endif
 
 #if CONFIG_PGTABLE_LEVELS > 2
-typedef struct { pmdval_t pmd; } pmd_t;
-
 static inline pmd_t native_make_pmd(pmdval_t val)
 {
-	return (pmd_t) { val };
+	return (pmd_t) { .pmd = val };
 }
 
 static inline pmdval_t native_pmd_val(pmd_t pmd)
