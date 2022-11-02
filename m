Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695F9615F38
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbiKBJOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiKBJMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:12:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B0E28E18;
        Wed,  2 Nov 2022 02:12:42 -0700 (PDT)
Date:   Wed, 02 Nov 2022 09:12:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667380360;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=RT8L0UGb4JToLrqr1SrWn3MXpnb+J9vu9IfgZDz2iTI=;
        b=RxmPFjaCarVAMF5rWqg6bbQCmE/Nn+SNQJhSXevJgzkcWeOXQQMz7aeNCP9rfMnsGZ1p8p
        t+/oc+rkPnv/n+qHkX/dHUKwxMr8NP6Hp9ipZSobeBv0E1/di/6G7ULXoFtfYN4Q9O8Rk9
        ta7hHU63Nfi8ChIIw3iPovucWU8EorZ68t0nnzvzZRXIVYSVkxltgWzBZ+XlyMFGC4vDLG
        K/ji5MiNh085zwXaEddA63WjL8Va6xPZxU1KFeu1jvseHpgI3KiNwzAbpmghcP41pWZ01i
        yfXCc2LvbygCMVpqy3S+PeZqa1kfjyol4U83phqZ+lnqSpAVep8iN9LZmpI8Vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667380360;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=RT8L0UGb4JToLrqr1SrWn3MXpnb+J9vu9IfgZDz2iTI=;
        b=WvdSmDGTsVes/NLOlw/lw11lVT0qch+xDbNrtwPs5cRDSkL2G2IOy/EVDaoEiRZ/GFELfx
        8nyt01rTXdhVNgAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] mm/gup: Fix the lockless PMD access
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166738035964.7716.5433885798359533434.tip-bot2@tip-bot2>
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

Commit-ID:     4fff2c7e6b8e91e00838b145d08353dd8a1893c1
Gitweb:        https://git.kernel.org/tip/4fff2c7e6b8e91e00838b145d08353dd8a1893c1
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 26 Nov 2020 17:21:30 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Nov 2022 13:44:02 +01:00

mm/gup: Fix the lockless PMD access

On architectures where the PTE/PMD is larger than the native word size
(i386-PAE for example), READ_ONCE() can do the wrong thing. Use
pmdp_get_lockless() just like we use ptep_get_lockless().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20221022114424.906110403%40infradead.org
---
 kernel/events/core.c | 2 +-
 mm/gup.c             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4ec3717..b0d3842 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7306,7 +7306,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
 		return pud_leaf_size(pud);
 
 	pmdp = pmd_offset_lockless(pudp, pud, addr);
-	pmd = READ_ONCE(*pmdp);
+	pmd = pmdp_get_lockless(pmdp);
 	if (!pmd_present(pmd))
 		return 0;
 
diff --git a/mm/gup.c b/mm/gup.c
index fe195d4..ff8b223 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2808,7 +2808,7 @@ static int gup_pmd_range(pud_t *pudp, pud_t pud, unsigned long addr, unsigned lo
 
 	pmdp = pmd_offset_lockless(pudp, pud, addr);
 	do {
-		pmd_t pmd = READ_ONCE(*pmdp);
+		pmd_t pmd = pmdp_get_lockless(pmdp);
 
 		next = pmd_addr_end(addr, end);
 		if (!pmd_present(pmd))
