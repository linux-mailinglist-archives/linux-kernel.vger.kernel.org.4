Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9886D4D0D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbjDCQDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbjDCQDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:03:34 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E86B1FF2
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 09:03:31 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 21E381EC063F;
        Mon,  3 Apr 2023 18:03:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1680537810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sb/Hhj4OHpVhM7izMhMuZxG/aHMI5JmXLhBwrgGnMRY=;
        b=jN7tAishzzwoq/Zyv6jX1n1AlSd8qlGLrnaehHgjIbnlxGAQ6AT+UXiTPsUgdWZD+qx+sf
        mi9pZj/7fgta71QIYpHCjzZ0uEvB36N7sH38ir+c8/maeHdgM7KfPbutAwmlA4fGA5a0hb
        2Aq0/dTya4OAE5ApvIgIM5hcimJXSsg=
Date:   Mon, 3 Apr 2023 18:03:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 03/15] x86/mtrr: replace some constants with defines
Message-ID: <20230403160323.GAZCr4y14GvOA4dZID@fat_crate.local>
References: <20230401063652.23522-1-jgross@suse.com>
 <20230401063652.23522-4-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230401063652.23522-4-jgross@suse.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 01, 2023 at 08:36:40AM +0200, Juergen Gross wrote:
> @@ -643,10 +646,12 @@ static bool set_mtrr_var_ranges(unsigned int index, struct mtrr_var_range *vr)
>  	unsigned int lo, hi;
>  	bool changed = false;
>  
> +#define BASE_MASK	(MTRR_BASE_TYPE_MASK | (size_and_mask << PAGE_SHIFT))
> +#define MASK_MASK	(MTRR_MASK_VALID | (size_and_mask << PAGE_SHIFT))

No, "MASK_MASK" is too much. :-)

Anyway, so I started looking at this and here's what I'm seeing on my
machine even with the old code:

        rdmsr(MTRRphysBase_MSR(index), lo, hi);
        if ((vr->base_lo & 0xfffff0ffUL) != (lo & 0xfffff0ffUL)
            || (vr->base_hi & (size_and_mask >> (32 - PAGE_SHIFT))) !=
                (hi & (size_and_mask >> (32 - PAGE_SHIFT)))) {


size_and_mask:		0x0000000ffff00000
the shifted version:	0x000000000000ffff

which is bits [15:0]

Now, looking at MTRRphysBase_MSR's definition, the high 32 bits are:

[63 ... reserved ... ][ max_addr ... 32 ]

and that second slice: from max_addr to the 32nd bit of the whole MSR is
the second part of PhysBase.

max_addr aka phys_addr comes from:

	phys_addr = cpuid_eax(0x80000008) & 0xff;

on that machine, that value is 48.

Which means, the physaddr slice should be [48 .. 32], i.e.,

	0x0001ffff00000000

and when you shift that by 32 so that it can be ANDed with the high
portion of the MSR, it becomes

0x000000000001ffff

i.e., bit 16 is set too.

And that max address can be up to 51:

"Range Physical Base-Address (PhysBase)—Bits 51:12. The memory-range base-address in
physical-address space. PhysBase is aligned on a 4-Kbyte (or greater) address in the 52-bit
physical-address space supported by the AMD64 architecture. PhysBase represents the most-
significant 40-address bits of the physical address. Physical-address
bits 11:0 are assumed to be 0."

Long story short, size_and_mask needs to be done from

	size_and_mask = ~size_or_mask & 0xfffff00000ULL;

to

	size_and_mask = ~size_or_mask & GENMASK_ULL(phys_addr, 20);

size_or_mask bits already took into consideration the phys_addr:

	size_or_mask = SIZE_OR_MASK_BITS(phys_addr);

and size_and_mask needs to do it too.

Right?

I'll test this on the boxes here everywhere. I guess this gets hit only
on boxes where the phys_addr of the variable MTRRs goes over the 16
bits.

As to this patch: please make all the bit and mask definitions you're
adding as close to the MTRR bit and mask definition names in the
APM+SDM. I've started this already (ontop of yours):

---

diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index 4e59f7854950..a768a8716980 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -28,7 +28,7 @@
 
 /* Defines for hardware MTRR registers. */
 #define MTRR_CONFIG_NUM_VAR_MASK	GENMASK(7, 0)
-#define MTRR_CONFIG_HAVE_FIXED		BIT_MASK(8)
+#define MTRR_CAP_FIX			BIT_MASK(8)
 #define MTRR_CONFIG_HAVE_WC		BIT_MASK(10)
 
 #define MTRR_DEFTYPE_TYPE_MASK		GENMASK(7, 0)
@@ -39,9 +39,9 @@
 #define MTRR_DEFTYPE_DISABLE_MASK	~(MTRR_DEFTYPE_TYPE_MASK |	\
 					  MTRR_DEFTYPE_ENABLE_MASK)
 
-#define MTRR_BASE_TYPE_MASK		GENMASK_ULL(7, 0)
+#define MTRR_BASE_TYPE_MASK		GENMASK(7, 0)
 
-#define MTRR_MASK_VALID			BIT_ULL_MASK(11)
+#define MTRR_PHYS_MASK_VALID		BIT_ULL_MASK(11)
 
 /*
  * The following functions are for use by other drivers that cannot use
@@ -140,9 +140,7 @@ struct mtrr_gentry32 {
 
 /* Bit fields for enabled in struct mtrr_state_type */
 #define MTRR_STATE_SHIFT		10
