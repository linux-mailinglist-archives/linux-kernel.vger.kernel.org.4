Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9212B72F064
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241803AbjFMXlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241562AbjFMXkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:40:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126CD2108;
        Tue, 13 Jun 2023 16:39:43 -0700 (PDT)
Message-ID: <20230613224545.670360645@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686699581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=lNQFIv9giVxLbCumZPShd6fBwItl7AKDfIjQdD1B1ok=;
        b=NhwOjp0vdKWOrteRuFiTOkExTiGFZ+1X3uZu8Sf9fdyrIPm2q/gN4MmPHkCZJSMuDFIyau
        62b1YEZwJdmoo/8iAGDMB+f2rfpJWTxhz280VlrOWuVI8kMlClaNhFnA/HnrvxfThhq2Y7
        LrmEMnVJ5d25Djkc3MZjVW/Fmz2axOYQ++mr4C8i7V8xhsVuiDO0UcuAgoIZ2LkpjNgGiP
        7dqi2bz7PCyBpzzyh/htAgssbDnwJDTyEbGU2gqgSCoXYtobvOXRW69yEXXCETLnzJzHvQ
        dbG14Dx6omVuOO5nyZKPQvEOw9jwwdikXGwasbUA2D71OPAp4CjnptBqSSwaHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686699581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=lNQFIv9giVxLbCumZPShd6fBwItl7AKDfIjQdD1B1ok=;
        b=gfCfRi6taulCsvO42taqM4pd4hXtC0EjIZYTeRqyo9lKyT8xnwcJ0CXF+9O/JENzPKmB+i
        pT1TJrwh+wATGyAA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Nikolay Borisov <nik.borisov@suse.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org,
        Richard Henderson <richard.henderson@linaro.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chris Zankel <chris@zankel.net>
Subject: [patch 13/17] init, x86: Move mem_encrypt_init() into
 arch_cpu_finalize_init()
References: <20230613223827.532680283@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 14 Jun 2023 01:39:41 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Invoke the X86ism mem_encrypt_init() from X86 arch_cpu_finalize_init() and
remove the weak fallback from the core code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/mem_encrypt.h |    7 ++++---
 arch/x86/kernel/cpu/common.c       |   11 +++++++++++
 init/main.c                        |   13 -------------
 3 files changed, 15 insertions(+), 16 deletions(-)

--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -51,6 +51,8 @@ void __init mem_encrypt_free_decrypted_m
 
 void __init sev_es_init_vc_handling(void);
 
+void __init mem_encrypt_init(void);
+
 #define __bss_decrypted __section(".bss..decrypted")
 
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
@@ -83,13 +85,12 @@ early_set_mem_enc_dec_hypercall(unsigned
 
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
@@ -2417,4 +2418,14 @@ void __init arch_cpu_finalize_init(void)
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
@@ -786,8 +785,6 @@ void __init __weak thread_stack_cache_in
 }
 #endif
 
-void __init __weak mem_encrypt_init(void) { }
-
 void __init __weak poking_init(void) { }
 
 void __init __weak pgtable_cache_init(void) { }
@@ -1043,16 +1040,6 @@ asmlinkage __visible void __init __no_sa
 
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

