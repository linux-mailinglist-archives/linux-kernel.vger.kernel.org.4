Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F70B62AE53
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 23:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238582AbiKOW1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 17:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbiKOW0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 17:26:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48781317D2;
        Tue, 15 Nov 2022 14:26:29 -0800 (PST)
Date:   Tue, 15 Nov 2022 22:26:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668551187;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pn5UtiqnRGWlXM480Esc6q28LEpVXsJC04ec2EQZjWU=;
        b=dtbHKtn0ZpWT4r3/2guQbR+S0Pi5H1Y7QsXcdviel3KIB8ztVDhG7Z7CG7tF/QmtPKjJBk
        SNZJbVrIlK9PLeo/7eWJw3jRRh653onuqOYNvmjuEdzNjh7WGa3X87RPDwlX4gwqyncGTd
        kbKhjErGHOLpmmydwS/7Ft2XWorr8ctVpjN4bZwmlI/NeU5zSplJc2DL2be9LTaxl5t5jS
        gZ3jLgDD/eaGd64XinGGcJbbPv80BPyZX/6x2x3Rv+Yv5KxIMV4IjJ5l0nhBvGsINS/FtJ
        PZqaFyRzxtbU29GxbGFODyh64VTFuc1+dvt3+Gel7/CEOrMeDrBHnlOdJkQMkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668551187;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pn5UtiqnRGWlXM480Esc6q28LEpVXsJC04ec2EQZjWU=;
        b=+tz4oZcJX9zq+tt9ZADPCtiyGR5gNQPdsORtpjPQ4naRXs3Con3PpsdHROYuTMPiMMDiut
        ceUowSkgJ7HurvDQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Inhibit _PAGE_NX changes from cpa_process_alias()
Cc:     kernel test robot <oliver.sang@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166855118670.4906.4131361261876319025.tip-bot2@tip-bot2>
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

Commit-ID:     127960a05548ea699a95791669e8112552eb2452
Gitweb:        https://git.kernel.org/tip/127960a05548ea699a95791669e8112552eb2452
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 10 Nov 2022 13:33:57 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Nov 2022 22:29:58 +01:00

x86/mm: Inhibit _PAGE_NX changes from cpa_process_alias()

There is a cludge in change_page_attr_set_clr() that inhibits
propagating NX changes to the aliases (directmap and highmap) -- this
is a cludge twofold:

 - it also inhibits the primary checks in __change_page_attr();
 - it hard depends on single bit changes.

The introduction of set_memory_rox() triggered this last issue for
clearing both _PAGE_RW and _PAGE_NX.

Explicitly ignore _PAGE_NX in cpa_process_alias() instead.

Fixes: b38994948567 ("x86/mm: Implement native set_memory_rox()")
Reported-by: kernel test robot <oliver.sang@intel.com>
Debugged-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20221110125544.594991716%40infradead.org
---
 arch/x86/mm/pat/set_memory.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 4943f6c..beef774 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1669,6 +1669,12 @@ static int cpa_process_alias(struct cpa_data *cpa)
 		alias_cpa.flags &= ~(CPA_PAGES_ARRAY | CPA_ARRAY);
 		alias_cpa.curpage = 0;
 
+		/* Directmap always has NX set, do not modify. */
+		if (__supported_pte_mask & _PAGE_NX) {
+			alias_cpa.mask_clr.pgprot &= ~_PAGE_NX;
+			alias_cpa.mask_set.pgprot &= ~_PAGE_NX;
+		}
+
 		cpa->force_flush_all = 1;
 
 		ret = __change_page_attr_set_clr(&alias_cpa, 0);
@@ -1691,6 +1697,15 @@ static int cpa_process_alias(struct cpa_data *cpa)
 		alias_cpa.flags &= ~(CPA_PAGES_ARRAY | CPA_ARRAY);
 		alias_cpa.curpage = 0;
 
+		/*
+		 * [_text, _brk_end) also covers data, do not modify NX except
+		 * in cases where the highmap is the primary target.
+		 */
+		if (__supported_pte_mask & _PAGE_NX) {
+			alias_cpa.mask_clr.pgprot &= ~_PAGE_NX;
+			alias_cpa.mask_set.pgprot &= ~_PAGE_NX;
+		}
+
 		cpa->force_flush_all = 1;
 		/*
 		 * The high mapping range is imprecise, so ignore the
@@ -1709,6 +1724,12 @@ static int __change_page_attr_set_clr(struct cpa_data *cpa, int checkalias)
 	unsigned long rempages = numpages;
 	int ret = 0;
 
+	/*
+	 * No changes, easy!
+	 */
+	if (!(pgprot_val(cpa->mask_set) | pgprot_val(cpa->mask_clr)))
+		return ret;
+
 	while (rempages) {
 		/*
 		 * Store the remaining nr of pages for the large page
@@ -1755,7 +1776,7 @@ static int change_page_attr_set_clr(unsigned long *addr, int numpages,
 				    struct page **pages)
 {
 	struct cpa_data cpa;
-	int ret, cache, checkalias;
+	int ret, cache;
 
 	memset(&cpa, 0, sizeof(cpa));
 
@@ -1805,10 +1826,7 @@ static int change_page_attr_set_clr(unsigned long *addr, int numpages,
 	cpa.curpage = 0;
 	cpa.force_split = force_split;
 
-	/* No alias checking for _NX bit modifications */
-	checkalias = (pgprot_val(mask_set) | pgprot_val(mask_clr)) != _PAGE_NX;
-
-	ret = __change_page_attr_set_clr(&cpa, checkalias);
+	ret = __change_page_attr_set_clr(&cpa, 1);
 
 	/*
 	 * Check whether we really changed something:
