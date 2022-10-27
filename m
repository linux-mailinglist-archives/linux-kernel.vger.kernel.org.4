Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB64561046D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236132AbiJ0VbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234849AbiJ0VbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 17:31:09 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E90A68CDC
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 14:31:07 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id k19so5395558lji.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 14:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBlvNL5JxdJ/PzqAb968FRZUq7jJe0xpV2M3dTQY+YY=;
        b=Ur/DqlEEOnSyhu2CPONFAlmd1wdC2/xX8SY6vNzjRQyiEDjV9ZsCzkXrfUY6PSsTtR
         qpjJBTcptVwMV2tqShoeHZyKLk9gFhXq3QT0/Mw7KE9qTyZyWH1D5ZOPZ0l7mnFh77IB
         Z7EAhOp7BpGijc7HQxj4v46t/SNXSscCBHAaw6Jz48gMaO+vwURUvXvcPqX60sRC8t19
         ac3MCqGN7hTQD9FqQRIsEXwaoAusyz6iQNPue9Gu5Zr+OiDfuy7blzMS6uoDzKqNMY8r
         FdRmijnW+6Q/cq0ZSnHg2b3MTjlZuh7VoreVGstKksaZCE+kSH6OneB9BEtZFoJAn86z
         eUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBlvNL5JxdJ/PzqAb968FRZUq7jJe0xpV2M3dTQY+YY=;
        b=5WEc4+pc/5jYxDx5nGzRcTog29bfOw8tY3+WnpRNHYc3uPYNrnbhekiqvPpek44WOO
         yGDQzk+haq6Sg5k95qVbgPn5wRTJyV5omZOBRjFUn+ODKIzjmgr+S6Z2jKgFyBVE0U5r
         0cmPJkvcQUFEFgx++mNxVUpqv+ON5xjq+0UZWNWnSmrW6xdmOVukYFgd9PjuvYUA+RHW
         59MwZDaS1+YN5rYylHuX/KzrgM1OeeyH7qKP8V9/ekLkXjETvmvhpWfil6bXWk4Wt8Hn
         Bl+mzMfvthsllDpECNTjz4Gkvtx7fAzW8J4kdDrZ/IQzrL+Vhga2UVj2igtKrlyg2Y+R
         p9MA==
X-Gm-Message-State: ACrzQf07+fSgh9fR0uswfgzqI8YZYksOGVJZSPt/Q322BUTz5WlFQiWA
        RHg8vFQng8oTKHhtv692Db4=
X-Google-Smtp-Source: AMsMyM5fLtSxA/4DyP8AtiUyWAn/eNDAc5a/RM8jJuauBwUxgoU9VPoIxoYuMuSMJ711pU8JT+Vv2Q==
X-Received: by 2002:a2e:7812:0:b0:277:2463:c1e2 with SMTP id t18-20020a2e7812000000b002772463c1e2mr3297139ljc.184.1666906265714;
        Thu, 27 Oct 2022 14:31:05 -0700 (PDT)
Received: from localhost.localdomain ([5.19.98.172])
        by smtp.gmail.com with ESMTPSA id r4-20020a2e9944000000b0026c5579c64csm368453ljj.89.2022.10.27.14.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 14:31:05 -0700 (PDT)
From:   Andrey Ryabinin <ryabinin.a.a@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        kernel test robot <yujie.liu@intel.com>
Cc:     Seth Jenkins <sethjenkins@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, "Yin, Fengwei" <fengwei.yin@intel.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
Subject: [PATCH] x86/kasan: map shadow for percpu pages on demand
Date:   Fri, 28 Oct 2022 00:31:04 +0300
Message-Id: <20221027213105.4905-1-ryabinin.a.a@gmail.com>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <864b4fbe-4462-9962-7afd-9140d5165cdb@intel.com>
References: <864b4fbe-4462-9962-7afd-9140d5165cdb@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN maps shadow for the entire CPU-entry-area:
  [CPU_ENTRY_AREA_BASE, CPU_ENTRY_AREA_BASE + CPU_ENTRY_AREA_MAP_SIZE]

