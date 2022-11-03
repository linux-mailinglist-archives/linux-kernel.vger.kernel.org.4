Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93D9618A61
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 22:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiKCVPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 17:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiKCVPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 17:15:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243D712AB2;
        Thu,  3 Nov 2022 14:15:47 -0700 (PDT)
Date:   Thu, 03 Nov 2022 21:15:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667510145;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hnBqM0hHO13kceo1Zil340S6guxw3qweJaVBaRBfiMg=;
        b=wEVSlIC4w5GF4uElz8Y+rqA43DK8rvm/MNgCckJxRNvmPqEFEoBICcl5p9RhFdaXwDKAMH
        wQKneM6T1ky46Z89TP1UqxT55MeHKFjqnOg01XSZNNaNnHRn2RBA7yrr7bebx9KasgA51B
        5f2Aa3MnC8tYxlhIT6CAk37bcb1X+z/9EFj9Il84OmM2TnPcsOvtnbl4pC2/krRqTePYc0
        Serkib/YTRSqlUJ/A2jzWLkoj0TkJU4GbZyy6ZAVNi80qYOF0xKsLvpOAndSTLbhnK6X4c
        gdqEEgUhC+GcStoW+it+XRPRkOJbsEcAC/ga3yoMxxL81iG+TfLQvHiN37modw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667510145;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hnBqM0hHO13kceo1Zil340S6guxw3qweJaVBaRBfiMg=;
        b=Li2vS8Jwxmawtss+dI5OVpdL1xlxh2u8qaJsAtv7eU5V54+gruY6L8i2vvyavia6VhpnZX
        WE+lAK9XPIuMouDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] mm: Convert __HAVE_ARCH_P..P_GET to the new style
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <Y2EUEBlQXNgaJgoI@hirez.programming.kicks-ass.net>
References: <Y2EUEBlQXNgaJgoI@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <166751014320.6127.9197829586904529035.tip-bot2@tip-bot2>
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

Commit-ID:     3301badde43dee7c2a013fbd6479c258366519da
Gitweb:        https://git.kernel.org/tip/3301badde43dee7c2a013fbd6479c258366519da
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 01 Nov 2022 12:53:18 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 03 Nov 2022 22:04:29 +01:00

mm: Convert __HAVE_ARCH_P..P_GET to the new style

Since __HAVE_ARCH_* style guards have been depricated in favour of
defining the function name onto itself, convert pxxp_get().

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/Y2EUEBlQXNgaJgoI@hirez.programming.kicks-ass.net
---
 arch/powerpc/include/asm/nohash/32/pgtable.h | 2 +-
 include/linux/pgtable.h                      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 0d40b33..cb1ac02 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -263,7 +263,7 @@ static inline pte_basic_t pte_update(struct mm_struct *mm, unsigned long addr, p
 }
 
 #ifdef CONFIG_PPC_16K_PAGES
-#define __HAVE_ARCH_PTEP_GET
+#define ptep_get ptep_get
 static inline pte_t ptep_get(pte_t *ptep)
 {
 	pte_basic_t val = READ_ONCE(ptep->pte);
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 2334852..70e2a7e 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -291,14 +291,14 @@ static inline void ptep_clear(struct mm_struct *mm, unsigned long addr,
 	ptep_get_and_clear(mm, addr, ptep);
 }
 
-#ifndef __HAVE_ARCH_PTEP_GET
+#ifndef ptep_get
 static inline pte_t ptep_get(pte_t *ptep)
 {
 	return READ_ONCE(*ptep);
 }
 #endif
 
-#ifndef __HAVE_ARCH_PMDP_GET
+#ifndef pmdp_get
 static inline pmd_t pmdp_get(pmd_t *pmdp)
 {
 	return READ_ONCE(*pmdp);
