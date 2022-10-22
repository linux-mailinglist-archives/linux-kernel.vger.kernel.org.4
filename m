Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84C6608CEE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 13:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiJVLsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 07:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJVLst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 07:48:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A80624FEC7
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 04:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ooIZw4CypGPCb0zPum6oOMgggH2beVobr6aR5c3g6lI=; b=K1NZC28rbCpDx1lOpuyqqeOlu0
        u3HYYfJW0hm7LNd8SPY5tyqEMpHWPxr11iKs9l58bdoPnVU6wHHL2BsM1n5/JdXsM0nZfADRbHFqz
        v8V6qBdgbc9YK9ivVKEpDExRf6QDkCdPgacqCcnSoo9/LIGBwfOTjWoso36OcEgniZ48URn3tfWKv
        9W3APtgZ2AOVMvmrrjyx1tGJ6tYWebVeBHPYVBttdim6OSimso7Cn3gFaTTlAa6QuNq13n8bEp1WD
        JUaT8tW6KC84dQ4vZgwnBJuYXBP8WtAmVqc1uEfDt3bFBi0IyCgb1WGcB4XpIzmQjGYlCvhnqr0X6
        FlQvWLug==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1omCzM-005XdS-Vs; Sat, 22 Oct 2022 11:48:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C79DA302E97;
        Sat, 22 Oct 2022 13:48:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3EEA728B8E517; Sat, 22 Oct 2022 13:48:26 +0200 (CEST)
Message-ID: <20221022114425.103392961@infradead.org>
User-Agent: quilt/0.66
Date:   Sat, 22 Oct 2022 13:14:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, willy@infradead.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux-mm@kvack.org, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, jroedel@suse.de, ubizjak@gmail.com
Subject: [PATCH 10/13] x86/mm/pae: Be consistent with pXXp_get_and_clear()
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

Given that ptep_get_and_clear() uses cmpxchg8b, and that should be by
far the most common case, there's no point in having an optimized
variant for pmd/pud.

Introduce the pxx_xchg64() helper to implement the common logic once.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/pgtable-3level.h |   67 ++++++++--------------------------
 1 file changed, 17 insertions(+), 50 deletions(-)

--- a/arch/x86/include/asm/pgtable-3level.h
+++ b/arch/x86/include/asm/pgtable-3level.h
@@ -90,34 +90,33 @@ static inline void pud_clear(pud_t *pudp
 	 */
 }
 
+
+#define pxx_xchg64(_pxx, _ptr, _val) ({					\
+	_pxx##val_t *_p = (_pxx##val_t *)_ptr;				\
+	_pxx##val_t _o = *_p;						\
+	do { } while (!try_cmpxchg64(_p, &_o, (_val)));			\
+	native_make_##_pxx(_o);						\
+})
+
 #ifdef CONFIG_SMP
 static inline pte_t native_ptep_get_and_clear(pte_t *ptep)
 {
-	pte_t old = *ptep;
-
-	do {
-	} while (!try_cmpxchg64(&ptep->pte, &old.pte, 0ULL));
-
-	return old;
+	return pxx_xchg64(pte, ptep, 0ULL);
 }
-#else
-#define native_ptep_get_and_clear(xp) native_local_ptep_get_and_clear(xp)
-#endif
 
-#ifdef CONFIG_SMP
 static inline pmd_t native_pmdp_get_and_clear(pmd_t *pmdp)
 {
-	pmd_t res;
-
-	/* xchg acts as a barrier before setting of the high bits */
-	res.pmd_low = xchg(&pmdp->pmd_low, 0);
-	res.pmd_high = READ_ONCE(pmdp->pmd_high);
-	WRITE_ONCE(pmdp->pmd_high, 0);
+	return pxx_xchg64(pmd, pmdp, 0ULL);
+}
 
-	return res;
+static inline pud_t native_pudp_get_and_clear(pud_t *pudp)
+{
+	return pxx_xchg64(pud, pudp, 0ULL);
 }
 #else
+#define native_ptep_get_and_clear(xp) native_local_ptep_get_and_clear(xp)
 #define native_pmdp_get_and_clear(xp) native_local_pmdp_get_and_clear(xp)
+#define native_pudp_get_and_clear(xp) native_local_pudp_get_and_clear(xp)
 #endif
 
 #ifndef pmdp_establish
@@ -141,40 +140,8 @@ static inline pmd_t pmdp_establish(struc
 		return old;
 	}
 
-	do {
-		old = *pmdp;
-	} while (cmpxchg64(&pmdp->pmd, old.pmd, pmd.pmd) != old.pmd);
-
-	return old;
-}
-#endif
-
-#ifdef CONFIG_SMP
-union split_pud {
-	struct {
-		u32 pud_low;
-		u32 pud_high;
-	};
-	pud_t pud;
-};
-
-static inline pud_t native_pudp_get_and_clear(pud_t *pudp)
-{
-	union split_pud res, *orig = (union split_pud *)pudp;
-
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
-	pti_set_user_pgtbl(&pudp->p4d.pgd, __pgd(0));
-#endif
-
-	/* xchg acts as a barrier before setting of the high bits */
-	res.pud_low = xchg(&orig->pud_low, 0);
-	res.pud_high = orig->pud_high;
-	orig->pud_high = 0;
-
-	return res.pud;
+	return pxx_xchg64(pmd, pmdp, pmd.pmd);
 }
-#else
-#define native_pudp_get_and_clear(xp) native_local_pudp_get_and_clear(xp)
 #endif
 
 /* Encode and de-code a swap entry */


