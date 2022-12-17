Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380CD64FBB5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 19:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiLQSzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 13:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiLQSzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 13:55:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EFA10B6A;
        Sat, 17 Dec 2022 10:55:32 -0800 (PST)
Date:   Sat, 17 Dec 2022 18:55:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1671303330;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Hl8fIVQ+iann6jMELIl27UvronYuxaCq2Quycexs1I=;
        b=HdIzZH+vQpv0vtyRjK48wNgbAb8bxc18vngWIRsrlo0cjuy3qmTvBYHbXWSXPxSLZpn+W8
        VgiLWAnBTHnwPLleusxeO3bSOAS4LeEMkUF0eOuBi+D3sDjyi88FESCh8hcPh8Xc4BEHaO
        0p4WE7EMd/W9Q9tf0dFFyE4wBkWhF3PIefLbhCG9maugIF5X7jZkbuJV2jiWIAyPeB9nK8
        yMycOoMgmEPtSDB2rKC4rTjDuMjJTpvuoArsFuH1YXE0Al3x3hXcJIGlujL0M3hGe7E1Hg
        A5Xc9tpFoay55/qUmp4MmzGgQBt3Ui0Q1z2tzD3iPl14yOhK5Tn0sRAwKGwo3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1671303330;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Hl8fIVQ+iann6jMELIl27UvronYuxaCq2Quycexs1I=;
        b=McswiTeB0AJhm54S0bv6pA1AMXrH16Im2TvxRA3iWJbKE6AUpyA8QIHY6642o4MQOQKR27
        dV02/yoCTTrEo0DQ==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/kasan: Rename local CPU_ENTRY_AREA variables to
 shorten names
Cc:     Sean Christopherson <seanjc@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221110203504.1985010-4-seanjc@google.com>
References: <20221110203504.1985010-4-seanjc@google.com>
MIME-Version: 1.0
Message-ID: <167130332996.4906.17918341321563753453.tip-bot2@tip-bot2>
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

Commit-ID:     7077d2ccb94dafd00b29cc2d601c9f6891648f5b
Gitweb:        https://git.kernel.org/tip/7077d2ccb94dafd00b29cc2d601c9f6891648f5b
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Thu, 10 Nov 2022 20:35:02 
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 15 Dec 2022 10:37:28 -08:00

x86/kasan: Rename local CPU_ENTRY_AREA variables to shorten names

Rename the CPU entry area variables in kasan_init() to shorten their
names, a future fix will reference the beginning of the per-CPU portion
of the CPU entry area, and shadow_cpu_entry_per_cpu_begin is a bit much.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Link: https://lkml.kernel.org/r/20221110203504.1985010-4-seanjc@google.com
---
 arch/x86/mm/kasan_init_64.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index d141692..ad7872a 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -331,7 +331,7 @@ void __init kasan_populate_shadow_for_vaddr(void *va, size_t size, int nid)
 void __init kasan_init(void)
 {
 	int i;
-	void *shadow_cpu_entry_begin, *shadow_cpu_entry_end;
+	void *shadow_cea_begin, *shadow_cea_end;
 
 	memcpy(early_top_pgt, init_top_pgt, sizeof(early_top_pgt));
 
@@ -372,16 +372,16 @@ void __init kasan_init(void)
 		map_range(&pfn_mapped[i]);
 	}
 
-	shadow_cpu_entry_begin = (void *)CPU_ENTRY_AREA_BASE;
-	shadow_cpu_entry_begin = kasan_mem_to_shadow(shadow_cpu_entry_begin);
-	shadow_cpu_entry_begin = (void *)round_down(
-			(unsigned long)shadow_cpu_entry_begin, PAGE_SIZE);
+	shadow_cea_begin = (void *)CPU_ENTRY_AREA_BASE;
+	shadow_cea_begin = kasan_mem_to_shadow(shadow_cea_begin);
+	shadow_cea_begin = (void *)round_down(
+			(unsigned long)shadow_cea_begin, PAGE_SIZE);
 
-	shadow_cpu_entry_end = (void *)(CPU_ENTRY_AREA_BASE +
+	shadow_cea_end = (void *)(CPU_ENTRY_AREA_BASE +
 					CPU_ENTRY_AREA_MAP_SIZE);
-	shadow_cpu_entry_end = kasan_mem_to_shadow(shadow_cpu_entry_end);
-	shadow_cpu_entry_end = (void *)round_up(
-			(unsigned long)shadow_cpu_entry_end, PAGE_SIZE);
+	shadow_cea_end = kasan_mem_to_shadow(shadow_cea_end);
+	shadow_cea_end = (void *)round_up(
+			(unsigned long)shadow_cea_end, PAGE_SIZE);
 
 	kasan_populate_early_shadow(
 		kasan_mem_to_shadow((void *)PAGE_OFFSET + MAXMEM),
@@ -403,9 +403,9 @@ void __init kasan_init(void)
 
 	kasan_populate_early_shadow(
 		kasan_mem_to_shadow((void *)VMALLOC_END + 1),
-		shadow_cpu_entry_begin);
+		shadow_cea_begin);
 
-	kasan_populate_early_shadow(shadow_cpu_entry_end,
+	kasan_populate_early_shadow(shadow_cea_end,
 			kasan_mem_to_shadow((void *)__START_KERNEL_map));
 
 	kasan_populate_shadow((unsigned long)kasan_mem_to_shadow(_stext),
