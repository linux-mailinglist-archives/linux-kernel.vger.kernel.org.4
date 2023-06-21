Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0613D738107
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjFUKnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbjFUKnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:43:07 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44002D7D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 03:40:51 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4QmKlM2nJyz9sDZ;
        Wed, 21 Jun 2023 12:40:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NbYnEwTcC-OB; Wed, 21 Jun 2023 12:40:15 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4QmKlM20Plz9sCn;
        Wed, 21 Jun 2023 12:40:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 419A38B779;
        Wed, 21 Jun 2023 12:40:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id mMCMKADsnCeK; Wed, 21 Jun 2023 12:40:15 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2201F8B763;
        Wed, 21 Jun 2023 12:40:15 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 35LAeBbY2083043
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 12:40:11 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 35LAeApo2083002;
        Wed, 21 Jun 2023 12:40:10 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/kuap: KUAP enabling/disabling functions must be __always_inline
Date:   Wed, 21 Jun 2023 12:40:05 +0200
Message-Id: <25a39c954562e74d06db8b4ec3b6441b7eae3355.1687343989.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687344004; l=17772; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=tRdCHm1N5vuxvRQX7hD/93h/ORWg63Y+02PpH5NUnYY=; b=qg4I/DsH99vgTXB5Cdu7MAKcOgSH1hphOt0cLtgPu8gsaCkpLHRohplvqkxN8Fh4cafxuIvpT GQCGx7VzFMOAWlecqKZUVMjD8uMMS64Cg/Ggcyv03xmszTYoZWgPg+G
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

Objtool reports following warnings:

  arch/powerpc/kernel/signal_32.o: warning: objtool:
    __prevent_user_access.constprop.0+0x4 (.text+0x4):
    redundant UACCESS disable

  arch/powerpc/kernel/signal_32.o: warning: objtool: user_access_begin+0x2c
    (.text+0x4c): return with UACCESS enabled

  arch/powerpc/kernel/signal_32.o: warning: objtool: handle_rt_signal32+0x188
    (.text+0x360): call to __prevent_user_access.constprop.0() with UACCESS enabled

  arch/powerpc/kernel/signal_32.o: warning: objtool: handle_signal32+0x150
    (.text+0x4d4): call to __prevent_user_access.constprop.0() with UACCESS enabled

This is due to some KUAP enabling/disabling functions being outline
allthough they are marked inline. Use __always_inline instead.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/32/kup.h     | 26 ++++++++++----------
 arch/powerpc/include/asm/book3s/64/kup.h     | 22 ++++++++---------
 arch/powerpc/include/asm/kup.h               | 16 ++++++------
 arch/powerpc/include/asm/nohash/32/kup-8xx.h | 20 +++++++--------
 arch/powerpc/include/asm/nohash/kup-booke.h  | 22 ++++++++---------
 arch/powerpc/include/asm/uaccess.h           |  6 ++---
 6 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/include/asm/book3s/32/kup.h
index 8da9997a67ba..41746a22c650 100644
--- a/arch/powerpc/include/asm/book3s/32/kup.h
+++ b/arch/powerpc/include/asm/book3s/32/kup.h
@@ -23,25 +23,25 @@ static __always_inline bool kuep_is_disabled(void)
 #define KUAP_NONE	(~0UL)
 #define KUAP_ALL	(~1UL)
 
-static inline void kuap_lock_one(unsigned long addr)
+static __always_inline void kuap_lock_one(unsigned long addr)
 {
 	mtsr(mfsr(addr) | SR_KS, addr);
 	isync();	/* Context sync required after mtsr() */
 }
 
-static inline void kuap_unlock_one(unsigned long addr)
+static __always_inline void kuap_unlock_one(unsigned long addr)
 {
 	mtsr(mfsr(addr) & ~SR_KS, addr);
 	isync();	/* Context sync required after mtsr() */
 }
 
-static inline void kuap_lock_all(void)
+static __always_inline void kuap_lock_all(void)
 {
 	update_user_segments(mfsr(0) | SR_KS);
 	isync();	/* Context sync required after mtsr() */
 }
 
