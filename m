Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F2B6F4357
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 14:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbjEBMKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 08:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbjEBMJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 08:09:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D1644BF
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 05:09:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 92A261F8C4;
        Tue,  2 May 2023 12:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683029393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gVBUKM5fVdXUpPFkRUIn5N9J3pTHqSbjbMSZMdYf6OE=;
        b=AVx9e94ce1YQjDOweHYjuUzNmx3XQ1tCeCHLuY6tUkd/Bdf8Fhl3Xo1VRjo1pdmo5oRtee
        JWrsLOhtsmo7fjtRar4VlTX7Ivpdy3DwygPWfiZwbemhPLVLsxn72dx30u53NM/cbEASCi
        1RXkV+PWWulMErVLTTBAX5Sjhn8tFDI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4FAF0139C3;
        Tue,  2 May 2023 12:09:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DGszEpH9UGSPLwAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 02 May 2023 12:09:53 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     mikelley@microsoft.com, Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v6 02/16] x86/mtrr: replace some constants with defines
Date:   Tue,  2 May 2023 14:09:17 +0200
Message-Id: <20230502120931.20719-3-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230502120931.20719-1-jgross@suse.com>
References: <20230502120931.20719-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using constants in MTRR code, use some new #defines.

Replace size_or_mask and size_and_mask with the much easier concept of
high reserved bits.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V5:
- new patch (inspired by a request of Boris Petkov)
V6:
- switch macro names to match SDM nomenclature of MSRs (Boris Petkov)
- replace size_or_mask and size_and_mask (Boris Petkov)
---
 arch/x86/include/asm/mtrr.h        | 24 ++++++++++-
 arch/x86/kernel/cpu/mtrr/cleanup.c |  2 +-
 arch/x86/kernel/cpu/mtrr/generic.c | 68 +++++++++++++++---------------
 arch/x86/kernel/cpu/mtrr/mtrr.c    |  2 +-
 4 files changed, 59 insertions(+), 37 deletions(-)

diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index f0eeaf6e5f5f..15379aa41edc 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -23,8 +23,27 @@
 #ifndef _ASM_X86_MTRR_H
 #define _ASM_X86_MTRR_H
 
+#include <linux/bits.h>
 #include <uapi/asm/mtrr.h>
 
+/* Defines for hardware MTRR registers. */
+#define MTRR_CAP_VCNT		GENMASK(7, 0)
+#define MTRR_CAP_FIX		BIT_MASK(8)
+#define MTRR_CAP_WC		BIT_MASK(10)
+
+#define MTRR_DEF_TYPE_TYPE	GENMASK(7, 0)
+#define MTRR_DEF_TYPE_FE	BIT_MASK(10)
+#define MTRR_DEF_TYPE_E		BIT_MASK(11)
+
+#define MTRR_DEF_TYPE_ENABLE	(MTRR_DEF_TYPE_FE | MTRR_DEF_TYPE_E)
+#define MTRR_DEF_TYPE_DISABLE	~(MTRR_DEF_TYPE_TYPE | MTRR_DEF_TYPE_ENABLE)
+
+#define MTRR_PHYSBASE_TYPE	GENMASK(7, 0)
+#define MTRR_PHYSBASE_RSVD	GENMASK(11, 8)
+
+#define MTRR_PHYSMASK_RSVD	GENMASK(10, 0)
+#define MTRR_PHYSMASK_V		BIT_MASK(11)
+
 /*
  * The following functions are for use by other drivers that cannot use
  * arch_phys_wc_add and arch_phys_wc_del.
@@ -121,7 +140,8 @@ struct mtrr_gentry32 {
 #endif /* CONFIG_COMPAT */
 
 /* Bit fields for enabled in struct mtrr_state_type */
-#define MTRR_STATE_MTRR_FIXED_ENABLED	0x01
-#define MTRR_STATE_MTRR_ENABLED		0x02
+#define MTRR_STATE_SHIFT		10
+#define MTRR_STATE_MTRR_FIXED_ENABLED	(MTRR_DEF_TYPE_FE >> MTRR_STATE_SHIFT)
+#define MTRR_STATE_MTRR_ENABLED		(MTRR_DEF_TYPE_E >> MTRR_STATE_SHIFT)
 
 #endif /* _ASM_X86_MTRR_H */