-#define MTRR_STATE_MTRR_FIXED_ENABLED	\
-			(MTRR_DEFTYPE_FIXED_ENABLED >> MTRR_STATE_SHIFT)
-#define MTRR_STATE_MTRR_ENABLED		\
-			(MTRR_DEFTYPE_ENABLED >> MTRR_STATE_SHIFT)
+#define MTRR_STATE_MTRR_FIXED_ENABLED	(MTRR_DEFTYPE_FIXED_ENABLED >> MTRR_STATE_SHIFT)
+#define MTRR_STATE_MTRR_ENABLED		(MTRR_DEFTYPE_ENABLED >> MTRR_STATE_SHIFT)
 
 #endif /* _ASM_X86_MTRR_H */
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 9a12da76635c..8f8b7775a5ac 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -171,7 +171,7 @@ static u8 mtrr_type_lookup_variable(u64 start, u64 end, u64 *partial_end,
 	for (i = 0; i < num_var_ranges; ++i) {
 		unsigned short start_state, end_state, inclusive;
 
-		if (!(mtrr_state.var_ranges[i].mask_lo & MTRR_MASK_VALID))
+		if (!(mtrr_state.var_ranges[i].mask_lo & MTRR_PHYS_MASK_VALID))
 			continue;
 
 		base = (((u64)mtrr_state.var_ranges[i].base_hi) << 32) +
@@ -223,8 +223,7 @@ static u8 mtrr_type_lookup_variable(u64 start, u64 end, u64 *partial_end,
 		if ((start & mask) != (base & mask))
 			continue;
 
-		curr_match = mtrr_state.var_ranges[i].base_lo &
-			     MTRR_BASE_TYPE_MASK;
+		curr_match = mtrr_state.var_ranges[i].base_lo & MTRR_BASE_TYPE_MASK;
 		if (prev_match == MTRR_TYPE_INVALID) {
 			prev_match = curr_match;
 			continue;
@@ -426,7 +425,7 @@ static void __init print_mtrr_state(void)
 	high_width = (__ffs64(size_or_mask) - (32 - PAGE_SHIFT) + 3) / 4;
 
 	for (i = 0; i < num_var_ranges; ++i) {
-		if (mtrr_state.var_ranges[i].mask_lo & MTRR_MASK_VALID)
+		if (mtrr_state.var_ranges[i].mask_lo & MTRR_PHYS_MASK_VALID)
 			pr_debug("  %u base %0*X%05X000 mask %0*X%05X000 %s\n",
 				 i,
 				 high_width,
@@ -454,7 +453,7 @@ bool __init get_mtrr_state(void)
 	vrs = mtrr_state.var_ranges;
 
 	rdmsr(MSR_MTRRcap, lo, dummy);
-	mtrr_state.have_fixed = !!(lo & MTRR_CONFIG_HAVE_FIXED);
+	mtrr_state.have_fixed = !!(lo & MTRR_CAP_FIX);
 
 	for (i = 0; i < num_var_ranges; i++)
 		get_mtrr_var_range(i, &vrs[i]);
@@ -463,8 +462,7 @@ bool __init get_mtrr_state(void)
 
 	rdmsr(MSR_MTRRdefType, lo, dummy);
 	mtrr_state.def_type = lo & MTRR_DEFTYPE_TYPE_MASK;
-	mtrr_state.enabled = (lo & MTRR_DEFTYPE_ENABLE_MASK) >>
-			     MTRR_STATE_SHIFT;
+	mtrr_state.enabled = (lo & MTRR_DEFTYPE_ENABLE_MASK) >> MTRR_STATE_SHIFT;
 
 	if (amd_special_default_mtrr()) {
 		unsigned low, high;
@@ -576,8 +574,7 @@ static void generic_get_mtrr(unsigned int reg, unsigned long *base,
 	get_cpu();
 
 	rdmsr(MTRRphysMask_MSR(reg), mask_lo, mask_hi);
-
-	if ((mask_lo & MTRR_MASK_VALID) == 0) {
+	if (!(mask_lo & MTRR_PHYS_MASK_VALID)) {
 		/*  Invalid (i.e. free) range */
 		*base = 0;
 		*size = 0;
@@ -647,7 +644,7 @@ static bool set_mtrr_var_ranges(unsigned int index, struct mtrr_var_range *vr)
 	bool changed = false;
 
 #define BASE_MASK	(MTRR_BASE_TYPE_MASK | (size_and_mask << PAGE_SHIFT))
-#define MASK_MASK	(MTRR_MASK_VALID | (size_and_mask << PAGE_SHIFT))
+#define MASK_MASK	(MTRR_PHYS_MASK_VALID | (size_and_mask << PAGE_SHIFT))
 
 	rdmsr(MTRRphysBase_MSR(index), lo, hi);
 	if ((vr->base_lo & BASE_MASK) != (lo & BASE_MASK)
@@ -770,7 +767,7 @@ static void generic_set_mtrr(unsigned int reg, unsigned long base,
 	} else {
 		vr->base_lo = base << PAGE_SHIFT | type;
 		vr->base_hi = (base & size_and_mask) >> (32 - PAGE_SHIFT);
-		vr->mask_lo = -size << PAGE_SHIFT | MTRR_MASK_VALID;
+		vr->mask_lo = -size << PAGE_SHIFT | MTRR_PHYS_MASK_VALID;
 		vr->mask_hi = (-size & size_and_mask) >> (32 - PAGE_SHIFT);
 
 		mtrr_wrmsr(MTRRphysBase_MSR(reg), vr->base_lo, vr->base_hi);

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
