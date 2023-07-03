Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3C17457B4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjGCIu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjGCIuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:50:13 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B7CE62
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 01:49:54 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4Qvfj312SXz9sFq;
        Mon,  3 Jul 2023 10:48:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id T8SbAgQWrGV2; Mon,  3 Jul 2023 10:48:39 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Qvfhs5YkGz9sFb;
        Mon,  3 Jul 2023 10:48:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B9DF68B768;
        Mon,  3 Jul 2023 10:48:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id s-7mluNzcG8G; Mon,  3 Jul 2023 10:48:29 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6B49A8B81B;
        Mon,  3 Jul 2023 10:48:29 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 3638mQ1j1103959
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 3 Jul 2023 10:48:26 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 3638mQoM1103958;
        Mon, 3 Jul 2023 10:48:26 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 6/9] powerpc/kuap: Use MMU_FTR_KUAP on all and refactor disabling kuap
Date:   Mon,  3 Jul 2023 10:48:10 +0200
Message-ID: <2bfd558836e6bd1e4ed8063eb284a8ade1eb901c.1688373335.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1688373335.git.christophe.leroy@csgroup.eu>
References: <cover.1688373335.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688374084; l=6672; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=Pqt4ataQNmqi54ocs8mx2vDSBBYVydLvUVBK9BYfKnU=; b=C3dPaD3vtYK39YZykwtmYoQoA9UrocqfGotp7L8QowWV/vvj16LVsU2TlwxWcOC4VLgE3fEcM 4qUyj0GIHoUBSziZ5NcKGXn3nKoAelWN7/xTfjPjlF/uFzghoQIfwoc
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

All but book3s/64 use a static branch key for disabling kuap.
book3s/64 uses an mmu feature.

Refactor all targets to use MMU_FTR_KUAP like book3s/64.

For PPC32 that implies updating mmu features fixups once KUAP
has been initialised.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/32/kup.h     |  9 ---------
 arch/powerpc/include/asm/book3s/64/kup.h     |  5 -----
 arch/powerpc/include/asm/kup.h               | 11 +++++++++++
 arch/powerpc/include/asm/nohash/32/kup-8xx.h |  9 ---------
 arch/powerpc/include/asm/nohash/kup-booke.h  |  8 --------
 arch/powerpc/kernel/cputable.c               |  4 ++++
 arch/powerpc/mm/book3s32/kuap.c              |  5 +----
 arch/powerpc/mm/init_32.c                    |  2 ++
 arch/powerpc/mm/nohash/kup.c                 |  6 +-----
 9 files changed, 19 insertions(+), 40 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/include/asm/book3s/32/kup.h
index 0da0dea76c47..4ca6122ef0e1 100644
--- a/arch/powerpc/include/asm/book3s/32/kup.h
+++ b/arch/powerpc/include/asm/book3s/32/kup.h
@@ -9,10 +9,6 @@
 
 #ifndef __ASSEMBLY__
 
-#include <linux/jump_label.h>
-
-extern struct static_key_false disable_kuap_key;
-
 #ifdef CONFIG_PPC_KUAP
 
 #include <linux/sched.h>
@@ -20,11 +16,6 @@ extern struct static_key_false disable_kuap_key;
 #define KUAP_NONE	(~0UL)
 #define KUAP_ALL	(~1UL)
 
