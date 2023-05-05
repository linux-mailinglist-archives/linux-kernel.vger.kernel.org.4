Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4416F6F88FC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 20:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbjEESuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 14:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbjEESuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 14:50:01 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A98203E0
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 11:49:59 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CD08D1EC0421;
        Fri,  5 May 2023 20:49:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1683312597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FFIT+MIXclPqiy46BnxVsu0PYxvhZXqRoK4IPFWa2ZI=;
        b=qqk1DTCKxsQcCH9iUrAboa0RZW8hIxMm7/JeI88HPDqgKa9TNQ468t+nRH8+vS3dWUJJX1
        FZgD8mmQwVsryvaWyTgDFPWOWhN/LumNh9EmJaTvDsn5JXTTLV588/CEiywK/Tq2chcg8/
        Woc6wSGV7ORRkIVRci2lknyF/Dj+iZs=
Date:   Fri, 5 May 2023 20:49:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        mikelley@microsoft.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v6 02/16] x86/mtrr: replace some constants with defines
Message-ID: <20230505184952.GBZFVP0DkRrJiI+84Y@fat_crate.local>
References: <20230502120931.20719-1-jgross@suse.com>
 <20230502120931.20719-3-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230502120931.20719-3-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2023 at 02:09:17PM +0200, Juergen Gross wrote:
> Instead of using constants in MTRR code, use some new #defines.
> 
> Replace size_or_mask and size_and_mask with the much easier concept of
> high reserved bits.

This is the better commit title than what's there now because the patch
does more than just replacing some constants with defines. Therefore my
question to patch 1. Anyway, I'll fix it up.

Also, some minor cleanups ontop:

---

diff --git a/arch/x86/include/uapi/asm/mtrr.h b/arch/x86/include/uapi/asm/mtrr.h
index 376563f2bac1..e314969a5e6d 100644
--- a/arch/x86/include/uapi/asm/mtrr.h
+++ b/arch/x86/include/uapi/asm/mtrr.h
@@ -84,8 +84,8 @@ typedef __u8 mtrr_type;
 struct mtrr_state_type {
 	struct mtrr_var_range var_ranges[MTRR_MAX_VAR_RANGES];
 	mtrr_type fixed_ranges[MTRR_NUM_FIXED_RANGES];
-	unsigned char enabled;
-	unsigned char have_fixed;
+	bool enabled;
+	bool have_fixed;
 	mtrr_type def_type;
 };
 
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 59b48bd8380c..3f0811b2fd18 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -38,14 +38,8 @@ u64 mtrr_tom2;
 struct mtrr_state_type mtrr_state;
 EXPORT_SYMBOL_GPL(mtrr_state);
 
