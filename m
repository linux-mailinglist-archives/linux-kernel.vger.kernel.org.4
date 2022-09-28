Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A635ED4E0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 08:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbiI1G30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 02:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbiI1G3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:29:24 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A801EAD4E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 23:29:20 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Mcmmb1CnWz9smH;
        Wed, 28 Sep 2022 08:29:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2mTkLnVdGBwG; Wed, 28 Sep 2022 08:29:19 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Mcmmb0QNqz9sm8;
        Wed, 28 Sep 2022 08:29:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E55CA8B776;
        Wed, 28 Sep 2022 08:29:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id G2sli3qU7am1; Wed, 28 Sep 2022 08:29:18 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.79])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B2D6C8B763;
        Wed, 28 Sep 2022 08:29:18 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 28S6T81H420548
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 08:29:08 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 28S6T6A3420543;
        Wed, 28 Sep 2022 08:29:06 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/8xx: Simplify pte_update() with 16k pages
Date:   Wed, 28 Sep 2022 08:29:00 +0200
Message-Id: <65f76300de07091a59a042a3db2d0ce9b939a05c.1664346532.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1664346539; l=1661; s=20211009; h=from:subject:message-id; bh=Lr8XahhYObOfzO5oPsqbgqOUCyBYxfNYnveRrwOm2sU=; b=XzTB8nyhZpJHQBEnqrFzGfTYexL6o+RStqeFlKPBVi1IqgcLoqYAfrPab+bXLb/sOFwSWjFoexBA Ncpm+3UkCEJv/geDDdmspWD17TX3plxzB7ariBr4glrf3PH+Sup8
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While looking at code generated for code patching, I saw that
pte_clear generated:

 2d8:	38 a0 00 00 	li      r5,0
 2dc:	38 e0 10 00 	li      r7,4096
 2e0:	39 00 20 00 	li      r8,8192
 2e4:	39 40 30 00 	li      r10,12288
 2e8:	90 a9 00 00 	stw     r5,0(r9)
 2ec:	90 e9 00 04 	stw     r7,4(r9)
 2f0:	91 09 00 08 	stw     r8,8(r9)
 2f4:	91 49 00 0c 	stw     r10,12(r9)

With 16k pages, only the first entry is used by the kernel, so no need
to adapt the address of other entries. Only duplicate the first entry
for hardware.

Now it is:

 2cc:	39 40 00 00 	li      r10,0
 2d0:	91 49 00 00 	stw     r10,0(r9)
 2d4:	91 49 00 04 	stw     r10,4(r9)
 2d8:	91 49 00 08 	stw     r10,8(r9)
 2dc:	91 49 00 0c 	stw     r10,12(r9)

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/nohash/32/pgtable.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 9091e4904a6b..981e414bdeef 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -256,8 +256,14 @@ static inline pte_basic_t pte_update(struct mm_struct *mm, unsigned long addr, p
 
 	num = number_of_cells_per_pte(pmd, new, huge);
 
-	for (i = 0; i < num; i++, entry++, new += SZ_4K)
-		*entry = new;
+	for (i = 0; i < num; i += PAGE_SIZE / SZ_4K, new += PAGE_SIZE) {
+		*entry++ = new;
+		if (IS_ENABLED(CONFIG_PPC_16K_PAGES) && num != 1) {
+			*entry++ = new;
+			*entry++ = new;
+			*entry++ = new;
+		}
+	}
 
 	return old;
 }
-- 
2.37.1