diff --git a/arch/x86/kernel/cpu/mtrr/cleanup.c b/arch/x86/kernel/cpu/mtrr/cleanup.c
index 70314093bb9b..ca2d567e729e 100644
--- a/arch/x86/kernel/cpu/mtrr/cleanup.c
+++ b/arch/x86/kernel/cpu/mtrr/cleanup.c
@@ -890,7 +890,7 @@ int __init mtrr_trim_uncached_memory(unsigned long end_pfn)
 		return 0;
 
 	rdmsr(MSR_MTRRdefType, def, dummy);
-	def &= 0xff;
+	def &= MTRR_DEF_TYPE_TYPE;
 	if (def != MTRR_TYPE_UNCACHABLE)
 		return 0;
 
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 3922552340b1..ad2a396233c1 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -38,14 +38,13 @@ u64 mtrr_tom2;
 struct mtrr_state_type mtrr_state;
 EXPORT_SYMBOL_GPL(mtrr_state);
 
-static u64 size_or_mask, size_and_mask;
+static u32 phys_hi_rsvd;
 
 void __init mtrr_set_mask(void)
 {
 	unsigned int phys_addr = boot_cpu_data.x86_phys_bits;
 
-	size_or_mask = ~GENMASK_ULL(phys_addr - PAGE_SHIFT - 1, 0);
-	size_and_mask = ~size_or_mask & GENMASK_ULL(39, 20);
+	phys_hi_rsvd = GENMASK(31, phys_addr - 32);
 }
 
 /*
@@ -79,10 +78,9 @@ static u64 get_mtrr_size(u64 mask)
 {
 	u64 size;
 
-	mask >>= PAGE_SHIFT;
-	mask |= size_or_mask;
+	mask |= (u64)phys_hi_rsvd << 32;
 	size = -mask;
-	size <<= PAGE_SHIFT;
+
 	return size;
 }
 
@@ -181,7 +179,7 @@ static u8 mtrr_type_lookup_variable(u64 start, u64 end, u64 *partial_end,
 	for (i = 0; i < num_var_ranges; ++i) {
 		unsigned short start_state, end_state, inclusive;
 
-		if (!(mtrr_state.var_ranges[i].mask_lo & (1 << 11)))
+		if (!(mtrr_state.var_ranges[i].mask_lo & MTRR_PHYSMASK_V))
 			continue;
 
 		base = (((u64)mtrr_state.var_ranges[i].base_hi) << 32) +
@@ -233,7 +231,8 @@ static u8 mtrr_type_lookup_variable(u64 start, u64 end, u64 *partial_end,
 		if ((start & mask) != (base & mask))
 			continue;
 
-		curr_match = mtrr_state.var_ranges[i].base_lo & 0xff;
+		curr_match = mtrr_state.var_ranges[i].base_lo &
+			     MTRR_PHYSBASE_TYPE;
 		if (prev_match == MTRR_TYPE_INVALID) {
 			prev_match = curr_match;
 			continue;
@@ -435,7 +434,7 @@ static void __init print_mtrr_state(void)
 	high_width = (boot_cpu_data.x86_phys_bits - (32 - PAGE_SHIFT) + 3) / 4;
 
 	for (i = 0; i < num_var_ranges; ++i) {
-		if (mtrr_state.var_ranges[i].mask_lo & (1 << 11))
+		if (mtrr_state.var_ranges[i].mask_lo & MTRR_PHYSMASK_V)
 			pr_debug("  %u base %0*X%05X000 mask %0*X%05X000 %s\n",
 				 i,
 				 high_width,
@@ -444,7 +443,8 @@ static void __init print_mtrr_state(void)
 				 high_width,
 				 mtrr_state.var_ranges[i].mask_hi,
 				 mtrr_state.var_ranges[i].mask_lo >> 12,
-				 mtrr_attrib_to_str(mtrr_state.var_ranges[i].base_lo & 0xff));
+				 mtrr_attrib_to_str(mtrr_state.var_ranges[i].base_lo &
+						    MTRR_PHYSBASE_TYPE));
 		else
 			pr_debug("  %u disabled\n", i);
 	}
@@ -462,7 +462,7 @@ bool __init get_mtrr_state(void)
 	vrs = mtrr_state.var_ranges;
 
 	rdmsr(MSR_MTRRcap, lo, dummy);
-	mtrr_state.have_fixed = (lo >> 8) & 1;
+	mtrr_state.have_fixed = !!(lo & MTRR_CAP_FIX);
 
 	for (i = 0; i < num_var_ranges; i++)
 		get_mtrr_var_range(i, &vrs[i]);
@@ -470,8 +470,9 @@ bool __init get_mtrr_state(void)
 		get_fixed_ranges(mtrr_state.fixed_ranges);
 
 	rdmsr(MSR_MTRRdefType, lo, dummy);
-	mtrr_state.def_type = (lo & 0xff);
-	mtrr_state.enabled = (lo & 0xc00) >> 10;
+	mtrr_state.def_type = lo & MTRR_DEF_TYPE_TYPE;
+	mtrr_state.enabled = (lo & MTRR_DEF_TYPE_ENABLE) >>
+			     MTRR_STATE_SHIFT;
 
 	if (amd_special_default_mtrr()) {
 		unsigned low, high;
@@ -584,7 +585,7 @@ static void generic_get_mtrr(unsigned int reg, unsigned long *base,
 
 	rdmsr(MTRRphysMask_MSR(reg), mask_lo, mask_hi);
 
-	if ((mask_lo & 0x800) == 0) {
+	if ((mask_lo & MTRR_PHYSMASK_V) == 0) {
 		/*  Invalid (i.e. free) range */
 		*base = 0;
 		*size = 0;
