Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3EF615F3D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiKBJOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbiKBJNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:13:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CCF28E25;
        Wed,  2 Nov 2022 02:12:44 -0700 (PDT)
Date:   Wed, 02 Nov 2022 09:12:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667380362;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=b1Xd7WLlUunRZgS6wyq5HgrLiH9Z3FGDx37GUrghheI=;
        b=QJuRG7wqk9i16Gjwx4ITxpScs6a8o1iLXukEtQhGJ1g89co7AkVeZn1uX/lJuXAoJazVjd
        DykXYirxSH66f10q2hVhIEYZ9NvGCq15xWXzdVoZrFBolC39xdp3JIGZVZxybrhyFej9ta
        zRDSG+AsPIx5YXTt6N4c9S1e5yZYNL7GRZpb965N2XTk58VdpUGGi3Jce7zD0DBOy3r35n
        TXM3DpzlPS+sC8r+sbr4nNIB48p1GjOR0mcOBl9XBpMaC9ZmxYjaldXUsFQa93KHhyd8so
        Vj0+0/42CxsnzvCTaVMtBgUpaEn3xDlAbsnZz0GqT4mIc1ujY55sRyWsxnMgJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667380362;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=b1Xd7WLlUunRZgS6wyq5HgrLiH9Z3FGDx37GUrghheI=;
        b=/hkp1NVqKhLclAKZDRZUQKVszvMIh9QGbNOntuHWE9mcrrQSwkKI9h5Pe54sW214KM1ywa
        WPuxpH4b/XPhfXCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/pae: Be consistent with pXXp_get_and_clear()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166738035620.7716.3394738648837838435.tip-bot2@tip-bot2>
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

Commit-ID:     533627610ae7709572a4fac1393fb61153e2a5b3
Gitweb:        https://git.kernel.org/tip/533627610ae7709572a4fac1393fb61153e2a5b3
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 30 Nov 2020 12:21:25 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Nov 2022 13:44:04 +01:00

x86/mm/pae: Be consistent with pXXp_get_and_clear()

Given that ptep_get_and_clear() uses cmpxchg8b, and that should be by
far the most common case, there's no point in having an optimized
variant for pmd/pud.

Introduce the pxx_xchg64() helper to implement the common logic once.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20221022114425.103392961%40infradead.org
---
 arch/x86/include/asm/pgtable-3level.h | 67 ++++++--------------------
 1 file changed, 17 insertions(+), 50 deletions(-)

diff --git a/arch/x86/include/asm/pgtable-3level.h b/arch/x86/include/asm/pgtable-3level.h
index d3a2492..93c82c6 100644
--- a/arch/x86/include/asm/pgtable-3level.h
+++ b/arch/x86/include/asm/pgtable-3level.h
@@ -90,34 +90,33 @@ static inline void pud_clear(pud_t *pudp)
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
@@ -141,42 +140,10 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 		return old;
 	}
 
-	do {
-		old = *pmdp;
-	} while (cmpxchg64(&pmdp->pmd, old.pmd, pmd.pmd) != old.pmd);
-
-	return old;
+	return pxx_xchg64(pmd, pmdp, pmd.pmd);
 }
 #endif
 
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
-}
-#else
-#define native_pudp_get_and_clear(xp) native_local_pudp_get_and_clear(xp)
-#endif
-
 /* Encode and de-code a swap entry */
 #define SWP_TYPE_BITS		5
 
