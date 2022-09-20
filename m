Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A5F5BEC1D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 19:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbiITRhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 13:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiITRhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 13:37:11 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561DD48CA0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 10:37:10 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4MX7yr1zdVz9snR;
        Tue, 20 Sep 2022 19:37:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3hNtrYzvTGo0; Tue, 20 Sep 2022 19:37:08 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4MX7yr0lMSz9sb2;
        Tue, 20 Sep 2022 19:37:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 03DEB8B773;
        Tue, 20 Sep 2022 19:37:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id GN5d43MMkRdB; Tue, 20 Sep 2022 19:37:07 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (po16898.idsi0.si.c-s.fr [192.168.232.36])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C612D8B764;
        Tue, 20 Sep 2022 19:37:07 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 28KHaueN1631727
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 19:36:57 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 28KHat3e1631724;
        Tue, 20 Sep 2022 19:36:55 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: [PATCH] powerpc/highmem: Properly handle fragmented memory
Date:   Tue, 20 Sep 2022 19:36:42 +0200
Message-Id: <f08cca5c46d67399c53262eca48e015dcf1841f9.1663695394.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1663695401; l=2820; s=20211009; h=from:subject:message-id; bh=zZYtB2x+Tm15SIiBUEcswFS/ssyXHnPqFPklEmioB4g=; b=DWfX+yK3bDaiCsFckfmR1Kazj+e3NO54zggM77+tVV1X5m2OPJYaAQV+DhDhUXw1lQVNYYUVia/c xG2Vc4kMDIHj/1bCUPyclookzOwuYqrv2vYSaAYb+KO0dN/gje8r
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to checking whether a page is reserved before allocating
it to highmem, verify that it is valid memory.

Otherwise the kernel Oopses as below:

[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Kernel attempted to read user page (7df58) - exploit attempt? (uid: 0)
[    0.000000] BUG: Unable to handle kernel data access on read at 0x0007df58
[    0.000000] Faulting instruction address: 0xc01c8348
[    0.000000] Oops: Kernel access of bad area, sig: 11 [#1]
[    0.000000] BE PAGE_SIZE=4K SMP NR_CPUS=2 P2020RDB-PC
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.0.0-rc2-0caacb197b677410bdac81bc34f05235+ #121
[    0.000000] NIP:  c01c8348 LR: c01cb2bc CTR: 0000000a
[    0.000000] REGS: c10d7e20 TRAP: 0300   Not tainted  (6.0.0-rc2-0caacb197b677410bdac81bc34f05235+)
[    0.000000] MSR:  00021000 <CE,ME>  CR: 48044224  XER: 00000000
[    0.000000] DEAR: 0007df58 ESR: 00000000
[    0.000000] GPR00: c01cb294 c10d7f10 c1045340 00000001 00000004 c112bcc0 00000015 eedf1000
[    0.000000] GPR08: 00000003 0007df58 00000000 f0000000 28044228 00000200 00000000 00000000
[    0.000000] GPR16: 00000000 00000000 00000000 0275cb7a c0000000 00000001 0000075f 00000000
[    0.000000] GPR24: c1031004 00000000 00000000 00000001 c10f0000 eedf1000 00080000 00080000
[    0.000000] NIP [c01c8348] free_unref_page_prepare.part.93+0x48/0x60
[    0.000000] LR [c01cb2bc] free_unref_page+0x84/0x4b8
[    0.000000] Call Trace:
[    0.000000] [c10d7f10] [eedf1000] 0xeedf1000 (unreliable)
[    0.000000] [c10d7f20] [c01cb294] free_unref_page+0x5c/0x4b8
[    0.000000] [c10d7f70] [c1007644] mem_init+0xd0/0x194
[    0.000000] [c10d7fa0] [c1000e4c] start_kernel+0x4c0/0x6d0
[    0.000000] [c10d7ff0] [c00003e0] set_ivor+0x13c/0x178
[    0.000000] Instruction dump:
[    0.000000] 552817be 5509103a 7d294214 55293830 7d4a4a14 812a003c 814a0038 5529002a
[    0.000000] 7c892050 5484c23a 5489eafa 548406fe <7d2a482e> 7d242430 5484077e 90870010
[    0.000000] ---[ end trace 0000000000000000 ]---

Reported-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 01772e79fd93..6ddbd6cb3a2a 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -302,7 +302,7 @@ void __init mem_init(void)
 		for (pfn = highmem_mapnr; pfn < max_mapnr; ++pfn) {
 			phys_addr_t paddr = (phys_addr_t)pfn << PAGE_SHIFT;
 			struct page *page = pfn_to_page(pfn);
-			if (!memblock_is_reserved(paddr))
+			if (memblock_is_memory(paddr) && !memblock_is_reserved(paddr))
 				free_highmem_page(page);
 		}
 	}
-- 
2.37.1

