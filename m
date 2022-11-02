Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94E6615D29
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 08:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiKBHtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 03:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiKBHsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 03:48:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3A32612B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 00:48:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6A0B91F8B0;
        Wed,  2 Nov 2022 07:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667375309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R10C4rCtq1ivY+IhxBh2ebzergfYAXSfqeTMWrGpHUU=;
        b=qZQZ0JcdkHpjwpSv3z1bF5ehq6gHqILX5N8Vbq8iXlMOAa+LIawMaBw6ksJlv/nGRZE22P
        FSE+oowEBloJhkwhaad3tO4V18zCI1uRxrvU73huJqz7+a3Lt1hvwcWhV6F7wy2FzyH+Xw
        sp3IHVCmEwTHpuzXZU4CI7aZbv5DiGY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 224DE1376E;
        Wed,  2 Nov 2022 07:48:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /UczB80gYmM3cwAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 02 Nov 2022 07:48:29 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v5 13/16] x86: decouple PAT and MTRR handling
Date:   Wed,  2 Nov 2022 08:47:10 +0100
Message-Id: <20221102074713.21493-14-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221102074713.21493-1-jgross@suse.com>
References: <20221102074713.21493-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
V5:
- rework PAT() macro
- drop local pat variable (Borislav Petkov)
- use cpu_feature_enabled() (Borislav Petkov)
- some more minor adjustments (Borislav Petkov)
---
 arch/x86/include/asm/memtype.h  |   5 +-
 arch/x86/kernel/cpu/cacheinfo.c |   3 +-
 arch/x86/kernel/cpu/mtrr/mtrr.c |  12 +--
 arch/x86/kernel/setup.c         |  13 +--
 arch/x86/mm/pat/memtype.c       | 152 +++++++++++---------------------
 5 files changed, 57 insertions(+), 128 deletions(-)

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
index a92099569617..1aaf830254df 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -1133,7 +1133,7 @@ static void cache_cpu_init(void)
 		mtrr_generic_set_state();
 
 	if (memory_caching_control & CACHE_PAT)
-		pat_init();
+		pat_cpu_init();
 
 	cache_enable();
 	local_irq_restore(flags);
@@ -1162,6 +1162,7 @@ static int cache_rendezvous_handler(void *unused)
 void __init cache_bp_init(void)
 {
 	mtrr_bp_init();
+	pat_bp_init();
 
 	if (memory_caching_control)
 		cache_cpu_init();
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 99b6973a69b4..8403daf34158 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -725,7 +725,7 @@ void __init mtrr_bp_init(void)
 		if (mtrr_if == &generic_mtrr_ops) {
 			/* BIOS may override */
 			if (get_mtrr_state()) {
-				memory_caching_control |= CACHE_MTRR | CACHE_PAT;
+				memory_caching_control |= CACHE_MTRR;
 				changed_by_mtrr_cleanup = mtrr_cleanup(phys_addr);
 			} else {
 				mtrr_if = NULL;
@@ -733,16 +733,8 @@ void __init mtrr_bp_init(void)
 		}
 	}
 
-	if (!mtrr_enabled()) {
+	if (!mtrr_enabled())
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
index 66a209f7eb86..9aab17d660cd 100644
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
+static u64 __ro_after_init pat_msr_val;
 
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
@@ -234,34 +227,9 @@ static void __init_cache_modes(u64 pat)
 		update_cache_mode_entry(i, cache);
 	}
 	pr_info("x86/PAT: Configuration [0-7]: %s\n", pat_msg);
-
-	pat_cm_initialized = true;
 }
 
