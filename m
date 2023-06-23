Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBED73BD57
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 19:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjFWRF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 13:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjFWRFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 13:05:54 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1129A26BB
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 10:05:49 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4QnkCH4lQ8z9sgY;
        Fri, 23 Jun 2023 19:05:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sv3-deHSrF5C; Fri, 23 Jun 2023 19:05:47 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4QnkCH44NMz9sgT;
        Fri, 23 Jun 2023 19:05:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 861858B77C;
        Fri, 23 Jun 2023 19:05:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id wE64t1vDfFC4; Fri, 23 Jun 2023 19:05:47 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.71])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 31C038B763;
        Fri, 23 Jun 2023 19:05:47 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 35NH5eVr2645720
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 19:05:40 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 35NH5eGJ2645719;
        Fri, 23 Jun 2023 19:05:40 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        Naveen N Rao <naveen@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 01/15] powerpc/kuap: Avoid unnecessary reads of MD_AP
Date:   Fri, 23 Jun 2023 19:05:12 +0200
Message-Id: <6928772943c0e7e1f0c26fb8d42a9b6eb8c9489d.1687539638.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1687539638.git.christophe.leroy@csgroup.eu>
References: <cover.1687539638.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687539921; l=2619; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=MpFKL0d/EfDJ0kCQxhMEiBWz5R0LOuG+v/7pxC8nbYg=; b=OrKO4NsRLP9QaG+j5ga5kEUjLHA1BioBrCmMsF5qhSVT9IovGUM5guLTckhRw0WzPMrL1DAFW EBWGXIQbNZ5CJd1n43d/DsM6apfzR3AaV6JOD8BXJu4L31tGL0OFyVR
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

