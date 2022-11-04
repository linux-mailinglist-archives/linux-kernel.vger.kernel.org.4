Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C3C619FFF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 19:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiKDSdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 14:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbiKDSc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:32:56 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F5340471
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 11:32:55 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id u8-20020a17090341c800b0018731b83fe4so4058934ple.16
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 11:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=NyjCQLTGMZRdycUacwFyAxLckz0Mzvzm9v3NS3Lsp2Q=;
        b=AVNcRZuDOXKkWmneCdtvaxaauUn8pnyvuKeXgPpoA7oiOGmi9OxLgYnyUOwCRRGH0K
         dBh2Xma4Y6oO9Qpgnxutb03h74QM6y3a9XAkRrYXJmzOUURYwqnNKG3gyrT0ihxFkXUT
         Ddm/MgdwGQ80jg6kUaprBEP+0H85k9a5uTO4ESZJ3QMv9WrjcvA16a07YzdvAb+gWjpJ
         FjkM0VzCNePqkvGtljKd1aofy2WISvZViliS38XVjz10op33UYWpYXDDiJYIjQONRK+A
         DhnyIgjNZ3a1RvaF9Surpd+1x+EGiFaw5O0RmRLkVEPx7j+yN6asICDRXmzRI61muClU
         Tu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NyjCQLTGMZRdycUacwFyAxLckz0Mzvzm9v3NS3Lsp2Q=;
        b=01wUey31vaE0ypxsB9xT7ot/53AAL8OyKsplBn62ijlTzak8HraPLfW1P6PM+Ao7dy
         JSFd8v1x8enUIqEjpdxh4CPbojVDj6O4WeUMCU2bwrQOXA+n2dxvLssWfDAsE9UGIrcG
         S7VI4NETHjO5nVc8TbGkQt+q9Vo24bEMqNdRCQ6WO6oVNJLWQRbx/AXwsjvNl3mC8SIv
         f5bLOTtwafUy7TDfsFRrS6zeqr8BO46bq9guIOUWlmKh+lBXHUIxNarG6kYqBt8yAteW
         q4z0f8dw8Edc8aaVuvxvWWVi4eW5lgQ/sZmFafZZSPpnkQrrTI5TldQTrVkuCvbPsSwI
         AWVg==
X-Gm-Message-State: ACrzQf2gi378uC5sxfczpLPmnkZAlMVDmN5RUohAvK2Hu88cO3krDPEc
        1PGsSXvzisl2awefkwuiu9DBlJIGypY=
X-Google-Smtp-Source: AMsMyM66P4Sl/iCruZJ88KS4Y3U+Wj7MQ/h68YnfMx6vYxCgarVhivUYc1AEY4Yy10853t0epdAixpflqZ8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a62:79d4:0:b0:561:f3bb:878 with SMTP id
 u203-20020a6279d4000000b00561f3bb0878mr366882pfc.83.1667586775330; Fri, 04
 Nov 2022 11:32:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  4 Nov 2022 18:32:46 +0000
In-Reply-To: <20221104183247.834988-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221104183247.834988-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221104183247.834988-3-seanjc@google.com>
Subject: [PATCH 2/3] x86/kasan: Add helpers to align shadow addresses up and down
From:   Sean Christopherson <seanjc@google.com>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
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