This explodes after commit 1248fb6a8201 ("x86/mm: Randomize per-cpu entry area")
since it increases CPU_ENTRY_AREA_MAP_SIZE to 512 GB and KASAN fails
to allocate shadow for such big area.

Fix this by allocating KASAN shadow only for really used cpu entry area
addresses mapped by cea_map_percpu_pages()

Fixes: 1248fb6a8201 ("x86/mm: Randomize per-cpu entry area")
Reported-by: kernel test robot <yujie.liu@intel.com>
Link: https://lore.kernel.org/r/202210241508.2e203c3d-yujie.liu@intel.com
Tested-by: Yujie Liu <yujie.liu@intel.com>
Signed-off-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
---
 arch/x86/include/asm/kasan.h |  3 +++
 arch/x86/mm/cpu_entry_area.c |  8 +++++++-
 arch/x86/mm/kasan_init_64.c  | 15 ++++++++++++---
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/kasan.h b/arch/x86/include/asm/kasan.h
index 13e70da38bed..de75306b932e 100644
--- a/arch/x86/include/asm/kasan.h
+++ b/arch/x86/include/asm/kasan.h
@@ -28,9 +28,12 @@
 #ifdef CONFIG_KASAN
 void __init kasan_early_init(void);
 void __init kasan_init(void);
+void __init kasan_populate_shadow_for_vaddr(void *va, size_t size, int nid);
 #else
 static inline void kasan_early_init(void) { }
 static inline void kasan_init(void) { }
+static inline void kasan_populate_shadow_for_vaddr(void *va, size_t size,
+						   int nid) { }
 #endif
 
 #endif
diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index ad1f750517a1..ac2e952186c3 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -9,6 +9,7 @@
 #include <asm/cpu_entry_area.h>
 #include <asm/fixmap.h>
 #include <asm/desc.h>
+#include <asm/kasan.h>
 
 static DEFINE_PER_CPU_PAGE_ALIGNED(struct entry_stack_page, entry_stack_storage);
 
@@ -91,8 +92,13 @@ void cea_set_pte(void *cea_vaddr, phys_addr_t pa, pgprot_t flags)
 static void __init
 cea_map_percpu_pages(void *cea_vaddr, void *ptr, int pages, pgprot_t prot)
 {
+	phys_addr_t pa = per_cpu_ptr_to_phys(ptr);
+
+	kasan_populate_shadow_for_vaddr(cea_vaddr, pages * PAGE_SIZE,
+					early_pfn_to_nid(PFN_DOWN(pa)));
+
 	for ( ; pages; pages--, cea_vaddr+= PAGE_SIZE, ptr += PAGE_SIZE)
-		cea_set_pte(cea_vaddr, per_cpu_ptr_to_phys(ptr), prot);
+		cea_set_pte(cea_vaddr, pa, prot);
 }
 
 static void __init percpu_setup_debug_store(unsigned int cpu)
diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index e7b9b464a82f..d1416926ad52 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -316,6 +316,18 @@ void __init kasan_early_init(void)
 	kasan_map_early_shadow(init_top_pgt);
 }
 
+void __init kasan_populate_shadow_for_vaddr(void *va, size_t size, int nid)
+{
+	unsigned long shadow_start, shadow_end;
+
+	shadow_start = (unsigned long)kasan_mem_to_shadow(va);
+	shadow_start = round_down(shadow_start, PAGE_SIZE);
+	shadow_end = (unsigned long)kasan_mem_to_shadow(va + size);
+	shadow_end = round_up(shadow_end, PAGE_SIZE);
+
+	kasan_populate_shadow(shadow_start, shadow_end, nid);
+}
+
 void __init kasan_init(void)
 {
 	int i;
@@ -393,9 +405,6 @@ void __init kasan_init(void)
 		kasan_mem_to_shadow((void *)VMALLOC_END + 1),
 		shadow_cpu_entry_begin);
 
-	kasan_populate_shadow((unsigned long)shadow_cpu_entry_begin,
-			      (unsigned long)shadow_cpu_entry_end, 0);
-
 	kasan_populate_early_shadow(shadow_cpu_entry_end,
 			kasan_mem_to_shadow((void *)__START_KERNEL_map));
 
-- 
2.37.4

