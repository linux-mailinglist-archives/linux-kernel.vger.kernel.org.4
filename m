Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018C162AE4D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 23:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbiKOW05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 17:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbiKOW0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 17:26:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A8F31215;
        Tue, 15 Nov 2022 14:26:24 -0800 (PST)
Date:   Tue, 15 Nov 2022 22:26:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668551182;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hP2IakV95smq3JPeATW9iAUtNeeOUIlhOeZqgdEDGTA=;
        b=qUBlioG2P0onn6518ODPwedW2WWKAxAzwGEr9mD1eM4NO43ExrN6QgWITZrTR+bJMjny+6
        sLSSzImy5iZWT6g/BvDqZrfAo3h4Lqpj+Nmr4SmRAuZ3xVSXkg6khv48wrrPEfock7Elt4
        GBs/2d/LzQKpLaji9k/C/YeeoyJq/e9IawS5InH5xUrrlj3BrfG4pSlV9hsMiDAEZjBMC4
        BZ/dgaMK2N8Dr+wEztQEGjeVuK/cDLmw84NgdcaevizC513oQNwuLqqZArlCVPcdC3BhMC
        IXGxeWTUjfqozvUi4e6Vk9rW6n7h9JbO7iXt3xCzGqHbSvnseyUex6r95oL20A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668551182;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hP2IakV95smq3JPeATW9iAUtNeeOUIlhOeZqgdEDGTA=;
        b=5FJj9J9tV77SjTqEfSj6SACKgbS45t0TsIPffEQ6oMgwSpDaIaHuFWiMCB9oe/Zahed4kL
        PatKeoDRyo8qPDBg==
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/kasan: Add helpers to align shadow addresses up and down
Cc:     Sean Christopherson <seanjc@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221110203504.1985010-5-seanjc@google.com>
References: <20221110203504.1985010-5-seanjc@google.com>
MIME-Version: 1.0
Message-ID: <166855118092.4906.5811594861632748902.tip-bot2@tip-bot2>
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

Commit-ID:     74b5a69c2a577d4fdba581171e3ebf33cddbddc1
Gitweb:        https://git.kernel.org/tip/74b5a69c2a577d4fdba581171e3ebf33cddbddc1
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Thu, 10 Nov 2022 20:35:03 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Nov 2022 22:29:59 +01:00

x86/kasan: Add helpers to align shadow addresses up and down

Add helpers to dedup code for aligning shadow address up/down to page
boundaries when translating an address to its shadow.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Link: https://lkml.kernel.org/r/20221110203504.1985010-5-seanjc@google.com
---
 arch/x86/mm/kasan_init_64.c | 40 +++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index ad7872a..afc5e12 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -316,22 +316,33 @@ void __init kasan_early_init(void)
 	kasan_map_early_shadow(init_top_pgt);
 }
 
+static unsigned long kasan_mem_to_shadow_align_down(unsigned long va)
+{
+	unsigned long shadow = (unsigned long)kasan_mem_to_shadow((void *)va);
+
+	return round_down(shadow, PAGE_SIZE);
+}
+
+static unsigned long kasan_mem_to_shadow_align_up(unsigned long va)
+{
+	unsigned long shadow = (unsigned long)kasan_mem_to_shadow((void *)va);
+
+	return round_up(shadow, PAGE_SIZE);
+}
+
 void __init kasan_populate_shadow_for_vaddr(void *va, size_t size, int nid)
 {
 	unsigned long shadow_start, shadow_end;
 
-	shadow_start = (unsigned long)kasan_mem_to_shadow(va);
-	shadow_start = round_down(shadow_start, PAGE_SIZE);
-	shadow_end = (unsigned long)kasan_mem_to_shadow(va + size);
-	shadow_end = round_up(shadow_end, PAGE_SIZE);
-
+	shadow_start = kasan_mem_to_shadow_align_down((unsigned long)va);
+	shadow_end = kasan_mem_to_shadow_align_up((unsigned long)va + size);
 	kasan_populate_shadow(shadow_start, shadow_end, nid);
 }
 
 void __init kasan_init(void)
 {
+	unsigned long shadow_cea_begin, shadow_cea_end;
 	int i;
-	void *shadow_cea_begin, *shadow_cea_end;
 
 	memcpy(early_top_pgt, init_top_pgt, sizeof(early_top_pgt));
 
@@ -372,16 +383,9 @@ void __init kasan_init(void)
 		map_range(&pfn_mapped[i]);
 	}
 
-	shadow_cea_begin = (void *)CPU_ENTRY_AREA_BASE;
-	shadow_cea_begin = kasan_mem_to_shadow(shadow_cea_begin);
-	shadow_cea_begin = (void *)round_down(
-			(unsigned long)shadow_cea_begin, PAGE_SIZE);
-
-	shadow_cea_end = (void *)(CPU_ENTRY_AREA_BASE +
-					CPU_ENTRY_AREA_MAP_SIZE);
-	shadow_cea_end = kasan_mem_to_shadow(shadow_cea_end);
-	shadow_cea_end = (void *)round_up(
-			(unsigned long)shadow_cea_end, PAGE_SIZE);
+	shadow_cea_begin = kasan_mem_to_shadow_align_down(CPU_ENTRY_AREA_BASE);
+	shadow_cea_end = kasan_mem_to_shadow_align_up(CPU_ENTRY_AREA_BASE +
+						      CPU_ENTRY_AREA_MAP_SIZE);
 
 	kasan_populate_early_shadow(
 		kasan_mem_to_shadow((void *)PAGE_OFFSET + MAXMEM),
@@ -403,9 +407,9 @@ void __init kasan_init(void)
 
 	kasan_populate_early_shadow(
 		kasan_mem_to_shadow((void *)VMALLOC_END + 1),
-		shadow_cea_begin);
+		(void *)shadow_cea_begin);
 
-	kasan_populate_early_shadow(shadow_cea_end,
+	kasan_populate_early_shadow((void *)shadow_cea_end,
 			kasan_mem_to_shadow((void *)__START_KERNEL_map));
 
 	kasan_populate_shadow((unsigned long)kasan_mem_to_shadow(_stext),