-static __always_inline bool kuap_is_disabled(void)
-{
-	return static_branch_unlikely(&disable_kuap_key);
-}
-
 static inline void kuap_lock_one(unsigned long addr)
 {
 	mtsr(mfsr(addr) | SR_KS, addr);
diff --git a/arch/powerpc/include/asm/book3s/64/kup.h b/arch/powerpc/include/asm/book3s/64/kup.h
index 72fc4263ed26..a014f4d9a2aa 100644
--- a/arch/powerpc/include/asm/book3s/64/kup.h
+++ b/arch/powerpc/include/asm/book3s/64/kup.h
@@ -230,11 +230,6 @@ static inline u64 current_thread_iamr(void)
 
 #ifdef CONFIG_PPC_KUAP
 
-static __always_inline bool kuap_is_disabled(void)
-{
-	return !mmu_has_feature(MMU_FTR_KUAP);
-}
-
 static inline void kuap_user_restore(struct pt_regs *regs)
 {
 	bool restore_amr = false, restore_iamr = false;
diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
index 24cde16c4fbe..bab161b609c1 100644
--- a/arch/powerpc/include/asm/kup.h
+++ b/arch/powerpc/include/asm/kup.h
@@ -6,6 +6,12 @@
 #define KUAP_WRITE	2
 #define KUAP_READ_WRITE	(KUAP_READ | KUAP_WRITE)
 
+#ifndef __ASSEMBLY__
+#include <linux/types.h>
+
+static __always_inline bool kuap_is_disabled(void);
+#endif
+
 #ifdef CONFIG_PPC_BOOK3S_64
 #include <asm/book3s/64/kup.h>
 #endif
@@ -41,6 +47,11 @@ void setup_kuep(bool disabled);
 
 #ifdef CONFIG_PPC_KUAP
 void setup_kuap(bool disabled);
+
+static __always_inline bool kuap_is_disabled(void)
+{
+	return !mmu_has_feature(MMU_FTR_KUAP);
+}
 #else
 static inline void setup_kuap(bool disabled) { }
 
diff --git a/arch/powerpc/include/asm/nohash/32/kup-8xx.h b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
index a372cd822887..d0601859c45a 100644
--- a/arch/powerpc/include/asm/nohash/32/kup-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/kup-8xx.h
@@ -9,17 +9,8 @@
 
 #ifndef __ASSEMBLY__
 
-#include <linux/jump_label.h>
-
 #include <asm/reg.h>
 
-extern struct static_key_false disable_kuap_key;
-
-static __always_inline bool kuap_is_disabled(void)
-{
-	return static_branch_unlikely(&disable_kuap_key);
-}
-
 static inline void __kuap_save_and_lock(struct pt_regs *regs)
 {
 	regs->kuap = mfspr(SPRN_MD_AP);
diff --git a/arch/powerpc/include/asm/nohash/kup-booke.h b/arch/powerpc/include/asm/nohash/kup-booke.h
index 71182cbe20c3..8e4734c8fef1 100644
--- a/arch/powerpc/include/asm/nohash/kup-booke.h
+++ b/arch/powerpc/include/asm/nohash/kup-booke.h
@@ -13,18 +13,10 @@
 
 #else
 
-#include <linux/jump_label.h>
 #include <linux/sched.h>
 
 #include <asm/reg.h>
 
-extern struct static_key_false disable_kuap_key;
-
-static __always_inline bool kuap_is_disabled(void)
-{
-	return static_branch_unlikely(&disable_kuap_key);
-}
-
 static inline void __kuap_lock(void)
 {
 	mtspr(SPRN_PID, 0);
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 8a32bffefa5b..e97a0fd0ae90 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -75,6 +75,10 @@ static struct cpu_spec * __init setup_cpu_spec(unsigned long offset,
 		t->cpu_features |= old.cpu_features & CPU_FTR_PMAO_BUG;
 	}
 
+	/* Set kuap ON at startup, will be disabled later if cmdline has 'nosmap' */
+	if (IS_ENABLED(CONFIG_PPC_KUAP) && IS_ENABLED(CONFIG_PPC32))
+		t->mmu_features |= MMU_FTR_KUAP;
+
 	*PTRRELOC(&cur_cpu_spec) = &the_cpu_spec;
 
 	/*
diff --git a/arch/powerpc/mm/book3s32/kuap.c b/arch/powerpc/mm/book3s32/kuap.c
index 28676cabb005..24c1c686e6b9 100644
--- a/arch/powerpc/mm/book3s32/kuap.c
+++ b/arch/powerpc/mm/book3s32/kuap.c
@@ -3,9 +3,6 @@
 #include <asm/kup.h>
 #include <asm/smp.h>
 
-struct static_key_false disable_kuap_key;
-EXPORT_SYMBOL(disable_kuap_key);
-
 void kuap_lock_all_ool(void)
 {
 	kuap_lock_all();
@@ -30,7 +27,7 @@ void setup_kuap(bool disabled)
 		return;
 
 	if (disabled)
-		static_branch_enable(&disable_kuap_key);
+		cur_cpu_spec->mmu_features &= ~MMU_FTR_KUAP;
 	else
 		pr_info("Activating Kernel Userspace Access Protection\n");
 }
diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index d4cc3749e621..d8adc452f431 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -126,6 +126,8 @@ void __init MMU_init(void)
 
 	setup_kup();
 
+	update_mmu_feature_fixups(MMU_FTR_KUAP);
+
 	/* Shortly after that, the entire linear mapping will be available */
 	memblock_set_current_limit(lowmem_end_addr);
 }
diff --git a/arch/powerpc/mm/nohash/kup.c b/arch/powerpc/mm/nohash/kup.c
index 552becf90e97..94ff82b9ae60 100644
--- a/arch/powerpc/mm/nohash/kup.c
+++ b/arch/powerpc/mm/nohash/kup.c
@@ -5,7 +5,6 @@
 
 #include <linux/export.h>
 #include <linux/init.h>
-#include <linux/jump_label.h>
 #include <linux/printk.h>
 #include <linux/smp.h>
 
@@ -13,16 +12,13 @@
 #include <asm/smp.h>
 
 #ifdef CONFIG_PPC_KUAP
-struct static_key_false disable_kuap_key;
-EXPORT_SYMBOL(disable_kuap_key);
-
 void setup_kuap(bool disabled)
 {
 	if (disabled) {
 		if (IS_ENABLED(CONFIG_40x))
 			disable_kuep = true;
 		if (smp_processor_id() == boot_cpuid)
-			static_branch_enable(&disable_kuap_key);
+			cur_cpu_spec->mmu_features &= ~MMU_FTR_KUAP;
 		return;
 	}
 
-- 
2.41.0

