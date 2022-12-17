Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCEC64FBE6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 19:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiLQS5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 13:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiLQSzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 13:55:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7994FBE7;
        Sat, 17 Dec 2022 10:55:37 -0800 (PST)
Date:   Sat, 17 Dec 2022 18:55:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1671303333;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=lKKXJOtH81Nxky+4PgDivO30jQ9slzM0RDWljCDF8b0=;
        b=fHrySRWb/Qy+LCtVqUXNzNi8iI4MK5TvsICB9NoiwX0Z6I5Zf5Umq149KcygQsyeGj3Nu5
        G4yiqPdpxCibLDbNpflayVPMwmRX1HuWXxmCwlFWjfzgeldVCiN/vsOun1XnuV0BSUZN7R
        KpWVW/c4s/wq8S4Ncug8jc21ZFaUBpQ8vXWBvL57qlgny6BXZsN/T1Xf7IVglbmfK6721z
        tqL8jlyegWkIFaQxp4mOqncKaIUMTItCUoAr5pQ72UUwT9DYaefYshhEBZ+bd9YPFOJQ1v
        qZworw0iu5g3Se0DyNPobXqjDn9n4kex9vif6UdlcZNR+2OidCUkMS8DDlKJ5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1671303333;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=lKKXJOtH81Nxky+4PgDivO30jQ9slzM0RDWljCDF8b0=;
        b=y9M3JHTZHNzx2WFkg+/bB3LzxJwSusq5tgnhr/tx9qVaucK2dRISUMy6ZqnACjyIy05C+e
        g8b8I8wzE3mfc0Ag==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] mm/gup: Fix the lockless PMD access
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167130333302.4906.13152896885964546282.tip-bot2@tip-bot2>
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

Commit-ID:     1180e732c985ed3c8866d2fd9e02b619848404a0
Gitweb:        https://git.kernel.org/tip/1180e732c985ed3c8866d2fd9e02b619848404a0
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 26 Nov 2020 17:21:30 +01:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 15 Dec 2022 10:37:27 -08:00

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
