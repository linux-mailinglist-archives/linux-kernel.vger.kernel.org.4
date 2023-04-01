Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88886D2EAA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 08:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbjDAGh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 02:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbjDAGhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 02:37:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB071EFE6
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 23:37:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 80F721F8B9;
        Sat,  1 Apr 2023 06:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680331032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5tBXsp0muXYt38fiqF48mI0NM1nAHxNxMRiNpwrq0p8=;
        b=pkYfCnFpOH8pZGbqSy25hweqcgFa7lM80kv9hgtSwJUFq5u3pGem/fY9+Bf7EHSa57sdRQ
        oxc6OfCjN5TMskB5pdc7I13Pnqi+L6R5CmsF2qCWRbcNrqzUsfYrW2kYP58o9BftSGQBhQ
        KmuYJWeRZ6AHvUop0MKuYTrW5bUeUuw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 437D4134FB;
        Sat,  1 Apr 2023 06:37:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nyXhDhjRJ2QjdwAAMHmgww
        (envelope-from <jgross@suse.com>); Sat, 01 Apr 2023 06:37:12 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v5 03/15] x86/mtrr: replace some constants with defines
Date:   Sat,  1 Apr 2023 08:36:40 +0200
Message-Id: <20230401063652.23522-4-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230401063652.23522-1-jgross@suse.com>
References: <20230401063652.23522-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using constants in MTRR code, use some new #defines.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V5:
- new patch (inspired by a request of Boris Petkov)
---
 arch/x86/include/asm/mtrr.h        | 25 +++++++++++++--
 arch/x86/kernel/cpu/mtrr/cleanup.c |  2 +-
 arch/x86/kernel/cpu/mtrr/generic.c | 51 +++++++++++++++++-------------
 arch/x86/kernel/cpu/mtrr/mtrr.c    |  2 +-
 4 files changed, 54 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index f0eeaf6e5f5f..4e59f7854950 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -23,8 +23,26 @@
 #ifndef _ASM_X86_MTRR_H
 #define _ASM_X86_MTRR_H
 
+#include <linux/bits.h>
 #include <uapi/asm/mtrr.h>
 
+/* Defines for hardware MTRR registers. */
+#define MTRR_CONFIG_NUM_VAR_MASK	GENMASK(7, 0)
+#define MTRR_CONFIG_HAVE_FIXED		BIT_MASK(8)
+#define MTRR_CONFIG_HAVE_WC		BIT_MASK(10)
+
+#define MTRR_DEFTYPE_TYPE_MASK		GENMASK(7, 0)
+#define MTRR_DEFTYPE_FIXED_ENABLED	BIT_MASK(10)
+#define MTRR_DEFTYPE_ENABLED		BIT_MASK(11)
+#define MTRR_DEFTYPE_ENABLE_MASK	(MTRR_DEFTYPE_FIXED_ENABLED |	\
+					 MTRR_DEFTYPE_ENABLED)
+#define MTRR_DEFTYPE_DISABLE_MASK	~(MTRR_DEFTYPE_TYPE_MASK |	\
+					  MTRR_DEFTYPE_ENABLE_MASK)
+
+#define MTRR_BASE_TYPE_MASK		GENMASK_ULL(7, 0)
+
+#define MTRR_MASK_VALID			BIT_ULL_MASK(11)
+
 /*
  * The following functions are for use by other drivers that cannot use
  * arch_phys_wc_add and arch_phys_wc_del.
@@ -121,7 +139,10 @@ struct mtrr_gentry32 {
 #endif /* CONFIG_COMPAT */
 
 /* Bit fields for enabled in struct mtrr_state_type */
-#define MTRR_STATE_MTRR_FIXED_ENABLED	0x01
-#define MTRR_STATE_MTRR_ENABLED		0x02
+#define MTRR_STATE_SHIFT		10
+#define MTRR_STATE_MTRR_FIXED_ENABLED	\
+			(MTRR_DEFTYPE_FIXED_ENABLED >> MTRR_STATE_SHIFT)
+#define MTRR_STATE_MTRR_ENABLED		\
+			(MTRR_DEFTYPE_ENABLED >> MTRR_STATE_SHIFT)
 
 #endif /* _ASM_X86_MTRR_H */
diff --git a/arch/x86/kernel/cpu/mtrr/cleanup.c b/arch/x86/kernel/cpu/mtrr/cleanup.c
index b5f43049fa5f..ce45d7617874 100644
--- a/arch/x86/kernel/cpu/mtrr/cleanup.c
+++ b/arch/x86/kernel/cpu/mtrr/cleanup.c
@@ -890,7 +890,7 @@ int __init mtrr_trim_uncached_memory(unsigned long end_pfn)
 		return 0;
 
 	rdmsr(MSR_MTRRdefType, def, dummy);
