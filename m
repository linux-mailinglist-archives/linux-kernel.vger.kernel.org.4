Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34D5615F33
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbiKBJNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbiKBJMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:12:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E19286F6;
        Wed,  2 Nov 2022 02:12:40 -0700 (PDT)
Date:   Wed, 02 Nov 2022 09:12:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667380358;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=e9uUSw8EVpTexp8I0TRf1oNdg3RQ7pHlb95ESBglqL8=;
        b=GeJ2XNMPtDUTdtzIl7h/+tdMh5f7JDAiJ7iuBQ3anEBUcFr+0OkrC9tWOrwSEsFOiKqlWv
        d1S/hR7h8ZybrhHQ6N50aAOY6A+rNf2uD/UnVO98Z97eKn6Dj2J5KWXTVXIIX9SKxsmTO5
        2HDRH1mlbSvGtxIlB+kttOcGSKq2D5RdyolhR9XnrsxSmzwZgikIIMl2Pde3/RMOgZnbMw
        UFHKDhZCYTuJqb0K7g99pdqAou2GnzsXvCzZGSlC4AjmqINZwvgpgJh6/JsQ+BJdLaV8bq
        Hb+ZrhnFABOeF2t1ZnVV0Xo6Ur2u9metjQJUh/W/6TYE1ZeOLBSxjRV33s1Jug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667380358;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=e9uUSw8EVpTexp8I0TRf1oNdg3RQ7pHlb95ESBglqL8=;
        b=kXAdTuQRZ0Af9QZrA147pYSLNEj0zh/MkYX0bbMwmWnHRjWEDVoCruGUaZgj2iVpvx8B+J
        hWne0EY8JMZ+4NBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/pae: Use WRITE_ONCE()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166738035739.7716.310533349085902628.tip-bot2@tip-bot2>
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

Commit-ID:     56a91588395af386a55bd2fee6304a161e7c766f
Gitweb:        https://git.kernel.org/tip/56a91588395af386a55bd2fee6304a161e7c766f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 26 Nov 2020 17:40:12 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Nov 2022 13:44:03 +01:00

x86/mm/pae: Use WRITE_ONCE()

Disallow write-tearing, that would be really unfortunate.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20221022114425.038102604%40infradead.org
---
 arch/x86/include/asm/pgtable-3level.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/pgtable-3level.h b/arch/x86/include/asm/pgtable-3level.h
index 0a1b81d..d3a2492 100644
--- a/arch/x86/include/asm/pgtable-3level.h
+++ b/arch/x86/include/asm/pgtable-3level.h
@@ -27,9 +27,9 @@
  */
 static inline void native_set_pte(pte_t *ptep, pte_t pte)
 {
-	ptep->pte_high = pte.pte_high;
+	WRITE_ONCE(ptep->pte_high, pte.pte_high);
 	smp_wmb();
-	ptep->pte_low = pte.pte_low;
+	WRITE_ONCE(ptep->pte_low, pte.pte_low);
 }
 
 static inline void native_set_pte_atomic(pte_t *ptep, pte_t pte)
@@ -58,16 +58,16 @@ static inline void native_set_pud(pud_t *pudp, pud_t pud)
 static inline void native_pte_clear(struct mm_struct *mm, unsigned long addr,
 				    pte_t *ptep)
 {
-	ptep->pte_low = 0;
+	WRITE_ONCE(ptep->pte_low, 0);
 	smp_wmb();
-	ptep->pte_high = 0;
+	WRITE_ONCE(ptep->pte_high, 0);
 }
 
 static inline void native_pmd_clear(pmd_t *pmdp)
 {
-	pmdp->pmd_low = 0;
+	WRITE_ONCE(pmdp->pmd_low, 0);
 	smp_wmb();
-	pmdp->pmd_high = 0;
+	WRITE_ONCE(pmdp->pmd_high, 0);
 }
 
 static inline void native_pud_clear(pud_t *pudp)
