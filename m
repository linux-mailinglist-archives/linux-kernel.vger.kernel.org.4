Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28808619FFE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 19:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbiKDSc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 14:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbiKDScy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:32:54 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E06A40918
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 11:32:54 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id n12-20020a170902e54c00b00188515e81a6so4126621plf.23
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 11:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=XS7y2dqHGNcxgJtQwV0riGq39Rt6nVME96ygRYhND24=;
        b=oN6YQDqk6ql/yuJpP2UHc5AJeq/0ASHaTsGwHNuH0ViA1j3iC6PG06JEXvHvu2Zbm/
         Mo8YEDWCn2wPXsZ8oYKUa9/1Nor0gac9QNs/GUXtA+mK7eRoaRSnVehZBrhJSDqPMWjb
         p73JoT41qN6YwQNuOHWvDEkGb4XNQTaPkaUVY/adqR1MoTAMN2OJ/3xR+yEAPhkF1iaK
         XmDC09ZwkPcj/dlWtOizwlMnqqe+rVYLgREo5yJpcmOuMdsODCZq2MttWV4wmy7xKFR8
         8HFFEUDjIKncdnXQ9XTvZAZHHi7Mmywz351zvd6tXPhK5EO5gNq1Wvr8SXN0wg2poWdg
         z7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XS7y2dqHGNcxgJtQwV0riGq39Rt6nVME96ygRYhND24=;
        b=SgNyp/n69zwutwAlElIzVirCLUyI10Px2WAeQSNzrh8VUDgSY8/+uDKZUHeLZvyO3q
         OD5bVnVfVkwOnVgexkIQA66iPl8iuR8mvAHbfn6LX5LOXb1Pt//AtByKXtMhWS67T7Gk
         N846uoHq56EnrZ1lFkGTRGFMPNY2F6mStBpAuhF0SgFR5awXJkX3BZNz7hJ14HL7u140
         OaL1yUxx5V/nt7y69NB9x9k8Z3CaMccfsdpIXDwmxnEjXDJ9QzVJa3EF6vlaMY4jJD/H
         gjdqrjMcc27x2Ha0Z6vpD8euCTuI6KUFbK8jC0aPiHJYcSVXPkE6xwpPDvbBHQZmsRcQ
         s9cw==
X-Gm-Message-State: ACrzQf1d7hisF9B2XrqV4BzrYw42kFp0t0QX7WDmWcsI+aooVj8cJ1rT
        7jwWJwM+3+HE/YKPwpKyoAGhEzjj55w=
X-Google-Smtp-Source: AMsMyM5jBLHsdg5VE1uhO3ecnvExGMWNVad3CWCtLAIUktoktpVNhX9REt3v9pHpmml/q4NjkJXkXlsso0o=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:aa7:9527:0:b0:563:b1bc:7f98 with SMTP id
 c7-20020aa79527000000b00563b1bc7f98mr367586pfp.29.1667586773676; Fri, 04 Nov
 2022 11:32:53 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  4 Nov 2022 18:32:45 +0000
In-Reply-To: <20221104183247.834988-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221104183247.834988-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221104183247.834988-2-seanjc@google.com>
Subject: [PATCH 1/3] x86/kasan: Rename local CPU_ENTRY_AREA variables to
 shorten names
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

Rename the CPU entry area variables in kasan_init() to shorten their
names, a future fix will reference the beginning of the per-CPU portion
of the CPU entry area, and shadow_cpu_entry_per_cpu_begin is a bit much.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/mm/kasan_init_64.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index d1416926ad52..ad7872ae10ed 100644
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
-- 
2.38.1.431.g37b22c650d-goog

