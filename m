Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCD064FBF7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 19:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiLQS6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 13:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiLQSzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 13:55:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8A926E1;
        Sat, 17 Dec 2022 10:55:40 -0800 (PST)
Date:   Sat, 17 Dec 2022 18:55:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1671303336;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EwScUKCAuqcxKvEg+fzCxcOtq2toSjlWXN7gMvbmeRc=;
        b=nkj8hiqHkhrOvNOVU3CyErJgGYbM/PSA0n9kTX42J4lKzUHTBAiCs3O2S44G7aOqKmMjGA
        iYKHz75OpWEakp9RzDMAsMPGSFFuN0JwpH/hwJbkFbE6xIJGzxgY8ckx/9NHoOJXKLFNlf
        jvE2r9lW6+v2ma/JFT2Ufin7D+7ldpp+ydf35h3LNJVhuhG9i2IdN1wBOF0RWvigskgeYB
        kgYGBZOVppxwU6UGwNrkNe8HBPpu40JmcfrAA4qHLXz/gniHvpSg5qSNwRWyLeYnWV55eg
        0jfxBX5wA+g6uvaSnaoPl4pn7vLq9o/2oILiG8qcvNCIKtnPJW/7PHcDs2yVzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1671303336;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EwScUKCAuqcxKvEg+fzCxcOtq2toSjlWXN7gMvbmeRc=;
        b=UUWDIC1lfy3bMqeNZNJSO+2Oa92N19UCDOPGrI8HutLqa+igEsjHHaIrowQbgHsvIbjFuO
        v46D0focDXsRJ5BQ==
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
Message-ID: <167130333617.4906.4876243828161129003.tip-bot2@tip-bot2>
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

Commit-ID:     3f148f3318140035e87decc1214795ff0755757b
Gitweb:        https://git.kernel.org/tip/3f148f3318140035e87decc1214795ff0755757b
Author:        Andrey Ryabinin <ryabinin.a.a@gmail.com>
AuthorDate:    Fri, 28 Oct 2022 00:31:04 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 15 Dec 2022 10:37:26 -08:00

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
 
