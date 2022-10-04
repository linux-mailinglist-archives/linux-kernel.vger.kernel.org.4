Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5304E5F3DFC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiJDINS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiJDIL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:11:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698441F0
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 01:11:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9A9F4219B0;
        Tue,  4 Oct 2022 08:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664871100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cfd9GXwMsF2oHrjWI8khgMyNgY9guc85ahmXq4+XzZc=;
        b=rXkYpHqMUoG5cNNyWPcpg+oX5S/E24G6GuSjnJTJj185dYM/fKCyVPqEveVj9CkDzZpgwN
        PNunlTN1Ve+Ro7t3IhADWy3Lz5Ze5KwwJ/lAQtw/zMXo9xCk96BYW2IKi9jNzY+PLh3Sv2
        bF96XbN4YqBQokPO3F4Wn1qqXNfyJu4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5442A139EF;
        Tue,  4 Oct 2022 08:11:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WFJEE7zqO2OySAAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 04 Oct 2022 08:11:40 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v4 13/16] x86: decouple pat and mtrr handling
Date:   Tue,  4 Oct 2022 10:10:20 +0200
Message-Id: <20221004081023.32402-14-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221004081023.32402-1-jgross@suse.com>
References: <20221004081023.32402-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today PAT is usable only with MTRR being active, with some nasty tweaks
to make PAT usable when running as Xen PV guest, which doesn't support
MTRR.

The reason for this coupling is, that both, PAT MSR changes and MTRR
changes, require a similar sequence and so full PAT support was added
using the already available MTRR handling.

Xen PV PAT handling can work without MTRR, as it just needs to consume
the PAT MSR setting done by the hypervisor without the ability and need
to change it. This in turn has resulted in a convoluted initialization
sequence and wrong decisions regarding cache mode availability due to
misguiding PAT availability flags.

Fix all of that by allowing to use PAT without MTRR and by reworking
the current PAT initialization sequence to match better with the newly
introduced generic cache initialization.

This removes the need of the recently added pat_force_disabled flag, so
remove the remnants of the patch adding it.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- former patch 3 completely reworked
---
 arch/x86/include/asm/memtype.h  |   5 +-
 arch/x86/kernel/cpu/cacheinfo.c |   3 +-
 arch/x86/kernel/cpu/mtrr/mtrr.c |  12 +--
 arch/x86/kernel/setup.c         |  13 +---
 arch/x86/mm/pat/memtype.c       | 127 ++++++++++----------------------
 5 files changed, 45 insertions(+), 115 deletions(-)

diff --git a/arch/x86/include/asm/memtype.h b/arch/x86/include/asm/memtype.h
index 9ca760e430b9..113b2fa51849 100644
--- a/arch/x86/include/asm/memtype.h
+++ b/arch/x86/include/asm/memtype.h
@@ -6,9 +6,8 @@
 #include <asm/pgtable_types.h>
 
 extern bool pat_enabled(void);
-extern void pat_disable(const char *reason);
-extern void pat_init(void);
-extern void init_cache_modes(void);
+extern void pat_bp_init(void);
+extern void pat_cpu_init(void);
 
 extern int memtype_reserve(u64 start, u64 end,
 		enum page_cache_mode req_pcm, enum page_cache_mode *ret_pcm);
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 5867325809a6..40c304314513 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -1133,7 +1133,7 @@ static void cache_cpu_init(void)
 		mtrr_generic_set_state();
 
 	if (memory_caching_control & CACHE_PAT)
-		pat_init();
+		pat_cpu_init();
 
 	cache_enable();
 	local_irq_restore(flags);
@@ -1157,6 +1157,7 @@ static int cache_rendezvous_handler(void *unused)
 void __init cache_bp_init(void)
 {
 	mtrr_bp_init();
+	pat_bp_init();
 
 	if (memory_caching_control)
 		cache_cpu_init();
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 61666931abc4..1b652fa768a6 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -721,7 +721,7 @@ void __init mtrr_bp_init(void)
 		if (mtrr_if == &generic_mtrr_ops) {
 			/* BIOS may override */
 			if (get_mtrr_state()) {
-				memory_caching_control |= CACHE_MTRR | CACHE_PAT;
+				memory_caching_control |= CACHE_MTRR;
 				changed_by_mtrr_cleanup = mtrr_cleanup(phys_addr);
 			} else {
 				mtrr_if = NULL;
@@ -729,16 +729,8 @@ void __init mtrr_bp_init(void)
 		}
 	}
 
-	if (!mtrr_if) {
+	if (!mtrr_if)
 		pr_info("Disabled\n");
-
-		/*
-		 * PAT initialization relies on MTRR's rendezvous handler.
-		 * Skip PAT init until the handler can initialize both
-		 * features independently.
-		 */
-		pat_disable("MTRRs disabled, skipping PAT initialization too.");
-	}
 }
 
 /**
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index e0e185ee0229..aacaa96f0195 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1075,23 +1075,12 @@ void __init setup_arch(char **cmdline_p)
 	max_pfn = e820__end_of_ram_pfn();
 
 	/* update e820 for memory not covered by WB MTRRs */
