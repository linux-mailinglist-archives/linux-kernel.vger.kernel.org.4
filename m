Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88580722420
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjFELFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbjFELFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:05:17 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E12F1
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 04:05:15 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4QZW3V1zy5z9sB5;
        Mon,  5 Jun 2023 13:05:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WF4PdVAcC7Eb; Mon,  5 Jun 2023 13:05:10 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4QZW3T3jhZz9sB3;
        Mon,  5 Jun 2023 13:05:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7A5CB8B778;
        Mon,  5 Jun 2023 13:05:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id A4OgtW1-2yfv; Mon,  5 Jun 2023 13:05:09 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 52F978B763;
        Mon,  5 Jun 2023 13:05:09 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 355B52Tj063388
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 5 Jun 2023 13:05:02 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 355B51Hv063387;
        Mon, 5 Jun 2023 13:05:01 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/4] powerpc/kuap: Avoid useless jump_label on empty function
Date:   Mon,  5 Jun 2023 13:04:51 +0200
Message-Id: <c2c9660cc4441dc37c477ce5cf60707c971bd2a1.1685963081.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <1a3c69e38349b687c6c65240d7c09a7817a797d8.1685963081.git.christophe.leroy@csgroup.eu>
References: <1a3c69e38349b687c6c65240d7c09a7817a797d8.1685963081.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685963090; l=8334; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=V3a4ia79DSU+swldJhXy7MvvBkm9p8lGL7cecdQiomE=; b=NLWp1xo3VRliyXq/rbdL9ZSRAFcMDUeHGJFJFl6cAAUxFmt59breqjoqMP9tp3lC+iJGH816f 450FlBej9HIDiJwkQTbmXYU9jNB6iq+uS0FLHUW3Ao7XOxe6c/hjxsK
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

Disassembly of interrupt_enter_prepare() shows a pointless nop before the mftb

  c000abf0 <interrupt_enter_prepare>:
  c000abf0:       81 23 00 84     lwz     r9,132(r3)
  c000abf4:       71 29 40 00     andi.   r9,r9,16384
  c000abf8:       41 82 00 28     beq-    c000ac20 <interrupt_enter_prepare+0x30>
  c000abfc: ===>  60 00 00 00     nop	<====
  c000ac00:       7d 0c 42 e6     mftb    r8
  c000ac04:       80 e2 00 08     lwz     r7,8(r2)
  c000ac08:       81 22 00 28     lwz     r9,40(r2)
  c000ac0c:       91 02 00 24     stw     r8,36(r2)
  c000ac10:       7d 29 38 50     subf    r9,r9,r7
  c000ac14:       7d 29 42 14     add     r9,r9,r8
  c000ac18:       91 22 00 08     stw     r9,8(r2)
  c000ac1c:       4e 80 00 20     blr
  c000ac20:       60 00 00 00     nop
  c000ac24:       7d 5a c2 a6     mfmd_ap r10
  c000ac28:       3d 20 de 00     lis     r9,-8704
  c000ac2c:       91 43 00 b0     stw     r10,176(r3)
  c000ac30:       7d 3a c3 a6     mtspr   794,r9
  c000ac34:       4e 80 00 20     blr

That comes from the call to kuap_loc(), allthough __kuap_lock() is an empty
function on the 8xx.

To avoid that, only perform kuap_is_disabled() check when there is something
to do with __kuap_lock().

Do the same with __kuap_save_and_lock() and __kuap_get_and_assert_locked().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/32/kup.h     |  6 ++---
 arch/powerpc/include/asm/book3s/64/kup.h     | 10 +-------
 arch/powerpc/include/asm/kup.h               | 25 ++++++++++----------
 arch/powerpc/include/asm/nohash/32/kup-8xx.h | 11 ++++-----
 arch/powerpc/include/asm/nohash/kup-booke.h  |  8 +++++--
 5 files changed, 26 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/include/asm/book3s/32/kup.h
