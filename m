Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5169E722867
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 16:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234533AbjFEOJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 10:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbjFEOIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 10:08:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EE8E54;
        Mon,  5 Jun 2023 07:08:20 -0700 (PDT)
Date:   Mon, 05 Jun 2023 14:08:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685974098;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=paNP292sfeDaRbA9lZSiZo3oka1xntFg+WeA1DhWd3Y=;
        b=11p31SqCuIjTLaB/Y8Fq/YogslPaU1MnWBt4W5ZGX0OGa/LfrytY6df5wZTEH+T15iWFLa
        QF3XAwYVGzs6GOp8RmpN6JvvLRxfoMslGGEZiE9LhxNQwjXpIyNoGzfuWXiJpm3JsBRzZJ
        n1SVCA/1yCrkPh6ZFzPfjZud+N7ZvJdpjzleXdQghXMf5jc6zn4QJvKpFFfU2aB2l+nGRw
        BIAglmh99Pa8OXZmlz54D4Xpw6poPnA7kKAU2vI0F3ZpfnIePGOH+F0D9aGAHq7sqnHqgs
        WyoxXjAOGai5h4v2BOmkpyCid1EQMYwx8WT+WN7ZssJSOQl96vq7MmpPYH1VUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685974098;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=paNP292sfeDaRbA9lZSiZo3oka1xntFg+WeA1DhWd3Y=;
        b=8YnUbyzNFu8CT0Y2E0P9rgAEZPhuIAD8p3XNogsTno0NiGBaoECuWfFjiM6VKDRAs/knbl
        dITQiUY5eZsSeSBw==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mtrr] x86/mtrr: Replace size_or_mask and size_and_mask with
 a much easier concept
Cc:     Juergen Gross <jgross@suse.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230502120931.20719-3-jgross@suse.com>
References: <20230502120931.20719-3-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <168597409759.404.4107410930941956610.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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

Commit-ID:     d053b481a5f16dbd4f020c6b3ebdf9173fdef0e2
Gitweb:        https://git.kernel.org/tip/d053b481a5f16dbd4f020c6b3ebdf9173fd=
ef0e2
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Tue, 02 May 2023 14:09:17 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 01 Jun 2023 15:04:23 +02:00

x86/mtrr: Replace size_or_mask and size_and_mask with a much easier concept

Replace size_or_mask and size_and_mask with the much easier concept of
high reserved bits.

While at it, instead of using constants in the MTRR code, use some new

  [ bp:
   - Drop mtrr_set_mask()
   - Unbreak long lines
   - Move struct mtrr_state_type out of the uapi header as it doesn't
     belong there. It also fixes a HDRTEST breakage "unknown type name =E2=80=
=98bool=E2=80=99"
     as Reported-by: kernel test robot <lkp@intel.com>
   - Massage.
  ]

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230502120931.20719-3-jgross@suse.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/mtrr.h        | 32 ++++++++++++-
 arch/x86/include/uapi/asm/mtrr.h   |  8 +---
 arch/x86/kernel/cpu/mtrr/cleanup.c |  2 +-
 arch/x86/kernel/cpu/mtrr/generic.c | 70 ++++++++++++-----------------
 arch/x86/kernel/cpu/mtrr/mtrr.c    |  4 +-
 arch/x86/kernel/cpu/mtrr/mtrr.h    |  2 +-
 6 files changed, 65 insertions(+), 53 deletions(-)

diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index f0eeaf6..1421fe8 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -23,8 +23,35 @@
 #ifndef _ASM_X86_MTRR_H
 #define _ASM_X86_MTRR_H
=20
+#include <linux/bits.h>
 #include <uapi/asm/mtrr.h>
=20
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
+struct mtrr_state_type {
+	struct mtrr_var_range var_ranges[MTRR_MAX_VAR_RANGES];
+	mtrr_type fixed_ranges[MTRR_NUM_FIXED_RANGES];
+	unsigned char enabled;
+	bool have_fixed;
+	mtrr_type def_type;
+};
+
 /*
  * The following functions are for use by other drivers that cannot use
  * arch_phys_wc_add and arch_phys_wc_del.
@@ -121,7 +148,8 @@ struct mtrr_gentry32 {
 #endif /* CONFIG_COMPAT */
