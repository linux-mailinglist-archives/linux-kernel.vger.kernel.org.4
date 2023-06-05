Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F276E72241F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjFELFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbjFELFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:05:15 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32CEED
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 04:05:10 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4QZW3T4WZ7z9sCP;
        Mon,  5 Jun 2023 13:05:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3wylewUK9X54; Mon,  5 Jun 2023 13:05:09 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4QZW3T3jqJz9sB5;
        Mon,  5 Jun 2023 13:05:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7A97C8B779;
        Mon,  5 Jun 2023 13:05:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id lEUim57Ixwxf; Mon,  5 Jun 2023 13:05:09 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 54CD58B776;
        Mon,  5 Jun 2023 13:05:09 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 355B51wO063384
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 5 Jun 2023 13:05:01 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 355B50RE063381;
        Mon, 5 Jun 2023 13:05:00 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/4] powerpc/kuap: Avoid unnecessary reads of MD_AP
Date:   Mon,  5 Jun 2023 13:04:50 +0200
Message-Id: <1a3c69e38349b687c6c65240d7c09a7817a797d8.1685963081.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685963090; l=2619; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=MpFKL0d/EfDJ0kCQxhMEiBWz5R0LOuG+v/7pxC8nbYg=; b=yFk0cQtOBClqR7+PON7Sbs8qGOthFHJPTPLMFmfROgtuV2h1DKcrbU5GVFZnTR0oTJL2fA5Xv 0uBUcaS5bDvAOEdWghpXIcLzT15MN1cjfmVS8ULDaPc31r7tZEzPLaI
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A disassembly of interrupt_exit_kernel_prepare() shows a useless read
of MD_AP register. This is shown by r9 being re-used immediately without
doing anything with the value read.

  c000e0e0:       60 00 00 00     nop
  c000e0e4: ===>  7d 3a c2 a6     mfmd_ap r9	<====
  c000e0e8:       7d 20 00 a6     mfmsr   r9
  c000e0ec:       7c 51 13 a6     mtspr   81,r2
  c000e0f0:       81 3f 00 84     lwz     r9,132(r31)
  c000e0f4:       71 29 80 00     andi.   r9,r9,32768

kuap_get_and_assert_locked() is paired with kuap_kernel_restore()
and are only used in interrupt_exit_kernel_prepare(). The value
returned by kuap_get_and_assert_locked() is only used by
kuap_kernel_restore().

On 8xx, kuap_kernel_restore() doesn't use the value read by
kuap_get_and_assert_locked() so modify kuap_get_and_assert_locked()
to not perform the read of MD_AP and return 0 instead.

The same applies on BOOKE.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/nohash/32/kup-8xx.h | 8 ++------
 arch/powerpc/include/asm/nohash/kup-booke.h  | 6 ++----
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/kup-8xx.h b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
index c44d97751723..8579210f2a6a 100644
--- a/arch/powerpc/include/asm/nohash/32/kup-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
@@ -41,14 +41,10 @@ static inline void __kuap_kernel_restore(struct pt_regs *regs, unsigned long kua
 
 static inline unsigned long __kuap_get_and_assert_locked(void)
 {
-	unsigned long kuap;
-
-	kuap = mfspr(SPRN_MD_AP);
-
 	if (IS_ENABLED(CONFIG_PPC_KUAP_DEBUG))
-		WARN_ON_ONCE(kuap >> 16 != MD_APG_KUAP >> 16);
+		WARN_ON_ONCE(mfspr(SPRN_MD_AP) >> 16 != MD_APG_KUAP >> 16);
 
-	return kuap;
+	return 0;
 }
 
 static inline void __allow_user_access(void __user *to, const void __user *from,
diff --git a/arch/powerpc/include/asm/nohash/kup-booke.h b/arch/powerpc/include/asm/nohash/kup-booke.h
index 49bb41ed0816..823c5a3a96d8 100644
--- a/arch/powerpc/include/asm/nohash/kup-booke.h
+++ b/arch/powerpc/include/asm/nohash/kup-booke.h
@@ -58,12 +58,10 @@ static inline void __kuap_kernel_restore(struct pt_regs *regs, unsigned long kua
 
 static inline unsigned long __kuap_get_and_assert_locked(void)
 {
-	unsigned long kuap = mfspr(SPRN_PID);
-
 	if (IS_ENABLED(CONFIG_PPC_KUAP_DEBUG))
-		WARN_ON_ONCE(kuap);
+		WARN_ON_ONCE(mfspr(SPRN_PID));
 
-	return kuap;
+	return 0;
 }
 
 static inline void __allow_user_access(void __user *to, const void __user *from,
-- 
2.40.1