-static u32 phys_hi_rsvd;
-
-void __init mtrr_set_mask(void)
-{
-	unsigned int phys_addr = boot_cpu_data.x86_phys_bits;
-
-	phys_hi_rsvd = GENMASK(31, phys_addr - 32);
-}
+/* Reserved bits in the high portion of the MTRRphysBaseN MSR. */
+u32 phys_hi_rsvd;
 
 /*
  * BIOS is expected to clear MtrrFixDramModEn bit, see for example
@@ -231,8 +225,7 @@ static u8 mtrr_type_lookup_variable(u64 start, u64 end, u64 *partial_end,
 		if ((start & mask) != (base & mask))
 			continue;
 
-		curr_match = mtrr_state.var_ranges[i].base_lo &
-			     MTRR_PHYSBASE_TYPE;
+		curr_match = mtrr_state.var_ranges[i].base_lo & MTRR_PHYSBASE_TYPE;
 		if (prev_match == MTRR_TYPE_INVALID) {
 			prev_match = curr_match;
 			continue;
@@ -462,7 +455,7 @@ bool __init get_mtrr_state(void)
 	vrs = mtrr_state.var_ranges;
 
 	rdmsr(MSR_MTRRcap, lo, dummy);
-	mtrr_state.have_fixed = !!(lo & MTRR_CAP_FIX);
+	mtrr_state.have_fixed = lo & MTRR_CAP_FIX;
 
 	for (i = 0; i < num_var_ranges; i++)
 		get_mtrr_var_range(i, &vrs[i]);
@@ -471,8 +464,7 @@ bool __init get_mtrr_state(void)
 
 	rdmsr(MSR_MTRRdefType, lo, dummy);
 	mtrr_state.def_type = lo & MTRR_DEF_TYPE_TYPE;
-	mtrr_state.enabled = (lo & MTRR_DEF_TYPE_ENABLE) >>
-			     MTRR_STATE_SHIFT;
+	mtrr_state.enabled = (lo & MTRR_DEF_TYPE_ENABLE) >> MTRR_STATE_SHIFT;
 
 	if (amd_special_default_mtrr()) {
 		unsigned low, high;
@@ -585,7 +577,7 @@ static void generic_get_mtrr(unsigned int reg, unsigned long *base,
 
 	rdmsr(MTRRphysMask_MSR(reg), mask_lo, mask_hi);
 
-	if ((mask_lo & MTRR_PHYSMASK_V) == 0) {
+	if (!(mask_lo & MTRR_PHYSMASK_V)) {
 		/*  Invalid (i.e. free) range */
 		*base = 0;
 		*size = 0;
@@ -700,9 +692,8 @@ static unsigned long set_mtrr_state(void)
 	 * Set_mtrr_restore restores the old value of MTRRdefType,
 	 * so to set it we fiddle with the saved value:
 	 */
-	if ((deftype_lo & MTRR_DEF_TYPE_TYPE) != mtrr_state.def_type
-	    || ((deftype_lo & MTRR_DEF_TYPE_ENABLE) >> MTRR_STATE_SHIFT) !=
-	       mtrr_state.enabled) {
+	if ((deftype_lo & MTRR_DEF_TYPE_TYPE) != mtrr_state.def_type ||
+	    ((deftype_lo & MTRR_DEF_TYPE_ENABLE) >> MTRR_STATE_SHIFT) != mtrr_state.enabled) {
 
 		deftype_lo = (deftype_lo & MTRR_DEF_TYPE_DISABLE) |
 			     mtrr_state.def_type |
@@ -719,8 +710,7 @@ void mtrr_disable(void)
 	rdmsr(MSR_MTRRdefType, deftype_lo, deftype_hi);
 
 	/* Disable MTRRs, and set the default type to uncached */
-	mtrr_wrmsr(MSR_MTRRdefType, deftype_lo & MTRR_DEF_TYPE_DISABLE,
-		   deftype_hi);
+	mtrr_wrmsr(MSR_MTRRdefType, deftype_lo & MTRR_DEF_TYPE_DISABLE, deftype_hi);
 }
 
 void mtrr_enable(void)
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index fddc4e0c6626..1067f128bded 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -627,7 +627,7 @@ void __init mtrr_bp_init(void)
 {
 	const char *why = "(not available)";
 
-	mtrr_set_mask();
+	phys_hi_rsvd = GENMASK(31, boot_cpu_data.x86_phys_bits - 32);
 
 	if (cpu_feature_enabled(X86_FEATURE_MTRR)) {
 		mtrr_if = &generic_mtrr_ops;
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.h b/arch/x86/kernel/cpu/mtrr/mtrr.h
index a00987e6cc1c..1028a2b67961 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.h
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.h
@@ -58,6 +58,7 @@ extern const struct mtrr_ops *mtrr_if;
 extern unsigned int num_var_ranges;
 extern u64 mtrr_tom2;
 extern struct mtrr_state_type mtrr_state;
+extern u32 phys_hi_rsvd;
 
 void mtrr_set_mask(void);
 void mtrr_state_warn(void);

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