=20
 /* Bit fields for enabled in struct mtrr_state_type */
-#define MTRR_STATE_MTRR_FIXED_ENABLED	0x01
-#define MTRR_STATE_MTRR_ENABLED		0x02
+#define MTRR_STATE_SHIFT		10
+#define MTRR_STATE_MTRR_FIXED_ENABLED	(MTRR_DEF_TYPE_FE >> MTRR_STATE_SHIFT)
+#define MTRR_STATE_MTRR_ENABLED		(MTRR_DEF_TYPE_E >> MTRR_STATE_SHIFT)
=20
 #endif /* _ASM_X86_MTRR_H */
diff --git a/arch/x86/include/uapi/asm/mtrr.h b/arch/x86/include/uapi/asm/mtr=
r.h
index 376563f..ab194c8 100644
--- a/arch/x86/include/uapi/asm/mtrr.h
+++ b/arch/x86/include/uapi/asm/mtrr.h
@@ -81,14 +81,6 @@ typedef __u8 mtrr_type;
 #define MTRR_NUM_FIXED_RANGES 88
 #define MTRR_MAX_VAR_RANGES 256
=20
-struct mtrr_state_type {
-	struct mtrr_var_range var_ranges[MTRR_MAX_VAR_RANGES];
-	mtrr_type fixed_ranges[MTRR_NUM_FIXED_RANGES];
-	unsigned char enabled;
-	unsigned char have_fixed;
-	mtrr_type def_type;
-};
-
 #define MTRRphysBase_MSR(reg) (0x200 + 2 * (reg))
 #define MTRRphysMask_MSR(reg) (0x200 + 2 * (reg) + 1)
=20
diff --git a/arch/x86/kernel/cpu/mtrr/cleanup.c b/arch/x86/kernel/cpu/mtrr/cl=
eanup.c
index 7031409..ca2d567 100644
--- a/arch/x86/kernel/cpu/mtrr/cleanup.c
+++ b/arch/x86/kernel/cpu/mtrr/cleanup.c
@@ -890,7 +890,7 @@ int __init mtrr_trim_uncached_memory(unsigned long end_pf=
n)
 		return 0;
=20
 	rdmsr(MSR_MTRRdefType, def, dummy);
-	def &=3D 0xff;
+	def &=3D MTRR_DEF_TYPE_TYPE;
 	if (def !=3D MTRR_TYPE_UNCACHABLE)
 		return 0;
=20
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/ge=
neric.c
index 3922552..08ba558 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -38,15 +38,8 @@ u64 mtrr_tom2;
 struct mtrr_state_type mtrr_state;
 EXPORT_SYMBOL_GPL(mtrr_state);