-	def &= 0xff;
+	def &= MTRR_DEFTYPE_TYPE_MASK;
 	if (def != MTRR_TYPE_UNCACHABLE)
 		return 0;
 
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index ee09d359e08f..9a12da76635c 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -171,7 +171,7 @@ static u8 mtrr_type_lookup_variable(u64 start, u64 end, u64 *partial_end,
 	for (i = 0; i < num_var_ranges; ++i) {
 		unsigned short start_state, end_state, inclusive;
 
-		if (!(mtrr_state.var_ranges[i].mask_lo & (1 << 11)))
+		if (!(mtrr_state.var_ranges[i].mask_lo & MTRR_MASK_VALID))
 			continue;
 
 		base = (((u64)mtrr_state.var_ranges[i].base_hi) << 32) +
@@ -223,7 +223,8 @@ static u8 mtrr_type_lookup_variable(u64 start, u64 end, u64 *partial_end,
 		if ((start & mask) != (base & mask))
 			continue;
 
-		curr_match = mtrr_state.var_ranges[i].base_lo & 0xff;
+		curr_match = mtrr_state.var_ranges[i].base_lo &
+			     MTRR_BASE_TYPE_MASK;
 		if (prev_match == MTRR_TYPE_INVALID) {
 			prev_match = curr_match;
 			continue;
@@ -425,7 +426,7 @@ static void __init print_mtrr_state(void)
 	high_width = (__ffs64(size_or_mask) - (32 - PAGE_SHIFT) + 3) / 4;
 
 	for (i = 0; i < num_var_ranges; ++i) {
-		if (mtrr_state.var_ranges[i].mask_lo & (1 << 11))
+		if (mtrr_state.var_ranges[i].mask_lo & MTRR_MASK_VALID)
 			pr_debug("  %u base %0*X%05X000 mask %0*X%05X000 %s\n",
 				 i,
 				 high_width,
@@ -434,7 +435,8 @@ static void __init print_mtrr_state(void)
 				 high_width,
 				 mtrr_state.var_ranges[i].mask_hi,
 				 mtrr_state.var_ranges[i].mask_lo >> 12,
-				 mtrr_attrib_to_str(mtrr_state.var_ranges[i].base_lo & 0xff));
+				 mtrr_attrib_to_str(mtrr_state.var_ranges[i].base_lo &
+						    MTRR_BASE_TYPE_MASK));
 		else
 			pr_debug("  %u disabled\n", i);
 	}
@@ -452,7 +454,7 @@ bool __init get_mtrr_state(void)
 	vrs = mtrr_state.var_ranges;
 
 	rdmsr(MSR_MTRRcap, lo, dummy);
-	mtrr_state.have_fixed = (lo >> 8) & 1;
+	mtrr_state.have_fixed = !!(lo & MTRR_CONFIG_HAVE_FIXED);
 
 	for (i = 0; i < num_var_ranges; i++)
 		get_mtrr_var_range(i, &vrs[i]);
@@ -460,8 +462,9 @@ bool __init get_mtrr_state(void)
 		get_fixed_ranges(mtrr_state.fixed_ranges);
 
 	rdmsr(MSR_MTRRdefType, lo, dummy);
-	mtrr_state.def_type = (lo & 0xff);
-	mtrr_state.enabled = (lo & 0xc00) >> 10;
+	mtrr_state.def_type = lo & MTRR_DEFTYPE_TYPE_MASK;
+	mtrr_state.enabled = (lo & MTRR_DEFTYPE_ENABLE_MASK) >>
+			     MTRR_STATE_SHIFT;
 
 	if (amd_special_default_mtrr()) {
 		unsigned low, high;
@@ -574,7 +577,7 @@ static void generic_get_mtrr(unsigned int reg, unsigned long *base,
 
 	rdmsr(MTRRphysMask_MSR(reg), mask_lo, mask_hi);
 
-	if ((mask_lo & 0x800) == 0) {
+	if ((mask_lo & MTRR_MASK_VALID) == 0) {
 		/*  Invalid (i.e. free) range */
 		*base = 0;
 		*size = 0;
@@ -606,7 +609,7 @@ static void generic_get_mtrr(unsigned int reg, unsigned long *base,
 	 */
 	*size = -mask;
 	*base = (u64)base_hi << (32 - PAGE_SHIFT) | base_lo >> PAGE_SHIFT;
-	*type = base_lo & 0xff;
+	*type = base_lo & MTRR_BASE_TYPE_MASK;
 
 out_put_cpu:
 	put_cpu();
@@ -643,10 +646,12 @@ static bool set_mtrr_var_ranges(unsigned int index, struct mtrr_var_range *vr)
 	unsigned int lo, hi;
 	bool changed = false;
 
+#define BASE_MASK	(MTRR_BASE_TYPE_MASK | (size_and_mask << PAGE_SHIFT))
+#define MASK_MASK	(MTRR_MASK_VALID | (size_and_mask << PAGE_SHIFT))
+
 	rdmsr(MTRRphysBase_MSR(index), lo, hi);
-	if ((vr->base_lo & 0xfffff0ffUL) != (lo & 0xfffff0ffUL)
-	    || (vr->base_hi & (size_and_mask >> (32 - PAGE_SHIFT))) !=
-		(hi & (size_and_mask >> (32 - PAGE_SHIFT)))) {
+	if ((vr->base_lo & BASE_MASK) != (lo & BASE_MASK)
+	    || (vr->base_hi & (BASE_MASK >> 32)) != (hi & (BASE_MASK >> 32))) {
 
 		mtrr_wrmsr(MTRRphysBase_MSR(index), vr->base_lo, vr->base_hi);
 		changed = true;
@@ -654,9 +659,8 @@ static bool set_mtrr_var_ranges(unsigned int index, struct mtrr_var_range *vr)
 
 	rdmsr(MTRRphysMask_MSR(index), lo, hi);
 
-	if ((vr->mask_lo & 0xfffff800UL) != (lo & 0xfffff800UL)
-	    || (vr->mask_hi & (size_and_mask >> (32 - PAGE_SHIFT))) !=
-		(hi & (size_and_mask >> (32 - PAGE_SHIFT)))) {
+	if ((vr->mask_lo & MASK_MASK) != (lo & MASK_MASK)
+	    || (vr->mask_hi & (MASK_MASK >> 32)) != (hi & (MASK_MASK >> 32))) {
 		mtrr_wrmsr(MTRRphysMask_MSR(index), vr->mask_lo, vr->mask_hi);
 		changed = true;
 	}
@@ -691,11 +695,13 @@ static unsigned long set_mtrr_state(void)
 	 * Set_mtrr_restore restores the old value of MTRRdefType,
 	 * so to set it we fiddle with the saved value:
 	 */
-	if ((deftype_lo & 0xff) != mtrr_state.def_type
-	    || ((deftype_lo & 0xc00) >> 10) != mtrr_state.enabled) {
+	if ((deftype_lo & MTRR_DEFTYPE_TYPE_MASK) != mtrr_state.def_type
+	    || ((deftype_lo & MTRR_DEFTYPE_ENABLE_MASK) >> MTRR_STATE_SHIFT) !=
+	       mtrr_state.enabled) {
 
-		deftype_lo = (deftype_lo & ~0xcff) | mtrr_state.def_type |
-			     (mtrr_state.enabled << 10);
+		deftype_lo = (deftype_lo & MTRR_DEFTYPE_DISABLE_MASK) |
+			     mtrr_state.def_type |
+			     (mtrr_state.enabled << MTRR_STATE_SHIFT);
 		change_mask |= MTRR_CHANGE_MASK_DEFTYPE;
 	}
 
@@ -708,7 +714,8 @@ void mtrr_disable(void)
 	rdmsr(MSR_MTRRdefType, deftype_lo, deftype_hi);
 
 	/* Disable MTRRs, and set the default type to uncached */
-	mtrr_wrmsr(MSR_MTRRdefType, deftype_lo & ~0xcff, deftype_hi);
+	mtrr_wrmsr(MSR_MTRRdefType, deftype_lo & MTRR_DEFTYPE_DISABLE_MASK,
+		   deftype_hi);
 }
 
 void mtrr_enable(void)
@@ -763,7 +770,7 @@ static void generic_set_mtrr(unsigned int reg, unsigned long base,
 	} else {
 		vr->base_lo = base << PAGE_SHIFT | type;
 		vr->base_hi = (base & size_and_mask) >> (32 - PAGE_SHIFT);
-		vr->mask_lo = -size << PAGE_SHIFT | 0x800;
+		vr->mask_lo = -size << PAGE_SHIFT | MTRR_MASK_VALID;
 		vr->mask_hi = (-size & size_and_mask) >> (32 - PAGE_SHIFT);
 
 		mtrr_wrmsr(MTRRphysBase_MSR(reg), vr->base_lo, vr->base_hi);
@@ -817,7 +824,7 @@ static int generic_have_wrcomb(void)
 {
 	unsigned long config, dummy;
 	rdmsr(MSR_MTRRcap, config, dummy);
-	return config & (1 << 10);
+	return config & MTRR_CONFIG_HAVE_WC;
 }
 
 int positive_have_wrcomb(void)
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index ce0b82209ad3..1beb38f7a7a3 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -117,7 +117,7 @@ static void __init set_num_var_ranges(bool use_generic)
 	else if (is_cpu(CYRIX) || is_cpu(CENTAUR))
 		config = 8;
 
-	num_var_ranges = config & 0xff;
+	num_var_ranges = config & MTRR_CONFIG_NUM_VAR_MASK;
 }
 
 static void __init init_table(void)
-- 
2.35.3

