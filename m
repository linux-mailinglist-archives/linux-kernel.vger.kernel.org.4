Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A203A5EFB3E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235922AbiI2Qrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235638AbiI2Qrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:47:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C5E1C6A43;
        Thu, 29 Sep 2022 09:47:34 -0700 (PDT)
Date:   Thu, 29 Sep 2022 16:47:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664470052;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=VeXdpqz/lh/+Kphnno09Gfa6VE0YUSzpiNwMegRtrO8=;
        b=mqKcZk9qf1uGFr0Oq7qMh0YE7zK2lqJE04qop0WSq+mSI8khYo5tCN70AFzkFG12QsfD5Y
        1E6mAduqVNpnPVWNgzetveRaoK3nXJP+VPVkF3Aj+OXVYKDQDumQcEHd7teC2uJ8cLn42Q
        15FcgqPjvvsbx8YMPkLZRfwuuu4YbxrcYYHsvAToHrC73jTxiKoAJ/DYFx4Ilyn79tdOyX
        +KA+IQioDPNxNKjKw330NJNaZJWY0YDvqjIgSL5d9REWYEvpOI6Og6JjLcK3iOTF3tVqLo
        t2utZKh80x9JWluKHOa0We6sRe72UEu8VX/ptcdY64bbyEIj+wsDFNDgI9KfrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664470052;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=VeXdpqz/lh/+Kphnno09Gfa6VE0YUSzpiNwMegRtrO8=;
        b=86g0y6FbLXjMRgt46IYxSrwrFLQW3hLGeQlUljEnIPgz36w+SNnGXKO7+mDpRUAJ3B/jj0
        /QHP95LUy3RfdmBw==
From:   "tip-bot2 for Linus Torvalds" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Add prot_sethuge() helper to abstract out
 _PAGE_PSE handling
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166447005137.401.6681051003676535352.tip-bot2@tip-bot2>
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

Commit-ID:     334b2cea811944df99ae2172bcc0effcdfdbe862
Gitweb:        https://git.kernel.org/tip/334b2cea811944df99ae2172bcc0effcdfdbe862
Author:        Linus Torvalds <torvalds@linux-foundation.org>
AuthorDate:    Wed, 28 Sep 2022 09:30:31 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 29 Sep 2022 18:01:40 +02:00

x86/mm: Add prot_sethuge() helper to abstract out _PAGE_PSE handling

We still have some historic cases of direct fiddling of page
attributes with (dangerous & fragile) type casting and address shifting.

Add the prot_sethuge() helper instead that gets the types right and
doesn't have to transform addresses.

( Also add a debug check to make sure this doesn't get applied
  to _PAGE_BIT_PAT/_PAGE_BIT_PAT_LARGE pages. )

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
---
 arch/x86/mm/init_64.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 0fe690e..7ea7d47 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -90,6 +90,12 @@ DEFINE_ENTRY(pud, pud, init)
 DEFINE_ENTRY(pmd, pmd, init)
 DEFINE_ENTRY(pte, pte, init)
 
+static inline pgprot_t prot_sethuge(pgprot_t prot)
+{
+	WARN_ON_ONCE(pgprot_val(prot) & _PAGE_PAT);
+
+	return __pgprot(pgprot_val(prot) | _PAGE_PSE);
+}
 
 /*
  * NOTE: pagetable_init alloc all the fixmap pagetables contiguous on the
@@ -557,9 +563,8 @@ phys_pmd_init(pmd_t *pmd_page, unsigned long paddr, unsigned long paddr_end,
 		if (page_size_mask & (1<<PG_LEVEL_2M)) {
 			pages++;
 			spin_lock(&init_mm.page_table_lock);
-			set_pte_init((pte_t *)pmd,
-				     pfn_pte((paddr & PMD_MASK) >> PAGE_SHIFT,
-					     __pgprot(pgprot_val(prot) | _PAGE_PSE)),
+			set_pmd_init(pmd,
+				     pfn_pmd(paddr >> PAGE_SHIFT, prot_sethuge(prot)),
 				     init);
 			spin_unlock(&init_mm.page_table_lock);
 			paddr_last = paddr_next;
@@ -644,12 +649,8 @@ phys_pud_init(pud_t *pud_page, unsigned long paddr, unsigned long paddr_end,
 		if (page_size_mask & (1<<PG_LEVEL_1G)) {
 			pages++;
 			spin_lock(&init_mm.page_table_lock);
-
-			prot = __pgprot(pgprot_val(prot) | _PAGE_PSE);
-
-			set_pte_init((pte_t *)pud,
-				     pfn_pte((paddr & PUD_MASK) >> PAGE_SHIFT,
-					     prot),
+			set_pud_init(pud,
+				     pfn_pud(paddr >> PAGE_SHIFT, prot_sethuge(prot)),
 				     init);
 			spin_unlock(&init_mm.page_table_lock);
 			paddr_last = paddr_next;