=20
-static u64 size_or_mask, size_and_mask;
-
-void __init mtrr_set_mask(void)
-{
-	unsigned int phys_addr =3D boot_cpu_data.x86_phys_bits;
-
-	size_or_mask =3D ~GENMASK_ULL(phys_addr - PAGE_SHIFT - 1, 0);
-	size_and_mask =3D ~size_or_mask & GENMASK_ULL(39, 20);
-}
+/* Reserved bits in the high portion of the MTRRphysBaseN MSR. */
+u32 phys_hi_rsvd;
=20
 /*
  * BIOS is expected to clear MtrrFixDramModEn bit, see for example
@@ -79,10 +72,9 @@ static u64 get_mtrr_size(u64 mask)
 {
 	u64 size;
=20
-	mask >>=3D PAGE_SHIFT;
-	mask |=3D size_or_mask;
+	mask |=3D (u64)phys_hi_rsvd << 32;
 	size =3D -mask;
-	size <<=3D PAGE_SHIFT;
+
 	return size;
 }
=20
@@ -181,7 +173,7 @@ static u8 mtrr_type_lookup_variable(u64 start, u64 end, u=
64 *partial_end,
 	for (i =3D 0; i < num_var_ranges; ++i) {
 		unsigned short start_state, end_state, inclusive;
=20
-		if (!(mtrr_state.var_ranges[i].mask_lo & (1 << 11)))
+		if (!(mtrr_state.var_ranges[i].mask_lo & MTRR_PHYSMASK_V))
 			continue;
=20
 		base =3D (((u64)mtrr_state.var_ranges[i].base_hi) << 32) +
@@ -233,7 +225,7 @@ static u8 mtrr_type_lookup_variable(u64 start, u64 end, u=
64 *partial_end,
 		if ((start & mask) !=3D (base & mask))
 			continue;
=20
-		curr_match =3D mtrr_state.var_ranges[i].base_lo & 0xff;
+		curr_match =3D mtrr_state.var_ranges[i].base_lo & MTRR_PHYSBASE_TYPE;
 		if (prev_match =3D=3D MTRR_TYPE_INVALID) {
 			prev_match =3D curr_match;
 			continue;
@@ -435,7 +427,7 @@ static void __init print_mtrr_state(void)
 	high_width =3D (boot_cpu_data.x86_phys_bits - (32 - PAGE_SHIFT) + 3) / 4;
=20
 	for (i =3D 0; i < num_var_ranges; ++i) {
-		if (mtrr_state.var_ranges[i].mask_lo & (1 << 11))
+		if (mtrr_state.var_ranges[i].mask_lo & MTRR_PHYSMASK_V)
 			pr_debug("  %u base %0*X%05X000 mask %0*X%05X000 %s\n",
 				 i,
 				 high_width,
@@ -444,7 +436,8 @@ static void __init print_mtrr_state(void)
 				 high_width,
 				 mtrr_state.var_ranges[i].mask_hi,
 				 mtrr_state.var_ranges[i].mask_lo >> 12,
-				 mtrr_attrib_to_str(mtrr_state.var_ranges[i].base_lo & 0xff));
+				 mtrr_attrib_to_str(mtrr_state.var_ranges[i].base_lo &
+						    MTRR_PHYSBASE_TYPE));
 		else
 			pr_debug("  %u disabled\n", i);
 	}
@@ -462,7 +455,7 @@ bool __init get_mtrr_state(void)
 	vrs =3D mtrr_state.var_ranges;
=20
 	rdmsr(MSR_MTRRcap, lo, dummy);
-	mtrr_state.have_fixed =3D (lo >> 8) & 1;
+	mtrr_state.have_fixed =3D lo & MTRR_CAP_FIX;
=20
 	for (i =3D 0; i < num_var_ranges; i++)
 		get_mtrr_var_range(i, &vrs[i]);
@@ -470,8 +463,8 @@ bool __init get_mtrr_state(void)
 		get_fixed_ranges(mtrr_state.fixed_ranges);
=20
 	rdmsr(MSR_MTRRdefType, lo, dummy);
-	mtrr_state.def_type =3D (lo & 0xff);
-	mtrr_state.enabled =3D (lo & 0xc00) >> 10;
+	mtrr_state.def_type =3D lo & MTRR_DEF_TYPE_TYPE;
+	mtrr_state.enabled =3D (lo & MTRR_DEF_TYPE_ENABLE) >> MTRR_STATE_SHIFT;
=20
 	if (amd_special_default_mtrr()) {
 		unsigned low, high;
@@ -584,7 +577,7 @@ static void generic_get_mtrr(unsigned int reg, unsigned l=
ong *base,
=20
 	rdmsr(MTRRphysMask_MSR(reg), mask_lo, mask_hi);
=20
-	if ((mask_lo & 0x800) =3D=3D 0) {
+	if (!(mask_lo & MTRR_PHYSMASK_V)) {
 		/*  Invalid (i.e. free) range */
 		*base =3D 0;
 		*size =3D 0;
