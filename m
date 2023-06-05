Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DAD722864
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbjFEOJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbjFEOIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:08:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62130E56;
        Mon,  5 Jun 2023 07:08:20 -0700 (PDT)
Date:   Mon, 05 Jun 2023 14:08:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685974098;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bj5n/9FycideN6LU31c0B+GZeQ9PsxS1vDH3fWVWczY=;
        b=XJO4GVwk+YQeD9zvB2g9Mv/NBkPBQI/tq/N1Wi6IC2kxOSy7wA/weigIJGM3d5FAwcffMB
        5ZFMQK94BokzCfuaELb22KK+sam+lo1UhBcj9DllnpHZJ+EiGseg/HLwQPwJ3uCyDOKCZb
        Qr1KzYtCaNCXPmwuC72OjFFbOoWZc+E4syLOcUVnZ2vmUVKuAHh7Y7/b6OLhezA2BI4aAK
        x0g3aMD3k3/teR8MmWXcgARJUq8k03amXrS+pbE9JsEaiUpAnA0aATZD9nWzATmqeGfm4W
        JeK7E458n4TUos06xA8AyJkia2P8R7p2ilJtgRkvnbeMf6L265szLk2gN65Qrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685974098;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bj5n/9FycideN6LU31c0B+GZeQ9PsxS1vDH3fWVWczY=;
        b=2NMsi91AZCjxi90JBMn97Vzqx3SO8C0uV9MyCR7NB4p9RdU6Yhts1nuo2mv+TkJad4EL8q
        jemN1kCkwRFSjQDg==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mtrr] x86/mtrr: Remove physical address size calculation
Cc:     Juergen Gross <jgross@suse.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Michael Kelley <mikelley@microsoft.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230502120931.20719-2-jgross@suse.com>
References: <20230502120931.20719-2-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <168597409795.404.3288881453243222973.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mtrr branch of tip:

Commit-ID:     f6b980646b93a8c585b4ed991b8a34e8fc6ef847
Gitweb:        https://git.kernel.org/tip/f6b980646b93a8c585b4ed991b8a34e8fc6ef847
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Tue, 02 May 2023 14:09:16 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 09 May 2023 14:13:30 +02:00

x86/mtrr: Remove physical address size calculation

The physical address width calculation in mtrr_bp_init() can easily be
replaced with using the already available value x86_phys_bits from
struct cpuinfo_x86.

The same information source can be used in mtrr/cleanup.c, removing the
need to pass that value on to mtrr_cleanup().

In print_mtrr_state() use x86_phys_bits instead of recalculating it
from size_or_mask.

Move setting of size_or_mask and size_and_mask into a dedicated new
function in mtrr/generic.c, enabling to make those 2 variables static,
as they are used in generic.c only now.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Link: https://lore.kernel.org/r/20230502120931.20719-2-jgross@suse.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/mtrr/cleanup.c | 16 ++++----
 arch/x86/kernel/cpu/mtrr/generic.c | 12 +++++-
 arch/x86/kernel/cpu/mtrr/mtrr.c    | 61 +++--------------------------
 arch/x86/kernel/cpu/mtrr/mtrr.h    |  4 +-
 4 files changed, 29 insertions(+), 64 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/cleanup.c b/arch/x86/kernel/cpu/mtrr/cleanup.c
index b5f4304..7031409 100644
--- a/arch/x86/kernel/cpu/mtrr/cleanup.c
+++ b/arch/x86/kernel/cpu/mtrr/cleanup.c
@@ -173,7 +173,7 @@ early_param("mtrr_cleanup_debug", mtrr_cleanup_debug_setup);
 
 static void __init
 set_var_mtrr(unsigned int reg, unsigned long basek, unsigned long sizek,
-	     unsigned char type, unsigned int address_bits)
+	     unsigned char type)
 {
 	u32 base_lo, base_hi, mask_lo, mask_hi;
 	u64 base, mask;
@@ -183,7 +183,7 @@ set_var_mtrr(unsigned int reg, unsigned long basek, unsigned long sizek,
 		return;
 	}
 
-	mask = (1ULL << address_bits) - 1;
+	mask = (1ULL << boot_cpu_data.x86_phys_bits) - 1;
 	mask &= ~((((u64)sizek) << 10) - 1);
 
 	base = ((u64)basek) << 10;
@@ -209,7 +209,7 @@ save_var_mtrr(unsigned int reg, unsigned long basek, unsigned long sizek,
 	range_state[reg].type = type;
 }
 
-static void __init set_var_mtrr_all(unsigned int address_bits)
+static void __init set_var_mtrr_all(void)
 {
 	unsigned long basek, sizek;
 	unsigned char type;
@@ -220,7 +220,7 @@ static void __init set_var_mtrr_all(unsigned int address_bits)
 		sizek = range_state[reg].size_pfn << (PAGE_SHIFT - 10);
 		type = range_state[reg].type;
 
-		set_var_mtrr(reg, basek, sizek, type, address_bits);
+		set_var_mtrr(reg, basek, sizek, type);
 	}
 }
 