-	if (IS_ENABLED(CONFIG_MTRR))
-		cache_bp_init();
-	else
-		pat_disable("PAT support disabled because CONFIG_MTRR is disabled in the kernel.");
-
+	cache_bp_init();
 	if (mtrr_trim_uncached_memory(max_pfn))
 		max_pfn = e820__end_of_ram_pfn();
 
 	max_possible_pfn = max_pfn;
 
-	/*
-	 * This call is required when the CPU does not support PAT. If
-	 * mtrr_bp_init() invoked it already via pat_init() the call has no
-	 * effect.
-	 */
-	init_cache_modes();
-
 	/*
 	 * Define random base addresses for memory sections after max_pfn is
 	 * defined and before each memory section base is used.
diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 66a209f7eb86..ce1f3246a3e3 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -43,6 +43,7 @@
 #include <linux/rbtree.h>
 
 #include <asm/cacheflush.h>
+#include <asm/cacheinfo.h>
 #include <asm/processor.h>
 #include <asm/tlbflush.h>
 #include <asm/x86_init.h>
@@ -60,41 +61,34 @@
 #undef pr_fmt
 #define pr_fmt(fmt) "" fmt
 
-static bool __read_mostly pat_bp_initialized;
 static bool __read_mostly pat_disabled = !IS_ENABLED(CONFIG_X86_PAT);
-static bool __initdata pat_force_disabled = !IS_ENABLED(CONFIG_X86_PAT);
-static bool __read_mostly pat_bp_enabled;
-static bool __read_mostly pat_cm_initialized;
+static u64 __read_mostly pat_msr_val;
 
 /*
  * PAT support is enabled by default, but can be disabled for
  * various user-requested or hardware-forced reasons:
  */
-void pat_disable(const char *msg_reason)
+static void __init pat_disable(const char *msg_reason)
 {
 	if (pat_disabled)
 		return;
 
-	if (pat_bp_initialized) {
-		WARN_ONCE(1, "x86/PAT: PAT cannot be disabled after initialization\n");
-		return;
-	}
-
 	pat_disabled = true;
 	pr_info("x86/PAT: %s\n", msg_reason);
+
+	memory_caching_control &= ~CACHE_PAT;
 }
 
 static int __init nopat(char *str)
 {
 	pat_disable("PAT support disabled via boot option.");
-	pat_force_disabled = true;
 	return 0;
 }
 early_param("nopat", nopat);
 
 bool pat_enabled(void)
 {
-	return pat_bp_enabled;
+	return !pat_disabled;
 }
 EXPORT_SYMBOL_GPL(pat_enabled);
 
