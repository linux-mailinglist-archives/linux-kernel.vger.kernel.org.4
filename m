Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60F7610AAA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 08:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiJ1Gqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 02:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiJ1GqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 02:46:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F73C1BE92B;
        Thu, 27 Oct 2022 23:43:09 -0700 (PDT)
Date:   Fri, 28 Oct 2022 06:43:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666939386;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qDx3NeXME9vlHi6hoEFj3TeAwMqdGUgWCn6jvXx4n0c=;
        b=VRhmt2gMBNP9oKNHa5IM1FKwSG9kgZbZMOngA5oe1X+4/lFP4YpVKyY7eiet76ATATo0R9
        PjQEP2zTW6M2FEezdvoNgEv+pf4+nbP5MnOHQ3+oEbinl5wMNyrT0JN8MF8fuonbWBxtZF
        tvYBUHzQju29GfD1HWIyI1RAz4PTdqB4l0J6QnNl5pT1TCrw47pzJxNaMT2AlB77YsvU5C
        5cZwOhZJRoCywqA37naZyl9F/aFtG0p8z4WLmc9UPxWpcKxx4LeonjfGNuLya13dzp3sG3
        x75C0xbH8IpKMzPmtCdM5eeLxyGjJ1IC6HAf4Tlo2/TFGNKVjNV4VSXiyfQnSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666939386;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qDx3NeXME9vlHi6hoEFj3TeAwMqdGUgWCn6jvXx4n0c=;
        b=Oy8bIoSIoQp5ACjoOmJnvXswIaADXRMUqYiZBA4N0Z10z9AYIVFPlqiOzTVEiZ5drrQm21
        nqqKrSC6RwvO/dDg==
From:   "tip-bot2 for Andrey Ryabinin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/kasan: Map shadow for percpu pages on demand
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yujie Liu <yujie.liu@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <202210241508.2e203c3d-yujie.liu@intel.com>
References: <202210241508.2e203c3d-yujie.liu@intel.com>
MIME-Version: 1.0
Message-ID: <166693938482.29415.7034851115705424459.tip-bot2@tip-bot2>
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

Commit-ID:     9fd429c28073fa40f5465cd6e4769a0af80bf398
Gitweb:        https://git.kernel.org/tip/9fd429c28073fa40f5465cd6e4769a0af80bf398
Author:        Andrey Ryabinin <ryabinin.a.a@gmail.com>
AuthorDate:    Fri, 28 Oct 2022 00:31:04 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 27 Oct 2022 15:00:24 -07:00

x86/kasan: Map shadow for percpu pages on demand

KASAN maps shadow for the entire CPU-entry-area:
  [CPU_ENTRY_AREA_BASE, CPU_ENTRY_AREA_BASE + CPU_ENTRY_AREA_MAP_SIZE]

This will explode once the per-cpu entry areas are randomized since it
will increase CPU_ENTRY_AREA_MAP_SIZE to 512 GB and KASAN fails to
allocate shadow for such big area.

Fix this by allocating KASAN shadow only for really used cpu entry area
addresses mapped by cea_map_percpu_pages()

Thanks to the 0day folks for finding and reporting this to be an issue.

[ dhansen: tweak changelog since this will get committed before peterz's
	   actual cpu-entry-area randomization ]

Signed-off-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Yujie Liu <yujie.liu@intel.com>
Cc: kernel test robot <yujie.liu@intel.com>
Link: https://lore.kernel.org/r/202210241508.2e203c3d-yujie.liu@intel.com
---
 arch/x86/include/asm/kasan.h |  3 +++
 arch/x86/mm/cpu_entry_area.c |  8 +++++++-
 arch/x86/mm/kasan_init_64.c  | 15 ++++++++++++---
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/kasan.h b/arch/x86/include/asm/kasan.h
index 13e70da..de75306 100644
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
index 6c2f1b7..d7081b1 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -9,6 +9,7 @@
 #include <asm/cpu_entry_area.h>
 #include <asm/fixmap.h>
 #include <asm/desc.h>
+#include <asm/kasan.h>
 
 static DEFINE_PER_CPU_PAGE_ALIGNED(struct entry_stack_page, entry_stack_storage);
 
@@ -53,8 +54,13 @@ void cea_set_pte(void *cea_vaddr, phys_addr_t pa, pgprot_t flags)
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
index e7b9b46..d141692 100644
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
 
