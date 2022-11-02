Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB4A615F34
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiKBJNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbiKBJMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:12:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380BD28709;
        Wed,  2 Nov 2022 02:12:41 -0700 (PDT)
Date:   Wed, 02 Nov 2022 09:12:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667380359;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fU47EUKC4U4OsnqSfoay35OX31MeTDwt/5o2wlBWrec=;
        b=gYeWZCLx9diIdJ5L6x2bpTn/s8z/TCCETe3bC0J/eV0Ky0XIAsQVuLWpthQug9pK/H3vMr
        lJZ9LqA4EwM+UtctnRuMIIRi8D5AK/2Pm8KNLDzbFnvo38R/uP/R8J1Jnvdwacg1X40enX
        24oVjg9HF5K3fzRLP17yUckeO/TaiR5q1UoLtwFJ1iMoBVse6HpqnpM1ku7SDXiC+dwFLT
        wEv7mTmPdQv84BqWsEYhs38cVMcGXQYUFOfvhny09POULCMuyqK3FTbKzcID4XAwWPlrYB
        hEnjVzfYeewerO307fhFHI1cZYsvgJQjlwOkZlPODzVVmgqKVcyCCBgPuFcM9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667380359;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fU47EUKC4U4OsnqSfoay35OX31MeTDwt/5o2wlBWrec=;
        b=wCxNmaIccdNJN6nNtfT1PV9LkZHuYmtHNhpGZPOfdiPlvVmSsjWEZJqQncWpY6+K5jkyty
        rTkJQvFTSXAv2wBA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/pae: Don't (ab)use atomic64
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166738035851.7716.7987336244095815440.tip-bot2@tip-bot2>
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

Commit-ID:     a677802d5b0258f93f54620e1cd181b56547c36c
Gitweb:        https://git.kernel.org/tip/a677802d5b0258f93f54620e1cd181b56547c36c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 26 Nov 2020 17:38:42 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Nov 2022 13:44:03 +01:00

x86/mm/pae: Don't (ab)use atomic64

PAE implies CX8, write readable code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20221022114424.971450128%40infradead.org
---
 arch/x86/include/asm/pgtable-3level.h |  9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/pgtable-3level.h b/arch/x86/include/asm/pgtable-3level.h
index 94f50b0..0a1b81d 100644
--- a/arch/x86/include/asm/pgtable-3level.h
+++ b/arch/x86/include/asm/pgtable-3level.h
@@ -2,8 +2,6 @@
 #ifndef _ASM_X86_PGTABLE_3LEVEL_H
 #define _ASM_X86_PGTABLE_3LEVEL_H
 
-#include <asm/atomic64_32.h>
-
 /*
  * Intel Physical Address Extension (PAE) Mode - three-level page
  * tables on PPro+ CPUs.
@@ -95,11 +93,12 @@ static inline void pud_clear(pud_t *pudp)
 #ifdef CONFIG_SMP
 static inline pte_t native_ptep_get_and_clear(pte_t *ptep)
 {
-	pte_t res;
+	pte_t old = *ptep;
 
-	res.pte = (pteval_t)arch_atomic64_xchg((atomic64_t *)ptep, 0);
+	do {
+	} while (!try_cmpxchg64(&ptep->pte, &old.pte, 0ULL));
 
-	return res;
+	return old;
 }
 #else
 #define native_ptep_get_and_clear(xp) native_local_ptep_get_and_clear(xp)