index 678f9c9d89b6..466a19cfb4df 100644
--- a/arch/powerpc/include/asm/book3s/32/kup.h
+++ b/arch/powerpc/include/asm/book3s/32/kup.h
@@ -77,10 +77,6 @@ static inline void kuap_unlock(unsigned long addr, bool ool)
 		kuap_unlock_all_ool();
 }
 
-static inline void __kuap_lock(void)
-{
-}
-
 static inline void __kuap_save_and_lock(struct pt_regs *regs)
 {
 	unsigned long kuap = current->thread.kuap;
@@ -92,6 +88,7 @@ static inline void __kuap_save_and_lock(struct pt_regs *regs)
 	current->thread.kuap = KUAP_NONE;
 	kuap_lock_addr(kuap, false);
 }
+#define __kuap_save_and_lock __kuap_save_and_lock
 
 static inline void kuap_user_restore(struct pt_regs *regs)
 {
@@ -120,6 +117,7 @@ static inline unsigned long __kuap_get_and_assert_locked(void)
 
 	return kuap;
 }
+#define __kuap_get_and_assert_locked __kuap_get_and_assert_locked
 
 static __always_inline void __allow_user_access(void __user *to, const void __user *from,
 						u32 size, unsigned long dir)
diff --git a/arch/powerpc/include/asm/book3s/64/kup.h b/arch/powerpc/include/asm/book3s/64/kup.h
index 54cf46808157..1b0215ff3710 100644
--- a/arch/powerpc/include/asm/book3s/64/kup.h
+++ b/arch/powerpc/include/asm/book3s/64/kup.h
@@ -297,15 +297,7 @@ static inline unsigned long __kuap_get_and_assert_locked(void)
 		WARN_ON_ONCE(amr != AMR_KUAP_BLOCKED);
 	return amr;
 }