@@ -595,8 +588,8 @@ static void generic_get_mtrr(unsigned int reg, unsigned l=
ong *base,
 	rdmsr(MTRRphysBase_MSR(reg), base_lo, base_hi);
=20
 	/* Work out the shifted address mask: */
-	tmp =3D (u64)mask_hi << (32 - PAGE_SHIFT) | mask_lo >> PAGE_SHIFT;
-	mask =3D size_or_mask | tmp;
+	tmp =3D (u64)mask_hi << 32 | (mask_lo & PAGE_MASK);
+	mask =3D (u64)phys_hi_rsvd << 32 | tmp;
=20
 	/* Expand tmp with high bits to all 1s: */
 	hi =3D fls64(tmp);
@@ -614,9 +607,9 @@ static void generic_get_mtrr(unsigned int reg, unsigned l=
ong *base,
 	 * This works correctly if size is a power of two, i.e. a
 	 * contiguous range:
 	 */
-	*size =3D -mask;
+	*size =3D -mask >> PAGE_SHIFT;
 	*base =3D (u64)base_hi << (32 - PAGE_SHIFT) | base_lo >> PAGE_SHIFT;
-	*type =3D base_lo & 0xff;
+	*type =3D base_lo & MTRR_PHYSBASE_TYPE;
=20
 out_put_cpu:
 	put_cpu();
@@ -654,9 +647,8 @@ static bool set_mtrr_var_ranges(unsigned int index, struc=
t mtrr_var_range *vr)
 	bool changed =3D false;
=20
 	rdmsr(MTRRphysBase_MSR(index), lo, hi);
-	if ((vr->base_lo & 0xfffff0ffUL) !=3D (lo & 0xfffff0ffUL)
-	    || (vr->base_hi & (size_and_mask >> (32 - PAGE_SHIFT))) !=3D
-		(hi & (size_and_mask >> (32 - PAGE_SHIFT)))) {
+	if ((vr->base_lo & ~MTRR_PHYSBASE_RSVD) !=3D (lo & ~MTRR_PHYSBASE_RSVD)
+	    || (vr->base_hi & ~phys_hi_rsvd) !=3D (hi & ~phys_hi_rsvd)) {
=20
 		mtrr_wrmsr(MTRRphysBase_MSR(index), vr->base_lo, vr->base_hi);
 		changed =3D true;
@@ -664,9 +656,8 @@ static bool set_mtrr_var_ranges(unsigned int index, struc=
t mtrr_var_range *vr)
=20
 	rdmsr(MTRRphysMask_MSR(index), lo, hi);
=20
-	if ((vr->mask_lo & 0xfffff800UL) !=3D (lo & 0xfffff800UL)
-	    || (vr->mask_hi & (size_and_mask >> (32 - PAGE_SHIFT))) !=3D
-		(hi & (size_and_mask >> (32 - PAGE_SHIFT)))) {
+	if ((vr->mask_lo & ~MTRR_PHYSMASK_RSVD) !=3D (lo & ~MTRR_PHYSMASK_RSVD)
+	    || (vr->mask_hi & ~phys_hi_rsvd) !=3D (hi & ~phys_hi_rsvd)) {
 		mtrr_wrmsr(MTRRphysMask_MSR(index), vr->mask_lo, vr->mask_hi);
 		changed =3D true;
 	}
@@ -701,11 +692,12 @@ static unsigned long set_mtrr_state(void)
 	 * Set_mtrr_restore restores the old value of MTRRdefType,
 	 * so to set it we fiddle with the saved value:
 	 */
-	if ((deftype_lo & 0xff) !=3D mtrr_state.def_type
-	    || ((deftype_lo & 0xc00) >> 10) !=3D mtrr_state.enabled) {
+	if ((deftype_lo & MTRR_DEF_TYPE_TYPE) !=3D mtrr_state.def_type ||
+	    ((deftype_lo & MTRR_DEF_TYPE_ENABLE) >> MTRR_STATE_SHIFT) !=3D mtrr_sta=
te.enabled) {
=20
-		deftype_lo =3D (deftype_lo & ~0xcff) | mtrr_state.def_type |
-			     (mtrr_state.enabled << 10);
+		deftype_lo =3D (deftype_lo & MTRR_DEF_TYPE_DISABLE) |
+			     mtrr_state.def_type |
+			     (mtrr_state.enabled << MTRR_STATE_SHIFT);
 		change_mask |=3D MTRR_CHANGE_MASK_DEFTYPE;
 	}
=20
@@ -718,7 +710,7 @@ void mtrr_disable(void)
 	rdmsr(MSR_MTRRdefType, deftype_lo, deftype_hi);
=20
 	/* Disable MTRRs, and set the default type to uncached */
-	mtrr_wrmsr(MSR_MTRRdefType, deftype_lo & ~0xcff, deftype_hi);
+	mtrr_wrmsr(MSR_MTRRdefType, deftype_lo & MTRR_DEF_TYPE_DISABLE, deftype_hi);
 }
=20
 void mtrr_enable(void)
@@ -772,9 +764,9 @@ static void generic_set_mtrr(unsigned int reg, unsigned l=
ong base,
 		memset(vr, 0, sizeof(struct mtrr_var_range));
 	} else {
 		vr->base_lo =3D base << PAGE_SHIFT | type;
-		vr->base_hi =3D (base & size_and_mask) >> (32 - PAGE_SHIFT);
-		vr->mask_lo =3D -size << PAGE_SHIFT | 0x800;
-		vr->mask_hi =3D (-size & size_and_mask) >> (32 - PAGE_SHIFT);
+		vr->base_hi =3D (base >> (32 - PAGE_SHIFT)) & ~phys_hi_rsvd;
+		vr->mask_lo =3D -size << PAGE_SHIFT | MTRR_PHYSMASK_V;
+		vr->mask_hi =3D (-size >> (32 - PAGE_SHIFT)) & ~phys_hi_rsvd;
=20
 		mtrr_wrmsr(MTRRphysBase_MSR(reg), vr->base_lo, vr->base_hi);
 		mtrr_wrmsr(MTRRphysMask_MSR(reg), vr->mask_lo, vr->mask_hi);
@@ -827,7 +819,7 @@ static int generic_have_wrcomb(void)
 {
 	unsigned long config, dummy;
 	rdmsr(MSR_MTRRcap, config, dummy);
-	return config & (1 << 10);
+	return config & MTRR_CAP_WC;
 }
=20
 int positive_have_wrcomb(void)
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 1bdab16..1067f12 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -115,7 +115,7 @@ static void __init set_num_var_ranges(bool use_generic)
 	else if (is_cpu(CYRIX) || is_cpu(CENTAUR))
 		config =3D 8;
=20
-	num_var_ranges =3D config & 0xff;
+	num_var_ranges =3D config & MTRR_CAP_VCNT;
 }
=20
 static void __init init_table(void)
@@ -627,7 +627,7 @@ void __init mtrr_bp_init(void)
 {
 	const char *why =3D "(not available)";
=20
-	mtrr_set_mask();
+	phys_hi_rsvd =3D GENMASK(31, boot_cpu_data.x86_phys_bits - 32);
=20
 	if (cpu_feature_enabled(X86_FEATURE_MTRR)) {
 		mtrr_if =3D &generic_mtrr_ops;
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.h b/arch/x86/kernel/cpu/mtrr/mtrr.h
index a00987e..59e8fb2 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.h
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.h
@@ -58,8 +58,8 @@ extern const struct mtrr_ops *mtrr_if;
 extern unsigned int num_var_ranges;
 extern u64 mtrr_tom2;
 extern struct mtrr_state_type mtrr_state;
+extern u32 phys_hi_rsvd;
=20
-void mtrr_set_mask(void);
 void mtrr_state_warn(void);
 const char *mtrr_attrib_to_str(int x);
 void mtrr_wrmsr(unsigned, unsigned, unsigned);
