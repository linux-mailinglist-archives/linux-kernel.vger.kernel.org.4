Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A398624BF7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 21:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiKJUf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 15:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbiKJUfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 15:35:14 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9926397
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:35:13 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id b2-20020a170902d50200b001871a3c51afso2060910plg.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=NyjCQLTGMZRdycUacwFyAxLckz0Mzvzm9v3NS3Lsp2Q=;
        b=ica0cDCUID9I3SR6IOAWlSBXbXnnWiD8g//aKt7PzSybddsy+Uza8seX3JWpahv96N
         ii+SEb49m9HRiW0UzQwvzGN0CGk36fKeab0Fjd03cE1ylLgV713LcAbVoqO+sdoDUju7
         IY44yRTBvl+jC+38xrbv5eGrlp2tqaKQxIsGsxD40M8Lr5zcIhNc5RI8j32X1tx3glTf
         NEZE09UOJjAVgMoQyII9XQXRLjc7N93J4Rw8/kv5Zv0lCt8K3Bipge9Fze2z4oOerTMd
         Dtm3F+4nv4LczFbQ44PV+4bMlwbrXTorjZIqsXOxRKe7U1SXL9bd5vCLy20dvKrmcJfO
         n2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NyjCQLTGMZRdycUacwFyAxLckz0Mzvzm9v3NS3Lsp2Q=;
        b=w4LZr9KCM/oJ/Es5klQwaTKe+kbt+I2OolJyYrGuLdql9G6kGbgFlVxI/Vznx/GlE7
         ucJZzMtCD7IxOL8HRC0IE/D1D2BUDgnFi9JYMjP4w+s3va4IVHm3Z9rcBA919DxKa/fn
         Iqa9dbWzpB38Mul/ttCdtl2J+huDRp8PGct0lDMXJFEaYV1CLkmhcAWXXo1Rrfr0a+dQ
         13NHTSvynhlBDdQbZjtTXThRriGCgCc4rcGCNsSgxkJXEvDjii9Kcaf4IzIFNMfqWmLJ
         Vn/dLh2BrqDQbBbHu2pGR5Q4vqAK9Ly8ma/V/m6KSh2QwsrzDCj+S+mVfrc3tIxYGQn+
         SXGA==
X-Gm-Message-State: ACrzQf28T6wQvbR663VgNREM49FIuT1DQwGSwu+UNdcCzTtsZ0bDq9Mc
        M1z/lI842FzXaOgEVRg5drkXDRWP8bQ=
X-Google-Smtp-Source: AMsMyM7+Pwcb+qFYXeiEN21fKrgYZH3JZFo42rg62GLiL1a+HCgBIuUnU8Ey79P+VT/9Tb/aLfVM6yP5MCc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:2bcb:b0:200:462f:6419 with SMTP id
 n11-20020a17090a2bcb00b00200462f6419mr1968927pje.135.1668112513500; Thu, 10
 Nov 2022 12:35:13 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 10 Nov 2022 20:35:03 +0000
In-Reply-To: <20221110203504.1985010-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221110203504.1985010-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221110203504.1985010-5-seanjc@google.com>
Subject: [PATCH v2 4/5] x86/kasan: Add helpers to align shadow addresses up
 and down
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Sean Christopherson <seanjc@google.com>,
        syzbot+ffb4f000dc2872c93f62@syzkaller.appspotmail.com,
        syzbot+8cdd16fd5a6c0565e227@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add helpers to dedup code for aligning shadow address up/down to page
boundaries when translating an address to its shadow.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/mm/kasan_init_64.c | 40 ++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index ad7872ae10ed..afc5e129ca7b 100644
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
-- 
2.38.1.431.g37b22c650d-goog

