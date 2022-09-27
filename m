Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AF65EC691
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbiI0OhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbiI0Og0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:36:26 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978291B95D2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:34:04 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4McMYn3XqRz9spD;
        Tue, 27 Sep 2022 16:33:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id k3i4UjjGt2Lg; Tue, 27 Sep 2022 16:33:33 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4McMYh2T46z9sp0;
        Tue, 27 Sep 2022 16:33:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 424BE8B779;
        Tue, 27 Sep 2022 16:33:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Dz6HhJ3gwE0p; Tue, 27 Sep 2022 16:33:28 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.35])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D66B08B77A;
        Tue, 27 Sep 2022 16:33:27 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 28REXLSe351162
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 16:33:21 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 28REXLSo351161;
        Tue, 27 Sep 2022 16:33:21 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Gray <bgray@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 2/4] powerpc/code-patching: Speed up page mapping/unmapping
Date:   Tue, 27 Sep 2022 16:33:05 +0200
Message-Id: <3a1e34312b5c169cde846174c275241db85f7406.1647962456.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1647962456.git.christophe.leroy@csgroup.eu>
References: <cover.1647962456.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1664289185; l=2635; s=20211009; h=from:subject:message-id; bh=35yiHUmQqTxn+N9RYcp08cbKx03tJYDkvUBA219cU6Q=; b=lL3JmyX9ZsrLD+y1Wie/N+76g/R+fQ8xSraCXJtgMb/f+hm4shGkKigT5uKuCHLECSobvNOL22Rb hIjZ1KywC+u0zxFNC+L/Ov9yTKmkQwjPZN737+UIPAjaUBsN0I8i
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 591b4b268435 ("powerpc/code-patching: Pre-map patch area")
the patch area is premapped so intermediate page tables are already
allocated.

Use __set_pte_at() directly instead of the heavy map_kernel_page(),
at for unmapping just do a pte_clear() followed by a flush.

__set_pte_at() can be used directly without the filters in
set_pte_at() because we are mapping a normal page non executable.

Make sure gcc knows text_poke_area is page aligned in order to
optimise the flush.

This change reduces by 66% the time needed to activate ftrace on
an 8xx (588000 tb ticks instead of 1744000).

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/lib/code-patching.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index f970f189875b..62692c6031bc 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -90,17 +90,20 @@ void __init poking_init(void)
 		text_area_cpu_down));
 }
 
+static unsigned long get_patch_pfn(void *addr)
+{
+	if (IS_ENABLED(CONFIG_MODULES) && is_vmalloc_or_module_addr(addr))
+		return vmalloc_to_pfn(addr);
+	else
+		return __pa_symbol(addr) >> PAGE_SHIFT;
+}
+
 /*
  * This can be called for kernel text or a module.
  */
 static int map_patch_area(void *addr, unsigned long text_poke_addr)
 {
-	unsigned long pfn;
-
-	if (IS_ENABLED(CONFIG_MODULES) && is_vmalloc_or_module_addr(addr))
-		pfn = vmalloc_to_pfn(addr);
-	else
-		pfn = __pa_symbol(addr) >> PAGE_SHIFT;
+	unsigned long pfn = get_patch_pfn(addr);
 
 	return map_kernel_page(text_poke_addr, (pfn << PAGE_SHIFT), PAGE_KERNEL);
 }
@@ -145,17 +148,19 @@ static int __do_patch_instruction(u32 *addr, ppc_inst_t instr)
 	int err;
 	u32 *patch_addr;
 	unsigned long text_poke_addr;
+	pte_t *pte;
+	unsigned long pfn = get_patch_pfn(addr);
 
-	text_poke_addr = (unsigned long)__this_cpu_read(text_poke_area)->addr;
+	text_poke_addr = (unsigned long)__this_cpu_read(text_poke_area)->addr & PAGE_MASK;
 	patch_addr = (u32 *)(text_poke_addr + offset_in_page(addr));
 
-	err = map_patch_area(addr, text_poke_addr);
-	if (err)
-		return err;
+	pte = virt_to_kpte(text_poke_addr);
+	__set_pte_at(&init_mm, text_poke_addr, pte, pfn_pte(pfn, PAGE_KERNEL), 0);
 
 	err = __patch_instruction(addr, instr, patch_addr);
 
-	unmap_patch_area(text_poke_addr);
+	pte_clear(&init_mm, text_poke_addr, pte);
+	flush_tlb_kernel_range(text_poke_addr, text_poke_addr + PAGE_SIZE);
 
 	return err;
 }
-- 
2.35.1

