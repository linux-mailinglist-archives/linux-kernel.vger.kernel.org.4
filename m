Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDE4608CFB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 13:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbiJVLts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 07:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiJVLtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 07:49:01 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7456253BD1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 04:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=f4g92HolWEIcUN5sHQre4J13ebXNQzotEK5t5/pJgYg=; b=fWHHwCBmHCqVGItBT3D823XpSB
        9Dn0Fb6t5HnrtAN4U48A3Kztys6P91mnsAdPmGWnZ3YL+ZvkCkwUYv4Ial3sfGO9vpxYlV7hlxvyK
        3S4ZVu9VS0hcs0IcRh4wPkHYNzxCF+xcAfF3mKxqWKNm5u3W3mE/zcxAUdZZ35p0u0vwdqmIL82rj
        HnNNEu1yDU0W/lGAtsf9OLSNIhvyVEARw22A89v685RQawGPHxFiOAqR9vB8sH2yL2Ka38J0NakbM
        ssY2mMFhQM/DSYKztlMPN7IRfdul4t4thrnD2FzWx4MShTDJuzc0hlc+KfdxZjC/RbZuES/YqJTQo
        zuzGHOWA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1omCzL-005XdE-G3; Sat, 22 Oct 2022 11:48:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 36A6630067F;
        Sat, 22 Oct 2022 13:48:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1FFF728B8E50D; Sat, 22 Oct 2022 13:48:26 +0200 (CEST)
Message-ID: <20221022114424.580310787@infradead.org>
User-Agent: quilt/0.66
Date:   Sat, 22 Oct 2022 13:14:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, willy@infradead.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux-mm@kvack.org, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, jroedel@suse.de, ubizjak@gmail.com
Subject: [PATCH 02/13] x86/mm/pae: Make pmd_t similar to pte_t
References: <20221022111403.531902164@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of mucking about with at least 2 different ways of fudging
it, do the same thing we do for pte_t.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/pgtable-3level.h       |   42 +++++++++-------------------
 arch/x86/include/asm/pgtable-3level_types.h |    7 ++++
 arch/x86/include/asm/pgtable_64_types.h     |    1 
 arch/x86/include/asm/pgtable_types.h        |    4 --
 4 files changed, 23 insertions(+), 31 deletions(-)

--- a/arch/x86/include/asm/pgtable-3level.h
+++ b/arch/x86/include/asm/pgtable-3level.h
@@ -87,7 +87,7 @@ static inline pmd_t pmd_read_atomic(pmd_
 		ret |= ((pmdval_t)*(tmp + 1)) << 32;
 	}
 
-	return (pmd_t) { ret };
+	return (pmd_t) { .pmd = ret };
 }
 
 static inline void native_set_pte_atomic(pte_t *ptep, pte_t pte)
@@ -121,12 +121,11 @@ static inline void native_pte_clear(stru
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
@@ -162,25 +161,17 @@ static inline pte_t native_ptep_get_and_
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
@@ -199,17 +190,12 @@ static inline pmd_t pmdp_establish(struc
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
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -19,6 +19,7 @@ typedef unsigned long	pgdval_t;
 typedef unsigned long	pgprotval_t;
 
 typedef struct { pteval_t pte; } pte_t;
+typedef struct { pmdval_t pmd; } pmd_t;
 
 #ifdef CONFIG_X86_5LEVEL
 extern unsigned int __pgtable_l5_enabled;
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -381,11 +381,9 @@ static inline pudval_t native_pud_val(pu
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