-#define PAT(x, y)	((u64)PAT_ ## y << ((x)*8))
-
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
@@ -271,30 +239,39 @@ static void pat_ap_init(u64 pat)
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
+ * on all CPUs.
+ */
+void __init pat_bp_init(void)
 {
-	u64 pat = 0;
+	struct cpuinfo_x86 *c = &boot_cpu_data;
+#define PAT(p0, p1, p2, p3, p4, p5, p6, p7)			\
+	(((u64)PAT_ ## p0) | ((u64)PAT_ ## p1 << 8) |		\
+	((u64)PAT_ ## p2 << 16) | ((u64)PAT_ ## p3 << 24) |	\
+	((u64)PAT_ ## p4 << 32) | ((u64)PAT_ ## p5 << 40) |	\
+	((u64)PAT_ ## p6 << 48) | ((u64)PAT_ ## p7 << 56))
 
-	if (pat_cm_initialized)
-		return;
 
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
-		rdmsrl(MSR_IA32_CR_PAT, pat);
-	}
+	if (!IS_ENABLED(CONFIG_X86_PAT))
+		pr_info_once("x86/PAT: PAT support disabled because CONFIG_X86_PAT is disabled in the kernel.\n");
+
+	if (!cpu_feature_enabled(X86_FEATURE_PAT))
+		pat_disable("PAT not supported by the CPU.");
+	else
+		rdmsrl(MSR_IA32_CR_PAT, pat_msr_val);
+
+	if (!pat_msr_val) {
+		pat_disable("PAT support disabled by the firmware.");
 
-	if (!pat) {
 		/*
 		 * No PAT. Emulate the PAT table that corresponds to the two
 		 * cache bits, PWT (Write Through) and PCD (Cache Disable).
@@ -313,40 +290,17 @@ void __init init_cache_modes(void)
 		 * NOTE: When WC or WP is used, it is redirected to UC- per
 		 * the default setup in __cachemode2pte_tbl[].
 		 */
-		pat = PAT(0, WB) | PAT(1, WT) | PAT(2, UC_MINUS) | PAT(3, UC) |
-		      PAT(4, WB) | PAT(5, WT) | PAT(6, UC_MINUS) | PAT(7, UC);
-	} else if (!pat_force_disabled && cpu_feature_enabled(X86_FEATURE_HYPERVISOR)) {
-		/*
-		 * Clearly PAT is enabled underneath. Allow pat_enabled() to
-		 * reflect this.
-		 */
-		pat_bp_enabled = true;
+		pat_msr_val = PAT(WB, WT, UC_MINUS, UC, WB, WT, UC_MINUS, UC);
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
-
-	if (pat_disabled)
+	/*
+	 * Xen PV doesn't allow to set PAT MSR, but all cache modes are
+	 * supported.
+	 */
+	if (pat_disabled || cpu_feature_enabled(X86_FEATURE_XENPV)) {
+		init_cache_modes(pat_msr_val);
 		return;
+	}
 
 	if ((c->x86_vendor == X86_VENDOR_INTEL) &&
 	    (((c->x86 == 0x6) && (c->x86_model <= 0xd)) ||
@@ -371,8 +325,7 @@ void pat_init(void)
 		 * NOTE: When WT or WP is used, it is redirected to UC- per
 		 * the default setup in __cachemode2pte_tbl[].
 		 */
-		pat = PAT(0, WB) | PAT(1, WC) | PAT(2, UC_MINUS) | PAT(3, UC) |
-		      PAT(4, WB) | PAT(5, WC) | PAT(6, UC_MINUS) | PAT(7, UC);
+		pat_msr_val = PAT(WB, WC, UC_MINUS, UC, WB, WC, UC_MINUS, UC);
 	} else {
 		/*
 		 * Full PAT support.  We put WT in slot 7 to improve
@@ -400,19 +353,14 @@ void pat_init(void)
 		 * The reserved slots are unused, but mapped to their
 		 * corresponding types in the presence of PAT errata.
 		 */
-		pat = PAT(0, WB) | PAT(1, WC) | PAT(2, UC_MINUS) | PAT(3, UC) |
-		      PAT(4, WB) | PAT(5, WP) | PAT(6, UC_MINUS) | PAT(7, WT);
+		pat_msr_val = PAT(WB, WC, UC_MINUS, UC, WB, WP, UC_MINUS, WT);
 	}
 
-	if (!pat_bp_initialized) {
-		pat_bp_init(pat);
-		pat_bp_initialized = true;
-	} else {
-		pat_ap_init(pat);
-	}
-}
+	memory_caching_control |= CACHE_PAT;
 
+	init_cache_modes(pat_msr_val);
 #undef PAT
+}
 
 static DEFINE_SPINLOCK(memtype_lock);	/* protects memtype accesses */
 
-- 
2.35.3