-static inline void kuap_unlock_all(void)
+static __always_inline void kuap_unlock_all(void)
 {
 	update_user_segments(mfsr(0) & ~SR_KS);
 	isync();	/* Context sync required after mtsr() */
@@ -50,7 +50,7 @@ static inline void kuap_unlock_all(void)
 void kuap_lock_all_ool(void);
 void kuap_unlock_all_ool(void);
 
-static inline void kuap_lock_addr(unsigned long addr, bool ool)
+static __always_inline void kuap_lock_addr(unsigned long addr, bool ool)
 {
 	if (likely(addr != KUAP_ALL))
 		kuap_lock_one(addr);
@@ -60,7 +60,7 @@ static inline void kuap_lock_addr(unsigned long addr, bool ool)
 		kuap_lock_all_ool();
 }
 
-static inline void kuap_unlock(unsigned long addr, bool ool)
+static __always_inline void kuap_unlock(unsigned long addr, bool ool)
 {
 	if (likely(addr != KUAP_ALL))
 		kuap_unlock_one(addr);
@@ -70,7 +70,7 @@ static inline void kuap_unlock(unsigned long addr, bool ool)
 		kuap_unlock_all_ool();
 }
 
-static inline void __kuap_save_and_lock(struct pt_regs *regs)
+static __always_inline void __kuap_save_and_lock(struct pt_regs *regs)
 {
 	unsigned long kuap = current->thread.kuap;
 
@@ -83,11 +83,11 @@ static inline void __kuap_save_and_lock(struct pt_regs *regs)
 }
 #define __kuap_save_and_lock __kuap_save_and_lock
 
-static inline void kuap_user_restore(struct pt_regs *regs)
+static __always_inline void kuap_user_restore(struct pt_regs *regs)
 {
 }
 
-static inline void __kuap_kernel_restore(struct pt_regs *regs, unsigned long kuap)
+static __always_inline void __kuap_kernel_restore(struct pt_regs *regs, unsigned long kuap)
 {
 	if (unlikely(kuap != KUAP_NONE)) {
 		current->thread.kuap = KUAP_NONE;
@@ -102,7 +102,7 @@ static inline void __kuap_kernel_restore(struct pt_regs *regs, unsigned long kua
 	kuap_unlock(regs->kuap, false);
 }
 
-static inline unsigned long __kuap_get_and_assert_locked(void)
+static __always_inline unsigned long __kuap_get_and_assert_locked(void)
 {
 	unsigned long kuap = current->thread.kuap;
 
@@ -137,7 +137,7 @@ static __always_inline void __prevent_user_access(unsigned long dir)
 	kuap_lock_addr(kuap, true);
 }
 
-static inline unsigned long __prevent_user_access_return(void)
+static __always_inline unsigned long __prevent_user_access_return(void)
 {
 	unsigned long flags = current->thread.kuap;
 
@@ -149,7 +149,7 @@ static inline unsigned long __prevent_user_access_return(void)
 	return flags;
 }
 
-static inline void __restore_user_access(unsigned long flags)
+static __always_inline void __restore_user_access(unsigned long flags)
 {
 	if (flags != KUAP_NONE) {
 		current->thread.kuap = flags;
@@ -157,7 +157,7 @@ static inline void __restore_user_access(unsigned long flags)
 	}
 }
 
-static inline bool
+static __always_inline bool
 __bad_kuap_fault(struct pt_regs *regs, unsigned long address, bool is_write)
 {
 	unsigned long kuap = regs->kuap;
diff --git a/arch/powerpc/include/asm/book3s/64/kup.h b/arch/powerpc/include/asm/book3s/64/kup.h
index b40a5099c1ae..19f137a272bf 100644
--- a/arch/powerpc/include/asm/book3s/64/kup.h
+++ b/arch/powerpc/include/asm/book3s/64/kup.h
@@ -213,14 +213,14 @@ extern u64 __ro_after_init default_iamr;
  * access restrictions. Because of this ignore AMR value when accessing
  * userspace via kernel thread.
  */
-static inline u64 current_thread_amr(void)
+static __always_inline u64 current_thread_amr(void)
 {
 	if (current->thread.regs)
 		return current->thread.regs->amr;
 	return default_amr;
 }
 
-static inline u64 current_thread_iamr(void)
+static __always_inline u64 current_thread_iamr(void)
 {
 	if (current->thread.regs)
 		return current->thread.regs->iamr;
@@ -236,7 +236,7 @@ static __always_inline bool kuap_is_disabled(void)
 }
 #define kuap_is_disabled kuap_is_disabled
 
-static inline void kuap_user_restore(struct pt_regs *regs)
+static __always_inline void kuap_user_restore(struct pt_regs *regs)
 {
 	bool restore_amr = false, restore_iamr = false;
 	unsigned long amr, iamr;
@@ -275,7 +275,7 @@ static inline void kuap_user_restore(struct pt_regs *regs)
 	 */
 }
 
-static inline void __kuap_kernel_restore(struct pt_regs *regs, unsigned long amr)
+static __always_inline void __kuap_kernel_restore(struct pt_regs *regs, unsigned long amr)
 {
 	if (likely(regs->amr == amr))
 		return;
@@ -291,7 +291,7 @@ static inline void __kuap_kernel_restore(struct pt_regs *regs, unsigned long amr
 	 */
 }
 
-static inline unsigned long __kuap_get_and_assert_locked(void)
+static __always_inline unsigned long __kuap_get_and_assert_locked(void)
 {
 	unsigned long amr = mfspr(SPRN_AMR);
 
@@ -306,7 +306,7 @@ static inline unsigned long __kuap_get_and_assert_locked(void)
  * because that would require an expensive read/modify write of the AMR.
  */
 
-static inline unsigned long get_kuap(void)
+static __always_inline unsigned long get_kuap(void)
 {
 	/*
 	 * We return AMR_KUAP_BLOCKED when we don't support KUAP because
@@ -336,7 +336,7 @@ static __always_inline void set_kuap(unsigned long value)
 	isync();
 }
 
-static inline bool __bad_kuap_fault(struct pt_regs *regs, unsigned long address, bool is_write)
+static __always_inline bool __bad_kuap_fault(struct pt_regs *regs, unsigned long address, bool is_write)
 {
 	/*
 	 * For radix this will be a storage protection fault (DSISR_PROTFAULT).
@@ -379,12 +379,12 @@ static __always_inline void allow_user_access(void __user *to, const void __user
 
 #else /* CONFIG_PPC_KUAP */
 
-static inline unsigned long get_kuap(void)
+static __always_inline unsigned long get_kuap(void)
 {
 	return AMR_KUAP_BLOCKED;
 }
 
-static inline void set_kuap(unsigned long value) { }
+static __always_inline void set_kuap(unsigned long value) { }
 
 static __always_inline void allow_user_access(void __user *to, const void __user *from,
 					      unsigned long size, unsigned long dir)
@@ -399,7 +399,7 @@ static __always_inline void prevent_user_access(unsigned long dir)
 		do_uaccess_flush();
 }
 
-static inline unsigned long prevent_user_access_return(void)
+static __always_inline unsigned long prevent_user_access_return(void)
 {
 	unsigned long flags = get_kuap();
 
@@ -410,7 +410,7 @@ static inline unsigned long prevent_user_access_return(void)
 	return flags;
 }
 
-static inline void restore_user_access(unsigned long flags)
+static __always_inline void restore_user_access(unsigned long flags)
 {
 	set_kuap(flags);
 	if (static_branch_unlikely(&uaccess_flush_key) && flags == AMR_KUAP_BLOCKED)
diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
index f3280169aeec..d39454274f73 100644
--- a/arch/powerpc/include/asm/kup.h
+++ b/arch/powerpc/include/asm/kup.h
@@ -61,14 +61,14 @@ static inline void setup_kuap(bool disabled) { }
 
 static __always_inline bool kuap_is_disabled(void) { return true; }
 
-static inline bool
+static __always_inline bool
 __bad_kuap_fault(struct pt_regs *regs, unsigned long address, bool is_write)
 {
 	return false;
 }
 
-static inline void kuap_user_restore(struct pt_regs *regs) { }
-static inline void __kuap_kernel_restore(struct pt_regs *regs, unsigned long amr) { }
+static __always_inline void kuap_user_restore(struct pt_regs *regs) { }
+static __always_inline void __kuap_kernel_restore(struct pt_regs *regs, unsigned long amr) { }
 
 /*
  * book3s/64/kup-radix.h defines these functions for the !KUAP case to flush
@@ -76,11 +76,11 @@ static inline void __kuap_kernel_restore(struct pt_regs *regs, unsigned long amr
  * platforms.
  */
 #ifndef CONFIG_PPC_BOOK3S_64
-static inline void __allow_user_access(void __user *to, const void __user *from,
-				       unsigned long size, unsigned long dir) { }
-static inline void __prevent_user_access(unsigned long dir) { }
-static inline unsigned long __prevent_user_access_return(void) { return 0UL; }
-static inline void __restore_user_access(unsigned long flags) { }
+static __always_inline void __allow_user_access(void __user *to, const void __user *from,
+						unsigned long size, unsigned long dir) { }
+static __always_inline void __prevent_user_access(unsigned long dir) { }
+static __always_inline unsigned long __prevent_user_access_return(void) { return 0UL; }
+static __always_inline void __restore_user_access(unsigned long flags) { }
 #endif /* CONFIG_PPC_BOOK3S_64 */
 #endif /* CONFIG_PPC_KUAP */
 
diff --git a/arch/powerpc/include/asm/nohash/32/kup-8xx.h b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
index 1d53f38c5cd5..61067e4c8f22 100644
--- a/arch/powerpc/include/asm/nohash/32/kup-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
@@ -13,24 +13,24 @@
 
 #include <asm/reg.h>
 
-static inline void __kuap_save_and_lock(struct pt_regs *regs)
+static __always_inline void __kuap_save_and_lock(struct pt_regs *regs)
 {
 	regs->kuap = mfspr(SPRN_MD_AP);
 	mtspr(SPRN_MD_AP, MD_APG_KUAP);
 }
 #define __kuap_save_and_lock __kuap_save_and_lock
 
-static inline void kuap_user_restore(struct pt_regs *regs)
+static __always_inline void kuap_user_restore(struct pt_regs *regs)
 {
 }
 
-static inline void __kuap_kernel_restore(struct pt_regs *regs, unsigned long kuap)
+static __always_inline void __kuap_kernel_restore(struct pt_regs *regs, unsigned long kuap)
 {
 	mtspr(SPRN_MD_AP, regs->kuap);
 }
 
 #ifdef CONFIG_PPC_KUAP_DEBUG
-static inline unsigned long __kuap_get_and_assert_locked(void)
+static __always_inline unsigned long __kuap_get_and_assert_locked(void)
 {
 	WARN_ON_ONCE(mfspr(SPRN_MD_AP) >> 16 != MD_APG_KUAP >> 16);
 
@@ -39,18 +39,18 @@ static inline unsigned long __kuap_get_and_assert_locked(void)
 #define __kuap_get_and_assert_locked __kuap_get_and_assert_locked
 #endif
 
-static inline void __allow_user_access(void __user *to, const void __user *from,
-				       unsigned long size, unsigned long dir)
+static __always_inline void __allow_user_access(void __user *to, const void __user *from,
+						unsigned long size, unsigned long dir)
 {
 	mtspr(SPRN_MD_AP, MD_APG_INIT);
 }
 
-static inline void __prevent_user_access(unsigned long dir)
+static __always_inline void __prevent_user_access(unsigned long dir)
 {
 	mtspr(SPRN_MD_AP, MD_APG_KUAP);
 }
 
-static inline unsigned long __prevent_user_access_return(void)
+static __always_inline unsigned long __prevent_user_access_return(void)
 {
 	unsigned long flags;
 
@@ -61,12 +61,12 @@ static inline unsigned long __prevent_user_access_return(void)
 	return flags;
 }
 
-static inline void __restore_user_access(unsigned long flags)
+static __always_inline void __restore_user_access(unsigned long flags)
 {
 	mtspr(SPRN_MD_AP, flags);
 }
 
-static inline bool
+static __always_inline bool
 __bad_kuap_fault(struct pt_regs *regs, unsigned long address, bool is_write)
 {
 	return !((regs->kuap ^ MD_APG_KUAP) & 0xff000000);
diff --git a/arch/powerpc/include/asm/nohash/kup-booke.h b/arch/powerpc/include/asm/nohash/kup-booke.h
index 07759ae9117b..416f3e0897d5 100644
--- a/arch/powerpc/include/asm/nohash/kup-booke.h
+++ b/arch/powerpc/include/asm/nohash/kup-booke.h
@@ -18,14 +18,14 @@
 
 #include <asm/reg.h>
 
-static inline void __kuap_lock(void)
+static __always_inline void __kuap_lock(void)
 {
 	mtspr(SPRN_PID, 0);
 	isync();
 }
 #define __kuap_lock __kuap_lock
 
-static inline void __kuap_save_and_lock(struct pt_regs *regs)
+static __always_inline void __kuap_save_and_lock(struct pt_regs *regs)
 {
 	regs->kuap = mfspr(SPRN_PID);
 	mtspr(SPRN_PID, 0);
@@ -33,7 +33,7 @@ static inline void __kuap_save_and_lock(struct pt_regs *regs)
 }
 #define __kuap_save_and_lock __kuap_save_and_lock
 
-static inline void kuap_user_restore(struct pt_regs *regs)
+static __always_inline void kuap_user_restore(struct pt_regs *regs)
 {
 	if (kuap_is_disabled())
 		return;
@@ -43,7 +43,7 @@ static inline void kuap_user_restore(struct pt_regs *regs)
 	/* Context synchronisation is performed by rfi */
 }
 
-static inline void __kuap_kernel_restore(struct pt_regs *regs, unsigned long kuap)
+static __always_inline void __kuap_kernel_restore(struct pt_regs *regs, unsigned long kuap)
 {
 	if (regs->kuap)
 		mtspr(SPRN_PID, current->thread.pid);
@@ -52,7 +52,7 @@ static inline void __kuap_kernel_restore(struct pt_regs *regs, unsigned long kua
 }
 
 #ifdef CONFIG_PPC_KUAP_DEBUG
-static inline unsigned long __kuap_get_and_assert_locked(void)
+static __always_inline unsigned long __kuap_get_and_assert_locked(void)
 {
 	WARN_ON_ONCE(mfspr(SPRN_PID));
 
@@ -61,20 +61,20 @@ static inline unsigned long __kuap_get_and_assert_locked(void)
 #define __kuap_get_and_assert_locked __kuap_get_and_assert_locked
 #endif
 
-static inline void __allow_user_access(void __user *to, const void __user *from,
-				       unsigned long size, unsigned long dir)
+static __always_inline void __allow_user_access(void __user *to, const void __user *from,
+						unsigned long size, unsigned long dir)
 {
 	mtspr(SPRN_PID, current->thread.pid);
 	isync();
 }
 
-static inline void __prevent_user_access(unsigned long dir)
+static __always_inline void __prevent_user_access(unsigned long dir)
 {
 	mtspr(SPRN_PID, 0);
 	isync();
 }
 
-static inline unsigned long __prevent_user_access_return(void)
+static __always_inline unsigned long __prevent_user_access_return(void)
 {
 	unsigned long flags = mfspr(SPRN_PID);
 
@@ -84,7 +84,7 @@ static inline unsigned long __prevent_user_access_return(void)
 	return flags;
 }
 
-static inline void __restore_user_access(unsigned long flags)
+static __always_inline void __restore_user_access(unsigned long flags)
 {
 	if (flags) {
 		mtspr(SPRN_PID, current->thread.pid);
@@ -92,7 +92,7 @@ static inline void __restore_user_access(unsigned long flags)
 	}
 }
 
-static inline bool
+static __always_inline bool
 __bad_kuap_fault(struct pt_regs *regs, unsigned long address, bool is_write)
 {
 	return !regs->kuap;
diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index a2d255aa9627..fb725ec77926 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -386,7 +386,7 @@ copy_mc_to_user(void __user *to, const void *from, unsigned long n)
 extern long __copy_from_user_flushcache(void *dst, const void __user *src,
 		unsigned size);
 
-static __must_check inline bool user_access_begin(const void __user *ptr, size_t len)
+static __must_check __always_inline bool user_access_begin(const void __user *ptr, size_t len)
 {
 	if (unlikely(!access_ok(ptr, len)))
 		return false;
@@ -401,7 +401,7 @@ static __must_check inline bool user_access_begin(const void __user *ptr, size_t
 #define user_access_save	prevent_user_access_return
 #define user_access_restore	restore_user_access
 
-static __must_check inline bool
+static __must_check __always_inline bool
 user_read_access_begin(const void __user *ptr, size_t len)
 {
 	if (unlikely(!access_ok(ptr, len)))
@@ -415,7 +415,7 @@ user_read_access_begin(const void __user *ptr, size_t len)
 #define user_read_access_begin	user_read_access_begin
 #define user_read_access_end		prevent_current_read_from_user
 
-static __must_check inline bool
+static __must_check __always_inline bool
 user_write_access_begin(const void __user *ptr, size_t len)
 {
 	if (unlikely(!access_ok(ptr, len)))
-- 
2.40.1

