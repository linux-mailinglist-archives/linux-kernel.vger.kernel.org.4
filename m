Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2A5607D5E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 19:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbiJURUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 13:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbiJURT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 13:19:59 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DBC733C9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 10:19:48 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e769329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e769:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1716C1EC072C;
        Fri, 21 Oct 2022 19:19:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666372769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ffg5NFO6tKVWSvtqYlp2XGILZ80EHuLep0vwKN4z2rY=;
        b=ME7+CSalOdpFY8l4MGtCsWwEHn2B8Dt8+LLRPZfDhiJCeR/y9ROe1wTmobgr+mcetr8Sj8
        qyLrlUAmcnOU7EZ0BiFoTMaof7nCcPOwOUauWFQwdZBOnwgW4bxKhxDJVNGGddCGl2vPrJ
        XKUFyYmhyHoviplwhPk2B5aMpwRN4eA=
Date:   Fri, 21 Oct 2022 19:19:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 03/16] x86/mtrr: replace use_intel() with a local flag
Message-ID: <Y1LUm1Vdu4u2Tp1c@zn.tnic>
References: <20221004081023.32402-1-jgross@suse.com>
 <20221004081023.32402-4-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221004081023.32402-4-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 10:10:10AM +0200, Juergen Gross wrote:
> In MTRR code use_intel() is only used in one source file, and the
> relevant use_intel_if member of struct mtrr_ops is set only in
> generic_mtrr_ops.
> 
> Replace use_intel() with a single flag in cacheinfo.c, which can be set
> when assigning generic_mtrr_ops to mtrr_if. This allows to drop
> use_intel_if from mtrr_ops, while preparing to support PAT without
> MTRR. As another preparation for the PAT/MTRR decoupling use a bit for
> MTRR control and one for PAT control. For now set both bits together,
> this can be changed later.
> 
> As the new flag will be set only if mtrr_enabled is set, the test for
> mtrr_enabled can be dropped at some places.
> 
> At the same time drop the local mtrr_enabled() function and rename
> the __mtrr_enabled flag to mtrr_enabled.

So, I kinda like your idea about "replace the bool with mtrr_if != NULL"
to test whether MTRRs are enabled.

IOW, how does this look ontop of yours?

At the end of mtrr_bp_init() I need to do some careful dancing but I
think this way it is even clearer. I'm pretty sure it can be simplified
even more but one thing at a time...

Thx.

---
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index dacb537da126..927b463a22bd 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -59,7 +59,6 @@
 #define MTRR_TO_PHYS_WC_OFFSET 1000
 
 u32 num_var_ranges;
-static bool mtrr_enabled;
 
 unsigned int mtrr_usage_table[MTRR_MAX_VAR_RANGES];
 static DEFINE_MUTEX(mtrr_mutex);
@@ -71,15 +70,17 @@ static const struct mtrr_ops *mtrr_ops[X86_VENDOR_NUM] __ro_after_init;
 
 const struct mtrr_ops *mtrr_if;
 
-static void set_mtrr(unsigned int reg, unsigned long base,
-		     unsigned long size, mtrr_type type);
-
 void __init set_mtrr_ops(const struct mtrr_ops *ops)
 {
 	if (ops->vendor && ops->vendor < X86_VENDOR_NUM)
 		mtrr_ops[ops->vendor] = ops;
 }
 
+static bool mtrr_enabled(void)
+{
+	return !!mtrr_if;
+}
+
 /*  Returns non-zero if we have the write-combining memory type  */
 static int have_wrcomb(void)
 {
@@ -299,7 +300,7 @@ int mtrr_add_page(unsigned long base, unsigned long size,
 	int i, replace, error;
 	mtrr_type ltype;
 
-	if (!mtrr_enabled)
+	if (!mtrr_enabled())
 		return -ENXIO;
 
 	error = mtrr_if->validate_add_page(base, size, type);
@@ -447,7 +448,7 @@ static int mtrr_check(unsigned long base, unsigned long size)
 int mtrr_add(unsigned long base, unsigned long size, unsigned int type,
 	     bool increment)
 {
-	if (!mtrr_enabled)
+	if (!mtrr_enabled())
 		return -ENODEV;
 	if (mtrr_check(base, size))
 		return -EINVAL;
@@ -476,7 +477,7 @@ int mtrr_del_page(int reg, unsigned long base, unsigned long size)
 	unsigned long lbase, lsize;
 	int error = -EINVAL;
 
-	if (!mtrr_enabled)
+	if (!mtrr_enabled())
 		return -ENODEV;
 
 	max = num_var_ranges;
@@ -536,7 +537,7 @@ int mtrr_del_page(int reg, unsigned long base, unsigned long size)
  */
 int mtrr_del(int reg, unsigned long base, unsigned long size)
 {
-	if (!mtrr_enabled)
+	if (!mtrr_enabled())
 		return -ENODEV;
 	if (mtrr_check(base, size))
 		return -EINVAL;
@@ -562,7 +563,7 @@ int arch_phys_wc_add(unsigned long base, unsigned long size)
 {
 	int ret;
 
-	if (pat_enabled() || !mtrr_enabled)
+	if (pat_enabled() || !mtrr_enabled())
 		return 0;  /* Success!  (We don't need to do anything.) */
 
 	ret = mtrr_add(base, size, MTRR_TYPE_WRCOMB, true);
@@ -750,15 +751,18 @@ void __init mtrr_bp_init(void)
 		}
 	}
 
-	if (mtrr_if) {
-		mtrr_enabled = true;
-		set_num_var_ranges(mtrr_if == &generic_mtrr_ops);
+	if (mtrr_enabled()) {
+		bool use_generic = mtrr_if == &generic_mtrr_ops;
+		bool mtrr_state_enabled = true;
+
+		set_num_var_ranges(use_generic);
 		init_table();
-		if (mtrr_if == &generic_mtrr_ops) {
+
+		if (use_generic) {
 			/* BIOS may override */
-			mtrr_enabled = get_mtrr_state();
+			mtrr_state_enabled = get_mtrr_state();
 
-			if (mtrr_enabled) {
+			if (mtrr_state_enabled) {
 				mtrr_bp_pat_init();
 				memory_caching_control |= CACHE_MTRR | CACHE_PAT;
 			}
@@ -767,10 +771,13 @@ void __init mtrr_bp_init(void)
 				changed_by_mtrr_cleanup = 1;
 				mtrr_if->set_all();
 			}
+
+			if (!mtrr_state_enabled)
+				mtrr_if = NULL;
 		}
 	}
 
-	if (!mtrr_enabled) {
+	if (!mtrr_enabled()) {
 		pr_info("Disabled\n");
 
 		/*
@@ -811,7 +818,7 @@ void mtrr_save_state(void)
 {
 	int first_cpu;
 
-	if (!mtrr_enabled)
+	if (!mtrr_enabled())
 		return;
 
 	first_cpu = cpumask_first(cpu_online_mask);
@@ -856,7 +863,7 @@ void mtrr_bp_restore(void)
 
 static int __init mtrr_init_finialize(void)
 {
-	if (!mtrr_enabled)
+	if (!mtrr_enabled())
 		return 0;
 
 	if (memory_caching_control & CACHE_MTRR) {

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