@@ -595,8 +596,8 @@ static void generic_get_mtrr(unsigned int reg, unsigned long *base,
 	rdmsr(MTRRphysBase_MSR(reg), base_lo, base_hi);
 
 	/* Work out the shifted address mask: */
-	tmp = (u64)mask_hi << (32 - PAGE_SHIFT) | mask_lo >> PAGE_SHIFT;
-	mask = size_or_mask | tmp;
+	tmp = (u64)mask_hi << 32 | (mask_lo & PAGE_MASK);
+	mask = (u64)phys_hi_rsvd << 32 | tmp;
 
 	/* Expand tmp with high bits to all 1s: */
 	hi = fls64(tmp);
@@ -614,9 +615,9 @@ static void generic_get_mtrr(unsigned int reg, unsigned long *base,
 	 * This works correctly if size is a power of two, i.e. a
 	 * contiguous range:
 	 */
-	*size = -mask;
+	*size = -mask >> PAGE_SHIFT;
 	*base = (u64)base_hi << (32 - PAGE_SHIFT) | base_lo >> PAGE_SHIFT;
-	*type = base_lo & 0xff;
+	*type = base_lo & MTRR_PHYSBASE_TYPE;
 
 out_put_cpu:
 	put_cpu();
@@ -654,9 +655,8 @@ static bool set_mtrr_var_ranges(unsigned int index, struct mtrr_var_range *vr)
 	bool changed = false;
 
 	rdmsr(MTRRphysBase_MSR(index), lo, hi);
-	if ((vr->base_lo & 0xfffff0ffUL) != (lo & 0xfffff0ffUL)
-	    || (vr->base_hi & (size_and_mask >> (32 - PAGE_SHIFT))) !=
-		(hi & (size_and_mask >> (32 - PAGE_SHIFT)))) {
+	if ((vr->base_lo & MTRR_PHYSBASE_RSVD) != (lo & MTRR_PHYSBASE_RSVD)
+	    || (vr->base_hi & ~phys_hi_rsvd) != (hi & ~phys_hi_rsvd)) {
 
 		mtrr_wrmsr(MTRRphysBase_MSR(index), vr->base_lo, vr->base_hi);
 		changed = true;
@@ -664,9 +664,8 @@ static bool set_mtrr_var_ranges(unsigned int index, struct mtrr_var_range *vr)
 
 	rdmsr(MTRRphysMask_MSR(index), lo, hi);
 
-	if ((vr->mask_lo & 0xfffff800UL) != (lo & 0xfffff800UL)
-	    || (vr->mask_hi & (size_and_mask >> (32 - PAGE_SHIFT))) !=
-		(hi & (size_and_mask >> (32 - PAGE_SHIFT)))) {
+	if ((vr->mask_lo & MTRR_PHYSMASK_RSVD) != (lo & MTRR_PHYSMASK_RSVD)
+	    || (vr->mask_hi & ~phys_hi_rsvd) != (hi & ~phys_hi_rsvd)) {
 		mtrr_wrmsr(MTRRphysMask_MSR(index), vr->mask_lo, vr->mask_hi);
 		changed = true;
 	}
@@ -701,11 +700,13 @@ static unsigned long set_mtrr_state(void)
 	 * Set_mtrr_restore restores the old value of MTRRdefType,
 	 * so to set it we fiddle with the saved value:
 	 */
-	if ((deftype_lo & 0xff) != mtrr_state.def_type
-	    || ((deftype_lo & 0xc00) >> 10) != mtrr_state.enabled) {
+	if ((deftype_lo & MTRR_DEF_TYPE_TYPE) != mtrr_state.def_type
+	    || ((deftype_lo & MTRR_DEF_TYPE_ENABLE) >> MTRR_STATE_SHIFT) !=
+	       mtrr_state.enabled) {
 
-		deftype_lo = (deftype_lo & ~0xcff) | mtrr_state.def_type |
-			     (mtrr_state.enabled << 10);
+		deftype_lo = (deftype_lo & MTRR_DEF_TYPE_DISABLE) |
+			     mtrr_state.def_type |
+			     (mtrr_state.enabled << MTRR_STATE_SHIFT);
 		change_mask |= MTRR_CHANGE_MASK_DEFTYPE;
 	}
 
@@ -718,7 +719,8 @@ void mtrr_disable(void)
 	rdmsr(MSR_MTRRdefType, deftype_lo, deftype_hi);
 
 	/* Disable MTRRs, and set the default type to uncached */
-	mtrr_wrmsr(MSR_MTRRdefType, deftype_lo & ~0xcff, deftype_hi);
+	mtrr_wrmsr(MSR_MTRRdefType, deftype_lo & MTRR_DEF_TYPE_DISABLE,
+		   deftype_hi);
 }
 
 void mtrr_enable(void)
@@ -772,9 +774,9 @@ static void generic_set_mtrr(unsigned int reg, unsigned long base,
 		memset(vr, 0, sizeof(struct mtrr_var_range));
 	} else {
 		vr->base_lo = base << PAGE_SHIFT | type;
-		vr->base_hi = (base & size_and_mask) >> (32 - PAGE_SHIFT);
-		vr->mask_lo = -size << PAGE_SHIFT | 0x800;
-		vr->mask_hi = (-size & size_and_mask) >> (32 - PAGE_SHIFT);
+		vr->base_hi = (base >> (32 - PAGE_SHIFT)) & ~phys_hi_rsvd;
+		vr->mask_lo = -size << PAGE_SHIFT | MTRR_PHYSMASK_V;
+		vr->mask_hi = (-size >> (32 - PAGE_SHIFT)) & ~phys_hi_rsvd;
 
 		mtrr_wrmsr(MTRRphysBase_MSR(reg), vr->base_lo, vr->base_hi);
 		mtrr_wrmsr(MTRRphysMask_MSR(reg), vr->mask_lo, vr->mask_hi);
@@ -827,7 +829,7 @@ static int generic_have_wrcomb(void)
 {
 	unsigned long config, dummy;
 	rdmsr(MSR_MTRRcap, config, dummy);
-	return config & (1 << 10);
+	return config & MTRR_CAP_WC;
 }
 
 int positive_have_wrcomb(void)
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 1bdab16f16bd..fddc4e0c6626 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -115,7 +115,7 @@ static void __init set_num_var_ranges(bool use_generic)
 	else if (is_cpu(CYRIX) || is_cpu(CENTAUR))
 		config = 8;
 
-	num_var_ranges = config & 0xff;
+	num_var_ranges = config & MTRR_CAP_VCNT;
 }
 
 static void __init init_table(void)
-- 
2.35.3

