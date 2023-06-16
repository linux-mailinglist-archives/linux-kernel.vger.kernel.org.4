Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0DC732B5D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344180AbjFPJZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344018AbjFPJYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:24:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12EA2728;
        Fri, 16 Jun 2023 02:24:45 -0700 (PDT)
Date:   Fri, 16 Jun 2023 09:24:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686907484;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f7gy6MsfQJ3FW/zAGe1eR+9fJ/Ctzbfikdo/p5Z0QRA=;
        b=VbZjNOpswXEA2d9yw8dRJPGO8TAVmBjWK2IeU+p/qBydwXzsuTRxl+WctLiQBiTUbm3Ind
        YpEHzxNbZ/h/EoDN8AXPNUyRUF5fyPNqzPgOj6RVmU+6YkO/BQH3OVnYn6ltx7pkEF69DL
        ypnBs+liKgqHPZGmelrqhesySuLLTaZXVaGqa4ChQg8H4ng2+rKNfOASyoxrgixxVJepb4
        P3sromSpXixIOo+eH7ruv/NVYy3b1o9NTsCXiO6vuNVqHzBHNw54KKkuzUTwSFlwGGnUJr
        H8ODgL/OLkj4d9WE38hdD96Dxft+EwmoPPrSX/wiD+K0SI7oBRVkilfduZ/k4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686907484;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f7gy6MsfQJ3FW/zAGe1eR+9fJ/Ctzbfikdo/p5Z0QRA=;
        b=V0nEWxFUBTJ8za2z6MlBiXGfNo4psneoHCSfFNGklFeSutdQWJCMVCJSmj7RVmuzEDjF52
        AFJs2UpcjfdHE2AQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] init, x86: Move mem_encrypt_init() into
 arch_cpu_finalize_init()
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230613224545.670360645@linutronix.de>
References: <20230613224545.670360645@linutronix.de>
MIME-Version: 1.0
Message-ID: <168690748383.404.8801319601606683604.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     439e17576eb47f26b78c5bbc72e344d4206d2327
Gitweb:        https://git.kernel.org/tip/439e17576eb47f26b78c5bbc72e344d4206d2327
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 14 Jun 2023 01:39:41 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 Jun 2023 10:16:00 +02:00

init, x86: Move mem_encrypt_init() into arch_cpu_finalize_init()

Invoke the X86ism mem_encrypt_init() from X86 arch_cpu_finalize_init() and
remove the weak fallback from the core code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230613224545.670360645@linutronix.de

---
 arch/x86/include/asm/mem_encrypt.h |  7 ++++---
 arch/x86/kernel/cpu/common.c       | 11 +++++++++++
 init/main.c                        | 13 -------------
 3 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index b712670..98ce265 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -51,6 +51,8 @@ void __init mem_encrypt_free_decrypted_mem(void);
 
 void __init sev_es_init_vc_handling(void);
 
+void __init mem_encrypt_init(void);
+
 #define __bss_decrypted __section(".bss..decrypted")
 
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
@@ -83,13 +85,12 @@ early_set_mem_enc_dec_hypercall(unsigned long vaddr, int npages, bool enc) {}
 
 static inline void mem_encrypt_free_decrypted_mem(void) { }
 
+static inline void mem_encrypt_init(void) { }
+
 #define __bss_decrypted
 
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
 
-/* Architecture __weak replacement functions */
-void __init mem_encrypt_init(void);
-
 void add_encrypt_protection_map(void);
 
 /*
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 18612e5..5ee8b31 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/kprobes.h>
 #include <linux/kgdb.h>
+#include <linux/mem_encrypt.h>
 #include <linux/smp.h>
 #include <linux/cpu.h>
 #include <linux/io.h>
@@ -2414,4 +2415,14 @@ void __init arch_cpu_finalize_init(void)
 	} else {
 		fpu__init_check_bugs();
 	}
+
+	/*
+	 * This needs to be called before any devices perform DMA
+	 * operations that might use the SWIOTLB bounce buffers. It will
+	 * mark the bounce buffers as decrypted so that their usage will
+	 * not cause "plain-text" data to be decrypted when accessed. It
+	 * must be called after late_time_init() so that Hyper-V x86/x64
+	 * hypercalls work when the SWIOTLB bounce buffers are decrypted.
+	 */
+	mem_encrypt_init();
 }
diff --git a/init/main.c b/init/main.c
index c968c19..32c65f2 100644
--- a/init/main.c
+++ b/init/main.c
@@ -95,7 +95,6 @@
 #include <linux/cache.h>
 #include <linux/rodata_test.h>
 #include <linux/jump_label.h>
-#include <linux/mem_encrypt.h>
 #include <linux/kcsan.h>
 #include <linux/init_syscalls.h>
 #include <linux/stackdepot.h>
@@ -786,8 +785,6 @@ void __init __weak thread_stack_cache_init(void)
 }
 #endif
 
-void __init __weak mem_encrypt_init(void) { }
-
 void __init __weak poking_init(void) { }
 
 void __init __weak pgtable_cache_init(void) { }
@@ -1043,16 +1040,6 @@ asmlinkage __visible void __init __no_sanitize_address __noreturn start_kernel(v
 
 	arch_cpu_finalize_init();
 
-	/*
-	 * This needs to be called before any devices perform DMA
-	 * operations that might use the SWIOTLB bounce buffers. It will
-	 * mark the bounce buffers as decrypted so that their usage will
-	 * not cause "plain-text" data to be decrypted when accessed. It
-	 * must be called after late_time_init() so that Hyper-V x86/x64
-	 * hypercalls work when the SWIOTLB bounce buffers are decrypted.
-	 */
-	mem_encrypt_init();
-
 	pid_idr_init();
 	anon_vma_init();
 #ifdef CONFIG_X86