-
-/* Do nothing, book3s/64 does that in ASM */
-static inline void __kuap_lock(void)
-{
-}
-
-static inline void __kuap_save_and_lock(struct pt_regs *regs)
-{
-}
+#define __kuap_get_and_assert_locked __kuap_get_and_assert_locked
 
 /*
  * We support individually allowing read or write, but we don't support nesting
diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
index d751ddd08110..0a4e07175612 100644
--- a/arch/powerpc/include/asm/kup.h
+++ b/arch/powerpc/include/asm/kup.h
@@ -52,16 +52,9 @@ __bad_kuap_fault(struct pt_regs *regs, unsigned long address, bool is_write)
 	return false;
 }
 
-static inline void __kuap_lock(void) { }
-static inline void __kuap_save_and_lock(struct pt_regs *regs) { }
 static inline void kuap_user_restore(struct pt_regs *regs) { }
 static inline void __kuap_kernel_restore(struct pt_regs *regs, unsigned long amr) { }
 
-static inline unsigned long __kuap_get_and_assert_locked(void)
-{
-	return 0;
-}
-
 /*
  * book3s/64/kup-radix.h defines these functions for the !KUAP case to flush
  * the L1D cache after user accesses. Only include the empty stubs for other
@@ -87,27 +80,32 @@ bad_kuap_fault(struct pt_regs *regs, unsigned long address, bool is_write)
 
 static __always_inline void kuap_assert_locked(void)
 {
+#if defined(CONFIG_PPC_KUAP_DEBUG) && defined(__kuap_get_and_assert_locked)
 	if (kuap_is_disabled())
 		return;
 
-	if (IS_ENABLED(CONFIG_PPC_KUAP_DEBUG))
-		__kuap_get_and_assert_locked();
+	__kuap_get_and_assert_locked();
+#endif
 }
 
 static __always_inline void kuap_lock(void)
 {
+#ifdef __kuap_lock
 	if (kuap_is_disabled())
 		return;
 
 	__kuap_lock();
+#endif
 }
 
 static __always_inline void kuap_save_and_lock(struct pt_regs *regs)
 {
+#ifdef __kuap_save_and_lock
 	if (kuap_is_disabled())
 		return;
 
 	__kuap_save_and_lock(regs);
+#endif
 }
 
 static __always_inline void kuap_kernel_restore(struct pt_regs *regs, unsigned long amr)
@@ -120,10 +118,11 @@ static __always_inline void kuap_kernel_restore(struct pt_regs *regs, unsigned l
 
 static __always_inline unsigned long kuap_get_and_assert_locked(void)
 {
-	if (kuap_is_disabled())
-		return 0;
-
-	return __kuap_get_and_assert_locked();
+#ifdef __kuap_get_and_assert_locked
+	if (!kuap_is_disabled())
+		return __kuap_get_and_assert_locked();
+#endif
+	return 0;
 }
 
 #ifndef CONFIG_PPC_BOOK3S_64
diff --git a/arch/powerpc/include/asm/nohash/32/kup-8xx.h b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
index 8579210f2a6a..a372cd822887 100644
--- a/arch/powerpc/include/asm/nohash/32/kup-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
@@ -20,15 +20,12 @@ static __always_inline bool kuap_is_disabled(void)
 	return static_branch_unlikely(&disable_kuap_key);
 }
 
-static inline void __kuap_lock(void)
-{
-}
-
 static inline void __kuap_save_and_lock(struct pt_regs *regs)
 {
 	regs->kuap = mfspr(SPRN_MD_AP);
 	mtspr(SPRN_MD_AP, MD_APG_KUAP);
 }
+#define __kuap_save_and_lock __kuap_save_and_lock
 
 static inline void kuap_user_restore(struct pt_regs *regs)
 {
@@ -39,13 +36,15 @@ static inline void __kuap_kernel_restore(struct pt_regs *regs, unsigned long kua
 	mtspr(SPRN_MD_AP, regs->kuap);
 }
 
+#ifdef CONFIG_PPC_KUAP_DEBUG
 static inline unsigned long __kuap_get_and_assert_locked(void)
 {
-	if (IS_ENABLED(CONFIG_PPC_KUAP_DEBUG))
-		WARN_ON_ONCE(mfspr(SPRN_MD_AP) >> 16 != MD_APG_KUAP >> 16);
+	WARN_ON_ONCE(mfspr(SPRN_MD_AP) >> 16 != MD_APG_KUAP >> 16);
 
 	return 0;
 }
+#define __kuap_get_and_assert_locked __kuap_get_and_assert_locked
+#endif
 
 static inline void __allow_user_access(void __user *to, const void __user *from,
 				       unsigned long size, unsigned long dir)
diff --git a/arch/powerpc/include/asm/nohash/kup-booke.h b/arch/powerpc/include/asm/nohash/kup-booke.h
index 823c5a3a96d8..71182cbe20c3 100644
--- a/arch/powerpc/include/asm/nohash/kup-booke.h
+++ b/arch/powerpc/include/asm/nohash/kup-booke.h
@@ -30,6 +30,7 @@ static inline void __kuap_lock(void)
 	mtspr(SPRN_PID, 0);
 	isync();
 }
+#define __kuap_lock __kuap_lock
 
 static inline void __kuap_save_and_lock(struct pt_regs *regs)
 {
@@ -37,6 +38,7 @@ static inline void __kuap_save_and_lock(struct pt_regs *regs)
 	mtspr(SPRN_PID, 0);
 	isync();
 }
+#define __kuap_save_and_lock __kuap_save_and_lock
 
 static inline void kuap_user_restore(struct pt_regs *regs)
 {
@@ -56,13 +58,15 @@ static inline void __kuap_kernel_restore(struct pt_regs *regs, unsigned long kua
 	/* Context synchronisation is performed by rfi */
 }
 
+#ifdef CONFIG_PPC_KUAP_DEBUG
 static inline unsigned long __kuap_get_and_assert_locked(void)
 {
-	if (IS_ENABLED(CONFIG_PPC_KUAP_DEBUG))
-		WARN_ON_ONCE(mfspr(SPRN_PID));
+	WARN_ON_ONCE(mfspr(SPRN_PID));
 
 	return 0;
 }
+#define __kuap_get_and_assert_locked __kuap_get_and_assert_locked
+#endif
 
 static inline void __allow_user_access(void __user *to, const void __user *from,
 				       unsigned long size, unsigned long dir)
-- 
2.40.1

