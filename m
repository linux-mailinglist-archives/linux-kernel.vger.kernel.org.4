Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9769662AE55
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 23:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238613AbiKOW1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 17:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbiKOW0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 17:26:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3321B317CB;
        Tue, 15 Nov 2022 14:26:28 -0800 (PST)
Date:   Tue, 15 Nov 2022 22:26:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668551186;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=c33MI+BxwG+cQfCEElhwxlr9SkSYKKNVNQBEdF7CgOU=;
        b=xsvBfcBCyWrbo2HAvTevyzIUUHPapyZ1/QhsFlkYDXLphhySIc46vOoXgdLEmVNAvFcyxC
        it7Vh29jeQ/FMwUJltxLx/FMH00Zw7zTjnW6FYVtaFLwplx35XAVhZ8tj2hMfOP0n6MvgS
        pZgexq9L/rsAof2YvRPO5Zj42BkkiVpdLEr8QpSY4bvD9am6pNfcO8G6z5yqVIkAZy+1jT
        xWfUfhsK8P1DGq1hNJ1Tq+G8Zihiug7gVqX61Rru55G+eOQcr2Kwpg8gmMMZPLHJicx+ko
        LHojiXhPbV/uQdMAdsiUw2cjNZ2NYQwMbUdi6F7t/QL84lgsI29VlGSqAUURyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668551186;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=c33MI+BxwG+cQfCEElhwxlr9SkSYKKNVNQBEdF7CgOU=;
        b=9KNmK44qJ4UY98cKp+PDl1WRdDB++PayVhLd9zs7g0rHruUmQh6XQ3AyuS4SlV+Nq9LyoC
        HEKbJdvWwan8lhCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Rename __change_page_attr_set_clr(.checkalias)
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166855118563.4906.986870700026077869.tip-bot2@tip-bot2>
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

Commit-ID:     abfb852313e49a75dca0f3d1bc2ad73960592c0a
Gitweb:        https://git.kernel.org/tip/abfb852313e49a75dca0f3d1bc2ad73960592c0a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 10 Nov 2022 13:34:00 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Nov 2022 22:29:58 +01:00

x86/mm: Rename __change_page_attr_set_clr(.checkalias)

Now that the checkalias functionality is taken by CPA_NO_CHECK_ALIAS
rename the argument to better match is remaining purpose: primary,
matching __change_page_attr().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20221110125544.661001508%40infradead.org
---
 arch/x86/mm/pat/set_memory.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index beef774..220361c 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1641,7 +1641,7 @@ repeat:
 	return err;
 }
 
-static int __change_page_attr_set_clr(struct cpa_data *cpa, int checkalias);
+static int __change_page_attr_set_clr(struct cpa_data *cpa, int primary);
 
 /*
  * Check the directmap and "high kernel map" 'aliases'.
@@ -1718,7 +1718,7 @@ static int cpa_process_alias(struct cpa_data *cpa)
 	return 0;
 }
 
-static int __change_page_attr_set_clr(struct cpa_data *cpa, int checkalias)
+static int __change_page_attr_set_clr(struct cpa_data *cpa, int primary)
 {
 	unsigned long numpages = cpa->numpages;
 	unsigned long rempages = numpages;
@@ -1742,13 +1742,13 @@ static int __change_page_attr_set_clr(struct cpa_data *cpa, int checkalias)
 
 		if (!debug_pagealloc_enabled())
 			spin_lock(&cpa_lock);
-		ret = __change_page_attr(cpa, checkalias);
+		ret = __change_page_attr(cpa, primary);
 		if (!debug_pagealloc_enabled())
 			spin_unlock(&cpa_lock);
 		if (ret)
 			goto out;
 
-		if (checkalias && !(cpa->flags & CPA_NO_CHECK_ALIAS)) {
+		if (primary && !(cpa->flags & CPA_NO_CHECK_ALIAS)) {
 			ret = cpa_process_alias(cpa);
 			if (ret)
 				goto out;
