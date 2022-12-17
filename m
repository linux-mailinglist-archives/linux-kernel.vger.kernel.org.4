Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3F164FBD0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 19:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiLQS4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 13:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiLQSzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 13:55:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7C910B7B;
        Sat, 17 Dec 2022 10:55:35 -0800 (PST)
Date:   Sat, 17 Dec 2022 18:55:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1671303331;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=nt5Z13x7cPRUra6u/EdfRu87/NpycaDyh7wrSUQR9ck=;
        b=G1G58/Gb5ndyH6ooxLbFLJ29hJyHGVkqlNF5UoKuCGT5brcQZi+ZV1m4jlDHfk8u4KQ5Mi
        jYVnmlTH5U5VcZnPu7JbSUnmeGHMmOA43sPoGpMwzWdrVgkK8fhVbfCl+O29jqBXd1KtnX
        sNDaDTg5V7bSB/aafQydz804ftw0v75hkZUSA/uL9nP8jJTkXOSvMOOnEt9X4L7ZJiw+ys
        LhRkR4KHoCgmRSga9NEpxEYhv5lbpcjVYg/DQfm/Zuxs6i6aGQEzlxf5UMQVxISlXHoLRK
        GMpURkDBBC+QQ77h8/jNJWcll9PwO7xGAjR6vQ1EDBFizDHbeC1WjqQpbJ103w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1671303331;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=nt5Z13x7cPRUra6u/EdfRu87/NpycaDyh7wrSUQR9ck=;
        b=cRUVvfO1HZ2uAoa2pDPSwPdMWrt4SEMgBjfs4F6hFNTu1OSrf8LGf+bw9h9NiX5W8IsN9I
        yARtmsIK93SidfAA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Inhibit _PAGE_NX changes from cpa_process_alias()
Cc:     kernel test robot <oliver.sang@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167130333070.4906.17678564285729472836.tip-bot2@tip-bot2>
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

Commit-ID:     d597416683d587e940faa35945fba162329b5a71
Gitweb:        https://git.kernel.org/tip/d597416683d587e940faa35945fba162329b5a71
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 10 Nov 2022 13:33:57 +01:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 15 Dec 2022 10:37:28 -08:00

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