@@ -192,7 +186,8 @@ enum {
 
 #define CM(c) (_PAGE_CACHE_MODE_ ## c)
 
-static enum page_cache_mode pat_get_cache_mode(unsigned pat_val, char *msg)
+static enum page_cache_mode __init pat_get_cache_mode(unsigned int pat_val,
+						      char *msg)
 {
 	enum page_cache_mode cache;
 	char *cache_mode;
@@ -219,14 +214,12 @@ static enum page_cache_mode pat_get_cache_mode(unsigned pat_val, char *msg)
  * configuration.
  * Using lower indices is preferred, so we start with highest index.
  */
-static void __init_cache_modes(u64 pat)
+static void __init init_cache_modes(u64 pat)
 {
 	enum page_cache_mode cache;
 	char pat_msg[33];
 	int i;
 
-	WARN_ON_ONCE(pat_cm_initialized);
-
 	pat_msg[32] = 0;
 	for (i = 7; i >= 0; i--) {
 		cache = pat_get_cache_mode((pat >> (i * 8)) & 7,
@@ -234,34 +227,11 @@ static void __init_cache_modes(u64 pat)
 		update_cache_mode_entry(i, cache);
 	}
 	pr_info("x86/PAT: Configuration [0-7]: %s\n", pat_msg);
-
-	pat_cm_initialized = true;
 }
 
 #define PAT(x, y)	((u64)PAT_ ## y << ((x)*8))
 
-static void pat_bp_init(u64 pat)
-{
-	u64 tmp_pat;
-
-	if (!boot_cpu_has(X86_FEATURE_PAT)) {
-		pat_disable("PAT not supported by the CPU.");
-		return;
-	}
-
-	rdmsrl(MSR_IA32_CR_PAT, tmp_pat);
-	if (!tmp_pat) {
-		pat_disable("PAT support disabled by the firmware.");
-		return;
-	}
-
-	wrmsrl(MSR_IA32_CR_PAT, pat);
-	pat_bp_enabled = true;
-
-	__init_cache_modes(pat);
-}
-
-static void pat_ap_init(u64 pat)
+void pat_cpu_init(void)
 {
 	if (!boot_cpu_has(X86_FEATURE_PAT)) {
 		/*
@@ -271,30 +241,35 @@ static void pat_ap_init(u64 pat)
 		panic("x86/PAT: PAT enabled, but not supported by secondary CPU\n");
 	}
 
-	wrmsrl(MSR_IA32_CR_PAT, pat);
+	wrmsrl(MSR_IA32_CR_PAT, pat_msr_val);
 }
 
-void __init init_cache_modes(void)
+/**
+ * pat_bp_init - Initialize the PAT MSR value and PAT table
+ *
+ * This function initializes PAT MSR value and PAT table with an OS-defined
+ * value to enable additional cache attributes, WC, WT and WP.
+ *
+ * This function prepares the calls of pat_cpu_init() via cache_cpu_init()
+ * on all cpus.
+ */
+void __init pat_bp_init(void)
 {
+	struct cpuinfo_x86 *c = &boot_cpu_data;
 	u64 pat = 0;
 
-	if (pat_cm_initialized)
-		return;
+#ifndef CONFIG_X86_PAT
+	pr_info_once("x86/PAT: PAT support disabled because CONFIG_X86_PAT is disabled in the kernel.\n");
+#endif
 
-	if (boot_cpu_has(X86_FEATURE_PAT)) {
-		/*
-		 * CPU supports PAT. Set PAT table to be consistent with
-		 * PAT MSR. This case supports "nopat" boot option, and
-		 * virtual machine environments which support PAT without
-		 * MTRRs. In specific, Xen has unique setup to PAT MSR.
-		 *
-		 * If PAT MSR returns 0, it is considered invalid and emulates
-		 * as No PAT.
-		 */
+	if (!boot_cpu_has(X86_FEATURE_PAT))
+		pat_disable("PAT not supported by the CPU.");
+	else
 		rdmsrl(MSR_IA32_CR_PAT, pat);
-	}
 
 	if (!pat) {
+		pat_disable("PAT support disabled by the firmware.");
+
 		/*
 		 * No PAT. Emulate the PAT table that corresponds to the two
 		 * cache bits, PWT (Write Through) and PCD (Cache Disable).
@@ -315,38 +290,14 @@ void __init init_cache_modes(void)
 		 */
 		pat = PAT(0, WB) | PAT(1, WT) | PAT(2, UC_MINUS) | PAT(3, UC) |
 		      PAT(4, WB) | PAT(5, WT) | PAT(6, UC_MINUS) | PAT(7, UC);
-	} else if (!pat_force_disabled && cpu_feature_enabled(X86_FEATURE_HYPERVISOR)) {
-		/*
-		 * Clearly PAT is enabled underneath. Allow pat_enabled() to
-		 * reflect this.
-		 */
-		pat_bp_enabled = true;
 	}
 
-	__init_cache_modes(pat);
-}
-
-/**
- * pat_init - Initialize the PAT MSR and PAT table on the current CPU
- *
- * This function initializes PAT MSR and PAT table with an OS-defined value
- * to enable additional cache attributes, WC, WT and WP.
- *
- * This function must be called on all CPUs using the specific sequence of
- * operations defined in Intel SDM. mtrr_rendezvous_handler() provides this
- * procedure for PAT.
- */
-void pat_init(void)
-{
-	u64 pat;
-	struct cpuinfo_x86 *c = &boot_cpu_data;
-
-#ifndef CONFIG_X86_PAT
-	pr_info_once("x86/PAT: PAT support disabled because CONFIG_X86_PAT is disabled in the kernel.\n");
-#endif
+	/* Xen PV doesn't allow to set PAT MSR, but all cache modes are fine. */
+	if (pat_disabled || cpu_feature_enabled(X86_FEATURE_XENPV)) {
+		init_cache_modes(pat);
 
-	if (pat_disabled)
 		return;
+	}
 
 	if ((c->x86_vendor == X86_VENDOR_INTEL) &&
 	    (((c->x86 == 0x6) && (c->x86_model <= 0xd)) ||
@@ -404,12 +355,10 @@ void pat_init(void)
 		      PAT(4, WB) | PAT(5, WP) | PAT(6, UC_MINUS) | PAT(7, WT);
 	}
 
-	if (!pat_bp_initialized) {
-		pat_bp_init(pat);
-		pat_bp_initialized = true;
-	} else {
-		pat_ap_init(pat);
-	}
+	pat_msr_val = pat;
+	memory_caching_control |= CACHE_PAT;
+
+	init_cache_modes(pat);
 }
 
 #undef PAT
-- 
2.35.3

