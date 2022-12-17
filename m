Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC3B64FBE3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 19:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiLQS5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 13:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiLQSzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 13:55:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC7123A;
        Sat, 17 Dec 2022 10:55:37 -0800 (PST)
Date:   Sat, 17 Dec 2022 18:55:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1671303332;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=c5g6MSrqZsjP8rQ+Bx44M5yo8LZcSCCthyNX2GgIJYU=;
        b=YIQSN19LWJmoUttmAjjI3Pb/eyiffL6VPEsBMCmPtWT+bBcC7OVrWmScUrH9N8L3n1al2V
        9WO9PyAOtkX5+tq63dwh45YfCW40AUe5pkbMi4WEgul6Y7kUNn/XojnPX64iPWQrStX1uE
        xVnZyFqqCbsvWUp+aWSqcYW1WWRHtiPb3D1IEkX/NIbmaswm6FXhFg4CeHAJFfG7B6K7aX
        UpweqwHacnFSpi5ySY8hD00UMwalOOwfo5PvXgUCaeWgko5ABKKL/yCANSmELZEfjE9KPa
        GpvI+6Ii6IkBEqPokCIqSrYpEpCH5OnYjqcJUKgh33I+/KSlUXc/6a1xaO5DAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1671303332;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=c5g6MSrqZsjP8rQ+Bx44M5yo8LZcSCCthyNX2GgIJYU=;
        b=LFhIRGS43jiyYOup8PegzRc+4pycbWG13QfFLUT2uBVNZEr1FhXfDHtKR9sPURnYevLMGY
        dT1gikrMpdvUfHAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/pae: Use WRITE_ONCE()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167130333255.4906.14861666890204509269.tip-bot2@tip-bot2>
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

Commit-ID:     f7bcd4617de67a4700a7bd7dc56808b57f1c8748
Gitweb:        https://git.kernel.org/tip/f7bcd4617de67a4700a7bd7dc56808b57f1c8748
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 26 Nov 2020 17:40:12 +01:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 15 Dec 2022 10:37:27 -08:00

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