@@ -680,7 +680,7 @@ static int __init mtrr_search_optimal_index(void)
 	return index_good;
 }
 
-int __init mtrr_cleanup(unsigned address_bits)
+int __init mtrr_cleanup(void)
 {
 	unsigned long x_remove_base, x_remove_size;
 	unsigned long base, size, def, dummy;
@@ -742,7 +742,7 @@ int __init mtrr_cleanup(unsigned address_bits)
 		mtrr_print_out_one_result(i);
 
 		if (!result[i].bad) {
-			set_var_mtrr_all(address_bits);
+			set_var_mtrr_all();
 			pr_debug("New variable MTRRs\n");
 			print_out_mtrr_range_state();
 			return 1;
@@ -786,7 +786,7 @@ int __init mtrr_cleanup(unsigned address_bits)
 		gran_size = result[i].gran_sizek;
 		gran_size <<= 10;
 		x86_setup_var_mtrrs(range, nr_range, chunk_size, gran_size);
-		set_var_mtrr_all(address_bits);
+		set_var_mtrr_all();
 		pr_debug("New variable MTRRs\n");
 		print_out_mtrr_range_state();
 		return 1;
@@ -802,7 +802,7 @@ int __init mtrr_cleanup(unsigned address_bits)
 	return 0;
 }
 #else
-int __init mtrr_cleanup(unsigned address_bits)
+int __init mtrr_cleanup(void)
 {
 	return 0;
 }
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index ee09d35..3922552 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -38,6 +38,16 @@ u64 mtrr_tom2;
 struct mtrr_state_type mtrr_state;
 EXPORT_SYMBOL_GPL(mtrr_state);
 
+static u64 size_or_mask, size_and_mask;
+
+void __init mtrr_set_mask(void)
+{
+	unsigned int phys_addr = boot_cpu_data.x86_phys_bits;
+
+	size_or_mask = ~GENMASK_ULL(phys_addr - PAGE_SHIFT - 1, 0);
+	size_and_mask = ~size_or_mask & GENMASK_ULL(39, 20);
+}
+
 /*
  * BIOS is expected to clear MtrrFixDramModEn bit, see for example
  * "BIOS and Kernel Developer's Guide for the AMD Athlon 64 and AMD
@@ -422,7 +432,7 @@ static void __init print_mtrr_state(void)
 	}
 	pr_debug("MTRR variable ranges %sabled:\n",
 		 mtrr_state.enabled & MTRR_STATE_MTRR_ENABLED ? "en" : "dis");
-	high_width = (__ffs64(size_or_mask) - (32 - PAGE_SHIFT) + 3) / 4;
+	high_width = (boot_cpu_data.x86_phys_bits - (32 - PAGE_SHIFT) + 3) / 4;
 
 	for (i = 0; i < num_var_ranges; ++i) {
 		if (mtrr_state.var_ranges[i].mask_lo & (1 << 11))
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 783f321..1bdab16 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -67,8 +67,6 @@ static bool mtrr_enabled(void)
 unsigned int mtrr_usage_table[MTRR_MAX_VAR_RANGES];
 static DEFINE_MUTEX(mtrr_mutex);
 
-u64 size_or_mask, size_and_mask;
-
 const struct mtrr_ops *mtrr_if;
 
 /*  Returns non-zero if we have the write-combining memory type  */
@@ -619,77 +617,34 @@ static struct syscore_ops mtrr_syscore_ops = {
 
 int __initdata changed_by_mtrr_cleanup;
 
-#define SIZE_OR_MASK_BITS(n)  (~((1ULL << ((n) - PAGE_SHIFT)) - 1))
 /**
- * mtrr_bp_init - initialize mtrrs on the boot CPU
+ * mtrr_bp_init - initialize MTRRs on the boot CPU
  *
  * This needs to be called early; before any of the other CPUs are
  * initialized (i.e. before smp_init()).
- *
  */
 void __init mtrr_bp_init(void)
 {
 	const char *why = "(not available)";
-	u32 phys_addr;
 
-	phys_addr = 32;
+	mtrr_set_mask();
 
-	if (boot_cpu_has(X86_FEATURE_MTRR)) {
+	if (cpu_feature_enabled(X86_FEATURE_MTRR)) {
 		mtrr_if = &generic_mtrr_ops;
-		size_or_mask = SIZE_OR_MASK_BITS(36);
-		size_and_mask = 0x00f00000;
-		phys_addr = 36;
-
-		/*
-		 * This is an AMD specific MSR, but we assume(hope?) that
-		 * Intel will implement it too when they extend the address
-		 * bus of the Xeon.
-		 */
-		if (cpuid_eax(0x80000000) >= 0x80000008) {
-			phys_addr = cpuid_eax(0x80000008) & 0xff;
-			/* CPUID workaround for Intel 0F33/0F34 CPU */
-			if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
-			    boot_cpu_data.x86 == 0xF &&
-			    boot_cpu_data.x86_model == 0x3 &&
-			    (boot_cpu_data.x86_stepping == 0x3 ||
-			     boot_cpu_data.x86_stepping == 0x4))
-				phys_addr = 36;
-
-			size_or_mask = SIZE_OR_MASK_BITS(phys_addr);
-			size_and_mask = ~size_or_mask & 0xfffff00000ULL;
-		} else if (boot_cpu_data.x86_vendor == X86_VENDOR_CENTAUR &&
-			   boot_cpu_data.x86 == 6) {
-			/*
-			 * VIA C* family have Intel style MTRRs,
-			 * but don't support PAE
-			 */
-			size_or_mask = SIZE_OR_MASK_BITS(32);
-			size_and_mask = 0;
-			phys_addr = 32;
-		}
 	} else {
 		switch (boot_cpu_data.x86_vendor) {
 		case X86_VENDOR_AMD:
-			if (cpu_feature_enabled(X86_FEATURE_K6_MTRR)) {
-				/* Pre-Athlon (K6) AMD CPU MTRRs */
+			/* Pre-Athlon (K6) AMD CPU MTRRs */
+			if (cpu_feature_enabled(X86_FEATURE_K6_MTRR))
 				mtrr_if = &amd_mtrr_ops;
-				size_or_mask = SIZE_OR_MASK_BITS(32);
-				size_and_mask = 0;
-			}
 			break;
 		case X86_VENDOR_CENTAUR:
-			if (cpu_feature_enabled(X86_FEATURE_CENTAUR_MCR)) {
+			if (cpu_feature_enabled(X86_FEATURE_CENTAUR_MCR))
 				mtrr_if = &centaur_mtrr_ops;
-				size_or_mask = SIZE_OR_MASK_BITS(32);
-				size_and_mask = 0;
-			}
 			break;
 		case X86_VENDOR_CYRIX:
-			if (cpu_feature_enabled(X86_FEATURE_CYRIX_ARR)) {
+			if (cpu_feature_enabled(X86_FEATURE_CYRIX_ARR))
 				mtrr_if = &cyrix_mtrr_ops;
-				size_or_mask = SIZE_OR_MASK_BITS(32);
-				size_and_mask = 0;
-			}
 			break;
 		default:
 			break;
@@ -703,7 +658,7 @@ void __init mtrr_bp_init(void)
 			/* BIOS may override */
 			if (get_mtrr_state()) {
 				memory_caching_control |= CACHE_MTRR;
-				changed_by_mtrr_cleanup = mtrr_cleanup(phys_addr);
+				changed_by_mtrr_cleanup = mtrr_cleanup();
 			} else {
 				mtrr_if = NULL;
 				why = "by BIOS";
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.h b/arch/x86/kernel/cpu/mtrr/mtrr.h
index 02eb587..a00987e 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.h
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.h
@@ -51,7 +51,6 @@ void fill_mtrr_var_range(unsigned int index,
 		u32 base_lo, u32 base_hi, u32 mask_lo, u32 mask_hi);
 bool get_mtrr_state(void);
 
-extern u64 size_or_mask, size_and_mask;
 extern const struct mtrr_ops *mtrr_if;
 
 #define is_cpu(vnd)	(mtrr_if && mtrr_if->vendor == X86_VENDOR_##vnd)
@@ -60,6 +59,7 @@ extern unsigned int num_var_ranges;
 extern u64 mtrr_tom2;
 extern struct mtrr_state_type mtrr_state;
 
+void mtrr_set_mask(void);
 void mtrr_state_warn(void);
 const char *mtrr_attrib_to_str(int x);
 void mtrr_wrmsr(unsigned, unsigned, unsigned);
@@ -70,4 +70,4 @@ extern const struct mtrr_ops cyrix_mtrr_ops;
 extern const struct mtrr_ops centaur_mtrr_ops;
 
 extern int changed_by_mtrr_cleanup;
-extern int mtrr_cleanup(unsigned address_bits);
+extern int mtrr_cleanup(void);
